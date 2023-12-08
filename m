Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51DC6C10DCE
	for <intel-wired-lan@archiver.kernel.org>; Fri,  8 Dec 2023 09:28:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F24F3417D8;
	Fri,  8 Dec 2023 09:28:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F24F3417D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1702027712;
	bh=Som3Q7wddPtJB26kW2E34aa3fYLymfsxCFQDBU6avNc=;
	h=To:References:From:Date:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=Z+okfcgLWZ/wR0icKREHcCBEtJwr4EodOOZW2UmvMicFSVnjNdT1nwpPaiunyze0c
	 4NI3SKmJrU0HIVEp+tNHwfK5bkXCSn2h6IAidbNPWofQ1ymn10gWT1m0IYCEvT1kue
	 ZvACX1efSPswgS4tOTeKMkcD05FG38fpfseSR13hPK0ghgkcM9RMQaz/5jBHigSxLs
	 UUxS1xohF5B5Lc5Xx4H/mrdA9mYs98MliGUmkKuJMp+PwctVM0zfKm8jgHWWFGM/Yn
	 FmnP+4KtJ0FHVZVd4qdsAQCg8jyZ0h8c12xCWQN40Ld7B91UvJqUKZ4Bivqn7h1nMS
	 lI8iENIR8cALA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3RiQWBwJrkXI; Fri,  8 Dec 2023 09:28:31 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id E84B1417E0;
	Fri,  8 Dec 2023 09:28:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E84B1417E0
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 4DF7C1BF831
 for <intel-wired-lan@lists.osuosl.org>; Fri,  8 Dec 2023 09:28:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 320724179A
 for <intel-wired-lan@lists.osuosl.org>; Fri,  8 Dec 2023 09:28:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 320724179A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tM1HiFrzxYUD for <intel-wired-lan@lists.osuosl.org>;
 Fri,  8 Dec 2023 09:28:27 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 62B9C417D8
 for <intel-wired-lan@lists.osuosl.org>; Fri,  8 Dec 2023 09:28:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 62B9C417D8
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.53])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Smm1X2YcFz1Q6QK;
 Fri,  8 Dec 2023 17:24:32 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 8 Dec
 2023 17:28:21 +0800
To: Alexander Lobakin <aleksander.lobakin@intel.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20231207172010.1441468-1-aleksander.lobakin@intel.com>
 <20231207172010.1441468-9-aleksander.lobakin@intel.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <1103fe8f-04c8-8cc4-8f1b-ff45cea22b54@huawei.com>
Date: Fri, 8 Dec 2023 17:28:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20231207172010.1441468-9-aleksander.lobakin@intel.com>
Content-Language: en-US
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
Subject: Re: [Intel-wired-lan] [PATCH net-next v6 08/12] libie: add Rx
 buffer management (via Page Pool)
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
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Larysa Zaremba <larysa.zaremba@intel.com>, netdev@vger.kernel.org,
 Alexander Duyck <alexanderduyck@fb.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, linux-kernel@vger.kernel.org,
 Michal Kubiak <michal.kubiak@intel.com>, intel-wired-lan@lists.osuosl.org,
 David Christensen <drc@linux.vnet.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On 2023/12/8 1:20, Alexander Lobakin wrote:
...

> +
> +/**
> + * libie_rx_page_pool_create - create a PP with the default libie settings
> + * @bq: buffer queue struct to fill
> + * @napi: &napi_struct covering this PP (no usage outside its poll loops)
> + *
> + * Return: 0 on success, -errno on failure.
> + */
> +int libie_rx_page_pool_create(struct libie_buf_queue *bq,
> +			      struct napi_struct *napi)
> +{
> +	struct page_pool_params pp = {
> +		.flags		= PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
> +		.order		= LIBIE_RX_PAGE_ORDER,
> +		.pool_size	= bq->count,
> +		.nid		= NUMA_NO_NODE,

Is there a reason the NUMA_NO_NODE is used here instead of
dev_to_node(napi->dev->dev.parent)?

> +		.dev		= napi->dev->dev.parent,
> +		.netdev		= napi->dev,
> +		.napi		= napi,
> +		.dma_dir	= DMA_FROM_DEVICE,
> +		.offset		= LIBIE_SKB_HEADROOM,
> +	};
> +
> +	/* HW-writeable / syncable length per one page */
> +	pp.max_len = LIBIE_RX_BUF_LEN(pp.offset);
> +
> +	/* HW-writeable length per buffer */
> +	bq->rx_buf_len = libie_rx_hw_len(&pp);
> +	/* Buffer size to allocate */
> +	bq->truesize = roundup_pow_of_two(SKB_HEAD_ALIGN(pp.offset +
> +							 bq->rx_buf_len));
> +
> +	bq->pp = page_pool_create(&pp);
> +
> +	return PTR_ERR_OR_ZERO(bq->pp);
> +}
> +EXPORT_SYMBOL_NS_GPL(libie_rx_page_pool_create, LIBIE);
> +

...

> +/**
> + * libie_rx_sync_for_cpu - synchronize or recycle buffer post DMA
> + * @buf: buffer to process
> + * @len: frame length from the descriptor
> + *
> + * Process the buffer after it's written by HW. The regular path is to
> + * synchronize DMA for CPU, but in case of no data it will be immediately
> + * recycled back to its PP.
> + *
> + * Return: true when there's data to process, false otherwise.
> + */
> +static inline bool libie_rx_sync_for_cpu(const struct libie_rx_buffer *buf,
> +					 u32 len)
> +{
> +	struct page *page = buf->page;
> +
> +	/* Very rare, but possible case. The most common reason:
> +	 * the last fragment contained FCS only, which was then
> +	 * stripped by the HW.
> +	 */
> +	if (unlikely(!len)) {
> +		page_pool_recycle_direct(page->pp, page);
> +		return false;
> +	}
> +
> +	page_pool_dma_sync_for_cpu(page->pp, page, buf->offset, len);

Is there a reason why page_pool_dma_sync_for_cpu() is still used when
page_pool_create() is called with PP_FLAG_DMA_SYNC_DEV flag? Isn't syncing
already handled in page_pool core when when PP_FLAG_DMA_SYNC_DEV flag is
set?

> +
> +	return true;
> +}
>  
>  /* O(1) converting i40e/ice/iavf's 8/10-bit hardware packet type to a parsed
>   * bitfield struct.
> 
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
