Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3302ECAAA1
	for <intel-wired-lan@archiver.kernel.org>; Fri, 28 Oct 2022 10:01:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5A816409A3;
	Fri, 28 Oct 2022 10:01:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5A816409A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1666951278;
	bh=1qDmSGtRqHwN/3Ghd9cuhGu7DUm1QWsiTnuIRrICcRM=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=tRpW+5sATqe9Gma5ocCk0ljhEfW7UzIKCC7BS9uPCOmkEibCs757PpDzLtHrdPYFr
	 yvUsKmA1tgTp4a3wbw5cUQ2V8RTZWmSgyLgVf+yj1aHxqmLhAD4EP2oVIUMYvHI80B
	 Okn2S6icqxiX7KqxonzEPRXSVCo46w/sJs3Ab9OL8X2yJf1SPvjs1Xb6MdGadhBqyx
	 QVFK1iRnIpjo7ZgJKmM+jzYpJYC/2GznTKk3+Q2iuBrudDyJCggBbC4EFG64WKG9uE
	 OdgR4O0O6eOWTnRijiW3Hp5I2x33bbfUn43me8i+yNkGJn0DW7MvzfkrulTK7uRZjr
	 zKs422ZhtW1Hw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e8DKyrpR2O2b; Fri, 28 Oct 2022 10:01:17 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 17A9B409B2;
	Fri, 28 Oct 2022 10:01:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 17A9B409B2
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id A441B1BF3E0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 28 Oct 2022 10:01:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 80FCF4014E
 for <intel-wired-lan@lists.osuosl.org>; Fri, 28 Oct 2022 10:01:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 80FCF4014E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UW9rKhvNffgH for <intel-wired-lan@lists.osuosl.org>;
 Fri, 28 Oct 2022 10:01:14 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C0642400AF
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C0642400AF
 for <intel-wired-lan@lists.osuosl.org>; Fri, 28 Oct 2022 10:01:13 +0000 (UTC)
Received: from [141.14.13.43] (g298.RadioFreeInternet.molgen.mpg.de
 [141.14.13.43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 870D161EA192A;
 Fri, 28 Oct 2022 12:01:10 +0200 (CEST)
Message-ID: <1bd57adb-49f1-3b90-541c-8d3d10963ccb@molgen.mpg.de>
Date: Fri, 28 Oct 2022 12:01:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>
References: <20221013050044.11862-1-akihiko.odaki@daynix.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20221013050044.11862-1-akihiko.odaki@daynix.com>
Subject: Re: [Intel-wired-lan] [PATCH] e1000e: Fix TX dispatch condition
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
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org,
 Yan Vugenfirer <yan@daynix.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

RGVhciBBa2loaWtvLAoKClRoYW5rIHlvdSB2ZXJ5IG11Y2ggZm9yIHRoZSBwYXRjaC4KCkFtIDEz
LjEwLjIyIHVtIDA3OjAwIHNjaHJpZWIgQWtpaGlrbyBPZGFraToKPiBlMTAwMF94bWl0X2ZyYW1l
IGlzIGV4cGVjdGVkIHRvIHN0b3AgdGhlIHF1ZXVlIGFuZCBkaXNwYXRjaCBmcmFtZXMgdG8KPiBo
YXJkd2FyZSBpZiB0aGVyZSBpcyBub3Qgc3VmZmljaWVudCBzcGFjZSBmb3IgdGhlIG5leHQgZnJh
bWUgaW4gdGhlCj4gYnVmZmVyLCBidXQgc29tZXRpbWVzIGl0IGZhaWxlZCB0byBkbyBzbyBiZWNh
dXNlIHRoZSBlc3RpbWF0ZWQgbWF4bWl1bQo+IHNpemUgb2YgZnJhbWUgd2FzIHdyb25nLiBBcyB0
aGUgY29uc2VxdWVuY2UsIHRoZSBsYXRlciBpbnZvY2F0aW9uIG9mCj4gZTEwMDBfeG1pdF9mcmFt
ZSBmYWlsZWQgd2l0aCBORVRERVZfVFhfQlVTWSwgYW5kIHRoZSBmcmFtZSBpbiB0aGUgYnVmZmVy
Cj4gcmVtYWluZWQgZm9yZXZlciwgcmVzdWx0aW5nIGluIGEgd2F0Y2hkb2cgZmFpbHVyZS4KPiAK
PiBUaGlzIGNoYW5nZSBmaXhlcyB0aGUgZXN0aW1hdGVkIHNpemUgYnkgbWFraW5nIGl0IG1hdGNo
IHdpdGggdGhlCj4gY29uZGl0aW9uIGZvciBORVRERVZfVFhfQlVTWS4gQXBwYXJlbnRseSwgdGhl
IG9sZCBlc3RpbWF0aW9uIGZhaWxlZCB0bwo+IGFjY291bnQgZm9yIHRoZSBmb2xsb3dpbmcgbGlu
ZXMgd2hpY2ggZGV0ZXJtaW5lcyB0aGUgc3BhY2UgcmVxdWlyZW1lbnQKPiBmb3Igbm90IGNhdXNp
bmcgTkVUREVWX1RYX0JVU1k6Cj4+IAkvKiByZXNlcnZlIGEgZGVzY3JpcHRvciBmb3IgdGhlIG9m
ZmxvYWQgY29udGV4dCAqLwo+PiAJaWYgKChtc3MpIHx8IChza2ItPmlwX3N1bW1lZCA9PSBDSEVD
S1NVTV9QQVJUSUFMKSkKPj4gCQljb3VudCsrOwo+PiAJY291bnQrKzsKPj4KPj4gCWNvdW50ICs9
IERJVl9ST1VORF9VUChsZW4sIGFkYXB0ZXItPnR4X2ZpZm9fbGltaXQpOwoKSeKAmWQganVzdCB1
c2UgTWFya2Rvd24gc3ludGF4LCBhbmQgaW5kZW50IGJ5IGZvdXIgc3BhY2VzIHdpdGhvdXQgPiBm
b3IgCmNpdGF0aW9uLgoKPiBUaGlzIGlzc3VlIHdhcyBmb3VuZCB3aXRoIGh0dHAtc3RyZXNzMDIg
dGVzdCBpbmNsdWRlZCBpbiBMaW51eCBUZXN0Cj4gUHJvamVjdCAyMDIyMDkzMC4KClNvIGl0IHdh
cyByZXByb2R1Y2VkIGluIFFFTVU/IEZvciBjb252ZW5pZW5jZSwgaXTigJlkIGJlIGdyZWF0IGlm
IHlvdSAKYWRkZWQgdGhlIFFFTVUgY29tbWFuZC4KCkFsc28sIGRvIHlvdSBrbm93IGlmIHRoaXMg
aXMgYSByZWdyZXNzaW9uPyBJZiBzbywgaXTigJlkIGJlIGdyZWF0IGlmIHlvdSAKYWRkZWQgdGhl
IEZpeGVzOiB0YWcuCgoKS2luZCByZWdhcmRzLAoKUGF1bAoKCj4gU2lnbmVkLW9mZi1ieTogQWtp
aGlrbyBPZGFraSA8YWtpaGlrby5vZGFraUBkYXluaXguY29tPgo+IC0tLQo+ICAgZHJpdmVycy9u
ZXQvZXRoZXJuZXQvaW50ZWwvZTEwMDBlL25ldGRldi5jIHwgNCArKy0tCj4gICAxIGZpbGUgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9lMTAwMGUvbmV0ZGV2LmMgYi9kcml2ZXJzL25ldC9l
dGhlcm5ldC9pbnRlbC9lMTAwMGUvbmV0ZGV2LmMKPiBpbmRleCAzMjFmMmE5NWFlM2EuLmRhMTEz
ZjUwMTFlOSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9lMTAwMGUv
bmV0ZGV2LmMKPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9lMTAwMGUvbmV0ZGV2
LmMKPiBAQCAtNTkzNiw5ICs1OTM2LDkgQEAgc3RhdGljIG5ldGRldl90eF90IGUxMDAwX3htaXRf
ZnJhbWUoc3RydWN0IHNrX2J1ZmYgKnNrYiwKPiAgIAkJZTEwMDBfdHhfcXVldWUodHhfcmluZywg
dHhfZmxhZ3MsIGNvdW50KTsKPiAgIAkJLyogTWFrZSBzdXJlIHRoZXJlIGlzIHNwYWNlIGluIHRo
ZSByaW5nIGZvciB0aGUgbmV4dCBzZW5kLiAqLwo+ICAgCQllMTAwMF9tYXliZV9zdG9wX3R4KHR4
X3JpbmcsCj4gLQkJCQkgICAgKE1BWF9TS0JfRlJBR1MgKgo+ICsJCQkJICAgICgoTUFYX1NLQl9G
UkFHUyArIDEpICoKPiAgIAkJCQkgICAgIERJVl9ST1VORF9VUChQQUdFX1NJWkUsCj4gLQkJCQkJ
CSAgYWRhcHRlci0+dHhfZmlmb19saW1pdCkgKyAyKSk7Cj4gKwkJCQkJCSAgYWRhcHRlci0+dHhf
Zmlmb19saW1pdCkgKyA0KSk7Cj4gICAKPiAgIAkJaWYgKCFuZXRkZXZfeG1pdF9tb3JlKCkgfHwK
PiAgIAkJICAgIG5ldGlmX3htaXRfc3RvcHBlZChuZXRkZXZfZ2V0X3R4X3F1ZXVlKG5ldGRldiwg
MCkpKSB7Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCklu
dGVsLXdpcmVkLWxhbiBtYWlsaW5nIGxpc3QKSW50ZWwtd2lyZWQtbGFuQG9zdW9zbC5vcmcKaHR0
cHM6Ly9saXN0cy5vc3Vvc2wub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtd2lyZWQtbGFuCg==
