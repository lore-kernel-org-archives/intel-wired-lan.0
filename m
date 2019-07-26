From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 26 Jul 2019 21:44:50 +0000
Subject: [Intel-wired-lan] [next PATCH S8 02/12] i40e: Add drop mode
 parameter to set mac config
In-Reply-To: <20190723100144.57435-2-alice.michael@intel.com>
References: <20190723100144.57435-1-alice.michael@intel.com>
 <20190723100144.57435-2-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40CE68@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Tuesday, July 23, 2019 3:02 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Wnuczko, Sylwia <sylwia.wnuczko@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S8 02/12] i40e: Add drop mode
> parameter to set mac config
> 
> From: Sylwia Wnuczko <sylwia.wnuczko@intel.com>
> 
> This patch adds "drop mode" parameter to set mac config AQ command.
> This bit controls the behavior when a no-drop packet is blocking a TC queue.
> 0 ? The PF driver is notified.
> 1 ? The blocking packet is dropped and then the PF driver is notified.
> 
> Signed-off-by: Sylwia Wnuczko <sylwia.wnuczko@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_adminq.c |  4 ++-
> .../net/ethernet/intel/i40e/i40e_adminq_cmd.h | 29 ++++++++++---------
>  drivers/net/ethernet/intel/i40e/i40e_type.h   |  1 +
>  3 files changed, 19 insertions(+), 15 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


