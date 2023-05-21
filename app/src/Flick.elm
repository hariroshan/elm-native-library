module Flick exposing (main)

import Browser
import Html exposing (node)
import Html.Attributes exposing (attribute)
import Json.Decode as D
import Json.Encode as E
import Native exposing (Native)
import Native.Attributes as NA exposing (bindAttributeWithExpression)
import Native.Event as Event
import Native.Frame as Frame
import Native.Layout as Layout
import Native.Page as Page


type alias Flick =
    { id : Int
    , genre : String
    , title : String
    , image : String
    , url : String
    , description : String
    , details :
        List { title : String, body : String }
    }


decodeFlick : D.Decoder Flick
decodeFlick =
    D.map7
        (\id genre title image url description details ->
            { id = id
            , genre = genre
            , title = title
            , image = image
            , url = url
            , description = description
            , details = details
            }
        )
        (D.field "id" D.int)
        (D.field "genre" D.string)
        (D.field "title" D.string)
        (D.field "image" D.string)
        (D.field "url" D.string)
        (D.field "description" D.string)
        (D.field "details"
            (D.list
                (D.map2 (\title body -> { title = title, body = body })
                    (D.field "title" D.string)
                    (D.field "body" D.string)
                )
            )
        )


response : List Flick
response =
    """
    [{"id":1,"genre":"Musical","title":"Book of Mormon","image":"~/assets/bookofmormon.png","url":"https://nativescript.org/images/ngconf/book-of-mormon.mov","description":"A satirical examination of the beliefs and practices of The Church of Jesus Christ of Latter-day Saints.","details":[{"title":"Music, Lyrics and Book by","body":"Trey Parker, Robert Lopez, and Matt Stone"},{"title":"First showing on Broadway","body":"March 2011 after nearly seven years of development."},{"title":"Revenue","body":"Grossed over $500 million, making it one of the most successful musicals of all time."},{"title":"History","body":"The Book of Mormon was conceived by Trey Parker, Matt Stone and Robert Lopez. Parker and Stone grew up in Colorado, and were familiar with The Church of Jesus Christ of Latter-day Saints and its members. They became friends at the University of Colorado Boulder and collaborated on a musical film, Cannibal! The Musical (1993), their first experience with movie musicals. In 1997, they created the TV series South Park for Comedy Central and in 1999, the musical film South Park: Bigger, Longer & Uncut. The two had first thought of a fictionalized Joseph Smith, religious leader and founder of the Latter Day Saint movement, while working on an aborted Fox series about historical characters. Their 1997 film, Orgazmo, and a 2003 episode of South Park, \\"All About Mormons\\", both gave comic treatment to Mormonism. Smith was also included as one of South Park's \\"Super Best Friends\\", a Justice League parody team of religious figures like Jesus and Buddha."},{"title":"Development","body":"During the summer of 2003, Parker and Stone flew to New York City to discuss the script of their new film, Team America: World Police, with friend and producer Scott Rudin (who also produced South Park: Bigger, Longer & Uncut). Rudin advised the duo to see the musical Avenue Q on Broadway, finding the cast of marionettes in Team America similar to the puppets of Avenue Q. Parker and Stone went to see the production during that summer and the writer-composers of Avenue Q, Lopez and Jeff Marx, noticed them in the audience and introduced themselves. Lopez revealed that South Park: Bigger, Longer & Uncut was highly influential in the creation of Avenue Q. The quartet went for drinks afterwards, and soon found that each camp wanted to write something involving Joseph Smith. The four began working out details nearly immediately, with the idea to create a modern story formulated early on. For research purposes, the quartet took a road trip to Salt Lake City where they \\"interviewed a bunch of missionaries—or ex-missionaries.\\" They had to work around Parker and Stone's South Park schedule. In 2006, Parker and Stone flew to London where they spent three weeks with Lopez, who was working on the West End production of Avenue Q. There, the three wrote \\"four or five songs\\" and came up with the basic idea of the story. After an argument between Parker and Marx, who felt he was not getting enough creative control, Marx was separated from the project.[10] For the next few years, the remaining trio met frequently to develop what they initially called The Book of Mormon: The Musical of the Church of Jesus Christ of Latter-day Saints. \\"There was a lot of hopping back and forth between L.A. and New York,\\" Parker recalled."}]},{"id":2,"genre":"Musical","title":"Beetlejuice","image":"~/assets/beetlejuicemusical.png","url":"https://nativescript.org/images/ngconf/beetlejuice.mov","description":"A deceased couple looks for help from a devious bio-exorcist to handle their haunted house.","details":[{"title":"Music and Lyrics","body":"Eddie Perfect"},{"title":"Book by","body":"Scott Brown and Anthony King"},{"title":"Based on","body":"A 1988 film of the same name."},{"title":"First showing on Broadway","body":"April 25, 2019"},{"title":"Background","body":"In 2016, a musical adaptation of the 1988 film Beetlejuice (directed by Tim Burton and starring Geena Davis as Barbara Maitland, Alec Baldwin as Adam Maitland, Winona Ryder as Lydia Deetz and Michael Keaton as Betelgeuse) was reported to be in the works, directed by Alex Timbers and produced by Warner Bros., following a reading with Christopher Fitzgerald in the title role. In March 2017, it was reported that Australian musical comedian Eddie Perfect would be writing the music and lyrics and Scott Brown and Anthony King would be writing the book of the musical, and that another reading would take place in May, featuring Kris Kukul as musical director. The musical has had three readings and two laboratory workshops with Alex Brightman in the title role, Sophia Anne Caruso as Lydia Deetz, Kerry Butler and Rob McClure as Barbara and Adam Maitland."}]},{"id":3,"genre":"Musical","title":"Anastasia","image":"~/assets/anastasia.png","url":"https://nativescript.org/images/ngconf/anastasia.mov","description":"The legend of Grand Duchess Anastasia Nikolaevna of Russia.","details":[{"title":"Music and Lyrics","body":"Lynn Ahrens and Stephen Flaherty"},{"title":"Book by","body":"Terrence McNally"},{"title":"Based on","body":"A 1997 film of the same name."},{"title":"Background","body":"A reading was held in 2012, featuring Kelli Barret as Anya (Anastasia), Aaron Tveit as Dmitry, Patrick Page as Vladimir, and Angela Lansbury as the Empress Maria. A workshop was held on June 12, 2015, in New York City, and included Elena Shaddow as Anya, Ramin Karimloo as Gleb Vaganov, a new role, and Douglas Sills as Vlad.\\n        The original stage production of Anastasia premiered at the Hartford Stage in Hartford, Connecticut on May 13, 2016 (previews). The show was directed by Darko Tresnjak and choreography by Peggy Hickey, with Christy Altomare and Derek Klena starring as Anya and Dmitry, respectively.\\n        Director Tresnjak explained: \\"We've kept, I think, six songs from the movie, but there are 16 new numbers. We've kept the best parts of the animated movie, but it really is a new musical.\\" The musical also adds characters not in the film. Additionally, Act 1 is set in Russia and Act 2 in Paris, \\"which was everything modern Soviet Russia was not: free, expressive, creative, no barriers,\\" according to McNally.\\n        The musical also omits the supernatural elements from the original film, including the character of Rasputin and his musical number \\"In the Dark of the Night\\", (although that song’s melody is repurposed in the new number \\"Stay, I Pray You\\"), and introduces instead a new villain called Gleb, a general for the Bolsheviks who receives orders to kill Anya."}]}]
    """
        |> D.decodeString (D.list decodeFlick)
        |> Result.toMaybe
        |> Maybe.withDefault []


main : Program () Model Msg
main =
    Browser.element
        { init = always init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type NavPage
    = HomePage
    | DetailsPage
    | AnimatedCircle


type alias Model =
    { rootFrame : Frame.Model NavPage
    , flick : Native.ListViewModel Flick
    , picked : Maybe Flick
    }


encodeFlix : Flick -> E.Value
encodeFlix flick =
    [ ( "image", E.string flick.image )
    , ( "title", E.string flick.title )
    , ( "description", E.string flick.description )
    , ( "id", E.int flick.id )
    ]
        |> E.object


init : ( Model, Cmd Msg )
init =
    ( { rootFrame = Frame.init AnimatedCircle
      , picked = Nothing
      , flick =
            Native.makeListViewModel encodeFlix response
      }
    , Cmd.none
    )


type Msg
    = ToDetails Int
    | Back Bool


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Back bool ->
            ( { model | rootFrame = Frame.handleBack bool model.rootFrame }, Cmd.none )

        ToDetails idx ->
            ( { model
                | rootFrame =
                    model.rootFrame
                        |> Frame.goTo DetailsPage
                            (Frame.defaultNavigationOptions
                                |> Frame.setAnimated True
                                |> Frame.setTransition
                                    { name = Just Frame.FlipLeft
                                    , duration = Just 200
                                    , curve = Just Frame.Spring
                                    }
                                |> Just
                            )
                , picked =
                    model.flick
                        |> Native.getListItems
                        |> List.foldl
                            (\cur (( curIdx, acc ) as result) ->
                                if acc /= Nothing then
                                    result

                                else if curIdx == idx then
                                    ( idx, Just cur )

                                else
                                    ( curIdx + 1, acc )
                            )
                            ( 0, Nothing )
                        |> Tuple.second
              }
            , Cmd.none
            )



{-


       Layout.asElement <|
               Layout.flexboxLayout
                   [ NA.flexDirection "column"
                   ]
                   [ Native.listPicker
                       [ E.list E.string
                           [ "2022", "2021", "2020" ]
                           |> NA.items
                       , NA.selectedIndex "1"
                       ]
                       []
                   ]

   Native.listView
           [ E.list E.int [ 2022, 2021, 2020, 2019, 2018, 2017 ] |> NA.items
           , NA.itemTemplateSelector "{{ $value % 2 == 0 ? 'even' : 'odd' }}"
           ]
           [ Layout.asElement <|
               Layout.stackLayout
                   [ NA.key "even" ]
                   [ Native.label [ NA.text "{{ $value.toString() }}", NA.color "green" ] []
                   ]
           , Layout.asElement <|
               Layout.stackLayout
                   [ NA.key "odd" ]
                   [ Native.label [ NA.text "{{ $value.toString() }}", NA.color "red" ] [] ]
           ]
-}


flickTemplate : Native Msg
flickTemplate =
    Layout.gridLayout
        [ NA.height "280"
        , NA.borderRadius "10"
        , NA.class "bg-secondary"
        , NA.rows "*, auto, auto"
        , NA.columns "*"
        , NA.margin "5, 10"
        , NA.padding "0"
        ]
        [ Native.image
            [ NA.row "0"
            , NA.margin "0"
            , NA.stretch "aspectFill"
            , bindAttributeWithExpression "src" " $value.image "
            ]
            []
        , Native.label
            [ NA.row "1"
            , NA.margin "10, 10, 0, 10"
            , NA.fontWeight "700"
            , NA.class "text-primary"
            , NA.fontSize "18"
            , bindAttributeWithExpression "title" " $value.title "
            ]
            []
        , Native.label
            [ NA.row "2"
            , NA.margin "0, 10, 10, 10"
            , NA.class "text-secondary"
            , NA.fontSize "14"
            , NA.textWrap "true"
            , bindAttributeWithExpression "text" " $value.description "
            ]
            []
        ]


homePage : Model -> Native Msg
homePage model =
    Page.pageWithActionBar Back
        []
        (Native.actionBar [ NA.title "Elm Native Flix" ] [])
        (Layout.stackLayout [ NA.height "100%" ]
            [ Native.listViewWithSingleTemplate
                [ NA.height "100%"
                , NA.separatorColor "transparent"
                , NA.items model.flick
                , Event.onItemTap ToDetails
                ]
                flickTemplate
            ]
        )


detailsPage : Model -> Native Msg
detailsPage model =
    case model.picked of
        Nothing ->
            Page.page Back
                []
                (Layout.stackLayout []
                    [ Native.label [ NA.text "Not found" ] []
                    ]
                )

        Just flick ->
            Page.pageWithActionBar Back
                [ Event.on "navigatedTo" (D.field "isBackNavigation" D.bool |> D.map Back) ]
                (Native.actionBar [ NA.title flick.title ]
                    [ Native.navigationButton [ NA.text "Back" ] []
                    ]
                )
                (Native.scrollView
                    []
                    (Layout.flexboxLayout []
                        [ Layout.stackLayout []
                            [ Native.image
                                [ NA.margin "0"
                                , NA.stretch "aspectFill"
                                , NA.src flick.image
                                ]
                                []
                            ]
                        , Layout.stackLayout [ NA.padding "10, 20" ]
                            (flick.details
                                |> List.map
                                    (\detail ->
                                        Layout.stackLayout []
                                            [ Native.label
                                                [ NA.marginTop "15"
                                                , NA.fontSize "16"
                                                , NA.fontWeight "700"
                                                , NA.class "text-primary"
                                                , NA.textWrap "true"
                                                , NA.text detail.title
                                                ]
                                                []
                                            , Native.label
                                                [ NA.fontSize "14"
                                                , NA.class "text-secondary"
                                                , NA.textWrap "true"
                                                , NA.text detail.body
                                                ]
                                                []
                                            ]
                                    )
                            )
                        ]
                    )
                )


animatedCirclePage : Native Msg
animatedCirclePage =
    Page.pageWithActionBar Back
        []
        (Native.actionBar [ NA.title "Animated Circle" ] [])
        (node "ns-animated-circle"
                [ attribute "background-color" "transparent"
                , attribute "width" "200"
                , attribute "height" "200"
                , attribute "animated" "true"
                , attribute "animate-from" "0"
                , attribute "rim-color" "#FF5722"
                , attribute "bar-color" "#3D8FF4"
                , attribute "fill-color" "#eee"
                , attribute "clockwise" "true"
                , attribute "rim-width" "5"
                , attribute "progress" "50"
                , attribute "text" "50%"
                , attribute "text-size" "28"
                , attribute "text-color" "red"
                ]
                [])

getPage : Model -> NavPage -> Native Msg
getPage model page =
    case page of
        DetailsPage ->
            detailsPage model

        HomePage ->
            homePage model

        AnimatedCircle ->
            animatedCirclePage


view : Model -> Native Msg
view model =
    model.rootFrame
        |> Frame.view [] (getPage model)


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none
