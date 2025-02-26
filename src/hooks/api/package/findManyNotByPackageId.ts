import { ApiManager } from "@/lib/api"

export const UseFetchFindManyProductNotByPackageId = async ({packageId}: {packageId: string}) => {
    try {
        const fetch = await ApiManager(`/product/find-many-not-by-package-id?package_id=${packageId}`)

        return fetch.data
    } catch (error: any) {
        throw new Error(error)
    }
}