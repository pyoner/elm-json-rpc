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
        , version
        , createRequest
        , createNotification
        )

{-| Types and functions

# Types
@docs version, Id, Params, Version, Method, Request, Response, ResponseResult, Error

# Functions
@docs createRequest, createNotification
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


{-| Default version ("2.0") of JSON-RPC
-}
version : Version
version =
    "2.0"


{-| Helper function to create Request
-}
createRequest : Method -> Maybe Params -> Maybe Id -> Request
createRequest method params id =
    { jsonrpc = version
    , method = method
    , params = params
    , id = id
    }


{-| Helper function to create Notification
-}
createNotification : Method -> Maybe Params -> Request
createNotification method params =
    createRequest method params Nothing
