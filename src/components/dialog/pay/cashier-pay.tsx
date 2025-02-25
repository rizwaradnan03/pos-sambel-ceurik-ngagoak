import Receipt from '@/components/receipt'
import { Button } from '@/components/ui/button'
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger } from '@/components/ui/dialog'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select'
import { UseCreateOrder } from '@/hooks/api/order/create'
import { IFCartItem, IFOrder } from '@/interfaces/form-interface'
import { PaymentTypeEnum } from '@/interfaces/schema-interface'
import React, { useEffect, useRef, useState } from 'react'
import toast from 'react-hot-toast'
import {useReactToPrint} from "react-to-print";

const CashierPay = ({ totalPrice, cart, setIsDoneCreatingOrder }: { totalPrice: number, cart: IFCartItem[], setIsDoneCreatingOrder: (value: boolean) => void }) => {
    const [name, setName] = useState<string | undefined>(undefined)
    const [paymentMethod, setPaymentMethod] = useState<PaymentTypeEnum | undefined>(undefined)

    const [isCashierPayDialogOpen, setIsCashierPayDialogOpen] = useState(false)

    useEffect(() => {
        if(isCashierPayDialogOpen && cart.length < 1){
            setIsCashierPayDialogOpen(false)
            toast.error("Keranjang pesanan harus terisi terlebih dahulu!")
        }
    }, [isCashierPayDialogOpen])

    const printRef = useRef<HTMLDivElement | null>(null)
    const handlePrint = useReactToPrint({
        contentRef: printRef
    })

    const handleCreateOrder = async () => {
        console.log("isi cart ", cart)
        if(!name || !paymentMethod || cart.length < 1){
            toast.error("Harap semua field diisi!")
            return
        }

        try {
            const payload = {
                cart: cart,
                customer: name,
                paymentType: paymentMethod,
                totalPrice: Number(totalPrice)
            } as IFOrder

            const createOrder = await UseCreateOrder({data: payload})
            if(createOrder){
                // setTimeout(() => {
                    handlePrint()
                // }, 500)
                toast.success("Berhasil membuat pesanan!")
                setIsCashierPayDialogOpen(false)
                setIsDoneCreatingOrder(true)
            }
        } catch (error: any) {
            console.log("errorkontol ", error)
            toast.error(error.response.data.message)
        }
    }

    return (
        <>
        <Dialog onOpenChange={setIsCashierPayDialogOpen} open={isCashierPayDialogOpen}>
            <DialogTrigger><Button className='w-full text-md'>Bayar Sekarang</Button></DialogTrigger>
            <DialogContent>
                <DialogHeader>
                    <DialogTitle>Bayar</DialogTitle>
                </DialogHeader>
                <div className='flex flex-col gap-2'>
                    <Label>Nama Pembeli</Label>
                    <Input type='text' value={name} onChange={(e) => setName(e.target.value)} placeholder='contoh : Akmal' />
                </div>
                <div className='flex flex-col gap-2'>
                    <Label>Metode Pembayaran</Label>
                    <Select onValueChange={(value) => setPaymentMethod(value as PaymentTypeEnum)}>
                        <SelectTrigger>
                            <SelectValue placeholder="Pilih Metode Pembayaran" />
                        </SelectTrigger>
                        <SelectContent>
                            <SelectItem value='CASH'>Cash</SelectItem>
                            <SelectItem value='TRANSFER'>Transfer</SelectItem>
                        </SelectContent>
                    </Select>
                </div>
                <div>
                    <Button className='w-full' onClick={() => handleCreateOrder()}>Buat Pesanan</Button>
                </div>
            </DialogContent>
        </Dialog>
        <div className="hidden">
                <Receipt ref={printRef} order={{ customer: name, cart, totalPrice }} />
            </div>
        </>

    )
}

export default CashierPay