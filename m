Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A2E0C4452D
	for <intel-wired-lan@archiver.kernel.org>; Tue, 21 Jul 2026 23:04:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B9AF480B6E;
	Tue, 21 Jul 2026 23:04:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qZ1lOLwNdeL1; Tue, 21 Jul 2026 23:04:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1D08580B89
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784675066;
	bh=78htSqZa+5pBteZG4UB1DmemzqB0eVW2EvSwVDuZiqs=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P0a0GY5t1sGwEJUpnZqBx6XRgkkywKdow0IJgkr8dOluJDeyItMoPASDBv3Ma3+qu
	 GeGUqlVOicfVj/Heja3or3oyibI/wRxeug98S2m6YsNAxJjq+5PPIsYLLHBBwcn2Fr
	 /5in9nsq+TRNjQsl9sv+95ZIJZOx1TwT36H339hRVWTBN/TEuPL8n75aze2wztXxFF
	 oykP49N3rtROYCc413IhWd/fcM/7hB5c1gt+wAPG2Byp50HpVHt2QuDVO/l5azOwwi
	 rqjBipLGp+oSyCyIqs7qYLuv7r1nbyiZ+d65jSvPTzImS7CrMpwN0AqXqXmDjPv8EJ
	 frUM/J/ZRFsTQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1D08580B89;
	Tue, 21 Jul 2026 23:04:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DDF97313
 for <intel-wired-lan@lists.osuosl.org>; Tue, 21 Jul 2026 23:04:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C7B9A40A3A
 for <intel-wired-lan@lists.osuosl.org>; Tue, 21 Jul 2026 23:04:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nNnDbDKUJCFI for <intel-wired-lan@lists.osuosl.org>;
 Tue, 21 Jul 2026 23:04:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:39::7;
 helo=mail-pj2-x07.google.com; envelope-from=sdf.kernel@gmail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 1D01C40A40
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1D01C40A40
Received: from mail-pj2-x07.google.com (mail-pj2-x07.google.com
 [IPv6:2607:f8b0:4864:39::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1D01C40A40
 for <intel-wired-lan@lists.osuosl.org>; Tue, 21 Jul 2026 23:04:23 +0000 (UTC)
Received: by mail-pj2-x07.google.com with SMTP id
 98e67ed59e1d1-38dcd98e5easo5996429a91.0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 21 Jul 2026 16:04:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784675063; x=1785279863;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=78htSqZa+5pBteZG4UB1DmemzqB0eVW2EvSwVDuZiqs=;
 b=m/Gi/AM7hdZ/u2WF3/sOXXixXJq5RTnOQ7X8cR4I7eENNV94S/jtT4f2mjykEPXHv2
 DB5oNXAGIT6cmZ8elHmT3oL/CU6Yn4aaC6LySUXsVJox49Z48bW8VwBzSq5YmAkGDobi
 FMfY3fSxwo624j3ol6H8Vp3dO5NF0rLjB/6nGDs0WZH86n6PCBu4ll4yKGnjVQ7auOTF
 g8cR0coVUbrjHLdQ0nIK1VPHOEh5dUS8oCLHohQ2Uj+UvwGK2nMeGZ9IcB+VCcqPIKop
 KsWWexWY44bZCzjaDTSUX1GFe26e9DbF8GNn68ig0O9CW9tdNJxwNzLVHIJkjijxJCnc
 w35Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RrC5Grt/QY2ME9KZPlOXyjVRoCuCxCpJWxkZutTaVAqQjDc+B7vZRi4tzvqsm/BOPAKNFu/MKoPkifQcRtiMx8=@lists.osuosl.org
X-Gm-Message-State: AOJu0YwNsZKDX52AOgUNrF0mDzU9U9ilIFpPuXp976Br5KdceLgprz/4
 266glbc6Mg5UFQd/L27uncdWLsK7MitF5ODiUy+52ADppVvVc1VKT0ud
X-Gm-Gg: AR+sD112xA+OauQ2V0mVtA3sAFeSktIiM6ApBAVpij3UhrPicTewxuyn7i75JEejXHM
 EIVmCwq84UCDEjfgWHkjfEsslkOSu1j6cWxh/TxYgazPHyAIMDZamvEs0BGupFQM7iPfFrzYBNr
 2wSPYL86M5dbIedfn7ut1AhvMo+ukOy+3zOWv8NY0lJBko+ZNILXFKdhO7QJSJPUpg/YThGW8t0
 RmyfR2RrKOnlN/ydVaArGRBgXcqsYGVcfpMRJ2u2fpQunjAWm/tZUvN3dv+cYx3ULXfgQeeguBF
 Pbr/TM2OTSrLwuGibYxvBnYO60w4rZG4RXk+B7m+1estUDwMaovrYjo5jKo0JcJSUYBxNrwflw2
 rZXMsGZbU0mdtgh2kvqCiRl+f7KqbDY+AgyXC2xXUQXjwPiVk9nYlKcwrnniScplB3HARsQ==
X-Received: by 2002:a17:90b:38ca:b0:387:e0db:3d8f with SMTP id
 98e67ed59e1d1-38e4b5b4fadmr19229906a91.42.1784675063089; 
 Tue, 21 Jul 2026 16:04:23 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4::])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38ea81b2c92sm24438a91.14.2026.07.21.16.04.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 16:04:22 -0700 (PDT)
Date: Tue, 21 Jul 2026 16:03:37 -0700
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
Message-ID: <al_4VWS_EyyZLe8z@devvm7509.cco0.facebook.com>
References: <20260715-bpf-xdp-meta-rxcksum-v5-0-623d5c0d0ab7@kernel.org>
 <20260715-bpf-xdp-meta-rxcksum-v5-8-623d5c0d0ab7@kernel.org>
 <aljNR2sf8qJVKFgb@devvm7509.cco0.facebook.com>
 <alkBnI3XcH0XGjEo@lore-desk>
 <al53WS9FMTnu7tBI@devvm7509.cco0.facebook.com>
 <20260721082728.74142e6c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260721082728.74142e6c@kernel.org>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784675063; x=1785279863; darn=lists.osuosl.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=78htSqZa+5pBteZG4UB1DmemzqB0eVW2EvSwVDuZiqs=;
 b=QhgxUxfcDla09eYz8t4hHS5hXq2z337zPER1ZbXPysYdMusgbSTEHFw9odbAuEc189
 WxcxgSYxzqPgNm3BGcFap/3nLPAztc3/W5P9F0djaDhAE3i4rJWi8g6UwHYeS+2WLz5Z
 6chBflIC328f87FFjysD4qpM4bpBxi9qRNXhL03Ds6L1P7b+7Z0pCPkXJ/P63wkTBMJ/
 bnsWfj7dhyzsmcbQUvDaqWrx9z6ruJJj7Jbn9LofT5iCXESHH6xzzbqt3+TNAGE8QlCh
 csBr2YY6McIKcYzO7mrqCJwUZAWK6IUxWpkPy4rR/wxZ3x3OfVv4b3z4iG7G6/64sCT8
 rmhw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=QhgxUxfc
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

On 07/21, Jakub Kicinski wrote:
> On Mon, 20 Jul 2026 12:32:55 -0700 Stanislav Fomichev wrote:
> > > > (although for gve I might be wrong, there is also gve_rx_skb_csum that only
> > > > does UNNECESSARY).
> > > > 
> > > > I'd wait for Jakub to chime in, but it feels like we should just document
> > > > what we currently do as a recommended approach: for the drivers
> > > > that support COMPLETE, do not report it when the bpf program is attached.
> > > > Both NONE and UNNECESSARY are ok.  
> > > 
> > > I am not completely sure the UNNECESSARY case is different from the COMPLETE
> > > one. What are we supposed to do if the driver reports UNNECESSARY and the ebpf
> > > program modifies some fields covered by the rx-checksum?  
> > 
> > For unnecessary, I think the safe expectation is that the bpf program
> > will update the value of the checksum in the packet if it touches the data?
> 
> Documenting as expected behavior which no driver currently follows 
> is a bit silly. I thought the ask was to sketch out the plan of
> explicitly updating/invalidating the checksum even if we don't
> implement it today?

This is about current drivers that only report UNNECESSARY with xdp: the xdp
prog has to maintain in-packet checksum if it changes the payload. I think
it's a fair assumption?

In terms of documentation, here is what I have on my side, lmk if that makes
sense, roughly:

- TODAY
  - some drivers (correctly) disable reporting COMPLETE when XDP is attached
    - the xdp program has to modify the packet checksum value if it
      changes the payload
  - some drivers (incorrectly?) report COMPLETE for xdp-to-skb path -> unsafe,
    needs to be fixed
    - updating the payload doesn't update skb->csum, so the safest
      option right now is to only do UNNECESSARY with xdp for all drivers
  - the hw test needs to make sure that the csum is either
    NONE or UNNECESSARY, and will error out on COMPLETE

- TOMORROW
  - if we want to properly support COMPLETE, we need a new set of kfuncs
    to update skb->csum value in the skb

Does that make sense?
