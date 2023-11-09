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

    @State private var formModel = AddSiteFormModel()
    @State private var isAddingSite = false
    @FocusState private var focusedField: Field?

    enum Field: Int, Hashable {
       case siteName
       case siteURL
    }

    var body: some View {
        Form {
            Section {
                siteNameField
                siteURLField
            }
        }
        .interactiveDismissDisabled(isAddingSite)
        .onAppear {
            focusedField = .siteName
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
                .help("CANCEL")
                .disabled(isAddingSite)
                .accessibilityIdentifier("cancelButton")
            }

            ToolbarItem(placement: .primaryAction) {
                Button {
                    addSite()
                } label: {
                    Text("ADD")
                }
                .help("ADD_SITE")
                .opacity(isAddingSite ? 0 : 1)
                .overlay {
                    if isAddingSite {
                        ProgressView()
                    }
                }
                .accessibilityIdentifier("addButton")
                .disabled(!formModel.isValid)
            }
        }
    }

    private var siteNameField: some View {
        TextField("SITE_NAME", text: $formModel.name)
            .submitLabel(.next)
            .focused($focusedField, equals: .siteName)
            .onSubmit { focusedField = .siteURL }
            .accessibilityIdentifier("siteNameField")
    }

    private var siteURLField: some View {
        TextField("URL", text: $formModel.url)
            #if os(iOS)
            .keyboardType(.URL)
            .textInputAutocapitalization(.never)
            #endif
            .submitLabel(.return)
            .disableAutocorrection(true)
            .textContentType(.URL)
            .focused($focusedField, equals: .siteURL)
            .onSubmit {
                addSite()
            }
            .accessibilityIdentifier("siteURLField")
    }

}

extension AddSiteView {

    private func addSite() {
        guard let site = formModel.site else {
            return
        }

        isAddingSite = true
        Task {
            await store.send(.sites(.store(site)))
            await store.send(.siteStatuses(.checkSiteStatus(site)))
            await MainActor.run {
                dismiss()
            }
        }
    }

}

#Preview {
    let store = PingStore.preview()

    return AddSiteView()
        .environment(store)
}
