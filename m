Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B118C00140
	for <intel-wired-lan@archiver.kernel.org>; Mon,  8 Aug 2022 06:48:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DB842400FB;
	Mon,  8 Aug 2022 06:48:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DB842400FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1659941334;
	bh=YFDrAN6AI+yTR5ytkNW1mjMa9cvP2jca+Wv3lsPd1wk=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=WFCVc/NXpfGVCljrMlnv7hw4UrMEYiIm+tSAFdkfVtp/zCs5gUdccbaqn+ShCOCkv
	 o5lNTYwfToHH3WPzmICR9PgTrI/jOfGkbBP1ILh9C4sVJTErpI2aTeNg8YtXIBntpw
	 Vi7E/6mNF6C6jDbkiurNPwUnRD1kD2GCz+Hk0qK/DD1LDt8Joei87+21E5EQn8C2kA
	 5ZEBqOOaQ9sTY2ZELotzot7vbWkCgqHDs/T1QzI81jwJIHEf+wy5pI2fYxq9rf1Ay8
	 R9WOs5hLsB2ShCX0vlYMsnywdca4jpVJJ7OFZ1W3HPaUd2j0oi3NKf1JKA15es94cW
	 06J5/scX7tVLA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0aJELt0d7zxt; Mon,  8 Aug 2022 06:48:54 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id CA05F403A5;
	Mon,  8 Aug 2022 06:48:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CA05F403A5
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 9FD7B1BF5D7
 for <intel-wired-lan@lists.osuosl.org>; Mon,  8 Aug 2022 06:48:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 791F0403A5
 for <intel-wired-lan@lists.osuosl.org>; Mon,  8 Aug 2022 06:48:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 791F0403A5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8QNNqjU_NRDu for <intel-wired-lan@lists.osuosl.org>;
 Mon,  8 Aug 2022 06:48:50 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C4B5B400FB
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C4B5B400FB
 for <intel-wired-lan@lists.osuosl.org>; Mon,  8 Aug 2022 06:48:49 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5aec8b.dynamic.kabel-deutschland.de
 [95.90.236.139])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 671C061EA1928;
 Mon,  8 Aug 2022 08:48:46 +0200 (CEST)
Message-ID: <629564b2-75ac-c495-b252-f0184d534283@molgen.mpg.de>
Date: Mon, 8 Aug 2022 08:48:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.1
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
References: <20220808042339.2979-1-michal.swiatkowski@linux.intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220808042339.2979-1-michal.swiatkowski@linux.intel.com>
Subject: Re: [Intel-wired-lan] [PATCH net] ice: config netdev tc before
 setting queues number
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

RGVhciBNaWNoYWwsCgoKVGhhbmsgeW91IGZvciB5b3VyIHBhdGNoLgoKQW0gMDguMDguMjIgdW0g
MDY6MjMgc2NocmllYiBNaWNoYWwgU3dpYXRrb3dza2k6Cj4gQWZ0ZXIgbG93ZXJpbmcgbnVtYmVy
IG9mIHR4IHF1ZXVlcyB0aGUgd2FybmluZyBhcHBlYXJzOgo+ICJOdW1iZXIgb2YgaW4gdXNlIHR4
IHF1ZXVlcyBjaGFuZ2VkIGludmFsaWRhdGluZyB0YyBtYXBwaW5ncy4gUHJpb3JpdHkKPiB0cmFm
ZiBpYyBjbGFzc2lmaWNhdGlvbiBkaXNhYmxlZCEiCgpBIHNwYWNlIHNudWNrIGluIGluICp0cmFm
ZmljKi4KCkl04oCZZCBiZSBhbHNvIG5pY2UsIGlmIHlvdSBhZGRlZCB0aGUgY29tbWFuZCB0byBs
b3dlciB0aGUgdHggcXVldWVzIHRvIAp0aGUgY29tbWl0IG1lc3NhZ2UuCgo+IEZpeCB0aGlzIGJ5
IHNldHRpbmcgY29ycmVjdCB0YyBtYXBwaW5nIGJlZm9yZSBzZXR0aW5nIHJlYWwgbnVtYmVyIG9m
Cj4gcXVldWVzIG9uIG5ldGRldi4KPiAKPiBGaXhlczogMDc1NGQ2NWJkNGJlNSAoImljZTogQWRk
IGluZnJhc3RydWN0dXJlIGZvciBtcXByaW8gc3VwcG9ydCB2aWEgbmRvX3NldHVwX3RjIikKPiBT
aWduZWQtb2ZmLWJ5OiBNaWNoYWwgU3dpYXRrb3dza2kgPG1pY2hhbC5zd2lhdGtvd3NraUBsaW51
eC5pbnRlbC5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNl
X21haW4uYyB8IDIgKysKPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKPiAKPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9tYWluLmMgYi9k
cml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX21haW4uYwo+IGluZGV4IGQ5OTIzMjFl
NzRiYS4uYmIxN2JjZmQyNTI5IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2lu
dGVsL2ljZS9pY2VfbWFpbi5jCj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNl
L2ljZV9tYWluLmMKPiBAQCAtNjkxOCw2ICs2OTE4LDggQEAgaW50IGljZV92c2lfb3BlbihzdHJ1
Y3QgaWNlX3ZzaSAqdnNpKQo+ICAgCWlmIChlcnIpCj4gICAJCWdvdG8gZXJyX3NldHVwX3J4Owo+
ICAgCj4gKwlpY2VfdnNpX2NmZ19uZXRkZXZfdGModnNpLCB2c2ktPnRjX2NmZy5lbmFfdGMpOwo+
ICsKPiAgIAlpZiAodnNpLT50eXBlID09IElDRV9WU0lfUEYpIHsKPiAgIAkJLyogTm90aWZ5IHRo
ZSBzdGFjayBvZiB0aGUgYWN0dWFsIHF1ZXVlIGNvdW50cy4gKi8KPiAgIAkJZXJyID0gbmV0aWZf
c2V0X3JlYWxfbnVtX3R4X3F1ZXVlcyh2c2ktPm5ldGRldiwgdnNpLT5udW1fdHhxKTsKCgpLaW5k
IHJlZ2FyZHMsCgpQYXVsCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCkludGVsLXdpcmVkLWxhbiBtYWlsaW5nIGxpc3QKSW50ZWwtd2lyZWQtbGFuQG9zdW9z
bC5vcmcKaHR0cHM6Ly9saXN0cy5vc3Vvc2wub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtd2ly
ZWQtbGFuCg==
