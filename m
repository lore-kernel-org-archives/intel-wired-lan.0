From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 17 May 2017 21:50:51 +0000
Subject: [Intel-wired-lan] [PATCH 2/4] ixgbe: Resolve warnings
	for	-Wimplicit-fallthrough
In-Reply-To: <20170512183810.26185-2-anthony.l.nguyen@intel.com>
References: <20170512183810.26185-1-anthony.l.nguyen@intel.com>
 <20170512183810.26185-2-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DA390E@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Friday, May 12, 2017 11:38 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 2/4] ixgbe: Resolve warnings for -Wimplicit-
> fallthrough
> 
> This patch adds/changes fall through comments to address new warnings
> produced by gcc 7.
> 
> Fixed formatting on a couple of comments in the function.
> 
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c   | 9 ++++++---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_common.c  | 4 ++--
> drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 1 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    | 8 ++++++--
>  drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c   | 7 +++----
>  5 files changed, 18 insertions(+), 11 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


