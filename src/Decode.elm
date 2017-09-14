module Decode exposing (..)

import Json.Decode exposing (..)
import Types exposing (..)


idDecoder : Decoder Id
idDecoder =
    oneOf
        [ map (\id -> IdInt id)
            int
        , map (\id -> IdString id)
            string
        ]


errorDecoder : Decoder Error
errorDecoder =
    map3 Error
        (field "code" int)
        (field "message" string)
        (maybe (field "data" value))


resultDecoder : Decoder ResponseResult
resultDecoder =
    (maybe (field "error" value))
        |> andThen
            (\err ->
                case err of
                    Just v ->
                        map (\err -> Err err)
                            errorDecoder

                    Nothing ->
                        map (\result -> Ok result)
                            (field "result" value)
            )


responseDecoder : Decoder Response
responseDecoder =
    map3 Response
        (field "jsonrpc" string)
        resultDecoder
        (maybe (field "id" idDecoder))
