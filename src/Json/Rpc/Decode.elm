module Json.Rpc.Decode exposing (response)

import Json.Decode
    exposing
        ( Decoder
        , field
        , value
        , oneOf
        , map
        , map3
        , int
        , string
        , maybe
        , andThen
        )
import Json.Rpc.Types exposing (Id(..), Error, ResponseResult, Response)


-- Decoders


id : Decoder Id
id =
    oneOf
        [ map (\v -> IdInt v)
            int
        , map (\v -> IdString v)
            string
        ]


error : Decoder Error
error =
    map3 Error
        (field "code" int)
        (field "message" string)
        (maybe (field "data" value))


result : Decoder ResponseResult
result =
    (maybe (field "error" value))
        |> andThen
            (\err ->
                case err of
                    Just v ->
                        map (\v -> Err v)
                            error

                    Nothing ->
                        map (\v -> Ok v)
                            (field "result" value)
            )


response : Decoder Response
response =
    map3 Response
        (field "jsonrpc" string)
        result
        (maybe (field "id" id))
