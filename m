Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 541D7C001E0
	for <intel-wired-lan@archiver.kernel.org>; Wed, 16 Aug 2023 15:01:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DDBC342060;
	Wed, 16 Aug 2023 15:01:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DDBC342060
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1692198090;
	bh=is1In+P2sqtN6iDvctxqqHXq2kALLla5nmM26NrDrfc=;
	h=References:In-Reply-To:From:Date:To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=wgUJ+Cdpt8cKpPyPotyUMggGYQH6GLHYlhLFqv14eK+Mz09amaCuYHnmbfBENkWnT
	 Vocqro9wo31bnMhjA2f8W6SytULxZ9SIgS/vCAjnDYGBBkjtrkT0MkNXSSDTtyqA5b
	 zM85m3/24KLqeTtAsP+1cOf6JftTecROgxonPSm1cwDsmRYb8fd6Dcn/Y9wL7N5oGG
	 /wcCr3Fhbl4/ncF2BI0VBIbq7ofi/rdq5NwlNCQXlNm1Abplid+mh4Zw/M46C5lYeM
	 83NDYoOnGTofaj9tYJ3S9yzKXMyd5k0hVeB38LVdKcqJDV4UhRTwS3w+57QRVXl2UO
	 2Zip53OyoK5sQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f9KyimlTplfH; Wed, 16 Aug 2023 15:01:29 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8A1BD42062;
	Wed, 16 Aug 2023 15:01:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8A1BD42062
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 833EE1BF41B
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Aug 2023 15:01:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6897661350
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Aug 2023 15:01:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6897661350
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jS1_dlp1tJld for <intel-wired-lan@lists.osuosl.org>;
 Wed, 16 Aug 2023 15:01:27 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2098260A8C
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Aug 2023 15:01:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2098260A8C
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-99d90ffed68so890286466b.0
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Aug 2023 08:01:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692198085; x=1692802885;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zsaDsMPO5ZV2AqjhfXoaV5yTJLxRJeYGvz3XE1CIUIc=;
 b=VNMpY+HxIxjHeZDK/Orh1a3sMRelE89ZmXbscAGrTY2QEsfrkWP4gIFticEXGSwE2o
 gr3+W38BVZZ06ne5qLucwknXvAr5I7MqhgVSvRy7m94zLyZhdFFKLs9gLItC2RnxGZwJ
 cwboeA8E6tWKjLBDSEfo2rF4e0zQwa3ARH5M3latHUdk+jvAuxGz0itF3S657l305rTR
 6Qf1X0ZLPZGU1QJbgEkLJ/u6f3c1ffiSnYZNvRQEBXkW2eke4tV+6rbWsb8t0XfcVpwY
 rT7QLaNq78TDniOTIh3t5PdGHQcCy7hsgaAk7lvURi+aKSWQMFoHuhR1n8Y9nPfnSZTh
 kDLQ==
X-Gm-Message-State: AOJu0Yz2XD0BjH07tH6l6Hh5IB8tzFZY75nx9tcIRqX6xGn2kUNhlDFh
 1BCtNP7wCgcMnAIxV0kyz7UhhEZGywFyQDcMEyc=
X-Google-Smtp-Source: AGHT+IGtAKEDE+xT7TNnkw6TPYDNLMC4+1tbYbjVQLLPFOUQJ7vUeFyz2cwobk843W8psqC5T4xRMMXFELE8FjY2D+Q=
X-Received: by 2002:a17:907:7d87:b0:978:2b56:d76e with SMTP id
 oz7-20020a1709077d8700b009782b56d76emr5258514ejc.12.1692198084302; Wed, 16
 Aug 2023 08:01:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230816010705.1360446-1-jesse.brandeburg@intel.com>
 <20230816010705.1360446-2-jesse.brandeburg@intel.com>
In-Reply-To: <20230816010705.1360446-2-jesse.brandeburg@intel.com>
From: Shannon Nelson <shannon.lee.nelson@gmail.com>
Date: Wed, 16 Aug 2023 08:01:13 -0700
Message-ID: <CAP-MU4Pxx3GT6tTV1as3Lk_kj1iZpFHWp=6wn+5dh=C4g5OjpA@mail.gmail.com>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692198085; x=1692802885;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zsaDsMPO5ZV2AqjhfXoaV5yTJLxRJeYGvz3XE1CIUIc=;
 b=iX/JBUx6gMgJzNlvlUSbeaMg2LOWHBUEs9wfw73TDPNGGBdq6oeQVpyeaZmKIbUu+6
 3pVj1odtJ2+CXlP4HRI0nUJTbJQ2vytGP86KMvwIS9LMAZv1vhKRsmx6GQZDV65dV660
 6NVgsfeOA3u8ykIEvB4W225zdkyzosfbupLRhM0/fuX9I0jo+KshtLBVVUwXWOkMtW2i
 Ingdfq6dafrJBXO1cP8JYZCL4r8Ws0znTRl9SMQsC/SsRht2T+x7q5vl5lXVOm/iVY5L
 Gbd/XD+VwKVlGMdpvuvjNlcAuuxo9OG90lWrZs+n2riV7Q5P9llCKe98blKOimNPLTV7
 z0iw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20221208 header.b=iX/JBUx6
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1 1/2] ice: refactor code to
 remove unused variable
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

T24gVHVlLCBBdWcgMTUsIDIwMjMgYXQgNjowN+KAr1BNIEplc3NlIEJyYW5kZWJ1cmcKPGplc3Nl
LmJyYW5kZWJ1cmdAaW50ZWwuY29tPiB3cm90ZToKPgo+IFVwb24gcmV2aWV3IGl0IHdhcyBub3Rp
Y2VkIHRoYXQgdGhlcmUgaXMgYW4gdW51c2VkIGxvY2FsIHZhcmlhYmxlIHRoYXQKPiBpcyB1c2lu
ZyBhbm90aGVyIHVudXNlZCBkZWZpbmUuIFJlbW92ZSBhbGwgdGhlIHVudXNlZCBzdHVmZiBmcm9t
IHRoZQo+IGZ1bmN0aW9uIGFuZCBoZWFkZXIgaW4gcXVlc3Rpb24uCj4KPiBTaWduZWQtb2ZmLWJ5
OiBKZXNzZSBCcmFuZGVidXJnIDxqZXNzZS5icmFuZGVidXJnQGludGVsLmNvbT4KPiAtLS0KPiAg
ZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9nbnNzLmMgfCA1ICsrLS0tCj4gIGRy
aXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfZ25zcy5oIHwgMSAtCj4gIDIgZmlsZXMg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfZ25zcy5jIGIvZHJpdmVycy9uZXQv
ZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9nbnNzLmMKPiBpbmRleCA3NWM5ZGU2NzVmMjAuLjAyNmJm
YTcxMjA0ZiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNl
X2duc3MuYwo+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfZ25zcy5j
Cj4gQEAgLTg1LDcgKzg1LDYgQEAgc3RhdGljIHZvaWQgaWNlX2duc3NfcmVhZChzdHJ1Y3Qga3Ro
cmVhZF93b3JrICp3b3JrKQo+ICB7Cj4gICAgICAgICBzdHJ1Y3QgZ25zc19zZXJpYWwgKmduc3Mg
PSBjb250YWluZXJfb2Yod29yaywgc3RydWN0IGduc3Nfc2VyaWFsLAo+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJlYWRfd29yay53b3JrKTsKPiAtICAg
ICAgIHVuc2lnbmVkIGxvbmcgZGVsYXkgPSBJQ0VfR05TU19QT0xMX0RBVEFfREVMQVlfVElNRTsK
ClRoaXMgaXMgYSBkaWZmZXJlbnQgdmFsdWUgdGhhbiB0aGUgb25lIHlvdSBhcmUgdXNpbmcgaW4g
dGhlIGt0aHJlYWQuLi4KY2FsbCBiZWxvdy4gIFRoZSBsb2dpYyBoYXMgc29tZSBqdW1wcyB0byB0
aGUgcmVxdWV1ZSBsYWJlbCB0aGF0IHdvdWxkCmJlIHVzaW5nIHRoaXMgUE9MTF9EQVRBX0RFTEFZ
IHZhbHVlLiAgV2l0aCB5b3VyIGNoYW5nZSwgdGhlc2UganVtcHMKd2lsbCBub3cgYmUgdXNpbmcg
dGhlIFRJTUVSX0RFTEFZIHZhbHVlLiAgSXMgdGhpcyBhIHNpZ25pZmljYW50IGNoYW5nZQppbiBi
ZWhhdmlvcj8KCnNsbgoKPiAgICAgICAgIHVuc2lnbmVkIGludCBpLCBieXRlc19yZWFkLCBkYXRh
X2xlbiwgY291bnQ7Cj4gICAgICAgICBzdHJ1Y3QgaWNlX2FxY19saW5rX3RvcG9fYWRkciBsaW5r
X3RvcG87Cj4gICAgICAgICBzdHJ1Y3QgaWNlX3BmICpwZjsKPiBAQCAtMTQ5LDExICsxNDgsMTEg
QEAgc3RhdGljIHZvaWQgaWNlX2duc3NfcmVhZChzdHJ1Y3Qga3RocmVhZF93b3JrICp3b3JrKQo+
ICAgICAgICAgICAgICAgICBkZXZfd2FybihpY2VfcGZfdG9fZGV2KHBmKSwKPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgImduc3NfaW5zZXJ0X3JhdyByZXQ9JWQgc2l6ZT0lZFxuIiwKPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgY291bnQsIGkpOwo+IC0gICAgICAgZGVsYXkgPSBJQ0VfR05T
U19USU1FUl9ERUxBWV9USU1FOwo+ICBmcmVlX2J1ZjoKPiAgICAgICAgIGZyZWVfcGFnZSgodW5z
aWduZWQgbG9uZylidWYpOwo+ICByZXF1ZXVlOgo+IC0gICAgICAga3RocmVhZF9xdWV1ZV9kZWxh
eWVkX3dvcmsoZ25zcy0+a3dvcmtlciwgJmduc3MtPnJlYWRfd29yaywgZGVsYXkpOwo+ICsgICAg
ICAga3RocmVhZF9xdWV1ZV9kZWxheWVkX3dvcmsoZ25zcy0+a3dvcmtlciwgJmduc3MtPnJlYWRf
d29yaywKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIElDRV9HTlNTX1RJTUVS
X0RFTEFZX1RJTUUpOwo+ICAgICAgICAgaWYgKGVycikKPiAgICAgICAgICAgICAgICAgZGV2X2Ri
ZyhpY2VfcGZfdG9fZGV2KHBmKSwgIkdOU1MgZmFpbGVkIHRvIHJlYWQgZXJyPSVkXG4iLCBlcnIp
Owo+ICB9Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2Vf
Z25zcy5oIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9nbnNzLmgKPiBpbmRl
eCA3NWU1NjdhZDcwNTkuLjdhMzU5MDNkNjE5YyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL25ldC9l
dGhlcm5ldC9pbnRlbC9pY2UvaWNlX2duc3MuaAo+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0
L2ludGVsL2ljZS9pY2VfZ25zcy5oCj4gQEAgLTUsNyArNSw2IEBACj4gICNkZWZpbmUgX0lDRV9H
TlNTX0hfCj4KPiAgI2RlZmluZSBJQ0VfRTgxMFRfR05TU19JMkNfQlVTICAgICAgICAgMHgyCj4g
LSNkZWZpbmUgSUNFX0dOU1NfUE9MTF9EQVRBX0RFTEFZX1RJTUUgIChIWiAvIDUwKSAvKiBwb2xs
IGV2ZXJ5IDIwIG1zICovCj4gICNkZWZpbmUgSUNFX0dOU1NfVElNRVJfREVMQVlfVElNRSAgICAg
IChIWiAvIDEwKSAvKiAwLjEgc2Vjb25kIHBlciBtZXNzYWdlICovCj4gICNkZWZpbmUgSUNFX0dO
U1NfVFRZX1dSSVRFX0JVRiAgICAgICAgIDI1MAo+ICAjZGVmaW5lIElDRV9NQVhfSTJDX0RBVEFf
U0laRSAgICAgICAgICBGSUVMRF9NQVgoSUNFX0FRQ19JMkNfREFUQV9TSVpFX00pCj4gLS0KPiAy
LjQxLjAKPgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Cj4gSW50ZWwtd2lyZWQtbGFuIG1haWxpbmcgbGlzdAo+IEludGVsLXdpcmVkLWxhbkBvc3Vvc2wu
b3JnCj4gaHR0cHM6Ly9saXN0cy5vc3Vvc2wub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtd2ly
ZWQtbGFuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCklu
dGVsLXdpcmVkLWxhbiBtYWlsaW5nIGxpc3QKSW50ZWwtd2lyZWQtbGFuQG9zdW9zbC5vcmcKaHR0
cHM6Ly9saXN0cy5vc3Vvc2wub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtd2lyZWQtbGFuCg==
