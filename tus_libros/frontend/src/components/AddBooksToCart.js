import React, {Component} from 'react';
import Button from "@mui/material/Button";
import AddShoppingCartIcon from "@mui/icons-material/Add";
import {IconButton} from "@mui/material";
import ShoppingCartIcon from "@mui/icons-material/ShoppingCart";
import RemoveIcon from "@mui/icons-material/Remove";
import {styled} from "@mui/material/styles";
import Badge from "@mui/material/Badge";
import Box from "@mui/material/Box";
import PropTypes from "prop-types";
import Pluralizer from "../lib/Pluralizer";

export default class AddBooksToCart extends Component {

    static propTypes = {
        book: PropTypes.object.isRequired,
        onAddToCartDo: PropTypes.func.isRequired,
    };

    constructor(props) {
        super(props);
        this.state = {
            numberOfCopiesToOrder: 0
        }
    }


    render() {
        return <Box sx={{
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
            width: '100%',
            p: 1,
            m: 1,
        }}>
            {this.renderAddCopy()}
            {this.renderAddCopiesToCart()}
            {this.renderRemoveCopy()}
        </Box>
    }

    renderAddCopiesToCart() {
        return <IconButton
            aria-label="cart" color="primary"
            title={`Agregar ${this.pluralize(this.state.numberOfCopiesToOrder, "copia")} al carrito`}
            onClick={ ()=> this._addCopiesToCart()}>
            <StyledBadge badgeContent={this.state.numberOfCopiesToOrder} color="secondary">
                <ShoppingCartIcon/>
            </StyledBadge>
        </IconButton>;
    }

    renderAddCopy() {
        return <Button
            style={{border: 0}}
            onClick={() => { this._increaseNumberOfCopiesToOrder()}}
            title="Sumar una copia"
        >
            <AddShoppingCartIcon fontSize="small"/>
        </Button>;
    }

    renderRemoveCopy() {
        return <Button
            style={{border: 0}}
            onClick={() => this._decreaseNumberOfCopiesToOrder()}
            title="Quitar una copia"
        >
            <RemoveIcon fontSize="small"/>
        </Button>;
    }

    _increaseNumberOfCopiesToOrder() {
        this.setState({numberOfCopiesToOrder: this.state.numberOfCopiesToOrder + 1})
    }
    _decreaseNumberOfCopiesToOrder() {
        this.setState({numberOfCopiesToOrder: (this.state.numberOfCopiesToOrder - 1).max(0)})
    }

    _addCopiesToCart() {
        this.props.onAddToCartDo(this.props.book, this.state.numberOfCopiesToOrder);
        this.setState({numberOfCopiesToOrder: 0})
    }

    pluralize(count, noun) {
        const pluralizer = Pluralizer.for(count, noun);
        return pluralizer.value()
    }

}


const StyledBadge = styled(Badge)(({ theme }) => ({
    '& .MuiBadge-badge': {
        right: -3,
        top: 13,
        border: `2px solid ${theme.palette.background.paper}`,
        padding: '0 4px',
    },
}));
