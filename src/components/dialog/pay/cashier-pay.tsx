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
import { useReactToPrint } from "react-to-print";

const CashierPay = ({ totalPrice, setTotalPrice,cart, setIsDoneCreatingOrder }: { totalPrice: number, setTotalPrice: (value: number) => void,cart: IFCartItem[], setIsDoneCreatingOrder: (value: boolean) => void }) => {
    const [name, setName] = useState<string | undefined>(undefined)
    const [isTaxEnable, setIsTaxEnable] = useState<string | undefined>(undefined)
    const [paymentMethod, setPaymentMethod] = useState<PaymentTypeEnum | undefined>(undefined)

    const [originalPrice, setOriginalPrice] = useState<number>(totalPrice)
    const [taxAmount, setTaxAmount] = useState<number>(0)

    const [isCashierPayDialogOpen, setIsCashierPayDialogOpen] = useState(false)

    useEffect(() => {
        if (isCashierPayDialogOpen && cart.length < 1) {
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
        if (!name || !paymentMethod || cart.length < 1) {
            toast.error("Harap semua field diisi!")
            return
        }

        try {
            const payload = {
                cart: cart,
                isTaxEnable: isTaxEnable === "TRUE",
                customer: name,
                paymentType: paymentMethod,
                totalPrice: isTaxEnable ? totalPrice : originalPrice,
                taxAmount: isTaxEnable ? taxAmount : 0
            } as IFOrder
            console.log("payloaddd nya ", payload)
            // const createOrder = await UseCreateOrder({ data: payload })
            // if (createOrder) {
            //     handlePrint()
            //     toast.success("Berhasil membuat pesanan!")
            //     setIsCashierPayDialogOpen(false)
            //     setIsDoneCreatingOrder(true)
            // }
        } catch (error: any) {
            toast.error(error.response.data.message)
        }
    }

    // useEffect(() => {
    //     if (isTaxEnable !== undefined) {
    //         const taxAmount = originalPrice * 0.10;
    //         if (isTaxEnable === "TRUE") {
    //             setTotalPrice(originalPrice + taxAmount);
    //         } else {
    //             setTotalPrice(originalPrice);
    //         }
    //     }
    // }, [isTaxEnable, originalPrice]);

    // useEffect(() => {
    //     let price = cart.reduce((acc, item) => acc + item.price * item.quantity, 0);
    //     setOriginalPrice(price);
    //     setTotalPrice(price);
    // }, [cart]);
    
    useEffect(() => {
        if(isTaxEnable != undefined){
            const taxAmount = originalPrice * 0.10
            if(isTaxEnable == "TRUE"){
                setTaxAmount(taxAmount)
                setTotalPrice(originalPrice + taxAmount)
            }else if(isTaxEnable == "FALSE"){
                setTotalPrice(originalPrice)
                setTaxAmount(0)
            }
        }
    }, [isTaxEnable])

    useEffect(() => {
        let price = 0
        for(let i = 0;i < cart.length;i++){
            price += cart[i].price * cart[i].quantity
        }

        setOriginalPrice(price)
        setTotalPrice(price)
        setIsTaxEnable(undefined)
    }, [cart])

    console.log("original price nya ", originalPrice)

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
                    <div className='flex flex-col gap-2'>
                        <Label>Pajak</Label>
                        <Select onValueChange={(value) => setIsTaxEnable(value)} defaultValue='FALSE'>
                            <SelectTrigger>
                                <SelectValue placeholder="Apakah Menggunakan Pajak?" />
                            </SelectTrigger>
                            <SelectContent>
                                <SelectItem value='FALSE'>Tidak</SelectItem>
                                <SelectItem value='TRUE'>Ya</SelectItem>
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