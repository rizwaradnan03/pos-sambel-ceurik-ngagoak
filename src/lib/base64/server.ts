import { writeFile } from "fs/promises";
import { v4 as uuidv4 } from "uuid";
import * as path from "path";

export const UseDecodedBase64ToFile = async ({
  base64String,
  dir,
}: {
  base64String: string;
  dir?: string;
}) => {
  try {
    const matches = base64String.match(
      /data:([a-zA-Z0-9\/\-\+]+);base64,/
    )?.[1] as keyof typeof mimeToExtension;

    if (!matches) {
      throw new Error("Invalid Base64 Format!");
    }

    const mimeToExtension = {
      "image/jpeg": "jpg",
      "image/png": "png",
      "image/gif": "gif",
      "application/pdf": "pdf",
      "text/plain": "txt",
      "application/json": "json",
      "video/mp4": "mp4",
      "video/mpeg": "mpeg",
      "video/quicktime": "mov",
      "video/x-msvideo": "avi",
      "video/x-matroska": "mkv",
      "video/webm": "webm",
      "video/ogg": "ogv",
    };

    const extension = mimeToExtension[matches];
    const fileName = `${uuidv4()}.${extension}`;

    const trimmedString = base64String.replace(/^data:.*?;base64,/, "");
    const fileBuffer = Buffer.from(trimmedString, "base64");

    // Path dalam folder public tanpa process.cwd()
    const saveDir = dir ? path.join("public", dir) : "public";
    const filePath = path.join(saveDir, fileName);

    await writeFile(filePath, fileBuffer);

    const fileUrl = dir ? `/${dir}/${fileName}` : `/${fileName}`;

    return { fileUrl };
  } catch (error: any) {
    throw new Error(error.message);
  }
};
