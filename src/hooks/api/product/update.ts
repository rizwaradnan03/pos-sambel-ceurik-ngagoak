import { IFProduct } from "@/interfaces/form-interface";
import { ApiManager } from "@/lib/api";

export const UseUpdateProduct = async ({data, id}: {data: IFProduct, id: string}) => {
    try {
        const create = await ApiManager(`/product/update?id=${id}`, {
            method: "PATCH",
            data: data
        })

        return create.data
    } catch (error: any) {
        throw new Error(error)
    }
}