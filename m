From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 13 Jan 2016 17:26:26 +0000
Subject: [Intel-wired-lan] [next PATCH S24 02/12] i40e: Extend ethtool
 RSS	hooks for X722
In-Reply-To: <1450823114-29514-3-git-send-email-deepthi.kavalur@intel.com>
References: <1450823114-29514-1-git-send-email-deepthi.kavalur@intel.com>
 <1450823114-29514-3-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9800C6@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Deepthi Kavalur
> Sent: Tuesday, December 22, 2015 2:25 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S24 02/12] i40e: Extend ethtool RSS
> hooks for X722
> 
> From: Anjali Singhai Jain <anjali.singhai@intel.com>
> 
> This patch adds another way to access the RSS keys and lut using the AQ for
> X722 devices.
> 
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 53
> ++++++++++++++++++++++++++++-
>  1 file changed, 52 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied
