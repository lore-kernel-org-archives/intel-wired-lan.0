Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF347EB64DC
	for <intel-wired-lan@archiver.kernel.org>; Mon, 17 Jul 2023 11:00:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 99EE48126D;
	Mon, 17 Jul 2023 11:00:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 99EE48126D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1689591649;
	bh=+RZj7H0s2mu/crGsS8Rm+3xsirrOcQAvhgTAeMUYezk=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=6+Za2ZT6T40msj7CA2fYvXFMCQ/sQzt1tIi15edN91dIYpJaX3LEEbUPuzB1uMQhX
	 x/ESNxX6S/sxoI2hto4TLOHnvODj+2RwRWKD0LlWM2hzZ6Jmn1ojy4chZHBRe9svc6
	 1YpFxYFqUcPko5xAEooKe50KRQN8BCNnaNv9CLm7HSKCx690866rcOTsssvMToSVrW
	 ObwsyDhDNrQuvmowZxtH/drDR40k1VpqZQNLtXz5wVrrJdrUrPsdt0pwP9ceiu0pPq
	 SgmCiq4IlV9tAkazZtBI3uLhBTCxIUsYU9jbfPgFPIAbAk3IrpWpS2O9qhysrZbPsD
	 L2Y//64EMzv1w==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9F-IWOk6l_kw; Mon, 17 Jul 2023 11:00:48 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id ABDC181290;
	Mon, 17 Jul 2023 11:00:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ABDC181290
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 563A11BF38D
 for <intel-wired-lan@lists.osuosl.org>; Mon, 17 Jul 2023 11:00:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3AA0B4092F
 for <intel-wired-lan@lists.osuosl.org>; Mon, 17 Jul 2023 11:00:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3AA0B4092F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ML2VS7E0Ihr9 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 17 Jul 2023 11:00:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 63D8640882
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 63D8640882
 for <intel-wired-lan@lists.osuosl.org>; Mon, 17 Jul 2023 11:00:45 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="452273721"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; d="scan'208";a="452273721"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2023 04:00:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="700474867"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; d="scan'208";a="700474867"
Received: from gk3153-or4-r750-36948.igk.intel.com ([10.102.19.252])
 by orsmga006.jf.intel.com with ESMTP; 17 Jul 2023 04:00:43 -0700
From: "Zaborska, Olga" <olga.zaborska@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Mon, 17 Jul 2023 13:00:39 +0200
Message-Id: <20230717110039.298259-1-olga.zaborska@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1689591645; x=1721127645;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=98xdvRLdNxWa1QILVAI/MQeF9P0a7o7ZDRYIRiCCH5M=;
 b=b+mVxfy/j+Uea6pq0pvZ6G7UgKAJZuX+Vccj2p5A99iBTvEMYllu695Z
 K23gwcCXRlYYOPOaV0TL5tqlMG7xu6CnVBEWFA3j8924PRTNnaQIXNZlH
 ZyWI3awOO/HfhcipyHmqSPGruo60Sqj9kFnS0/rU8CeVoMDA3LGWNQrKM
 bJ0XJ7c2SAkWBJLwdVuqhcg0xCTaooWhjCeOz38TcJt4YmuwaU6BxLBCU
 LzAaJBo7+dDBCnzb7gdPNPxGKgQ/DIOadCnu/jhGrBmbKU7xkdkkyxyqM
 9DNCKa4Odoc9FhRA2J/a6ci3xjULBErVLIun8xuqtk7NzTtO8zMY/eXs6
 g==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=b+mVxfy/
Subject: [Intel-wired-lan] [PATCH iwl-net v3 3/3] igc: Change IGC_MIN to
 allow set rx/tx value between 64 and 80
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
Cc: "Zaborska, Olga" <olga.zaborska@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Q2hhbmdlIHRoZSBtaW5pbXVtIHZhbHVlIG9mIFJYL1RYIGRlc2NyaXB0b3JzIHRvIDY0IHRvIGVu
YWJsZSBzZXR0aW5nIHRoZSByeC90eCB2YWx1ZcKgCmJldHdlZW4gNjQgYW5kIDgwLiBBbGwgaWdj
IGRldmljZXMgY2FuIHVzZSBhcyBsb3cgYXMgNjQgZGVzY3JpcHRvcnMuClRoaXMgY2hhbmdlIHdp
bGwgdW5pZnkgaWdjIHdpdGggb3RoZXIgZHJpdmVycy4KQmFzZWQgb24gY29tbWl0IDdiMWJlMTkg
KCJlMTAwMGU6IGxvd2VyIHJpbmcgbWluaW11bSBzaXplIHRvIDY0IikKCkZpeGVzOiAwNTA3ZWY4
ICgiaWdjOiBBZGQgdHJhbnNtaXQgYW5kIHJlY2VpdmUgZmFzdHBhdGggYW5kIGludGVycnVwdCBo
YW5kbGVycyIpClNpZ25lZC1vZmYtYnk6IE9sZ2EgWmFib3Jza2EgPG9sZ2EuemFib3Jza2FAaW50
ZWwuY29tPgotLS0KIHYxLT52MiBmaXhlZCBjb21taXQgdGl0bGUgYW5kIG1lc3NhZ2UKIHYyLT52
MyBmaXhlZCBjb21taXQgdGl0bGUgYW5kIG1lc3NhZ2UsIGFkZGVkIGNoYW5nZXMgZm9yIGlnYiBh
bmQgaWdjCi0tLQogZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdjL2lnYy5oIHwgNCArKy0t
CiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lnYy9pZ2MuaCBiL2RyaXZlcnMvbmV0
L2V0aGVybmV0L2ludGVsL2lnYy9pZ2MuaAppbmRleCAzNGFlYmYwMGE1MTIuLjU1ODc2OGNlZTVi
OSAxMDA2NDQKLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdjL2lnYy5oCisrKyBi
L2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lnYy9pZ2MuaApAQCAtMzI2LDExICszMjYsMTEg
QEAgZXh0ZXJuIGNoYXIgaWdjX2RyaXZlcl9uYW1lW107CiAvKiBUWC9SWCBkZXNjcmlwdG9yIGRl
ZmluZXMgKi8KICNkZWZpbmUgSUdDX0RFRkFVTFRfVFhECQkyNTYKICNkZWZpbmUgSUdDX0RFRkFV
TFRfVFhfV09SSwkxMjgKLSNkZWZpbmUgSUdDX01JTl9UWEQJCTgwCisjZGVmaW5lIElHQ19NSU5f
VFhECQk2NAogI2RlZmluZSBJR0NfTUFYX1RYRAkJNDA5NgogCiAjZGVmaW5lIElHQ19ERUZBVUxU
X1JYRAkJMjU2Ci0jZGVmaW5lIElHQ19NSU5fUlhECQk4MAorI2RlZmluZSBJR0NfTUlOX1JYRAkJ
NjQKICNkZWZpbmUgSUdDX01BWF9SWEQJCTQwOTYKIAogLyogU3VwcG9ydGVkIFJ4IEJ1ZmZlciBT
aXplcyAqLwotLSAKMi4zMS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpJbnRlbC13aXJlZC1sYW4gbWFpbGluZyBsaXN0CkludGVsLXdpcmVkLWxhbkBv
c3Vvc2wub3JnCmh0dHBzOi8vbGlzdHMub3N1b3NsLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2ludGVs
LXdpcmVkLWxhbgo=
