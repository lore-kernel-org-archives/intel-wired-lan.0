From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 21 Jul 2017 18:51:20 +0000
Subject: [Intel-wired-lan] [next PATCH S77-V3 05/10] i40e: don't
	clear	suspended state until we finish resuming
In-Reply-To: <20170714132709.52657-5-alice.michael@intel.com>
References: <20170714132709.52657-1-alice.michael@intel.com>
 <20170714132709.52657-5-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DB2748@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, July 14, 2017 6:27 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S77-V3 05/10] i40e: don't clear
> suspended state until we finish resuming
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> When handling suspend and resume callbacks we want to make sure that (a)
> we don't suspend again if we're already suspended and (b) we don't resume
> again if we're already resuming. Lets make sure we test_and_set the
> __I40E_SUSPENDED bit in i40e_suspend which ensures that a suspend call
> when already suspended will exit early. Additionally, if __I40E_SUSPENDED is
> not set when we begin resuming, exit early as well.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


