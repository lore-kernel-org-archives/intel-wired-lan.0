From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 18 Sep 2018 14:58:13 +0000
Subject: [Intel-wired-lan] [PATCH net-next v2 03/14] iavf: rename
 functions and structs to new name
In-Reply-To: <20180915003757.169108-4-jesse.brandeburg@intel.com>
References: <20180915003757.169108-1-jesse.brandeburg@intel.com>
 <20180915003757.169108-4-jesse.brandeburg@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2ED404@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH net-next v2 03/14] iavf: rename functions
> and structs to new name
> 
> This basically begins the internal portion of the rename of i40evf to iavf,
> by renaming many of the functions, structs, variables and defines.
> 
> Most of the changes were made mechanically, which introduces some
> alignment issues.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/i40e_adminq.c     |   38 +-
>  drivers/net/ethernet/intel/iavf/i40e_adminq.h     |    3 +-
>  drivers/net/ethernet/intel/iavf/i40e_common.c     |   89 +-
>  drivers/net/ethernet/intel/iavf/i40e_osdep.h      |   12 +-
>  drivers/net/ethernet/intel/iavf/i40e_prototype.h  |   40 +-
>  drivers/net/ethernet/intel/iavf/i40e_trace.h      |   26 +-
>  drivers/net/ethernet/intel/iavf/i40e_txrx.c       |   94 +-
>  drivers/net/ethernet/intel/iavf/i40e_txrx.h       |   36 +-
>  drivers/net/ethernet/intel/iavf/i40evf.h          |  362 +++---
>  drivers/net/ethernet/intel/iavf/i40evf_client.c   |  184 +--
>  drivers/net/ethernet/intel/iavf/i40evf_client.h   |   30 +-
>  drivers/net/ethernet/intel/iavf/i40evf_ethtool.c  |  364 +++---
>  drivers/net/ethernet/intel/iavf/i40evf_main.c     | 1424 ++++++++++---------
> --
>  drivers/net/ethernet/intel/iavf/i40evf_virtchnl.c |  402 +++---
>  14 files changed, 1550 insertions(+), 1554 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


