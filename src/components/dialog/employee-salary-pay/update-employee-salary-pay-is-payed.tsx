import { Button } from '@/components/ui/button'
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger } from '@/components/ui/dialog'    
import { UseUpdateEmployeeSalarySummaryIsPayed } from '@/hooks/api/employee-salary-summary/updateIsPayed'
import React, { useState } from 'react'
import toast from 'react-hot-toast'

const UpdateEmployeeSalaryPayIsPayed = ({ employeeSalaryPayId, setIsDoneUpdatingEmployeeSalaryPay }: { employeeSalaryPayId: string, setIsDoneUpdatingEmployeeSalaryPay: (value: boolean) => void }) => {
    const [isUpdateEmployeeSalaryPayDialogOpen, setIsUpdateEmployeeSalaryPayDialogOpen] = useState<boolean>(false)

    const handleUpdateIsPayed = async () => {
        try {
            await UseUpdateEmployeeSalarySummaryIsPayed({ id: employeeSalaryPayId, isPayed: true })

            setIsDoneUpdatingEmployeeSalaryPay(true)
            setIsUpdateEmployeeSalaryPayDialogOpen(false)

            toast.success("Berhasil membayarkan gaji karyawan")
        } catch (error: any) {
            toast.error(error.message)
        }
    }

    return (
        <Dialog onOpenChange={setIsUpdateEmployeeSalaryPayDialogOpen} open={isUpdateEmployeeSalaryPayDialogOpen}>
            <DialogTrigger asChild><Button>Selesai</Button></DialogTrigger>
            <DialogContent>
                <DialogHeader>
                    <DialogTitle>Selesai Bayar Gaji Karyawan</DialogTitle>
                </DialogHeader>
                <div className='flex flex-col gap-2'>
                    <Button onClick={() => handleUpdateIsPayed()}>Sudah Bayar Gaji Karyawan</Button>
                </div>
            </DialogContent>
        </Dialog>
    )
}

export default UpdateEmployeeSalaryPayIsPayed