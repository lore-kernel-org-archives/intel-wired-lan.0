Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40384606A884
	for <intel-wired-lan@archiver.kernel.org>; Thu, 12 Nov 2026 01:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=iYC2bfV1;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aWGOzBnY
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1414A812B3;
	Thu, 12 Nov 2026 01:37:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z93tSkl2tRni; Thu, 12 Nov 2026 01:37:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7E6E48124B
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794447440;
	b=RXfM9xuKd5oh4G2C2QXnXR6XFJn66LBsGGlpO8PQYSpatQElYsBsYlsabXEk7HG8lCX+
	 i49Jtf69DVb6XPPqpKXSpduZX8Gxj/vdTsAaEq7z/2M5JTrB+Z6xlEj8ibc9rw2PGyZex
	 mQeKwMgD7JFYYRASrs/RkLg1ZqMoDpQiD5lxi3w92aaRrCUhqbASLxkltpk7GNb/Alo0K
	 EHW4UZijirjRbLzZjVj3FOP9I5lMNsJAQ+COk4z9lqS1sCzTQvNOHdsXYDaIGWNaWFPaH
	 8pZTSAOgo5EEsxOcbJmylrGA5j93iceTXeoPyXkwKObQP5xKspEWdCP9qCvwChBZmmQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794447440;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=btUPWx1UcmpMZ1wNFLhAkAK57tox2FcAT8+j9g6x7RM=;
	b=omLkKXxiMlX20iw/rkg0/K0ucW67CCj6OG9IrDR7E/OTcopF7ljWQK7gV9d31P98XiVm
	 Isa5aJ6yCULvA2cPtDp0j2Wac1CR0+OdtiwZY2WYXI6SVnfjLN027SRRanIJLD+REG+iy
	 p8658giEzlAQruo8l0SNCeA7sedrKQQdTATvuCSkuCpzvGCKRjCmkdo3krm6zMOB3pBCc
	 471/Wz5NdBzk1L43IBG0xyoNaJRrtWaTBTIUdnjWb/h+PQ7qhP4V8HFm6OeuT6VvVcmKc
	 q2aSGK4sobmRr6iLnjmM44Ls1TT5pKSYEv857fWROHONxuKXIJNZi3q9LkM4A99DSYg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794447440;
	bh=btUPWx1UcmpMZ1wNFLhAkAK57tox2FcAT8+j9g6x7RM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iYC2bfV1MO/DcoR/mRghTx8YB67JBquRlRtjbgpuq9YTRuxzLf8DEzXEi0EWaysvQ
	 KcOzksl2fgsVS8OT38qVYkoL4jEXG6p56oFu7/8U5BxPSsiNyHk8qtz/6AaLD0B4wG
	 ifIFUWyXZS9cnyRC2ppGWoDWYHjvwlwqDTDrxT5anlY2GrSWf6mNLO4oPIhKSgMu+r
	 27HL47ESF5qPIM0704DqhuholzOJKGBE5HEJazEZw3x2xcN4zJ0nsz/7V7liaj4Zoi
	 nh1iJZcJeUlav78WzkizZRTRZS92CR4GfThoeqz4EeFDzO71UIhuNAQKlDIbCKz1Jc
	 BnNCKf92U09CA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7E6E48124B;
	Thu, 12 Nov 2026 01:37:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2162CD7
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Nov 2026 01:37:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1ECF34060F
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Nov 2026 01:37:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7QTt7iQHaLYd for <intel-wired-lan@lists.osuosl.org>;
 Thu, 12 Nov 2026 01:37:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 69318405C9
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=aWGOzBnY
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 69318405C9
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Nov 2026 01:37:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 389E443472;
 Thu, 12 Nov 2026 01:37:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3507E1F00A05;
 Thu, 12 Nov 2026 01:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794447437;
 bh=btUPWx1UcmpMZ1wNFLhAkAK57tox2FcAT8+j9g6x7RM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=aWGOzBnYNa0wVY3pMutI6+4BN31XNpQd4GlZTzAz07lsL0KwUtBb0lgZ6nVvKze6F
 M9w2uEqj+wtz6a6Ww83J/b9Tol/gqGQcPRgGd8Hqn85BgIyleFGK7zi+JCGmEyvR5E
 M3dOXdjmq6lvympxiICUmANRGPspFpZq0jRylkE97o5VxM6HAGPj3aDMl3HTcUvek8
 ZS/G34DyqhyDR1stf3cbqOtS1e0nxdC28q5zxbow87lTc4D9q3KGteJlGd5vvQaVOk
 XaYDgIf4oVx0BrPT2CV6vUDc0AKIo87i719Bc18b2GUBHeJw+gRyhYGs48kNFm0/+0
 qaWLKBH4AQJDA==
Date: Wed, 11 Nov 2026 17:37:15 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Marcin Knap via B4 Relay <devnull+marcin.knap.vecima.com@kernel.org>
Cc: marcin.knap@vecima.com, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Magnus
 Karlsson <magnus.karlsson@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, Simon
 Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, jtollet@cisco.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, =?UTF-8?B?QmrDtnJuIFQ=?=
 =?UTF-8?B?w7ZwZWw=?= <bjorn@kernel.org>, Jason Xing
 <kerneljasonxing@gmail.com>, Nitin Shetty J <nshettyj@marvell.com>, Joshua
 Washington <joshwash@google.com>, Harshitha Ramamurthy
 <hramamurthy@google.com>, Sunil Goutham <sgoutham@marvell.com>, Geetha
 sowjanya <gakula@marvell.com>, Ratheesh Kannoth <rkannoth@marvell.com>,
 Subbaraya Sundeep <sbhatta@marvell.com>, Bharat Bhushan
 <bbhushan2@marvell.com>
Subject: Re: [PATCH net v4] xsk: Do not free ZC Rx buffer when the Rx ring
 is full
Message-ID: <20261111173715.75bccc04@kernel.org>
In-Reply-To: <20261109-xsk-zc-rx-double-free-v4-1-24e00ac221a0@vecima.com>
References: <20261109-xsk-zc-rx-double-free-v4-1-24e00ac221a0@vecima.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 09 Nov 2026 12:01:14 +0100 Marcin Knap via B4 Relay wrote:
> This covers redirects to an XSKMAP. A zero-copy buffer redirected to
> a devmap or cpumap is copied by xdp_convert_zc_to_xdp_frame(), which
> frees it before the enqueue can still fail. That path is not changed
> here.

But what's the plan for fixing those redirect targets?
I think it'd be much better if we had one series which
addresses all the cases, which AI can review...
If there's consensus that xdp_convert_zc_to_xdp_frame() 
can be trivially handled later let's document that (and 
how) in the commit message?
-- 
pw-bot: cr
