import {ApiResponse} from "@eryxcoop/appyx-comm";


export class ItemAddedToCartResponse extends ApiResponse {

    static understandThis(aRawResponse) {
        const result = aRawResponse.split('|');
        const code = result[0];
        return code == '0';
    }

    static defaultResponse() {
        return '0|ok';
    }

    errors() {
        return []
    }

}