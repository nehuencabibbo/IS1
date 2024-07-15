import ApiResponse from "../communication/ApiResponse";


export class ListPurchasesResponse extends ApiResponse {

    static understandThis(aRawResponse) {
        const result = aRawResponse.split('|');
        const code = result[0];
        return code === '0';
    }

    static defaultResponse() {
        return '0|Smalltalk Best Practice Patterns|1|Modern Software Engineering|1|150000';
    }


    errors() {
        return []
    }

    total() {
        const content = this._content();
        return content[content.length - 1]
    }

    itemsCollect(aClosure){
        return this.items().map( (aPurchase) => {
            return aClosure(aPurchase.article.isbn, aPurchase.quantity)
        });
    }

    items(){
        const content = this._content();
        return (0).range(content.length - 2, 2).map( (index) => {
            return {
                article: {isbn: content[index]},
                quantity: parseInt(content[index + 1])
            }
        } )
    }

    _content() {
        return this._rawResponse.split('|').slice(1).filter((each) => each !== "");
    }
}