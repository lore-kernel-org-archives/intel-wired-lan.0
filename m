From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 2 May 2019 21:45:23 +0000
Subject: [Intel-wired-lan] [next PATCH S4 iavf 4/9] iavf: replace i40e
 variables with iavf
In-Reply-To: <20190417221737.11460-4-alice.michael@intel.com>
References: <20190417221737.11460-1-alice.michael@intel.com>
 <20190417221737.11460-4-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D39C49F@ORSMSX106.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S4 iavf 4/9] iavf: replace i40e variables
> with iavf
> 
> Update the old variables and flags marked as i40e to match
> the iavf name of the driver.
> 
> Signed-off-by: Alice Michael <alice.michael@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_adminq.c |  80 +--
>  drivers/net/ethernet/intel/iavf/iavf_adminq.h |  72 +-
>  .../net/ethernet/intel/iavf/iavf_adminq_cmd.h | 656 +++++++++---------
>  drivers/net/ethernet/intel/iavf/iavf_common.c | 182 ++---
>  .../net/ethernet/intel/iavf/iavf_ethtool.c    |  12 +-
>  drivers/net/ethernet/intel/iavf/iavf_main.c   |  18 +-
>  .../net/ethernet/intel/iavf/iavf_prototype.h  |  14 +-
>  drivers/net/ethernet/intel/iavf/iavf_txrx.c   |  12 +-
>  drivers/net/ethernet/intel/iavf/iavf_type.h   |   2 +-
>  .../net/ethernet/intel/iavf/iavf_virtchnl.c   |  16 +-
>  10 files changed, 532 insertions(+), 532 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


