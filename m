Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2638DC88E46
	for <intel-wired-lan@archiver.kernel.org>; Thu, 10 Sep 2026 21:37:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AD5A180D1E;
	Thu, 10 Sep 2026 21:37:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HCgHYKSoKQe1; Thu, 10 Sep 2026 21:37:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C0E24811CF
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789076265;
	b=fAe54pmE93DyjZJFkCW8I9PiJ9vapXQ1ooKQjREuz/8aJ557+nE684LMJ7qfcWJAF2XX
	 f0z6I2/6kCsOekeZGhcFPE+5lvDA+8R37dE2tTQjFRCVZz1VPESsxVKwy9PJvKrQEM0dT
	 6kPzPwqJY8IP0YnV3xSJXM56y1VJz0KdfNvixI29g8eJXpDHAm9n7Fp6ZPjvrHqpT1PUm
	 ExG4jHfZv38Qazjvc/6Kmx+d4QYCeSPaQ3sqC9Ma9X8AYBGuloUOo7h5G0aRTk3p0MBxB
	 KRrKd8ypClzOScpGnRlwrCPoz54KqJnuEQBhJxPziPUz1vSLPuzMkssTSC6xPhnfYxw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789076265;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:Received:Received:
	 Message-ID:Date:User-Agent:Subject:To:CC:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
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
	bh=F50/OImruBCkjFdbmgPTflKTf++gEBNX42ZU3wFtKgA=;
	b=cBHwkx6j7Co2ktY78w3mqFQtzxXtJbolFtFPa4OyGZKuAodmqWujy2S3fIOb+k9l2e97
	 zxqnLPFI6eaQvYOi8JQAco3KJYWq2MoVdRHpibjrqaSb2osmIOmHqelST3R2D5eVDVHqR
	 WrrXINewIKuUZMnNzriWakKtlNlnn0bCQ/KblrDKE577dAaoIzylqYYtCy2vAjVB8O9Bs
	 5EWbNFblXP0E4/zWeu4zLGhNjGsgnARazR+bw8grt94zhbgx0eZP5GKdITOYZrd4GseDl
	 mwQx3Ft6r/ZUZOSjKTxC6j3g9XIoNwNGIdFeaynPxo1Qh2qNfrb9w2yw25sKVAS7kHg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789076265;
	bh=F50/OImruBCkjFdbmgPTflKTf++gEBNX42ZU3wFtKgA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DzLgr+ANrId0fl3BsKflqkexXkbRD3tvyfAuGHlJ65Br6czKaixtsSLxUSsXxtEpk
	 pNVI8nRsyaIqcXYDRYm0Y5wAz4sK1xrz+WDxReq/PlrGuzjoZPpMAMhAZ15FavugiX
	 P6Qa9hWSOX9i+nVtOtPycYjJ3DLONFdz0TCHL4J9/u0IXrlK44uZAGDOqfsYFBEVr1
	 a531ajZhBNcZJs9gXvmdC/eYaAO4qFc+e6rFxZZoRsCVHp/Vesly6WpVZdIGEfK3Kl
	 NSztgEEf9yu6DfVTzAmoTv7j23LRwEcwl9X2Li1VsRHx0qu9lqgJELwW9aaaezqKnG
	 yzwhEH0sAZZCg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C0E24811CF;
	Thu, 10 Sep 2026 21:37:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9763A769
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Sep 2026 21:37:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7DC3560BBB
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Sep 2026 21:37:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l6AEqhLi1JQU for <intel-wired-lan@lists.osuosl.org>;
 Thu, 10 Sep 2026 21:37:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 669DE60B4E
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=198.175.65.20
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789076262;
 b=kujSSFCkbEY7dSoENmR1H08DjNZuEq5/9ffDEcVvWDRxczySTWCGvVyKoLXEkAIHvoeX
 Lb8/oGRRWRpGzCBVvulEBS8gV2XxyMoHYMeXuKZ65f5XYrGUQeRPI71L04htu3cTLFcZ5
 YW15QgYU9jWiQNyrVgKxxV1RR7EiGuajZadwE9WOIax+lsICCzRze5xMPVZzUK0TJud2r
 rqO9AoT7b+yFx8e1mP16xbo74lCOE2OOZxKHq6EafPniPcXFzZaCxI3iCgBnUCZY/hnOh
 YTOWRjwchfgkWZqU6icUllhEdcWE7LaHx/D97OyOncEcMhLRi3QrmuSKd897w76lRTA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789076262;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
 References:Content-Language:From:In-Reply-To:Content-Type:
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
 bh=F50/OImruBCkjFdbmgPTflKTf++gEBNX42ZU3wFtKgA=;
 b=JR4Fw0t3hCSnEaPEEUldyXExSAySC/PuQD2/N759TAExz2E5mjceZFzgGD/C1mKhWWNr
 XxRu+Ej2T33lsKrJpFszAwker6QD3tz8x8kK7+UbKiNuKVc8LL/ZnAiSW1blC0KG7yF1o
 d20tT3mIWVBPDKjS15jsj7dc81Rdh7Bpy7lfAtQxs42zZmg9RiZfcVZZIAg6Vtj35oP4W
 FzXIuiJAIiizSMksWMiKoCtK3LuEV4j+oVVQMti0x3zPzBvO5mRe+FNHAft0NE+8m6duw
 WsMmFlwBaiZNV0tqCDTzZu8vvVjEEMLhauF40NF2tVA8wAN+8f9iNW6C88WwgVsg4KA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=B11G9pVu; 
 arc=fail smtp.remote-ip=198.175.65.20
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.20;
 helo=mgamail.intel.com; envelope-from=anthony.l.nguyen@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=B11G9pVu
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 669DE60B4E
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Sep 2026 21:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789076262; x=1820612262;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=/+WXggZpKi2x7iomr8vGlevLIIlGwBDgGStrx2JqRM8=;
 b=B11G9pVuEN9gHd30jm8viYEwrE/BnDuZub505YiuuJTlPkEBgVf/htIP
 pOGjQykFgmfvhYlMv1BgkVAxyVwZ6tX4pldhLN36owzGM+F/CwXjrPpnF
 HgpYuIONOwfa50EGcS82OscID6A1HGQxfzUJY7Rg5tzTxwUcwsaylm0FU
 YC1+CA5h+oC8/waAXoPAaoN6AQo1a+hQ1bbLxi+/o4DsohVSoG1kOGtCc
 ZvtZqIj4A/qnA4zYzSVAFjeIsOa0LMgO5p0hmYMoYSFyuDuY7y9aS/1re
 IOZ6NozxKiKihy0ohiOtDJTvLyPs8c36vgxLd3nBt0b0W4du+7ZNtZ3Ft A==;
X-CSE-ConnectionGUID: ntYfnXqaTxuXLSvXPs0+wg==
X-CSE-MsgGUID: +0WVEeScSIW+b4pfJBe5BA==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="89305021"
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="89305021"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2026 14:37:41 -0700
X-CSE-ConnectionGUID: SqbAAG/XTreYKC50+W4O7Q==
X-CSE-MsgGUID: q+c26V3gQ9urogBgV+kbmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; d="scan'208";a="275275014"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2026 14:37:41 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 10 Sep 2026 14:37:40 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 10 Sep 2026 14:37:40 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.21) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 10 Sep 2026 14:37:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RfFS/giQhPs6WkEOdHbncFcbU4Uj9zsDD0Hbfcuxgem0reY1ysXuWbGjQtvJHVN+Qi5GJRpx6G/xqBCfbltKYfnqXUzT9VLk4D6hYutBa9nf44ocvi76KUAzBDKUVHIUgLgWB32BfOnbnHKxb8o6IUanclk4GhDVexXSBS6v/Q8TbsC28avcoznEKoZlaTaHJpX/s+oJjmfna5jfzfP/a30MKKz3fNfrpWPPoqARS4GO7F4GdvVOZWwG4EVQZ8Y8xX5a8p9gQe5IQIUS/qBPbew1lJm5rxDlG67SlXODh/ByQCSgzKGPdbWn6ndZy1CpwaE+ppSmuqbzudDGVW74jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F50/OImruBCkjFdbmgPTflKTf++gEBNX42ZU3wFtKgA=;
 b=otdq+Xi+glE+43vjZ2rbECJcrtjnYUSee0QPNArdrHQZI1gvMTMX7upHd2OZblN2EaJYaPWwjldLVFtaA2PnQQ4Fh+t4psW/Rr5nKYZgx/XhAFdFNTP4HEXf9Xfv8vZrhy2/mfZV6IfV1zEUtF+SErXi64k2QBzI06EfedRKOb1kS5tTkMutcYs+tLbRWtX/oYWZEqx4LEf90bbFIO+hdM127DVvvLBamqvPPXib5Dk3RIZOi8w8FUho6vt/lOS+76PpwtfzS2qKrLCbv+kbIcQSqBocRyZuCiSVdn8rST++wazaVouueSv8Z3szNY5gcwg+6j00NJWqsnuDbj4Y1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8230.namprd11.prod.outlook.com (2603:10b6:8:158::21)
 by IA3PR11MB106965.namprd11.prod.outlook.com (2603:10b6:208:620::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Thu, 10 Sep
 2026 21:37:38 +0000
Received: from DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40]) by DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40%5]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 21:37:38 +0000
Message-ID: <5e55342a-9cbd-4a5f-84d9-56a80ac42664@intel.com>
Date: Thu, 10 Sep 2026 14:37:35 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v2] ice: Fix "Unknown bps" during link events
To: Lukasz Czapnik <lukasz.czapnik@intel.com>,
 <intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, Jakub Kaminski <jakub.kaminski@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Tomasz Lichwala
 <tomasz.lichwala@intel.com>
References: <20260806162458.2384818-1-lukasz.czapnik@intel.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20260806162458.2384818-1-lukasz.czapnik@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0370.namprd04.prod.outlook.com
 (2603:10b6:303:81::15) To DS0PR11MB8230.namprd11.prod.outlook.com
 (2603:10b6:8:158::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8230:EE_|IA3PR11MB106965:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e1ded76-54ab-4b5b-28d8-08df0f83bc19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|10067099003|18002099003|11063799006|56012099006|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info: BTwctJhTrg+CHXnZ21Lfj2JuIhyRhxbgo7LsdC9l3qmp84/ivqkDMhSRGXLw+F/ypry0hnV1XlewcCUFTvPJMuUvYNwuyP4+YAY9UTGfFoErOw5twjw8yFWSDWRPxLhwi5FCanamztjqwDp6R0zkIjygn8RY2/hn2Ti2S5NTIA0DwOCM5MjnGzHpD5eZzT0uWSU3R5AFjEsARyQDgYrkw+612jVMJbuASpAcurVwGy+aPewL5GuBZXIe2CR4URlTiLql3LAetFwW0CXpYzS6RG5zw85m/A7YIks/vj8IWiC3qKKszwbzuHV/X8r84KfwXdrCGZKv74/IUoG817j5WPpvbdiXkUBX85rVxqbEXEG8RkYjx7ejUk0IRqhMwudKZbpHpoNClMFHecpQ7fB++IPa3zncHcsyOHRFrFP8ZxkOx9ZZYnU1OjqW5dAmEWw0wK+ZLFeKZG3YMqW67YUIIL5DjQ6XWL2Z84kl4kPG0SvQ3QcUeuGk3DSx7P2xoswwcju1WGPvV0VYKgXatAO9L8ZWKuVrs4YCjcam/YG6gHPuKroFWSZirMvL1gBUNOPYrzIWkL3jLm2gq6zi8I98Grxv48QaRyPguAu7RgGdNBJdI8Y0FU0U2SFcRQvttMhxzbxpoOVRXFYe+fT+Lj97f+zIEUU+v6PUlWPbeyKLoU4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8230.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10067099003)(18002099003)(11063799006)(56012099006)(6133799003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OS9sOFVkS2JCVE44aE51T3pJSFQ3MEk0clo4Tm9tZGhPK2JHQyt4azJZZDRv?=
 =?utf-8?B?amJweUNBenhtcEI2a1lYU0dIbi9NMlpnR2Y1MGJFbzB0eTRkaEFZVEEzb01l?=
 =?utf-8?B?K25JRWkxZ1pUcTdnYU9HcGdmdTZkWUZqb05Fb1pkUlNJZzBncHJzUWg0NGla?=
 =?utf-8?B?QnlRWmlWRmJiU1ZKZndiNFBvTXp0L3NNR0graCtPVjhadXd0UXI3eVJHaXp3?=
 =?utf-8?B?azA4VnVzSUJsWVYySDUxekhPSnp3QmJmSUJ2M29JQ3U4MlRiRE9mQ3FJbkNJ?=
 =?utf-8?B?N28yOVRFR1daVWJzZXdJbG9MdDFPU2dZbCtBZ0hET3I0V0dCU0VqakdTMjc4?=
 =?utf-8?B?ZVlOQ21iNTNtZkE5cEdLZ044TUVXNW5abzdYd1A3WjAwK3FrSGI3QXh1MU10?=
 =?utf-8?B?anA4RzM2ODNXekVQUUZEOUQyNVRDdFFLSnVvWWhSTmFSK3RFUFRrSDUvVmpL?=
 =?utf-8?B?VVVTRi9yWXJiWHd2eWFXNmdTNE9nY0dxeUhrdWxLamtQL1l0dzVZdDQzd1hq?=
 =?utf-8?B?SitJQzRSYVdTUmZRdmM0eDVkbXZSamlsRk8zMHhIYzRjYmZOZHF4R0ZpTnFa?=
 =?utf-8?B?blFtUUZyb3Z4bHFCRzBObzNMcWxsbnB6SThLcGNROTN0UllTU2ova3VQNlNG?=
 =?utf-8?B?eXJsZ2RMSEpwb25JKzI4bEQxN2oxK0ZxcXp6bnFyMGlCQVJlM3QrZmw0UUtt?=
 =?utf-8?B?cjlGQ1ljeVNHeFJoTUVQZFBFWUwwelRaVlVPclpXaEI3T3ZsT2VOdVhXN0Rh?=
 =?utf-8?B?U1hqT2dDUHo2TFBmNUIyS0FNMGhnS3Fzblo5TEI4U1pyTVUreFd5OCtHODNF?=
 =?utf-8?B?bnp1OXgrRnRhVDNMVDRJUlJNMEN0UVBYUTQ0ejlxeFROdHNCN0FVcWlWbWNQ?=
 =?utf-8?B?MHdYYlFUSnNIUGFkSmNVRFhNOWUrb2o1SWExejBnZ2FWTmYwTUpZamhSQnox?=
 =?utf-8?B?SGREaTZ6UHBPSlB0RXpvKzlTUVJrVjBqcHpEckpUaDFRT2JxbHJBTW15OUVM?=
 =?utf-8?B?d0htUDNXQlV1dGk3MTdDMDh5bjZIVWRReWhST2h3bUNmaWFOZG5HNnlmaGJK?=
 =?utf-8?B?NjdsTVRnMUY0cVd2NGlpd3F0dFZ6cWdHQjdWN0hDTE1FZ1ZKTlpzb3dVdzdW?=
 =?utf-8?B?TEtOK2VZTWExcSs5eW90Ym5wZ2sxN3BpVDFZS0l6T1J5SG1Pd3htN2lGQVh3?=
 =?utf-8?B?ZHBnMkFtNTJtNjRvaXVhT1Q4aUlNdy9qRnJmS1N6V1Fkb2tlUmJPZW5aTXFR?=
 =?utf-8?B?TGptaEJEOEs3cm9FYXNoNVNMVThZcFdlWUpOUDhReXRLK295WEVUai9pU0w1?=
 =?utf-8?B?Z3N0dFJWbTFsYXdaSDFzV2I4M3grKzZ6UFR3S1lqOFhiQUJKNWlCUUx6NkZG?=
 =?utf-8?B?dit1RzBhOUZYUUFVQ0RUeHdneUJhOStoZ2ZkcEJVemlpeFRoL29Uek5JYzZt?=
 =?utf-8?B?R2p6Tkl1NnR2TnpWaTFhWHNPcEtObjNUbFRVelJrRWhyOExXVEZmUThBV3pi?=
 =?utf-8?B?TjNmNk82MVE5VzYzMlJPRlJWYll1N0pVSlEvTmxCS0xiZnBPbHdHM3paWk4v?=
 =?utf-8?B?aU1aWEVsVHpiblVWODgvVnlxYmJNbmdpNFJtQmx2eW01ZUM2MFhINXFTNTA3?=
 =?utf-8?B?R1RIbFQyUFRKQjZ4aW1tN0NSWUw2RDFiR1pIaUFmNUM3ZytvdWtLSUM1eTM3?=
 =?utf-8?B?T2ZJN3R0RHRGaTNiQWd4bEFleTNZR3ZVWTVJbzVYaHlDYlZDbjBROEZWTytF?=
 =?utf-8?B?djNzNnV5cWdYb0c3OFFrbVhkdVQ3MjJmSmxNMXdnajAvZTR5U2IwSnVKRUll?=
 =?utf-8?B?UGZoZzh1ZlFLOTY5ZGg0eTVxVGJDUjErbTB2cWVmNGs2bHQ1Zk1nU1JpL1Uz?=
 =?utf-8?B?YjJBMzVmc0ZnN0d4cm1reXhtejVTQTlQRDVsTVlwUkU0ZWxCQnEwZGY3bkFU?=
 =?utf-8?B?TE1vdDl5UlZMbVF2ZVNiNzZrd3JOTmxNS3dXT0ExaEV0aDFyVmtBaTVoT1JP?=
 =?utf-8?B?T3hWRjBCMUdsNlJNSWoyTDBUSTd2YjdlZ1NxS2hKNm5TcllzZzN5MGF4eW42?=
 =?utf-8?B?QXFrcER5cVpQQSt6U3BIUWxFMnVvY1pWTWNaSkRLMHFyN21KbERaVkcyOEpm?=
 =?utf-8?B?QmZYN2ZYZk4zbWx4S2ROTWZLaUZRbTJZNHFqa2tiV29OSWdUTzBsVWNKZUc4?=
 =?utf-8?B?dUc3OHExK1QzYmxTbXFFWEVuUitaL1M4OXFFZ0Jmc28vRXl5OHdoMWxvQ3Fi?=
 =?utf-8?B?VjJWZ1pYRUFpanFSaXR2QjJNRWcwaWtQaEVpMTc0OFRoNDJtWko5M0VGWDNt?=
 =?utf-8?B?NGpUK2x5ZW0yTGkyb2NVa1FGdkVDUXFlZHZWY3pnRGNseHp3blNjNG5tMDlx?=
 =?utf-8?Q?+g5fwLcONiKMvEcY=3D?=
X-Exchange-RoutingPolicyChecked: TyQrjq8MNjHczhH1WHTc/MrevHHSi3KeTz4bd75jHvM+Dp0FxfjZ+Wg2ywKwvq/pH8ynqer0X+cowiBFtwu/n4zIEkCn6HCY9Db5k/4Z8qXki489CEi1ftozP/imABKjpKCdVKc6Rjsye4HsJoTrGSCNREgo2RuVfTs2atmV0NyOx48S/U5SOYmUU1Wzm0i/2b2oOD43xbk2+QP+WdwxWfnqc72YTrp0TS2I6hWWIJ9MPD2mhfCjSKcQO9jSp1ia/5/TFyr0dRSaWOt0jVJhyKTa81u4dFrANDbYtHQl0cnny1gWq5eyh3qWSxy8NLHEsvc3A/Ab3hCXPlAMb9GPng==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e1ded76-54ab-4b5b-28d8-08df0f83bc19
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 21:37:38.1880 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Oq6Bmn20BVxaubpPwO4QUoVh46lsIutn4C2W60fXFDtQ8mTl6DaNghjS6mw2l2uSR5lX6RduQ8rDEhfQU5dB3Um/MEY9IqQBhqNtmoy5ec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB106965
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



On 8/6/2026 9:24 AM, Lukasz Czapnik wrote:
> From: Jakub Kaminski <jakub.kaminski@intel.com>

...

> @@ -1190,11 +1191,8 @@ ice_link_event(struct ice_pf *pf, struct ice_port_info *pi, bool link_up,
>   
>   	ice_check_link_cfg_err(pf, pi->phy.link_info.link_cfg_err);
>   
> -	/* Check if the link state is up after updating link info, and treat
> -	 * this event as an UP event since the link is actually UP now.
> -	 */
> -	if (phy_info->link_info.link_info & ICE_AQ_LINK_UP)
> -		link_up = true;
> +	link_up = phy_info->link_info.link_info & ICE_AQ_LINK_UP;
> +	link_speed = phy_info->link_info.link_speed;

Sashiko says:
Does this unconditionally overwrite the ARQ-provided link_up and link_speed
arguments with the cached AQ state?
If the synchronous AQ query (ice_update_link_info()) called earlier in
ice_link_event() fails, for example due to an AQ timeout, the
phy_info->link_info structure is not updated.
By unconditionally reading from this potentially stale structure, link_up
and link_speed are guaranteed to match old_link and old_link_speed. This
would cause the following early return block to trigger erroneously:
drivers/net/ethernet/intel/ice/ice_main.c:ice_link_event() {
         ...
         if (link_up == old_link && link_speed == old_link_speed)
                 return 0;
         ...
}
Could this silently drop a valid hardware link state change, leaving the
OS and the hardware out of sync and causing network hangs?

Tony says:
I think the right/wrong combination could cause this to occur. I, also, 
think there's an issue with accounting for the link event and updated 
link info that could get lost if it changes.

Thanks,
Tony

>   	vsi = ice_get_main_vsi(pf);
>   	if (!vsi || !vsi->port_info)
