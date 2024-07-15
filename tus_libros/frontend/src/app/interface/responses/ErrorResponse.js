import ApiResponse from "../communication/ApiResponse";


export class ErrorResponse extends ApiResponse {

    static understandThis(content) {
        const result = content.split('|');
        const code = result[0];
        return code == '1';
    }

    errors() {
        return [this.message()]
    }

    message() {
        return this._rawResponse.split('|')[1];
    }
}