From: Richard Cochran <richardcochran@gmail.com>
Date: Fri, 20 Aug 2021 08:55:38 -0700
Subject: [Intel-wired-lan] [RFC net-next 1/7] ptp: Add interface for
 acquiring DPLL state
In-Reply-To: <PH0PR11MB4951F51CBA231DFD65806CDAEAC09@PH0PR11MB4951.namprd11.prod.outlook.com>
References: <20210816160717.31285-1-arkadiusz.kubalewski@intel.com>
 <20210816160717.31285-2-arkadiusz.kubalewski@intel.com>
 <20210816235400.GA24680@hoboy.vegasvil.org>
 <PH0PR11MB4951762ECB04D90D634E905DEAFE9@PH0PR11MB4951.namprd11.prod.outlook.com>
 <20210818170259.GD9992@hoboy.vegasvil.org>
 <PH0PR11MB495162EC9116F197D79589F5EAFF9@PH0PR11MB4951.namprd11.prod.outlook.com>
 <20210819153414.GC26242@hoboy.vegasvil.org>
 <PH0PR11MB4951F51CBA231DFD65806CDAEAC09@PH0PR11MB4951.namprd11.prod.outlook.com>
Message-ID: <20210820155538.GB9604@hoboy.vegasvil.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Aug 19, 2021 at 03:40:22PM +0000, Machnikowski, Maciej wrote:

> If it helps we'd be happy to separate that in 2 separate RFCs.

It would help me if you could explain the connection.  I have a
totally different understanding of SyncE which I explained here:

   https://lore.kernel.org/netdev/20150317161128.GA8793 at localhost.localdomain/

So you need to implement two things, one in kernel and one in user
space.

1. Control bits according to IEEE 802.3 Section 40.5.2 as Ethtool or RTNL.

2. User space Ethernet Synchronization Messaging Channel (ESMC)
   service according to IEEE 802.3ay

The PHY should be automatically controlled by #1.

As I said before, none of this belongs in the PHC subsystem.

Thanks,
Richard
