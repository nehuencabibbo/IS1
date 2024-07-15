import React, {Component} from "react";
import TableContainer from "@mui/material/TableContainer";
import Paper from "@mui/material/Paper";
import Table from "@mui/material/Table";
import TableHead from "@mui/material/TableHead";
import TableBody from "@mui/material/TableBody";
import Stack from "@mui/material/Stack";
import {Avatar} from "@mui/material";
import Typography from "@mui/material/Typography";
import PropTypes from "prop-types";
import {styled} from "@mui/material/styles";
import TableCell, {tableCellClasses} from "@mui/material/TableCell";
import TableRow from "@mui/material/TableRow";


export default class PurchasesTable extends Component {

    static propTypes = {
        items: PropTypes.array.isRequired,
    };

    render() {
        return <TableContainer component={Paper} sx={{minWidth: 650, width: "fit-content"}}>
            <Table>
                {this.renderHeader()}
                {this.renderBody()}
            </Table>
        </TableContainer>;
    }

    renderHeader() {
        return <TableHead>
            <StyledTableRow>
                <StyledTableCell align="left">Título</StyledTableCell>
                <StyledTableCell align="center">Cantidad</StyledTableCell>
            </StyledTableRow>
        </TableHead>;
    }

    renderBody() {
        return <TableBody>
            {this.props.items.map((aPurchase) => this.renderPurchase(aPurchase))}
        </TableBody>;
    }

    renderPurchase(aPurchase) {
        return <StyledTableRow
            key={aPurchase.article.isbn}
            sx={{'&:last-child td, &:last-child th': {border: 0}}}
        >
            <StyledTableCell align="left">
                <Stack direction={"row"} spacing={1} alignItems={"center"}>
                    <Avatar src={aPurchase.article.cover}/>
                    <Typography>{aPurchase.article.title}</Typography>
                </Stack>
            </StyledTableCell>
            <StyledTableCell align="center">{aPurchase.quantity}</StyledTableCell>
        </StyledTableRow>;
    }
}

const StyledTableCell = styled(TableCell)(({theme}) => ({
    [`&.${tableCellClasses.head}`]: {
        backgroundColor: theme.palette.common.black,
        color: theme.palette.common.white,
        fontSize: 18,
        fontWeight: "bold"
    },
    [`&.${tableCellClasses.body}`]: {
        fontSize: 14,
    },
}));

const StyledTableRow = styled(TableRow)(({theme}) => ({
    '&:nth-of-type(odd)': {
        backgroundColor: theme.palette.action.hover,
    },
    // hide last border
    '&:last-child td, &:last-child th': {
        border: 0,
    },
}));