import { StatusError } from "./../controllers/utils/utils";
import jwt from "jsonwebtoken";
import {
  CreateUserRequest,
  UserSignInRequest,
} from "./../controllers/users.controller";
import usersController from "../controllers/users.controller";
import usersValidator from "../controllers/utils/vaildation/users-validator";
import { serviceErrorHandler } from "./utils";
import jwtDecode from "jwt-decode";
import UserModel from "../models/user/user.model";

export interface SCreateUserRequest extends CreateUserRequest {
  confirmPassword: string;
}

export interface SUserSignInRequest extends UserSignInRequest {}

class UserService {
  async userSignUp(data: SCreateUserRequest) {
    try {
      await usersValidator.create(data);

      const foundUser = (
        await usersController.getOneByFilter({ email: data.email })
      ).data;

      if (foundUser) {
        throw new serviceErrorHandler(
          { message: "Email already exists", name: "userFound" },
          {
            code: 409,
            path: "email",
          }
        );
      }

      delete data.confirmPassword;

      const userResponse = await usersController.userRegister(data);

      return userResponse;
    } catch (error) {
      serviceErrorHandler(error, {
        code: error?.code,
        path: error?.path,
      });
    }
  }

  async userSignIn(data: SUserSignInRequest) {
    try {
      await usersValidator.signin(data);

      const userResponse = await usersController.signIn(data);

      return userResponse;
    } catch (error) {
      serviceErrorHandler(error, {
        code: error?.code,
        path: error?.path,
      });
    }
  }

  async verifyUser(data: string) {
    try {
      try {
        jwt.verify(data, process.env.JWT_SECRET_KEY)
      } catch (err) {
        throw new StatusError("Token not valid", 401);
      }

      const decodedToken = jwtDecode(data);

      const userResponse = await usersController.updateOneByFilter(
        { email: (decodedToken as any).email },
        { isVerified: true }
      );

      return {
        data: userResponse,
      };
    } catch (error) {
      throw error;
    }
  }

  async updateUser(user) {
    try {
      const userResponse = await usersController.updateOneByFilter(
        { email: user.email },
        user
      );

      return {
        data: userResponse,
      };      
    } catch (error) {
      throw error
    }
  
  }
  async deleteUser(user) {
    try {
      const userResponse = await usersController.deleteOneByFilter(
        { email: user.email },
        user
      );
    } catch (error) {
      throw error
    }
  }
}

export default new UserService();
