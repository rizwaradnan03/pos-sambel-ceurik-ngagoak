import { ApiManager } from "@/lib/api"

export const UseFetchFindManyExpenses = async () => {
    try {
        const fetch = await ApiManager(`/expense/find-many`)

        return fetch.data
    } catch (error: any) {
        throw new Error(error)
    }
}