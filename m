Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4652AC5479D
	for <intel-wired-lan@archiver.kernel.org>; Fri,  6 Jan 2023 08:49:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B8B17409C3;
	Fri,  6 Jan 2023 08:49:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B8B17409C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1672994950;
	bh=0WkYjiqXdpbObnzsa3B81SJH2nxj0GMmmSR6awLXkPA=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=RKQabyYK47rUfpl1eST9AwbjBAdm8B0fl7grPzQGYdXuhuPWZVYNKWsHCVcKymrqJ
	 18dR/dtRTM6qSNHA9kt3coiLdymvClSFMPVsGz5V+RkPl9P2UHek9joFqxji0ofSci
	 ZJRnJXPVB2jZGoyX41ovRCCjlf2Ce72umIl7HsLH/PjeVnp0HMPwpNMMcLFnuxAw14
	 tXF3GjyU6e7ELEZ8Yb69hUaDlOJyOlKSU9KAORbkFTeFPu1TQmeaM9SgD7cPfWbOQd
	 FH8GwGqRaLr1Y3rpBA9zfmag4r9C8zHRugPraKlCShRzLVhB4A6N6dNqjlE4g/141n
	 2uWWeRhyZm+9A==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jeLD4uMU38Tl; Fri,  6 Jan 2023 08:49:09 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9042E416BF;
	Fri,  6 Jan 2023 08:49:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9042E416BF
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 106901BF332
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Jan 2023 08:49:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DEAB2400B9
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Jan 2023 08:49:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DEAB2400B9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Rnup-vqIJgE8 for <intel-wired-lan@lists.osuosl.org>;
 Fri,  6 Jan 2023 08:49:06 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 23D82402DC
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 23D82402DC
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Jan 2023 08:49:05 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5ae967.dynamic.kabel-deutschland.de
 [95.90.233.103])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id C1A8360027FCF;
 Fri,  6 Jan 2023 09:49:02 +0100 (CET)
Message-ID: <86209fb7-6075-aa3c-f000-a587a1776112@molgen.mpg.de>
Date: Fri, 6 Jan 2023 09:49:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
References: <20230105221415.15394-1-paul.m.stillwell.jr@intel.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230105221415.15394-1-paul.m.stillwell.jr@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH net v4] ice: move devlink port
 creation/deletion
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

RGVhciBQYXVsLAoKClRoYW5rIHlvdSBmb3IgdGhlIHBhdGNoLgoKCkFtIDA1LjAxLjIzIHVtIDIz
OjE0IHNjaHJpZWIgUGF1bCBNIFN0aWxsd2VsbCBKcjoKPiBDb21taXQgYTI4NmJhNzM4NzE0ICgi
aWNlOiByZW9yZGVyIFBGL3JlcHJlc2VudG9yIGRldmxpbmsKPiBwb3J0IHJlZ2lzdGVyL3VucmVn
aXN0ZXIgZmxvd3MiKSBtb3ZlZCB0aGUgY29kZSB0byBjcmVhdGUKPiBhbmQgZGVzdHJveSB0aGUg
ZGV2bGluayBQRiBwb3J0LiBUaGlzIHdhcyBmaW5lLCBidXQgY3JlYXRlZAo+IGEgY29ybmVyIGNh
c2UgaXNzdWUgaW4gdGhlIGNhc2Ugb2YgaWNlX3JlZ2lzdGVyX25ldGRldigpCj4gZmFpbGluZy4g
SW4gdGhhdCBjYXNlLCB0aGUgZHJpdmVyIHdvdWxkIGVuZCB1cCBjYWxsaW5nCj4gaWNlX2Rldmxp
bmtfZGVzdHJveV9wZl9wb3J0KCkgdHdpY2UuCgpSZWFkaW5nIHRoZSBzdW1tYXJ5LCBJIHRob3Vn
aCBpdOKAmXMganVzdCBhIHJlZmFjdG9yaW5nLCBhbmQgbm90IGFsc28gYSAKZml4LiBNYXliZSB1
c2UKCkF2b2lkIGNhbGxpbmcgaWNlX2RldmxpbmtfZGVzdHJveV9wZl9wb3J0KCkgdHdpY2UKCm9y
IHNvbWV0aGluZyBzaW1pbGFyLgoKPiBBZGRpdGlvbmFsbHksIGl0IG1ha2VzIG5vIHNlbnNlIHRv
IHRpZSBjcmVhdGlvbiBvZiB0aGUgZGV2bGluawo+IFBGIHBvcnQgdG8gdGhlIGNyZWF0aW9uIG9m
IHRoZSBuZXRkZXYgc28gc2VwYXJhdGUgb3V0IHRoZQo+IGNvZGUgdG8gY3JlYXRlL2Rlc3Ryb3kg
dGhlIGRldmxpbmsgUEYgcG9ydCBmcm9tIHRoZSBuZXRkZXYKPiBjb2RlLiBUaGlzIG1ha2VzIGl0
IGEgY2xlYW5lciBpbnRlcmZhY2UuCgpJdOKAmWQgYmUgZ3JlYXQgaWYgeW91IHJlLWZsb3dlZCB0
aGUgYm9keSBmb3IgNzIgY2hhcmFjdGVycyBwZXIgbGluZS4gWW91IApzZWVtIHRvIHVzZSBsZXNz
LgoKPiBGaXhlczogYTI4NmJhNzM4NzE0ICgiaWNlOiByZW9yZGVyIFBGL3JlcHJlc2VudG9yIGRl
dmxpbmsgcG9ydCByZWdpc3Rlci91bnJlZ2lzdGVyIGZsb3dzIikKPiBTaWduZWQtb2ZmLWJ5OiBQ
YXVsIE0gU3RpbGx3ZWxsIEpyIDxwYXVsLm0uc3RpbGx3ZWxsLmpyQGludGVsLmNvbT4KPiAtLS0K
PiAgIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfbGliLmMgIHwgIDMgLS0tCj4g
ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX21haW4uYyB8IDI1ICsrKysrKysr
KysrKysrKy0tLS0tLS0tCj4gICAyIGZpbGVzIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDEx
IGRlbGV0aW9ucygtKQoKW+KApl0KCgpLaW5kIHJlZ2FyZHMsCgpQYXVsCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkludGVsLXdpcmVkLWxhbiBtYWlsaW5n
IGxpc3QKSW50ZWwtd2lyZWQtbGFuQG9zdW9zbC5vcmcKaHR0cHM6Ly9saXN0cy5vc3Vvc2wub3Jn
L21haWxtYW4vbGlzdGluZm8vaW50ZWwtd2lyZWQtbGFuCg==
