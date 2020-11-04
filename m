From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Wed, 4 Nov 2020 22:56:27 +0100
Subject: [Intel-wired-lan] [PATCH v3 7/9] igc: Add initial XDP support
In-Reply-To: <160444682187.10323.11872975494131598005@anemani-mobl2.amr.corp.intel.com>
References: <20201030210351.46482-1-andre.guedes@intel.com>
 <20201030210351.46482-8-andre.guedes@intel.com>
 <20201102180700.GJ6427@ranger.igk.intel.com>
 <160444682187.10323.11872975494131598005@anemani-mobl2.amr.corp.intel.com>
Message-ID: <20201104215627.GA39754@ranger.igk.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Nov 03, 2020 at 03:40:21PM -0800, Andre Guedes wrote:
> Quoting Maciej Fijalkowski (2020-11-02 10:07:00)
> > >  static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
> > >  {
> > >       unsigned int total_bytes = 0, total_packets = 0;
> > > @@ -1912,8 +1974,10 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
> > >               union igc_adv_rx_desc *rx_desc;
> > >               struct igc_rx_buffer *rx_buffer;
> > >               ktime_t timestamp = 0;
> > > +             struct xdp_buff xdp;
> > 
> > I'm wondering if this patch should zero-init the xdp_buff. There are two
> > pointers that are left untouched below (rxq/txq) so maybe bpf prog would
> > get some weird behavior if it would be touching them.
> 
> I see your point. While rxq is set by the next patch txq is not. I took a look
> at ice, i40e, ixgbe, and they don't seem to zero-init neither set txq so maybe
> that's OK.

To clear it up, txq in xdp_buff is explicitly set in dev_map_run_prog(),
which is sort of a xdp tx hook. That's why none of the driver has to do
that. Sorry for confusion :)
