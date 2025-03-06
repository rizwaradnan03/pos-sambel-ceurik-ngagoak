import { ApiManager } from "@/lib/api"

export const UseFetchFindOneEmployeeAttendanceByEmployeeId = async ({employeeId}: {employeeId: string}) => {
    try {
        const fetch = await ApiManager(`/employee-attendance/find-one-by-employee-id?employee_id=${employeeId}`)

        return fetch.data
    } catch (error: any) {
        throw new Error(error)
    }
}