import dotenv from "dotenv";
dotenv.config();

import axios from "axios";
import fs from "fs";

const universeID = 788795360;
const placeID = 2274608588;
const placeFile = "out/GameRunner.rbxl";
const apiKey = process.env.API_KEY_GAME;

try {
  if (!fs.existsSync(placeFile)) {
    throw new Error(`Place file does not exist: ${placeFile}`);
  }
  const extension = placeFile.split(".").pop();
  if (extension !== "rbxl" && extension !== "rbxlx") {
    throw new Error(`Unrecognized place file extension: ${extension}`);
  }

  const fileContents = fs.readFileSync(placeFile);
  const isBinary = extension === "rbxl";

  console.log(`Universe ID: ${universeID}, Place ID: ${placeID}`);
  console.log(`API key: ${apiKey}`);
  console.log(`Uploading place file ${placeFile}`);
  console.log(`Place file size: ${fileContents.length} bytes`);
  axios
    .post(
      `https://apis.roblox.com/universes/v1/${universeID}/places/${placeID}/versions?versionType=Published`,
      fileContents,
      {
        headers: {
          "x-api-key": apiKey,
          "Content-Type": isBinary
            ? "application/octet-stream"
            : "application/xml",
        },
        // proxy: createProxy(),
      }
    )
    .then((response) => {
      const data = response.data;
      const versionNumber = data.versionNumber;
      console.log(`Saved place file as version ${versionNumber}`);
    });
} catch (e) {
  console.error(e);
}
