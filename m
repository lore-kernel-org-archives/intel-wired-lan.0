Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19838EB64D9
	for <intel-wired-lan@archiver.kernel.org>; Thu,  6 Jul 2023 15:19:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B780660BD8;
	Thu,  6 Jul 2023 15:19:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B780660BD8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1688656788;
	bh=wLvUt44j74dnqCwm2HUBmEot/u0Vb+BDCZvd1FMEAeo=;
	h=To:References:From:Date:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=nahiz4MynHj9HgbVEDaZfmtt29Iow51P+79ZfWKuOlevwJvhlr38j+qaC3QP2FCmR
	 HYYMxoqst7LUEL9McVNiW2YGJZovLfPVBjbUUEK6zZ2oKVldjrpFES+oSUkOPQUHv7
	 DOpcb/bqSk77HMSWCjqW9C9jY8mkiWc/5VzLEYDQKYrV0nuQBNwXlvlDxIDzK3tbVw
	 8MYY+lqwflnSRLO6sMyeecH+E747plPW9lF4Le9ZWh35x9MUuW8yV9rI9PaYPdBY9l
	 f7WNR1YNXPaHgAdiy9Deii25Un7mdBhuWHcV+va4HAy4M/AluYWzAQyI4vJrcuE+Jr
	 1ef3PTpA6BgyA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ltq5WtL30HdD; Thu,  6 Jul 2023 15:19:47 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 41E5D60F74;
	Thu,  6 Jul 2023 15:19:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 41E5D60F74
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 9740A1BF85D
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Jul 2023 12:47:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7C49C416DB
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Jul 2023 12:47:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7C49C416DB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KfQ6ZceKpbUh for <intel-wired-lan@lists.osuosl.org>;
 Thu,  6 Jul 2023 12:47:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 901E5416AC
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 901E5416AC
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Jul 2023 12:47:32 +0000 (UTC)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.54])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QxbnV4YfyzMqTH;
 Thu,  6 Jul 2023 20:44:14 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 6 Jul
 2023 20:47:28 +0800
To: Alexander Lobakin <aleksander.lobakin@intel.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20230705155551.1317583-1-aleksander.lobakin@intel.com>
 <20230705155551.1317583-6-aleksander.lobakin@intel.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <138b94a7-c186-bdd9-e073-2794760c9454@huawei.com>
Date: Thu, 6 Jul 2023 20:47:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20230705155551.1317583-6-aleksander.lobakin@intel.com>
Content-Language: en-US
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Thu, 06 Jul 2023 15:19:32 +0000
Subject: Re: [Intel-wired-lan] [PATCH RFC net-next v4 5/9] libie: add Rx
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

On 2023/7/5 23:55, Alexander Lobakin wrote:

> +/**
> + * libie_rx_page_pool_create - create a PP with the default libie settings
> + * @napi: &napi_struct covering this PP (no usage outside its poll loops)
> + * @size: size of the PP, usually simply Rx queue len
> + *
> + * Returns &page_pool on success, casted -errno on failure.
> + */
> +struct page_pool *libie_rx_page_pool_create(struct napi_struct *napi,
> +					    u32 size)
> +{
> +	struct page_pool_params pp = {
> +		.flags		= PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
> +		.order		= LIBIE_RX_PAGE_ORDER,
> +		.pool_size	= size,
> +		.nid		= NUMA_NO_NODE,
> +		.dev		= napi->dev->dev.parent,
> +		.napi		= napi,
> +		.dma_dir	= DMA_FROM_DEVICE,
> +		.offset		= LIBIE_SKB_HEADROOM,

I think it worth mentioning that the '.offset' is not really accurate
when the page is split, as we do not really know what is the offset of
the frag of a page except for the first frag.

> +	};
> +	size_t truesize;
> +
> +	pp.max_len = libie_rx_sync_len(napi->dev, pp.offset);
> +
> +	/* "Wanted" truesize, passed to page_pool_dev_alloc() */
> +	truesize = roundup_pow_of_two(SKB_HEAD_ALIGN(pp.offset + pp.max_len));
> +	pp.init_arg = (void *)truesize;

I am not sure if it is correct to use pp.init_arg here, as it is supposed to
be used along with init_callback. And if we want to change the implemetation
of init_callback, we may stuck with it as the driver is using it very
differently here.

Is it possible to pass the 'wanted true size' by adding a parameter for
libie_rx_alloc()?

> +
> +	return page_pool_create(&pp);
> +}
> +EXPORT_SYMBOL_NS_GPL(libie_rx_page_pool_create, LIBIE);
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
