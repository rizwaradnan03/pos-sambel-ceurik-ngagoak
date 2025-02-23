import { ApiManager } from "@/lib/api"

export const UseFetchFindManyCategory = async () => {
    try {
        const fetch = await ApiManager(`/category/find-many`)

        return fetch.data
    } catch (error: any) {
        throw new Error(error)
    }
}