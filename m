Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40138C44536
	for <intel-wired-lan@archiver.kernel.org>; Wed, 22 Jul 2026 20:41:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D49C06087E;
	Wed, 22 Jul 2026 20:41:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yDQvxmV0SfSf; Wed, 22 Jul 2026 20:41:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 395EC605E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784752888;
	bh=lwCODOyVSYFhI5c3HdXAxVNdit7/+b6pODVCWxPDLeg=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=N7BkyLkIuJ5QStc0ICez+bW5CvQM74tVGvlFASWrp4c/MCptgMBWKtIA3ALlWPWyE
	 6vjvH9wO23uSsdwwV12z/uBZmr3uCdtx9JV9UdkB4QtSxw1K3AacY8r+7due+ep3bJ
	 L11G5ewf/bj5NPD2JK0PlVOeYGPANby2LMkGE6SVcjxxnjDix2RD/K7V8m5MLlfMXi
	 gKZAc5v1WQdGkFyM8h02H6rkGEdxuHxTMTAc7CPyl6NKlXSs3MgcoryH9jVmPKXN3U
	 5jm/XzDQLy0Chw8guBiJ6wc0vIsD/BVKvdeRxkGWmbmT+MhW5+IF2ffoVxDq/BPaRf
	 tMC18pE/BCS3w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 395EC605E6;
	Wed, 22 Jul 2026 20:41:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 27B1C347
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 Jul 2026 20:41:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 196CD605E6
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 Jul 2026 20:41:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0yxLPpD9QV05 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 22 Jul 2026 20:41:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:39::1;
 helo=mail-pj2-x01.google.com; envelope-from=sdf.kernel@gmail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 74EB0605E0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 74EB0605E0
Received: from mail-pj2-x01.google.com (mail-pj2-x01.google.com
 [IPv6:2607:f8b0:4864:39::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 74EB0605E0
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 Jul 2026 20:41:26 +0000 (UTC)
Received: by mail-pj2-x01.google.com with SMTP id
 98e67ed59e1d1-37fb1883fbfso3460092a91.0
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 Jul 2026 13:41:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784752886; x=1785357686;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lwCODOyVSYFhI5c3HdXAxVNdit7/+b6pODVCWxPDLeg=;
 b=melVwwznBk+7agT+ZO6rP9efxg6awh7OyHbUOQ3rrpsmy8SefB2Y/hJ1b9P0PjTJOp
 MHExoXI1CPQIO+Tf8vCfCpj67xKos2V8AycotHpT++9RRh7dQnWCG1rrDcNJeSGy3F6M
 r5mndzD7ZjTiq0O2Up9M/fymV5q618x47epCyscXsj7WIBVeumw7wFFtHWI0qk9ZfEP2
 bMbOxC7WfhyOT5rCA/8Rl/+VZWXC8WmjTqz5v/GyGjzZYa5/OsHkd1P7f85kzHcy3CvG
 99OP9Q4zqXJ3DB5XY32U6yEmpQkCBSPH3aSZ9GqCTeOfv2QR+4dwygW1bCDt+I0NzT2I
 rDtw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqq9a4LL1hUL+5qbwPDAnkREwoR+GIFTgOXyIKU15b5RJ3en1Iac+WVxSnjWjvE9nMhFjaXKi19eGADnUaS9Zc=@lists.osuosl.org
X-Gm-Message-State: AOJu0Yw2PUCWRDsdT3vtNTYVMihQQ1cbgFlJOtCQlDTCu7PyF5BaVhyP
 MEi5bIHFL95Qw1NP7FZOaKj6uiwlXRN4/mHYWVwdocspYKjLIKqInaj9
X-Gm-Gg: AR+sD12houtafX54/ggBze1C5bLytkyEPgAVCJe+KY6yoAiEQkZALQsfjhKhatz6x5Y
 Ac72J8xaM1edSsVJU7XaKNlCdpBUXoilvhZIWH2GzMdiJtQYL8GFcZwGTYPTtb3tjBHwWLGp1by
 DLenMtd4udcui0euBfshmFOVQyoY4FbpNvag1a1AlzzlFZb/5hZBAygSCYWlrbdO61vdLSwQJgS
 HxlzUlycCbpDd5Y55LzXEznf6WMTdj/ErbK16zGO36QqVv55CAbjRLsFUBrEMJQhW8ktszm+4hm
 GH2ougtzVnPLfwI1umy6uANhvlAfUkX/sSo9nWflwgb+tSgvWjIZoqnSSDq6+n2s9tIJ2VVDJAD
 3aom9Wv8+IaOY2eNEnOoeDLcLzl6Qa3UD4q/9lrQ6HKjmPEl/vT6MGCNb5wMhaKRt7vBK1ZL9rW
 O6Rygqnw==
X-Received: by 2002:a17:90a:e703:b0:38d:ddc2:7ccb with SMTP id
 98e67ed59e1d1-38ec6406625mr281164a91.1.1784752885668; 
 Wed, 22 Jul 2026 13:41:25 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4e::])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38ea466e62fsm1240712a91.1.2026.07.22.13.41.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 13:41:24 -0700 (PDT)
Date: Wed, 22 Jul 2026 13:40:58 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, 
 Donald Hunter <donald.hunter@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Vladimir Vdovin <deliran@verdict.gg>, 
 Jakub Sitnicki <jakub@cloudflare.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, 
 intel-wired-lan@lists.osuosl.org, linux-kselftest@vger.kernel.org,
 linux-doc@vger.kernel.org
Message-ID: <amEojEGsIGkUjIWn@devvm7509.cco0.facebook.com>
References: <20260715-bpf-xdp-meta-rxcksum-v5-0-623d5c0d0ab7@kernel.org>
 <20260715-bpf-xdp-meta-rxcksum-v5-8-623d5c0d0ab7@kernel.org>
 <aljNR2sf8qJVKFgb@devvm7509.cco0.facebook.com>
 <alkBnI3XcH0XGjEo@lore-desk>
 <al53WS9FMTnu7tBI@devvm7509.cco0.facebook.com>
 <20260721082728.74142e6c@kernel.org>
 <al_4VWS_EyyZLe8z@devvm7509.cco0.facebook.com>
 <20260721183256.6f49d6e1@kernel.org>
 <amEEEohxmC8hkBvY@devvm7509.cco0.facebook.com>
 <20260722113525.34092660@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260722113525.34092660@kernel.org>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784752886; x=1785357686; darn=lists.osuosl.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lwCODOyVSYFhI5c3HdXAxVNdit7/+b6pODVCWxPDLeg=;
 b=ZgL3L/xlqJlkRofBVnNeyK+dlk0ESlaq1c9zlZnBmZCjcVfRVcCXMu46GtS12aB7q0
 xO48Fedz1R0eg9nfZ+5s1CubleFTW7Nla5WbJHoNAiSNy04PJRxMk1ZDJLvA9Vo7ufgG
 t62Nv/hOvkcbip7y2k1AGS1yOmeC2+Z9rf4Xkgbl3iv7hDJCFRtnfxRkKszG6bKtVZFT
 91KCtsPoSBDgSdLPzhDRwzoSqwGYMwPdi3TJNfVe1rnHoVKKosY5sfkZJV2pbfrlCTaE
 aSwWCIiTL4bxn/yxpyD7Em2Gc5KJnsVDRmqXNxGcBoSETzw5lr38HqwEk+Zebxe2z9eF
 TllQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=ZgL3L/xl
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

On 07/22, Jakub Kicinski wrote:
> On Wed, 22 Jul 2026 11:00:07 -0700 Stanislav Fomichev wrote:
> > > > This is about current drivers that only report UNNECESSARY with xdp: the xdp
> > > > prog has to maintain in-packet checksum if it changes the payload. I think
> > > > it's a fair assumption?  
> > > 
> > > What about decap? If we decap the header that device validated 
> > > as UNNECESSARY there's no possibility of maintaining the checksum
> > > (by which IIUC you mean correcting it in along the payload changes).
> > > 
> > > I think we'd need some API to "decrement the csum level" ?
> > > Or some heuristic in the drivers to decrement if the head moved
> > > by at least len(IP+UDP) into the packet ?  
> > 
> > True :-/ I guess one more case to document?
> 
> What would we be documenting? That it's a known bug and we have no idea
> how to address it? Or am I missing something?

Yeah, that UNECESSARY + decap in xdp has this corner case of inner
csum being not validated (and currently no way to flip it to NONE from
bpf).

(idk whether we really have nics that do csum_level>=2, so I'd just add
bpf_invalidate_csum or something, but it's a separate conversation)

> Again: 
>  .. the ask was to sketch out the plan of explicitly
>  updating/invalidating the checksum even if we don't 
>  implement it today

SGTM, I'll leave it up to Lorenzo. I had this TODAY vs TOMORROW summary,
we can expand on that with UNNECESSARY+csum_level plus maybe more
details on the shape of kfuncs for TOMORROW section..
