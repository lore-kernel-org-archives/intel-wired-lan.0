From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Sat, 8 Jan 2022 04:42:04 +0000
Subject: [Intel-wired-lan] [PATCH net-next v3 09/14] ice: Add hot path
 support for 802.1Q and 802.1ad VLAN offloads
In-Reply-To: <20211202163852.36436-9-anthony.l.nguyen@intel.com>
References: <20211202163852.36436-1-anthony.l.nguyen@intel.com>
 <20211202163852.36436-9-anthony.l.nguyen@intel.com>
Message-ID: <BYAPR11MB3367F9CD9C6A4717A30EFC89FC4E9@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Tony
> Nguyen
> Sent: Thursday, December 2, 2021 10:09 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net-next v3 09/14] ice: Add hot path support
> for 802.1Q and 802.1ad VLAN offloads
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently the driver only supports 802.1Q VLAN insertion and stripping.
> However, once Double VLAN Mode (DVM) is fully supported, then both 802.1Q
> and 802.1ad VLAN insertion and stripping will be supported. Unfortunately the
> VSI context parameters only allow for one VLAN ethertype at a time for VLAN
> offloads so only one or the other VLAN ethertype offload can be supported at
> once.
> 
> To support this, multiple changes are needed.
> 
> Rx path changes:
> 
> [1] In DVM, the Rx queue context l2tagsel field needs to be cleared so the
> outermost tag shows up in the l2tag2_2nd field of the Rx flex descriptor. In
> Single VLAN Mode (SVM), the l2tagsel field should remain
> 1 to support SVM configurations.
> 
> [2] Modify the ice_test_staterr() function to take a __le16 instead of the
> ice_32b_rx_flex_desc union pointer so this function can be used for both
> rx_desc->wb.status_error0 and rx_desc->wb.status_error1.
> 
> [3] Add the new inline function ice_get_vlan_tag_from_rx_desc() that checks if
> there is a VLAN tag in l2tag1 or l2tag2_2nd.
> 
> [4] In ice_receive_skb(), add a check to see if NETIF_F_HW_VLAN_STAG_RX is
> enabled in netdev->features. If it is, then this is the VLAN ethertype that needs
> to be added to the stripping VLAN tag. Since
> ice_fix_features() prevents CTAG_RX and STAG_RX from being enabled
> simultaneously, the VLAN ethertype will only ever be 802.1Q or 802.1ad.
> 
> Tx path changes:
> 
> [1] In DVM, the VLAN tag needs to be placed in the l2tag2 field of the Tx
> context descriptor. The new define ICE_TX_FLAGS_HW_OUTER_SINGLE_VLAN
> was added to the list of tx_flags to handle this case.
> 
> [2] When the stack requests the VLAN tag to be offloaded on Tx, the driver
> needs to set either ICE_TX_FLAGS_HW_OUTER_SINGLE_VLAN or
> ICE_TX_FLAGS_HW_VLAN, so the tag is inserted in l2tag2 or l2tag1
> respectively. To determine which location to use, set a bit in the Tx ring flags
> field during ring allocation that can be used to determine which field to use in
> the Tx descriptor. In DVM, always use l2tag2, and in SVM, always use l2tag1.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
> v2: Fix kdoc issue
> 
>  drivers/net/ethernet/intel/ice/ice_base.c     | 18 +++++++++--
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c  |  8 +++--
>  .../net/ethernet/intel/ice/ice_lan_tx_rx.h    |  2 ++
>  drivers/net/ethernet/intel/ice/ice_lib.c      |  5 ++++
>  drivers/net/ethernet/intel/ice/ice_txrx.c     | 28 +++++++++++------
>  drivers/net/ethernet/intel/ice/ice_txrx.h     |  3 ++
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.c |  9 ++++--
> drivers/net/ethernet/intel/ice/ice_txrx_lib.h | 30 +++++++++++++++++--
>  drivers/net/ethernet/intel/ice/ice_xsk.c      |  6 ++--
>  9 files changed, 87 insertions(+), 22 deletions(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
