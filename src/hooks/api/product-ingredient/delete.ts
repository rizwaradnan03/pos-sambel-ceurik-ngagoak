import { ApiManager } from "@/lib/api"

export const UseDeleteProductIngredient = async ({id}: {id: string}) => {
    try {
        const fetch = await ApiManager(`/product-ingredient/delete?id=${id}`, {
            method: 'DELETE',
        })

        return fetch.data
    } catch (error: any) {
        throw new Error(error)
    }
}