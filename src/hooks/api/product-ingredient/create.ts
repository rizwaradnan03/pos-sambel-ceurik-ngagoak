import { IFProductIngredient } from "@/interfaces/form-interface";
import { ApiManager } from "@/lib/api";

export const UseCreateProductIngredient = async ({data}: {data: IFProductIngredient}) => {
    try {
        const create = await ApiManager(`/product-ingredient/create`, {
            method: "POST",
            data: data
        })

        return create.data
    } catch (error: any) {
        throw new Error(error)
    }
}