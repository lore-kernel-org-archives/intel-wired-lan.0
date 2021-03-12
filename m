From: Jambekar, Vishakha <vishakha.jambekar@intel.com>
Date: Fri, 12 Mar 2021 10:24:06 +0000
Subject: [Intel-wired-lan] [PATCH] igb: avoid premature Rx buffer reuse
In-Reply-To: <65a7da2dc20c4fa5b69270f078026100@baidu.com>
References: <1609990905-29220-1-git-send-email-lirongqing@baidu.com>
 <CAKgT0Ucar6h-V2pQK6Gx4wrwFzJqySfv-MGXtW1yEc6Jq3uNSQ@mail.gmail.com>
 <65a7da2dc20c4fa5b69270f078026100@baidu.com>
Message-ID: <SA2PR11MB4940B65641B2D901330B4E40FF6F9@SA2PR11MB4940.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Li,Rongqing
> Sent: Tuesday, January 12, 2021 8:24 AM
> To: Alexander Duyck <alexander.duyck@gmail.com>
> Cc: Netdev <netdev@vger.kernel.org>; Topel, Bjorn <bjorn.topel@intel.com>;
> intel-wired-lan <intel-wired-lan@lists.osuosl.org>
> Subject: Re: [Intel-wired-lan] [PATCH] igb: avoid premature Rx buffer reuse
> 
> 
> 
> > -----Original Message-----
> > From: Alexander Duyck [mailto:alexander.duyck at gmail.com]
> > Sent: Tuesday, January 12, 2021 4:54 AM
> > To: Li,Rongqing <lirongqing@baidu.com>
> > Cc: Netdev <netdev@vger.kernel.org>; intel-wired-lan
> > <intel-wired-lan@lists.osuosl.org>; Bj?rn T?pel
> > <bjorn.topel@intel.com>
> > Subject: Re: [PATCH] igb: avoid premature Rx buffer reuse
> >
> > On Wed, Jan 6, 2021 at 7:53 PM Li RongQing <lirongqing@baidu.com> wrote:
> > >
> > > The page recycle code, incorrectly, relied on that a page fragment
> > > could not be freed inside xdp_do_redirect(). This assumption leads
> > > to that page fragments that are used by the stack/XDP redirect can
> > > be reused and overwritten.
> > >
> > > To avoid this, store the page count prior invoking xdp_do_redirect().
> > >
> > > Fixes: 9cbc948b5a20 ("igb: add XDP support")
> > > Signed-off-by: Li RongQing <lirongqing@baidu.com>
> > > Cc: Bj?rn T?pel <bjorn.topel@intel.com>
> >
> > I'm not sure what you are talking about here. We allow for a 0 to 1
> > count difference in the pagecount bias. The idea is the driver should
> > be holding onto at least one reference from the driver at all times.
> > Are you saying that is not the case?
> >
> > As far as the code itself we hold onto the page as long as our
> > difference does not exceed 1. So specifically if the XDP call is
> > freeing the page the page itself should still be valid as the
> > reference count shouldn't drop below 1, and in that case the driver should be
> holding that one reference to the page.
> >
> > When we perform our check we are performing it such at output of
> > either 0 if the page is freed, or 1 if the page is not freed are
> > acceptable for us to allow reuse. The key bit is in igb_clean_rx_irq
> > where we will flip the buffer for the IGB_XDP_TX | IGB_XDP_REDIR case
> > and just increment the pagecnt_bias indicating that the page was dropped in
> the non-flipped case.
> >
> > Are you perhaps seeing a function that is returning an error and still
> > consuming the page? If so that might explain what you are seeing.
> > However the bug would be in the other driver not this one. The
> > xdp_do_redirect function is not supposed to free the page if it returns an
> error.
> > It is supposed to leave that up to the function that called xdp_do_redirect.
> >
> > > ---
> > >  drivers/net/ethernet/intel/igb/igb_main.c | 22
> > > +++++++++++++++-------
> > >  1 file changed, 15 insertions(+), 7 deletions(-)
> > >
> Tested-by: Vishakha Jambekar <vishakha.jambekar@intel.com>
