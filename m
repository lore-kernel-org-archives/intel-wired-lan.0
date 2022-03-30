From: Alexander Lobakin <alexandr.lobakin@intel.com>
Date: Wed, 30 Mar 2022 11:07:34 +0200
Subject: [Intel-wired-lan] [PATCH v4 net-next 5/5] ice: switch: convert
 packet template match code to rodata
In-Reply-To: <PH0PR11MB5782637EA9771D3ED4E56012FD1E9@PH0PR11MB5782.namprd11.prod.outlook.com>
References: <20220321105954.843154-1-alexandr.lobakin@intel.com>
 <20220321105954.843154-6-alexandr.lobakin@intel.com>
 <PH0PR11MB5782637EA9771D3ED4E56012FD1E9@PH0PR11MB5782.namprd11.prod.outlook.com>
Message-ID: <20220330090734.2725099-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Wojciech Drewek <wojciech.drewek@intel.com>
Date: Tue, 29 Mar 2022 15:12:44 +0000

> Hi Alex,
> 
> > -----Original Message-----
> > From: Lobakin, Alexandr <alexandr.lobakin@intel.com>
> > Sent: poniedzialek, 21 marca 2022 12:00
> > To: intel-wired-lan at lists.osuosl.org
> > Cc: Lobakin, Alexandr <alexandr.lobakin@intel.com>; Fijalkowski, Maciej <maciej.fijalkowski@intel.com>; Michal Swiatkowski
> > <michal.swiatkowski@linux.intel.com>; Drewek, Wojciech <wojciech.drewek@intel.com>; Marcin Szycik
> > <marcin.szycik@linux.intel.com>; Szapar-Mudlaw, Martyna <martyna.szapar-mudlaw@intel.com>; David S. Miller
> > <davem@davemloft.net>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; netdev at vger.kernel.org; linux-
> > kernel at vger.kernel.org
> > Subject: [PATCH v4 net-next 5/5] ice: switch: convert packet template match code to rodata
> >
> > Trade text size for rodata size and replace tons of nested if-elses
> > to the const mask match based structs. The almost entire
> > ice_find_dummy_packet() now becomes just one plain while-increment
> > loop. The order in ice_dummy_pkt_profiles[] should be same with the
> > if-elses order previously, as masks become less and less strict
> > through the array to follow the original code flow.
> > Apart from removing 80 locs of 4-level if-elses, it brings a solid
> > text size optimization:
> >
> > add/remove: 0/1 grow/shrink: 1/1 up/down: 2/-1058 (-1056)
> > Function                                     old     new   delta
> > ice_fill_adv_dummy_packet                    289     291      +2
> > ice_adv_add_update_vsi_list                  201       -    -201
> > ice_add_adv_rule                            2950    2093    -857
> > Total: Before=414512, After=413456, chg -0.25%
> > add/remove: 53/52 grow/shrink: 0/0 up/down: 4660/-3988 (672)
> > RO Data                                      old     new   delta
> > ice_dummy_pkt_profiles                         -     672    +672
> > Total: Before=37895, After=38567, chg +1.77%
> >
> > Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> > Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> > Tested-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> > ---
> >  drivers/net/ethernet/intel/ice/ice_switch.c | 215 ++++++++++----------
> >  1 file changed, 108 insertions(+), 107 deletions(-)

--- 8< ---

> > +	ICE_PKT_PROFILE(vlan_udp, ICE_PKT_INNER_UDP | ICE_PKT_VLAN),
> > +	ICE_PKT_PROFILE(udp, ICE_PKT_INNER_UDP),
> > +	ICE_PKT_PROFILE(vlan_tcp_ipv6, ICE_PKT_INNER_IPV6 | ICE_PKT_VLAN),
> > +	ICE_PKT_PROFILE(tcp_ipv6, ICE_PKT_INNER_IPV6),
> 
> I think that in both "vlan_tcp_ipv6" and "tcp_ipv6" we should use ICE_PKT_OUTER_IPV6 instead
> of ICE_PKT_INNER_IPV6. We are not dealing with tunnels in those cases so inner addresses are 
> incorrect here.

Oh, some copy'n'paste braino indeed.
I'll send a fixup to Tony in a moment.

> 
> Thanks,
> Wojtek

Great catch, thanks for noticing!

> 
> > +	ICE_PKT_PROFILE(vlan_tcp, ICE_PKT_VLAN),
> > +	ICE_PKT_PROFILE(tcp, 0),
> > +};

--- 8< ---

> > --
> > 2.35.1

Al
