From: Andre Guedes <andre.guedes@intel.com>
Date: Thu, 29 Oct 2020 17:00:02 -0700
Subject: [Intel-wired-lan] [PATCH v2 07/10] igc: Add initial XDP support
In-Reply-To: <20201029141346.GC890@ranger.igk.intel.com>
References: <20201028201943.93147-1-andre.guedes@intel.com>
 <20201028201943.93147-8-andre.guedes@intel.com>
 <20201029141346.GC890@ranger.igk.intel.com>
Message-ID: <160401600277.13680.18047091279684955908@sjaggi-mobl.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Quoting Maciej Fijalkowski (2020-10-29 07:13:46)
> > diff --git a/drivers/net/ethernet/intel/igc/igc_xdp.c b/drivers/net/ethernet/intel/igc/igc_xdp.c
> > new file mode 100644
> > index 000000000000..faec0bedc550
> > --- /dev/null
> > +++ b/drivers/net/ethernet/intel/igc/igc_xdp.c

[...]

> > +struct sk_buff *igc_xdp_run_prog(struct igc_adapter *adapter,
> > +                              struct xdp_buff *xdp)
> 
> I would suggest to either have it in igc_main.c or in the header so that
> compiler could take the decision whether to inline it or not. For control
> plane related functions it's fine to have them in the separate file.

Do you also mean to move all other xdp functions currently defined in igc_xdp.c
that are called from igc_xdp_run_prog()?

	igc_xdp_xmit_back()
	igc_xdp_get_tx_ring()
	igc_xdp_init_tx_descriptor()
	igc_xdp_init_tx_buffer()

Thanks,
Andre
