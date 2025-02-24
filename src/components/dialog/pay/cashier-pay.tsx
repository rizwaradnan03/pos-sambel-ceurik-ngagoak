import { Button } from '@/components/ui/button'
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger } from '@/components/ui/dialog'
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table'
import { IFCartItem } from '@/interfaces/form-interface'
import { formatPrice } from '@/lib/number'
import React, { useState } from 'react'

const CashierPay = ({ totalPrice, cart }: { totalPrice: number, cart: IFCartItem[] }) => {
    const [name, setName] = useState<string | undefined>(undefined)

    const [isCashierPayDialogOpen, setIsCashierPayDialogOpen] = useState(false)

    return (
        <Dialog onOpenChange={setIsCashierPayDialogOpen} open={isCashierPayDialogOpen}>
            <DialogTrigger><Button className='w-full text-md'>Bayar Sekarang</Button></DialogTrigger>
            <DialogContent>
                <DialogHeader>
                    <DialogTitle>Bayar</DialogTitle>
                </DialogHeader>
                <Table>
                    <TableHeader>
                        <TableRow>
                            <TableHead>No</TableHead>
                            <TableHead>Nama</TableHead>
                            <TableHead>Jumlah</TableHead>
                            <TableHead>Harga</TableHead>
                        </TableRow>
                    </TableHeader>
                    <TableBody>
                        {cart.map((item, index) => (
                            <TableRow key={index}>
                                <TableCell>{index + 1}</TableCell>
                                <TableCell>{item.name}</TableCell>
                                <TableCell>{item.quantity}</TableCell>
                                <TableCell>{formatPrice({value: item.price.toString()})}</TableCell>
                            </TableRow>
                        ))}
                    </TableBody>
                </Table>
            </DialogContent>
        </Dialog>
    )
}

export default CashierPay