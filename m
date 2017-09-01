From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 1 Sep 2017 18:39:43 +0000
Subject: [Intel-wired-lan] [next PATCH S79-V2 12/13] i40evf: enable
 support	for VF VLAN tag stripping control
In-Reply-To: <20170829093242.41026-12-alice.michael@intel.com>
References: <20170829093242.41026-1-alice.michael@intel.com>
 <20170829093242.41026-12-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EA96A5@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Tuesday, August 29, 2017 2:33 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S79-V2 12/13] i40evf: enable support
> for VF VLAN tag stripping control
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> A recent commit 809481484e5d ("i40e/i40evf: support for VF VLAN tag
> stripping control") added support for VFs to negotiate the control of VLAN
> tag stripping. This should have allowed VFs to disable the feature.
> Unfortunately, the flag was set only in netdev->feature flags and not in
> netdev->hw_features.
> 
> This ultimately causes the stack to assume that it cannot change the flag, so it
> was unchangeable and marked as [fixed] in the ethtool -k output.
> 
> Fix this by setting the feature in hw_features first, just as we do for the PF
> code. This enables ethtool -K to disable the feature correctly, and fully
> enables user control of the VLAN tag stripping feature.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 22 ++++++++++++++-----
> ---
>  1 file changed, 14 insertions(+), 8 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


