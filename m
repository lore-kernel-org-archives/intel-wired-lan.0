From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Tue, 3 Apr 2018 19:25:57 +0000
Subject: [Intel-wired-lan] [PATCH] ice: Bug fixes in ethtool code
In-Reply-To: <20180402162606.16234-1-anirudh.venkataramanan@intel.com>
References: <20180402162606.16234-1-anirudh.venkataramanan@intel.com>
Message-ID: <C25D919FD1849B409D8D987DDC7FCD26194A4F98@ORSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Monday, April 2, 2018 9:26 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ice: Bug fixes in ethtool code
> 
> 1) Return correct size from ice_get_regs_len.
> 2) Fix incorrect use of ARRAY_SIZE in ice_get_regs.
> 
> Fixes: fcea6f3da546 (ice: Add stats and ethtool support)
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com>


