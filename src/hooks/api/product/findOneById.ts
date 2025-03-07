import { ApiManager } from "@/lib/api"

export const UseFetchFindOneProductById = async ({id}: {id: string}) => {
    try {
        const fetch = await ApiManager(`/product/find-one-by-id?id=${id}`)

        return fetch.data
    } catch (error: any) {
        throw new Error(error)
    }
}