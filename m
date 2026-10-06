Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03A44CA6004
	for <intel-wired-lan@archiver.kernel.org>; Tue,  6 Oct 2026 14:33:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BFF5A80DCE;
	Tue,  6 Oct 2026 14:33:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EfrkKA2e2ZyY; Tue,  6 Oct 2026 14:33:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1280580DC0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791297221;
	b=baAZMUjybfkzq44/OB8pRQ7SNzx3WMfsOvRLJA7K9539o7Jhotibrfd2y79Wa/878FWL
	 MP+pk1+0vXYlCY55exzRMmsa072fQInx2gjgXzfIDpzFGES/4rVdLWxycij0dMBE+3xri
	 9kCQvoj/o8iXs79AMCbUgvsnR2TRwuXZno9Pxz0Bxr+ixDWrSa9SXd/IMOLS9AGLWyD8r
	 Y5XGgJIXjEkZffvz9oEbkpnHWrFWa//NVJHE3eI+YBH+oBBXV655KRX3bCbGe+fQS9pgA
	 DoxfWRuT3hESCdlJuXN2Zcmt+AAVUTrFwkLFkW5P1944hv0CLMbbRgwWFera1c79AzA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791297221;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=6riLc9gn/M4eYs+hLmdDLqBD2nxwyvtp6G5ysCHxvZk=;
	b=IfgarPKqFxa+ebwqimcNrj3jfEBQb8YO5PjBxUPLWj1dU5z/twfO9GraZginP+q/E8O6
	 TbryBRr+VCJaputySPWbD86RlUTefwVRMKYcAfB7dzrNGEZBEBh3pWD3dlnyjFYzVzZWv
	 XQJXLuSm0nnsHL+BaZ4v2cNDJgBmk37balOb8N+H5upNIFEDzn7ZtFtrB3kyJhz9OY2g9
	 RX2Yaqm4QBYKmWj56pQzkRWszoFbCTUDLxV5G4MaGusNrYvDZfVgEM4V45YBEcY7f3OnS
	 4787weS5GrSqrf8+2Sr/XcXZ0kwj1MwP8IcIpbyonaUYAqel58DjbHh4A/vHHSyFUow==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791297221;
	bh=6riLc9gn/M4eYs+hLmdDLqBD2nxwyvtp6G5ysCHxvZk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MDOekrh7W1b6ZZbuhlHgv03VWcyXtSr1M0UhNJiX5E1Yzu1fqqPAaqjBYVy23hieq
	 OQCL+OCwyJTmIW0N0za+lKn+zJVL3eZ37XRlm9mE4Bgg+V4+TVCvhky/RyiDuYvWon
	 HI/MKKhBS1Yxgw1sjYUixvEvBtxPAFMIVWkflYXrBBBJisvSn/jKQsdFPBGYFWJLQZ
	 Nt2lZmSZmTzEKUNwK45wQa5oelwQgk0TlzGOciubqo5LYShu6WZAG6aDK0zw9X68BP
	 6JF+ULllNqPJe1jzadY9UMXlyJWqL14mdvhchHnNX5xh5cmIU0k2LtC9vjc0AvfCcD
	 e5EW3S6NW3RCg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1280580DC0;
	Tue,  6 Oct 2026 14:33:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 43CD9341
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 14:32:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3606C402A3
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 14:32:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 74VCg79TisnB for <intel-wired-lan@lists.osuosl.org>;
 Tue,  6 Oct 2026 14:32:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8714940268
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791297149;
 b=RVF4l/K1Qz5cfhI4Xlp9Uyh58H5QsxR/JYWkH22JIQwjRuNQFc6o5fdB2I0mE4q8Lpun
 IKLatbfD03gY28vPmm+lGruFifP2WjZ3Ljj22aFagXBmdcUwierbqXkKn/vqqOaq6WQ9e
 uo3mhVdPjHvZCCO3cVXLdh5BhQ21MHgytHpLR/rgbIxodeh5HSefCP119viY454k7S7zl
 KajviU1pEkkF7kMmIRVWGu1QHS56btEEDM4ap5tmhKmpwUwGTXcvYok2oeiGSJn7OJqNu
 rL8sGnh3Iwm7Wz4nnYpozAAGgYa1Rv3ouGV+zfhcuUlQiDeDU+QAV9xkuGqqqO6H9gA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791297149;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=6riLc9gn/M4eYs+hLmdDLqBD2nxwyvtp6G5ysCHxvZk=;
 b=MBF1Eks5g4PsmcIYIuL0dwiNQ1TmUNlcgQgbDL2dYXBhH6LfP6gaCL7U4X+MGFqfW9D7
 hOZwQTr4No/KOg3hcA6Bh5HXzAIHfvu9HcVesrUeglcSjNEVpmh3atF77Qb7nGqbjUELv
 Z0LAi3FOjsfcA0pl4sOG/doc8w3xwweFJooDt+6PvU4BVozqxqNsIC/WTItam/h4w2PEo
 oAjRHt/gk2Xn9BrqKWQo+jzANn8rQqfJNEaTgJcCN5pKtz25w3GV+2WT21wlVDh96hHQc
 XiCwNrXEunoYCR3PMA1rvbvmWOcBEjA19ZxE3r6t600EornDQUubBgsXYa18Eqot1zA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=c+aPfdPR; 
 arc=none smtp.remote-ip=192.198.163.16
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.16;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=c+aPfdPR
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8714940268
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 14:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791297149; x=1822833149;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=cHLjYi4+d/RUAh9y0+pgw6kZnmWF8t5gGg5xGZpKwsY=;
 b=c+aPfdPRtraqZBlVeVrVAPh8ciExd/AIYQ1x7M/6ygyzMq9F4ifkfVGv
 xqboUe7i6MdbWqCxk7YPymTx+lmb2w/oFm0lEz54HH5Yg8yJ5c7NsXRoz
 0OBt86E4ujWefiVOiUfIzxjv/ODOH50KFLsmZnrsJs09tSzePPXQpSNPH
 n8UhdqH558mvinyiPSVb7TQj81YSLpZd6IpRrgkYSRa0vcnEJ7hP/ciW+
 lUSSbp5/JoPX1l206QG9owQbI8VLDzLR4DYgk/nOZ09o0bHb48eFRsSMZ
 QXdWaqnnk4JPjygCRYYWsfYDrfFkTtz086PtQdUT4M20/CaxB85aDtrdN Q==;
X-CSE-ConnectionGUID: fR5ui8GpTvmnfhTUa/3bug==
X-CSE-MsgGUID: IoOr3Al7TbqLDiEoczu6EQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="40118"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="40118"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 07:32:29 -0700
X-CSE-ConnectionGUID: sKWCxJQ1TyyVCqFpId2GIQ==
X-CSE-MsgGUID: VgENpkg+T8GNs2z7zcF1mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="275813111"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmviesa006.fm.intel.com with ESMTP; 06 Oct 2026 07:32:28 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: Simon Horman <horms@kernel.org>
Subject: [PATCH iwl-net v3] iavf: fix error path in iavf_request_misc_irq
Date: Tue,  6 Oct 2026 16:32:27 +0200
Message-ID: <20261006143227.2879494-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
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
Signed-off-by: Piotr Gardocki <piotrx.gardocki@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
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

