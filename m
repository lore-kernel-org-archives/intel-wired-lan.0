From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 6 Oct 2015 20:58:36 +0000
Subject: [Intel-wired-lan] [next PATCH S18 6/8] i40e: Fix an incorrect
 OEM	version string
In-Reply-To: <1443724661-92168-7-git-send-email-catherine.sullivan@intel.com>
References: <1443724661-92168-1-git-send-email-catherine.sullivan@intel.com>
 <1443724661-92168-7-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060B37E8@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Thursday, October 01, 2015 11:38 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S18 6/8] i40e: Fix an incorrect OEM
> version string
> 
> From: Carolyn Wyborny <carolyn.wyborny@intel.com>
> 
> This patch fixes a problem where the driver output of the oem version string
> varied from the other tools.  The mask value and the order of operations
> were incorrect, per the DCR.
> Without this patch, the version string will appear incorrect from the driver.
> 
> Signed-off-by: Carolyn Wyborny <carolyn.wyborny@intel.com>
> Change-ID: Ie1ca6485284b4ce3b57e5a99b18b7641617c7ef7
> 
> ---
> Testing-hints: 5646237
>  drivers/net/ethernet/intel/i40e/i40e.h | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, version output from dmesg and ethtool is correct
