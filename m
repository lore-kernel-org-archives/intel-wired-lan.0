Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95FF1C77B7C
	for <intel-wired-lan@archiver.kernel.org>; Thu,  3 Jul 2025 11:46:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4DCD860DF9;
	Thu,  3 Jul 2025 11:46:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1hpRwUpdF0PU; Thu,  3 Jul 2025 11:46:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C095860E0C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1751543202;
	bh=tBx6NEC8GsoxyDD/gwqFwxuD6bEIQ8wrbTMKJedUbd8=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WDARtEamSB/psRuNg3VsD4GbKxpawr1uNZobu4U4eo8R97bMWGgCl9pnuEX0t44bW
	 yy7VH4cL1FtV+db8OiowbhFMm4fCzawQdF4x1xH1c5a/uJwGYfYkAW364PqVY95bI+
	 yTqS698itAyYVgeeaBnhnDGVCIQySB7oGZn9VisA70fxWILyjjOWCx1cU2Qy1eT24h
	 y+JLdWX3k6Q6wywO6XBSpdFhjiG3LpDDPTbFpLSCuS2GBbJawRHu/RuUY936Gl4Sry
	 S/Su5iWKO6Z+3fdqNXJ+RPNYxeuLp94xD4i5uRzWiiuDzniGECwV+sPzNCozKlCibm
	 xntEQuHdQpjdQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C095860E0C;
	Thu,  3 Jul 2025 11:46:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 23FE5193
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Jul 2025 11:46:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0994C4072F
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Jul 2025 11:46:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eWXjYXhLg3qe for <intel-wired-lan@lists.osuosl.org>;
 Thu,  3 Jul 2025 11:46:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.9;
 helo=mgamail.intel.com; envelope-from=jedrzej.jagielski@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 6B5E04017B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6B5E04017B
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6B5E04017B
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Jul 2025 11:46:41 +0000 (UTC)
X-CSE-ConnectionGUID: 4XlbVApoS5iZ6cEqjb9kTQ==
X-CSE-MsgGUID: kbWf0zOISGqCqUx7qERFKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="76411122"
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; d="scan'208";a="76411122"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 04:46:41 -0700
X-CSE-ConnectionGUID: RcthAU26TCegUM8ad0krlA==
X-CSE-MsgGUID: CWKNUrJmSgSMWUd1meejsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; d="scan'208";a="153780323"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
 by orviesa006.jf.intel.com with ESMTP; 03 Jul 2025 04:46:39 -0700
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com, netdev@vger.kernel.org, jiri@resnulli.us,
 david.kaplan@amd.com, dhowells@redhat.com,
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Date: Thu,  3 Jul 2025 13:30:21 +0200
Message-Id: <20250703113022.1451223-1-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751543202; x=1783079202;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=cgMuh17xA1ql/xkR2cAotkaIPYhgV1dPC0GUwBHrweQ=;
 b=iGwyaWD9mHgFnp0+u1bhZhOJQCtOJrvUdTIjyNhsp1qfQMd4fgEKQc7W
 p+73jZXy2wtkeWMeig/8CLLPSGeoH6gTAKj14p97Iv81eD11dbpetFXI/
 EzWLSdy70JSHd877MtlJYa6o/QzUv+x63/TKOBbBjRnyl5qq8wMpW2OdV
 hPWC5yAYwwWXsOO79Kqv58KNmrwWmr64Rs6uY+bJLefbwYWKDGSnylCyh
 7wyFQnQDnURurKwbAuhFUFeH3+LpdprMrsrHpjzWO6OsXEHBO8rHAjgtR
 wFGVS8YLDYjt0PVQ3qHrRcUqxTx8wQ8TnOEymHyngkmwgxqZhYOYeLjZS
 A==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=iGwyaWD9
Subject: [Intel-wired-lan] [PATCH iwl-net v1 1/2] devlink: allow driver to
 freely name interfaces
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

Currently when adding devlink port it is prohibited to let
a driver name an interface on its own. In some scenarios
it would not be preferable to provide such limitation.

Remove triggering the warning when ndo_get_phys_port_name() is
implemented for driver which interface is about to get a devlink
port on.

Suggested-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 net/devlink/port.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/net/devlink/port.c b/net/devlink/port.c
index 939081a0e615..f885c8e73307 100644
--- a/net/devlink/port.c
+++ b/net/devlink/port.c
@@ -1161,23 +1161,6 @@ static void devlink_port_type_netdev_checks(struct devlink_port *devlink_port,
 {
 	const struct net_device_ops *ops = netdev->netdev_ops;
 
-	/* If driver registers devlink port, it should set devlink port
-	 * attributes accordingly so the compat functions are called
-	 * and the original ops are not used.
-	 */
-	if (ops->ndo_get_phys_port_name) {
-		/* Some drivers use the same set of ndos for netdevs
-		 * that have devlink_port registered and also for
-		 * those who don't. Make sure that ndo_get_phys_port_name
-		 * returns -EOPNOTSUPP here in case it is defined.
-		 * Warn if not.
-		 */
-		char name[IFNAMSIZ];
-		int err;
-
-		err = ops->ndo_get_phys_port_name(netdev, name, sizeof(name));
-		WARN_ON(err != -EOPNOTSUPP);
-	}
 	if (ops->ndo_get_port_parent_id) {
 		/* Some drivers use the same set of ndos for netdevs
 		 * that have devlink_port registered and also for
-- 
2.31.1

