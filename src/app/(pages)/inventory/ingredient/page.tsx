"use client";

import AddStockIngredient from "@/components/dialog/ingredient/add-stock-ingredient";
import CreateIngredient from "@/components/dialog/ingredient/create-ingredient";
import { Table, TableBody, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { UseFetchFindManyIngredients } from "@/hooks/api/ingredient/findMany";
import { ISIngredient } from "@/interfaces/schema-interface";
import React, { useEffect, useState } from "react";
import toast from "react-hot-toast";

const StockPage = () => {
  const [ingredients, setIngredients] = useState<ISIngredient[] | undefined>(undefined);
  const [isDoneCreatingIngredient, setIsDoneCreatingIngredient] = useState<boolean>(false);
  const [isDoneAddingIngredientStock, setIsDoneAddingIngredientStock] = useState<boolean>(false);

  const fetchIngredient = async () => {
    try {
      const fetch = await UseFetchFindManyIngredients();
      setIngredients(fetch.data);
    } catch (error: any) {
      toast.error(error.message);
    }
  };

  useEffect(() => {
    fetchIngredient();
  }, [isDoneCreatingIngredient, isDoneAddingIngredientStock]); // Fetch ulang jika ada perubahan

  return (
    <div className="w-full bg-white rounded-sm p-4 flex flex-col gap-4">
      {/* Header */}
      <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center">
        <h1 className="font-bold text-xl tracking-wide">Ingredients</h1>
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
  );
};

export default StockPage;
