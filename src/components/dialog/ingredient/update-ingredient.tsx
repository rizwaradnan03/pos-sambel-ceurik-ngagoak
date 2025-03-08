import { Button } from '@/components/ui/button'
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger } from '@/components/ui/dialog'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { Select, SelectContent, SelectGroup, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select'
import { UseCreateIngredient } from '@/hooks/api/ingredient/create'
import { UseFetchFindOneIngredientById } from '@/hooks/api/ingredient/findOneById'
import { UseUpdateIngredient } from '@/hooks/api/ingredient/update'
import { IFIngredient } from '@/interfaces/form-interface'
import { ISIngredient, UnitOfMeasureEnum } from '@/interfaces/schema-interface'
import { Pen, Plus } from 'lucide-react'
import React, { useEffect, useState } from 'react'
import toast from 'react-hot-toast'

const UpdateIngredient = ({ ingredientId, setIsDoneUpdatingIngredient }: { ingredientId: string, setIsDoneUpdatingIngredient: (value: boolean) => void }) => {
    const [name, setName] = useState<string | undefined>(undefined)
    const [stock, setStock] = useState<number>(0)
    const [unitOfMeasure, setUnitOfMeasure] = useState<UnitOfMeasureEnum | undefined>(undefined)

    const [isDialogCreateIngredientOpen, setIsDialogCreateIngredientOpen] = useState<boolean>(false)
    
    const [isButtonDisabled, setIsButtonDisabled] = useState<boolean>(false)

    const handleUpdateIngredient = async () => {
        if(!name || !unitOfMeasure) {
            toast.error('Semua field harus diisi')
            return
        }
        setIsButtonDisabled(true)

        try {
            const payload = {
                name: name,
                stock: stock,
                unitOfMeasure: unitOfMeasure
            } as IFIngredient

            const create = await UseUpdateIngredient({data: payload, id: ingredientId})

            if (create) {
                setIsDoneUpdatingIngredient(true)
                setIsDialogCreateIngredientOpen(false)
                toast.success('Berhasil mengubah bahan baku')
            }
        } catch (error: any) {
            toast.error(error.message)
        }finally{
            setIsButtonDisabled(false)
        }
    }
    
    const fetchIngredient = async () => {
        try {
            const {data}: {data: ISIngredient} = await UseFetchFindOneIngredientById({id: ingredientId})

            setName(data.name)
            setUnitOfMeasure(data.unitOfMeasure)
        } catch (error) {
            console.log(error)
        }
    }

    useEffect(() => {
        if(ingredientId){
            fetchIngredient()
        }
    }, [ingredientId])

    return (
        <>
            <Dialog onOpenChange={setIsDialogCreateIngredientOpen} open={isDialogCreateIngredientOpen}>
                <DialogTrigger asChild>
                    <Button className='bg-yellow-500'><Pen /> Ubah</Button>
                </DialogTrigger>
                <DialogContent>
                    <DialogHeader>
                        <DialogTitle>Ubah</DialogTitle>
                    </DialogHeader>
                    <div className='flex flex-col gap-2'>
                        <Label>Nama Bahan</Label>
                        <Input type='text' value={name} onChange={(e) => setName(e.target.value)} placeholder='contoh : cabai' />
                    </div>
                    {/* <div className='flex flex-col gap-2'>
                        <Label>Stok</Label>
                        <Input type='text' value={stock} onChange={(e) => setStock(e.target.value)} placeholder='contoh : 1' />
                    </div> */}
                    <div className='flex flex-col gap-2'>
                        <Label>Satuan</Label>
                        <Select value={unitOfMeasure} onValueChange={(value) => setUnitOfMeasure(value as UnitOfMeasureEnum)}>
                            <SelectTrigger>
                                <SelectValue placeholder="Pilih Satuan" />
                            </SelectTrigger>
                            <SelectContent>
                                <SelectGroup>
                                    <SelectItem value='G'>Gram</SelectItem>
                                    <SelectItem value='ML'>Mili liter</SelectItem>
                                    <SelectItem value='PCS'>Pieces</SelectItem>
                                </SelectGroup>
                            </SelectContent>
                        </Select>
                    </div>
                    <div>
                        <Button className='w-full' onClick={() => handleUpdateIngredient()} disabled={isButtonDisabled}>Submit</Button>
                    </div>
                </DialogContent>
            </Dialog>
        </>
    )
}

export default UpdateIngredient