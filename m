Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23F0CC4332F
	for <intel-wired-lan@archiver.kernel.org>; Wed, 21 Dec 2022 15:24:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BE015607A1;
	Wed, 21 Dec 2022 15:24:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BE015607A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1671636295;
	bh=CoMXrXGBnutcEC24pc4BFGftW/DZn/eN1mevOPV6hSA=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=SZKlEsuTrXzARj8l72Ae3mFRRFV6sWBmbbmNc3iaH7cmic6Y0KyVEO6o6+QtlqezY
	 8S6G5TzR4GiVAZ7AyBK2bJ3HsgNJohhQ+bObetav9DpBUpVZpvTQDvGeQxc3fbWNLH
	 JZlxVP4czA8c5DU9VlCntluzBhOq0btUrb0e+GcvmPC/TatfNdsEtq2MTOE4WZBNWK
	 /sd8l6dS7MHF8aGVI9agkFPo4fhBq5Kfk6rVvSBYo6gWnGE1BP8zx6SzUCno4Qw4wp
	 IJ7NuDlPMApoU92Ix2asSiv9C77Na5J1/nldtRsKLyKwa6wQeUnxugApLnZLYzQjxw
	 nVvGFtY6lAKsw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qrU2W_a0Z71x; Wed, 21 Dec 2022 15:24:55 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id CC2AA60B09;
	Wed, 21 Dec 2022 15:24:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CC2AA60B09
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id BF78D1BF232
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Dec 2022 15:24:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A6DF340B8D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Dec 2022 15:24:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A6DF340B8D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Hqam5GDecnBS for <intel-wired-lan@lists.osuosl.org>;
 Wed, 21 Dec 2022 15:24:51 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DC64F404C2
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DC64F404C2
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Dec 2022 15:24:50 +0000 (UTC)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 0DAAA61CCD7B0;
 Wed, 21 Dec 2022 16:24:49 +0100 (CET)
Message-ID: <de860700-d302-5ac2-950b-4363f6a55c56@molgen.mpg.de>
Date: Wed, 21 Dec 2022 16:24:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To: Mateusz Palczewski <mateusz.palczewski@intel.com>
References: <20221221132502.1099843-1-mateusz.palczewski@intel.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20221221132502.1099843-1-mateusz.palczewski@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH net v2] e1000e: Disable TSO on i219-LM
 card to increase speed
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
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, Jakub Kicinski <kuba@kernel.org>,
 intel-wired-lan@lists.osuosl.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

RGVhciBNYXRldXN6LAoKClRoYW5rIHlvdSBmb3IgdGhlIHNlY29uZCBpdGVyYXRpb24uCgpBbSAy
MS4xMi4yMiB1bSAxNDoyNSBzY2hyaWViIE1hdGV1c3ogUGFsY3pld3NraToKPiBXaGlsZSB1c2lu
ZyBpMjE5LUxNIGNhcmQgY3VycmVudGx5IGl0IHdhcyBvbmx5IHBvc3NpYmxlIHRvIGFjaGlldmUK
PiBhYm91dCA2MCUgb2YgbWF4aW11bSBzcGVlZCBkdWUgdG8gcmVncmVzc2lvbiBpbnRyb2R1Y2Vk
IGluIExpbnV4IDUuOC1yYzEuCj4gVGhpcyB3YXMgY2F1c2VkIGJ5IFRTTyBub3QgYmVpbmcgZGlz
YWJsZWQgYnkgZGVmYXVsdCBkZXNwaXRlIGNvbW1pdAo+IGYyOTgwMTAzMGFjNiBpbXBsZW1lbnRh
dGlvbi4gRml4IHRoYXQgYnkgbW92aW5nIHRoZSBwYXJ0IG9mIHRoZSBjb2RlCj4gcmVzcG9uc2li
bGUgZm9yIHRoaXMgb3V0c2lkZSBvZiBhZGFwdGVyLT5mbGFncyAmIEZMQUdfVFNPX0ZPUkNFIGNo
ZWNrLgoKVW5mb3J0dW5hdGVseSwgeW91IG1pc3NlZCB0byBhZGQgYWxsIHRoZSBpbmZvcm1hdGlv
biwgdGhhdCB0aGlzIGNhbuKAmXQgYmUgCnJlcHJvZHVjZWQgaW4gYWxsIHNpdHVhdGlvbnMsIGFu
ZCB5b3UgYWxzbyBmb3Jnb3QgdG8gYWRkIHRoZSBkYXRhc2hlZXQgCnNlY3Rpb24sIHdoZXJlIGl0
4oCZcyB3cml0dGVuIHRoYXQgVFNPIG5lZWRzIHRvIGJlIGRpc2FibGVkLgoKPiBGaXhlczogZjI5
ODAxMDMwYWM2ICgiZTEwMDBlOiBEaXNhYmxlIFRTTyBmb3IgYnVmZmVyIG92ZXJydW4gd29ya2Fy
b3VuZCIpCgpXaHkgZG9lcwoKICAgICBpZiAoIShhZGFwdGVyLT5mbGFncyAmIEZMQUdfVFNPX0ZP
UkNFKSkgewogICAgIAlb4oCmXQogICAgIAlpZiAoaHctPm1hYy50eXBlID09IGUxMDAwX3BjaF9z
cHQpIHsKCm5vdCB3b3JrIGluIHlvdXIgc2l0dWF0aW9uPyBJcyBgRkxBR19UU09fRk9SQ0VgIHNl
dCBmb3IgbmV0d29yayBuYW1lc3BhY2VzPwoKQW55d2F5LCBJ4oCZZCBzYXksIGl04oCZcyB0aGUg
d3JvbmcgY29tbWl0IHRvIHJlZmVyZW5jZSwgYXMgaXQgZG9lcyBub3QgCmludHJvZHVjZSB0aGUg
cGVyZm9ybWFuY2UgcmVncmVzc2lvbiB5b3UgYXJlIHNlZWluZy4KCkFuZCBub3cgaGF2aW5nIGR1
ZyBpbiBtb3JlIGludG8gdGhpcyBjaGFuZ2UsIEkgZG8gbm90IHRoaW5rLCBpdCBjYW4gYmUgCmFj
Y2VwdGVkIGFzIGlzLCBhcyBkaXNhYmxpbmcgVENQIFNlZ21lbnRhdGlvbiBPZmZsb2FkIChUU08p
IHdvdWxkIGJlIGEgCnBvdGVudGlhbCBwZXJmb3JtYW5jZSByZWdyZXNzaW9uIChDUFUgdXNhZ2Up
IG9uIGEgbG90IG9mIHN5c3RlbXMuCgo+IFNpZ25lZC1vZmYtYnk6IE1hdGV1c3ogUGFsY3pld3Nr
aSA8bWF0ZXVzei5wYWxjemV3c2tpQGludGVsLmNvbT4KPiAtLS0KPiAgIHYyOiBGaXhlZCBjb21t
aXQgbWVzc2FnZSBhbmQgY29tbWVudCBpbnNpZGUgdGhlIGNvZGUKPiAtLS0KPiAgIGRyaXZlcnMv
bmV0L2V0aGVybmV0L2ludGVsL2UxMDAwZS9uZXRkZXYuYyB8IDEyICsrKysrKysrLS0tLQo+ICAg
MSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKPiAKPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvZTEwMDBlL25ldGRldi5jIGIvZHJp
dmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvZTEwMDBlL25ldGRldi5jCj4gaW5kZXggMDRhY2QxYTk5
MmZhLi4yZjVjZjEyNWZmNzcgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50
ZWwvZTEwMDBlL25ldGRldi5jCj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvZTEw
MDBlL25ldGRldi5jCj4gQEAgLTUzMDcsMTAgKzUzMDcsNiBAQCBzdGF0aWMgdm9pZCBlMTAwMF93
YXRjaGRvZ190YXNrKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykKPiAgIAkJCQkJLyogb29wcyAq
Lwo+ICAgCQkJCQlicmVhazsKPiAgIAkJCQl9Cj4gLQkJCQlpZiAoaHctPm1hYy50eXBlID09IGUx
MDAwX3BjaF9zcHQpIHsKPiAtCQkJCQluZXRkZXYtPmZlYXR1cmVzICY9IH5ORVRJRl9GX1RTTzsK
PiAtCQkJCQluZXRkZXYtPmZlYXR1cmVzICY9IH5ORVRJRl9GX1RTTzY7Cj4gLQkJCQl9Cj4gICAJ
CQl9Cj4gICAKPiAgIAkJCS8qIGVuYWJsZSB0cmFuc21pdHMgaW4gdGhlIGhhcmR3YXJlLCBuZWVk
IHRvIGRvIHRoaXMKPiBAQCAtNTMyNiw2ICs1MzIyLDE0IEBAIHN0YXRpYyB2b2lkIGUxMDAwX3dh
dGNoZG9nX3Rhc2soc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQo+ICAgCQkJaWYgKHBoeS0+b3Bz
LmNmZ19vbl9saW5rX3VwKQo+ICAgCQkJCXBoeS0+b3BzLmNmZ19vbl9saW5rX3VwKGh3KTsKPiAg
IAo+ICsJCQkvKiBEaXNhYmxlIFRTTyBmb3IgaTIxOSB0byBhdm9pZCB0cmFuc2ZlciBzcGVlZAo+
ICsJCQkgKiBiZWluZyBjYXBwZWQgYXQgNjAlLgo+ICsJCQkgKi8KClRoZSByZXN1bHRzIG9mIHRo
ZSBhbmFseXNpcyB3b3VsZCBuZWVkIHRvIGJlIGFkZGVkIGhlcmUsIGFuZCB0aGUgY29tbWVudCAK
ZXh0ZW5kZWQuCgo+ICsJCQlpZiAoaHctPm1hYy50eXBlID09IGUxMDAwX3BjaF9zcHQpIHsKPiAr
CQkJCQluZXRkZXYtPmZlYXR1cmVzICY9IH5ORVRJRl9GX1RTTzsKPiArCQkJCQluZXRkZXYtPmZl
YXR1cmVzICY9IH5ORVRJRl9GX1RTTzY7Cj4gKwkJCX0KPiArCj4gICAJCQluZXRpZl93YWtlX3F1
ZXVlKG5ldGRldik7Cj4gICAJCQluZXRpZl9jYXJyaWVyX29uKG5ldGRldik7Cj4gICAKCgpLaW5k
IHJlZ2FyZHMsCgpQYXVsCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCkludGVsLXdpcmVkLWxhbiBtYWlsaW5nIGxpc3QKSW50ZWwtd2lyZWQtbGFuQG9zdW9z
bC5vcmcKaHR0cHM6Ly9saXN0cy5vc3Vvc2wub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtd2ly
ZWQtbGFuCg==
