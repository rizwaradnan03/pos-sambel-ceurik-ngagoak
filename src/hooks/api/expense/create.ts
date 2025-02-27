import { IFExpense } from "@/interfaces/form-interface"
import { ApiManager } from "@/lib/api"

export const UseCreateExpense = async ({data}: {data: IFExpense}) => {
    try {
        const fetch = await ApiManager(`/expense/create`, {
            method: 'POST',
            data: data
        })

        return fetch.data
    } catch (error: any) {
        throw new Error(error)
    }
}