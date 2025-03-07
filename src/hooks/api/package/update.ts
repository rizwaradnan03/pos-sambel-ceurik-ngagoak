import { IFPackage } from "@/interfaces/form-interface";
import { ApiManager } from "@/lib/api";

export const UseUpdatePackageroduct = async ({data, id}: {data: IFPackage, id: string}) => {
    try {
        const create = await ApiManager(`/package/update?id=${id}`, {
            method: "PATCH",
            data: data
        })

        return create.data
    } catch (error: any) {
        throw new Error(error)
    }
}