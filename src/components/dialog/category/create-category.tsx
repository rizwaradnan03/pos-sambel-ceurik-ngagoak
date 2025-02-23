import { Button } from '@/components/ui/button'
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger } from '@/components/ui/dialog'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { Select, SelectContent, SelectGroup, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select'
import { UseCreateCategory } from '@/hooks/api/category/create'
import { UseEncodeFileToBase64 } from '@/lib/base64/client'
import { formatPrice } from '@/lib/number'
import { Plus } from 'lucide-react'
import React, { useState } from 'react'
import toast from 'react-hot-toast'

const CreateCategory = ({ setIsDoneCreatingCategory }: { setIsDoneCreatingCategory: (value: boolean) => void }) => {
    const [title, setTitle] = useState<string | undefined>(undefined)
    const [isDialogCreateProductOpen, setIsDialogCreateProductOpen] = useState<boolean>(false)

    const handleCreateProduct = async () => {
        if (!title) {
            toast.error('Semua field harus diisi')
            return
        }

        try {
            const createProduct = await UseCreateCategory({data: {title: title}})

            toast.success("Berhasil menambahkan data kategori!")
            setIsDoneCreatingCategory(true)
            setIsDialogCreateProductOpen(false)
        } catch (error: any) {
            toast.error(error.message)
        } finally {
            setIsDoneCreatingCategory(false)
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
                    <div>
                        <Button className='w-full' onClick={() => handleCreateProduct()}>Submit</Button>
                    </div>
                </DialogContent>
            </Dialog>
        </>
    )
}

export default CreateCategory