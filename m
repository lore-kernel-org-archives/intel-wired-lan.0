From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 8 Jun 2017 18:51:00 +0000
Subject: [Intel-wired-lan] [next PATCH S72-V3 11/13] i40e: clear
	only	cause_ena bit
In-Reply-To: <20170607094313.32060-11-alice.michael@intel.com>
References: <20170607094313.32060-1-alice.michael@intel.com>
 <20170607094313.32060-11-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DAA912@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, June 7, 2017 2:43 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Shannon Nelson <shannon.nelson@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S72-V3 11/13] i40e: clear only
> cause_ena bit
> 
> From: Shannon Nelson <shannon.nelson@intel.com>
> 
> When disabling interrupts, we should only be clearing the CAUSE_ENA bit,
> not clearing the whole register.  Clearing the whole register sets the
> NEXTQ_IDX field to 0 instead of 0x7ff which can confuse the Firmware in
> some reset sequences.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


