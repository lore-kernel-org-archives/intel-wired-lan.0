From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 9 Sep 2015 19:31:53 +0000
Subject: [Intel-wired-lan] [next PATCH S12 09/15] i40e/i40evf: Store
	CEE	DCBX DesiredCfg and RemoteCfg
In-Reply-To: <1440690163-128213-10-git-send-email-catherine.sullivan@intel.com>
References: <1440690163-128213-1-git-send-email-catherine.sullivan@intel.com>
 <1440690163-128213-10-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060A5DE2@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S12 09/15] i40e/i40evf: Store CEE
> DCBX DesiredCfg and RemoteCfg
> 
> From: Neerav Parikh <neerav.parikh@intel.com>
> 
> This patch adds capability to query and store the CEE DCBX DesiredCfg and
> RemoteCfg data from the LLDP MIB.
> Added new member "desired_dcbx_config" in the i40e_hw data structure to
> hold CEE only DesiredCfg data.
> 
> Signed-off-by: Neerav Parikh <neerav.parikh@intel.com>
> Change-ID: I19c550369594384eaff4cc63e690ca740231195d
> ---
>  drivers/net/ethernet/intel/i40e/i40e_dcb.c    | 44
> ++++++++++++++++++++++-----
>  drivers/net/ethernet/intel/i40e/i40e_type.h   |  5 +--
>  drivers/net/ethernet/intel/i40evf/i40e_type.h |  5 +--
>  3 files changed, 42 insertions(+), 12 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree
