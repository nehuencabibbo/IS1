import ApiResponse from "../communication/ApiResponse";


export class SuccessfulCheckoutResponse extends ApiResponse {

    static understandThis(aRawResponse) {
        const result = aRawResponse.split('|');
        const code = result[0];
        return code === '0';
    }

    static defaultResponse() {
        return '0|123456789';
    }


    errors() {
        return []
    }

    transactionId(){
        return this._rawResponse.split('|')[1];
    }
}