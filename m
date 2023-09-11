Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95A5EEE57DF
	for <intel-wired-lan@archiver.kernel.org>; Mon, 11 Sep 2023 15:07:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1181D408C4;
	Mon, 11 Sep 2023 15:07:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1181D408C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1694444852;
	bh=ulV9fRIlYXtxVhXZeQAfzvqNm/lfoTdNQqiG5FLpriQ=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=ayMLaH2C8Qkz+k+i0qpBarvwyPAa1dtHft5W9NDZWzrmVqH5zfisdQ9uiPZKztPux
	 zNwd1CJL8t9BAMipuLqIqE5dqNGnsfA5hbdnkHqymumGhk6b4o81MhIxehRuIHrUmI
	 GeN3Nd/H5e0kWhQJ0/EDN5as2e7ddm+wA9J8HW3/aHEoF3ZlIboB17MGIptHeQcd8t
	 NJxhEz1HggjnlSfweESm+w5/+dFkJyGpw2YN9OUfP1Zho7oMwrrNCHZ7A+MB42Mj8i
	 NkvB06l4wFdjZEVWWQ0WiyyGYz6hWoZn7fkP7rJmAkVt3Bz9Mr8gM1ZmUz0socf5l1
	 prD2SahGY1kpA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DShmV3DDfwpW; Mon, 11 Sep 2023 15:07:31 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 084E0408C9;
	Mon, 11 Sep 2023 15:07:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 084E0408C9
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id DB74D1BF580
 for <intel-wired-lan@lists.osuosl.org>; Mon, 11 Sep 2023 12:15:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B3B1C81E2A
 for <intel-wired-lan@lists.osuosl.org>; Mon, 11 Sep 2023 12:15:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B3B1C81E2A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0I631zdPuXw3 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 11 Sep 2023 12:15:24 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EEA6B81E26
 for <intel-wired-lan@lists.osuosl.org>; Mon, 11 Sep 2023 12:15:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EEA6B81E26
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="381863508"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; d="scan'208";a="381863508"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2023 05:15:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="746383290"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; d="scan'208";a="746383290"
Received: from mzarkov-mobl3.ger.corp.intel.com (HELO
 ijarvine-mobl2.ger.corp.intel.com) ([10.252.36.200])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2023 05:15:18 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 11 Sep 2023 15:14:56 +0300
Message-Id: <20230911121501.21910-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230911121501.21910-1-ilpo.jarvinen@linux.intel.com>
References: <20230911121501.21910-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 11 Sep 2023 15:07:29 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1694434523; x=1725970523;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=UfjgEcn3j45qxnCU9n6VXDTvhnlTPXsfglb+ZF4euEo=;
 b=Jn7ogr3pd1609v1kHis9HUF8swGqOV6UWZ/f8E2ZhssZ3dmmbhlagKth
 FaMWgbKnMVT0wslfcrr2Sl0O52OA1pFCcAFwBNlr2BS1vf1Nh6PjbPA+p
 qogQsBz+G2wA99FbN0DxpCwD2hqwheSXbNb6oKD7OKUn05QcgL6qN3o/g
 HJz4mS+KzZ6bjtJPG+qPjlQ5ig1igMq2P4OCklKNVHpaEQMvhSQu0BuhR
 34BWLkRqOnNJzYkxeTOSprlDPkhacKB6hjxb+PGR+4F1X5ykj1M4JF54V
 bvgI5MjOd+H4BK+YFOXgnLggFAYQ2kTGtb/t6caq1npFOu+dZztxDSi6j
 Q==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Jn7ogr3p
Subject: [Intel-wired-lan] [PATCH 3/8] igb: Use FIELD_GET() to extract Link
 Width
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
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

VXNlIEZJRUxEX0dFVCgpIHRvIGV4dHJhY3QgUENJZSBOZWdvdGlhdGVkIExpbmsgV2lkdGggZmll
bGQgaW5zdGVhZCBvZgpjdXN0b20gbWFza2luZyBhbmQgc2hpZnRpbmcuCgpTaWduZWQtb2ZmLWJ5
OiBJbHBvIErDpHJ2aW5lbiA8aWxwby5qYXJ2aW5lbkBsaW51eC5pbnRlbC5jb20+Ci0tLQogZHJp
dmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdiL2UxMDAwX21hYy5jIHwgNiArKystLS0KIDEgZmls
ZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdiL2UxMDAwX21hYy5jIGIvZHJpdmVycy9uZXQv
ZXRoZXJuZXQvaW50ZWwvaWdiL2UxMDAwX21hYy5jCmluZGV4IGNhZjkxYzZmNTJiNC4uNWEyM2I5
Y2ZlYzZjIDEwMDY0NAotLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZ2IvZTEwMDBf
bWFjLmMKKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdiL2UxMDAwX21hYy5jCkBA
IC0xLDYgKzEsNyBAQAogLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAKIC8qIENv
cHlyaWdodChjKSAyMDA3IC0gMjAxOCBJbnRlbCBDb3Jwb3JhdGlvbi4gKi8KIAorI2luY2x1ZGUg
PGxpbnV4L2JpdGZpZWxkLmg+CiAjaW5jbHVkZSA8bGludXgvaWZfZXRoZXIuaD4KICNpbmNsdWRl
IDxsaW51eC9kZWxheS5oPgogI2luY2x1ZGUgPGxpbnV4L3BjaS5oPgpAQCAtNTAsOSArNTEsOCBA
QCBzMzIgaWdiX2dldF9idXNfaW5mb19wY2llKHN0cnVjdCBlMTAwMF9odyAqaHcpCiAJCQlicmVh
azsKIAkJfQogCi0JCWJ1cy0+d2lkdGggPSAoZW51bSBlMTAwMF9idXNfd2lkdGgpKChwY2llX2xp
bmtfc3RhdHVzICYKLQkJCQkJCSAgICAgUENJX0VYUF9MTktTVEFfTkxXKSA+PgotCQkJCQkJICAg
ICBQQ0lfRVhQX0xOS1NUQV9OTFdfU0hJRlQpOworCQlidXMtPndpZHRoID0gKGVudW0gZTEwMDBf
YnVzX3dpZHRoKUZJRUxEX0dFVChQQ0lfRVhQX0xOS1NUQV9OTFcsCisJCQkJCQkJICAgICBwY2ll
X2xpbmtfc3RhdHVzKTsKIAl9CiAKIAlyZWcgPSByZDMyKEUxMDAwX1NUQVRVUyk7Ci0tIAoyLjMw
LjIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkludGVs
LXdpcmVkLWxhbiBtYWlsaW5nIGxpc3QKSW50ZWwtd2lyZWQtbGFuQG9zdW9zbC5vcmcKaHR0cHM6
Ly9saXN0cy5vc3Vvc2wub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtd2lyZWQtbGFuCg==
