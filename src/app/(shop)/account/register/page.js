import { redirect } from "next/navigation";
import { getCustomer } from "@/lib/auth";
import { RegisterForm } from "@/components/AuthForms";
import { createChallenge } from "@/lib/captcha";

export const metadata = { title: "Create account", robots: { index: false } };

export default async function RegisterPage() {
  if (await getCustomer()) redirect("/account");
  const challenge = await createChallenge("register");
  return (
    <div className="mx-auto max-w-lg px-4 py-16">
      <h1 className="mb-8 text-center text-4xl">Create account</h1>
      <RegisterForm initialChallenge={challenge} />
    </div>
  );
}
