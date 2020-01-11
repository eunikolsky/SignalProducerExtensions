//
//  SignalProducerExtensions.swift
//  SignalProducerExtensions
//
// Created by u on 11.01.20.
// Copyright (c) 2020 yes. All rights reserved.
//

import ReactiveSwift

public extension Collection where Element: SignalProducerProtocol, Element.Error == Never {
    /// Sequentially executes an array of `SignalProducer`s and collects the results in an array.
    /// The type is effectively is:
    /// `sequence : Array<SignalProducer<T, E>> -> SignalProducer<Array<T>, E>`
    func sequence() -> SignalProducer<[Element.Value], Element.Error> {
        func iter <C: Collection> (_ producers: C, _ results: [Element.Value]) -> SignalProducer<[Element.Value], Element.Error> where C.Element == Element {
            switch producers.first {
            case .some(let producer):
                return producer.producer.flatMap(.merge, { value in
                    iter(producers.dropFirst(), results + [value])
                })

            case .none:
                return SignalProducer(value: results)
            }
        }

        return iter(self, [])
    }
}
