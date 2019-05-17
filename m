From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 17 May 2019 22:27:22 +0000
Subject: [Intel-wired-lan] [next PATCH S5 iavf 07/11] iavf: Remove timer
 for work triggering, use delaying work instead
In-Reply-To: <20190514173709.62431-7-alice.michael@intel.com>
References: <20190514173709.62431-1-alice.michael@intel.com>
 <20190514173709.62431-7-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3DB758@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Tuesday, May 14, 2019 10:37 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Pawlak, Jakub <jakub.pawlak@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S5 iavf 07/11] iavf: Remove timer for
> work triggering, use delaying work instead
> 
> From: Jakub Pawlak <jakub.pawlak@intel.com>
> 
> Remove the watchdog timer, instead declare watchdog task as delayed work
> and use dedicated workqueue to service driver tasks. The dedicated driver
> workqueue iavf_wq is common for all driver instances.
> 
> Signed-off-by: Jakub Pawlak <jakub.pawlak@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf.h        |  4 +-
>  .../net/ethernet/intel/iavf/iavf_ethtool.c    |  4 +-
>  drivers/net/ethernet/intel/iavf/iavf_main.c   | 66 ++++++++-----------
>  .../net/ethernet/intel/iavf/iavf_virtchnl.c   |  2 +-
>  4 files changed, 31 insertions(+), 45 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


