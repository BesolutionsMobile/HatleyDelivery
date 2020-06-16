//
//  APIRouterNew.swift
//  Wassalny
//
//  Created by Apple on 9/30/19.
//  Copyright © 2019 amirahmed. All rights reserved.
//

import Alamofire

enum APIRouterNew: URLRequestConvertible {
    
   case activate(key:String)
   case forgetPassword(mail:String)
    
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .activate:
            return .get
        case .forgetPassword:
            return .get
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .activate:
             return "/activate"
        case .forgetPassword:
            return "/account/reset-password/init"
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .activate(let key):
            return [K.Login.email: key]
        
        case .forgetPassword(let mail):
            return [K.Login.email: mail]
        }
}
    
// MARK: - URLRequestConvertible
func asURLRequest() throws -> URLRequest {
    
    let url = try K.ProductionServer.baseURL.asURL()
    
    var urlRequest = URLRequest(url: url.appendingPathComponent(path))
    
    // HTTP Method
    urlRequest.httpMethod = method.rawValue
    
    // Common Headers
    urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
    urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
    
    
    // Parameters
    var encodedURLRequest:URLRequest? = nil
    
    var Vparameters: [String: Any]
    
    if(parameters == nil)
    {
        encodedURLRequest = try URLEncoding.queryString.encode(urlRequest, with: nil)
    }else
    {
        Vparameters = parameters!
        encodedURLRequest = try URLEncoding.queryString.encode(urlRequest, with: Vparameters)
    }

    
    return encodedURLRequest!
    
    }
}


