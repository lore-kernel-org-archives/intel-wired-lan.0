Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F10C77B75
	for <intel-wired-lan@archiver.kernel.org>; Mon, 22 May 2023 15:27:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C893183B9C;
	Mon, 22 May 2023 15:27:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C893183B9C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1684769263;
	bh=1ob8RDsPFq/UzwnghT9QiASQ+cYBV0YJ9k3f3r+voYk=;
	h=References:In-Reply-To:From:Date:To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=2nz+mHwtJob9b234LquUCmGR3pkgLY7pNwL24U8UvTOeBUWfBaFtX9fTG/ceyLJyj
	 NP3tALnA8wpz1nNTPrw4woDgfGYKqFxg01i1o9lcVsoqkMfAXj57joXdnFMluHonHc
	 oQFXHaAvoDcE57J84r+JwJliOEGA2iabbQb1DHOY2oYSzWXHvEsX0eLHWM0+L4/pk7
	 qwMgEyWMVZpk2Yp0C/n2LTlpEHKZqUhJt5Hh6ZcDU1MHdoh0X/HuIVtCzlIUu9SmVd
	 7fWQX+QQvK2BV0hf7um5zOi70QF/NLSQA2RWxRpQ4MCgrxoYAdnTQYHdMmexMUJE8g
	 CERnsYPALP2YQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lbgyu7db1F6G; Mon, 22 May 2023 15:27:43 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id DB0F083BAB;
	Mon, 22 May 2023 15:27:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DB0F083BAB
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 70E0E1BF393
 for <intel-wired-lan@lists.osuosl.org>; Mon, 22 May 2023 15:27:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4444160F17
 for <intel-wired-lan@lists.osuosl.org>; Mon, 22 May 2023 15:27:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4444160F17
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f2lJvO9IIXGi for <intel-wired-lan@lists.osuosl.org>;
 Mon, 22 May 2023 15:27:40 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 148DD60F13
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 148DD60F13
 for <intel-wired-lan@lists.osuosl.org>; Mon, 22 May 2023 15:27:40 +0000 (UTC)
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-62382e20dc6so9714416d6.1
 for <intel-wired-lan@lists.osuosl.org>; Mon, 22 May 2023 08:27:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684769259; x=1687361259;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xa/ua3ow8lJkwBDnoTBS0dJRU1AVeGtz9D7HTeSun6k=;
 b=KEMblsdhJWqNBxlI7Pca1HhGffKL0H4E5a/z36fKVlNo0IUedxIYsjXj/3miIndAvc
 vqmv2fhLMGvr+KHuc7Tl79zhjLv1PH035YWWGFZg6vbNlH5Z33KkT5ayB+Nfn3Utqe+C
 I/ZUuoqwbVnA29qeZ3lBvEQevGy6HqYWeakow81CjS5m/9oIXoV5b++ZaoUuNvtIl8lv
 3MdWBqp4M07BdB267JFYd5yQgy2Esg/csJ/5NSSEcubuusjHui5DeMHk84+Rxz2oej+H
 nriGkX6zit25KfrdIPT3rbvOETDX92CZVghVTTQZVx/WhAXKRBBnFB0MYrbUVfX7J+U9
 KEOA==
X-Gm-Message-State: AC+VfDz6PxrqY/WqC2uH57rtU0JSx+bxfO1gY5xJVjRHUrhSvSa+3xdn
 Rqq8dOJn7zLBh+ikSwBZK1s4c3274ENkMO67e0Q=
X-Google-Smtp-Source: ACHHUZ5KYk+as52iODE4Sis2n+4GA/Rz8Y5VlAKTZhpWxv00l5E83NNoKzGzMtgFmDk+iN7tIl2rf9g82wiLbors6EY=
X-Received: by 2002:ad4:574f:0:b0:61b:73b2:85ca with SMTP id
 q15-20020ad4574f000000b0061b73b285camr18600992qvx.5.1684769258852; Mon, 22
 May 2023 08:27:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230516161841.37138-1-aleksander.lobakin@intel.com>
 <20230516161841.37138-8-aleksander.lobakin@intel.com>
 <20230517211211.1d1bbd0b@kernel.org>
 <9feef136-7ff3-91a4-4198-237b07a91c0c@intel.com>
 <20230518075643.3a242837@kernel.org>
 <0dfa36f1-a847-739e-4557-fc43e2e8c6a7@intel.com>
 <20230518133627.72747418@kernel.org>
 <77d929b2-c124-d3db-1cd9-8301d1d269d3@intel.com>
 <20230519134545.5807e1d8@kernel.org>
 <5effd41a-81c3-4815-826d-ba5d8f6c69b4@intel.com>
In-Reply-To: <5effd41a-81c3-4815-826d-ba5d8f6c69b4@intel.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Mon, 22 May 2023 17:27:27 +0200
Message-ID: <CAJ8uoz30j7axJ+jd4UC4v57SBBBExbshQk7EZo-+bvPHOmcbSw@mail.gmail.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684769259; x=1687361259;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xa/ua3ow8lJkwBDnoTBS0dJRU1AVeGtz9D7HTeSun6k=;
 b=ECnG3apANojL8aEfq5G+Ik1+yG9BwL936d4N4e4AQstLABStMolNIBU2nwk4e609mv
 IwuHKuX35pAiRbr3tk9wQDLAxvJMRHYn1LziG7VldDjvPIhJSE+YUk9LM621zC2bvJQ9
 mgRwVWxH/xJ1zq7atFzjbsv/qi/D5hPFaFQruTeGdLNzl58jlwlJHM7CISzvH6/eznwM
 XCYntLzDYWGw8CJmc+fLxoMsPb6xH9HrR5a+R69m/DQT+BJV4MnKWGMOVzYowQ8AvqTG
 RVqH4t4/g9x9ClgRAlX4F33UzlJFZE+wcqmIvcD9S+8tPdnrgqQE6ve2wgBZ+3tXuToW
 jbuA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20221208 header.b=ECnG3apA
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
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Christoph Hellwig <hch@lst.de>, Magnus Karlsson <magnus.karlsson@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Mon, 22 May 2023 at 15:50, Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Jakub Kicinski <kuba@kernel.org>
> Date: Fri, 19 May 2023 13:45:45 -0700
>
> > On Fri, 19 May 2023 15:56:40 +0200 Alexander Lobakin wrote:
> >> From: Jakub Kicinski <kuba@kernel.org>
> >> Date: Thu, 18 May 2023 13:36:27 -0700
>
> [...]
>
> > Ack, not saying that we need to split now, it's just about the naming
> > (everyone's favorite topic).
> >
> > I think that it's a touch weird to name the header _drv.h and then
> > include it in the core in multiple places (*cough* xdp_sock_drv.h).
>
> Hahaha, I also thought of it :>

Haha! Point taken. Will clear it up.

> > Also If someone needs to add another "heavy" static line for use by
> > the core they will try to put it in page_pool.h rather than _drv.h...
> >
> > I'd rather split the includes by the basic language-level contents,
> > first, then by the intended consumer, only if necessary. Language
> > level sorting require less thinking :)
> >
> > But none of this is important, if you don't wanna to do it, just keep
> > the new helpers in page_pool.h (let's not do another _drv.h).
>
> Ack, will just put there. It doesn't get included by the whole kernel
> via skbuff.h anymore (in v2), so new inlines won't hurt.
>
> Thanks,
> Olek
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan@osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
