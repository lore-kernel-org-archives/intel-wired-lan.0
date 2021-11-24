From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Wed, 24 Nov 2021 17:06:37 +0000
Subject: [Intel-wired-lan] [PATCH net-next v1] i40e: Add VF VLAN pruning
In-Reply-To: <20211122120216.11512-1-mateusz.palczewski@intel.com>
References: <20211122120216.11512-1-mateusz.palczewski@intel.com>
Message-ID: <20d6054551498fedcf6d9604017a7809fcdd9aa2.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2021-11-22 at 13:02 +0100, Mateusz Palczewski wrote:
> From: Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
> 
> VFs by default are able to see all tagged traffic regardless of trust
> and VLAN filters configured.
> 
> Add new private flag vf-vlan-pruning that allows changing of default
> VF behavior for tagged traffic. When the flag is turned on
> untrusted VF will only be able to receive untagged traffic
> or traffic with VLAN tags it has created interfaces for
> 
> The flag is off by default and can only be changed if
> there are no VFs spawned on the PF. This flag will only be effective
> when no PVID is set on VF and VF is not trusted.
> Add new function that computes the correct VLAN ID for VF VLAN
> filters
> based on trust, PVID, vf-vlan-prune-disable flag and current VLAN ID.
> 
> Testing Hints:
> 
> Test 1: vf-vlan-pruning == off
> ==============================
> 1. Set the private flag
> > ethtool --set-priv-flag eth0 vf-vlan-pruning off (default setting)
> 2. Use scapy to send any VLAN tagged traffic and make sure the VF
> receives all VLAN tagged traffic that matches its destination MAC
> filters (unicast, multicast, and broadcast).
> 
> Test 2: vf-vlan-pruning == on
> ==============================
> 1. Set the private flag
> > ethtool --set-priv-flag eth0 vf-vlan-pruning on
> 2. Use scapy to send any VLAN tagged traffic and make sure the VF
> does
> not receive any VLAN tagged traffic that matches its destination MAC
> filters (unicast, multicast, and broadcast).
> 3. Add a VLAN filter on the VF netdev
> > ip link add link eth0v0 name vlan10 type vlan id 10
> 4. Bring the VLAN netdev up
> > ip link set vlan10 up
> 4. Use scapy to send traffic with VLAN 10, VLAN 11 (anything not VLAN
> 10), and untagged traffic. Make sure the VF only receives VLAN 10
> and untagged traffic when the link partner is sending.
> 
> Test 3: vf-vlan-pruning == off && VF is in a port VLAN
> ==============================
> 1. Set the private flag
> > ethtool --set-priv-flag eth0 vf-vlan-pruning off (default setting)
> 2. Create a VF
> > echo 1 > sriov_numvfs
> 3. Put the VF in a port VLAN
> > ip link set eth0 vf 0 vlan 10
> 4. Use scapy to send traffic with VLAN 10 and VLAN 11 (anything not
> VLAN
> 10) and make sure the VF only receives untagged traffic when the link
> partner is sending VLAN 10 tagged traffic as the VLAN tag is expected
> to be stripped by HW for port VLANs and not visible to the VF.
> 
> Test 4: Change vf-vlan-pruning while VFs are created
> ==============================
> echo 0 > sriov_numvfs
> ethtool --set-priv-flag eth0 vf-vlan-pruning off
> echo 1 > sriov_numvfs
> ethtool --set-priv-flag eth0 vf-vlan-pruning on (expect failure)
> 
> Signed-off-by: Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
> Signed-off-by: Przemyslaw Patynowski
> <przemyslawx.patynowski@intel.com>
> Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
This has checkpatch issues, please fix.

CHECK: Alignment should match open parenthesis
#108: FILE: drivers/net/ethernet/intel/i40e/i40e_ethtool.c:5283:
+               dev_warn(&pf->pdev->dev,
+                       "Changing vf-vlan-pruning flag while VF(s) are
active is not supported\n");

CHECK: Please don't use multiple blank lines
#112: FILE: drivers/net/ethernet/intel/i40e/i40e_ethtool.c:5287:
+
+


