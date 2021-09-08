From: Andrew Lunn <andrew@lunn.ch>
Date: Thu, 9 Sep 2021 01:14:36 +0200
Subject: [Intel-wired-lan] [PATCH net-next 1/2] rtnetlink: Add new
 RTM_GETEECSTATE message to get SyncE status
In-Reply-To: <20210908151852.7ad8a0f1@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <PH0PR11MB49511F2017F48BBAAB2A065CEAD29@PH0PR11MB4951.namprd11.prod.outlook.com>
 <20210906180124.33ff49ef@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <PH0PR11MB495152B03F32A5A17EDB2F6CEAD39@PH0PR11MB4951.namprd11.prod.outlook.com>
 <20210907075509.0b3cb353@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <PH0PR11MB49512C265E090FC8741D8510EAD39@PH0PR11MB4951.namprd11.prod.outlook.com>
 <20210907124730.33852895@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <PH0PR11MB495169997552152891A69B57EAD49@PH0PR11MB4951.namprd11.prod.outlook.com>
 <20210908092115.191fdc28@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <PH0PR11MB4951AA3C65DD8E7612F5F396EAD49@PH0PR11MB4951.namprd11.prod.outlook.com>
 <20210908151852.7ad8a0f1@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <YTlD3Gok7w/MF+g2@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> As you said, pin -> ref mapping is board specific, so the API should
> not assume knowledge of routing between Port and ECC.

That information will probably end up in device tree. And X different
implementations of ACPI, unless somebody puts there foot down and
stops the snow flakes.

> Imagine a system with two cascaded switch ASICs and a bunch of PHYs.
> How do you express that by pure extensions to the proposed API?

Device tree is good at that. ACPI might eventually catch up.

How complex a setup do we actually expect? Can there be multiple
disjoint SyncE trees within an Ethernet switch cluster? Or would it be
reasonable to say all you need to configure is the clock source, and
all other ports of the switches are slaves if SyncE is enabled for the
port? I've never see any SOHO switch hardware which allows you to have
disjoint PTP trees, so it does not sound too unreasonable to only
allow a single SyncE tree per switch cluster.

Also, if you are cascading switches, you generally don't put PHYs in
the middle, you just connect the SERDES lanes together.

	 Andrew
