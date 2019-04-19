From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 19 Apr 2019 17:13:58 +0000
Subject: [Intel-wired-lan] [PATCH 3/4] ixgbe: Use LLDP ethertype define
 ETH_P_LLDP
In-Reply-To: <20190411161136.1541-4-anirudh.venkataramanan@intel.com>
References: <20190411161136.1541-1-anirudh.venkataramanan@intel.com>
 <20190411161136.1541-4-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D38EE24@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Thursday, April 11, 2019 9:12 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 3/4] ixgbe: Use LLDP ethertype define
> ETH_P_LLDP
> 
> Remove references to IXGBE_ETH_P_LLD and use ETH_P_LLDP instead.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h       | 2 --
>  drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c | 2 +-
>  2 files changed, 1 insertion(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


