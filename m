Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09603E75458
	for <intel-wired-lan@archiver.kernel.org>; Tue,  3 Oct 2023 13:17:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8774441F60;
	Tue,  3 Oct 2023 13:17:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8774441F60
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1696339035;
	bh=QZxX717EVsIZzHrkkU83KRQsowX4O6jUJ0U6A8+nu8Y=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=HTbWyZkzJf3EGTdiX4XkZS3kFTcCXT+dPBnwmIyppVJQgJ0/+QwZn8DZp9t/cpSeF
	 5kLpuzn2ovR+XbdUEIH4bGH8lYQXdt6RIsHbOvdyOy9ae42RuBQr3AbkFu/cgHCe+Q
	 2fJhMzLKPLgvcYYfn3sldVtW69Gx+x0MvqyBWCmNFOqChXPg94Vpk4/8iaKOBaahAe
	 d6pBrdaXSY/GwE7Jd+8FkwtWGHAXJ8y1MgbhOSg8qaBh29Mt7ugkYrefU7+HL+uzOk
	 vt3iwOUZqSF9Wj8Rm71iPMQQ9+iiq17MX6AjFHzvzzSSLYsRetvZoaYamvYP+zl61J
	 wN6aSNDkPWw/g==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GargYts1L062; Tue,  3 Oct 2023 13:17:14 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3AD0641F7E;
	Tue,  3 Oct 2023 13:17:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3AD0641F7E
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 493CD1BF3CD
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Oct 2023 13:17:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1AD0D40620
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Oct 2023 13:17:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1AD0D40620
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8cbgw2I_V-Z9 for <intel-wired-lan@lists.osuosl.org>;
 Tue,  3 Oct 2023 13:17:11 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1FF514060D
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Oct 2023 13:17:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1FF514060D
Received: from [192.168.0.185] (ip5f5ae806.dynamic.kabel-deutschland.de
 [95.90.232.6])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id B812C61E5FE01;
 Tue,  3 Oct 2023 15:16:50 +0200 (CEST)
Message-ID: <0e161808-d028-4351-b54c-6ac4ef3c7b91@molgen.mpg.de>
Date: Tue, 3 Oct 2023 15:16:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Jacob Keller <jacob.e.keller@intel.com>
References: <20230919233435.518620-1-jacob.e.keller@intel.com>
 <20230919233435.518620-5-jacob.e.keller@intel.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230919233435.518620-5-jacob.e.keller@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next 4/4] ice: cleanup
 ice_find_netlist_node
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
Cc: intel-wired-lan@lists.osuosl.org,
 Anthony Nguyen <anthony.l.nguyen@intel.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

RGVhciBKYWNvYiwKCgpUaGFuayB5b3UgZm9yIHlvdXIgcGF0Y2guIEEgc21hbGwgbml0IGZvciB0
aGUgc3ViamVjdDogVGhlIHZlcmIgKmNsZWFuIAp1cCogaXMgc3BlbGxlZCB3aXRoIGEgc3BhY2Uu
CgpBbSAyMC4wOS4yMyB1bSAwMTozNCBzY2hyaWViIEphY29iIEtlbGxlcjoKPiBUaGUgaWNlX2Zp
bmRfbmV0bGlzdF9ub2RlIGZ1bmN0aW9uIHdhcyBpbnRyb2R1Y2VkIGluIGNvbW1pdCA4YTNhNTY1
ZmYyMTAKPiAoImljZTogYWRkIGFkbWluIGNvbW1hbmRzIHRvIGFjY2VzcyBjZ3UgY29uZmlndXJh
dGlvbiIpLiBWYXJpYXRpb25zIG9mIHRoaXMKPiBmdW5jdGlvbiB3ZXJlIHJldmlld2VkIGNvbmN1
cnJlbnRseSBvbiBib3RoIGludGVsLXdpcmVkLWxhblsxXVsyXSwgYW5kCj4gbmV0ZGV2IFszXVs0
XQo+IAo+IFsxXTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvaW50ZWwtd2lyZWQtbGFuLzIwMjMw
OTEzMjA0OTQzLjEwNTEyMzMtNy12YWRpbS5mZWRvcmVua29AbGludXguZGV2Lwo+IFsyXTogaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvaW50ZWwtd2lyZWQtbGFuLzIwMjMwODE3MDAwMDU4LjI0MzMy
MzYtNS1qYWNvYi5lLmtlbGxlckBpbnRlbC5jb20vCj4gWzNdOiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9uZXRkZXYvMjAyMzA5MTgyMTI4MTQuNDM1Njg4LTEtYW50aG9ueS5sLm5ndXllbkBpbnRl
bC5jb20vCj4gWzRdOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9uZXRkZXYvMjAyMzA5MTMyMDQ5
NDMuMTA1MTIzMy03LXZhZGltLmZlZG9yZW5rb0BsaW51eC5kZXYvCj4gCj4gVGhlIHZhcmlhbnQg
SSBwb3N0ZWQgaGFkIGEgZmV3IGNoYW5nZXMgZHVlIHRvIHJldmlldyBmZWVkYmFjayB3aGljaCB3
ZXJlCj4gbmV2ZXIgaW5jb3Jwb3JhdGVkIGludG8gdGhlIERQTEwgc2VyaWVzOgo+IAo+ICogUmVw
bGFjZSB0aGUgcmVmZXJlbmNlcyB0byBhbmNpZW50IGFuZCBsb25nIHJlbW92ZWQgSUNFX1NVQ0NF
U1MgYW5kCj4gICAgSUNFX0VSUl9ET0VTX05PVF9FWElTVCBzdGF0dXMgY29kZXMgaW4gdGhlIGZ1
bmN0aW9uIGNvbW1lbnQuCj4gCj4gKiBSZXR1cm4gLUVOT0VOVCBpbnN0ZWFkIG9mIC1FTk9UQkxL
LCBhcyBhIG1vcmUgY29tbW9uIHdheSB0byBpbmRpY2F0ZSB0aGF0Cj4gICAgYW4gZW50cnkgZG9l
c24ndCBleGlzdC4KPiAKPiAqIEF2b2lkIHRoZSB1c2Ugb2YgbWVtc2V0KCkgYW5kIHVzZSBzaW1w
bGUgc3RhdGljIGluaXRpYWxpemF0aW9uIGZvciB0aGUKPiAgICBjbWQgdmFyaWFibGUuCj4gCj4g
KiBVc2UgRklFTERfUFJFUCB0byBhc3NpZ24gdGhlIG5vZGVfdHlwZV9jdHguCj4gCj4gKiBSZW1v
dmUgYW4gdW5uZWNlc3NhcnkgbG9jYWwgdmFyaWFibGUgdG8ga2VlcCB0cmFjayBvZiByZWNfbm9k
ZV9oYW5kbGUsCj4gICAganVzdCBwYXNzIHRoZSBub2RlX2hhbmRsZSBwb2ludGVyIGRpcmVjdGx5
IGludG8gaWNlX2FxX2dldF9uZXRsaXN0X25vZGUuCgpJZiB5b3UgbmVlZCB0byBlbnVtZXJhdGUg
Y2hhbmdlcywgd2l0aCBnaXQgaXTigJlzIGFsd2F5cyBnb29kIHRvIGRvIG9uZSAKY29tbWl0IHBl
ciBpdGVtLiA7LSkgKEJldHRlciB0byBiaXNlY3QgYW5kIHRvIHJldmVydC4pIEFueXdheSwgbm90
IAppbXBvcnRhbnQgZW5vdWdoLgoKPiBTaWduZWQtb2ZmLWJ5OiBKYWNvYiBLZWxsZXIgPGphY29i
LmUua2VsbGVyQGludGVsLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVs
L2ljZS9pY2VfY29tbW9uLmMgfCAzMCArKysrKysrKysrLS0tLS0tLS0tLS0KPiAgIDEgZmlsZSBj
aGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCAxNSBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9jb21tb24uYyBiL2RyaXZlcnMv
bmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfY29tbW9uLmMKPiBpbmRleCAxMmMwOTM3NGMyYmUu
LmQ0ZTI1OWI4MTZiOSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9p
Y2UvaWNlX2NvbW1vbi5jCj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2lj
ZV9jb21tb24uYwo+IEBAIC00NzMsNDEgKzQ3Myw0MSBAQCBpY2VfYXFfZ2V0X25ldGxpc3Rfbm9k
ZShzdHJ1Y3QgaWNlX2h3ICpodywgc3RydWN0IGljZV9hcWNfZ2V0X2xpbmtfdG9wbyAqY21kLAo+
ICAgICogQG5vZGVfcGFydF9udW1iZXI6IG5vZGUgcGFydCBudW1iZXIgdG8gbG9vayBmb3IKPiAg
ICAqIEBub2RlX2hhbmRsZTogb3V0cHV0IHBhcmFtZXRlciBpZiBub2RlIGZvdW5kIC0gb3B0aW9u
YWwKPiAgICAqCj4gLSAqIEZpbmQgYW5kIHJldHVybiB0aGUgbm9kZSBoYW5kbGUgZm9yIGEgZ2l2
ZW4gbm9kZSB0eXBlIGFuZCBwYXJ0IG51bWJlciBpbiB0aGUKPiAtICogbmV0bGlzdC4gV2hlbiBm
b3VuZCBJQ0VfU1VDQ0VTUyBpcyByZXR1cm5lZCwgSUNFX0VSUl9ET0VTX05PVF9FWElTVAo+IC0g
KiBvdGhlcndpc2UuIElmIG5vZGVfaGFuZGxlIHByb3ZpZGVkLCBpdCB3b3VsZCBiZSBzZXQgdG8g
Zm91bmQgbm9kZSBoYW5kbGUuCj4gKyAqIFNjYW4gdGhlIG5ldGxpc3QgZm9yIGEgbm9kZSBoYW5k
bGUgb2YgdGhlIGdpdmVuIG5vZGUgdHlwZSBhbmQgcGFydCBudW1iZXIuCj4gKyAqCj4gKyAqIElm
IG5vZGVfaGFuZGxlIGlzIG5vbi1OVUxMIGl0IHdpbGwgYmUgbW9kaWZpZWQgb24gZnVuY3Rpb24g
ZXhpdC4gSXQgaXMgb25seQo+ICsgKiB2YWxpZCBpZiB0aGUgZnVuY3Rpb24gcmV0dXJucyB6ZXJv
LCBhbmQgc2hvdWxkIGJlIGlnbm9yZWQgb24gYW55IG5vbi16ZXJvCj4gKyAqIHJldHVybiB2YWx1
ZS4KPiArICoKPiArICogUmV0dXJuczogMCBpZiB0aGUgbm9kZSBpcyBmb3VuZCwgLUVOT0VOVCBp
ZiBubyBoYW5kbGUgd2FzIGZvdW5kLCBhbmQKPiArICogYSBuZWdhdGl2ZSBlcnJvciBjb2RlIG9u
IGZhaWx1cmUgdG8gYWNjZXNzIHRoZSBBUS4KPiAgICAqLwo+ICAgc3RhdGljIGludCBpY2VfZmlu
ZF9uZXRsaXN0X25vZGUoc3RydWN0IGljZV9odyAqaHcsIHU4IG5vZGVfdHlwZV9jdHgsCj4gICAJ
CQkJIHU4IG5vZGVfcGFydF9udW1iZXIsIHUxNiAqbm9kZV9oYW5kbGUpCj4gICB7Cj4gLQlzdHJ1
Y3QgaWNlX2FxY19nZXRfbGlua190b3BvIGNtZDsKPiAtCXU4IHJlY19ub2RlX3BhcnRfbnVtYmVy
Owo+IC0JdTE2IHJlY19ub2RlX2hhbmRsZTsKPiAgIAl1OCBpZHg7Cj4gICAKPiAgIAlmb3IgKGlk
eCA9IDA7IGlkeCA8IElDRV9NQVhfTkVUTElTVF9TSVpFOyBpZHgrKykgewo+ICsJCXN0cnVjdCBp
Y2VfYXFjX2dldF9saW5rX3RvcG8gY21kID0ge307Cj4gKwkJdTggcmVjX25vZGVfcGFydF9udW1i
ZXI7Cj4gICAJCWludCBzdGF0dXM7Cj4gICAKPiAtCQltZW1zZXQoJmNtZCwgMCwgc2l6ZW9mKGNt
ZCkpOwo+IC0KPiAgIAkJY21kLmFkZHIudG9wb19wYXJhbXMubm9kZV90eXBlX2N0eCA9Cj4gLQkJ
CShub2RlX3R5cGVfY3R4IDw8IElDRV9BUUNfTElOS19UT1BPX05PREVfVFlQRV9TKTsKPiArCQkJ
RklFTERfUFJFUChJQ0VfQVFDX0xJTktfVE9QT19OT0RFX1RZUEVfTSwKPiArCQkJCSAgIG5vZGVf
dHlwZV9jdHgpOwo+ICAgCQljbWQuYWRkci50b3BvX3BhcmFtcy5pbmRleCA9IGlkeDsKPiAgIAo+
ICAgCQlzdGF0dXMgPSBpY2VfYXFfZ2V0X25ldGxpc3Rfbm9kZShodywgJmNtZCwKPiAgIAkJCQkJ
CSAmcmVjX25vZGVfcGFydF9udW1iZXIsCj4gLQkJCQkJCSAmcmVjX25vZGVfaGFuZGxlKTsKPiAr
CQkJCQkJIG5vZGVfaGFuZGxlKTsKPiAgIAkJaWYgKHN0YXR1cykKPiAgIAkJCXJldHVybiBzdGF0
dXM7Cj4gICAKPiAtCQlpZiAocmVjX25vZGVfcGFydF9udW1iZXIgPT0gbm9kZV9wYXJ0X251bWJl
cikgewo+IC0JCQlpZiAobm9kZV9oYW5kbGUpCj4gLQkJCQkqbm9kZV9oYW5kbGUgPSByZWNfbm9k
ZV9oYW5kbGU7Cj4gKwkJaWYgKHJlY19ub2RlX3BhcnRfbnVtYmVyID09IG5vZGVfcGFydF9udW1i
ZXIpCj4gICAJCQlyZXR1cm4gMDsKPiAtCQl9Cj4gICAJfQo+ICAgCj4gLQlyZXR1cm4gLUVOT1RC
TEs7Cj4gKwlyZXR1cm4gLUVOT0VOVDsKPiAgIH0KPiAgIAo+ICAgLyoqCgpSZXZpZXdlZC1ieTog
UGF1bCBNZW56ZWwgPHBtZW56ZWxAbW9sZ2VuLm1wZy5kZT4KCgpLaW5kIHJlZ2FyZHMsCgpQYXVs
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkludGVsLXdp
cmVkLWxhbiBtYWlsaW5nIGxpc3QKSW50ZWwtd2lyZWQtbGFuQG9zdW9zbC5vcmcKaHR0cHM6Ly9s
aXN0cy5vc3Vvc2wub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtd2lyZWQtbGFuCg==
