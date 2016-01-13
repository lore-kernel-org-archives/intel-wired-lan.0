From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 13 Jan 2016 19:32:26 +0000
Subject: [Intel-wired-lan] [v2 next PATCH] i40e: add priv flag for
 automatic	rule eviction
In-Reply-To: <1452304221-8276-1-git-send-email-deepthi.kavalur@intel.com>
References: <1452304221-8276-1-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F980237@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Deepthi Kavalur
> Sent: Friday, January 08, 2016 5:50 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [v2 next PATCH] i40e: add priv flag for automatic
> rule eviction
> 
> From: Anjali Singhai Jain <anjali.singhai@intel.com>
> 
> The X722 can support automatic rule eviction for automatically added flow
> director rules.  Feature is (should be) disabled by default.
> 
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h         | 1 +
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 9 +++++++++
>  drivers/net/ethernet/intel/i40e/i40e_main.c    | 3 +++
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c    | 6 ++++--
>  drivers/net/ethernet/intel/i40e/i40e_type.h    | 4 ++++
>  5 files changed, 21 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, hw-atr-eviction priv flag shown in Ethtool
