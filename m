From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 1 Sep 2017 18:36:18 +0000
Subject: [Intel-wired-lan] [next PATCH S79-V2 10/13] i40e: implement
 split	PCI error reset handler
In-Reply-To: <20170829093242.41026-10-alice.michael@intel.com>
References: <20170829093242.41026-1-alice.michael@intel.com>
 <20170829093242.41026-10-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EA9685@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Tuesday, August 29, 2017 2:33 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S79-V2 10/13] i40e: implement split
> PCI error reset handler
> 
> From: Alan Brady <alan.brady@intel.com>
> 
> This patch implements the PCI error handler reset_prepare and reset_done.
> This allows us to handle function level reset.  Without this patch we are
> unable to perform and recover from an FLR correctly and this will cause VFs
> to be unable to recover from an FLR on the PF.
> 
> Signed-off-by: Alan Brady <alan.brady@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 24
> ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


