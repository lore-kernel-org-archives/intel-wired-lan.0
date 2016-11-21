From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 21 Nov 2016 21:17:37 +0000
Subject: [Intel-wired-lan] [next PATCH S52-V2 06/15] i40e: set
	broadcast	promiscuous mode for each active VLAN
In-Reply-To: <1478639119-14656-7-git-send-email-bimmy.pujari@intel.com>
References: <1478639119-14656-1-git-send-email-bimmy.pujari@intel.com>
 <1478639119-14656-7-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA38546@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Tuesday, November 08, 2016 1:05 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S52-V2 06/15] i40e: set broadcast
> promiscuous mode for each active VLAN
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> A previous workaround added to ensure receipt of all broadcast frames
> incorrectly set the broadcast promiscuous mode unconditionally regardless
> of active VLAN status.
> 
> Replace this partial workaround with a complete solution that sets the
> broadcast promiscuous filters in i40e_sync_vsi_filters. This new method sets
> the promiscuous mode based on when broadcast filters are added or
> removed.
> 
> I40E_VLAN_ANY will request a broadcast filter for all VLANs, (as we're in
> untagged mode) while a broadcast filter on a specific VLAN will only request
> broadcast for that VLAN.
> 
> Thus, we restore addition of broadcast filter to the array, but we add special
> handling for these such that they enable the broadcast promiscuous mode
> instead of being sent as regular filters.
> 
> The end result is that we will correctly receive all broadcast packets (even
> those with a *source* address equal to the broadcast address) but will not
> receive packets for which we don't have an active VLAN filter.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: I7d0585c5cec1a5bf55bf533b42e5e817d5db6a2d
> ---
> Testing-hints:
>   Ensure that we do not receive broadcast packets for VLANs which are
>   not configured. That is, when we no VLANs configured we need to
>   receive broadcast packets on all VLANs. When we have added a VLAN
>   filter, we need to receive broadcasts only on VID=0 and any active
>   VLANs, but *not* any in-actve VLANs.
> 
>   Additionally we need to ensure that we do not break the receipt of
>   broadcast filters with a *source* address equal to the broadcast
>   address. This can be tested using scapy or similar tools. Ensure that
>   these packets follow the same receipt rules as above.
> 
>   Additionally it may be worth checking whether adding many VLANs
>   rapidly does not cause any driver stability issues and that the
>   broadcast packets are still correctly received.
> 
>  drivers/net/ethernet/intel/i40e/i40e_common.c      |  34 +++++++
>  drivers/net/ethernet/intel/i40e/i40e_main.c        | 106
> +++++++++++++++++----
>  drivers/net/ethernet/intel/i40e/i40e_prototype.h   |   3 +
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |   7 ++
>  4 files changed, 129 insertions(+), 21 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


