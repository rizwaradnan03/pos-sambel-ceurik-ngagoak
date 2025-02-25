import { ApiManager } from "@/lib/api"

export const UseFetchFindManyOnProgressOrder = async () => {
    try {
        const fetch = await ApiManager(`/order/find-many-on-progress`)

        return fetch.data
    } catch (error: any) {
        throw new Error(error)
    }
}