//
//  ManageSiteGroupsView.swift
//  Ping
//
//  Created by Adam Young on 10/11/2023.
//

import SwiftData
import SwiftUI

struct ManageSiteGroupsView: View {

    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var isAddingSiteGroup = false

    @Query(sort: [SortDescriptor(\SiteGroup.name, comparator: .localizedStandard)]) private var siteGroups: [SiteGroup]
    @Query private var sites: [Site]

    var body: some View {
        List {
            Section {
                ForEach(siteGroups) { siteGroup in
                    NavigationLink {
                        EmptyView()
                    } label: {
                        Label {
                            HStack {
                                Text(verbatim: siteGroup.name)
                                Spacer()

                                Text(verbatim: "\(siteGroup.sites?.count ?? 0)")
                                    .foregroundStyle(Color.secondary)

                            }
                        } icon: {
                            Image(systemName: "folder.fill")
                        }
                    }
                    .accessibilityIdentifier("siteGroupNavigationLink-\(siteGroup.id.uuidString)")
                }
                .onDelete(perform: delete)
            } footer: {
                if !siteGroups.isEmpty {
                    Text("SITES_IN_A_DELETED_GROUP_WILL_NOT_BE_DELETED")
                }
            }
        }
        .scrollDisabled(siteGroups.isEmpty)
        .overlay {
            if siteGroups.isEmpty {
                NoSiteGroupsView {
                    isAddingSiteGroup.toggle()
                }
            }
        }
        #if os(iOS)
        .listStyle(.insetGrouped)
        #endif
        .sheet(isPresented: $isAddingSiteGroup) {
            AddSiteGroupSheetView()
                .modelContext(modelContext)
        }
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
        .navigationTitle("SITE_GROUPS")
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button {
                    dismiss()
                } label: {
                    Text("CLOSE")
                }
                .help("CLOSE")
                .accessibilityIdentifier("closeSiteGroupToolbarButton")
            }

            ToolbarItem(placement: .primaryAction) {
                Button {
                    isAddingSiteGroup.toggle()
                } label: {
                    Label("ADD_SITE_GROUP", systemImage: "plus")
                }
                .help("ADD_SITE_GROUP")
                .accessibilityIdentifier("addSiteGroupToolbarButton")
            }
        }
    }

}

extension ManageSiteGroupsView {

    private func delete(at offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(siteGroups[index])
            }

            do {
                try modelContext.save()
            } catch let error {
                fatalError(error.localizedDescription)
            }
        }
    }

}

#Preview("Manage Site Groups") {
    let modelContainer = PingFactory.shared.modelContainer

    return NavigationStack {
        ManageSiteGroupsView()
    }
    .modelContainer(modelContainer)
}

#Preview("Manage Site Groups - No Groups") {
    let modelContainer = PingFactory.shared.modelContainer
    try? modelContainer.mainContext.delete(model: SiteGroup.self)

    return NavigationStack {
        ManageSiteGroupsView()
    }
    .modelContainer(modelContainer)
}
