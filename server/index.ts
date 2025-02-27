import { startCronJob } from "@/lib/cron/employee-salary";
import express from "express";

const app = express();
const PORT = 3020;

app.listen(PORT, () => {
  console.log(`🚀 Cron Job Server running on port ${PORT}`);
  startCronJob();
});
