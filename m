Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B1BEDEC71
	for <intel-wired-lan@archiver.kernel.org>; Wed, 13 Sep 2023 15:10:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C1E4E416A9;
	Wed, 13 Sep 2023 15:10:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C1E4E416A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1694617827;
	bh=Yn6pSMtPivvGQ63EkX4B22RvNt+v1c60jHakjw6rjX8=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=gacDDDTJQbdeIo+j72Xwy+DOfBtJOmmDp6OhDcmdQD8+p7H7VbZMoO3TWZdj/Pn0e
	 s9FqX6ztYELc+GJrgEr7Uq1bsb9u5iQxkrT5+bZj0EKDxvjxo9yw6FMlKjW4fhEPYk
	 wyB8bn3RGg32oddw4pl4VxwJJV58becaoOHWRzgCnbrRdEGBRxqiLDgKqTqVIrl0r1
	 5KCko6bJ4ojY3fBalBpW1OizZQlGPneRDysyWh5U17k8WqoLSdJYOG5o/dMcJqe3Gc
	 Fxjhgnd7zR3OLyLUVrm8fopISyd8MqUtWIOcLCZFnk6xkELk1b4WzGu6790ZAVic0r
	 /VMqcNY6NwLqg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WO6WjFTHE0b7; Wed, 13 Sep 2023 15:10:27 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id CDF434152B;
	Wed, 13 Sep 2023 15:10:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CDF434152B
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id AD6D31BF3B9
 for <intel-wired-lan@lists.osuosl.org>; Wed, 13 Sep 2023 12:31:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 85542400B1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 13 Sep 2023 12:31:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 85542400B1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HoU9GKUSKZEg for <intel-wired-lan@lists.osuosl.org>;
 Wed, 13 Sep 2023 12:31:40 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A34A54002D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 13 Sep 2023 12:31:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A34A54002D
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="368912689"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; d="scan'208";a="368912689"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Sep 2023 05:28:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="693836724"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; d="scan'208";a="693836724"
Received: from pakurapo-mobl3.ger.corp.intel.com (HELO
 ijarvine-mobl2.ger.corp.intel.com) ([10.249.45.213])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Sep 2023 05:28:38 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <helgaas@kernel.org>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 13 Sep 2023 15:27:48 +0300
Message-Id: <20230913122748.29530-11-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230913122748.29530-1-ilpo.jarvinen@linux.intel.com>
References: <20230913122748.29530-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 13 Sep 2023 15:10:17 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1694608300; x=1726144300;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wo7umevM4e5cancbBmuxKjkF/sAUzuBzzYDYja1futw=;
 b=BZA1AfNZyKA8S0EMrOjr4K59DEX2wqVsBFYjQTUmK4NioBFHXH2NNVu6
 f05aQivLAmnNLjgUeWuMh/wiwSDy5F5tpjl5+JmMndk3NtGloAxkcyuOn
 mZ5JebhiPzIiGr4zxOweBRNZ0t6L3WS3NsCb0jrGkSGk/AZ7aLMotMrQt
 MW8tG+sV9ay0OtK6sfwjbA2+61HvQUMHxEf1o01c76SSJ0ee3/KZCRR5j
 5HZJc1qw53UVLys6e6KFm0PTP0XXwKKZBHAJhXQIUAnpKon4rypcdgRWR
 Ey96mSupFVXJQcB2xQQ3PdYt0VSxgft3QLmNZOVPVOhVbH3Uqw317iCA5
 g==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=BZA1AfNZ
Subject: [Intel-wired-lan] [PATCH v2 10/10] e1000e: Use
 pcie_capability_read_word() for reading LNKSTA
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

VXNlIHBjaWVfY2FwYWJpbGl0eV9yZWFkX3dvcmQoKSBmb3IgcmVhZGluZyBMTktTVEEgYW5kIHJl
bW92ZSB0aGUKY3VzdG9tIGRlZmluZSB0aGF0IG1hdGNoZXMgdG8gUENJX0VYUF9MTktTVEEuCgpB
cyBvbmx5IHNpbmdsZSB1c2VyIGZvciBjYXBfb2Zmc2V0IHJlbWFpbnMsIHJlbW92ZSBpdCB0b28g
YW5kIHVzZQphZGFwdGVyLT5wZGV2LT5wY2llX2NhcCBkaXJlY3RseSBpbiB0aGUgaWYgY29uZGl0
aW9uLgoKU2lnbmVkLW9mZi1ieTogSWxwbyBKw6RydmluZW4gPGlscG8uamFydmluZW5AbGludXgu
aW50ZWwuY29tPgotLS0KIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2UxMDAwZS9kZWZpbmVz
LmggfCAgMSAtCiBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9lMTAwMGUvbWFjLmMgICAgIHwg
MTAgKysrKy0tLS0tLQogMiBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDcgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvZTEwMDBlL2Rl
ZmluZXMuaCBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2UxMDAwZS9kZWZpbmVzLmgKaW5k
ZXggYTRkMjljOWUwM2E2Li4yM2E1OGNhZGE0M2EgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbmV0L2V0
aGVybmV0L2ludGVsL2UxMDAwZS9kZWZpbmVzLmgKKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQv
aW50ZWwvZTEwMDBlL2RlZmluZXMuaApAQCAtNjc4LDcgKzY3OCw2IEBACiAKIC8qIFBDSS9QQ0kt
WC9QQ0ktRVggQ29uZmlnIHNwYWNlICovCiAjZGVmaW5lIFBDSV9IRUFERVJfVFlQRV9SRUdJU1RF
UiAgICAgMHgwRQotI2RlZmluZSBQQ0lFX0xJTktfU1RBVFVTICAgICAgICAgICAgIDB4MTIKIAog
I2RlZmluZSBQQ0lfSEVBREVSX1RZUEVfTVVMVElGVU5DICAgIDB4ODAKIApkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvZTEwMDBlL21hYy5jIGIvZHJpdmVycy9uZXQvZXRo
ZXJuZXQvaW50ZWwvZTEwMDBlL21hYy5jCmluZGV4IDUzNDBjZjczNzc4ZC4uZTg2NjUyYTMwMDY5
IDEwMDY0NAotLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9lMTAwMGUvbWFjLmMKKysr
IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvZTEwMDBlL21hYy5jCkBAIC0xOCwxNSArMTgs
MTMgQEAgczMyIGUxMDAwZV9nZXRfYnVzX2luZm9fcGNpZShzdHJ1Y3QgZTEwMDBfaHcgKmh3KQog
CXN0cnVjdCBlMTAwMF9tYWNfaW5mbyAqbWFjID0gJmh3LT5tYWM7CiAJc3RydWN0IGUxMDAwX2J1
c19pbmZvICpidXMgPSAmaHctPmJ1czsKIAlzdHJ1Y3QgZTEwMDBfYWRhcHRlciAqYWRhcHRlciA9
IGh3LT5hZGFwdGVyOwotCXUxNiBwY2llX2xpbmtfc3RhdHVzLCBjYXBfb2Zmc2V0OworCXUxNiBw
Y2llX2xpbmtfc3RhdHVzOwogCi0JY2FwX29mZnNldCA9IGFkYXB0ZXItPnBkZXYtPnBjaWVfY2Fw
OwotCWlmICghY2FwX29mZnNldCkgeworCWlmICghYWRhcHRlci0+cGRldi0+cGNpZV9jYXApIHsK
IAkJYnVzLT53aWR0aCA9IGUxMDAwX2J1c193aWR0aF91bmtub3duOwogCX0gZWxzZSB7Ci0JCXBj
aV9yZWFkX2NvbmZpZ193b3JkKGFkYXB0ZXItPnBkZXYsCi0JCQkJICAgICBjYXBfb2Zmc2V0ICsg
UENJRV9MSU5LX1NUQVRVUywKLQkJCQkgICAgICZwY2llX2xpbmtfc3RhdHVzKTsKKwkJcGNpZV9j
YXBhYmlsaXR5X3JlYWRfd29yZChhZGFwdGVyLT5wZGV2LCBQQ0lfRVhQX0xOS1NUQSwKKwkJCQkJ
ICAmcGNpZV9saW5rX3N0YXR1cyk7CiAJCWJ1cy0+d2lkdGggPSAoZW51bSBlMTAwMF9idXNfd2lk
dGgpRklFTERfR0VUKFBDSV9FWFBfTE5LU1RBX05MVywKIAkJCQkJCQkgICAgIHBjaWVfbGlua19z
dGF0dXMpOwogCX0KLS0gCjIuMzAuMgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KSW50ZWwtd2lyZWQtbGFuIG1haWxpbmcgbGlzdApJbnRlbC13aXJlZC1s
YW5Ab3N1b3NsLm9yZwpodHRwczovL2xpc3RzLm9zdW9zbC5vcmcvbWFpbG1hbi9saXN0aW5mby9p
bnRlbC13aXJlZC1sYW4K
