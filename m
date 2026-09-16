Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66D62C88E77
	for <intel-wired-lan@archiver.kernel.org>; Wed, 16 Sep 2026 12:16:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0A9AA80E3D;
	Wed, 16 Sep 2026 12:16:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UK_hq7UF3QX8; Wed, 16 Sep 2026 12:16:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 78ED080E33
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789560988;
	b=SL+Y5XLszicXoadktXL5pt2FnzzGCbjL6rKmXpk+IV25OfmIEhIReejTe2UIElZV6gIz
	 kiTS3sb93TcG2amLRrlaWY8F5gh9tj6DqfO2qJgg9QBqlb02JrEhpieVqruhCT7Fw9S59
	 9vuxjtrevvnxmOAhuflg6AzxVZn5OKaUmhHvMunzvrdJ93IRI4eum7PoZhV8OS8ADwg0B
	 hDv6AEwBhjN47usXORPvWwbzTaxxYz8Gt4iIA0/v1r51NweCDx6FOFtRuaDvHqJ3kQUDc
	 pljiRYlhDtx27nKVFO3Ad9rghDH+oY6Ulg+JHqfbt0ER6vyyFOPQ0rLwNl04bxj4+ag==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789560988;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=PIS9U/18rQl8lBKlViyzQy9Hl++svioDR9nvszokbIQ=;
	b=MBtBPrOsRVcYXw394PTwraNzdpO12fBz1RegUC/+z8RPs6Cvy1ljlrdxXRd0Kqgj4d5s
	 XMLgWwCn/feVsG7CeQ0Gw6SNB5OilJGbvneHibrEbMKXSbxu6fbSvnAzV42PfnMgxhp8O
	 O7deDYqREIcTSSFGkEOcPF9W/v8pfsrFRhi1WfjZtaEc03Dpvs0ju2uZABc1FbQKQvCij
	 md5uVGceQ+46YVhKIjJWMp3eL/u5YCAbRytPCy7kKVUCC19SLl2mr/sa1wvcOXWqrPsbg
	 si9Hs14zhKpxG3IlxiRKtn2VpPvj3PfvjNkfE6KL2eg0fl/bmC+n2c6h1cXeAZMzLwA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789560988;
	bh=PIS9U/18rQl8lBKlViyzQy9Hl++svioDR9nvszokbIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IgWbXTBDg/E9781On165fb3UCLS13RDgnlE9NPd05iN3KNbN4XVWBAcrk6z5KC0jh
	 iPUSG7EZJIc/2YkiKZJuugLFXXu8mFvQHsP/WQzZw4kS5fm2w9vft3yL5qCpgEjodO
	 rGqNgsw0ha/vQAS8OytXOoL8YVx9iW1SfI8eyiDmHjDsjonOP+Q/j4SuVTjzGkDQ5t
	 B5JNV2TSnzfKCulxtR6rxLrIE85NBS9TgUfgFBc1rPoPR/yYshzaRSDa8QvV3Nmtv+
	 TVto1h/ZaRbKN3K+qIksS5k6cfDRPjUBhYtofCuR5N9sLmR+ua0a/thDp041dXzyWs
	 gKpkhaelj/VXQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 78ED080E33;
	Wed, 16 Sep 2026 12:16:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A928E29B
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 12:16:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9B5CC402C7
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 12:16:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rDvv0EQHA8OW for <intel-wired-lan@lists.osuosl.org>;
 Wed, 16 Sep 2026 12:16:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org EA44540093
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789560986;
 b=U2V+D9OxUbAL1Kh9NwBHB8636f6YfzgAYZGCm2tDAG8HNzJ7YmtkOAZUgdZ2Ln9jNBTO
 6oTEBseP9XzIaAFCLhBv8DexVTbzUxO9g5ntbrAR+lpK1wYfhLSeGM+BVWq8njJj0TxyR
 5U3SpzjPQ/bDVHKhpJQj4oiYlbwqSyeb5vG9y3DctyV8r8eHaRa3neFN0tOvTq0t2QzJ1
 ohbhw7ap0E/NzxrG2yH0Fc06ho4JWrh75qf7poIMEzGNyQRmWm3b1UtsEE5gvZ5HmzCQs
 HTLfXLtBUNLOmL/jW6m9CGuSinGfkGzzsgfZdwjHROZkUTXsP4uTB8s6uTDO4sGCcJw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789560986;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=PIS9U/18rQl8lBKlViyzQy9Hl++svioDR9nvszokbIQ=;
 b=AsvWlE6TMkDEm+uQ0UOzwHIh1t0Aty3XeLG+IZaFyteOdunkUq+KfOhGBCIj8zC82Kxk
 JwE9ko8av7yT78dg+f8bAInwd83YCcoyEngeK3yEcRNvtbNa1usOUxZA+sp/DXgAYHnEj
 U48/H6GizPgd2fL7RoKRoy6zCKVNIGPNPcS18y7lQxgEX6GdPEWGkCh+HuSwQ7AT6UuvW
 /VVLIr1MlcxP5CFwk4UbHDqLE84jG3lmjhqcnfmWbrzgb+XGFmo+Cik1V8nZbsZnZDVEG
 DVvEcmX9ZQg1xzfIXbbCGkUsCxBitOngNIyed0H4MuzooTdoXuNHoLZmiiIe3CEwCsA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=BQmbd9uu; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=BQmbd9uu
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EA44540093
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 12:16:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B15EB60234;
 Wed, 16 Sep 2026 12:16:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84D2F1F000FF;
 Wed, 16 Sep 2026 12:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789560983;
 bh=PIS9U/18rQl8lBKlViyzQy9Hl++svioDR9nvszokbIQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=BQmbd9uuSFjAokSp2ZjJVssc8VsmgadTTYCv6wxOXlPms9LPdxOm4A5Yl+2e297GE
 a9xYeZzZRZhmCGSPGa+3fzKz1NlcSRuXNsKfrSeoRlkAMcvgOa27JoB3eGLA7PQVZs
 H5eqjo3VgZsO7/4NSaW6QZlwP1bZPtF/sseOdGEe8tALWqc9hAT6+Vicb5xtCSfQZD
 JtM7Wjk739NboFGWvjZHQgL/0FPc85EL4XAQaiOzKvAfAnO94pYdvSvNIZl8pPYOlW
 e5DXwCPzaV0o/5VMILrxMHKBH8mMrnDbYtQ5fjo4isD39U8Kihn5KBF3xs81L28dU0
 uDfGB/oSG8FBg==
Date: Wed, 16 Sep 2026 13:16:19 +0100
From: Simon Horman <horms@kernel.org>
To: Matt Vollrath <tactii@gmail.com>
Cc: intel-wired-lan@lists.osuosl.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCH iwl-net v2 0/2] e1000e: fix Rx DMA error handling
Message-ID: <20260916121619.GD51261@horms.kernel.org>
References: <20260913171555.89537-1-tactii@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260913171555.89537-1-tactii@gmail.com>
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

On Sun, Sep 13, 2026 at 01:15:53PM -0400, Matt Vollrath wrote:
> Fix some longstanding bugs in Rx DMA error handling.
> 
> These two patches eliminate some conditions which would result in
> DMA_MAPPING_ERROR being sent to h/w or to dma_unmap_page() or
> dma_unmap_single(). A teardown leak in the packet-splitting path is also
> fixed by a necessary refactor.
> 
> v2:
> * Renamed series from "e1000e: fix Rx bugs"
> * Removed RXALL buffer overrun fix from the series.
>   RXALL bugs will be fixed in a separate series.
> * Reworded patch commit messages.

For the series:

Reviewed-by: Simon Horman <horms@kernel.org>

