Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B577B60A2602
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Nov 2026 14:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=dHck848c;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=EmsZyBQW
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 821D88126B;
	Wed, 18 Nov 2026 14:52:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id So34ePF5OcPf; Wed, 18 Nov 2026 14:52:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 85B528125A
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795013559;
	b=Wc4wMoJokagyYB8HaYh7R2XNjNoQo+SWaOoCHobiTGiPDLXCTPpEIMo0ImR6lU2ofXea
	 GhW6aBEdlOBpWxBN6UZblDE8qMaUBBPA8Jz0txKM7WB5eUT4J5hcvo9LNNSGp/RCMCYug
	 r1BVh82nQpmtNB7zzG6A4JdRmcNvThWt/5dFzEWTKtEbM5HsVosdr/KEye4RatHMvmn+7
	 9vMBEXIM5wcuWownKeoHYUwjLfiCARWudneXrHGcMB/GzkFyWeFnLkB3feua0pDk8aX7F
	 or/3KMNKO5Ad2bSPPsEf4Kbq17eKsSjfXvzNiYK4HQfl2Fj6xKdQIshbhAVr7S/z2Ow==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795013559;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:Organization:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Rspamd-Queue-Id:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=pnA9abm8tKCVM9tIK3l/Su5BC83HTMGiHZbk93iWfqI=;
	b=RR5ByNLZbu2pMRIPAQxdd80UaTDNMnbdA6+ZCcF/DHLnQNU+bMu7tLTtKUa4gzp2n193
	 JB3XJFbKp7+N/ohELqm2vtw+POxshwmInVqCLf7n2CCYDxmW02mjM9x22hSmLhs5tUJZP
	 Xvx7YwX4sggMpLGw2KfpwjRByMEvWqQjEr+dA0XIVUaXxVPZ/mIldb/SXap1NSusWb0w4
	 SE80NaxUoWq6BCvi3iVbs9rlmcDuQ2LfRqtwrrFM3rCRRIuxjPPJ8SVH4/Fhpq/70Fg+e
	 IGeqe//eUdWF3HdYG5s2Ve2lpYg1TOj7EB5b83LCeDbiagbItpO8aeiMuK3FAIaWbuw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795013559;
	bh=pnA9abm8tKCVM9tIK3l/Su5BC83HTMGiHZbk93iWfqI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dHck848c8orzuPsUYPDGTRjfxIZcYSGv1f/7wK/pdK64hKnf13swP+Dp/UaUySOql
	 kbwJKm7KrOmXcaORqMRDscTu5HnGEMc8th7hR99v1F2i//bVyZm1fVuVvCobmQZrBP
	 9v42EmEuHLWDDbzloArlytdPR6hSt3mNb8r0+tXnWMBf1TfgAGyTgu4tPcP1DLPS/L
	 uJZo3vSQvhcQniWP29sCgli1lAVm1Kl2gJwVuA2f86NQg7oxCLsg3ur20YY1xGC6mP
	 FSzH+QJnjMPG/z0o0BHMgzMbQJ5lmu+XeBu5quv5W9Leonx3nzEnHNlXU6A9zFF2gA
	 0o4GCuVGnDzpQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 85B528125A;
	Wed, 18 Nov 2026 14:52:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A601B9F8
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 14:52:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 97BF540A0D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 14:52:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DxzjU_INhQgm for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Nov 2026 14:52:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6CBB440A0E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:102:465::112"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:102:465::112; helo=mout-b-112.mailbox.org;
 envelope-from=antonio@mandelbit.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mandelbit.com header.i=@mandelbit.com
 header.a=rsa-sha256 header.s=MBO0001 header.b=EmsZyBQW
Received: from mout-b-112.mailbox.org (mout-b-112.mailbox.org
 [IPv6:2001:67c:2050:102:465::112])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6CBB440A0E
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 14:52:35 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-112.mailbox.org (Postfix) with ESMTPS id 4jV4MM4M4hz5wkr;
 Wed, 18 Nov 2026 15:52:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1795013551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pnA9abm8tKCVM9tIK3l/Su5BC83HTMGiHZbk93iWfqI=;
 b=EmsZyBQWl3mIWf54qckm4AL2FWnWPQltJ16v4suq+m6zKB5dVSyasZC9x4pZnAgWiua/n/
 qSHiG+NYJsV/y35oPsTl5upz2YjsZPhO377xLqE9m1cO5GgYVEdYOZ7ANXinkgemGyW9Wq
 ZLGB6TZYzCqTP9OeSvFB35JHqy+/SJF2gkztz+2t20L1WfHHItZZ0TRRl3l/hzpzxE5AxC
 SOfLwz0PK8yHXKqXGn+vjooG57KIJGMloU95Oi5zCisHK6NKNl5+Eulk9U8qtzhg9VwC+9
 FFLJdMPaWsAxqs5lQGYP6OrXkoCQI3w3oGotOaYAcd5f3K6e4GljlrMT3n40RA==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of antonio@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=antonio@mandelbit.com
Message-ID: <3f6b535c-fce1-41d7-90a4-b15cfa20db52@mandelbit.com>
Date: Wed, 18 Nov 2026 15:52:28 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/3] igb: fix RTNL assertion when resuming from
 runtime suspend
To: Janis Edvarts Lacis <janislacis06@gmail.com>
Cc: intel-wired-lan@lists.osuosl.org, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261116153041.3002666-1-antonio@mandelbit.com>
 <20261116153041.3002666-2-antonio@mandelbit.com>
 <rab7ustlezklu43vnjkby5mqh33bgqoztlz6bv5wxkjqfvbtfd@imjngi6j72nz>
Content-Language: en-US
From: Antonio Quartulli <antonio@mandelbit.com>
Organization: Mandelbit SRL
In-Reply-To: <rab7ustlezklu43vnjkby5mqh33bgqoztlz6bv5wxkjqfvbtfd@imjngi6j72nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4jV4MM4M4hz5wkr
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Janis, thanks for the review!

On 18/11/2026 14:21, Janis Edvarts Lacis wrote:
> On 16 Nov 16:30, Antonio Quartulli wrote:
>> Since commit ac8c58f5b535 ("igb: fix deadlock caused by taking RTNL in
>> RPM resume path") __igb_resume() doesn't take RTNL for runtime resume,
>> but __igb_open() still calls netif_set_real_num_{tx,rx}_queues(), which
>> require it. An asynchronous runtime resume (e.g. after the link comes
>> back) then triggers "RTNL: assertion failed".
>>
>> Skip them when resuming. The counts are set again on every regular open,
>> which happens under RTNL; the only case left out is a fallback from
>> MSI-X to MSI during a resume, which leaves the stack with more queues
>> than the device uses until the next open.
> 
> RTNL is not held only on runtime resume, it is held on a normal resume.
> __igb_open() skips netif_set_real_num_{tx,rx}_queues() for both resume
> types. Maybe it makes sense to skip them only on runtime resume when the
> RTNL is not held?

You're right.
RTNL is held on normal (system sleep) resume, so the counts can and 
should be set there.

> 
> May I ask why is it okay to leave out the fallback case, can't it lead
> to trouble if the counts are not updated but a fallback happens?

Ouch..you're right again.
The fallback case can't be left out: with fewer rings than the stack's 
real queue count, igb_tx_queue_mapping() maps several TX queues onto 
tx_ring[0], each under its own xmit lock, and igb_xsk_pool_disable() can 
index a ring that doesn't exist (Sashiko reported the same on this 
version....).

To summarize: in v3 I'll set the counts directly on normal resume and on 
runtime resume from a work item that takes RTNL (as patch 2 already does 
for the NAPI links).
Until the work item has run, igb_xmit_frame() will drop packets for 
queues the device doesn't have instead of mapping them onto tx_ring[0] 
(the stack drops them anyway when the count is lowered), and the XSK 
disable path will skip rings that don't exist.

Best,

> 
> Best regards,
> Janis

-- 
Antonio Quartulli

CEO and Co-Founder
Mandelbit Srl
https://www.mandelbit.com

