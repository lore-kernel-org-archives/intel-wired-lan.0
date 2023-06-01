Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15A15C7EE23
	for <intel-wired-lan@archiver.kernel.org>; Thu,  1 Jun 2023 05:34:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9113F81ED4;
	Thu,  1 Jun 2023 05:34:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9113F81ED4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1685597682;
	bh=YAyIX3E0qKQudDbiYMPhJB4BfvFp16rNiMMSAl4pcSk=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=bWmF4eXdw8Gp6kVFeqmU0R1uUCo+puy0HytrPMvfNyCNJNKXZEZQciIbl64DTiMEB
	 vU0w1OOfsO52uj36O8XKrjfnMHrHfBB5DWxF5i3pH+87RRGk+VHTjJ7jrSZjT+L93S
	 E2muu+XrsIocTxbGsCIV8kIETYbMgwjYauNhBFJ9ehSvspvUaIggvSpJbmBueWK8Vu
	 QkKtW4d+80yjF29Ud4m52XpUEkC05dFKVTRUgGqrUaHeGXYK57eR10nhafbMGn2f/D
	 hE0hLxuAzkev7SRk0Cxo+nFRSppcBR+kcbNUz6wAc4Kr9jZkBUzR8T3Gqe2ugs1tdj
	 9tfDW4h7s1n0g==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BeY75lMVPnI3; Thu,  1 Jun 2023 05:34:41 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 95B3581ED9;
	Thu,  1 Jun 2023 05:34:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 95B3581ED9
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id BEDEF1BF852
 for <intel-wired-lan@lists.osuosl.org>; Thu,  1 Jun 2023 05:34:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A10A361199
 for <intel-wired-lan@lists.osuosl.org>; Thu,  1 Jun 2023 05:34:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A10A361199
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FLwG3H_nu3Cy for <intel-wired-lan@lists.osuosl.org>;
 Thu,  1 Jun 2023 05:34:38 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BF4A86110B
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BF4A86110B
 for <intel-wired-lan@lists.osuosl.org>; Thu,  1 Jun 2023 05:34:38 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5aef03.dynamic.kabel-deutschland.de
 [95.90.239.3])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id B3F0361DFA913;
 Thu,  1 Jun 2023 07:33:53 +0200 (CEST)
Message-ID: <92180324-fa55-5427-839e-d555ac5a6cd7@molgen.mpg.de>
Date: Thu, 1 Jun 2023 07:33:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To: Yuezhen Luan <eggcar.luan@gmail.com>
References: <20230531090805.3959-1-eggcar.luan@gmail.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230531090805.3959-1-eggcar.luan@gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH] igb: Fix extts capture value format
 for 82580/i354/i350
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
Cc: netdev@vger.kernel.org, jesse.brandeburg@intel.com,
 linux-kernel@vger.kernel.org, edumazet@google.com, anthony.l.nguyen@intel.com,
 intel-wired-lan@lists.osuosl.org, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

RGVhciBZdWV6aGVuLAoKClRoYW5rIHlvdSB2ZXJ5IG11Y2ggZm9yIHlvdXIgcGF0Y2guCgpBbSAz
MS4wNS4yMyB1bSAxMTowOCBzY2hyaWViIFl1ZXpoZW4gTHVhbjoKPiA4MjU4MC9pMzU0L2kzNTAg
ZmVhdHVyZXMgY2lyY2xlLWNvdW50ZXItbGlrZSB0aW1lc3RhbXAgcmVnaXN0ZXJzCj4gdGhhdCBh
cmUgZGlmZmVyZW50IHdpdGggbmV3ZXIgaTIxMC4gVGhlIEVYVFRTIGNhcHR1cmUgdmFsdWUgaW4K
PiBBVVhUU01QeCBzaG91bGQgYmUgY29udmVydGVkIGZyb20gcmF3IGNpcmNsZSBjb3VudGVyIHZh
bHVlIHRvCj4gdGltZXN0YW1wIHZhbHVlIGluIHJlc29sdXRpb24gb2YgMSBuYW5vc2VjIGJ5IHRo
ZSBkcml2ZXIuCgpJdOKAmWQgYmUgZ3JlYXQsIGlmIHlvdSBhZGRlZCBhIHBhcmFncmFwaCBob3cg
dG8gcmVwcm9kdWNlIHRoZSBpc3N1ZS4KCj4gU2lnbmVkLW9mZi1ieTogWXVlemhlbiBMdWFuIDxl
Z2djYXIubHVhbkBnbWFpbC5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRl
bC9pZ2IvaWdiX21haW4uYyB8IDggKysrKysrLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2Vy
dGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0
aGVybmV0L2ludGVsL2lnYi9pZ2JfbWFpbi5jIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwv
aWdiL2lnYl9tYWluLmMKPiBpbmRleCA1ODg3MmE0YzIuLjE4N2RhYThlZiAxMDA2NDQKPiAtLS0g
YS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZ2IvaWdiX21haW4uYwo+ICsrKyBiL2RyaXZl
cnMvbmV0L2V0aGVybmV0L2ludGVsL2lnYi9pZ2JfbWFpbi5jCj4gQEAgLTY5NDcsNiArNjk0Nyw3
IEBAIHN0YXRpYyB2b2lkIGlnYl9leHR0cyhzdHJ1Y3QgaWdiX2FkYXB0ZXIgKmFkYXB0ZXIsIGlu
dCB0c2ludHJfdHQpCj4gICAJc3RydWN0IGUxMDAwX2h3ICpodyA9ICZhZGFwdGVyLT5odzsKPiAg
IAlzdHJ1Y3QgcHRwX2Nsb2NrX2V2ZW50IGV2ZW50Owo+ICAgCXN0cnVjdCB0aW1lc3BlYzY0IHRz
Owo+ICsJdW5zaWduZWQgbG9uZyBmbGFnczsKCkkgZG8gbm90IHNlZSB0aGUgdmFyaWFibGUgKmZs
YWdzKiBiZWluZyB1c2VkLgoKPiAgIAo+ICAgCWlmIChwaW4gPCAwIHx8IHBpbiA+PSBJR0JfTl9T
RFApCj4gICAJCXJldHVybjsKPiBAQCAtNjk1NCw5ICs2OTU1LDEyIEBAIHN0YXRpYyB2b2lkIGln
Yl9leHR0cyhzdHJ1Y3QgaWdiX2FkYXB0ZXIgKmFkYXB0ZXIsIGludCB0c2ludHJfdHQpCj4gICAJ
aWYgKGh3LT5tYWMudHlwZSA9PSBlMTAwMF84MjU4MCB8fAo+ICAgCSAgICBody0+bWFjLnR5cGUg
PT0gZTEwMDBfaTM1NCB8fAo+ICAgCSAgICBody0+bWFjLnR5cGUgPT0gZTEwMDBfaTM1MCkgewo+
IC0JCXM2NCBucyA9IHJkMzIoYXV4c3RtcGwpOwo+ICsJCXU2NCBucyA9IHJkMzIoYXV4c3RtcGwp
Owo+ICAgCj4gLQkJbnMgKz0gKChzNjQpKHJkMzIoYXV4c3RtcGgpICYgMHhGRikpIDw8IDMyOwo+
ICsJCW5zICs9ICgodTY0KShyZDMyKGF1eHN0bXBoKSAmIDB4RkYpKSA8PCAzMjsKPiArCQlzcGlu
X2xvY2tfaXJxc2F2ZSgmYWRhcHRlci0+dGMsIG5zKTsKPiArCQlucyA9IHRpbWVjb3VudGVyX2N5
YzJ0aW1lKCZhZGFwdGVyLT50YywgbnMpOwo+ICsJCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmFk
YXB0ZXItPnRjLCBucyk7Cj4gICAJCXRzID0gbnNfdG9fdGltZXNwZWM2NChucyk7Cj4gICAJfSBl
bHNlIHsKPiAgIAkJdHMudHZfbnNlYyA9IHJkMzIoYXV4c3RtcGwpOwoKCktpbmQgcmVnYXJkcywK
ClBhdWwKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50
ZWwtd2lyZWQtbGFuIG1haWxpbmcgbGlzdApJbnRlbC13aXJlZC1sYW5Ab3N1b3NsLm9yZwpodHRw
czovL2xpc3RzLm9zdW9zbC5vcmcvbWFpbG1hbi9saXN0aW5mby9pbnRlbC13aXJlZC1sYW4K
