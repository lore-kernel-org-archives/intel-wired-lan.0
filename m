From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 18 Sep 2018 14:59:19 +0000
Subject: [Intel-wired-lan] [PATCH net-next v2 05/14] iavf: move i40evf
 files to new name
In-Reply-To: <20180915003757.169108-6-jesse.brandeburg@intel.com>
References: <20180915003757.169108-1-jesse.brandeburg@intel.com>
 <20180915003757.169108-6-jesse.brandeburg@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2ED423@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH net-next v2 05/14] iavf: move i40evf files to
> new name
> 
> Simply move the i40evf files to the new name, updating the #includes to
> track the new names, and updating the Makefile as well.
> 
> A future patch will remove the i40e references (after the code removal
> patches later in this series).
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/Makefile                              | 4 ++--
>  drivers/net/ethernet/intel/iavf/{i40evf.h => iavf.h}                  | 2 +-
>  drivers/net/ethernet/intel/iavf/{i40evf_client.c => iavf_client.c}    | 4 ++--
>  drivers/net/ethernet/intel/iavf/{i40evf_client.h => iavf_client.h}    | 0
>  drivers/net/ethernet/intel/iavf/{i40evf_ethtool.c => iavf_ethtool.c}  | 2 +-
>  drivers/net/ethernet/intel/iavf/{i40evf_main.c => iavf_main.c}        | 4 ++--
>  drivers/net/ethernet/intel/iavf/{i40e_txrx.c => iavf_txrx.c}          | 2 +-
>  drivers/net/ethernet/intel/iavf/{i40e_txrx.h => iavf_txrx.h}          | 0
>  .../net/ethernet/intel/iavf/{i40evf_virtchnl.c => iavf_virtchnl.c}    | 4 ++--
>  9 files changed, 11 insertions(+), 11 deletions(-)  rename
> drivers/net/ethernet/intel/iavf/{i40evf.h => iavf.h} (99%)  rename
> drivers/net/ethernet/intel/iavf/{i40evf_client.c => iavf_client.c} (99%)
> rename drivers/net/ethernet/intel/iavf/{i40evf_client.h => iavf_client.h}
> (100%)  rename drivers/net/ethernet/intel/iavf/{i40evf_ethtool.c =>
> iavf_ethtool.c} (99%)  rename
> drivers/net/ethernet/intel/iavf/{i40evf_main.c => iavf_main.c} (99%)
> rename drivers/net/ethernet/intel/iavf/{i40e_txrx.c => iavf_txrx.c} (99%)
> rename drivers/net/ethernet/intel/iavf/{i40e_txrx.h => iavf_txrx.h} (100%)
> rename drivers/net/ethernet/intel/iavf/{i40evf_virtchnl.c => iavf_virtchnl.c}
> (99%)
> 


Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


