module Encode exposing (..)

import Json.Encode
    exposing
        ( Value
        , encode
        , int
        , string
        , object
        , list
        )
import Types exposing (..)


encodeId : Id -> Value
encodeId id =
    case id of
        IdString v ->
            string v

        IdInt v ->
            int v


encodeParams : Params -> Value
encodeParams params =
    case params of
        ParamsList v ->
            list v

        ParamsObject v ->
            object v


encodeRequest : Request -> String
encodeRequest request =
    let
        base =
            [ ( "jsonrpc", string request.jsonrpc )
            , ( "method", string request.method )
            ]

        params =
            case request.params of
                Nothing ->
                    []

                Just v ->
                    [ ( "params", encodeParams v ) ]

        id =
            case request.id of
                Nothing ->
                    []

                Just v ->
                    [ ( "id", encodeId v ) ]

        items =
            base ++ params ++ id
    in
        encode 0 (object items)
