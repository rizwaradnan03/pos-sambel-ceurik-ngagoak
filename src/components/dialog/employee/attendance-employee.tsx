import { Button } from '@/components/ui/button'
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger } from '@/components/ui/dialog'
import { RadioGroup, RadioGroupItem } from '@/components/ui/radio-group'
import { UseFetchFindOneEmployeeAttendanceByEmployeeId } from '@/hooks/api/employee-attendance/findOneByEmployeeId'
import { UseUpdateEmployeeAttendance } from '@/hooks/api/employee-attendance/updateAttendance'
import { UseFetch } from '@/hooks/use-fetch'
import { ISEmployeeAttendance } from '@/interfaces/schema-interface'
import { Plus } from 'lucide-react'
import React, { useState } from 'react'
import toast from 'react-hot-toast'

const AttendanceEmployee = ({employeeId}: {employeeId: string}) => {
    const [isDialogAttendanceOpen, setIsDialogAttendanceOpen] = useState<boolean>(false)
    const [isDoneUpdatingAttendance, setIsDoneUpdatingAttendance] = useState<boolean>(false)
    const [transportation, setTransportation] = useState<string>('')

    const handleAttendance = async () => {
        if(!dataEmployeeAttendance){
            return
        }

        try {
            const updateAttendance = await UseUpdateEmployeeAttendance({id: dataEmployeeAttendance?.id as string, transportation: transportation == "yes" ? true : false})
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
                <Button><Plus /> Absensi Karyawan</Button>
            </DialogTrigger>
            <DialogContent>
                <DialogHeader>
                    <DialogTitle>Absensi Karyawan</DialogTitle>
                </DialogHeader>
                <div>
                    {dataEmployeeAttendance && (
                        <>
                            <RadioGroup value={transportation} onValueChange={setTransportation} className='my-2'>
                                <h1>Apakah menggunakan uang transportasi pada hari ini?</h1>
                                <div className="flex items-center gap-2">
                                    <RadioGroupItem value="yes" id="ya" />
                                    <label htmlFor="ya">Ya</label>
                                </div>
                                <div className="flex items-center gap-2">
                                    <RadioGroupItem value="no" id="tidak" />
                                    <label htmlFor="tidak">Tidak</label>
                                </div>
                            </RadioGroup>
                            <Button className='w-full' onClick={() => handleAttendance()}>Lakukan Absensi Untuk Hari Ini</Button>
                        </>
                    )}
                </div>
            </DialogContent>
        </Dialog>
    )
}

export default AttendanceEmployee
