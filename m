Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD15C4452B
	for <intel-wired-lan@archiver.kernel.org>; Wed, 22 Jul 2026 01:33:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2C53540729;
	Wed, 22 Jul 2026 01:33:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X2sWPk3w5Nhx; Wed, 22 Jul 2026 01:33:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 76A0C40719
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784683982;
	bh=GJ0tXnBlUAMTn2vLq/Edg9l+cM0LotSgg3TuWENMbdk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yQTRhBlG2UaI/zfQXswFU09DpMofZXXnMIr2Ms8yD5UqnXFD3jVRF36/mCyZfZ75C
	 zqCgHMO7cq6jFl2PO83czZaUbfUc31JmSMKO0NRsoBqtNustbgISn3NDCf3ObB/jSe
	 k9iRorH/GrkoX8jLkKYf1YpXvRbNpUnG7iA09MhGsbMouL7LYNKgb+3Ggq7w6ZTQEF
	 thAt6vqs1j2O5QNNJWK4rvVBRqfcKWm8lp4j5Ln2Ac4VysAAn7eaJYnIE0Y5WVa5wE
	 3sEgvXwl94xFMS3pQNQaPyy/aLUk7GOuUGXriTlgcOOsw6cklPGgHsCpo89Qm9cMxU
	 ZHWI0VEV90SzQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 76A0C40719;
	Wed, 22 Jul 2026 01:33:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 78A2310A3
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 Jul 2026 01:33:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 69BF880E85
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 Jul 2026 01:33:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K4dSgSN1FXOc for <intel-wired-lan@lists.osuosl.org>;
 Wed, 22 Jul 2026 01:32:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org B061880E84
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B061880E84
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B061880E84
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 Jul 2026 01:32:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BCCEE40AA1;
 Wed, 22 Jul 2026 01:32:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F301F000E9;
 Wed, 22 Jul 2026 01:32:57 +0000 (UTC)
Date: Tue, 21 Jul 2026 18:32:56 -0700
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
Message-ID: <20260721183256.6f49d6e1@kernel.org>
In-Reply-To: <al_4VWS_EyyZLe8z@devvm7509.cco0.facebook.com>
References: <20260715-bpf-xdp-meta-rxcksum-v5-0-623d5c0d0ab7@kernel.org>
 <20260715-bpf-xdp-meta-rxcksum-v5-8-623d5c0d0ab7@kernel.org>
 <aljNR2sf8qJVKFgb@devvm7509.cco0.facebook.com>
 <alkBnI3XcH0XGjEo@lore-desk>
 <al53WS9FMTnu7tBI@devvm7509.cco0.facebook.com>
 <20260721082728.74142e6c@kernel.org>
 <al_4VWS_EyyZLe8z@devvm7509.cco0.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1784683978;
 bh=GJ0tXnBlUAMTn2vLq/Edg9l+cM0LotSgg3TuWENMbdk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=AxXhpc0MAuyw11QvJ3ZWa+7FkgiGGgOwhWYp0NRErDBuIeb050T1pQu21yVnOOIN/
 iTO+l+Po6Ckw6SKbDkBL0Z2dFqJJtItMYTQhRNaweADU3UtXDtCwo8gHqbssv0/Pgf
 D0NS+PQO2v/p6oeBN/rQgz0OkEAxlHX/Ctaccap0Mts6dH2e4F80WW92/+hS7EUfTF
 7P4xoed3eUGomJSJcMH4o9zz3eiz0p7Hw57A12GI6iPVx4CfYl4fH5YhbVwNgx0iJF
 DXHH3+BodXak7EzcRKAlWLYF0WztavTDILn8g9LMQd5/9cpaxFFPdoD6UY9tMi1bOm
 VB8XBeLvS7Ezg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=AxXhpc0M
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

On Tue, 21 Jul 2026 16:03:37 -0700 Stanislav Fomichev wrote:
> > > For unnecessary, I think the safe expectation is that the bpf program
> > > will update the value of the checksum in the packet if it touches the data?  
> > 
> > Documenting as expected behavior which no driver currently follows 
> > is a bit silly. I thought the ask was to sketch out the plan of
> > explicitly updating/invalidating the checksum even if we don't
> > implement it today?  
> 
> This is about current drivers that only report UNNECESSARY with xdp: the xdp
> prog has to maintain in-packet checksum if it changes the payload. I think
> it's a fair assumption?

What about decap? If we decap the header that device validated 
as UNNECESSARY there's no possibility of maintaining the checksum
(by which IIUC you mean correcting it in along the payload changes).

I think we'd need some API to "decrement the csum level" ?
Or some heuristic in the drivers to decrement if the head moved
by at least len(IP+UDP) into the packet ?

> In terms of documentation, here is what I have on my side, lmk if that makes
> sense, roughly:
> 
> - TODAY
>   - some drivers (correctly) disable reporting COMPLETE when XDP is attached
>     - the xdp program has to modify the packet checksum value if it
>       changes the payload
>   - some drivers (incorrectly?) report COMPLETE for xdp-to-skb path -> unsafe,
>     needs to be fixed
>     - updating the payload doesn't update skb->csum, so the safest
>       option right now is to only do UNNECESSARY with xdp for all drivers

Yes, that sounds fair.

>   - the hw test needs to make sure that the csum is either
>     NONE or UNNECESSARY, and will error out on COMPLETE

Driver can report COMPLETE to XDP, just not to the stack.
I think we can use a tracepoint (bpftrace) or attach in TCP
to check the skb state?

> - TOMORROW
>   - if we want to properly support COMPLETE, we need a new set of kfuncs
>     to update skb->csum value in the skb
> 
> Does that make sense?
