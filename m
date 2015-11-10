From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 10 Nov 2015 21:21:06 +0000
Subject: [Intel-wired-lan] [PATCH v3 1/6] i40e: Remove CONFIG_I40E_VXLAN
In-Reply-To: <1447136740-77107-1-git-send-email-anjali.singhai@intel.com>
References: <1447136740-77107-1-git-send-email-anjali.singhai@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060E1FAB@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Anjali Singhai Jain
> Sent: Monday, November 09, 2015 10:26 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v3 1/6] i40e: Remove CONFIG_I40E_VXLAN
> 
> If the kernel flag CONFIG_VXLAN is true or CONFIG_VXLAN_MODULE is true,
> enable VXLAN offload in the driver.
> 
> v2: Fix bisection error for this patch series.
> 
> Signed-off-by: Kiran Patil <kiran.patil@intel.com>
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> ---
>  drivers/net/ethernet/intel/Kconfig          | 11 -----------
>  drivers/net/ethernet/intel/i40e/i40e.h      |  4 ----
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 14 ++++----------
>  3 files changed, 4 insertions(+), 25 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes altered by subsequent patch
