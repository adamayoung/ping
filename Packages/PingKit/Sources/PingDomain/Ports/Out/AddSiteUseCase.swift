//
//  AddSiteUseCase.swift
//  PingDomain
//
//  Created by Adam Young on 28/10/2023.
//

import Foundation

public protocol AddSiteUseCase {

    func execute(_ site: Site) async throws

}
