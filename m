Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C86E77197
	for <intel-wired-lan@archiver.kernel.org>; Tue,  7 Jan 2025 12:54:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A2DFA81348;
	Tue,  7 Jan 2025 12:54:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tsNLidwuXLJ4; Tue,  7 Jan 2025 12:54:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C9F9681350
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1736254495;
	bh=WotX3OmVYtK9hOTlISzPgOeDnsvJ7SWrH06GSLHjh10=;
	h=Date:To:CC:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eHlvH6zj413M/x6QFRYtnQwtTonuOhKMwOC3FGzgkMNgbmQLTo7uYjYOc6aHh97uU
	 ilKotx/L24NWNGSHGx/pFn6wJKl5usQHsp3J0Jq2wlWD4sF3//oLqYJkoTQg07OOdc
	 /J6qX3LzBbMEtCVL2hDorR5jRTe4oR5Q9aUi1rSjv2EGu/W7xBs4n+mGjn41KFfQvL
	 FVPYdwuuk8flBaUzEOlh/Mo+4YHDzcnLcusGGG6lSsodLyapZNhxo/Z0xG1BD3rkon
	 4uwbmSWqLsNA+lnpUtZWDlcle6CYa+1FP2Eqj9G6hUa4GBB3y1qIoM9axlXYzfpVkt
	 an6JIpOXrA18Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C9F9681350;
	Tue,  7 Jan 2025 12:54:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C8D0C6B
 for <intel-wired-lan@lists.osuosl.org>; Tue,  7 Jan 2025 12:54:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B6B64607DB
 for <intel-wired-lan@lists.osuosl.org>; Tue,  7 Jan 2025 12:54:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S5slgZhZxIbe for <intel-wired-lan@lists.osuosl.org>;
 Tue,  7 Jan 2025 12:54:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.249.212.255;
 helo=szxga08-in.huawei.com; envelope-from=linyunsheng@huawei.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 51E4B607AD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 51E4B607AD
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 51E4B607AD
 for <intel-wired-lan@lists.osuosl.org>; Tue,  7 Jan 2025 12:54:45 +0000 (UTC)
Received: from mail.maildlp.com (unknown [172.19.88.194])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4YS9rx0bFCz1W338;
 Tue,  7 Jan 2025 20:50:57 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
 by mail.maildlp.com (Postfix) with ESMTPS id AF9FA140137;
 Tue,  7 Jan 2025 20:54:37 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 7 Jan 2025 20:54:37 +0800
Message-ID: <561e07c0-98ba-44ee-abda-778b12438df6@huawei.com>
Date: Tue, 7 Jan 2025 20:54:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <liuyonglong@huawei.com>,
 <fanghaiqing@huawei.com>, <zhangkun09@huawei.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Robin Murphy <robin.murphy@arm.com>,
 Alexander Duyck <alexander.duyck@gmail.com>, Andrew Morton
 <akpm@linux-foundation.org>, IOMMU <iommu@lists.linux.dev>, MM
 <linux-mm@kvack.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, <netdev@vger.kernel.org>,
 <intel-wired-lan@lists.osuosl.org>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-mediatek@lists.infradead.org>
References: <20250106130116.457938-1-linyunsheng@huawei.com>
 <20250106155154.7c349c67@kernel.org>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <20250106155154.7c349c67@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.120.129]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf200006.china.huawei.com (7.185.36.61)
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=huawei.com
Subject: Re: [Intel-wired-lan] [PATCH net-next v6 0/8] fix two bugs related
 to page_pool
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On 2025/1/7 7:51, Jakub Kicinski wrote:
> On Mon, 6 Jan 2025 21:01:08 +0800 Yunsheng Lin wrote:
>> This patchset fix a possible time window problem for page_pool and
>> the dma API misuse problem as mentioned in [1], and try to avoid the
>> overhead of the fixing using some optimization.
>>
>> From the below performance data, the overhead is not so obvious
>> due to performance variations for time_bench_page_pool01_fast_path()
>> and time_bench_page_pool02_ptr_ring, and there is about 20ns overhead
>> for time_bench_page_pool03_slow() for fixing the bug.
> 
> This appears to make the selftest from the drivers/net target implode.
> 
> [   20.227775][  T218] BUG: KASAN: use-after-free in page_pool_item_uninit+0x100/0x130
> 
> Running the ping.py tests should be enough to repro.

Thanks for reminding.
Something like below seems to fix the use-after-free bug, will enable more
DEBUG config when doing testing.

--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -518,9 +518,13 @@ static void page_pool_items_unmap(struct page_pool *pool)

 static void page_pool_item_uninit(struct page_pool *pool)
 {
-       struct page_pool_item_block *block;
+       while (!list_empty(&pool->item_blocks)) {
+               struct page_pool_item_block *block;

-       list_for_each_entry(block, &pool->item_blocks, list) {
+               block = list_first_entry(&pool->item_blocks,
+                                        struct page_pool_item_block,
+                                        list);
+               list_del(&block->list);
                WARN_ON(refcount_read(&block->ref));
                put_page(virt_to_page(block));
        }

