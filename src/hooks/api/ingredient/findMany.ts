import { ApiManager } from "@/lib/api"

export const UseFetchFindManyIngredients = async () => {
    try {
        const fetch = await ApiManager(`/ingredient/find-many`)

        return fetch.data
    } catch (error: any) {
        throw new Error(error)
    }
}