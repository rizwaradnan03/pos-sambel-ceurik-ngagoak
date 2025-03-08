import { IFIngredient } from "@/interfaces/form-interface";
import { ApiManager } from "@/lib/api";

export const UseUpdateIngredient = async ({data, id}: {data: IFIngredient, id: string}) => {
    try {
        const create = await ApiManager(`/ingredient/update?id=${id}`, {
            method: "PATCH",
            data: data
        })

        return create.data
    } catch (error: any) {
        throw new Error(error)
    }
}