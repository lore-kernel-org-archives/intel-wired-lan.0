Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C7D0ECD989
	for <intel-wired-lan@archiver.kernel.org>; Thu,  5 Feb 2026 16:48:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0AC8840D8F;
	Thu,  5 Feb 2026 16:48:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2w1mDO2-99as; Thu,  5 Feb 2026 16:48:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 74F0A40D51
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1770310094;
	bh=vSwoma4O2xrgSZMEnOzQ9SyuZba4dI6P6unZjdIT0ZA=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ALdGfnn8JsIWCG4zAHJsHWqB1joV3tK6fzjx+FcU2IaWqSf2ulEJaXVOcyOQc+2O0
	 klfcd7purUs/kVFp6wGv7zvw5mvuR7grVfxHKqaH9UJcNRM/vVS6nu4AwDUtBU+qiw
	 GlPmN70VpD4rXIRvGJosNpKCH9x/hv5fAWNLDBKrok0qweqS4hb4qf/Fj1DWdwLLK0
	 RC889subDc+HirveibRVcpFDPyEt6DZGVJKd+fErQA1oefaRPHcN76COM+X6BGcqWJ
	 u3JMm/3L3BO992mh2xDt+kO5AyQX1QpYttY+ja8R0G+G++8SRMKv/Yem0zidFs3Its
	 qnFyO8CYiLvrw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 74F0A40D51;
	Thu,  5 Feb 2026 16:48:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id DBA1017A
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Feb 2026 16:48:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CD0A940D51
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Feb 2026 16:48:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 11uf3mgYshfk for <intel-wired-lan@lists.osuosl.org>;
 Thu,  5 Feb 2026 16:48:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=95.215.58.171;
 helo=out-171.mta1.migadu.com; envelope-from=vadim.fedorenko@linux.dev;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org BFC4440D3A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BFC4440D3A
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com
 [95.215.58.171])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BFC4440D3A
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Feb 2026 16:48:10 +0000 (UTC)
Message-ID: <76acd5cc-eb6f-4c56-a5e6-f6413736afbb@linux.dev>
Date: Thu, 5 Feb 2026 16:48:01 +0000
MIME-Version: 1.0
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260205164341.pJvni8kA@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.dev; s=key1; t=1770310085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vSwoma4O2xrgSZMEnOzQ9SyuZba4dI6P6unZjdIT0ZA=;
 b=NAqYauyOnOdnTPlNxN2yN8J2WrIwnB8RffBEJyunEHPilpcgkGbKlVr6ZuZrNxdvba0nQc
 EBsIkWkdC0ykONGwon5Q1UPmJ9vh7l5KnKOxjyc1kvoydAGGINbY5kN93lunt/XSJWR2P7
 atytxicDFNqOPgQM1rBcSU7eFs3zqxc=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linux.dev
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=NAqYauyO
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

On 05/02/2026 16:43, Sebastian Andrzej Siewior wrote:
> On 2026-02-05 16:27:03 [+0000], Vadim Fedorenko wrote:
>>> So the only thing that bothers me is the read_lock_bh() in
>>> skb_may_tx_timestamp() which deadlocks if the socket is write-locked on
>>> the same CPU.
>>
>> Alright. Now you make me think whether we should enforce OPT_TSONLY
>> option on socket which doesn't have CAP_NET_RAW? Then we can get rid of this
>> check, and in case sysctl was flipped off - drop TX timestamps as
>> it's done now?
> 
> This would "fix" this problem for all users which do deliver the
> timestamp from their IRQ handler instead of napi. There are a few of
> those…
> This would be considered stable material, right? (despite the fact that
> we have it for quite some time and nobody complained so far).

cc: Willem as he is the author of the check introduced back in 2015.

But it's more like a question to maintainers whether it is acceptable
way of "fixing" drivers or it's no-go solution
