import React, {Component} from "react";
import Typography from "@mui/material/Typography";
import Container from "@mui/material/Container";
import Stack from "@mui/material/Stack";
import Button from "@mui/material/Button";
import Box from "@mui/material/Box";
import ShoppingCartIcon from '@mui/icons-material/ShoppingCart';
import PropTypes from "prop-types";


export default class CallToTakeACart extends Component {

    static propTypes = {
        onTakeACartDo: PropTypes.func.isRequired,
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
                {this.renderSubtitles()}
                {this.renderInitializeOrderButton()}
            </Container>
        </Box>
    }

    renterTitle() {
        return <Typography
            component="h1"
            variant="h2"
            align="center"
            color="text.primary"
            gutterBottom
        >
            La editorial de la FIUBA
        </Typography>;
    }

    renderSubtitles() {
        return <>
            <Typography variant="h5" align="center" color="text.secondary" paragraph>
                ¡Hace tu pedido ahora!
            </Typography>
            <Typography variant="h6" align="center" color="text.secondary" paragraph>
                Contamos con los mejores libros técnicos
            </Typography>
        </>;
    }

    renderInitializeOrderButton() {
        return <Stack
            sx={{pt: 4}}
            direction="row"
            spacing={2}
            justifyContent="center"
        >
            <Button variant="contained" startIcon={<ShoppingCartIcon/>} onClick={()=> this.props.onTakeACartDo()}>
                Iniciar Pedido
            </Button>
        </Stack>;
    }
}