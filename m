From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 29 Aug 2018 18:09:13 +0000
Subject: [Intel-wired-lan] [next PATCH S96 1/9] i40e: Check and correct
 speed values for link on open
In-Reply-To: <20180828171609.78242-1-alice.michael@intel.com>
References: <20180828171609.78242-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2EB1D1@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Tuesday, August 28, 2018 10:16 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S96 1/9] i40e: Check and correct
> speed values for link on open
> 
> From: Jan Sokolowski <jan.sokolowski@intel.com>
> 
> If our card has been put in an unstable state due to other drivers interacting
> with it, speed settings might be incorrect. If incorrect, forcefully reset them
> on open to known default values.
> 
> Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 27
> ++++++++++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


