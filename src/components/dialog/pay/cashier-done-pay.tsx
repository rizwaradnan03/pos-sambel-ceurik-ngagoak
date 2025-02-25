import { Button } from '@/components/ui/button'
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger } from '@/components/ui/dialog'
import { UseUpdateOrderOnProgressOrderStatus } from '@/hooks/api/order/updateOrderOnProgress'
import React, { useState } from 'react'
import toast from 'react-hot-toast'

const CashierDonePay = ({orderId, setIsOrderDonePay}: {orderId: string, setIsOrderDonePay: (value: boolean) => void}) => {
    const [isDonePayDialogOpen, setIsDonePayDialogOpen] = useState<boolean>(false)

    const handleDonePay = async () => {
        try {
        await UseUpdateOrderOnProgressOrderStatus({id: orderId})

            toast.success("Berhasil!")

            setIsOrderDonePay(true)
        } catch (error: any) {
            toast.error(error.message)
        }
    }

  return (
    <Dialog onOpenChange={setIsDonePayDialogOpen} open={isDonePayDialogOpen}>
        <DialogTrigger>
            <Button>Selesai</Button>
        </DialogTrigger>
        <DialogContent>
            <DialogHeader>
                <DialogTitle>Selesaikan Pesanan</DialogTitle>
            </DialogHeader>
            <div>
                <Button className='w-full' onClick={() => handleDonePay()}>Selesaikan Pesanan</Button>
            </div>
        </DialogContent>
    </Dialog>
  )
}

export default CashierDonePay