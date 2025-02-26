import { ApiManager } from "@/lib/api"

export const UseReportByMonth = async () => {
    try {
        const fetch = await ApiManager(`/report/by-month`)

        return fetch.data
    } catch (error: any) {
        throw new Error(error)
    }
}