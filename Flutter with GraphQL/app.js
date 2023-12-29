const express = require("express");
const dotenv = require('dotenv');
dotenv.config();
var { graphqlHTTP } = require("express-graphql");


const schema = require("./schema/schema");
const mongoose = require("mongoose");

const app = express();
const port = process.env.PORT || 4000;
const cors = require("cors");

app.use(cors());
app.use(
    "/graphql",
    graphqlHTTP({
        graphiql: true,
        schema,
    })
);



mongoose.connect(process.env.MONGODB_SERVER, {
        useNewUrlParser: true,
        useUnifiedTopology: true,
        dbName: 'flutter-with-graphql'
    })
    .then(() => {
        console.log('Database Connection is ready...');
        app.listen(port, () => {
            console.log(process.env.MONGODB_SERVER);
            console.log(`server is running http://localhost:${port}`);
        })
    })
    .catch((err) => {
        console.log(err);
    })



/***
 * .env containe those information
PORT=4000
MONGODB_SERVER="mongodb://127.0.0.1:27017/shanto"
 */