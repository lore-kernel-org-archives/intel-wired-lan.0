From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Wed, 4 Nov 2020 23:26:08 +0100
Subject: [Intel-wired-lan] [PATCH v3 1/9] igc: Fix igc_ptp_rx_pktstamp()
In-Reply-To: <160444679837.10323.6569127492617330628@anemani-mobl2.amr.corp.intel.com>
References: <20201030210351.46482-1-andre.guedes@intel.com>
 <20201030210351.46482-2-andre.guedes@intel.com>
 <20201102175617.GI6427@ranger.igk.intel.com>
 <160444679837.10323.6569127492617330628@anemani-mobl2.amr.corp.intel.com>
Message-ID: <20201104222608.GB39754@ranger.igk.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Nov 03, 2020 at 03:39:58PM -0800, Andre Guedes wrote:
> Quoting Maciej Fijalkowski (2020-11-02 09:56:17)
> > > +void igc_ptp_rx_pktstamp(struct igc_q_vector *q_vector, u32 *va,
> > >                        struct sk_buff *skb)
> > >  {
> > >       struct igc_adapter *adapter = q_vector->adapter;
> > > -     __le64 *regval = (__le64 *)va;
> > > -     int adjust = 0;
> > > -
> > > -     /* The timestamp is recorded in little endian format.
> > > -      * DWORD: | 0          | 1           | 2          | 3
> > > -      * Field: | Timer0 Low | Timer0 High | Timer1 Low | Timer1 High
> > > +     u64 regval;
> > > +     int adjust;
> > > +
> > > +     /* Timestamps are saved in little endian at the beginning of the packet
> > > +      * buffer following the layout:
> > > +      *
> > > +      * | 0              | 1              | 2              | 3              |
> > 
> > Minor nit, I find DWORD comment helpful from previous version of this
> > description.
> 
> Let me bring that comment back.
> 
> > 
> > > +      * | Timer1 SYSTIML | Timer1 SYSTIMH | Timer0 SYSTIML | Timer0 SYSTIMH |
> > 
> > A dumb question from ptp/igc noob: why two timers?
> 
> i225 has 4 independent timers and software can select 2 of them to be sampled
> when the packet is received. One use case I can think of is to help with
> cross-timestamping in multiple clocks scenario so you could have a "global"
> timestamp and a "local" timestamp for a single packet.
> 
> > > +      *
> > > +      * SYSTIML holds the nanoseconds part while SYSTIMH holds the seconds
> > > +      * part of the timestamp.
> > >        */
> > > -     igc_ptp_systim_to_hwtstamp(adapter, skb_hwtstamps(skb),
> > > -                                le64_to_cpu(regval[0]));
> > > -
> > > -     /* adjust timestamp for the RX latency based on link speed */
> > > -     if (adapter->hw.mac.type == igc_i225) {
> > 
> > if this check is not required here, then is it within
> > igc_ptp_systim_to_hwtstamp?
> 
> It is not required in igc_ptp_systim_to_hwtstamp() either. As discussed in [1]
> these checks will be cleaned up in a separate series.

Okay thanks.

> 
> > > +     /* Adjust timestamp for the RX latency based on link speed */
> > > +     switch (adapter->link_speed) {
> > > +     case SPEED_10:
> > > +             adjust = IGC_I225_RX_LATENCY_10;
> > > +             break;
> > > +     case SPEED_100:
> > > +             adjust = IGC_I225_RX_LATENCY_100;
> > > +             break;
> > > +     case SPEED_1000:
> > > +             adjust = IGC_I225_RX_LATENCY_1000;
> > > +             break;
> > > +     case SPEED_2500:
> > > +             adjust = IGC_I225_RX_LATENCY_2500;
> > > +             break;
> > > +     default:
> > > +             adjust = 0;
> > > +             netdev_warn_once(adapter->netdev, "Imprecise timestamp\n");
> > 
> > How is timestamp related to link speed? I mean, this warning is telling me
> > that there is something wrong with the timestamp that hw put onto frame,
> > not that link speed is cranky.
> 
> The timestamp is sampled at the beginning of the packet. Although the timestamp
> logic is located as close as possible to the PHY interface, there is a latency
> between the moment the PHY received the first bit of the packet and the moment
> the timestamp logic samples. That latency depends on the link speed and is
> specified in the datasheet so software can adjust it.

Thanks for that explanation! I meant that warning should say something
like "wrong link speed, can not adjust timestamp", but OTOH I have a
feeling that all of the speeds that this HW supports are handled in this
switch statement, so probably arguing about that warning is pointless? :)

> 
> In this regards, i225 is similar to i210 so you can take a look at section
> 7.8.3.1 Capture Timestamp Mechanism from i210 datasheet for further details.
> 
> Best,
> Andre
> 
> [1] https://patchwork.ozlabs.org/project/intel-wired-lan/patch/20200519101644.8246-1-sasha.neftin at intel.com/
