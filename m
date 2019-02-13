From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 13 Feb 2019 20:24:33 +0000
Subject: [Intel-wired-lan] [next PATCH S2-V2 12/12] i40e: Fix misleading
 error message
In-Reply-To: <20190206230826.24970-12-alice.michael@intel.com>
References: <20190206230826.24970-1-alice.michael@intel.com>
 <20190206230826.24970-12-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D36601F@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, February 6, 2019 3:08 PM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S2-V2 12/12] i40e: Fix misleading error
> message
> 
> From: Carolyn Wyborny <carolyn.wyborny@intel.com>
> 
> This patch changes an error code for an admin queue head overrun to use
> I40E_ERR_ADMIN_QUEUE_FULL instead of I40E_ERR_QUEUE_EMPTY.
> 
> Signed-off-by: Carolyn Wyborny <carolyn.wyborny@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_adminq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


