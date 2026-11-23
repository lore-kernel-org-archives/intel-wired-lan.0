Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEFB606A32C
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Nov 2026 18:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=wV2+UHZn;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=HUoHEc4v
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C30EF80BD2;
	Mon, 23 Nov 2026 18:00:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id odTU0mXo7H1z; Mon, 23 Nov 2026 18:00:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DDFB080DD7
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795456857;
	b=qxVMBKux2agY1ZDL7lzYgBSaHqa3W3FukEGe4CEQTU0O8uD5gY0Z7YAtB7+0pBSczmDq
	 KBEh4JilpqVUmuWPtNUjI4WVjZUTc9vSgdC4D+UvHIJsx1jZzJ9aPA6jvZNtDu4h1cWux
	 LsLpOYG0oTFgAySLbIjk9YZjrU+D93fOaV3ZGdVhxX75MaXXbFlhva6YyhPvNGHZP1NSv
	 OO2DUkGoqYKNrbs6KZ0ljlHMHt7g/uaJsHh3/62PE2cwGMll38R0k2d601ccA/9B60+xJ
	 5rF9nSqGL0dZyLBT+gnJfrk5wW1hVaCTZlmxevEKPVGLKmMkOOnSAMEpiWKXInPLbbg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795456857;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zx6yEgwy8nze2Tq2bWtkVXJMQWmaTvH/rbYpXA9I2lQ=;
	b=CRhQ/zJ12a5ldJef1LPs8Xf4e7jfyYq2EbwZn/2fLB45eC/Xn5vzz6ekvLqgnJu1BLZ4
	 ARSXBPx4++78pc3UlP9RxWq2lm6YySdPsMi+Ix/TXcxMusJkyIqgh0iTGcr1TkwqHDsYq
	 rwvyu9MZuesoXMgAsFigEq/dJ5tb1Z2CbTyzlmgWzwtZVh1GM7hROVoO1mq65Q8NnUjb2
	 Thaggu5oSyMFKiTOxS8oK5QXfQ7Doq/2nbszQKK84gx4z2DvVTyyM/bQJGSJ+vb0ckbVk
	 odD+cAmDliksauxA2ZzhRnR5Lwh9RlV9Sf4C/JsiGlXEnYdUweBBF1EkUIKpfwz/eqA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795456856;
	bh=zx6yEgwy8nze2Tq2bWtkVXJMQWmaTvH/rbYpXA9I2lQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wV2+UHZn7D4W3mhxaApspHBDo0DkUVmd4NX/Y9WyvSGqpsqZqIWRZSdDsVFdIX9cK
	 ZahWzhbtB9cxw+dDOpkZA4ZDntp+MSGNGe695TiaXEokr4hLI2zeUGHCffOjm5RJ5Y
	 rQvqxqZHgc7NXzX9yqsaT83mvQ9wbml362/nwmKaqMQTsQ64NoE2BpIN2/t73atD/f
	 Rky+54rjO3KgLx8BJAyeOFBQWfFKBt5/cV9Rbpz6quducuh/7a74XCF2lmZrjDvtOh
	 t00bkjjPqC50X233YLIS9GUQCG+wuddJBxmHUQFf0Nze41TWd5kXZxT2qt1NCKY5bg
	 GYPrKK8S1F0/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DDFB080DD7;
	Mon, 23 Nov 2026 18:00:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C229E15D
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 18:00:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B3D0860661
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 18:00:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I3iBLo9mxSZK for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Nov 2026 18:00:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org ABA04605F5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=40.93.201.36
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.93.201.36;
 helo=cy3pr05cu001.outbound.protection.outlook.com;
 envelope-from=petrm@nvidia.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=HUoHEc4v
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013036.outbound.protection.outlook.com
 [40.93.201.36])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ABA04605F5
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 18:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zx6yEgwy8nze2Tq2bWtkVXJMQWmaTvH/rbYpXA9I2lQ=;
 b=HUoHEc4v1b20bkiDbdZ42NRWqGM7XDSUvPZaQy64bFfkxhWNRz7xfjGt7Y8kOQNSdd7i04LWqoybOg3GMzkSyHmKqYzFITWR1PJaktbjuxYoH+cU50XSMwdwaioPf6Qtly2EdW4Fvv8A4TilWd4UZ9NnT4XSKBBAp3zmQ5L6nxTK3HUBdhcw4YxYLO5aQIABA/Pce5DIPZL0l8S7OVzP1RtqsDP/KF3SltKZCNAJ56QXXMyGu0R+LHCEGJUDdZ4ouOV21UkZg7eoso3CqLqJYgXkvi2Stra0i0+LXbIrb7HcXyRAyODaVeqqFbchplMC+ZqSuXeQV16CY+Tt/+FC8w==
Received: from SJ0PR13CA0187.namprd13.prod.outlook.com (2603:10b6:a03:2c3::12)
 by SA1PR12MB6848.namprd12.prod.outlook.com (2603:10b6:806:25f::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 18:00:48 +0000
Received: from MW2PEPF00014675.namprd04.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::24) by SJ0PR13CA0187.outlook.office365.com
 (2603:10b6:a03:2c3::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.5 via Frontend Transport; Mon, 23
 Nov 2026 18:00:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MW2PEPF00014675.mail.protection.outlook.com (10.167.249.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Mon, 23 Nov 2026 18:00:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 23 Nov
 2026 10:00:13 -0800
Received: from tuxedo.docsis.vodafone.cz (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 10:00:06 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 <netdev@vger.kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, Nikolay Aleksandrov
 <razor@blackwall.org>, <bridge@lists.linux.dev>, Ido Schimmel
 <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, Andy Roulin
 <aroulin@nvidia.com>, <mlxsw@nvidia.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 <intel-wired-lan@lists.osuosl.org>, Shahed Shaikh <shshaikh@marvell.com>,
 Manish Chopra <manishc@marvell.com>, <GR-Linux-NIC-Dev@marvell.com>
Subject: [PATCH net-next 02/13] net: Pass struct ndo_fdb_parms to
 ndo_dflt_fdb_{add, del}()
Date: Mon, 23 Nov 2026 18:59:17 +0100
Message-ID: <dfb728bec60618c6f1bebea429cabba25c5be36f.1795447450.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <cover.1795447450.git.petrm@nvidia.com>
References: <cover.1795447450.git.petrm@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PEPF00014675:EE_|SA1PR12MB6848:EE_
X-MS-Office365-Filtering-Correlation-Id: d927ac3a-da8a-428f-2b57-08df498bb36b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|7416014|261026140227099003|261026121527099003|261028144727099003|261021123027099003|261021121427099003|261022075727099003|261022105027099003|261021135927099003|261102123227099003|11063799006|56012099006|10067099003|22082099003|18002099003|261009223027099003|6133799003;
X-Microsoft-Antispam-Message-Info: kvcJlbWfrrOThYNnLRKTvCyrINCjQjl/gbQNB1iBFGySULZiVSg69t9hWp6ElMFxJSWG/y86qPGqafinpXOT1Nge9pfW/FYVkPzf6cIk/L+1G17A4qwmaAbEIikntMXUeo2HxpNUq/3BcBatAgwbXxUBdO8V/aQs3/qVZF7tawIEq6PcXlcEJBctc+VZRELSbNKeNPOOQsamxKR0hkD41pajBa5jb4qYBvfQQsI42OkmRY16GEKopMDHJTKhEuKORCLU0ULn/fezA0s8cEwRYC1titqJAFzSM7En5vk+e+mGtxmssU36f0yxdw8EmYX74qGqTcw2LWBqpQi/Dh3ATmM2ZjHOBXCsZm29ayv1PZzUjB0gEyxT/uHn5BKu2kBrszjCqjbpSqLjgmR6+rkVRfztyAD/KiQavWsN1DQiuANveXY5kK3wejSYhN1GnkqYuwKHcZP1t9HIhfS0XQS47yiNTmJ302gUUSa3PVdKzI8Ug++g6/gBoXZH3kfOQnbd+WcUA2i1KYxY/iHF4OtqrRnGg6RB6OilfQXWJ8oT3CQcaPBy28n8r8vMY+Ba9LQre9V4ScOL2hLnJkbU4xc8hagPOnzT0J+4zYTXEOmn7JkjGhJueIdV/qrwV+5bpIQ+eVum3/3adT5pvxKF27Bi1DUt0Ho21GfCGMPUNgUyk95Cu6IoNu8IXiHtUDqiptgsTSikAgBciFZ38iNrSYo1nw==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(7416014)(261026140227099003)(261026121527099003)(261028144727099003)(261021123027099003)(261021121427099003)(261022075727099003)(261022105027099003)(261021135927099003)(261102123227099003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(261009223027099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1nsEXsHnpvDh0eTMlqNY3SOskbUn9RbXLYU1bp9PvmL+ngRTdRH0YJYykNDqCzQlBHhvY3z6a13h41dxDQcgzMfVvjU7H5F+jqZiNf0TELG3bu/KWHst9cy8XyGTR9mC9nGhQ1iejJNfpaRB/A+7cbJ6m0C8WvL+xoDOoLj9InC5+c68hrAXsDrnrDuyMFNsJ/d5hkDuhatClxce8JiHUP3yO4kRggmOgLN25AHGQiROjHcxwTIgpqzZXjbv/y3Hh+9xNLpzJsAGyyZ/l3QCWay7G9ISvfxXmApwriujJtgL8d6Yp9EQhOLdyhRHMNqOy48SRihff78EfxxhZp5/g6mjmfH4iRqMk6nUvIdTEyLOVbAtS/5X9WZUf7AsZFIbV5w9DVqCkjSczvvL6aqbS9gfUZpNu9dPLTsx0kUtY6e1xg9dwVT5fzgbomKBiS1P
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 18:00:46.8367 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d927ac3a-da8a-428f-2b57-08df498bb36b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2PEPF00014675.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6848
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The previous patch converted the ndo_fdb_add, ndo_fdb_del and ndo_fdb_get
callbacks to take their common arguments through struct ndo_fdb_parms. The
default implementations, ndo_dflt_fdb_add() and ndo_dflt_fdb_del(), are
called from those callbacks in several drivers (igb, ixgbe, qlcnic) and
from rtnl_fdb_add() and rtnl_fdb_del() as a fallback. These default
implementations have not been converted, and callers must unpack individual
arguments.

Convert the fallback functions to take the structure as well.

No functional change intended.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
CC: Tony Nguyen <anthony.l.nguyen@intel.com>
CC: Przemek Kitszel <przemyslaw.kitszel@intel.com>
CC: intel-wired-lan@lists.osuosl.org
CC: Shahed Shaikh <shshaikh@marvell.com>
CC: Manish Chopra <manishc@marvell.com>
CC: GR-Linux-NIC-Dev@marvell.com
---
 drivers/net/ethernet/intel/igb/igb_main.c     |  3 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  3 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_main.c  |  6 +--
 include/linux/rtnetlink.h                     |  9 +---
 net/core/rtnetlink.c                          | 42 +++++++++----------
 5 files changed, 26 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 42b2fd3ed95c..b2efa0a1fa07 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -2531,8 +2531,7 @@ static int igb_ndo_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 			return -ENOMEM;
 	}
 
-	return ndo_dflt_fdb_add(ndm, tb, parms->dev, parms->addr,
-				parms->vid, parms->flags);
+	return ndo_dflt_fdb_add(ndm, tb, parms);
 }
 
 #define IGB_MAX_MAC_HDR_LEN	127
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 26d1a7253cf3..e444ebfe77fa 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -10617,8 +10617,7 @@ static int ixgbe_ndo_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 			return -ENOMEM;
 	}
 
-	return ndo_dflt_fdb_add(ndm, tb, parms->dev, parms->addr,
-				parms->vid, parms->flags);
+	return ndo_dflt_fdb_add(ndm, tb, parms);
 }
 
 /**
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
index 85017de2161b..6c48cdaf25c0 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
@@ -373,8 +373,7 @@ static int qlcnic_fdb_del(struct ndmsg *ndm, struct nlattr *tb[],
 	int err = -EOPNOTSUPP;
 
 	if (!adapter->fdb_mac_learn)
-		return ndo_dflt_fdb_del(ndm, tb, parms->dev, parms->addr,
-					parms->vid);
+		return ndo_dflt_fdb_del(ndm, tb, parms);
 
 	if ((adapter->flags & QLCNIC_ESWITCH_ENABLED) ||
 	    qlcnic_sriov_check(adapter)) {
@@ -399,8 +398,7 @@ static int qlcnic_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 	int err = 0;
 
 	if (!adapter->fdb_mac_learn)
-		return ndo_dflt_fdb_add(ndm, tb, parms->dev, parms->addr,
-					parms->vid, parms->flags);
+		return ndo_dflt_fdb_add(ndm, tb, parms);
 
 	if (!(adapter->flags & QLCNIC_ESWITCH_ENABLED) &&
 	    !qlcnic_sriov_check(adapter)) {
diff --git a/include/linux/rtnetlink.h b/include/linux/rtnetlink.h
index a54ec40d095c..e963b43bce76 100644
--- a/include/linux/rtnetlink.h
+++ b/include/linux/rtnetlink.h
@@ -211,15 +211,10 @@ extern int ndo_dflt_fdb_dump(struct sk_buff *skb,
 			     int *idx);
 extern int ndo_dflt_fdb_add(struct ndmsg *ndm,
 			    struct nlattr *tb[],
-			    struct net_device *dev,
-			    const unsigned char *addr,
-			    u16 vid,
-			    u16 flags);
+			    const struct ndo_fdb_parms *parms);
 extern int ndo_dflt_fdb_del(struct ndmsg *ndm,
 			    struct nlattr *tb[],
-			    struct net_device *dev,
-			    const unsigned char *addr,
-			    u16 vid);
+			    const struct ndo_fdb_parms *parms);
 
 extern int ndo_dflt_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 				   struct net_device *dev, u16 mode,
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index b1649f1cb33a..e7d683952838 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -4749,9 +4749,7 @@ static void rtnl_fdb_notify(struct net_device *dev, u8 *addr, u16 vid, int type,
  */
 int ndo_dflt_fdb_add(struct ndmsg *ndm,
 		     struct nlattr *tb[],
-		     struct net_device *dev,
-		     const unsigned char *addr, u16 vid,
-		     u16 flags)
+		     const struct ndo_fdb_parms *parms)
 {
 	int err = -EINVAL;
 
@@ -4759,27 +4757,28 @@ int ndo_dflt_fdb_add(struct ndmsg *ndm,
 	 * implement its own handler for this.
 	 */
 	if (ndm->ndm_state && !(ndm->ndm_state & NUD_PERMANENT)) {
-		netdev_info(dev, "default FDB implementation only supports local addresses\n");
+		netdev_info(parms->dev, "default FDB implementation only supports local addresses\n");
 		return err;
 	}
 
 	if (tb[NDA_FLAGS_EXT]) {
-		netdev_info(dev, "invalid flags given to default FDB implementation\n");
+		netdev_info(parms->dev, "invalid flags given to default FDB implementation\n");
 		return err;
 	}
 
-	if (vid) {
-		netdev_info(dev, "vlans aren't supported yet for dev_uc|mc_add()\n");
+	if (parms->vid) {
+		netdev_info(parms->dev, "vlans aren't supported yet for dev_uc|mc_add()\n");
 		return err;
 	}
 
-	if (is_unicast_ether_addr(addr) || is_link_local_ether_addr(addr))
-		err = dev_uc_add_excl(dev, addr);
-	else if (is_multicast_ether_addr(addr))
-		err = dev_mc_add_excl(dev, addr);
+	if (is_unicast_ether_addr(parms->addr) ||
+	    is_link_local_ether_addr(parms->addr))
+		err = dev_uc_add_excl(parms->dev, parms->addr);
+	else if (is_multicast_ether_addr(parms->addr))
+		err = dev_mc_add_excl(parms->dev, parms->addr);
 
 	/* Only return duplicate errors if NLM_F_EXCL is set */
-	if (err == -EEXIST && !(flags & NLM_F_EXCL))
+	if (err == -EEXIST && !(parms->flags & NLM_F_EXCL))
 		err = 0;
 
 	return err;
@@ -4884,8 +4883,7 @@ static int rtnl_fdb_add(struct sk_buff *skb, struct nlmsghdr *nlh,
 			err = dev->netdev_ops->ndo_fdb_add(ndm, tb, &parms,
 							   &notified, extack);
 		else
-			err = ndo_dflt_fdb_add(ndm, tb, dev, addr, vid,
-					       nlh->nlmsg_flags);
+			err = ndo_dflt_fdb_add(ndm, tb, &parms);
 
 		if (!err && !notified) {
 			rtnl_fdb_notify(dev, addr, vid, RTM_NEWNEIGH,
@@ -4902,8 +4900,7 @@ static int rtnl_fdb_add(struct sk_buff *skb, struct nlmsghdr *nlh,
  */
 int ndo_dflt_fdb_del(struct ndmsg *ndm,
 		     struct nlattr *tb[],
-		     struct net_device *dev,
-		     const unsigned char *addr, u16 vid)
+		     const struct ndo_fdb_parms *parms)
 {
 	int err = -EINVAL;
 
@@ -4911,14 +4908,15 @@ int ndo_dflt_fdb_del(struct ndmsg *ndm,
 	 * implement its own handler for this.
 	 */
 	if (!(ndm->ndm_state & NUD_PERMANENT)) {
-		netdev_info(dev, "default FDB implementation only supports local addresses\n");
+		netdev_info(parms->dev, "default FDB implementation only supports local addresses\n");
 		return err;
 	}
 
-	if (is_unicast_ether_addr(addr) || is_link_local_ether_addr(addr))
-		err = dev_uc_del(dev, addr);
-	else if (is_multicast_ether_addr(addr))
-		err = dev_mc_del(dev, addr);
+	if (is_unicast_ether_addr(parms->addr) ||
+	    is_link_local_ether_addr(parms->addr))
+		err = dev_uc_del(parms->dev, parms->addr);
+	else if (is_multicast_ether_addr(parms->addr))
+		err = dev_mc_del(parms->dev, parms->addr);
 
 	return err;
 }
@@ -5019,7 +5017,7 @@ static int rtnl_fdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
 				err = ops->ndo_fdb_del(ndm, tb, &parms,
 						       &notified, extack);
 			else
-				err = ndo_dflt_fdb_del(ndm, tb, dev, addr, vid);
+				err = ndo_dflt_fdb_del(ndm, tb, &parms);
 		} else {
 			/* in case err was cleared by NTF_MASTER call */
 			err = -EOPNOTSUPP;
-- 
2.56.1

