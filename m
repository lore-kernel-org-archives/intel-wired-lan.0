From: Arend Van Spriel <arend.vanspriel@broadcom.com>
Date: Mon, 28 Sep 2020 11:40:01 +0200
Subject: [Intel-wired-lan] [patch 24/35] net: brcmfmac: Replace
 in_interrupt()
In-Reply-To: <20200927194922.245750969@linutronix.de>
References: <20200927194846.045411263@linutronix.de>
 <20200927194922.245750969@linutronix.de>
Message-ID: <5e0d60a4-418e-434e-e5fa-4d2dd1cf0d23@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 9/27/2020 9:49 PM, Thomas Gleixner wrote:
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> brcmf_sdio_isr() is using in_interrupt() to distinguish if it is called
> from a interrupt service routine or from a worker thread.
> 
> Passing such information from the calling context is preferred and
> requested by Linus, so add an argument `in_isr' to brcmf_sdio_isr() and let
> the callers pass the information about the calling context.

After getting confirmation here is my ...

Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Arend van Spriel <arend.vanspriel@broadcom.com>
> Cc: Franky Lin <franky.lin@broadcom.com>
> Cc: Hante Meuleman <hante.meuleman@broadcom.com>
> Cc: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
> Cc: Wright Feng <wright.feng@cypress.com>
> Cc: Kalle Valo <kvalo@codeaurora.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: linux-wireless at vger.kernel.org
> Cc: brcm80211-dev-list.pdl at broadcom.com
> Cc: brcm80211-dev-list at cypress.com
> Cc: netdev at vger.kernel.org
> ---
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c |    4 ++--
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c   |    4 ++--
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.h   |    2 +-
>   3 files changed, 5 insertions(+), 5 deletions(-)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/pkcs7-signature
Size: 4176 bytes
Desc: S/MIME Cryptographic Signature
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200928/04397eb9/attachment-0001.p7s>
