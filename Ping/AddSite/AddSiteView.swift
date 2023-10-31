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

    @State private var isValid = false
    @State private var name: String = ""
    @FocusState private var nameFieldIsFocused: Bool
    @State private var url: String = ""
    @FocusState private var urlFieldIsFocused: Bool

    var body: some View {
        Form {
            Section {
                TextField("SITE_NAME", text: $name)
                    .focused($nameFieldIsFocused)
                    .accessibilityIdentifier("siteNameField")

                TextField("URL", text: $url)
                    #if os(iOS)
                    .keyboardType(.URL)
                    .textInputAutocapitalization(.never)
                    #endif
                    .disableAutocorrection(true)
                    .textContentType(.URL)
                    .focused($urlFieldIsFocused)
                    .accessibilityIdentifier("siteURLField")
            }
        }
        .accessibilityIdentifier("addSiteView")
        .onAppear {
            nameFieldIsFocused = true
        }
        .onChange(of: url) { _, _ in
            validateForm()
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
                .accessibilityIdentifier("cancelButton")
                .accessibilityLabel("CANCEL")
            }

            ToolbarItem(placement: .primaryAction) {
                Button {
                    addSite()
                } label: {
                    Text("ADD")
                }
                .accessibilityIdentifier("addButton")
                .accessibilityLabel("ADD_SITE")
                .disabled(!isValid)
            }
        }
    }

}

extension AddSiteView {

    private func validateForm() {
        if name.isEmpty {
            isValid = false
            return
        }

        let url = URL(string: url)

        if url?.scheme == nil || url?.host() == nil {
            isValid = false
            return
        }

        isValid = true
    }

    private func addSite() {
        let site = Site(
            name: name,
            url: URL(string: url)!
        )

        Task {
            await store.send(.sites(.add(site)))
        }

        dismiss()
    }

}

#Preview {
    let store = PingStore.preview

    return AddSiteView()
        .environment(store)
}
