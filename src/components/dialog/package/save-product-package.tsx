import { Button } from '@/components/ui/button';
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger } from '@/components/ui/dialog';
import { Label } from '@/components/ui/label';
import MultipleSelector, { Option } from '@/components/ui/multiple-selector';
import { UseFetchFindManyProduct } from '@/hooks/api/product/findMany';
import { ISProduct } from '@/interfaces/schema-interface';
import { Plus } from 'lucide-react';
import React, { useEffect, useState } from 'react';
import { IFProductPackage } from '@/interfaces/form-interface';
import { UseSavePackageItem } from '@/hooks/api/package-item/save';

const SaveProductPackage = ({ packageId }: { packageId: string }) => {
    const [isDialogOpen, setIsDialogOpen] = useState<boolean>(false);
    const [dataProduct, setDataProduct] = useState<Option[]>([]);
    const [selectedProducts, setSelectedProducts] = useState<Option[]>([]);
    const [loading, setLoading] = useState<boolean>(false);
    const [error, setError] = useState<string | null>(null);

    useEffect(() => {
        const fetchProducts = async () => {
            setLoading(true);
            setError(null);
            try {
                const fetch = await UseFetchFindManyProduct();
                const data: ISProduct[] = fetch.data;

                if (!Array.isArray(data)) {
                    throw new Error("Data fetched is not an array");
                }

                const productOptions = data.map(product => ({
                    label: product.name,
                    value: product.id
                }));

                setDataProduct(productOptions);
            } catch (err) {
                console.error("Error fetching products:", err);
                setError("Failed to fetch products.");
            } finally {
                setLoading(false);
            }
        };

        fetchProducts();
    }, []);

    const handleSave = async () => {
        try {
            const payload = {
                packageId,
                selectedProducts: selectedProducts
            } as IFProductPackage
            await UseSavePackageItem({data: payload})

            setIsDialogOpen(false);
        } catch (err) {
            console.error("Error saving package:", err);
        }
    };

    return (
        <Dialog onOpenChange={setIsDialogOpen} open={isDialogOpen}>
            <DialogTrigger asChild>
                <Button><Plus /> List Produk</Button>
            </DialogTrigger>
            <DialogContent>
                <DialogHeader>
                    <DialogTitle>Tambah Produk ke Paket</DialogTitle>
                </DialogHeader>
                {loading ? (
                    <p>Loading...</p>
                ) : error ? (
                    <p className="text-red-500">{error}</p>
                ) : (
                    <div className="flex flex-col gap-2">
                        <Label>Pilih Produk</Label>
                        <MultipleSelector 
                            defaultOptions={dataProduct} 
                            placeholder="Pilih Produk"
                            selectedValues={selectedProducts}
                            onChange={setSelectedProducts}
                        />
                        <Button className="mt-2 w-full" onClick={handleSave}>Simpan</Button>
                    </div>
                )}
            </DialogContent>
        </Dialog>
    );
};

export default SaveProductPackage;
