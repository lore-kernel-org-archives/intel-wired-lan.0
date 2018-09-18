From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 18 Sep 2018 15:03:42 +0000
Subject: [Intel-wired-lan] [PATCH net-next v2 14/14] intel-ethernet: use
 correct module license
In-Reply-To: <20180915003757.169108-15-jesse.brandeburg@intel.com>
References: <20180915003757.169108-1-jesse.brandeburg@intel.com>
 <20180915003757.169108-15-jesse.brandeburg@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2ED4AF@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jesse Brandeburg
> Sent: Friday, September 14, 2018 5:38 PM
> To: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net-next v2 14/14] intel-ethernet: use
> correct module license
> 
> We recently updated all our SPDX identifiers to correctly indicate our
> net/ethernet/intel/* drivers were always released and intended to be
> released under GPL v2, but the MODULE_LICENSE declaration was never
> updated.
> 
> Fix the MODULE_LICENSE to be GPL v2, for all our drivers.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>  drivers/net/ethernet/intel/e100.c                 | 2 +-
>  drivers/net/ethernet/intel/e1000/e1000_main.c     | 2 +-
>  drivers/net/ethernet/intel/e1000e/netdev.c        | 2 +-
>  drivers/net/ethernet/intel/fm10k/fm10k_main.c     | 2 +-
>  drivers/net/ethernet/intel/i40e/i40e_main.c       | 2 +-
>  drivers/net/ethernet/intel/iavf/iavf_main.c       | 4 ++--
>  drivers/net/ethernet/intel/ice/ice_main.c         | 2 +-
>  drivers/net/ethernet/intel/igb/igb_main.c         | 2 +-
>  drivers/net/ethernet/intel/igbvf/netdev.c         | 2 +-
>  drivers/net/ethernet/intel/ixgb/ixgb_main.c       | 2 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c     | 2 +-
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 2 +-
>  12 files changed, 13 insertions(+), 13 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


