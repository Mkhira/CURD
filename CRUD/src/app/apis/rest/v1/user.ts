import { Router } from "express";
import usersService from "../../../services/users.service";

const router = Router();

router.post("/signUp", async (req, res) => {
  try {
    const result = await usersService.userSignUp(req.body);

    res.send(result);
  } catch (error) {
    res.send(error);
  }
});

router.post("/signIn", async (req, res) => {
  try {
    const result = await usersService.userSignIn(req.body);

    res.send(result);
  } catch (error) {
    res.send(error);
  }
});

router.get("/:token", async (req, res) => {
  try {
    const result = await usersService.verifyUser(req.params.token);

    res.send(result);
  } catch (error) {
    res.send(error);
  }
});

router.put("/update", async (req, res) => {
  try {
    const result = await usersService.updateUser(req.body);

    res.send(result);
  } catch (error) {
    res.send(error);
  }
})

router.put("/delete", async (req, res) => {
  try {
    const result = await usersService.deleteUser(req.body);

    res.send(result);
  } catch (error) {
    res.send(error);
  }
})

export const UserRouter = router;
