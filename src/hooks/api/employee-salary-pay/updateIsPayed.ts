import { ApiManager } from "@/lib/api"

export const UseUpdateEmployeeSalaryPayIsPayed = async ({id, isPayed}: {id: string, isPayed: boolean}) => {
    try {
        const update = await ApiManager(`/employee-salary-pay/update-is-payed?id=${id}`, {
            method: 'PATCH',
            data: {
                isPayed: isPayed
            }
        })

        return update.data
    } catch (error: any) {
        throw new Error(error.message)
    }
}