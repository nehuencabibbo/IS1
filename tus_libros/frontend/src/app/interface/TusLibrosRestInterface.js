import {ApiClient, Endpoint} from "@eryxcoop/appyx-comm";
import {ItemAddedToCartResponse} from "./responses/ItemAddedToCartResponse";
import {ErrorResponse} from "./responses/ErrorResponse";
import {CartResponse} from "./responses/CartResponse";
import ApiResponseHandler from "@eryxcoop/appyx-comm/src/errors/ApiResponseHandler";
import {CreateCartResponse} from "./responses/CreateCartResponse";
import {SuccessfulCheckoutResponse} from "./responses/SuccessfulCheckoutResponse";
import {ListPurchasesResponse} from "./responses/ListPurchasesResponse";


export class TusLibrosRestInterface{

    constructor(requester) {
        this._apiClient = new ApiClient(requester);
    }

    createCart(aClientId, aPassword) {
        const values = {clientId: aClientId, password: aPassword};
        return this._callEndpoint(this._createCartEndpoint(), values);
    }

    listCart(aCartId) {
        let values = {cartId: aCartId};
        return this._callEndpoint(this._listCartEndpoint(), values);
    }

    addToCart(aBook, aQuantity, aCart){
        const values = {
            bookIsbn: aBook.isbn,
            bookQuantity: aQuantity.toString(),
            cartId: aCart.id
        };
        return this._callEndpoint(this._addToCartEndpoint(), values);
    }

    checkout(aCard, aCart) {
        const values = {
            cartId: aCart.id,
            ccn: aCard.number,
            cced: aCard.expiry,
            cco: aCard.name
        };
        return this._callEndpoint(this._checkoutCartEndpoint(), values);
    }

    listPurchases(aClientId, aPassword) {
        const values = {clientId: aClientId, password: aPassword};
        return this._callEndpoint(this._listPurchasesEndpoint(), values);
    }

    _callEndpoint(endpoint, values) {
        const responseHandler = new ApiResponseHandler(
            {
                handlesSuccess: (response) => response,
                handlesError: (response) => response,
            });
        return this._apiClient.callEndpoint(endpoint, values, responseHandler);
    }

    _createCartEndpoint() {
        return Endpoint.newGet({
            url: 'createCart',
            ownResponses: [CreateCartResponse, ErrorResponse],
            needsAuthorization: false,
            contentType: 'application/json'
        })
    }

    _listCartEndpoint() {
        return Endpoint.newGet({
            url: 'listCart',
            ownResponses: [CartResponse, ErrorResponse],
            needsAuthorization: false,
            contentType: 'application/json'
        })
    }

    _addToCartEndpoint() {
        return Endpoint.newGet({
            url: 'addToCart',
            ownResponses:  [ItemAddedToCartResponse, ErrorResponse],
            needsAuthorization: false,
            contentType: 'application/json'
        })
    }

    _checkoutCartEndpoint() {
        return Endpoint.newGet({
            url: 'checkOutCart',
            ownResponses:  [SuccessfulCheckoutResponse, ErrorResponse],
            needsAuthorization: false,
            contentType: 'application/json'
        })
    }

    _listPurchasesEndpoint() {
        return Endpoint.newGet({
            url: 'listPurchases',
            ownResponses:  [ListPurchasesResponse, ErrorResponse],
            needsAuthorization: false,
            contentType: 'application/json'
        })
    }
}