import { redirect } from "next/navigation";
import { getCustomer } from "@/lib/auth";
import { ForgotPasswordForm } from "@/components/AuthForms";
import { createChallenge } from "@/lib/captcha";

export const metadata = { title: "Forgot password", robots: { index: false } };

export default async function ForgotPasswordPage() {
  // Signed in: the account page has its own "email me a reset link" option.
  if (await getCustomer()) redirect("/account#password");
  const challenge = await createChallenge("reset");
  return (
    <div className="mx-auto max-w-md px-4 py-16">
      <h1 className="mb-8 text-center text-4xl">Reset your password</h1>
      <ForgotPasswordForm initialChallenge={challenge} />
    </div>
  );
}
