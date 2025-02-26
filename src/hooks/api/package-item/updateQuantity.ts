import { ApiManager } from "@/lib/api"

export const UseUpdatePackageItemQuantity = async ({id, quantity}: {id: string, quantity: number}) => {
    try {
        const update = await ApiManager(`/package-item/update-quantity?id=${id}`, {
            method: 'PATCH',
            data: {
                quantity: quantity
            }
        })

        return update.data
    } catch (error: any) {
        throw new Error(error.message)
    }
}