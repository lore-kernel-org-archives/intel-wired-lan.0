From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 10 Nov 2015 20:59:25 +0000
Subject: [Intel-wired-lan] [PATCH v4 1/6] i40e: Remove CONFIG_I40E_VXLAN
In-Reply-To: <1447178205-99510-1-git-send-email-anjali.singhai@intel.com>
References: <1447178205-99510-1-git-send-email-anjali.singhai@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060E1F18@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Anjali Singhai Jain
> Sent: Tuesday, November 10, 2015 9:57 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v4 1/6] i40e: Remove CONFIG_I40E_VXLAN
> 
> If the kernel flag CONFIG_VXLAN is true or CONFIG_VXLAN_MODULE is true,
> enable VXLAN offload in the driver.
> 
> v2: Fix bisection error for this patch series.
> 
> Signed-off-by: Kiran Patil <kiran.patil@intel.com>
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h      |  2 --
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 10 ++--------
>  2 files changed, 2 insertions(+), 10 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes altered by subesquent patch
