import React from 'react';
import 'react-credit-cards-2/dist/es/styles-compiled.css';
import EnterCreditCard from "./EnterCreditCard";
import ConfirmCheckout from "./ConfirmCheckout";
import Box from "@mui/material/Box";
import {Step, StepContent, StepLabel, Stepper} from "@mui/material";
import Typography from "@mui/material/Typography";
import Stack from "@mui/material/Stack";
import Button from "@mui/material/Button";
import ArrowBackIosIcon from "@mui/icons-material/ArrowBackIos";
import ShoppingCartIcon from "@mui/icons-material/ShoppingCart";
import ShoppingBagIcon from '@mui/icons-material/ShoppingBag';
import PropTypes from "prop-types";
import {Ticket} from "./Ticket";
import ContinueChoosingButton from "../Base/ContinueChoosingButton";


export default class Checkout extends React.Component {

    static propTypes = {
        app: PropTypes.object.isRequired,
        cart: PropTypes.object.isRequired,
        notifyMessageWith: PropTypes.func.isRequired,
        cancelCheckout: PropTypes.func.isRequired,
        listPurchases: PropTypes.func.isRequired,
    };

    _STEP_ENTER_CARD = 0;
    _STEP_CONFIRM_CHECKOUT = 1;
    _STEP_CHECKOUT_FINISHED = 2;

    constructor(props) {
        super(props);
        this.state = {
            step: this._STEP_ENTER_CARD,
            card: {
                number: '',
                name: '',
                expiry: ''
            },
            transactionId: null,
        }
    }

    render() {
        return <>
            {this.renderContent()}
            {this.renderContinueChoosingButton()}
        </>
    }

    renderContent() {
        return (
            <Box
                sx={{
                    my: 8,
                    mx: 4,
                    display: 'flex',
                    flexDirection: 'column',
                    alignItems: 'center',
                }}
            >
                <Stepper activeStep={this.state.step} orientation="vertical">
                    <Step key={1}>
                        {this.renderEnterCard()}
                    </Step>
                    <Step key={2}>
                        {this.renderConfirmCheckout()}
                    </Step>
                    <Step key={3}>
                        {this.renderCheckoutResult()}
                    </Step>
                </Stepper>
            </Box>
        );
    }

    renderEnterCard() {
        return <>
            <StepLabel><Typography variant="h6">Ingresar medio de pago</Typography></StepLabel>
            <StepContent>
                <EnterCreditCard card={this.state.card}
                                 onChangeCard={(cardField, cardValue) => this._changeCard(cardField, cardValue)}/>
                <Stack direction="row" justifyContent="space-around" gap={1}>
                    <Button variant="contained" startIcon={<ShoppingCartIcon/>}
                            onClick={() => this.setState({step: this._STEP_CONFIRM_CHECKOUT})}>
                        Siguiente
                    </Button>
                </Stack>
            </StepContent>
        </>;
    }

    renderConfirmCheckout() {
        return <>
            <StepLabel><Typography variant="h6">Confirmar pago</Typography></StepLabel>
            <StepContent>
                <ConfirmCheckout card={this.state.card} amountToPay={this._amountToPay()}/>
                <Stack direction="row" justifyContent="space-around" gap={1}>
                    <Button variant="contained" color="secondary" startIcon={<ArrowBackIosIcon/>}
                            onClick={() => this.setState({step: this._STEP_ENTER_CARD})}>
                    </Button>
                    <Button variant="contained" startIcon={<ShoppingCartIcon/>}
                            onClick={() => this._checkout()}>
                        Confirmar Pago
                    </Button>
                </Stack>
            </StepContent>
        </>;
    }

    renderCheckoutResult() {
        return <>
            <StepLabel><Typography variant="h6">¡Ya son tuyos!</Typography></StepLabel>
            <StepContent>
                <Ticket transactionId={this.state.transactionId}/>
                <Box sx={{
                    display: 'flex',
                    justifyContent: 'right',
                    width: '100%',
                    p: 1,
                    m: 1,
                }}>
                    <Button variant="contained" color="secondary" size="small"
                            onClick={() => this.props.listPurchases()} startIcon={<ShoppingBagIcon />}>
                        Ver mis compras
                    </Button>
                </Box>
            </StepContent>
        </>;
    }

    renderContinueChoosingButton() {
        return <ContinueChoosingButton onClick={() => this.props.cancelCheckout()} />
    }

    _checkout() {
        const result = this.props.app.checkout(this.state.card, this.props.cart);
        result.then((response) => {
            if (response.hasError()) {
                this.props.notifyMessageWith("error", response.message())
            } else {
                return this.setState({step: this._STEP_CHECKOUT_FINISHED, transactionId: response.transactionId()});
            }
        })
    }

    _changeCard(cardField, cardValue) {
        this.setState({card: {...this.state.card, [cardField]: cardValue}})
    }

    _amountToPay() {
        return this.props.app.totalOf(this.props.cart.items);
    }
}