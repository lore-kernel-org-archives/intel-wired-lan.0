From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Wed, 27 Oct 2021 16:57:21 +0000
Subject: [Intel-wired-lan] [next-queue v2 1/4] ice: support for indirect
 notification
In-Reply-To: <20211012183106.2315477-2-anthony.l.nguyen@intel.com>
References: <20211012183106.2315477-1-anthony.l.nguyen@intel.com>
 <20211012183106.2315477-2-anthony.l.nguyen@intel.com>
Message-ID: <MW3PR11MB4554EABAC87FFFC29FB071AA9C859@MW3PR11MB4554.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Tony Nguyen
>Sent: Wednesday, October 13, 2021 12:01 AM
To: intel-wired-lan@lists.osuosl.org
>Subject: [Intel-wired-lan] [next-queue v2 1/4] ice: support for indirect
>notification
>
>From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>
>Implement indirect notification mechanism to support offloading TC rules on
>tunnel devices.
>
>Keep indirect block list in netdev priv. Notification will call setting tc cls flower
>function.
>
>Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>---
> drivers/net/ethernet/intel/ice/ice.h        |   8 +
> drivers/net/ethernet/intel/ice/ice_main.c   | 198 +++++++++++++++++++-
> drivers/net/ethernet/intel/ice/ice_tc_lib.h |   6 +
> 3 files changed, 210 insertions(+), 2 deletions(-)
>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
