import mongoose, { Model, Schema } from "mongoose";
import { ObjectId, ObjectID } from 'bson';
import bcrypt from 'bcryptjs';


const UserSchema = new Schema<UserDocument>({
  _id: {
    type: Schema.Types.ObjectId,
    get: function (v) {
      return v ? v.toString() : undefined
    },
    default: function () { return new ObjectId() }
  },
  name: {
    firstName: {
      type: String,
      default: "",
    },
    lastName: {
      type: String,
      default: "",
    },
  },
  email: {
    type: String,
    required: true,
  },
  password: {
    type: String,
    required: true,
  },
  role: {
    type: String,
    enum: ['admin', 'user']
  },
  isVerified: {
    type: Boolean,
    default: false
  }
},
{
  versionKey: false,
});


UserSchema.methods.toJSON = function () {
  let userObject = this.toObject();
  delete userObject.tokens;
  delete userObject.password;
  return userObject;
};

UserSchema.pre("save", async function (next)  {
  if(this.isModified('password')) {
    const salt = await bcrypt.genSalt()
    this.password = bcrypt.hashSync(this.password, salt);
  }
  next();
})


UserSchema.static("checkPassword", function (password, userPassword) {
  return bcrypt.compareSync(password, userPassword);
});

export interface IUser {
  /** First and last name */
  name?: PersonalName;
  /** User email */
  email?: string;
  /** User password */
  password?: string;
  /** User role */
  role?: UserRolesTypes;
  isVerified?: boolean;
}

export enum UserRolesTypes {
  admin = 'admin',
  user = 'user' 
}

export interface PersonalName {
  firstName?: string;
  lastName?: string;
}

export interface UserDocument extends Document, IUser {
  _id?: ObjectId;
}

export interface IUserModel extends Model<UserDocument> {
  checkPassword(password: string, originalPassword: string): boolean
}

export interface UserWithId extends IUser {
  /** Document _id */
  _id?: ObjectId;
}

const UserModel = mongoose.model<UserWithId, IUserModel>("User", UserSchema);

export default UserModel;
