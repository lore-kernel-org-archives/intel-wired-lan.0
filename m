Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CB1606A32A
	for <intel-wired-lan@archiver.kernel.org>; Wed, 25 Nov 2026 14:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=w7Y0ZUng;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DCOd/lXy;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=VwnfbMH6
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 58655605E9;
	Wed, 25 Nov 2026 14:31:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lA83Sep6usLD; Wed, 25 Nov 2026 14:31:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A5CFA6076D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795617088;
	b=iS/5wCtg1FlyAinYIkevjCtsyZilyKcDRW0uPxFu8XI4WCsrRcz8Hk22i5cN+bNjalT1
	 7N3XTxwWDfc9BppNWiICF8mMMJNW4kkuz48/7r+Surc3VyJzw/LAfihTq5Pv71GxOX0n3
	 y5lmhpKkE6pqHAnyCn089cugid+nltPZHlVivSlfoCGPLPmIsGwRw7RZoaIpp1OeURrvC
	 eq/8QI3hSwQHeJFHrK8kBJ1b+IiKm3O/gXRbX3ReERGf9i+0V8Tx2Szyy8SlJy3HqfW8C
	 5ht7rbrnWZRYAlmCcCm/qy4+MDes+3jT6Bf/bD0wI3MqY/GmBO8YDI44EFc0W/is9Hg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795617088;
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
	bh=RPO2cq9VZoSjEQASARb2dUfIrWp1dg3KPb6NKJxfuB8=;
	b=nBXCYa3oVgzLfMCz0Y8rbdyXy80Pn/ukK2e8sQmK9g5njr+aVfK1nth6Zt7ubZgymrFd
	 uJVQZb7AKDWisXD8z8hyn26XqM6GC2biPPSXlyyGbcxM0uiVjVnsktpZ+hxT5nslmEn/t
	 ddeJH12RxbqxxTiZIuXgAj/egaZGTj9D7vcVSXsgjnH0QKf3wcZ0pEJbcY8Iz4dNXMa47
	 mnlu4MUxSOGt86B3QnfLPCJgwl3UzuNqr1Wg8o2USMwPL3acQzCSTW06fUxcIqePr2pRx
	 uaY25mMbzv7+AX6voV/hHuUCb9n8Mtr9ULWFGzB7NEf3gX6qCmTE5vSUjl4l1poP6+w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="DCOd/lXy";
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=VwnfbMH6;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795617088;
	bh=RPO2cq9VZoSjEQASARb2dUfIrWp1dg3KPb6NKJxfuB8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=w7Y0ZUngtpcj9HU//znyt9loUkp4mDtd9b7HBaLjZmI1tG0DpOsL2BsJtz1qGFI0M
	 i75nN7pSokGp7+iebB95y57Kp2ItF/fLCezt5VidTBTlinqBmdlz7PfmHu44WZkhNq
	 AmcDEaOQt93PPLqDopFijqZAnKJ6NN88NfZnHPrMTl1tfbuiesdS8oIwcRq6zZNppw
	 gJB0BbQyWGSPrmZoD3GMQ6Cs567NElc4n7WnBKpQrs/sLy314VxpzJ6BT1TowEoue8
	 YBmAOmWzqf0qweiXLBZ1CuMklR90lT3iz1KhQmK9w0Z1zImsQhxGEYifBqPzWtJ8pT
	 h/9rJ2TGtqyGg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A5CFA6076D;
	Wed, 25 Nov 2026 14:31:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A08F443
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 14:31:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 85F146076D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 14:31:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CjGuDA9sifVm for <intel-wired-lan@lists.osuosl.org>;
 Wed, 25 Nov 2026 14:31:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E2643605E9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.12
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.12;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=DCOd/lXy; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=VwnfbMH6
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E2643605E9
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 14:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795617085; x=1827153085;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=wUj0ZdIPgCranayi03VC7KQ/fXjSiQRN5mhb96XC2wo=;
 b=DCOd/lXyif5PzM7v6OzxT1wkCFDR/eewJncSn2YFuRpjIIvuW5qxkE//
 mha0OXQCK/M2HJl+1wEwBZ7fF5Flp4TWbKsiPv0WK7QR+KJ9rO4Rd5Xye
 zBru780vB1rWesyLNbv+wUDoniIoz5M0ZoI8a3g9OjPXXQyR1LIkF4ZMc
 8NT+dF5dqnVu0wQYWiNqqrpUSKDTO/+SvMuPe8mn7KxZYQRX2F5s/wJq0
 viRmWxAMWyS5LUW8mtrNhXiAbyomSLcO+GdN63H6LiRppyFVuMlj8rFg4
 euOcRxCjUFpkY2+PyUpen/CgHqdOiAPMkhxIzG0Do1g632FmgETMy3Eks Q==;
X-CSE-ConnectionGUID: 8lhjEj5ET6WUfBPKDG86Fg==
X-CSE-MsgGUID: QNajD3H5TuCh6vdJT05qjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4378700"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4378700"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 06:31:06 -0800
X-CSE-ConnectionGUID: 7hTzCLeqRRKG2399604aoQ==
X-CSE-MsgGUID: TGLazwAoSUKtwfEPCxXLhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; d="scan'208";a="11763707"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 06:31:07 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 06:31:06 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Wed, 25 Nov 2026 06:31:05 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.59) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 06:31:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RPO2cq9VZoSjEQASARb2dUfIrWp1dg3KPb6NKJxfuB8=;
 b=VwnfbMH6gU/0yKuuOb9Ohtw6uwhYwazWeMJYqkR+6bUuTAkelWqRuh72ZWhNEsuGhxAX9TYunBtpNaFlCPR+dh0zYNeoWil6B7Axxm1HlE7TSGYWjedIOZQAP2tvjMxefeeA5ln0srlAb6vmq8dE8cDgvA7HKLrQ5rBs1m5aqQU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by MN0PR11MB6012.namprd11.prod.outlook.com (2603:10b6:208:373::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Wed, 25 Nov
 2026 14:30:57 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 14:30:57 +0000
Message-ID: <6ce9cb98-d615-4bf0-990b-35aa4b970503@intel.com>
Date: Wed, 25 Nov 2026 15:30:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/6][pull request] Intel Wired LAN Driver Updates
 2026-11-13 (ice)
To: Petr Oros <poros@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Jacob
 Keller" <jacob.e.keller@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Magnus Karlsson <magnus.karlsson@gmail.com>
CC: <netdev@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
 <edumazet@kernel.org>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
 <horms@kernel.org>, Marcin Szycik <marcin.szycik@linux.intel.com>, "Aleksandr
 Loktionov" <aleksandr.loktionov@intel.com>
References: <20261113231225.1864810-1-anthony.l.nguyen@intel.com>
 <20261118115915.116177-1-poros@redhat.com>
 <20261125124652.3843638-1-poros@redhat.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20261125124652.3843638-1-poros@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P195CA0008.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:54d::35) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|MN0PR11MB6012:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b116600-58f5-4bb8-5992-08df4b00b7dc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|23010399003|18002099003|22082099003|56012099006|11063799006|4143699003|261028144727099003|261022105027099003|261026140227099003|261026121527099003|10067099003;
X-Microsoft-Antispam-Message-Info: bWTBj4dmMF4T3ygdoFOxsEWdQeaym0GnfeavnE/UvCZGEDx03H66f9otwV60RFB8fExgyU5MepWNX2lDta8FNhW0NIwTMDgVUYOhXMiHLlh6AtjF14/X7v/Mn4kwzRuzODtkSWNZDUXryadeO0mVy/W3+E/7pn3NPQ91x9B/+iOgTt5HfiDN4qciLsv2cDI/905r9vF9f2EjZt0owhufnx5MVCcjlSCm1obcRGfWWLMFU6pEelQVH1juCGj597J4PLe9xJQyEjLdE8AzTH0tWvIx5okBMVna9ugdPob0MoimHCNcGfla/fZ6ET3iKl59h+Ffrz1Q8FV9+FB6NqFB27cakoaO8OScgaLxA2u5I1ApWpl+c7Elxtk++wQqDFmx/B+kNa9U8Cgm7AahP2LrjyiF0bIjTZZlXn1LAsajb8QYhu7ApD7ZVrl42e0ZUgX6F4rv41gts8ATLqvQNUo0aXPAamn30H86sepgh9NBhgT5gYE52kQ69jj438cIkf4NTh/rNVk6IkK7xzaRZF4woqNzis6t0yDfHVdhoNXqJt6h5b0Z1lH6UHZ2HnXdOU9swS6oewY8Gf50tcO1Uanv0IOuopPXEIlFdOsIWZ+reZrciA0rcRDqO/AYZYof/LoVkum3uv1b0QVyAWiOPa/IejaukdMdwGZS03Lwppktabc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR11MB8508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(261028144727099003)(261022105027099003)(261026140227099003)(261026121527099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUV1d2lIeGNIaVdidVAzU1RPZGxUQklKYWE2dGxoeE5vMVkvemZrRExWZ0h2?=
 =?utf-8?B?TUJiM1p4TCtOMnNwTzNISVVhRlhKRmh4NFdXb1FmcU0weVlBbEFBNkx3USt6?=
 =?utf-8?B?OE5pV2w0dDNXODdkRFVQVWZEOXVvS1EzbStETStsK0tCYVJINWM1c2dIaXBw?=
 =?utf-8?B?N1hHWVNCVkxkdlUzUktpK0ZwVmRBQnpVbGZ0MFgvcytNU1dDRzFjRW1WWjVv?=
 =?utf-8?B?eVRyRWxiTTNhbTFDcUVjQk9rWXJVL0dZYm5BVmd2U3JGZ1lBNWdycGdQZVlt?=
 =?utf-8?B?WWVtRGwrYjFKK0IxeFFXQ3lkWllxRmFYZEZQdXM2Y0V1NkpER3NsZkJWK0Ux?=
 =?utf-8?B?ZHI1VUROMGt0TkxUMzFHdUgvNkwrWXp1SEpnclhTdGZlRDFsZVBQS215eER1?=
 =?utf-8?B?WDIzdWxEQnloUnZpeUpDcEpzL2JleXFWb1RHQW1qemFRWFNPWmtGZjBCcm1J?=
 =?utf-8?B?alZNWkZiSWpjeUoxQXRubXJvdjhTU3FTR1lhOFFIM04xd3NLZ1VqWGQvVW0z?=
 =?utf-8?B?VDMwVWZDN0RURDJpdlJBZEpQMEJzNlUxRm5VRHJtZmxtdnlLNmZUZTBSR2Uz?=
 =?utf-8?B?b2pPMEd4WmdHUHdoNE9xbkxCdE9aYmFoUkRnZk5sOHY5Z09WZkZLRmZaeXZ1?=
 =?utf-8?B?NVVSRzROOHVlbUN2SEtVNTN5SFBHbkIxOEpRcmJpYUh6QlJzeGdDZythYkY0?=
 =?utf-8?B?ZmlrNkJGbmZ6Q0RJWDRqbU4xK2VyUUZ5VXEreWxEaWlxbEZwK1NLYS94UWNE?=
 =?utf-8?B?UFZSQ1k5a25EMmtLbDdOZ1FXVld4TnRFWlpKUVBwN1ZzRHlxYko4WTg4dlYz?=
 =?utf-8?B?eHFPNUhZTmZhbWFNaCtPbFVydFZ4Tk5HNEJYalJ5WlB2eW5QZ3c1Vi9JV0px?=
 =?utf-8?B?VzBWUFRzWXZXOWxiSktReW8xb09yL05LcitDOTNKbFlacUoyYTFLYWYyaVgz?=
 =?utf-8?B?NDJ1STNOa1NoT3JYaEJqemN4TFpraUJJWmZpemhWaVJna3VKS2ZNMDhCMXhS?=
 =?utf-8?B?VklBc0dSbW9Vd0N4bXBsU1hBdFZ2MlNnNWQ3YzM1bUFEdU11MXdPcWljMjNQ?=
 =?utf-8?B?WnJ3M3JRY3owb215ZmEyVEtSRzNEUEZ2ZUpLTy9yMWVoR1F5ZHphU1FPZTBo?=
 =?utf-8?B?T3prVFR1VTRZM3pjWnRwSjJuZUdxVWF3UldWaWk0TzM1dXN0RXNQYjlsQUJQ?=
 =?utf-8?B?MEtkVmFwWW55RDdSdmtBaVFDaTUrd3J0QmpzYnBlQzVsUWdRTC9oWDZCVkVh?=
 =?utf-8?B?ZlErOVV0bTZNUmV6aUlzSnIwZ0p1a0ZOOEdCSnV1ckQ2dVZPaDVlT295Zm5o?=
 =?utf-8?B?OVNkMWJwdGtJQ3dYdzgxREZwRk5ZQkRJVGVXS0F6Z0J1SWx6TmliTlozRUpw?=
 =?utf-8?B?V2daQ3pkN05kZFpLN01samZKYjNFcWVsUndHMXhFWXdIdEd3eEJzK2JiZTRK?=
 =?utf-8?B?QzIxdTdNbGFuQjVNdGU1SHBheVM0YTdDejRBc2hiSHVUdTlYSXJJN1UwTkVi?=
 =?utf-8?B?WXNLa01QS0gyQ3dQUGVNeVdLUWVhNGNzYW1jaXVGcmhPZld4MkhWTENBeCtv?=
 =?utf-8?B?dUZCMXUyd1ZxN25FcEo2dHlycVhpbWZVVHlwNVNFenROendUNDJPR2Y1N0N2?=
 =?utf-8?B?SDJwNE1taFZlbTM3NHl5WWc3S0JSUWdyN3pTbHdkcHVGS1MvRHZTR01GYU91?=
 =?utf-8?B?cmExeFZNQzlWNVF0L1FvUjhSUUQzZVk2NXBGZXJtMWRKMHhBa3pvL3N3RjVK?=
 =?utf-8?B?Q1Z1NWFiblRMbmZEMi92TEQ4SHdqcCtyWW5USnZiYmFYaTNoVUdHeUxDak9V?=
 =?utf-8?B?MDZlNFI2dERERnZaNmZZdWF6enEwV2pHMmU2anNFcXhzK3lCd0VLNk1FVUhw?=
 =?utf-8?B?a01lL3ZrY1dJbE1Hb3ZjVDZsRDNaME9lWG9kMWUyUUJwbHliSlVJZFBvUG5t?=
 =?utf-8?B?U0tLTENYdmptcjd6cHlvTTFkNHJXZ1ZuTzR3bklRSis4b1lWOFd5bkVHK3lL?=
 =?utf-8?B?S2s3SzRtQnpyQVN5ZjZLRmFMYTdsaHh4cG9HN1pIY21RMEFOUWVlcEdCQXhH?=
 =?utf-8?B?MkhtNEt1Yksxai9NVmtBVDdYdTRQekdhUWhPaFJHalJPbnQ2cXo1Wkk4K1ow?=
 =?utf-8?B?M0t6UVpJWG9IZ3V1UUtPRjRCMFR3RVVwZWluTjBrQjJ2c2d3WTBCSWF0c3JY?=
 =?utf-8?B?N0NKVDY1MUc1Y2dtTTIyNVNyY1BJMFgyUnV4WjVVWG9HTm9VTmNQY0hDNk5F?=
 =?utf-8?B?UjVpWFF3S1NQbk5uaWlGczh6cFpEZE5UdlRiQ01VNGdyZmpCU3JkOEYxZ2ZI?=
 =?utf-8?B?K1c1NzZ2NHZpRVRMNTUwMGg1VUFLUzVmaENrSkw0MlpDcHRZVFZTR0hyZVZn?=
 =?utf-8?Q?oSyOAsNSljAqmg6M=3D?=
X-Exchange-RoutingPolicyChecked: Tt4TEIjYB1/QNHWnFyjU2gltRFgvGN+/8dc/Nt8+2Ai/t8X7Cr9oS7OQnIqdoMORCLD/8q/nURiuQJLeWi/IUeIScsRysMNe9Grfg+LtVV0l1DgFplIL2fqjGOOroea3cI7iPDhC5LErwOMjdHdUo4j36ZKu6wIt7lWtJ4DGA/Q5FVT0X+mUTuInNlKBrAlpm9nG/AOgiknxYV/eK56Xr7zyOS3whvXGPYwuKBcpNZqbgBYDWPxc3G6zzaOp0ipYvieC7tGk6+b28aikV+4wRVGdqphBCK2nwCXEwvAEa+RkgSceZnQzj4ddFxGveQa+wEKT2tpicwNaFu+lliGixA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b116600-58f5-4bb8-5992-08df4b00b7dc
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 14:30:56.9090 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dnj40XkmemOEpKi3dZ1D/BB4GTgALKlGfEcNyAka3N2JKc+YnjBKb3N9BShYj9O5FKTOyg8Rw3IjrYk03iRakyHGrFdLu01gVfxs+oxjOzw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6012
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

On 11/25/26 1:46 PM, Petr Oros wrote:
> Thanks everyone for the input. Jakub wrote that netdev is happy to take
> the patches directly once a maintainer acks them there, and Przemek
> that they will ack more on netdev. Building on that, here is a
> suggestion for how it could look. It is only a proposal, for anyone to
> comment on or change.
> 
> 1. Fixes could go to netdev as [PATCH net] with intel-wired-lan in Cc
>     and be acked there by a maintainer listed for the driver, so they
>     would not need a separate round on iwl-net.
> 2. Patches that are already queued could be sent again directly to net
>     by the people who originally posted them, the same way.

but please not everyone at the same moment ;)
on our side we will try to not only human-review the code, but also
use local sashiko and to run the code

the current time frame for that is ~3 days, after that in netdev
patchwork series is marked as "awaiting upstream" (yeah, weird name for
"awaiting intel" :)), another revision of course refreshes the timer,
but it's not good to repost just for that

> 3. Later, once this works for fixes, the same might be worth
>     considering for net-next.
> 
> It would also help if Intel updated the MAINTAINERS entry to match and
> kept it up to date, so that it is clear who acks fixes for each driver.
> Jakub mentioned adding maintainers or splitting the entry, and the
> details would be for Intel to decide.
> 
> Does anyone see a problem with this? And who can make the final call
> on how to go on?

that's correct summary

> 
> Regards,
> Petr
> 

