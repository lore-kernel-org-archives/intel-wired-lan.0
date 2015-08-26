From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 26 Aug 2015 23:45:17 +0000
Subject: [Intel-wired-lan] [PATCH 1/4] i40e: Remove CONFIG_I40E_VXLAN
In-Reply-To: <1440096383-8915-1-git-send-email-anjali.singhai@intel.com>
References: <1440096383-8915-1-git-send-email-anjali.singhai@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0609C5F3@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Anjali Singhai Jain
> Sent: Thursday, August 20, 2015 11:46 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 1/4] i40e: Remove CONFIG_I40E_VXLAN
> 
> If the kernel flag CONFIG_VXLAN is true or CONFIG_VXLAN_MODULE is true,
> enable VXLAN offload in the driver.
> 
> Signed-off-by: Kiran Patil <kiran.patil@intel.com>
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> ---
>  drivers/net/ethernet/intel/Kconfig          | 11 -----------
>  drivers/net/ethernet/intel/i40e/i40e.h      |  4 ----
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 14 ++++----------
>  3 files changed, 4 insertions(+), 25 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Present in GIT log, code changes present in tree, will pass traffic when configured, traffic appears as expected in Wireshark.
