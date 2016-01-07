From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 7 Jan 2016 19:44:57 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: Enable Geneve offload for FW
 API	ver > 1.4 for XL710/X710 devices
In-Reply-To: <1452109768-89575-1-git-send-email-anjali.singhai@intel.com>
References: <1452109768-89575-1-git-send-email-anjali.singhai@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F97E4E8@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Anjali Singhai Jain
> Sent: Wednesday, January 06, 2016 11:49 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] i40e: Enable Geneve offload for FW API
> ver > 1.4 for XL710/X710 devices
> 
> This patch makes sure we check the GENEVE offload capable flag before we
> attempt offload.
> It also enables the Capability for XL710/X710 devices with FW API version
> higher than 1.4
> 
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, driver reports Geneve support w/ proper FW
