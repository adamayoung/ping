import Foundation

func pingReducer(state: PingState, action: PingAction) -> PingState {
    var state = state

    switch action {
    case .sites(let sitesAction):
        state.sites = sitesReducer(state: state.sites, action: sitesAction)
    }

    return state
}
