import { ApiManager } from "@/lib/api"

export const UseUpdateEmployeeAttendance = async ({id, transportation}: {id: string, transportation: boolean}) => {
    try {
        const fetch = await ApiManager(`/employee-attendance/update/attendance?id=${id}`, {
            method: 'PATCH',
            data: {
                transportation: transportation
            }
        })

        return fetch.data
    } catch (error: any) {
        throw new Error(error)
    }
}