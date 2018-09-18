From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 18 Sep 2018 15:01:11 +0000
Subject: [Intel-wired-lan] [PATCH net-next v2 09/14] iavf: rename
 i40e_hw to iavf_hw
In-Reply-To: <20180915003757.169108-10-jesse.brandeburg@intel.com>
References: <20180915003757.169108-1-jesse.brandeburg@intel.com>
 <20180915003757.169108-10-jesse.brandeburg@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2ED45E@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH net-next v2 09/14] iavf: rename i40e_hw to
> iavf_hw
> 
> Fix up the i40e_hw names to new name, including versions inside other
> strings.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/i40e_adminq.c    | 42 +++++++--------
>  drivers/net/ethernet/intel/iavf/i40e_alloc.h     | 21 +++-----
>  drivers/net/ethernet/intel/iavf/i40e_common.c    | 30 +++++------
>  drivers/net/ethernet/intel/iavf/i40e_prototype.h | 65 +++++++++++---------
> ----
>  drivers/net/ethernet/intel/iavf/i40e_type.h      | 10 ++--
>  drivers/net/ethernet/intel/iavf/iavf.h           |  2 +-
>  drivers/net/ethernet/intel/iavf/iavf_main.c      | 52 +++++++++----------
>  drivers/net/ethernet/intel/iavf/iavf_txrx.c      |  2 +-
>  drivers/net/ethernet/intel/iavf/iavf_virtchnl.c  |  6 +--
>  9 files changed, 111 insertions(+), 119 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


