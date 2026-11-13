Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C42606A33F
	for <intel-wired-lan@archiver.kernel.org>; Fri, 13 Nov 2026 20:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=wX8WO/Gg;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.a=rsa-sha256 header.s=dkim11 header.b=dHn8cJbq
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E8C2540E97;
	Fri, 13 Nov 2026 20:59:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4vAllpeAl7bf; Fri, 13 Nov 2026 20:59:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 985F840E30
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794603594;
	b=BgBBXfkfizR7/KLlCHvKcqVWDKJP5svVI2KgazbhjGBH0AP6S82wcPIKsyR0qYdr7F8Y
	 +LQD2BrmMsKcgcEbUHZ+N9gfzBUEa+Lna+uedkYSxbgYH9F0O3lVo1K6Uu3ziSczQkQI2
	 9pxmbvyhqSq6Q4NX+JGrFeogdtxTwd6gT7Div6ELZY3/fDY10J55mNAp92uLdcPY76EvO
	 Z63FNYCP4bAuw9kRnxvHfm7chCvV3uOG9gwTe/mZGxlV32RDorSAP7P9blji5rrOwfQcY
	 uiNKWrnt6AcyTBrNkQls7aFl5jULeGyz5Q5Vkw3a2E42OvGSLl3zPEn8upsbWMDzO8A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794603594;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-AV-Do-Run:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=EJBj5wqDDAB9+pHKPL6VCCp1UXeWowXlq/LPUcUSsu4=;
	b=FwRmPpi/MOnFWK2ueXDjxRJzh68RSmH5Mmmh2Nq8rZ3HFsPJJJdogocCnKPxcPr/puJp
	 2iWVHt4wrCsuhoU38YI6tekIG6q++7xMrFatkwP5OHLkWAFi7/7BxkQISJn257LdTRiTN
	 jQunVUyyg65cfze5U5dGCcR6F6Q/dNa3Oz9zHSMqtnHlhQYYE9E5q5AE8m0kV3xA3MqHJ
	 akVIKf/9PopLTPEkVHTVgIf9lGVWush/I1rK9rrKkH2TPdnQx1xNZeEN573fO+EARZL0+
	 FqwN9gpH/XN9T8h5jEvc6T39jL1CzBX/5fFH0Tm2xcJXfeug9YhBV8e0kOTxHJRnwKA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794603594;
	bh=EJBj5wqDDAB9+pHKPL6VCCp1UXeWowXlq/LPUcUSsu4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wX8WO/GgELv2pj2ClXOXDbsiewoXmmnadwhVkKW1uheyjCkez9gJh15VtxLg4Dccm
	 gpuCQ+9/9GPclc99m1U8XetzTbVX9nf/m94QjbBrGFa9+2He9bf3vwZrJ+BjwCCGFI
	 pRu8QMKK86mz3rtc1XM9GaScyRmpaShLedh/jXX0XTP3J3VhLsP6NYkBzigCbZl85s
	 2nqr5VYbQOQR62x9ku2o/kR1toa8Ao3cuSCQYmXg9Er4wcnyuF0qCYVThjSjK5GE0V
	 ZbDVWOAFSKErzyBFrzojRsGN03bTO0IqJ0UEmjZUOqS6XHZIA47lCd/HHtG1unVWrN
	 v+cTj0s9pv98Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 985F840E30;
	Fri, 13 Nov 2026 20:59:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D89E52FE
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 20:59:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CCBE081A47
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 20:59:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XX1B5-OvMJ-z for <intel-wired-lan@lists.osuosl.org>;
 Fri, 13 Nov 2026 20:59:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 76F1E81A46
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=81.19.149.119
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=81.19.149.119;
 helo=mx09lb.world4you.com; envelope-from=gerhard@engleder-embedded.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=engleder-embedded.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=engleder-embedded.com header.i=@engleder-embedded.com
 header.a=rsa-sha256 header.s=dkim11 header.b=dHn8cJbq
Received: from mx09lb.world4you.com (mx09lb.world4you.com [81.19.149.119])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 76F1E81A46
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 20:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EJBj5wqDDAB9+pHKPL6VCCp1UXeWowXlq/LPUcUSsu4=; b=dHn8cJbqKQ+Jj9d6vLb1sY/nWc
 B6e+o0CtxAqo/uiUQxLgcOvzG5rwHmG6mUVvysHwv/8Q4vyIoeHlj6zWXFc8wyQnOiyUlJhJ1aT+r
 GPFq/WKMzMFmbnaScuB7+7mfZJlPcKE59hOuMdOXFHcO2apJFdVvRKSwbj/yAd1dGhWY=;
Received: from [80.121.72.134] (helo=[10.0.0.160])
 by mx09lb.world4you.com with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.97.1)
 (envelope-from <gerhard@engleder-embedded.com>)
 id 1xRyMi-000000004vO-2IYe; Fri, 13 Nov 2026 21:59:20 +0100
Message-ID: <1ab53072-b9ee-464b-b5b3-cbb578059b49@engleder-embedded.com>
Date: Fri, 13 Nov 2026 21:59:17 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: mark skb NAPI IDs independently of busy polling
To: Paul Moses <p@1g4.org>, Ding Meng <meng.ding@siemens.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>, florian.bezdeka@siemens.com,
 jan.kiszka@siemens.com, wq.wang@siemens.com,
 Jason Xing <kerneljasonxing@gmail.com>, Simon Horman <horms@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20261105071706.7043-1-meng.ding@siemens.com>
 <20261110134539.12d860ef@kernel.org>
 <4pqljild2fp6eotiicvwbwu2wfw66fzd4qamwt6utirdjxlaok@iiu2f3k7azrp>
 <Fhn2gT70aJ-2_eak73NBZYuXuKtVb64PoD8VQ9jwm-S-K0RhZilAg9iwSBJ0RlaiSrRvM1vPw1aHvGPjcktu9GmdBuvFk9244-q2IVOrFu0=@1g4.org>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <Fhn2gT70aJ-2_eak73NBZYuXuKtVb64PoD8VQ9jwm-S-K0RhZilAg9iwSBJ0RlaiSrRvM1vPw1aHvGPjcktu9GmdBuvFk9244-q2IVOrFu0=@1g4.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes
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
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 13.11.26 09:29, Paul Moses wrote:
> 
>>
>> Then, drivers that use deferred timestamp conversion (e.g. igc, engleder) must
>> specify a busy poll dependency if they want to obtain the original net
>> device upon consuming the skb. However, this dependency is far from
>> obvious, and annotating it for future features of this kind will be very
>> hard to discover.
> 
> The "deferred timestamp conversion" was incomplete is what I'm saying.
> 
> This started with 97dc7cd92ac6, 0abb62b68252 and 069b142f5819 were built upon
> it, so maybe Gerhard should decide the path forward?

The deferred timestamp conversion is a niche feature for TSN to solve
the working clock / global time problem in TSN networks. IMO there is
no need to make it working as soon as igc or tsnep drivers are enabled.
It would be ok to fall back to normal vclock behavior like all other
drivers if CONFIG_NET_RX_BUSY_POLL=n. For me it is ok that NETCONSOLE
is not possible for PREEMPT_RT in combination with this feature.

There are already so many things to consider to get TSN working. To
not enable NETCONSOLE on PREEMPT_RT for deferred timestamp conversion
would be just one of many.

@Ding Meng: Do you actually need the NETCONSOLE in this combination?
On productive systems likely not these days due to CRA.

Gerhard
