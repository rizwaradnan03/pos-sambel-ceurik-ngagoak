"use client"

import { Button } from '@/components/ui/button'
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger } from '@/components/ui/dialog'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select'
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table'
import { UseFetchFindManyIngredientNotByProductId } from '@/hooks/api/ingredient/findManyNotByProductId'
import { UseCreateProductIngredient } from '@/hooks/api/product-ingredient/create'
import { UseFetchFindManyProductIngredientByProductId } from '@/hooks/api/product-ingredient/findManyByProductId'
import { UseFetch } from '@/hooks/use-fetch'
import { IFProductIngredient } from '@/interfaces/form-interface'
import { ISIngredient, ISProductIngredient } from '@/interfaces/schema-interface'
import { Plus } from 'lucide-react'
import React, { useState } from 'react'
import toast from 'react-hot-toast'

const ProductIngredient = ({ productId }: { productId: string }) => {
    const [selectedIngredient, setSelectedIngredient] = useState<string | undefined>(undefined)
    const [dose, setDose] = useState<string | undefined>(undefined)

    const [isDoseProductDialogOpen, setIsDoseProductDialogOpen] = useState<boolean>(false)
    const [isDoneCreatingProductIngredient, setIsDoneCreatingProductIngredient] = useState<boolean>(false)

    const [isButtonDisabled, setIsButtonDisabled] = useState<boolean>(false)

    const { data: dataIngredient } = UseFetch<ISIngredient[]>({
        key: 'inventoryProductIngredientIngredient', dependencies: [productId], refetchDependencies: [{stateValue: isDoneCreatingProductIngredient, stateSetter: setIsDoneCreatingProductIngredient}], apiFunction: async () => {
            return await UseFetchFindManyIngredientNotByProductId({ productId: productId })
        }
    })

    const { data: dataProductIngredient } = UseFetch<ISProductIngredient[]>({
        key: 'inventoryProductIngredient', dependencies: [productId], refetchDependencies: [{stateValue: isDoneCreatingProductIngredient, stateSetter: setIsDoneCreatingProductIngredient}], apiFunction: async () => {
            return await UseFetchFindManyProductIngredientByProductId({ productId: productId })
        }
    })

    console.log("isi data product ingredientz ", dataProductIngredient)

    const handleCreateProductIngredient = async () => {
        if(!selectedIngredient || !dose || !productId){
            toast.error("Bahan & dosis dibutuhkan!")
            return
        }

        setIsButtonDisabled(true)

        try {
            const payload = {
                productId: productId,
                ingredientId: selectedIngredient,
                dose: Number(dose)
            } as IFProductIngredient

            await UseCreateProductIngredient({data: payload})

            toast.success("Berhasil membuat data bahan baku produk!")
            setIsDoseProductDialogOpen(false)
            setIsDoneCreatingProductIngredient(true)

            setSelectedIngredient(undefined)
            setDose(undefined)
        } catch (error: any) {
            toast.error(error.message)
        }finally{
            setIsButtonDisabled(false)
        }
    }

    return (
        <Dialog onOpenChange={setIsDoseProductDialogOpen} open={isDoseProductDialogOpen}>
            <DialogTrigger asChild>
                <Button><Plus /> Dosis Bahan</Button>
            </DialogTrigger>
            <DialogContent>
                <DialogHeader>
                    <DialogTitle>Dosis Bahan</DialogTitle>
                </DialogHeader>
                <div className='flex flex-col gap-2'>
                    <div className='flex flex-col gap-3'>
                        <div className='flex flex-col gap-2'>
                            <Label>Bahan</Label>
                            <Select onValueChange={(value) => setSelectedIngredient(value as string)}>
                                <SelectTrigger>
                                    <SelectValue placeholder="Pilih Kategori" />
                                </SelectTrigger>
                                <SelectContent>
                                    {dataIngredient?.map((ingredient) => (
                                        <SelectItem value={ingredient.id as string}>({ingredient.unitOfMeasure}) {ingredient.name}</SelectItem>
                                    ))}
                                </SelectContent>
                            </Select>
                        </div>
                        <div className='flex flex-col gap-2'>
                            <Label>Dosis</Label>
                            <Input type='text' value={dose} onChange={(e) => setDose(e.target.value)} placeholder='Masukan jumlah dosis bahan untuk menjadi satu produk' />
                        </div>
                        <div>
                            <Button className='w-full' onClick={() => handleCreateProductIngredient()} disabled={isButtonDisabled}>Submit</Button>
                        </div>
                    </div>
                    <div>
                        <Table>
                            <TableHeader>
                                <TableRow>
                                    <TableHead>No</TableHead>
                                    <TableHead>Bahan</TableHead>
                                    <TableHead>Dosis</TableHead>
                                    <TableHead>Satuan</TableHead>
                                </TableRow>
                            </TableHeader>
                            <TableBody>
                                {dataProductIngredient?.map((productIngredient, index) => (
                                <TableRow key={index + 1}>
                                    <TableCell>{index + 1}</TableCell>
                                    <TableCell>{productIngredient.Ingredient?.name}</TableCell>
                                    <TableCell>{productIngredient.dose}</TableCell>
                                    <TableCell>{productIngredient.Ingredient?.unitOfMeasure}</TableCell>
                                </TableRow>
                                ))}
                            </TableBody>
                        </Table>          
                    </div>
                </div>
            </DialogContent>
        </Dialog>
    )
}

export default ProductIngredient