import { Button } from '@/components/ui/button'
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger } from '@/components/ui/dialog'
import { Label } from '@/components/ui/label'
import MultipleSelector, { Option } from '@/components/ui/multiple-selector'
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table'
import { UseSaveCategoryItem } from '@/hooks/api/category/save'
import { UseFetchFindManyPackageByCategoryId } from '@/hooks/api/package/findManyByCategoryId'
import { UseFetchFindManyPackageNotByCategoryId } from '@/hooks/api/package/findManyNotByCategoryId'
import { UseFetchFindManyProductByCategoryId } from '@/hooks/api/product/findManyByCategoryId'
import { UseFetchFindManyProductNotByCategoryId } from '@/hooks/api/product/findManyNotByCategoryId'
import { ICCategoryItem } from '@/interfaces/custom-interface'
import { IFCategorySave } from '@/interfaces/form-interface'
import { ISPackage, ISProduct } from '@/interfaces/schema-interface'
import { Plus } from 'lucide-react'
import React, { useEffect, useState } from 'react'
import toast from 'react-hot-toast'

const SaveCategory = ({ categoryId }: { categoryId: string }) => {
    const [selectedItem, setSelectedItem] = useState<Option[] | undefined>(undefined)
    const [notFilteredItems, setNotFilteredItems] = useState<Option[] | undefined>(undefined)
    const [filteredItems, setFilteredItems] = useState<ICCategoryItem[] | undefined>(undefined)

    const [isSaveCategoryDialogOpen, setIsSaveCategoryDialogOpen] = useState<boolean>(false)
    const [isDoneSaveCategory,setIsDoneSaveCategory] = useState<boolean>(false)

    const fetchNotFilteredItem = async () => {
        try {
            const fetchProduct = await UseFetchFindManyProductNotByCategoryId({ categoryId: categoryId })
            const fetchPackage = await UseFetchFindManyPackageNotByCategoryId({ categoryId: categoryId })

            const addingNewObjectForProduct = fetchProduct.data.map((product: ISProduct) => {
                return {
                    value: product.id,
                    label: product.name,
                    // ...product,
                    category: "PRODUCT"
                }
            })

            const addingNewObjectForPackage = fetchPackage.data.map((pkg: ISPackage) => {
                return {
                    value: pkg.id,
                    label: pkg.name,
                    category: "PACKAGE"
                }
            })

            setNotFilteredItems([...addingNewObjectForProduct, ...addingNewObjectForPackage])
        } catch (error: any) {
            toast.error(error.message)
        }
    }

    const fetchFilteredItem = async () => {
        try {
            const fetchProduct = await UseFetchFindManyProductByCategoryId({ categoryId: categoryId })
            const fetchPackage = await UseFetchFindManyPackageByCategoryId({ categoryId: categoryId })

            const addingNewObjectForProduct = fetchProduct.data.map((product: ISProduct) => {
                return {
                    ...product,
                    category: "PRODUCT"
                }
            })

            const addingNewObjectForPackage = fetchPackage.data.map((pkg: ISPackage) => {
                return {
                    ...pkg,
                    category: "PACKAGE"
                }
            })

            setFilteredItems([...addingNewObjectForProduct, ...addingNewObjectForPackage])
        } catch (error: any) {
            toast.error(error.message)
        }
    }

    useEffect(() => {
        fetchFilteredItem()
        fetchNotFilteredItem()
    }, [categoryId])

    useEffect(() => {
        if(isDoneSaveCategory == true){
            fetchFilteredItem()
            fetchNotFilteredItem()
            setIsDoneSaveCategory(false)
        }
    }, [isDoneSaveCategory])

    const handleSave = async () => {
        try {
            const payload = {
                categoryId: categoryId,
                selectedItems: selectedItem
            } as IFCategorySave
            await UseSaveCategoryItem({data: payload})

            setSelectedItem(undefined)
            setIsDoneSaveCategory(true)
            toast.success("Berhasil menambahkan item kepada kategori!")
        } catch (error: any) {
            toast.error(error.message)
        }
    }

    return (
        <Dialog onOpenChange={setIsSaveCategoryDialogOpen} open={isSaveCategoryDialogOpen}>
            <DialogTrigger asChild>
                <Button><Plus /> List Produk</Button>
            </DialogTrigger>
            <DialogContent>
                <DialogHeader>
                    <DialogTitle>Tambah Produk ke Paket</DialogTitle>
                </DialogHeader>
                <div className="flex flex-col gap-2">
                    <Label>Pilih Produk</Label>
                    {notFilteredItems ? (
                        <MultipleSelector
                            defaultOptions={notFilteredItems}
                            placeholder="Pilih Produk"
                            onChange={setSelectedItem}
                        />
                    ) : null}
                    <Button className="mt-2 w-full" onClick={() => handleSave()}>Simpan</Button>
                </div>
                <Table>
                    <TableHeader>
                        <TableRow>
                            <TableHead>No</TableHead>
                            <TableHead>Nama Item</TableHead>
                        </TableRow>
                    </TableHeader>
                    <TableBody>
                        {filteredItems?.map((item, index) => (
                            <TableRow key={index + 1}>
                                <TableCell>{index + 1}</TableCell>
                                <TableCell>{item.name}</TableCell>
                            </TableRow>
                        ))}
                    </TableBody>
                </Table>
            </DialogContent>
        </Dialog>
    )
}

export default SaveCategory