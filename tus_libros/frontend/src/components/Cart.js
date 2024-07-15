import React, {Component} from "react";
import Typography from "@mui/material/Typography";
import {Avatar, Divider, List, ListItem, ListItemAvatar, ListItemText} from "@mui/material";
import Box from "@mui/material/Box";
import Container from "@mui/material/Container";
import PropTypes from "prop-types";
import PaymentIcon from '@mui/icons-material/Payment';
import AutoStoriesIcon from "@mui/icons-material/AutoStories";
import Stack from "@mui/material/Stack";
import Button from "@mui/material/Button";


export default class Cart extends Component {

    static propTypes = {
        cart: PropTypes.object.isRequired,
        onCheckoutDo: PropTypes.func.isRequired,
    };


    render() {
        return <Box
            sx={{
                bgcolor: 'background.paper',
                pt: 8,
                pb: 6,
            }}
        >
            <Container maxWidth="sm">
                {this.renterTitle()}
                {this.renderItems()}
                {this.renderCheckout()}
            </Container>
        </Box>
    }

    renterTitle() {
        return <Stack direction="column" alignItems="center" gap={1}>
            <AutoStoriesIcon sx={{mr: 2}} fontSize="large"/>
            <Typography variant="h5" color="text.secondary" sx={{ flexGrow: 1 }}>
                {this.title()}
            </Typography>
        </Stack>
    }

    renderItems() {
        return <List sx={{width: '100%', maxWidth: 360, bgcolor: 'background.paper'}}>
            {this._cart().items.map((cartItem) => this.renderItem(cartItem))}
        </List>;
    }

    renderCheckout() {
        return <Typography
            variant="h5"
            align="center"
            color="text.secondary"
            gutterBottom
        >
            <Button variant="contained" startIcon={<PaymentIcon />} onClick={()=> this.props.onCheckoutDo()}>
                Iniciar Pago
            </Button>
        </Typography>;
    }

    renderItem(cartItem) {
        return <>
            <ListItem alignItems="flex-start">
                <ListItemAvatar>
                    <Avatar src={cartItem.article.cover}/>
                </ListItemAvatar>
                <ListItemText
                    primary={cartItem.article.title}
                    secondary={
                        <>
                            <Typography
                                sx={{display: 'inline'}}
                                component="span"
                                variant="body2"
                                color="text.secondary"
                            >
                                {cartItem.quantity}
                            </Typography>
                        </>
                    }
                />
            </ListItem>
            <Divider variant="inset" component="li"/>
        </>;
    }

    title() {
        if (this._hasItems()) {
            return "¡Ya casi son tuyos!";
        }
        else {
            return "¡Comienza a armar tu pedido!";
        }
    }

    _cart() {
        return this.props.cart;
    }

    _hasItems() {
        return this._cart().items.length > 0
    }
}