Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E34BDC77B7D
	for <intel-wired-lan@archiver.kernel.org>; Thu, 18 May 2023 15:02:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 60C1F4012F;
	Thu, 18 May 2023 15:02:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 60C1F4012F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1684422145;
	bh=qLW/ZS+ji4IxJHEGcAEDQbjzzllKn7mlh5rvijh3x+M=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=egjVZbsuLEmmaLNfGbQSH+DV36VZaNc0Dmo/GJ6SzbFMD6yEsCE6o8zenMaE0OVIo
	 3YJB4sWuBdV6RbnE7L8wLCm6nM5428JsRyrHzWSlY+eNSy/yN6WQ5jO1N4ZjP+WFZK
	 AxYrx9iW4kdFbEsMQd6f6pFJ4xGfsZrOHFZ0qrqgreTfz48i5dDn+MRnXkcZkvgDO6
	 57ytsZeb/CdDc1acIPy43Fc1zLG519QdWF2kQl0iqPIxvyggPcuU+9hjNaXRwUG8to
	 FA6gPT2rpv8bDycHmjpb6a02GwG3X3vin/Hp4iVeWgo08Vak0xZDymvkhJry+Ih3gQ
	 NYbk3JTYeT2ng==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PJNmD1vnVjHb; Thu, 18 May 2023 15:02:24 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7828140AA1;
	Thu, 18 May 2023 15:02:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7828140AA1
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 1BC471BF947
 for <intel-wired-lan@lists.osuosl.org>; Thu, 18 May 2023 15:02:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E7C9684251
 for <intel-wired-lan@lists.osuosl.org>; Thu, 18 May 2023 15:02:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E7C9684251
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lpfDZi7U4UE2 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 18 May 2023 15:02:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4DA25841BF
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4DA25841BF
 for <intel-wired-lan@lists.osuosl.org>; Thu, 18 May 2023 15:02:22 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 8F01F64FF5;
 Thu, 18 May 2023 15:02:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E875C4339E;
 Thu, 18 May 2023 15:02:20 +0000 (UTC)
Date: Thu, 18 May 2023 08:02:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Message-ID: <20230518080219.109675cc@kernel.org>
In-Reply-To: <f7a082ae-5ec8-484b-b602-559f6104c9d7@intel.com>
References: <20230516161841.37138-1-aleksander.lobakin@intel.com>
 <20230516161841.37138-7-aleksander.lobakin@intel.com>
 <20230517210804.7de610bd@kernel.org>
 <f7a082ae-5ec8-484b-b602-559f6104c9d7@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1684422141;
 bh=xi3asrp56sPf98pO0KbOLnYOqohykz8L/amW+nqIs+E=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=uW8OufCuNHQQ7nfswu1Ueu3ITdB0P2RTXIV9e6yfCUYIDzzIs3AoQlrpKZcZGpqWh
 V+YSitL1FBM+xQuHfKelmMh0UPmtfcC10y1z8KpUA30dzcVtLVa5muOzq/vBv/ZL53
 B0M0aYFzy4IFXn6VZ6dzQxsuaxvY1/citOAINEvMEllDeEz0JwybCwSoT7so4mAQCC
 9/4uKTi4VsIcphyWitNBpkhy3t6vLF4bmPmeqTDLngrUoXPRWGOSJ9GJKAN6iezcc7
 +hj15JkZaXQDQ0fLcg0MOXMXu6mPaLORXIqkWqzEj02mcTH9l/xAVgukySFQCfSd6x
 r1KXwdCLXJQzg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=uW8OufCu
Subject: Re: [Intel-wired-lan] [PATCH net-next 06/11] net: page_pool: avoid
 calling no-op externals when possible
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

On Thu, 18 May 2023 15:34:44 +0200 Alexander Lobakin wrote:
> And seems like I didn't get the sentence regarding "allocate and throw"
> :s This condition just disables the shortcut if any new page suddenly
> requires real DMA syncs (and if it does, then the sync a line below will
> take way more time than 1 more `if`  anyway).

Right, I misread.
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
