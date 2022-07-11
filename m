Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B738C433EF
	for <intel-wired-lan@archiver.kernel.org>; Mon, 11 Jul 2022 13:38:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9D15780BF8;
	Mon, 11 Jul 2022 13:38:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9D15780BF8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1657546696;
	bh=lhK0hZLsaKJhB6A4+jpieXM3J1FpsPxxzCtZ9dy/DUs=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=ty2Jc9zVcYk1CmDNq3/QGBmreeYu2h704uttcXSyV41X2zq0bJ73BE89QJQIQyb2c
	 ciIkjV85NasWztr4znwN9J4fk9/MM8oGMnR9wvs9p/s3Pa0R9FDkmcl84X3WoeaNqZ
	 D78vhvkhRgqB1q6s4v95R8Z7hVXZpJHbtAZXX6vRBjygd5tUY/GFZ2OaF3SLvsvBoI
	 QMvnLUHuPT+BTT8GifmDyAh5mKRWEbXubwWY2k1wKKao3arOfz8rK0putNZGuuKty1
	 uBYTbPyCFryIM6YyGc7k/2DJPLaULDUTDCMetMrCki139aA4qmZL3hiQwwglEYTl19
	 oLpz8UAmbnN4Q==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1z1AABwnm5oE; Mon, 11 Jul 2022 13:38:15 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9BBD382779;
	Mon, 11 Jul 2022 13:38:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9BBD382779
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 4EADF1BF20F
 for <intel-wired-lan@lists.osuosl.org>; Mon, 11 Jul 2022 13:38:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 27D6860C0A
 for <intel-wired-lan@lists.osuosl.org>; Mon, 11 Jul 2022 13:38:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 27D6860C0A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IzOBf_vi0kJF for <intel-wired-lan@lists.osuosl.org>;
 Mon, 11 Jul 2022 13:38:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 62AAD60EC5
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 62AAD60EC5
 for <intel-wired-lan@lists.osuosl.org>; Mon, 11 Jul 2022 13:38:11 +0000 (UTC)
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-617-5UDYd3OSPvKyBS3pP63G2g-1; Mon, 11 Jul 2022 09:38:08 -0400
X-MC-Unique: 5UDYd3OSPvKyBS3pP63G2g-1
Received: by mail-wr1-f71.google.com with SMTP id
 m7-20020adfa3c7000000b0021d7ae39d1dso653270wrb.12
 for <intel-wired-lan@lists.osuosl.org>; Mon, 11 Jul 2022 06:38:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:subject:from:reply-to:to:date
 :in-reply-to:references:organization:content-transfer-encoding
 :user-agent:mime-version;
 bh=PK4RReiCLvZ6vqODodam/9lBxCDZrMin5XBxjYN8eC4=;
 b=Xw4kXkSuSxz6Jt0tjaShWijo4nkD5UybsuKlunUeJclPPu9zaIpLeTELdrTVQGT/il
 QKBwbsK18IQdbWWKKtIFfL9f99Svcw6L9IeJADrgO+2PPi6+Bb2/wb+qIYjbS/qlW9/l
 dp3osUEn7wi3X1DKJueeROkxez0FWHG2Qe/+TYS8Jz/KXC+W0ic3hZkho/xguNwZxyVl
 Jkz/ROp/AyDRwFIGRt99F0xpDez/UQDDOp5xxqLeXSA9aMTAq38HZ19AYEA1HizOvJd9
 7bQq6GBaMtkZkpaowg8L2W82X05w/e/LRcekKjglC8ReM7sb4vVnkFVZCKyqEdViZVwj
 cI+w==
X-Gm-Message-State: AJIora8cj/GOy6lF3BIw5DsrzFCOhZAUK6t2n+49inkyuNTpIrER+wt+
 N84bvleVwA0XtIsFbxBCVWVjUIABrOWlHKX8S1NTAEFMeR8c1KGfMmRsci5gjNbhHLBvaarHyyW
 9Y7u7sdQRJ3mQZDkUOa1+gbBivsYlFQ==
X-Received: by 2002:a5d:6da5:0:b0:21d:9275:4de0 with SMTP id
 u5-20020a5d6da5000000b0021d92754de0mr15776574wrs.670.1657546687439; 
 Mon, 11 Jul 2022 06:38:07 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uEzjxf8van7MOzCmZC0VBRgUlSQTFs5sTTqS4/xQpRAmH9RSqYvrzEj3HeUfgv6j9C8SJlOg==
X-Received: by 2002:a5d:6da5:0:b0:21d:9275:4de0 with SMTP id
 u5-20020a5d6da5000000b0021d92754de0mr15776554wrs.670.1657546687151; 
 Mon, 11 Jul 2022 06:38:07 -0700 (PDT)
Received: from [192.168.2.36] (ip4-46-175-183-46.net.iconn.cz. [46.175.183.46])
 by smtp.gmail.com with ESMTPSA id
 187-20020a1c19c4000000b003a044fe7fe7sm6871997wmz.9.2022.07.11.06.38.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Jul 2022 06:38:06 -0700 (PDT)
Message-ID: <4dae99462c44043ce8cce5d40f1e158248877888.camel@redhat.com>
From: Petr Oros <poros@redhat.com>
To: Grzegorz Siwik <grzegorz.siwik@intel.com>, 
 intel-wired-lan@lists.osuosl.org
Date: Mon, 11 Jul 2022 15:38:04 +0200
In-Reply-To: <1657199751-256188-1-git-send-email-grzegorz.siwik@intel.com>
References: <1657199751-256188-1-git-send-email-grzegorz.siwik@intel.com>
Organization: Red Hat
User-Agent: Evolution 3.44.2
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1657546689;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PK4RReiCLvZ6vqODodam/9lBxCDZrMin5XBxjYN8eC4=;
 b=X0Q9pweJMEeW6jO22BMjb2qvofRE73f594kvqEw5F4iDlWbVopD769VJy4DEmBF+YAIK/6
 HUN2e7mKNLYdGgh/wpycO+2waR2Q6RNv1KXr+9/ETn3/SL2WR/hMfkUMLhb9zGg0UgH7JN
 hj5xyFaBJprq9c7qbWjs1qB+ZGPJoA8=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=X0Q9pweJ
X-Mailman-Original-Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=poros@redhat.com
Subject: Re: [Intel-wired-lan] [PATCH net v1 0/3] ice: Fixes for double vlan
 promiscuous mode
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
Reply-To: poros@redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

R3J6ZWdvcnogU2l3aWsgcMOtxaFlIHYgxIx0IDA3LiAwNy4gMjAyMiB2IDE1OjE1ICswMjAwOgo+
IFRoaXMgc2VyaWVzIGZpeGVzIGtub3duIGlzc3VlcyByZWxhdGVkIHRvIGRvdWJsZSB2bGFuIHBy
b21pc2N1b3VzCj4gbW9kZS4KPiBXaGVuIGF0IGxlYXN0IHR3byBpbnRlcmZhY2VzIGFyZSBib25k
ZWQgYW5kIGEgYnJpZGdlIGlzIGVuYWJsZWQgb24KPiB0aGUKPiBib25kLCBhbiBlcnJvciBjYW4g
b2NjdXIgd2hlbiB0aGUgYnJpZGdlIGlzIHJlbW92ZWQgYW5kIHJlLWFkZGVkLiBUaGUKPiByZWFz
b24gZm9yIHRoZSBlcnJvciBpcyBiZWNhdXNlIHByb21pc2N1b3VzIG1vZGUgd2FzIG5vdCBmdWxs
eQo+IGNsZWFyZWQgZnJvbQo+IHRoZSBWTEFOIFZTSSBpbiB0aGUgaGFyZHdhcmUuCj4gSWdub3Jl
IEVSUl9BTFJFQURZX0VYSVNUUyBlcnJvciB3aGVuIHNldHRpbmcgcHJvbWlzY3VvdXMgbW9kZS4K
PiBUaGlzIGZpeCBpcyBuZWVkZWQgYmVjYXVzZSB0aGUgZHJpdmVyIGNvdWxkIHNldCBwcm9taXNj
dW91cyBtb2RlCj4gd2hlbiBpdCBzdGlsbCBoYXMgbm90IGNsZWFyZWQgcHJvcGVybHkuCj4gQXZv
aWQgZW5hYmxpbmcgb3IgZGlzYWJsaW5nIHZsYW4gMCB3aGVuIHRyeWluZyB0byBzZXQgcHJvbWlz
Y3VvdXMKPiB2bGFuIG1vZGUgaWYgZG91YmxlIHZsYW4gbW9kZSBpcyBlbmFibGVkLiBUaGlzIGZp
eCBpcyBuZWVkZWQKPiBiZWNhdXNlIHRoZSBkcml2ZXIgdHJpZXMgdG8gYWRkIHRoZSB2bGFuIDAg
ZmlsdGVyIHR3aWNlIChvbmNlIGZvcgo+IGlubmVyIGFuZCBvbmNlIGZvciBvdXRlcikgd2hlbiBk
b3VibGUgVkxBTiBtb2RlIGlzIGVuYWJsZWQuCj4gCj4gR3J6ZWdvcnogU2l3aWsgKDMpOgo+IMKg
IGljZTogRml4IGRvdWJsZSBWTEFOIGVycm9yIHdoZW4gZW50ZXJpbmcgcHJvbWlzYyBtb2RlCj4g
wqAgaWNlOiBJZ25vcmUgRVJSX0FMUkVBRFlfRVhJU1RTIHdoZW4gc2V0dGluZyBwcm9taXNjIG1v
ZGUKPiDCoCBpY2U6IEZpeCBjbGVhcmluZyBvZiBwcm9taXNjIG1vZGUgd2l0aCBicmlkZ2Ugb3Zl
ciBib25kCj4gCj4gwqBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX2xpYi5jwqDC
oMKgIHzCoCA4ICsrKysrKystCj4gwqBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNl
X21haW4uY8KgwqAgfCAxMyArKysrKysrKysrKystCj4gwqBkcml2ZXJzL25ldC9ldGhlcm5ldC9p
bnRlbC9pY2UvaWNlX3N3aXRjaC5jIHzCoCA5ICsrKysrKysrLQo+IMKgMyBmaWxlcyBjaGFuZ2Vk
LCAyNyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+IAoKVGVzdGVkLWJ5OiBQZXRyIE9y
b3MgPHBvcm9zQHJlZGhhdC5jb20+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpJbnRlbC13aXJlZC1sYW4gbWFpbGluZyBsaXN0CkludGVsLXdpcmVkLWxh
bkBvc3Vvc2wub3JnCmh0dHBzOi8vbGlzdHMub3N1b3NsLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lu
dGVsLXdpcmVkLWxhbgo=
