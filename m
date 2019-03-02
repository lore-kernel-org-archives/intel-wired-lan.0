From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Sat, 2 Mar 2019 00:21:59 +0000
Subject: [Intel-wired-lan] [next PATCH S3 1/9] i40e: Fix for allowing
 too many MDD events on VF
In-Reply-To: <20190228175255.54754-1-alice.michael@intel.com>
References: <20190228175255.54754-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3676C1@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Thursday, February 28, 2019 9:53 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S3 1/9] i40e: Fix for allowing too many
> MDD events on VF
> 
> From: Carolyn Wyborny <carolyn.wyborny@intel.com>
> 
> This patch changes the driver behavior when detecting a VF MDD event.
> It now disables the VF after one event, which indicates a hw detected
> problem in the VF.  Before this change, the PF would allow a couple of events
> before doing the reset.
> 
> Signed-off-by: Carolyn Wyborny <carolyn.wyborny@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


