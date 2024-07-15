import {RemoteRequester as AppyxRemoteRequester} from "@eryxcoop/appyx-comm";


export default class RemoteRequester extends AppyxRemoteRequester {
    call({endpoint, data = undefined}) {
        const request = this._buildRequest(endpoint, data);
        let url = endpoint.url();
        if (endpoint.isGetMethod() && data) {
            url += "?" + this._dataToQueryString(data);
        }

        return fetch(this._baseUrl + "/" + url, request).then(result => this._asContentType(result))
            .then(jsonResponse => {
                return this._buildResponse(jsonResponse, endpoint)
            })
    }

    _asContentType(result) {
        // Esto deberia ser responsabilidad del endpoint?
        return result.text()
    }
}

