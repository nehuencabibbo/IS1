import React, {Component} from "react";
import PropTypes from "prop-types";
import Card from "@mui/material/Card";
import Stack from "@mui/material/Stack";
import Container from "@mui/material/Container";
import {Avatar} from "@mui/material";

export class PurchasesSummeryCard extends Component {

    static propTypes = {
        value: PropTypes.element.isRequired,
        icon: PropTypes.element.isRequired
    }

    render() {
        let {value, icon} = this.props;
        return <Card sx={{backgroundColor: "primary.main", opacity: 0.8, p: 5, borderRadius: 5}}>
            <Stack direction={"row"} spacing={1} alignItems={"center"}>
                <Container sx={{color: "common.white"}}>{value}</Container>
                <Avatar sx={{backgroundColor: "transparent"}}>
                    {icon}
                </Avatar>
            </Stack>
        </Card>
    }
}