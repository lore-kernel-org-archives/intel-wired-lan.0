Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E961C624B4
	for <intel-wired-lan@archiver.kernel.org>; Thu, 23 Nov 2023 11:58:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D20D54017C;
	Thu, 23 Nov 2023 11:58:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D20D54017C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1700740682;
	bh=cut7X6y2zjvptG8hkvhkgxwX6HSJRqqe/mcMkgFfNXs=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=eQuKWvvXhOtcntiKPA2KUJ8ch+4egMEhOtBmkbHJvWiINMNbwYlZbuhBkDoejnN4H
	 RGpY+LsFldgWFVRxDXuxaMRdrLvOe6HqpCaKBI1NW0KeWfILVjYBDe/dViiWBUPbqr
	 3nWqyKIDX0a1h0+8FJSsl/ElM1mlgaFw9fRRuWhuujvOGR7Vq2f4TqC3ocd1yLy7Lc
	 Ed8vj0wsMBmdKjsj0ahEEQsZTeJgs14EHdtkYur7E7Mx0hTlnzLeVpPNJ0y+O3Uqut
	 rcHLQ3skNS1OSazU6N+g/4e8fEWbgxdtjrnd6H0qZvDU6mHuLk1rdlZs7Hf5Efh/6i
	 e0XMegrFEFHdg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Wi03yoGyoTl5; Thu, 23 Nov 2023 11:58:02 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id AFD8540341;
	Thu, 23 Nov 2023 11:58:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AFD8540341
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id CBCCA1BF5DF
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Nov 2023 11:57:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A369E415BF
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Nov 2023 11:57:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A369E415BF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RUjPiowwXnqu for <intel-wired-lan@lists.osuosl.org>;
 Thu, 23 Nov 2023 11:57:59 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CEFEA40198
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Nov 2023 11:57:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CEFEA40198
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id C4A4EB82BE6;
 Thu, 23 Nov 2023 11:57:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 014FAC433C8;
 Thu, 23 Nov 2023 11:57:52 +0000 (UTC)
Date: Thu, 23 Nov 2023 11:57:50 +0000
From: Simon Horman <horms@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Message-ID: <20231123115750.GB6339@kernel.org>
References: <20231121123428.20907-1-ilpo.jarvinen@linux.intel.com>
 <20231121123428.20907-3-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231121123428.20907-3-ilpo.jarvinen@linux.intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1700740675;
 bh=wl9oNNHOLEXop5o0ArpCVRXBXQS6LvZBy1Xs2D72YlQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RBtfNhqgVf2DOEg6I9Ifs5PmN+q9wsTnGe+qHhbeEJKlV8I3wzrxM4I2f5G51Q6I2
 rYG1IMBn7OTW+y1uEZcyfOUd+/AcRqbZEM3uigEqI97iQgNZLWzo1Bb6wlbzq0C9An
 xoPhMmQyKzAEvEbnekNqT89fst8W1GZVYnGv/8DFHntwaOie+yuRdTkDp9dN7MDmo/
 D62Pp6nSt3IQLkaCFiWQT153LIol6TSYcPB5GtiWGB2g5qINJ6P9Y7QELDfkOtUrwh
 M6CxD1zlgZX6MhtInT6OppoHdLT6VcWlTPaN3dz1G6jojeO1ku1/qcFbqRqy+q2xSf
 ysgI+NwGKBteA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=RBtfNhqg
Subject: Re: [Intel-wired-lan] [PATCH v4 2/3] e1000e: Use PCI_EXP_LNKSTA_NLW
 & FIELD_GET() instead of custom defines/code
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
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org,
 Jesse Brandeburg <jesse.brandeburg@intel.com>, linux-kernel@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

T24gVHVlLCBOb3YgMjEsIDIwMjMgYXQgMDI6MzQ6MjdQTSArMDIwMCwgSWxwbyBKw6RydmluZW4g
d3JvdGU6Cj4gZTEwMDBlIGhhcyBvd24gY29weSBvZiBQQ0kgTmVnb3RpYXRlZCBMaW5rIFdpZHRo
IGZpZWxkIGRlZmluZXMuIFVzZSB0aGUKPiBvbmVzIGZyb20gaW5jbHVkZS91YXBpL2xpbnV4L3Bj
aV9yZWdzLmggaW5zdGVhZCBvZiB0aGUgY3VzdG9tIG9uZXMgYW5kCj4gcmVtb3ZlIHRoZSBjdXN0
b20gb25lcyBhbmQgY29udmVydCB0byBGSUVMRF9HRVQoKS4KPiAKPiBTdWdnZXN0ZWQtYnk6IEpv
bmF0aGFuIENhbWVyb24gPEpvbmF0aGFuLkNhbWVyb25AaHVhd2VpLmNvbT4KPiBTaWduZWQtb2Zm
LWJ5OiBJbHBvIErDpHJ2aW5lbiA8aWxwby5qYXJ2aW5lbkBsaW51eC5pbnRlbC5jb20+Cj4gUmV2
aWV3ZWQtYnk6IEpvbmF0aGFuIENhbWVyb24gPEpvbmF0aGFuLkNhbWVyb25AaHVhd2VpLmNvbT4K
ClJldmlld2VkLWJ5OiBTaW1vbiBIb3JtYW4gPGhvcm1zQGtlcm5lbC5vcmc+CgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpJbnRlbC13aXJlZC1sYW4gbWFp
bGluZyBsaXN0CkludGVsLXdpcmVkLWxhbkBvc3Vvc2wub3JnCmh0dHBzOi8vbGlzdHMub3N1b3Ns
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2ludGVsLXdpcmVkLWxhbgo=
