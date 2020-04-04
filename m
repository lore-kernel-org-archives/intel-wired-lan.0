From: Andre Guedes <andre.guedes@linux.intel.com>
Date: Fri, 03 Apr 2020 20:00:22 -0700
Subject: [Intel-wired-lan] [PATCH 4/4] igc: Refactor VLAN priority
 filtering code
In-Reply-To: <87lfnc9fqx.fsf@intel.com>
References: <20200403181743.23447-1-andre.guedes@intel.com>
 <20200403181743.23447-5-andre.guedes@intel.com> <87lfnc9fqx.fsf@intel.com>
Message-ID: <158596922224.30972.7562066188020088348@aguedesl-mac01.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Vinicius,

> >  int igc_erase_filter(struct igc_adapter *adapter, struct igc_nfc_filter *input)
> >  {
> >       if (input->filter.match_flags & IGC_FILTER_FLAG_ETHER_TYPE)
> >               igc_clear_etype_filter_regs(adapter,
> >                                           input->etype_reg_index);
> >  
> > -     if (input->filter.match_flags & IGC_FILTER_FLAG_VLAN_TCI)
> > -             igc_clear_vlan_prio_filter(adapter,
> > -                                        ntohs(input->filter.vlan_tci));
> > +     if (input->filter.match_flags & IGC_FILTER_FLAG_VLAN_TCI) {
> > +             int prio = (ntohs(input->filter.vlan_tci) & VLAN_PRIO_MASK)
> > +                             >> VLAN_PRIO_SHIFT;
> 
> As you are refactoring this, one suggestion/question: is it possible to
> move the ntohs() and friends closer to writing/reading to/from the
> registers?

I left this ntohs() here on purpose. The reason why we need it is due to the
ethtool byte order convention for the vlan_tci, not the controller. So it makes
more sense to have it in igc_ethtool.c instead of igc_main.c.

> > +int igc_add_vlan_prio_filter(struct igc_adapter *adapter, int prio, int queue)
> > +{
> > +     struct net_device *dev = adapter->netdev;
> > +     struct igc_hw *hw = &adapter->hw;
> > +     u32 vlanpqf;
> > +
> > +     vlanpqf = rd32(IGC_VLANPQF);
> > +
> > +     if (vlanpqf & IGC_VLANPQF_VALID(prio)) {
> > +             netdev_dbg(dev, "VLAN priority filter already in use");
> > +             return -EEXIST;
> > +     }
> > +
> > +     vlanpqf |= IGC_VLANPQF_QSEL(prio, queue);
> > +     vlanpqf |= IGC_VLANPQF_VALID(prio);
> > +
> > +     wr32(IGC_VLANPQF, vlanpqf);
> > +
> > +     netdev_dbg(dev, "Add VLAN priority filter: prio %d queue %d",
> > +                prio, queue);
> 
> As you added a way to dump this register, I don't think this debug
> statement, and the one below, are that useful.

Even considering that we are now able to dump the VLANPQF register, these debug
messages are still useful for logging purposes. We want to know when VLAN
priority filters are added or deleted. The register dump gives us a snapshot
of the register value, not the sequence of events that happened to get there.

At least they have been useful to me while debugging this code.

- Andre
