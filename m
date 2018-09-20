From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu, 20 Sep 2018 14:01:37 -0700
Subject: [Intel-wired-lan] [PATCH net] ixgbe: check return value of
 napi_complete_done()
In-Reply-To: <c1251d5d-4b18-a1de-acd2-6de829b7c7ac@gmail.com>
References: <20180920190113.490005-1-songliubraving@fb.com>
 <c1251d5d-4b18-a1de-acd2-6de829b7c7ac@gmail.com>
Message-ID: <2ca0e823642d232092017f66e8151652e22e74a1.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2018-09-20 at 13:35 -0700, Eric Dumazet wrote:
> On 09/20/2018 12:01 PM, Song Liu wrote:
> > The NIC driver should only enable interrupts when napi_complete_done()
> > returns true. This patch adds the check for ixgbe.
> > 
> > Cc: stable at vger.kernel.org # 4.10+
> > Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> > Suggested-by: Eric Dumazet <edumazet@google.com>
> > Signed-off-by: Song Liu <songliubraving@fb.com>
> > ---
> 
> 
> Well, unfortunately we do not know why this is needed,
> this is why I have not yet sent this patch formally.
> 
> netpoll has correct synchronization :
> 
> poll_napi() places into napi->poll_owner current cpu number before
> calling poll_one_napi()
> 
> netpoll_poll_lock() does also use napi->poll_owner
> 
> When netpoll calls ixgbe poll() method, it passed a budget of 0,
> meaning napi_complete_done() is not called.
> 
> As long as we can not explain the problem properly in the changelog,
> we should investigate, otherwise we will probably see coming dozens of
> patches
> trying to fix a 'potential hazard'.

Agreed, which is why I have our validation and developers looking into it,
while we test the current patch from Song.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180920/5c6fd8f9/attachment.asc>
