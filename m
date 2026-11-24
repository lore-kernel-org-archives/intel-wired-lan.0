Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE69606A31E
	for <intel-wired-lan@archiver.kernel.org>; Tue, 24 Nov 2026 23:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=OkZSMXI/;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=jhRuRnXH
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F0A8A607DE;
	Tue, 24 Nov 2026 23:57:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L-6qW091LxdD; Tue, 24 Nov 2026 23:57:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4336960744
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795564634;
	b=WeeBjaHpLqzqvDiEuscKZhUKj7LcmnfPKJ5NMpgArQS9O7i/Hvom0VZ8me058Qx1LpQi
	 WFtOW+IkGsmj2maksNH7cgRhOVUdygosxUQykqxcQD5FowN1spoealMQsIH2blV5ZkClj
	 /TzwW5kPy4h8iiP1U5jeery/zv8WIUT1k3MFSxzd/K/Kc7/3hk4UwJyNY7cF7cnUQ4rcL
	 lI6RZtTzH/zJppFclxXqT/zzg8AmMXmGHqTfhNnWeZxyDyu+lqhHNa3uiH6aweAoIiPvS
	 DvPXTZY0c2S4Aj2VXLTkTvzFKY6mG1a60vcvXomouBdDutbZGhmotpoJmeU/hTx1bPg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795564634;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:Organization:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Rspamd-Queue-Id:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=FPGxYREIu5QBknQBTYCZT8SkLTQYnWSM7RCkrhgdZV0=;
	b=e6doHhKe+jjxyAewDKsc9MvgaG2EC3UglRoEDSGnPwrpoCzbv5bE5JsDTbNGk9SlrZbr
	 EkhVLRMUCZbfmTcc5Rm1fSMZGa3TInzkgMf1WKR35SXTPcxDL4nl7d1piVCqZXTEICG/R
	 XIYaNIQeZY8phmKYBvOtzamYvnT1EmGebJqVElXQxkWFEW8emqwbgYefY+VuRs0oF3cmK
	 Tv7s2pP9Ja0ro76QzRIY1efIwVGRrGPpk7TItCxueRoK27gHRgPTPVlPjD4/8l0oHhtNc
	 5SddqNVWKRyH04X2cHtSifh523IHAbvUk3x9eLFGq3Q2l1H+TQ7Ui/+rkc7T4l5dL6A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795564634;
	bh=FPGxYREIu5QBknQBTYCZT8SkLTQYnWSM7RCkrhgdZV0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OkZSMXI/K2e1v7FlXawOoGcqDF2PKu9qYyxfs7NqAbzyXoBRKuH56TS18fwbEc9YW
	 SuwCRMzZmQGiCtBYZQn0oH8Cti8noXshWgRSF5sC73pYqpCjV9Ka1UdcORTDB0V9Lu
	 poVd+uswNZQQUsInfws6oTG03qn4x4MmlpHWnCWC6gtXG8zPU9SRCnDnEfctxCC/Sg
	 zIZOIEw78AxizuywbTErOUW8u6LMOoVDPwZ26f8ybh7q5A/2TVzMrpHUven9mY8xUm
	 zNEeVig8kOg/W0+YmHsu+FGvKtFObvZGIMqOgrS1MzFHuOZnO9g6EMkTgXhzUWIqsY
	 HOdvKyn5Qfuzg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4336960744;
	Tue, 24 Nov 2026 23:57:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 660AC26D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 23:57:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 57DF280D07
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 23:57:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CLmma0vqGGtp for <intel-wired-lan@lists.osuosl.org>;
 Tue, 24 Nov 2026 23:57:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4BCC880CDF
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=195.10.208.40
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.10.208.40;
 helo=mout-b-210.mailbox.org; envelope-from=antonio@mandelbit.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mandelbit.com header.i=@mandelbit.com
 header.a=rsa-sha256 header.s=MBO0001 header.b=jhRuRnXH
Received: from mout-b-210.mailbox.org (mout-b-210.mailbox.org [195.10.208.40])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4BCC880CDF
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 23:57:10 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-210.mailbox.org (Postfix) with ESMTPS id 4jZ08y6scNzFqWZ;
 Wed, 25 Nov 2026 00:57:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1795564627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FPGxYREIu5QBknQBTYCZT8SkLTQYnWSM7RCkrhgdZV0=;
 b=jhRuRnXHKgLAEHTss96zJFJab56EGK+9ghs1SA42cJZGYE3lMIK5zLnUa/ks+oqNK8FMql
 Gbr/EfhYvhFoHkRJgd0TXI/wl+miqCsyiZ4P9zaK8gUAOmAc3virTnIPYz2dOJ7XQg//L9
 LwBsX3i0Ed193TMfltUkt3vx/s6RBqeVLLWdOlqTn1JxMksHqNSGt78r3iISB4DKV5s/iG
 DkzcJ/2dgd+rGILGuvDkG/7fuCTPKLQet/xnMlCs/sZZOkM6YXu39B8k1Y4HBdDHt1EMVr
 3EoS4K9ra9Mgy6URGZFyfacAbUWla+dSqvKGYCMj5vxhupNiMTsz1OaVsOpWyw==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of antonio@mandelbit.com designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=antonio@mandelbit.com
Message-ID: <865b2952-d3db-4b51-93ce-28b3254d33c0@mandelbit.com>
Date: Wed, 25 Nov 2026 00:57:05 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 4/4] igb: only allow runtime PM if the device can
 wake up
To: netdev-bot+sashiko@kernel.org
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 janislacis06@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261120210134.133238-5-antonio@mandelbit.com>
 <179555632736.3135.1658046091917963917@kernel.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@mandelbit.com>
Organization: Mandelbit SRL
In-Reply-To: <179555632736.3135.1658046091917963917@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jZ08y6scNzFqWZ
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 24/11/2026 22:38, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] The runtime PM usage count can end up unbalanced, because the
>    same decision is made twice.

Right: pci_dev_run_wake() can change while the driver is bound. v5
checks it where the runtime suspend is scheduled (the watchdog and
igb_runtime_idle()) instead of at probe and remove, which stay
unconditional, so the usage count stays balanced.

Regards,


-- 
Antonio Quartulli

CEO and Co-Founder
Mandelbit Srl
https://www.mandelbit.com

