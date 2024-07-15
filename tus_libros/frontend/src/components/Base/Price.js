import React from "react";
import PropTypes from "prop-types";
import Stack from "@mui/material/Stack";
import AttachMoneyIcon from "@mui/icons-material/AttachMoney";
import Typography from "@mui/material/Typography";


export class Price extends React.Component {

    static propTypes = {
        value: PropTypes.number.isRequired,
        currencyFontSize: PropTypes.oneOf(["inherit", "large", "medium", "small"]),
        valueFontSize: PropTypes.string,
    };

    static defaultProps = {
        currencyFontSize: "small"
    }

    render() {
        return <Stack direction="row" justifyContent="flex-end" alignItems="center">
            <AttachMoneyIcon fontSize={this.props.currencyFontSize}/>
            <Typography variant="h6" sx={ {fontSize: this.props.valueFontSize }}>{this._localeValue()}</Typography>
        </Stack>;
    }

    _localeValue() {
        return this.props.value.toLocaleString('es-AR');
    }
}