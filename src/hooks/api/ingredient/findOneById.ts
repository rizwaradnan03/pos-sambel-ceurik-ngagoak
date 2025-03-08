import { ApiManager } from "@/lib/api"

export const UseFetchFindOneIngredientById = async ({id}: {id: string}) => {
    try {
        const fetch = await ApiManager(`/ingredient/find-one-by-id?id=${id}`)

        return fetch.data
    } catch (error: any) {
        throw new Error(error)
    }
}