import { IFProduct } from "@/interfaces/form-interface";
import { ApiManager } from "@/lib/api";

export const UseCreateProduct = async ({data}: {data: IFProduct}) => {
    try {
        const create = await ApiManager(`/product/create`, {
            method: "POST",
            data: data
        })

        return create.data
    } catch (error: any) {
        throw new Error(error)
    }
}