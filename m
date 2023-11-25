Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91275C61D9D
	for <intel-wired-lan@archiver.kernel.org>; Sat, 25 Nov 2023 12:49:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 29F7B4037C;
	Sat, 25 Nov 2023 12:49:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 29F7B4037C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1700916564;
	bh=NmkMGKCriPhi/yuWsagInBKUtRKmVIBgcVfze/vRSTk=;
	h=To:References:From:Date:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=sW4szLVfMfbgIOc2v8yc6ZDMJa1NX55bHk3pCuVjLxekWvFKio3bufpccpeMCK4pE
	 IJ7H+LukvHwFNJ8cIvkhH0n3dAwV/XwSVrTnCItx81FsqaNpOzwxUdbpPXj1x7PnUW
	 D9+mpX4zYtYOmbUl7e5f/7Tc8csnJCX4vwSQbcPKlPbUu8dFF3Xak1+qFo/D7SOC0x
	 2r3/CqXwFpMIoTOVPGTCQrR5H0LFjf7B8rOvxBYPWu1xMJTgzKKUIdtdKJoY5iTmS7
	 e2Z1XU2hyw3sWjG3Xubmv8HJME1RYMk3SZtah46CJSKQIMmMLJPK3iY3fZ/PbDqvHx
	 NrRaMcpMfHS7A==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TYU_S4bDrmRQ; Sat, 25 Nov 2023 12:49:23 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id DDDE44037E;
	Sat, 25 Nov 2023 12:49:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DDDE44037E
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 7181D1BF487
 for <intel-wired-lan@lists.osuosl.org>; Sat, 25 Nov 2023 12:49:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 493D560B69
 for <intel-wired-lan@lists.osuosl.org>; Sat, 25 Nov 2023 12:49:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 493D560B69
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4lY9hfmyBJDi for <intel-wired-lan@lists.osuosl.org>;
 Sat, 25 Nov 2023 12:49:20 +0000 (UTC)
X-Greylist: delayed 1192 seconds by postgrey-1.37 at util1.osuosl.org;
 Sat, 25 Nov 2023 12:49:19 UTC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A70B360B29
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A70B360B29
 for <intel-wired-lan@lists.osuosl.org>; Sat, 25 Nov 2023 12:49:19 +0000 (UTC)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.53])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4ScrdJ16N2zMnKp;
 Sat, 25 Nov 2023 20:24:36 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sat, 25 Nov
 2023 20:29:22 +0800
To: Alexander Lobakin <aleksander.lobakin@intel.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20231124154732.1623518-1-aleksander.lobakin@intel.com>
 <20231124154732.1623518-2-aleksander.lobakin@intel.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <9902d1c4-5e51-551a-3b66-c078c217c5ad@huawei.com>
Date: Sat, 25 Nov 2023 20:29:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20231124154732.1623518-2-aleksander.lobakin@intel.com>
Content-Language: en-US
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
Subject: Re: [Intel-wired-lan] [PATCH net-next v5 01/14] page_pool: make
 sure frag API fields don't span between cachelines
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

On 2023/11/24 23:47, Alexander Lobakin wrote:
> After commit 5027ec19f104 ("net: page_pool: split the page_pool_params
> into fast and slow") that made &page_pool contain only "hot" params at
> the start, cacheline boundary chops frag API fields group in the middle
> again.
> To not bother with this each time fast params get expanded or shrunk,
> let's just align them to `4 * sizeof(long)`, the closest upper pow-2 to
> their actual size (2 longs + 2 ints). This ensures 16-byte alignment for
> the 32-bit architectures and 32-byte alignment for the 64-bit ones,
> excluding unnecessary false-sharing.
> 
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  include/net/page_pool/types.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
> index e1bb92c192de..989d07b831fc 100644
> --- a/include/net/page_pool/types.h
> +++ b/include/net/page_pool/types.h
> @@ -127,7 +127,7 @@ struct page_pool {
>  
>  	bool has_init_callback;

It seems odd to have only a slow field between tow fast
field group, isn't it better to move it to the end of
page_pool or where is more appropriate?

>  
> -	long frag_users;
> +	long frag_users __aligned(4 * sizeof(long));

If we need that, why not just use '____cacheline_aligned_in_smp'?

>  	struct page *frag_page;
>  	unsigned int frag_offset;
>  	u32 pages_state_hold_cnt;
> 
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
