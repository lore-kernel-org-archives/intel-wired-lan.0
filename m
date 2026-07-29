Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DBB1C53200
	for <intel-wired-lan@archiver.kernel.org>; Thu, 30 Jul 2026 00:03:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EE4AC4071B;
	Thu, 30 Jul 2026 00:03:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vG4w2Xt6uy01; Thu, 30 Jul 2026 00:03:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CD3F64080A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785369803;
	bh=RmsiUCZOH7A37LzwcUr+xtsXv37j13Fc38CeVL8wqsc=;
	h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VjDstR91z1Q/UyY+Sx3zHeWXypUnKRUCvEPr2FgKOpnhoFHUTXiZumQ2umIOAW0AX
	 WS+ta6AXMcPRR08SjOLvuC5xOUMwhnv2TXf0s/fQdfJol49DPEsfT/u1hnlZEVdLjZ
	 zoSVme3yQK94ympkvAgWyOlSnpl8Z+xLJfTuolN90x3BiZAFmQSGYD4J/Cz1B163Ko
	 ueD9ymrYJ6Mz6hM6JKeP1hQ0Iv9Nww7CR8t5E6uNnVXLIZvSMazbc8KjyLO/XFmLID
	 nc+1/o5/Wvz3xFM4KxzkC42xvtubi1/tD1gRIHBLXvK8vaumQuQIfCJp5wXElBHJZ7
	 VL77SWGjbVvWg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CD3F64080A;
	Thu, 30 Jul 2026 00:03:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 81BB727B
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Jul 2026 00:03:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5B9116072A
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Jul 2026 00:03:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YedSzhx7UPHD for <intel-wired-lan@lists.osuosl.org>;
 Thu, 30 Jul 2026 00:03:21 +0000 (UTC)
X-Greylist: delayed 594 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 30 Jul 2026 00:03:20 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 9E60E60625
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9E60E60625
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=202.36.163.20;
 helo=gate2.alliedtelesis.co.nz;
 envelope-from=chris.packham@alliedtelesis.co.nz; receiver=<UNKNOWN> 
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz
 [202.36.163.20])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9E60E60625
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Jul 2026 00:03:20 +0000 (UTC)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id EC8FA2C04AC;
 Thu, 30 Jul 2026 11:53:17 +1200 (NZST)
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by
 svr-chch-seg1.atlnz.lc with Trustwave SEG (v8, 2, 6, 11305)
 id <B6a6a926d0000>; Thu, 30 Jul 2026 11:53:17 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Thu, 30 Jul 2026 11:53:17 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1748.039; Thu, 30 Jul 2026 11:53:17 +1200
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: "anthony.l.nguyen@intel.com" <anthony.l.nguyen@intel.com>,
 "przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
 "aleksander.lobakin@intel.com" <aleksander.lobakin@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Blair Steven
 <Blair.Steven@alliedtelesis.co.nz>, Carl Smith
 <Carl.Smith@alliedtelesis.co.nz>
Thread-Topic: [PATCH net-next] i40e: Avoid repeating RX filter warning
Thread-Index: AQHc4znbWyYjUBsJCUSplU0ijsiEzraE2zuA
Date: Wed, 29 Jul 2026 23:53:17 +0000
Message-ID: <c2f3acdd-9985-4d8f-bfc4-5d83f520f4a9@alliedtelesis.co.nz>
References: <20260514003733.1718771-1-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20260514003733.1718771-1-chris.packham@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.33.22.12]
Content-Type: text/plain; charset="utf-8"
Content-ID: <EBBB1D3BE8C29F4695CD5C6EFC63F9EE@alliedtelesis.co.nz>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=O66avw9W c=1 sm=1 tr=0 ts=6a6a926d
 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=drD7vYo3kbIA:10
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=3aN_N3N0Ft81ibqlF-MA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=alliedtelesis.co.nz; 
 s=mail181024; t=1785369197;
 bh=RmsiUCZOH7A37LzwcUr+xtsXv37j13Fc38CeVL8wqsc=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:From;
 b=qIvFN0CRgFxhy6Mwf6aEznb0Up7vvGvw8OGmMiqotKj1kS8sMJWBMIfhhxKH0eKtv
 IbiIswFnAwn4S1Tz/CFMGGh6JdDahwX1OaYq8KbhI5mY021/MIIq5G202lFyZjU7/C
 RfmztySWZeNk/ZGFREjvQ2mCJJdFGzPDQDAXvyeCYJG5LBB6evoE/1Pi/9h6SFHIFy
 wByk1omy82kjhf+wTVolTm9ntzFnq0lm7249QIEw3ujVU3mFmrPPOWsQSLCfwygrT8
 XTGvdunK/E9hLKrsJIpLJ04d1uYfMqOK5olmD8UEpGCOdv8abIIZM70E7CvWl0gcmx
 j9YaJfVmUKdWw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=alliedtelesis.co.nz
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz
 header.a=rsa-sha256 header.s=mail181024 header.b=qIvFN0CR
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

SGkgQWxsLA0KDQpPbiAxNC8wNS8yMDI2IDEyOjM3LCBDaHJpcyBQYWNraGFtIHdyb3RlOg0KPiBX
aGVuIHRoZSBpNDBlIHJ1bnMgb3V0IG9mIHNwYWNlIGZvciBSWCBmaWx0ZXJzIHRoZSBkcml2ZXIg
c3dpdGNoZXMgdG8NCj4gcHJvbWlzY3VvdXMgbW9kZSBhbmQgd2FybnMgdGhhdCBpdCBoYXMgZG9u
ZSBzby4gSW4gc2NlbmFyaW9zIHdpdGggYQ0KPiBsYXJnZSBudW1iZXIgb2YgdGhlc2UgZmlsdGVy
cyB0aGlzIGNhbiBnZW5lcmF0ZSBhIGxvdCBvZiB3YXJuaW5ncy4gRm9yDQo+IGV4YW1wbGU6DQo+
DQo+ICAgICQgZG1lc2cgLWMgPiAvZGV2L251bGwNCj4gICAgJCBpcCBsaW5rIGFkZCBkZXYgYnIw
IHR5cGUgYnJpZGdlIHZsYW5fZmlsdGVyaW5nIDEgdmxhbl9kZWZhdWx0X3B2aWQgMQ0KPiAgICAk
IGlwIGxpbmsgc2V0IGRldiBldGg3IG1hc3RlciBicjANCj4gICAgJCBicmlkZ2UgdmxhbiBhZGQg
dmlkIDEgZGV2IGV0aDcgcHZpZCB1bnRhZ2dlZCBzZWxmDQo+ICAgICQgYnJpZGdlIHZsYW4gYWRk
IHZpZCAyLTQwOTQgZGV2IGV0aDcgdGFnZ2VkDQo+ICAgICQgZG1lc2cNCj4gICAgWyAgIDI1LjYw
MTcwNV0gaTQwZSAwMDAwOjAxOjAwLjE6IEVycm9yIExJQklFX0FRX1JDX0VOT1NQQywgZm9yY2lu
ZyBvdmVyZmxvdyBwcm9taXNjdW91cyBvbiBQRg0KPiAgICBbICAgMjUuNjAxODMzXSBpNDBlIDAw
MDA6MDE6MDAuMTogRXJyb3IgTElCSUVfQVFfUkNfRU5PU1BDLCBmb3JjaW5nIG92ZXJmbG93IHBy
b21pc2N1b3VzIG9uIFBGDQo+ICAgIFsgICAyNS42MDE5NjFdIGk0MGUgMDAwMDowMTowMC4xOiBF
cnJvciBMSUJJRV9BUV9SQ19FTk9TUEMsIGZvcmNpbmcgb3ZlcmZsb3cgcHJvbWlzY3VvdXMgb24g
UEYNCj4gICAgWyAgIDI1LjYwMjA4OF0gaTQwZSAwMDAwOjAxOjAwLjE6IEVycm9yIExJQklFX0FR
X1JDX0VOT1NQQywgZm9yY2luZyBvdmVyZmxvdyBwcm9taXNjdW91cyBvbiBQRg0KPiAgICBbICAg
MjUuNjAyMjE2XSBpNDBlIDAwMDA6MDE6MDAuMTogRXJyb3IgTElCSUVfQVFfUkNfRU5PU1BDLCBm
b3JjaW5nIG92ZXJmbG93IHByb21pc2N1b3VzIG9uIFBGDQo+ICAgIFsgICAyNS42MDIzNDRdIGk0
MGUgMDAwMDowMTowMC4xOiBFcnJvciBMSUJJRV9BUV9SQ19FTk9TUEMsIGZvcmNpbmcgb3ZlcmZs
b3cgcHJvbWlzY3VvdXMgb24gUEYNCj4gICAgLi4uDQo+DQo+IFVzZSB0ZXN0X2FuZF9zZXRfYml0
KCkgc28gdGhhdCB0aGUgd2FybmluZyBpcyBvbmx5IGlzc3VlZCB3aGVuIHRoZQ0KPiBkcml2ZXIg
ZW5hYmxlcyBwcm9taXNjdW91cyBtb2RlIGFuZCBub3Qgb24gdGhlIGFkZGl0aW9uIG9mIHN1YnNl
cXVlbnQgUlgNCj4gZmlsdGVycy4NCj4NCj4gU2lnbmVkLW9mZi1ieTogQ2hyaXMgUGFja2hhbSA8
Y2hyaXMucGFja2hhbUBhbGxpZWR0ZWxlc2lzLmNvLm56Pg0KPiAtLS0NCj4NCj4gUmVzZW5kIHdp
dGggbmV0LW5leHQgdGFnDQoNCkhhcyB0aGlzIGZhbGxlbiB0aHJvdWdoIHRoZSBjcmFja3M/IEkn
dmUgc2VlbiBzb21lIFJldmlld2VkLWJ5cyBidXQgaXQgDQpkb2Vzbid0IHNlZW0gdG8gaGF2ZSBi
ZWVuIHBpY2tlZCB1cC4NCg0KPg0KPiAgIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2k0MGUv
aTQwZV9tYWluLmMgfCAxOCArKysrKysrKysrLS0tLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwg
MTAgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbmV0L2V0aGVybmV0L2ludGVsL2k0MGUvaTQwZV9tYWluLmMgYi9kcml2ZXJzL25ldC9ldGhl
cm5ldC9pbnRlbC9pNDBlL2k0MGVfbWFpbi5jDQo+IGluZGV4IDkyNmQwMDFiMjE1MC4uODc0MTk5
MGI1YTVlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pNDBlL2k0
MGVfbWFpbi5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2k0MGUvaTQwZV9t
YWluLmMNCj4gQEAgLTI0MDgsMTAgKzI0MDgsMTEgQEAgdm9pZCBpNDBlX2FxY19hZGRfZmlsdGVy
cyhzdHJ1Y3QgaTQwZV92c2kgKnZzaSwgY29uc3QgY2hhciAqdnNpX25hbWUsDQo+ICAgDQo+ICAg
CWlmIChmY250ICE9IG51bV9hZGQpIHsNCj4gICAJCWlmICh2c2ktPnR5cGUgPT0gSTQwRV9WU0lf
TUFJTikgew0KPiAtCQkJc2V0X2JpdChfX0k0MEVfVlNJX09WRVJGTE9XX1BST01JU0MsIHZzaS0+
c3RhdGUpOw0KPiAtCQkJZGV2X3dhcm4oJnZzaS0+YmFjay0+cGRldi0+ZGV2LA0KPiAtCQkJCSAi
RXJyb3IgJXMgYWRkaW5nIFJYIGZpbHRlcnMgb24gJXMsIHByb21pc2N1b3VzIG1vZGUgZm9yY2Vk
IG9uXG4iLA0KPiAtCQkJCSBsaWJpZV9hcV9zdHIoYXFfc3RhdHVzKSwgdnNpX25hbWUpOw0KPiAr
CQkJaWYgKCF0ZXN0X2FuZF9zZXRfYml0KF9fSTQwRV9WU0lfT1ZFUkZMT1dfUFJPTUlTQywgdnNp
LT5zdGF0ZSkpIHsNCj4gKwkJCQlkZXZfd2FybigmdnNpLT5iYWNrLT5wZGV2LT5kZXYsDQo+ICsJ
CQkJCSAiRXJyb3IgJXMgYWRkaW5nIFJYIGZpbHRlcnMgb24gJXMsIHByb21pc2N1b3VzIG1vZGUg
Zm9yY2VkIG9uXG4iLA0KPiArCQkJCQkgbGliaWVfYXFfc3RyKGFxX3N0YXR1cyksIHZzaV9uYW1l
KTsNCj4gKwkJCX0NCj4gICAJCX0gZWxzZSBpZiAodnNpLT50eXBlID09IEk0MEVfVlNJX1NSSU9W
IHx8DQo+ICAgCQkJICAgdnNpLT50eXBlID09IEk0MEVfVlNJX1ZNRFExIHx8DQo+ICAgCQkJICAg
dnNpLT50eXBlID09IEk0MEVfVlNJX1ZNRFEyKSB7DQo+IEBAIC0yNDYxLDEwICsyNDYyLDExIEBA
IGk0MGVfYXFjX2Jyb2FkY2FzdF9maWx0ZXIoc3RydWN0IGk0MGVfdnNpICp2c2ksIGNvbnN0IGNo
YXIgKnZzaV9uYW1lLA0KPiAgIAl9DQo+ICAgDQo+ICAgCWlmIChhcV9yZXQpIHsNCj4gLQkJc2V0
X2JpdChfX0k0MEVfVlNJX09WRVJGTE9XX1BST01JU0MsIHZzaS0+c3RhdGUpOw0KPiAtCQlkZXZf
d2FybigmdnNpLT5iYWNrLT5wZGV2LT5kZXYsDQo+IC0JCQkgIkVycm9yICVzLCBmb3JjaW5nIG92
ZXJmbG93IHByb21pc2N1b3VzIG9uICVzXG4iLA0KPiAtCQkJIGxpYmllX2FxX3N0cihody0+YXEu
YXNxX2xhc3Rfc3RhdHVzKSwgdnNpX25hbWUpOw0KPiArCQlpZiAoIXRlc3RfYW5kX3NldF9iaXQo
X19JNDBFX1ZTSV9PVkVSRkxPV19QUk9NSVNDLCB2c2ktPnN0YXRlKSkgew0KPiArCQkJZGV2X3dh
cm4oJnZzaS0+YmFjay0+cGRldi0+ZGV2LA0KPiArCQkJCSAiRXJyb3IgJXMsIGZvcmNpbmcgb3Zl
cmZsb3cgcHJvbWlzY3VvdXMgb24gJXNcbiIsDQo+ICsJCQkJIGxpYmllX2FxX3N0cihody0+YXEu
YXNxX2xhc3Rfc3RhdHVzKSwgdnNpX25hbWUpOw0KPiArCQl9DQo+ICAgCX0NCj4gICANCj4gICAJ
cmV0dXJuIGFxX3JldDs=
