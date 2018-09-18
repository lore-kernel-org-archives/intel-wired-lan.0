From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 18 Sep 2018 15:01:40 +0000
Subject: [Intel-wired-lan] [PATCH net-next v2 10/14] iavf: replace
 i40e_debug with iavf version
In-Reply-To: <20180915003757.169108-11-jesse.brandeburg@intel.com>
References: <20180915003757.169108-1-jesse.brandeburg@intel.com>
 <20180915003757.169108-11-jesse.brandeburg@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2ED46E@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH net-next v2 10/14] iavf: replace
> i40e_debug with iavf version
> 
> Change another string (i40e_debug)
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/i40e_adminq.c    | 28 ++++++++++++---------
> ---
>  drivers/net/ethernet/intel/iavf/i40e_common.c    | 12 +++++-----
>  drivers/net/ethernet/intel/iavf/i40e_osdep.h     |  2 +-
>  drivers/net/ethernet/intel/iavf/i40e_prototype.h |  2 +-
>  drivers/net/ethernet/intel/iavf/i40e_type.h      |  2 +-
>  5 files changed, 23 insertions(+), 23 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


