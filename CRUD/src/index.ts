import * as boot from "./boot";
import yargs from "yargs";
import { hideBin } from "yargs/helpers";
import * as apis from "./app/apis";

const dBSeedArgs = yargs(hideBin(process.argv))
  .command("--init", "initiate database seed", {
    initSeed: {
      description: "initiate database",
      type: "boolean",
    },
  })
  .example('$0 --init "true"', "initiate database")
  .help()
  .alias("help", "h").argv;

export const initSeed = Boolean((dBSeedArgs as any).initSeed);

export async function start() {
  try {
    apis.start();
    await boot.start();

    if (initSeed && process.env.NODE_ENV !== "production") {
      const DatabaseSeed = await import("./app/seed/db-seed");
      DatabaseSeed.startSeed();
    }

    // if (process.env.NODE_ENV === "development") {
    //   await import("./app/playground");
    // }
  } catch (error) {
    console.log("APP ERROR");
    console.trace(error);
  }
}

start();
