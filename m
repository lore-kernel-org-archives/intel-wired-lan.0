Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DAF4C54EAA
	for <intel-wired-lan@archiver.kernel.org>; Fri, 27 Jan 2023 16:34:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1A1A24014B;
	Fri, 27 Jan 2023 16:34:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1A1A24014B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1674837257;
	bh=csrdS9dnH+ex/CTQreNHWbRzziJ9ZQOR0BzvZR6ZzDo=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=faLkhRgRlSRp4umdGonwTEP4XRdoJdq8mOx2N4p3S16ipJFf5tqZ5zDRtXC3NHeaX
	 1Kerhx3kZ6bUldrRg93w007NCBRuU1LGa75w5ziQHil1doeetkIK63eR7B7beZsaOi
	 JagVOtyCX23VdHTixEs30oThCqtQW6hdTg9ZFhjvCfxxFi5VMFyOtRm8wQKG6Rwmk3
	 Ob+iqQBBVfSH+jxn0DPjdlqE4f/2r2gWGb+nAULiwqtAtQc9jsuK9IrkbbMj9S47Wn
	 GfdVvVEMr9cQB05av603YllxlHR8QJEzjJMi7LOl3RRYHrxG+j+PXTrWpopAWj60jB
	 QffHK3Znd5tgg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DXhEtZ2xxXYJ; Fri, 27 Jan 2023 16:34:16 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1D3BC4183E;
	Fri, 27 Jan 2023 16:34:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1D3BC4183E
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id E27881BF363
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Jan 2023 08:20:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BAB7E82566
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Jan 2023 08:20:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BAB7E82566
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xCbSclwq1FmP for <intel-wired-lan@lists.osuosl.org>;
 Fri, 27 Jan 2023 08:20:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 858B582716
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 858B582716
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Jan 2023 08:20:06 +0000 (UTC)
Message-ID: <a208ed96-20e5-43d3-13e9-122776230da1@linux.dev>
Date: Fri, 27 Jan 2023 00:19:54 -0800
MIME-Version: 1.0
Content-Language: en-US
To: Lorenzo Bianconi <lorenzo@kernel.org>
References: <cover.1674737592.git.lorenzo@kernel.org>
 <0b05b08d4579b017dd96869d1329cd82801bd803.1674737592.git.lorenzo@kernel.org>
 <Y9LIPaojtpTjYlNu@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <Y9LIPaojtpTjYlNu@google.com>
X-Migadu-Flow: FLOW_OUT
X-Mailman-Approved-At: Fri, 27 Jan 2023 16:34:14 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.dev; s=key1; t=1674807601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ov/FJthsCODGeWj8ILAwNRT93LKgz9Jx2BLZQJFGouA=;
 b=VvpwaWRgkPXmVGVaxMPg0j7GTF9JSJn1hndRbmKIDgfs8CFaBdUmYJOfni4D7xIfmVL7bN
 ZrttmyNQPsGKC8xh6GxIWlIDzD9wwK9DjIgVcYjx4tWVV+43dzRET5LsMtobKHNxUfUq09
 3IabGtps6eJVAfRUs/mF28o+asZtQr0=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=VvpwaWRg
Subject: Re: [Intel-wired-lan] [PATCH v3 bpf-next 8/8] selftests/bpf:
 introduce XDP compliance test tool
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
Cc: mst@redhat.com, vladimir.oltean@nxp.com, ast@kernel.org,
 edumazet@google.com, anthony.l.nguyen@intel.com, sdf@google.com,
 daniel@iogearbox.net, andrii@kernel.org, intel-wired-lan@lists.osuosl.org,
 simon.horman@corigine.com, kuba@kernel.org, pabeni@redhat.com,
 aelior@marvell.com, hawk@kernel.org, christophe.jaillet@wanadoo.fr,
 memxor@gmail.com, john@phrozen.org, bjorn@kernel.org, bpf@vger.kernel.org,
 magnus.karlsson@intel.com, leon@kernel.org, netdev@vger.kernel.org,
 toke@redhat.com, ecree.xilinx@gmail.com, alardam@gmail.com, gospo@broadcom.com,
 saeedm@nvidia.com, davem@davemloft.net, nbd@nbd.name
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

T24gMS8yNi8yMyAxMDozNiBBTSwgc2RmQGdvb2dsZS5jb20gd3JvdGU6Cj4gCj4+ICvCoMKgwqAg
c29ja2ZkID0gc29ja2V0KEFGX0lORVQsIFNPQ0tfREdSQU0sIDApOwo+PiArwqDCoMKgIGlmIChz
b2NrZmQgPCAwKSB7Cj4+ICvCoMKgwqDCoMKgwqDCoCBmcHJpbnRmKHN0ZGVyciwgIkZhaWxlZCB0
byBjcmVhdGUgZWNobyBzb2NrZXRcbiIpOwo+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1lcnJu
bzsKPj4gK8KgwqDCoCB9Cj4+ICsKPj4gK8KgwqDCoCBlcnIgPSBzZXRzb2Nrb3B0KHNvY2tmZCwg
U09MX1NPQ0tFVCwgU09fUkVVU0VBRERSLCAmb3B0dmFsLAo+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHNpemVvZihvcHR2YWwpKTsKPj4gK8KgwqDCoCBpZiAoZXJyIDwgMCkgewo+PiArwqDC
oMKgwqDCoMKgwqAgZnByaW50ZihzdGRlcnIsICJGYWlsZWQgc29ja29wdCBvbiBlY2hvIHNvY2tl
dFxuIik7Cj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gLWVycm5vOwo+PiArwqDCoMKgIH0KPj4g
Kwo+PiArwqDCoMKgIGVyciA9IGJpbmQoc29ja2ZkLCAoc3RydWN0IHNvY2thZGRyICopJmFkZHIs
IHNpemVvZihhZGRyKSk7Cj4+ICvCoMKgwqAgaWYgKGVycikgewo+PiArwqDCoMKgwqDCoMKgwqAg
ZnByaW50ZihzdGRlcnIsICJGYWlsZWQgdG8gYmluZCBlY2hvIHNvY2tldFxuIik7Cj4+ICvCoMKg
wqDCoMKgwqDCoCByZXR1cm4gLWVycm5vOwo+PiArwqDCoMKgIH0KPiAKPiBJSVJDLCBNYXJ0aW4g
bWVudGlvbmVkIElQdjYgc3VwcG9ydCBpbiB0aGUgcHJldmlvdXMgdmVyc2lvbi4gU2hvdWxkIHdl
Cj4gYWxzbyBtYWtlIHRoZSB1c2Vyc3BhY2UgdjYgYXdhcmUgYnkgYXQgbGVhc3QgdXNpbmcgQUZf
SU5FVDYgZHVhbHN0YWNrCj4gc29ja2V0cz8gSSBmZWVsIGxpa2UgbGlzdGVuaW5nIG9uIGluYWRk
cl9hbnkgd2l0aCBBRl9JTkVUNiBzaG91bGQKPiBnZXQgdXMgdGhlcmUgd2l0aG91dCB0b28gbXVj
aCBwYWluLi4KClllYWguIFRoaW5rIGFib3V0IGhvc3QgdGhhdCBvbmx5IGhhcyBJUHY2IGFkZHJl
c3MuIEEgdG9vbCBub3Qgc3VwcG9ydGluZyBJUHY2IGlzIAphIG5vLWdvIG5vd2FkYXlzLgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpJbnRlbC13aXJlZC1s
YW4gbWFpbGluZyBsaXN0CkludGVsLXdpcmVkLWxhbkBvc3Vvc2wub3JnCmh0dHBzOi8vbGlzdHMu
b3N1b3NsLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2ludGVsLXdpcmVkLWxhbgo=
