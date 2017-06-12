From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 12 Jun 2017 18:14:32 +0000
Subject: [Intel-wired-lan] [next PATCH S72-V3 12/13] i40e: Handle
 PE_CRITERR	properly with IWARP enabled
In-Reply-To: <20170607094313.32060-12-alice.michael@intel.com>
References: <20170607094313.32060-1-alice.michael@intel.com>
 <20170607094313.32060-12-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DAAB78@ORSMSX104.amr.corp.intel.com>
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
> Cc: Catherine Sullivan <catherine.sullivan@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S72-V3 12/13] i40e: Handle
> PE_CRITERR properly with IWARP enabled
> 
> From: Catherine Sullivan <catherine.sullivan@intel.com>
> 
> When IWARP is enabled, we weren't clearing the PE_CRITERR, just logging it
> and removing it from the mask. We need to do a corer to reset the
> PE_CRITERR register, so set the bit for that as we handle the interrupt.
> 
> We should also be checking for the error against the PFINT_ICR0 register, and
> only need to clear it in the value getting written to PFINT_ICR0_ENA.
> 
> Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


