From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 12 Apr 2016 22:02:08 +0000
Subject: [Intel-wired-lan] [PATCH 2/2] ixgbe: set vlan spoof
	checking	unconditionally
In-Reply-To: <20160318231119.25773.39536.stgit@localhost6.localdomain6>
References: <20160318225046.25773.35723.stgit@localhost6.localdomain6>
 <20160318231119.25773.39536.stgit@localhost6.localdomain6>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9CF4B2@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Emil Tantilov
> Sent: Friday, March 18, 2016 4:11 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 2/2] ixgbe: set vlan spoof checking
> unconditionally
> 
> Previously the PF driver would only set VLAN spoof checking if the VF had
> created vlans. This was done by setting and checking a counter (vlan_count)
> whenever a vlan was created by the VF.
> However it is possible for the vlan_count to be !=0 while there are no VLANs
> assigned to the VF due to the count incrementing every time a VLAN 0 is
> added on ifdown/up, which resulted in vlan spoofing always being set for
> those VFs.
> 
> This patch cleans up the logic by unconditionally setting VLAN based on how
> the VF is configured (via ip link set ethX vf Y spoofchk on/off).
> This change also resolves an issue where the VLAN spoofing can remain set
> even after being disabled by the user due to the driver enabling VLAN spoof
> checking every time a VLAN is added to the VF, but would only allow changes
> in the setting if vlan_count != 0.
> 
> Also default_vf_vlan_id and vlans_enabled were removed from the
> vf_data_storage structure since they are not being used in the driver.
> 
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h       |    3 ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c |   25 ++----------------------
>  2 files changed, 2 insertions(+), 26 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Spoof checking on by default on VFs, can be toggled
