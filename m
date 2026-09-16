Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E06EC982C9
	for <intel-wired-lan@archiver.kernel.org>; Wed, 16 Sep 2026 21:56:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6284980E57;
	Wed, 16 Sep 2026 21:56:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wsurcs-tOZ7b; Wed, 16 Sep 2026 21:56:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6F36B80E73
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789595780;
	b=eYQ6IW/jznaQLB8hPJmjnPmOs2c4IHDdtuNN3PpmMokllfTocSD7YqDqtztBAVL6/KQ6
	 6Oo0ICmpZHCzgRwQtX5mgnNkfEtOmFrirPD1mYq2RXe2Ojz1s/UUcKnmtyuq4cqsZRTFC
	 IZigd3iN3U/6bs56fSlpWW+hqzsE9v61kmvzQM5zyRbg0uqR9JkPyO3N5phEVCc+AkH1f
	 pGtq4pwhTb6vIlftBDhtPWwoWEfXRoD3E9ITxw8acEFqsmS+rB/FgwUcynGmjlg5gn6SD
	 qHBxKpWICxfJXmrcIEqBOL3XkgGCC0/6SIspNrFupeUyNt1l7kHoA001aFxGxX7+/Mw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789595780;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:From:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=F86npnAVvTP7utuodLFhhH29hf82hOKCV9ZQ7Qgnz0M=;
	b=BkANKDHiVrfnWu8Kp3mjJNE9rTxUMJbLcclrCCrnjYdu4XN2dgOCb4D7dDsEigyTZ1RC
	 iGXgS2l+USKL2zcXE+IeQpUum514gDRPghT84Jxg0SmSmPI417bavcVnEf1LoE57Ho+Ht
	 e8TF971og+C00cKJ1/fpz+cBX+re1JvDG4zvcu/ltbyBE2N9EF7kp+Wxbpqz0/ilQnfUi
	 Af8wXkbZuWHzU+StRn6/js1cQPSfo2BcefUM/Nh/0rKOqzZhbk+yyKXGBuAXeX7vVHV0G
	 2in2DWP8g/p5z3JnH3uGdGjtlpalSM4GJ1glo0/W2NaOyNRAi3b+SCXGEJRNhXG/d8A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789595780;
	bh=F86npnAVvTP7utuodLFhhH29hf82hOKCV9ZQ7Qgnz0M=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IGqb36ov7xGumBxJNkRvIJM8AXBRITiCIt/r2olCU2K15ibRdmvCnBfEJkmWHewA7
	 Gs+lDdqBfFrj9cpVqwJYxHoeLBioXXXjLPjX8YvnYAfGUi1VayQXXHUPJU3ldtmIjb
	 hiVeEeJeAIt2SrG25J0ZV1dzT3T+XO4p/OTJEwLeANf0NN4oswa1vifhc1Pl0XxZxV
	 kJxnhqiIcP8/BMTRKhudXCLwnrnaduFbThGad37IOL7LjLwOhqLeYDIJzf0EEQgoyX
	 I0fKmDJdB1yUr91HNEeD52+FoMzqRiLvUUI0zMtpp2xWxyM5x4r5AJAIyN4fzrgEMn
	 FvEvuNtJMCKWg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6F36B80E73;
	Wed, 16 Sep 2026 21:56:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5F22B24D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 21:56:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 44CDB6062D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 21:56:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6R7UcFmchMuf for <intel-wired-lan@lists.osuosl.org>;
 Wed, 16 Sep 2026 21:56:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org AE7906061C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789595776;
 b=Ea6FiZe6QbtyJDTQpRO55RiJHp+CcHiyAlOqnNY1ZQdXX61h0dtmcVPEu8wmJdHAGOaY
 8TZfPRVCIzb0GUQVLXLDaVfzdL+dxHEvgWAKfKpUn+7ydMh/yOOd2IMeTpnsgVvtfCdxw
 2Ja06GpMCN4+Y4xmkLkD+vl3W3i2VUohFGwIzAgkOYi7Q8chWM0sUXKXJQ/HxQbPNuVnW
 9vB/87P7DzA9M9d5zMy784NXp3+TYlDSAN7C3eOFpZ3VIrlPgHRO4overV4gMyX6QrSV6
 2JZAzcu7SOSS3eMNfyG2PFUZxCTOc/yFJMbeLKq1b2GpSTGCXjO90K0kj41qnS/LW+Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789595776;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
 User-Agent:From:Subject:To:Cc:References:Content-Language:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=F86npnAVvTP7utuodLFhhH29hf82hOKCV9ZQ7Qgnz0M=;
 b=l88sdrbPFNRcxW0Fz6L/zs9wwq7TrV6iD3Q/Tqj85Fli/EbohYBX5KoKwpYwF3t+ycep
 mEk6EGT8uz41a8MDo4iIMlosiqkQpVriFVUYf3Q1l7n/E190VWSZn6zE8L6Zz7+/8gUGS
 3jobhCa40bwDR5j8DcMc6QOUZyMKHK7OXV23U4vGjAP04hNFpB6M20Q1ZSofrcQf36wJC
 i7q1ZfXMcNZHhhzFMXqWmM6RHFfVM6xvjrciPXw/FzfDPDTGUIwVdQYi6gLyjq4OYSNVz
 p73rDe1wFlX9cnXheItGNeaSlJ6A2T6ku/TJYBiSZHcJRNTw2Jiz6LlIxZNWHSdCJ1g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=infradead.org; 
 dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=bombadil.20210309 header.b=jZVOGvP4; 
 arc=none smtp.remote-ip="2607:7c80:54:3::133"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:3::133;
 helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20210309 header.b=jZVOGvP4
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AE7906061C
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 21:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:
 Message-ID:Sender:Reply-To:Content-ID:Content-Description;
 bh=F86npnAVvTP7utuodLFhhH29hf82hOKCV9ZQ7Qgnz0M=; b=jZVOGvP4+NyncfuumXy/ZDra9W
 MhUoP3f+OC3xgkpw6vquAqwTOS8i+ujU3w5gjOIE3lfPxrOtmNTcGr/DZupJD5tg6X2Hvz0jXlO1w
 0n7JCsF5ZuEZnaMmB0aF2QPJ/GOxoIJ9PNTFGo/GpSSqbly6e1xZXhgXKNVkPb4u6DH7GE8vwCF0y
 6RtZwloVRwhYZSSKi9b5ytkLs2MgfXkk2vdTOwalgDaxO5i/9k8V8VI3emuFXHKcCl0ai+smmHYPH
 t4SYlkxKbAXPe2UPQT71d6pcyQBOi2YEsTB30WogSl8yn1volV+eT25eLMhy6kYG+3zoZdTfZEDtx
 Yt2L1mhg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
 by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
 id 1x6xbv-0000000ABO3-3yDe; Wed, 16 Sep 2026 21:56:12 +0000
Message-ID: <6336d240-fe6d-4ab9-bb8a-f160988c74cb@infradead.org>
Date: Wed, 16 Sep 2026 14:56:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2] docs: kdoc: fix struct_group_tagged() parsing
 regression
To: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Cc: corbet@lwn.net, skhan@linuxfoundation.org, mchehab@kernel.org,
 aleksander.lobakin@intel.com, aleksandr.loktionov@intel.com,
 tudor.ambarus@linaro.org, bvanassche@acm.org
References: <20260916214357.22573-1-emmaonana18@gmail.com>
Content-Language: en-US
In-Reply-To: <20260916214357.22573-1-emmaonana18@gmail.com>
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



On 9/16/26 2:43 PM, Omokefe Emmanuel Onanaroghene wrote:
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
> Assisted-by: LLM
> Signed-off-by: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>

same as for v1:

Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> Changes in v2:
> - Add Assisted-by: LLM as requested by Jonathan Corbet.
> 
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
