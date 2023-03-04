module Native.Layout exposing
    ( absoluteLayout
    , dockLayout
    , flexboxLayout
    , gridLayout
    , rootLayout
    , stackLayout
    , wrapLayout
    , tabView
    )

{-| Layout is used to organize the UI elements in the mobile screen [refer.](https://docs.nativescript.org/ui-and-styling.html#layout-containers)


# Layouts

@docs absoluteLayout
@docs dockLayout
@docs flexboxLayout
@docs gridLayout
@docs rootLayout
@docs stackLayout
@docs wrapLayout
@docs tabView

-}

import Html exposing (Attribute, Html)


buildLayout : String -> List (Attribute msg) -> List (Html msg) -> Html msg
buildLayout nodeName attrs children =
    Html.node nodeName attrs children


{-| [Refer](https://docs.nativescript.org/ui-and-styling.html#absolutelayout)

The AbsoluteLayout container is the simplest layout container in NativeScript.

AbsoluteLayout has the following behavior:

  - Uses a pair of absolute left/top coordinates to position its children.
  - Doesn't enforce any layout constraints on its children.
  - Doesn't resize its children at runtime when its size changes.

Example

    absoluteLayout [ backgroundColor "#3c495e" ]
        [ label
            [ text "10,10"
            , left "10"
            , top "10"
            , width "100"
            , height "100"
            , backgroundColor "#43b883"
            ]
            []
        , label
            [ text "120,10"
            , left "120"
            , top "10"
            , width "100"
            , height "100"
            , backgroundColor "#43b883"
            ]
            []
        ]

-}
absoluteLayout : List (Attribute msg) -> List (Html msg) -> Html msg
absoluteLayout =
    buildLayout "ns-absolute-layout"


{-| [Refer](https://docs.nativescript.org/ui-and-styling.html#docklayout)

DockLayout is a layout container that lets you dock child elements to the sides or the center of the layout.

DockLayout has the following behavior:

  - Uses the dock property to dock its children to the left, right, top, bottom or center of the layout.
  - To dock a child element to the center, it must be the last child of the container and you must set the stretchLastChild property of the parent to true.
  - Enforces layout constraints to its children.
  - Resizes its children at runtime when its size changes.

Example

    dockLayout
        [ stretchLastChild "false", backgroundColor "#3c495e" ]
        [ label [ text "left", dock "left", width "40", backgroundColor "#43b883" ] []
        , label [ text "top", dock "top", width "40", backgroundColor "#289062" ] []
        , label [ text "right", dock "right", width "40", backgroundColor "#43b883" ] []
        , label [ text "bottom", dock "bottom", width "40", backgroundColor "#289062" ] []
        ]

-}
dockLayout : List (Attribute msg) -> List (Html msg) -> Html msg
dockLayout =
    buildLayout "ns-dock-layout"


{-| [Refer](https://docs.nativescript.org/ui-and-styling.html#gridlayout)

GridLayout is a layout container that lets you arrange its child elements in a table-like manner.

The grid consists of rows, columns, and cells. A cell can span one or more rows and one or more columns. It can contain multiple child elements which can span over multiple rows and columns, and even overlap each other.

By default, GridLayout has one column and one row. You can add columns and rows by configuring the columns and the rows properties. In these properties, you need to set the number of columns and rows and their width and height. You set the number of columns by listing their widths, separated by a comma. You set the number of rows by listing their heights, separated by a comma.

You can set a fixed size for column width and row height or you can create them in a responsive manner:

  - An absolute number: Indicates a fixed size.
  - auto: Makes the column as wide as its widest child or makes the row as tall as its tallest child.
  - `*`: Takes as much space as available after filling all auto and fixed size columns or rows.

Example

    -- Grid layout with fixed sizing
    gridLayout [ columns "115, 115", rows "115, 115" ]
        [ label [ text "0,0", row "0", col "0", backgroundColor "#43b883" ] []
        , label [ text "0,1", row "0", col "1", backgroundColor "#1c6b48" ] []
        , label [ text "1,0", row "1", col "0", backgroundColor "#289062" ] []
        , label [ text "1,1", row "1", col "1", backgroundColor "#43b883" ] []
        ]

    -- Grid layout with star sizing
    gridLayout [ columns "*, 2*", rows "2*, 3*", backgroundColor "#3c495e" ]
        [ label [ text "0,0", row "0", col "0", backgroundColor "#43b883" ] []
        , label [ text "0,1", row "0", col "1", backgroundColor "#1c6b48" ] []
        , label [ text "1,0", row "1", col "0", backgroundColor "#289062" ] []
        , label [ text "1,1", row "1", col "1", backgroundColor "#43b883" ] []
        ]

    -- Grid layout with fixed and auto sizing
    gridLayout [ columns "80, auto", rows "80, 80", backgroundColor "#3c495e" ]
        [ label [ text "0,0", row "0", col "0", backgroundColor "#43b883" ] []
        , label [ text "0,1", row "0", col "1", backgroundColor "#1c6b48" ] []
        , label [ text "1,0", row "1", col "0", backgroundColor "#289062" ] []
        , label [ text "1,1", row "1", col "1", backgroundColor "#43b883" ] []
        ]

-}
gridLayout : List (Attribute msg) -> List (Html msg) -> Html msg
gridLayout =
    buildLayout "ns-grid-layout"


{-| [Refer](https://docs.nativescript.org/ui-and-styling.html#stacklayout)

StackLayout is a layout container that lets you stack the child elements vertically (default) or horizontally.

Important:

Try not to nest too many StackLayout in your markup. If you find yourself nesting a lot of StackLayout you will likely get better performance by switching to a GridLayout or FlexboxLayout.
See [Layout Nesting](https://docs.nativescript.org/common-pitfalls.html#layout-nesting) for more information.

Example

    stackLayout [ backgroundColor "#3c495e" ]
        [ label [ text "first", height "70", backgroundColor "#43b883" ] []
        , label [ text "second", height "70", backgroundColor "#289062" ] []
        , label [ text "third", height "70", backgroundColor "#1c6b48" ] []
        ]

    -- Horizontal stacking
    stackLayout [ orientation "horizontal", backgroundColor "#3c495e" ]
        [ label [ text "first", height "70", backgroundColor "#43b883" ] []
        , label [ text "second", height "70", backgroundColor "#289062" ] []
        , label [ text "third", height "70", backgroundColor "#1c6b48" ] []
        ]

-}
stackLayout : List (Attribute msg) -> List (Html msg) -> Html msg
stackLayout =
    buildLayout "ns-stack-layout"


{-| [Refer](https://docs.nativescript.org/ui-and-styling.html#rootlayout)

RootLayout is a layout container designed to be used as the primary root layout container for your app with a built in api to easily control dynamic view layers. It extends a GridLayout so has all the features of a grid but enhanced with additional apis.

-}
rootLayout : List (Attribute msg) -> List (Html msg) -> Html msg
rootLayout =
    buildLayout "ns-root-layout"


{-| [Refer](https://docs.nativescript.org/ui-and-styling.html#wraplayout)

WrapLayout is a layout container that lets you position items in rows or columns, based on the orientation property. When the space is filled, the container automatically wraps items onto a new row or column.

    wrapLayout []
        [ label [ text "first", width "30%", height "30%", backgroundColor "#43b883" ] []
        , label [ text "second", width "30%", height "30%", backgroundColor "#1c6b48" ] []
        , label [ text "third", width "30%", height "30%", backgroundColor "#289062" ] []
        , label [ text "fourth", width "30%", height "30%", backgroundColor "#289062" ] []
        ]

-}
wrapLayout : List (Attribute msg) -> List (Html msg) -> Html msg
wrapLayout =
    buildLayout "ns-wrap-layout"


{-| [Refer](https://docs.nativescript.org/ui-and-styling.html#flexboxlayout)

FlexboxLayout is a layout container that provides a non-exact implementation of the CSS Flexbox layout. This layout lets you arrange child components both horizontally and vertically.

    -- Default flex layout
    flexboxLayout [ backgroundColor "#3c495e" ]
        [ label [ text "first", width "70", backgroundColor "#43b883" ] []
        , label [ text "second", width "70", backgroundColor "#1c6b48" ] []
        , label [ text "third", width "70", backgroundColor "#289062" ] []
        ]

    -- Column flex layout
    flexboxLayout [ flexDirection "column", backgroundColor "#3c495e" ]
        [ label [ text "first", width "70", backgroundColor "#43b883" ] []
        , label [ text "second", width "70", backgroundColor "#1c6b48" ] []
        , label [ text "third", width "70", backgroundColor "#289062" ] []
        ]

    -- Row flex layout with items aligned to flex-start
    flexboxLayout [ alignItems "flex-start", backgroundColor "#3c495e" ]
        [ label [ text "first", width "70", backgroundColor "#43b883" ] []
        , label [ text "second", width "70", backgroundColor "#1c6b48" ] []
        , label [ text "third", width "70", backgroundColor "#289062" ] []
        ]

    -- Row flex layout with custom order
    flexboxLayout [ alignItems "flex-start", backgroundColor "#3c495e" ]
        [ label [ text "first", order "2", width "70", backgroundColor "#43b883" ] []
        , label [ text "second", order "3", width "70", backgroundColor "#1c6b48" ] []
        , label [ text "third", order "1", width "70", backgroundColor "#289062" ] []
        ]

    -- Row flex layout with wrapping
    flexboxLayout [ flexWrap "wrap", backgroundColor "#3c495e" ]
        [ label [ text "first", width "30%", backgroundColor "#43b883" ] []
        , label [ text "second", width "30%", backgroundColor "#1c6b48" ] []
        , label [ text "third", width "30%", backgroundColor "#289062" ] []
        , label [ text "fourth", width "30%", backgroundColor "#289062" ] []
        ]

-}
flexboxLayout : List (Attribute msg) -> List (Html msg) -> Html msg
flexboxLayout =
    buildLayout "ns-flexbox-layout"


{-| [Refer](https://docs.nativescript.org/ui-and-styling.html#tabview)

TabView is a navigation component that shows content grouped into tabs and lets users switch between tabs.

Currently, TabViewItem expects a single child element. In most cases, you might want to wrap your content in a layout.

-}
tabView : List (Attribute msg) -> List (Html msg) -> Html msg
tabView =
    buildLayout "ns-tab-view"
