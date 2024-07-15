import {ApiResponse as AppyxApiResponse} from "@eryxcoop/appyx-comm";


export default class ApiResponse extends  AppyxApiResponse{

    // Renombrar en la superclase _jsonResponse por  _rawResponse
    constructor(jsonResponse) {
        super(jsonResponse);
        this._rawResponse = jsonResponse;
    }

}