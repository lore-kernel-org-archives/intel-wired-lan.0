From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 19 Apr 2019 17:14:24 +0000
Subject: [Intel-wired-lan] [PATCH 4/4] net: hns3: Use LLDP ethertype
 define ETH_P_LLDP
In-Reply-To: <20190411161136.1541-5-anirudh.venkataramanan@intel.com>
References: <20190411161136.1541-1-anirudh.venkataramanan@intel.com>
 <20190411161136.1541-5-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D38EE38@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH 4/4] net: hns3: Use LLDP ethertype define
> ETH_P_LLDP
> 
> Remove references to HCLGE_MAC_ETHERTYPE_LLDP and use ETH_P_LLDP
> instead.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h  | 1 -
> drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 2 +-
>  2 files changed, 1 insertion(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


