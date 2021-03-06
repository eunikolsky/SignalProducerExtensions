//
//  UserDetailsFetcherSpec.swift
//  SignalProducerExtensionsTests
//
//  Created by u on 11.01.20.
//  Copyright © 2020 yes. All rights reserved.
//

import ReactiveSwift
import SignalProducerExtensions

import Nimble
import Quick

class UserDetailsFetcherSpec: QuickSpec {
    override func spec() {
        describe("fetchDetails") {
            let fakeNetworkRequest = { username in
                SignalProducer(value: UserDetails(name: "~" + username))
                    .delay(0.001, on: QueueScheduler(qos: .userInteractive))
            }
            let sut = UserDetailsFetcher(networkRequest: fakeNetworkRequest)

            it("returns details for all users") {
                let detailsProducer = sut.fetchDetails(for: ["foo", "bar", "!"])
                let result = detailsProducer.single()

                let expected = [UserDetails(name: "~foo"), UserDetails(name: "~bar"), UserDetails(name: "~!")]
                let actual = try! result?.get()
                expect(actual).to(equal(expected))
            }

            it("returns empty details for no users") {
                let detailsProducer = sut.fetchDetails(for: [])
                let result = detailsProducer.single()

                let actual = try! result?.get()
                expect(actual).to(beEmpty())
            }
        }
    }
}
