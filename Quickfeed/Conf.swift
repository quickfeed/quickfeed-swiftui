//
//  Conf.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 01/07/2021.
//

import Foundation

enum Configuration {
    enum Error: Swift.Error {
        case missingKey, invalidValue
    }

    static func value<T>(for key: String) throws -> T where T: LosslessStringConvertible {
        guard let object = Bundle.main.object(forInfoDictionaryKey:key) else {
            throw Error.missingKey
        }

        switch object {
        case let value as T:
            return value
        case let string as String:
            guard let value = T(string) else { fallthrough }
            return value
        default:
            throw Error.invalidValue
        }
    }
}

var CONF_BASE_URL: String {
        return try! Configuration.value(for: "BASE_URL")
}

var CONF_GRPC_PORT: String {
        return try! Configuration.value(for: "GRPC_PORT")
}
