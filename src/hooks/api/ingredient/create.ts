import { IFIngredient } from "@/interfaces/form-interface"
import { ApiManager } from "@/lib/api"

export const UseCreateIngredient = async ({data}: {data: IFIngredient}) => {
    try {
        const fetch = await ApiManager(`/ingredient/create`, {
            method: 'POST',
            data: data
        })

        return fetch.data
    } catch (error: any) {
        throw new Error(error)
    }
}