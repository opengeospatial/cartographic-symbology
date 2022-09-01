# Vector Features Symbolizer

```mermaid
  classDiagram
  %% Class definition
    %% Note: Symbolizer, StylingRule and Style are defined in core.md
    class Symbolizer
    class VectorSymbolizer {
      <<interface>>
      fill: Fill [0..1]
      stroke: Stroke [0..1]
      marker: Marker [0..1]
      label: Label [0..1]
    }

    class Marker {
      elements: Graphic[0..*]
    }
    class LabelPlacement {
      priority: float
      minSpacing: float
      maxSpacing: float
    }
    class Label {
      placement: LabelPlacement
    }
    class Graphic
  %% Relations
  %% Association
    Symbolizer --> ParameterValue
    VectorSymbolizer --> ParameterValue
  %% Inheritance
    VectorSymbolizer --|> Symbolizer
    Label --|> Marker
  %% Composition
    VectorSymbolizer --* Label
    VectorSymbolizer --* Marker
    VectorSymbolizer --* Fill
    VectorSymbolizer --* Stroke
    Marker --* Graphic
    Label --* LabelPlacement
    Fill --* Graphic
    Stroke --* Graphic
```
