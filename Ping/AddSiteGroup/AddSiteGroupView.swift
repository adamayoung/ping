//
//  AddSiteGroupView.swift
//  Ping
//
//  Created by Adam Young on 10/11/2023.
//

import SwiftUI

struct AddSiteGroupView: View {

    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var formModel = AddSiteGroupFormModel()
    @FocusState private var focusedField: Field?

    enum Field: Int, Hashable {
        case siteGroupName
    }

    var body: some View {
        Form {
            siteGroupNameField
        }
        .formStyle(.grouped)
        .onAppear {
            focusedField = .siteGroupName
        }
        .navigationTitle("ADD_SITE_GROUP")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
        .toolbar {
            toolbar
        }
    }

    private var siteGroupNameField: some View {
        TextField("NAME", text: $formModel.name)
            .submitLabel(.next)
            .focused($focusedField, equals: .siteGroupName)
            .onSubmit { addSiteGroup() }
            .accessibilityIdentifier("siteGroupNameField")
    }

    @ToolbarContentBuilder private var toolbar: some ToolbarContent {
        ToolbarItem(placement: .cancellationAction) {
            Button {
                dismiss()
            } label: {
                Text("CANCEL")
            }
            .help("CANCEL")
            .accessibilityIdentifier("cancelAddSiteGroupButton")
        }

        ToolbarItem(placement: .primaryAction) {
            Button {
                addSiteGroup()
            } label: {
                Text("ADD")
            }
            .help("ADD_SITE_GROUP")
            .accessibilityIdentifier("addSiteGroupButton")
            .disabled(!formModel.isValid)
        }
    }

}

extension AddSiteGroupView {

    private func addSiteGroup() {
        guard let siteGroup = formModel.siteGroup else {
            return
        }

        withAnimation {
            modelContext.insert(siteGroup)
        }

        do {
            try modelContext.save()
        } catch let error {
            fatalError(error.localizedDescription)
        }

        dismiss()
    }

}

#Preview {
    let modelContainer = PingFactory.shared.modelContainer

    return NavigationStack {
        AddSiteGroupView()
    }
    .modelContainer(modelContainer)
}
