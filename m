From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 18 Sep 2018 15:03:11 +0000
Subject: [Intel-wired-lan] [PATCH net-next v2 13/14] iavf: finish
 renaming files to iavf
In-Reply-To: <20180915003757.169108-14-jesse.brandeburg@intel.com>
References: <20180915003757.169108-1-jesse.brandeburg@intel.com>
 <20180915003757.169108-14-jesse.brandeburg@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2ED49E@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH net-next v2 13/14] iavf: finish renaming
> files to iavf
> 
> This finishes the process of renaming the files that make sense to rename
> (skipping adminq related files that talk to i40e), and fixes up the build and the
> #includes so that everything builds nicely.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/Makefile                          | 2 +-
>  drivers/net/ethernet/intel/iavf/i40e_adminq.c                     | 8 ++++----
>  drivers/net/ethernet/intel/iavf/i40e_adminq.h                     | 4 ++--
>  drivers/net/ethernet/intel/iavf/iavf.h                            | 4 ++--
>  drivers/net/ethernet/intel/iavf/{i40e_alloc.h => iavf_alloc.h}    | 0
>  drivers/net/ethernet/intel/iavf/iavf_client.c                     | 2 +-
>  drivers/net/ethernet/intel/iavf/{i40e_common.c => iavf_common.c}  | 4 ++-
> -  drivers/net/ethernet/intel/iavf/{i40e_devids.h => iavf_devids.h}  | 0
>  drivers/net/ethernet/intel/iavf/iavf_main.c                       | 2 +-
>  drivers/net/ethernet/intel/iavf/{i40e_osdep.h => iavf_osdep.h}    | 0
>  .../ethernet/intel/iavf/{i40e_prototype.h => iavf_prototype.h}    | 4 ++--
>  .../net/ethernet/intel/iavf/{i40e_register.h => iavf_register.h}  | 0
> drivers/net/ethernet/intel/iavf/{i40e_status.h => iavf_status.h}  | 0
>  drivers/net/ethernet/intel/iavf/iavf_txrx.c                       | 2 +-
>  drivers/net/ethernet/intel/iavf/{i40e_type.h => iavf_type.h}      | 8 ++++----
>  drivers/net/ethernet/intel/iavf/iavf_virtchnl.c                   | 2 +-
>  16 files changed, 21 insertions(+), 21 deletions(-)  rename

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


