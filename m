From: Corinna Vinschen <vinschen@redhat.com>
Date: Fri, 14 Jan 2022 17:51:34 +0100
Subject: [Intel-wired-lan] [PATCH 2/2 net-next v2] igb: refactor XDP
 registration
In-Reply-To: <5521e35f-3adf-2949-f360-12e2f7946480@suse.de>
References: <20220114114354.1071776-1-vinschen@redhat.com>
 <20220114114354.1071776-3-vinschen@redhat.com>
 <5521e35f-3adf-2949-f360-12e2f7946480@suse.de>
Message-ID: <YeGqFq2oJqIzar53@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Jan 14 17:13, Denis Kirjanov wrote:
> 1/14/22 14:43, Corinna Vinschen ?????:
> > On changing the RX ring parameters igb uses a hack to avoid a warning
> > when calling xdp_rxq_info_reg via igb_setup_rx_resources.  It just
> > clears the struct xdp_rxq_info content.
> > 
> > Change this to unregister if we're already registered instead.  ALign
> > code to the igc code.
> > 
> > Fixes: 9cbc948b5a20c ("igb: add XDP support")
> > Signed-off-by: Corinna Vinschen <vinschen@redhat.com>
> > ---
> >   drivers/net/ethernet/intel/igb/igb_ethtool.c |  4 ----
> >   drivers/net/ethernet/intel/igb/igb_main.c    | 15 +++++++++++----
> >   2 files changed, 11 insertions(+), 8 deletions(-)
> > [...]
> > +	if (res < 0) {
> > +		netdev_err(rx_ring->netdev,
> > +			   "Failed to register xdp_rxq index %u\n",
> > +			   rx_ring->queue_index);
> nit: would be nice to have the same printing functions like dev_err()
> in the error case

Thanks, I pushed a v3.


Corinna

