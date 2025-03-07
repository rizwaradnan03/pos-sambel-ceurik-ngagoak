import { Button } from '@/components/ui/button'
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger } from '@/components/ui/dialog'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { UseFetchFindOnePackageById } from '@/hooks/api/package/findOneById'
import { UseFetchFindOneProductById } from '@/hooks/api/product/findOneById'
import { UseUpdateProduct } from '@/hooks/api/product/update'
import { UseFetch } from '@/hooks/use-fetch'
import { ISProduct } from '@/interfaces/schema-interface'
import { UseEncodeFileToBase64 } from '@/lib/base64/client'
import { formatPrice, pricedString } from '@/lib/number'
import { Pen } from 'lucide-react'
import React, { useState } from 'react'
import toast from 'react-hot-toast'

const UpdatePackage = ({ packageId, setIsDoneUpdatingPackage }: {packageId: string, setIsDoneUpdatingPackage: (value: boolean) => void }) => {
    const [image, setImage] = useState<string | undefined>(undefined)
    const [name, setName] = useState<string | undefined>(undefined)
    const [price, setPrice] = useState<string | undefined>(undefined)

    const [isButtonDisabled, setIsButtonDisabled] = useState<boolean>(false)

    const [isDialogCreateProductOpen, setIsDialogCreateProductOpen] = useState<boolean>(false)

    const handleUpdatePackage = async () => {
        if (!name || !price) {
            toast.error('Semua field harus diisi')
            return
        }

        setIsButtonDisabled(true)

        try {
            const payload = {
                name: name,
                price: pricedString({value: price}),
                image: image
            }

            await UseUpdateProduct({data: payload, id: packageId})

            setIsDoneUpdatingPackage(true)
            setIsDialogCreateProductOpen(false)
            toast.success("Berhasil mengubah data paket!")

            setName(undefined)
            setImage(undefined)
            setPrice(undefined)
        } catch (error: any) {
            toast.error(error.message)
        }finally{
            setIsButtonDisabled(false)
        }
    }

    const {} = UseFetch<ISProduct>({key: "inventoryPackageUpdate", dependencies: [packageId], apiFunction: async () => {
        const {data}: {data: ISProduct} = await UseFetchFindOnePackageById({id: packageId})
        
        setName(data.name)
        setPrice(formatPrice({value: data.price.toString()}))
    }})

    return (
        <>
            <Dialog onOpenChange={setIsDialogCreateProductOpen} open={isDialogCreateProductOpen}>
                <DialogTrigger asChild className='bg-yellow-500'>
                    <Button><Pen /> Ubah</Button>
                </DialogTrigger>
                <DialogContent>
                    <DialogHeader>
                        <DialogTitle>Ubah Paket</DialogTitle>
                    </DialogHeader>
                    <div className='flex flex-row gap-2'>
                        <div>
                            <img src={image ? image : "#"} alt="Gambar Paket" width={200}  />
                        </div>
                        <div className='flex flex-col gap-2'>
                            <Label>Gambar Paket</Label>
                            <Input type='file' onChange={async (e) => {
                                if (e.target.files && e.target.files[0]) {
                                    setImage(await UseEncodeFileToBase64({ file: e.target.files[0] }))
                                }
                            }} />
                        </div>
                    </div>
                    <div className='flex flex-col gap-2'>
                        <Label>Nama Paket</Label>
                        <Input type='text' value={name} onChange={(e) => setName(e.target.value)} placeholder='contoh : Mie Ayam' />
                    </div>
                    <div className='flex flex-col gap-2'>
                        <Label>Harga</Label>
                        <Input type='text' value={price} onChange={(e) => setPrice(formatPrice({ value: e.target.value }))} placeholder='contoh : 10.000' />
                    </div>
                    <div>
                        <Button className='w-full' onClick={() => handleUpdatePackage()} disabled={isButtonDisabled}>Submit</Button>
                    </div>
                </DialogContent>
            </Dialog>
        </>
    )
}

export default UpdatePackage