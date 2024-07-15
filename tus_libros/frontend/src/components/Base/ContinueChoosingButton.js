import React, {Component} from "react";
import {Fab} from "@mui/material";
import AddShoppingCartIcon from "@mui/icons-material/AddShoppingCart";
import PropTypes from "prop-types";

export default class ContinueChoosingButton extends Component {

    static propTypes = {
        onClick: PropTypes.func.isRequired,
    };
    render() {
        return <Fab variant="extended" sx={{bottom: 20, right: 20, position: 'fixed', opacity: 0.7}}
                    color="secondary" onClick={() => this.props.onClick()} title="Seguir comprando">
            <AddShoppingCartIcon sx={{mr: 1}}/>
        </Fab>;
    }
}