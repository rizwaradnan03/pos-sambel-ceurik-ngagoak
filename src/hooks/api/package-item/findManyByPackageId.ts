import { ApiManager } from "@/lib/api"

export const UseFetchFindManyPackageItemByPackageId = async ({packageId}: {packageId: string}) => {
    try {
        const fetch = await ApiManager(`/package-item/find-many-by-package-id?package_id=${packageId}`)

        return fetch.data
    } catch (error: any) {
        throw new Error(error)
    }
}