//
//  RemoveSiteUseCase.swift
//  PingDomain
//
//  Created by Adam Young on 28/10/2023.
//

import Foundation

public protocol RemoveSiteUseCase {

    func execute(id: Site.ID) async throws

}
