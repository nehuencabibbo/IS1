import React from 'react';
import Cards from 'react-credit-cards-2';
import 'react-credit-cards-2/dist/es/styles-compiled.css';
import Box from "@mui/material/Box";
import Typography from "@mui/material/Typography";
import PaymentIcon from '@mui/icons-material/Payment';
import {Avatar} from "@mui/material";
import Stack from "@mui/material/Stack";
import AttachMoneyIcon from "@mui/icons-material/AttachMoney";
import PropTypes from "prop-types";

export default class ConfirmCheckout extends React.Component {

    static propTypes = {
        card: PropTypes.object.isRequired,
        amountToPay: PropTypes.number.isRequired
    };

    render() {
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
                <Avatar sx={{m: 1, backgroundColor: 'secondary.main'}}>
                    <PaymentIcon/>
                </Avatar>
                <Typography component="h1" variant="h5">
                    Por favor confirme la compra
                </Typography>
                {this.renderTotal()}
                <Stack spacing={2} sx={{my: 2}}>
                    <Cards
                        focused={'number'}
                        expiry={this.props.card.expiry}
                        name={this.props.card.name}
                        number={this.props.card.number}
                        cvc={''}
                    />
                </Stack>
            </Box>
        );
    }

    renderTotal() {
        return <Stack direction="row" justifyContent="flex-end" alignItems="center">
            <AttachMoneyIcon fontSize="small"/>
            <Typography variant="h5">{this.props.amountToPay}</Typography>
        </Stack>;
    }
}