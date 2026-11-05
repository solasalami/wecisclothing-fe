import { ActionForm, SubmitButton } from "@/components/admin/Form";
import { Field, Card, PageHeader } from "@/components/admin/Fields";
import { changeOwnPassword } from "@/app/admin/actions";

export const metadata = { title: "My password" };

export default function AccountAdmin() {
  return (
    <div className="max-w-md">
      <PageHeader title="Change password" />
      <Card>
        <ActionForm action={changeOwnPassword} className="space-y-4">
          <Field label="Current password" name="current" type="password" required autoComplete="current-password" />
          <Field label="New password (10+ characters)" name="next" type="password" required minLength={10} autoComplete="new-password" />
          <SubmitButton>Change password</SubmitButton>
        </ActionForm>
      </Card>
    </div>
  );
}
