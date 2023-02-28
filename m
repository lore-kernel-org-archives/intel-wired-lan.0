Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D6D5C64ED6
	for <intel-wired-lan@archiver.kernel.org>; Tue, 28 Feb 2023 15:40:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4126D60017;
	Tue, 28 Feb 2023 15:40:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4126D60017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1677598836;
	bh=0agB2RRWxZwQLDJt5rgLu0HTNUhyJzqoRiKkTCQEqh4=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=XKfoQOp2GPyAIWxpHEz/iAii3VeEzLiOXr8/uZXb83eIObm5bnHUafeIzJ07Tw6+1
	 fh3653e8XX2bwwxg6TqLSoEFbQQ862szXtF84IhTNgQYAjZly/S3aqF99A4Vb6pSxn
	 FX5Ov2jrwvgLoxk2xJjuSTEzKlT7sXlnxONk/XvTtpDMqb8cTvAWniegMgMJwu0X1G
	 gjdlBT+XTFAouv2VyDHwR5gBH4Z+GbGonlWXWtsUjZcWeHoEOmEZlm7xXgfvOeHgPL
	 WCCnWaDlZh+WbExF/ugVN6CVcJ1twHPmHFCwIDpgNfIygayOTr6iJkUjz7zaP3JevQ
	 /yCuzL4rmeQLw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MF1vBTqg6rBH; Tue, 28 Feb 2023 15:40:35 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2BEED606E7;
	Tue, 28 Feb 2023 15:40:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2BEED606E7
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id E35031BF2AA
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Feb 2023 15:40:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BC24441902
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Feb 2023 15:40:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BC24441902
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9_bwQD4gLpSL for <intel-wired-lan@lists.osuosl.org>;
 Tue, 28 Feb 2023 15:40:31 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9420B418EF
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9420B418EF
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Feb 2023 15:40:31 +0000 (UTC)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 4FAD06244DFBA;
 Tue, 28 Feb 2023 16:40:28 +0100 (CET)
Message-ID: <4434d991-a5e5-4499-2045-89ece2940385@molgen.mpg.de>
Date: Tue, 28 Feb 2023 16:40:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To: Alexander Lobakin <aleksander.lobakin@intel.com>
References: <20230228084915.2866564-1-kalyan.kodamagula@intel.com>
 <08101843-9284-a9ae-8898-559ef2ed6a20@intel.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <08101843-9284-a9ae-8898-559ef2ed6a20@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH net-next] ice: Fix implicit cast u32
 to u16
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
Cc: intel-wired-lan@lists.osuosl.org, Marcin Szycik <marcin.szycik@intel.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

RGVhciBBbGV4YW5kZXIsCgoKQW0gMjguMDIuMjMgdW0gMTY6Mjkgc2NocmllYiBBbGV4YW5kZXIg
TG9iYWtpbjoKPiBGcm9tOiBLYWx5YW4gS29kYW1hZ3VsYSA8a2FseWFuLmtvZGFtYWd1bGFAaW50
ZWwuY29tPgo+IERhdGU6IFR1ZSwgMjggRmViIDIwMjMgMDk6NDk6MTUgKzAxMDAKPiAKPj4gRnJv
bTogTWFyY2luIFN6eWNpayA8bWFyY2luLnN6eWNpa0BpbnRlbC5jb20+Cj4+Cj4+IEZpeCBpbXBs
aWNpdCBjYXN0IGJ5IGNoYW5naW5nIGFyZ3VtZW50IHR5cGVzIG9mIHR3byBmdW5jdGlvbnMgdG8g
Y29ycmVjdAo+PiB0eXBlcy4KPj4KPj4gU2lnbmVkLW9mZi1ieTogTWFyY2luIFN6eWNpayA8bWFy
Y2luLnN6eWNpa0BpbnRlbC5jb20+Cj4+IFNpZ25lZC1vZmYtYnk6IEthbHlhbiBLb2RhbWFndWxh
IDxrYWx5YW4ua29kYW1hZ3VsYUBpbnRlbC5jb20+Cj4gCj4gUmVnYXJkaW5nIHRoZSBhY3R1YWwg
cGF0Y2ggKGJlbG93KSwKPiAKPj4gLS0tCj4+ICAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwv
aWNlL2ljZV9kZHAuYyB8IDQgKystLQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5l
dC9pbnRlbC9pY2UvaWNlX2RkcC5jIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2lj
ZV9kZHAuYwo+PiBpbmRleCBkNzFlZDIxMGY5YzQuLjgzMGZhNTNiNWUwYSAxMDA2NDQKPj4gLS0t
IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9kZHAuYwo+PiArKysgYi9kcml2
ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX2RkcC5jCj4+IEBAIC03MDEsMTQgKzcwMSwx
NCBAQCBzdHJ1Y3QgaWNlX2J1Zl9idWlsZCAqaWNlX3BrZ19idWZfYWxsb2Moc3RydWN0IGljZV9o
dyAqaHcpCj4+ICAgCXJldHVybiBibGQ7Cj4+ICAgfQo+PiAgIAo+PiAtc3RhdGljIGJvb2wgaWNl
X2lzX2d0cF91X3Byb2ZpbGUodTE2IHByb2ZfaWR4KQo+PiArc3RhdGljIGJvb2wgaWNlX2lzX2d0
cF91X3Byb2ZpbGUodTMyIHByb2ZfaWR4KQo+PiAgIHsKPj4gICAJcmV0dXJuIChwcm9mX2lkeCA+
PSBJQ0VfUFJPRklEX0lQVjZfR1RQVV9URUlEICYmCj4+ICAgCQlwcm9mX2lkeCA8PSBJQ0VfUFJP
RklEX0lQVjZfR1RQVV9JUFY2X1RDUF9JTk5FUikgfHwKPj4gICAJICAgICAgIHByb2ZfaWR4ID09
IElDRV9QUk9GSURfSVBWNF9HVFBVX1RFSUQ7Cj4+ICAgfQo+PiAgIAo+PiAtc3RhdGljIGJvb2wg
aWNlX2lzX2d0cF9jX3Byb2ZpbGUodTE2IHByb2ZfaWR4KQo+PiArc3RhdGljIGJvb2wgaWNlX2lz
X2d0cF9jX3Byb2ZpbGUodTMyIHByb2ZfaWR4KQo+PiAgIHsKPj4gICAJc3dpdGNoIChwcm9mX2lk
eCkgewo+PiAgIAljYXNlIElDRV9QUk9GSURfSVBWNF9HVFBDX1RFSUQ6Cj4gCj4gV2hhdCBpcyB0
aGlzIGNoYW5nZSByZWFsbHkgYWJvdXQ/IEl0IG1pZ2h0J3ZlIGJlZW4gYSBwYXJ0IG9mIHNvbWUg
YmlnZ2VyCj4gc2VyaWVzLCBpc24ndCBpdD8gRG9lcyBpdCBmaXggYW55IHRydW5jYXRpbmctcmVs
YXRlZCBidWdzIG9yIGltcHJvdmUKPiBjb2RlZ2VuLCB3aGljaCBjb3VsZCBiZSBvYnNlcnZlZCBi
eSBvYmpkaWZmIG9yIGJsb2F0LW8tbWV0ZXI/IEl0IGZlZWxzCj4gY29tcGxldGVseSBvdXQgb2Yg
Y29udGV4dC4KCkkgYXNrZWQgbXlzZWxmIHRoZSBzYW1lIHRoaW5nIHJpZ2h0IG5vdyByZWFkaW5n
IHlvdXIgb3RoZXIgcmVwbHk6CgpgYGAKLyoqCiAgKiBpY2VfZ2V0X3N3X3Byb2ZfdHlwZSAtIGRl
dGVybWluZSBzd2l0Y2ggcHJvZmlsZSB0eXBlCiAgKiBAaHc6IHBvaW50ZXIgdG8gdGhlIEhXIHN0
cnVjdHVyZQogICogQGZ2OiBwb2ludGVyIHRvIHRoZSBzd2l0Y2ggZmllbGQgdmVjdG9yCiAgKiBA
cHJvZl9pZHg6IHByb2ZpbGUgaW5kZXggdG8gY2hlY2sKICAqLwpzdGF0aWMgZW51bSBpY2VfcHJv
Zl90eXBlIGljZV9nZXRfc3dfcHJvZl90eXBlKHN0cnVjdCBpY2VfaHcgKmh3LAogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgaWNlX2Z2ICpmdiwg
dTMyIApwcm9mX2lkeCkKewogICAgICAgICB1MTYgaTsKCiAgICAgICAgIGlmIChpY2VfaXNfZ3Rw
X2NfcHJvZmlsZShwcm9mX2lkeCkpCiAgICAgICAgICAgICAgICAgcmV0dXJuIElDRV9QUk9GX1RV
Tl9HVFBDOwoKICAgICAgICAgaWYgKGljZV9pc19ndHBfdV9wcm9maWxlKHByb2ZfaWR4KSkKICAg
ICAgICAgICAgICAgICByZXR1cm4gSUNFX1BST0ZfVFVOX0dUUFU7Cgpb4oCmXQpgYGAKCkkgdGhp
bmsgdGhleSBtZWFuIHRoYXQgdGhlIHNpZ25hdHVyZSBvZiBpY2VfcHJvZl90eXBlIAppY2VfZ2V0
X3N3X3Byb2ZfdHlwZSgpIHRha2VzIHByb2ZfaWR4IGFzIHUzMi4KCgpLaW5kIHJlZ2FyZHMsCgpQ
YXVsCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkludGVs
LXdpcmVkLWxhbiBtYWlsaW5nIGxpc3QKSW50ZWwtd2lyZWQtbGFuQG9zdW9zbC5vcmcKaHR0cHM6
Ly9saXN0cy5vc3Vvc2wub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtd2lyZWQtbGFuCg==
