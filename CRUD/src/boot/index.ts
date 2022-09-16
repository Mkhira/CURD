import { mongodb } from './databases'
import * as servers from "./servers";
import swaggerDocs from './utils/swagger'

export async function start() {
    await Promise.all([
        mongodb.start(),
        servers.main.start(),
        swaggerDocs(servers.main.app, +process.env.PORT)
      ]);
}