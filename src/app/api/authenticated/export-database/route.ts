import { NextRequest } from "next/server";
import mysqldump from "mysqldump";
import path from "path";
import fs from "fs";

export async function GET(req: NextRequest) {
  try {
    const folderPath = path.join(process.cwd(), "backup");
    if (!fs.existsSync(folderPath)) {
      fs.mkdirSync(folderPath);
    }

    const filePath = path.join(folderPath, `backup-${Date.now()}.sql`);
    await mysqldump({
      connection: {
        host: "localhost",
        user: "root",
        password: "",
        database: "sambel_ceurik_ngagoak",
      },
      dumpToFile: filePath,
    });

    return Response.json({
      message: "Database berhasil di-export!",
      filePath,
    });
  } catch (err: any) {
    return Response.json(
      { message: "Gagal export database!", error: err.message },
      { status: 500 }
    );
  }
}
