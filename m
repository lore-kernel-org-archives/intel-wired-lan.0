Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2AB2C88E6F
	for <intel-wired-lan@archiver.kernel.org>; Mon, 14 Sep 2026 17:20:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 79DCA80E14;
	Mon, 14 Sep 2026 17:20:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vQIHAdMohXWG; Mon, 14 Sep 2026 17:20:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org EBB2680DC5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789406431;
	b=p22CefYi28Gr5PdOc7GNi+ZGQQOrxp99k+41HFb48gRWoYPsMLXHn2BJDDYfdZ9CWwqy
	 QnO8bTCyqrz0YhtXYYIH+KWsLp5wTA0c7JmYFwUj22d91ArRNQfFhaLU3Okz8cyy6XqES
	 nKTx0coVkUgkYN7I4JYoF823VMkrFx62jd1WpHekRPkXZhP2edNZN8F829p/QxjCR6nlY
	 s90M7TLUuOzULurkOJI8hw2XJZ3zgK8sDD6LRzbceFTXVXxjIL4QyBeb8zGY+YKinyIX5
	 xYGzyamU1wNpI7Bwv/mdhnFnQ/K/5u+fNyWZS9IxFTzGCIawfP1Z96xognbBt4zpPhg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789406431;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=L/2mUsKjcaJbKckiFuEIeCMG6ptMUuWX6YPpy3IoNEs=;
	b=SBmE57515NTPQqS4MFy0vpvCK2he6Y/lfpUVLjZ9jiCnhudB0jLxi/OvB0UYM4IG3oQC
	 tX52dOvko51ludM1QBztdjzZEcVfhaHuh0rKYmUDhYKomoNvdsrPGyYAdYdQ1Bl27UYSq
	 TDjO6T4MumzEuJY/8LRnN7hgv30+uS3bctdcw66/DIKt9LIYmvcC+2ccvgqRrjm1gSm1E
	 9x62QMI5tXCJmKHdMu5/gSopdAXIBFoqkpomqfXWU+GF5cLHXxYw5ET8kZ312eWeWuVob
	 1tRDF3AT2qiaHsSS2g6yqqZ3TxDR6KLSKAQkEPYpnzI0d+Ikyo6YxTlbeQ/tzgx/3Hg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789406431;
	bh=L/2mUsKjcaJbKckiFuEIeCMG6ptMUuWX6YPpy3IoNEs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cJvmU5EQBn/0CQisSNqrdxcbikKFLTh5boOBWuxY5DGZk6vOu5sabd2yIc2lxHZzi
	 RzjxdCBzUVr7ck4mD2BWK6GtNR7t1SRL7Apa+lXkYJoMKnjuvZEvoRzJq3uJ1UIrMc
	 gnExXJvE7DboIqnUP7ykbKJzncERjOpC1TV5HVozHs7D54h4kbvpbJN4bjjS8fC6Dl
	 zK4Cd5VPHVtrOPtxElr+n8rF/AZDJSZw0i7dxxKXVT0hg2oNbbG1ak7kGKFrdnq6Ke
	 UXMDsPWg6LUL7HIGYRfNgiR+Cv2qgi7pXEy2cXwSUoTtz6A10hkRJuHrLDj6abvNWb
	 YddFosVyZjTXw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EBB2680DC5;
	Mon, 14 Sep 2026 17:20:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 61CB3259
 for <intel-wired-lan@lists.osuosl.org>; Mon, 14 Sep 2026 17:20:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4708F405CC
 for <intel-wired-lan@lists.osuosl.org>; Mon, 14 Sep 2026 17:20:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wYXsKcyrU7m0 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 14 Sep 2026 17:20:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 85E4C405C4
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789406428;
 b=XaZDBU13UBwRObbBgGY2XJZTL5qgDUy4EO5V64MtOkaOSj76qYHMrYJd6rVX9TMIBkww
 QElUyECFpiaGNwf2qY/qqwpY1qtxz33Zl6o3eR+cX/3+R2gW2RcAzUdwqLR5NPuK0v34T
 vOejCYmzN93g1QCkjya4x/3KSn92FOagLC+1K9DjTaWR4B/Qci+CEbN45cvTIkh7ZGf7f
 MIyFx3389JIk8Va3gntsgVbiWYxTjMs/kM1bFQ+V3twlJmfuYVnDrYihNorwoXfhlUuYw
 J5I9Qa/xRpetLhF2GUWigFv/dtjOsRdMEgKXsiFktIRjGYYJLU0nX4GD0RS8HXfj3bA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789406428;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=L/2mUsKjcaJbKckiFuEIeCMG6ptMUuWX6YPpy3IoNEs=;
 b=jYRY+lrZRet5RApjP8FxvE3nUCDIzlIcJBo51ZPSeYV34kwS+c+E2OL7E3y8YJVdS2lU
 346CS2rCg7Oxp2tTsTV+HNM1dzf1IerF9qCxoEWMqofS0LJKrXxWjthP8/IDA2Ohc7tbg
 pqRfIJ+zqp9M9Ir0haa7JAPg7u6z0+6kl4x+2Iy9JbdUNcN0Bviv+S8jI683PEMgy8PJi
 AA76+cYL2gAzNzPjWCzM27jH6LZvGcekKh81MtI/T0sR90PgqYmpx0+bCIM5a/90bzR0f
 YIhyEE6bf6CvmKZRvYgV8I2+FH2k5h1aBKWdLEVvzoZ0SI7Q07gCJIOtI+1qL6MgdIg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=infradead.org; 
 dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=bombadil.20210309 header.b=OpsBZS61; 
 arc=none smtp.remote-ip="2607:7c80:54:3::133"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:3::133;
 helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20210309 header.b=OpsBZS61
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 85E4C405C4
 for <intel-wired-lan@lists.osuosl.org>; Mon, 14 Sep 2026 17:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
 Message-ID:Sender:Reply-To:Content-ID:Content-Description;
 bh=L/2mUsKjcaJbKckiFuEIeCMG6ptMUuWX6YPpy3IoNEs=; b=OpsBZS61aw1SaUDg1JECT10lRR
 7wjk8hOeJnrPD+ZvOy7EXBIZE/iyXuK9Kx1gHRShkHOg/mIkkXl0hS2jPJIDTnLfqBDAgOZVQT9BG
 93kYvhSCLxLz5pagot2GizELuh3MTt6MUtfRn+MbsSnAqqKGdwsEMMIwEmxTqthfla4lH/4hScEX8
 Ps+XUXY1RLW098CyZEuMsGB0KvmlTMuqsmOJIWlee4zu82AiCgAy9/HySu891fhLd72/uBWE7f8ic
 speuhGdMDRsTen5IHsaNmiYF6zYJ7bnWbrgchGBZyZyc8a6zx2Iv6lUz6yLxjC0eMQxZKnQ595SB+
 87pjLtGQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
 by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
 id 1x6ALw-00000004NCH-0U2g; Mon, 14 Sep 2026 17:20:24 +0000
Message-ID: <63af51ab-8adc-474b-b59e-fe6ba8a7033f@infradead.org>
Date: Mon, 14 Sep 2026 10:20:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: kdoc: fix struct_group_tagged() parsing regression
To: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Cc: corbet@lwn.net, skhan@linuxfoundation.org, mchehab@kernel.org,
 aleksander.lobakin@intel.com, aleksandr.loktionov@intel.com,
 tudor.ambarus@linaro.org, bvanassche@acm.org
References: <20260914155127.21515-1-emmaonana18@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260914155127.21515-1-emmaonana18@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 9/14/26 8:51 AM, Omokefe Emmanuel Onanaroghene wrote:
> kernel-doc reports struct_group_tagged() members as excess because
> the macro transformation rewrites it to an anonymous struct and drops their
> member names.
> 
> Keep the tag and member name when transforming struct_group_tagged(). The
> nested members are then recorded as names such as fast.order; accept the
> existing unqualified @order documentation tag during validation.
> 
> Add a regression test based on struct page_pool_params.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Link: https://lore.kernel.org/all/0cf8ea5f-418f-45f0-907c-3d1ed4f03e9f@infradead.org/
> Fixes: 2f07ddbd5793 ("docs: xforms_lists: better evaluate struct_group macros")
> Signed-off-by: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>

Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  tools/lib/python/kdoc/kdoc_parser.py  |  4 ++-
>  tools/lib/python/kdoc/xforms_lists.py |  2 +-
>  tools/unittests/test_kdoc_parser.py   | 37 +++++++++++++++++++++++++++
>  3 files changed, 41 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
> index d9ad1ddc87dd..ced09504f3d7 100644
> --- a/tools/lib/python/kdoc/kdoc_parser.py
> +++ b/tools/lib/python/kdoc/kdoc_parser.py
> @@ -635,7 +635,9 @@ class KernelDoc:
>                  continue
>              if param_name.startswith("{unnamed_"):
>                  continue
> -            if param_name in self.entry.parameterlist:
> +            if param_name in self.entry.parameterlist or \
> +               any(actual.endswith('.' + param_name)
> +                   for actual in self.entry.parameterlist):
>                  continue
>  
>              hint = self.get_suggestions_hint(param_name, self.entry.parameterlist)
> diff --git a/tools/lib/python/kdoc/xforms_lists.py b/tools/lib/python/kdoc/xforms_lists.py
> index e3dda2fe8a53..9e8b3a6b1da1 100644
> --- a/tools/lib/python/kdoc/xforms_lists.py
> +++ b/tools/lib/python/kdoc/xforms_lists.py
> @@ -60,7 +60,7 @@ class CTransforms:
>          #
>          (CMatch("struct_group"), r"struct { \2+ };"),
>          (CMatch("struct_group_attr"), r"struct { \3+ };"),
> -        (CMatch("struct_group_tagged"), r"struct { \3+ };"),
> +        (CMatch("struct_group_tagged"), r"struct \1 { \3+ } \2;"),
>          (CMatch("__struct_group"), r"struct { \4+ };"),
>      ]
>  
> diff --git a/tools/unittests/test_kdoc_parser.py b/tools/unittests/test_kdoc_parser.py
> index c4a76ed13dbc..1a8287e99f2e 100755
> --- a/tools/unittests/test_kdoc_parser.py
> +++ b/tools/unittests/test_kdoc_parser.py
> @@ -418,6 +418,43 @@ class TestSelfValidate(GenerateKdocItem):
>          """
>          self.run_test(self.SOURCE, [self.DEFAULT.copy()], self.EXPORTS)
>  
> +
> +class TestStructGroupTagged(GenerateKdocItem):
> +    def test_nested_struct_group_tagged_members(self):
> +        source = """
> +            /**
> +             * struct page_pool_params - page pool parameters
> +             * @fast: Fast path parameters.
> +             * @order: Order of pages.
> +             * @pool_size: Number of pages.
> +             * @slow: Slow path parameters.
> +             * @netdev: Net device pointer.
> +             * @queue_idx: Queue index.
> +             * @flags: Flags.
> +             */
> +            struct page_pool_params {
> +                struct_group_tagged(page_pool_params_fast, fast,
> +                                    unsigned int order;
> +                                    unsigned int pool_size;
> +                );
> +                struct_group_tagged(page_pool_params_slow, slow,
> +                                    struct net_device *netdev;
> +                                    unsigned int queue_idx;
> +                                    unsigned int flags;
> +                );
> +            };
> +        """
> +
> +        kernel_doc = KernelDoc(self.config, "test.c", self.xforms)
> +        patcher = patch('builtins.open', new_callable=mock_open,
> +                        read_data=dedent(source))
> +        with patcher:
> +            _, entries = kernel_doc.parse_kdoc()
> +
> +        self.assertEqual(len(entries), 1)
> +        self.assertEqual(entries[0].warnings, [])
> +
> +
>  #
>  # Class and logic to create dynamic tests from YAML
>  #

-- 
~Randy
