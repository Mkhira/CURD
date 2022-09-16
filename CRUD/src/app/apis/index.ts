import swaggerUi from "swagger-ui-express";
import express from "express";
import * as servers from "../../boot/servers";
import cors from "cors";
import restful from "./rest";
import swaggerJSDoc from "swagger-jsdoc";



export async function start() {
  servers.main.app.use(cors());

  servers.main.app.use(express.json());

  servers.main.app.get("/", (req, res) => {
    res.send("Hello World !");
  });

  servers.main.app.use("/v1", restful.v1);
}
