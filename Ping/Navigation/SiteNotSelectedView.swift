//
//  SiteNotSelectedView.swift
//  Ping
//
//  Created by Adam Young on 02/11/2023.
//

import SwiftUI

struct SiteNotSelectedView: View {

    var body: some View {
        ContentUnavailableView {
            Text("NO_SITE_SELECTED")
                .font(.headline)
                .foregroundStyle(Color.secondary)
        }
    }

}

#Preview {
    SiteNotSelectedView()
}
