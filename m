From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 11 May 2018 18:16:48 +0000
Subject: [Intel-wired-lan] [next PATCH S91-V1 11/11] i40evf: Fix a
 hardware reset support in VF driver
In-Reply-To: <20180510125949.79823-11-alice.michael@intel.com>
References: <20180510125949.79823-1-alice.michael@intel.com>
 <20180510125949.79823-11-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1B76514A@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Thursday, May 10, 2018 6:00 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Jablonski, Pawel <pawel.jablonski@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S91-V1 11/11] i40evf: Fix a hardware
> reset support in VF driver
> 
> From: Pawe? Jab?o?ski <pawel.jablonski@intel.com>
> 
> This patch fixes a hardware reset support in VF driver.
> It is needed because when a hardware reset is detected
> adapter->state is in __I40EVF_RESETTING state before
> i40evf_reset_task is called. Without this patch unloading VF driver after a
> hardware reset ends with a system crash.
> 
> Signed-off-by: Pawe? Jab?o?ski <pawel.jablonski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c     | 21
> +++++++++++++++++++--
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c |  3 ++-
>  2 files changed, 21 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


