From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 24 Jan 2018 22:30:43 +0000
Subject: [Intel-wired-lan] [PATCH v3 next-queue 01/12] i40evf: Fix link
 up issue when queues are disabled
In-Reply-To: <20180123165106.28900-2-avinash.dayanand@intel.com>
References: <20180123165106.28900-1-avinash.dayanand@intel.com>
 <20180123165106.28900-2-avinash.dayanand@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A93A217@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH v3 next-queue 01/12] i40evf: Fix link up
> issue when queues are disabled
> 
> One of the previous patch fixes the link up issue by ignoring it if i40evf is not
> in __I40EVF_RUNNING state. However this doesn't fix the race condition
> when queues are disabled esp for ADq on VF. Hence check if all queues are
> enabled before starting all queues.
> 
> Signed-off-by: Avinash Dayanand <avinash.dayanand@intel.com>
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf.h         |  1 +
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c    |  1 +
>  .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    | 28 +++++++++++++++-----
> --
>  3 files changed, 22 insertions(+), 8 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


