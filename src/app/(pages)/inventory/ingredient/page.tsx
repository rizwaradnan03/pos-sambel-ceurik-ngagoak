"use client"

import AddStockIngredient from '@/components/dialog/ingredient/add-stock-ingredient'
import CreateIngredient from '@/components/dialog/ingredient/create-ingredient'
import { Button } from '@/components/ui/button'
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger } from '@/components/ui/dialog'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { Table, TableBody, TableHead, TableHeader, TableRow } from '@/components/ui/table'
import { UseFetchFindManyIngredients } from '@/hooks/api/ingredient/findMany'
import { ISIngredient } from '@/interfaces/schema-interface'
import { Plus } from 'lucide-react'
import React, { useEffect, useState } from 'react'
import toast from 'react-hot-toast'

const StockPage = () => {
  const [ingredients, setIngredients] = useState<ISIngredient[] | undefined>(undefined)

  const [isDoneCreatingIngredient, setIsDoneCreatingIngredient] = useState<boolean>(false)
  const [isDoneAddingIngredientStock, setIsDoneAddingIngredientStock] = useState<boolean>(false)

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
  }, [isDoneCreatingIngredient])

  return (
    <>
      <div className='w-full bg-white rounded-sm p-4 flex flex-col gap-4'>
        <div className='flex flex-row justify-between'>
          <div className=''>
            <h1 className='font-bold text-xl tracking-wide'>Ingredients</h1>
          </div>
          <div className='flex flex-row gap-3'>
            <AddStockIngredient setIsDoneAddingIngredientStock={setIsDoneAddingIngredientStock} />

            <CreateIngredient setIsDoneCreating={setIsDoneCreatingIngredient} />
          </div>
        </div>
        <div>
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead>No</TableHead>
                <TableHead>Nama</TableHead>
                <TableHead>Stock</TableHead>
                <TableHead>Satuan</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {ingredients?.map((ingredient, index) => (
                <TableRow key={ingredient.id}>
                  <TableHead>{index + 1}</TableHead>
                  <TableHead>{ingredient.name}</TableHead>
                  <TableHead>{ingredient.stock}</TableHead>
                  <TableHead>{ingredient.unitOfMeasure}</TableHead>
                </TableRow>
              ))}
            </TableBody>
          </Table>
        </div>
      </div>
    </>
  )
}

export default StockPage