import exec from "@actions/exec";
import * as path from "path";
import {exit} from "process";

(async function() {
  try {
    await exec(path.join(__dirname, "./start.sh"));
  } catch(err) {
    console.error(err);
    console.error(err.stack);
    exit(err.code || -1);
  }
})();