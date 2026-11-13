import { getSettings } from "@/lib/settings";
import { PageHeader } from "@/components/admin/Fields";
import GoLiveChecklist from "@/components/admin/GoLiveChecklist";

export const metadata = { title: "Go-live checklist" };

export default async function GoLivePage() {
  const settings = await getSettings();
  return (
    <div className="space-y-4">
      <PageHeader title="Go-live checklist" />
      <p className="max-w-3xl text-sm text-muted">
        Everything to confirm before launching the store. Automatic items are
        re-checked each time you open this page; tick off the manual steps as
        the team completes them.
      </p>
      <GoLiveChecklist settings={settings} />
    </div>
  );
}
