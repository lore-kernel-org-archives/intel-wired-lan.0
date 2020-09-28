From: Arend Van Spriel <arend.vanspriel@broadcom.com>
Date: Mon, 28 Sep 2020 11:37:43 +0200
Subject: [Intel-wired-lan] [patch 24/35] net: brcmfmac: Replace
 in_interrupt()
In-Reply-To: <CAPDyKFrC2j5S7NrtTRCBga=rttKBp-OZnsEnAEgnXj8zj11p0w@mail.gmail.com>
References: <20200927194846.045411263@linutronix.de>
 <20200927194922.245750969@linutronix.de>
 <a345ad51-4db7-5e4f-3ff9-f1673c12da99@broadcom.com>
 <CAPDyKFrC2j5S7NrtTRCBga=rttKBp-OZnsEnAEgnXj8zj11p0w@mail.gmail.com>
Message-ID: <c0e376ac-3261-e413-0fe1-505aaa7cbea9@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 9/28/2020 11:19 AM, Ulf Hansson wrote:
> On Mon, 28 Sep 2020 at 09:35, Arend Van Spriel
> <arend.vanspriel@broadcom.com> wrote:
>>
>> + Uffe
>>
>> On 9/27/2020 9:49 PM, Thomas Gleixner wrote:
>>> @@ -85,7 +85,7 @@ static void brcmf_sdiod_ib_irqhandler(st
>>>
>>>        brcmf_dbg(INTR, "IB intr triggered\n");
>>>
>>> -     brcmf_sdio_isr(sdiodev->bus);
>>> +     brcmf_sdio_isr(sdiodev->bus, false);
>>>    }
>>
>> Hi Uffe,
>>
>> I assume the above code is okay, but want to confirm. Is the SDIO
>> interrupt guaranteed to be on a worker thread?
> 
> Correct.
> 
> As a matter of fact, the sdio irqs can be delivered through a couple
> of different paths. The legacy (scheduled for removal), is from a
> dedicated kthread. The more "modern" way is either from the context of
> a threaded IRQ handler or via a workqueue.
> 
> However, there are also so-called out of band SDIO irqs, typically
> routed via a separate GPIO line. This isn't managed by the MMC/SDIO
> subsystem, but the SDIO functional driver itself.

In brcmfmac we indeed support the out-of-band interrupt. That scnenario 
is also taken care of in this patch. Thanks for the confirmation.

Regards,
Arend
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/pkcs7-signature
Size: 4176 bytes
Desc: S/MIME Cryptographic Signature
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200928/c06b9ee1/attachment-0001.p7s>
