From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Tue, 15 Feb 2022 04:47:05 +0000
Subject: [Intel-wired-lan] [PATCH net] ice: fix setting l4 port flag
 when adding filter
In-Reply-To: <20220103064121.2366-1-michal.swiatkowski@linux.intel.com>
References: <20220103064121.2366-1-michal.swiatkowski@linux.intel.com>
Message-ID: <MW3PR11MB4554C559AD81666797AF86B99C349@MW3PR11MB4554.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Michal Swiatkowski
>Sent: Monday, January 3, 2022 12:11 PM
To: intel-wired-lan@osuosl.org
>Subject: [Intel-wired-lan] [PATCH net] ice: fix setting l4 port flag when adding
>filter
>
>Accidentally filter flag for none encapsulated l4 port filed is always set. Even if
>user wants to add encapsulated l4 port field.
>
>Remove this unnecessary flag setting.
>
>Fixes: 9e300987d4a81 ("ice: VXLAN and Geneve TC support")
>Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>---
> drivers/net/ethernet/intel/ice/ice_tc_lib.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
