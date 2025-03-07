import { formatPrice } from "@/lib/number";
import React, { forwardRef } from "react";

interface Order {
    customer?: string;
    cart: { name: string; quantity: number; price: number }[];
    totalPrice: number;
    taxAmount?: number; // Tambahkan taxAmount sebagai properti opsional
}

const Receipt = forwardRef<HTMLDivElement, { order: Order }>(({ order }, ref) => {
    return (
        <div ref={ref} className="p-4 text-sm font-sans bg-white shadow-lg rounded-lg">
            <h2 className="text-lg font-bold text-center mb-2">STRUK PEMBELIAN</h2>
            <h2 className="text-sm text-center text-gray-600 mb-4">Sambel Ceurik Ngagoak</h2>
            <hr className="border-t border-gray-300 my-2" />
            <div className="mb-4">
                <p className="text-gray-700">Tanggal: {new Date().toLocaleString()}</p>
                <p className="text-gray-700">Pelanggan: {order.customer || "Guest"}</p>
            </div>
            <hr className="border-t border-gray-300 my-2" />
            <table className="w-full mb-4">
                <thead>
                    <tr className="border-b border-gray-300">
                        <th className="text-left py-2">Item</th>
                        <th className="text-center py-2">Qty</th>
                        <th className="text-right py-2">Harga</th>
                    </tr>
                </thead>
                <tbody>
                    {order.cart.map((item, index) => (
                        <tr key={index} className="border-b border-gray-200">
                            <td className="py-2">{item.name}</td>
                            <td className="text-center py-2">{item.quantity}</td>
                            <td className="text-right py-2">{formatPrice({ value: item.price.toString() })}</td>
                        </tr>
                    ))}
                </tbody>
            </table>
            <hr className="border-t border-gray-300 my-2" />
            {order.taxAmount && order.taxAmount > 0 && (
                <div className="flex justify-between text-gray-700 mb-2">
                    <p>Pajak:</p>
                    <p>{formatPrice({ value: order.taxAmount.toString() })}</p>
                </div>
            )}
            <div className="flex justify-between text-gray-700 font-bold">
                <p>Total:</p>
                <p>Rp {formatPrice({ value: order.totalPrice.toString() })}</p>
            </div>
            <p className="text-center mt-4 text-gray-600">Terima kasih atas pembelian Anda!</p>
        </div>
    );
});

export default Receipt;