//
//  UserDetails.swift
//  SignalProducerExtensions
//
//
// Created by u on 11.01.20.
// Copyright (c) 2020 yes. All rights reserved.
//

public typealias Username = String

/// Simple struct with user details.
public struct UserDetails {
    let name: Username

    public init(name: Username) {
        self.name = name
    }
}

extension UserDetails: Equatable {}
