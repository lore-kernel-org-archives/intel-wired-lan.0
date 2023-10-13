Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76209C46CA1
	for <intel-wired-lan@archiver.kernel.org>; Fri, 13 Oct 2023 16:49:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 14680401CC;
	Fri, 13 Oct 2023 16:49:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 14680401CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1697215740;
	bh=aDiyuKT/DEV2qRDbUinQ5kgUz+TlBkD8XbQ0pEx5St8=;
	h=Date:From:To:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Cc:From;
	b=QFf9RC/GGbEO0NjMfmbJixO6RY+8VGNwSe6ArjDO2tSCwNHezGuufNw1ZlSVXYPGf
	 LVJMHQJ/PIGym8jZ19YOdgU60QK4T9DjE5xvSHT/84u4ilEjZ9/ncejA6kgHyTVAj4
	 j5vCArhx3IyJID+8ebcgQQw079KDxEtXX4XHO8lVdIchub/9dQXdftzfB1tgeeMUR1
	 8X8qNYwID632Tjunct9l6OllK5GsBDZdEtpj+Q3TCIUXFGEhEm/AYIfpf7i1FN+9UB
	 rsoPfjTdt9AeYyMUgI6YXJqY7kpGFggnAVqk7ZUT4tgRumv19lCYS4ZWmV/2mFXfx0
	 6r3Yy/01rLIDw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0lHzu7kDeIWg; Fri, 13 Oct 2023 16:48:58 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id DB32340590;
	Fri, 13 Oct 2023 16:48:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DB32340590
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id D3E411BF349
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Oct 2023 16:48:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B833641AFD
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Oct 2023 16:48:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B833641AFD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WVa294QQcAbm for <intel-wired-lan@lists.osuosl.org>;
 Fri, 13 Oct 2023 16:48:56 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9BD9C41AEB
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Oct 2023 16:48:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9BD9C41AEB
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 8F2E6B82BBE;
 Fri, 13 Oct 2023 16:48:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A61FEC433C9;
 Fri, 13 Oct 2023 16:48:51 +0000 (UTC)
Date: Fri, 13 Oct 2023 11:48:50 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Message-ID: <20231013164850.GA1118214@bhelgaas>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <afb4db5-5fe1-9f5d-a910-032adf195c@linux.intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1697215731;
 bh=szP7x2S0GYdm6BcJLpTOMMqgkvX4QE9nsVO22TS5i8o=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=iXecQ4KBb/XyryDRw48MJQ8eE5IZmTibbJWLMBT63ah7VMsNNhfRxsQRBnSxXVRz8
 ptzcbqS9ofaJyIOri3ZALVgpwCe+Rwg/lONB4QUFij9MtoErSRw7/rE4HfqKMRp9Ol
 1AuluwowvDK8NcbSOabPG4FxyRekhzTRLLTUCt9VlQsHG9fr69h7832PJfiQYCJtsC
 xvTbFlvGOVHUu8F9jtsNeee3XWb5EfGiJLqK4gNafwswJDcPCPTqjBh2AHAtqM1Mvf
 uNDeS2sjsSyZm50Zfb+V47XLjRkfe0MUfugLCniPVwGscnhdTvdZP2Opj4v6DC5oEv
 fj+erZKZvWbGg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=iXecQ4KB
Subject: Re: [Intel-wired-lan] [PATCH v2 05/13] PCI/ASPM: Add
 pci_enable_link_state()
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
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
 linux-rdma@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>, ath12k@lists.infradead.org,
 linux-pci@vger.kernel.org, linux-wireless@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, ath10k@lists.infradead.org,
 ath11k@lists.infradead.org, Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
 linux-bluetooth@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
 intel-wired-lan@lists.osuosl.org, Netdev <netdev@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-mediatek@lists.infradead.org,
 Rob Herring <robh@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

T24gVGh1LCBPY3QgMTIsIDIwMjMgYXQgMDM6NTM6MzlQTSArMDMwMCwgSWxwbyBKw6RydmluZW4g
d3JvdGU6Cj4gT24gV2VkLCAxMSBPY3QgMjAyMywgQmpvcm4gSGVsZ2FhcyB3cm90ZToKPiA+IE9u
IE1vbiwgU2VwIDE4LCAyMDIzIGF0IDA0OjEwOjU1UE0gKzAzMDAsIElscG8gSsOkcnZpbmVuIHdy
b3RlOgo+ID4gPiBwY2lfZGlzYWJsZV9saW5rX3N0YXRlKCkgbGFja3MgYSBzeW1tZXRyaWMgcGFp
ci4gU29tZSBkcml2ZXJzIHdhbnQgdG8KPiA+ID4gZGlzYWJsZSBBU1BNIGR1cmluZyBjZXJ0YWlu
IHBoYXNlcyBvZiB0aGVpciBvcGVyYXRpb24gYnV0IHRoZW4KPiA+ID4gcmUtZW5hYmxlIGl0IGxh
dGVyIG9uLiBJZiBwY2lfZGlzYWJsZV9saW5rX3N0YXRlKCkgaXMgbWFkZSBmb3IgdGhlCj4gPiA+
IGRldmljZSwgdGhlcmUgaXMgY3VycmVudGx5IG5vIHdheSB0byByZS1lbmFibGUgdGhlIHN0YXRl
cyB0aGF0IHdlcmUKPiA+ID4gZGlzYWJsZWQuCj4gPiAKPiA+IHBjaV9kaXNhYmxlX2xpbmtfc3Rh
dGUoKSBnaXZlcyBkcml2ZXJzIGEgd2F5IHRvIGRpc2FibGUgc3BlY2lmaWVkIEFTUE0KPiA+IHN0
YXRlcyB1c2luZyBhIGJpdG1hc2sgKFBDSUVfTElOS19TVEFURV9MMFMsIFBDSUVfTElOS19TVEFU
RV9MMSwKPiA+IFBDSUVfTElOS19TVEFURV9MMV8xLCBldGMpLCBidXQgSUlVQyB0aGUgZHJpdmVy
IGNhbid0IHRlbGwgZXhhY3RseQo+ID4gd2hhdCBjaGFuZ2VkIGFuZCBjYW4ndCBkaXJlY3RseSBy
ZXN0b3JlIHRoZSBvcmlnaW5hbCBzdGF0ZSwgZS5nLiwKPiA+IAo+ID4gICAtIFBDSUVfTElOS19T
VEFURV9MMSBlbmFibGVkIGluaXRpYWxseQo+ID4gICAtIGRyaXZlciBjYWxscyBwY2lfZGlzYWJs
ZV9saW5rX3N0YXRlKFBDSUVfTElOS19TVEFURV9MMFMpCj4gPiAgIC0gZHJpdmVyIGNhbGxzIHBj
aV9lbmFibGVfbGlua19zdGF0ZShQQ0lFX0xJTktfU1RBVEVfTDBTKQo+ID4gICAtIFBDSUVfTElO
S19TVEFURV9MMFMgYW5kIFBDSUVfTElOS19TVEFURV9MMSBhcmUgZW5hYmxlZCBub3cKPiA+IAo+
ID4gTm93IFBDSUVfTElOS19TVEFURV9MMFMgaXMgZW5hYmxlZCBldmVuIHRob3VnaCBpdCB3YXMg
bm90IGluaXRpYWxseQo+ID4gZW5hYmxlZC4gIE1heWJlIHRoYXQncyB3aGF0IHdlIHdhbnQ7IEkg
ZHVubm8uCj4gPiAKPiA+IHBjaV9kaXNhYmxlX2xpbmtfc3RhdGUoKSBjdXJyZW50bHkgcmV0dXJu
cyBzdWNjZXNzL2ZhaWx1cmUsIGJ1dCBvbmx5Cj4gPiByODE2OSBhbmQgbXQ3NiBldmVuIGNoZWNr
LCBhbmQgb25seSBydGxfaW5pdF9vbmUoKSAocjgxNjkpIGhhcyBhCj4gPiBub24tdHJpdmlhbCBy
ZWFzb24sIHNvIGl0J3MgY29uY2VpdmFibGUgdGhhdCBpdCBjb3VsZCByZXR1cm4gYSBiaXRtYXNr
Cj4gPiBpbnN0ZWFkLgo+IAo+IEl0J3MgZ3JlYXQgdGhhdCB5b3Ugc3VnZ2VzdGVkIHRoaXMgc2lu
Y2UgaXQncyBhY3R1YWxseSB3aGF0IGFsc28gSSd2ZSBiZWVuIAo+IHN0YXJ0ZWQgdG8gdGhpbmsg
c2hvdWxkIGJlIGRvbmUgaW5zdGVhZCBvZiB0aGlzIHN0cmFpZ2h0Zm9yd2FyZCBhcHByb2FjaAo+
IEkgdXNlZCBpbiBWMi4gCj4gCj4gVGhhdCBpcywgZG9uJ3QgaGF2ZSB0aGUgZHJpdmVycyB0byBn
ZXQgYW55dGhpbmcgZGlyZWN0bHkgZnJvbSBMTktDVEwKPiBidXQgdGhleSBzaG91bGQgZ2V0IGV2
ZXJ5dGhpbmcgdGhyb3VnaCB0aGUgQVBJIHByb3ZpZGVkIGJ5IHRoZSAKPiBkaXNhYmxlL2VuYWJs
ZSBjYWxscyB3aGljaCBtYWtlcyBpdCBlYXN5IGZvciB0aGUgZHJpdmVyIHRvIHBhc3MgdGhlIHNh
bWUKPiB2YWx1ZSBiYWNrIGludG8gdGhlIGVuYWJsZSBjYWxsLgo+IAo+ID4gPiBBZGQgcGNpX2Vu
YWJsZV9saW5rX3N0YXRlKCkgdG8gcmVtb3ZlIEFTUE0gc3RhdGVzIGZyb20gdGhlIHN0YXRlCj4g
PiA+IGRpc2FibGUgbWFzay4KPiA+ID4gCj4gPiA+IFNpZ25lZC1vZmYtYnk6IElscG8gSsOkcnZp
bmVuIDxpbHBvLmphcnZpbmVuQGxpbnV4LmludGVsLmNvbT4KPiA+ID4gLS0tCj4gPiA+ICBkcml2
ZXJzL3BjaS9wY2llL2FzcG0uYyB8IDQyICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrCj4gPiA+ICBpbmNsdWRlL2xpbnV4L3BjaS5oICAgICB8ICAyICsrCj4gPiA+ICAy
IGZpbGVzIGNoYW5nZWQsIDQ0IGluc2VydGlvbnMoKykKPiA+ID4gCj4gPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3BjaS9wY2llL2FzcG0uYyBiL2RyaXZlcnMvcGNpL3BjaWUvYXNwbS5jCj4gPiA+
IGluZGV4IDkxZGM5NWFjYTkwZi4uZjQ1ZDE4ZDQ3YzIwIDEwMDY0NAo+ID4gPiAtLS0gYS9kcml2
ZXJzL3BjaS9wY2llL2FzcG0uYwo+ID4gPiArKysgYi9kcml2ZXJzL3BjaS9wY2llL2FzcG0uYwo+
ID4gPiBAQCAtMTExNyw2ICsxMTE3LDQ4IEBAIGludCBwY2lfZGlzYWJsZV9saW5rX3N0YXRlKHN0
cnVjdCBwY2lfZGV2ICpwZGV2LCBpbnQgc3RhdGUpCj4gPiA+ICB9Cj4gPiA+ICBFWFBPUlRfU1lN
Qk9MKHBjaV9kaXNhYmxlX2xpbmtfc3RhdGUpOwo+ID4gPiAgCj4gPiA+ICsvKioKPiA+ID4gKyAq
IHBjaV9lbmFibGVfbGlua19zdGF0ZSAtIFJlLWVuYWJsZSBkZXZpY2UncyBsaW5rIHN0YXRlCj4g
PiA+ICsgKiBAcGRldjogUENJIGRldmljZQo+ID4gPiArICogQHN0YXRlOiBBU1BNIGxpbmsgc3Rh
dGVzIHRvIHJlLWVuYWJsZQo+ID4gPiArICoKPiA+ID4gKyAqIEVuYWJsZSBkZXZpY2UncyBsaW5r
IHN0YXRlIHRoYXQgd2VyZSBwcmV2aW91c2x5IGRpc2FibGUgc28gdGhlIGxpbmsgaXMKPiA+IAo+
ID4gInN0YXRlW3NdIHRoYXQgd2VyZSBwcmV2aW91c2x5IGRpc2FibGVbZF0iIGFsbHVkZXMgdG8g
dGhlIHVzZSBjYXNlIHlvdQo+ID4gaGF2ZSBpbiBtaW5kLCBidXQgSSBkb24ndCB0aGluayBpdCBk
ZXNjcmliZXMgaG93IHRoaXMgZnVuY3Rpb24KPiA+IGFjdHVhbGx5IHdvcmtzLiAgVGhpcyBmdW5j
dGlvbiBqdXN0IG1ha2VzIGl0IHBvc3NpYmxlIHRvIGVuYWJsZSB0aGUKPiA+IHNwZWNpZmllZCBz
dGF0ZXMuICBUaGUgQHN0YXRlIHBhcmFtZXRlciBtYXkgaGF2ZSBub3RoaW5nIHRvIGRvIHdpdGgK
PiA+IGFueSBwcmV2aW91c2x5IGRpc2FibGVkIHN0YXRlcy4KPiAKPiBZZXMsIGl0J3Mgd2hhdCBJ
J3ZlIGJlZW4gdGhpbmtpbmcgYmV0d2VlbiB0aGUgbGluZXMuIEJ1dCBJIHNlZSB5b3VyIHBvaW50
IAo+IHRoYXQgdGhpcyBBUEkgZGlkbid0IG1ha2UgaXQgZWFzeS9vYnZpb3VzIGFzIGlzLgo+IAo+
IFdvdWxkIHlvdSB3YW50IG1lIHRvIGVuZm9yY2UgaXQgdG9vIGJlc2lkZXMgYWx0ZXJpbmcgdGhl
IEFQSSBzdWNoIHRoYXQgdGhlIAo+IHN0YXRlcyBhcmUgYWN0dWFsbHkgcmV0dXJuZWQgZnJvbSBk
aXNhYmxlIGNhbGw/IChJIGRvbid0IHBlcnNvbmFsbHkgZmluZAo+IHRoYXQgbmVjZXNzYXJ5IGFz
IGxvbmcgYXMgdGhlIEFQSSBwYWlyIGl0c2VsZiBtYWtlcyBpdCBvYnZpb3VzIHdoYXQgdGhlIAo+
IGRyaXZlciBpcyBleHBlY3QgdG8gcGFzcyB0aGVyZS4pCgpUaGlzIHdhcyBqdXN0IGEgY29tbWVu
dCBhYm91dCB0aGUgZG9jIG5vdCBtYXRjaGluZyB0aGUgZnVuY3Rpb24KYmVoYXZpb3IuCgpJIHRo
aW5rIHdlIGhhdmUgdG8gc3VwcG9ydCBwY2lfZW5hYmxlX2xpbmtfc3RhdGUoKSBldmVuIGlmIHRo
ZSBkcml2ZXIKaGFzbid0IHByZXZpb3VzbHkgY2FsbGVkIHBjaV9kaXNhYmxlX2xpbmtfc3RhdGUo
KSwgc28gZHJpdmVycyBoYXZlIHRvCmJlIGFibGUgdG8gc3BlY2lmeSB0aGUgcGNpX2VuYWJsZV9s
aW5rX3N0YXRlKCkgQHN0YXRlIGZyb20gc2NyYXRjaC4KCkRvZXMgdGhhdCBhbnN3ZXIgdGhlIGVu
Zm9yY2VtZW50IHF1ZXN0aW9uPyAgSSBkb24ndCB0aGluayB3ZSBjYW4KcmVhbGx5IGVuZm9yY2Ug
YW55dGhpbmcgb3RoZXIgdGhhbiB0aGF0IEBzdGF0ZSBzcGVjaWZpZXMgdmFsaWQgQVNQTQpzdGF0
ZXMuCgpCam9ybgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpJbnRlbC13aXJlZC1sYW4gbWFpbGluZyBsaXN0CkludGVsLXdpcmVkLWxhbkBvc3Vvc2wub3Jn
Cmh0dHBzOi8vbGlzdHMub3N1b3NsLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2ludGVsLXdpcmVkLWxh
bgo=
