import { Button } from '@/components/ui/button'
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger } from '@/components/ui/dialog'
import { UseDeleteProduct } from '@/hooks/api/product/delete'
import { Delete } from 'lucide-react'
import React, { useState } from 'react'
import toast from 'react-hot-toast'

const DeleteProduct = ({ productId, setIsDoneDeletingProduct }: { productId: string, setIsDoneDeletingProduct: (value: boolean) => void }) => {
    const [isDialogAttendanceOpen, setIsDialogAttendanceOpen] = useState<boolean>(false)

    const handleDeleteProduct = async () => {
        try {
            console.log("produk id yang mau dihapus nya ", productId)

            await UseDeleteProduct({productId: productId})

            toast.success("Berhasil menghapus produk!")
            setIsDialogAttendanceOpen(false)
            setIsDoneDeletingProduct(true)
        } catch (error: any) {
            toast.error(error.message)
        }
    }

    return (
        <Dialog onOpenChange={setIsDialogAttendanceOpen} open={isDialogAttendanceOpen}>
            <DialogTrigger asChild>
                <Button><Delete /> Hapus</Button>
            </DialogTrigger>
            <DialogContent>
                <DialogHeader>
                    <DialogTitle>Hapus Produk</DialogTitle>
                </DialogHeader>
                <div>
                    <Button className='w-full' onClick={() => handleDeleteProduct()}>Hapus Produk Ini</Button>
                </div>
            </DialogContent>
        </Dialog>
    )
}

export default DeleteProduct
