import React, {Component} from "react";
import PropTypes from "prop-types";
import Typography from "@mui/material/Typography";
import Grid from "@mui/material/Grid";
import Card from "@mui/material/Card";
import CardMedia from "@mui/material/CardMedia";
import CardContent from "@mui/material/CardContent";
import CardActions from "@mui/material/CardActions";
import {Rating} from "@mui/material";
import AddBooksToCart from "./AddBooksToCart";
import Stack from "@mui/material/Stack";
import {Price} from "./Base/Price";


export default class BookRack extends Component {

    static propTypes = {
        app: PropTypes.object.isRequired,
        onAddToCartDo: PropTypes.func.isRequired,
    };

    constructor(props) {
        super(props);
        this._books = this.props.app.books()
    }

    render() {
        return <Grid container spacing={4}>
            {this._books.map((aBook) => (
                <Grid item key={aBook.isbn} xs={12} sm={6} md={4}>
                    {this.renderBook(aBook)}
                </Grid>
            ))}
        </Grid>
    }

    renderBook(aBook) {
        return <Card sx={{height: '100%', display: 'flex', flexDirection: 'column'}}>
            {this.renderBookCoverOf(aBook)}
            {this.renderBookDetailOf(aBook)}
            {this.renderBookActionsOn(aBook)}
        </Card>;
    }

    renderBookCoverOf(aBook) {
        return <CardMedia
            component="div"
            sx={{pt: '56.25%'}}
            image={aBook.cover}
        />;
    }

    renderBookDetailOf(aBook) {
        return <CardContent>
            <Stack direction="column" sx={{minHeight: "13em"}} spacing={2}>
                <Typography variant="h5">
                    {aBook.title}
                </Typography>
                <Typography>
                    {aBook.description.slice(0, 100) + "..."}
                </Typography>
            </Stack>
            <Stack direction="row" justifyContent="space-around">
                <Rating value={aBook.score} precision={0.5} readOnly/>
                {this.renderPriceOf(aBook)}
            </Stack>
        </CardContent>;
    }

    renderBookActionsOn(aBook) {
        return <CardActions>
            {this.renderAddToCartBar(aBook)}
        </CardActions>;
    }

    renderPriceOf(aBook) {
        return <Price value={aBook.price} />;
    }

    renderAddToCartBar(aBook) {
        return <AddBooksToCart book={aBook} onAddToCartDo={this.props.onAddToCartDo}/>
    }
}


