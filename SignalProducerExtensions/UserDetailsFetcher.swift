//
//  UserDetailsFetcher.swift
//  SignalProducerExtensions
//
// Created by u on 11.01.20.
// Copyright (c) 2020 yes. All rights reserved.
//

import ReactiveSwift

public struct UserDetailsFetcher {
    /// A type of function to make an API request to get `UserDetails`.
    /// This will send only one value and complete. For simplicity, we don't
    /// handle errors.
    public typealias NetworkRequest = (Username) -> SignalProducer<UserDetails, Never>

    let networkRequest: NetworkRequest

    public init(networkRequest: @escaping NetworkRequest) {
        self.networkRequest = networkRequest
    }

    /// Sequentially fetches details for every `Username`.
    public func fetchDetails(for usernames: [Username]) -> SignalProducer<[UserDetails], Never> {
        return usernames
            .map(self.networkRequest)
            .sequence()
    }
}
