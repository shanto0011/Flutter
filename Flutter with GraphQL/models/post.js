const {
    Schema,
    model
} = require('mongoose');


const postSchema = Schema({
    comment: String,
    userId: String,
});

module.exports = model("Post", postSchema);