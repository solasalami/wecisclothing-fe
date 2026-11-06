// Store defaults. Kept free of database imports so the maintenance page can use them.
export const DEFAULT_SETTINGS = {
  store: {
    name: "Wecis Clothing",
    tagline: "Premium African-inspired fashion for men and women",
    email: "info@wecisclothing.com",
    phone: "+234 803 364 0090",
    whatsapp: "+234 803 364 0090",
    whatsapp_message: "Hello Wecis Clothing, I'd like to make an enquiry.",
    instagram: "",
    facebook: "",
    tiktok: "",
  },
  shipping: {
    delivery_lagos_fee: 5000,
    delivery_nationwide_fee: 10000,
    free_delivery_threshold: 0, // 0 = disabled
    pickup_enabled: true,
  },
  payments: {
    opay_enabled: true,
    bank_transfer_enabled: true,
    bank_transfer_details: "Bank: \nAccount name: Wecis Clothing\nAccount number: \nUse your order number as the payment reference.",
  },
  tracking: {
    gtm_id: "", // overrides NEXT_PUBLIC_GTM_ID when set
  },
  campaign: {
    // Seasonal campaign (Detty December, Eid, Valentine's…). Fully editable in Admin → Seasonal campaign.
    enabled: true,
    name: "Detty December", // menu label + used across the site
    slug: "detty-december", // public URL: /detty-december
    previous_slugs: [], // old URLs that redirect to the current one
    starts_at: "2026-11-01", // YYYY-MM-DD (Lagos time); blank = immediately
    ends_at: "2026-12-31", // YYYY-MM-DD (Lagos time); blank = no end
    hide_after_end: true, // switch everything off automatically after ends_at
    show_countdown: true,
    eyebrow: "Wecis Clothing presents",
    title: "Detty December 2026",
    subtitle: "Festive outfits & packages for every owambe, concert and family gathering this December.",
    hero_image: "",
    body: "",
    cta_label: "Shop the packages",
    packages_heading: "Festive packages",
    packages_subheading: "Curated looks for owambe, concerts, Christmas and New Year.",
    package_label: "Festive package", // badge on package cards / product pages
    empty_message: "Our Detty December packages are dropping soon.",
    whatsapp_message: "Hello Wecis Clothing, I'd like to order a Detty December package.",
    show_on_home: true,
    home_image: "", // optional banner image; blank = text placeholder design
    home_image_mobile: "", // optional portrait image for phones
    home_image_alt: "",
    home_title: "", // blank = use the landing page title
    home_subtitle: "", // blank = use the landing page sub-heading
    home_show_packages: true, // show published packages under the section
    home_eyebrow: "Limited season collection",
    home_cta: "Explore festive packages",
    announcement: "Detty December packages are live! Order early for delivery before Christmas.",
    show_announcement: true,
    hide_packages_when_off: true, // remove packages from shop listings outside the campaign
  },
};
