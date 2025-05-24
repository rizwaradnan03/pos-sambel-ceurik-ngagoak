"use client";

import { ScrollArea, ScrollBar } from "@/components/ui/scroll-area";
import { Separator } from "@/components/ui/separator";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { Sheet, SheetContent, SheetTrigger } from "@/components/ui/sheet";
import {
  PlusCircle,
  ShoppingCart,
  Menu,
  Minus,
  ListOrdered,
} from "lucide-react";
import { useEffect, useState, useMemo } from "react";
import {
  ISCategory,
  ISOrder,
  ISPackage,
  ISProduct,
} from "@/interfaces/schema-interface";
import { IFCartItem } from "@/interfaces/form-interface";
import toast from "react-hot-toast";
import { UseFetchFindManyProduct } from "@/hooks/api/product/findMany";
import { UseFetchFindManyProductByCategoryId } from "@/hooks/api/product/findManyByCategoryId";
import { UseFetchFindManyCategory } from "@/hooks/api/category/findMany";
import { formatPrice } from "@/lib/number";
import CashierPay from "@/components/dialog/pay/cashier-pay";
import { UseFetchFindManyPackage } from "@/hooks/api/package/findMany";
import { UseFetchFindManyPackageByCategoryId } from "@/hooks/api/package/findManyByCategoryId";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";
import { UseFetchFindManyOnProgressOrder } from "@/hooks/api/order/findManyOnProgress";
import CashierDonePay from "@/components/dialog/pay/cashier-done-pay";
import { Input } from "@/components/ui/input";

export default function ResponsiveCashierPage() {
  const [selectedCategories, setSelectedCategories] = useState<ISCategory>({
    id: "all",
    title: "Semua",
  });
  const [categories, setCategories] = useState<ISCategory[]>();
  const [cart, setCart] = useState<IFCartItem[]>([]);
  const [filteredItem, setFilteredItem] = useState<IFCartItem[]>();
  const [totalPrice, setTotalPrice] = useState<number>(0);
  const [onProgressOrder, setOnProgressOrder] = useState<ISOrder[]>();
  const [isDoneCreatingOrder, setIsDoneCreatingOrder] = useState(false);
  const [isOrderDonePay, setIsOrderDonePay] = useState(false);
  const [searchProduct, setSearchProduct] = useState<string>("");

  const fetchFilteredProduct = async () => {
    try {
      if (selectedCategories.id === "all") {
        const [fetchProduct, fetchPackage] = await Promise.all([
          UseFetchFindManyProduct(),
          UseFetchFindManyPackage(),
        ]);

        const productWithType = fetchProduct.data.map((p: ISProduct) => ({
          ...p,
          category: "PRODUCT",
        }));

        const packageWithType = fetchPackage.data.map((p: ISPackage) => ({
          ...p,
          category: "PACKAGE",
        }));

        setFilteredItem([...productWithType, ...packageWithType]);
      } else {
        if (selectedCategories.category === "PRODUCT") {
          const fetch = await UseFetchFindManyProductByCategoryId({
            categoryId: selectedCategories.id as string,
          });
          const mapped = fetch.data.map((p: ISProduct) => ({
            ...p,
            category: "PRODUCT",
          }));
          setFilteredItem(mapped);
        } else if (selectedCategories.category === "PACKAGE") {
          const fetch = await UseFetchFindManyPackageByCategoryId({
            categoryId: selectedCategories.id as string,
          });
          const mapped = fetch.data.map((p: ISPackage) => ({
            ...p,
            category: "PACKAGE",
          }));
          setFilteredItem(mapped);
        }
      }
    } catch (err) {
      toast.error("Gagal Melakukan Fetching Menu");
    }
  };

  useEffect(() => {
    fetchFilteredProduct();
  }, [selectedCategories]);

  const fetchCategory = async () => {
    try {
      const fetch = await UseFetchFindManyCategory();
      setCategories([{ id: "all", title: "Semua" }, ...fetch.data]);
    } catch (error) {
      toast.error("Gagal Melakukan Fetching Kategori");
    }
  };

  useEffect(() => {
    fetchCategory();
    fetchOnProgressOrder();
  }, []);

  const handleAddToCart = ({ product }: { product: IFCartItem }) => {
    const found = cart.find((item) => item.id === product.id);
    if (found) {
      setCart((prev) =>
        prev.map((item) =>
          item.id === product.id
            ? { ...item, quantity: item.quantity + 1 }
            : item
        )
      );
    } else {
      setCart((prev) => [
        ...prev,
        { ...product, quantity: 1, id: product.id as string },
      ]);
    }
  };

  const handleDecrementQuantity = ({ productId }: { productId: string }) => {
    setCart((prev) =>
      prev
        .map((item) =>
          item.id === productId
            ? { ...item, quantity: item.quantity - 1 }
            : item
        )
        .filter((item) => item.quantity > 0)
    );
  };

  const fetchOnProgressOrder = async () => {
    try {
      const fetch = await UseFetchFindManyOnProgressOrder();
      setOnProgressOrder(fetch.data);
    } catch (err: any) {
      toast.error(err.message);
    }
  };

  useEffect(() => {
    if (isDoneCreatingOrder) {
      fetchOnProgressOrder();
      setCart([]);
      setTotalPrice(0);
      setIsDoneCreatingOrder(false);
    }
  }, [isDoneCreatingOrder]);

  useEffect(() => {
    if (isOrderDonePay) {
      fetchOnProgressOrder();
      setIsDoneCreatingOrder(false);
      setIsOrderDonePay(false);
    }
  }, [isOrderDonePay]);

  const searchedItems = useMemo(() => {
    if (!searchProduct.trim()) return filteredItem;
    return filteredItem?.filter((item) =>
      item.name.toLowerCase().includes(searchProduct.toLowerCase())
    );
  }, [searchProduct, filteredItem]);

  return (
    <div className="flex flex-col lg:flex-row h-screen bg-gradient-to-br from-red-50 to-red-100">
      {/* LEFT SECTION */}
      <div className="w-full lg:w-3/4 p-4 lg:p-6 overflow-hidden flex flex-col">
        {/* Mobile Header */}
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
                <h2 className="text-2xl font-bold mb-4 text-red-800">
                  Kategori
                </h2>
                <div className="grid grid-cols-2 gap-4">
                  {categories?.map((cat) => (
                    <Button
                      key={cat.id}
                      variant="outline"
                      className="w-full justify-start"
                      onClick={() => setSelectedCategories(cat)}
                    >
                      {cat.title}
                    </Button>
                  ))}
                </div>
              </div>
            </SheetContent>
          </Sheet>
        </div>

        <div className="hidden lg:block mb-2">
          <h2 className="text-3xl font-bold mb-4 text-red-800">Kategori</h2>
          <ScrollArea className="w-full h-[80px] relative">
            {" "}
            <div className="flex space-x-2 min-w-max">
              {" "}
              {categories?.map((cat) => (
                <Card
                  key={cat.id}
                  className={`inline-block transition cursor-pointer min-w-[120px] ${
                    selectedCategories.id === cat.id
                      ? "bg-red-100"
                      : "bg-white hover:bg-red-50"
                  }`}
                  onClick={() => setSelectedCategories(cat)}
                >
                  <CardContent className="py-2 px-4">
                    <span className="text-lg font-semibold text-red-700">
                      {cat.title}
                    </span>
                  </CardContent>
                </Card>
              ))}
            </div>
            <ScrollBar orientation="horizontal" /> {/* scrollbar horizontal */}
          </ScrollArea>
        </div>

        <div className="mb-6">
          <Input
            placeholder="Cari Produk..."
            value={searchProduct}
            onChange={(e) => setSearchProduct(e.target.value)}
          />
        </div>

        {/* Menu Section */}
        <h2 className="text-2xl lg:text-3xl font-bold mb-4 text-red-800">
          Menu
        </h2>
        <ScrollArea className="flex-grow">
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
            {searchedItems && searchedItems.length > 0 ? (
              searchedItems.map((product) => (
                <Card
                  key={product.id}
                  className="bg-white group hover:shadow-md transition-shadow"
                >
                  <CardContent className="p-0">
                    <div className="relative w-full h-64">
                      <img
                        src={product.image || "/placeholder.jpg"}
                        alt="Gambar Produk"
                        className="absolute top-0 left-0 w-full h-full object-cover"
                      />
                    </div>
                    <div className="p-4">
                      <h3 className="text-lg font-semibold text-red-800 mb-1">
                        {product.name}
                      </h3>
                      <p className="text-red-600 font-bold text-xl mb-4">
                        Rp {formatPrice({ value: product.price.toString() })}
                      </p>
                      <Button
                        className="w-full bg-red-500 hover:bg-red-600"
                        onClick={() => handleAddToCart({ product })}
                      >
                        <PlusCircle className="mr-2 h-4 w-4" /> Add To Cart
                      </Button>
                    </div>
                  </CardContent>
                </Card>
              ))
            ) : (
              <div className="text-center col-span-full text-red-600 font-semibold py-10">
                Tidak ada produk ditemukan.
              </div>
            )}
          </div>
        </ScrollArea>
      </div>

      {/* RIGHT SECTION - Cart */}
      <div className="w-full lg:w-1/4 lg:shadow-xl h-full flex flex-col">
        {/* On-Progress Orders */}
        <div className="bg-white p-4 lg:p-6">
          <h2 className="text-2xl lg:text-3xl font-bold mb-4 text-red-800 flex items-center">
            <ListOrdered className="mr-2 h-6 w-6 lg:h-8 lg:w-8" /> Order
          </h2>
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead>No</TableHead>
                <TableHead>Customer</TableHead>
                <TableHead>Total</TableHead>
                <TableHead>Aksi</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {onProgressOrder?.map((order, index) => (
                <TableRow key={order.id}>
                  <TableCell>{index + 1}</TableCell>
                  <TableCell>{order.customer}</TableCell>
                  <TableCell>
                    Rp {formatPrice({ value: order.totalPrice.toString() })}
                  </TableCell>
                  <TableCell>
                    <CashierDonePay
                      setIsOrderDonePay={setIsOrderDonePay}
                      orderId={order.id as string}
                    />
                  </TableCell>
                </TableRow>
              ))}
            </TableBody>
          </Table>
        </div>

        {/* Cart Section */}
        <div className="flex-1 bg-white p-4 lg:p-6 flex flex-col">
          <h2 className="text-2xl font-bold mb-4 text-red-800 flex items-center">
            <ShoppingCart className="mr-2 h-6 w-6" /> Keranjang
          </h2>
          <ScrollArea className="flex-grow mb-4">
            <div className="space-y-4">
              {cart.map((item) => (
                <div
                  key={item.id}
                  className="flex justify-between items-center bg-red-50 p-3 rounded-lg"
                >
                  <span className="text-red-800 font-medium">{item.name}</span>
                  <span className="text-red-600 font-bold">
                    Rp {formatPrice({ value: item.price.toString() })}
                  </span>
                  <span className="text-red-600">({item.quantity})</span>
                  <Button
                    variant="ghost"
                    size="sm"
                    onClick={() =>
                      handleDecrementQuantity({ productId: item.id })
                    }
                  >
                    <Minus />
                  </Button>
                </div>
              ))}
            </div>
          </ScrollArea>
          <Separator className="my-4 bg-red-200" />
          <div className="flex justify-between text-lg font-bold text-red-800 mb-4">
            <span>Total:</span>
            <span>Rp {formatPrice({ value: totalPrice.toString() })}</span>
          </div>
          <CashierPay
            cart={cart}
            totalPrice={totalPrice}
            setTotalPrice={setTotalPrice}
            setIsDoneCreatingOrder={setIsDoneCreatingOrder}
          />
        </div>
      </div>
    </div>
  );
}
