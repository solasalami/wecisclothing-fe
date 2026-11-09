import Link from "next/link";
import { customerFromResetToken } from "@/lib/customers";
import { ResetPasswordForm } from "@/components/AuthForms";

// no-referrer: the reset token in the address must not be passed on to other sites.
export const metadata = { title: "Choose a new password", robots: { index: false }, referrer: "no-referrer" };

export default async function ResetPasswordPage({ searchParams }) {
  const token = String((await searchParams).token || "");
  const customer = token ? await customerFromResetToken(token) : null;
  return (
    <div className="mx-auto max-w-md px-4 py-16">
      <h1 className="mb-8 text-center text-4xl">Choose a new password</h1>
      {customer ? (
        <ResetPasswordForm token={token} email={customer.email} />
      ) : (
        <div className="space-y-4">
          <p className="border border-red-200 bg-red-50 p-3 text-sm text-red-700" role="alert">
            This reset link has expired or was already used. Links work once, for 1 hour.
          </p>
          <Link href="/account/forgot-password" className="btn-primary w-full">Send a new link</Link>
        </div>
      )}
    </div>
  );
}
