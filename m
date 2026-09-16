Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE696C982C1
	for <intel-wired-lan@archiver.kernel.org>; Wed, 16 Sep 2026 21:22:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9F43D40377;
	Wed, 16 Sep 2026 21:22:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v_BIcktWfVdd; Wed, 16 Sep 2026 21:22:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org AEB9740401
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789593755;
	b=QGmbcdCei5FGAOwpYxKCwSzB58a8sxuYfbwMT3jCFlCVS7LvuV8kgPnWW61T7KtozEUV
	 L1UTkooCfe+CqniO/66NiXuBNflYVpezbTPU5xW+0qykAisSqN/1wnJpCz5aEf39vUoi4
	 F6lQ7X9lfqpUy+840qiWQ9RBvoNl3dLNCnd5n2HWk9me01qOJeiMe2UKGu/hl7xcId4D/
	 uRh+dYW+bMqCJy0YJ/q+87Eux9fOmq0uX8z/BSv50To2sdlrn/YeiMXjAryiZOAhra9Ea
	 b8SEMImX+0bgHYnFEuS2sbwRt9uC1g3zU3mGGvVB1jlgNy8OyfBRG/GXLPTtsawCdZg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789593755;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=hI36Dt83+aBklx0mctAZ5voXCECNLVsKWv1vBMRK6q8=;
	b=h9AYHRSvHsfsH/IBbvlwdC0K+t3rw/8w31uvnKqiz3pahL+bPLmWQqK73sUaygLY2M4t
	 /XOg/aq+4WMaNMsfJJzA+zLxCfkFibKz7V/1JBC8bfIfVJdSq3LwEoxjqczwGj7YCTstQ
	 /CCsrVq5608illxozZPcO9NYHWVtSoaI20zrG+MPLnKrbpcWvEofBFfVRMOWVlw4skegm
	 K+tlRx3bGOzEgmOhzEL/Yt5cZdgWlCphQ0JlsPw9clx4goT91PryRt+Yjp6pLOk8Z4Ks7
	 GXpWaCgtHi/KRDr1sYLO8CrSdWtxMpDEwt3selqZJIMNd2Dpr92tM+ncAvVU5kOmb4g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789593755;
	bh=hI36Dt83+aBklx0mctAZ5voXCECNLVsKWv1vBMRK6q8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DhwwweO0T2ILQKXP9tY/DW/9au20ei7LlJs8mMeMyozdqBhpICosnuSYSQcNvQhUh
	 n7dIlDL/f87SMqhlvP8DLyjMzkbV2DJBs0UoXdVZRMLoYgeqnWNxszigFZ337tcx9Q
	 wLND2FU5ZBQfmhSMVsiCPZYiBkvH9etLkz1aUQU1xwAvYnFjbX7ipBK8bN3R7a93Y+
	 d5b8X/LupOoAxlMznuszVpUlbldMIfq+gbiHKnWaxbSGQ0dUPGn/qnIEPOhFvLKjg9
	 yhMnWlL/7Uo64IFdth8sFkqtjAXH8DAZQlSr6Dxd0hzlbBb50B4ypNr8D1zYhTcMXh
	 mt8tT8JOYcgoQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AEB9740401;
	Wed, 16 Sep 2026 21:22:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0B66C2EB
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 21:22:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0862C807AA
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 21:22:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3DYywSj7hMsW for <intel-wired-lan@lists.osuosl.org>;
 Wed, 16 Sep 2026 21:22:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 65F24806D3
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789593752;
 b=XLTvmwzTu3xf+kmrLnRzCx3IJmuzNNGAG+FTD+LRZmLgaBImFoqcuPOS8BRfkE+EPml7
 QX7qznBfPD+C2CCRbo/igwonbMMEpFR/CtM9s+sdiexvMmDxbIkVFjgGycin5RbQuzrkx
 m6GdrAaSMe1p19jeHmlEAmCiHYR60I5aRv03CU+xrXbZzWamboqZ0ua3tAny/ozvE4rsD
 RoXUyODnHo0ieX8FisT3Ws/6Q4T26xuQTt+CKBP22y0KQ4hjzims0YvtkNDdzTOQwv7Fq
 aCE7sPvT4eXeGlKxW6ANCPptHB15NVZhNPM6vmAza315hD1gGagC1b/ybGgtk1B5oKQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789593752;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=hI36Dt83+aBklx0mctAZ5voXCECNLVsKWv1vBMRK6q8=;
 b=QSaxs4iTGJjQJUBXepTF0qRa8waeLSTk2yqg6ibesshWBkH4YUUt3StSebQ3F+GQL47L
 JSBcG3a7MZ1wLAKDNlqdG0z0YCILIPCUbVSrvH1ieU56p6g7+MvcIukPUuw87gwz4IMeB
 IaMdLF+OBkdQr92Od81U/+fpcY5wHJ7C9pLPSrIhQrdYQjTiaVqBSOa+XpjVsSd2kGWrc
 8IQBdG+JaLcO2kurQq31SaUE6IqBgFmi0++miVHqbCuwFuiLiTWTMDDh40y1Q/2ZMbOnb
 19G0doFWyR58LWBrnJlVNR9wxNxgHGahGznZYivjMDpq1NGEULbwcLnDSTRWzMYVGNQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=infradead.org; 
 dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=bombadil.20210309 header.b=MlT2t8uU; 
 arc=none smtp.remote-ip="2607:7c80:54:3::133"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:3::133;
 helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20210309 header.b=MlT2t8uU
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 65F24806D3
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 21:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
 Message-ID:Sender:Reply-To:Content-ID:Content-Description;
 bh=hI36Dt83+aBklx0mctAZ5voXCECNLVsKWv1vBMRK6q8=; b=MlT2t8uUqAHjVOEfAVvpKLynqk
 s7uz9sdzSbpbuNGds+mV45rbKrkvgrwXKpdP3vHZ9nCXDT+iAGyBiZKxZntBPQcPnWgysNHWeTBP6
 h7YJCZ4kxc3LxCh+2kqK2of4U2CXI9slEHiSCnVG5FA6tgj+4bcqRFkuHar7IjDuHpLksiaYJ6Y3w
 cdUeNgQgkErD/jMKu64ZjY3MiVgUPjwTZCg7faxfbqwfPqgJigjoxXPBGJRSIi3vcaijQDW7wT34e
 eoaYJmGEvMeyV2JZbQMOz22nmEY7u+CKvzP1pEOxyQFdkUT5uCtUlDkUQUz7e5oP1Q9CBSui2ZLWH
 y8ae3c8w==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
 by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
 id 1x6x5K-0000000A8mG-0TOL; Wed, 16 Sep 2026 21:22:30 +0000
Message-ID: <f0591ce9-2e8f-4777-90ab-b9159b7d8f20@infradead.org>
Date: Wed, 16 Sep 2026 14:22:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs: kdoc: fix struct_group_tagged() parsing
 regression
To: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Cc: corbet@lwn.net, skhan@linuxfoundation.org, mchehab@kernel.org,
 aleksander.lobakin@intel.com, aleksandr.loktionov@intel.com,
 tudor.ambarus@linaro.org, bvanassche@acm.org
References: <20260916211012.16821-1-emmaonana18@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260916211012.16821-1-emmaonana18@gmail.com>
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

Hi,

On 9/16/26 2:10 PM, Omokefe Emmanuel Onanaroghene wrote:
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

This is the same as your v1 patch. Did you send the wrong patch contents
by mistake?

Also, please tell what changed between versions between the "---" line above
here and the diff below here.

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

thanks.
-- 
~Randy

