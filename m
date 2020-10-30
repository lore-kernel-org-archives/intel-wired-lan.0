From: Andre Guedes <andre.guedes@intel.com>
Date: Thu, 29 Oct 2020 17:00:13 -0700
Subject: [Intel-wired-lan] [PATCH v2 08/10] igc: Add support for XDP_TX
 action
In-Reply-To: <20201029143009.GD890@ranger.igk.intel.com>
References: <20201028201943.93147-1-andre.guedes@intel.com>
 <20201028201943.93147-9-andre.guedes@intel.com>
 <20201029143009.GD890@ranger.igk.intel.com>
Message-ID: <160401601359.13680.1113520617252128897@sjaggi-mobl.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Quoting Maciej Fijalkowski (2020-10-29 07:30:09)
> > +
> > +struct igc_ring *igc_xdp_get_tx_ring(struct igc_adapter *adapter, int cpu)
> > +{
> > +     int index = cpu;
> > +
> > +     if (index >= adapter->num_tx_queues)
> > +             index = index % adapter->num_tx_queues;
> 
> So you kept modulos? :) I think you can simply substitute it with
> subtraction.

Did you mean something like:

	while (index >= adapter->num_tx_queues)
		index -= adapter->num_tx_queues

That should work too. I just followed the same approach we do in igb driver
here.

Thanks,
Andre
