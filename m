From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 3 Apr 2019 21:56:27 +0000
Subject: [Intel-wired-lan] [next PATCH S4 03/11] i40e: Setting VF to
 VLAN 0 requires restart
In-Reply-To: <20190329220840.51187-3-alice.michael@intel.com>
References: <20190329220840.51187-1-alice.michael@intel.com>
 <20190329220840.51187-3-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3787B1@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, March 29, 2019 3:09 PM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Siwik, Grzegorz <grzegorz.siwik@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S4 03/11] i40e: Setting VF to VLAN 0
> requires restart
> 
> From: Grzegorz Siwik <grzegorz.siwik@intel.com>
> 
> This patch fixes a bug where changing VLAN to 0 was not set until VF restart.
> 
> Now we are setting pvid info to 0 when we have to change VLAN to 0.
> Without this change when VF VLAN was changed to 0 nothing happened until
> VF restart. For changing to VLAN different than 0 it worked correctly.
> 
> Signed-off-by: Grzegorz Siwik <grzegorz.siwik@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


