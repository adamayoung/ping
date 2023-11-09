//
//  SummaryRow.swift
//  Ping
//
//  Created by Adam Young on 02/11/2023.
//

import SwiftUI

struct SummaryRow: View {

    var body: some View {
        Label("SUMMARY", systemImage: "tablecells")
            .accessibilityIdentifier("summaryNavigationLink")
    }
}

#Preview {
    NavigationStack {
        List {
            SummaryRow()
        }
    }
    #if os(macOS)
    .listStyle(.sidebar)
    #else
    .listStyle(.insetGrouped)
    #endif
}
