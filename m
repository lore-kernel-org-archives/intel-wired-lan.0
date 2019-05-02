From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 2 May 2019 21:44:30 +0000
Subject: [Intel-wired-lan] [next PATCH S4 iavf 2/9] iavf: change
 iavf_status_code to iavf_status
In-Reply-To: <20190417221737.11460-2-alice.michael@intel.com>
References: <20190417221737.11460-1-alice.michael@intel.com>
 <20190417221737.11460-2-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D39C47E@ORSMSX106.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S4 iavf 2/9] iavf: change
> iavf_status_code to iavf_status
> 
> From: Sergey Nemov <sergey.nemov@intel.com>
> 
> Instead of typedefing the enum iavf_status_code with iavf_status, just
> shorten the enum itself and get rid of typedef.
> 
> Signed-off-by: Sergey Nemov <sergey.nemov@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf.h        |  2 +-
>  drivers/net/ethernet/intel/iavf/iavf_adminq.c | 67 ++++++++++---------
> drivers/net/ethernet/intel/iavf/iavf_alloc.h  | 17 +++--
> drivers/net/ethernet/intel/iavf/iavf_client.c |  6 +-
> drivers/net/ethernet/intel/iavf/iavf_common.c | 53 ++++++++-------
>  drivers/net/ethernet/intel/iavf/iavf_main.c   | 20 +++---
>  drivers/net/ethernet/intel/iavf/iavf_osdep.h  |  1 -
> .../net/ethernet/intel/iavf/iavf_prototype.h  | 52 +++++++-------
> drivers/net/ethernet/intel/iavf/iavf_status.h |  2 +-
>  .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 14 ++--
>  10 files changed, 121 insertions(+), 113 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


