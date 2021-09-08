From: Andrew Lunn <andrew@lunn.ch>
Date: Thu, 9 Sep 2021 00:59:27 +0200
Subject: [Intel-wired-lan] [PATCH net-next 1/2] rtnetlink: Add new
 RTM_GETEECSTATE message to get SyncE status
In-Reply-To: <20210908152027.313d7168@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20210906180124.33ff49ef@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <PH0PR11MB495152B03F32A5A17EDB2F6CEAD39@PH0PR11MB4951.namprd11.prod.outlook.com>
 <20210907075509.0b3cb353@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <PH0PR11MB49512C265E090FC8741D8510EAD39@PH0PR11MB4951.namprd11.prod.outlook.com>
 <20210907124730.33852895@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <PH0PR11MB495169997552152891A69B57EAD49@PH0PR11MB4951.namprd11.prod.outlook.com>
 <20210908092115.191fdc28@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <PH0PR11MB4951AA3C65DD8E7612F5F396EAD49@PH0PR11MB4951.namprd11.prod.outlook.com>
 <YTkQTQM6Is4Hqmxh@lunn.ch>
 <20210908152027.313d7168@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <YTlAT+1wkazy3Uge@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Sep 08, 2021 at 03:20:27PM -0700, Jakub Kicinski wrote:
> On Wed, 8 Sep 2021 21:34:37 +0200 Andrew Lunn wrote:
> > Since we are talking about clocks and dividers, and multiplexors,
> > should all this be using the common clock framework, which already
> > supports most of this? Do we actually need something new?
> 
> Does the common clock framework expose any user space API?

Ah, good point. No, i don't think it does, apart from debugfs, which
is not really a user space API, and it contains read only descriptions
of the clock tree, current status, mux settings, dividers etc.

So probably anybody implemented the proposed API the Linux way will
use the common clock framework and its internal API, and debug the
implementation via debugfs.

PHY drivers already do use it, e.g. when the PHY is using a clock
provided by the MAC, it uses the API to enable/disable and set ifs
frequency as needed.

    Andrew
