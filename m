From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 12 Sep 2017 21:41:46 +0000
Subject: [Intel-wired-lan] [next PATCH S80-V3 07/11] i40e/i40evf:
	bundle	more descriptors when allocating buffers
In-Reply-To: <20170907120556.45699-7-alice.michael@intel.com>
References: <20170907120556.45699-1-alice.michael@intel.com>
 <20170907120556.45699-7-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAA0FA@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Thursday, September 7, 2017 5:06 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S80-V3 07/11] i40e/i40evf: bundle
> more descriptors when allocating buffers
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Double the number of descriptors we'll bundle into one tail bump when
> receiving. Empirical testing has shown that we reduce CPU utilization and
> don't appear to reduce throughput or packet rate. 32 seems to be the sweet
> spot, as it's half the default polling budget, so we'd essentially reduce from 4
> tail writes when polling down to 2. Increasing this up to
> 64 appears to have negative impacts as it may become possible that we don't
> bump the tail each time we get polled, which could cause a long delay
> between returning descriptors to the hardware.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h   | 2 +-
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


