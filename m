From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 30 Oct 2017 18:59:37 +0000
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH v5 2/6] i40e: Map
 TCs	with the VSI seids
In-Reply-To: <150909694002.48377.13680917261556432785.stgit@anamdev.jf.intel.com>
References: <150909628755.48377.16561267691881106259.stgit@anamdev.jf.intel.com>
 <150909694002.48377.13680917261556432785.stgit@anamdev.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EADB84@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Amritha Nambiar
> Sent: Friday, October 27, 2017 2:36 AM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Cc: jiri at resnulli.us; netdev at vger.kernel.org; jhs at mojatatu.com;
> xiyou.wangcong at gmail.com
> Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH v5 2/6] i40e: Map TCs
> with the VSI seids
> 
> Add mapping of TCs with the seids of the channel VSIs. TC0 will be mapped to
> the main VSI seid and all other TCs are mapped to the seid of the
> corresponding channel VSI.
> 
> Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h      |    1 +
>  drivers/net/ethernet/intel/i40e/i40e_main.c |    2 ++
>  2 files changed, 3 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


