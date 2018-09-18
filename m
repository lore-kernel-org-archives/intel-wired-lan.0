From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 18 Sep 2018 14:57:45 +0000
Subject: [Intel-wired-lan] [PATCH net-next v2 02/14] iavf: diet and
 reformat
In-Reply-To: <20180915003757.169108-3-jesse.brandeburg@intel.com>
References: <20180915003757.169108-1-jesse.brandeburg@intel.com>
 <20180915003757.169108-3-jesse.brandeburg@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2ED3F7@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH net-next v2 02/14] iavf: diet and reformat
> 
> Remove a bunch of unused code and reformat a few lines. Also
> remove some now un-necessary files.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/i40e_adminq.c     |   27 -
>  drivers/net/ethernet/intel/iavf/i40e_adminq_cmd.h | 2277 +------------------
> --
>  drivers/net/ethernet/intel/iavf/i40e_common.c     |  337 ---
>  drivers/net/ethernet/intel/iavf/i40e_hmc.h        |  215 --
>  drivers/net/ethernet/intel/iavf/i40e_lan_hmc.h    |  158 --
>  drivers/net/ethernet/intel/iavf/i40e_prototype.h  |   65 +-
>  drivers/net/ethernet/intel/iavf/i40e_register.h   |  245 ---
>  drivers/net/ethernet/intel/iavf/i40e_type.h       |  783 +------
>  8 files changed, 50 insertions(+), 4057 deletions(-)
>  delete mode 100644 drivers/net/ethernet/intel/iavf/i40e_hmc.h
>  delete mode 100644 drivers/net/ethernet/intel/iavf/i40e_lan_hmc.h

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


