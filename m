Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8A6606A31C
	for <intel-wired-lan@archiver.kernel.org>; Sun,  8 Nov 2026 20:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=elnepTJo;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OWAt14sf
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 54B9F605F8;
	Sun,  8 Nov 2026 20:01:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y7R42cn7090d; Sun,  8 Nov 2026 20:01:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8085C605FD
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794168063;
	b=HuDoceg5ErLpfGWTw53ajcu3ohLRN8U9rymJYUdpHVBNmIqgyRgeEwRlq+UG6dhIRRAS
	 Y7KXLtLrIsAcz8sJ6C0IHKG9wyV+ksEm/8OGILfNW6LDwnMS24QfBmei+ymA1LoKCjhcz
	 FLCBROr3T3DrZ2fLrjhtPsusl6FlhDmhKGaD+Fh+oAmmGsj+NABuVJJnL/hdQpAYIREUQ
	 xLOORhjzEcub04fElqDhkSmOlx8L+k0827i2bb4PstwmZzWZePR3SxxATQdIBTPN5Zpct
	 gwGLmLp5RMiocKFkpJk2qP/3PHCgA07LuZeyoVkr3RknjzVaDVO5Z+ew1hszyT3frww==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794168063;
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
	bh=90DFUXC4MZMU0+y6Jh/Ecf4DAfZ0klGUxykydAJHhAI=;
	b=P5QJwzdr7NvGPLyxNYc5akMtKUnmuR2XNiKjuqvTGzcof0xs1cc1ote0JDO2HKUYgRuW
	 FMKF7JtndtoHiAY7IX1GlEGFVI5zbN0B4oEnDxW0nx1Z0AWS4hWvhw9sAJxw/Taat0gAz
	 ow7UClrM5/mghHPzGueFCLVZm7SNcUiVxiLnqdpzXRISP9e2stV37gSwd3ZehKH59K0XD
	 o/G4zB+xU0jsJ872c0aPpPu3AVRV7gQdIS6N7N/VsMwYvURHSdlksS/xQ9T+mxK1WnHHp
	 ZmYvijcyoUcfDTVrSDkM1nILbDudqWEZvg+4AjhscEes47dIBwW542QlRd+YI8XlGJg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794168063;
	bh=90DFUXC4MZMU0+y6Jh/Ecf4DAfZ0klGUxykydAJHhAI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=elnepTJoL8SeEnfJaIn4kyZmS3UhmfO01p9Ur4ZtxxyCXFbCEX/YYVtloLZdFaDcl
	 sm6yOOpnoFqKtF44/57+Ny4QeddeLm77kR8XBNJrr/AfOfT5v6YgqECwi6vurxrdPF
	 JGrEY7ocnKAMwOIx+c/Flmy4Hm489fW2EZRzlGUAYoiRv0AoJPUMPOLjH9H5QhX425
	 CznSaRC8r9X0dEdd/dXwuraVonGqQJArLnurBzHbKd3P4M7lYfIcU41fpzIW2yVA86
	 vjEDgypP5j6APFYxocdh8YTiH10MXjLM5EqWm3XnPnoFQhpqxUQ38Onv8WKu7kWXm/
	 2lEOlkzuxTe5g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8085C605FD;
	Sun,  8 Nov 2026 20:01:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E91C2317
 for <intel-wired-lan@lists.osuosl.org>; Sun,  8 Nov 2026 20:01:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DA9E940111
 for <intel-wired-lan@lists.osuosl.org>; Sun,  8 Nov 2026 20:01:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ugmXSY42-TdB for <intel-wired-lan@lists.osuosl.org>;
 Sun,  8 Nov 2026 20:01:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E6CFF400FB
Authentication-Results: smtp2.osuosl.org;
 arc=fail smtp.remote-ip=192.198.163.19
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.19;
 helo=mgamail.intel.com; envelope-from=dima.ruinskiy@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=OWAt14sf
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E6CFF400FB
 for <intel-wired-lan@lists.osuosl.org>; Sun,  8 Nov 2026 20:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794168061; x=1825704061;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=WfQyNWa5LOTrOKhLueOl/q8lrGyCftUxpdYfJtS3gNU=;
 b=OWAt14sffNHSvAHOZf/pmvSV9LTexHEAsjVt82uACla93rdZAZsaBEqg
 /FemhonM8AxUfzv0okMm+QzE21RdMezfZXPS+7H6BaZy5k3/AFbTaR5AL
 fJVUNmxjs7OP71RitZS4lEvwhNFUUzbYxngq4wXTeTAfjD0ouc70MGv+Z
 Nvvlzbt2vQPfswWY4P+aAapLnbEz7oU4FxlU3jhwlwrYoUtovBiMAUgfF
 lgl30CxwqEsfPW2n7OrPGwNx/+YMnwYe3RxcBZNmHFSnRQnsiNXUWvvYG
 UXBmMofIhCKk3oF5i41qH+iKPU+aiBW9DtEsEMfa2V6qXriwBGmUu7z7S w==;
X-CSE-ConnectionGUID: SaQ8FtMYRHuUjDONQ3uqOg==
X-CSE-MsgGUID: 4yjixtvDRgikrpOH+Zezog==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="3003706"
X-IronPort-AV: E=Sophos;i="6.27,202,1787036400"; 
   d="scan'208";a="3003706"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Nov 2026 12:01:00 -0800
X-CSE-ConnectionGUID: fg8oGKUeRYaAKVri2z6XmA==
X-CSE-MsgGUID: 2cf1Vxu8SBij/wB+4hjJtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,202,1787036400"; 
   d="scan'208";a="9480478"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Nov 2026 12:01:00 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sun, 8 Nov 2026 12:00:59 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Sun, 8 Nov 2026 12:00:59 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.62) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sun, 8 Nov 2026 12:00:58 -0800
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5630.namprd11.prod.outlook.com (2603:10b6:a03:3bb::6)
 by DS4PPF990BCE628.namprd11.prod.outlook.com (2603:10b6:f:fc02::3d)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Sun, 8 Nov
 2026 20:00:50 +0000
Received: from SJ0PR11MB5630.namprd11.prod.outlook.com
 ([fe80::79de:af84:3b43:84e3]) by SJ0PR11MB5630.namprd11.prod.outlook.com
 ([fe80::79de:af84:3b43:84e3%4]) with mapi id 15.21.0592.010; Sun, 8 Nov 2026
 20:00:49 +0000
Message-ID: <f7a42b9a-0c1a-4d1e-a908-512616ca65a0@intel.com>
Date: Sun, 8 Nov 2026 22:00:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [e1000e] Intel I219-LM host becomes unreachable
 under VM network load when AMT SOL/IDER is active
To: Viktor Donner <vikdon@gmx.com>, <anthony.l.nguyen@intel.com>,
 <przemyslaw.kitszel@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>
References: <1dbf956a-e981-4b2a-ab5e-ddbd5905663c@gmx.com>
 <46dde8c9-1d39-40d1-b1d0-973d274fffc8@intel.com>
 <e6e1722b-a36b-4784-b763-0d7bae8945fb@gmx.com>
Content-Language: en-US
From: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>
In-Reply-To: <e6e1722b-a36b-4784-b763-0d7bae8945fb@gmx.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0006.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::6)
 To SJ0PR11MB5630.namprd11.prod.outlook.com
 (2603:10b6:a03:3bb::6)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5630:EE_|DS4PPF990BCE628:EE_
X-MS-Office365-Filtering-Correlation-Id: 8133561b-db86-4e07-96ea-08df3dd2fc4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|11063799006|4143699003|56012099006|261021135927099003|261021121427099003|261022105027099003|261022075727099003|261026140227099003|261026121527099003|261028144727099003|261102123227099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 6Rx3DmC7NH9Biczazu8caL38W4zu0OuJ/1hlnF+WsGUTAQ+b2z6fdXZpHX6aiRIIRa1W6z5zAQKx+8E+5tsO/K55YbpefarnbmgbxuEbREVy6omx2bgzQaIdppKD6yeLTG/vQV24tbauv3YLvR3IFWaXfGYQE8bX2gKzOpijsusB5DaWOdnVAW9crY0AAkgBedLpVneiVxeStjy1JKBVNKTs6eC5VtH1HSVevQwTibXgC3j9ILV2CD07EqHGvo8xCcXBKpsLCle4+SDi+vKlP1tKv106nKi134lDIljzQHo3oFTKoBFoA61Sn0t12i8ahWeewgnNmc6W6vg/u+QmMw55wbO5WQ3e9jwmYQfiFK9OeyUeALNG+SAjbTFMEwz7t0RGXOfhYknQm02QNSUOLv3ldqlpjnhSj/LOKYQBlxc6IKBZ+RLgB0FU1ocqPjl42fuNQDWXqQIHxO14PkGY/h/huSl4mx1eLZhoPx2tOySOwzxr9e63Ro37i+MCukovHie+2J2p7qGC4g/Qu0R7Knb9PHz6ZUGla3Yy9rQYijAqA6biFeM0T5qGVnStBCKuGI1Fz6Vb2mqYLxBCulxOgO5e/OXaJmKBdHHldaTGPLf5FWD5MwCJhYUcxstPQWO2xgTWug3LVr0E3EiiAN5QZoZSoxebf/uqJJkYS/3h+IA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB5630.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(11063799006)(4143699003)(56012099006)(261021135927099003)(261021121427099003)(261022105027099003)(261022075727099003)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUl6TGs4eFFHaEpBWFp0OEozTWtscWV0elJUbGhWQ3R0M0pYdUMyS2VHeUs1?=
 =?utf-8?B?ZTA0UmNwT2dXcGxCN2FrQUFNMFVXa0RmNDdMdUpVRGhIQTBJSGZEdEF3NXdF?=
 =?utf-8?B?YVlya3gzY2VBU3JIRi9mdkhxTktFN1FGcitUTzFIVmErc3JMZ2lyaHQzNS9Q?=
 =?utf-8?B?MUV5aElhMzIzU3B4SjFtUUVkU3kzV3R4ek1KOFVRYnZ3Y2FkVllGMlhZNHhI?=
 =?utf-8?B?V0s4a2NVVEt4Yll5Y1RGeHBqbDZwTVpqODZ5dHk1Z05WU3dqRDZ2WVd1YjZB?=
 =?utf-8?B?RE9idnhLdnpjcU4xTkExT0lTYnpBWlNaa1F4ZWZrcWoxK2FleEJYdU50aEhZ?=
 =?utf-8?B?MVQrQzlaSk83SWhqdDMySjZHK0k5SmNRMW01dEQ1bUNxOVVDQW1Ya1FsMnV6?=
 =?utf-8?B?anBxbWVxT3ArWEZsaXErUGxmY1gzTHZ6ejhmZXFVMEs5MlB0L1FLa0RSZjJJ?=
 =?utf-8?B?cEFwcTRZVnBaM1dYWTZEcWVGWDV4UkV4RmhLWDlteGJRSGpGK2lycEtrbEJy?=
 =?utf-8?B?WlI2Y0ttVTdJTnEycjB6MnRKbmtFSTUydGZjNXRYaWZlTnRxWnBseXUxQTBp?=
 =?utf-8?B?L1hNUzZOVjZpMlFhdDZLOGFNQjVQNUQ3TDM0V3pzUlRCVkloZEZkOTBUMWM2?=
 =?utf-8?B?WWRyd1I3TDlEb1ZhOXVGR2doNjA4NDlvNnB5c2pPQUN2ejlmRXNJUTNESkhT?=
 =?utf-8?B?Ui9XK3grOC90L0ZTVnpWQ2ozVHdFdEpLSm42OVlWU3NnS2d6VGMyb0ZvK1dF?=
 =?utf-8?B?c05NWHlrbmx0T3VLSGM4b3VURnowczFWUUF4TndKQUlMa0NBUGNVdlpyWHEy?=
 =?utf-8?B?MmFOZzlxSnlEMTlsNWc0c1d0Zy96RFY5Zkg2by9wNjVocXh1aDNWei9wbzhX?=
 =?utf-8?B?ZjZGaVJXY3ZRN2xMNFh5WnYyQ1JodG90NHVWUWVRdSszT3hIQ25UenpCandP?=
 =?utf-8?B?TVJzMXpkTEdTd09oN3AzbytTT1FEZGFaS0R4VDJ1U3NIY1g0ZEkxS1VVTTNk?=
 =?utf-8?B?VzAxdmpBaElVN2VNeTZpN2JaUHB2U0ZmMktGTGQyU29TMzhsNmNpc0lVaW5B?=
 =?utf-8?B?bitoY2JOZmFtYnhJL2dUQTlzRU5kOXFSMjF0K1AzOEpXdzltc05ESm1nb3VZ?=
 =?utf-8?B?VXd0OGRxQVI5ODJKK3htRGZhNnJ6YVFYYnZzRWVpVkdaSkNDWXlVMkVsSDNN?=
 =?utf-8?B?QTZEK0tVR0lOVkNiT1FXSUJLVEVqeHBmNGZ0YnpYL0dURUdOZm9obXRLSjBa?=
 =?utf-8?B?Zm54RjBQTGtRRGNZVU4zYXJIQ2NLMzN2WFIxM1FZRUNMZDJTMkEvVXFlQmE2?=
 =?utf-8?B?ZGs3U2xHaHIyQkpYaWxISTNpQStGbUNiWEJZckYwaGlTNUtJNWNzdFBXRG5J?=
 =?utf-8?B?djlZcnpyRHBKT2t1NTBmaHR6Z1hkWit2dkY3M0VsbjJMKzVXaFVCaXZjdUxt?=
 =?utf-8?B?dXJaVEN2NlRrWTVOaWgrem9wQkFpSVNsTGwwcWgwT0g0WDRieEJGdVlpOXVP?=
 =?utf-8?B?UnNqL3BQVFN6SW9FOG82bEdvNUFwa0NyREd5YjZQN21qZXc2cUtOcHN1WHNn?=
 =?utf-8?B?NU9RVm1HRG9WUFl1WXEwMGhGNHovcm05amVMblhGL0lDZVlLckQ1VjZSY3JT?=
 =?utf-8?B?SHNqVVhMOHM2bXZDQkhOYXMvTXJGYnNhWVQ4bEd1b2lYYzBKYXR2K1VwRnFY?=
 =?utf-8?B?b0sxdnpKb2dNWEYzMEVwaUF4d255WnJlM0dCcmNjOEdaMVEzZkRJTnc5Mmh1?=
 =?utf-8?B?MFVraVN5VlErcVBYRW9UZnVCbzF1MVVsUG5UTytVOThWZTFWSkFqV1Y3R0Zq?=
 =?utf-8?B?cjVaTllPY2lCOGxWU3FJMzF5NWhXai9XVktzbHFKNCs3R1ZwSW01MDg0Ri8w?=
 =?utf-8?B?QmZoZ1JzaEJOc25VUzNEZE1QWC9PV00vTzh6SWh0U01QcUdIU1Nlb0lkV2o0?=
 =?utf-8?B?Smp3djRxL29IK3AweTk0M3MvT21pamwzTlh6eXV6Zk5EeGJVTkhqWDdMSXFX?=
 =?utf-8?B?MFZ0Y0N1WmVBR1pHb0JyOWMwemZzWW1kWWhkMDRnVGJSa3FEakRKVytLcHZ4?=
 =?utf-8?B?R2E4NWE3MmZDRkpaMlN4UW43NUdHMi9NeExrMVJGM3VtVU9NcStNUVdBdGxB?=
 =?utf-8?B?WHFjRkRROGNSVlBkNnFvRDlyZm9lNkZYRnVWbHh5SmIvaEtVZm1IbTJyVXZL?=
 =?utf-8?B?a0dJMllPNjdNdWR3SUx3c2hhOHV6VW1YRHhEemdoSzVtclBlRTY4SDJPaGFR?=
 =?utf-8?B?eXhZZlA4eThGTGliZDZIV1ZPTGFJa1YwdjFkNlNyNXFJRW83MnZjWndEQjJP?=
 =?utf-8?B?eDFrWWQ5VnNnRG1Kb2x4blh5NWJVaFdML1pNRmo4azBtQzh2QTIyQT09?=
X-Exchange-RoutingPolicyChecked: K2vFj31hABZmNJJ6ySpVQWPm/TaqOjPQpnSJcQKE8H+gtATmQaDEGoqeN+4AU9njoZGCE3M3yLvPr6UAZHByImig/aK2UMrsbggh5db9UblCbXQKWDtrPjAiN/zlnPc4exdNUC0S2N0LccdrC22jpzk2twb3sRGk8XxBXju5+HUhqmvZLBuzQUYOA1V6kYTiLZY5Tw91DIfzvmJ4o6sCTRUgyHwNnjrPXMN+h9jKxmbSjQhR4yFEGO325pwGoTFgB1lZ5MSH8Vumse5sDkrtDCIcPGgt/22AywgxJtlV49lSPmTNXfYYJpnZzGrZDS9J1aV4gDbMjZHZAYCUTeMVMw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8133561b-db86-4e07-96ea-08df3dd2fc4b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5630.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2026 20:00:49.8044 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4EYtXreGQZn3/GzqdBWEz8sGJM2koliCIMbFxJx+rTdKmeJd2vZqJBBtnJ0iVJ1BiBT9miBgwUWpxLhA1/6H0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF990BCE628
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
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 15/09/2026 23:32, Viktor Donner wrote:
> |Hi, I reproduced the issue again after a clean Proxmox VE installation. 
> Updated environment: - Proxmox VE: 9.2.20 - Kernel: 7.0.14-17-pve - NIC: 
> Intel I219-LM - Driver: e1000e - Firmware: 0.4-4 During the failure: - 
> nic0 remained UP and LOWER_UP - link remained detected at 1000 Mb/s/full 
> duplex - the ARP/neighbour entry for the gateway 192.168.1.10 changed to 
> FAILED - ping returned "Destination Host Unreachable" from the host - 
> rx_missed_errors reached 14867 - rx_errors, tx_errors, CRC, frame, 
> carrier and timeout counters remained zero - the kernel log contained no 
> e1000e Tx hang, watchdog, reset or register dump Bringing nic0 down and 
> up, running ifreload, and flushing the neighbour table restored 
> connectivity without rebooting. I then disabled the following offloads: 
> ethtool -K nic0 tso off gso off gro off After that, several speed tests 
> completed successfully and rx_missed_errors did not increase. This 
> appears reproducible with offloads enabled and is mitigated by disabling 
> them. Please let me know whether testing TSO, GSO and GRO individually, 
> or collecting any specific e1000e trace/debug data, would be useful. 
> Regards, Viktor|

Hi Viktor,

Sorry for only replying now. This mail arrived while I was away on 
vacation, and almost got lost in my mailbox.

Would it be possible for you to enable netif_msg_hw so that 
e1000e_dump() prints detailed info when a hang is detected?

I think you can do it via ethtool or module_param.

Additionally, the global system log level may need to be raised to cover 
KERN_INFO.

--Dima
