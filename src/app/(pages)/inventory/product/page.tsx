"use client"

import AddStockIngredient from '@/components/dialog/ingredient/add-stock-ingredient'
import CreateIngredient from '@/components/dialog/ingredient/create-ingredient'
import CreateProduct from '@/components/dialog/product/create-product'
import { Button } from '@/components/ui/button'
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger } from '@/components/ui/dialog'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { Table, TableBody, TableHead, TableHeader, TableRow } from '@/components/ui/table'
import { UseFetchFindManyIngredients } from '@/hooks/api/ingredient/findMany'
import { UseFetchFindManyProduct } from '@/hooks/api/product/findMany'
import { ISIngredient, ISProduct } from '@/interfaces/schema-interface'
import { Plus } from 'lucide-react'
import React, { useEffect, useState } from 'react'
import toast from 'react-hot-toast'

const page = () => {
    const [products, setProducts] = useState<ISProduct[] | undefined>(undefined)

    const [isDoneCreatingProduct, setIsDoneCreatingProduct] = useState<boolean>(false)

    const fetchProduct = async () => {
        try {
            const fetch = await UseFetchFindManyProduct()

            setProducts(fetch.data)
        } catch (error: any) {
            toast.error(error.message)
        }
    }

    useEffect(() => {
        fetchProduct()
    }, [isDoneCreatingProduct])

    return (
        <div className="w-full bg-white rounded-sm p-4 flex flex-col gap-4">
          {/* Header */}
          <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center">
            <h1 className="font-bold text-xl tracking-wide">Produk</h1>
            <div className="flex flex-wrap gap-3 mt-3 sm:mt-0">
              <CreateProduct setIsDoneCreatingProduct={setIsDoneCreatingProduct} />
            </div>
          </div>
    
          {/* Tabel Responsif */}
          <div className="overflow-x-auto">
            <Table className="min-w-[600px]">
              <TableHeader>
                <TableRow>
                  <TableHead>No</TableHead>
                  <TableHead>Nama</TableHead>
                  <TableHead>Harga</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {products?.map((product, index) => (
                  <TableRow key={product.id}>
                    <TableHead>{index + 1}</TableHead>
                    <TableHead>{product.name}</TableHead>
                    <TableHead>{product.price}</TableHead>
                  </TableRow>
                ))}
              </TableBody>
            </Table>
          </div>
        </div>
      );
}

export default page