import { ScrollArea } from "@/components/ui/scroll-area"
import { Separator } from "@/components/ui/separator"
import { Button } from "@/components/ui/button"
import { Card, CardContent } from "@/components/ui/card"
import { Sheet, SheetContent, SheetTrigger } from "@/components/ui/sheet"
import { PlusCircle, ShoppingCart, Menu } from "lucide-react"

export default function ResponsiveCashierPage() {
  return (
    <div className="flex flex-col lg:flex-row h-screen bg-gradient-to-br from-red-50 to-red-100">
      <div className="w-full lg:w-3/4 p-4 lg:p-6 overflow-hidden flex flex-col">
        <div className="flex justify-between items-center lg:hidden mb-4">
          <h1 className="text-2xl font-bold text-red-800">Cashier</h1>
          <Sheet>
            <SheetTrigger asChild>
              <Button variant="outline" size="icon">
                <Menu className="h-6 w-6" />
              </Button>
            </SheetTrigger>
            <SheetContent side="left" className="w-[300px] sm:w-[400px]">
              <div className="py-4">
                <h2 className="text-2xl font-bold mb-4 text-red-800">Categories</h2>
                <div className="grid grid-cols-2 gap-4">
                  {["All", "Food", "Drinks", "Desserts"].map((category) => (
                    <Button key={category} variant="outline" className="w-full justify-start">
                      {category}
                    </Button>
                  ))}
                </div>
              </div>
            </SheetContent>
          </Sheet>
        </div>

        <div className="hidden lg:block mb-8">
          <h2 className="text-3xl font-bold mb-4 text-red-800">Categories</h2>
          <ScrollArea className="whitespace-nowrap">
            <div className="flex space-x-4">
              {["All", "Food", "Drinks", "Desserts"].map((category) => (
                <Card key={category} className="inline-block bg-white hover:bg-red-50 transition-colors cursor-pointer">
                  <CardContent className="py-2 px-4">
                    <span className="text-lg font-semibold text-red-700">{category}</span>
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
            {["Mie Ayam", "Nasi Goreng", "Ayam Goreng", "Es Teh", "Juice", "Brownies"].map((product) => (
              <Card key={product} className="bg-white overflow-hidden group hover:shadow-lg transition-shadow">
                <CardContent className="p-0">
                  <div className="w-full h-40 bg-red-200 group-hover:bg-red-300 transition-colors"></div>
                  <div className="p-4">
                    <h3 className="text-lg font-semibold text-red-800 mb-2">{product}</h3>
                    <p className="text-red-600 font-bold text-xl mb-4">Rp 25.000</p>
                    <Button className="w-full bg-red-500 hover:bg-red-600 transition-colors">
                      <PlusCircle className="mr-2 h-4 w-4" /> Add to Cart
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
          <ShoppingCart className="mr-2 h-6 w-6 lg:h-8 lg:w-8" /> Cart
        </h2>
        <ScrollArea className="flex-grow mb-6">
          <div className="space-y-4">
            {["Mie Ayam", "Nasi Goreng", "Es Teh"].map((item, index) => (
              <div key={item} className="flex justify-between items-center bg-red-50 p-3 rounded-lg">
                <span className="text-red-800 font-medium">{item}</span>
                <span className="text-red-600 font-bold">Rp 25.000</span>
              </div>
            ))}
          </div>
        </ScrollArea>
        <Separator className="my-4 bg-red-200" />
        <div className="flex justify-between items-center mb-6">
          <span className="text-xl lg:text-2xl font-bold text-red-800">Total:</span>
          <span className="text-xl lg:text-2xl font-bold text-red-600">Rp 75.000</span>
        </div>
        <Button className="w-full bg-gradient-to-r from-red-500 to-red-600 hover:from-red-600 hover:to-red-700 text-lg py-4 lg:py-6 rounded-xl shadow-lg transition-all hover:shadow-xl">
          Pay Now
        </Button>
      </div>
    </div>
  )
}

