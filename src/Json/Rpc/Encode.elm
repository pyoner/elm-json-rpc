module Json.Rpc.Encode exposing (request, batchRequest)

{-| This module implements encoders

# Encoders
@docs request, batchRequest
-}

import Json.Encode
    exposing
        ( Value
        , int
        , string
        , object
        , list
        )
import Json.Rpc.Types exposing (Id(..), Params(..), Request, BatchRequest)


-- Encoders


id : Id -> Value
id a =
    case a of
        IdString v ->
            string v

        IdInt v ->
            int v


params : Params -> Value
params p =
    case p of
        ParamsList v ->
            list v

        ParamsObject v ->
            object v


{-| Function encode Request to Value
-}
request : Request -> Value
request r =
    let
        base =
            [ ( "jsonrpc", string r.jsonrpc )
            , ( "method", string r.method )
            ]

        params_ =
            case r.params of
                Nothing ->
                    []

                Just v ->
                    [ ( "params", params v ) ]

        id_ =
            case r.id of
                Nothing ->
                    []

                Just v ->
                    [ ( "id", id v ) ]

        items =
            base ++ params_ ++ id_
    in
        object items


{-| Function encode BatchRequest to Value
-}
batchRequest : BatchRequest -> Value
batchRequest batch =
    list <| List.map request batch
