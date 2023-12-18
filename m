Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E03C35274
	for <intel-wired-lan@archiver.kernel.org>; Mon, 18 Dec 2023 16:15:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B0BE640018;
	Mon, 18 Dec 2023 16:15:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B0BE640018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1702916137;
	bh=0IKX1GzAoVvuURJw+nrmnqLfp3dnKJGMX/ySRKjZoBg=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=ONjecmuV5h9p5wgaP0eFxNGgLLFO2cez2vMu7LV8NAbVuFGUbWp8/Ps4sYAxvwFmS
	 xCb0pH88RNsSFp3invNViseyrplj5kLfKlVh/2CUYyr3amTF2Mn4sF7g6LSpAUjpnh
	 Eyx9twimSsUdsJqLFu+ZJQ1AmfXuxf/RdVMhUVS4rZwTrQEXco1p/+v9jgRRqhpCPU
	 yFiCb59XV0RT+2MIacbXwsCiw1vgdhj0Zv4NfUJxeNwV75Ti96GZ+CvdCnPxcVVQgV
	 OHikLfyI+PltC3lzrbYaH9/itedduoJYtSuwNCpKrlbp9KfzZYboqHcRDa2ksvxT2e
	 sY7uct9qeQmGg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WibN0zytlyOL; Mon, 18 Dec 2023 16:15:35 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 30E634044C;
	Mon, 18 Dec 2023 16:15:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 30E634044C
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 955041BF427
 for <intel-wired-lan@lists.osuosl.org>; Mon, 18 Dec 2023 07:02:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 60B6181FA6
 for <intel-wired-lan@lists.osuosl.org>; Mon, 18 Dec 2023 07:02:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 60B6181FA6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sct2N57sVwvV for <intel-wired-lan@lists.osuosl.org>;
 Mon, 18 Dec 2023 07:02:54 +0000 (UTC)
X-Greylist: delayed 439 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 18 Dec 2023 07:02:49 UTC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CFA4B81EAC
Received: from mail-m25492.xmail.ntesmail.com (mail-m25492.xmail.ntesmail.com
 [103.129.254.92])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CFA4B81EAC
 for <intel-wired-lan@lists.osuosl.org>; Mon, 18 Dec 2023 07:02:49 +0000 (UTC)
Received: from [172.23.77.185] (unknown [121.32.254.148])
 by mail-m12741.qiye.163.com (Hmail) with ESMTPA id 47A809E0588;
 Mon, 18 Dec 2023 14:54:50 +0800 (CST)
Message-ID: <3ca71217-4291-45e4-9073-9e32c5177e29@sangfor.com.cn>
Date: Mon, 18 Dec 2023 14:54:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Brett Creeley <bcreeley@amd.com>, jesse.brandeburg@intel.com,
 anthony.l.nguyen@intel.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
References: <20231213104912.16153-1-xiaoke@sangfor.com.cn>
 <0edc953a-0357-d054-d9a2-e9a86e90233d@amd.com>
From: "xiaoke@sangfor.com.cn" <xiaoke@sangfor.com.cn>
In-Reply-To: <0edc953a-0357-d054-d9a2-e9a86e90233d@amd.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCGhlPVk4eQh8dQx9JShlOTFUTARMWGhIXJBQOD1
 lXWRgSC1lBWUpJSlVISVVJTk9VSk9DWVdZFhoPEhUdFFlBWU9LSFVKTU9JTE5VSktLVUpCS0tZBg
 ++
X-HM-Tid: 0a8c7bb4b97cb214kuuu47a809e0588
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ngg6Nxw4UTwxSioDKyhKDVEU
 SRowC01VSlVKTEtJQ0NJT0JKSU9MVTMWGhIXVQMSGhQQHjsIGhUcHRQJVRgUFlUYFUVZV1kSC1lB
 WUpJSlVISVVJTk9VSk9DWVdZCAFZQUlOSkI3Bg++
X-Mailman-Approved-At: Mon, 18 Dec 2023 16:15:33 +0000
Subject: Re: [Intel-wired-lan] [net PATCH] i40e: fix use-after-free in
 i40e_aqc_add_filters()
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
Cc: intel-wired-lan@lists.osuosl.org, zhudi2@huawei.com, dinghui@sangfor.com.cn,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

T24gMjAyMy8xMi8xNiAxOjE2LCBCcmV0dCBDcmVlbGV5IHdyb3RlOgo+IE9uIDEyLzEzLzIwMjMg
Mjo0OSBBTSwgS2UgWGlhbyB3cm90ZToKPj4gQ2F1dGlvbjogVGhpcyBtZXNzYWdlIG9yaWdpbmF0
ZWQgZnJvbSBhbiBFeHRlcm5hbCBTb3VyY2UuIFVzZSBwcm9wZXIgCj4+IGNhdXRpb24gd2hlbiBv
cGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlja2luZyBsaW5rcywgb3IgcmVzcG9uZGluZy4KPj4KPj4K
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2k0MGUvaTQwZV9tYWlu
LmMgCj4+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaTQwZS9pNDBlX21haW4uYwo+PiBp
bmRleCAxYWI4ZGJlMmQ4ODAuLjE2YjU3NGQ2OTg0MyAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9u
ZXQvZXRoZXJuZXQvaW50ZWwvaTQwZS9pNDBlX21haW4uYwo+PiArKysgYi9kcml2ZXJzL25ldC9l
dGhlcm5ldC9pbnRlbC9pNDBlL2k0MGVfbWFpbi5jCj4+IEBAIC0xMDgsMTEgKzEwOCwxNyBAQCBz
dGF0aWMgdm9pZCBuZXRkZXZfaHdfYWRkcl9yZWZjbnQoc3RydWN0IAo+PiBpNDBlX21hY19maWx0
ZXIgKmYsCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBuZXRfZGV2aWNlICpuZXRkZXYsIGludCBkZWx0
YSkKPj4gwqAgewo+PiDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBuZXRkZXZfaHdfYWRkciAqaGE7
Cj4+ICvCoMKgwqDCoMKgwqAgc3RydWN0IG5ldGRldl9od19hZGRyX2xpc3QgKmhhX2xpc3Q7Cj4g
Cj4gTml0LCBuZWVkcyB0byBiZSBpbiBSZXZlcnNlIENocmlzdG1hcyBUcmVlIChSQ1QpIG9yZGVy
LgoKVGhhbmtzLCBJIHdpbGwgc2VuZCB0aGUgVjIgdG8gZm9sbG93IHRoZSBydWxlLgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpJbnRlbC13aXJlZC1sYW4g
bWFpbGluZyBsaXN0CkludGVsLXdpcmVkLWxhbkBvc3Vvc2wub3JnCmh0dHBzOi8vbGlzdHMub3N1
b3NsLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2ludGVsLXdpcmVkLWxhbgo=
