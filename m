From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Tue, 1 May 2018 21:23:15 +0000
Subject: [Intel-wired-lan] [PATCH 1/6] fm10k: setup VLANs for l2
 accelerated macvlan interfaces
In-Reply-To: <20180412181559.4343-1-jacob.e.keller@intel.com>
References: <20180412181559.4343-1-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E8294D4C9@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf Of
> Jacob Keller
> Sent: Thursday, April 12, 2018 11:16 AM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [PATCH 1/6] fm10k: setup VLANs for l2 accelerated
> macvlan interfaces
> 
> We have support for accelerating macvlan devices via the
> .ndo_dfwd_add_station() netdev op. These accelerated macvlan MAC
> addresses are stored in the l2_accel structure, separate from the
> unicast or multicast address lists.
> 
> If a VLAN is added on top of the macvlan device by the stack, traffic
> will not properly flow to the macvlan. This occurs because we fail to
> setup the VLANs for l2_accel MAC addresses.
> 
> In the non-offloaded case the MAC address is added to the unicast
> address list, and thus the normal setup for enabling VLANs works as
> expected.
> 
> We also need to add VLANs marked from .ndo_vlan_rx_add_vid() into the
> l2_accel MAC addresses. Otherwise, VLAN traffic will not properly be
> received by the VLAN devices attached to the offloaded macvlan devices.
> 
> Fix this by adding necessary logic to setup VLANs not only for the
> unicast and multicast addresses, but also the l2_accel list. We need
> similar logic in dfwd_add_station, dfwd_del_station, fm10k_update_vid,
> and fm10k_restore_rx_state.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---

Tested-by: Krishneil Singh  <krishneil.k.singh@intel.com>

