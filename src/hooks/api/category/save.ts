import { IFCategorySave } from "@/interfaces/form-interface";
import { ApiManager } from "@/lib/api";

export const UseSaveCategoryItem = async ({data}: {data: IFCategorySave}) => {
    try {
        const save = await ApiManager(`/category/save`, {
            method: 'POST',
            data: data
        })

        return save.data
    } catch (error: any) {
        throw new Error(error)
    }
}