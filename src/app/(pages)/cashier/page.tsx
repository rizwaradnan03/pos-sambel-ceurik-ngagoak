"use client"

import { ScrollArea } from "@/components/ui/scroll-area"
import { Separator } from "@/components/ui/separator"
import { Button } from "@/components/ui/button"
import { Card, CardContent } from "@/components/ui/card"
import { Sheet, SheetContent, SheetTrigger } from "@/components/ui/sheet"
import { PlusCircle, ShoppingCart, Menu, Minus } from "lucide-react"
import { useEffect, useState } from "react"
import { ISCategory, ISProduct } from "@/interfaces/schema-interface"
import { IFCartItem } from "@/interfaces/form-interface"
import toast from "react-hot-toast"
import { UseFetchFindManyProduct } from "@/hooks/api/product/findMany"
import { UseFetchFindManyProductByCategoryId } from "@/hooks/api/product/findManyByCategoryId"
import { UseFetchFindManyCategory } from "@/hooks/api/category/findMany"
import { formatPrice } from "@/lib/number"
import Image from "next/image"
import CashierPay from "@/components/dialog/pay/cashier-pay"
import { ICItem } from "@/interfaces/custom-interface"

export default function ResponsiveCashierPage() {
  const [selectedCategories, setSelectedCategories] = useState<ISCategory>({id: "all", title: "Semua"})
  const [categories, setCategories] = useState<ISCategory[] | undefined>(undefined)
  const [cart, setCart] = useState<IFCartItem[]>([])
  const [filteredItem, setFilteredItem] = useState<ICItem[] | undefined>(undefined)
  const [totalPrice, setTotalPrice] = useState<number>(0)

  const fetchFilteredProduct = async () => {
    try {
      if(selectedCategories.id == "all"){
        const fetch = await UseFetchFindManyProduct()
        setFilteredItem(fetch.data)
      }else{
        const fetch = await UseFetchFindManyProductByCategoryId({categoryId: selectedCategories.id as string})
        setFilteredItem(fetch.data)
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

      setCategories([{id: "all", title: "Semua"}, ...fetch.data])
    } catch (error) {
      toast.error("Gagal Melakukan Fetching Kategori")
    }
  }

  useEffect(() => {
    fetchCategory()
  }, [])

  const handleAddToCart = ({product}: {product: ISProduct}) => {
    let newCart = [...cart]

    let isFound = false
    for(let i = 0;i < newCart.length;i++){
      if(newCart[i].id == product.id){
        isFound = true
        newCart[i].quantity++
      }
    }

    if(!isFound){
      setCart([...newCart, {id: product.id as string, name: product.name, price: product.price, quantity: 1}])
    }else{
      setCart(newCart)
    }
  }

  useEffect(() => {
    let price = 0
    for(let i = 0;i < cart.length;i++){
      price += cart[i].price * cart[i].quantity
    }
    setTotalPrice(price)
  }, [cart])

  const handleDecrementQuantity = ({productId}: {productId: string}) => {
    let newCart = [...cart]

    for(let i = 0;i < newCart.length;i++){
      if(newCart[i].id == productId){
        newCart[i].quantity--

        if(newCart[i].quantity == 0){
          newCart.splice(i, 1)
        }

        break
      }
    }

    setCart(newCart)
  }

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
      <div className="w-full lg:w-1/4 bg-white lg:shadow-xl p-4 lg:p-6 flex flex-col">
        <h2 className="text-2xl lg:text-3xl font-bold mb-6 text-red-800 flex items-center">
          <ShoppingCart className="mr-2 h-6 w-6 lg:h-8 lg:w-8" /> Keranjang
        </h2>
        <ScrollArea className="flex-grow mb-6">
          <div className="space-y-4">
            {cart?.map((product) => (
              <div key={product.id} className="flex justify-between items-center bg-red-50 p-3 rounded-lg">
                <span className="text-red-800 font-medium">{product.name}</span>
                <span className="text-red-600 font-bold">Rp {formatPrice({value: product.price.toString()})}</span>
                <span className="text-red-600 font-bold">({product.quantity})</span>
                <Button onClick={() => handleDecrementQuantity({productId: product.id})}>
                <Minus />
                </Button>
              </div>
            ))}
          </div>
        </ScrollArea>
        <Separator className="my-4 bg-red-200" />
        <div className="flex justify-between items-center mb-6">
          <span className="text-xl lg:text-2xl font-bold text-red-800">Total:</span>
          <span className="text-xl lg:text-2xl font-bold text-red-600">Rp {formatPrice({value: totalPrice.toString()})}</span>
        </div>
        <CashierPay cart={cart} totalPrice={totalPrice} />
      </div>
    </div>
  )
}

