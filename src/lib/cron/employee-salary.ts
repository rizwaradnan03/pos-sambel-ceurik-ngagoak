import { prisma } from "../prisma";
import * as cron from "node-cron";

const getLastDayOfMonth = (year: number, month: number) => {
  return new Date(year, month, 0).getDate();
};

export const startCronJob = () => {
  cron.schedule("* * * * *", async () => {
    const now = new Date();
    const dateCurrentYear = now.getFullYear();
    const dateCurrentMonth = now.getMonth() + 1;
    const lastDay = getLastDayOfMonth(dateCurrentYear, dateCurrentMonth);
  
    if (now.getDate() === lastDay) {
      console.log("It's the last day of the month, running job...");
  
      const employees = await prisma.employee.findMany({
        where: { isActive: true },
      });
  
      const isAlreadyCreated = await prisma.employeeSalarySummary.findMany({
        where: {
          employeeId: {
            in: employees.map((employee) => employee.id),
          },
          month: dateCurrentMonth,
          year: dateCurrentYear,
        },
      });
  
      if (isAlreadyCreated.length === 0) {
        for (let employee of employees) {
          const countOfPresent = await prisma.employeeAttendance.count({
            where: {
              employeeId: employee.id,
              isPresent: true,
              date: {
                gte: new Date(`${dateCurrentYear}-${dateCurrentMonth}-01`),
                lt: new Date(`${dateCurrentYear}-${dateCurrentMonth + 1}-01`),
              },
            },
          });

          const countOfTransport = await prisma.employeeAttendance.count({
            where: {
              employeeId: employee.id,
              isTransport: true,
              date: {
                gte: new Date(`${dateCurrentYear}-${dateCurrentMonth}-01`),
                lt: new Date(`${dateCurrentYear}-${dateCurrentMonth + 1}-01`),
              },
            }
          })
          
          const totalDays = getLastDayOfMonth(dateCurrentYear, dateCurrentMonth);
          const countOfAbsent = totalDays - countOfPresent;
          const salaryPerDay = Number(employee.salaryPerDay);
  
          const totalSalary = countOfPresent * salaryPerDay;
          const totalCut = countOfAbsent * salaryPerDay;
  
          await prisma.employeeSalarySummary.create({
            data: {
              employeeId: employee.id,
              month: dateCurrentMonth,
              year: dateCurrentYear,
              totalSalary: totalSalary,
              totalTransport: employee.transport,
              totalCut: totalCut,
              isPayed: false,
            },
          });
          console.log(`Salary summary created for employee ${employee.id}`);
        }
      } else {
        console.log("Salary summary already created, skipping...");
      }
    } else {
      console.log("Not the last day of the month, skipping...");
    }
  });
  

  cron.schedule("* * * * *", async () => {
    const now = new Date();
    const today = now.toISOString().split("T")[0];

    console.log("Attendance Job Running...");

    const employees = await prisma.employee.findMany({
      where: { isActive: true },
    });

    for (let employee of employees) {
      const attendance = await prisma.employeeAttendance.findFirst({
        where: {
          employeeId: employee.id,
          date: {
            gte: new Date(today + "T00:00:00.000Z"),
            lt: new Date(today + "T23:59:59.999Z"),
          },
        },
      });
      
      if (!attendance) {
        await prisma.employeeAttendance.create({
          data: {
            employeeId: employee.id,
            date: new Date(today),
            isPresent: false,
            isTransport: false,
          },
        });
        console.log(`Attendance created for employee ${employee.id}`);
      } else {
        console.log(`Attendance already exists for employee ${employee.id}, skipping...`);
      }
    }
  });

};