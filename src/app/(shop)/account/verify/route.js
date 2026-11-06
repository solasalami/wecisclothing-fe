import { NextResponse } from "next/server";
import { confirmEmailToken } from "@/lib/customers";

export const dynamic = "force-dynamic";

/** Link from the "Confirm your email" message. Works whether or not the customer is signed in. */
export async function GET(request) {
  const url = new URL(request.url);
  const customer = await confirmEmailToken(url.searchParams.get("token"));
  const to = new URL("/account", url);
  if (customer) {
    to.searchParams.set("verified", "1");
    if (customer.linked) to.searchParams.set("linked", String(customer.linked));
  } else {
    to.searchParams.set("verify", "invalid");
  }
  return NextResponse.redirect(to);
}
