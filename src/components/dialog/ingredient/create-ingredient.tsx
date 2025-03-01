import { Button } from '@/components/ui/button'
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger } from '@/components/ui/dialog'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { Select, SelectContent, SelectGroup, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select'
import { UseCreateIngredient } from '@/hooks/api/ingredient/create'
import { IFIngredient } from '@/interfaces/form-interface'
import { UnitOfMeasureEnum } from '@/interfaces/schema-interface'
import { Plus } from 'lucide-react'
import React, { useState } from 'react'
import toast from 'react-hot-toast'

const CreateIngredient = ({ setIsDoneCreating }: { setIsDoneCreating: (value: boolean) => void }) => {
    const [name, setName] = useState<string | undefined>(undefined)
    const [stock, setStock] = useState<number>(0)
    const [unitOfMeasure, setUnitOfMeasure] = useState<UnitOfMeasureEnum | undefined>(undefined)

    const [isDialogCreateIngredientOpen, setIsDialogCreateIngredientOpen] = useState<boolean>(false)
    
    const [isButtonDisabled, setIsButtonDisabled] = useState<boolean>(false)

    const handleCreateIngredient = async () => {
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

            const create = await UseCreateIngredient({data: payload})

            if (create) {
                setIsDoneCreating(true)
                setIsDialogCreateIngredientOpen(false)
                toast.success('Berhasil menambahkan bahan baku')
            }
        } catch (error: any) {
            toast.error(error.message)
        }finally{
            setIsButtonDisabled(false)
        }
    }
    
    return (
        <>
            <Dialog onOpenChange={setIsDialogCreateIngredientOpen} open={isDialogCreateIngredientOpen}>
                <DialogTrigger asChild>
                    <Button><Plus /> Tambah Bahan</Button>
                </DialogTrigger>
                <DialogContent>
                    <DialogHeader>
                        <DialogTitle>Tambah Bahan Baku</DialogTitle>
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
                        <Button className='w-full' onClick={() => handleCreateIngredient()} disabled={isButtonDisabled}>Submit</Button>
                    </div>
                </DialogContent>
            </Dialog>
        </>
    )
}

export default CreateIngredient