Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D27BCC00140
	for <intel-wired-lan@archiver.kernel.org>; Fri, 12 Aug 2022 08:12:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 578D460A81;
	Fri, 12 Aug 2022 08:12:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 578D460A81
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1660291968;
	bh=K2kLbY8etrY6vJrpA2rzhX02B1V/i5VdyHQOEc7JsQk=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=9uimQ7rh/MwGC3XqTxwWdxaQP0KVdn/pYfJflvYwKv9Dd1NRlft6nfkWSVgoeKdZ1
	 oZByZZ8fl3oEYJlDZ8KlEY3bglO5xXfeGmVKWIhkzSJ7X8cEcAOtTwh8dVn3H0V52n
	 mILv7c3lAlExST51QdliRnrsiFkNpb9y+sutSjyA5y7XI3UkeOlyZSMrOqeav+pglF
	 luBgjQYb4uwApuz2vJoNU9vMpP6Xa4DE7FzPkksrxREu/j8kp9memXas3JKs+EyFfd
	 NG+3KbvI3USDhl4NbjDyrtXGc95K1e2nRsYzAj7iIAFQOC6TucFQfWOBEWsnvqE//U
	 xV2fH13PWsZsA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xRX7SGH3U7RX; Fri, 12 Aug 2022 08:12:47 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 443DC610D3;
	Fri, 12 Aug 2022 08:12:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 443DC610D3
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id E00E31BF309
 for <intel-wired-lan@osuosl.org>; Fri, 12 Aug 2022 08:12:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B0B6D4048D
 for <intel-wired-lan@osuosl.org>; Fri, 12 Aug 2022 08:12:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B0B6D4048D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dVW-DnQ7Q70Q for <intel-wired-lan@osuosl.org>;
 Fri, 12 Aug 2022 08:12:42 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AEA9C40391
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AEA9C40391
 for <intel-wired-lan@osuosl.org>; Fri, 12 Aug 2022 08:12:42 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5aec83.dynamic.kabel-deutschland.de
 [95.90.236.131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 6C6FD61EA1929;
 Fri, 12 Aug 2022 10:12:39 +0200 (CEST)
Message-ID: <6435ac6b-2620-fbdc-234a-406c77971800@molgen.mpg.de>
Date: Fri, 12 Aug 2022 10:12:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
To: Mark D Rustad <mark.d.rustad@intel.com>,
 Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
References: <20220728192332.159990-1-mikael.barsehyan@intel.com>
 <f55dc242-eaa1-fa58-38d7-1b48f3d00394@molgen.mpg.de>
 <b7b6c6b8-58d3-2aed-7124-44ce585ef783@intel.com>
 <E98612EF-23CD-4FF2-9953-B4CD8815C1E1@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <E98612EF-23CD-4FF2-9953-B4CD8815C1E1@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH net-next v2] ice: Allow 100M speeds
 for some devices
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
Cc: intel-wired-lan@osuosl.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

RGVhciBNYXJrLAoKCkFtIDExLjA4LjIyIHVtIDAyOjEwIHNjaHJpZWIgUnVzdGFkLCBNYXJrIEQ6
Cj4+IE9uIEF1ZyA4LCAyMDIyLCBhdCAxMDo0NCBBTSwgQW5pcnVkaCBWZW5rYXRhcmFtYW5hbiA8
YW5pcnVkaC52ZW5rYXRhcmFtYW5hbkBpbnRlbC5jb20+IHdyb3RlOgo+Pgo+Pj4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX2NvbW1vbi5oIGIvZHJpdmVy
cy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9jb21tb24uaAo+Pj4+IGluZGV4IGE3NGRmMWQz
YTAwMi4uMjczNDI5NmJkZDNiIDEwMDY0NAo+Pj4+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0
L2ludGVsL2ljZS9pY2VfY29tbW9uLmgKPj4+PiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9p
bnRlbC9pY2UvaWNlX2NvbW1vbi5oCj4+Pj4gQEAgLTIwNSw2ICsyMDUsNyBAQCBpY2VfYXFfc2V0
X2dwaW8oc3RydWN0IGljZV9odyAqaHcsIHUxNiBncGlvX2N0cmxfaGFuZGxlLCB1OCBwaW5faWR4
LCBib29sIHZhbHVlLAo+Pj4+IGludAo+Pj4+IGljZV9hcV9nZXRfZ3BpbyhzdHJ1Y3QgaWNlX2h3
ICpodywgdTE2IGdwaW9fY3RybF9oYW5kbGUsIHU4IHBpbl9pZHgsCj4+Pj4gYm9vbCAqdmFsdWUs
IHN0cnVjdCBpY2Vfc3FfY2QgKmNkKTsKPj4+PiArYm9vbCBpY2VfaXNfMTAwbV9zcGVlZF9zdXBw
b3J0ZWQoc3RydWN0IGljZV9odyAqaHcpOwo+Pj4gSeKAmWQgbmFtZSBpdCBgaXNfMTAwbWJpdHNf
c3VwcG9ydGVkYC4KPj4KPj4gTmFtaW5nIGlzIGEgYml0IHN1YmplY3RpdmUgSSBzdXBwb3NlLiBB
cyBsb25nIGFzIHRoZSBmdW5jdGlvbiBuYW1lIGlzIHNlbnNpYmxlIGFuZCByZWFkYWJsZSwgaXQn
cyBmaW5lLgo+Pgo+PiBUbyBlYWNoIHRoZWlyIG93biBJIHN1cHBvc2UuIDotKQo+IAo+IEl0IHJl
YWxseSBpcyBiZXR0ZXIgdG8gYWx3YXlzIGhhdmUgdGhlIGRyaXZlciBwcmVmaXggb24gc3ltYm9s
cyB0byBhdm9pZCBhbnkgcG9zc2libGUgbmFtZXNwYWNlIGNsYXNoZXMuIFNvLCBpdCBpcyBiZXN0
IGFzIGl0IHdhcyBpbiB0aGlzIGNhc2UuCgpNeSBjb21tZW50IHdhcyBhYm91dCB0aGUgdW5pdCBp
biB0aGUgbmFtZSwgYW5kIG5vdCB0aGUgcHJlZml4LgoKCktpbmQgcmVnYXJkcywKClBhdWwKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtd2lyZWQt
bGFuIG1haWxpbmcgbGlzdApJbnRlbC13aXJlZC1sYW5Ab3N1b3NsLm9yZwpodHRwczovL2xpc3Rz
Lm9zdW9zbC5vcmcvbWFpbG1hbi9saXN0aW5mby9pbnRlbC13aXJlZC1sYW4K
