Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A56B606A31A
	for <intel-wired-lan@archiver.kernel.org>; Wed, 28 Oct 2026 12:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=Rh89Brqh;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XHjSd1FG
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 23BAD605DF;
	Wed, 28 Oct 2026 12:11:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dzhvnghjAaKj; Wed, 28 Oct 2026 12:11:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 617F6605F1
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793189486;
	b=J6k3OsIOuAGASRMi4aNnSYVYxtrmUE7XJpgbEcmiB4Zh7iyqGD82EM8OUWXeEJSpwqnk
	 vFez1X7aIf3Ms0aSb4Mx+YHUHEhhqeweJF2fQCIzOjEouROE446y1G/i8X2s5HNd2vNUK
	 o3pwUEcXp6dEoNOhLrTzsqe0+0wYmEH9JuQuJIy35IhsNZFb0R269+/CfzHSfF4Flecet
	 dUj2I7wyy05j381DvFovPnSIK1LGBIyhSxIHniDU38lPoWanLLkzxd6My+eNVZIcvbuCy
	 88PjqTqpnEBRoUnpKe3V3P0TP1bM/cCDaLGZ/LuTrEtRRu4JriR9K/2FDiUCjUvWbNQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793189486;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:Received:Received:
	 Message-ID:Date:User-Agent:Subject:To:References:From:
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
	bh=GH/NZqeIe/lPBHHICctDYjW3M/zmkW+dc6kf/rM2HLg=;
	b=lqo2ZMY+nAyWmRS6SkLQgYYfnMtn6k4uDw+YHzaSkaLBY3MofzAR74rB7mZ5TFtInHgN
	 flpmFd5bo3lAcZJkFtMcv/VIYpT3s5mgE0cbh5R4jfXZU0moVisGOXdO1sV1nlSx6Ly+p
	 Imbz4GclYi4M0EBn13GuHMhb2sMUlk5047I9CPKE/Rvm7DlvhvsEsX3XMb2AAqK4+FVPn
	 3Oa9e7ZycSTHH70uNyMn1XY5FowHXR7uK7ptzz1eoTlOGjtYyfq2UdvpTk8yOFUFWXEuf
	 WLmKqdhtgVooLSWJIcUNQ43Ev00eZfM920aBkO02A/v5sVmIiH9fk0CIXnwPEfcqjSA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XHjSd1FG;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793189486;
	bh=GH/NZqeIe/lPBHHICctDYjW3M/zmkW+dc6kf/rM2HLg=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Rh89BrqhWqhpW+SoT+mCPLmY090uRLWQAfjaP6P+z/e9FbXxaLK3O4wnF5m1DdSdn
	 c7TbmcDQJvzAffFSYxnjt6Fr5tzJ3oLuOm9XK9BwwqG3mwR1KNRsOJu8Oi2w98oxwC
	 h4s5/h0ffckvCpTYf+YmBTpZaRJl0zxTHPAJdFnzeAq5WVYW/prfd05fDQiZfTpHzm
	 ekfHWnho9bK/1UxTTHynClrmhQO4zZJO5ldqGede7QYs68y76zBtommE6DUQZS+FiT
	 CCkD1L0W06mIB+ABYdqas8OpZ5zhn/UoWSbQL9zkRaUcDDIuzL/LYeAbA+86XLmbnf
	 PUYiR90DbS/sg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 617F6605F1;
	Wed, 28 Oct 2026 12:11:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 49744972
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Oct 2026 12:11:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3AE7F605DF
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Oct 2026 12:11:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XNh1iepYKRgY for <intel-wired-lan@lists.osuosl.org>;
 Wed, 28 Oct 2026 12:11:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4D501605D4
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=198.175.65.19
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793189483;
 b=N/HzO08xDPNM/OiCnjUtDPbhI5tkvALNYXh/6fjq0Xt7OYik3B+xcaA/xZRRpic9yFxZ
 EqLt7v9P06Vt9cfzGpIJmBWFpIIKWpSjpYBrXGYYRQigIOr707N84LUZpWszI/lxfLa1/
 DkIvRdxYgFaX8bJHHQjGcjb+bhP6zAfAwOKG1ufFjfUdBCbCH7HQuQj5WLD0FunPvWNDc
 MmdVA3ifsYk/tCYWtBrutzkX4zK6K9GL7/wVqeLj9u/ERfg4nzsFOa8z5d4deV6NXP5Tn
 fXZ03wOZ86kwukbIgkBfhKGdlxJBjXqTob8vShCpiAB9bjzOkcMeGP7d1OcaQ/z5Zqg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793189483;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:
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
 bh=GH/NZqeIe/lPBHHICctDYjW3M/zmkW+dc6kf/rM2HLg=;
 b=GTgXB+ybcb+IYdo24ZvdjucR4AzJEYXORRNxcKTGCCyWH6uSmSfiWP8YZh7Fz5q38iOF
 m8906t93sNnO5EquD2+j2KJvU0UrbY6axPhfqepUQHQH9bQNAr+VQBP8ImkDDP6McKgD7
 u/OwHulbgULlDfuOwqPeQ0Eshuw4XAbbd6gyBRoGP/8XgMzAFyV1pBaijVuTrPD3kRJ3i
 DYS+Oqfbygr/sAAGP47oOQTPyw2J4n25CKxy588Lz6HtIjYEdnKIHYhnaCHIEflN6J/tC
 xdztxNYobWlfL4OCS486oIgat0tXm9QllN+sU6g8giRFehqGtGp/MUzjCqDR2Mzmlag==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=XHjSd1FG; 
 arc=fail smtp.remote-ip=198.175.65.19
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.19;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=XHjSd1FG
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4D501605D4
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Oct 2026 12:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793189483; x=1824725483;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=2J3jJXDLB6PtfvifFJ+2sTThz22CJhQxcnaRaVLPHrA=;
 b=XHjSd1FG6y3S2Gwep7978w+siBLshSaapq+HMxBYJz9Ou8UjVodHsPah
 vFV1sssHqHxSuHOP8djggLl07snLB2tBQbQ4plhm/bbm5c75nLjna3fz8
 u9PlMyA5yf02LNKwPyY3EzafadPSKlGXDGLFWYnhtd7shZZcjSn5cwIzU
 xpXlGuiL4mQSwoeo52lGebRrGMsO6qN6ONH8HlgsvRod9X264WBzBnnZA
 LPc5OsmC76jPHD/iu82X2MWDUnE3MEEZ2Hcu8TDYFwCaCNFqyZlWbizch
 HmKO65jxjhx7eXFuPwVMBFU2RiKXqcqh6gCznUxsXi5XaFuqJLmVgQYvD w==;
X-CSE-ConnectionGUID: RMCsdJ9uQSuvCuT+y8d+ww==
X-CSE-MsgGUID: QLPAl8AOQiSlu9zhEaacpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1930921"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1930921"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2026 05:11:22 -0700
X-CSE-ConnectionGUID: rr/eYYq5Qq6cfXlF37kjSQ==
X-CSE-MsgGUID: a68/g7BwQTWiyWAmrd6vTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="4688801"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2026 05:11:22 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 28 Oct 2026 05:11:21 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 28 Oct 2026 05:11:21 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.64) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 28 Oct 2026 05:11:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UhI0zvEuRH9r4uJNGCAzVOALIrTj9xeD/rJkflRCBe6nehwyVzRYD0v+6YEtsZoz1aFDwq1C1i4iyj9Jfz54xFLeCZZwgi4FX97/V7nC7RVIL9sJ2JJ+2Ng+6hqmkRMghPlUGrZ2TQ2bIk/QUU49K89P6bU72CLpAEtUNBoFU2jnUYD39oAYE6veLpYqCmfRfvKerLdE3x8pCQ8P9kVxHXq02stVOVtwFDgsVcgnfBbAMBcLFeutfJJYYqpCuQJ/5k1vSSqYpNTG3cKbtc4MHWWJ3OsV20jZGRcA/5uIvHYfLxU5x3oLYSabeH3q8j6mMPIVlvjhD0HbO9JcH81+tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GH/NZqeIe/lPBHHICctDYjW3M/zmkW+dc6kf/rM2HLg=;
 b=c0zPM5+LCRn4bNEJgW2jAru+jat+EVFzpvHbh2FNKiVO+/UB4naVN1yS/8DDoLvBVIID+9DM2+Qzav9Qni4HxAb8/NnCE6RyYVtTzvmDrH7mPAxHOf6G8SpTboLA3Hzn3bEyhtTcm8Xez9nahp+UOiDnUDhdyfIE7pDrCe1bGF4PUNjDO91FwVjsYR7NyCYczi3ZWmMSZn0ODSJHJ+4ZQzKWFBJoArOrRZ7qTwI2my3aSvItpZh8St0LM4kDYZ3/0/IAvm7bMpQeoS1Z9owScchrVq+oqQLGdQjofk9ER7RWQ6rkid1k9jQ7bD7cn+Jt4rLkPKYXaPhhI8nXbgs5Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by IA1PR11MB6220.namprd11.prod.outlook.com (2603:10b6:208:3e8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 12:11:18 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0569.007; Wed, 28 Oct 2026
 12:11:17 +0000
Message-ID: <adb812a4-8e3d-4670-9ffb-34b118155843@intel.com>
Date: Wed, 28 Oct 2026 13:11:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v3 2/2] ice: reject partial NVM update on eRoT
 adapters
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 <intel-wired-lan@lists.osuosl.org>, <anthony.l.nguyen@intel.com>
References: <cover.1793119681.git.aleksandr.loktionov@intel.com>
 <9fe20320948a496217f4888b8196f64f1cdd3874.1793119681.git.aleksandr.loktionov@intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <9fe20320948a496217f4888b8196f64f1cdd3874.1793119681.git.aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8PR06CA0050.eurprd06.prod.outlook.com
 (2603:10a6:10:120::24) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|IA1PR11MB6220:EE_
X-MS-Office365-Filtering-Correlation-Id: 37ad52d2-1dce-49c0-1714-08df34ec91fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|6133799003|22082099003|18002099003|10067099003|261026140227099003|5023799004|56012099006|11063799006|261021123027099003|4143699003|261022075727099003|261009223027099003|261022115727099003|261022105027099003|261021121427099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: Q7gbASeTLMixajjLP1mf3VLwVc7s+ZQkJjk4oPwq9BD7DtiL0JMNwOmyUEaQ5pYtYWkjJNz7PxDv+ZmXZa/9pX5zfPhh56GpAGeXymK1d1FLCXwraymz37n5yWfurbW4olggJTOYMTHynPSUv+oDPHQtXO/dYw6hAuGel5htddwPyjVP7S+gNvFr5aEzB6JSu9u5AQ8pCQYANAJ75IrkhwYmIcCcXPoZXTONgXOUybBUoeY5uieUV4PmcoPf1SOtX57o/N3pIK2gcRw49xFixrhPcRusk2HW3CO6YpzroM54Rb9tLxplL4D39IOroc5QxwVfckZHUEgbxBC20oqKpTnn4tWTBuZ3GrHqfQIhlelNTxamH+dMI5rVzUXJAv83XoF4/m6qxdqZVaFLtqjPtpiXvjfdvu7m3HCGo/R/PcJnUClLpP3uoXbDYL659ML6/TTVeadMIsht7dwmObDQ/VoQ1e3f5Oh4dqnHmUmh5BjosPtFXL1/dZ5xM+jk6Kiwct+9V9YLyBDIFjb+yWkFas4kcCY7y7o6rWZhgIIrUAu+LqQE5MjW390SlzTUamQ+4K8de0k89jjYM/ngXKvHCww9ENHTlWNZnefdSAnsHrnIe1HZrvYCJ0vQh/XmCj5/TegvA7dKiRY9tdJWiE+1+CCg/zekPgqzthmOWF11M08=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR11MB8508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(6133799003)(22082099003)(18002099003)(10067099003)(261026140227099003)(5023799004)(56012099006)(11063799006)(261021123027099003)(4143699003)(261022075727099003)(261009223027099003)(261022115727099003)(261022105027099003)(261021121427099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2FYUFNjUG1zOHRiSWU4Q2gvUTBFcDNiU2JTZ1FzV0JRNzk4cmVpVWZLOXFJ?=
 =?utf-8?B?RDNkZndlaDVZSExOUTlEWXZiZGozWmVKOUptV2l5QVVNT3JoTDRUeVlJUUdY?=
 =?utf-8?B?T29YOGtTUlNVQU1yOGZ6WGsrak96Wll2akJ0bVl4dmdiTjM0U0EwTmF6dFpT?=
 =?utf-8?B?VjJSWWVyaVJIdGRtdGU3Ritqa2JaR2ZtVEwzTnhBWTRJR0FNQTRuSkRXaGNP?=
 =?utf-8?B?R096MFRHRkZSbThJdHFiLzFDWURaTmdNZXJ4TDhXekhlUEJFY3ZuaGV1K3dX?=
 =?utf-8?B?ZlRWUXJ2UW8vbFhHb2xCMTV1MW5zMGwyY3pSazJGQ2JHY3ovMXdFcmxKL2p5?=
 =?utf-8?B?TGk3YTBDZ3JGYzkrajBPMFZVeHdDTE84S1dyL1lxZVdQY2FSUVByb09YOW1B?=
 =?utf-8?B?Y2JlWDJ3MjlRNUVqdjJsSFY5dmF6WllJN0FlSjZQM2ZpVmlCejF6a0dxZGlH?=
 =?utf-8?B?a1JkeUxGS3dSa1B4T3VBR0FsbGMzNmZvV0RoYktzK3R0Rno2anlMTnppYjgw?=
 =?utf-8?B?WnlCMUlPNVlPSTRSRi9pVWk4ZjJFYlVkZFYyejA2WW8vSVVJSDZNOXdlZDZ6?=
 =?utf-8?B?K1pxSVM0SER4TjVJUVFOcysyenVZQnNrQVBPTXZwT3V0eHdJV0ExVmxNRVNi?=
 =?utf-8?B?SDkyalk0S1BqZVNnc3R1WmtzSVQ1ZDhoc2ZLb2tKWk1vWndobzA0UmJSMU5y?=
 =?utf-8?B?Und4Y05sVlVEbk96Z3ovVUxveTJsYXYxbDNVcnZ0WVBFcDVXN1FVd21nSUNo?=
 =?utf-8?B?VVF5R1Y1NU5SVkVUQ2xoMjN4UkhZNUtHb2VsS0RsdXdQb0tLSzNCczBtOUJU?=
 =?utf-8?B?UTZXRlFBSlY5aHZmWFBLeUNoQVYreXpDNk5uS0FyYzI4NDg2MkFibERhR3lI?=
 =?utf-8?B?Vk9RdHV1aGNLakhJUkZhOVowSno2S2Y1aHdyMHpjNkxhWnpqc3lUcWxvcktz?=
 =?utf-8?B?Y0huY2dVbzhJcnBMMmx6Wjg2ZWdXM1RUamJnWU5tRWlqQUxaNnVLeVBiQ0l2?=
 =?utf-8?B?QWtXeE5YQmpJVG51QU0vYzBWbEo1d3lRc1N4SUtLQlp4bE5WUUhKUW9FMDgy?=
 =?utf-8?B?dmR4T0RKZ2NpL0ZnaFlWeTI5aEpIdHNpRE04MWFVTXFwS2dJcmpURXcyS0hN?=
 =?utf-8?B?T2NSaWt1RWY4WWpFVUZpK2JYcU9EbkYvaFQyTmpoYW9RWDdNZlkyMjd4aG1E?=
 =?utf-8?B?aGI2aUJjUTJXMnJuYU1WbDM5UEszZ1owSGFQTnQxK2dFRlJCWmZmSnNVRnVk?=
 =?utf-8?B?V3FiZ1ZjTFN3ZzduN0JiRWQwdXpDckoxdTdDSzhLTG1oMDBySUJCV0FxYW8y?=
 =?utf-8?B?VnZUUHNBRjBsd2xEYW9qMmpBSW1ueEJ4TG9sa1ZKQzAxeDFoZVdmU3M0M1Bq?=
 =?utf-8?B?TlFNMDByVk80N3lCcWI4djdWclV1bCszelVLbEdtQUY3YWVQaDFQUXlJKzhh?=
 =?utf-8?B?WDdUNHZrUk9WRzhuRXgxZGloY2VKY3hOQUIyQVBwMjlLbjkwbHFBV1BWUzBj?=
 =?utf-8?B?L0Yvc0R3WWU5QmFablcrcWRVbzdRSkZOK0ZzNTJIaHorMmJhemwxUzRyNXhX?=
 =?utf-8?B?QmEzelVjc0xJbEI3WVdTMUhLbDMwRVQ2MjE2dTBsdjAvd0pRSVNVQm82MDV2?=
 =?utf-8?B?YStJTjNKOHorclNyWjZaU1FmUXQ4bkt3cmZoUHZtVFZ3Wm5EeEZjWVozNEp3?=
 =?utf-8?B?bEFSRllrZ0FKOHJnN1RvVk9LMlJObkZnVE5TVHIvbGM0SzhsWHRlQSsvbGhz?=
 =?utf-8?B?alpxSEZSOUxQYmVKVWx3Z2xsa0NGRHRITXlFd3VMbXFYTDRTTlNKQUx4STlr?=
 =?utf-8?B?ZnhuYlBENHhDdTRxd21MeFFBekZUK3BVTzUvQU5OTkh5ZjI0T1Y5U2IrVjdO?=
 =?utf-8?B?YnJhUUgyc0RjMm0vUVllL0pQVDZSbXIyTlhDWDFYVHEwTitPSUtBakhqREJK?=
 =?utf-8?B?WXZqaG05QStISFp3aXRndGt6WERWay9XN1NHeEpDQTg4N213cUx2aEdjdCt3?=
 =?utf-8?B?WTNXWkIvWUZqbHQvWmRlSFB3VGIwTnVOSyt2azJmenRoanFrZytZK1hMcjJL?=
 =?utf-8?B?NW9KNnpOeFdWaHMxaGw3Z3hramdGZWxZTThaUThodmEyb3NYVlN1YzVqS2ZX?=
 =?utf-8?B?SUg1OWF1K2R5SGgyb0FGd1FWYVEyLy9oY3NQNERqLzJYdndCRzN5WGdCcXhS?=
 =?utf-8?B?U3EwZmNwSWJKdlJQWUNZL2M1YnNHdVhubGRJTmsyVXNLT20yNXVPRWJlY2pP?=
 =?utf-8?B?NTdrcjFHYmZzc3BsOUxZVVI5VVdxQ2F2QkJ3VHgyL1A1M1JRWkN3RmtTRmxR?=
 =?utf-8?B?R1hjY25nNS9DdE5tTkRYRmJGaHBGRWxHS25Ya2VLclFEaVVOQlczSTk0Zllj?=
 =?utf-8?Q?dOo4sLonyuIGLmHs=3D?=
X-Exchange-RoutingPolicyChecked: CSvlvcVzAP9NYldbPN7M19+71puyNykmCMWIbPOxiTF9gIcO47P/XK0j3iiP7Xl8DAyCPEfUBEQUvaPhlNynZd141PIFSuTLWw5PL4Lzz4kPWyfFk5ymsanOEgitDQW0s1gLvlO0DlktkrpdFWEIbpWDXMXC2dWaQB6u7Y2RM64CVfIGNJMlBZO3dj6erQRD3A7PPt2pG9/COyvw/M/tS8CheSi7mcHKJ9UQIijjxnRvx7g16sTwjv/RA1DvObxu5UZihvXSt8UtHwrxhd92izyaMn9B2gZbcuYSRP0B6O/jZJpYgaJaKy0Cwt9TueNeDAlM4YHf4VWuQvIfLPV11g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 37ad52d2-1dce-49c0-1714-08df34ec91fb
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 12:11:17.7734 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5NpX04GhUjmr0+cyJJPZbGU5Jydp3MUfQ3AGPEW1sPKl2CnoiKkthsAdEEsUKFNpZ+RN2KFEDO3hU9zZVDaX347q8OgGRLqyh/7lKjZWfdQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6220
X-OriginatorOrg: intel.com
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/27/26 6:45 PM, Aleksandr Loktionov wrote:
> An eRoT authenticates the complete NVM image, so a PLDM capsule that
> carries only part of the components is not a valid update on such an
> adapter. Report that from the driver: it knows the components an eRoT
> adapter needs, so it can reject the image with a reason in the extended
> ACK before anything is written to the device.
> 
> Reject a repeated component and a component without data while the
> component tables are sent, and require all four components before the
> first bank is erased. Check the component set again before activation,
> because an image whose device record selects no component at all skips
> the flash path and still reaches that step. Reject a single component
> request up front, and accept the Manifest component only when firmware
> reports eRoT presence. Adapters whose firmware does not report eRoT
> keep their current handling.
> 
> Read the device capabilities once per flash attempt and act on that
> snapshot, then reuse it for the pending update check the attempt
> already makes, so an update still costs one List Device Capabilities
> round trip. The cached copy in hw->dev_caps cannot decide this: a
> driver loaded while firmware was already in recovery mode never reads
> it, and a reset re-parses it in place. An explicit capability value
> other than 0 or 1 rejects every update, because an answer the driver
> cannot interpret is not evidence that the image is complete.
> 
> No activation is requested for the Manifest: the AQ activation select
> mask and the pending update capabilities have no Manifest entry, so the
> driver writes the bank and leaves the activation flag zero. It can
> neither activate nor roll back that bank, which is documented along
> with the other eRoT update limits.
> 
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>   Documentation/networking/devlink/ice.rst      |  24 +++
>   .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   1 +
>   .../net/ethernet/intel/ice/ice_fw_update.c    | 193 +++++++++++++++---
>   drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
>   4 files changed, 192 insertions(+), 27 deletions(-)


two nitpicks, otherwise the whole series is fine, feel free to add my RB
to both patches:
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

> @@ -994,6 +1093,7 @@ int ice_devlink_flash_update(struct devlink *devlink,
>   	struct ice_pf *pf = devlink_priv(devlink);
>   	struct device *dev = ice_pf_to_dev(pf);
>   	struct ice_hw *hw = &pf->hw;
> +	struct ice_hw_dev_caps *dev_caps;

RCT

>   	struct ice_fwu_priv priv;
>   	u8 preservation;
>   	int err;
> @@ -1013,18 +1113,52 @@ int ice_devlink_flash_update(struct devlink *devlink,
>   		return -EOPNOTSUPP;
>   	}
>   
> -	if (!hw->dev_caps.common_cap.nvm_unified_update && !ice_is_recovery_mode(hw)) {
> +	dev_caps = kzalloc_obj(*dev_caps);
> +	if (!dev_caps)
> +		return -ENOMEM;
> +
> +	/* Read the most recent device capabilities from firmware. Do not use
> +	 * the cached values in hw->dev_caps: a driver loaded while firmware
> +	 * was already in recovery mode never reads them, and a reset may be
> +	 * rebuilding them while this request runs. The same read serves the
> +	 * pending update check below, so this costs one AQ command per flash
> +	 * attempt, as it did before.
> +	 */
> +	err = ice_discover_dev_caps(hw, dev_caps);
> +	if (err) {
> +		NL_SET_ERR_MSG_MOD(extack, "Unable to read device capabilities");
> +		kfree(dev_caps);
> +		return err;

goto free_caps instead

> +	}
> +
> +	if (dev_caps->common_cap.external_pqc_rot_invalid) {
> +		NL_SET_ERR_MSG_MOD(extack, "Invalid eRoT capability reported by firmware");
> +		err = -EIO;
> +		goto free_caps;
> +	}

[...]

> @@ -1066,4 +1201,8 @@ int ice_devlink_flash_update(struct devlink *devlink,
>   	ice_release_nvm(hw);
>   
>   	return err;
> +
> +free_caps:
> +	kfree(dev_caps);
> +	return err;
>   }
