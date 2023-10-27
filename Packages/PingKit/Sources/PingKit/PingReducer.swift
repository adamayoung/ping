import Foundation

func pingReducer(state: PingState, action: PingAction) -> PingState {
    var state = state

    switch action {
    case .fetchSitesError(let error):
        state.sitesError = error

    case .setSites(let sites):
        state.sites = sites

    case .addSite(let site):
        var sites = state.sites
        sites.append(site)
        state.sites = sites.sorted(by: { $0.name.localizedStandardCompare($1.name) == .orderedAscending })

    default:
        break
    }

    return state
}
