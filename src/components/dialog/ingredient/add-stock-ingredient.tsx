import { Button } from '@/components/ui/button'
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger } from '@/components/ui/dialog'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { Select, SelectContent, SelectGroup, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select'
import { UseCreateIngredientPurchase } from '@/hooks/api/ingredient-purchase/create'
import { UseCreateIngredient } from '@/hooks/api/ingredient/create'
import { UseFetchFindManyIngredients } from '@/hooks/api/ingredient/findMany'
import { IFIngredient, IFIngredientPurchase } from '@/interfaces/form-interface'
import { ISIngredient, UnitOfMeasureEnum } from '@/interfaces/schema-interface'
import { Plus } from 'lucide-react'
import React, { useEffect, useState } from 'react'
import toast from 'react-hot-toast'

const AddStockIngredient = ({ setIsDoneAddingIngredientStock }: { setIsDoneAddingIngredientStock: (value: boolean) => void }) => {
  const [ingredients, setIngredients] = useState<ISIngredient[] | undefined>(undefined)
  const [selectedIngredient, setSelectedIngredient] = useState<ISIngredient | undefined>(undefined)
  const [quantity, setQuantity] = useState<string | undefined>(undefined)
  const [totalCost, setTotalCost] = useState<string | undefined>(undefined)

  const [isDialogAddStockIngredientOpen, setIsDialogAddStockIngredientOpen] = useState<boolean>(false)

  const fetchIngredient = async () => {
    try {
      const fetch = await UseFetchFindManyIngredients()

      setIngredients(fetch.data)
    } catch (error: any) {
      toast.error(error.message)
    }
  }

  useEffect(() => {
    fetchIngredient()
  }, [])

  const handleAddIngredientStock = async () => {
    try {
      const payload = {
        ingredientId: selectedIngredient?.id,
        quantity: Number(quantity),
        pricePerUnit: Number(totalCost),
        totalCost: Number(totalCost) * Number(quantity)
      } as IFIngredientPurchase

      const create = await UseCreateIngredientPurchase({data: payload})

      setIsDoneAddingIngredientStock(true)
      setIsDialogAddStockIngredientOpen(false)
      toast.success('Berhasil menambahkan stok bahan baku')

    } catch (error: any) {
      toast.error(error.message)
    }finally{
      setIsDoneAddingIngredientStock(false)
    }
  }

  return (
    <Dialog onOpenChange={setIsDialogAddStockIngredientOpen} open={isDialogAddStockIngredientOpen}>
      <DialogTrigger asChild>
        <Button><Plus /> Stok Bahan</Button>
      </DialogTrigger>
      <DialogContent>
        <DialogHeader>
          <DialogTitle>Tambah Stok Bahan Baku</DialogTitle>
        </DialogHeader>
        <div className='flex flex-col gap-2'>
          <Label>Bahan</Label>
          <Select value={selectedIngredient?.id} onValueChange={(value) => {
                const ingredient = ingredients?.find((ing) => ing.id === value);
                setSelectedIngredient(ingredient! || null);
              }}>
            <SelectTrigger>
              <SelectValue placeholder="Pilih Bahan Baku" />
            </SelectTrigger>
            <SelectContent>
              <SelectGroup>
                {ingredients?.map((ingredient) => (
                  <SelectItem key={ingredient.id} value={ingredient.id}>({ingredient.unitOfMeasure}) {ingredient.name}</SelectItem>
                ))}
              </SelectGroup>
            </SelectContent>
          </Select>
        </div>
        <div className='flex flex-col gap-2'>
          <Label>Kuantity</Label>
          <Input type='text' value={quantity} onChange={(e) => setQuantity(e.target.value)} placeholder='contoh : 1' />
        </div>
        <div className='flex flex-col gap-2'>
          <Label>Harga Pembelian</Label>
          <Input type='text' value={totalCost} onChange={(e) => setTotalCost(e.target.value)} placeholder='10.000' />
        </div>
        <div>
          <Button className='w-full' onClick={() => handleAddIngredientStock()}>Submit</Button>
        </div>
      </DialogContent>
    </Dialog>
  )
}

export default AddStockIngredient