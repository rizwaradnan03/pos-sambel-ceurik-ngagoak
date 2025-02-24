import { IFPackage } from "@/interfaces/form-interface";
import { ApiManager } from "@/lib/api";

export const UseCreatePackage = async ({data}: {data: IFPackage}) => {
    try {
        const create = await ApiManager(`/package/create`, {
            method: "POST",
            data: data
        })

        return create.data
    } catch (error: any) {
        throw new Error(error)
    }
}