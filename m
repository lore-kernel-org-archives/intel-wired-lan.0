From: Richard Cochran <richardcochran@gmail.com>
Date: Mon, 30 Aug 2021 13:57:58 -0700
Subject: [Intel-wired-lan] [RFC v2 net-next 1/2] rtnetlink: Add new
 RTM_GETSYNCESTATE message to get SyncE status
In-Reply-To: <PH0PR11MB495126A63998DABA5B5DE184EACA9@PH0PR11MB4951.namprd11.prod.outlook.com>
References: <20210829080512.3573627-1-maciej.machnikowski@intel.com>
 <20210829080512.3573627-2-maciej.machnikowski@intel.com>
 <20210829151017.GA6016@hoboy.vegasvil.org>
 <PH0PR11MB495126A63998DABA5B5DE184EACA9@PH0PR11MB4951.namprd11.prod.outlook.com>
Message-ID: <20210830205758.GA26230@hoboy.vegasvil.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sun, Aug 29, 2021 at 04:42:55PM +0000, Machnikowski, Maciej wrote:

> Please take a look at the 10.2 Operation modes of the G.8264 and at the Figure A.1
> which depicts the EEC. This interface is to report the status of the EEC.

Well, I read it, and it is still fairly high level with no mention at
all of "DPLL".  I hope that the new RTNL states will cover other
possible EEC implementations, too.

The "Reference source selection mechanism" is also quite vague.  Your
patch is more specific:

+enum if_eec_src {
+       IF_EEC_SRC_INVALID = 0,
+       IF_EEC_SRC_UNKNOWN,
+       IF_EEC_SRC_SYNCE,
+       IF_EEC_SRC_GNSS,
+       IF_EEC_SRC_PTP,
+       IF_EEC_SRC_EXT,
+       __IF_EEC_SRC_MAX,
+};

But I guess your list is reasonable.  It can always be expanded, right?


> If you prefer EEC over DPLL I'm fine with the name change. I think it will be less confusing.

Yes, thanks for doing that.

Thanks,
Richard
