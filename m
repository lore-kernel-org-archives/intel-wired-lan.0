Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBFA9C61DD3
	for <intel-wired-lan@archiver.kernel.org>; Thu,  3 Sep 2026 16:03:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 91E1860B75;
	Thu,  3 Sep 2026 16:03:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XuHHEpdR4RvP; Thu,  3 Sep 2026 16:03:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0088860B43
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788451403;
	b=HXVMXAXfDrapOYl7GXPLi87zykrmujIFwBAyShiU0QRTDIF7htazdhDXs8FeK8mar3Fa
	 2EU1CX/BTvxzwaOSGjDRCYnqwR74wAGj7VMNUrWv6wFQWWIMiHad8OZhfydcG+uJKewNO
	 6HAUfGMKdQriCq6Zh11Vbbl64/ljs+o0ATIflxS+qx9u5Gy5aXzR3RXThYWErL9PCb7Z2
	 dFEKFNjq2TK85VVoC6WnNTGdNaQx9f61YTRfG6KlznnpCHLwTn+Hc0Q9wl8o2hWxUkipX
	 FL/Rt77wkd4zF2pzF8lV1lVwp5tmo/7bkU8b6BswfzaIOfRxAEyg0qs5rMY2tEG6LOw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788451403;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=LZj4LdSfPedU0Mmhrz7DO0cjxYNFhpgyLP1lLl+xrJE=;
	b=iR+wTdKSzYFY5GdcR3FQ4+SzgFy+E3notSHSM5iXBbUd1msokHpZux/RMmVEYCZz4myc
	 Gd02jWcdHEn/Z1mMpV8vPt3BBtlM1ni9jLw+6st7Hr3NjmeRdTuwT0khO0yKKkG/ejVNt
	 an0OOF5KAORvmCILg84zRN2itEiJBFT36hkNEjcv38E76qafn13cwffTzOBbKve9wZ+hI
	 qNItaRvqJpXmhYXcyc0Zd+NM7ThMp0A/72GzjH8M7yWrQsybPJ8JTMLVuyyIYuwkyVW5K
	 VMzHLbuprzN2l9KNyQuAX0bLVv/WWvYbzJGQlvnI/a1dlbXUD7UKzvglfxuU4sKoqRw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788451403;
	bh=LZj4LdSfPedU0Mmhrz7DO0cjxYNFhpgyLP1lLl+xrJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=3ur1GEY2g2sp+rYzsNBLBDqpRWIx6p7vvij/7OTL/dlUtvSc8svm1V7QDFEZ+sFJA
	 70cl9rC+mst9zEedhVHCwTgjeNC/o1I83KbudhinmfBgykAwwklE4ya2eLHIAyIGUr
	 Spj+LpqfhTVPY/F8z4pw60fe82ZMtVxUkL48X17nmRn3U3S4bsokLlQdicRe0pnnjC
	 tMr6cdBnAgPsOlyV77SN73iEkwLV6mC6E3Mu9EZa5S+JbdP7I96gC74ZQdqPkf8MIv
	 w9Ki8qkNfmfBEJOpWaGNWhhfwfVTBfIwZEGUKQHclCmv7asykgBNDlwplOLUeviZ3v
	 X3u0vUBwqS/Wg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0088860B43;
	Thu,  3 Sep 2026 16:03:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9117F279
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Sep 2026 16:03:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8391B40B1C
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Sep 2026 16:03:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MC9fDXkFYKKy for <intel-wired-lan@lists.osuosl.org>;
 Thu,  3 Sep 2026 16:03:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8510940B0E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788451400;
 b=CcsZmdqIywIsWDBIip852x8AZ0kHyNAnTMkdwTl3oyRplri06d/Ep1VHYS6+LdFk64d+
 9WdwLZP8zauf4Vli1s6tQzoXEvvnSJYmmp156DPRPdE0RqQSM2gOT574Mya0NH/hvWX4X
 0fhL9YvD/JJOlQlPcCkQJONdgGJQVxAEL/uvQ88/KKQmCVzNGgdBmTi2+lDQ4/zZytt9q
 tUfUyaoeQH9aP/21/7ybmEgW1R/gBMRYaqchZJQ5r0Dv4i0zgx6MKiVPkuu9rop3RU5Ga
 JRRWzqJrMEqfH0IZ0pvi/FK7YmPDr+uyrFhEP0KHreiUY60BIu+vivIR2oIdhKzQ+fw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788451400;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=LZj4LdSfPedU0Mmhrz7DO0cjxYNFhpgyLP1lLl+xrJE=;
 b=GURHVJ9KGZYNIkmYj/2XA8amhJefrGTfkdFyRf5k/982xvPek6vYQchv+z1QAIrQPBSD
 OtWFDZ7Qccywn2yNeChltWNWiTVjqt61it83+0vZSjt7qeWaNC7HxJubJut0uC5mEfGF9
 TcyqOIKTHEJWlE8I4Rt7ClazBqGQYtIlBOGT88YBpA0bqFXp07DVpNzemzndb74T1tqMq
 yK22dbiADrg945FByCbnAjKk1vlbTLsijF0LTORz9MQoe+Lwq7wgr1jVWP9/lhKeU3JEw
 mSY5pWNaAGLPL6yGpO1S5d7F78hgw/psEI8gR9mpghCT0oAx7Ol2hzWG8BK1BzPCMHg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=d2OR26Tk; 
 arc=none smtp.remote-ip=192.198.163.16
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.16;
 helo=mgamail.intel.com; envelope-from=paul.greenwalt@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=d2OR26Tk
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8510940B0E
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Sep 2026 16:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788451401; x=1819987401;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rwuWtEjxe/h+L0LLA3eu0cuUAJDgmKszxKZBoiZCt2s=;
 b=d2OR26TkGIpoW9ol3bXRL1iOE5HkIeXMbJanUWcxFzWrcGbPlEWfM1as
 /g/gpj5UoRU767E4fanDPpK/oeZR6yYaLzo6eTRIb2wAm0j0D7MFvBDmI
 4oUIpFooyTGyKoNCXYCHwVLIpCytG9Adc5SACfn9dAYiUzsThjDHUJNg6
 Kz0nN2lhuEqzFljT7lvEZjyseGBCmMrSKncSvvTAFaKRqGqiwLKs2Ukk7
 vi3u1lLoutjgpMoeWIcwseCCFadR+/845Ulo040HZY4zKpiJsCBAljPtP
 wqdZDxwToxxHBVfkrqJsq7xvqyz9+3Z+zmtEtOCWWERdc6HgxHcXVKIfS w==;
X-CSE-ConnectionGUID: zXITxJK9Rwm38bvxveNsYw==
X-CSE-MsgGUID: SWlvNM7qQbiti1jLNOMpdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="76492947"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="76492947"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 09:03:19 -0700
X-CSE-ConnectionGUID: UJRI4aaxT4KV7nMHiU3cKA==
X-CSE-MsgGUID: uN3oR0dxRaq6asiIwa/19g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="293270200"
Received: from unknown (HELO fedora.jf.intel.com) ([10.166.5.147])
 by fmviesa002.fm.intel.com with ESMTP; 03 Sep 2026 09:03:18 -0700
From: Paul Greenwalt <paul.greenwalt@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Paul Greenwalt <paul.greenwalt@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-next v2 1/4] idpf: clear drvdata in idpf_decfg_device()
Date: Thu,  3 Sep 2026 04:27:39 -0400
Message-ID: <20260903082742.43837-2-paul.greenwalt@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260903082742.43837-1-paul.greenwalt@intel.com>
References: <20260903082742.43837-1-paul.greenwalt@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
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
Errors-To: intel-wired-lan-bounces@osuosl.org

pci_set_drvdata(pdev, adapter) is set as the last step of
idpf_cfg_device(), but its declared inverse, idpf_decfg_device(),
does not clear it. idpf_remove() open-codes the clear right after
calling idpf_decfg_device(), so the two functions are not true
opposites of each other.

Move the pci_set_drvdata(pdev, NULL) into idpf_decfg_device() so the
set/clear pairing lives in one place, and drop the now-redundant
explicit clear from idpf_remove(). idpf_decfg_device() is also called
from idpf_probe()'s err_init_wq unwind path, which did not previously
clear drvdata at all; it now does too, closing that window for
consistency with the rest of the teardown path. This has no
observable effect: the driver core already clears drvdata via
dev_set_drvdata() when a probe function returns an error, under
device_lock(), before any consumer of drvdata can observe a stale
pointer.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
index 1e4dd9b713a0..fc67d8f02569 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_main.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
@@ -112,6 +112,9 @@ static void idpf_decfg_device(struct idpf_adapter *adapter)
 		pci_disable_ptm(pdev);
 
 	libie_pci_unmap_all_mmio_regions(&adapter->ctlq_ctx.mmio_info);
+
+	/* pairs with pci_set_drvdata() in idpf_cfg_device() */
+	pci_set_drvdata(pdev, NULL);
 }
 
 /**
@@ -182,7 +185,6 @@ static void idpf_remove(struct pci_dev *pdev)
 	mutex_destroy(&adapter->vc_buf_lock);
 
 	idpf_decfg_device(adapter);
-	pci_set_drvdata(pdev, NULL);
 	kfree(adapter);
 }
 
-- 
2.52.0

