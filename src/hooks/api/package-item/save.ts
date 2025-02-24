import { IFProductCategory, IFProductPackage } from "@/interfaces/form-interface"
import { ApiManager } from "@/lib/api"

export const UseSavePackageItem = async ({data}: {data: IFProductPackage}) => {
    try {
        const save = await ApiManager(`/product-item/save`, {
            method: 'POST',
            data: data
        })

        return save.data
    } catch (error: any) {
        throw new Error(error)
    }
}