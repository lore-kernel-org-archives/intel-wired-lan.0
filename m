From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 29 Apr 2019 18:09:53 +0000
Subject: [Intel-wired-lan] [PATCH S20 01/15] ice: Remove direct write
 for GLLAN_RCTL_0
In-Reply-To: <20190416173052.28928-2-anirudh.venkataramanan@intel.com>
References: <20190416173052.28928-1-anirudh.venkataramanan@intel.com>
 <20190416173052.28928-2-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D39AC2F@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Tuesday, April 16, 2019 10:31 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S20 01/15] ice: Remove direct write for
> GLLAN_RCTL_0
> 
> Clear PXE mode AQ call (opcode 0x0110) is now supported in FW. So remove
> the direct register write to GLLAN_RCTL_0.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c | 3 ---
>  1 file changed, 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


