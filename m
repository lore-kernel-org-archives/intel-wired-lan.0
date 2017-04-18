From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 18 Apr 2017 19:15:10 +0000
Subject: [Intel-wired-lan] [PATCH v2 1/3] ixgbe: Check for RSS key
 before	setting value
In-Reply-To: <20170413142607.7364-1-anthony.l.nguyen@intel.com>
References: <20170413142607.7364-1-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DA0CE9@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, April 13, 2017 7:26 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v2 1/3] ixgbe: Check for RSS key before
> setting value
> 
> The RSS key is being repopulated every time the interface is brought up
> regardless of whether there is an existing value. If the user sets the RSS key
> and the interface is brought up (e.g. reset), the user specified RSS key will be
> overwritten.
> 
> This patch changes the rss_key to a pointer so we can check to see if the key
> has been populated and preserve it accordingly.
> 
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h         |  2 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |  4 +---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    | 30
> ++++++++++++++++++++++--
>  drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c   |  2 +-
>  4 files changed, 31 insertions(+), 7 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


