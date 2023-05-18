Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C6B6C7EE24
	for <intel-wired-lan@archiver.kernel.org>; Thu, 18 May 2023 04:19:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 12F5A60E29;
	Thu, 18 May 2023 04:19:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 12F5A60E29
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1684383560;
	bh=6CxKpQndB2VoAtlBXvZYH0Idr6PMAntOXL9hp9L2Z08=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=VHmfjgnKmXjVeZeuQorPt+1Vg0ECP4esPhPTgZGNI699al2q+e+jhF2JPSvSeMd6x
	 E69xkVUGzwp+KBwAYZ9iTF+DyiUF5diOUpdG7co9/tf9xjWMGVXUm5lFQkmov0FTJK
	 99k51p5CQsOqNIB5GrbMseuRh24ItOtHsR1xWesRcI1y32ooQOq5PfVvhrRw2Tgy/i
	 uy/bFP3N5ixB+uQ5jQuy0/N85LDmdZ+vbDoqxt9r0Sv1I24gJCmttw9ntHwwlbCvS1
	 9VLxpZD2j2hwyCIgVdsIyhwWubWdGOwTtRPN8PBJfChXagYEnBOfwpil9zUlQ1/coL
	 ykEk+Le96+68Q==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ClOksg14Z5CE; Thu, 18 May 2023 04:19:19 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1461C613FE;
	Thu, 18 May 2023 04:19:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1461C613FE
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 463B91BF3B5
 for <intel-wired-lan@lists.osuosl.org>; Thu, 18 May 2023 04:19:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1D9CC400D3
 for <intel-wired-lan@lists.osuosl.org>; Thu, 18 May 2023 04:19:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1D9CC400D3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X6jh8O2u1nkT for <intel-wired-lan@lists.osuosl.org>;
 Thu, 18 May 2023 04:19:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 88764400C1
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 88764400C1
 for <intel-wired-lan@lists.osuosl.org>; Thu, 18 May 2023 04:19:16 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id CC27160D2E;
 Thu, 18 May 2023 04:19:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F76CC433D2;
 Thu, 18 May 2023 04:19:14 +0000 (UTC)
Date: Wed, 17 May 2023 21:19:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Message-ID: <20230517211913.773c1266@kernel.org>
In-Reply-To: <20230516161841.37138-11-aleksander.lobakin@intel.com>
References: <20230516161841.37138-1-aleksander.lobakin@intel.com>
 <20230516161841.37138-11-aleksander.lobakin@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1684383555;
 bh=kWki9SBP3s3z9e8Ww/Dw19IuXFtpOy6XpwmIo0LWGkw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=jXN2AmuBMiyJMvI5RI0B+cuSny06go0LAOC6U+JCDgICRH7ctjefRQ1B/F3WwoCvL
 PuZ2uNKgsRKH55JTQ4b7Ws2nkGx3ZPCvar3CMN/OfmTbWRO1PizQfa3KNdneqiglJ4
 /DGtc4esUf+EyeouPifs69w0zvijQBWcHSVbYk3JWbGfj1VjbWf8umlng2u9+w8H+0
 nna42fyLwCwz9woW7mNkWoifn6dw9ZoOcNBLJrRq706/IddJocqdvOO3Uu+VysTS/e
 YPKZ5gEj3mkka+HYpfs8c037MaCAVFnvbE9T/0lt+GkkcFjISVph4UZ3OGayAFLr6l
 u/jH4EpApgefw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=jXN2AmuB
Subject: Re: [Intel-wired-lan] [PATCH net-next 10/11] libie: add per-queue
 Page Pool stats
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Larysa Zaremba <larysa.zaremba@intel.com>, netdev@vger.kernel.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Eric Dumazet <edumazet@google.com>,
 Michal Kubiak <michal.kubiak@intel.com>, intel-wired-lan@lists.osuosl.org,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Magnus Karlsson <magnus.karlsson@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Tue, 16 May 2023 18:18:40 +0200 Alexander Lobakin wrote:
> +static inline void libie_rq_stats_get_pp(u64 *sarr, struct page_pool *pool)
> +{
> +}

s/inline //
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
