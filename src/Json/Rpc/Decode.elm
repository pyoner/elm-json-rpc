module Json.Rpc.Decode exposing (response, batchResponse)

{-| This module implements decoders

# Decoders
@docs response, batchResponse
-}

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
        , list
        )
import Json.Rpc.Types
    exposing
        ( Id(..)
        , Error
        , ResponseResult
        , Response
        , BatchResponse
        )


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


{-| Function decode value to Respose
-}
response : Decoder Response
response =
    map3 Response
        (field "jsonrpc" string)
        result
        (maybe (field "id" id))


{-| Function decode value to BatchResponse
-}
batchResponse : Decoder BatchResponse
batchResponse =
    list response
