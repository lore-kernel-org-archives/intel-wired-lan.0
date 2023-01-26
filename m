Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6478BC54E94
	for <intel-wired-lan@archiver.kernel.org>; Thu, 26 Jan 2023 08:18:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CFE584086F;
	Thu, 26 Jan 2023 08:18:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CFE584086F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1674721101;
	bh=Cytu7xYKFBZ+zppZUvdzGCM7wUj02ixa5pU1vzBlp44=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=sUfRB7eNSBPiqSFs4cNXGqk4DZ1fTkwmrYkaVzbcctpftEVeQrczfanpSpXw35V9b
	 rNIBVSKSQRbX3jgRTR2B+rH0mp3nEOIeoznFDPzbgZJYKZb+Se4624FrkHo81hGoDR
	 vu5ig7Mfl7ua/CE7I3aGVZFPYHHj8y27XUO63TXEWZAHgY9SB7frhWq95Ld2B9wwQu
	 +8gD9PwgG3thB1Vl6WkDFEenAm8OhLeUZ3gt0hk1lVdDkayw2W15f3riweNezvwUyI
	 ipHQQnd/vSRdLcQKq0eiNHIh+uZiJTOqX/4wIB6kCrlyETHOJLTgqKwgBa3V+EUwyk
	 z93abO8Td35Kg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Xyp-9tbkWzh9; Thu, 26 Jan 2023 08:18:20 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9EC4940876;
	Thu, 26 Jan 2023 08:18:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9EC4940876
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 543111BF3B0
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Jan 2023 08:18:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 398E160E1A
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Jan 2023 08:18:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 398E160E1A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MFe5Jj7JXABw for <intel-wired-lan@lists.osuosl.org>;
 Thu, 26 Jan 2023 08:18:17 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 62F8C60E18
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 62F8C60E18
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Jan 2023 08:18:17 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5aed4b.dynamic.kabel-deutschland.de
 [95.90.237.75])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 0986D61CC457B;
 Thu, 26 Jan 2023 09:18:13 +0100 (CET)
Message-ID: <dab01afa-cb7e-16ac-5498-918c60955c6e@molgen.mpg.de>
Date: Thu, 26 Jan 2023 09:18:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
To: Karen Ostrowska <karen.ostrowska@intel.com>
References: <20230125160149.1899331-1-karen.ostrowska@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230125160149.1899331-1-karen.ostrowska@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH net v1] ice: Fix DSCP PFC TLV creation
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
Cc: intel-wired-lan@lists.osuosl.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

RGVhciBLYXJlbiwKCgpUaGFuayB5b3UgZm9yIHRoZSBwYXRjaC4KCkFtIDI1LjAxLjIzIHVtIDE3
OjAxIHNjaHJpZWIgS2FyZW4gT3N0cm93c2thOgo+IEZyb206IERhdmUgRXJ0bWFuIDxkYXZpZC5t
LmVydG1hbkBpbnRlbC5jb20+Cj4gCj4gV2hlbiBjcmVhdGluZyB0aGUgVExWIHRvIHNlbmQgdG8g
dGhlIEZXIGZvciBjb25maWd1cmluZyBEU0NQCj4gbW9kZSBQRkMsIHRoZSBQRkNFTkFCTEUgZmll
bGQgd2FzIGJlaW5nIG1hc2tlZCB3aXRoIGEgNCBiaXQKPiBtYXNrICgweEYpLCBidXQgdGhpcyBp
cyBhbiA4IGJpdCBiaXRtYXNrIGZvciBlbmFibGVkIGNsYXNzZXMKPiBmb3IgUEZDLiAgVGhpcyBt
ZWFucyB0aGF0IHRyYWZmaWMgY2xhc3NlcyA0LTcgY291bGQgbm90IGJlCj4gZW5hYmxlZCBmb3Ig
UEZDLgo+IAo+IFJlbW92ZSB0aGUgbWFzayBjb21wbGV0ZWx5LCBhcyBpdCBpcyBub3QgbmVjZXNz
YXJ5LCBhcyB3ZSBhcmUKPiBhc3NpZ25pbmcgOGJpdHMgdG8gYW4gOCBiaXQgZmllbGQuCgpQbGVh
c2UgcmVmbG93IHRoZSB0ZXh0IHRvIHVzZSB0aGUgZnVsbCA3NSBjaGFyYWN0ZXJzIG9mIGFsbG93
ZWQgdGV4dCB3aWR0aC4KClBsZWFzZSBhZGQgYSBzcGFjZSBpbiDigJw4IGJpdHPigJ0uCgo+IEZp
eGVzOiAyYTg3YmQ3M2U1MGQoImljZTogQWRkIERTQ1Agc3VwcG9ydCIpCgpQbGVhc2UgYWRkIGEg
c3BhY2UgYWZ0ZXIgdGhlIGNvbW1pdCBoYXNoIGJlZm9yZSB0aGUgKC4KCj4gU2lnbmVkLW9mZi1i
eTogRGF2ZSBFcnRtYW4gPGRhdmlkLm0uZXJ0bWFuQGludGVsLmNvbT4KPiBTaWduZWQtb2ZmLWJ5
OiBLYXJlbiBPc3Ryb3dza2EgPGthcmVuLm9zdHJvd3NrYUBpbnRlbC5jb20+Cj4gLS0tCj4gICBk
cml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX2RjYi5jIHwgMiArLQo+ICAgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4gCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfZGNiLmMgYi9kcml2ZXJzL25ldC9l
dGhlcm5ldC9pbnRlbC9pY2UvaWNlX2RjYi5jCj4gaW5kZXggNmJlMDJmOWIwYjhjLi43ODliOTk5
NjM5MTAgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9k
Y2IuYwo+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfZGNiLmMKPiBA
QCAtMTM3Miw3ICsxMzcyLDcgQEAgaWNlX2FkZF9kc2NwX3BmY190bHYoc3RydWN0IGljZV9sbGRw
X29yZ190bHYgKnRsdiwgc3RydWN0IGljZV9kY2J4X2NmZyAqZGNiY2ZnKQo+ICAgCXRsdi0+b3Vp
c3VidHlwZSA9IGh0b25sKG91aXN1YnR5cGUpOwo+ICAgCj4gICAJYnVmWzBdID0gZGNiY2ZnLT5w
ZmMucGZjY2FwICYgMHhGOwo+IC0JYnVmWzFdID0gZGNiY2ZnLT5wZmMucGZjZW5hICYgMHhGOwo+
ICsJYnVmWzFdID0gZGNiY2ZnLT5wZmMucGZjZW5hOwo+ICAgfQo+ICAgCj4gICAvKioKCgpLaW5k
IHJlZ2FyZHMsCgpQYXVsCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCkludGVsLXdpcmVkLWxhbiBtYWlsaW5nIGxpc3QKSW50ZWwtd2lyZWQtbGFuQG9zdW9z
bC5vcmcKaHR0cHM6Ly9saXN0cy5vc3Vvc2wub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtd2ly
ZWQtbGFuCg==
