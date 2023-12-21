Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6201C35274
	for <intel-wired-lan@archiver.kernel.org>; Thu, 21 Dec 2023 15:35:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 645AA423E4;
	Thu, 21 Dec 2023 15:35:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 645AA423E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1703172931;
	bh=09KJd3RIqj8GUgnPv0DL3rWeTThcHNGQHcDBR1bZOcg=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=vP0PEGWUgcxqm2Gf6jEJWrnFdvsOrKss0PxMjyQHWwp6s71GtV3uJSAWNwG2wZO4D
	 el/OQcr8mHFFlV2zS1CnvJCJAx/EH8Krlr4D8w+kRGkPhFi0K7rbWxFK2G+Rd6cylG
	 E4C0nZGEH9kD8FQFMeIfJW3xlgJLuxdyQz9yiDgkjSoynRd1grm3Txy2sj0NG2ZDjF
	 RtLS4SWSoh8t9sABDnfyrCHbT5xeVkjmrLvtBZs2fO95uPnh5qJw+jXHvbIWEfuqgp
	 P6jH8eSZVdc8+gqa8tcZt9iG0c+UCivWEsczWFU7zRxa9wByWY104hNJn1O5ekksBq
	 YaxNXv3D3a1BA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wf8sV_9rk7cc; Thu, 21 Dec 2023 15:35:30 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 63F3D423F2;
	Thu, 21 Dec 2023 15:35:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 63F3D423F2
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 670011BF381
 for <intel-wired-lan@lists.osuosl.org>; Thu, 21 Dec 2023 15:35:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3292E437F9
 for <intel-wired-lan@lists.osuosl.org>; Thu, 21 Dec 2023 15:35:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3292E437F9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qo-U5nusD9tj for <intel-wired-lan@lists.osuosl.org>;
 Thu, 21 Dec 2023 15:35:27 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4F1F0402E6
 for <intel-wired-lan@lists.osuosl.org>; Thu, 21 Dec 2023 15:35:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4F1F0402E6
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 0044B6198E;
 Thu, 21 Dec 2023 15:35:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66998C433C8;
 Thu, 21 Dec 2023 15:35:23 +0000 (UTC)
Date: Thu, 21 Dec 2023 16:35:19 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Message-ID: <20231221153519.GB1056991@kernel.org>
References: <20231220173837.3326983-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231220173837.3326983-1-aleksandr.loktionov@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1703172925;
 bh=MRVxiUU/5WhXcsoURMm4LApVrWo9wUSaDt/JjoevQs8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tJCPJQpPNph9pG0BBZn/XdIkiSaFTgkKt/OQTQlWywW92h8xv3o20oUswuydj5Yu1
 zjur+uQiynr2diojouIXHrNHU/SLwWlf3zYEphwQGqgHFGYh2IREMTxnnFQs34ACQ+
 xUnBkNB1nWKiCMggrmbAjhVIQsj/qSy/vlYqazcO6HB81JZCAlt7hAQBfJSFAHk72j
 4KQfGzW4qZqCMH5flhX9V5ky2uTsbZveDVf36vUTNbC2B4yYB+3Ih+Do9oMKNr8nU0
 8+H6nZ7vHbwGCv8LYuKiaufZgCzZUiGLErxLDArOYGA0+FkMTntvs5/wv3BD0J5XOd
 NBy4aFLzEBtJw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=tJCPJQpP
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2] i40e: add trace events
 related to SFP module IOCTLs
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
Cc: anthony.l.nguyen@intel.com, intel-wired-lan@lists.osuosl.org,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

T24gV2VkLCBEZWMgMjAsIDIwMjMgYXQgMDY6Mzg6MzdQTSArMDEwMCwgQWxla3NhbmRyIExva3Rp
b25vdiB3cm90ZToKPiBBZGQgdHJhY2UgZXZlbnRzIHJlbGF0ZWQgdG8gU0ZQIG1vZHVsZSBJT0NU
THMgZm9yIHRyb3VibGVzaG9vdGluZy4KPiAKPiBFeGFtcGxlOgo+ICAgICAgICAgZWNobyAiaTQw
ZV8qIiA+L3N5cy9rZXJuZWwvdHJhY2luZy9zZXRfZnRyYWNlX2ZpbHRlcgo+ICAgICAgICAgZWNo
byAiaTQwZV9pb2N0bCoiID4vc3lzL2tlcm5lbC90cmFjaW5nL2V2ZW50cy9pNDBlL2ZpbHRlcgo+
ICAgICAgICAgZWNobyAxICA+L3N5cy9rZXJuZWwvdHJhY2luZy90cmFjaW5nX29uCj4gICAgICAg
ICBlY2hvIDEgID4vc3lzL2tlcm5lbC90cmFjaW5nL2V2ZW50cy9pNDBlL2VuYWJsZQo+ICAgICAg
ICAgLi4uCj4gICAgICAgICBjYXQgICAgIC9zeXMva2VybmVsL3RyYWNpbmcvdHJhY2UKPiAKPiBS
aWV3ZWQtYnk6IFByemVtZWsgS2l0c3plbCA8cHJ6ZW15c2xhdy5raXRzemVsQGludGVsLmNvbT4K
PiBTaWduZWQtb2ZmLWJ5OiBBbGVrc2FuZHIgTG9rdGlvbm92IDxhbGVrc2FuZHIubG9rdGlvbm92
QGludGVsLmNvbT4KPiAtLS0KPiB2MS0+djIgYXBwbGllZCB0byBwcm9wZXIgZ2l0IGJyYW5jaAo+
IC0tLQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pNDBlL2k0MGVfZXRodG9vbC5jIHwg
IDUgKysrKysKPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaTQwZS9pNDBlX3RyYWNlLmgg
ICB8IDE4ICsrKysrKysrKysrKysrKysrKwo+ICAyIGZpbGVzIGNoYW5nZWQsIDIzIGluc2VydGlv
bnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaTQwZS9p
NDBlX2V0aHRvb2wuYyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2k0MGUvaTQwZV9ldGh0
b29sLmMKPiBpbmRleCBjODQxNzc5Li5iZGYyYjZiIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvbmV0
L2V0aGVybmV0L2ludGVsL2k0MGUvaTQwZV9ldGh0b29sLmMKPiArKysgYi9kcml2ZXJzL25ldC9l
dGhlcm5ldC9pbnRlbC9pNDBlL2k0MGVfZXRodG9vbC5jCj4gQEAgLTEwNzQsNiArMTA3NCw3IEBA
IHN0YXRpYyBpbnQgaTQwZV9nZXRfbGlua19rc2V0dGluZ3Moc3RydWN0IG5ldF9kZXZpY2UgKm5l
dGRldiwKPiAgCWV0aHRvb2xfbGlua19rc2V0dGluZ3NfemVyb19saW5rX21vZGUoa3MsIHN1cHBv
cnRlZCk7Cj4gIAlldGh0b29sX2xpbmtfa3NldHRpbmdzX3plcm9fbGlua19tb2RlKGtzLCBhZHZl
cnRpc2luZyk7Cj4gIAo+ICsJaTQwZV90cmFjZShpb2N0bF9nZXRfbGlua19rc2V0dGluZ3MsIHBm
LCBod19saW5rX2luZm8tPmxpbmtfaW5mbyk7Cj4gIAlpZiAobGlua191cCkKPiAgCQlpNDBlX2dl
dF9zZXR0aW5nc19saW5rX3VwKGh3LCBrcywgbmV0ZGV2LCBwZik7Cj4gIAllbHNlCgpIaSBBbGVr
c2FuZHIsCgpJIHRoaW5rIHRoYXQgaTQwZV90cmFjZS5oIG5lZWRzIHRvIGJlIGluY2x1ZGVkIGlu
IGk0MGVfZXRodG9vbC5jCmFzIHBhcnQgb2YgdGhpcyBwYXRjaC4KCiAuLi4vaTQwZV9ldGh0b29s
LmM6IEluIGZ1bmN0aW9uIOKAmGk0MGVfZ2V0X2xpbmtfa3NldHRpbmdz4oCZOgogLi4uL2k0MGVf
ZXRodG9vbC5jOjEwNzc6OTogZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9u
IOKAmGk0MGVfdHJhY2XigJkgWy1XZXJyb3I9aW1wbGljaXQtZnVuY3Rpb24tZGVjbGFyYXRpb25d
CiAxMDc3IHwgICAgICAgICBpNDBlX3RyYWNlKGlvY3RsX2dldF9saW5rX2tzZXR0aW5ncywgcGYs
IGh3X2xpbmtfaW5mby0+bGlua19pbmZvKTsKICAgICAgfCAgICAgICAgIF5+fn5+fn5+fn4KCi4u
LgoKRmxhZ2dlZCBieSBnY2MtMTMgVz0xIGJ1aWxkCgouLi4KCi0tIApwdy1ib3Q6IGNoYW5nZXMt
cmVxdWVzdGVkCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkludGVsLXdpcmVkLWxhbiBtYWlsaW5nIGxpc3QKSW50ZWwtd2lyZWQtbGFuQG9zdW9zbC5vcmcK
aHR0cHM6Ly9saXN0cy5vc3Vvc2wub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtd2lyZWQtbGFu
Cg==
