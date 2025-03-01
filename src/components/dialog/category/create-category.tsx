import { Button } from '@/components/ui/button'
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger } from '@/components/ui/dialog'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select'
import { UseCreateCategory } from '@/hooks/api/category/create'
import { IFCategory } from '@/interfaces/form-interface'
import { CategoryEnum } from '@/interfaces/schema-interface'
import { Plus } from 'lucide-react'
import React, { useState } from 'react'
import toast from 'react-hot-toast'

const CreateCategory = ({ setIsDoneCreatingCategory }: { setIsDoneCreatingCategory: (value: boolean) => void }) => {
    const [title, setTitle] = useState<string | undefined>(undefined)
    const [category, setCategory] = useState<CategoryEnum | undefined>(undefined)
    const [isDialogCreateProductOpen, setIsDialogCreateProductOpen] = useState<boolean>(false)

    const [isButtonDisabled, setIsButtonDisabled] = useState<boolean>(false)

    const handleCreateProduct = async () => {
        if (!title) {
            toast.error('Semua field harus diisi')
            return
        }

        setIsButtonDisabled(true)

        try {
            const payload = {
                title: title,
                category: category
            } as IFCategory

            await UseCreateCategory({data: payload})

            toast.success("Berhasil menambahkan data kategori!")
            setIsDoneCreatingCategory(true)
            setIsDialogCreateProductOpen(false)

            setTitle(undefined)
            setCategory(undefined)
        } catch (error: any) {
            toast.error(error.message)
        }finally{
            setIsButtonDisabled(false)
        }
    }

    return (
        <>
            <Dialog onOpenChange={setIsDialogCreateProductOpen} open={isDialogCreateProductOpen}>
                <DialogTrigger asChild>
                    <Button><Plus /> Tambah Kategori</Button>
                </DialogTrigger>
                <DialogContent>
                    <DialogHeader>
                        <DialogTitle>Tambah Kategori</DialogTitle>
                    </DialogHeader>
                    <div className='flex flex-col gap-2'>
                        <Label>Judul Kategori</Label>
                        <Input type='text' value={title} onChange={(e) => setTitle(e.target.value)} placeholder='contoh : Makanan' />
                    </div>
                    <div className='flex flex-col gap-2'>
                        <Label>Kategori</Label>
                        <Select onValueChange={(value) => setCategory(value as CategoryEnum)}>
                            <SelectTrigger>
                                <SelectValue placeholder="Pilih Kategori" />
                            </SelectTrigger>
                            <SelectContent>
                                <SelectItem value='PRODUCT'>Produk</SelectItem>
                                <SelectItem value='PACKAGE'>Paket</SelectItem>
                            </SelectContent>
                        </Select>
                    </div>
                    <div>
                        <Button className='w-full' onClick={() => handleCreateProduct()} disabled={isButtonDisabled}>Submit</Button>
                    </div>
                </DialogContent>
            </Dialog>
        </>
    )
}

export default CreateCategory