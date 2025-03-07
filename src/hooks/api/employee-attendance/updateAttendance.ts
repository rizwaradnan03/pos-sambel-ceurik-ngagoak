import { ApiManager } from "@/lib/api"

export const UseUpdateEmployeeAttendance = async ({id}: {id: string,}) => {
    try {
        const fetch = await ApiManager(`/employee-attendance/update/attendance?id=${id}`, {
            method: 'PATCH',
        })

        return fetch.data
    } catch (error: any) {
        throw new Error(error)
    }
}