//
//  ServiceHelper.swift
//  MVVMTestProject
//
//  Created by Martin Pinka on 02.11.16.
//  Copyright Â© 2016 The Funtasty. All rights reserved.
//

import Foundation

protocol Service {
    init()
}

class ServiceHelper {
    private var servicesDictionary: [String: Service] = [:]

    init(services: [Service.Type]? = nil) {
        services?.forEach {            
            self.add($0)
        }
    }

    func add(_ type: Service.Type, with name: String? = nil) {
        let name = name ?? String(reflecting: type)
        servicesDictionary[name] = type.init()
    }

    func add<T>(_ protocolType: T.Type, for concreteType: Service.Type, with name: String? = nil) {
        let name = name ?? String(reflecting: protocolType)
        servicesDictionary[name] = concreteType.init()
    }

    func add(_ type: Service.Type, with name: String? = nil, constructor: () -> Service) {
        // check type

        let name = name ?? String(reflecting: type)
        servicesDictionary[name] = constructor()
    }

    func get<T>(by type: T.Type = T.self) -> T {
        return get(by: String(reflecting: type))
    }

    func get<T>(by name: String) -> T {
        guard let service = servicesDictionary[name] as? T else {
            fatalError("firstly you have to add the service")
        }

        return service
    }
}
