From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 8 Aug 2019 18:10:05 +0000
Subject: [Intel-wired-lan] [PATCH 2/2] i40e: Implement debug macro
 hw_dbg using pr_debug
In-Reply-To: <20190806133348.17924-2-maurosr@linux.vnet.ibm.com>
References: <20190806133348.17924-1-maurosr@linux.vnet.ibm.com>
 <20190806133348.17924-2-maurosr@linux.vnet.ibm.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40F4BD@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH 2/2] i40e: Implement debug macro hw_dbg
> using pr_debug
> 
> There are several uses of hw_dbg in the code, producing no output. This
> patch implments it using pr_debug.
> 
> Initially the intention was to implement it using netdev_dbg, analogously to
> what is done in ixgbe for instance. That approach was avoided due to some
> early usages of hw_dbg, like i40e_pf_reset, before the vsi structure
> initialization causing NULL pointer dereference during the driver probe if the
> dbg messages were turned on as soon as the module is probed.
> 
> Signed-off-by: Mauro S. M. Rodrigues <maurosr@linux.vnet.ibm.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c | 1 +
>  drivers/net/ethernet/intel/i40e/i40e_hmc.c    | 1 +
>  drivers/net/ethernet/intel/i40e/i40e_osdep.h  | 7 ++++++-
>  3 files changed, 8 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


