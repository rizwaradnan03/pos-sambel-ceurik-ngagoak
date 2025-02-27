import { Button } from '@/components/ui/button';
import { Dialog, DialogContent, DialogHeader, DialogTrigger } from '@/components/ui/dialog';
import { Label } from '@/components/ui/label';
import MultipleSelector, { Option } from '@/components/ui/multiple-selector';
import { UseFetchFindManyCategory } from '@/hooks/api/category/findMany';
import { UseSaveProductCategory } from '@/hooks/api/product-category/save';
import { IFProductCategory } from '@/interfaces/form-interface';
import { ISCategory } from '@/interfaces/schema-interface';
import { DialogTitle } from '@radix-ui/react-dialog';
import { Pencil } from 'lucide-react';
import React, { useEffect, useState } from 'react';

const ProductCategory = ({ productId, setIsDoneUpdatingProductCategory }: { 
    productId: string; 
    setIsDoneUpdatingProductCategory: (value: boolean) => void; 
}) => {
    const [isDialogProductCategoryOpen, setIsDialogProductCategoryOpen] = useState<boolean>(false);
    const [dataCategory, setDataCategory] = useState<Option[]>([]);
    const [selectedCategories, setSelectedCategories] = useState<Option[]>([]);
    const [loading, setLoading] = useState<boolean>(false);
    const [error, setError] = useState<string | null>(null);

    useEffect(() => {
        const fetchCategories = async () => {
            setLoading(true);
            setError(null);
            try {
                const fetch = await UseFetchFindManyCategory();
                const data: ISCategory[] = fetch.data;

                if (!Array.isArray(data)) {
                    throw new Error("Data fetched is not an array");
                }

                let dataMap: Option[] = []

                for(let i = 0;i < data.length;i++){
                    if(data[i].ProductCategory){
                        let isFound = false
                        for(let j = 0;j < data[i].ProductCategory!.length; j++){
                            if(data[i].ProductCategory![j].productId! === productId){
                                isFound = true
                            }
                        }
                        if(!isFound){
                            dataMap.push({
                                label: data[i].title,
                                value: data[i].id!
                            })
                        }
                    }
                }

                setDataCategory(dataMap);
            } catch (err) {
                console.error("Error fetching categories:", err);
                setError("Failed to fetch categories.");
            } finally {
                setLoading(false);
            }
        };

        fetchCategories();
    }, []);

    const handleSave = async () => {
        try {
            const payload = {
                productId: productId,
                selectedCategories: selectedCategories
            } as IFProductCategory

            const save = await UseSaveProductCategory({data: payload})
            
            setIsDoneUpdatingProductCategory(true);
            setIsDialogProductCategoryOpen(false);
        } catch (err) {
            console.error("Error saving categories:", err);
        }
    };

    console.log("selectedd ", selectedCategories)

    return (
        <Dialog onOpenChange={setIsDialogProductCategoryOpen} open={isDialogProductCategoryOpen}>
            <DialogTrigger asChild>
                <Button><Pencil /> Kategori</Button>
            </DialogTrigger>
            <DialogContent>
                <DialogHeader>
                    <DialogTitle>Kategori Produk</DialogTitle>
                </DialogHeader>
                {loading ? (
                    <p>Loading...</p>
                ) : error ? (
                    <p className="text-red-500">{error}</p>
                ) : (
                    <div className="flex flex-col gap-2">
                        <Label>Kategori Produk</Label>
                        <MultipleSelector 
                            defaultOptions={dataCategory} 
                            placeholder="Pilih Produk Kategori" 
                            // selectedValues={selectedCategories} 
                            onChange={setSelectedCategories} 
                        />
                        <Button onClick={handleSave} className="mt-2">Simpan</Button>
                    </div>
                )}
            </DialogContent>
        </Dialog>
    );
};

export default ProductCategory;
