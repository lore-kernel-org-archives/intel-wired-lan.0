From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 4 May 2016 16:03:20 +0000
Subject: [Intel-wired-lan] [next PATCH S36 04/12] i40e:
	Add	vf-true-promisc-support priv flag
In-Reply-To: <1462313600-3123-5-git-send-email-bimmy.pujari@intel.com>
References: <1462313600-3123-1-git-send-email-bimmy.pujari@intel.com>
 <1462313600-3123-5-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D5988@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Tuesday, May 03, 2016 3:13 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S36 04/12] i40e: Add vf-true-promisc-
> support priv flag
> 
> From: Anjali Singhai Jain <anjali.singhai@intel.com>
> 
> This patch adds priv-flag knob to configure global true promisc support. With
> this patch the user can decide the flavor of promiscuous that the VFs will see
> when promiscuous mode is enabled on the interface. Since this a global
> setting for the whole device, the priv-flag is exposed only on the first PF of
> the device.
> 
> The default is true promisc support is off, which means the promisc mode for
> the VF will be limited/defport mode.
> 
> For the PF, we still will be in limited promisc unless in MFP mode irrespective
> of the flavor picked through this knob.
> 
> Usage:
> On PF0
> ethtool --show-priv-flags p261p1
> Private flags for p261p1:
> MFP                    : off
> LinkPolling            : off
> flow-director-atr      : on
> veb-stats              : off
> hw-atr-eviction        : off
> vf-true-promisc-support: off
> 
> to enable setting true promisc
> ethtool --set-priv-flags p261p1 vf-true-promisc-support on
> 
> At this point if the VF is set to trust and promisc is enabled on the VF through
> ip link set ... promisc on The VF/VFs will be able to see ALL ingress traffic
> 
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> Change-Id: I8fac4b6eb1af9ca77b5376b79c50bdce5055bd94
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h             | 12 ++--
>  drivers/net/ethernet/intel/i40e/i40e_common.c      |  9 ++-
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c     | 72
> +++++++++++++++++++---
>  drivers/net/ethernet/intel/i40e/i40e_main.c        | 30 ++++++++-
>  drivers/net/ethernet/intel/i40e/i40e_prototype.h   |  3 +-
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  3 +-
>  6 files changed, 111 insertions(+), 18 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
VF promiscuous mode works as expected
