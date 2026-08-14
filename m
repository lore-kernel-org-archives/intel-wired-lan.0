Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E41DC5CFC1
	for <intel-wired-lan@archiver.kernel.org>; Sat, 15 Aug 2026 01:26:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CA9E960B10;
	Sat, 15 Aug 2026 01:26:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8kKx9qCldDEJ; Sat, 15 Aug 2026 01:26:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AB0ED606DF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786757174;
	bh=x1M+38VVBttjdczTOkQcikRQnaO4Jp+lD9HsMljn0YM=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QiUCngrkjm7zQ8ErGJOAcXi4U8S7AjaYcruBYbZWJDyW0ozLyNAJBnktoOnIRZYaS
	 5PsOKfv8xL+jodkyrk11IcpDsI6CnDdct/8xA3/Uq+OHxqghXKdJH6ALO6gf7LtLbx
	 yH+TiUm0EDrnwGrImZl00sUHQYvww+a/Dk4MUMXz7mzq14VvvZJp6vT1mija7UOD4q
	 xP3tsu8QIC8HGHWbgOt3GdODZOssMlGRnqpdRlsOnht7P4R0pD3Q4pTBhebCcSNtZL
	 rXtsjXMnAz9ovtyjT8frLkWKFcL39zPnpKg9FkM9xKdr2lV8jJQyQpheKGWCO9g0LX
	 uFKG1iYSokSOg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AB0ED606DF;
	Sat, 15 Aug 2026 01:26:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 319922BB
 for <intel-wired-lan@lists.osuosl.org>; Sat, 15 Aug 2026 01:26:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 23DAE40BD2
 for <intel-wired-lan@lists.osuosl.org>; Sat, 15 Aug 2026 01:26:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pkfRuLCRy0vc for <intel-wired-lan@lists.osuosl.org>;
 Sat, 15 Aug 2026 01:26:13 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.21;
 helo=mgamail.intel.com; envelope-from=paul.greenwalt@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 053A040BC0
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 053A040BC0
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=gIE3rKI0
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 053A040BC0
 for <intel-wired-lan@lists.osuosl.org>; Sat, 15 Aug 2026 01:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786757173; x=1818293173;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uId5g3DqFv4eHYhtqK7IUw6Taku6sM+8MhYTCS58Kv0=;
 b=gIE3rKI0Tzu/rg/knaRMWhr27VD2iww5vQCutni3yIN4+DRfIwHYuSe/
 J2cdhdWHqprs5aHaeV8W0PffgW6EJrfNawieoaZMXIyOhLVH4JMAHDR+K
 epU7ncBYbJw5CQ3OylUXjl7n9KSHp7NlH6kQYuGQ+XO2ciQIke5fhrnyd
 sbtH8RPqamH1yvK90sgjE/vy/zkqSBs45mQueD8g8qISHU2AE5a/+qMBR
 jslbDOhVYRmttBNX81LI9CLMuWhqN/Xzw2QwnLXX3ZRPsFo6HGB7gtcY8
 v874WsVfWd1IwISDNLm30eN3k7tGc22cTrF9aDFdISfxCkf7Nk7lXm6cZ Q==;
X-CSE-ConnectionGUID: uTUIRATQQDigUBJz53Qy1Q==
X-CSE-MsgGUID: DnFesqIXTfSCCnyA0o6c2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11875"; a="87194380"
X-IronPort-AV: E=Sophos;i="6.25,224,1779174000"; d="scan'208";a="87194380"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2026 18:26:13 -0700
X-CSE-ConnectionGUID: qJO4KlTBTPKnguV/y4uTNg==
X-CSE-MsgGUID: 6MQ8ykKgSAqWKDXNAnkRkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,224,1779174000"; d="scan'208";a="287844731"
Received: from unknown (HELO fedora.jf.intel.com) ([10.166.5.147])
 by fmviesa002.fm.intel.com with ESMTP; 14 Aug 2026 18:26:13 -0700
From: Paul Greenwalt <paul.greenwalt@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, Paul Greenwalt <paul.greenwalt@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Date: Fri, 14 Aug 2026 13:49:17 -0400
Message-ID: <20260814174919.4177289-2-paul.greenwalt@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260814174919.4177289-1-paul.greenwalt@intel.com>
References: <20260814174919.4177289-1-paul.greenwalt@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Intel-wired-lan] [PATCH iwl-next 1/3] idpf: clear drvdata on probe
 error path
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

If idpf_probe() fails after idpf_cfg_device() succeeds,
pci_set_drvdata() leaves a pointer to freed memory. Clear
it before freeing the adapter to prevent potential
use-after-free if anything accesses pci_get_drvdata().

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
index 807608899084..6f9579c39342 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_main.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
@@ -364,6 +364,7 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 err_init_wq:
 	idpf_decfg_device(adapter);
 err_free:
+	pci_set_drvdata(pdev, NULL);
 	kfree(adapter);
 	return err;
 }
-- 
2.52.0

