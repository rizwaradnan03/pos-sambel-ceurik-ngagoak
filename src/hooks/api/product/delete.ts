import { ApiManager } from "@/lib/api"

export const UseDeleteProduct = async ({productId}: {productId: string}) => {
    try {
        const deleteProduct = await ApiManager(`/product/delete?id=${productId}`, {
            method: "DELETE"
        })

        return deleteProduct.data
    } catch (error: any) {
        throw new Error(error)
    }
}