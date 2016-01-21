From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 20 Jan 2016 19:32:19 -0800
Subject: [Intel-wired-lan] [PATCH RESEND v2] ixgbe: on recv increment
	rx.ring->stats.yields
In-Reply-To: <1453277324-6180-1-git-send-email-ptikhomirov@virtuozzo.com>
References: <1453277324-6180-1-git-send-email-ptikhomirov@virtuozzo.com>
Message-ID: <1453347139.3312.2.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2016-01-20 at 11:08 +0300, Pavel Tikhomirov wrote:
> It seem to be non intentionaly changed to tx in
> commit adc810900a70 ("ixgbe: Refactor busy poll socket code to
> address
> multiple issues")
> 
> Lock is taken from ixgbe_low_latency_recv, and there under this
> lock we use ixgbe_clean_rx_irq so it looks wrong for me to increment
> tx counter.
> 
> Yield stats can be shown through ethtool:
> ethtool -S enp129s0 | grep yield
> 
> v2: follow commit citing style
> 
> Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
> ---
> ?drivers/net/ethernet/intel/ixgbe/ixgbe.h | 2 +-
> ?1 file changed, 1 insertion(+), 1 deletion(-)

Why are you re-sending this patch? ?I already have it queued up for
testing in my tree. ?This just causes problems and extra work for me.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160120/8c3c2202/attachment.asc>
