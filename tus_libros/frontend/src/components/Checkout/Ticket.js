import React from "react";
import Card from "@mui/material/Card";
import {Avatar, CardHeader} from "@mui/material";
import CreditScoreIcon from "@mui/icons-material/CreditScore";
import Typography from "@mui/material/Typography";
import CardContent from "@mui/material/CardContent";
import Stack from "@mui/material/Stack";
import LocalShippingIcon from "@mui/icons-material/LocalShipping";
import ReceiptIcon from "@mui/icons-material/Receipt";
import PropTypes from "prop-types";

export class Ticket extends React.Component {

    static propTypes = {
        transactionId: PropTypes.string,
    };

    render() {
        return <Card sx={{maxWidth: 545, margin: 5, p: 3}}>
            {this.renderHeader()}
            {this.renderContent()}
        </Card>;
    }

    renderHeader() {
        return <CardHeader
            avatar={
                <Avatar sx={{backgroundColor: "secondary.main"}} aria-label="recipe">
                    <CreditScoreIcon/>
                </Avatar>
            }
            title={<Typography variant="h6">Hemos registrado tu compra exitosamente</Typography>}
            subheader={new Date().toLocaleDateString()}
        />;
    }

    renderContent() {
        return <CardContent>
            <Stack direction="column" alignItems="center" gap={1}>
                <LocalShippingIcon sx={{mr: 2}} fontSize="large"/>
                <Typography variant="body1" align="center">
                    Estarás recibiendo tu pedido en los próximos dias.
                </Typography>
                <ReceiptIcon sx={{mr: 2}} fontSize="large"/>
                <Typography variant="body1" align="center">
                    Tu número de transacción es {this.props.transactionId}
                </Typography>
            </Stack>
        </CardContent>;
    }
}