import { ApiManager } from "@/lib/api"

export const UseDeleteProductCategory = async ({id}: {id: string}) => {
    try {
        const deleteProduct = await ApiManager(`/product-category/delete?id=${id}`, {
            method: "DELETE"
        })

        return deleteProduct.data
    } catch (error: any) {
        throw new Error(error)
    }
}