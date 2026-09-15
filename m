Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 157AEC88E7F
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 12:56:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CF054406A2;
	Tue, 15 Sep 2026 12:56:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6eKD5158S_vM; Tue, 15 Sep 2026 12:56:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5680B40699
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789476974;
	b=Wou6O5oqoHlxMOegTztwOhU4W+tBuyx3uvvV8zA1z6Da7N8RcngnXOi6eLkG0TM44ibJ
	 5R8VpqTfRRqAQyqC51GpI2tnzykycK66OSLtndLKv8OWcGOkRIaHmdfmdbDC4tSHtQllt
	 mpV3caNHDW/cX+cjUUpYvHjuBSMz5XFv4lJIcEoIkEprIpZRxJtxEJAYA3/AmVIkH3ZPa
	 1IBFUNoUXXBt8jepWg5WnvvOR7eR/IM/npPSpVfN6kRVqDc31FCEzPfrR5NDII9IVEhL5
	 mPIu288PeK70DcOlezaVYnEAHljoOUzSkHbl2mV/SLnFCppvjjdSCfm7hc5yewsI4lA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789476974;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=4L1Ndo0q84a4+J6kxQ/RhBkx6h6tXby5XzGHTmlOfr4=;
	b=RKkc9gOHqDQEjvMNCE6hoGnA7ACscMXL/8m78vFIku3brVQ8kahWN/bmcSXwqoAmuNIx
	 Br7/Os1q0jL+PJ7asm5QqiSwNSPYflK9y+5dMGUPvknK2ALpuPFnf/ChDVp5LeEBQ5DpN
	 HmnCyCK0HCYktmWRwzrK5V91E+ZiaX+DpTs0tH2tstjcZ/elkn/j0jZH4rpMalBxG+C9C
	 lifxeoTlpUx27W9JsZs8KEte7hkmawEZusqD+DO3VwRkpWgVQMXeKJ0UnyYwXs4ydFfCX
	 aj89WRTtaPR4rDGUTsqgOJhk/EU9hlHULi03h++hAXiFpXtanKD4hW4KjI7bBjCKXUg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789476974;
	bh=4L1Ndo0q84a4+J6kxQ/RhBkx6h6tXby5XzGHTmlOfr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H9dtJO+j3F/L0qAA5orPyqPssZPO/DrADcMjidF4Xprg6SX0IMZ8FxURNTzLeEb8/
	 rP35kGvLObJOfkICQGDdvu2z/BflilYmzeAVzMGrIA32GPGZYuSdCmnIAnaOnnzHoF
	 plaqvdf6sqL33WTcy6Z31SaiyUJrXB22gzT5NPeLz1zXey0cXgCwRSXXmZGaymyf/2
	 hzGCJ4a3UN5ItH01OtKhrk6aRO5kk48L/r2RszYqcUPI7PjVICWUPyGasiQpDuy6Q7
	 /oKn0LOngRjGT+V94KGE8nPJb3zVjvrC25aCyRfLBbJ4Zz0ZBgBgpQhWoAOtGLLkQO
	 F0QxgszucDLYg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5680B40699;
	Tue, 15 Sep 2026 12:56:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 69AAEDD6
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 12:56:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5ABB64002B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 12:56:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TDmys-6NEeRj for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 12:56:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org AC8FF4009D
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789476969;
 b=CbC3e5ppeQkcxkuPm++WtZ+PJfifv1+hp+nFK8hIpFhDPO6c/dcAb7pH1Ih4U0XNGFob
 mK1RIZ4M9NbOV7EsZ60Q4Mj5VyiAO0/wZCLhOzcXVI9cLuwcYZVT7bYDNTWlYKNQTpJ/A
 AqcdzIPabkPR8D7/xCbr2D/kU3mqAfqWUgykrsirvZvN2DUvtHL1nVA741TRhEFytpPco
 Ql82tq0NWy+O/bFzvy914RSXlfLx48T0Myk6eybpTCON8I7A/ZjBEMsdYb0Eg7MvjJeiz
 NvBcsBrHB6JNOqdPCiCyaOKoZcSacpuvXrqkACCfsi6lTi9zdg/QvsWUax6FZK8N53Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789476969;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:Received:From:To:Cc:Subject:Date:Message-ID:
 X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=4L1Ndo0q84a4+J6kxQ/RhBkx6h6tXby5XzGHTmlOfr4=;
 b=iiYcTPjRsEgH7OeRYzR2wcrdlpSoIpSKbps66ELFVe10Gcsy/wJ3+QjQxN67FXbNElZP
 bPg6Hqzaf2mCewBWon3kv+m78X4bHDX7Y5IfregL3JM4Uktah8cw80jTW4yJ+3e9NkV1+
 5f5wPozQq+WEV8Cj3cBW2OOeaIN0cyLWNoExcPqUk4eILW779Pqbth1CObDGPwf9GpaZt
 99LoTffCG5JIxoy53M0TOjtqUkHdvVg5YblnT68BlSQ3r3hbOXwAutCNkgl2zErZK2w7i
 02PWW3uwNAO1+p1oDuXrnF0Mjs/3pYaVvfQycYX7rUL9/Yr811OYx1pqHXR/6skBwKA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=V8qj8Y13; 
 arc=none smtp.remote-ip=198.175.65.9
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.9;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=V8qj8Y13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AC8FF4009D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 12:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789476970; x=1821012970;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=On1pLPVQtHxohooxcvcmMAW3DwaX2GFpkBX9DoheHhM=;
 b=V8qj8Y13r+Wt7MoriR/XSCE2qBOL1uLEGEOwr/koEB+XpqOAddIQFOZK
 JWvLWEOTH0ADLnJb8CFKAtlIIKuzp6nL7EHsxCVkB0K15Wg0W0ABe3ug/
 NtiFEegEUmF8rNk2rwDv+6EeHMo9qn0ovcqSieqKCPL0Xlq1F0ow9r9BM
 WcO8tGilgvr9WqwC/FXYwHaj4CS6P7DhgyMQZd0vW9P3Jhu59B8t3Zoa8
 AhF85IxiMLLOU5MAs9HUuT7qJLqgMolrDmt3sjlOzWg6ni4+CYipRiNVn
 67XbGY+/TSNYtbDNqttfM4eoWi1f6OGGglBUgLVDMmE7CkOe6HVioKP5S g==;
X-CSE-ConnectionGUID: 8PLQj0g0Symh810H99VaZQ==
X-CSE-MsgGUID: iG9WgYSGRCS1LiZdkhpNGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="112607081"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="112607081"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 05:55:56 -0700
X-CSE-ConnectionGUID: W9wafoBsQ8ivnHBMm2LdIA==
X-CSE-MsgGUID: 1AK9FFU6TjiqLVg4vX98KQ==
X-ExtLoop1: 1
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmviesa003.fm.intel.com with ESMTP; 15 Sep 2026 05:55:55 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-net v2 2/5] iavf: fix error path in iavf_request_misc_irq
Date: Tue, 15 Sep 2026 14:55:48 +0200
Message-ID: <20260915125551.3976068-3-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260915125551.3976068-1-aleksandr.loktionov@intel.com>
References: <20260915125551.3976068-1-aleksandr.loktionov@intel.com>
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

From: Piotr Gardocki <piotrx.gardocki@intel.com>

When request_irq() fails the interrupt vector was not registered for
the driver. Calling free_irq() on a vector that was never successfully
requested triggers a kernel warning. Drop the erroneous free_irq()
call from the error path.

Fixes: 5eae00c57f5e ("i40evf: main driver core")
Cc: stable@vger.kernel.org
Signed-off-by: Piotr Gardocki <piotrx.gardocki@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index dad001a..ab5f5adc 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -587,7 +587,6 @@ static int iavf_request_misc_irq(struct iavf_adapter *adapter)
 		dev_err(&adapter->pdev->dev,
 			"request_irq for %s failed: %d\n",
 			adapter->misc_vector_name, err);
-		free_irq(adapter->msix_entries[0].vector, netdev);
 	}
 	return err;
 }
-- 
2.52.0

