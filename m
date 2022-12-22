Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 103CCC001B2
	for <intel-wired-lan@archiver.kernel.org>; Thu, 22 Dec 2022 06:22:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 790C241893;
	Thu, 22 Dec 2022 06:22:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 790C241893
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1671690154;
	bh=iQADXLdHjUytjsyhKlZUbdTcaEiK3mexgGsSFKYUZro=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=5XcqL3gZ8KtAwyWC+XQ944itDUcDuR7FHYepB6za/H5yP858RQz60cs0eQArN3rmL
	 WXpjkAUOz9A9AbFt1jIq9KxlVzyd/MTKMrYH0qyIty0Azi8/5T10kAkmdr57uQmyzN
	 xKGubIXPd75BecDHtkWHL9t8F4DO+eyYe7sR0oauX/r2p0rOiJsEdnMa7WetX1GDg3
	 fWNj80RA6vDmyzo1UVA9T9rLzBtUqGxMogcfVmGJNptCJ/xPXjrr3E5v/n2fnyW6dd
	 sLmpeGyy1r7RytXX2VRoehC5H5ZDg0Zc8u43vU7jB4SD0OTxfE8lpp95EX5zicMSWs
	 jTd2+pobAupHA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CFnl3dxSsAFe; Thu, 22 Dec 2022 06:22:33 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 194184189C;
	Thu, 22 Dec 2022 06:22:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 194184189C
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 961891BF39D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 22 Dec 2022 06:22:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 668B5608F5
 for <intel-wired-lan@lists.osuosl.org>; Thu, 22 Dec 2022 06:22:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 668B5608F5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SehQ4OplWLfO for <intel-wired-lan@lists.osuosl.org>;
 Thu, 22 Dec 2022 06:22:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2B747606E6
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2B747606E6
 for <intel-wired-lan@lists.osuosl.org>; Thu, 22 Dec 2022 06:22:28 +0000 (UTC)
Received: from kwepemm600001.china.huawei.com (unknown [172.30.72.53])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Nd0ZB58NwzJqfx;
 Thu, 22 Dec 2022 14:21:22 +0800 (CST)
Received: from [10.174.176.245] (10.174.176.245) by
 kwepemm600001.china.huawei.com (7.193.23.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 22 Dec 2022 14:22:22 +0800
Message-ID: <82b98e76-d9a9-aade-a96b-5afe26c9e6e3@huawei.com>
Date: Thu, 22 Dec 2022 14:22:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
References: <20221220012143.52141-1-wanghai38@huawei.com>
 <Y6LpRq5iqw6kcVPj@localhost.localdomain>
From: "wanghai (M)" <wanghai38@huawei.com>
In-Reply-To: <Y6LpRq5iqw6kcVPj@localhost.localdomain>
X-Originating-IP: [10.174.176.245]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600001.china.huawei.com (7.193.23.3)
X-CFilter-Loop: Reflected
Subject: Re: [Intel-wired-lan] [PATCH v2] kobject: Fix slab-out-of-bounds in
 fill_kobj_path()
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
Cc: rafael@kernel.org, gregkh@linuxfoundation.org, jesse.brandeburg@intel.com,
 linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 anthony.l.nguyen@intel.com, alice.chao@mediatek.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

CuWcqCAyMDIyLzEyLzIxIDE5OjA4LCBNaWNoYWwgU3dpYXRrb3dza2kg5YaZ6YGTOgo+IE9uIFR1
ZSwgRGVjIDIwLCAyMDIyIGF0IDA5OjIxOjQzQU0gKzA4MDAsIFdhbmcgSGFpIHdyb3RlOgo+PiBJ
biBrb2JqZWN0X2dldF9wYXRoKCksIGlmIGtvYmotPm5hbWUgaXMgY2hhbmdlZCBiZXR3ZWVuIGNh
bGxzCj4+IGdldF9rb2JqX3BhdGhfbGVuZ3RoKCkgYW5kIGZpbGxfa29ial9wYXRoKCkgYW5kIHRo
ZSBsZW5ndGggYmVjb21lcwo+PiBsb25nZXIsIHRoZW4gZmlsbF9rb2JqX3BhdGgoKSB3aWxsIGhh
dmUgYW4gb3V0LW9mLWJvdW5kcyBidWcuCj4+Cj4+IFRoZSBhY3R1YWwgY3VycmVudCBwcm9ibGVt
IG9jY3VycyB3aGVuIHRoZSBpeGdiZSBwcm9iZS4KPj4KPj4gSW4gaXhnYmVfbWlpX2J1c19pbml0
KCksIGlmIHRoZSBsZW5ndGggb2YgbmV0ZGV2LT5kZXYua29iai5uYW1lCj4+IGxlbmd0aCBiZWNv
bWVzIGxvbmdlciwgb3V0LW9mLWJvdW5kcyB3aWxsIG9jY3VyLgo+Pgo+PiBjcHUwICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjcHUxCj4+IGl4Z2JlX3Byb2JlCj4+ICAg
cmVnaXN0ZXJfbmV0ZGV2KG5ldGRldikKPj4gICAgbmV0ZGV2X3JlZ2lzdGVyX2tvYmplY3QKPj4g
ICAgIGRldmljZV9hZGQKPj4gICAgICBrb2JqZWN0X3VldmVudCAvLyBTZW5kaW5nIEFERCBldmVu
dHMKPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN5c3Rl
bWQtdWRldmQgLy8gcmVuYW1lIG5ldGRldgo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGRldl9jaGFuZ2VfbmFtZQo+PiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkZXZpY2VfcmVuYW1lCj4+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBrb2JqZWN0X3JlbmFtZQo+PiAg
IGl4Z2JlX21paV9idXNfaW5pdCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfAo+PiAgICBt
ZGlvYnVzX3JlZ2lzdGVyICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfAo+PiAgICAgX19t
ZGlvYnVzX3JlZ2lzdGVyICAgICAgICAgICAgICAgICAgICAgICAgICAgfAo+PiAgICAgIGRldmlj
ZV9yZWdpc3RlciAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfAo+PiAgICAgICBkZXZpY2Vf
YWRkICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfAo+PiAgICAgICAga29iamVjdF91
ZXZlbnQgICAgICAgICAgICAgICAgICAgICAgICAgICAgfAo+PiAgICAgICAgIGtvYmplY3RfZ2V0
X3BhdGggICAgICAgICAgICAgICAgICAgICAgICAgfAo+PiAgICAgICAgICBsZW4gPSBnZXRfa29i
al9wYXRoX2xlbmd0aCAvLyBvbGQgbmFtZSAgfAo+PiAgICAgICAgICBwYXRoID0ga3phbGxvYyhs
ZW4sIGdmcF9tYXNrKTsgICAgICAgICAgfAo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAga29iai0+bmFtZSA9IG5hbWU7Cj4+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAvKiBuYW1lIGxlbmd0aCBiZWNvbWVz
Cj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKiBs
b25nZXIKPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAqLwo+PiAgICAgICAgICBmaWxsX2tvYmpfcGF0aCAvKiBrb2JqIHBhdGggbGVuZ3RoIGlzCj4+
ICAgICAgICAgICAgICAgICAgICAgICAgICAqIGxvbmdlciB0aGFuIHBhdGgsCj4+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAqIHJlc3VsdGluZyBpbiBvdXQgb2YKPj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICogYm91bmRzIHdoZW4gZmlsbGluZyBwYXRoCj4+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAqLwo+Pgo+PiBUaGlzIGlzIHRoZSBrYXNhbiByZXBvcnQ6Cj4+Cj4+ID09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PQo+PiBCVUc6IEtBU0FOOiBzbGFiLW91dC1vZi1ib3VuZHMgaW4gZmlsbF9rb2JqX3BhdGgrMHg1
MC8weGMwCj4+IFdyaXRlIG9mIHNpemUgNyBhdCBhZGRyIGZmMTEwMDA5MDU3M2QxZmQgYnkgdGFz
ayBrd29ya2VyLzI4OjEvNjczCj4+Cj4+ICAgV29ya3F1ZXVlOiBldmVudHMgd29ya19mb3JfY3B1
X2ZuCj4+ICAgQ2FsbCBUcmFjZToKPj4gICA8VEFTSz4KPj4gICBkdW1wX3N0YWNrX2x2bCsweDM0
LzB4NDgKPj4gICBwcmludF9hZGRyZXNzX2Rlc2NyaXB0aW9uLmNvbnN0cHJvcC4wKzB4ODYvMHgx
ZTcKPj4gICBwcmludF9yZXBvcnQrMHgzNi8weDRmCj4+ICAga2FzYW5fcmVwb3J0KzB4YWQvMHgx
MzAKPj4gICBrYXNhbl9jaGVja19yYW5nZSsweDM1LzB4MWMwCj4+ICAgbWVtY3B5KzB4MzkvMHg2
MAo+PiAgIGZpbGxfa29ial9wYXRoKzB4NTAvMHhjMAo+PiAgIGtvYmplY3RfZ2V0X3BhdGgrMHg1
YS8weGMwCj4+ICAga29iamVjdF91ZXZlbnRfZW52KzB4MTQwLzB4NDYwCj4+ICAgZGV2aWNlX2Fk
ZCsweDVjNy8weDkxMAo+PiAgIF9fbWRpb2J1c19yZWdpc3RlcisweDE0ZS8weDQ5MAo+PiAgIGl4
Z2JlX3Byb2JlLmNvbGQrMHg0NDEvMHg1NzQgW2l4Z2JlXQo+PiAgIGxvY2FsX3BjaV9wcm9iZSsw
eDc4LzB4YzAKPj4gICB3b3JrX2Zvcl9jcHVfZm4rMHgyNi8weDQwCj4+ICAgcHJvY2Vzc19vbmVf
d29yaysweDNiNi8weDZhMAo+PiAgIHdvcmtlcl90aHJlYWQrMHgzNjgvMHg1MjAKPj4gICBrdGhy
ZWFkKzB4MTY1LzB4MWEwCj4+ICAgcmV0X2Zyb21fZm9yaysweDFmLzB4MzAKPj4KPj4gVGhpcyBy
ZXByb2R1Y2VyIHRyaWdnZXJzIHRoYXQgYnVnOgo+Pgo+PiB3aGlsZToKPj4gZG8KPj4gICAgICBy
bW1vZCBpeGdiZQo+PiAgICAgIHNsZWVwIDAuNQo+PiAgICAgIG1vZHByb2JlIGl4Z2JlCj4+ICAg
ICAgc2xlZXAgMC41Cj4+Cj4+IFdoZW4gY2FsbGluZyBmaWxsX2tvYmpfcGF0aCgpIHRvIGZpbGwg
cGF0aCwgaWYgdGhlIG5hbWUgbGVuZ3RoIG9mCj4+IGtvYmogYmVjb21lcyBsb25nZXIsIHJldHVy
biBmYWlsdXJlIGFuZCByZXRyeS4gVGhpcyBmaXhlcyB0aGUgcHJvYmxlbS4KPj4KPj4gRml4ZXM6
IDFkYTE3N2U0YzNmNCAoIkxpbnV4LTIuNi4xMi1yYzIiKQo+PiBTaWduZWQtb2ZmLWJ5OiBXYW5n
IEhhaSA8d2FuZ2hhaTM4QGh1YXdlaS5jb20+Cj4+IC0tLQo+PiB2MS0+djI6IFJldHVybiB2YWx1
ZSB0eXBlIGNoYW5nZSBhbmQgc29tZSBmb3JtYXR0aW5nIGFkanVzdG1lbnRzLgo+PiAgIGxpYi9r
b2JqZWN0LmMgfCAxMiArKysrKysrKysrLS0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2xpYi9rb2JqZWN0LmMg
Yi9saWIva29iamVjdC5jCj4+IGluZGV4IGEwYjJkYmZjZmEyMy4uM2Y5N2Q5MDMyNjZhIDEwMDY0
NAo+PiAtLS0gYS9saWIva29iamVjdC5jCj4+ICsrKyBiL2xpYi9rb2JqZWN0LmMKPj4gQEAgLTEx
Miw3ICsxMTIsNyBAQCBzdGF0aWMgaW50IGdldF9rb2JqX3BhdGhfbGVuZ3RoKHN0cnVjdCBrb2Jq
ZWN0ICprb2JqKQo+PiAgIAlyZXR1cm4gbGVuZ3RoOwo+PiAgIH0KPj4gICAKPj4gLXN0YXRpYyB2
b2lkIGZpbGxfa29ial9wYXRoKHN0cnVjdCBrb2JqZWN0ICprb2JqLCBjaGFyICpwYXRoLCBpbnQg
bGVuZ3RoKQo+PiArc3RhdGljIGludCBmaWxsX2tvYmpfcGF0aChzdHJ1Y3Qga29iamVjdCAqa29i
aiwgY2hhciAqcGF0aCwgaW50IGxlbmd0aCkKPj4gICB7Cj4+ICAgCXN0cnVjdCBrb2JqZWN0ICpw
YXJlbnQ7Cj4+ICAgCj4+IEBAIC0xMjEsMTIgKzEyMSwxNiBAQCBzdGF0aWMgdm9pZCBmaWxsX2tv
YmpfcGF0aChzdHJ1Y3Qga29iamVjdCAqa29iaiwgY2hhciAqcGF0aCwgaW50IGxlbmd0aCkKPj4g
ICAJCWludCBjdXIgPSBzdHJsZW4oa29iamVjdF9uYW1lKHBhcmVudCkpOwo+PiAgIAkJLyogYmFj
ayB1cCBlbm91Z2ggdG8gcHJpbnQgdGhpcyBuYW1lIHdpdGggJy8nICovCj4+ICAgCQlsZW5ndGgg
LT0gY3VyOwo+PiArCQlpZiAobGVuZ3RoIDw9IDApCj4+ICsJCQlyZXR1cm4gLUVJTlZBTDsKPj4g
ICAJCW1lbWNweShwYXRoICsgbGVuZ3RoLCBrb2JqZWN0X25hbWUocGFyZW50KSwgY3VyKTsKPj4g
ICAJCSoocGF0aCArIC0tbGVuZ3RoKSA9ICcvJzsKPj4gICAJfQo+PiAgIAo+PiAgIAlwcl9kZWJ1
Zygia29iamVjdDogJyVzJyAoJXApOiAlczogcGF0aCA9ICclcydcbiIsIGtvYmplY3RfbmFtZShr
b2JqKSwKPj4gICAJCSBrb2JqLCBfX2Z1bmNfXywgcGF0aCk7Cj4+ICsKPj4gKwlyZXR1cm4gMDsK
Pj4gICB9Cj4+ICAgCj4+ICAgLyoqCj4+IEBAIC0xNDEsMTMgKzE0NSwxNyBAQCBjaGFyICprb2Jq
ZWN0X2dldF9wYXRoKHN0cnVjdCBrb2JqZWN0ICprb2JqLCBnZnBfdCBnZnBfbWFzaykKPj4gICAJ
Y2hhciAqcGF0aDsKPj4gICAJaW50IGxlbjsKPj4gICAKPj4gK3JldHJ5Ogo+PiAgIAlsZW4gPSBn
ZXRfa29ial9wYXRoX2xlbmd0aChrb2JqKTsKPj4gICAJaWYgKGxlbiA9PSAwKQo+PiAgIAkJcmV0
dXJuIE5VTEw7Cj4+ICAgCXBhdGggPSBremFsbG9jKGxlbiwgZ2ZwX21hc2spOwo+PiAgIAlpZiAo
IXBhdGgpCj4+ICAgCQlyZXR1cm4gTlVMTDsKPj4gLQlmaWxsX2tvYmpfcGF0aChrb2JqLCBwYXRo
LCBsZW4pOwo+PiArCWlmIChmaWxsX2tvYmpfcGF0aChrb2JqLCBwYXRoLCBsZW4pKSB7Cj4+ICsJ
CWtmcmVlKHBhdGgpOwo+PiArCQlnb3RvIHJldHJ5Owo+PiArCX0KPiBUaGFua3MgZm9yIHRoZSBm
aXguCj4KPiBJIHdvbmRlciBpZiB0aGVyZSBpcyBubyBjYXNlIHdlIGVuZCB1cCB3aXRoIGluZmlu
aXRlIGxvb3AKPiAoZmlsbF9rb2JqX3BhdGggYWx3YXlzIHJldHVybmluZyBlcnJvcikuIERvIFlv
dSBrbm93PwpJdCBzaG91bGQgb25seSBiZSBwb3NzaWJsZSB0byBoYXZlIGFuIGluZmluaXRlIGxv
b3AgaWYgbmFtZSBvciBwYXJlbnQgCmtlZXBzIGNoYW5naW5nLiBUaGUgcHJvYmFiaWxpdHkgb2Yg
dGhpcyBpcyBleHRyZW1lbHkgbG93LgpJZiBuZWNlc3NhcnksIGNoYW5nZSBpdCB0byBvbmx5IHJl
dHJ5IDMgdGltZXM/Cj4+ICAgCj4+ICAgCXJldHVybiBwYXRoOwo+PiAgIH0KPj4gLS0gCj4+IDIu
MTcuMQo+Pgo+PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwo+PiBJbnRlbC13aXJlZC1sYW4gbWFpbGluZyBsaXN0Cj4+IEludGVsLXdpcmVkLWxhbkBvc3Vv
c2wub3JnCj4+IGh0dHBzOi8vbGlzdHMub3N1b3NsLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2ludGVs
LXdpcmVkLWxhbgo+IC4KCi0tIApXYW5nIEhhaQoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KSW50ZWwtd2lyZWQtbGFuIG1haWxpbmcgbGlzdApJbnRlbC13
aXJlZC1sYW5Ab3N1b3NsLm9yZwpodHRwczovL2xpc3RzLm9zdW9zbC5vcmcvbWFpbG1hbi9saXN0
aW5mby9pbnRlbC13aXJlZC1sYW4K
