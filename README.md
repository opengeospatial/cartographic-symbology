# OGC Styles & Symbology

This repository hosts the working draft documents for the multi-part OGC Cartographic Symbology Standard. The core **Part 1: Core model and encodings** is available as [HTML](https://opengeospatial.github.io/ogcna-auto-review/18-067r4.html) or [PDF](https://opengeospatial.github.io/ogcna-auto-review/18-067r4.pdf) and corresponds to the version **2.0** of SymCore.
The following extensions are also planned:

- Part 2: Model extension for graphical shapes and transformations
- Part 3: Model extension for geometry relations and manipulation
- Part 4: Model extension for additional coverage symbolization

In comparison to the current _OGC Symbology Conceptual Model: Core Part ("SymCore")_ version 1.0, the new draft candidate Standard aims to better reflect its classification as an OGC Implementation Standard by including the requirements classes needed to enable the implementation of interoperable ***encodings***, ***renderers*** (e.g., [_OGC API - Maps_](https://github.com/opengeospatial/ogcapi-maps/) / [_OGC API - Tiles_](https://github.com/opengeospatial/ogcapi-tiles)) and systems ***parsing*** and/or ***generating*** style definitions (e.g., [_OGC API - Styles_](https://github.com/opengeospatial/ogcapi-styles/), visual style editors, style transcoders).

It does so by featuring:
- A **modular logical and conceptual model** for styling capabilities,  
- A [**minimal Core**](https://opengeospatial.github.io/ogcna-auto-review/18-067r4.html#toc20) requirements class including clear extension mechanisms, through the definition of abstract _Selectors_, _Symbolizers_, and _Expressions_,
- a basic [**Vector Styling**](https://opengeospatial.github.io/ogcna-auto-review/18-067r4.html#toc23) requirements class,
- a basic [**Coverage Styling**](https://opengeospatial.github.io/ogcna-auto-review/18-067r4.html#toc26) requirements class,
- requirements classes providing additional styling functionality,
- a [**JSON encoding**](https://opengeospatial.github.io/ogcna-auto-review/18-067r4.html) of the conceptual and logical model facilitating machine readability,
- a [**CSS-inspired encoding**](https://opengeospatial.github.io/ogcna-auto-review/18-067r4.html) of the conceptual and logical model facilitating hand-editing.

_The current **published** version of OGC Symbology Conceptual Model: Core Part (SymCore) **1.0** is available in [HTML](https://docs.ogc.org/is/18-067r3/18-067r3.html) or [PDF](https://docs.ogc.org/is/18-067r3/18-067r3.pdf)._

## Part 1 Requirements classes

### Basic portrayal capabilities
- a [core symbology conceptual and logical model](https://opengeospatial.github.io/ogcna-auto-review/18-067r4.html#toc20) based on Styles as a list of Styling Rules consisting of a Symbolizer and optional Selector Expression,
- basic [vector styling](https://opengeospatial.github.io/ogcna-auto-review/18-067r4.html#toc23),
- basic [coverage styling](https://opengeospatial.github.io/ogcna-auto-review/18-067r4.html#toc26),
- basic [labeling](https://opengeospatial.github.io/ogcna-auto-review/18-067r4.html)

### Common portrayal capabilities

- [hill shading](https://opengeospatial.github.io/ogcna-auto-review/18-067r4.html),
- [font outlines](https://opengeospatial.github.io/ogcna-auto-review/18-067r4.html),
- [dashed strokes](https://opengeospatial.github.io/ogcna-auto-review/18-067r4.html),
- [casing and center lines](https://opengeospatial.github.io/ogcna-auto-review/18-067r4.html),
- [hatches](https://opengeospatial.github.io/ogcna-auto-review/18-067r4.html),
- [stipples](https://opengeospatial.github.io/ogcna-auto-review/18-067r4.html)

### Additional Expression capabilities

- [expressions as parameter values](https://opengeospatial.github.io/ogcna-auto-review/18-067r4.html) for any symbolizer properties,
- using [identifiers in the right side](https://opengeospatial.github.io/ogcna-auto-review/18-067r4.html) of operation expressions,
- [conditional expressions](https://opengeospatial.github.io/ogcna-auto-review/18-067r4.html),
- [variables](https://opengeospatial.github.io/ogcna-auto-review/18-067r4.html),
- [arithmetic operators](https://opengeospatial.github.io/ogcna-auto-review/18-067r4.html),
- [text relation operators](https://opengeospatial.github.io/ogcna-auto-review/18-067r4.html),
- [function call expressions](https://opengeospatial.github.io/ogcna-auto-review/18-067r4.html),
- [array relations](https://opengeospatial.github.io/ogcna-auto-review/18-067r4.html) standard functions,
- [text manipulation](https://opengeospatial.github.io/ogcna-auto-review/18-067r4.html) standard functions,

### Encodings

- [JSON encoding](https://opengeospatial.github.io/ogcna-auto-review/18-067r4.html) that can be readily parsed by a generic JSON parser,
- [Cascading Cartographic Symbology Style Sheets](https://opengeospatial.github.io/ogcna-auto-review/18-067r4.html), a more expressive encoding inspired from Web CSS and other cartographic CSS-like (e.g., GeoCSS, CartoCSS, MapCSS, GNOSIS CMSS) which is better suited to hand-edit styles.

The following requirements classes are planned for the next parts of the standard:

## Part 2 Requirements classes

### Advanced Stroke and Fills

- specific [joins and caps](https://opengeospatial.github.io/ogcna-auto-review/18-067r4.html) for Strokes
- [Graphic pattern Strokes](https://opengeospatial.github.io/ogcna-auto-review/18-067r4.html),
- [Graphic pattern Fills](https://opengeospatial.github.io/ogcna-auto-review/18-067r4.html),
- [gradient fills](https://opengeospatial.github.io/ogcna-auto-review/18-067r4.html)

### Additional portrayal capabilities

- [shape graphics](https://opengeospatial.github.io/ogcna-auto-review/18-067r4.html) including circles, ellipses, arcs, rectangles (rounded or not) and paths (polylines and polygons),
- [shape outlines](https://opengeospatial.github.io/ogcna-auto-review/18-067r4.html),
- [vector graphic hierarchy](https://opengeospatial.github.io/ogcna-auto-review/18-067r4.html), including full 2D transforms,
- [3D model graphics and 3D transforms](https://opengeospatial.github.io/ogcna-auto-review/18-067r4.html),
- [image outline](https://opengeospatial.github.io/ogcna-auto-review/18-067r4.html)

## Part 3 Requirements classes

### Additional Expression capabilities

- [spatial relation](https://opengeospatial.github.io/ogcna-auto-review/18-067r4.html) standard functions,
- [temporal relation](https://opengeospatial.github.io/ogcna-auto-review/18-067r4.html) standard fuctions,
- [geometry manipulation](https://opengeospatial.github.io/ogcna-auto-review/18-067r4.html) standard functions,
- [symbolizer geometry](https://opengeospatial.github.io/ogcna-auto-review/18-067r4.html)

## Part 4 Requirements classes

### Advanced Coverage Styling

- [bitwise operators](https://opengeospatial.github.io/ogcna-auto-review/18-067r4.html),
- [coverage as points](https://opengeospatial.github.io/ogcna-auto-review/18-067r4.html),
- [coverage as contours](https://opengeospatial.github.io/ogcna-auto-review/18-067r4.html),
- [contrast enhancement](https://opengeospatial.github.io/ogcna-auto-review/18-067r4.html),
- [hue, saturation, value modifier](https://opengeospatial.github.io/ogcna-auto-review/18-067r4.html),
- [aggregation functions](https://opengeospatial.github.io/ogcna-auto-review/18-067r4.html)

## Communication

Join the OGC Styles & Symbology [mailing list](https://lists.ogc.org/mailman/listinfo/styles-se.swg).

Visit the OGC Styles & Symbology [project on the OGC portal](https://portal.ogc.org/files/?artifact_id=37164) after signing the [Observer Agreement](https://portal.ogc.org/files/?artifact_id=92169).

Most work on the specification takes place in [GitHub issues](https://github.com/opengeospatial/styles-and-symbology/issues),
so browse there to get a good idea of what is happening, as well as past decisions.

## Contributing

The contributor understands that any contributions, if accepted by the OGC Membership, shall be incorporated into OGC standards documents and that all copyright and intellectual property shall be vested to the OGC.

The OGC Styles & Symbology Standards Working Group (SWG) is the group at OGC responsible for the stewardship of the standard, but is working to do as much work in public as possible.

* [Open issues](https://github.com/opengeospatial/styles-and-symbology/issues)
* [Copy of License Language](https://raw.githubusercontent.com/opengeospatial/styles-and-symbology/main/LICENSE)

Pull Requests from contributors are welcomed. However, please note that by sending a Pull Request or Commit to this GitHub repository, you are agreeing to the terms in the [Observer Agreement](https://portal.ogc.org/files/?artifact_id=37164).
