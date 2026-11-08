import { redirect } from "next/navigation";
import Image from "next/image";
import { getAdmin } from "@/lib/auth";
import LoginForm from "./LoginForm";

export const dynamic = "force-dynamic";
export const metadata = { title: "Admin sign in", robots: { index: false } };

export default async function AdminLoginPage() {
  if (await getAdmin()) redirect("/admin");
  return (
    <div className="flex min-h-screen items-center justify-center bg-soft px-4">
      <div className="w-full max-w-sm border border-line bg-white p-8">
        <Image src="/logo.png" alt="Wecis Clothing" width={72} height={70} loading="eager" className="mx-auto" />
        <h1 className="mb-6 mt-4 text-center text-2xl">Admin sign in</h1>
        <LoginForm />
      </div>
    </div>
  );
}
