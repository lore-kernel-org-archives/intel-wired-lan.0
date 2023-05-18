Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 860AFC7EE24
	for <intel-wired-lan@archiver.kernel.org>; Thu, 18 May 2023 04:20:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2CBB660E29;
	Thu, 18 May 2023 04:20:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2CBB660E29
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1684383600;
	bh=37Ce7qyq8NjdQyMmFsclpHR9sWtCu2FbDMqZY6Iam74=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=lnJt1LeX2ehRfVxMSSf1rRxyjILgt/zH+Sfv7ljpTjTQwwPiCKfypHm6NYXNNGWB1
	 frp9BcgBKE33xYg+4WhoekWAv1eo4G5OP0PEhg6/YUQUzPuYRDGzX8nD+xTTljdNGh
	 Oq+oCQk7caBMzLblrBIYjUM8Bx5H23QPkGlxJst5ejziZRUFTva8NX0yOd/4BjEtba
	 Qiopgofv8Aarzf5uA+aEYIJqjw2d6VpIhFK3zvtdP8iayO5M9sLc7jNafSx2P0p1K1
	 H2yKNfc2pN8O2rmAM6oSZznUpZdf5I2f/g6rHUMD3kr6xcMFPWxq9GnygOYMp952fa
	 h8MBbplrtwGsw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hU0n19Dq13gA; Thu, 18 May 2023 04:19:59 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 36B14613FE;
	Thu, 18 May 2023 04:19:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 36B14613FE
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id D47011BF3B5
 for <intel-wired-lan@lists.osuosl.org>; Thu, 18 May 2023 04:19:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B9504400D3
 for <intel-wired-lan@lists.osuosl.org>; Thu, 18 May 2023 04:19:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B9504400D3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PXgAmCKvEoa0 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 18 May 2023 04:19:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3E96E400C1
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3E96E400C1
 for <intel-wired-lan@lists.osuosl.org>; Thu, 18 May 2023 04:19:56 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 9487960C8F;
 Thu, 18 May 2023 04:19:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75CF0C433D2;
 Thu, 18 May 2023 04:19:54 +0000 (UTC)
Date: Wed, 17 May 2023 21:19:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Message-ID: <20230517211953.4b9073df@kernel.org>
In-Reply-To: <20230516161841.37138-8-aleksander.lobakin@intel.com>
References: <20230516161841.37138-1-aleksander.lobakin@intel.com>
 <20230516161841.37138-8-aleksander.lobakin@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1684383595;
 bh=GeeqPPmpGf6jdAsXnyHhP0qzOCppSPPDHIviQQ+RUYg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=A98Fra/jyQMybi+nJKUXkCM2ckcK9Xm52ect40QmS/P1i3VpIFoYgl9bMnR3vHIoD
 iI4pgRjRcVuoGO3AGzz1mx0Fb/30ikGf0DY2BAV90MD8IcpYT0HQJWTEkfCmcZ4rJT
 X8gCHlYxiVf6k37PczzBBdqEbNkga48+e8gz3CJ0l6FJmXJ84f5VdcHugKqabP5S9U
 GFUcGr7kgvREKQ5XjbQa0ShastY0EEzu0eTblw7YbAN/YIojCzLh707GvP5To3TEgG
 XTCt9KuXsYmZf4G75Cp4jokf9vs6OZhB/M5xmH6C30VqCKoMNcQPSUaohNEmYRwtX3
 4SzSAVmMvm9vg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=A98Fra/j
Subject: Re: [Intel-wired-lan] [PATCH net-next 07/11] net: page_pool: add
 DMA-sync-for-CPU inline helpers
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

On Tue, 16 May 2023 18:18:37 +0200 Alexander Lobakin wrote:
> +/**
> + * page_pool_dma_sync_for_cpu - sync full Rx page for CPU
...
> +page_pool_dma_sync_full_for_cpu(const struct page_pool *pool,

kdoc name mismatch
-- 
pw-bot: cr
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
