Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A527C4453A
	for <intel-wired-lan@archiver.kernel.org>; Wed, 22 Jul 2026 18:35:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CECDA40755;
	Wed, 22 Jul 2026 18:35:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TySL1fDbtxTy; Wed, 22 Jul 2026 18:35:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 012B44090B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784745332;
	bh=670ICVCxpkbIIsTKMOsa+I+z+C4FgJRDQNs6RF7SdGI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W58U6x7j9c27mxkhZZsknjAqaEvYX0cvF+Gh1oqFOCUt39xZqJYOjCq8BpFzb6c1F
	 jCBP2IS58/OozLgTjDAbWAtfWdvvQbBRaR8ZgLiBCMv8L4wrG99/l57wjl3PkbtCZo
	 GUy4C5RRtjER/T5kHA5g/2L60ornB0FNrEtXiuvYWg+5BXzNWm7ThZT8mSpYkhe8d9
	 Kt5veU0IJjsvfd955+cZMH7iehDuABFBqEK/275lLRgUUwzYflPUTGIIVHZxMeU5c0
	 yq+nTmGdkpEaSbbNsIGxXoINOd5QOLVInD4Wf+tdmQQooWE/0q2o6eVVD8Z2cLT4cd
	 whoEdXuZQ8SsQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 012B44090B;
	Wed, 22 Jul 2026 18:35:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7DD35224
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 Jul 2026 18:35:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6352D40115
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 Jul 2026 18:35:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KnCInpVMko-z for <intel-wired-lan@lists.osuosl.org>;
 Wed, 22 Jul 2026 18:35:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 9F99B40057
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9F99B40057
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9F99B40057
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 Jul 2026 18:35:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id ABA7B43A5A;
 Wed, 22 Jul 2026 18:35:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C4751F00A3A;
 Wed, 22 Jul 2026 18:35:26 +0000 (UTC)
Date: Wed, 22 Jul 2026 11:35:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Donald Hunter
 <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Andrew Lunn <andrew+netdev@lunn.ch>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP
 Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, Vladimir Vdovin
 <deliran@verdict.gg>, Jakub Sitnicki <jakub@cloudflare.com>,
 netdev@vger.kernel.org, bpf@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-kselftest@vger.kernel.org,
 linux-doc@vger.kernel.org
Message-ID: <20260722113525.34092660@kernel.org>
In-Reply-To: <amEEEohxmC8hkBvY@devvm7509.cco0.facebook.com>
References: <20260715-bpf-xdp-meta-rxcksum-v5-0-623d5c0d0ab7@kernel.org>
 <20260715-bpf-xdp-meta-rxcksum-v5-8-623d5c0d0ab7@kernel.org>
 <aljNR2sf8qJVKFgb@devvm7509.cco0.facebook.com>
 <alkBnI3XcH0XGjEo@lore-desk>
 <al53WS9FMTnu7tBI@devvm7509.cco0.facebook.com>
 <20260721082728.74142e6c@kernel.org>
 <al_4VWS_EyyZLe8z@devvm7509.cco0.facebook.com>
 <20260721183256.6f49d6e1@kernel.org>
 <amEEEohxmC8hkBvY@devvm7509.cco0.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1784745328;
 bh=670ICVCxpkbIIsTKMOsa+I+z+C4FgJRDQNs6RF7SdGI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=a6LTxb6Me6mG2aUNvx62hRLaJopZgj2ogTsG8vH+9nTrF7phHbWJSmGpvev0Mxvvt
 3c8U84ok5cF/v+rxZT6PsnyNEZnEti27oSLMZ9CjBWQ14jQOM+KjpEdYKOjUnyscea
 bD75r9/q7UDGNM7PAAcphCZ39vlipGyeAoYzQ+fLUEH8VNtac1NbFbz50FqsCzoChy
 yx4Eo3Q4/fyiLdyQPCRVfHlVSFX0DNSbXI2sqB0ToGN4AG0xOBFEB1dtrm4HHoicKc
 Z1YlaRTqCujzVsoH4VJYq92fziN8WHTbT/wc//wfZW0o1XGNXS+uwZmLenI7DcjKu+
 iVpXtEUew6/mw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=a6LTxb6M
Subject: Re: [Intel-wired-lan] [PATCH bpf-next v5 8/8] selftests: net: add
 test for XDP_PASS skb checksum invalidation
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

On Wed, 22 Jul 2026 11:00:07 -0700 Stanislav Fomichev wrote:
> > > This is about current drivers that only report UNNECESSARY with xdp: the xdp
> > > prog has to maintain in-packet checksum if it changes the payload. I think
> > > it's a fair assumption?  
> > 
> > What about decap? If we decap the header that device validated 
> > as UNNECESSARY there's no possibility of maintaining the checksum
> > (by which IIUC you mean correcting it in along the payload changes).
> > 
> > I think we'd need some API to "decrement the csum level" ?
> > Or some heuristic in the drivers to decrement if the head moved
> > by at least len(IP+UDP) into the packet ?  
> 
> True :-/ I guess one more case to document?

What would we be documenting? That it's a known bug and we have no idea
how to address it? Or am I missing something?

Again: 
 .. the ask was to sketch out the plan of explicitly
 updating/invalidating the checksum even if we don't 
 implement it today
