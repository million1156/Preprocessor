import noblox from "noblox.js";
import fs from "fs";
import dotenv from "dotenv";
dotenv.config();

await noblox.setCookie(process.env.KEY);

const response = await noblox.uploadModel(
  fs.readFileSync("./out/Driver.rbxm"),
  {
    name: "MainModule",
    description: "",
    copyLocked: false,
    allowComments: false,
  },
  12727689035
);
console.log(response.AssetId);
