Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B126EB64D9
	for <intel-wired-lan@archiver.kernel.org>; Sun,  2 Jul 2023 19:17:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A7F7340018;
	Sun,  2 Jul 2023 19:17:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A7F7340018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1688325437;
	bh=2qPshLEBv+i2QCm1Sl3wrIVTX3EJF3gW4Uvh6IEiIA0=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=hgdYQ6jZ7P+kb0HjSvHrzULjE9Ea2yCXkM5Pei/fHU0SVzOfw89+VUnjbIkEOKKDa
	 lx8snqvP0F+45vBu9vG8gvImrJuH7uGHn8Dmcedu7mNgNOf/9TmzvZRxTnAM3ZZFgH
	 ysddS780OKyR70shNJw7aquSDxGUh38upu34Xc3/jz//+S+DI6qKrXofSk26cDxUC/
	 fK4Bjfb/d4DV94fUPrn+bTuyD2/aCAUkQsZ1Suvqwbjnyu+cXQU2x0g/0MZXJtU0DB
	 2AOQFeYCwp3AN6kNquyyHtkB/ulbl0ur66BGBkWbX/9iswjToJkSoBe3WMHwETVAM4
	 wkQfjO7Ywzn1A==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oc34X4O4tpOj; Sun,  2 Jul 2023 19:17:17 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id C5F4A40A93;
	Sun,  2 Jul 2023 19:17:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C5F4A40A93
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id DD1C81BF28D
 for <intel-wired-lan@lists.osuosl.org>; Sun,  2 Jul 2023 19:17:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B379A408AA
 for <intel-wired-lan@lists.osuosl.org>; Sun,  2 Jul 2023 19:17:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B379A408AA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HZQPHE3zvXT5 for <intel-wired-lan@lists.osuosl.org>;
 Sun,  2 Jul 2023 19:17:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7BB33408A4
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7BB33408A4
 for <intel-wired-lan@lists.osuosl.org>; Sun,  2 Jul 2023 19:17:14 +0000 (UTC)
Message-ID: <0c02e976-0da6-8ed8-4546-4df7af4ebed5@linutronix.de>
Date: Sun, 2 Jul 2023 21:17:01 +0200
MIME-Version: 1.0
To: Markus Elfring <Markus.Elfring@web.de>, intel-wired-lan@lists.osuosl.org, 
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Aravindhan Gunasekaran <aravindhan.gunasekaran@intel.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Kurt Kanzenbach <kurt@linutronix.de>,
 Mallikarjuna Chilakala <mallikarjuna.chilakala@intel.com>,
 Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>,
 Paolo Abeni <pabeni@redhat.com>, Tan Tee Min <tee.min.tan@linux.intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
References: <20230619100858.116286-2-florian.kauer@linutronix.de>
 <36b57ea5-baff-f964-3088-e1b186532cfe@web.de>
Content-Language: en-US
From: Florian Kauer <florian.kauer@linutronix.de>
In-Reply-To: <36b57ea5-baff-f964-3088-e1b186532cfe@web.de>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linutronix.de; s=2020; t=1688325430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bcRkV1JsdAB+1QeSMkNj7SU4PliDC9ED89IW5fPJQLc=;
 b=cln18HT5XkWRzeQ6oUlGUJ234pgfk+6U1z7i3GWmYV4eQjqUZO5sz7JD65DQOEF2CqnmtE
 94waio+VxYSc7kjlSBpPuvetqEbMPgKALT6NNIV4i7W9jSBtEuQJuyfJgQf+FVpCkh73ul
 tCYh94u++ADCaAq7m02N5/rLTFXIRVZAmxOtx8JY/6VlVJyE5cBp/dzaO0kBT+Dx1Nh9B8
 DoHsN2oCZEvwAsE3e4dAOmFScSXdRUCsepnCQMGMIWuvrxLliba4C9L33C1bXBtCjYVRZm
 O3RmpbtJ6dc5fKbVSjZznDRbQirmlIDGxU8kBz6w0olg8fWZZiiEUk9jWtx53w==
X-Mailman-Original-DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=linutronix.de; s=2020e; t=1688325430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bcRkV1JsdAB+1QeSMkNj7SU4PliDC9ED89IW5fPJQLc=;
 b=6ZF0sry1dcNvmgR8l0d/9AAjahUM5CPICbkZrcc9y8f2C+AoKOyoPfBmA4IY4encveZXmZ
 PZa+03/IJp4zUQAw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de
 header.a=rsa-sha256 header.s=2020 header.b=cln18HT5; 
 dkim=pass header.d=linutronix.de header.i=@linutronix.de
 header.a=ed25519-sha256 header.s=2020e header.b=6ZF0sry1
Subject: Re: [Intel-wired-lan] [PATCH net v2 1/6] igc: Rename qbv_enable to
 taprio_offload_enable
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
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

SGkgTWFya3VzLAoKT24gMDIuMDcuMjMgMTg6NTUsIE1hcmt1cyBFbGZyaW5nIHdyb3RlOgo+PiBU
aGUgcmVuYW1lIHNob3VsZCByZWR1Y2UgdGhpcyBjb25mdXNpb24uCj4gCj4gV291bGQgdGhlIHdv
cmRpbmcg4oCcUmVkdWNlIHRoaXMgY29uZnVzaW9uIGJ5IHJlbmFtaW5nIGEgdmFyaWFibGUgYXQg
dGhyZWUgcGxhY2Vz4oCdCj4gYmUgbW9yZSBhcHByb3ByaWF0ZSBmb3IgYSBzdWJzZXF1ZW50IGNo
YW5nZSBkZXNjcmlwdGlvbj8KPiAKPiBTZWUgYWxzbzoKPiBodHRwczovL2dpdC5rZXJuZWwub3Jn
L3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvdHJlZS9Eb2N1bWVu
dGF0aW9uL3Byb2Nlc3Mvc3VibWl0dGluZy1wYXRjaGVzLnJzdD9oPXY2LjQjbjk0CgpUaGFua3Mg
Zm9yIHBvaW50aW5nIHRoYXQgb3V0IChhbHNvIGluIHlvdXIgb3RoZXIgbWFpbCBmb3IgdGhpcyBz
ZXJpZXMpLgpJIHdpbGwgYmUgbW9yZSBjYXJlZnVsIHJlZ2FyZGluZyB0aGUgdXNlIG9mIGltcGVy
YXRpdmUgbW9vZC4KCj4gCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgU2luY2UgaXQgaXMgYSBwdXJlCj4+IHJlbmFtZSwgaXQgaGFzIG5vIGltcGFjdCBvbiBmdW5j
dGlvbmFsaXR5Lgo+Pgo+PiBGaXhlczogZTE3MDkwZWIyNDk0ICgiaWdjOiBhbGxvdyBCYXNlVGlt
ZSAwIGVucm9sbG1lbnQgZm9yIFFidiIpCj4gCj4gSG93IGRvZXMgc3VjaCBpbmZvcm1hdGlvbiBm
aXQgdG9nZXRoZXI/CgpUaGUgcmVmZXJlbmNlZCBjb21taXQgaW50cm9kdWNlZCBhbiBpc3N1ZSBp
bnRvIHRoZSBrZXJuZWwgYnkKaW50cm9kdWNpbmcgYSB2YXJpYWJsZSB0aGF0IGRvZXMgbm90IGV4
YWN0bHkgZGVzY3JpYmUgaXRzIGFjdHVhbCBwdXJwb3NlLgpJdCBpcyBub3Qgb25seSBhIGNvc21l
dGljIGNoYW5nZSwgYnV0IGluIG15IHZpZXcgdGhpcyBjb25mdXNpb24Kd2FzIHJlbGF0ZWQgdG8g
b3RoZXIgaXNzdWVzIChzZWUgdGhlIG90aGVyIHBhdGNoZXMpLiBTbywgaXQgc2VlbWVkIHRvIGJl
IHdvcnRoCmZpeGluZyBhbG9uZ3NpZGUgd2l0aCB0aGUgb3RoZXIgZml4ZXMsIGV2ZW4gaWYgaXQg
ZG9lcyBub3QgZGlyZWN0bHkgaW1wYWN0CmZ1bmN0aW9uYWxpdHkgaWYgaXQgaXMgYXBwbGllZCBv
ciBub3QgKHVudGlsIHNvbWVvbmUgZWxzZSBjb21lcyBhbG9uZywKYWxzbyBnZXRzIGNvbmZ1c2Vk
IGFuZCBpbnRyb2R1Y2VzIGFub3RoZXIgYnVnLi4uKS4KClRoYW5rcywKRmxvcmlhbgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpJbnRlbC13aXJlZC1sYW4g
bWFpbGluZyBsaXN0CkludGVsLXdpcmVkLWxhbkBvc3Vvc2wub3JnCmh0dHBzOi8vbGlzdHMub3N1
b3NsLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2ludGVsLXdpcmVkLWxhbgo=
