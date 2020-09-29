From: Arend Van Spriel <arend.vanspriel@broadcom.com>
Date: Wed, 30 Sep 2020 00:03:59 +0200
Subject: [Intel-wired-lan] [patch V2 26/36] net: brcmfmac: Convey
 execution context via argument to brcmf_netif_rx()
In-Reply-To: <20200929203502.084703195@linutronix.de>
References: <20200929202509.673358734@linutronix.de>
 <20200929203502.084703195@linutronix.de>
Message-ID: <0f26e8be-bfb1-7e69-3a8d-a5ef2bf22b25@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 9/29/2020 10:25 PM, Thomas Gleixner wrote:
> bcrmgf_netif_rx() uses in_interrupt to chose between netif_rx() and
> netif_rx_ni(). in_interrupt() usage in drivers is phased out.
> 
> Convey the execution mode via an 'inirq' argument through the various
> callchains leading to brcmf_netif_rx():
> 
> brcmf_pcie_isr_thread()		    <- Task context
>    brcmf_proto_msgbuf_rx_trigger()
>      brcmf_msgbuf_process_rx()
>        brcmf_msgbuf_process_msgtype()
>          brcmf_msgbuf_process_rx_complete()
> 	  brcmf_netif_mon_rx()
> 	     brcmf_netif_rx(isirq = false)
> 	  brcmf_netif_rx(isirq = false)
> 
> brcmf_sdio_readframes()  <- Task context sdio_claim_host() might sleep
>    brcmf_rx_frame(isirq = false)
> 
> brcmf_sdio_rxglom()      <- Task context sdio_claim_host() might sleep
>    brcmf_rx_frame(isirq = false)
> 
> brcmf_usb_rx_complete()  <- Interrupt context
>    brcmf_rx_frame(isirq = true)
> 
> brcmf_rx_frame()
>    brcmf_proto_rxreorder()
>      brcmf_proto_bcdc_rxreorder()
>        brcmf_fws_rxreorder()
>          brcmf_netif_rx()
>        brcmf_netif_rx()

Thanks for taking the dive.

Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Arend van Spriel <arend.vanspriel@broadcom.com>
> Cc: Kalle Valo <kvalo@codeaurora.org>
> ---
> V2: New patch. Using an argument instead of switching to netif_rx_any_context()
> ---
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcdc.c     |    4 +--
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h      |    3 +-
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c     |   16 ++++++------
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h     |    2 -
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c |   10 +++----
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.h |    2 -
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf.c   |    5 ++-
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/proto.h    |    6 ++--
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c     |    4 +--
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c      |    2 -
>   10 files changed, 29 insertions(+), 25 deletions(-)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/pkcs7-signature
Size: 4176 bytes
Desc: S/MIME Cryptographic Signature
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200930/8ad054ab/attachment.p7s>
