import { ApiManager } from "@/lib/api"

export const UseFetchFindOneEmployeeById = async ({id}: {id: string}) => {
    try {
        const fetch = await ApiManager(`/employee/find-one-by-id?id=${id}`)

        return fetch.data
    } catch (error: any) {
        throw new Error(error)
    }
}