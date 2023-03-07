Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27432C678D5
	for <intel-wired-lan@archiver.kernel.org>; Tue,  7 Mar 2023 10:19:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A86FB60017;
	Tue,  7 Mar 2023 10:19:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A86FB60017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1678184365;
	bh=XWeA8xRHlq4s6um8o5lpWF2A1PHhNT2BAOQ+oKr6KlI=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=R/5pmDj6unpd0MJZN2H33Dbov9CMJb9/0RF2XcAexhN5fhrfWzYFxrTpWrYlz1ccd
	 Qx6cTgJDpjxTWxVp7aOmfDss6NH6xb+wubxaEfLpa03scnncHl3QmKvBvKTey1P7p9
	 ppPmNiHnfVGcmY2PWSG565yKvetSeKAJuo/IgZqiIKDg/6m/zDFmiO87jrac3pQxes
	 F4HK9ShwRlBhUNxOHHIF6dWtJvhfTfvZKWBf9ZOr43aG6H7sRHVvI5K4MSsAR4l0zQ
	 CPqH2AEtAcXUmWVUgvhLBvPWsu+0FqdDQKSsWzMsMFcrDHFTOcY0RcU6rmttMwFktZ
	 EKPaanxUAViag==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bCJWpuKiT3U5; Tue,  7 Mar 2023 10:19:24 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id A8CD160BEA;
	Tue,  7 Mar 2023 10:19:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A8CD160BEA
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id D6B681BF28A
 for <intel-wired-lan@lists.osuosl.org>; Tue,  7 Mar 2023 10:19:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B8C0160BEA
 for <intel-wired-lan@lists.osuosl.org>; Tue,  7 Mar 2023 10:19:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B8C0160BEA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zbQsXqeh7ifF for <intel-wired-lan@lists.osuosl.org>;
 Tue,  7 Mar 2023 10:19:21 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 54FD760017
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 54FD760017
 for <intel-wired-lan@lists.osuosl.org>; Tue,  7 Mar 2023 10:19:21 +0000 (UTC)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 0F7AC6002768E;
 Tue,  7 Mar 2023 11:19:19 +0100 (CET)
Message-ID: <882d6a36-d3ac-c231-ba02-bc2235984cfd@molgen.mpg.de>
Date: Tue, 7 Mar 2023 11:19:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: Lin Ma <linma@zju.edu.cn>, Corinna Vinschen <vinschen@redhat.com>
References: <ZAcJvkEPqWeJHO2r@calimero.vinschen.de>
 <3ef31c0b-ce40-20d0-7740-5dc0cca278ca@molgen.mpg.de>
In-Reply-To: <3ef31c0b-ce40-20d0-7740-5dc0cca278ca@molgen.mpg.de>
Subject: Re: [Intel-wired-lan] [REGRESSION] Deadlock since commit
 6faee3d4ee8b ("igb: Add lock to avoid data race")
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
Cc: intel-wired-lan@lists.osuosl.org, regressions@lists.linux.dev
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

W0FkZCBDb3Jpbm5hIGJhY2sgdG8gQ2M6LCB3aG8gd2FzIHJlbW92ZWQgYnkgTW96aWxsYSBUaHVu
ZGVyYmlyZCBiZWNhdXNlIApSZXBseS1UbyBoZWFkZXIgd2FzIHNldCBmb3Igc29tZSByZWFzb24g
aW4gdGhlIG9yaWdpbmFsIHJlcG9ydC5dCgpBbSAwNy4wMy4yMyB1bSAxMToxMiBzY2hyaWViIFBh
dWwgTWVuemVsOgo+IFtBZGRpbmcgcmVncmVzc2lvbnNAbGlzdHMubGludXguZGV2XQo+IAo+ICNy
ZWd6Ym90IF5pbnRyb2R1Y2VkOiA2ZmFlZTNkNGVlOGIKPiAKPiBBbSAwNy4wMy4yMyB1bSAxMDo1
NCBzY2hyaWViIENvcmlubmEgVmluc2NoZW46Cj4+IEhpLAo+Pgo+Pgo+PiBBZnRlciBwYXRjaCA2
ZmFlZTNkNGVlOGIgKCJpZ2I6IEFkZCBsb2NrIHRvIGF2b2lkIGRhdGEgcmFjZSIpLCB3ZSBzZWUK
Pj4gYSBkZWFkbG9jayBzY2VuYXJpbyB3aGVuIHRyeWluZyB0byB1bmxvYWQgdGhlIGlnYiBtb2R1
bGUuCj4+Cj4+IFRoZSByZXByb2R1Y2VyIGlzIHByZXR0eSBzaW1wbGU6Cj4+Cj4+IMKgwqAgIyBl
Y2hvIDIgPiAvc3lzL2NsYXNzL25ldC9lbnM1ZjIvZGV2aWNlL3NyaW92X251bXZmcwo+PiDCoMKg
ICMgbW9kcHJvYmUgLXIgaWdiCj4+Cj4+IFRoZSBoYW5nIGlzIHF1aXRlIHRob3JvdWdoLCBJIGFz
c3VtZSBpdCdzIHN1ZmZlcmluZyBhIGRlYWRsb2NrIGJldHdlZW4KPj4gdGhlIHJ0bmxfbG9jayBh
bmQgdGhlIHNwaW5sb2NrIGludHJvZHVjZWQgYnkgNmZhZWUzZDRlZThiLgo+Pgo+PiBBbnkgY2hh
bmNlIHlvdSBjb3VsZCBoYXZlIGEgbG9vaz8KPj4KPj4KPj4gVGhhbmtzLAo+PiBDb3Jpbm5hCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkludGVsLXdpcmVk
LWxhbiBtYWlsaW5nIGxpc3QKSW50ZWwtd2lyZWQtbGFuQG9zdW9zbC5vcmcKaHR0cHM6Ly9saXN0
cy5vc3Vvc2wub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtd2lyZWQtbGFuCg==
