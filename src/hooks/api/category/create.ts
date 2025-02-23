import { IFCategory } from "@/interfaces/form-interface"
import { ApiManager } from "@/lib/api"

export const UseCreateCategory = async ({data}: {data: IFCategory}) => {
    try {
        const fetch = await ApiManager(`/category/create`, {
            method: 'POST',
            data: data
        })

        return fetch.data
    } catch (error: any) {
        throw new Error(error)
    }
}