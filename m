Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5051EC5B572
	for <intel-wired-lan@archiver.kernel.org>; Sun, 16 Aug 2026 10:06:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E8B476066F;
	Sun, 16 Aug 2026 10:06:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9y8oVxlrilVM; Sun, 16 Aug 2026 10:06:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6A72A60614
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786874766;
	bh=s+oEiJd/hvEJNu5U3EQwdXIgMUNhjDK1tVJ9O20XbPU=;
	h=Date:To:CC:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Tqbyk4L/7NB1h67AgMPinH87U7/jACP7XDJ1A+mHRXRWrkbxCy0t/7wPoZOb8TrWF
	 32koIQlDF9jvZ8IRSFXrMa4eTyCbFxvVMRSMqNxVzdkw9CIabWEwnmpJQ97JM9rux6
	 ZyJcdScBhv25cmZ4+UEkngWfSxboq4Mc8uIJcvtukkdvBs3N0dd7uOrhZgpgDEsoKw
	 JllC623Hwg4jmkzFmTfQPuWErWxfN21H7LBtLoZ8Yf69FH4/WBjPrv8vR+hZej5RZ0
	 VOTdOFw2L6INLrliNYrNSNcsh6u2JxvlO5162flNwLihRHArd/dikRT2DrQ3vNhaPj
	 RGkM3BFbsOkbg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6A72A60614;
	Sun, 16 Aug 2026 10:06:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id CB7A6337
 for <intel-wired-lan@lists.osuosl.org>; Sun, 16 Aug 2026 10:06:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B1A67406C5
 for <intel-wired-lan@lists.osuosl.org>; Sun, 16 Aug 2026 10:06:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZzLkwMC2vBkg for <intel-wired-lan@lists.osuosl.org>;
 Sun, 16 Aug 2026 10:06:03 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.13;
 helo=mgamail.intel.com; envelope-from=moriyax.kadosh@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 450F2406A7
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 450F2406A7
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=j5BkAxZT
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 450F2406A7
 for <intel-wired-lan@lists.osuosl.org>; Sun, 16 Aug 2026 10:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786874763; x=1818410763;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=+XJvdMq97LfCwEeOV0YCT4daztqwqyCagWmKkgSSPIU=;
 b=j5BkAxZTyBGH8x2raVV6Ws+w3oXtI8Cq4rNBO2wSyRMJ+jPjmQ79SrMn
 XHTh0eEGjtjkijbsRpkCJFfyq+Bd2fnQSF4oklMEbMYvzc8MeZVF6CQgh
 dJN/d4VX5RZRxcAYBGeJYboo175vQX8FHOg9Rb8pT7yoN646PbWDunn6u
 cmUi/jmjh6EQVj/ZAnj3VRnnKiVRkRcb9ADIBLTQ5Cvl7h77KcRuXlZAy
 vVO8/D9fHY3ieBR4kLvhpYLuOdXbAuNzkcAl/IuMe9IBJ4t8JpYvm78zB
 fU5DsBUgeE3aGRdf4yrNrZyO1sQuNPOXZ7/5CmoQiw15WmUH+ZBMhv6Ev g==;
X-CSE-ConnectionGUID: htGP7fdgQkKAc0bi/VbqDg==
X-CSE-MsgGUID: 37WEvecVRYez+3mFV834Fw==
X-IronPort-AV: E=McAfee;i="6800,10657,11876"; a="89896312"
X-IronPort-AV: E=Sophos;i="6.25,226,1779174000"; d="scan'208";a="89896312"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Aug 2026 03:06:02 -0700
X-CSE-ConnectionGUID: m4aIDdl4SmK9JUIU0qkjkA==
X-CSE-MsgGUID: uifcoQSJQAa7k95SRJKnQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,226,1779174000"; d="scan'208";a="302877891"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Aug 2026 03:06:02 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sun, 16 Aug 2026 03:06:01 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Sun, 16 Aug 2026 03:06:01 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.48) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sun, 16 Aug 2026 03:06:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I17/+kyHVc0+taW5/JglXrExsPzjt/63XT82w8aT7y+uQyh2ApAz5yy9GDrojJ1R6HerkEDc/Dt5auFhTgepMNAesIk6+SZ0ebC6XC0kXthBGfXWxJLJzTFKeWSOD76ad3u0JPgfycZZKQRyu9IjBXYHYXuZJXfj6l3bv6urGBEvIpgf/VgKN12CEiCTIwM4z2/8tKqBASmGAXb7ijIrLq/x/fUgoS/bCaCczXxzKWlhOYkpt4AD8D5LCoMTXozycmd3MarIX1Hau745ZBBAXs4ITDHXvgwdmoWy4X4XpEvhFVsNwsFjEBlbPWlbNTGmIVZbGokdAyAo8vlKYF/8sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s+oEiJd/hvEJNu5U3EQwdXIgMUNhjDK1tVJ9O20XbPU=;
 b=wQCE9BYW1TO0vOkgvBQpb4k0NC3RYAHvHgkedFjsh4ZNc52arrf1W+rpuHYz4HLDuPMKJHtpIF5BO6wvPelRAuE6L19rcEqvRM6+Jdv2CdRvGnUuWCWvk580mU0T+gYe6CdjxFRbpE01ap03+Nj9Wal1dW24TtE85u7XEyKattlzV80TxnZb6PkBFXEBBcV9a9XOuJquUqla1UU1GgL6RqmpQ1qRpU3P+IY5LkP2c3bP+JKAPLfXyZLQnNAzzuJVTzijpiBXz1nu8R6DMMQSw32HZhKNbr9WG7pGiFlIypxPD3Po3rahRAg/kPvFPRDrKl5xujmSd4frvvoqGjMaQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8448.namprd11.prod.outlook.com (2603:10b6:806:3a3::17)
 by MW3PR11MB4537.namprd11.prod.outlook.com (2603:10b6:303:5d::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 10:05:58 +0000
Received: from SA1PR11MB8448.namprd11.prod.outlook.com
 ([fe80::38f:6a4:ce6b:d5b8]) by SA1PR11MB8448.namprd11.prod.outlook.com
 ([fe80::38f:6a4:ce6b:d5b8%4]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 10:05:57 +0000
Message-ID: <71733617-814a-497d-a43e-421b688539da@intel.com>
Date: Sun, 16 Aug 2026 13:05:48 +0300
User-Agent: Mozilla Thunderbird
To: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>, "Loktionov, Aleksandr"
 <aleksandr.loktionov@intel.com>, Ivy Lopez <skunkolee@gmail.com>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260806172452.32139-1-skunkolee@gmail.com>
 <DS4PPF7551E6552AF076FA235232DAB1E95E5D12@DS4PPF7551E6552.namprd11.prod.outlook.com>
 <835dad4a-6873-4983-af3b-ea7b58f93a12@intel.com>
Content-Language: en-US
From: "Kadosh, MoriyaX" <moriyax.kadosh@intel.com>
Organization: Intel Israel (74) Limited
In-Reply-To: <835dad4a-6873-4983-af3b-ea7b58f93a12@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::16) To SA1PR11MB8448.namprd11.prod.outlook.com
 (2603:10b6:806:3a3::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8448:EE_|MW3PR11MB4537:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ced2a43-57a1-4f5e-c6e5-08defb7df75a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|56012099006|10067099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: E/+l8xKVEbVEx/mi1FRDA6kNXrEBeP6QIAPfw+fWkvnfG5mHMmz0KeFKMCw6Kg/1Pwm1LpLfs574zoJ3dF5OTEks4eTPrAiQeLO19rRENwGUXRmUKjQFuaBU3aeKUx+hK9K+Jwu15NucwrqO74m3gKrjBeZiIXIL6dY53ZFZnAV9K+NJLwKx2oRP3BD/f5sfnBp9SDHAScIvAgeB4O2ATW/CNGgeBluGtC6OHmk+aoo6Hfrc+7wsuB72hbBfl844pPWQ/UyAzy/K/A/m/QcppJ2Nrys2YTFKyb8tC9PiZ2SUnz//sV2B+p8beK1yfBmXDg2qc9VPVeSYEiwgjxg/Iy2dYtfB5pwYKd28MXogAc5CrdWOK342ZAZZfG4UgVCIfYieZxYq7LpPd0deZoqMhdfR2pSHStw0A7IRsFn8oQJUc4zi0mcyuMW1ooDkTwABAwmcQ8Lsb7Cx8DJEI6twB2uGU247wyGy0FVgK/QZOGkV28kbH7SBotspy3N8cqkIEqNVlnzQODDqZaz5Hj86hdDiagXjxQ77tHBWspPys8VhLAUSsOnqHyXlK6ox0rdyIycm23wH+MpM9sAT46HvoGfYEtOkBwXVQsZAfGTw4vbb8KcL9LEkMLyEvMPgIpiJMUGB1zqNSsIsRbivnDjjfH4IdRQLxyco+YGsVQWJ1qQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR11MB8448.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(56012099006)(10067099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVJJemdoL0NuYlR6bisvWDJZYld4UkszQWFBWVV1K2UvQUlWTzI3NjlFUWlo?=
 =?utf-8?B?WHkvQnNTcjA5U0JxdlpCbmFyajZyTmF2bWdlZkt5Y2ozREx0SXZhYktIZEg4?=
 =?utf-8?B?eTlMU0tZb3N6OHBTeUt4dVRBZ3Y3dkxHQnNBZEdNUGpWbDcrbkE3Q0V4U1FB?=
 =?utf-8?B?ZEdyd2psaFV6WlpNVTZyR2VQeEF2eFppdjZIbmg4WGlkczhOQks2NU05allK?=
 =?utf-8?B?cWJKSTNqT3JTQ2RKMHZTejFDMXRsQ0VxT1Bkc1ZrQ2ZnQWxRVnZGWTF2NTVw?=
 =?utf-8?B?dzg5UlAxU0Qzd1hkenc0MDQ5N0syaVlFVWRxdW1maUZyS1QvcG96MzBwVkdV?=
 =?utf-8?B?V2VaVjJDTnFzbTRDZFdPWHloL1B4OVNvM3F0M3YxWVlod2JDdm44bC9ZWUh3?=
 =?utf-8?B?VjMxcHExUjlRbU9xOGpqNHRXeVMxY3lFWmUwWFdPK1h6K1BmOW5SRmVBN0tu?=
 =?utf-8?B?MHBQT0h3SG9yTlVvejZnQnd5WUk4eklTWjhzaGV5RmpNZm5SdFFINmNrNUZG?=
 =?utf-8?B?US8waHNvcnJTc3I4NStyQnQ5QlVpNnlHS3FtdEsxL1Y2d1lRblU3Q0NXRTJi?=
 =?utf-8?B?MTk3WVUyYmVYTWpiQzdXMC9KcE9abDBOU3U3RUVrTmNHTXBibW9Wd2dIaHoy?=
 =?utf-8?B?SzkxTHdqVzZYbDdWYURidG4xVUM0L0IwMVEzRTZnSU9DVTJQeW16MllyVkdu?=
 =?utf-8?B?b1dlTUFUNFVlMlRhUU8xaDludTRVaVRZZG4yTUI0UDBOcTFNL2crMnBROElU?=
 =?utf-8?B?TnI3WXJkNlgzRGJXM3RGa1JnUHU4MlJGTVc5dEgzVkRHNnFsK0liTC9OQlJF?=
 =?utf-8?B?MDgzU2FGT3ZDTXRzeitCanhzMWV0ZFVlK1JMSk9sUHl1UmRUcDcxMDF5NnBI?=
 =?utf-8?B?aldUYmo1RjV1YXB5Rk40U3c5RmFQZEdxL1BxalVyYlNVWGdSd3BieUZHNG1t?=
 =?utf-8?B?Mk1PWXVhc1E1ZG9RajJKMlJzWXlYNm8zZmh4MklRYlFrZzFValdERFV2RUNs?=
 =?utf-8?B?YzE2em5HeWpoR2gvemMrZzE3cmloc0FGQURyT3REbWlZd1ZhSUV4cVRpemFT?=
 =?utf-8?B?NC9meG0xekhiY3NQSUlwOGtzWmpyQXJqU2x6a2M0MWgwZHRDaHJBOW1NSTRT?=
 =?utf-8?B?a2lzNXRtanlmd1pDL2xyamZEVW52eXhIS2kwbUViSHUyZ1gvMzNxMU96Rm82?=
 =?utf-8?B?cEpQbGQ3UmFnU1oyaWk5WlJ6TG55TzM4VkVJb3E0QjVOellvTEwvY2tqM2xK?=
 =?utf-8?B?VW5LdHJFa1ZwOUQ5Z0lNOSsrNmRBZ0htdW1mQ05CMHpHaS8zY1NIaTF2UUx4?=
 =?utf-8?B?cGxEU3dUU3laVlZ0TVR1UXhCMWd6a0NKeTJDWVIvRUhzaXNsVXA5VUtRb09L?=
 =?utf-8?B?TFMwWnRkdkZxY3pGeFJSTWJnUnl3N1I3RjEvcjlsMVR4VTVkVTdKcmdtSER2?=
 =?utf-8?B?Mis4ZC81dUlCcVZkTVVRS3F1amdBQXZtbHNoSmlRY0NWYXZyajdBWXQ1QXR6?=
 =?utf-8?B?QWdBK2cxSllSZVBGV2ZKNFBvRDRLbFpHQTA0NHJTeDRhRjl4L3F3cFdWMlJ4?=
 =?utf-8?B?ZENWb09YY0o2QlQyZGdCREhocWNqSWk0Z3cwZ1htNDhhdEhNa09pY1ptMHM0?=
 =?utf-8?B?emFoRUNLcENrb01NUjFkZ2xMK1hNd3YzMXREV0JWTFIrQ2FxVUh0TytBMXNt?=
 =?utf-8?B?UjhCbFR0ZWtEN3RQMXM5ZVdPbDNoMGNTSkhFWkFSZkJuSVM5N3k5dS9YMGNH?=
 =?utf-8?B?MmxrZGYxTlJ6dFRGcmZiOHY0Um9WUzd6N3JJV3dvMnlVeFhyTHJYaTFjMTZm?=
 =?utf-8?B?MDE0NjUvL0F6TVpOMFliZFprenJTelFmVzBTaXhWVlljYjN3Q21NSEhjY2tT?=
 =?utf-8?B?Vkc0RnJMcDA2dlZHcHVKcUc5dGdla2xHWUY1N0dmRUh1VGk0UytLSmNoUFRw?=
 =?utf-8?B?aTZWakFac05iWTBWNmgyOWVySXphaTVLcmRTejg3TVpRRU02Q2hiakRUZ1JR?=
 =?utf-8?B?eWFJS000aUpXZEhwN095a01kY0hJQzBPSGc0U00xOUtnMzRYV2ZHOHlSYW9V?=
 =?utf-8?B?cHJMUU0wZ0RONWEySWdTbjNQTmVQNnRjdDBMdTVKQ2tpaHNjU1Z0TkViWUx4?=
 =?utf-8?B?N2NPVlo0ZWNER2tMUm1GMGxDUDgzZkQ0QUpOU1ZMOWt3cDZPRGhVc1F3cVZa?=
 =?utf-8?B?eExkTXpBUGJHY2RtT1FoVlJiUko1TFdheGs2ZWgwZVUvOUlIM0JyQjJSeDBs?=
 =?utf-8?B?b2QzZnBCU0JLcmUxY3JjREJSVVRreVVuTEtpS2M3aFhvak5IMnJNMzV0Sllh?=
 =?utf-8?B?bGV3dkFRd2orcDZjWHRrTXpubGtJSEk5ZWVWNW5pcmN1b2g5V09sc3JLL0pE?=
 =?utf-8?Q?uppZpSxmc5dKjOTg=3D?=
X-Exchange-RoutingPolicyChecked: B2tzqnVVs/fkyjRCTUOkQj+hISa5PfpqQbLJymPwMIP3G5RNR29WhKW8MB11Y4lxxnWULRwxW+0FQTuDq21cp28uOwoo3ivBCKcCHK0pjQscmzWqZSoOK45zVnx4PjkjZkIcHJM1L0NWcrjkdJURqaxTuo0pW9yMUW44E8I1xbXlrZtwJmcjIJGxKTVyWoEN7tRak+I6zmzQEgcMTb+r3Nb1T/XRSJmRdLPffh4ggv3CBbQNXWtVaW4jd2ScqF34mQSXUJ7aQXCGR2UywF+DrNQCOF3TFDIW0Dom+aaq6jg4y3MY6BAyAdeuMov+nyzwqjjJkB3VocLyTKYgdLVAvQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ced2a43-57a1-4f5e-c6e5-08defb7df75a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8448.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 10:05:57.7489 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WH5e6OwSqokqUa16LLO1h9rkxrLHrdirPIxVDgODqhnOS1ECrQWD0UvLiAKRGYEXfx5zeXyJIZuN33qgGMz2Ndd+jsSkCOEUCh3VXybvtI8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4537
X-OriginatorOrg: intel.com
Subject: Re: [Intel-wired-lan] [PATCH] e1000e: fix incorrect modified flag
 check in e1000_read_nvm_spt()
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



On 09/08/2026 12:21, Ruinskiy, Dima wrote:
> On 07/08/2026 13:56, Loktionov, Aleksandr wrote:
>>
>>
>>> -----Original Message-----
>>> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
>>> Of Ivy Lopez
>>> Sent: Thursday, August 6, 2026 7:25 PM
>>> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
>>> Przemyslaw <przemyslaw.kitszel@intel.com>
>>> Cc: andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
>>> kuba@kernel.org; pabeni@redhat.com; intel-wired-lan@lists.osuosl.org;
>>> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Ivy Lopez
>>> <skunkolee@gmail.com>
>>> Subject: [Intel-wired-lan] [PATCH] e1000e: fix incorrect modified flag
>>> check in e1000_read_nvm_spt()
>>>
>>> e1000_read_nvm_spt() reads two adjacent 16-bit NVM words as one 32-bit
>>> dword for efficiency. When deciding whether to use the shadow RAM
>>> value for the high word (data[i + 1]), it incorrectly checks the
>>> "modified" flag of the low word (shadow_ram[offset + i]) instead of
>>> the high word's own flag (shadow_ram[offset + i + 1]).
>>>
>>> This can cause silent NVM shadow RAM corruption:
>>>   - if only the high word is marked modified, its pending write is
>>>     lost and the stale flash value is returned instead
>>>   - if only the low word is marked modified, the high word is
>>>     incorrectly overwritten with the low word's shadow value
>>>
>>> This function is used on all PCH chips from SPT onward (SPT, CNP, TGP,
>>> ADP, MTP, etc). The bug has been present since the dword-read
>>> optimization was introduced for these chips.
>>>
>>> Note: this was found via code review while investigating a separate
>>> reproducible packet loss issue on I219-LM (SPT+ PCH). Testing showed
>>> this fix does not resolve that particular symptom, but the flag check
>>> is still a genuine logic bug that can corrupt shadow RAM contents and
>>> should be fixed regardless.
>>>
>>> Fixes: 79849ebc0e06 ("e1000e: initial support for i219")
>>> Signed-off-by: Ivy Lopez <skunkolee@gmail.com>
>>> ---
>>>   drivers/net/ethernet/intel/e1000e/ich8lan.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c
>>> b/drivers/net/ethernet/intel/e1000e/ich8lan.c
>>> index aa90e0ce8aca..87cd1cdc6f10 100644
>>> --- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
>>> +++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
>>> @@ -3473,7 +3473,7 @@ static s32 e1000_read_nvm_spt(struct e1000_hw
>>> *hw, u16 offset, u16 words,
>>>                       dev_spec->shadow_ram[offset + i].value;
>>>               else
>>>                   data[i] = (u16)(dword & 0xFFFF);
>>> -            if (dev_spec->shadow_ram[offset + i].modified)
>>> +            if (dev_spec->shadow_ram[offset + i +
>>> 1].modified)
>>>                   data[i + 1] =
>>>                       dev_spec->shadow_ram[offset + i +
>>> 1].value;
>>>               else
>>> -- 
>>> 2.55.0
>>
>> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>>
> Reviewed-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
> 
Tested-by: Moriya Kadosh <moriyax.kadosh@intel.com>

