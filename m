From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 4 Sep 2019 22:30:27 +0000
Subject: [Intel-wired-lan] [PATCH v2 net-next 2/2] i40e: Implement debug
 macro hw_dbg using dev_dbg
In-Reply-To: <20190903192021.25789-2-maurosr@linux.vnet.ibm.com>
References: <20190903192021.25789-1-maurosr@linux.vnet.ibm.com>
 <20190903192021.25789-2-maurosr@linux.vnet.ibm.com>
Message-ID: <88b220e5a964498fbcf91e530ee67de0@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Mauro S. M. Rodrigues [mailto:maurosr at linux.vnet.ibm.com]
> Sent: Tuesday, September 3, 2019 12:20 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: intel-wired-lan at lists.osuosl.org; netdev at vger.kernel.org;
> davem at davemloft.net; Bowers, AndrewX <andrewx.bowers@intel.com>;
> Jakub Kicinski <jakub.kicinski@netronome.com>;
> maurosr at linux.vnet.ibm.com
> Subject: [PATCH v2 net-next 2/2] i40e: Implement debug macro hw_dbg
> using dev_dbg
> 
> There are several uses of hw_dbg in the code, producing no output. This
> patch implments it using dev_debug.
> 
> Initially the intention was to implement it using netdev_dbg, analogously to
> what is done in ixgbe for instance. That approach was avoided due to some
> early usages of hw_dbg, like i40e_pf_reset, before the vsi structure
> initialization causing NULL pointer dereference during the driver probe if the
> dbg messages were turned on as soon as the module is probed.
> 
> v2:
>  - Use dev_dbg instead of pr_debug, and take advantage of dev_name
> instead of crafting pretty much the same device name locally as suggested by
> Jakub Kicinski.
> 
> Signed-off-by: Mauro S. M. Rodrigues <maurosr@linux.vnet.ibm.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c | 1 +
>  drivers/net/ethernet/intel/i40e/i40e_hmc.c    | 1 +
>  drivers/net/ethernet/intel/i40e/i40e_osdep.h  | 5 ++++-
>  3 files changed, 6 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


