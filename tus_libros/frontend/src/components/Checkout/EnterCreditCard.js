import React from 'react';
import Cards from 'react-credit-cards-2';
import 'react-credit-cards-2/dist/es/styles-compiled.css';
import Box from "@mui/material/Box";
import PaymentIcon from '@mui/icons-material/Payment';
import AccountCircleIcon from '@mui/icons-material/AccountCircle';
import CalendarMonthIcon from '@mui/icons-material/CalendarMonth';
import {InputAdornment, TextField} from "@mui/material";
import PropTypes from "prop-types";


export default class EnterCreditCard extends React.Component {

    static propTypes = {
        card: PropTypes.object.isRequired,
        onChangeCard: PropTypes.func.isRequired,
    };

    constructor(props) {
        super(props);
        this.state = {
            focus: '',
        };
    }

    handleInputFocus(event) {
        this.setState({focus: event.target.name});
    }

    handleFieldChange(event) {
        const {name, value} = event.target;
        this.props.onChangeCard(name, value);
    }

    render() {
        return (
            <Box
                sx={{
                    p: 4,
                    display: 'flex',
                    flexDirection: 'column',
                    alignItems: 'center',
                }}
            >
                {this.renderCard()}
                {this.renderCardInputs()}
            </Box>
        );
    }

    renderCard() {
        return <Cards
            focused={this.state.focus}
            expiry={this.props.card.expiry}
            name={this.props.card.name}
            number={this.props.card.number}
            cvc={''}
        />;
    }

    renderCardInputs() {
        return <>
            {this.renderTextField("number", "Número de tarjeta", <PaymentIcon/>, true)}
            {this.renderTextField("name", "Nombre y apellido", <AccountCircleIcon/>, false)}
            {this.renderTextField("expiry", "Fecha de vencimiento", <CalendarMonthIcon/>, false)}
        </>;
    }

    renderTextField(name, label, icon, autoFocus) {
        return <TextField
            InputProps={{
                startAdornment: (
                    <InputAdornment position="start">
                        {icon}
                    </InputAdornment>
                )
            }}
            margin="normal"
            required
            fullWidth
            id={name}
            label={label}
            name={name}
            autoComplete={name}
            autoFocus={autoFocus}
            value={this.props.card[name]}
            onChange={(event) => this.handleFieldChange(event)}
            onFocus={(event) => this.handleInputFocus(event)}
        />;
    }
}