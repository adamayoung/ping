//
//  AddSiteView.swift
//  Ping
//
//  Created by Adam Young on 27/10/2023.
//

import PingKit
import SwiftUI

struct AddSiteView: View {

    @Environment(PingStore.self) private var store
    @Environment(\.dismiss) private var dismiss

    @State private var name: String = ""
    @FocusState private var nameFieldIsFocused: Bool
    @State private var url: String = ""
    @FocusState private var urlFieldIsFocused: Bool

    var body: some View {
        Form {
            Section {
                TextField("SITE_NAME", text: $name)
                    .focused($nameFieldIsFocused)

                TextField("URL", text: $url)
                    #if os(iOS)
                    .keyboardType(.URL)
                    .textInputAutocapitalization(.never)
                    #endif

                    .disableAutocorrection(true)
                    .textContentType(.URL)
                    .focused($urlFieldIsFocused)
            }
        }
        .navigationTitle("ADD_SITE")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button {
                    dismiss()
                } label: {
                    Text("CANCEL")
                }
            }

            ToolbarItem(placement: .primaryAction) {
                Button {
                    addSite()
                } label: {
                    Text("ADD")
                }
                .disabled(!isValid)
            }
        }
    }

}

extension AddSiteView {

    private var isValid: Bool {
        if name.isEmpty {
            return false
        }

        let url = URL(string: url)

        if url?.scheme == nil || url?.host() == nil {
            return false
        }

        return true
    }

    private func addSite() {
        let site = Site(
            id: UUID(),
            name: name,
            url: URL(string: url)!
        )

        Task {
            await store.send(.addSite(site))
        }

        dismiss()
    }

}

#Preview {
    let store = PingStore.preview

    return AddSiteView()
        .environment(store)
}
