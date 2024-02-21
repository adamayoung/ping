//
//  File.swift
//  
//
//  Created by Adam Young on 19/02/2024.
//

import SwiftData
import SwiftUI

final class DataGeneration {

    private init() { }

    static func generateSampleData(in modelContext: ModelContext) {
        do {
            try modelContext.delete(model: Site.self)
        } catch {
            fatalError(error.localizedDescription)
        }

        let sites = Site.generate()
        for site in sites {
            modelContext.insert(site)
        }

        let siteGroups = SiteGroup.generate()
        for siteGroup in siteGroups {
            modelContext.insert(siteGroup)
        }
    }

}

struct GenerateDataViewModifier: ViewModifier {

    @Environment(\.modelContext) private var modelContext

    func body(content: Content) -> some View {
        content.onAppear {
            DataGeneration.generateSampleData(in: modelContext)
        }
    }

}

public extension View {

    func generateSampleData() -> some View {
        modifier(GenerateDataViewModifier())
    }

}
