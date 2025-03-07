import { Button } from '@/components/ui/button'
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger } from '@/components/ui/dialog'
import { RadioGroup, RadioGroupItem } from '@/components/ui/radio-group'
import { UseFetchFindOneEmployeeAttendanceByEmployeeId } from '@/hooks/api/employee-attendance/findOneByEmployeeId'
import { UseUpdateEmployeeAttendance } from '@/hooks/api/employee-attendance/updateAttendance'
import { UseFetch } from '@/hooks/use-fetch'
import { ISEmployeeAttendance } from '@/interfaces/schema-interface'
import { Pen, Plus } from 'lucide-react'
import React, { useState } from 'react'
import toast from 'react-hot-toast'

const AttendanceEmployee = ({employeeId}: {employeeId: string}) => {
    const [isDialogAttendanceOpen, setIsDialogAttendanceOpen] = useState<boolean>(false)
    const [isDoneUpdatingAttendance, setIsDoneUpdatingAttendance] = useState<boolean>(false)

    const handleAttendance = async () => {
        if(!dataEmployeeAttendance){
            return
        }

        try {
            await UseUpdateEmployeeAttendance({id: dataEmployeeAttendance?.id as string})
            toast.success("Berhasil melakukan absensi")
            setIsDoneUpdatingAttendance(true)
        } catch (error: any) {
            toast.error(error.message)
        }
    }

    const {data: dataEmployeeAttendance} = UseFetch<ISEmployeeAttendance>({key: "userEmployeeAttendance", dependencies: [employeeId], refetchDependencies: [{stateValue: isDoneUpdatingAttendance, stateSetter: setIsDoneUpdatingAttendance}], apiFunction: async () => {
        return await UseFetchFindOneEmployeeAttendanceByEmployeeId({employeeId: employeeId})
    }})

    return (
        <Dialog onOpenChange={setIsDialogAttendanceOpen} open={isDialogAttendanceOpen}>
            <DialogTrigger asChild>
                <Button><Pen /> Absensi</Button>
            </DialogTrigger>
            <DialogContent>
                <DialogHeader>
                    <DialogTitle>Absensi Karyawan</DialogTitle>
                </DialogHeader>
                <div>
                    {dataEmployeeAttendance && (
                        <>
                            <Button className='w-full' onClick={() => handleAttendance()}>Lakukan Absensi Untuk Hari Ini</Button>
                        </>
                    )}
                </div>
            </DialogContent>
        </Dialog>
    )
}

export default AttendanceEmployee
