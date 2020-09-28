From: Arend Van Spriel <arend.vanspriel@broadcom.com>
Date: Mon, 28 Sep 2020 10:03:25 +0200
Subject: [Intel-wired-lan] [patch 25/35] net: brcmfmac: Use
 netif_rx_any_context().
In-Reply-To: <20200927194922.339094192@linutronix.de>
References: <20200927194846.045411263@linutronix.de>
 <20200927194922.339094192@linutronix.de>
Message-ID: <174d3bce0c8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 9/27/2020 9:49 PM, Thomas Gleixner wrote:
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>
> The usage of in_interrupt() in non-core code is phased out. Ideally the
> information of the calling context should be passed by the callers or the
> functions be split as appropriate.
>
> brcmfmac uses in_interupt() to select the netif_rx*() variant which matches
> the calling context. The attempt to consolidate the code by passing an
> arguemnt or by distangling it failed due lack of knowledge about this
> driver and because the call chains are convoluted and hard to follow.

I think it is only for USB devices that the function can be called in
"interrupt" context. PCIe devices call it from thread context for sure.
The function brcmf_netif_rx() is (in)directly called by brcmf_rx_frame(), 
which is used by SDIO and USB. Anyway, it will be a bit more work, but 
doable. Let me see what I can come up with.

Regards,
Arend


-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/pkcs7-signature
Size: 4176 bytes
Desc: S/MIME Cryptographic Signature
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200928/2c81f2e0/attachment-0001.p7s>
