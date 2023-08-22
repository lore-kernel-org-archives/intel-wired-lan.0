Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9480DEE4993
	for <intel-wired-lan@archiver.kernel.org>; Tue, 22 Aug 2023 14:13:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2ED0B60B14;
	Tue, 22 Aug 2023 14:13:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2ED0B60B14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1692713637;
	bh=dbgL00dG2Yx9B6NYE1GJ4xdgxsC5uIlinYJ13yG1NfU=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=SJilHa22PE8ChrLTswdZAPDIdgrnLO9YZGcnnNt2rtdPec2cv4nFPWYGiJtR5dx47
	 EY3eEjawcKP6DngPQua6jBUFds69O7+gPNvbefthA9g5dPpxm0T8n6VxRo7800N+Ry
	 dcFzLH+5oVBpU9XMTL781v3JOdD7EHl9rLKMt0kK9HNdZV3Ga31P3vanShxiwXXVnu
	 9NX4c6BxsEvN95xrElSVWYVbuzJ6Wf5zeRc9pLKU4/SuiiqqfplmQjM/xixVbtvN39
	 aokD2ROHOUTm4uLH+eJAceZ8twJbJYVnwzncYMvK/AKdGCmop+22+UYbnrlwCL7cB1
	 40mn5yMZ5iRfg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id btiUP88EuWby; Tue, 22 Aug 2023 14:13:56 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4776460DFF;
	Tue, 22 Aug 2023 14:13:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4776460DFF
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 3BC2C1BF2BA
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Aug 2023 14:13:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 10D8060DFF
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Aug 2023 14:13:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 10D8060DFF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QfIsi7gdv2OF for <intel-wired-lan@lists.osuosl.org>;
 Tue, 22 Aug 2023 14:13:54 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 446FF60B14
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Aug 2023 14:13:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 446FF60B14
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 2A2EA6585F;
 Tue, 22 Aug 2023 14:13:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D17B9C433C7;
 Tue, 22 Aug 2023 14:13:51 +0000 (UTC)
Date: Tue, 22 Aug 2023 17:13:48 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Simon Horman <horms@kernel.org>
Message-ID: <20230822141348.GH6029@unreal>
References: <20230817141746.18726-1-karol.kolacinski@intel.com>
 <20230817141746.18726-2-karol.kolacinski@intel.com>
 <20230819115249.GP22185@unreal>
 <20230822070211.GH2711035@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230822070211.GH2711035@kernel.org>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1692713632;
 bh=qSVZxItR//vIO7mz/Yu7lmVbQ1T01x1pm5HG2QxTKHo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jvU0SJKU3wPCEMFhb/WPzwnOtXRHVJSWqadVCrsHGSXfYyMzxq1iSkYfUSzAGtUu8
 mN4ETipG12soYpJr02bkjP7LcR7VtQFU9H3Q16P83a66gKDuymo/iakha6tew5wDr1
 EquTVm5dJ1v5hIakVR3MYsGDZUsErzZmwdK0IFZB9D2z7yWqqtiTIL0Rc2/eDcOMK9
 Py58CpY1Jfhyx6h7g5VF1gZLrr7l1HX9WU25QqriTNuPM+TKTViztwyZPhBcyGFGJ8
 4qz/dvCImBCinrIDfC1K6CmwDLp6HJ1Almh86jg+WUpkO/h7qLSjGWPwClhx0/WdGo
 KxhPhlSM6Tg7Q==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=jvU0SJKU
Subject: Re: [Intel-wired-lan] [PATCH v2 iwl-next 1/9] ice: use
 ice_pf_src_tmr_owned where available
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
Cc: netdev@vger.kernel.org, jesse.brandeburg@intel.com,
 Karol Kolacinski <karol.kolacinski@intel.com>, anthony.l.nguyen@intel.com,
 intel-wired-lan@lists.osuosl.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

T24gVHVlLCBBdWcgMjIsIDIwMjMgYXQgMDk6MDI6MTFBTSArMDIwMCwgU2ltb24gSG9ybWFuIHdy
b3RlOgo+IE9uIFNhdCwgQXVnIDE5LCAyMDIzIGF0IDAyOjUyOjQ5UE0gKzAzMDAsIExlb24gUm9t
YW5vdnNreSB3cm90ZToKPiA+IE9uIFRodSwgQXVnIDE3LCAyMDIzIGF0IDA0OjE3OjM4UE0gKzAy
MDAsIEthcm9sIEtvbGFjaW5za2kgd3JvdGU6Cj4gPiA+IFRoZSBpY2VfcGZfc3JjX3Rtcl9vd25l
ZCgpIG1hY3JvIGV4aXN0cyB0byBjaGVjayB0aGUgZnVuY3Rpb24gY2FwYWJpbGl0eQo+ID4gPiBi
aXQgaW5kaWNhdGluZyBpZiB0aGUgY3VycmVudCBmdW5jdGlvbiBvd25zIHRoZSBQVFAgaGFyZHdh
cmUgY2xvY2suCj4gPiAKPiA+IFRoaXMgaXMgZmlyc3QgcGF0Y2ggaW4gdGhlIHNlcmllcywgYnV0
IEkgY2FuJ3QgZmluZCBtZW50aW9uZWQgbWFjcm8uCj4gPiBNeSBuZXQtbmV4dCBpcyBiYXNlZCBv
biA1YjBhMTQxNGUwYjAgKCJNZXJnZSBicmFuY2ggJ3NtYy1mZWF0dXJlcyciKQo+ID4g4p6cICBr
ZXJuZWwgZ2l0OihuZXQtbmV4dCkgZ2l0IGdyZXAgaWNlX3BmX3NyY190bXJfb3duZWQKPiA+IHNo
b3dzIG5vdGhpbmcuCj4gPiAKPiA+IE9uIHdoaWNoIGJyYW5jaCBpcyBpdCBiYXNlZD8KPiAKPiBI
aSBMZW9uLAo+IAo+IE15IGFzc3VtcHRpb24gaXMgdGhhdCBpdCBpcyBiYXNlZCBvbiB0aGUgZGV2
LXF1ZXVlIGJyYW5jaCBvZgo+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9r
ZXJuZWwvZ2l0L3RuZ3V5L25leHQtcXVldWUuZ2l0CgpTbyBzaG91bGQgbmV0ZGV2IHJlYWRlcnMg
cmV2aWV3IGl0IG9yIHdhaXQgdGlsbCBJbnRlbCBmb2xrcyBwZXJmb3JtCmZpcnN0IHBhc3Mgb24g
aXQ/CgpUaGFua3MKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KSW50ZWwtd2lyZWQtbGFuIG1haWxpbmcgbGlzdApJbnRlbC13aXJlZC1sYW5Ab3N1b3NsLm9y
ZwpodHRwczovL2xpc3RzLm9zdW9zbC5vcmcvbWFpbG1hbi9saXN0aW5mby9pbnRlbC13aXJlZC1s
YW4K
