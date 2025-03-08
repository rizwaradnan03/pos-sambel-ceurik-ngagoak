import { IFOrder } from "@/interfaces/form-interface";
import { ApiManager } from "@/lib/api";

export const UseCreateOrder = async ({data}: {data: IFOrder}) => {
    try {
        const create = await ApiManager(`/order/create`, {
            method: "POST",
            data: data
        })

        return create.data
    } catch (error: any) {
        console.log("bentuk error s", error)
        // throw error
        throw new Error(error)
    }
}