//
//  NoSitesView.swift
//  Ping
//
//  Created by Adam Young on 28/10/2023.
//

import SwiftUI

struct NoSitesView: View {

    var body: some View {
        ContentUnavailableView("NO_SITES", systemImage: "globe")
    }

}

#Preview {
    NoSitesView()
}
