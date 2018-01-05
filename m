From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 5 Jan 2018 19:16:14 +0000
Subject: [Intel-wired-lan] [next PATCH S85-V1 04/14] i40e/i40evf: Only
 track one itr setting per ring instead of Tx/Rx
In-Reply-To: <20171229134928.14308-1-alice.michael@intel.com>
References: <20171229134928.14308-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A8D71F5@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, December 29, 2017 5:49 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S85-V1 04/14] i40e/i40evf: Only track
> one itr setting per ring instead of Tx/Rx
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> The rings are already split out into Tx and Rx rings so it does't make sense to
> have any single ring store both a Tx and Rx itr_setting value.
> Since that is the case drop the pair in favor of storing just a single ITR value.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_debugfs.c     | 12 ++++----
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c     | 32 +++++++++++---------
> --
>  drivers/net/ethernet/intel/i40e/i40e_main.c        | 14 +++++-----
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c        |  6 ++--
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h        |  3 +-
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c      |  6 ++--
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.h      |  3 +-
>  drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c | 24 ++++++++--------
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c    |  8 +++---
>  9 files changed, 53 insertions(+), 55 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


