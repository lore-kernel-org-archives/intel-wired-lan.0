From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 12 Aug 2016 22:45:40 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: check for and deal
	with	non-contiguous TCs
In-Reply-To: <1471020992-22402-1-git-send-email-david.m.ertman@intel.com>
References: <1471020992-22402-1-git-send-email-david.m.ertman@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9F8B77@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Dave Ertman
> Sent: Friday, August 12, 2016 9:57 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] i40e: check for and deal with non-
> contiguous TCs
> 
> The i40e driver was causing a kernel panic when non-contiguous Traffic
> Classes, or Traffic Classes not starting with TC0, were configured on a link
> partner switch.
> i40e does not support non-contiguous TCs.
> 
> To fix this, the patch changes the logic when determining the total number of
> TCs enabled.  Before, this would use the highest TC number enabled and
> assume that all TCs below it were also enabled.  Now, we create a bitmask of
> enabled TCs and scan it to determine not only the number of TCs, but also if
> the set of enabled TCs starts at zero and is contiguous.  If not, then DCB is
> disabled by only returning one TC.
> 
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 35
> ++++++++++++++++++++---------
>  1 file changed, 25 insertions(+), 10 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
