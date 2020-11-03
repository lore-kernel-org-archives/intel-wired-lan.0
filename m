From: Andre Guedes <andre.guedes@intel.com>
Date: Tue, 03 Nov 2020 15:40:55 -0800
Subject: [Intel-wired-lan] [PATCH v3 8/9] igc: Add support for XDP_TX
 action
In-Reply-To: <20201102182659.GK6427@ranger.igk.intel.com>
References: <20201030210351.46482-1-andre.guedes@intel.com>
 <20201030210351.46482-9-andre.guedes@intel.com>
 <20201102182659.GK6427@ranger.igk.intel.com>
Message-ID: <160444685523.10323.13712174376571831748@anemani-mobl2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Quoting Maciej Fijalkowski (2020-11-02 10:26:59)
> > +static struct igc_ring *igc_xdp_get_tx_ring(struct igc_adapter *adapter,
> > +                                         int cpu)
> > +{
> > +     int index = cpu;
> > +
> > +     if (index >= adapter->num_tx_queues)
> > +             index = index % adapter->num_tx_queues;
> 
> I'm not sure why you don't want to take the suggestion for getting rid of
> modulo op. I won't insist anymore ;)

As I mentioned in the previous comment, I was just following the same
approach from igb. Since I'll submit a v4 already, I'll do that as well.
