From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 13 Apr 2016 17:23:31 +0000
Subject: [Intel-wired-lan] [next PATCH S33 02/13] i40evf: Don't Panic
In-Reply-To: <1460475052-6348-3-git-send-email-harshitha.ramamurthy@intel.com>
References: <1460475052-6348-1-git-send-email-harshitha.ramamurthy@intel.com>
 <1460475052-6348-3-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D06DD@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Harshitha Ramamurthy
> Sent: Tuesday, April 12, 2016 8:31 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S33 02/13] i40evf: Don't Panic
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> Under some circumstances the driver remove function may be called before
> the driver is fully initialized. So we can't assume that we know where our
> towel is at, or that all of the data structures are initialized.
> 
> To ensure that we don't panic, check that the vsi_res pointer is valid before
> dereferencing it. Then drink beer and eat peanuts.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: If697b4db57348e39f9538793e16aa755e3e1af03
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Added and removed driver in rapid succession, no panics
