import { ApiManager } from "@/lib/api"

export const UseFetchFindManyPackage = async () => {
    try {
        const fetch = await ApiManager(`/package/find-many`)

        return fetch.data
    } catch (error: any) {
        throw new Error(error)
    }
}