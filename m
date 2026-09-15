Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F61C88E77
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 19:00:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6075680AD5;
	Tue, 15 Sep 2026 19:00:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3Rh1d4n-GpPe; Tue, 15 Sep 2026 19:00:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9C76880AA0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789498814;
	b=dCTn6vG6IOAF1Uc2Rwq4X7ClJcQq/W7Eyo7ky8MN6RpQyBdgb6T+Zizy7UW+tCAuWnhK
	 Qpdbp5hEFMCldwPhP07Q3fuPnz4WG9fj0nT2x18jTmxi2AKgO5fnGn86X3K8py4wqfDgp
	 fUd0T/hvSAxlPccRtBQEEUhq/ntwBCK2g+LHmAW4/3pTWhYisdq8JMPEfl/yCpHh5aQP9
	 mhoutX9aeX37oMervcMdbAunBzKG3e5Io1dMWhbhWkNeaYuuFPFwDTASm+CwvR8E5vEMK
	 UTarMKcJhhvpMFZbzGMLcljIe+WkG60IGXC3QUTYTcv80kpir7ng33t1/E1DDTxOu4Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789498814;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Filter:DKIM-Signature:Received:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/rqDGNFB1EvMVZVpxGsWgt/E/NZkIXTIaDmimmq2Rhc=;
	b=QIBLmkBcedroT1oTLzRqVqFADxK6td8PvTCQ40wAJ0uKiTAtcow+pFoniKUilyA7i0DV
	 bPb9HFT9lYo+h4BGFxitHwd2PTeh0xgBUZa7Y5P8Lf1sgea6oeVUsfsGM9LV2SD/wkhoT
	 cnlP65Ijz8Lb28hyYU4Vrex2i0b/rORHHpzgN/nGORoI+Xgkacvr0IovZOct2rlRVXV8o
	 +GM4POmLeLH1rQoP2VrOVdTkCYXqhvR3iBFQwhfzfVWzqDfQeH5VQGlKF8voZtty3GKOc
	 3NwoTBDuZ++2VIB90jq6M9Fq3lUWJ2kP5yPBCenriza2YpCUqljRfok8KwdxQJxueTQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789498814;
	bh=/rqDGNFB1EvMVZVpxGsWgt/E/NZkIXTIaDmimmq2Rhc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IoOhMAoNMi9TPyTnBuNvZJdQi49S4jRXCtKZItiphJR3jdUrSjXft3t30K4ZFRFlM
	 PwkR1MqHlEQhjXZQVHwc+OBpnxTBQ443R9s5EvVnja26Ot9r4sBcxA3jFlgumAdDtA
	 fXlOvRYa/OLwRcoNOeBJwgqYUm1Ua8fEdTqoeGpvo++yVtEIx3++NRPMs8ECYfcXTU
	 jBwdTa5DPjSYqzKoT0nSVN2/3UY8OeI4eWDuq8BMVGK0qU+RgdifWMjlvD02Qsx0le
	 qAAb480avMwCI8qNuxALO9yXNU81I5G2zxKl7trO080HTijcg8udy9tBB8JbScs8Qo
	 LMdoen8dEpBIQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9C76880AA0;
	Tue, 15 Sep 2026 19:00:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 38648352
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 19:00:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 29F02404EE
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 19:00:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5QcBP07gZSbR for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 19:00:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 16DBB404E0
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2600:3c01:e000:3a1::42"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789498812;
 b=hUNb1+v1rLU92W9U+fAo9HzKYw/CN6SLDrWsFkzIIZ8qlIdcTdrafKPaJQWsuHQAwK8x
 ztUx57JgfDtwV95QBWdmouE+JVH5ln+9ooOtgcmnaJ9A9ZWV+tsEYyYSp78mRapH4QFGg
 u7lKkuWi2CgGW7w3tPxm5gKjWD4RqrSwg9FFuvKg/XRxP/iSt4jrZjymJ24/hY+DC8tHW
 Bx3meez1x3ROWgA0eNgTO8tgD/kCt4+E6/S45AgZk+n37tuISh2v0UHpwt+Oet1n4FaHH
 KPzYcSDSG3XZSbB1efUy/lQmTPJKCP6duwdZ9u+5TR6+Ng+OqitlT7L03k9AEuGpAKg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789498812;
 h=X-Greylist:Received-SPF:DKIM-Filter:DKIM-Signature:Received:From:To:
 Cc:Subject:In-Reply-To:References:Date:Message-ID:MIME-Version:
 Content-Type;
 bh=/rqDGNFB1EvMVZVpxGsWgt/E/NZkIXTIaDmimmq2Rhc=;
 b=UcRvY6Ko3sTE3wHDi8GwZ372ulGLlF9Wqz+u94LvXHsCJrbONOfpGCAWUH9j5YndzA5O
 H0af0Btw+OCBmZy4u3czYyqZ5FmWHbd54RepnMiG5JGSWdifo2MHH0lvky96wZxfz4o7e
 ae5l8z/sJCjJipth1JRPT9gzOqxQ/+7jpfr1jLM8NpCiO98KkbMmIJ6JIqk8Jyswik547
 Z+CJMkFqm7WBLeNqyxunKWWMafSp3HYxVod6N/JfE1B+h7M5fCeb+VHqsetab2IbWSTdL
 5FeY+U9ZFBPP/vefoENKHEgcgyda/alz/M8KWtQu4Ib4L8JRRi1T0uUtGAcey0StmgA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=lwn.net; 
 dkim=pass header.d=lwn.net header.i=@lwn.net header.a=rsa-sha256
 header.s=20201203 header.b=HGXzba2J; 
 arc=none smtp.remote-ip="2600:3c01:e000:3a1::42"
X-Greylist: delayed 558 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 15 Sep 2026 19:00:12 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=lwn.net header.i=@lwn.net header.a=rsa-sha256
 header.s=20201203 header.b=HGXzba2J
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c01:e000:3a1::42; helo=ms.lwn.net;
 envelope-from=corbet@lwn.net; receiver=<UNKNOWN> 
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 16DBB404E0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 19:00:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 93DD2408B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
 t=1789498251; bh=/rqDGNFB1EvMVZVpxGsWgt/E/NZkIXTIaDmimmq2Rhc=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=HGXzba2JDGuMqzSPH60oln1TwZV00Bcn2Xea3xM3bWcFT0ZtzD7VUjGJ6jkB5Wpws
 t2WUq+VhD+xI5gYCXaZgzAsNIUot3g7jgixehFBEJbzmmmRBjImlkebq0PxrdoSnMT
 ++FCZE3TOP/1TNKmkkFLkK6VcPY8zwEcnknEtqnlKBngyp9m2SNvuln9RXvUbwIud3
 2XSPbyvF6skwRkVyRudLbU46YDS7Ixw4YEquq2CRF0kkRyuYLcemmfuoS1Cv8xQPOK
 oCNxDSmXttMerQvbNEkeP2gB5wRl+AJrtJf4Ht46aZMpTjBkFcusT0A5YY51IntLjK
 Al3LVViCSybJA==
Received: from localhost (unknown [IPv6:2601:280:4600:814::1fe])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1)
 server-digest SHA256) (No client certificate requested)
 by ms.lwn.net (Postfix) with ESMTPSA id 93DD2408B4;
 Tue, 15 Sep 2026 18:50:51 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Cc: skhan@linuxfoundation.org, rdunlap@infradead.org, mchehab@kernel.org,
 aleksander.lobakin@intel.com, aleksandr.loktionov@intel.com,
 tudor.ambarus@linaro.org, emmaonana18@gmail.com, bvanassche@acm.org
Subject: Re: [PATCH] docs: kdoc: fix struct_group_tagged() parsing regression
In-Reply-To: <20260914155127.21515-1-emmaonana18@gmail.com>
References: <20260914155127.21515-1-emmaonana18@gmail.com>
Date: Tue, 15 Sep 2026 12:50:50 -0600
Message-ID: <87mrti9wmt.fsf@trenco.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
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

Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com> writes:

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

This seems perhaps a reasonable fix.  Did you write this on your own, or
was there an LLM involved?

Thanks,

jon
