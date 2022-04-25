From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Mon, 25 Apr 2022 08:48:50 +0000
Subject: [Intel-wired-lan] [PATCH net-next v2] i40e: Add VF VLAN pruning
In-Reply-To: <20220411120714.27462-1-mateusz.palczewski@intel.com>
References: <20220411120714.27462-1-mateusz.palczewski@intel.com>
Message-ID: <DM8PR11MB56218477304F15B9693A9BACABF89@DM8PR11MB5621.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Mateusz Palczewski
> Sent: Monday, April 11, 2022 2:07 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Palczewski, Mateusz <mateusz.palczewski@intel.com>; Patynowski,
> PrzemyslawX <przemyslawx.patynowski@intel.com>; Sylwester Dziedziuch
> <sylwesterx.dziedziuch@intel.com>
> Subject: [Intel-wired-lan] [PATCH net-next v2] i40e: Add VF VLAN pruning
> 
> VFs by default are able to see all tagged traffic regardless of trust and VLAN
> filters configured.
> 
> Add new private flag vf-vlan-pruning that allows changing of default VF
> behavior for tagged traffic. When the flag is turned on untrusted VF will only
> be able to receive untagged traffic or traffic with VLAN tags it has created
> interfaces for
> 
> The flag is off by default and can only be changed if there are no VFs
> spawned on the PF. This flag will only be effective when no PVID is set on VF
> and VF is not trusted.
> Add new function that computes the correct VLAN ID for VF VLAN filters
> based on trust, PVID, vf-vlan-prune-disable flag and current VLAN ID.
> 
> Testing Hints:
> 
> Test 1: vf-vlan-pruning == off
> ==============================
> 1. Set the private flag
> > ethtool --set-priv-flag eth0 vf-vlan-pruning off (default setting)
> 2. Use scapy to send any VLAN tagged traffic and make sure the VF receives
> all VLAN tagged traffic that matches its destination MAC filters (unicast,
> multicast, and broadcast).
> 
> Test 2: vf-vlan-pruning == on
> ==============================
> 1. Set the private flag
> > ethtool --set-priv-flag eth0 vf-vlan-pruning on
> 2. Use scapy to send any VLAN tagged traffic and make sure the VF does not
> receive any VLAN tagged traffic that matches its destination MAC filters
> (unicast, multicast, and broadcast).
> 3. Add a VLAN filter on the VF netdev
> > ip link add link eth0v0 name vlan10 type vlan id 10
> 4. Bring the VLAN netdev up
> > ip link set vlan10 up
> 4. Use scapy to send traffic with VLAN 10, VLAN 11 (anything not VLAN 10),
> and untagged traffic. Make sure the VF only receives VLAN 10 and untagged
> traffic when the link partner is sending.
> 
> Test 3: vf-vlan-pruning == off && VF is in a port VLAN
> ============================== 1. Set the private flag
> > ethtool --set-priv-flag eth0 vf-vlan-pruning off (default setting)
> 2. Create a VF
> > echo 1 > sriov_numvfs
> 3. Put the VF in a port VLAN
> > ip link set eth0 vf 0 vlan 10
> 4. Use scapy to send traffic with VLAN 10 and VLAN 11 (anything not VLAN
> 10) and make sure the VF only receives untagged traffic when the link
> partner is sending VLAN 10 tagged traffic as the VLAN tag is expected to be
> stripped by HW for port VLANs and not visible to the VF.
> 
> Test 4: Change vf-vlan-pruning while VFs are created
> ============================== echo 0 > sriov_numvfs ethtool --set-
> priv-flag eth0 vf-vlan-pruning off echo 1 > sriov_numvfs ethtool --set-priv-
> flag eth0 vf-vlan-pruning on (expect failure)
> 
> Signed-off-by: Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
> Signed-off-by: Przemyslaw Patynowski
> <przemyslawx.patynowski@intel.com>
> Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
> ---
>  v2: Fix checpatch issues
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h        |   1 +
>  .../net/ethernet/intel/i40e/i40e_ethtool.c    |   9 ++
>  drivers/net/ethernet/intel/i40e/i40e_main.c   | 135 +++++++++++++++++-
>  .../ethernet/intel/i40e/i40e_virtchnl_pf.c    |   8 +-
>  4 files changed, 147 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e.h
> b/drivers/net/ethernet/intel/i40e/i40e.h
> index 18558a0..57f4ec4 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e.h
> @@ -565,6 +565,7 @@ struct i40e_pf {
>  #define I40E_FLAG_DISABLE_FW_LLDP		BIT(24)
>  #define I40E_FLAG_RS_FEC			BIT(25)
>  #define I40E_FLAG_BASE_R_FEC			BIT(26)
> +#define I40E_FLAG_VF_VLAN_PRUNING		BIT(27)
>  /* TOTAL_PORT_SHUTDOWN
>   * Allows to physically disable the link on the NIC's port.
>   * If enabled, (after link down request from the OS) diff --git
> a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> index 610f00c..c65e9e2 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> @@ -457,6 +457,8 @@ static const struct i40e_priv_flags
> i40e_gstrings_priv_flags[] = {

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
