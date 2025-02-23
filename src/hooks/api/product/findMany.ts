import { ApiManager } from "@/lib/api"

export const UseFetchFindManyProduct = async () => {
    try {
        const fetch = await ApiManager(`/product/find-many`)

        return fetch.data
    } catch (error: any) {
        throw new Error(error)
    }
}