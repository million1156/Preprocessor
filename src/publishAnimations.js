import noblox from 'noblox.js';
import fs from "fs"
import dotenv from "dotenv"
dotenv.config()

await noblox.setCookie(process.env.KEY);

const assetIDs = new Map();

const files = fs.readdirSync("./build/animations/");
files.forEach(async (fileRawName) => {
    const fileName = (fileRawName.slice(0, -5));
    const assetID = await noblox.uploadAnimation(fs.readFileSync("./build/animations/" + fileRawName), {
        name: fileName,
        description: "",
        copyLocked: false,
        allowComments: false
    });

    console.log(assetID.toString(), assetID);
    assetIDs.set(fileName, assetID.toString())

    fs.writeFileSync("./build/anims.temp.txt", JSON.stringify(Array.from(assetIDs.entries())));
});