From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 31 Aug 2021 19:02:35 -0700
Subject: [Intel-wired-lan] [RFC v2 net-next 1/2] rtnetlink: Add new
 RTM_GETSYNCESTATE message to get SyncE status
In-Reply-To: <SJ0PR11MB4958D55CB9EDD459AF076525EACC9@SJ0PR11MB4958.namprd11.prod.outlook.com>
References: <20210829080512.3573627-1-maciej.machnikowski@intel.com>
 <20210829080512.3573627-2-maciej.machnikowski@intel.com>
 <20210829151017.GA6016@hoboy.vegasvil.org>
 <PH0PR11MB495126A63998DABA5B5DE184EACA9@PH0PR11MB4951.namprd11.prod.outlook.com>
 <20210830205758.GA26230@hoboy.vegasvil.org>
 <20210830162909.110753ec@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20210831161927.GA10747@hoboy.vegasvil.org>
 <SJ0PR11MB4958D55CB9EDD459AF076525EACC9@SJ0PR11MB4958.namprd11.prod.outlook.com>
Message-ID: <20210831190235.00fa780b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 31 Aug 2021 22:09:18 +0000 Machnikowski, Maciej wrote:
> OK I can strip down the RTNL EEC state interface to only report 
> the state without any extras, like pin. Next step would be to add 
> the control over recovered clock also to the netdev subsystem.
> 
> The EEC state read is needed for recovered/source clock validation
> and that's why I think it belongs to the RTNL part as it gates the QL
> for each port.

If you mean just reporting state and have a syncE on/off without any
option for other sources that's fine by me.
