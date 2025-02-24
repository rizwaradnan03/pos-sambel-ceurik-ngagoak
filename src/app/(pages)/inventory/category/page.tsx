"use client";

import CreateCategory from '@/components/dialog/category/create-category'
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table'
import { UseFetchFindManyCategory } from '@/hooks/api/category/findMany'
import { UseFetch } from '@/hooks/use-fetch'
import { ISCategory } from '@/interfaces/schema-interface'
import React, {useState } from 'react'
import toast from 'react-hot-toast'

const page = () => {
    const [isDoneCreatingCategory, setIsDoneCreatingCategory] = useState<boolean>(false)

    const {data: dataCategories} = UseFetch<ISCategory[]>({key: "inventoryCategories", dependencies: [], refetchDependencies: [{stateValue: isDoneCreatingCategory, stateSetter: setIsDoneCreatingCategory}], apiFunction: async () => {
        let data: ISCategory[] = await UseFetchFindManyCategory()
        data.unshift({id: "all", title: "Semua"} as ISCategory)

        return data
    }})

    console.log("data kategori ", dataCategories)

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
                {dataCategories?.map((category, index) => (
                  <TableRow key={category.id}>
                    <TableCell>{index + 1}</TableCell>
                    <TableCell>{category.title}</TableCell>
                  </TableRow>
                ))}
              </TableBody>
            </Table>
          </div>
        </div>
      );
}

export default page