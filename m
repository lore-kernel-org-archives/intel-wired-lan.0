From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 18 Sep 2018 14:59:45 +0000
Subject: [Intel-wired-lan] [PATCH net-next v2 06/14] iavf: remove
 references to old names
In-Reply-To: <20180915003757.169108-7-jesse.brandeburg@intel.com>
References: <20180915003757.169108-1-jesse.brandeburg@intel.com>
 <20180915003757.169108-7-jesse.brandeburg@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2ED432@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH net-next v2 06/14] iavf: remove references
> to old names
> 
> Remove the register name references to I40E_VF* and change to IAVF_VF.
> Update the descriptor names and defines to the IAVF name.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/i40e_adminq.c   |  28 ++--
>  drivers/net/ethernet/intel/iavf/i40e_common.c   |   2 +-
>  drivers/net/ethernet/intel/iavf/i40e_osdep.h    |   2 +-
>  drivers/net/ethernet/intel/iavf/i40e_register.h | 128 +++++++++---------
>  drivers/net/ethernet/intel/iavf/i40e_type.h     | 170 ++++++++++++----------
> --
>  drivers/net/ethernet/intel/iavf/iavf.h          |  10 +-
>  drivers/net/ethernet/intel/iavf/iavf_main.c     |  92 ++++++-------
>  drivers/net/ethernet/intel/iavf/iavf_txrx.c     | 104 +++++++--------
>  drivers/net/ethernet/intel/iavf/iavf_txrx.h     |   2 +-
>  9 files changed, 267 insertions(+), 271 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


