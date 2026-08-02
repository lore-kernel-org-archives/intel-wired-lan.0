Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 547C3C55171
	for <intel-wired-lan@archiver.kernel.org>; Sun,  2 Aug 2026 13:02:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E4DE480CDE;
	Sun,  2 Aug 2026 13:02:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WKklvyF2sE9a; Sun,  2 Aug 2026 13:02:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CD08F80CD8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785675743;
	bh=8iMyqX02UpaRW22lYJcpZBjOPaw1gu+3hlWoNXP5tP0=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gm+4VXsVPaRCPxDIAWhICAWqGW4Eh5CavhP4A2TfF7pnHSvYFPcEBOyJ9ABvQ8U8N
	 aqTU1Z/X3G8n1k9z2mLFXe1GJEbIqAkKTPPyxe5abUJhWNCXu9NTPC4Fg08qQqDNS/
	 6B0HX4LaSewjnM9C4jqbNJKZlAta6f52lS5axYgqea84UBlyIBChvDXK+hR1OYSQcz
	 VI/xDzcbLkKlqXgdAURJP1EM6VaZxFBBPERqt1PXgz3CQoaocaf6ZEOjwA/nwZ0RKD
	 XHrSDvEE+sg5cuTdB1uyKnr/rfB62+hcYwnUtozzK2r6QfFvbYvmA64cza6DlYdzuG
	 AxS0J52OFOXXw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CD08F80CD8;
	Sun,  2 Aug 2026 13:02:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B123C389
 for <intel-wired-lan@lists.osuosl.org>; Sun,  2 Aug 2026 13:02:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 96EF74061B
 for <intel-wired-lan@lists.osuosl.org>; Sun,  2 Aug 2026 13:02:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MqAWjzANoMqm for <intel-wired-lan@lists.osuosl.org>;
 Sun,  2 Aug 2026 13:02:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com;
 envelope-from=asml.silence@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org EB2B9405BA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EB2B9405BA
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EB2B9405BA
 for <intel-wired-lan@lists.osuosl.org>; Sun,  2 Aug 2026 13:02:21 +0000 (UTC)
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-848595b338cso3170940b3a.0
 for <intel-wired-lan@lists.osuosl.org>; Sun, 02 Aug 2026 06:02:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785675741; x=1786280541;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8iMyqX02UpaRW22lYJcpZBjOPaw1gu+3hlWoNXP5tP0=;
 b=WG1tUqj2JpoDOcEYAozc/ln3fl2CLgUNWs0CFNUoOxx9tM12bcB1CIOTs7N99SDc7k
 7HsTFED9PeMYeUxf3HKm/xaUTKpVeckh/bGAonVNnEvy8Mo+EyVILk8NDrAI7Uc/4uaU
 xt9vQZPRzw8x4YifNAIuLUw8thERTBU68DRZutMJUF2w1jxbf86n0ApbKNIKgeficZO8
 nbp8E7ml0PFZwplIQ+MWB2CKE6EoY2Av26t3nOwKV91GE41OCKiQr7jdho216mRQmDrs
 KhbeBPVGNwOoEMPkXgNTtW8yweepGafj50dOCfkBiV2iUoJwVR/lE8qWRYbPrCpxSi4X
 vGwQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpdKAX6TJAls551bl33z87TjmZDat/EJ79lOK+YZ4asayg7BshZ5R7W3q/T66CUu0WsP+RN2VVIzUhhKoKIins=@lists.osuosl.org
X-Gm-Message-State: AOJu0YyrAw06wrOR+bhzSbRVrNDTwLvd/qXOFLuAFkmL+/1f0PKSHx4s
 ITyUgwFDcKw0SnyAQLlP5omqqnAqau/gXFQstNy6mDdgdbmI+o0rNWKU
X-Gm-Gg: AR+sD111AiTjSfanfJ2Bj8citvgZZjXThrtp6ZviUF9iNjPtroBwC1SpGlNDZYY3ZHm
 HuHrPb/gfuO11ffAXflFqjbPL9ODnQ+3zDKOa8i7PVPApd8erRJS6Jq3bKMPvz5iRn0Rp450I9K
 4dZu5iGIu99Qo1HCZsJ0M44qERXQB3SJmdO0KSh3jYk5uZbH7aqq9grF7Nbu5tqFSPkd70etHBN
 h4b/XVRG4eOUa1MAEEE2Azol6Epp/NjJIocrdC5PMV0UQn9uGTZWTRoDmZPeC1CUIyby2Oz9K9L
 KRl7x0224sn5JbWkgSyxsSACwp8xSP4Tt/rEwBTO/xbQTp1/V7hQbnzvcxkGgX9Q7Zm3rKO1VQx
 rmfdGCUBzAxAjiGbSRlK0zZ2NDB4m1eblk7fsZs3tJYWMjftzZSo1Wb8OaFvnjsHUFg34ELX8Gx
 m/WRjiC9UiRMyGZ6VBlT4bVQICVQkbpV1kMd9ojiYXEKjC1DF02TCy3LjXqhjLtyedIeKm8LuqH
 EIuAksCRKxC4XOZXiDbgya4Pr/f6mqT9FiqF5pLzwZy3MsInKDi7GUm60PBpBSJXucm9KENN0CU
 /4FJ9hc5x7t+z33LbGYG2Vc25DXI4DI=
X-Received: by 2002:a05:6300:624b:b0:3c0:9c18:d5ad with SMTP id
 adf61e73a8af0-3c92a8f32b7mr6361782637.74.1785675741018; 
 Sun, 02 Aug 2026 06:02:21 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87?
 ([2620:10d:c092:600::1:b123]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbe3963ddc3sm2531160a12.7.2026.08.02.06.02.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Aug 2026 06:02:19 -0700 (PDT)
Message-ID: <7dfde9fc-63d0-4ff9-8c59-63af279cf85e@gmail.com>
Date: Sun, 2 Aug 2026 14:02:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Alexander Lobakin <aleksander.lobakin@intel.com>,
 intel-wired-lan@lists.osuosl.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Kohei Enju <kohei@enjuk.jp>,
 Jacob Keller <jacob.e.keller@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 nxne.cnse.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260505152923.1040589-1-aleksander.lobakin@intel.com>
 <20260505152923.1040589-3-aleksander.lobakin@intel.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260505152923.1040589-3-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785675741; x=1786280541; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8iMyqX02UpaRW22lYJcpZBjOPaw1gu+3hlWoNXP5tP0=;
 b=W+sklTLT4Y/dcl1TlhG1mLwkXl+j2hjJIYXlcUXGw3c43dOXGNs/S8KaNWxxp/Gz9Z
 TvzQUmFgtn0NJ8oDVFiQUn3XT1mscRhI8vqRsM0HYgoB99CmkvjSKC9wz+UImKEutBne
 R0tkATtxpFwJMOtW9MwT3KC6DblreRT3Msr9oravWYxF8Ltw5car3nTuIplkCz2hFF79
 kmj8jB6uohnx4N3Rg+PjybQx1RGCC5FAuBwr8B2V3I623ja3umEeEfIr/wvsjVMN6swM
 qK26xlIvD2UJV2i13y7Bwp5JvPPmo3kwJnGb5tcpZmMtvNAzjs7NNbUjLA+pVtSC6qXT
 bMGg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=W+sklTLT
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v5 2/5] libeth: handle
 creating pools with unreadable buffers
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

On 5/5/26 16:29, Alexander Lobakin wrote:
> libeth uses netmems for quite some time already, so in order to
> support unreadable frags / memory providers, it only needs to set
> PP_FLAG_ALLOW_UNREADABLE_NETMEM when needed.
> Also add a couple sanity checks to make sure the driver didn't mess
> up the configuration options and, in case when an MP is installed,
> return the truesize always equal to PAGE_SIZE, so that
> libeth_rx_alloc() will never try to allocate frags. Memory providers
> manage buffers on their own and expect 1:1 buffer / HW Rx descriptor
> association.

Maybe I'm misreading it, but providers don't expect that. It's
fine to use page_pool_alloc_frag_netmem() and friends, just like
bnxt and other drivers do. net_iovs are refcounted in the same
way as normal pages. Hope it helps.

-- 
Pavel Begunkov

