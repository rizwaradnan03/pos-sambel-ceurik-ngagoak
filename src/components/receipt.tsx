import { formatPrice } from "@/lib/number";
import React, { forwardRef } from "react";

interface Order {
    customer?: string;
    cart: { name: string; quantity: number; price: number }[];
    totalPrice: number;
}

const Receipt = forwardRef<HTMLDivElement, { order: Order }>(({ order }, ref) => {
    return (
        <div ref={ref} className="p-2 text-sm">
            <h2 className="text-md font-bold text-center">STRUK PEMBELIAN</h2>
            <h2 className="text-sm text-center">Sambel Ceurik Ngagoak</h2>
            <div>
                <p>Tanggal: {new Date().toLocaleString()}</p>
                <p>Pelanggan: {order.customer || "Guest"}</p>
            </div>
            <hr />
            <table className="w-full">
                <thead>
                    <tr>
                        <th>Item</th>
                        <th>Qty</th>
                        <th>Harga</th>
                    </tr>
                </thead>
                <tbody>
                    {order.cart.map((item, index) => (
                        <tr key={index}>
                            <td>{item.name}</td>
                            <td>{item.quantity}</td>
                            <td>Rp {item.price}</td>
                        </tr>
                    ))}
                </tbody>
            </table>
            <hr />
            <p className="text-right font-bold">Total: Rp {formatPrice({value: order.totalPrice.toString()})}</p>
            <p className="text-center mt-2">Terima kasih atas pembelian Anda!</p>
        </div>
    );
});

export default Receipt;
