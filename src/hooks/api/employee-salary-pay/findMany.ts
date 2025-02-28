import { ApiManager } from "@/lib/api"

export const UseFetchFindManyEmployeeSalaryPay = async () => {
    try {
        const fetch = await ApiManager(`/employee-salary-pay/find-many`)

        return fetch.data
    } catch (error: any) {
        throw new Error(error)
    }
}