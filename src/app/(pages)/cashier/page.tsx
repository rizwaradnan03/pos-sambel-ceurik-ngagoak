"use client"

import { ScrollArea } from "@/components/ui/scroll-area"
import { Separator } from "@/components/ui/separator"
import { Button } from "@/components/ui/button"
import { Card, CardContent } from "@/components/ui/card"
import { Sheet, SheetContent, SheetTrigger } from "@/components/ui/sheet"
import { PlusCircle, ShoppingCart, Menu, Minus, ListOrdered } from "lucide-react"
import { useEffect, useState } from "react"
import { ISCategory, ISOrder, ISPackage, ISProduct } from "@/interfaces/schema-interface"
import { IFCartItem } from "@/interfaces/form-interface"
import toast from "react-hot-toast"
import { UseFetchFindManyProduct } from "@/hooks/api/product/findMany"
import { UseFetchFindManyProductByCategoryId } from "@/hooks/api/product/findManyByCategoryId"
import { UseFetchFindManyCategory } from "@/hooks/api/category/findMany"
import { formatPrice } from "@/lib/number"
import Image from "next/image"
import CashierPay from "@/components/dialog/pay/cashier-pay"
import { ICCartItem } from "@/interfaces/custom-interface"
import { UseFetchFindManyPackage } from "@/hooks/api/package/findMany"
import { UseFetchFindManyPackageByCategoryId } from "@/hooks/api/package/findManyByCategoryId"
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table"
import { UseFetchFindManyOnProgressOrder } from "@/hooks/api/order/findManyOnProgress"
import CashierDonePay from "@/components/dialog/pay/cashier-done-pay"

export default function ResponsiveCashierPage() {
  const [selectedCategories, setSelectedCategories] = useState<ISCategory>({ id: "all", title: "Semua" })
  const [categories, setCategories] = useState<ISCategory[] | undefined>(undefined)
  const [cart, setCart] = useState<IFCartItem[]>([])
  const [filteredItem, setFilteredItem] = useState<ICCartItem[] | undefined>(undefined)
  const [totalPrice, setTotalPrice] = useState<number>(0)

  const [onProgressOrder, setOnProgressOrder] = useState<ISOrder[] | undefined>(undefined)

  const [isDoneCreatingOrder, setIsDoneCreatingOrder] = useState<boolean>(false)
  const [isOrderDonePay,setIsOrderDonePay] = useState<boolean>(false)

  const fetchFilteredProduct = async () => {
    try {
      if (selectedCategories.id == "all") {
        const fetchProduct = await UseFetchFindManyProduct()
        const fetchPackage = await UseFetchFindManyPackage()

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

        setFilteredItem([...addingNewObjectForProduct, ...addingNewObjectForPackage])
      } else {
        if (selectedCategories.category == "PRODUCT") {
          const fetchProduct = await UseFetchFindManyProductByCategoryId({ categoryId: selectedCategories.id as string })

          const addingNewObjectForProduct = fetchProduct.data.map((product: ISProduct) => {
            return {
              ...product,
              category: "PRODUCT"
            }
          })
          setFilteredItem(addingNewObjectForProduct)
        } else if (selectedCategories.category == "PACKAGE") {
          const fetchPackage = await UseFetchFindManyPackageByCategoryId({ categoryId: selectedCategories.id as string })

          const addingNewObjectForPackage = fetchPackage.data.map((pkg: ISPackage) => {
            return {
              ...pkg,
              category: "PACKAGE"
            }
          })
          setFilteredItem(addingNewObjectForPackage)
        }
      }
    } catch (error) {
      toast.error("Gagal Melakukan Fetching Menu")
    }
  }

  useEffect(() => {
    fetchFilteredProduct()
  }, [selectedCategories])

  const fetchCategory = async () => {
    try {
      const fetch = await UseFetchFindManyCategory()

      setCategories([{ id: "all", title: "Semua" }, ...fetch.data])
    } catch (error) {
      toast.error("Gagal Melakukan Fetching Kategori")
    }
  }

  useEffect(() => {
    fetchCategory()
    fetchOnProgressOrder()
  }, [])

  const handleAddToCart = ({ product }: { product: IFCartItem }) => {
    let newCart = [...cart]

    let isFound = false
    for (let i = 0; i < newCart.length; i++) {
      if (newCart[i].id == product.id) {
        isFound = true
        newCart[i].quantity++
      }
    }

    if (!isFound) {
      setCart([...newCart,
      {
        id: product.id as string, name: product.name, price: product.price, quantity: 1, category: product.category

      }])
    } else {
      setCart(newCart)
    }
  }

  // useEffect(() => {
  //   let price = 0
  //   for (let i = 0; i < cart.length; i++) {
  //     price += cart[i].price * cart[i].quantity
  //   }
  //   setTotalPrice(price)
  // }, [cart])

  const handleDecrementQuantity = ({ productId }: { productId: string }) => {
    let newCart = [...cart]

    for (let i = 0; i < newCart.length; i++) {
      if (newCart[i].id == productId) {
        newCart[i].quantity--

        if (newCart[i].quantity == 0) {
          newCart.splice(i, 1)
        }

        break
      }
    }

    setCart(newCart)
  }

  const fetchOnProgressOrder = async () => {
    try {
      const fetch = await UseFetchFindManyOnProgressOrder()

      setOnProgressOrder(fetch.data)
    } catch (error: any) {
      toast.error(error.message)
    }
  }

  const handleAfterCreatingOrder = async () => {
    fetchOnProgressOrder()
    setCart([])
    setIsDoneCreatingOrder(false)
  }

  useEffect(() => {
    if(isDoneCreatingOrder == true){
      handleAfterCreatingOrder()
    }
  }, [isDoneCreatingOrder])

  useEffect(() => {
    if(isOrderDonePay == true){
      fetchOnProgressOrder()
      setIsDoneCreatingOrder(false)
    }
  }, [isOrderDonePay])

  return (
    <div className="flex flex-col lg:flex-row h-screen bg-gradient-to-br from-red-50 to-red-100">
      <div className="w-full lg:w-3/4 p-4 lg:p-6 overflow-hidden flex flex-col">
        <div className="flex justify-between items-center lg:hidden mb-4">
          <h1 className="text-2xl font-bold text-red-800">Kasir</h1>
          <Sheet>
            <SheetTrigger asChild>
              <Button variant="outline" size="icon">
                <Menu className="h-6 w-6" />
              </Button>
            </SheetTrigger>
            <SheetContent side="left" className="w-[300px] sm:w-[400px]">
              <div className="py-4">
                <h2 className="text-2xl font-bold mb-4 text-red-800">Kategori</h2>
                <div className="grid grid-cols-2 gap-4">

                  {categories?.map((category) => (
                    <Button key={category.id} variant="outline" className="w-full justify-start" onClick={() => setSelectedCategories(category)}>
                      {category.title}
                    </Button>
                  ))}
                </div>
              </div>
            </SheetContent>
          </Sheet>
        </div>

        <div className="hidden lg:block mb-8">
          <h2 className="text-3xl font-bold mb-4 text-red-800">Kategori</h2>
          <ScrollArea className="whitespace-nowrap">
            <div className="flex space-x-4">
              {categories?.map((category) => (
                <Card key={category.id} className="inline-block bg-white hover:bg-red-50 transition-colors cursor-pointer" onClick={() => setSelectedCategories(category)}>
                  <CardContent className="py-2 px-4">
                    <span className="text-lg font-semibold text-red-700">{category.title}</span>
                  </CardContent>
                </Card>
              ))}
            </div>
          </ScrollArea>
        </div>

        {/* Products */}
        <h2 className="text-2xl lg:text-3xl font-bold mb-4 text-red-800">Menu</h2>
        <ScrollArea className="flex-grow">
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4 lg:gap-6">
            {filteredItem?.map((product) => (
              <Card key={product.id} className="bg-white overflow-hidden group hover:shadow-lg transition-shadow">
                <CardContent className="p-0">
                  <div className="relative w-full h-72"> {/* Tambahkan kelas "relative" & atur tinggi */}
                    <Image
                      src={product.image ? process.env.NEXT_PUBLIC_APP_URL + product.image : ""}
                      fill
                      className="object-cover"
                      alt="Gambar Produk"
                    />
                  </div>
                  <div className="p-4">
                    <h3 className="text-lg font-semibold text-red-800 mb-2">{product.name}</h3>
                    <p className="text-red-600 font-bold text-xl mb-4">
                      Rp {formatPrice({ value: product.price.toString() })}
                    </p>
                    <Button
                      className="w-full bg-red-500 hover:bg-red-600 transition-colors"
                      onClick={() => handleAddToCart({ product })}
                    >
                      <PlusCircle className="mr-2 h-4 w-4" /> Add To Cart
                    </Button>
                  </div>
                </CardContent>
              </Card>

            ))}
          </div>
        </ScrollArea>
      </div>

      {/* Cart */}
      <div className="w-full lg:w-1/4 lg:shadow-xl h-full flex flex-col">
        <div className="basis-1/4 w-full bg-white p-4 lg:p-6 flex flex-col">
          <h2 className="text-2xl lg:text-3xl font-bold mb-6 text-red-800 flex items-center">
            <ListOrdered className="mr-2 h-6 w-6 lg:h-8 lg:w-8" /> Order
          </h2>
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead>No</TableHead>
                <TableHead>Customer</TableHead>
                <TableHead>Total Bayar</TableHead>
                <TableHead>Aksi</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {onProgressOrder?.map((order, index) => (
                <TableRow key={index + 1}>
                  <TableCell>{index + 1}</TableCell>
                  <TableCell>{order.customer}</TableCell>
                  <TableCell>Rp{formatPrice({value: order.totalPrice.toString()})}</TableCell>
                  <TableCell><CashierDonePay setIsOrderDonePay={setIsOrderDonePay} orderId={order.id as string} /></TableCell>
                </TableRow>
              ))}
            </TableBody>
          </Table>
        </div>
        <div className="basis-3/4 w-full bg-white p-4 lg:p-6 flex flex-col">
          <h2 className="text-2xl lg:text-3xl font-bold mb-6 text-red-800 flex items-center">
            <ShoppingCart className="mr-2 h-6 w-6 lg:h-8 lg:w-8" /> Keranjang
          </h2>
          <ScrollArea className="flex-grow mb-6">
            <div className="space-y-4">
              {cart?.map((product) => (
                <div key={product.id} className="flex justify-between items-center bg-red-50 p-3 rounded-lg">
                  <span className="text-red-800 font-medium">{product.name}</span>
                  <span className="text-red-600 font-bold">Rp {formatPrice({ value: product.price.toString() })}</span>
                  <span className="text-red-600 font-bold">({product.quantity})</span>
                  <Button onClick={() => handleDecrementQuantity({ productId: product.id })}>
                    <Minus />
                  </Button>
                </div>
              ))}
            </div>
          </ScrollArea>
          <Separator className="my-4 bg-red-200" />
          <div className="flex justify-between items-center mb-6">
            <span className="text-xl lg:text-2xl font-bold text-red-800">Total:</span>
            <span className="text-xl lg:text-2xl font-bold text-red-600">Rp {formatPrice({ value: totalPrice.toString() })}</span>
          </div>
          <CashierPay setTotalPrice={setTotalPrice} setIsDoneCreatingOrder={setIsDoneCreatingOrder} cart={cart} totalPrice={totalPrice} />
        </div>
      </div>

    </div>
  )
}

