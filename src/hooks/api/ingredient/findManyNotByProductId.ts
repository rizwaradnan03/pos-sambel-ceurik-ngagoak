import { ApiManager } from "@/lib/api"

export const UseFetchFindManyIngredientNotByProductId = async ({productId}: {productId: string}) => {
    try {
        const fetch = await ApiManager(`/ingredient/find-many-not-by-product-id?product_id=${productId}`)

        return fetch.data
    } catch (error: any) {
        throw new Error(error)
    }
}