import ApiResponse from "../communication/ApiResponse";


export class CartResponse extends ApiResponse {

    static understandThis(aRawResponse) {
        const result = aRawResponse.split('|');
        const code = result[0];
        return code == '0';
    }

    static defaultResponse() {
        return '0|Smalltalk Best Practice Patterns|1|Modern Software Engineering|1';
    }


    errors() {
        return []
    }

    cartItems(){
        const items = this._rawResponse.split('|').slice(1).filter( (each) => each != "");
        return (0).range(items.length - 1, 2).map( (index) => {
            return {
                article: {isbn: items[index]},
                quantity: items[index + 1]
            }
        } )
    }

    cartItemsCollect(aClosure){
        return this.cartItems().map( (aCartItem) => {
            return aClosure(aCartItem.article.isbn, aCartItem.quantity)
        });
    }
}