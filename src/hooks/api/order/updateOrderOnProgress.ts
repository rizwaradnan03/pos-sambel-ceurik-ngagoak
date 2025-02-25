import { ApiManager } from "@/lib/api"

export const UseUpdateOrderOnProgressOrderStatus = async ({id}: {id: string}) => {
    try {
        const fetch = await ApiManager(`/order/update-on-progress?id=${id}`)

        return fetch.data
    } catch (error: any) {
        throw new Error(error)
    }
}