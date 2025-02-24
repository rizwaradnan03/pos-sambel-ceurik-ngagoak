import { IFProductCategory } from "@/interfaces/form-interface"
import { ApiManager } from "@/lib/api"

export const UseSaveProductCategory = async ({data}: {data: IFProductCategory}) => {
    try {
        const save = await ApiManager(`/product-category/save`, {
            method: 'POST',
            data: data
        })

        return save.data
    } catch (error: any) {
        throw new Error(error)
    }
}