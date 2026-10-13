Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE5D9CC6B0F
	for <intel-wired-lan@archiver.kernel.org>; Tue, 13 Oct 2026 13:43:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 63D926070C;
	Tue, 13 Oct 2026 13:43:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jDZxZdjfffUl; Tue, 13 Oct 2026 13:43:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 221C06060C
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791899038;
	b=hteqs3c7Dk1a9P3pUby0WS1KExfIjnj15lqtvkidKzlY7GWuHmlIBAMdkdHpoEz/NlMp
	 ZhsxpNbdTnF1024Cn+1/W0rETvN66ty10txsdizM0g/GCQ6S0QOsWgrgYmFthPBP4eCFN
	 3Au6vfGpuilsoQkpoWuvjn0Du32AerfytK6IWdQR1nZ6u5hjX17pltWJOho9mZTe427rL
	 GKMzQNx4WnD1algO/iDpZHWSRHP0j5UhZgGSEQL7TQhJBiedlC0bi31CfQxLgK7RKBMR0
	 EUzR9DqbGqjKnYsinJ6agCvVMlAMQu77ZtwN7Qos0SQeO8j2R0TCg5Y4DMWwjGRst6g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791899038;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:Received:Received:
	 Message-ID:Date:User-Agent:Subject:To:CC:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2J93eVM3Hn8/DOQrDK8tVjQHShlwMGATjVi3WoqciRg=;
	b=Tq1OX/vi9SJa5q1FedmTx34bsevHic3BFupybNqvif8nujmovEYQV7xSHBTpYwwmcXy6
	 Mo+S4+kaaHxbrbxH3nyidI0QOzvmhtj8thevlqh1slntcACYbnF9tENqNv7K9vyaQWk+n
	 KtTkHf564+sOnGL1vDtRpKDRc5LyIQQ1TvfC0avqIxiLx4pK+bSf8U7JY6AqJkO625/cy
	 CR/JOpRvfr0Q6or32SZR1OLjkET6y+ZmTxScTy3Gbs6wPZ3sl8dBkgshRcooW3JKsaQsI
	 lba5axeTBeAWo5poKiuGmvUeaAi5nj9vBu1FvQ/rcvbkkKxBuBRrutIkUe2VwFkVA6w==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791899038;
	bh=2J93eVM3Hn8/DOQrDK8tVjQHShlwMGATjVi3WoqciRg=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=3TItGuR87f7cq5FDC+PxZ1CvURPpcd1KBFcnRYgj+WWckKZUxQjI6T2Q4TqGkCDMP
	 LGGGp+H8FJkyPrTL04dZoEesqWseyFcQ+GSUgJZ5CRgt8txpfzbN5Y+eAwGcTVmSDD
	 pBAGztD3/mPrr28OhRG1hm/jGknxcpM3lHx/JteVvqFOpsQlN0BuByMdQhdcLKdhEQ
	 Wj/cADpYiH+XoCjVTU70R82XNwALx4O3KiYbhWAGUE88T0z7cfWJB8/7HYxqvM9mpe
	 /jLs/MEDQeLU/eetCDQTOMevdyqVXCW3oKBpzdOKnBwB+Z8FGodcz2hj8mEArjS2F9
	 QeXrFnOcw4hlQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 221C06060C;
	Tue, 13 Oct 2026 13:43:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C33AA1399
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 13:43:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B36EA400E0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 13:43:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yU1B07pYW7w5 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 13 Oct 2026 13:43:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 914FB4007C
Authentication-Results: smtp2.osuosl.org; arc=fail smtp.remote-ip=198.175.65.20
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791899035;
 b=qYPmqrnnjljAt0kOKFGU/TSiWaSEu3OGbeFieRJbMX9ucPI/1yh3rNeSjpkZEnmtMMKY
 UwtdQ789VE7qVN98mkpaS6nY+Rcq2yVs4itn4fpT6T+clTfvmLwxvFA3gjVSYqsWODiLM
 rdSfYOigMQzf4YpcjV3Jl8WLZGMEnaZ4OdjpP9N7QhGvt6Q8PDf/S5njvJkOxaVDev9W0
 UbhYMqQrY9tU3Cl5qy1YKIsNJvwHChW3t5LtcvRevwbtIxETf+nwooIy1eDS6JNpPv9yi
 KlMR30pi1x3uPSreZIoSvsDOffDul0rXdL/iJ1vgT8Sr0YMTIbneZwr4TPXWz8aVjZw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791899035;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
 References:From:Content-Language:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 bh=2J93eVM3Hn8/DOQrDK8tVjQHShlwMGATjVi3WoqciRg=;
 b=cbiossRqOXakM0IN8VUxUyWDWEe3rCc3xgTH+NIdkG57VrIpTVcWCwVqsJB8besQ2YKF
 i1mW2BebCIu3+bJxU/zazm5xODr9TWT39o+8yRPIso3/WMUQPTROrOexFs/rIngkK0/Pz
 bMVOG7U8A9CnohFCpDd3Xi376ucd6PM4AT/IFdJcK13NjVOCcyQo5awpvqu/3O7CcAOUY
 NSvFWQRkS6bE50EghpVAMeg3iK7RsQy8cys0ukYwynb/Q36oxDPoQSSdriyePwBysUBtD
 bQkuM3nREkl7rEOKmCP5ioaqXOYPfV/zfW/LT94OgJwByBjvDukbRFdaQrnIJjz0bkw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b="aLXJc+/B"; 
 arc=fail smtp.remote-ip=198.175.65.20
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.20;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=aLXJc+/B
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 914FB4007C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 13:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791899036; x=1823435036;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=2J93eVM3Hn8/DOQrDK8tVjQHShlwMGATjVi3WoqciRg=;
 b=aLXJc+/BUek5bsOkAVLcOBCJVOK8qZGUufTg3Jff4XAfR36RSJ8vvS5t
 MCS1M881UYMnAu8AUe+z+aSk8cBCqmd1yAYqlXH2hBrPkzLaJVlUo3pEc
 TYhVv7IRldNsL0pG+0RZacwA6AFtV6eNTLHQRJNP4axaReuDh9zAT2gkd
 PhUUxAH1y7pYCAlS8J2IBE7hIFmyXOXHpAd2u5WY66btC+bq6qLF7NoUb
 sgDbDA+KL1tAvUFLp6gVGbBYfLxIvT7lFf7iH8annYGFlmlvwoj+RuO6u
 3wl1rCvD40TT5+GBbgLwPAGnXzwYbUPrPK2GBw3DkqA/Y7L6XlJaRDUf/ g==;
X-CSE-ConnectionGUID: NACSLefDTgKRwn256UuiDg==
X-CSE-MsgGUID: nv0nnEbFSz+qiTbUV7bkUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="628419"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="628419"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 06:43:55 -0700
X-CSE-ConnectionGUID: f1d2wo6fSFOCz94vW/wSeQ==
X-CSE-MsgGUID: blQ2kU6lRECP3hbV5ApEfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="2928405"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 06:43:55 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 06:43:53 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 13 Oct 2026 06:43:53 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.29) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 06:43:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uYjH+4OrsYwO6XLYxUNsD3o3Enf9OxPvkeQOwFukLJz4r25eQOcNhsjGKkTsRJxca/YQRJKoCxhGo4wnP8wD32J6xGAomZQp9uGGxa2OWEY+uy7a/fjBuZj7DX7rDQ+vl/TirozSpOYyiq/O/tt2VbQBcIx64VwmyDo4vA6fjYhc3RPfWmuVO9GeizYA36zH5YAaVMf/XLproUeDbQ5xZQByTw6TYL5jPcgtTIvqbSoSOeRFzaFtE0ubzo95WVjGjylsQm1ekAxNkm8iTDX79O2NVc/C/ncWlkVCMZSzwCehrSpZsu0ZgISFtX3/qlb98jqstxCZDJTbBC5fQxQZNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2J93eVM3Hn8/DOQrDK8tVjQHShlwMGATjVi3WoqciRg=;
 b=pBWNxH9NE1nBHJa3tqyjMgFJxnkg9sTE/2lZnVwdDbxC9QOn2V9HNYRQZlASX73RM0A2H+hBOPCo5a1QR02tPDWMuD+60+n5dBpzDfC2cNV+euvYFI2d2XTw4OTIE8cuM9LoCYx13uh8/tuQrIVP8jpdLnC4v5so6nPpags7HGLoxTxjh+LzfXM9MUQjGLIMJbkUFeLR9+TtitWP0O2OLdsSESUFHa5ZKZoSYFCmC1aNO71E/L+nNO3NIlIcbP7SKyAe4sen2QPhlExMv/gsAu7Jx0Sd/+3DZjPsyJ0s9WFaGWT9md9j/oJ7oWH5oDdmTTqxWnN4yfOey3D7Y/OHrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by PH7PR11MB6650.namprd11.prod.outlook.com (2603:10b6:510:1a8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 13:43:50 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0522.011; Tue, 13 Oct 2026
 13:43:50 +0000
Message-ID: <9bab48c1-6c1f-49b4-ada0-c340a51d3692@intel.com>
Date: Tue, 13 Oct 2026 15:49:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 13/14] ice: represent RSS LUTs as devlink
 resources
To: <sashiko-reviews@lists.linux.dev>
CC: <intel-wired-lan@lists.osuosl.org>, Tony Nguyen
 <anthony.l.nguyen@intel.com>
References: <20261009121433.30347-1-przemyslaw.kitszel@intel.com>
 <20261009121433.30347-14-przemyslaw.kitszel@intel.com>
 <sashiko-outbox-166508@kernel.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-166508@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0032.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::21) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|PH7PR11MB6650:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e02429a-0736-4326-7a25-08df2930034b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: oKsNZUhdM8zZWrGpOAppR7mjiY94P+dsH3IEh7RasLeRw7Hb2cABxvq1tO+W4bMHpMMuSLYrYB22NTs8wKSmb0yacz4YEy2kTYD/ZoZBAYOxLzoXNFWqrmN4wF5PaNB39/oOu3dP88j8tqd8PBhii6NC+KMVrqFE6SkOr5B/UbVKCBB0/l78Vlo3uUu+Zu5SCc1EfFtHXP22VHHvfOre7cL5xfiVC9OdOqF7Jw7hOLXA16TMJE3nXbvb0lqkB+h1ZWVBsJ1vM6yKAGy0lfeklZYfj3cwAXt4Ollgef71ofJOj1d5kVYPTbuclcrFvcjCD483iijNtPh7mnCQ3NGuLuiP4rVZMgf5mVskASCVn+BQa3RYqsfjfzdb/sp/597OVz9VLfW1wYhBT6XKPQMb9kO74w7O/XiD2wkbPmALeJrNdbcwjDIi8miqze0tkT0Le4hx0C2y1HVPPxYnRjApJpUQ0AhuwB4C6Q9Hoz3gMbNuqMcPtMd0Q8manC3PJuInn14/tHLNDt0CBCWXiwxBrSnB+WRsRusZxfc+NmY3oRtIznzD6TuLCGg7u8WjAeonTY1Wae8PeMG+eXzHzvLPvZEIwaU5zXL8sQGXCaQvnTY4+uAcODjeuxzi4nFgmrPVWBrLZq7q2dP+eVLojZ4lIdJzDV2xuuIaTtZgAOsZMg4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR11MB8508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1VteWxUSE4yZUJ3TGQ1bmdRQlBvTU1KK1dUT21la0puQmVSY2wzZmI2WEth?=
 =?utf-8?B?THpMemZlUnhnRk8xVkRkUCtPK0U1QU9raEFnbERYQUZzZ3BMNERnSWtEczdq?=
 =?utf-8?B?OUlIZHpJM1pacytVdWoyV0FWTE1scXg2WmhTSStxL1pVNDd6TjFEN3hqa24v?=
 =?utf-8?B?aWJMdjk0NE1RV05XQ2ZkdkVPR3UvL2JhVEtCb3VpWi9MMDNlSzhCM0I1VXpK?=
 =?utf-8?B?WXE2dENTMDRXamJhZWpYYnpkeXAzd2s3N1JidTJrdnF1d3ArN1V4VjNhWG1N?=
 =?utf-8?B?MENWbktyZUdnUjlYR1F0UjNmQUpnMXZWUkFRL0IzZGV6bm4wWkI0NGRyTU1i?=
 =?utf-8?B?dTV3MEw5N3Jja0hHVEhzMW9PUHRWRFZCN3oydkk3dHdoVHNnUTV5QUJpdmpq?=
 =?utf-8?B?RXF0R3pWK1A4OXl0eURaWWxiZHpBY1ZnKyt3eUpXYUdMZFh3RnhUVnJJbk43?=
 =?utf-8?B?UHZVNkQxN1JRTnlhMnZXazBYb3RiQjNpRXFlaWZaMWFUWnRZazJ3cXJodzVO?=
 =?utf-8?B?QWxqdTFSWnhiNkdiOUE2UDd3bnV6MS9oVFpjeGcydE51TXZqOWJhZHRVSlpk?=
 =?utf-8?B?aENucWwzL0QyYkxpR3hXdjJWODJ2cGpuYWdQZmw0eU4wc20rVS9NV1dncXJ6?=
 =?utf-8?B?K21qV3F5MGE4dFVvUkFkU2YxWkVIbHVXWlpaZlN5Vk0yNjJDQ2JJM2FETU5u?=
 =?utf-8?B?U3c1ZHFwdExLWERmQXZLZE11M0lEbEViYmNsVUQwWHBFL1pzVzJqbXUzRHFX?=
 =?utf-8?B?UEZSekp4Mkg3cTBubTJuK1FnSHJodkI1d292dXIvdm8yajhpTWkzM0FVd2NL?=
 =?utf-8?B?aXYrS0VUVUJsdmxNa1FpMkJyL0xJaWZkVGRtdUpHS2dodHoxL1pob2IzSDVF?=
 =?utf-8?B?VFNqTGovVlY3WGkrSnk2RzJWN1BYamdwWnJ6c2p3Rm5TZUh6T3B0bFJVVlp2?=
 =?utf-8?B?dTRHdEdJb3UyUmMwWTJYSFhiUkFxUFFsUFNYSnI3cm1XTU5BZFEwU0JQMFRp?=
 =?utf-8?B?NzdNSVVIcHVZQXRqWGxXUGFVTUxlemhuS0hzQ3NISDg4bUh2dU9Hb015K29M?=
 =?utf-8?B?M21iWnNNZy9DY0JOZVJvVjBrUXd5bkNuUnJib2FFclZKck52cUMrdTNsSEht?=
 =?utf-8?B?WXNqWHlSaENpaHR4YjZuamVIQ1ZaSWxKVTJwMnhzUVRrbmVxSUhGNy9Za2pt?=
 =?utf-8?B?UU05dVNNbmkvcHJ4dmE0dStxd2lKdFhzNFVGYkxnNEY1RlZJOE1KL0xWdld2?=
 =?utf-8?B?NlBCQ0ZxNWw2TDg4MmZCaUpQWU5BT0E2NWdYcG51TzkreXZQYWN3Z0Z1WHNW?=
 =?utf-8?B?d2pIR09vNlFmU2d4S05tTUtDdXBpREg4cSsxbFdYRVVUYWJIOEpESmx5U2Qz?=
 =?utf-8?B?ZHltV0NZcW1LQ2REeVM5Z0VXTHI2TUJ5eGZjRGxtdUEreE5Rei9IWisyUGV5?=
 =?utf-8?B?cU5EM1RJemZRb1dJNzgzL3Iwd2pLRzQvcWNkU1FVV3ZjK1BTTTk5SldnTTdl?=
 =?utf-8?B?aXpwbDJOUnY3UzhRZ3ZPeHRIUG90L2NnODlhM25yaEwwVmtYeXZTbjdNR1Za?=
 =?utf-8?B?ZG1NZmtGejJGOUZ5Z0F3VWZSaDY1dmRHeHEzNENTWVRBMXRJZVl0WUpGNUtt?=
 =?utf-8?B?aEw0cm9qZlRvbzVXcDlZS0R6eEEvYjhYOEIxTUtCS1JCOEFzOXd6U0NHdmtR?=
 =?utf-8?B?UFIvSDdQQ0cvT2ZjWU5WMFFOTUt6bHBldjRqc0VKVFkrbzhPYUJVN2o5TmZx?=
 =?utf-8?B?RGZuTC9VRFRGSXFjbEhsTmJFdFU3UFMvUnV3VU1ndm5nT2VCQ1BoVjJBQld4?=
 =?utf-8?B?MW9jbXpEU3ByZDlSK04rYkw5SUREWEJtd1dMT2xTTk5QRDc5NDh5cWxYLzg0?=
 =?utf-8?B?by9PbGZ2dlZwbEt1cU8zeGVaVzlnQUNNbjNPZ1lySjlKS1JUNWFEMEZYbEI1?=
 =?utf-8?B?VWdUcmd0WU5JeCt4cFhsbFRad25VYUlHTGhZdncrWTNxWEJOd1NWd2V1UWNu?=
 =?utf-8?B?SEZwKy94dFUyeHREZE9oQjdBd3Q2Z3IyRHF0V0xUOHEvMndQWVlFd2R6SXZu?=
 =?utf-8?B?cG11Mk51V2kvODNoa2ZvUzBkMTNkVHA4STNvY1N4Qy9RT1Bla1FrWUo5UGhp?=
 =?utf-8?B?YnB1VVBoRjlTenBHRC9VMFBYNFBubzB6SVNaZ05vcnA2NktQS2h1UzRUaVVq?=
 =?utf-8?B?c0NDSkJsZDVLdkhVdCtBSzYyNGw0VWdNMDkyVmNkc2tMUzRQelZuWUxGaE8z?=
 =?utf-8?B?aGdDclZHelpWS1F3T0NFR056RzJkakJRQ0MvVUlNOUZ6R3NDZXlqNjNCaVVH?=
 =?utf-8?B?OHhnOTk2ajNPdHBHcmRmMnNoMng3YVlwaDE3MnRrbEE2UjNOamhGSnBvVndD?=
 =?utf-8?Q?nkxjGf3XWIxyUrLw=3D?=
X-Exchange-RoutingPolicyChecked: gQMFKRv7YJgv1I35MNohDR2ok2E1sB5NW8coeO0r21xhaMnnvE18ghCIkNOX5ms5w1InxkbA5g147L4Ey7BMmNCgGyZy+EwQsd44SG70OtJkBDtNfFxUxgqCuRNlPISnu8PaZERQbDs1e9klPz5VO6EGMNPi1UpQCcEzoOUT5aJO7sUS4Dlo8/Z5/roW2S4Pd6JMaon+C9dvjC9sBL1uGAvZ+IoOgnYE7Jz1LAnKH7ieEDEv2LJR5q8mno20tH5FSWB1bPDWT+bCyzGY8Ogd7klIK8lUz778SDvaYKH07ZGoVBZLi2rlCrf4CdJ9EZvGex8gWZIZ7tPdCIxo9j1BaQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e02429a-0736-4326-7a25-08df2930034b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 13:43:50.2971 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pmDwxZODMxY2R+1v/Vqxjq/PUUl2uKfJNUCSp1VUoomCwenWd4jlUIetgUXxb467n5NqK4wZ6YCPVHIT0hz2m71UPwXXMqRXQmT0Pfi1KkA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6650
X-OriginatorOrg: intel.com
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

On 10/10/26 2:16 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 6 potential issue(s) to consider:
> - [Critical] ice: Out-of-bounds array access on fixed-size devlink resource tracking arrays
> - [High] ice: Multi-NAC E825C device probe failure due to shared devlink resource collision

I will adjust against 2xNAC / E825C devices.
pw-bot: cr
