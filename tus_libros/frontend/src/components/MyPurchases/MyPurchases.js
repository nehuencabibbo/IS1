import React, {Component} from "react";
import ShoppingBagIcon from '@mui/icons-material/ShoppingBag';
import Login from "../Base/Login";
import PropTypes from "prop-types";

import PointOfSaleIcon from '@mui/icons-material/PointOfSale';
import Typography from "@mui/material/Typography";
import Stack from "@mui/material/Stack";
import {Price} from "../Base/Price";
import Pluralizer from "../../lib/Pluralizer";
import PurchasesTable from "./PurchasesTable";
import {PurchasesSummeryCard} from "./PurchasesSummeryCard";
import ContinueChoosingButton from "../Base/ContinueChoosingButton";


export default class MyPurchases extends Component {

    static propTypes = {
        app: PropTypes.object.isRequired,
        onCloseDo: PropTypes.func.isRequired,
        notifyMessageWith: PropTypes.func.isRequired,
    };

    constructor(props) {
        super(props);
        this.state = {
            purchases: null,
        }
    }

    render() {
        return <>
            {this.renderContinueChoosingButton()}
            {this.renderContent()}
        </>
    }

    renderContent() {
        if (this._hasPurchases()) {
            return <Stack direction={"column"} alignItems={"center"}>
                {this.renderPurchasesSummery()}
                {this.renderPurchasesDetail()}
            </Stack>
        } else {
            return this.renderLogin()
        }
    }

    renderContinueChoosingButton() {
        return <ContinueChoosingButton onClick={() => this.props.onCloseDo()} />
    }

    renderLogin() {
        return <Login
            title={'Mis compras'}
            buttonLabel={'Ver Compras'}
            titleIcon={<ShoppingBagIcon/>}
            onLoginDo={(aClientId, aPassword) => this._listPurchases(aClientId, aPassword)}/>;
    }

    renderPurchasesSummery() {
        return <Stack direction={"row"} alignItems="space-between" spacing={2} marginY={5}>
            {this.renderPurchasesSummeryTotal()}
            {this.renderPurchasesSummeryCount()}
        </Stack>
    }

    renderPurchasesSummeryTotal() {
        return <PurchasesSummeryCard
            value={<Price value={this.state.purchases.total} valueFontSize="2rem" currencyFontSize="large"/>}
            icon={<PointOfSaleIcon
                fontSize="large"/>}/>
    }

    renderPurchasesSummeryCount() {
        const count = this.state.purchases.items.reduce( (count, anItem) => count + anItem.quantity, 0)
        return <PurchasesSummeryCard
            value={<Typography fontSize="2rem">{Pluralizer.for(count, 'unidad', 'es').value()}</Typography>}
            icon={<ShoppingBagIcon fontSize="large"/>}/>
    }

    renderPurchasesDetail() {
        const hasItems = this.state.purchases.items.length > 0
        if (hasItems) {
            return <PurchasesTable items={this.state.purchases.items}/>
        } else {
            return <Typography variant="h5" color="text.secondary" sx={{ flexGrow: 1 }}>
                {"Aún no has realizado ninguna compra"}
            </Typography>
        }
    }

    _hasPurchases() {
        return this.state.purchases !== null;
    }

    _listPurchases(aClientId, aPassword) {
        const result = this.props.app.listPurchases(aClientId, aPassword);
        result.then((response) => {
            if (response.hasError()) {
                this.props.notifyMessageWith("error", response.message())
            } else {
                this.setState({purchases: {items: this._itemsFrom(response), total: response.total()}})
            }
        })
    }

    _itemsFrom(response) {
        return response.itemsCollect((isbn, quantity) => {
            const aBook = this.props.app.bookWithIsbn(isbn);
            return {article: aBook, quantity: quantity}
        });
    }
}


