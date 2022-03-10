From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Thu, 10 Mar 2022 10:37:06 +0000
Subject: [Intel-wired-lan] [PATCH net-next v10 6/7] ice: Fix FV offset
 searching
In-Reply-To: <20220304164048.476900-7-marcin.szycik@linux.intel.com>
References: <20220304164048.476900-1-marcin.szycik@linux.intel.com>
 <20220304164048.476900-7-marcin.szycik@linux.intel.com>
Message-ID: <MW3PR11MB45546A2306F39A3647C94E039C0B9@MW3PR11MB4554.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Marcin Szycik
>Sent: Friday, March 4, 2022 10:11 PM
To: netdev@vger.kernel.org
>Cc: jiri at resnulli.us; xiyou.wangcong at gmail.com; osmocom-net-
>gprs at lists.osmocom.org; jhs at mojatatu.com; laforge at gnumonks.org; intel-
>wired-lan at lists.osuosl.org; kuba at kernel.org; davem at davemloft.net;
>pablo at netfilter.org
>Subject: [Intel-wired-lan] [PATCH net-next v10 6/7] ice: Fix FV offset searching
>
>From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>
>Checking only protocol ids while searching for correct FVs can lead to a
>situation, when incorrect FV will be added to the list. Incorrect means that FV
>has correct protocol id but incorrect offset.
>
>Call ice_get_sw_fv_list with ice_prot_lkup_ext struct which contains all
>protocol ids with offsets.
>
>With this modification allocating and collecting protocol ids list is not longer
>needed.
>
>Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>---
>v7: Fix ice_get_sw_fv_list kernel-doc
>v10: Fix 80 char line limit
>---
> .../net/ethernet/intel/ice/ice_flex_pipe.c    | 22 +++++------
> .../net/ethernet/intel/ice/ice_flex_pipe.h    |  2 +-
> drivers/net/ethernet/intel/ice/ice_switch.c   | 39 +------------------
> 3 files changed, 12 insertions(+), 51 deletions(-)
>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
