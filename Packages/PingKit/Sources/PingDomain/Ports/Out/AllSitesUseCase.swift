//
//  AllSitesUseCase.swift
//  PingDomain
//
//  Created by Adam Young on 28/10/2023.
//

import Foundation

public protocol AllSitesUseCase {

    func execute() async throws -> [Site]

}
