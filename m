Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E923C07D5A
	for <intel-wired-lan@archiver.kernel.org>; Mon, 27 Nov 2023 18:17:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0054E81773;
	Mon, 27 Nov 2023 18:17:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0054E81773
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1701109050;
	bh=Hz2uVTaK+Jg8E+2yAmv8tmPVv7Vg1zS5EM6Ae79nnYQ=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=ThGGiegNWXwnAZhNzdzuOMfKYxSd//lAhkdoqQFSkPOzt/MqerIuaPHg75Gwz4aOX
	 4zPpZqeb9D1lsxzsRll/sxuKgXjvTuSApYNAAMj6DoN3YOKU8Z6oh50xdVYvQuQPPN
	 LVAgE/Gd9UgPC6sXqLC77fEmqCkACjCzpNEUhPzRctAWA6W2ggL1nh3V9kf8kZc3JY
	 ZiW1FqHIwGAmR23eheHeEGcojbkVNExlqVtVIpliz3WEf4MB6ZSPig9FgN0LISiMTF
	 OSyLvy9+NfLDdsJbsVmLxkBo/sL6WdHBWOY/ctyCfpwHBGAn7DaxHZ3Wv8QjsMFn53
	 pozXLJ4PPNmpQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C_2cFdpYvwxr; Mon, 27 Nov 2023 18:17:29 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1F9748177A;
	Mon, 27 Nov 2023 18:17:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1F9748177A
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 877B11BF348
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Nov 2023 18:17:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5CBCE4064E
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Nov 2023 18:17:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5CBCE4064E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DNrna6I0a0_9 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 27 Nov 2023 18:17:25 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0C0384063B
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Nov 2023 18:17:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0C0384063B
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 0B669B834FB;
 Mon, 27 Nov 2023 18:17:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F6DC433C7;
 Mon, 27 Nov 2023 18:17:20 +0000 (UTC)
Date: Mon, 27 Nov 2023 10:17:20 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Message-ID: <20231127101720.282862f6@kernel.org>
In-Reply-To: <a1a0c27f-f367-40e7-9dc2-9421b4b6379a@intel.com>
References: <20231124154732.1623518-1-aleksander.lobakin@intel.com>
 <20231124154732.1623518-4-aleksander.lobakin@intel.com>
 <6bd14aa9-fa65-e4f6-579c-3a1064b2a382@huawei.com>
 <a1a0c27f-f367-40e7-9dc2-9421b4b6379a@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1701109041;
 bh=Kq8G4186oIvvG0OGelsVcM8Ma8D3c+DoqPy0UYxMLWY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=QG6ONPukVchwWErAMLaSIt1BRLdfpyvDFYvlAneifGBLLwxrgc9YT9DQUv+jORVZl
 Wv2eJmxqdYpysNKvq88faMBlo509G9gLB4g5hMFATiV5ip1MamKARiU7ZI0QrcJzby
 iBOmDkhn7cftAcy9e+M8XNePHSRWBpEgAucP8J5IOYslJywc08DLve2OOYLOKSUH9D
 dXV4vYiNlS555n5f3WzGRnn8Lj7S9VnIkJT3TNd8k8d8Wd2AEfeoacY5qE0wwD7bxj
 3zEqW/QBr4UsSEFa3hQSNHvf5Db9My2Ez9GHfnaqmQhtAynL/Th6EhJQ2Mwo2LLnyA
 KeVCUsFW2DZRA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=QG6ONPuk
Subject: Re: [Intel-wired-lan] [PATCH net-next v5 03/14] page_pool: avoid
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
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Larysa Zaremba <larysa.zaremba@intel.com>, netdev@vger.kernel.org,
 Alexander Duyck <alexanderduyck@fb.com>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, linux-kernel@vger.kernel.org, "David
 S. Miller" <davem@davemloft.net>, Yunsheng Lin <linyunsheng@huawei.com>,
 Michal Kubiak <michal.kubiak@intel.com>, intel-wired-lan@lists.osuosl.org,
 David Christensen <drc@linux.vnet.ibm.com>, Paolo Abeni <pabeni@redhat.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Mon, 27 Nov 2023 15:32:19 +0100 Alexander Lobakin wrote:
> > Sorry for not remembering the suggestion:(  
> 
> In the previous versions of this change I used a global flag per whole
> page_pool, just like XSk does for the whole XSk buff pool, then you
> proposed to use the lowest bit of ::dma_addr and store it per page, so
> that it would be more granular/precise. I tested it and it doesn't
> perform worse than global, but in some cases may be beneficial.

FWIW I'd vote to stick to per-page pool. You seem to handle the
sizeof(dma_addr_t) > sizeof(long) case correctly but the code is
growing in complexity, providing no known/measurable benefit.
We can always do this later but for now it seems like a premature
optimization to me.
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
