From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 11 Dec 2015 16:47:33 +0300
Subject: [Intel-wired-lan] [PATCH] ixgbe: on recv increment
 rx.ring->stats.yields instead of tx
In-Reply-To: <1449818646-29348-1-git-send-email-ptikhomirov@virtuozzo.com>
References: <1449818646-29348-1-git-send-email-ptikhomirov@virtuozzo.com>
Message-ID: <566AD3F5.9050502@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello.

On 12/11/2015 10:24 AM, Pavel Tikhomirov wrote:

> It seem to be non intentionaly changed to tx in
> ms commit: adc810900a703ee78fe88fd65e086d359fec04b2
> ixgbe: Refactor busy poll socket code to address multiple issues

    scripts/checkpatch.pl now enforces uniform style of the commit citing, 
please follow.

> Lock is taken from ixgbe_low_latency_recv, and there under this
> lock we use ixgbe_clean_rx_irq so it looks wrong for me to increment
> tx counter.
>
> Yield stats can be shown through ethtool:
> ethtool -S enp129s0 | grep yield
>
> Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
[...]

MBR, Sergei

