import React, {Component} from "react";
import PropTypes from "prop-types";
import Container from "@mui/material/Container";
import BookRack from "./BookRack";
import Drawer from "@mui/material/Drawer";
import Header from "./Base/Header";
import Cart from "./Cart";
import CallToTakeACart from "./CallToTakeACart";
import {Alert, Snackbar} from "@mui/material";
import Checkout from "./Checkout/Checkout";
import MyPurchases from "./MyPurchases/MyPurchases";
import ShoppingCartIcon from "@mui/icons-material/ShoppingCart";
import Login from "./Base/Login";


export default class PublisherReceptionDesk extends Component {

    static propTypes = {
        app: PropTypes.object.isRequired
    };

    constructor(props) {
        super(props);
        this.state = {
            showMyPurchases: false,
            showCartPanel: false,
            showCheckout: false,
            cart: null,
            message: null
        }
    }

    render() {
        return <>
            {this.renderHeader()}
            {this.renderMainPanel()}
            {this.renderMessage()}
        </>
    }

    renderHeader() {
        return <Header
            onActionDo={() => this._listCart()}
            cartSize={this._cartSize()}
            onListPurchasesDo={() => this._listPurchases()}/>;
    }

    renderMainPanel() {
        return <main>
            {this.renderCartPanel()}
            {this.renderContent()}
        </main>;
    }

    renderContent() {
        if (this.state.showMyPurchases) {
            return <MyPurchases
                        app={this.props.app}
                        notifyMessageWith={ (severity, text) => this._notifyMessageWith(severity, text)}
                        onCloseDo={ () => this._closeMyPurchases() }/>
        }
        if (this.state.showCheckout) {
            return <Checkout
                        app={this.props.app}
                        cart={this._cart()}
                        notifyMessageWith={ (severity, text) => this._notifyMessageWith(severity, text)}
                        cancelCheckout={ () => this._cancelCheckout() }
                        listPurchases={ () => this._listPurchases() }
            />
        }
        return <>
            {this.renderCallToTakeACart()}
            <Container sx={{py: 8}} maxWidth="md">
                <BookRack app={this.props.app} onAddToCartDo={ (aBook, aQuantity) => this._addToCart(aBook, aQuantity)}/>
            </Container>
        </>;
    }

    renderCallToTakeACart() {
        return <CallToTakeACart onTakeACartDo={() => this._takeANewCart()} />
    }

    renderCartPanel() {
        return <Drawer
            anchor={'right'}
            open={this.state.showCartPanel}
            onClose={() => this.setState({showCartPanel: false})}
        >
            {this.renderCartPanelContent()}
        </Drawer>
    }

    renderCartPanelContent() {
        if (this._hasTakenACart()){
            return <Cart cart={this.state.cart} onCheckoutDo={ () => this._checkout() }/>;
        }
        else {
            return this.renderTakeACart()
        }
    }

    renderTakeACart() {
        return <Login
            title={'Inicia tu pedido'}
            buttonLabel={'Iniciar Pedido'}
            titleIcon={<ShoppingCartIcon />}
            onLoginDo={ (aClientId, aPassword) => this._takeACartFor(aClientId, aPassword) }/>
    }

    renderMessage(){
        if (this.state.message != null) {
            return <Snackbar open={true} autoHideDuration={6000} onClose={() => this._closeMessage()}>
                <Alert severity={this.state.message.severity} sx={{width: '100%'}}>
                    {this.state.message.text}
                </Alert>
            </Snackbar>
        }
    }

    _listCart() {
        this._fillCartWithItems(this._cart().id, true);
    }

    _takeANewCart() {
        this.setState({showCartPanel: true, cart: null})
    }

    _takeACartFor(aClientId, aPassword) {
        const result = this.props.app.createCart(aClientId, aPassword);
        this._handlePromisedResult(result, (aSuccessfulResponse) => {
            this.setState({cart: {id: aSuccessfulResponse.cartId(), items: []}, showCartPanel: false})
            this._notifyMessageWith(
                "success", "Ya puedes agregar tus libros preferidos al carrito")
        })
    }

    _fillCartWithItems(cartId, showCart) {
        const result = this.props.app.listCart(cartId);
        this._handlePromisedResult(result, (aSuccessfulResponse) => {
            this.setState({cart: {id: cartId, items: this._itemsFrom(aSuccessfulResponse)}, showCartPanel: showCart})
        })
    }

    _itemsFrom(response) {
        return response.cartItemsCollect((isbn, quantity) => {
            const aBook = this.props.app.bookWithIsbn(isbn);
            return {article: aBook, quantity: quantity}
        });
    }

    _addToCart(aBook, aQuantity) {
        const result = this.props.app.addToCart(aBook, aQuantity, this._cart());
        this._handlePromisedResult(result, (aSuccessfulResponse) => {
            this._notifyMessageWith("success", `Se ha agregado "${aBook.title}" al carrito!`)
        })
    }

    _handlePromisedResult(aPromisedResult, aClosureForSuccessfulResponse) {
        aPromisedResult.then((response) => {
            if (response.hasError()) {
                this._notifyMessageWith("error", response.message())
            } else {
                return aClosureForSuccessfulResponse(response)
            }
        })
    }

    _hasTakenACart() {
        return this.state.cart != null;
    }

    _closeMessage() {
        this.setState({message: null});
    }

    _notifyMessageWith(severity, text) {
        this.setState({message: {severity: severity, text: text}});
    }

    _cart() {
        if (!this._hasTakenACart()) {
            return {id: '', items: []};
        } else {
            return this.state.cart;
        }
    }

    _cartSize() {
        return this._cart().items.length
    }

    _checkout() {
        this.setState({showCheckout: true, showCartPanel: false, showMyPurchases: false})
    }

    _cancelCheckout() {
        this.setState({showCheckout: false})
    }

    _closeMyPurchases() {
        this.setState({showMyPurchases: false})
    }

    _listPurchases() {
        this.setState({showMyPurchases: true, showCheckout: false, showCartPanel: false})
    }
}