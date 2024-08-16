Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08402C3DA4A
	for <intel-wired-lan@archiver.kernel.org>; Fri, 16 Aug 2024 11:55:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8FF3E412F0;
	Fri, 16 Aug 2024 11:55:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q-qgrbkQ9FT8; Fri, 16 Aug 2024 11:55:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5A64A40874
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1723809329;
	bh=6MF+Hys4URJmfz1fejfZxR/uz81I1wSZn2lhLw7Q2dA=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=0E2cEAcnFTKUMYQaBOUJrL/Xmr3ETJYE8xXQdOD2c4pesgJNYzBB8DJ8WGjy0YB3p
	 enpRxCbnqnkh1R3fRsCED7jsj/ju5VC6aXB8mnxQBFDB1T+MvShGGBPwN6veKyyw2f
	 h0OEH5Wlqnu7Yr/mvTifX6Q9Zw91hL1DN5Trp/562PKQkqPeRb0a7PN6c3lCDJz/yF
	 6tq1b8X4U6YoWfjG/2J3YOuxKLDZSHsCVUsuZn88T5Yp9ggRKNb14CWvJZ5mFHXWkk
	 2+C7HKPsQCpbnsZwMhnt0kXWDy/455XLiw0vIlaX/C0LulMx2IdFinqBwrIYQz3b4Y
	 zJT8rSLh5DfDg==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5A64A40874;
	Fri, 16 Aug 2024 11:55:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 0E0031BF38E
 for <intel-wired-lan@lists.osuosl.org>; Fri, 16 Aug 2024 11:55:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EEA9880DEE
 for <intel-wired-lan@lists.osuosl.org>; Fri, 16 Aug 2024 11:55:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tjqAFkZqR6aD for <intel-wired-lan@lists.osuosl.org>;
 Fri, 16 Aug 2024 11:55:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.249.212.187;
 helo=szxga01-in.huawei.com; envelope-from=linyunsheng@huawei.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 0957380DE8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0957380DE8
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0957380DE8
 for <intel-wired-lan@lists.osuosl.org>; Fri, 16 Aug 2024 11:55:24 +0000 (UTC)
Received: from mail.maildlp.com (unknown [172.19.163.174])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WlgQt2dSLzcdVh;
 Fri, 16 Aug 2024 19:55:02 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
 by mail.maildlp.com (Postfix) with ESMTPS id 879EA1403D5;
 Fri, 16 Aug 2024 19:55:19 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 16 Aug 2024 19:55:18 +0800
Message-ID: <3e069c81-a728-4d72-a5bb-3be00d182107@huawei.com>
Date: Fri, 16 Aug 2024 19:55:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Alexander Duyck <alexander.duyck@gmail.com>
References: <20240808123714.462740-1-linyunsheng@huawei.com>
 <20240808123714.462740-5-linyunsheng@huawei.com>
 <d1a23116d054e2ebb00067227f0cffecefe33e11.camel@gmail.com>
 <676a2a15-d390-48a7-a8d7-6e491c89e200@huawei.com>
 <CAKgT0Uct5ptfs9ZEoe-9u-fOVz4HLf+5MS-YidKV+xELCBHKNw@mail.gmail.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <CAKgT0Uct5ptfs9ZEoe-9u-fOVz4HLf+5MS-YidKV+xELCBHKNw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.120.129]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf200006.china.huawei.com (7.185.36.61)
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=huawei.com
Subject: Re: [Intel-wired-lan] [PATCH net-next v13 04/14] mm: page_frag: add
 '_va' suffix to page_frag API
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
Cc: Yonghong Song <yonghong.song@linux.dev>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Neil Brown <neilb@suse.de>,
 Jason Wang <jasowang@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 linux-nvme@lists.infradead.org, Dai Ngo <Dai.Ngo@oracle.com>,
 David Howells <dhowells@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Subbaraya Sundeep <sbhatta@marvell.com>,
 Marc Dionne <marc.dionne@auristor.com>, Shuah Khan <shuah@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Anna Schumaker <anna@kernel.org>,
 Jeroen de Borst <jeroendb@google.com>, Sagi Grimberg <sagi@grimberg.me>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 linux-afs@lists.infradead.org,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Stanislav Fomichev <sdf@fomichev.me>, intel-wired-lan@lists.osuosl.org,
 Olga Kornievskaia <kolga@netapp.com>, kuba@kernel.org, pabeni@redhat.com,
 Lorenzo Bianconi <lorenzo@kernel.org>, Mark Lee <Mark-MC.Lee@mediatek.com>,
 Sunil Goutham <sgoutham@marvell.com>, linux-kselftest@vger.kernel.org,
 Chaitanya Kulkarni <kch@nvidia.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Sean Wang <sean.wang@mediatek.com>, virtualization@lists.linux.dev,
 KP Singh <kpsingh@kernel.org>, Tom Talpey <tom@talpey.com>,
 Shailend Chand <shailend@google.com>, linux-mediatek@lists.infradead.org,
 linux-mm@kvack.org, Matthias Brugger <matthias.bgg@gmail.com>,
 bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Jens Axboe <axboe@kernel.dk>, Hao Luo <haoluo@google.com>,
 linux-nfs@vger.kernel.org, Song Liu <song@kernel.org>, netdev@vger.kernel.org,
 Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org,
 davem@davemloft.net, Eduard Zingerman <eddyz87@gmail.com>,
 hariprasad <hkelam@marvell.com>, Chuck Lever <chuck.lever@oracle.com>,
 Jiri Olsa <jolsa@kernel.org>, Praveen Kaligineedi <pkaligineedi@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Geetha sowjanya <gakula@marvell.com>,
 Trond Myklebust <trondmy@kernel.org>, Felix Fietkau <nbd@nbd.name>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On 2024/8/15 23:00, Alexander Duyck wrote:
> On Wed, Aug 14, 2024 at 8:00 PM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>
>> On 2024/8/14 23:49, Alexander H Duyck wrote:
>>> On Thu, 2024-08-08 at 20:37 +0800, Yunsheng Lin wrote:
>>>> Currently the page_frag API is returning 'virtual address'
>>>> or 'va' when allocing and expecting 'virtual address' or
>>>> 'va' as input when freeing.
>>>>
>>>> As we are about to support new use cases that the caller
>>>> need to deal with 'struct page' or need to deal with both
>>>> 'va' and 'struct page'. In order to differentiate the API
>>>> handling between 'va' and 'struct page', add '_va' suffix
>>>> to the corresponding API mirroring the page_pool_alloc_va()
>>>> API of the page_pool. So that callers expecting to deal with
>>>> va, page or both va and page may call page_frag_alloc_va*,
>>>> page_frag_alloc_pg*, or page_frag_alloc* API accordingly.
>>>>
>>>> CC: Alexander Duyck <alexander.duyck@gmail.com>
>>>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
>>>> Reviewed-by: Subbaraya Sundeep <sbhatta@marvell.com>
>>>> Acked-by: Chuck Lever <chuck.lever@oracle.com>
>>>> Acked-by: Sagi Grimberg <sagi@grimberg.me>
>>>> ---
>>>>  drivers/net/ethernet/google/gve/gve_rx.c      |  4 ++--
>>>>  drivers/net/ethernet/intel/ice/ice_txrx.c     |  2 +-
>>>>  drivers/net/ethernet/intel/ice/ice_txrx.h     |  2 +-
>>>>  drivers/net/ethernet/intel/ice/ice_txrx_lib.c |  2 +-
>>>>  .../net/ethernet/intel/ixgbevf/ixgbevf_main.c |  4 ++--
>>>>  .../marvell/octeontx2/nic/otx2_common.c       |  2 +-
>>>>  drivers/net/ethernet/mediatek/mtk_wed_wo.c    |  4 ++--
>>>>  drivers/nvme/host/tcp.c                       |  8 +++----
>>>>  drivers/nvme/target/tcp.c                     | 22 +++++++++----------
>>>>  drivers/vhost/net.c                           |  6 ++---
>>>>  include/linux/page_frag_cache.h               | 21 +++++++++---------
>>>>  include/linux/skbuff.h                        |  2 +-
>>>>  kernel/bpf/cpumap.c                           |  2 +-
>>>>  mm/page_frag_cache.c                          | 12 +++++-----
>>>>  net/core/skbuff.c                             | 16 +++++++-------
>>>>  net/core/xdp.c                                |  2 +-
>>>>  net/rxrpc/txbuf.c                             | 15 +++++++------
>>>>  net/sunrpc/svcsock.c                          |  6 ++---
>>>>  .../selftests/mm/page_frag/page_frag_test.c   | 13 ++++++-----
>>>>  19 files changed, 75 insertions(+), 70 deletions(-)
>>>>
>>>
>>> I still say no to this patch. It is an unnecessary name change and adds
>>> no value. If you insist on this patch I will reject the set every time.
>>>
>>> The fact is it is polluting the git history and just makes things
>>> harder to maintain without adding any value as you aren't changing what
>>> the function does and there is no need for this. In addition it just
>>
>> I guess I have to disagree with the above 'no need for this' part for
>> now, as mentioned in [1]:
>>
>> "There are three types of API as proposed in this patchset instead of
>> two types of API:
>> 1. page_frag_alloc_va() returns [va].
>> 2. page_frag_alloc_pg() returns [page, offset].
>> 3. page_frag_alloc() returns [va] & [page, offset].
>>
>> You seemed to miss that we need a third naming for the type 3 API.
>> Do you see type 3 API as a valid API? if yes, what naming are you
>> suggesting for it? if no, why it is not a valid API?"
> 
> I didn't. I just don't see the point in pushing out the existing API
> to support that. In reality 2 and 3 are redundant. You probably only
> need 3. Like I mentioned earlier you can essentially just pass a

If the caller just expect [page, offset], do you expect the caller also
type 3 API, which return both [va] and [page, offset]?

I am not sure if I understand why you think 2 and 3 are redundant here?
If you think 2 and 3 are redundant here, aren't 1 and 3 also redundant
as the similar agrument?

> page_frag via pointer to the function. With that you could also look
> at just returning a virtual address as well if you insist on having
> something that returns all of the above. No point in having 2 and 3 be
> seperate functions.

Let's be more specific about what are your suggestion here: which way
is the prefer way to return the virtual address. It seems there are two
options:

1. Return the virtual address by function returning as below:
void *page_frag_alloc_bio(struct page_frag_cache *nc, struct bio_vec *bio);

2. Return the virtual address by double pointer as below:
int page_frag_alloc_bio(struct page_frag_cache *nc, struct bio_vec *bio,
		        void **va);

If the above options is what you have in mind, please be more specific
which one is the prefer option, and why it is the prefer option.
If the above options is not what you have in mind, please list out the
declaration of API in your mind.

> 
> I am going to nack this patch set if you insist on this pointless
> renaming. The fact is it is just adding noise that adds no value.
