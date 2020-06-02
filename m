From: Li,Rongqing <lirongqing@baidu.com>
Date: Tue, 2 Jun 2020 12:10:18 +0000
Subject: [Intel-wired-lan] =?utf-8?b?562U5aSNOiBbUEFUQ0hdIGk0MGU6IGZpeCB3?=
 =?utf-8?q?rong_index_in_i40e=5Fxsk=5Fumem=5Fdma=5Fmap?=
In-Reply-To: <CAJ+HfNjXh882Dc2N9qpYDGhEuTed9Vp36RuHSXnBMmWXfV9iHg@mail.gmail.com>
References: <1591089148-959-1-git-send-email-lirongqing@baidu.com>
 <CAJ+HfNjXh882Dc2N9qpYDGhEuTed9Vp36RuHSXnBMmWXfV9iHg@mail.gmail.com>
Message-ID: <562a0ea8fe694d5c82dba6f446d1b518@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----????-----
> ???: Bj?rn T?pel [mailto:bjorn.topel at gmail.com]
> ????: 2020?6?2? 19:27
> ???: Li,Rongqing <lirongqing@baidu.com>; intel-wired-lan
> <intel-wired-lan@lists.osuosl.org>; Netdev <netdev@vger.kernel.org>
> ??: bpf <bpf@vger.kernel.org>; Karlsson, Magnus
> <magnus.karlsson@intel.com>
> ??: Re: [PATCH] i40e: fix wrong index in i40e_xsk_umem_dma_map
> 
> On Tue, 2 Jun 2020 at 11:20, Li RongQing <lirongqing@baidu.com> wrote:
> >
> 
> Li, thanks for the patch! Good catch!
> 
> Please add a proper description for the patch. The fix should be added to the
> stable branches (5.7 and earlier). Note that this code was recently removed in
> favor of the new AF_XDP buffer allocation scheme.
> 
> 

Ok

-LiRongQing 

> Bj?rn
> 
> > Fixes: 0a714186d3c0 "(i40e: add AF_XDP zero-copy Rx support)"
> > Signed-off-by: Li RongQing <lirongqing@baidu.com>
> > ---
> >  drivers/net/ethernet/intel/i40e/i40e_xsk.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > index 0b7d29192b2c..c926438118ea 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > @@ -37,9 +37,9 @@ static int i40e_xsk_umem_dma_map(struct i40e_vsi
> > *vsi, struct xdp_umem *umem)
> >
> >  out_unmap:
> >         for (j = 0; j < i; j++) {
> > -               dma_unmap_page_attrs(dev, umem->pages[i].dma,
> PAGE_SIZE,
> > +               dma_unmap_page_attrs(dev, umem->pages[j].dma,
> > + PAGE_SIZE,
> >                                      DMA_BIDIRECTIONAL,
> I40E_RX_DMA_ATTR);
> > -               umem->pages[i].dma = 0;
> > +               umem->pages[j].dma = 0;
> >         }
> >
> >         return -1;
> > --
> > 2.16.2
> >
