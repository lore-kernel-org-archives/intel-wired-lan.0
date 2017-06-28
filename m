From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 28 Jun 2017 22:41:16 +0000
Subject: [Intel-wired-lan] [next PATCH S74-V2 01/10] i40e/i40evf: fix
 some	minor type mismatches
In-Reply-To: <20170623082451.32671-1-alice.michael@intel.com>
References: <20170623082451.32671-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DAC02E@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, June 23, 2017 1:25 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S74-V2 01/10] i40e/i40evf: fix some
> minor type mismatches
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> This patch fixes two trivial type mismatches, one where we were returning
> an enum type, but pretending it was an int, and the other where we were
> using a void* for offset math, but it is communicated more clearly and
> correctly to use a u8*, which we then cast to void* for prefetch to use.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Change-ID: I8d9cf84a1ddbcff7f31eaad9e08880cad4a71f5f
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 4 ++--
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


