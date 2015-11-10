From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 10 Nov 2015 20:40:37 +0000
Subject: [Intel-wired-lan] [next PATCH S21 v2 07/14] i40e: propagate
 properly
In-Reply-To: <1447112150-10713-1-git-send-email-joshua.a.hay@intel.com>
References: <1447112150-10713-1-git-send-email-joshua.a.hay@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060E1EE4@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Joshua Hay
> Sent: Monday, November 09, 2015 3:36 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S21 v2 07/14] i40e: propagate properly
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> i40e_sync_vsi_filters() is the surly teenager of this driver. It says it's going to
> report errors, but it doesn't actually do that most of the time. And when it
> does, it leaves a mess.
> 
> Change this function to have a common exit point so it will properly release
> the busy lock on the VSI. Propagate errors to the callers.
> Finally, adjust a few callers to check for and deal with errors from this
> function.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: Ic6af4956491e72402ebb3c538a3c31a0ad7f8667
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c        | 113 +++++++++++++------
> --
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  14 +--
>  2 files changed, 76 insertions(+), 51 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied
