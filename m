Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26FC7C982C1
	for <intel-wired-lan@archiver.kernel.org>; Wed, 16 Sep 2026 20:45:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C4467403D8;
	Wed, 16 Sep 2026 20:45:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OuM0Fgo6oQwN; Wed, 16 Sep 2026 20:45:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D34CD40680
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789591535;
	b=W3josN0xix1AYil6L3QSzwq7qtHAX8EVgB9IPuQv9wGy5NQJDTciyfxt0LtGR+nrqQLY
	 9Vq8F0/mCibh01OpE2tuLBKPQWI/VEnaQWeVprG63rwuAR0mGrqA/O584JJxWIHurSDz8
	 vQk20xZHJOS2gvuXTUg1LJXXfcAQYES8ODq/njp9T0IcqrmlknFyUUIK2144iCzsUWX9P
	 EKBJBHhZaZQqvNhiO4+YsUQCfaMqPnRagYJIyuz9R4LsPfnDiy7Kh8lXAqmvQ5HeFewIu
	 Hl9h8MJ+jilVzOSo9S3O7eag9aXyf2Ada/T5H8tdL3B9uaxDKLY720XmtgbiXrpO/4A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789591535;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=0e4JuDoGwJko+bWyw7DMuKSr0o57ajEnpbZrPm7VLzw=;
	b=mGkIHseToZaOJ9wrAc75Xduk/KtMjfuSiZkG4SeYYpVneLNLAB7icpIseDQZVTolBOtq
	 13NoTa88id+wwgpLeX9RwkRCX2UKleF1JYCddhSviZ+8WEGyl6bgKQlftL8WN2h9u/Of8
	 Jxvvl91KEa7M8R21cud1l6eAy1JLPL3qXweYMplVNrknFGom3HvHf5X0ZLR7dP6QbdUIo
	 4NvU1AIbVdpH+YwXJle4TGYTori9tmH0caxlOL0ZqVWE7onM9e1SrRtFVWJYOPCNCpUAd
	 /+rcvB9sHMwYXSA2+WC4k+akvgv3vWsmjFbgU+a1V8SNmcCGnh4GQH2lfXfGzrSJILw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=rwLIQ2+I;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789591535;
	bh=0e4JuDoGwJko+bWyw7DMuKSr0o57ajEnpbZrPm7VLzw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T0LJtIsl8TiuH/PEqN6Kix4GSpZY52YKt0JYWkSJJqojfDQBpnzYIRp85O72TjtNC
	 9/x2VrfaAMJcnPgnh4qWXD/l7XegwDUIb1a3IYxtY67MFPuPdAgBsHVaQgiKPVkvgM
	 bBZOZYkrFehnmWlkl+lUwccC3ewUehC/LA78sb4STvm9+dwKt3w+TbOiAhd4DL/9N3
	 iOhBccgtuEZA6oGTPB/3/bRaQIQgG5MZtFVttN55eom87trYB+Dy8CgHVoqpnu2RQY
	 7MoPk7XpPcij3vY0p5sijwAxHpKG0sDAxnd368nmwcW8x0ddoIVdUy+Kri/QGR8p8X
	 LG6qI/AlU9gzQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D34CD40680;
	Wed, 16 Sep 2026 20:45:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id F02EF24D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 20:45:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D5FC2404F5
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 20:45:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T1oY9O-WA-Il for <intel-wired-lan@lists.osuosl.org>;
 Wed, 16 Sep 2026 20:45:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 02D16403D8
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789591532;
 b=CK9tf5YvXJvuxgYv7SJkVp249UIL5sJNWJtbB40qfQ/CaabbleyZfGvdCQ0cv3XhtF//
 3IBSotiH+YQDyNGshZvdQWHziGW5lOgutyCaOOECXys6SDn90iy2LXTMzfLIarJ2Pl/oZ
 iEiAgwUyVb7geAjjYC5hb7zwqYqH+8c6S2TMXxF/I1Gi7F1trp/1iTA8dF7P7oglv9J6h
 kymB04dC7h4TDQAxCfwBw0mCmdqACrQ+lTL5FFO3YPTPqoHILRy0VLpaDKxNYwIlaAulB
 peSwZYQe0whDdr9WIWJKMDLmvPBGrcUXLByGb8t03FFJG83YyEWqLUxmqAbeb1iSiaQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789591532;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=0e4JuDoGwJko+bWyw7DMuKSr0o57ajEnpbZrPm7VLzw=;
 b=qY0OSLVp5sbXFuBxqN+aLEOwWRzAdCfuQbTF/ogy7riU00ewi3uJMQ/kF5SX5fRhc49x
 gto+LSAGFIntEPWbLYW1QLHh2FsRzmM2IMGdXkbclYVMJ7KLCqjKrRHxvJBoly7DdOyBC
 wCwdsb38qDEPObcaTrpDen+9PsE31ixDzL3ezPDrl4Q1pFNYMrckV3RFadkdfw3vQ9HUK
 TuikcQt0RAOm/zjjKm51e40sWNeCPy8TSW7bf5GkP+ZrjdTuf3d96auxJy5BERa0PB22h
 gVIkHuqCFuQ4qVhb5ZtgUPUAARPxmk5zXA7Q8wTgCCO322RR86uC57RdqyvuF3q+liA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=infradead.org; 
 dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=bombadil.20210309 header.b=rwLIQ2+I; 
 arc=none smtp.remote-ip="2607:7c80:54:3::133"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:3::133;
 helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20210309 header.b=rwLIQ2+I
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 02D16403D8
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 20:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
 Message-ID:Sender:Reply-To:Content-ID:Content-Description;
 bh=0e4JuDoGwJko+bWyw7DMuKSr0o57ajEnpbZrPm7VLzw=; b=rwLIQ2+IvPMDeexyGSSoUIWAlW
 vcOYNsE8OHjcoqWBx3G+PcIAvTX6tINDBo5QnGL3H9kVNaUSyNgPP2eA/PLBegpel8aTh7Y+NrVIX
 CpZqNWonEnKVZBww4olulWDz/7pG0jL0WmTNMRv/DQr8dPbLbE0i88PFDx9UeBrmM1ujhj09ceSpF
 C30iw3gx+Kt+cBSN4Yp2DhyvPORqCBJf6feRFOPgSNyIMGCFkkoMYdrthFr2LaLA+3MmijQIxTWdz
 K11Almdt5ybXRn0OPjRKgl/OyJlX7O087zGXCKYkLOGtjk+3Lmz6N1cjsYzHkw2UO9+i/XU4fMloP
 up/CE/Jw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
 by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
 id 1x6wVV-0000000A5dA-3pSq; Wed, 16 Sep 2026 20:45:29 +0000
Message-ID: <e8344a91-b2a1-42a5-b65d-e02939103108@infradead.org>
Date: Wed, 16 Sep 2026 13:45:29 -0700
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

Hi--

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

Would something similar to this work for this warning?

Warning: include/linux/debugfs.h:246 context_lock_struct(debugfs_cancellation) { struct list_head list; void (*cancel)(struct dentry *, void *); void *cancel_data; }; error: Cannot parse struct or union!

Even though context_lock_struct is in xforms_list.py, it's not working
in this case (above).

thanks.
-- 
~Randy

