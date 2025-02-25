import { IFOrder, IFPackage } from "@/interfaces/form-interface";
import { ApiManager } from "@/lib/api";

export const UseCreateOrder = async ({data}: {data: IFOrder}) => {
    try {
        const create = await ApiManager(`/order/create`, {
            method: "POST",
            data: data
        })

        return create.data
    } catch (error: any) {
        throw new Error(error)
    }
}