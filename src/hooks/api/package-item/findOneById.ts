import { ApiManager } from "@/lib/api"

export const UseFetchFindOnePackageItemById = async ({id}: {id: string}) => {
    try {
        const fetch = await ApiManager(`/package-item/find-one-by-id?id=${id}`)

        return fetch.data
    } catch (error: any) {
        throw new Error(error)
    }
}