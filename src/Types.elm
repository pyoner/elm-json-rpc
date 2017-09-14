module Types exposing (..)

import Dict exposing (Dict)
import Json.Encode exposing (Value)


version =
    "2.0"


type Id
    = IdString String
    | IdInt Int


type Params
    = ParamsList (List Value)
    | ParamsDict (Dict String Value)


type alias Version =
    String


type alias Method =
    String


type alias Request =
    { jsonrpc : Version
    , method : Method
    , params : Maybe Params
    , id : Maybe Id
    }


type alias Response =
    { jsonrpc : Version
    , result : Result Error Value
    , id : Maybe Id
    }


type alias Error =
    { code : Int
    , message : String
    , data : Maybe Value
    }


createRequest : Method -> Maybe Params -> Maybe Id -> Request
createRequest method params id =
    { jsonrpc = version
    , method = method
    , params = params
    , id = id
    }


createNotification : Method -> Maybe Params -> Request
createNotification method params =
    createRequest method params Nothing
