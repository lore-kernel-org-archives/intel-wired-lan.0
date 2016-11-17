From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 17 Nov 2016 21:35:00 +0000
Subject: [Intel-wired-lan] [next PATCH S53-V2 3/5] i40e: Add FEC for 25g
In-Reply-To: <1479157609-30812-3-git-send-email-bimmy.pujari@intel.com>
References: <1479157609-30812-1-git-send-email-bimmy.pujari@intel.com>
 <1479157609-30812-3-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA38076@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Monday, November 14, 2016 1:07 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Naczyk, Jacek <jacek.naczyk@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S53-V2 3/5] i40e: Add FEC for 25g
> 
> From: Carolyn Wyborny <carolyn.wyborny@intel.com>
> 
> This patch adds adminq support for Forward Error Correction ("FEC")for 25g
> products.
> 
> Signed-off-by: Carolyn Wyborny <carolyn.wyborny@intel.com>
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Signed-off-by: Jacek Naczyk <jacek.naczyk@intel.com>
> Change-ID: Iaff4910737c239d2c730e5c22a313ce9c37d3964
> ---
>  drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h  | 25
> ++++++++++++++++++++--
>  drivers/net/ethernet/intel/i40e/i40e_common.c      |  2 ++
>  .../net/ethernet/intel/i40evf/i40e_adminq_cmd.h    | 25
> ++++++++++++++++++++--
>  3 files changed, 48 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com


