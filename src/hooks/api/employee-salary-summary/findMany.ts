import { ApiManager } from "@/lib/api"

export const UseFetchFindManyEmployeeSalarySummary = async () => {
    try {
        const fetch = await ApiManager(`/employee-salary-summary/find-many`)

        return fetch.data
    } catch (error: any) {
        throw new Error(error)
    }
}