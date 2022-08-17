Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E27C1C25B08
	for <intel-wired-lan@archiver.kernel.org>; Wed, 17 Aug 2022 16:07:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6AA8F40475;
	Wed, 17 Aug 2022 16:07:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6AA8F40475
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1660752435;
	bh=/mo1n6irvsWESkD4QCNzUipLM4gkcuqP+eSRvEpKius=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=6fH7sEPuVz5+y6KJeG5GwLw/hw57vWecId3n04LDYBazfiWm4pkslDg2gjKQP8ZC4
	 5UBVUJ6ZKNzn7y8ZmC/bUu4RE9J/GBh4ohcGhlkPXG+6slcHGuDWYTrwbCHA0kdcnt
	 ICowRguX+p2SzyFDYWoY0Pff/1bH9k8hxqRa6CC6FO9/VE5XPOJFnXOnOTA8QWNmKI
	 cIXpcdex4d3AdG7RAuZe82OUUYcEK1DSZsOm2OJaYadR3cTCviXZCe5ugDYR2n6Cb0
	 eqpzNM6ARL9EEqL6PQeBzCBR+nWfoLwATdJEGTC6hquhpyrRiHduJQ3naOtnLbm8gC
	 pKCL4J4kNYdcw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SmybLvOuIlbh; Wed, 17 Aug 2022 16:07:14 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 51BB7405FB;
	Wed, 17 Aug 2022 16:07:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 51BB7405FB
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 8510D1BF589
 for <intel-wired-lan@lists.osuosl.org>; Wed, 17 Aug 2022 16:07:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5DAE2419C8
 for <intel-wired-lan@lists.osuosl.org>; Wed, 17 Aug 2022 16:07:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5DAE2419C8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id db-V9Gthtlzi for <intel-wired-lan@lists.osuosl.org>;
 Wed, 17 Aug 2022 16:07:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0A03A41935
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de
 [IPv6:2a01:488:42:1000:50ed:8234::])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0A03A41935
 for <intel-wired-lan@lists.osuosl.org>; Wed, 17 Aug 2022 16:07:10 +0000 (UTC)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
 by wp530.webpack.hosteurope.de running ExIM with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 id 1oOLZS-0001EA-FB; Wed, 17 Aug 2022 18:07:06 +0200
Message-ID: <61698d9d-088d-a878-2b23-f5423045c00e@leemhuis.info>
Date: Wed, 17 Aug 2022 18:07:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Content-Language: en-US
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 "Wilczynski, Michal" <michal.wilczynski@intel.com>,
 Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>,
 "Siwik, Grzegorz" <grzegorz.siwik@intel.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
References: <CAK8fFZ7m-KR57M_rYX6xZN39K89O=LGooYkKsu6HKt0Bs+x6xQ@mail.gmail.com>
 <2596b2c6-71e4-543f-799f-b4b174c21f31@leemhuis.info>
 <CAK8fFZ6hS69JMtnvFnLVt9aiWEivZ9-izNgMHtB+KeAWAfaXaQ@mail.gmail.com>
 <6f52ccd2-8411-0c53-2deb-885bb1234ce5@leemhuis.info>
 <c89c993e-7a7a-15df-85ef-8d9b7be16b71@intel.com>
 <35814f70-26ad-8007-9381-e8edf4a6d77f@leemhuis.info>
 <2151f504-5244-5680-1d70-1fcd8ecd7022@intel.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <2151f504-5244-5680-1d70-1fcd8ecd7022@intel.com>
X-bounce-key: webpack.hosteurope.de; regressions@leemhuis.info; 1660752431;
 c9e8f6c7; 
X-HE-SMSGID: 1oOLZS-0001EA-FB
Subject: Re: [Intel-wired-lan] ice: Error setting promisc mode on VSI 6
 (rc=-17) @ 5.18.x
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
Cc: LKML <linux-kernel@vger.kernel.org>, intel-wired-lan@lists.osuosl.org,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

T24gMTcuMDguMjIgMTc6NTksIFRvbnkgTmd1eWVuIHdyb3RlOgo+IE9uIDgvMTcvMjAyMiAyOjA4
IEFNLCBUaG9yc3RlbiBMZWVtaHVpcyB3cm90ZToKPj4gT24gMDUuMDcuMjIgMTU6NTEsIFdpbGN6
eW5za2ksIE1pY2hhbCB3cm90ZToKPj4+Cj4+PiBBZGRpbmcgR3J6ZWdvcnogU2l3aWsswqAgc2lu
Y2UgaGUgaXMgd29ya2luZyBvbiBzaW1pbGFyIGlzc3VlIGFuZCBhbHJlYWR5Cj4+PiBoYXMgYSBw
YXRjaCB0aGF0IGlzIGJlaW5nIHRlc3RlZC9yZXZpZXdlZCBpbnRlcm5hbGx5IGF0IHRoZSBtb21l
bnQuCj4+Pgo+Pj4gSGUgY2FuIHlvdSBhIHNlbmQgcGF0Y2ggdG9tb3Jyb3cgc28geW91IGNhbiB0
ZXN0IGlmIGl0IGFsc28gZml4ZXMgeW91cgo+Pj4gcHJvYmxlbS4KPj4KPj4gVG9ueSwgSmVzc2Us
IEkgaGF2ZSB0byB3b25kZXI6IHdoeSBpcyBpdCB0YWtlbiBzbyBsb25nIHRvIGdldCB0aGlzCj4+
IHJlZ3Jlc3Npb24gZml4ZWQ/IFRoZSByZWdyZXNzaW9uIHdhcyByZXBvcnRlZCA2OSBkYXlzIGFn
byBhbmQgdGhlIGZpcnN0Cj4+IHBhdGNoZXMgdG8gZml4IHRoaXMgd2VudCBvdXQgNDAgZGF5cyBh
Z28uIFRoYXQncyBmYXIgZnJvbSBpZGVhbC4KPiAKPiBPdXIgdmFsaWRhdGlvbiBmb3VuZCBpc3N1
ZXMgd2hlbiB0ZXN0aW5nIHRoZSBvcmlnaW5hbCBmaXggd2hpY2ggY2F1c2VkCj4gdGhlIGRlbGF5
cyBhcyB0aGUgbmV3IGlzc3VlcyB3ZXJlIGJlaW5nIHdvcmtlZCBvdXQuCgpZZWFoLCB0aGF0IGhh
cHBlbnMsIHN0aWxsIEkgd2lzaCBpdCB3b3VsZG4ndCB0YWtlbiAqdGhhdCogbXVjaCBsb25nZXIK
dGhlbiB3aGF0J3Mgb3V0bGluZWQgaW4gdGhlIGRvY3MuCgpTaWRlIG5vdGU6IHRoaXMgYW5kIGEg
c2ltaWxhciBpc3N1ZSBJIGhhZCB0b2RheSBtYWRlIG1lIHdvbmRlciBpZiB3ZQpuZWVkIGEgdGFn
IHRvIG1ha2UgInRoaXMgaXMgYSByZWdyZXNzaW9uIGZpeCIgbW9yZSBvYnZpb3VzIHRvIHJldmll
d2VycwphbmQgbWFpbnRhaW5lcnMuIEJ1dCBJIGd1ZXNzIHRoYXQgb3ZlcmJsb3duOyBzaG91bGQg
YmUgZW5vdWdoIGlmCmRldmVsb3BlcnMgbWFrZSBpdCBvYnZpb3VzIGluIHRoZWlyIGNvdmVyIGxl
dHRlciBvciBkZXNjcmlwdGlvbiB0aGF0CnRoaXMgZml4ZXMgYSByZWdyZXNzaW9uLgoKPj4gUmVt
aW5kZXI6IHRoaXMgcmVncmVzc2lvbiBpZGVhbGx5IHNob3VsZCBoYXZlIGJlZW4gZml4ZWQgd2l0
aGluIHR3bwo+PiB3ZWVrcyBhZnRlciB0aGUgcmVwb3J0LCBhcyBleHBsYWluZWQgaGVyZToKPj4g
aHR0cHM6Ly9kb2NzLmtlcm5lbC5vcmcvcHJvY2Vzcy9oYW5kbGluZy1yZWdyZXNzaW9ucy5odG1s
Cj4+Cj4+IEZXSVcsIGluIGNhc2UgYW55b25lIHdvbmRlcnM6IHRoZSBsYXRlc3QgcGF0Y2gtc2Vy
aWVzIHRvIGZpeCB0aGlzIGNhbiBiZQo+PiBmb3VuZCBoZXJlOgo+PiBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9pbnRlbC13aXJlZC1sYW4vMTY2MDMxMDc1MC0yOTA5NDMtMS1naXQtc2VuZC1lbWFp
bC1ncnplZ29yei5zaXdpa0BpbnRlbC5jb20vCj4gCj4gSSB3YXMgZ29pbmcgdG8gcG9pbnQgeW91
IHRvIHRoZSBuZXdlc3QgcGF0Y2hlcywgYnV0IHlvdSBsb2NhdGVkIHRoZW0uCj4gT3VyIHZhbGlk
YXRpb24gZmluaXNoZWQgdGVzdGluZyB0aGVtIHllc3RlcmRheSBzbyB0aGUgcHVsbCByZXF1ZXN0
IGZvcgo+IHRoZXNlIHdpbGwgYmUgZ29pbmcgb3V0IHRvIG5ldGRldiB0b2RheS4KCkdyZWF0LCBt
YW55IHRoeC4KCkNpYW8sIFRob3JzdGVuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCkludGVsLXdpcmVkLWxhbiBtYWlsaW5nIGxpc3QKSW50ZWwtd2lyZWQt
bGFuQG9zdW9zbC5vcmcKaHR0cHM6Ly9saXN0cy5vc3Vvc2wub3JnL21haWxtYW4vbGlzdGluZm8v
aW50ZWwtd2lyZWQtbGFuCg==
