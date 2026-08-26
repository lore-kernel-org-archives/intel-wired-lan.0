Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F099CC61DBD
	for <intel-wired-lan@archiver.kernel.org>; Wed, 26 Aug 2026 12:42:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BD36140562;
	Wed, 26 Aug 2026 12:42:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ALBzpF1ZuhTG; Wed, 26 Aug 2026 12:42:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787748168;
	bh=Bp6YGE+7SBR9E9ISCb4FnjJrUlmaJNlhCUdcBy6XW0M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BM8eltdMrIcJTZJ9Z+ZRfpq2gxHqEOsoEvIUMjICtpda+M5OIM9ipstxLHr4Dc1ai
	 9pDmheBmObs14zTSNAXZUVy43vH3SfcmaAB8NPiBQvw0yY8zPLpBJFqvWMCKlVcHE/
	 jjsHKxhqdYbnrBwo9LMGsHhrZVoFa+XXE2ECB+1VCHrWGg1LmQ9gy4H+xrwFUjuPE3
	 NRpoaRIlF/W5mAuGei9l1+vBXzFKXUxy8Jr0AY+/f23IMg9lVKdwtkLH1hMM6KygAN
	 99xWn0HjkPhbiPvf4rMfb7lIWnphsak8Ymglhb6X7QQ/JP7C628ygd5dhooQqElBDa
	 WGxM5wxFxkIEg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8ED914055E;
	Wed, 26 Aug 2026 12:42:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B0D903AD
 for <intel-wired-lan@lists.osuosl.org>; Wed, 26 Aug 2026 12:42:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 976D7400AF
 for <intel-wired-lan@lists.osuosl.org>; Wed, 26 Aug 2026 12:42:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CfzvCaCOIHE4 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 26 Aug 2026 12:42:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.84.56;
 helo=smtpout-02.galae.net; envelope-from=maxime.chevallier@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=LemI+t6G
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CFABA4005F
 for <intel-wired-lan@lists.osuosl.org>; Wed, 26 Aug 2026 12:42:45 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 285CB1A1844;
 Wed, 26 Aug 2026 12:42:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id D5886604EC;
 Wed, 26 Aug 2026 12:42:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8DC8D11C78133; 
 Wed, 26 Aug 2026 14:42:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1787748157; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=Bp6YGE+7SBR9E9ISCb4FnjJrUlmaJNlhCUdcBy6XW0M=;
 b=LemI+t6Gl02EuLwgM4WqthJR9G5PUktBl8kNfwXcMV/8nWLGaa2BsOt44Vkqbz6oplPPdt
 DdiFqkVnwrNOHgjAaAr+CQDy6hQkmyDyH6LTPU5Svvm0eAsmnUWvJ27Xoj8ZVtMsOKkcL9
 zwxXv6cLhzf/Sz1O8GC0laJQ2eQbQu4BMBYgQF6Ukfz2vQWZOWB++dpksI7MVgMoTnLmuJ
 H88vYk7W5+a6djiGjPyrDCVHfikhMaaTq3TnFkitjzKdmvtfnNu5wc6mtLZb7jn1Zo2BlH
 QDI6oFmvvQq6J6gn4zSGjlPCfxFPYeHU6IUHO5nEld/ScdEG1t1LeIcnXVgXyg==
Message-ID: <dc2ccb14-c7c0-402b-93b3-afba52df78fa@bootlin.com>
Date: Wed, 26 Aug 2026 14:42:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 3/3] net: stmmac: document oversized AF_XDP frame
 handling
To: Jakub Kicinski <kuba@kernel.org>, Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 aleksander.lobakin@intel.com, horms@kernel.org, magnus.karlsson@intel.com,
 sdf@fomichev.me, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, guoren@kernel.org, dtatulea@nvidia.com,
 witu@nvidia.com, martin.lau@kernel.org, yoong.siang.song@intel.com,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
 linux-csky@vger.kernel.org, leon@kernel.org
References: <20260819160535.1472459-1-sdf@fomichev.me>
 <20260819160535.1472459-4-sdf@fomichev.me> <aoceSoSFMx69Z9up@boxer>
 <aoeoJ6-njBxcWs4w@devvm7509.cco0.facebook.com> <aogpDsa8hz6CPpD3@boxer>
 <aoiIarzdjk92RkCN@devvm7509.cco0.facebook.com>
 <20260824111443.34bffe04@kernel.org>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260824111443.34bffe04@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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



On 8/24/26 20:14, Jakub Kicinski wrote:
> On Fri, 21 Aug 2026 10:28:47 -0700 Stanislav Fomichev wrote:
>>>> I do agree that a better idea is to probably do these checks during control
>>>> paths, but it's a bit more involved (and not sure if it's possible? if we
>>>> have a bunch of xsk sockets and we change that max_sdu, do we go over all
>>>> sockets on the system somehow?). My main motivation with this patch was
>>>> to make our LLM reviewers less chatty about preexisting issues.  
>>>
>>> I hear you, however I feel like we do not know this driver too much and
>>> probably we don't have a HW to test out such changes, so maybe let us try
>>> to fix existing behavior?  
>>
>> Let's definitely fix it properly if you have better ideas. But since we
>> don't have HW, I'm not super confident doing anything sophisticated
>> myself :-D
> 
> Let me take the first 2 patches and leave the stmmac for later.
> I don't think anyone involved care particularly deeply here.
> 
> Maxime said he bought a bunch of relevant HW. If we finally wrap 
> the AF_XDP tests into driver runtime he should be able to help us...

Indeed, I haven't started looking into the AF_XDP (and XDP in general) on
stmmac, lots of fixes lately on the subject so I'll get there eventually :)

I'm currently plumbing the driver selftest on my setup (ethtool -t) and just
runnign this uncovers lots of issues al lover the place, once this
passes I'll get on the kselftests and see what we can do on this.

Maxime
