//
//  AddSiteView.swift
//  Ping
//
//  Created by Adam Young on 27/10/2023.
//

import SwiftData
import SwiftUI

struct AddSiteView: View {

    @Environment(\.modelContext) private var modelContext
    @Environment(SiteStatusCheckerService.self) private var siteStatusCheckerService
    @Environment(\.dismiss) private var dismiss

    @Query(sort: [SortDescriptor(\SiteGroup.name, comparator: .localizedStandard)]) private var siteGroups: [SiteGroup]

    @State private var formModel = AddSiteFormModel()
    @State private var isAddingSite = false
    @FocusState private var focusedField: Field?

    enum Field: Int, Hashable {
        case siteName
        case siteURL
        case timeout
    }

    var body: some View {
        Form {
            Section {
                siteNameField
                siteURLField
                siteGroupPicker
            }

            Section("OPTIONS") {
                methodPicker
                timeoutField
            }
        }
        .formStyle(.grouped)
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
            .onSubmit { focusedField = .timeout }
            .accessibilityIdentifier("siteURLField")
    }

    private var siteGroupPicker: some View {
        Picker("SITE_GROUP", selection: $formModel.siteGroup) {
            ForEach(siteGroups) { siteGroup in
                Text(verbatim: siteGroup.name)
                    .tag(siteGroup as SiteGroup?)
            }

            Text("NO_GROUP_ITEM")
                .tag(nil as SiteGroup?)
        }
        .accessibilityIdentifier("siteGroupPicker")
    }

    private var methodPicker: some View {
        Picker("METHOD", selection: $formModel.method) {
            ForEach(AddSiteFormModel.Method.allCases, id: \.self) {
                Text($0.localizedName)
            }
        }
        .accessibilityIdentifier("siteMethodPicker")
    }

    #if os(iOS)
    @MainActor private var timeoutField: some View {
        LabeledContent("TIMEOUT") {
            HStack {
                TextField("TIMEOUT", value: $formModel.timeout, formatter: NumberFormatter())
                    .multilineTextAlignment(.trailing)
                    .submitLabel(.next)
                    .focused($focusedField, equals: .timeout)
                    .onSubmit { addSite() }
                    .accessibilityIdentifier("siteTimeoutField")
                Text("UNIT_MS")
                    .foregroundStyle(.primary)
            }
        }
    }
    #endif

    #if os(macOS)
    @MainActor private var timeoutField: some View {
        TextField("TIMEOUT_MS", value: $formModel.timeout, formatter: NumberFormatter())
            .multilineTextAlignment(.trailing)
            .submitLabel(.next)
            .focused($focusedField, equals: .timeout)
            .onSubmit { addSite() }
            .accessibilityIdentifier("siteTimeoutField")
    }
    #endif

}

extension AddSiteView {

    @MainActor
    private func addSite() {
        guard let site = formModel.site else {
            return
        }

        isAddingSite = true

        withAnimation {
            modelContext.insert(site)
        }

        do {
            try modelContext.save()
        } catch let error {
            fatalError(error.localizedDescription)
        }

        if let requestTask = SiteStatusRequestTask(siteRequest: site.request) {
            Task {
                await siteStatusCheckerService.checkSiteStatus(using: requestTask)
            }
        }

        dismiss()
    }

}

#Preview {
    let modelContainer = PingFactory.shared.modelContainer

    return AddSiteView()
        .modelContainer(modelContainer)
}
