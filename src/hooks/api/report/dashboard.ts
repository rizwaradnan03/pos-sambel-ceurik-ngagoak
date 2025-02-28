import { ApiManager } from "@/lib/api"

export const UseFetchReportDashboard = async () => {
    try {
        const fetch = await ApiManager(`/report/dashboard`)

        return fetch.data
    } catch (error: any) {
        throw new Error(error)
    }
}