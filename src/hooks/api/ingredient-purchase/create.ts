import { ApiManager } from "@/lib/api";
import { UseCreateIngredient } from "../ingredient/create";
import { IFIngredientPurchase } from "@/interfaces/form-interface";

export const UseCreateIngredientPurchase = async ({data}: {data: IFIngredientPurchase}) => {
    try {
        const create = await ApiManager(`/ingredient-purchase/create`, {
            method: 'POST',
            data: data
        })

        return create.data
    } catch (error: any) {
        throw new Error(error)
    }
}