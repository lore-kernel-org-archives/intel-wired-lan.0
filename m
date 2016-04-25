From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 25 Apr 2016 22:37:15 +0000
Subject: [Intel-wired-lan] [next PATCH S33 12/13] i40e: Add VF
 promiscuous	mode driver support
In-Reply-To: <1460475052-6348-13-git-send-email-harshitha.ramamurthy@intel.com>
References: <1460475052-6348-1-git-send-email-harshitha.ramamurthy@intel.com>
 <1460475052-6348-13-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D4E0D@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Harshitha Ramamurthy
> Sent: Tuesday, April 12, 2016 8:31 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S33 12/13] i40e: Add VF promiscuous
> mode driver support
> 
> From: Anjali Singhai Jain <anjali.singhai@intel.com>
> 
> Add infrastructure for Network Function Virtualization VLAN tagged packet
> steering feature.
> 
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> Signed-off-by: Greg Rose <gregory.v.rose@intel.com>
> Change-Id: I9b873d8fcc253858e6baba65ac68ec5b9363944e
> ---
> Testing Hints : Test the feature with
> Ip link set dev veth0 promisc on  (do this from the VF for the VF) Also test
> with adding vlan on VF plus port vlan for VF.
> 
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 153
> ++++++++++++++++++++-
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h |   2 +
>  2 files changed, 149 insertions(+), 6 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Promiscuous mode can be enabled on VF driver
