From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 11 Aug 2016 20:12:01 +0000
Subject: [Intel-wired-lan] [next PATCH S41-V2 4/5] i40e: Fix byte
 ordering	in ARP NS code for X722
In-Reply-To: <1470335825-15534-5-git-send-email-bimmy.pujari@intel.com>
References: <1470335825-15534-1-git-send-email-bimmy.pujari@intel.com>
 <1470335825-15534-5-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9F8A59@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Thursday, August 04, 2016 11:37 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S41-V2 4/5] i40e: Fix byte ordering in
> ARP NS code for X722
> 
> From: Carolyn Wyborny <carolyn.wyborny@intel.com>
> 
> This patch fixes byte ordering problems found when enabling this feature
> support. Without this patch, the feature will not work correctly. This patch
> fixes the definitions to have the correct byte order.
> 
> Signed-off-by: Carolyn Wyborny <carolyn.wyborny@intel.com>
> Change-ID: Ic7489fbcbe2195df7be62ff5e359201b827cefe6
> ---
>  drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h  | 38 ++++++++++++--
> --------
>  .../net/ethernet/intel/i40evf/i40e_adminq_cmd.h    | 38 ++++++++++++-----
> -----
>  2 files changed, 42 insertions(+), 34 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
