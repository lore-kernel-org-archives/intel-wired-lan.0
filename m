From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 2 May 2015 01:32:07 +0000
Subject: [Intel-wired-lan] [PATCH net 2/2] igb: Fix NULL assignment to
 incorrect variable in igb_reset_q_vector
In-Reply-To: <1429016551.2638.10.camel@jtkirshe-mobl>
References: <1428916512-25559-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
 <1428916512-25559-2-git-send-email-makita.toshiaki@lab.ntt.co.jp>
 <1429016551.2638.10.camel@jtkirshe-mobl>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B78DBCFB3@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Tuesday, April 14, 2015 6:03 AM
> To: Toshiaki Makita
> Cc: intel-wired-lan at lists.osuosl.org
> Subject: Re: [Intel-wired-lan] [PATCH net 2/2] igb: Fix NULL assignment to
> incorrect variable in igb_reset_q_vector
> 
> On Mon, 2015-04-13 at 18:15 +0900, Toshiaki Makita wrote:
> > adapter->tx_ring is set to NULL where rx_ring should be.
> >
> > Fixes: 5536d2102a2d ("igb: Combine q_vector and ring allocation into a
> > single function")
> > Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
> > ---
> >  drivers/net/ethernet/intel/igb/igb_main.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Thanks Toshiaki, I have applied your patch to my queue.

Tested-by: Aaron Brown <aaron.f.brown@intel.com>

