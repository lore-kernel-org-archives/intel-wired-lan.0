Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCE2606A31C
	for <intel-wired-lan@archiver.kernel.org>; Tue, 17 Nov 2026 14:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=Pkpu32CX;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=j4Sp8kGN;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=VWbJXvHB
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C9E73407FE;
	Tue, 17 Nov 2026 14:41:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QWYCN2-pFKep; Tue, 17 Nov 2026 14:41:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F2D8A405CF
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794926490;
	b=P/ehkh7LOtJoUpulSToxAbyrqGPg7daqH//ngXmmRl0jgXzHqc+WOqGwSWzBRIyB1H00
	 vPkqcVu2dD5GBETYurJNdr+6Rg2dPIKYLZy0YgOtdMzcWUuhO/Z5qMBtQdAmaSzIJEzj/
	 8uViT/b8ROdRuMe+mZXjg74ESOG2+2UHn7A7d2ei847DghgqNv3kk1tOwZ2o6qZ2bbjOx
	 h3VZAe7dQnLazKx8JsIgY3tRJkX6ZxnbEKzygNrr4JDjGw7qOOpdZHvMU1fnMMzqzpVy9
	 OCU9WCTqFiEssZF3OGKbmHtu//6kifGaySHmQYdfXLV3tH28dsg1Ns1MzGf2r+Ho35A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794926490;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:DKIM-Signature:
	 Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:References:
	 From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
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
	bh=jQf8Nxux/wDw+rUOXLnr9iCDlqEQyNaHI27l3hSq+fU=;
	b=rzg+9XWuc/z8yTlzGAEJ7pXHyz+V5pJwrJcbK+1GzCKkwDA57XlVWLSo5rut8CtGoPQG
	 5W2XsqTJ5CVyIgQiKiqK6lapkzUbiTh6CHv9A2he4LaS1fSt0TlkfvCXrFT1DFxIfNEky
	 rfHSEkJpJiwto5QwrASJZDYQ6343aZLq97HjgYMZzmX5OET8BmtLhdZjhNy37HBXTBwWm
	 OjUqeD08viOIYwnHtmsDTWYnQV6TRxdAXRzurxfGc59WvE/09sN82zLpwiBreiNlYCXHy
	 z3O2DNU8x1nigZiiJdm30vMD3XFeQBxSXcJLwKJUxbH47d/41fTV9CRtd07dpnY3mUw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794926490;
	bh=jQf8Nxux/wDw+rUOXLnr9iCDlqEQyNaHI27l3hSq+fU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Pkpu32CXu1N5KNUSX0Kv+Y9hdYInbY91Dw1MAWw6NkjGEE45YOCJGP4Hcqp6vX0Wi
	 QRp3qJG2pPw+J6gCjek5iUyuK5lxwlb8wsYAaxam/tUNU5o01mSWcnS+d8ZFs2g153
	 UgH9MIIQTQBpm3STkfW+s+ceV82B5cSb5RCT2ffXBSqCDo85i8aqxfC2A0A+sh1hip
	 fnYp8n9pSgRqSIW3rb1xA4YJOALUtcwpyex4KApqsiadv/0/2PMSWjorf77Vng8d88
	 n0bc9OupIi/okYV71Tico4r8pxXUg12ElKK524g362mo7IzFSNlO49ZHJkAN07XTmK
	 sLih7NKhsPlrg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F2D8A405CF;
	Tue, 17 Nov 2026 14:41:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7B06249B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 14:41:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6005B6085F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 14:41:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZgyKLW7Td8pf for <intel-wired-lan@lists.osuosl.org>;
 Tue, 17 Nov 2026 14:41:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 20D7A6081F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.17
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.17;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=j4Sp8kGN; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=VWbJXvHB
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 20D7A6081F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 14:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794926487; x=1826462487;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Xs1YaipoBVAjjUa2GcHl9dTaJXmgN5ZNGwZcCa93j9U=;
 b=j4Sp8kGNCHzpKOYSqEEKO4LtCuo4fN1XisqqTo78s8YpHGHOg9Z29zdg
 wZEDkRCyNoctskp9mZHMIyYgjCMmDedb6ZXe2xWHDW0mSBJKS+5NplJ59
 2D49YmLKy8KAnENBzXoFLiGzRKIyPzXfhgRT7HPEE4a59SNIfsh28fxSi
 41jjOWEoccKcUQsgRPJVtsuiGpjX+ZbhSGzE1cwPIUtd+8bkMeiJ9omty
 wzJlQai6Olu+CDtG3wEnHqMmIZX6IkqeQMZma8TCiVwLfS6ovebqMjSz/
 kTP1r5pg/AVN4RVp8g1NEKPUDBzL9PNlZifNgQNBB9xBBYD6lVxElTGbA w==;
X-CSE-ConnectionGUID: HpHfltmxT36LGbjuHUltig==
X-CSE-MsgGUID: oFm26dUrT7+hOQuxv0AW6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3692109"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3692109"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2026 06:41:16 -0800
X-CSE-ConnectionGUID: Nl1T380tTBCeNswl3cWwWQ==
X-CSE-MsgGUID: t8vrWe/PQZymDCHHlSXHpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; d="scan'208";a="10081037"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2026 06:41:15 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 17 Nov 2026 06:41:14 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 17 Nov 2026 06:41:14 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.64)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 17 Nov 2026 06:41:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQf8Nxux/wDw+rUOXLnr9iCDlqEQyNaHI27l3hSq+fU=;
 b=VWbJXvHBWtMu9Znepz4Cz5HkzQlOgT27r8uMaEiRyD0f//lDXPeXIEeM/lItqIEIMmBXL1zlKP2dsTJDJ6eRr7nRdyGM3nA+U2EcoIp4XWN3g7J+p3EXkw/SBHjDK8mcdjUDq353ubfI6dE5CPQ3IbaOzgxToe4RQarnUbc7iw0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by BN9PR11MB5258.namprd11.prod.outlook.com (2603:10b6:408:133::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 14:41:10 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 14:41:10 +0000
Message-ID: <afffea49-0a9e-4598-a6c5-ec8d8fa7bd5c@intel.com>
Date: Tue, 17 Nov 2026 15:48:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v3 1/4] ice: check the auxiliary device pointer
 under adev_mutex
To: Petr Oros <poros@redhat.com>, <intel-wired-lan@lists.osuosl.org>
CC: Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Jacob Keller <jacob.e.keller@intel.com>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@kernel.org>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, "Clark Williams" <clrkwllms@kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>, "Dave Ertman" <david.m.ertman@intel.com>, Leon
 Romanovsky <leon@kernel.org>
References: <20261113161453.1234851-1-poros@redhat.com>
 <20261113161453.1234851-2-poros@redhat.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20261113161453.1234851-2-poros@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIUP296CA0074.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:349::17) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|BN9PR11MB5258:EE_
X-MS-Office365-Filtering-Correlation-Id: b031010e-c4fd-4e74-247a-08df44b8d268
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|23010399003|366016|18002099003|22082099003|261009223027099003|4143699003|56012099006|11063799006|261102123227099003|261028144727099003|261026140227099003|261021121427099003|261022075727099003|261022105027099003|261021123027099003|261021135927099003|10067099003;
X-Microsoft-Antispam-Message-Info: +XnVhbe1TSN84oT6behoJ7M4sF8Kce5F+GAaf9XToDoiFJUnnYjloGMgtwExmLuiyO2D2hl3H+kaw6lMwdX06l7HVAS5PbMI/d3elvNovdI6J+OmQGO59D6px+axD+PO2HcPEOlpim0D/rL5yDMSMVW7yMKOEBQdIslpRL+e7DVDtCgfbXwVxUAhRRAmwRUsrlwRdFW9qN30Nvl2JaUeWxvjKCX8ap2ZNKeyfswVlr3Qb7sjMZ9DHOitfjRKqY3QnLwqD43yCEpsIHvlRXRaWkHrbzx3NIvqmWEgLB2pptxanFu0v54N9jzdXlrHFsRAeg18FTNeNbAClR1tHiLxwMhAG1HS2+6yHyGYjnab6Cp6OEg0vX8kx4WmYyrOsbQHAD/ypxeI40Vnn0MMK8ic7sYIXayY2Y/oI2WP53UqPqkAs8g18wCEhvDlB3o9S7QYQXjvwdTISYZ+J3EzsRpCImBV9gTVcczjaHMolPlTVpNz65hZtLDrqjvMRfft5BZZ6VHx29H1dw7lyeWpGaU7bfWGz6FqP3aCohSomzgMmHE4DDrsKaJWwAG1j0Ja4lX5THZJexXg3uezPdYDizrHgL2Tvm6Gsw4LONSEonCow1uNAvXpCltNLycrgPaMsNK6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR11MB8508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(18002099003)(22082099003)(261009223027099003)(4143699003)(56012099006)(11063799006)(261102123227099003)(261028144727099003)(261026140227099003)(261021121427099003)(261022075727099003)(261022105027099003)(261021123027099003)(261021135927099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?angxOGNDQkFPWlhmNEIwN3NSY1ZvZXZkdGd6UThZYzRzaWdzbDFZd2xSeTFh?=
 =?utf-8?B?dGFDbzZqZEZodWE1Uy9jSmp0Yks4MmtpU0ZjbEYzVkZsbjdUcTA1VUNwZWFS?=
 =?utf-8?B?cjZaM3h6YzFzdUFoQzh6dzd0MDJOdlBzRUZPVS9ZbGRZLzFGRDlqNjdTem9h?=
 =?utf-8?B?TFFUblA2U2RNcE1QWEZJYXAxWGtJUlJmMWs2T05RTTN4QVgwNytuTHorUmQ1?=
 =?utf-8?B?bjFvU2FERkZPT1VWYU9LYmZMbFdGVk43eFBSZnI0OGVGMDFkRXFoNWNoNkVV?=
 =?utf-8?B?TmprYmswdWlXY0F4b21VNnRweWx0RUxCSWVjeGRoYTdQVklkUTlFNnIrQlhK?=
 =?utf-8?B?bFcwWlZjb204cktoMCtWR1MybXdiYm9ITDY4NXlpdzNVdVo0T2tyZmx5enFP?=
 =?utf-8?B?WmhaVkh0Wjc3Wjd3am9za1lCcU50eVNtWm9mNTRKbmtxNm1LVTViai9KcGhW?=
 =?utf-8?B?YkxVeVl2SDJ4VDJTdFJpNm5vWWdDQmlFV0Q2T2k3MVhaVkMyUCtZVWFqeG9k?=
 =?utf-8?B?K01XYVFHVFQ2TzRWWm1ISW1IZmlBK0xpcnc0OUFWVTIrUWxvVDM2NkNyM2lX?=
 =?utf-8?B?OGRNczVlS2c5NERjN2VVTHFjMkxlazAwby81WkVjdWZITjJaczJuZEdLbkFz?=
 =?utf-8?B?VXMxM0dmY0pQNmFLN2dJRzVZUFA4b3ZJc0VrZlQ0dUl5ZWdnOFVGNExVSm94?=
 =?utf-8?B?eHQrQUJURVUvYmhqRGVlVENQc0p1bzFLbWx4QmJRMjJEMmJrS1hKYUlIbENJ?=
 =?utf-8?B?WUhFMTV6QmVEUGFkT1FIMFJsODdqT1FIQjFnMEE0TWd1SXNWYmxNcVpyQSt0?=
 =?utf-8?B?N1Q5WCtyVjFqc1ZBcHFrU2hrbU5PcHFLQmdLOXNBaHlLRFJVSDFZY3pJL2Zi?=
 =?utf-8?B?Nyt1L3EybFRJUjZRVXhSemxUZUpnbXM4KzR6eFhab09lMXp1RWwrTkl2OXc2?=
 =?utf-8?B?K0IxNHlSNHJVQjIzRkkvYSs3RjBCV0M5Q1htamdkNnJCQjlCTHpYVDRhN3hx?=
 =?utf-8?B?ZithSStrdzdIeUNHZzNZR0VockZtaXdvbXNremlVd1o1eUFsdkc2WDMwaHlH?=
 =?utf-8?B?bDFGakVZM0ExektKUG8vd2xYWWwrWXlwN1hHQ29yVlBTcWU2VmVzUzRXWUht?=
 =?utf-8?B?V3B5T0VnNzZFVU81ZkVNdGpJREg3YnYzcE5rdmY2MnBHYlM4WVZPaTVrQ2lV?=
 =?utf-8?B?bjRUYUIyZTB0ZjhXay95MjViQTdJcGpwVEE2Z1ZIcC9zd3IxRXdsb2phdzFh?=
 =?utf-8?B?Y3EvcGRBK3BmTVZKeWlTanBkczkyREpBb3gzTWUzakV1T09mMnFYWDdFdVZH?=
 =?utf-8?B?M3RsdDJPVTdKQi9CaEd1UWJiSUFPTU1KV0JQNEtGRzU5OFNLQWdMc0h0QjF1?=
 =?utf-8?B?Zm41TnN3bWkvUVNGSGw1U1YyQWFQVEQ0Qk9Sc3BIVG12ajd3bEE5RHV0UGFB?=
 =?utf-8?B?a0VhdGFnL1M2YnNEVVVTWTkzaVFBWlFuV1hiTGk2Unk4TXhKNkpIK3YvbGtV?=
 =?utf-8?B?ZnFOZ3FPMUl2MEpHSitqZFN3ZzFTRlJIN0VSNHROV0V3N3hyUmlFZFhwQkxY?=
 =?utf-8?B?Y2hTMmYwUGo4cGVZbW5IclVhejcwM1Q5aDI0dEdLaFRlM040ZW1oanRNMThC?=
 =?utf-8?B?b002enZHNEplV01oWm9IM0tEWXVvazZVbHk2V2c5MCsrc3FCeThFY2k5dnB1?=
 =?utf-8?B?MGFWVkxaR0k1Y0Ftc0dTREp3TnRRMkdiTXZ0U0QrN2xtTlZBMW1tNm1aMjJw?=
 =?utf-8?B?ZXNTTTJ0WHBIY3pqQ0F3N0VSWnBRZjYwV28vQi9CTnBhUUEzRmJ4UFFqWWxQ?=
 =?utf-8?B?WndYTGVZM1NDbzQvY2dRZzUvS3RJY0RqNVV0REJPQ21YN3lUdmZ1VzQyK01R?=
 =?utf-8?B?K3pod0t3dnZ0R3NXOGN1VFNidmRVMW5nQVR5TTd0TWNYWjVPOEdrWE4vOGpy?=
 =?utf-8?B?RGE1NW5EZkFDWEp0UkxwMTd0UEJzS0pZVVduckprdnJoTFBwSkppMHVQUWlx?=
 =?utf-8?B?SHJXaXZrVzV6cEpxZkI4WmkzK0plY0I0U2VPeWc4TFJUVEllK1d4Y0JHaWE3?=
 =?utf-8?B?bFBYWEt3NmlDZDF1VUxCMU41cHFIcWQ5Q2NSdVJSa2J4SVc3YWhrOGdSSDR1?=
 =?utf-8?B?dDk2eUFHcHQrYjVsZ3RjaVVKZGRKMmR1OEVaMkw2VHYzclh0Q2ZUb3RaemJI?=
 =?utf-8?B?enR3Mk9ZRjl0SEE1aGVKdGJiSng0cXRKUFJYdXZoM1Q3di9CUEJmYkhJM3Bu?=
 =?utf-8?B?bEwvdmorUHZIcEY1ZlFWZU0rSUp6MEJMcnJCUkMwbFREeWdVUXI5OUhIdVdu?=
 =?utf-8?B?amhiaDV4U1BncHdTSjNSNHRjcjhvd2ZPb1duWW5jSldsbEY3c2ZTSVArSCsv?=
 =?utf-8?Q?oemDQqhnM/b3Yke0=3D?=
X-Exchange-RoutingPolicyChecked: uzG/9v49tN1dmoWWYmSFJt6OOu6FJhlmT7uvYQjL+VUT3fl9vcq3MaGbT1KqH1ixNII+dRSO061UieAPe2XQc8Br75skJTVWTeoXogT7pzujz3YOQ/gBxWEwlsHqL3VtNFHNirXMUxMevsEb93J0o0iUpspYAGOemRc2upmkL7SqIjJ/3OWbSaQT1ct0AFvNA07YXaCyt/hYWXoJm6uyP7aXWKQtu5QVBR4f708+BuLkAVe1DWk9PL4+TEMBbjDIV+o1yVGaO428I9yIXqmADVuGJHFrUROwX/RmdfRvR1Uu828CenRFTrmKIIjR9+lpqYEoQZJJWxH4RnUlnEcizQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: b031010e-c4fd-4e74-247a-08df44b8d268
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 14:41:10.7264 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p7A7RcKeNyq7ak1TOwi+1mhIbu1LDIlfdh0LJ2kJUC5yBEyrFSlyOMc7G1bgKZRs/xs+fycJqwsIPq7JWM+vDLXod/vSSBQq8nmHTj2b4gM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5258
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/13/26 5:14 PM, Petr Oros wrote:
> ice_set_channels() and the mqprio path of ice_setup_tc() test
> cdev->adev before taking pf->adev_mutex and dereference it afterwards.
> ice_unplug_aux_dev() clears the pointer under the mutex from the
> service task, from ice_prepare_for_reset() and from the devlink RoCE
> and iWARP parameter handlers, none of which hold the RTNL lock, so the
> pointer can go away between the test and the device_lock() call.
> 
> Take pf->adev_mutex first and test the pointer under it. Without a
> device the mutex is released again and the rebuild runs unlocked as
> before.
> 
> Fixes: a6a0974aae42 ("ice: Prevent set_channel from changing queues while RDMA active")
> Fixes: 4b31fd4d77ff ("ice: Fix RDMA VSI removal during queue rebuild")
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
> v3:
> - rebased, Reviewed-by from Aleksandr
> 
> v2: https://lore.kernel.org/all/20261023070258.730168-2-poros@redhat.com/
> ---
>   drivers/net/ethernet/intel/ice/ice_ethtool.c | 22 +++++++++++++-------
>   drivers/net/ethernet/intel/ice/ice_main.c    | 22 +++++++++++++-------
>   2 files changed, 28 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> index 35dff5e937402d..910664b35b4d35 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> @@ -3888,6 +3888,7 @@ static int ice_vsi_set_dflt_rss_lut(struct ice_vsi *vsi, int req_rss_size)
>   static int ice_set_channels(struct net_device *dev, struct ethtool_channels *ch)
>   {
>   	struct ice_netdev_priv *np = netdev_priv(dev);
> +	struct auxiliary_device *adev = NULL;
>   	struct ice_vsi *vsi = np->vsi;
>   	struct ice_pf *pf = vsi->back;
>   	int new_rx = 0, new_tx = 0;
> @@ -3943,14 +3944,19 @@ static int ice_set_channels(struct net_device *dev, struct ethtool_channels *ch)
>   		return -EINVAL;
>   	}
>   
> -	if (pf->cdev_info && pf->cdev_info->adev) {
> +	if (pf->cdev_info) {
>   		mutex_lock(&pf->adev_mutex);

a small problem (less critical part of the last Medium issue raported by
Sashiko for the next patch) is that pf->cdev_info is changing while not
protected by adev_mutex, here we accidentally re-read it (instead of
keeping a variable), but overall it is a bad smell, would be nice to
have a wrapper that takes both locks, and only after the success callers
will deref the protected stuff

otherwise a pretty nice change! thank you for your continued effort!

> -		device_lock(&pf->cdev_info->adev->dev);
> -		locked = true;
> -		if (pf->cdev_info->adev->dev.driver) {
> -			netdev_err(dev, "Cannot change channels when RDMA is active\n");
> -			ret = -EBUSY;
> -			goto adev_unlock;
> +		adev = pf->cdev_info->adev;
> +		if (adev) {
> +			device_lock(&adev->dev);
> +			locked = true;
> +			if (adev->dev.driver) {
> +				netdev_err(dev, "Cannot change channels when RDMA is active\n");
> +				ret = -EBUSY;
> +				goto adev_unlock;
> +			}
> +		} else {
> +			mutex_unlock(&pf->adev_mutex);
>   		}
>   	}
>   
> @@ -3966,7 +3972,7 @@ static int ice_set_channels(struct net_device *dev, struct ethtool_channels *ch)
>   
>   adev_unlock:
>   	if (locked) {
> -		device_unlock(&pf->cdev_info->adev->dev);
> +		device_unlock(&adev->dev);
>   		mutex_unlock(&pf->adev_mutex);
>   	}
>   	return ret;
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index 1c6e85f3388668..1cc481ba4ca5f0 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -9538,6 +9538,7 @@ ice_setup_tc(struct net_device *netdev, enum tc_setup_type type,
>   	struct ice_netdev_priv *np = netdev_priv(netdev);
>   	enum flow_block_binder_type binder_type;
>   	struct iidc_rdma_core_dev_info *cdev;
> +	struct auxiliary_device *adev = NULL;
>   	struct ice_pf *pf = np->vsi->back;
>   	flow_setup_cb_t *flower_handler;
>   	bool locked = false;
> @@ -9570,14 +9571,19 @@ ice_setup_tc(struct net_device *netdev, enum tc_setup_type type,
>   		}
>   
>   		cdev = pf->cdev_info;
> -		if (cdev && cdev->adev) {
> +		if (cdev) {
>   			mutex_lock(&pf->adev_mutex);
> -			device_lock(&cdev->adev->dev);
> -			locked = true;
> -			if (cdev->adev->dev.driver) {
> -				netdev_err(netdev, "Cannot change qdisc when RDMA is active\n");
> -				err = -EBUSY;
> -				goto adev_unlock;
> +			adev = cdev->adev;
> +			if (adev) {
> +				device_lock(&adev->dev);
> +				locked = true;
> +				if (adev->dev.driver) {
> +					netdev_err(netdev, "Cannot change qdisc when RDMA is active\n");
> +					err = -EBUSY;
> +					goto adev_unlock;
> +				}
> +			} else {
> +				mutex_unlock(&pf->adev_mutex);
>   			}
>   		}
>   
> @@ -9586,7 +9592,7 @@ ice_setup_tc(struct net_device *netdev, enum tc_setup_type type,
>   
>   adev_unlock:
>   		if (locked) {
> -			device_unlock(&cdev->adev->dev);
> +			device_unlock(&adev->dev);
>   			mutex_unlock(&pf->adev_mutex);
>   		}
>   		return err;

