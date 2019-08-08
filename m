From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 8 Aug 2019 18:09:35 +0000
Subject: [Intel-wired-lan] [PATCH 1/2] i40e: fix hw_dbg usage in
 i40e_hmc_get_object_va
In-Reply-To: <20190806133348.17924-1-maurosr@linux.vnet.ibm.com>
References: <20190806133348.17924-1-maurosr@linux.vnet.ibm.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40F4AC@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Mauro S. M. Rodrigues
> Sent: Tuesday, August 6, 2019 6:34 AM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Subject: [Intel-wired-lan] [PATCH 1/2] i40e: fix hw_dbg usage in
> i40e_hmc_get_object_va
> 
> The mentioned function references a i40e_hw attribute, as parameter for
> hw_dbg, but it doesn't exist in the function scope.
> Fixes it by changing  parameters from i40e_hmc_info to i40e_hw which can
> retrieve the necessary i40e_hmc_info.
> 
> Signed-off-by: Mauro S. M. Rodrigues <maurosr@linux.vnet.ibm.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_lan_hmc.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


