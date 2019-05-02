From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 2 May 2019 21:45:45 +0000
Subject: [Intel-wired-lan] [next PATCH S4 iavf 5/9] iavf: rename
 iavf_status structure flags
In-Reply-To: <20190417221737.11460-5-alice.michael@intel.com>
References: <20190417221737.11460-1-alice.michael@intel.com>
 <20190417221737.11460-5-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D39C4AD@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, April 17, 2019 3:18 PM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S4 iavf 5/9] iavf: rename iavf_status
> structure flags
> 
> rename the flags inside of iavf_status from I40E_* to IAVF_*
> 
> Signed-off-by: Alice Michael <alice.michael@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_adminq.c |  42 +--
>  drivers/net/ethernet/intel/iavf/iavf_adminq.h |   2 +-
>  drivers/net/ethernet/intel/iavf/iavf_client.c |   6 +-
>  drivers/net/ethernet/intel/iavf/iavf_common.c | 266 +++++++++---------
>  drivers/net/ethernet/intel/iavf/iavf_main.c   |  38 +--
>  drivers/net/ethernet/intel/iavf/iavf_status.h | 134 ++++-----
>  .../net/ethernet/intel/iavf/iavf_virtchnl.c   |   2 +-
>  7 files changed, 245 insertions(+), 245 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
