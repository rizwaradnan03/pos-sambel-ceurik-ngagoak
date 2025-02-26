import { ApiManager } from "@/lib/api"

export const UseFetchFindManyPackageNotByCategoryId =async ({categoryId}: {categoryId: string}) => {
    try {
        const fetch = await ApiManager(`/package/find-many-not-by-category-id?category_id=${categoryId}`)

        return fetch.data
    } catch (error: any) {
        throw new Error(error)
    }
}