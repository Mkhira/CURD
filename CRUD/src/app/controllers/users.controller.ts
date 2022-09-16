import { StatusError } from './utils/utils';
import jwt from "jsonwebtoken";
import UserModel, { IUser, UserDocument, UserWithId } from "./../models/user/user.model";
import crud from "./utils/crud";
import Crud from "./utils/crud";

export interface CreateUserRequest extends IUser {}
export interface UserSignInRequest extends Pick<IUser, "email" | "password"> {}

export class UsersController {
  async userRegister(data: CreateUserRequest) {
    try {
      const userData: CreateUserRequest = {
        name: data.name,
        email: data.email,
        password: data.password,
        role: data.role
      };

      const user: UserWithId = await Crud.insert(UserModel, userData);

      const verificationToken = jwt.sign({
        email: user.email
      }, process.env.JWT_SECRET_KEY)




      return {
        data: user,
      };
    } catch (error) {
      throw error;
    }
  }

  async signIn(data: UserSignInRequest) {
    try {
      const user = await crud.findOneByFilter(UserModel, { email: data.email });

      if (!user) {
        throw new Error("User not found");
      }

      if(!user.isVerified) {
        throw new StatusError(
          "Email not verified",
          401,
          "email"
        )
      }

      if (UserModel.checkPassword(data.password, user.password)) {
        let token = jwt.sign(
          { _id: user._id, email: user.email },
          process.env.JWT_SECRET_KEY
        );

        return {
          data: {
            token: token,
            user: user,
          },
        };
      } else {
        throw new Error("Wrong password");
      }
    } catch (error) {
      throw error;
    }
  }

  async getOneById(id: UserDocument["_id"]) {
    try {
      const user = await crud.getById(UserModel, id);

      return {
        data: user,
      };
    } catch (error) {
      throw error;
    }
  }

  async getOneByFilter(filter) {
    try {
      const user = await crud.findOneByFilter(UserModel, filter);

      return {
        data: user,
      };
    } catch (error) {
      throw error;
    }
  }

  async updateOneByFilter(filter, data) {
    try {
      const user = await crud.findOneAndUpdate(UserModel, filter, data)

      return {
        data: user
      }
    } catch (error) {
      throw error
    }
  }

  async deleteOneByFilter(filter, data) {
    try {
      const user = await crud.findOneAndDelete(UserModel, filter)

      return {
        data: "Deleted Successfully"
      }
    } catch (error) {
      throw error
    }
  }

  
}

export default new UsersController();
