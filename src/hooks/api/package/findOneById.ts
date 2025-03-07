import { ApiManager } from "@/lib/api"

export const UseFetchFindOnePackageById = async ({id}: {id: string}) => {
    try {
        const fetch = await ApiManager(`/package/find-one-by-id?id=${id}`)

        return fetch.data
    } catch (error: any) {
        throw new Error(error)
    }
}