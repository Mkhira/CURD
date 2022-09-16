import { UserWithId } from './../../models/user/user.model';
import usersController, { UsersController } from "./../users.controller";
import jwt from "jsonwebtoken";
export class StatusError extends Error {
  code: number;
  path: string;
  constructor(message: string, code: number, public inputPath?: string) {
    super(message);
    this.code = code;
    this.path = inputPath;
  }
}

export async function authenticateUser(token: string): Promise<UserWithId> {

  if (token) {
    try {
      token = token.split(" ")[1];

      let decodedToken;

      try {
        decodedToken = jwt.verify(token, process.env.JWT_SECRET_KEY);
      } catch (error) {
        throw new StatusError("Invalid token", 401);
      }

      const userId = decodedToken._id;

      const user = await usersController.getOneById(userId);

      if (!user) {
        throw new StatusError("Authentication failed", 401);
      }

      return user.data;
    } catch (error) {
      throw new StatusError("Not authorized", 401);
    }
  } else {
    throw new StatusError("Not authorized", 401);
  }
}
