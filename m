Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC02C77B7D
	for <intel-wired-lan@archiver.kernel.org>; Thu, 18 May 2023 20:36:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9D54D8453F;
	Thu, 18 May 2023 20:36:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9D54D8453F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1684442193;
	bh=5l0Mgb7keMiIll5TqxW4OLPyF4hNXKICSepIT3MPnJU=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=mMDTKiu3D+1qw79rzFX2E8ch3hsTI4c9aUYxlxKK562EufKITHDgnbSKYzppSCdQz
	 hMPJdC9uw5Iyy0lUmALbinAFyPowRJRK70N59Ix6qi7r+hmDjSQOTGe00Lokt8rbuh
	 1YkHlHdxlWxxzXwbc5CRHJB3tiHcbJ7wG7c8o6UNSunNrWxOmpC2D1cGL5H4H2CgZm
	 F2TELg0ofug5iwq5HCgxOf/+l4QfW2xruxE0mCfP14W7YN26ykg+S3i5GksrwOPJVS
	 YjdF/XxMho8ZqNwFHdkBg4HAuDNZ+U4EcVvoS91a3nDYyQjA/XbvDok/sbCR1a2gNw
	 7GmMHt6P7/eTA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 75WRcRWKKH3s; Thu, 18 May 2023 20:36:33 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id C5EBC8453B;
	Thu, 18 May 2023 20:36:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C5EBC8453B
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 66A521BF356
 for <intel-wired-lan@lists.osuosl.org>; Thu, 18 May 2023 20:36:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 459BD8453B
 for <intel-wired-lan@lists.osuosl.org>; Thu, 18 May 2023 20:36:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 459BD8453B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Of6HZcdeUMCx for <intel-wired-lan@lists.osuosl.org>;
 Thu, 18 May 2023 20:36:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A53E084527
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A53E084527
 for <intel-wired-lan@lists.osuosl.org>; Thu, 18 May 2023 20:36:30 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 9C7C3651FF;
 Thu, 18 May 2023 20:36:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A18C433D2;
 Thu, 18 May 2023 20:36:28 +0000 (UTC)
Date: Thu, 18 May 2023 13:36:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Message-ID: <20230518133627.72747418@kernel.org>
In-Reply-To: <0dfa36f1-a847-739e-4557-fc43e2e8c6a7@intel.com>
References: <20230516161841.37138-1-aleksander.lobakin@intel.com>
 <20230516161841.37138-8-aleksander.lobakin@intel.com>
 <20230517211211.1d1bbd0b@kernel.org>
 <9feef136-7ff3-91a4-4198-237b07a91c0c@intel.com>
 <20230518075643.3a242837@kernel.org>
 <0dfa36f1-a847-739e-4557-fc43e2e8c6a7@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1684442189;
 bh=gywY8PWGZ7qWr4FaAteCVzU5t3a/2TpXuUzZ7c29shY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Br1Udi1ECQB0WIbtiCJSMtyrZ0ZMFtG5MnIzFiC83U6jaNH+WQmSY8dQfH8tL7j8Q
 +0jP+65qMGvOW7lyq3wUg7Ji2WecBWrOGFcQSUJZ1GEfYww5ZVUZwDLnUTrwMc6fP2
 gzGp6ZPJpizh1bBzEmvKKr6i6zHmy1H6059ZwMLX/IBnjc5Po3kGx41TypwI5GbomU
 BqSj57ihQq/jIN4FWXdaEKo6fxDk5jRQpfJ0J72FUWhTRv//5QOEh1F9SdnsTgTxOf
 znbu4msMs3yeBVq2ASblyBUHLNTQ209fzRG4urAWuyupdzax7Gzhm5OWwsdeoeGymA
 c2csTSZrjFl/w==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=Br1Udi1E
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
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Michal Kubiak <michal.kubiak@intel.com>, intel-wired-lan@lists.osuosl.org,
 Paolo Abeni <pabeni@redhat.com>, Christoph
 Hellwig <hch@lst.de>, Magnus Karlsson <magnus.karlsson@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, 18 May 2023 17:41:52 +0200 Alexander Lobakin wrote:
> > Or maybe we can do both? I think that separating types, defines and
> > simple wrappers from helpers should be considered good code hygiene.  
> 
> I'll definitely take a look, I also like the idea of minimalistic and
> lightweight headers.
> page_pool.h and page_pool_drv.h? :D

What I've been doing lately is split like this:

include/net/something.h           (simply includes all other headers)
include/net/something/types.h     (structs, defines, enums)
include/net/something/functions.h (inlines and function declarations)

If that's reasonable -- we should put the helpers under

include/net/page_pool/functions.h ?
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
