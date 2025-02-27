import { Button } from '@/components/ui/button'
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger } from '@/components/ui/dialog'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select'
import { Textarea } from '@/components/ui/textarea'
import { UseCreateCategory } from '@/hooks/api/category/create'
import { UseCreateExpense } from '@/hooks/api/expense/create'
import { IFCategory, IFExpense } from '@/interfaces/form-interface'
import { CategoryEnum } from '@/interfaces/schema-interface'
import { formatPrice, pricedString } from '@/lib/number'
import { Plus } from 'lucide-react'
import React, { useState } from 'react'
import toast from 'react-hot-toast'

const CreateExpense = ({ setIsDoneCreatingExpense }: { setIsDoneCreatingExpense: (value: boolean) => void }) => {
    const [name, setName] = useState<string | undefined>(undefined)
    const [amount, setAmount] = useState<string | undefined>(undefined)
    const [description, setDescription] = useState<string | undefined>(undefined)
    const [createdAt, setCreatedAt] = useState<string | undefined>(undefined)
    
    const [isDialogCreateExpenseOpen, setIsDialogCreateExpenseOpen] = useState<boolean>(false)

    const handleCreateProduct = async () => {
        if (!name || !amount || !description || !createdAt) {
            toast.error('Semua field harus diisi')
            return
        }

        try {
            const payload = {
                name: name,
                amount: pricedString({value: amount}),
                description: description,
                createdAt: new Date(createdAt).toISOString()
            } as IFExpense

            await UseCreateExpense({data: payload})

            toast.success("Berhasil menambahkan data kategori!")
            setIsDoneCreatingExpense(true)
            setIsDialogCreateExpenseOpen(false)

            setName(undefined)
            setAmount(undefined)
            setDescription(undefined)
            setCreatedAt(undefined)
        } catch (error: any) {
            toast.error(error.message)
        }
    }

    return (
        <>
            <Dialog onOpenChange={setIsDialogCreateExpenseOpen} open={isDialogCreateExpenseOpen}>
                <DialogTrigger asChild>
                    <Button><Plus /> Tambah Biaya Operasional</Button>
                </DialogTrigger>
                <DialogContent>
                    <DialogHeader>
                        <DialogTitle>Tambah Biaya Operasional</DialogTitle>
                    </DialogHeader>
                    <div className='flex flex-col gap-2'>
                        <Label>Judul</Label>
                        <Select value={name} onValueChange={(value) => setName(value)}>
                            <SelectTrigger>
                                <SelectValue placeholder={"Pilih Biaya Operasional"} />
                                <SelectContent>
                                    <SelectItem value='BIAYA LISTRIK'>Biaya Listrik</SelectItem>
                                    <SelectItem value='BIAYA AIR'>Biaya Air</SelectItem>
                                    <SelectItem value='BIAYA INTERNET'>Biaya Internet</SelectItem>
                                    <SelectItem value='BIAYA SEWA TEMPAT'>Biaya Sewa Tempat</SelectItem>
                                    <SelectItem value='BIAYA TRANSPORTASI'>Biaya Transportasi</SelectItem>
                                    <SelectItem value='BIAYA PERAWATAN BARANG'>Biaya Perawatan Barang (contoh: AC)</SelectItem>
                                    <SelectItem value='BIAYA MAKAN'>Biaya Makan (Karyawan)</SelectItem>
                                    <SelectItem value='BIAYA PAJAK & PERIZINAN'>Biaya Pajak & Perizinan</SelectItem>
                                    <SelectItem value='BIAYA KEAMANAN'>Biaya Keamanan</SelectItem>
                                    <SelectItem value='BIAYA BAHAN HABIS PAKAI'>Biaya Bahan Habis Pakai (contoh: tisu, kantong plastik)</SelectItem>
                                </SelectContent>
                            </SelectTrigger>
                        </Select>
                    </div>
                    <div className='flex flex-col gap-2'>
                        <Label>Jumlah</Label>
                        <Input type='text' value={amount} onChange={(e) => setAmount(formatPrice({value: e.target.value}))} placeholder='contoh : 12.000' />
                    </div>
                    <div className='flex flex-col gap-2'>
                        <Label>Waktu</Label>
                        <Input type='datetime-local' value={createdAt} onChange={(e) => setCreatedAt(e.target.value)} />
                    </div>
                    <div className='flex flex-col gap-2'>
                        <Label>Deskripsi</Label>
                        <Textarea value={description} onChange={(e) => setDescription(e.target.value)} placeholder='Bayar Listrik' />
                    </div>
                    <div>
                        <Button className='w-full' onClick={() => handleCreateProduct()}>Submit</Button>
                    </div>
                </DialogContent>
            </Dialog>
        </>
    )
}

export default CreateExpense