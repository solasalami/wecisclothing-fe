import { notFound, permanentRedirect } from "next/navigation";
import { getSetting } from "@/lib/settings";
import { PROMOS_PATH } from "@/lib/campaign";

// Old campaign addresses (e.g. /detty-december from earlier seasons) now live at /promos,
// which every campaign uses. Keeps old ads, flyers and shared links working.
export default async function OldCampaignAddress({ params }) {
  const { campaign: slug } = await params;
  const campaign = await getSetting("campaign");
  if (slug === campaign.slug || (campaign.previous_slugs || []).includes(slug)) permanentRedirect(PROMOS_PATH);
  notFound();
}
