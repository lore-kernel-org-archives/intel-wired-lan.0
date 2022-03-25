From: Ivan Vecera <ivecera@redhat.com>
Date: Fri, 25 Mar 2022 13:53:37 +0100
Subject: [Intel-wired-lan] [PATCH net] ice: Fix broken IFF_ALLMULTI
 handling
In-Reply-To: <eb6538d9-4667-f1f5-492c-e1e113a6da35@linux.intel.com>
References: <20220321191731.2596414-1-ivecera@redhat.com>
 <eb6538d9-4667-f1f5-492c-e1e113a6da35@linux.intel.com>
Message-ID: <20220325135337.2091ba08@ceranb>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 23 Mar 2022 21:05:20 +0100
Marcin Szycik <marcin.szycik@linux.intel.com> wrote:

> > @@ -352,29 +359,15 @@ static int ice_vsi_sync_fltr(struct ice_vsi *vsi)
> >  	/* check for changes in promiscuous modes */
> >  	if (changed_flags & IFF_ALLMULTI) {
> >  		if (vsi->current_netdev_flags & IFF_ALLMULTI) {
> > -			if (vsi->num_vlan > 1)
> > -				promisc_m = ICE_MCAST_VLAN_PROMISC_BITS;
> > -			else
> > -				promisc_m = ICE_MCAST_PROMISC_BITS;  
> 
> Because `ice_{set,clear}_promisc()` are now always called with the same second argument (ICE_MCAST_PROMISC_BITS), wouldn't it be better to remove the arg and instead call `ice_fltr_{clear,set}_{vlan,vsi}_vsi_promisc()` with either ICE_MCAST_VLAN_PROMISC_BITS or ICE_MCAST_PROMISC_BITS inside the function?

Because ice_{set,clear}_promisc() then could be used only for set mcast prosmisc mode so I modified them only to automatically insert ICE_PROMISC_VLAN_RX & ICE_PROMISC_VLAN_TX based on vsi->num_vlan value.

Anyway I will fix some objections from Jacob and send v2.

Thanks,
Ivan

