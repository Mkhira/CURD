import swaggerUi from "swagger-ui-express";
import swaggerJSDoc from "swagger-jsdoc";
import swaggerJsdoc from "swagger-jsdoc";
import { Express } from "express";

const swaggerOptions: swaggerJSDoc.Options = {
  swaggerDefinition: {
    info: {
      title: "CRUD API",
      description: "Apis for CRUD Apllication",
      version: "1.0.0",
    }
  },
  apis: ["./src/app/services/*.ts", "./src/app/apis/*.ts", "./src/app/apis/rest/v1/*.ts", "./src/app/apis/rest/v1/swagger/*.yml"],
};

const swaggerSpec = swaggerJsdoc(swaggerOptions);

function swaggerDocs(app: Express, port: number) {
  app.use("/v1/api-docs", swaggerUi.serve, swaggerUi.setup(swaggerSpec));
}

export default swaggerDocs