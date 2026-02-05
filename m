Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2775EC1EA7
	for <intel-wired-lan@archiver.kernel.org>; Thu,  5 Feb 2026 11:57:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8B797607CA;
	Thu,  5 Feb 2026 11:57:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ftyV4fAims1E; Thu,  5 Feb 2026 11:56:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 573706074A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1770292616;
	bh=YWd1t7s8OVCzkHAhm4N5l/L4ZD0CWDELd1TJlLAt68U=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FDUfqy/UPLnjGDcME64etRidzn3IAnheY15M0pR3U6UtjcpYaKqI+OOQrTmMHE0BF
	 58V642hQ5Sey4MvWFXiTVuW97UcufJdky4KmKvxDXaLEKEzXzMCSXqYEnwCluWAv6m
	 eBW+LCYW8sbo0PYMoBl95yLxM1SdZVtXK0GACNe92J34JEPUXLod9ApsT46X0JT8Fb
	 zwfqS2PGxC7Qv6WGOWL/Fysi63Zi/pI9bkH3uwjQxtrNg23FT/p0fHEk9hAmO05K1/
	 8HISH/ZvOXvKkjRGSwgASWcyHE9AkJe+k9vv8A60OCQahLwvybBtd82bO0kGHLK1wi
	 Ul3tycv2EgRJw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 573706074A;
	Thu,  5 Feb 2026 11:56:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E9ADAF5
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Feb 2026 11:56:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D6E3A40789
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Feb 2026 11:56:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XWsFNj0JN8_q for <intel-wired-lan@lists.osuosl.org>;
 Thu,  5 Feb 2026 11:56:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=91.218.175.181;
 helo=out-181.mta0.migadu.com; envelope-from=vadim.fedorenko@linux.dev;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org E2B334075C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E2B334075C
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com
 [91.218.175.181])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E2B334075C
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Feb 2026 11:56:52 +0000 (UTC)
Message-ID: <6a0f4cbb-e8b3-4f0e-b7f1-7f9ca5cba97d@linux.dev>
Date: Thu, 5 Feb 2026 11:56:44 +0000
MIME-Version: 1.0
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Kurt Kanzenbach <kurt@linutronix.de>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 Paul Menzel <pmenzel@molgen.mpg.de>,
 "Gomes, Vinicius" <vinicius.gomes@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "Keller, Jacob E" <jacob.e.keller@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
References: <20260205-igb_irq_ts-v3-1-2efc7bc4b885@linutronix.de>
 <IA3PR11MB898652699383BA265C5747A5E599A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <20260205100347.ssTBDAI_@linutronix.de>
 <IA3PR11MB89865B46DCBEB496BE28703BE599A@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <IA3PR11MB89865B46DCBEB496BE28703BE599A@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.dev; s=key1; t=1770292608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YWd1t7s8OVCzkHAhm4N5l/L4ZD0CWDELd1TJlLAt68U=;
 b=tWjgK1GYjSewCFxQBoXE6X/4NUyrFwcikDUcmUkvHi15VclE2tLCZgaKnKapRe007LcxlF
 rm4ZcLBv9tiWAxt/q8yJrSc/tXpDJ7+1c6SmxIi2i5CsKS61MjwsAs6V72ZT/x00fGNgWn
 ep18WFCopxHrV2i7BZD7AffQdCzj9to=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linux.dev
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=tWjgK1GY
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3] igb: Retrieve Tx
 timestamp directly from interrupt for i210
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
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
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On 05/02/2026 10:37, Loktionov, Aleksandr wrote:
> 
> 
>> -----Original Message-----
>> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> Sent: Thursday, February 5, 2026 11:04 AM
>> To: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
>> Cc: Kurt Kanzenbach <kurt@linutronix.de>; Nguyen, Anthony L
>> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
>> <przemyslaw.kitszel@intel.com>; Paul Menzel <pmenzel@molgen.mpg.de>;
>> Vadim Fedorenko <vadim.fedorenko@linux.dev>; Gomes, Vinicius
>> <vinicius.gomes@intel.com>; netdev@vger.kernel.org; Richard Cochran
>> <richardcochran@gmail.com>; linux-kernel@vger.kernel.org; Andrew Lunn
>> <andrew+netdev@lunn.ch>; Eric Dumazet <edumazet@google.com>; intel-
>> wired-lan@lists.osuosl.org; Keller, Jacob E
>> <jacob.e.keller@intel.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
>> Abeni <pabeni@redhat.com>; David S. Miller <davem@davemloft.net>
>> Subject: Re: RE: [Intel-wired-lan] [PATCH iwl-next v3] igb: Retrieve
>> Tx timestamp directly from interrupt for i210
>>
>> On 2026-02-05 09:47:14 [+0000], Loktionov, Aleksandr wrote:
>> …
>>>> --- a/drivers/net/ethernet/intel/igb/igb_ptp.c
>>>> +++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
>>>> @@ -796,6 +796,28 @@ static int igb_ptp_verify_pin(struct
>> …
>>>> +	igb_ptp_tx_hwtstamp(adapter); <-Calls existing function
>> designed for work queue!
>>>
>>> skb_tstamp_tx() can sleep
>>> Smells like sleep-in-atomic isn't it?
>>
>> How or where can it sleep?
>>
>> Sebastian
> 
> igb_ptp_tx_hwtstamp() -> https://elixir.bootlin.com/linux/v6.19-rc5/C/ident/skb_tstamp_tx -> https://elixir.bootlin.com/linux/v6.19-rc5/C/ident/__skb_complete_tx_timestamp -> https://elixir.bootlin.com/linux/v6.19-rc5/C/ident/sock_queue_err_skb -> https://elixir.bootlin.com/linux/v6.19-rc5/C/ident/skb_queue_tail -> https://elixir.bootlin.com/linux/v6.19-rc5/source/net/core/skbuff.c#L4075
> 
> spin_lock_irqsave(&wq_head->lock, flags);  <- RT mutex can sleep

Hmm... that actually means we have some drivers broken for RT kernels if
they are processing TX timestamps within a single irq vector:
- hisilicon/hns3
- intel/i40e (and ice probably)
- marvell/mvpp2

For igb/igc/i40e it's still OK to process TX timestamps directly in
MSI-X configuration, as ring processing has separate vector, right?

But in general skb_tstamp_tx should be moved to BH processing (NAPI poll
callback).
