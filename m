From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 2 May 2019 21:44:01 +0000
Subject: [Intel-wired-lan] [next PATCH S4 iavf 1/9] iavf: Rename
 i40e_adminq* files to iavf_adminq*
In-Reply-To: <20190417221737.11460-1-alice.michael@intel.com>
References: <20190417221737.11460-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D39C46F@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, April 17, 2019 3:17 PM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S4 iavf 1/9] iavf: Rename
> i40e_adminq* files to iavf_adminq*
> 
> With the rename of the iavf driver, there were some files that were missed
> in renaming.  Update these to be iavf as well.
> 
> Signed-off-by: Alice Michael <alice.michael@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/Makefile                        | 2 +-
>  .../net/ethernet/intel/iavf/{i40e_adminq.c => iavf_adminq.c}    | 2 +-
>  .../net/ethernet/intel/iavf/{i40e_adminq.h => iavf_adminq.h}    | 2 +-
>  .../intel/iavf/{i40e_adminq_cmd.h => iavf_adminq_cmd.h}         | 0
>  drivers/net/ethernet/intel/iavf/iavf_common.c                   | 2 +-
>  drivers/net/ethernet/intel/iavf/iavf_type.h                     | 2 +-
>  6 files changed, 5 insertions(+), 5 deletions(-)  rename

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


