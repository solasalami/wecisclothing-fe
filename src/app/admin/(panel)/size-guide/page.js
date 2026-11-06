import Link from "next/link";
import { requireAdmin } from "@/lib/auth";
import { getSetting } from "@/lib/settings";
import { SIZE_MEASURES } from "@/lib/size-guide";
import { ActionForm, SubmitButton } from "@/components/admin/Form";
import { TextArea, Card, PageHeader } from "@/components/admin/Fields";
import { saveSizeGuide } from "@/app/admin/actions";

export const metadata = { title: "Size guide" };

const ROWS = 7; // existing sizes plus blank rows for new ones

export default async function SizeGuideAdmin() {
  await requireAdmin();
  const guide = await getSetting("size_guide");
  return (
    <div className="max-w-4xl">
      <PageHeader title="Size guide">
        <Link href="/size-guide" target="_blank" className="btn-outline !py-2">View on website</Link>
      </PageHeader>
      <ActionForm action={saveSizeGuide}>
        <Card title="Text">
          <TextArea label="Introduction" name="intro" rows={3} defaultValue={guide.intro} />
          <TextArea label="Fit note" name="fit_note" rows={3} defaultValue={guide.fit_note} hint="Shown under the size finder, e.g. how agbada and senator styles fit." />
        </Card>
        {["women", "men"].map((g) => {
          const rows = [...(guide[g] || []), ...Array(ROWS).fill({})].slice(0, ROWS);
          return (
            <Card key={g} title={`${g === "women" ? "Women" : "Men"}: body measurements in inches`}>
              <p className="text-xs text-muted">
                Enter ranges like <code>37-39</code>, smallest size first. Leave a row&apos;s size blank to remove it. The website converts to centimetres
                and the size finder uses these numbers.
              </p>
              <div className="overflow-x-auto">
                <table className="w-full text-sm">
                  <thead>
                    <tr className="text-left text-xs uppercase text-muted">
                      <th className="py-1 pr-2">Size</th>
                      {SIZE_MEASURES[g].map(([key, label]) => <th key={key} className="py-1 pr-2">{label}</th>)}
                    </tr>
                  </thead>
                  <tbody>
                    {rows.map((r, i) => (
                      <tr key={i}>
                        <td className="py-1 pr-2"><input name={`${g}.${i}.size`} defaultValue={r.size || ""} className="input !py-1.5" aria-label={`${g} row ${i + 1} size`} /></td>
                        {SIZE_MEASURES[g].map(([key, label]) => (
                          <td key={key} className="py-1 pr-2">
                            <input name={`${g}.${i}.${key}`} defaultValue={r[key] || ""} placeholder="e.g. 37-39" className="input !py-1.5" aria-label={`${g} row ${i + 1} ${label}`} />
                          </td>
                        ))}
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            </Card>
          );
        })}
        <SubmitButton>Save size guide</SubmitButton>
      </ActionForm>
    </div>
  );
}
