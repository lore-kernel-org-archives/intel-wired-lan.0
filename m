From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Tue, 21 Aug 2018 21:10:26 +0000
Subject: [Intel-wired-lan] [PATCH v3 13/15] ice: Enable VSI Rx/Tx
 pruning only when VLAN 0 is active
In-Reply-To: <20180809132958.23036-14-anirudh.venkataramanan@intel.com>
References: <20180809132958.23036-1-anirudh.venkataramanan@intel.com>
 <20180809132958.23036-14-anirudh.venkataramanan@intel.com>
Message-ID: <C25D919FD1849B409D8D987DDC7FCD26195458FB@ORSMSX109.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Thursday, August 9, 2018 6:30 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v3 13/15] ice: Enable VSI Rx/Tx pruning only
> when VLAN 0 is active
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> VLAN pruning is not valid when VLAN 0 is not active. If VLAN pruning is
> enabled and VLAN 0 is not active (8021q driver not loaded) then normal, non-
> VLAN, traffic will not pass.
> 
> TX/RX VLAN pruning is enabled when the VLAN 0 is added to the active_vlan
> bitmap and it is disabled when VLAN 0 is removed from the active_vlan
> bitmap.
> 
> So, only enable VLAN pruning when VLAN 0 is active. Setting RX VLAN
> pruning causes the switch to drop received VLAN packets when there are no
> matching VLAN ids in the associated VSI's switch filters. Setting TX pruning
> makes it so the switch will not send out any packets with VLAN tags that
> don't match the associated VSI's switch filters.
> 
> With this patch, if the VF or PF tries to send a VLAN tagged packet with a
> VLAN tag that it does not have a pruning rule for it will trigger an MDD event.
> For example, if PF0 has VLAN10 and VLAN11 interfaces and scapy is used to
> send a packet with VLAN8 then the MDD is triggered.
> 
> Also make ice_vsi_kill_vlan return a value which the caller can check before
> updating VLAN related data structures (counts, pruning bits, etc.).
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 94 ++++++++++++++++++++---
>  1 file changed, 85 insertions(+), 9 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com>


