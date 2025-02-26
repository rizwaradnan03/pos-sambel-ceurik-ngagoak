import { Button } from '@/components/ui/button';
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger } from '@/components/ui/dialog';
import { Label } from '@/components/ui/label';
import MultipleSelector, { Option } from '@/components/ui/multiple-selector';
import { UseFetchFindManyProduct } from '@/hooks/api/product/findMany';
import { ISPackageItem, ISProduct } from '@/interfaces/schema-interface';
import { Plus } from 'lucide-react';
import React, { useEffect, useState } from 'react';
import { IFProductPackage } from '@/interfaces/form-interface';
import { UseSavePackageItem } from '@/hooks/api/package-item/save';
import { UseFetchFindManyProductNotByPackageId } from '@/hooks/api/package/findManyNotByPackageId';
import { UseFetchFindManyPackageItemByPackageId } from '@/hooks/api/package-item/findManyByPackageId';
import toast from 'react-hot-toast';
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table';
import ChangePackageQuantity from './change-package-quantity';

const SaveProductPackage = ({ packageId }: { packageId: string }) => {
    const [packageItems, setPackageItems] = useState<ISPackageItem[] | undefined>(undefined)
    const [isDialogOpen, setIsDialogOpen] = useState<boolean>(false);
    const [dataProduct, setDataProduct] = useState<Option[]>([]);
    const [selectedProducts, setSelectedProducts] = useState<Option[]>([]);
    const [loading, setLoading] = useState<boolean>(false);
    const [error, setError] = useState<string | null>(null);

    const [isDoneSavingProductPackage, setIsDoneSavingProductPackage] = useState<boolean>(false)

    const fetchNotListedProduct = async () => {
        setLoading(true);
        setError(null);
        try {
            const fetch = await UseFetchFindManyProductNotByPackageId({packageId: packageId});
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
            setIsDoneSavingProductPackage(false)
        }
    };

    const fetchPackageItem = async () => {
        try {
            const fetch = await UseFetchFindManyPackageItemByPackageId({packageId: packageId})

            setPackageItems(fetch.data)
        } catch (error: any) {
            toast.error(error.message)
        }
    }

    useEffect(() => {
        fetchNotListedProduct();
        fetchPackageItem()
    }, [packageId, isDoneSavingProductPackage]);

    const handleSave = async () => {
        try {
            const payload = {
                packageId,
                selectedProducts: selectedProducts
            } as IFProductPackage
            await UseSavePackageItem({data: payload})

            toast.success("Berhasil menambahkan produk ke paket!")

            setIsDialogOpen(false);
            setIsDoneSavingProductPackage(true)
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
                            // selectedValues={selectedProducts}
                            onChange={setSelectedProducts}
                        />
                        <Button className="mt-2 w-full" onClick={handleSave}>Simpan</Button>
                    </div>
                )}
                <Table>
                    <TableHeader>
                        <TableRow>
                            <TableHead>No</TableHead>
                            <TableHead>Nama Produk</TableHead>
                            <TableHead>Jumlah</TableHead>
                            <TableHead>Ubah Jumlah</TableHead>
                        </TableRow>
                    </TableHeader>
                    <TableBody>
                        {packageItems?.map((packageItem, index) => (
                            <TableRow key={index + 1}>
                                <TableCell>{index + 1}</TableCell>
                                <TableCell>{packageItem.Product?.name}</TableCell>
                                <TableCell>{packageItem.quantity}</TableCell>
                                <TableCell><ChangePackageQuantity packageItemId={packageItem.id as string} /></TableCell>
                            </TableRow>
                        ))}
                    </TableBody>
                </Table>
            </DialogContent>
        </Dialog>
    );
};

export default SaveProductPackage;
