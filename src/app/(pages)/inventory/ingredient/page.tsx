"use client";

import AddStockIngredient from "@/components/dialog/ingredient/add-stock-ingredient";
import CreateIngredient from "@/components/dialog/ingredient/create-ingredient";
import UpdateIngredient from "@/components/dialog/ingredient/update-ingredient";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { UseFetchFindManyIngredients } from "@/hooks/api/ingredient/findMany";
import { UseFetch } from "@/hooks/use-fetch";
import { ISIngredient } from "@/interfaces/schema-interface";
import React, { useState } from "react";

const StockPage = () => {
  const [isDoneCreatingIngredient, setIsDoneCreatingIngredient] = useState<boolean>(false);
  const [isDoneAddingIngredientStock, setIsDoneAddingIngredientStock] = useState<boolean>(false);
  const [isDoneUpdatingIngredient, setIsDoneUpdatingIngredient] = useState<boolean>(false);

  const {data: dataIngredients} = UseFetch<ISIngredient[]>({key: "inventoryIngredients", dependencies: [], refetchDependencies: [{stateValue: isDoneCreatingIngredient, stateSetter: setIsDoneCreatingIngredient}, {stateValue: isDoneAddingIngredientStock, stateSetter: setIsDoneAddingIngredientStock}, {stateValue: isDoneUpdatingIngredient, stateSetter: setIsDoneUpdatingIngredient}], apiFunction: async () => {
    return await UseFetchFindManyIngredients()
  }})

  return (
    <div className="w-full bg-white rounded-sm p-4 flex flex-col gap-4">
      {/* Header */}
      <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center">
        <h1 className="font-bold text-xl tracking-wide">Bahan Baku</h1>
        <div className="flex flex-wrap gap-3 mt-3 sm:mt-0">
          <AddStockIngredient setIsDoneAddingIngredientStock={setIsDoneAddingIngredientStock} />
          <CreateIngredient setIsDoneCreating={setIsDoneCreatingIngredient} />
        </div>
      </div>

      {/* Tabel Responsif */}
      <div className="overflow-x-auto">
        <Table className="min-w-[600px]">
          <TableHeader>
            <TableRow>
              <TableHead>No</TableHead>
              <TableHead>Nama</TableHead>
              <TableHead>Stock</TableHead>
              <TableHead>Satuan</TableHead>
              <TableHead>Aksi</TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {dataIngredients?.map((ingredient, index) => (
              <TableRow key={ingredient.id}>
                <TableCell>{index + 1}</TableCell>
                <TableCell>{ingredient.name}</TableCell>
                <TableCell>{ingredient.stock}</TableCell>
                <TableCell>{ingredient.unitOfMeasure}</TableCell>
                <TableCell><UpdateIngredient ingredientId={ingredient.id as string} setIsDoneUpdatingIngredient={setIsDoneUpdatingIngredient} /></TableCell>
              </TableRow>
            ))}
          </TableBody>
        </Table>
      </div>
    </div>
  );
};

export default StockPage;
