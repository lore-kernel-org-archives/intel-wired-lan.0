From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 24 Jan 2018 22:42:17 +0000
Subject: [Intel-wired-lan] [PATCH v3 next-queue 04/12] i40e: Enable ADq
 and create queue channel/s on VF
In-Reply-To: <20180123165106.28900-5-avinash.dayanand@intel.com>
References: <20180123165106.28900-1-avinash.dayanand@intel.com>
 <20180123165106.28900-5-avinash.dayanand@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A93A249@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Avinash Dayanand
> Sent: Tuesday, January 23, 2018 8:51 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v3 next-queue 04/12] i40e: Enable ADq and
> create queue channel/s on VF
> 
> This patch enables ADq and creates queue channels on a VF. An ADq enabled
> VF can have upto 4 VSIs and each one of them represents a traffic class and
> this is termed as a queue channel. Each of these VSIs can have up to 4
> queues. This patch services the request for enabling ADq and adds queue
> channel based on the TC mqprio info provided by the user in the VF.
> 
> Initially a check is made to see if spoof check is OFF, if not ADq will not be
> enabled. PF notifies VF for a reset in order to complete the creation of ADq
> resources i.e. creation of additional VSIs and allocation of queues as per TC
> information, all in the reset path.
> 
> Steps:
> 
> ======
> 1. Turn off the spoof check
> 2. Enable ADq using tc mqprio command with or without rate limit.
> 3. Pass traffic.
> 
> Example:
> ========
> % ip link set dev eth0 vf 0 spoofchk off % tc qdisc add dev $iface root mqprio
> num_tc 4 map\
> 	0 0 0 0 1 1 1 1 2 2 2 2 3 3 3 3 queues\
> 	4 at 0 4 at 4 4 at 8 4 at 8 hw 1 mode channel
> 
> Expected results:
> =================
> 1. Total number of queues for the VF should be sum of queues of all TCs.
> 2. Traffic flow should be normal without errors.
> 
> Signed-off-by: Avinash Dayanand <avinash.dayanand@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_type.h        |   2 +-
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 429
> +++++++++++++++++----
> drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h |  17 +
>  3 files changed, 379 insertions(+), 69 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


