module Json.Rpc.Types
    exposing
        ( Id(IdString, IdInt)
        , Params(ParamsList, ParamsObject)
        , Version
        , Method
        , Request
        , Response
        , ResponseResult
        , Error
        , BatchRequest
        , BatchResponse
        )

{-| Types and functions

# Base types
@docs Id, Params, Version, Method, Request, Response, ResponseResult, Error

# Batch types
@docs BatchRequest, BatchResponse
-}

import Json.Encode exposing (Value)


{-| Union type Id can be String or Int
-}
type Id
    = IdString String
    | IdInt Int


{-| Union type Params can be (List Value) to represent Array
or (List (String, Value)) to represent Object
-}
type Params
    = ParamsList (List Value)
    | ParamsObject (List ( String, Value ))


{-| Type alias Version is a String of JSON-RPC version ("2.0")
-}
type alias Version =
    String


{-| Type alias Method
-}
type alias Method =
    String


{-| JSON-RPC Request type
-}
type alias Request =
    { jsonrpc : Version
    , method : Method
    , params : Maybe Params
    , id : Maybe Id
    }


{-| Type alias ResponseResult
-}
type alias ResponseResult =
    Result Error Value


{-| Type alias Response
-}
type alias Response =
    { jsonrpc : Version
    , result : ResponseResult
    , id : Maybe Id
    }


{-| Type alias Error
-}
type alias Error =
    { code : Int
    , message : String
    , data : Maybe Value
    }


{-| Type alias BatchRequest
-}
type alias BatchRequest =
    List Request


{-| Type alias BatchResponse
-}
type alias BatchResponse =
    List Response
