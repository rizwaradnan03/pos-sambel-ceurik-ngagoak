import { Button } from '@/components/ui/button'
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger } from '@/components/ui/dialog'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { Select, SelectContent, SelectGroup, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select'
import { UseCreateProduct } from '@/hooks/api/product/create'
import { UseEncodeFileToBase64 } from '@/lib/base64/client'
import { formatPrice } from '@/lib/number'
import { Plus } from 'lucide-react'
import React, { useState } from 'react'
import toast from 'react-hot-toast'

const CreateProduct = ({ setIsDoneCreatingProduct }: { setIsDoneCreatingProduct: (value: boolean) => void }) => {
    const [image, setImage] = useState<string | undefined>(undefined)
    const [name, setName] = useState<string | undefined>(undefined)
    const [price, setPrice] = useState<string | undefined>(undefined)

    const [isDialogCreateProductOpen, setIsDialogCreateProductOpen] = useState<boolean>(false)

    const handleCreateProduct = async () => {
        if (!name || !price) {
            toast.error('Semua field harus diisi')
            return
        }

        try {
            let formattedPrice = ""
            for (let i = 0; i < price.length; i++) {
                if (price[i] !== '.') {
                    formattedPrice += price[i]
                }
            }

            const payload = {
                name: name,
                price: Number(formattedPrice),
                image: image
            }

            const createProduct = await UseCreateProduct({data: payload})

            setIsDoneCreatingProduct(true)
            setIsDialogCreateProductOpen(false)
            toast.success("Berhasil menambahkan data produk!")
        } catch (error: any) {
            toast.error(error.message)
        } finally {
            setIsDoneCreatingProduct(false)
        }
    }

    console.log("file nya ", image)

    return (
        <>
            <Dialog onOpenChange={setIsDialogCreateProductOpen} open={isDialogCreateProductOpen}>
                <DialogTrigger asChild>
                    <Button><Plus /> Tambah Produk</Button>
                </DialogTrigger>
                <DialogContent>
                    <DialogHeader>
                        <DialogTitle>Tambah Produk</DialogTitle>
                    </DialogHeader>
                    <div className='flex flex-row gap-2'>
                        <div>
                            <img src={image ? image : "#"} alt="Gambar Produk" width={200}  />
                        </div>
                        <div className='flex flex-col gap-2'>
                            <Label>Gambar Produk</Label>
                            <Input type='file' onChange={async (e) => {
                                if (e.target.files && e.target.files[0]) {
                                    setImage(await UseEncodeFileToBase64({ file: e.target.files[0] }))
                                }
                            }} />
                        </div>
                    </div>
                    <div className='flex flex-col gap-2'>
                        <Label>Nama Produk</Label>
                        <Input type='text' value={name} onChange={(e) => setName(e.target.value)} placeholder='contoh : Mie Ayam' />
                    </div>
                    <div className='flex flex-col gap-2'>
                        <Label>Harga</Label>
                        <Input type='text' value={price} onChange={(e) => setPrice(formatPrice({ value: e.target.value }))} placeholder='contoh : 10.000' />
                    </div>
                    <div>
                        <Button className='w-full' onClick={() => handleCreateProduct()}>Submit</Button>
                    </div>
                </DialogContent>
            </Dialog>
        </>
    )
}

export default CreateProduct