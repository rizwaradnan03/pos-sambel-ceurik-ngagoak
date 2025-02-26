import { ApiManager } from "@/lib/api"

export const UseFetchFindManyProductNotByCategoryId =async ({categoryId}: {categoryId: string}) => {
    try {
        const fetch = await ApiManager(`/product/find-many-not-by-category-id?category_id=${categoryId}`)

        return fetch.data
    } catch (error: any) {
        throw new Error(error)
    }
}