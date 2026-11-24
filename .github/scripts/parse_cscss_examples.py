"""Build the CartoSym-CSS parser from the grammar files and parse every example.

Usage: python .github/scripts/parse_cscss_examples.py

ANTLR requires a grammar file to be named after the grammar it declares, which
the files of 1-core/schemas are not (`CartoSym-CSS-Lexer.g4` declares
`CartoSymCSSLexer`). The parser is therefore generated from renamed copies in a
temporary directory; the files of the repository are not touched.

Needs Java, the `antlr4` command (package antlr4-tools) and the ANTLR Python
runtime, whose version is the one used to generate the parser. Exits with 1 if
ANTLR reports an error or a warning, or if a .cscss file has a syntax error.
"""

from __future__ import annotations

import subprocess
import sys
import tempfile
from importlib.metadata import version
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
SCHEMAS = ROOT / "1-core" / "schemas"
EXAMPLES = ROOT / "1-core" / "examples"
GRAMMARS = {
    "CartoSym-CSS-Lexer.g4": "CartoSymCSSLexer.g4",
    "CartoSym-CSS-Grammar.g4": "CartoSymCSSGrammar.g4",
}


def generate(out: Path) -> None:
    for source, target in GRAMMARS.items():
        (out / target).write_text(
            (SCHEMAS / source).read_text(encoding="utf-8"), encoding="utf-8"
        )
    antlr = [
        "antlr4",
        "-v",
        version("antlr4-python3-runtime"),
        "-Dlanguage=Python3",
    ]
    for target in GRAMMARS.values():
        proc = subprocess.run(
            [*antlr, target], cwd=out, capture_output=True, text=True, encoding="utf-8"
        )
        output = (proc.stdout + proc.stderr).strip()
        if proc.returncode != 0 or "error(" in output or "warning(" in output:
            raise SystemExit(f"ANTLR on {target}:\n{output}")


def parse_all(out: Path) -> int:
    from antlr4 import CommonTokenStream, FileStream
    from antlr4.error.ErrorListener import ErrorListener

    sys.path.insert(0, str(out))
    from CartoSymCSSGrammar import CartoSymCSSGrammar
    from CartoSymCSSLexer import CartoSymCSSLexer

    class Errors(ErrorListener):
        def __init__(self) -> None:
            self.messages: list[str] = []

        def syntaxError(  # noqa: N802 - ANTLR's name
            self, recognizer, symbol, line, column, message, e
        ) -> None:
            self.messages.append(f"{line}:{column} {message}")

    files = sorted(EXAMPLES.rglob("*.cscss"))
    failed = 0
    for path in files:
        errors = Errors()
        lexer = CartoSymCSSLexer(FileStream(str(path), encoding="utf-8"))
        lexer.removeErrorListeners()
        lexer.addErrorListener(errors)
        parser = CartoSymCSSGrammar(CommonTokenStream(lexer))
        parser.removeErrorListeners()
        parser.addErrorListener(errors)
        parser.styleSheet()
        if errors.messages:
            failed += 1
            print(f"{path.relative_to(ROOT)}: {errors.messages[0]}")
    print(f"{len(files)} .cscss files, {failed} with syntax errors")
    return failed


def main() -> int:
    with tempfile.TemporaryDirectory() as tmp:
        out = Path(tmp)
        generate(out)
        return 1 if parse_all(out) else 0


if __name__ == "__main__":
    sys.exit(main())
