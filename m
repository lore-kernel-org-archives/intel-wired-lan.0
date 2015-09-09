From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 9 Sep 2015 18:40:33 +0000
Subject: [Intel-wired-lan] [next PATCH S12 08/15] i40e: Add parsing for
 CEE	DCBX TLVs
In-Reply-To: <1440690163-128213-9-git-send-email-catherine.sullivan@intel.com>
References: <1440690163-128213-1-git-send-email-catherine.sullivan@intel.com>
 <1440690163-128213-9-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060A5D9C@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Thursday, August 27, 2015 8:43 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S12 08/15] i40e: Add parsing for CEE
> DCBX TLVs
> 
> From: Neerav Parikh <neerav.parikh@intel.com>
> 
> This patch adds parsing for CEE DCBX TLVs from the LLDP MIB.
> 
> While the driver gets the DCB CEE operational configuration from Firmware
> using the "Get CEE DCBX Oper Config" AQ command there is a need to get
> the CEE DesiredCfg Tx by firmware and DCB configuration Rx from peer; for
> debug and other application purposes.
> 
> Signed-off-by: Neerav Parikh <neerav.parikh@intel.com>
> Change-ID: I9140edf1a25a2852c7eff805d81e5eff6266178d
> ---
>  drivers/net/ethernet/intel/i40e/i40e_dcb.c | 179
> +++++++++++++++++++++++++++++
> drivers/net/ethernet/intel/i40e/i40e_dcb.h |  39 +++++++
>  2 files changed, 218 insertions(+)


Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree
