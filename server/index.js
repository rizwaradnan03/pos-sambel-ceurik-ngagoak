import { startCronJob } from "../src/lib/cron/employee-salary.js";
import express from "express";

const app = express();
const PORT = 3020;

app.listen(PORT, () => {
  console.log(`🚀 Cron Job Server running on port ${PORT}`);
  startCronJob();
});
