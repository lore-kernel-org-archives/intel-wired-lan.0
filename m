From: Arend Van Spriel <arend.vanspriel@broadcom.com>
Date: Wed, 30 Sep 2020 00:07:30 +0200
Subject: [Intel-wired-lan] [patch V2 27/36] net: brcmfmac: Convey
 allocation mode as argument
In-Reply-To: <20200929203502.180883992@linutronix.de>
References: <20200929202509.673358734@linutronix.de>
 <20200929203502.180883992@linutronix.de>
Message-ID: <d64a84f6-2ae6-ab26-e7a7-969f45b8cfb8@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 9/29/2020 10:25 PM, Thomas Gleixner wrote:
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> The usage of in_interrupt() in drivers is phased out and Linus clearly
> requested that code which changes behaviour depending on context should
> either be seperated or the context be conveyed in an argument passed by the
> caller, which usually knows the context.
> 
> brcmf_fweh_process_event() uses in_interrupt() to select the allocation
> mode GFP_KERNEL/GFP_ATOMIC. Aside of the above reasons this check is
> incomplete as it cannot detect contexts which just have preemption or
> interrupts disabled.
> 
> All callchains leading to brcmf_fweh_process_event() can clearly identify
> the calling context. Convey a 'gfp' argument through the callchains and let
> the callers hand in the appropriate GFP mode.
> 
> This has also the advantage that any change of execution context or
> preemption/interrupt state in these callchains will be detected by the
> memory allocator for all GFP_KERNEL allocations.

Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> V2: Adopt to the 'inirq' changes
> ---
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c   |   10 ++++++----
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c   |    8 ++------
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.h   |    7 ++++---
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf.c |    2 +-
>   4 files changed, 13 insertions(+), 14 deletions(-)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/pkcs7-signature
Size: 4176 bytes
Desc: S/MIME Cryptographic Signature
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200930/7c4c4347/attachment-0001.p7s>
