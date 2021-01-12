From: Li,Rongqing <lirongqing@baidu.com>
Date: Tue, 12 Jan 2021 02:54:15 +0000
Subject: [Intel-wired-lan] [PATCH] igb: avoid premature Rx buffer reuse
In-Reply-To: <CAKgT0Ucar6h-V2pQK6Gx4wrwFzJqySfv-MGXtW1yEc6Jq3uNSQ@mail.gmail.com>
References: <1609990905-29220-1-git-send-email-lirongqing@baidu.com>
 <CAKgT0Ucar6h-V2pQK6Gx4wrwFzJqySfv-MGXtW1yEc6Jq3uNSQ@mail.gmail.com>
Message-ID: <65a7da2dc20c4fa5b69270f078026100@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Alexander Duyck [mailto:alexander.duyck at gmail.com]
> Sent: Tuesday, January 12, 2021 4:54 AM
> To: Li,Rongqing <lirongqing@baidu.com>
> Cc: Netdev <netdev@vger.kernel.org>; intel-wired-lan
> <intel-wired-lan@lists.osuosl.org>; Bj?rn T?pel <bjorn.topel@intel.com>
> Subject: Re: [PATCH] igb: avoid premature Rx buffer reuse
> 
> On Wed, Jan 6, 2021 at 7:53 PM Li RongQing <lirongqing@baidu.com> wrote:
> >
> > The page recycle code, incorrectly, relied on that a page fragment
> > could not be freed inside xdp_do_redirect(). This assumption leads to
> > that page fragments that are used by the stack/XDP redirect can be
> > reused and overwritten.
> >
> > To avoid this, store the page count prior invoking xdp_do_redirect().
> >
> > Fixes: 9cbc948b5a20 ("igb: add XDP support")
> > Signed-off-by: Li RongQing <lirongqing@baidu.com>
> > Cc: Bj?rn T?pel <bjorn.topel@intel.com>
> 
> I'm not sure what you are talking about here. We allow for a 0 to 1 count
> difference in the pagecount bias. The idea is the driver should be holding onto
> at least one reference from the driver at all times.
> Are you saying that is not the case?
> 
> As far as the code itself we hold onto the page as long as our difference does
> not exceed 1. So specifically if the XDP call is freeing the page the page itself
> should still be valid as the reference count shouldn't drop below 1, and in that
> case the driver should be holding that one reference to the page.
> 
> When we perform our check we are performing it such at output of either 0 if
> the page is freed, or 1 if the page is not freed are acceptable for us to allow
> reuse. The key bit is in igb_clean_rx_irq where we will flip the buffer for the
> IGB_XDP_TX | IGB_XDP_REDIR case and just increment the pagecnt_bias
> indicating that the page was dropped in the non-flipped case.
> 
> Are you perhaps seeing a function that is returning an error and still consuming
> the page? If so that might explain what you are seeing.
> However the bug would be in the other driver not this one. The
> xdp_do_redirect function is not supposed to free the page if it returns an error.
> It is supposed to leave that up to the function that called xdp_do_redirect.
> 
> > ---
> >  drivers/net/ethernet/intel/igb/igb_main.c | 22 +++++++++++++++-------
> >  1 file changed, 15 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/igb/igb_main.c
> > b/drivers/net/ethernet/intel/igb/igb_main.c
> > index 03f78fdb0dcd..3e0d903cf919 100644
> > --- a/drivers/net/ethernet/intel/igb/igb_main.c
> > +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> > @@ -8232,7 +8232,8 @@ static inline bool igb_page_is_reserved(struct
> page *page)
> >         return (page_to_nid(page) != numa_mem_id()) ||
> > page_is_pfmemalloc(page);  }
> >
> > -static bool igb_can_reuse_rx_page(struct igb_rx_buffer *rx_buffer)
> > +static bool igb_can_reuse_rx_page(struct igb_rx_buffer *rx_buffer,
> > +
> int
> > +rx_buf_pgcnt)
> >  {
> >         unsigned int pagecnt_bias = rx_buffer->pagecnt_bias;
> >         struct page *page = rx_buffer->page; @@ -8243,7 +8244,7 @@
> > static bool igb_can_reuse_rx_page(struct igb_rx_buffer *rx_buffer)
> >
> >  #if (PAGE_SIZE < 8192)
> >         /* if we are only owner of page we can reuse it */
> > -       if (unlikely((page_ref_count(page) - pagecnt_bias) > 1))
> > +       if (unlikely((rx_buf_pgcnt - pagecnt_bias) > 1))
> >                 return false;
> >  #else
> I would need more info on the actual issue. If nothing else it might be useful to
> have an example where you print out the page_ref_count versus the
> pagecnt_bias at a few points to verify exactly what is going on. As I said before
> if the issue is the xdp_do_redirect returning an error and still consuming the
> page then the bug is elsewhere and not here.


This patch is same as 75aab4e10ae6a4593a60f66d13de755d4e91f400


commit 75aab4e10ae6a4593a60f66d13de755d4e91f400
Author: Bj?rn T?pel <bjorn.topel@intel.com>
Date:   Tue Aug 25 19:27:34 2020 +0200

    i40e: avoid premature Rx buffer reuse
    
    The page recycle code, incorrectly, relied on that a page fragment
    could not be freed inside xdp_do_redirect(). This assumption leads to
    that page fragments that are used by the stack/XDP redirect can be
    reused and overwritten.
    
    To avoid this, store the page count prior invoking xdp_do_redirect().
    
    Longer explanation:
    
    Intel NICs have a recycle mechanism. The main idea is that a page is
    split into two parts. One part is owned by the driver, one part might
    be owned by someone else, such as the stack.
    
    t0: Page is allocated, and put on the Rx ring
                  +---------------
    used by NIC ->| upper buffer
    (rx_buffer)   +---------------
                  | lower buffer
                  +---------------
      page count  == USHRT_MAX
      rx_buffer->pagecnt_bias == USHRT_MAX
    
    t1: Buffer is received, and passed to the stack (e.g.)
                  +---------------
                  | upper buff (skb)
                  +---------------
    used by NIC ->| lower buffer
    (rx_buffer)   +---------------
      page count  == USHRT_MAX
      rx_buffer->pagecnt_bias == USHRT_MAX - 1
    t2: Buffer is received, and redirected
                  +---------------
                  | upper buff (skb)
                  +---------------
    used by NIC ->| lower buffer
    (rx_buffer)   +---------------
    
    Now, prior calling xdp_do_redirect():
      page count  == USHRT_MAX
      rx_buffer->pagecnt_bias == USHRT_MAX - 2
    
    This means that buffer *cannot* be flipped/reused, because the skb is
    still using it.
    
    The problem arises when xdp_do_redirect() actually frees the
    segment. Then we get:
      page count  == USHRT_MAX - 1
      rx_buffer->pagecnt_bias == USHRT_MAX - 2
    
    From a recycle perspective, the buffer can be flipped and reused,
    which means that the skb data area is passed to the Rx HW ring!
    
    To work around this, the page count is stored prior calling
    xdp_do_redirect().
    
    Note that this is not optimal, since the NIC could actually reuse the
    "lower buffer" again. However, then we need to track whether
    XDP_REDIRECT consumed the buffer or not.
    
    Fixes: d9314c474d4f ("i40e: add support for XDP_REDIRECT")
    Reported-and-analyzed-by: Li RongQing <lirongqing@baidu.com>
    Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
    Tested-by: George Kuruvinakunnel <george.kuruvinakunnel@intel.com>
    Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>


Thanks

-Li
