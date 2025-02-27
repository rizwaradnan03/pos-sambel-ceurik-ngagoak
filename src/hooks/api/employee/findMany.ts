import { ApiManager } from "@/lib/api"

export const UseFetchFindManyEmployee = async () => {
    try {
        const fetch = await ApiManager(`/employee/find-many`)

        return fetch.data
    } catch (error: any) {
        throw new Error(error)
    }
}