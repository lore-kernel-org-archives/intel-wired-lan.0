Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D788606A320
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Nov 2026 16:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=mdSay/34;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=Z/ZUdx9x
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 509E440561;
	Tue, 10 Nov 2026 16:51:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QNiX_HMFiFCk; Tue, 10 Nov 2026 16:51:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 99891405D6
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794329483;
	b=PZeCWGVhpIqQsJjNFKJKzacpzk2tcxMt6nvxDhTHbu6syKzOais0Ru/WoY+gnd0Va8T6
	 TkpO4LoT6CmHEV5aQHKAZXhIbAB4oWnkN6UWF8yeetGtDoYg6YmUdOjqzU4P7McPKmXvR
	 0GinMhedJOt8ve4X+Gz8X1eWDo7nBF1PG/MM3rGEQ1xHibabhWd7SxLZaqC+j7aLeceuN
	 I3C6OGfnKG3yN2ZM0PlxQuEQIJi+OrhiyWDwEbHISIS9wgG7sxV8iQVNB3kHlN9rscDSK
	 8UTt7sQGZBfL3otP9sK0v0Ad8GnzN9fUOAdBM1soL2Vy23IWOBcg8EcNbSeSqRBO0Fg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794329483;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=svxxE6aa4tOgEOuICid1wcHp6IDk6Icb9UfPgrrg5LQ=;
	b=KPGr2DWHHdmhKZwJ15r16C+XfwcohvvYQxmh5/UMPLvoBHsIlgkn6mYF8BiOxggadscl
	 I7A/kG8/X3ypwOc1MaNXZfZyvQ31rMBvJ8/TSE+Ni1aDGSAfn/ij1uB+AAhVxE9Zw1fv0
	 ZahJMxkm8H8wzQ3AQ74ba7OOBFE7a4IVQQ5UMI+Aq270fnJVbDvuMuP/mWwqaoQ+vflF8
	 JcTvn4Roizn4f4YzzxoSqs3d0QxDrWkuZ1Vgw7bjkbQl2wCdnWun0aycQBr/vgHyugxHQ
	 2cY9lgInZv1UzxPRUwAi5objmLtQwdFmxBVlDPDn5HI0N6M6tN+p1A8dsZrKMJeAt5Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b="Z/ZUdx9x";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794329483;
	bh=svxxE6aa4tOgEOuICid1wcHp6IDk6Icb9UfPgrrg5LQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mdSay/341oa024IHg5SSV4iPmyX2+AxABJDCm5dZlUkaWjWN6cPrKsCvFncgXhm/6
	 vYdbHBKfXHIzVpWX78wUgnekN1fnLFAP0z9BtrPKT1s5BGglImfl1tA3WeuAZ5biOU
	 MJPMiHKegjY3JbklRmcseRqIJLB6h6kW+MF9YO5fr19/5adG5DGJSWPbsX7GsoNtSl
	 mLUjVZDGwM/UPb02+gjaXl1JICdCH3FJnlC2DKm7doabniENHhr46QfBZDgu3hM39P
	 V8KAEHOLkdkjW6IPlRw39wqzzz2C8rxNJGsthRLb4FCrMvSdqfmiOIUKCMXTN3J9C+
	 iaUsarpEhkMvg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 99891405D6;
	Tue, 10 Nov 2026 16:51:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 595C3335
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 04:57:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3EE3D407C7
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 04:57:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XvDDSRbdVAB2 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Nov 2026 04:57:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 278A040612
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62a; helo=mail-ej1-x62a.google.com;
 envelope-from=tianyi@cloudflare.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=cloudflare.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=cloudflare.com header.i=@cloudflare.com
 header.a=rsa-sha256 header.s=google09082023 header.b=Z/ZUdx9x
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 278A040612
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 04:57:26 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-c4d5cb1b181so218804966b.3
 for <intel-wired-lan@lists.osuosl.org>; Mon, 09 Nov 2026 20:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloudflare.com; s=google09082023; t=1794286645; x=1794891445;
 darn=lists.osuosl.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=svxxE6aa4tOgEOuICid1wcHp6IDk6Icb9UfPgrrg5LQ=;
 b=Z/ZUdx9xHauyEgEX5UM2nQdCVDqLk7P/woWMldLFsx4EerT7Pfop7j7kFz+m2DKoDl
 EFnjShIS+iBrhy6Jtjzp2HNBcIJ+mWumG47zVWrYu/vDqEPhH64ouDqOZ1eY/DDKSX9A
 OHBYMmhJZgJZ75cK5G8CxeJMTyPW2ctw0KcJAU5p2ZM6lSrU/1W/oJ0B9i8f2PZ38/xh
 p9nV1XQRl9afVN7xIX2GuLrngJkmxlNXcs885pRmOG2v3A3p72Du95mGzqn8tcPn2G9U
 qLng1Zog9vCy82jYmXCDc1Qg1PgWvQcLWuK//3m3Pp6OZn8L928esPMoW2GIlIfBm7f6
 v1Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794286645; x=1794891445;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=svxxE6aa4tOgEOuICid1wcHp6IDk6Icb9UfPgrrg5LQ=;
 b=eC4ytrRr1fZRRblTJwh4TcUEbPC9444Q8rxz2hq+ptevc3ApiuhRLm0/X9XR6REWPa
 Xx/aOho1aDCilV2ApEsphMJgMzMgPZ0fxDYDHQ+jdgdB5drrucz/NxZLcsVu2cdWoYzU
 FQxYCsAP96PJJTpKpZvJpCk1EaIaa6Qaa+8zTMioaaON0XwhOsQ6u9i4lPxnslXHhP38
 J27YBwsvLjKVjaswXZJqBc9nP+7VzDW7s/UHPtADTvNniZaoU7xqARLG28WE+wfEzg1w
 +fh2nndcizMX1THJORH0qVAmY/cVTBipnEqAHo3Hi4PutUtxexmiAIMmgnXxFExLW+X1
 8CSA==
X-Forwarded-Encrypted: i=1;
 AL+hErEHkRq830baTFnIAmXJxXtYGksxaZHxhj1sRFjuWDmqUBUt8p6Tm9Ida1BJoatBR80B/Fn5hbjcdnxGtBlYO9o=@lists.osuosl.org
X-Gm-Message-State: APuU4Z8Yw+AZ3aODdpt1oOLKXyyrirVLjq9c3cSKVhAQlkgxsb2Rls8i
 F2kMuTYmOK26Em6vOxl/cFzLCvaMLAi+6ceLQVnj2rYtSGHf3y3bH180ywuIOYwCIPY=
X-Gm-Gg: AYBFou3r50ZazoTXFhbnEK4ndRrU+jsoBbkkkh2TNyK23PeIjcZ740YxFGAlsv3g6Cj
 ikHDJTSoDl5rBQYabxxCqOgX89mnZSpBPJuUp7t4ndForkMPIffJI9p9yBfaZt3W0FVK8022qmW
 VoNLF86WDvk7txgySrA15aTV3PCwYPzIEoXYzsmqyskCTI31QD3oAPc4iAz1/AAmJOxiYWcSrdI
 AJ5BdlObEgm8orInB0AsH5K7iNbSrIcmD8NKLR7mGnBh26om5fr9CEcUtu38Kk/NGEDLPOXrb64
 51tcQ21Ls+eH1XVqCTy8RTHwGPzbLFdC6e9/qIfZ+kxYU1mjZ6letRiqJUIlJrT9uFiFUvvPdZ2
 s6FN2ArDzk2zxw0wRNdn4NeiQwPhTGHdcksGeKaK+3cqalnm2r3ERdUygAlLBFg0wb0VlqLxr0N
 G8jFISc6+LXfecBkKUNughE8prM6ArHRCmSEty/P+KSDZ/c3Ry0eQP/Q/Eec/jgRZQI5PYHkwlo
 AB3XqLJK/gR5JmdHu0M7W7odM9iHlmZFwGB42k2iOFbNGHXHCHo2A33Y0KHvOc9t4jIdtO+7m2Z
 RwVz1JPfsgPLuYYZKkIALeS1CS/Q41uI245oxCh/+iSKvkSbGUWFSww1umT5XkE=
X-Received: by 2002:a17:907:c13:b0:c49:9632:9280 with SMTP id
 a640c23a62f3a-c5049713306mr110969466b.46.1794286644790; 
 Mon, 09 Nov 2026 20:57:24 -0800 (PST)
Received: from L9JK9NPFH9.lan ([104.28.20.56])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c504a56c721sm61278266b.23.2026.11.09.20.57.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Nov 2026 20:57:23 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: sashiko-bot@kernel.org
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, Jakub Kicinski <kuba@kernel.org>,
 kernel-team@cloudflare.com
Subject: Re: [PATCH bpf-next 10/15] xdp: warn on XDP_PASS with stored values
 when XDP runs on an skb
Date: Tue, 10 Nov 2026 04:57:20 +0000
Message-ID: <20261110045720.77278-1-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <sashiko-outbox-206173@kernel.org>
References: <cover.1794281983.git.tianyi@cloudflare.com>
 <15f830924c4d06d3d8c7e41fb8a9f8c29b63d9a7.1794281983.git.tianyi@cloudflare.com>
 <sashiko-outbox-206173@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 10 Nov 2026 16:51:08 +0000
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
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Tue, Nov 10, 2026 at 04:10:19AM +0000, sashiko-bot@kernel.org wrote:
> [Severity: Critical]
> This problem wasn't introduced by this patch, but can veth_disable_xdp()
> unregister rq->xdp_rxq [1] while veth_xdp_rcv_skb() or
> veth_xdp_rcv_one() is still using it?

[ ... ]

The list [2] and I [3] are aware of this problem. If it is still not
fixed in a week, I will send a fix to net.

[2] https://lore.kernel.org/all/20260917185814.0f944e78@kernel.org/
[3] https://lore.kernel.org/all/20261105143356.17062-1-tianyi@cloudflare.com/

Cheers,
Tianyi
