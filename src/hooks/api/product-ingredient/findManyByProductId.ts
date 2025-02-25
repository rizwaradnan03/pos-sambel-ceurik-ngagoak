import { ApiManager } from "@/lib/api"

export const UseFetchFindManyProductIngredientByProductId = async ({productId}: {productId: string}) => {
    try {
        const fetch = await ApiManager(`/product-ingredient/find-many-by-product-id?product_id=${productId}`)

        return fetch.data
    } catch (error: any) {
        throw new Error(error)
    }
}