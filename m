From: Arend Van Spriel <arend.vanspriel@broadcom.com>
Date: Mon, 28 Sep 2020 11:34:22 +0200
Subject: [Intel-wired-lan] [patch 26/35] net: brcmfmac: Convey
 allocation mode as argument
In-Reply-To: <20200927194922.444952084@linutronix.de>
References: <20200927194846.045411263@linutronix.de>
 <20200927194922.444952084@linutronix.de>
Message-ID: <aac2b8b3-53f4-9b27-03d0-742bbe3cd81f@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 9/27/2020 9:49 PM, Thomas Gleixner wrote:
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

Looking at the functions changed I see overlap with patch 25/35 so maybe 
change to gfp flag to a 'in_isr' bool. The flag can then be used for 
dealing with netif_rx as well.

Regards,
Arend
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/pkcs7-signature
Size: 4176 bytes
Desc: S/MIME Cryptographic Signature
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200928/ff2058e2/attachment-0001.p7s>
