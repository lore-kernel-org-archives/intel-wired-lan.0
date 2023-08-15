Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD088C001B0
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Aug 2023 18:38:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 47B3F813BE;
	Tue, 15 Aug 2023 18:38:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 47B3F813BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1692124735;
	bh=j6TGzseJRfRHVreMpDKHDSvcrM/niax1LDe05KxtRmg=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=VY9wGjmHmkMoG+4wdHkHU8Vj1imILlZ9QXHUyPQ8I2xgS127ZaOEQ4aCFRjeAYZ6Y
	 VhCGFYSecA+8QPDUcN2iFvCib+8GKwWfR6z8o7MhdhdQ1NXetzscagIjcqGvVjVtS+
	 dbol4vJ/pfH/LCauemIOWfy3qZCGs2xsb9TOsJM65+UMePbouADTFotFsgcW1Qyjbg
	 7i9LNzJHN5JnH1UxLROc9MXIZbXO8l44TKO1TH3FGmU7AzPGvndBRTjnyLneJVF8w5
	 Xu8wqruQd++DOuUq9+meezy4ECwFSYo0tcfJ51vYHng9M0Vbozse3uswbptFOQAD05
	 KAzFaygB20Cng==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9Lh5ty_LBhqB; Tue, 15 Aug 2023 18:38:54 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 750388137F;
	Tue, 15 Aug 2023 18:38:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 750388137F
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 85E091BF422
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Aug 2023 18:38:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5781A8137F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Aug 2023 18:38:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5781A8137F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id REkUC605kzVF for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Aug 2023 18:38:51 +0000 (UTC)
Received: from out-60.mta1.migadu.com (out-60.mta1.migadu.com
 [IPv6:2001:41d0:203:375::3c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5A59A81373
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Aug 2023 18:38:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5A59A81373
Message-ID: <39e701b4-0992-2c96-67b3-38c341c77af5@linux.dev>
Date: Tue, 15 Aug 2023 19:38:41 +0100
MIME-Version: 1.0
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
References: <20230811200340.577359-1-vadim.fedorenko@linux.dev>
 <20230811200340.577359-4-vadim.fedorenko@linux.dev>
 <20230814201709.655a24e2@kernel.org>
 <ef2eca98-4fcc-b448-fecb-38695238f87b@linux.dev>
 <20230815112856.1f1bd3ac@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20230815112856.1f1bd3ac@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.dev; s=key1; t=1692124729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l71H0XchJUj51QCQRpzWl8MiAbxVsza3vleYUTSEqtE=;
 b=CMD5FNJiviDfxbHNuk8RG4XO8ZCqfxARGsXr9AgrSsoS1mpjwsidIpYQI3xR5mTzGEs0vU
 r1oAuACK5hLHQ76YInPYdy5/aekG7KQ5oICC1lV13jAW8FomaE/Cf7fmbogyFtNBLy7Qp3
 D+G2ERY4tAgLAvqfauVyah4hdUvW7WM=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=CMD5FNJi
Subject: Re: [Intel-wired-lan] [PATCH net-next v4 3/9] dpll: core: Add DPLL
 framework base functions
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
Cc: Jiri Pirko <jiri@resnulli.us>, Bart Van Assche <bvanassche@acm.org>,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-arm-kernel@lists.infradead.org, Jiri Pirko <jiri@nvidia.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-clk@vger.kernel.org, Milena Olech <milena.olech@intel.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On 15/08/2023 19:28, Jakub Kicinski wrote:
> On Tue, 15 Aug 2023 19:20:31 +0100 Vadim Fedorenko wrote:
>>>> +	ret = xa_alloc(&dpll_device_xa, &dpll->id, dpll, xa_limit_16b,
>>>> +		       GFP_KERNEL);
>>>
>>> Why only 16b and why not _cyclic?
>>
>> I cannot image systems with more than 65k of DPLL devices. We don't
>> store any id's of last used DPLL device, so there is no easy way to
>> restart the search from the last point. And it's not a hot path to
>> optimize it.
> 
> I think this gets used under the xa_lock() so you can just add a static
> variable inside the function to remember previous allocation.
> 
> I don't expect >64k devices either, obviously, but what are we saving
> by not allowing the full u32 range?

I don't see any benefits for either _cyclic or u32 range, but if you 
insist I can change it.
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
