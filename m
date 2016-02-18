From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 18 Feb 2016 23:10:42 +0000
Subject: [Intel-wired-lan] [next PATCH S29 13/14] i40e: let go of the
 past
In-Reply-To: <1455754344-6372-14-git-send-email-avinash.dayanand@intel.com>
References: <1455754344-6372-1-git-send-email-avinash.dayanand@intel.com>
 <1455754344-6372-14-git-send-email-avinash.dayanand@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F98F371@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Avinash Dayanand
> Sent: Wednesday, February 17, 2016 4:12 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S29 13/14] i40e: let go of the past
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> If we reset a VF, its VSI goes away, and it gets a new one. So don't hang on to
> the now-stale local VSI pointer. It just leads to suffering and kernel panics.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: Ia8823b4e85893e95e963acee284968022b29177a
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 2 ++
>  1 file changed, 2 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes properly applied
