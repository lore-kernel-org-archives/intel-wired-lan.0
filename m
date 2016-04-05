From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 5 Apr 2016 20:07:18 +0000
Subject: [Intel-wired-lan] [v3 next PATCH S32 07/13] i40e: Patch to
 support	trusted VF
In-Reply-To: <1459508173-22777-8-git-send-email-harshitha.ramamurthy@intel.com>
References: <1459508173-22777-1-git-send-email-harshitha.ramamurthy@intel.com>
 <1459508173-22777-8-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9ACBFC@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Harshitha Ramamurthy
> Sent: Friday, April 01, 2016 3:56 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [v3 next PATCH S32 07/13] i40e: Patch to support
> trusted VF
> 
> From: Anjali Singhai Jain <anjali.singhai@intel.com>
> 
> This patch adds hook to support changing a VF from not-trusted to trusted
> and vice-versa. Fixed the wrappers and function prototype.
> Changed the dmesg to reflex the current state better. This patch also
> disables turning on/off trusted VF in MFP mode.
> 
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> Change-ID: Ibcd910935c01f0be1f3fdd6d427230291ee92ebe
> ---
> Testing Hints : Test the feature with ip link set dev eth0 vf 1 trust on or ip link
> set dev eth0 vf 1 trust off
> 
>  drivers/net/ethernet/intel/i40e/i40e_main.c        |  1 +
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 42
> ++++++++++++++++++++++
> drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h |  2 ++
>  3 files changed, 45 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
dmesg reflects VF trust status when changed
