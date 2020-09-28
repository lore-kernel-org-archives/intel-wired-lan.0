From: Arend Van Spriel <arend.vanspriel@broadcom.com>
Date: Mon, 28 Sep 2020 09:35:38 +0200
Subject: [Intel-wired-lan] [patch 24/35] net: brcmfmac: Replace
 in_interrupt()
In-Reply-To: <20200927194922.245750969@linutronix.de>
References: <20200927194846.045411263@linutronix.de>
 <20200927194922.245750969@linutronix.de>
Message-ID: <a345ad51-4db7-5e4f-3ff9-f1673c12da99@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

+ Uffe

On 9/27/2020 9:49 PM, Thomas Gleixner wrote:
> @@ -85,7 +85,7 @@ static void brcmf_sdiod_ib_irqhandler(st
>   
>   	brcmf_dbg(INTR, "IB intr triggered\n");
>   
> -	brcmf_sdio_isr(sdiodev->bus);
> +	brcmf_sdio_isr(sdiodev->bus, false);
>   }

Hi Uffe,

I assume the above code is okay, but want to confirm. Is the SDIO 
interrupt guaranteed to be on a worker thread?

Thanks,
Arend
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/pkcs7-signature
Size: 4176 bytes
Desc: S/MIME Cryptographic Signature
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200928/6c6f49f1/attachment-0001.p7s>
