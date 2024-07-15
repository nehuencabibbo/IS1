import React, {Component} from "react";
import Box from "@mui/material/Box";
import Grid from "@mui/material/Grid";
import {Avatar, TextField} from "@mui/material";
import Typography from "@mui/material/Typography";
import Button from "@mui/material/Button";
import PropTypes from "prop-types";


export default class Login extends Component {

    static propTypes = {
        title: PropTypes.string.isRequired,
        titleIcon: PropTypes.element.isRequired,
        buttonLabel: PropTypes.string.isRequired,
        onLoginDo: PropTypes.func.isRequired,
    };

    handleSubmit(event) {
        event.preventDefault();
        const data = new FormData(event.currentTarget);
        const clientId = data.get('clientId');
        const password = data.get('password');

        this.props.onLoginDo(clientId, password)
    };

    render() {
        return <Grid item xs={12} sm={8} md={12}>
            <Box
                sx={{
                    my: 8,
                    mx: 4,
                    display: 'flex',
                    flexDirection: 'column',
                    alignItems: 'center',
                }}
            >
                <Avatar sx={{ m: 1, backgroundColor: 'secondary.main' }}>
                    {this.props.titleIcon}
                </Avatar>
                <Typography component="h1" variant="h5">
                    {this.props.title}
                </Typography>
                <Box component="form" noValidate onSubmit={(event) => this.handleSubmit(event)} sx={{ mt: 1 }}>
                    <TextField
                        margin="normal"
                        required
                        fullWidth
                        id="clientId"
                        label="Id de cliente"
                        name="clientId"
                        autoComplete="clientId"
                        autoFocus
                    />
                    <TextField
                        margin="normal"
                        required
                        fullWidth
                        name="password"
                        label="Password"
                        type="password"
                        id="password"
                        autoComplete="current-password"
                    />
                    <Button
                        type="submit"
                        fullWidth
                        variant="contained"
                        sx={{ mt: 3, mb: 2 }}
                    >
                        {this.props.buttonLabel}
                    </Button>
                </Box>
            </Box>
        </Grid>
    }
}