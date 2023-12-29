const {
    Schema,
    model
} = require('mongoose');

const userSchema = Schema({
    name: String,
    age: Number,
    profession: String,
});
module.exports = model("User", userSchema);
