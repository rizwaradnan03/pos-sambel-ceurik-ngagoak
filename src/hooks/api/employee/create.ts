import { IFEmployee } from "@/interfaces/form-interface"
import { ApiManager } from "@/lib/api"

export const UseCreateEmployee = async ({data}: {data: IFEmployee}) => {
    try {
        const fetch = await ApiManager(`/employee/create`, {
            method: 'POST',
            data: data
        })

        return fetch.data
    } catch (error: any) {
        throw new Error(error)
    }
}