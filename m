From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 2 May 2015 01:32:01 +0000
Subject: [Intel-wired-lan] [PATCH net 1/2] igb: Fix oops on
	changing	number of rings
In-Reply-To: <1429016502.2638.9.camel@jtkirshe-mobl>
References: <1428916512-25559-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
 <1429016502.2638.9.camel@jtkirshe-mobl>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B78DBCFAA@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Tuesday, April 14, 2015 6:02 AM
> To: Toshiaki Makita
> Cc: intel-wired-lan at lists.osuosl.org
> Subject: Re: [Intel-wired-lan] [PATCH net 1/2] igb: Fix oops on changing
> number of rings
> 
> On Mon, 2015-04-13 at 18:15 +0900, Toshiaki Makita wrote:
> > When changing the number of rings by ethtool -L, q_vectors are reused,
> > which causes oops because of uninitialized pointers.
> >
> > - When an rx is reused as a tx, q_vector->rx.ring is not set to NULL,
> > which
> >   misleads igb_poll() to determine that it has an rx ring although it
> >   actually points to the tx ring.
> > - When a tx is reused as an rx, q_vector->rx.ring->skb
> >   (q_vector->ring[0].skb) has a value that was used as tx_stats
> > before.
> >
> > Fix these problems by zeroing it out on reuseing it.
> >
> > Fixes: 02ef6e1d0b00 ("igb: Fix queue allocation method to accommodate
> > changing during runtime")
> > Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
> > ---
> >  drivers/net/ethernet/intel/igb/igb_main.c | 2 ++
> >  1 file changed, 2 insertions(+)
> 
> Thanks Toshiaki, I have applied your patch to my queue.
> --

Tested-by: Aaron Brown <aaron.f.brown@intel.com>

