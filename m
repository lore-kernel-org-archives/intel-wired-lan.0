From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Wed, 19 May 2021 23:28:30 +0000
Subject: [Intel-wired-lan] [PATCH net 3/4] ice: Allow all LLDP packets
 from PF to Tx
In-Reply-To: <20210505211800.11908-3-anthony.l.nguyen@intel.com>
References: <20210505211800.11908-1-anthony.l.nguyen@intel.com>
 <20210505211800.11908-3-anthony.l.nguyen@intel.com>
Message-ID: <CO1PR11MB51058B559CF7B516FDF7374DFA2B9@CO1PR11MB5105.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Wednesday, May 5, 2021 2:18 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net 3/4] ice: Allow all LLDP packets from PF
> to Tx
> 
> From: Dave Ertman <david.m.ertman@intel.com>
> 
> Currently in the ice driver, the check whether to allow a LLDP packet to
> egress the interface from the PF_VSI is being based on the SKB's priority
> field.
> It checks to see if the packets priority is equal to TC_PRIO_CONTROL.
> Injected LLDP packets do not always meet this condition.
> 
> SCAPY defaults to a sk_buff->protocol value of ETH_P_ALL
> (0x0003) and does not set the priority field.  There will be other injection
> methods (even ones used by end users) that will not correctly configure the
> socket so that SKB fields are correctly populated.
> 
> Then ethernet header has to have to correct value for the protocol though.
> 
> Add a check to also allow packets whose ethhdr->h_proto matches
> ETH_P_LLDP (0x88CC).
> 
> Fixes: 0c3a6101ff2d ("ice: Allow egress control packets from PF_VSI")
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_txrx.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> (A Contingent Worker at Intel)


