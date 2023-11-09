import Foundation

func pingReducer(state: PingState, action: PingAction) -> PingState {
    var state = state

    switch action {
    case .sites(let sitesAction):
        state.sites = sitesReducer(state: state.sites, action: sitesAction)

    case .siteStatuses(let siteStatusesAction):
        state.siteStatuses = siteStatusesReducer(state: state.siteStatuses, action: siteStatusesAction)
    }

    return state
}
