import { UserRolesTypes } from './../../../models/user/user.model';
import { StatusError } from "./../utils";
import joi from "joi";
import usersController from "../../users.controller";

class UserValidation {
async create(data) {
    const createSchema = joi.object({
      name: {
        firstName: joi.string().required(),
        lastName: joi.string().required(),
      },
      email: joi
        .string()
        .email()
        .required(),
      password: joi
        .string()
        .min(8)
        .required()
        .pattern(
          new RegExp(
            /^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*_=+-]).{8,12}$/
          )
        ),
      confirmPassword: joi.ref("password"),
      role: joi.string().required().valid(... Object.values(UserRolesTypes))
    });

    const { error, value } = createSchema.validate(data);
    if (error) {
      throw new StatusError(
        error.message,
        400,
        error?.details[0]?.path[0] as any
      );
    } else {
      return true;
    }
  }

  signin(data) {
    const signinSchema = joi.object({
      email: joi.string().email().required(),
      password: joi
        .string()
        .min(8)
        .required()
        .pattern(
          new RegExp(
            /^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*_=+-]).{8,12}$/
          )
        ),
    });

    const { error } = signinSchema.validate(data);
    if (error) {
      throw new StatusError(
        error.message,
        400,
        error?.details[0]?.path[0] as any
      );
    } else {
      return true;
    }
  }
}

export default new UserValidation();
