From: Joseph, Jithu <jithu.joseph@intel.com>
Date: Fri, 26 Feb 2021 00:15:49 +0000
Subject: [Intel-wired-lan] [PATCH v4 4/9] igc: Refactor XDP rxq info
 registration
In-Reply-To: <CAJ+HfNhx5LhsS++sFxq2w50gmsnVd2QeXT35ZFVPwvaixbnPAQ@mail.gmail.com>
References: <20210222090936.6768-1-jithu.joseph@intel.com>
 <20210222090936.6768-5-jithu.joseph@intel.com>
 <CAJ+HfNhx5LhsS++sFxq2w50gmsnVd2QeXT35ZFVPwvaixbnPAQ@mail.gmail.com>
Message-ID: <2114695f7949bf5d94dea6e6a04c44c226fcf8a8.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2021-02-22 at 10:32 +0100, Bj?rn T?pel wrote:
> On Mon, 22 Feb 2021 at 10:08, Jithu Joseph <jithu.joseph@intel.com>
> wrote:
> > From: Andre Guedes <andre.guedes@intel.com>
> > 
> > Refactor XDP rxq info registration code, preparing the driver for
> > AF_XDP
> > zero-copy support which is added by upcoming patches.
> > 
> > Currently, xdp_rxq and memory model are both registered during RX
> > resource setup time by igc_xdp_register_rxq_info() helper. With
> > AF_XDP,
> > we want to register the memory model later on while configuring the
> > ring
> > because we will know which memory model type to register
> > (MEM_TYPE_PAGE_SHARED or MEM_TYPE_XSK_BUFF_POOL).
> > 
> > The helpers igc_xdp_register_rxq_info() and igc_xdp_unregister_rxq_
> > info() are not useful anymore so they are removed.
> > 
> > Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> > Signed-off-by: Vedang Patel <vedang.patel@intel.com>
> > Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
> > Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > ---
> >  drivers/net/ethernet/intel/igc/igc_main.c | 15 +++++++++----
> >  drivers/net/ethernet/intel/igc/igc_xdp.c  | 27 -----------------
> > ------
> >  drivers/net/ethernet/intel/igc/igc_xdp.h  |  3 ---
> >  3 files changed, 11 insertions(+), 34 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/igc/igc_main.c
> > b/drivers/net/ethernet/intel/igc/igc_main.c
> > index bc086d2f738b..26208441aad3 100644
> > --- a/drivers/net/ethernet/intel/igc/igc_main.c
> > +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> > @@ -419,7 +419,7 @@ void igc_free_rx_resources(struct igc_ring
> > *rx_ring)
> >  {
> >         igc_clean_rx_ring(rx_ring);
> > 
> > -       igc_xdp_unregister_rxq_info(rx_ring);
> > +       xdp_rxq_info_unreg(&rx_ring->xdp_rxq);
> > 
> >         vfree(rx_ring->rx_buffer_info);
> >         rx_ring->rx_buffer_info = NULL;
> > @@ -458,11 +458,15 @@ int igc_setup_rx_resources(struct igc_ring
> > *rx_ring)
> >  {
> >         struct net_device *ndev = rx_ring->netdev;
> >         struct device *dev = rx_ring->dev;
> > +       u8 index = rx_ring->queue_index;
> >         int size, desc_len, res;
> > 
> > -       res = igc_xdp_register_rxq_info(rx_ring);
> > -       if (res < 0)
> > +       res = xdp_rxq_info_reg(&rx_ring->xdp_rxq, ndev, index, 0);
> 
> Thanks for working on AF_XDP ZC support!
> 
> The last argument is the napi_id. Setting this to 0, means that the
> napi_id is unknown/not available at this point. It also means that
> the
> AF_XDP busy-polling using preferred busy-polling [1] will not work.
> If
> the napi is registered at this point, please pass:
> rx_ring->q_vector->napi.napi_id instead of 0!

Thanks for reviewing the patch and suggesting the change. I have
revised the series with this change (in v5) after verifying that
napi_id is available at this point.
(Also apologies for the delay as I am still ramping up on the driver
and XDP)


Thanks
Jithu


