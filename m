From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 8 Jan 2018 18:58:53 +0000
Subject: [Intel-wired-lan] [patch] i40evf: ignore link up if not running
In-Reply-To: <20180105095521.3621-1-alice.michael@intel.com>
References: <20180105095521.3621-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A8D754A@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, January 5, 2018 1:55 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [patch] i40evf: ignore link up if not running
> 
> From: Alan Brady <alan.brady@intel.com>
> 
> If we receive the link status message from PF with link up before queues are
> actually enabled, it will trigger a TX hang.  This fixes the issue by ignoring a link
> up message if the VF state is not yet in RUNNING state.
> 
> Signed-off-by: Alan Brady <alan.brady@intel.com>
> ---
>  .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    | 35 ++++++++++++++------
> --
>  1 file changed, 23 insertions(+), 12 deletions(-)


Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


