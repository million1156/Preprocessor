import noblox from 'noblox.js';
import fs from "fs"
import dotenv from "dotenv"
dotenv.config()

await noblox.setCookie(process.env.KEY);

const assetIDs = new Map();

const files = fs.readdirSync("./out/MODELS/");
files.forEach(async (fileRawName) => {
    const fileName = (fileRawName.slice(0, -5));
    const response = await noblox.uploadModel(fs.readFileSync("./out/MODELS/" + fileRawName), {
        name: "Properations", // Change this every once in awhile to avoid getting banned
        description: "",
        copyLocked: false,
        allowComments: false
    });

    const assetID = response.AssetId;

    console.log(assetID.toString());
    assetIDs.set(fileName, assetID)

    fs.writeFileSync("./build/models.temp.txt", JSON.stringify(Array.from(assetIDs.entries())));
});