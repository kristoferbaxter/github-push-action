import resolve from "@rollup/plugin-node-resolve";
import commonjs from "@rollup/plugin-commonjs";

const external = ["path", "process", "os", "events", "child_process", "util", "assert", "fs"];
const plugins = [
  resolve({ preferBuiltins: true }),
  commonjs({ include: "node_modules/**" }),
];

export default {
  input: "index.js",
  output: {
    file: "dist/index.js",
    format: "cjs",
  },
  external,
  plugins,
};
