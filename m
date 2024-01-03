Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DBDFC47073
	for <intel-wired-lan@archiver.kernel.org>; Wed,  3 Jan 2024 22:13:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9DA3581437;
	Wed,  3 Jan 2024 22:13:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9DA3581437
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1704320010;
	bh=fHwQ56i97OHIXttecD026MYSyAw2rlXnCq/U+o4NtQU=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=Mw5s0T7JQmTr7/w5FXYkrH0tlrBfM4HTn/xZpnxTC+NxVdyHqweRI7XV1C8pL8QSA
	 +fOQE7hryP0e4curtYgL3xbI1/laf1FRNYLMrb+X+cBfzeTQ3m2SpzUbRMBfoN/99e
	 NONdgMyWBZQTK1hWtqPV0Edka5dU6FdWR5FTqJg4UW5Z80M50jnQvFM5FgOsETOPke
	 zOxv/p5584XeGLq1qIr5oi6QvTzLSm7q0tzqzoU27DkKyTc+5QYcjR11A3ObFrLP7J
	 4rCspdRiD8wITQ9y8JO2ac6X9NQFvjTlq4CPgOig0QnkzaF2XneimP0cUC5UFb8JGp
	 yty6om10F+s6Q==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NxxI2zoupRz3; Wed,  3 Jan 2024 22:13:30 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id BA83B813D4;
	Wed,  3 Jan 2024 22:13:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BA83B813D4
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 998F61BF48B
 for <intel-wired-lan@lists.osuosl.org>; Wed,  3 Jan 2024 22:13:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 706FE8131B
 for <intel-wired-lan@lists.osuosl.org>; Wed,  3 Jan 2024 22:13:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 706FE8131B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3R8qz9piD91D for <intel-wired-lan@lists.osuosl.org>;
 Wed,  3 Jan 2024 22:13:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BEA3480B84
 for <intel-wired-lan@lists.osuosl.org>; Wed,  3 Jan 2024 22:13:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BEA3480B84
Received: from [50.53.46.231] (helo=[192.168.254.15])
 by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
 id 1rL9U9-00CEYx-2Y; Wed, 03 Jan 2024 22:13:13 +0000
Message-ID: <3466355c-dc30-4638-9bbe-a7433477340c@infradead.org>
Date: Wed, 3 Jan 2024 14:13:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: lakshmi.sowjanya.d@intel.com, tglx@linutronix.de, jstultz@google.com,
 giometti@enneenne.com, corbet@lwn.net, linux-kernel@vger.kernel.org
References: <20240103115602.19044-1-lakshmi.sowjanya.d@intel.com>
 <20240103115602.19044-11-lakshmi.sowjanya.d@intel.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240103115602.19044-11-lakshmi.sowjanya.d@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; 
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
 Message-ID:Sender:Reply-To:Content-ID:Content-Description;
 bh=fHwQ56i97OHIXttecD026MYSyAw2rlXnCq/U+o4NtQU=; b=TQgtpQwWC4q+uBbxLsGIu9TdMR
 A1JMSyXBnIMP0z1jFR3+80MOnElOPNCfoV8Ar1xrBtaxE+GR50TysDT35s7Nv7qkGPpp554QbQ5ji
 2Ce0EEGf8NBuN4a+FbV5WgaGxPPuCtDqVDreR2Cf0tR9okTRrwkB8mNrGeCA1UPV3EOS+vpiyLt/O
 uJ+lMmAbXQgb1x6wPtzGmoInRuhGw1fEhoATgHtY3EGDH3cPt876igUx0ae0/BDzdBUkxk+Tv17vp
 uioPCfzrK1NVkArGYtNJL5Fw7NSFc6bbEoU+p+UJuyVCmy3sjBhDyajVDQR7PchvBGVwEpBSBu2A6
 9vTL2mOw==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20210309 header.b=TQgtpQwW
Subject: Re: [Intel-wired-lan] [RFC PATCH v3 10/11] Documentation:
 driver-api: pps: Add Intel Timed I/O PPS generator
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Unsubscribe: <https://lists.osuosl.org/mailman/options/intel-wired-lan>, 
 <mailto:intel-wired-lan-request@osuosl.org?subject=unsubscribe>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
Cc: christopher.s.hall@intel.com, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org, pandith.n@intel.com, x86@kernel.org,
 eddie.dong@intel.com, jesse.brandeburg@intel.com, linux-sound@vger.kernel.org,
 alexandre.torgue@foss.st.com, mallikarjunappa.sangannavar@intel.com,
 joabreu@synopsys.com, intel-wired-lan@lists.osuosl.org,
 mcoquelin.stm32@gmail.com, thejesh.reddy.t.r@intel.com, perex@perex.cz,
 anthony.l.nguyen@intel.com, andriy.shevchenko@linux.intel.com,
 davem@davemloft.net
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>



On 1/3/24 03:56, lakshmi.sowjanya.d@intel.com wrote:
> From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
> 
> Add Intel Timed I/O PPS usage instructions.
> 
> Co-developed-by: Pandith N <pandith.n@intel.com>
> Signed-off-by: Pandith N <pandith.n@intel.com>
> Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  Documentation/driver-api/pps.rst | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/Documentation/driver-api/pps.rst b/Documentation/driver-api/pps.rst
> index 78dded03e5d8..cb1e4d814d37 100644
> --- a/Documentation/driver-api/pps.rst
> +++ b/Documentation/driver-api/pps.rst
> @@ -246,3 +246,25 @@ delay between assert and clear edge as small as possible to reduce system
>  latencies. But if it is too small slave won't be able to capture clear edge
>  transition. The default of 30us should be good enough in most situations.
>  The delay can be selected using 'delay' pps_gen_parport module parameter.
> +
> +
> +Intel Timed I/O PPS signal generator
> +------------------------------------
> +
> +Intel Timed I/O is a high precision device, present on 2019 and newer Intel
> +CPUs, that can generate PPS signal.

              can generate a PPS signal.
or
              can generate PPS signals.

> +
> +Timed I/O and system time are both driven by same hardware clock, The signal

                                                              clock. The signal is

> +generated with a precision of ~20 nanoseconds. The generated PPS signal
> +is used to synchronize an external device with system clock. For example,
> +Share your clock with a device that receives PPS signal, generated by

   share

> +Timed I/O device. There are dedicated Timed I/O pins to deliver PPS signal

maybe:                                                  to deliver the PPS signal

> +to an external device.
> +
> +Usage of Intel Timed I/O as PPS generator:
> +
> +Start generating PPS signal::
> +        $echo 1 > /sys/devices/platform/INTCxxxx\:00/enable
> +
> +Stop generating PPS signal::
> +        $echo 0 > /sys/devices/platform/INTCxxxx\:00/enable

-- 
#Randy
