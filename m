Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5244AC77B7A
	for <intel-wired-lan@archiver.kernel.org>; Wed, 31 May 2023 15:21:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 006E0613DB;
	Wed, 31 May 2023 15:21:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 006E0613DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1685546474;
	bh=6iFcONYVTt/uTJ7qw+OnU1LkJAyIcHGGsaXqCQOtrQU=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=FRyLREX7+iuxKl9RrhZvCBzwWX7mLKkMrgiZm1zc/r+xYOUGlYY9sABiZ5IiIBkQW
	 2HhHohw1mh3sAYCveT03dlRqPhLy2Ap4gI4PhXahqU3NyAOnkm1CwM/vhoxa2VVBZu
	 ikWEMhf9VgPpBvGwUGwQqlhJIIH/t3lMhyr8T3flGAfMmOuAsP4MnNhYKnqYEpEFNf
	 Cbn/PCBCuVPFt3o+PFzUFgT7ssshKYo2pdpVeTQNm9iAMPq1mZwz5Xqlswyc+0+aRS
	 iMa6pEQIccV7TOkTgeK4eG1206G4wL0kfAlwIEmzIvwhuEaWdOovD+EDc+bnhi5FAc
	 Jo5mx6CAo3cxw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w_Mx3ijQYC34; Wed, 31 May 2023 15:21:13 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 35F376141F;
	Wed, 31 May 2023 15:21:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 35F376141F
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 30AF31BF5DB
 for <intel-wired-lan@lists.osuosl.org>; Wed, 31 May 2023 15:21:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0FA3B6141D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 31 May 2023 15:21:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0FA3B6141D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FojLtvhdibdn for <intel-wired-lan@lists.osuosl.org>;
 Wed, 31 May 2023 15:21:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ED6B06141A
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ED6B06141A
 for <intel-wired-lan@lists.osuosl.org>; Wed, 31 May 2023 15:21:07 +0000 (UTC)
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-64f47448aeaso4124346b3a.0
 for <intel-wired-lan@lists.osuosl.org>; Wed, 31 May 2023 08:21:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685546467; x=1688138467;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IqLBTLdww5a5qlwx/ErHlmc0YW7ggTL+TwrPcGnVcX4=;
 b=k52Ibu+OD2kgDF3cHh/6e7GOSwT3AHcc1sHeOBxAb+JXlwwWbb1SUKs1vRgZOt3hwZ
 W4e7GwZcI/LtYCXYddXHWdMB9MyOnpmOE4vgN3R5NZwujjenv8yPsVzuYOLvuHs88fhK
 aTES/i/FzthDZ9gM6epqCcOOLd0K+69QQs1DkJj9eEiQFinjrWIKNGoELmwC981Zn0rB
 Ld/oKF0/+e0+RRj4296BqAN+mzOTIpOx6IWTuGgBjwENVwef7RnC5tqwdZ/br7L5lala
 bMXnbtLcWHeqX8VrucGCR5LiwRu9iO7K261Q8y4NrpWHtIXpC6RKM63Hx6EidPbxHUeR
 QkKg==
X-Gm-Message-State: AC+VfDxNhm6iE8yxrE5vboc33c83YahG7u5NsuNvAShSx5ToDI57AxwE
 vMEIcjBSzglGygpxYqr9b00=
X-Google-Smtp-Source: ACHHUZ7qWb5EJ1Vta3RUHbsEc0FnXIcF/1yY6AZHnCnRRKEUMs+5U3MNoBrgWvAyebdKfa9LW1rKcA==
X-Received: by 2002:a05:6a20:3d89:b0:101:6a2f:2a0e with SMTP id
 s9-20020a056a203d8900b001016a2f2a0emr5629189pzi.18.1685546467120; 
 Wed, 31 May 2023 08:21:07 -0700 (PDT)
Received: from ?IPv6:2605:59c8:448:b800:82ee:73ff:fe41:9a02?
 ([2605:59c8:448:b800:82ee:73ff:fe41:9a02])
 by smtp.googlemail.com with ESMTPSA id
 k184-20020a6324c1000000b0052cbd854927sm1415909pgk.18.2023.05.31.08.21.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 May 2023 08:21:05 -0700 (PDT)
Message-ID: <81d8da838601a2029e97937a952652039285cb4e.camel@gmail.com>
From: Alexander H Duyck <alexander.duyck@gmail.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Date: Wed, 31 May 2023 08:21:03 -0700
In-Reply-To: <20230530150035.1943669-7-aleksander.lobakin@intel.com>
References: <20230530150035.1943669-1-aleksander.lobakin@intel.com>
 <20230530150035.1943669-7-aleksander.lobakin@intel.com>
User-Agent: Evolution 3.44.4 (3.44.4-3.fc36) 
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685546467; x=1688138467;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=IqLBTLdww5a5qlwx/ErHlmc0YW7ggTL+TwrPcGnVcX4=;
 b=bT1zvjsVW/ZrkiSShMdEqUra1jUkOaVgwIt/1jznhYZvXV6zCPFVA+l15MDE/OM0ZC
 QxlZ7IqcX+fbVhGL5MstdnbRIUyjoIM7ngh2tgimMtkkZcCzskyYdPxn8x2ye/n7P5pV
 j1NqLMYMliA95JkPluppdZ91Q19ncH7FWXLwLpG07jjn5BLRQFiMj5yhupdTZW+zE/2u
 3VKnEgkRQ30dkn8OxTBDhdX67TzbQrPJpL3wgQE+7SWM30Ck9HrZj8OeCZwHJFzVZjcI
 dA8ZtK3UEuGDAdo/JGD0tE0HnGC1SE2FkQUljcvAfzQwYhTKoQWTqamAY09SsK5PheSM
 anlg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20221208 header.b=bT1zvjsV
Subject: Re: [Intel-wired-lan] [PATCH net-next v3 06/12] net: skbuff: don't
 include <net/page_pool.h> into <linux/skbuff.h>
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
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, linux-kernel@vger.kernel.org,
 Michal Kubiak <michal.kubiak@intel.com>, intel-wired-lan@lists.osuosl.org,
 Christoph Hellwig <hch@lst.de>, Magnus Karlsson <magnus.karlsson@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Tue, 2023-05-30 at 17:00 +0200, Alexander Lobakin wrote:
> Currently, touching <net/page_pool.h> triggers a rebuild of more than
> a half of the kernel. That's because it's included in <linux/skbuff.h>.
> 
> In 6a5bcd84e886 ("page_pool: Allow drivers to hint on SKB recycling"),
> Matteo included it to be able to call a couple functions defined there.
> Then, in 57f05bc2ab24 ("page_pool: keep pp info as long as page pool
> owns the page") one of the calls was removed, so only one left.
> It's call to page_pool_return_skb_page() in napi_frag_unref(). The
> function is external and doesn't have any dependencies. Having include
> of very niche page_pool.h only for that looks like an overkill.
> Instead, move the declaration of that function to skbuff.h itself, with
> a small comment that it's a special guest and should not be touched.
> Now, after a few include fixes in the drivers, touching page_pool.h
> only triggers rebuilding of the drivers using it and a couple core
> networking files.
> 
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  drivers/net/ethernet/engleder/tsnep_main.c               | 1 +
>  drivers/net/ethernet/freescale/fec_main.c                | 1 +
>  drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c | 1 +
>  drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c     | 1 +
>  drivers/net/ethernet/mellanox/mlx5/core/en/params.c      | 1 +
>  drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c         | 1 +
>  drivers/net/wireless/mediatek/mt76/mt76.h                | 1 +
>  include/linux/skbuff.h                                   | 4 +++-
>  include/net/page_pool.h                                  | 2 --
>  9 files changed, 10 insertions(+), 3 deletions(-)
> 
> 

<...>

> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 5951904413ab..6d5eee932b95 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -32,7 +32,6 @@
>  #include <linux/if_packet.h>
>  #include <linux/llist.h>
>  #include <net/flow.h>
> -#include <net/page_pool.h>
>  #if IS_ENABLED(CONFIG_NF_CONNTRACK)
>  #include <linux/netfilter/nf_conntrack_common.h>
>  #endif
> @@ -3422,6 +3421,9 @@ static inline void skb_frag_ref(struct sk_buff *skb, int f)
>  	__skb_frag_ref(&skb_shinfo(skb)->frags[f]);
>  }
>  
> +/* Internal from net/core/page_pool.c, do not use in drivers directly */
> +bool page_pool_return_skb_page(struct page *page, bool napi_safe);
> +
>  static inline void
>  napi_frag_unref(skb_frag_t *frag, bool recycle, bool napi_safe)
>  {
> diff --git a/include/net/page_pool.h b/include/net/page_pool.h
> index 126f9e294389..2a9ce2aa6eb2 100644
> --- a/include/net/page_pool.h
> +++ b/include/net/page_pool.h
> @@ -240,8 +240,6 @@ inline enum dma_data_direction page_pool_get_dma_dir(struct page_pool *pool)
>  	return pool->p.dma_dir;
>  }
>  
> -bool page_pool_return_skb_page(struct page *page, bool napi_safe);
> -
>  struct page_pool *page_pool_create(const struct page_pool_params *params);
>  
>  struct xdp_mem_info;

So the code as-is works, so I am providing my "Reviewed-by".
Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>

Consider the rest of this a suggestion or a "nice to have".

I wonder if we shouldn't also look at restructuring the function and
just moving it to net/core/skbuff.c somewhere next to skb_pp_recycle.

I suspect we could look at pulling parts of it out as well. The
pp_magic check should always be succeeding unless we have pages getting
routed the wrong way somewhere. So maybe we should look at pulling it
out and moving it to another part of the path such as
__page_pool_put_page() and making it a bit more visible to catch those
cases.
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
