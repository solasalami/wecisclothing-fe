import { notFound, redirect } from "next/navigation";
import { getCustomer } from "@/lib/auth";
import { getOrderByNumber, orderAccessToken } from "@/lib/orders";

export default async function AccountOrderPage({ params }) {
  const { orderNumber } = await params;
  const customer = await getCustomer();
  if (!customer) redirect("/account");
  const order = await getOrderByNumber(orderNumber);
  if (!order || order.customer_id !== customer.id) notFound();
  redirect(`/checkout/success/${order.order_number}?t=${orderAccessToken(order.order_number)}`);
}
