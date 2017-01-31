From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 31 Jan 2017 19:21:25 +0000
Subject: [Intel-wired-lan] [next PATCH S58-V3 1/4] i40e-shared: fix
	up	recent proxy and wol bits for X722_SUPPORT
In-Reply-To: <1485282241-3579-1-git-send-email-bimmy.pujari@intel.com>
References: <1485282241-3579-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA5D749@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Tuesday, January 24, 2017 10:24 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Shannon Nelson <shannon.nelson@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S58-V3 1/4] i40e-shared: fix up recent
> proxy and wol bits for X722_SUPPORT
> 
> From: Shannon Nelson <shannon.nelson@intel.com>
> 
> Some opcodes added & reordered to be in numerical order with the rest of
> the opcodes.
> This patch adds admin queue structs to support Wake on LAN feature for
> X722.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Signed-off-by: Carolyn Wyborny <carolyn.wyborny@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h  | 65
> +++++++++++++++++++++-
>  .../net/ethernet/intel/i40evf/i40e_adminq_cmd.h    | 65
> +++++++++++++++++++++-
>  2 files changed, 128 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


