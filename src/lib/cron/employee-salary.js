import { dateCurrentMonth, dateCurrentYear } from "../../data/date.ts";
import { prisma } from "../prisma.ts";
import * as cron from "node-cron";

// cron.schedule('0 0 28 * *', async () => {
export const startCronJob = () => {
    cron.schedule('* * * * *', async () => {
        const employees = await prisma.employee.findMany({
            where: {
                isActive: true
            }
        })
    
        const isAlreadyCreated = await prisma.employeeSalaryPay.findMany({
            where: {
                employeeId: {
                    in: employees.map((employee) => employee.id)
                },
                createdAt: {
                    gte: new Date(`${dateCurrentYear}-${dateCurrentMonth}-01`), // Awal bulan
                    lt: new Date(`${dateCurrentYear}-${dateCurrentMonth + 1}-01`) // Awal bulan berikutnya
                }
    
            }
        })
    
        if(isAlreadyCreated.length > 0){
            console.log("data telah ada !")
            return
        }
    
        for(let i = 0;i < employees.length;i++){
            const createSalary = await prisma.employeeSalaryPay.create({
                data: {
                    employeeId: employees[i].id,
                    isPayed: false,
                    amount: employees[i].salary
                }
            })
        }
    }, {
        timezone: 'Asia/Jakarta'
    })
}