import { Button } from '@/components/ui/button'
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger } from '@/components/ui/dialog'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select'
import { Textarea } from '@/components/ui/textarea'
import { UseCreateCategory } from '@/hooks/api/category/create'
import { UseCreateEmployee } from '@/hooks/api/employee/create'
import { UseCreateExpense } from '@/hooks/api/expense/create'
import { IFCategory, IFEmployee, IFExpense } from '@/interfaces/form-interface'
import { CategoryEnum } from '@/interfaces/schema-interface'
import { formatPrice, pricedString } from '@/lib/number'
import { Plus } from 'lucide-react'
import React, { useState } from 'react'
import toast from 'react-hot-toast'

const CreateEmployee = ({ setIsDoneCreatingEmployee }: { setIsDoneCreatingEmployee: (value: boolean) => void }) => {
    const [name, setName] = useState<string | undefined>(undefined)
    const [salaryPerDay, setSalaryPerDay] = useState<string | undefined>(undefined)
    const [transportPerDay, setTransportPerDay] = useState<string | undefined>(undefined)
    const [phoneNumber, setPhoneNumber] = useState<string | undefined>(undefined)
    const [role, setRole] = useState<string | undefined>(undefined)
    const [isActive, setIsActive] = useState<string | undefined>(undefined)

    const [isDialogCreateExpenseOpen, setIsDialogCreateExpenseOpen] = useState<boolean>(false)

    const handleCreateProduct = async () => {
        console.log('data', [name, salaryPerDay, phoneNumber, role, isActive])

        if (!name || !salaryPerDay || !phoneNumber || !role || !isActive || !transportPerDay) {
            toast.error('Semua field harus diisi')
            return
        }

        try {
            const payload = {
                name: name,
                salaryPerDay: pricedString({ value: salaryPerDay }),
                transportPerDay: pricedString({ value: transportPerDay }),
                phoneNumber: phoneNumber,
                role: role,
                isActive: isActive === "TRUE"
            } as IFEmployee

            await UseCreateEmployee({ data: payload })

            toast.success("Berhasil menambahkan data kategori!")
            setIsDoneCreatingEmployee(true)
            setIsDialogCreateExpenseOpen(false)

            setName(undefined)
            setSalaryPerDay(undefined)
            setTransportPerDay(undefined)
            setPhoneNumber(undefined)
            setRole(undefined)
            setIsActive(undefined)
        } catch (error: any) {
            toast.error(error.message)
        }
    }

    return (
        <>
            <Dialog onOpenChange={setIsDialogCreateExpenseOpen} open={isDialogCreateExpenseOpen}>
                <DialogTrigger asChild>
                    <Button><Plus /> Tambah Karyawan</Button>
                </DialogTrigger>
                <DialogContent>
                    <DialogHeader>
                        <DialogTitle>Tambah Karyawan</DialogTitle>
                    </DialogHeader>
                    <div className='flex flex-col gap-2'>
                        <Label>Nama</Label>
                        <Input type='text' value={name} onChange={(e) => setName(e.target.value)} placeholder='contoh : Rizwar' />
                    </div>
                    <div className='flex flex-col gap-2'>
                        <Label>Nomor Telepon</Label>
                        <Input type='text' value={phoneNumber} onChange={(e) => setPhoneNumber(e.target.value)} placeholder='contoh : 0858******' />
                    </div>
                    <div className='flex flex-col gap-2'>
                        <Label>Jabatan</Label>
                        <Select value={role} onValueChange={(value) => setRole(value)}>
                            <SelectTrigger>
                                <SelectValue placeholder={"Pilih Jabatan"} />
                                <SelectContent>
                                    <SelectItem value='CASHIER'>Kasir</SelectItem>
                                    <SelectItem value='CHEF'>Chef</SelectItem>
                                </SelectContent>
                            </SelectTrigger>
                        </Select>
                    </div>
                    <div className='flex flex-col gap-2'>
                        <Label>Gaji Per Hari</Label>
                        <Input type='text' value={salaryPerDay} onChange={(e) => setSalaryPerDay(formatPrice({ value: e.target.value.toString() }))} placeholder='100.000' />
                    </div>
                    <div className='flex flex-col gap-2'>
                        <Label>Transportasi Per Hari</Label>
                        <Input type='text' value={transportPerDay} onChange={(e) => setTransportPerDay(formatPrice({ value: e.target.value.toString() }))} placeholder='25.000' />
                    </div>
                    <div className='flex flex-col gap-2'>
                        <Label>Status Aktif</Label>
                        <Select value={isActive} onValueChange={(value) => setIsActive(value)}>
                            <SelectTrigger>
                                <SelectValue placeholder={"Status Aktif Karyawan"} />
                                <SelectContent>
                                    <SelectItem value='TRUE'>Aktif</SelectItem>
                                    <SelectItem value='FALSE'>Tidak Aktif</SelectItem>
                                </SelectContent>
                            </SelectTrigger>
                        </Select>                    
                    </div>
                    <div>
                        <Button className='w-full' onClick={() => handleCreateProduct()}>Submit</Button>
                    </div>
                </DialogContent>
            </Dialog>
        </>
    )
}

export default CreateEmployee