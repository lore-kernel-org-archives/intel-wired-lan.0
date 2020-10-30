From: Andre Guedes <andre.guedes@intel.com>
Date: Thu, 29 Oct 2020 17:00:19 -0700
Subject: [Intel-wired-lan] [PATCH v2 10/10] igc: Implement ndo_xdp_xmit
 callback
In-Reply-To: <20201029143439.GE890@ranger.igk.intel.com>
References: <20201028201943.93147-1-andre.guedes@intel.com>
 <20201028201943.93147-11-andre.guedes@intel.com>
 <20201029143439.GE890@ranger.igk.intel.com>
Message-ID: <160401601981.13680.8790675217584504450@sjaggi-mobl.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Quoting Maciej Fijalkowski (2020-10-29 07:34:39)
> On Wed, Oct 28, 2020 at 01:19:43PM -0700, Andre Guedes wrote:
> > This patch introduces the helper igc_xdp_xmit() which implements the
> > ndo_xdp_xmit ops, enabling the igc driver to transmit packets forwarded
> > to it by xdp programs running on other interfaces.
> > 
> > This patch has been tested with the sample app "xdp_redirect_map"
> > located in samples/bpf/.
> > 
> > Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> > ---
> >  drivers/net/ethernet/intel/igc/igc_main.c | 41 +++++++++++++++++++++++
> >  drivers/net/ethernet/intel/igc/igc_xdp.c  |  3 +-
> >  drivers/net/ethernet/intel/igc/igc_xdp.h  |  2 ++
> >  3 files changed, 44 insertions(+), 2 deletions(-)
> 
> I think that it should be squashed with previous patch? So you have
> XDP_REDIRECT support in a single patch.

Sure, makes sense.

Thanks,
Andre
