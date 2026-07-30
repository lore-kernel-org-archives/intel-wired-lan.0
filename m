Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B742C55167
	for <intel-wired-lan@archiver.kernel.org>; Thu, 30 Jul 2026 20:49:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0829E40D93;
	Thu, 30 Jul 2026 20:49:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O5v5AEwscPEV; Thu, 30 Jul 2026 20:49:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 09B4640D99
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785444541;
	bh=+JX9cWqUuW45m07C5RH0ARr6Sep3gbrZV1Hw7AxFGmk=;
	h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nhVf7ykUGntvv55XqlSz4eJhNwI/dtp5WhANvBN0jpnmvta0G/dN4hbsXviIk6PN1
	 ESAEXUySkEX61FED1u135p4yFCR19yearpLwWe1CjDxgWpPgbc5sKxFEQsYbDxZeJx
	 yDxfstKAmMGroiXRs8g4ypObwpQqLeskAhKxnt5qkHt3ZXYK8tl8RpKKZACXzsJuCm
	 iIOlkBWhWpzM6yQgJ6sZRASnMhENFPzMnZ7GYFeYcRXHE8Pt5TH59BkKBRr5C3mBUS
	 B85F5wi7iQb7S8lONZlFpGQAD29X1lhjarNSWLnOk6r9m8uAZG8FhFwmIABJlaVetI
	 yabiXpJNx4vSw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 09B4640D99;
	Thu, 30 Jul 2026 20:49:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8615827C
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Jul 2026 20:48:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6B8A640086
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Jul 2026 20:48:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kw0xvCcO6bJH for <intel-wired-lan@lists.osuosl.org>;
 Thu, 30 Jul 2026 20:48:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=202.36.163.20;
 helo=gate2.alliedtelesis.co.nz;
 envelope-from=chris.packham@alliedtelesis.co.nz; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 4A3674008B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4A3674008B
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz
 [202.36.163.20])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4A3674008B
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Jul 2026 20:48:56 +0000 (UTC)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id B754F2C02D0;
 Fri, 31 Jul 2026 08:48:51 +1200 (NZST)
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by
 svr-chch-seg1.atlnz.lc with Trustwave SEG (v8, 2, 6, 11305)
 id <B6a6bb8b30000>; Fri, 31 Jul 2026 08:48:51 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Fri, 31 Jul 2026 08:48:51 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1748.039; Fri, 31 Jul 2026 08:48:51 +1200
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, "przemyslaw.kitszel@intel.com"
 <przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
 <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "aleksander.lobakin@intel.com" <aleksander.lobakin@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Blair Steven
 <Blair.Steven@alliedtelesis.co.nz>, Carl Smith
 <Carl.Smith@alliedtelesis.co.nz>
Thread-Topic: [PATCH net-next] i40e: Avoid repeating RX filter warning
Thread-Index: AQHc4znbWyYjUBsJCUSplU0ijsiEzraE2zuAgAFU2YCAAAn1gA==
Date: Thu, 30 Jul 2026 20:48:51 +0000
Message-ID: <38bfcc78-ca4d-4f4c-b4de-5afa486be302@alliedtelesis.co.nz>
References: <20260514003733.1718771-1-chris.packham@alliedtelesis.co.nz>
 <c2f3acdd-9985-4d8f-bfc4-5d83f520f4a9@alliedtelesis.co.nz>
 <5f1456d9-a098-4459-8fe0-3a90c4db0ed3@intel.com>
In-Reply-To: <5f1456d9-a098-4459-8fe0-3a90c4db0ed3@intel.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.33.22.12]
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D25F770D98A8F4BA884C3BD633DC0B3@alliedtelesis.co.nz>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=O66avw9W c=1 sm=1 tr=0 ts=6a6bb8b3
 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=drD7vYo3kbIA:10
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=K7DEirGRrMXiwQqxwewA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=alliedtelesis.co.nz; 
 s=mail181024; t=1785444531;
 bh=+JX9cWqUuW45m07C5RH0ARr6Sep3gbrZV1Hw7AxFGmk=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:From;
 b=c9laAda2HkK/YjLzvFl4q4+Dqhforj5THWA1gnLD1ctdNTeX07W1Tpqxl4T/VdOnR
 oox6jiU1zViAnBw0MtIPLZJ5n0NSQz8mb8EYXWOcIiYI9THZh6fDQD1Hw30g2rGSFq
 noH+zB1GVXe02Zw3jRxg1ni3gMfuv/x5GnnyLm/1a4rdGuRlUZ+gIufJ2QfFEZnPiR
 gqjrbEYRsNGx/6act9KR7ftgwBqb0ma6kczJMlIhXXlxPy8v2p2heZpNeIY0aMm1sa
 yWGhQLW2W92XuiRhiml50Ur2mDOrp5xn9+eMnMPYCTKJkxfDaKGyYu/8ooYZJJak5a
 fwDcbLXAyuoSg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=alliedtelesis.co.nz
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz
 header.a=rsa-sha256 header.s=mail181024 header.b=c9laAda2
Subject: Re: [Intel-wired-lan] [PATCH net-next] i40e: Avoid repeating RX
 filter warning
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
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
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

T24gMzEvMDcvMjAyNiAwODoxMywgVG9ueSBOZ3V5ZW4gd3JvdGU6DQo+DQo+DQo+IE9uIDcvMjkv
MjAyNiA0OjUzIFBNLCBDaHJpcyBQYWNraGFtIHdyb3RlOg0KPj4gSGkgQWxsLA0KPj4NCj4+IE9u
IDE0LzA1LzIwMjYgMTI6MzcsIENocmlzIFBhY2toYW0gd3JvdGU6DQo+Pj4gV2hlbiB0aGUgaTQw
ZSBydW5zIG91dCBvZiBzcGFjZSBmb3IgUlggZmlsdGVycyB0aGUgZHJpdmVyIHN3aXRjaGVzIHRv
DQo+Pj4gcHJvbWlzY3VvdXMgbW9kZSBhbmQgd2FybnMgdGhhdCBpdCBoYXMgZG9uZSBzby4gSW4g
c2NlbmFyaW9zIHdpdGggYQ0KPj4+IGxhcmdlIG51bWJlciBvZiB0aGVzZSBmaWx0ZXJzIHRoaXMg
Y2FuIGdlbmVyYXRlIGEgbG90IG9mIHdhcm5pbmdzLiBGb3INCj4+PiBleGFtcGxlOg0KPj4+DQo+
Pj4gwqDCoMKgICQgZG1lc2cgLWMgPiAvZGV2L251bGwNCj4+PiDCoMKgwqAgJCBpcCBsaW5rIGFk
ZCBkZXYgYnIwIHR5cGUgYnJpZGdlIHZsYW5fZmlsdGVyaW5nIDEgDQo+Pj4gdmxhbl9kZWZhdWx0
X3B2aWQgMQ0KPj4+IMKgwqDCoCAkIGlwIGxpbmsgc2V0IGRldiBldGg3IG1hc3RlciBicjANCj4+
PiDCoMKgwqAgJCBicmlkZ2UgdmxhbiBhZGQgdmlkIDEgZGV2IGV0aDcgcHZpZCB1bnRhZ2dlZCBz
ZWxmDQo+Pj4gwqDCoMKgICQgYnJpZGdlIHZsYW4gYWRkIHZpZCAyLTQwOTQgZGV2IGV0aDcgdGFn
Z2VkDQo+Pj4gwqDCoMKgICQgZG1lc2cNCj4+PiDCoMKgwqAgW8KgwqAgMjUuNjAxNzA1XSBpNDBl
IDAwMDA6MDE6MDAuMTogRXJyb3IgTElCSUVfQVFfUkNfRU5PU1BDLCANCj4+PiBmb3JjaW5nIG92
ZXJmbG93IHByb21pc2N1b3VzIG9uIFBGDQo+Pj4gwqDCoMKgIFvCoMKgIDI1LjYwMTgzM10gaTQw
ZSAwMDAwOjAxOjAwLjE6IEVycm9yIExJQklFX0FRX1JDX0VOT1NQQywgDQo+Pj4gZm9yY2luZyBv
dmVyZmxvdyBwcm9taXNjdW91cyBvbiBQRg0KPj4+IMKgwqDCoCBbwqDCoCAyNS42MDE5NjFdIGk0
MGUgMDAwMDowMTowMC4xOiBFcnJvciBMSUJJRV9BUV9SQ19FTk9TUEMsIA0KPj4+IGZvcmNpbmcg
b3ZlcmZsb3cgcHJvbWlzY3VvdXMgb24gUEYNCj4+PiDCoMKgwqAgW8KgwqAgMjUuNjAyMDg4XSBp
NDBlIDAwMDA6MDE6MDAuMTogRXJyb3IgTElCSUVfQVFfUkNfRU5PU1BDLCANCj4+PiBmb3JjaW5n
IG92ZXJmbG93IHByb21pc2N1b3VzIG9uIFBGDQo+Pj4gwqDCoMKgIFvCoMKgIDI1LjYwMjIxNl0g
aTQwZSAwMDAwOjAxOjAwLjE6IEVycm9yIExJQklFX0FRX1JDX0VOT1NQQywgDQo+Pj4gZm9yY2lu
ZyBvdmVyZmxvdyBwcm9taXNjdW91cyBvbiBQRg0KPj4+IMKgwqDCoCBbwqDCoCAyNS42MDIzNDRd
IGk0MGUgMDAwMDowMTowMC4xOiBFcnJvciBMSUJJRV9BUV9SQ19FTk9TUEMsIA0KPj4+IGZvcmNp
bmcgb3ZlcmZsb3cgcHJvbWlzY3VvdXMgb24gUEYNCj4+PiDCoMKgwqAgLi4uDQo+Pj4NCj4+PiBV
c2UgdGVzdF9hbmRfc2V0X2JpdCgpIHNvIHRoYXQgdGhlIHdhcm5pbmcgaXMgb25seSBpc3N1ZWQg
d2hlbiB0aGUNCj4+PiBkcml2ZXIgZW5hYmxlcyBwcm9taXNjdW91cyBtb2RlIGFuZCBub3Qgb24g
dGhlIGFkZGl0aW9uIG9mIA0KPj4+IHN1YnNlcXVlbnQgUlgNCj4+PiBmaWx0ZXJzLg0KPj4+DQo+
Pj4gU2lnbmVkLW9mZi1ieTogQ2hyaXMgUGFja2hhbSA8Y2hyaXMucGFja2hhbUBhbGxpZWR0ZWxl
c2lzLmNvLm56Pg0KPj4+IC0tLQ0KPj4+DQo+Pj4gUmVzZW5kIHdpdGggbmV0LW5leHQgdGFnDQo+
Pg0KPj4gSGFzIHRoaXMgZmFsbGVuIHRocm91Z2ggdGhlIGNyYWNrcz8gSSd2ZSBzZWVuIHNvbWUg
UmV2aWV3ZWQtYnlzIGJ1dCBpdA0KPj4gZG9lc24ndCBzZWVtIHRvIGhhdmUgYmVlbiBwaWNrZWQg
dXAuDQo+DQo+IEhpIENocmlzLA0KPg0KPiBJIGhhdmUgaXQgaW4gbXkgcXVldWUgb2YgcGF0Y2hl
cyB0byBzZW5kIG91dCBidXQgSSdtIHdvcmtpbmcgbXkgd2F5IHRvIA0KPiBpdC4gSSBkbyBob3Bl
IHRvIGhhdmUgaXQgc2VudCBvbiBzb29uLg0KPg0KPiBUaGFua3MsDQo+IFRvbnkgDQoNCkhpIFRv
bnksDQoNClRoYW5rcyBmb3IgY29uZmlybWluZyB0aGF0LiBObyBodXJyeSBqdXN0IHRocm91Z2gg
dGhpcyBtaWdodCBiZSBzbyBzbWFsbCANCml0J2QgYmUgZWFzaWx5IGxvc3QgaW4gdGhlIHN3YXJt
IG9mIEFJIHRoYXQgd2UncmUgYWxsIGdldHRpbmcgY2F1Z2h0IHVwIGluLg0KDQo+Pj4NCj4+PiDC
oMKgIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2k0MGUvaTQwZV9tYWluLmMgfCAxOCArKysr
KysrKysrLS0tLS0tLS0NCj4+PiDCoMKgIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCsp
LCA4IGRlbGV0aW9ucygtKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVy
bmV0L2ludGVsL2k0MGUvaTQwZV9tYWluLmMgDQo+Pj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9p
bnRlbC9pNDBlL2k0MGVfbWFpbi5jDQo+Pj4gaW5kZXggOTI2ZDAwMWIyMTUwLi44NzQxOTkwYjVh
NWUgMTAwNjQ0DQo+Pj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaTQwZS9pNDBl
X21haW4uYw0KPj4+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2k0MGUvaTQwZV9t
YWluLmMNCj4+PiBAQCAtMjQwOCwxMCArMjQwOCwxMSBAQCB2b2lkIGk0MGVfYXFjX2FkZF9maWx0
ZXJzKHN0cnVjdCBpNDBlX3ZzaSANCj4+PiAqdnNpLCBjb25zdCBjaGFyICp2c2lfbmFtZSwNCj4+
PiDCoMKgIMKgwqDCoMKgwqDCoCBpZiAoZmNudCAhPSBudW1fYWRkKSB7DQo+Pj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqAgaWYgKHZzaS0+dHlwZSA9PSBJNDBFX1ZTSV9NQUlOKSB7DQo+Pj4gLcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgc2V0X2JpdChfX0k0MEVfVlNJX09WRVJGTE9XX1BST01JU0MsIHZz
aS0+c3RhdGUpOw0KPj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRldl93YXJuKCZ2c2ktPmJh
Y2stPnBkZXYtPmRldiwNCj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIkVy
cm9yICVzIGFkZGluZyBSWCBmaWx0ZXJzIG9uICVzLCBwcm9taXNjdW91cyANCj4+PiBtb2RlIGZv
cmNlZCBvblxuIiwNCj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbGliaWVf
YXFfc3RyKGFxX3N0YXR1cyksIHZzaV9uYW1lKTsNCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBpZiAoIXRlc3RfYW5kX3NldF9iaXQoX19JNDBFX1ZTSV9PVkVSRkxPV19QUk9NSVNDLCANCj4+
PiB2c2ktPnN0YXRlKSkgew0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGV2
X3dhcm4oJnZzaS0+YmFjay0+cGRldi0+ZGV2LA0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgICJFcnJvciAlcyBhZGRpbmcgUlggZmlsdGVycyBvbiAlcywgcHJv
bWlzY3VvdXMgDQo+Pj4gbW9kZSBmb3JjZWQgb25cbiIsDQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbGliaWVfYXFfc3RyKGFxX3N0YXR1cyksIHZzaV9uYW1l
KTsNCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9DQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqAgfSBlbHNlIGlmICh2c2ktPnR5cGUgPT0gSTQwRV9WU0lfU1JJT1YgfHwNCj4+PiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZzaS0+dHlwZSA9PSBJNDBFX1ZTSV9WTURRMSB8
fA0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdnNpLT50eXBlID09IEk0
MEVfVlNJX1ZNRFEyKSB7DQo+Pj4gQEAgLTI0NjEsMTAgKzI0NjIsMTEgQEAgaTQwZV9hcWNfYnJv
YWRjYXN0X2ZpbHRlcihzdHJ1Y3QgaTQwZV92c2kgDQo+Pj4gKnZzaSwgY29uc3QgY2hhciAqdnNp
X25hbWUsDQo+Pj4gwqDCoMKgwqDCoMKgIH0NCj4+PiDCoMKgIMKgwqDCoMKgwqDCoCBpZiAoYXFf
cmV0KSB7DQo+Pj4gLcKgwqDCoMKgwqDCoMKgIHNldF9iaXQoX19JNDBFX1ZTSV9PVkVSRkxPV19Q
Uk9NSVNDLCB2c2ktPnN0YXRlKTsNCj4+PiAtwqDCoMKgwqDCoMKgwqAgZGV2X3dhcm4oJnZzaS0+
YmFjay0+cGRldi0+ZGV2LA0KPj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIkVycm9yICVz
LCBmb3JjaW5nIG92ZXJmbG93IHByb21pc2N1b3VzIG9uICVzXG4iLA0KPj4+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgbGliaWVfYXFfc3RyKGh3LT5hcS5hc3FfbGFzdF9zdGF0dXMpLCB2c2lf
bmFtZSk7DQo+Pj4gK8KgwqDCoMKgwqDCoMKgIGlmICghdGVzdF9hbmRfc2V0X2JpdChfX0k0MEVf
VlNJX09WRVJGTE9XX1BST01JU0MsIA0KPj4+IHZzaS0+c3RhdGUpKSB7DQo+Pj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgZGV2X3dhcm4oJnZzaS0+YmFjay0+cGRldi0+ZGV2LA0KPj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiRXJyb3IgJXMsIGZvcmNpbmcgb3ZlcmZsb3cg
cHJvbWlzY3VvdXMgb24gJXNcbiIsDQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGxpYmllX2FxX3N0cihody0+YXEuYXNxX2xhc3Rfc3RhdHVzKSwgdnNpX25hbWUpOw0KPj4+
ICvCoMKgwqDCoMKgwqDCoCB9DQo+Pj4gwqDCoMKgwqDCoMKgIH0NCj4+PiDCoMKgIMKgwqDCoMKg
wqDCoCByZXR1cm4gYXFfcmV0Ow0KPg==
