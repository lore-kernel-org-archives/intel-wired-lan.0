Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533AD606A31A
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Nov 2026 19:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=wfwK5Vmy;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QkfcUM5y;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=bqokImx9
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2E43B405B6;
	Mon, 23 Nov 2026 19:04:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fFy1OOXaFnXg; Mon, 23 Nov 2026 19:04:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E6B76405AC
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795460684;
	b=S7xorEawryurm57C4tjHxiz6WvXsQd7Bc3GLQD5o7fyG0fISfvFAnRcy+RKhINKVIoCM
	 fnp2nuvRi14migS5oPvZJLu+PjkznHTFy4Ro9vJGfnvQY/qsJZS+8G9wI+S4uyve7JedC
	 A9t7Imfm8YOJgptDlIR2KXlj6F8ehawM3FhzBmJEOnm7klueOLQzrmeputmnJX88ONycz
	 yZ67d85ASkHvAZqzDxus2xWSUJ3hS0CclIRXQT2b53ll02Jy1ZRV/nczwBv/eVC+WR2KE
	 o7cxMrVGjJ7SQlIhRpwMHFcsnUaVW8cg2KsFSoKjTFUNv+MMrloh7Ac/PzAdNfgOlnw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795460684;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=GiixTGsozKKtrZUE2IQYfLTgVUIwhRTW5DxtWJSy0/g=;
	b=R4JAd3yNV/HRiuy9HyEEX6eVLAOwxIEgb5+MWTzkOeflLnoTYJX84hak+9W/zQcLqEhn
	 dmUJhY030GXEX5VkYJyhOYFV+9NUc/xQRUXtvh5OPY+NQD66/4qvm26j47ypOaWTQYzHY
	 kgKzrGxmnBKRns1CuhZFj1jcvoHE0Ie/GCoUZ/aeLPt6tqFbEpgbH57Vj6FPnMxwWA9/a
	 zu2UQsXwJqTWkgwXpWiVLMkfF8QC6hQUasLIfAHdbeQdtDokmo+p2K8C9yKDjxka3Kdm1
	 R64Jv3g2qDcoTKlOy4rVM1bpgA2HiPYRAsIN4+qSg8ZBp/3AI1FThMJsjXJi+MKZ9Rg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795460684;
	bh=GiixTGsozKKtrZUE2IQYfLTgVUIwhRTW5DxtWJSy0/g=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wfwK5Vmye/nYK6ODbzbRoPoKFxtwrzL/caN4j92yhb2bI7OdhNBLu5gOqk/unfc65
	 YkMxqxJJZQNSaYIOgx73J9+NxMpaBk4bXaxBTDt0jMwj5oz79jQ4VL1nX8PAlyQRX7
	 XAVmLOMZhTlYswtDA+9mVeOooDSTVrqrLcR2vkCODWEbScsVqRHdiG6Cx35gX7S24K
	 66qNwBcY9qV1DNpuG4hThcu3KC1n5KFeTyvEFkghDYfOgv4IbVK5j6D9CGVdXtSZrD
	 d6QcBHn0axANSNMTde2hO5MPo07BE75btJbwGBAdA9IbJRkKwgD0Jw42LXWlT7ByXN
	 40Id01pJGqcvA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E6B76405AC;
	Mon, 23 Nov 2026 19:04:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 750EF22B
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 19:04:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 65C4880E3A
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 19:04:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TQtoa2SwiuBM for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Nov 2026 19:04:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B473880E29
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.12
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.12;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=QkfcUM5y; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=bqokImx9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B473880E29
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 19:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795460681; x=1826996681;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=T7U8ItOnULhNFZZbRb91nLGfISUwLWjZczPHC+dKvYE=;
 b=QkfcUM5yhrWQEYctywA4lY7yFj1j/C1c1wsqihXYQ5Uw/FEu/oLYfrKA
 haL3h4vFrJktmC+Krej2SH1rLxdva7AnQmz9zAmMc1fUsFKn0xtJJMRu2
 meLkYUBXp5oCgMnDcHXxSjJMV/SDlsdVHk1qikB6fODLLTNbtHkGui0Di
 uHXAdtbq1YAy/g6vJJAjaVN4cTaNmc0uGHWjfWmfoT4X39s/dqRekY5V6
 BPRQ7j05EuBLmNIeV0eBRm8VtBlXAy13plY6jB9GmmMpxrZjX6sjG7ram
 TYL+UBdTxqMmtZVqQtSg8PUYRQiqxcNy/OaMSyJ7CZQMtMko5Ezx92swf g==;
X-CSE-ConnectionGUID: HZyJlHJRSEuquV6T6/Auzg==
X-CSE-MsgGUID: 142fzfP3TyCQWHcXiVnG9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4157431"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4157431"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 11:04:39 -0800
X-CSE-ConnectionGUID: s8Uj/2igSYWa/ToVdsibSw==
X-CSE-MsgGUID: BrKOs//QTH6op7stziRECg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; d="scan'208";a="13158377"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 11:04:40 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 11:04:38 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Mon, 23 Nov 2026 11:04:38 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.56) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 23 Nov 2026 11:04:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GiixTGsozKKtrZUE2IQYfLTgVUIwhRTW5DxtWJSy0/g=;
 b=bqokImx9KeUfoGh0AI9yTmrm+o33Pfyj8FLtbWTO60A5wra1oeOke3vYtikiD3AxPKb6h6IBEkdgjlcn8/3fNK7jFHawpprUz7IDHhK375hmlxOqUHj1mmViKEmhq9rs2TJMM2H4kLfZkehKWX2Sh29Gythn4dm/x4PiZBfEbBg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8451.namprd11.prod.outlook.com (2603:10b6:a03:56e::20)
 by SJ0PR11MB5197.namprd11.prod.outlook.com (2603:10b6:a03:2d1::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 19:04:36 +0000
Received: from SJ2PR11MB8451.namprd11.prod.outlook.com
 ([fe80::7d5f:b2ba:92d4:5f3c]) by SJ2PR11MB8451.namprd11.prod.outlook.com
 ([fe80::7d5f:b2ba:92d4:5f3c%4]) with mapi id 15.21.0639.011; Mon, 23 Nov 2026
 19:04:36 +0000
Message-ID: <7864ad35-402b-4ae8-b470-ac6e9a81ac8e@intel.com>
Date: Mon, 23 Nov 2026 11:04:34 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net] ice: fix stale cached PHC time after a time step
To: "Korba, Przemyslaw" <przemyslaw.korba@intel.com>
CC: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, "Nguyen, Anthony
 L" <anthony.l.nguyen@intel.com>, "Kubalewski, Arkadiusz"
 <arkadiusz.kubalewski@intel.com>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, "Ilichev, Konstantin"
 <konstantin.ilichev@intel.com>, "Olech, Milena" <milena.olech@intel.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
References: <20261112102301.342584-2-przemyslaw.korba@intel.com>
 <6fa3928e-90f2-42d3-86c6-ddc5492b51ea@intel.com>
 <PH0PR11MB4904B8854B7457816C72D4A894452@PH0PR11MB4904.namprd11.prod.outlook.com>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <PH0PR11MB4904B8854B7457816C72D4A894452@PH0PR11MB4904.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P221CA0024.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::29) To SJ2PR11MB8451.namprd11.prod.outlook.com
 (2603:10b6:a03:56e::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8451:EE_|SJ0PR11MB5197:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e376612-85cd-445a-618b-08df49949dcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|10067099003|5023799004|11063799006|4143699003|261026121527099003|261026140227099003|261022105027099003|261022075727099003|261021123027099003|261028144727099003|261021121427099003|261102123227099003|56012099006|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: j3NmvrL8ajG5RmUOgy9e9+4P9mjHijNSUbkYwgJYEvfgdpC4hNCY/zyRNoPj0voDW/H2OaZBjaqosT41z6GHLXP/tdaMsUMqIiE5CZ4W3Y1zQ60GXMbTQh35ZZwKbDq0ESxM42MV4fOz+GuOrGteLSyhjNczRxZiCxnRE6JVF4O95u5B0A3GYcJVPzAwIg9d2lJAjELrfzBESKhCD2eRplqE+x3ZsAtZvsTyDPVrW57tEjL5uwlNNpLQC42XIJEaJfOk+I8GdqQL3zeKPcqrqZrWq3/RA2L5nclE5vze+5bcwUEIyRktS9QhqjVtJP41Dq0oTPv5kpEINmttHyHbCVxszZ7dyoRePD50vgwxsQXrtJKO9xZBruOOrT/P3QmlS7HGdN3OMVdbywLk+iVPM+3gG2tNbtKiI5jQAnToxssYSieo32Dh4iO3Jx0rGOBdlSFEpiQjQ1Dw1jgho2PCcIRtdS4S+JdRomGmp+xdlVO3jdhuxWfv2GDbC0TUUrj8yU5GDyfFlPHgzWs7rNuxhgKIIoU/0UFEpb18TjHshbl7LqiEKmh51xV8uICgrI4MObUWxXhZ2eMyo3IXwMqyD7Ll3sPHpU4cEWBrpBH9JV0wWgOeGcfwjrf71s8+PKoB8vzc6X+p8IEEOcdkeVi/IPv6hxYNsYMped+wpruZtOU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR11MB8451.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(5023799004)(11063799006)(4143699003)(261026121527099003)(261026140227099003)(261022105027099003)(261022075727099003)(261021123027099003)(261028144727099003)(261021121427099003)(261102123227099003)(56012099006)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXo0RzhUYjZmLzNGcHlnNFRkVmg0ci9SSSswekdaS2ptQjhHQUNaMmNZaFNu?=
 =?utf-8?B?dmxMNEZSODJVVVhqendNRWRxRGc1enJubzNTWVQ1WjVqT0R1MmFCS1ovZVVz?=
 =?utf-8?B?c010cUQxdFZvUDg2czFVT04zdVo4TE1xdkZtckZvYTZnMzFhL1MxNWYzRHhH?=
 =?utf-8?B?alV2T0dnendUdHdndW9DT280V0g5bFl6VkZQdVdrZkpqV3N5R1N6cjhSbHFn?=
 =?utf-8?B?anBRR2gvdnhGbWxMSVlPYlZxZ3FmeWxJNW50MFVtcTFjem9vUFVPaWx1NGl2?=
 =?utf-8?B?VHVRa1R4ZjMxakhlVWE4T2hEQTUrS3NVYVl4dnZ6NEc1Y1VsMUUxNGxFb0Iw?=
 =?utf-8?B?ZmFVQm9kb1VHblIza2xieDRHZUpScmZaS2gxamY0cUcrUHZRTUpIaDJkbTEr?=
 =?utf-8?B?WXpPZlUrbksxQW9QZ2wwaDJOeGxDR2liNlQvUllnc2Q1SG1KdS9MZmU5RzBP?=
 =?utf-8?B?bElQWGtpMDdRT1FqTmdwSWFuVGNjZXl6WFJYSC9WTncxMXBPcTBpak5rYUFY?=
 =?utf-8?B?bTNGT0RORGkveXBUeU9MV1k5cHlQSG10Wm1pNkt4alErdHBUZjdlYmhJcXA4?=
 =?utf-8?B?UVhGS3pSekl4YjkzeWtmYUF3TmRlZzV4SVBNUGRZMWVWR1FkQzd6RXVxeWUw?=
 =?utf-8?B?TWJFeUUrakRTS0kvTW5hNkJyWjdKZVlWRHpub1RnUHdYZUNsczRZRTJrZEVt?=
 =?utf-8?B?QzVFQTJMbzFBVkd1NFNZTnR0Qk9nNkhYNkJaKzdJcURGcExSTHJ1VlBMUnV2?=
 =?utf-8?B?RkNZeFRIeUMyQnhWa2F3b2phV0E1UXBheU9XYkVORHJwZjFzTVNhVkMwQkNC?=
 =?utf-8?B?SDJoWFlYazZ0Wjdqellidk8zOU5Sd21QTW14NnY4a09ieVVJOXpjMVJ4YkNW?=
 =?utf-8?B?OUlXdEF4cmtEVFZOTWp1dUJSOWozNjBvcGhTRGVXL2NKSTBYUVNyL0dla0h2?=
 =?utf-8?B?MGRxZThRVVF2L0U3TlNpUHpxVG93QXhqUHR1eCtnWHBOTWtaM2VUbTNSamZQ?=
 =?utf-8?B?dVhVc2c1RkV0N2FmdktqVUIyeVJ4OXpmbkVXNjg3d2l5SmZoVVlnVGxTa3BZ?=
 =?utf-8?B?bGQrdWhLWXAxME1YeWxBYVRZY0JwWXQzU2E4VDJKSzFkWjdkam0rTW9CNUxE?=
 =?utf-8?B?Z0pPenBUQVkvVmdIQ29aMEZIVEdzb3hVQm56cTQ2VW12YXFBYjllSFZNaWdW?=
 =?utf-8?B?eGY5UjFlaWFUdmMvbmt5SitVSHltayt4VEpGcHJqZDN5bDN2bHgvNTkxQnZS?=
 =?utf-8?B?SU9nZEw4cVdrOUJ2bFEyWlgxS0syaXRldU5mZ0d5ckJUZHFabU9palpsVDhR?=
 =?utf-8?B?WnRCOWgwcFVxRFZ6QXRPUFlnazIvZTR3YkdpOHd0dk5mVXRxeTFvYm8wd2d3?=
 =?utf-8?B?UFNDRTVuMzZ4VldpUWNFSFVtZDQxdzJyRHkvZGNFcVZtZ0pjejNKWnhYTVZY?=
 =?utf-8?B?cjlrK3dKNVJyeXhyUjZiTlU1cy9ZMk9PeU5qMzc1N0VJRzZnZm5yaXBFcDJx?=
 =?utf-8?B?UTV1bi9BTkR5cmxjOTQrblVnV0pMempUcmRud1pid3lzS2lISTE1TXFwaGdp?=
 =?utf-8?B?L0k1TVZ3dFJJRm5iWTduU3FzL2R4citOTkZUWUhPMmwzZm9HNFdBOGZKakM3?=
 =?utf-8?B?Ni9MUi9BTFhOb1RtczdpSFlKU3NrV3NiQjA3YUxnem5TcXIrdjNDQ3k2dUtE?=
 =?utf-8?B?d0JEd0hzUlhSby9OWng2VEE4c1RjZXMzOGQzM0x3RDJ3aG9lZktEYlE1bmtZ?=
 =?utf-8?B?eDcxWGJrNXYzU2Jxek5xTEFlZ2I5ZEpLc2IzVk53NDJreWloNDRubU9seVNY?=
 =?utf-8?B?U3NNelZFeDdhaU42QmVlT29ldEZlbVlxblBtK0FjcS9KRG1SUDFpSDVkMWlQ?=
 =?utf-8?B?VkZRTzF0UWZCblZWZDF6ckJkeUpCNkQwYVppSGRVSFpuNGF3bTZSUGNUZFZa?=
 =?utf-8?B?N2tkNmMzeGJZVTZVK0RNS25kdmRUUmNQNEdGUXZVMUo2Z1VvdlM4N05mVjl4?=
 =?utf-8?B?d0V2UTNBeHRkeTYwTUs4bEMzemJUQkc2QlV5eDNyYTBESTdwNXdjTnd1UXQw?=
 =?utf-8?B?eUc5Ni9nVE4yblRxTklZTHVhT2tzcG5KakFMUExacUt3MDMrWktvVWs2d1oy?=
 =?utf-8?B?YVJWVlNjaHFEdU9DTzBDa01nTExSVCtscmVKa2h3QkIwQUR4eW5YTjFIZDdV?=
 =?utf-8?B?YmpZaU04d1M1aSs5VmI2UTZsUUhKZFJRNEIvMFBIdFB2VEFHMlhrbXRYYmd4?=
 =?utf-8?B?cjYxR0JDbnA3eUZaSURuK2o3VTZ1aVZjeE9nT1Zjdy9vZ09wL2pRVlE1bnZM?=
 =?utf-8?B?Y2swd3pDRGhpVFZvNG5nRm5EVEVwY0xxMjBXSWVUaXRqVWw3Q2FHRS9LeVFh?=
 =?utf-8?Q?6J6GEbw3RSdAQ4Zo=3D?=
X-Exchange-RoutingPolicyChecked: mDL8SZb2E17xpRAEEbA+hnX0GZFYusPM21SFlLiP7NsGdgcg+WJNwTu+Ob06HSGOTDhv/2YMfhrXVAIKjA2yy3uOPBjDfZZuj0EGOVrfTpTmB6Y8QJTJ//EGjWKc0U1tTS5/MPnoYXE230YlCDZYpPx6cy5fq8TZRnszOkJh7ZwVMohvMGXP2UmdqK7ZIXBVu9UpA6F3h8MS6ecxQxf9rHnjqIkU/sYSgbpRbVd7bDTk4uHG3HZOAux3pzA8SxjBYdjKIN5WnM0PuVL8PrJOnaoGikpiRiVEQVkK8JLL+PUkHafLXJE+qgve/gIu/ZDCeGdRG8nRotLho0Hoekw1vw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e376612-85cd-445a-618b-08df49949dcb
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8451.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 19:04:36.4173 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GSGEz47M4bu3fS2/1IegnuBILm0sFJ582JMCuTyEaV8iV9dzseANP+w4zH6M6eCaX3Jwe61ilA2YQ+ygQ96nwxbdp8H7YLCOy696CRuCei0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5197
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

On 11/23/2026 2:25 AM, Korba, Przemyslaw wrote:
> 
> 
> 
>> -----Original Message-----
>> From: Keller, Jacob E <jacob.e.keller@intel.com>
>> Sent: Saturday, November 21, 2026 12:21 AM
>> To: Korba, Przemyslaw <przemyslaw.korba@intel.com>
>> Cc: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>; Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kubalewski, Arkadiusz
>> <arkadiusz.kubalewski@intel.com>; intel-wired-lan@lists.osuosl.org; Ilichev, Konstantin <konstantin.ilichev@intel.com>; Olech, Milena
>> <milena.olech@intel.com>; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>
>> Subject: Re: [PATCH iwl-net] ice: fix stale cached PHC time after a time step
>>
>> Przemyslaw Korba said:> ice_ptp_update_cached_phctime() reads the PHC
>> and then stores the value
>>> in the cached time that is used to extend Tx and Rx timestamps. It is
>>> called both from the periodic work and, after the PHC time is changed,
>>> from the settime/adjtime paths.
>>>
>>> Nothing orders these refreshes. The periodic work can read the PHC just
>>> before software changes its time, be delayed, and then store its reading
>>> after the refresh that follows the change. The cache then holds the old
>>> time until the next periodic update, up to 500 ms later. Timestamps
>>> extended in that window keep the correct low 32 bits but take the upper
>>> bits from the old time, so they are off by a multiple of 2^32 ns. Two
>>> concurrent time changes can race in the same way.
>>>
>>> For a follower that steps a large initial offset this makes ptp4l see
>>> the offset remain unchanged after the step, followed by a clockcheck
>>> failure and a second UNCALIBRATED transition:
>>>
>>>   port 1: UNCALIBRATED to SLAVE on MASTER_CLOCK_SELECTED
>>>   clockcheck: clock jumped forward or running faster than expected!
>>>   port 1: SLAVE to UNCALIBRATED on SYNCHRONIZATION_FAULT
>>>   port 1: UNCALIBRATED to SLAVE on MASTER_CLOCK_SELECTED
>>>
>>> In the failing case the offset after the step was exactly 5867 * 2^32 ns
>>> plus noise, i.e. only the low 32 bits of the time were right.
>>>
>>> Hold a spinlock across both the PHC read and the store of the cached
>>> time. Whichever refresh reads the PHC last then also stores last, so an
>>> older reading can never overwrite a newer one. The lock is only held for
>>> the register read and is taken before the GLTSYN_TIME lock that
>>> ice_ptp_read_src_clk_reg() takes, which is never held while taking it.
>>>
>>> Steps to reproduce:
>>> 1. Create QinQ (802.1ad outer, 802.1Q inner) VLANs on two directly
>>>    connected E810 ports.
>>> 2. Run a PTP leader on one side and ptp4l -s on the other, with the
>>>    follower PHC about 7 hours behind the leader, and run iperf3 on the
>>>    VLAN.
>>> 3. Restart the follower repeatedly.
>>>
>>> This is not reliably reproducible, as it depends on the periodic work
>>> overlapping the step. With a 200 ms delay added between the PHC read and
>>> the store, 3 of 20 runs show the second UNCALIBRATED transition and
>>> SYNCHRONIZATION_FAULT without this change.
>>>
>>> With a random delay of up to 100 ms added at the same place, and 4
>>> parallel "phc_ctl adj 1" loops running for 20 seconds, the stored value
>>> went backwards 579 times in 1509 stores without this change, and 0
>>> times in 399 stores with it.
>>>
>>> Tested on E810-C.
>>>
>>> Fixes: 77a781155a65 ("ice: enable receive hardware timestamping")
>>> Reviewed-by: Milena Olech <milena.olech@intel.com>
>>> Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
>>> ---
>>>  drivers/net/ethernet/intel/ice/ice_adapter.c | 1 +
>>>  drivers/net/ethernet/intel/ice/ice_adapter.h | 4 ++++
>>>  drivers/net/ethernet/intel/ice/ice_ptp.c     | 9 +++++++++
>>>  3 files changed, 14 insertions(+)
>>>
>>> diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c b/drivers/net/ethernet/intel/ice/ice_adapter.c
>>> index 207e4fe97be7..9874380b642d 100644
>>> --- a/drivers/net/ethernet/intel/ice/ice_adapter.c
>>> +++ b/drivers/net/ethernet/intel/ice/ice_adapter.c
>>> @@ -91,6 +91,7 @@ static struct ice_adapter *ice_adapter_new(struct pci_dev *pdev)
>>>  	timecounter_init(&adapter->phc.tc, &adapter->phc.cc, 0);
>>>
>>>  	seqlock_init(&adapter->phc.tc_lock);
>>> +	spin_lock_init(&adapter->phc.cache_lock);
>>>
>>
>> I think v4 of my timecounter series fixes this because each update is
>> protected by the phc->lock.
>>
>> The periodic update takes that lock in ice_ptp_update_cached_phctime,
>> and readers get a consistent view because of the write_seqcount_latch.
>>
>> The updates to the cached time only ever happen under the phc->lock
>> mutex and the read for the time to save also happens under lock. Thus, I
>> think this patch should not be needed with that timecounter series.
>>
>> Do you agree?
>>
> 
> Yeah, I agree. one caveat though - your series targets iwl-next, I think we'd need this
> stale cached PHC time fix backported, no?
> 

Fair. The problem is that other fixes we have for PTP landed on next as
well, and the main target customer I have is going to take the tree that
has all the fixes. Timecounter is a bit too big to backport.

I'm ok with backporting this fix, but it will probably cause
complication on merging because we'll want to drop the unnecessary extra
lock once we have the timecounter fix :\

>>>  	return adapter;
>>>  }
>>> diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h b/drivers/net/ethernet/intel/ice/ice_adapter.h
>>> index d8da68e73177..45c82f8d7f43 100644
>>> --- a/drivers/net/ethernet/intel/ice/ice_adapter.h
>>> +++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
>>> @@ -51,6 +51,8 @@ struct ice_port_list {
>>>   *
>>>   * Legacy timestamp extension fields:
>>>   * @cached_time: Cached copy of the PHC time for timestamp extension
>>> + * @cache_lock: Serializes reading the PHC and updating @cached_time, so that
>>> + *              an older reading can never overwrite a newer one
>>>   *
>>>   * struct timecounter fields:
>>>   * @tc: timecounter representing the current time
>>> @@ -64,6 +66,8 @@ struct ice_port_list {
>>>  struct ice_phc {
>>>  	/* Legacy timestamp extension fields */
>>>  	u64 cached_time;
>>> +	/* Protects reading the PHC for, and updating, cached_time */
>>> +	spinlock_t cache_lock;
>>>
>>>  	/* struct timecounter fields */
>>>  	struct timecounter tc;
>>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
>>> index 488db8298059..1486a6fc35f5 100644
>>> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
>>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
>>> @@ -1079,6 +1079,15 @@ static void ice_ptp_update_cached_phctime(struct ice_pf *pf)
>>>  		u64 systime;
>>>  		int err;
>>>
>>> +		/* The periodic work and the time set/adjust paths all refresh
>>> +		 * the cache. Hold the lock across both the PHC read and the
>>> +		 * store, so that whichever refresh reads the PHC last is also
>>> +		 * the one that stores last. Otherwise, a reading taken before
>>> +		 * a time change can overwrite a newer one and leave timestamps
>>> +		 * extended against the old time until the next update.
>>> +		 */
>>> +		guard(spinlock)(&phc->cache_lock);
>>> +
>>>  		err = ice_ptp_read_src_clk_reg(pf, NULL, &systime);
>>>  		if (err) {
>>>  			/* The source clock is gone, so the cache can no
>>>
>>> base-commit: 34a70a40c954fb8044ecd124840a2c38cd3aa4cc
>>> --
>>> 2.43.0
>>>

