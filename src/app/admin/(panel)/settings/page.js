import { requireOwner } from "@/lib/auth";
import { getSettings } from "@/lib/settings";
import { opayConfigured } from "@/lib/opay";
import { paystackConfigured, paystackMode } from "@/lib/paystack";
import { ActionForm, SubmitButton } from "@/components/admin/Form";
import {
  Field,
  TextArea,
  Check,
  Card,
  PageHeader,
} from "@/components/admin/Fields";
import { saveSettings } from "@/app/admin/actions";

export const metadata = { title: "Settings" };

export default async function SettingsAdmin() {
  await requireOwner();
  const { store, shipping, payments, tracking, tax } = await getSettings();
  return (
    <div className="max-w-4xl">
      <PageHeader title="Settings" />
      <ActionForm action={saveSettings}>
        <Card title="Store & contact">
          <div className="grid gap-4 sm:grid-cols-2">
            <Field
              label="Store name"
              name="store_name"
              defaultValue={store.name}
            />
            <Field
              label="Email"
              name="email"
              type="email"
              defaultValue={store.email}
            />
            <Field
              label="Sales phone"
              name="phone"
              defaultValue={store.phone}
            />
            <Field
              label="WhatsApp number"
              name="whatsapp"
              defaultValue={store.whatsapp}
              hint="Include country code, e.g. +234 803 364 0090"
            />
          </div>
          <Field label="Tagline" name="tagline" defaultValue={store.tagline} />
          <Field
            label="Default WhatsApp message"
            name="whatsapp_message"
            defaultValue={store.whatsapp_message}
          />
          <div className="grid gap-4 sm:grid-cols-3">
            <Field
              label="Instagram URL"
              name="instagram"
              defaultValue={store.instagram}
              placeholder="https://www.instagram.com/wecisclothing"
            />
            <Field
              label="Facebook URL"
              name="facebook"
              defaultValue={store.facebook}
              placeholder="https://www.facebook.com/wecisclothing"
            />
            <Field
              label="TikTok URL"
              name="tiktok"
              defaultValue={store.tiktok}
              placeholder="https://www.tiktok.com/@wecisclothing"
            />
          </div>
          <p className="-mt-2 text-xs text-muted">
            Shown as icons in the shop footer. Paste the full link or just the
            handle; leave blank to hide that icon.
          </p>
        </Card>
        <Card title="Delivery fees (₦)">
          <div className="grid gap-4 sm:grid-cols-3">
            <Field
              label="Lagos delivery"
              name="delivery_lagos_fee"
              type="number"
              min="0"
              defaultValue={shipping.delivery_lagos_fee}
            />
            <Field
              label="Outside Lagos"
              name="delivery_nationwide_fee"
              type="number"
              min="0"
              defaultValue={shipping.delivery_nationwide_fee}
            />
            <Field
              label="Free delivery over"
              name="free_delivery_threshold"
              type="number"
              min="0"
              defaultValue={shipping.free_delivery_threshold}
              hint="0 = never free"
            />
          </div>
          <Check
            label="Allow free pick-up from showrooms"
            name="pickup_enabled"
            defaultChecked={shipping.pickup_enabled}
          />
        </Card>
        <Card title="Tax (VAT)">
          <Check
            label="Charge VAT"
            name="vat_enabled"
            defaultChecked={tax.vat_enabled}
            hint="Applies to every product. Each product is set as VAT inclusive (price already contains VAT) or VAT exclusive (VAT is added at checkout)."
          />
          <div className="grid gap-4 sm:grid-cols-2">
            <Field
              label="VAT rate (%)"
              name="vat_rate"
              type="number"
              min="0"
              max="100"
              step="0.01"
              defaultValue={tax.vat_rate}
              hint="Nigerian VAT is currently 7.5%. Shown at checkout, on order confirmations and in emails."
            />
          </div>
        </Card>
        <Card title="Payments">
          <Check
            label="Paystack online payments"
            name="paystack_enabled"
            defaultChecked={payments.paystack_enabled}
            hint={
              paystackConfigured()
                ? `Paystack keys detected (${paystackMode()} mode).`
                : "Paystack keys are not configured yet. Set PAYSTACK_SECRET_KEY and PAYSTACK_PUBLIC_KEY in Netlify."
            }
          />
          <Check
            label="OPay online payments"
            name="opay_enabled"
            defaultChecked={payments.opay_enabled}
            hint={
              opayConfigured()
                ? "OPay keys detected."
                : "OPay keys are not configured yet. Set OPAY_MERCHANT_ID, OPAY_PUBLIC_KEY and OPAY_SECRET_KEY in Netlify."
            }
          />
          <Check
            label="Direct bank transfer"
            name="bank_transfer_enabled"
            defaultChecked={payments.bank_transfer_enabled}
          />
          <TextArea
            label="Bank transfer instructions"
            name="bank_transfer_details"
            rows={4}
            defaultValue={payments.bank_transfer_details}
          />
        </Card>
        <Card title="Tracking">
          <Field
            label="Google Tag Manager container ID"
            name="gtm_id"
            defaultValue={tracking.gtm_id}
            placeholder="GTM-XXXXXXX"
            hint="GA4, Google Ads conversions and remarketing are configured inside GTM."
          />
        </Card>
        <SubmitButton>Save settings</SubmitButton>
      </ActionForm>
    </div>
  );
}
