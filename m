From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 18 Apr 2016 19:03:10 +0000
Subject: [Intel-wired-lan] [next PATCH S34 02/12] i40e: Limit the number
 of	mac and vlan addresses that can be added for VFs
In-Reply-To: <1460542112-20166-3-git-send-email-harshitha.ramamurthy@intel.com>
References: <1460542112-20166-1-git-send-email-harshitha.ramamurthy@intel.com>
 <1460542112-20166-3-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D0EFB@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Harshitha Ramamurthy
> Sent: Wednesday, April 13, 2016 3:08 AM
> To: intel-wired-lan at osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S34 02/12] i40e: Limit the number of
> mac and vlan addresses that can be added for VFs
> 
> From: Anjali Singhai Jain <anjali.singhai@intel.com>
> 
> If the VF is privileged/trusted it can do as it may please including but not
> limited to hogging resources and playing unfair.
> But if the VF is not privileged/trusted it still can add some number
> (8) of MAC and VLAN addresses.
> Other restrictions with respect to Port VLAN and normal VLAN still apply to
> not privileged/trusted VF.
> 
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> Change-Id: I3a9529201b184c8873e1ad2e300aff468c9e6296
> ---
> Testing Hints :
> With this a non trusted VF can add up to 8 mac addresses and up to
> (8) vlan addresses if not under port vlan.
> 
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 25
> ++++++++++++++++++++--
> drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h |  3 +++
>  2 files changed, 26 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Untrusted VF successfully limits number of addresses
