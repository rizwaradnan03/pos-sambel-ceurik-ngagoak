"use client"

import CreateCategory from '@/components/dialog/category/create-category'
import AddStockIngredient from '@/components/dialog/ingredient/add-stock-ingredient'
import CreateIngredient from '@/components/dialog/ingredient/create-ingredient'
import CreateProduct from '@/components/dialog/product/create-product'
import { Button } from '@/components/ui/button'
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger } from '@/components/ui/dialog'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { Table, TableBody, TableHead, TableHeader, TableRow } from '@/components/ui/table'
import { UseFetchFindManyCategory } from '@/hooks/api/category/findMany'
import { UseFetchFindManyIngredients } from '@/hooks/api/ingredient/findMany'
import { UseFetchFindManyProduct } from '@/hooks/api/product/findMany'
import { ISCategory } from '@/interfaces/schema-interface'
import { Plus } from 'lucide-react'
import React, { useEffect, useState } from 'react'
import toast from 'react-hot-toast'

const page = () => {
    const [categories, setCategories] = useState<ISCategory[] | undefined>(undefined)

    const [isDoneCreatingCategory, setIsDoneCreatingCategory] = useState<boolean>(false)

    const fetchCategory = async () => {
        try {
            const fetch = await UseFetchFindManyCategory()

            setCategories(fetch.data)
        } catch (error: any) {
            toast.error(error.message)
        }
    }

    useEffect(() => {
        fetchCategory()
    }, [isDoneCreatingCategory])

    return (
        <div className="w-full bg-white rounded-sm p-4 flex flex-col gap-4">
          {/* Header */}
          <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center">
            <h1 className="font-bold text-xl tracking-wide">Kategori</h1>
            <div className="flex flex-wrap gap-3 mt-3 sm:mt-0">
              <CreateCategory setIsDoneCreatingCategory={setIsDoneCreatingCategory} />
            </div>
          </div>
    
          {/* Tabel Responsif */}
          <div className="overflow-x-auto">
            <Table className="min-w-[600px]">
              <TableHeader>
                <TableRow>
                  <TableHead>No</TableHead>
                  <TableHead>Judul</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {categories?.map((category, index) => (
                  <TableRow key={category.id}>
                    <TableHead>{index + 1}</TableHead>
                    <TableHead>{category.title}</TableHead>
                  </TableRow>
                ))}
              </TableBody>
            </Table>
          </div>
        </div>
      );
}

export default page