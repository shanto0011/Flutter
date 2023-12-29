const graphql = require("graphql");
var _ = require("lodash");
const User = require('../model/user');
const Hobby = require('../model/hobby');
const Post = require('../model/post');
const {
    GraphQLObjectType,
    GraphQLID,
    GraphQLString,
    GraphQLInt,
    GraphQLSchema,
    GraphQLList,
    GraphQLNonNull,
} = graphql;
//Create types
const UserType = new GraphQLObjectType({
    name: "User",
    description: "Documentation for user...",
    fields: () => ({
        id: { type: GraphQLID },
        name: { type: GraphQLString },
        age: { type: GraphQLInt },
        profession: { type: GraphQLString },

        posts: {
            type: new GraphQLList(PostType),
            resolve(parent, args) {
                return Post.find({ userId: parent.id });
            },
        },

        hobbies: {
            type: new GraphQLList(HobbyType),
            resolve(parent, args) {
                return Hobby.find({ userId: parent.id });
            },
        },
    }),
});

const HobbyType = new GraphQLObjectType({
    name: "Hobby",
    description: "Hobby description",
    fields: () => ({
        id: { type: GraphQLID },
        title: { type: GraphQLString },
        description: { type: GraphQLString },
        userId: { type: GraphQLNonNull(GraphQLString) },
        user: {
            type: UserType,
            resolve(parent, args) {
                return User.findById(parent.userId);
            },
        },
    }),
});

//Post type (id, comment)
const PostType = new GraphQLObjectType({
    name: "Post",
    description: "Post description",
    fields: () => ({
        id: { type: GraphQLID },
        comment: { type: GraphQLString },
        userId: { type: GraphQLString },
        user: {
            type: UserType,
            resolve(parent, args) {
                return User.findById(parent.userId);
            },
        },
    }),
});

//RootQuery
const RootQuery = new GraphQLObjectType({
    name: "RootQueryType",
    description: "Description",
    fields: {
        user: {
            type: UserType,
            args: { id: { type: GraphQLString } },

            resolve(parent, args) {
                return User.findById(args.id);
            },
        },

        users: {
            type: new GraphQLList(UserType),
            resolve(parent, args) {
                return User.find({});
            },
        },

        hobby: {
            type: HobbyType,
            args: { id: { type: GraphQLID } },

            resolve(parent, argsf) {
                //return data for our hobby

                return Hobby.findById(args.id);
            },
        },

        hobbies: {
            type: new GraphQLList(HobbyType),

            resolve(parent, args) {
                return Hobby.find({ id: args.userId });
            },
        },

        post: {
            type: PostType,
            args: { id: { type: GraphQLID } },

            resolve(parent, args) {
                return Post.findById(args.id);
            },
        },

        posts: {
            type: new GraphQLList(PostType),
            resolve(parent, args) {
                return Post.find({});
            },
        },
    },
});

//=== Mutations ===//
const Mutation = new GraphQLObjectType({
    name: "Mutation",
    fields: {
        CreateUser: {
            type: UserType,
            args: {
                name: { type: GraphQLNonNull(GraphQLString) },
                age: { type: GraphQLNonNull(GraphQLInt) },
                profession: { type: GraphQLString },
            },

            async resolve(parent, args) {
                try {
                    const user = new User({
                        name: args.name,
                        age: args.age,
                        profession: args.profession,
                    });
                    return await user.save();
                } catch (error) {
                    console.error(error);
                    throw new Error("Failed to create user.");
                }
            },
        },
        //Update User
        UpdateUser: {
            type: UserType,
            args: {
                id: { type: GraphQLNonNull(GraphQLString) },
                name: { type: GraphQLNonNull(GraphQLString) },
                age: { type: GraphQLNonNull(GraphQLInt) },
                profession: { type: GraphQLString },
            },
            async resolve(parent, args) {
                try {
                    return await User.findByIdAndUpdate(
                        args.id, {
                            $set: {
                                name: args.name,
                                age: args.age,
                                profession: args.profession,
                            },
                        }, { new: true }
                    );
                } catch (error) {
                    console.error(error);
                    throw new Error("Failed to update user.");
                }
            },
        },
        //RemoveUser
        RemoveUser: {
            type: UserType,
            args: {
                id: { type: GraphQLNonNull(GraphQLString) },
            },
            async resolve(parent, args) {
                try {
                    return await User.findByIdAndRemove(args.id).exec();
                } catch (error) {
                    console.error(error);
                    throw new Error("Failed to remove user.");
                }
            },
        },

        CreatePost: {
            type: PostType,
            args: {
                comment: { type: GraphQLNonNull(GraphQLString) },
                userId: { type: GraphQLNonNull(GraphQLString) },
            },

            async resolve(parent, args) {
                try {
                    const post = new Post({
                        comment: args.comment,
                        userId: args.userId,
                    });
                    return await post.save();
                } catch (error) {
                    console.error(error);
                    throw new Error("Failed to create post.");
                }
            },
        },

        //Update Post
        UpdatePost: {
            type: PostType,
            args: {
                id: { type: GraphQLNonNull(GraphQLString) },
                comment: { type: GraphQLNonNull(GraphQLString) },
            },
            async resolve(parent, args) {
                try {
                    return await Post.findByIdAndUpdate(
                        args.id, {
                            $set: {
                                comment: args.comment,
                            },
                        }, { new: true }
                    );
                } catch (error) {
                    console.error(error);
                    throw new Error("Failed to update post.");
                }
            },
        },
        //Remove Post
        RemovePost: {
            type: PostType,
            args: {
                id: { type: GraphQLNonNull(GraphQLString) },
            },
            async resolve(parent, args) {
                try {
                    return await Post.findByIdAndRemove(args.id).exec();
                } catch (error) {
                    console.error(error);
                    throw new Error("Failed to remove post.");
                }
            },
        },

        //RemovePosts
        RemovePosts: {
            type: PostType,
            args: {
                ids: { type: GraphQLList(GraphQLString) },
            },
            async resolve(parent, args) {
                try {
                    return await Post.deleteMany({
                        _id: args.ids,
                    });
                } catch (error) {
                    console.error(error);
                    throw new Error("Failed to remove posts.");
                }
            },
        },

        //CreateHobby mutation
        CreateHobby: {
            type: HobbyType,
            args: {
                title: { type: GraphQLNonNull(GraphQLString) },
                description: { type: GraphQLNonNull(GraphQLString) },
                userId: { type: GraphQLNonNull(GraphQLString) },
            },
            async resolve(parent, args) {
                try {
                    const hobby = new Hobby({
                        title: args.title,
                        description: args.description,
                        userId: args.userId,
                    });
                    return await hobby.save();
                } catch (error) {
                    console.error(error);
                    throw new Error("Failed to create hobby.");
                }
            },
        },

        //Update Hobby
        UpdateHobby: {
            type: HobbyType,
            args: {
                id: { type: GraphQLNonNull(GraphQLString) },
                title: { type: GraphQLNonNull(GraphQLString) },
                description: { type: GraphQLNonNull(GraphQLString) },
            },
            async resolve(parent, args) {
                try {
                    return await Hobby.findByIdAndUpdate(
                        args.id, {
                            $set: {
                                title: args.title,
                                description: args.description,
                            },
                        }, { new: true }
                    );
                } catch (error) {
                    console.error(error);
                    throw new Error("Failed to update hobby.");
                }
            },
        },
        //Remove Hobby
        RemoveHobby: {
            type: HobbyType,
            args: {
                id: { type: GraphQLNonNull(GraphQLString) },
            },
            async resolve(parent, args) {
                try {
                    return await Hobby.findByIdAndRemove(args.id).exec();
                } catch (error) {
                    console.error(error);
                    throw new Error("Failed to remove hobby.");
                }
            },
        },

        //RemoveHobbies
        RemoveHobbies: {
            type: HobbyType,
            args: {
                ids: { type: GraphQLList(GraphQLString) },
            },
            async resolve(parent, args) {
                try {
                    return await Hobby.deleteMany({
                        _id: args.ids,
                    });
                } catch (error) {
                    console.error(error);
                    throw new Error("Failed to remove hobbies.");
                }
            },
        },
    }, //End of the fields
});

module.exports = new GraphQLSchema({
    query: RootQuery,
    mutation: Mutation,
});
