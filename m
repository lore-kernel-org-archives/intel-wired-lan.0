From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 24 Jan 2018 22:50:37 +0000
Subject: [Intel-wired-lan] [PATCH v3 next-queue 06/12] i40e: Delete
 queue channel for ADq on VF
In-Reply-To: <20180123165106.28900-7-avinash.dayanand@intel.com>
References: <20180123165106.28900-1-avinash.dayanand@intel.com>
 <20180123165106.28900-7-avinash.dayanand@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A93A269@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH v3 next-queue 06/12] i40e: Delete queue
> channel for ADq on VF
> 
> This patch takes care of freeing up all the VSIs, queues and other ADq related
> software and hardware resources, when a user requests for deletion of ADq
> on VF.
> 
> Example command:
> tc qdisc del dev eth0 root
> 
> Signed-off-by: Avinash Dayanand <avinash.dayanand@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 63
> ++++++++++++++++++++++
>  1 file changed, 63 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


