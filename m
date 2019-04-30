From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 30 Apr 2019 23:22:09 +0000
Subject: [Intel-wired-lan] [PATCH 2/4] i40e: Use LLDP ethertype define
 ETH_P_LLDP
In-Reply-To: <20190411161136.1541-3-anirudh.venkataramanan@intel.com>
References: <20190411161136.1541-1-anirudh.venkataramanan@intel.com>
 <20190411161136.1541-3-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D39B07E@ORSMSX106.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH 2/4] i40e: Use LLDP ethertype define
> ETH_P_LLDP
> 
> Remove references to I40E_ETH_P_LLDP and use ETH_P_LLDP instead.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h         | 2 --
>  drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 4 ++--
>  2 files changed, 2 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


