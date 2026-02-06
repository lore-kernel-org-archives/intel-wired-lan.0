Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E02DCEE2080
	for <intel-wired-lan@archiver.kernel.org>; Fri,  6 Feb 2026 10:12:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 976C083FE8;
	Fri,  6 Feb 2026 10:12:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AVWGjhxN0MOB; Fri,  6 Feb 2026 10:12:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 50AA683FE7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1770372738;
	bh=DhaAgJyKGpAxu69onmTYpr1zMQl+4LY07Xc1GM3wQlQ=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RRZBi+bszG+3TkuaR9tqkjDG3V7ItyTC6fsOYO88RAkuAf13KHcGqLMhb7RXHuiLL
	 f6SMirGvJdkkr0bj4/R2Pcq0omSBnbsQrhmP0fIK18CKqLMIs56XgOJ0DU2HFqiHTo
	 OsiOyKiOz7YG8VtwIC/GF4Z6QbIfs34WKShZpsfKsC7CgQKnmyLWck5ZH9TLfoLtYa
	 5HEIMs0AYeLnXcGlFRV3uvWeSiPmuJTRWr8ZTlUareLb/H7EIbEtgN2fcAirf7UL0b
	 C/NDAd8/2NygYvzYfSvmW5FPCe8d+VnUBnyVQ1T0erfJIo1Rq/bW8LRFOGN0xSW1i0
	 8TxmWv20H1tag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 50AA683FE7;
	Fri,  6 Feb 2026 10:12:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9EC22173
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Feb 2026 10:12:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 830636115A
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Feb 2026 10:12:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kpRdEMYv5vCZ for <intel-wired-lan@lists.osuosl.org>;
 Fri,  6 Feb 2026 10:12:16 +0000 (UTC)
X-Greylist: delayed 63903 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 06 Feb 2026 10:12:15 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 471C660B1B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 471C660B1B
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:41d0:203:375::aa; helo=out-170.mta1.migadu.com;
 envelope-from=vadim.fedorenko@linux.dev; receiver=<UNKNOWN> 
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com
 [IPv6:2001:41d0:203:375::aa])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 471C660B1B
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Feb 2026 10:12:15 +0000 (UTC)
Message-ID: <601f0c4b-52d8-4b60-96bf-f2d65f8073d8@linux.dev>
Date: Fri, 6 Feb 2026 10:12:04 +0000
MIME-Version: 1.0
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Willem de Bruijn <willemb@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>
Cc: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
 Kurt Kanzenbach <kurt@linutronix.de>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 Paul Menzel <pmenzel@molgen.mpg.de>,
 "Gomes, Vinicius" <vinicius.gomes@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "Keller, Jacob E" <jacob.e.keller@intel.com>
References: <20260205-igb_irq_ts-v3-1-2efc7bc4b885@linutronix.de>
 <IA3PR11MB898652699383BA265C5747A5E599A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <20260205100347.ssTBDAI_@linutronix.de>
 <IA3PR11MB89865B46DCBEB496BE28703BE599A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <6a0f4cbb-e8b3-4f0e-b7f1-7f9ca5cba97d@linux.dev>
 <20260205145104.iWinkXHv@linutronix.de>
 <66925f09-ef9f-4401-baec-7d4c82a68ce3@linux.dev>
 <20260205164341.pJvni8kA@linutronix.de>
 <76acd5cc-eb6f-4c56-a5e6-f6413736afbb@linux.dev>
 <willemdebruijn.kernel.459b2672b1e7@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <willemdebruijn.kernel.459b2672b1e7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.dev; s=key1; t=1770372731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DhaAgJyKGpAxu69onmTYpr1zMQl+4LY07Xc1GM3wQlQ=;
 b=s1hZQdPCFE8qhcU9pfJ34OOPrLOGMEaldYRioPOYeFAwkarsS9aJKjFZe1mnuBWM0/mgEF
 XMpM54KSCIaU4FlVnTqz3BzQBbPXVzzhVsYng3GqfFD+5XsqR/WpfOLetaMX15ajsu6wT+
 P0mlT45JQxV26mer0sXRaGq9c0djpU0=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linux.dev
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=s1hZQdPC
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

On 05.02.2026 21:41, Willem de Bruijn wrote:
> Vadim Fedorenko wrote:
>> On 05/02/2026 16:43, Sebastian Andrzej Siewior wrote:
>>> On 2026-02-05 16:27:03 [+0000], Vadim Fedorenko wrote:
>>>>> So the only thing that bothers me is the read_lock_bh() in
>>>>> skb_may_tx_timestamp() which deadlocks if the socket is write-locked on
>>>>> the same CPU.
>>>>
>>>> Alright. Now you make me think whether we should enforce OPT_TSONLY
>>>> option on socket which doesn't have CAP_NET_RAW? Then we can get rid of this
>>>> check, and in case sysctl was flipped off - drop TX timestamps as
>>>> it's done now?
>>>
>>> This would "fix" this problem for all users which do deliver the
>>> timestamp from their IRQ handler instead of napi. There are a few of
>>> those…
>>> This would be considered stable material, right? (despite the fact that
>>> we have it for quite some time and nobody complained so far).
>>
>> cc: Willem as he is the author of the check introduced back in 2015.
>>
>> But it's more like a question to maintainers whether it is acceptable
>> way of "fixing" drivers or it's no-go solution
> 
> Requiring OPT_TSONLY unless CAP_NET_RAW would break legacy users.

Well, they are kinda broken already. Without OPT_TSONLY and CAP_NET_RAW all TX
timestamps are silently dropped. To receive these timestamps users have to get
CAP_NET_RAW permission, and it will work with the updated logic as well...
