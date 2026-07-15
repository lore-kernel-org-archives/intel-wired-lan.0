Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A4B6C44508
	for <intel-wired-lan@archiver.kernel.org>; Wed, 15 Jul 2026 18:22:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B039C60707;
	Wed, 15 Jul 2026 18:22:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MB71xVx6Z-BU; Wed, 15 Jul 2026 18:22:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7FA04606C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784139771;
	bh=V319b58gw2N9gDb7WG8KPrRqFR8pgBdJZzNhKb30hgY=;
	h=Date:To:CC:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=2wTIrIVRPk+Ee8FmQlJ5D7lsmzE77Kxt2g/M47V/KDqh3MkjiybV9SDrRcL9lXP9/
	 KJLkeMjLV1LnqWFz0abqcv6cDt4V1kMEKvlvZ+CuLk9vHS2SYA/mlfo0lpV6GO2lJR
	 kEsYXWPhGQ1z+3BRqQrPvi4Bq0G7wfVjAMotdw9tJxJsn9N8AW0OHEoEn+dnL+WvGe
	 JLD61TUXVt27l8gpKi1rMnizm8B3lgXSN8DbRgjs7HNf9jCLJ8/ca2OyH6qzrzabTq
	 h45EpS3YpPQxBwMnHvuaz39XyE7vh/pa0Sugffk2RZkrMqXT4tVCdDf38DjJrURf0j
	 rSz/EcwW5Ff8g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7FA04606C9;
	Wed, 15 Jul 2026 18:22:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A447C203
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Jul 2026 18:22:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9318B606C9
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Jul 2026 18:22:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QZKsYOytkFN6 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 15 Jul 2026 18:22:49 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.14;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org BCE8160678
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BCE8160678
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BCE8160678
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Jul 2026 18:22:48 +0000 (UTC)
X-CSE-ConnectionGUID: D/laoBMCSge4Bhl0dSD2Hg==
X-CSE-MsgGUID: TJgnW/C+Ra6YjKTszSGa0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84831203"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; d="scan'208";a="84831203"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2026 11:22:48 -0700
X-CSE-ConnectionGUID: oeS7H7+OSCKcW/HBsEBaeg==
X-CSE-MsgGUID: LF5ylBYrT5OLnX5vPG6MKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; d="scan'208";a="259837725"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2026 11:22:48 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 11:22:47 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 15 Jul 2026 11:22:47 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.61) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 11:22:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aW/AfsM3oUnxfCF778ZRmPn4QZ2ZvLnUI+f0E9paKLBfEpI0JRdxAN4jNvXRqK1CMiH8+pVkPQrEyK/6pYab9d4ERAA7QebI+ZZtdtuEVmqkXQvhT1wK8NtXufRtQJY+3xAtSaMGirD1LDzGDUqXakapvP9J2IqAQzSt466P9+sPc968vIZroag0AZkYV546lQWfOky3bordWG5WPW/oAg9tW9jSz5exEYYBtRg9yja6/a5/3L4CS4e6BzR6if0vti/41Pk0jzD1l8SdmVPr3gMTfpQU1wQdjbFeZ6aFMN+wRNMjkJET6c2xmoNd2LSYpqs5zzcy8FurpmB1JIR1Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V319b58gw2N9gDb7WG8KPrRqFR8pgBdJZzNhKb30hgY=;
 b=haDoHRpHGyUn0Ss0RdV0Vhj7H6sDWUmpJvi9i2S+pJyuFnTjhKZWeLc2/PvDKCLgxPF6h79JiLcYpz5f/LoE0qwjGMpGJLYP9PWieEM46d8ewFc56gCiI5sQYvdMScQoyregW1fvNscZbyQ/5TfNcfM5TCg9J7xBfoX9SRCm/B+9FEXJvcU1RJy9gZOqefL1M3it5JjyHJh95qHYC6+bW8fP3hBPqOovPOqLyiUf8E4hxzMntctdcIp0uCjyRIQBhrBSYnBQP1Zp6ZP3KkUWhm+i8FsE9usHt/VNs2gCcX35vI14xjpKsWZ09hBT2TOlDHK84aSk66qv9rlFn5mncw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by IA6PR11MB187491.namprd11.prod.outlook.com (2603:10b6:208:5e4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Wed, 15 Jul
 2026 18:22:44 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 18:22:43 +0000
Message-ID: <5b420008-96f9-4f62-b155-a4b694a58369@intel.com>
Date: Wed, 15 Jul 2026 11:22:36 -0700
User-Agent: Mozilla Thunderbird
To: Tony Nguyen <anthony.l.nguyen@intel.com>, Robert Malz
 <robert.malz@canonical.com>
CC: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, "Jesse
 Brandeburg" <jbrandeb@kernel.org>, <intel-wired-lan@lists.osuosl.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260703103245.374800-1-robert.malz@canonical.com>
 <bc89cccb-3f22-42c9-9f96-382586d12fcf@intel.com>
 <CADcc-bxLMg1NujF+jE2rOXGc38quv_XqZfv5K+yGQFfhc03avA@mail.gmail.com>
 <e8a4e549-c67f-4d20-8d33-fb50b4c44de9@intel.com>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <e8a4e549-c67f-4d20-8d33-fb50b4c44de9@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0051.namprd04.prod.outlook.com
 (2603:10b6:303:6a::26) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|IA6PR11MB187491:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d814c00-5763-4504-98c8-08dee29e100d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|7416014|1800799024|22082099003|10067099003|4143699003|11063799006|56012099006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: vafs0zYd7Ycv0lOBfiD8yxdXOQO+/LA7rAxBEt2OlapLPih7jwfz20boJSYFvbps9qgQp5qRqngyPaDiBqHGk21ocIrLY0+rSQ7+DYO1VqziBQJKlkHB+z72jXAeIKMZcRHfZKwKIu2C6mMi5C1EP8yFRQvwr9y4nCM9FqWvvcgCSgZH+P8YqaZLLn6jJvhNDDO9YJyqhj2A9D0nrxsxZTWPRQrUudD2qcjfbNs3XS8e3GXTiTwGqjabFJ6WXaHzzI1dV2WyGJlvjb5DGg2a/CmiRVc5WSCfaBOgbk038EU7tcEVD+r2vXZql6mJ3wDPa4WFDT6NUADDz03KZZg9dYSfK50aPq/ZLJzIIqMJSdxu6JsHn4GwiPQz6m1w9Ki66vnJhMqL47e23NouAUFm9+wDetklZJLnPb0ChaKdv+FQnLlC/ACg5RsuyWExqQ1Qd8F2Xz9sPMr1NN419DZGN7xm9qEaBZADQ+HW2BkwVLuik3SOx0LeDF93EGZnqJRntb1/a4OchvEC5+rpSfZeXMSa0Hyq0V7f6NtwfA8GE0jj61DvWo2l9g7KbRLBgQvKcHQVKuRJWjhv3zfXBaOIQfT1E/o/0kDcAQrCn9RJdJngKLNDPrMQ7gttJ4hEdKK8b9gmTuHBYiTACnBRgCBdRx3YXzh2WOnxw+9+CcIu3u0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7381.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(22082099003)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STFmanl1YWpBSnhsekFLNGpzL3BkdERxb2ZVWTA1cllzZXdNVDJsK2VFWVVP?=
 =?utf-8?B?RzdwMEl5MFZaUzBZUVA5QVNzdk02bGlXc1BrUU9NMW4vcE1DQzF4QlQzU09F?=
 =?utf-8?B?M3J2STQvd1FoSk4xRnZVa1d6QjF0b284ZjRyNlIxSnpyZnc4RGllOHFXMlNJ?=
 =?utf-8?B?eW5reFFXNnNxUTh2b3VkMllRbTIvdXF5WmFNSFgzaTBDZ3YzeUpxZkwyQm1q?=
 =?utf-8?B?K0RGb2l0UnB0VU8xNHYwSWRjVzBQa0hTQVBEVDVtQkpPRjJDTFBaNEd2dktY?=
 =?utf-8?B?YmxtcEhlMUtHY25kbG9kNU10T2JxTkVWUXhDb3dNZ2hLWEhnWGU5cEU1cmxU?=
 =?utf-8?B?NjJjT1pHYTNpMjlmdnZXdmxJVndxanVlZlVueEpia00yczBCTWE2b0JzMlA2?=
 =?utf-8?B?VHpuU1gvYjBiZlZaZVgrRzhjNzlnZHFlMWh5RHVLZkJPL2FSa09wUDY5OVhB?=
 =?utf-8?B?di9Cd1BmZWxhWXR1alZVQUh5Mk9xTlB5UUJicFgyT1NzTENNMEdFdEV3Y3or?=
 =?utf-8?B?THhHV3hudXZGMnJWczVmM2ZEcy9hYTlnbllDd1NjTVdRL2FQZndoQVdYTkVt?=
 =?utf-8?B?MzI5V3o4aXMySUkxTmp6alRpVTZ6ZzR0MkdrY2NiSENZR3VEUW9UL1ljKzBv?=
 =?utf-8?B?ZWt1bzNXSDU5aGxMelVQR2xVY0tSVUxiN0haRlNWOWI2WmF1YlRtLzJBSC9s?=
 =?utf-8?B?LzYwcUtoRVhtQkRVYWQ0YlJHTlZIc3RJLzBRd1ZhREZYbHI0eWJYWG15S2dj?=
 =?utf-8?B?QnkrOGdremk4UjhTWnVTSm1VTW1WZEFJNFd1VktFUllSOEJsY2RYbzVYWjQ3?=
 =?utf-8?B?eXZOTElQLzVlbDhFWXdqYmRDcUVMM2JZcDV4aW5DeXR1RUZPclVzOGxyN29S?=
 =?utf-8?B?SlEydFh5b0RMdDJleW9oMzh0NFBpeTBLQmRGNGlYYnJ3NUh2WlBIVzdETUNv?=
 =?utf-8?B?UVNoYmx1OVBTdTdoK2xjSzBCQ2tnYXVweWl2NDA3ZEk0Y1UybGdDblJDR1Yw?=
 =?utf-8?B?TU9YSUIrQ1RMdzZHM0w3M25WSyt1cEZlRDluRWlsUFcwQmUwMFIxN3R2UU1j?=
 =?utf-8?B?RWdjbGZoRVF4clJ6QVVJdGsyaFB2MWhJcDhwYmgvQlB4ODNVRWQ3akF6VTNX?=
 =?utf-8?B?Q2hwM0o5UmUxTWRia0tXVXdMNlBkU0ErRUtrZDdaUDk4cXRXVFJvQ21TMGtp?=
 =?utf-8?B?eE4zRFRjUWIxUGYyanhiaDB3Y2cyMlhRTDNkSkswaGxsek5kdEFMdTdFbmVT?=
 =?utf-8?B?U2YxTWxQczdBeUVaclVRTW5qRjhRYVN1cmQxdDdqVjV3bkpzTkVMU0VRdHlo?=
 =?utf-8?B?dzV1SFJXa1d1cmJlNkZsTklnaUFnVWg2bHp2MkY2OXk0UHdnM29Fbm9rM1pW?=
 =?utf-8?B?Ny9pUUNwSWlzOWIwbGozV2wyRjVjTCtkZ3piUmxmV3lRM2RKc3dPNGpyUC9M?=
 =?utf-8?B?QzVqUWhRQ29YUERpTUk4cy9ZUzFoUFBqd0VRa3NCQmF3ZVVWU0dCZDVleDNQ?=
 =?utf-8?B?RUpOSGJMQjlWZFMvY2k3NGZpVW5hcXZoNDBzSlZLME0wcnlNd0RwVDR4U2VS?=
 =?utf-8?B?cDVMWlFLUSt4QTJBdHhHMUN6WU9CTzhXUUs5bTNVTUsxMWk5cDhRWlpjSTlH?=
 =?utf-8?B?dEhXYUpKRjBGQTEyMVhENlRSSXNkK0dzYnJYTzErWlpQZmxZWkQyQVR3VTlu?=
 =?utf-8?B?NjJPRHpLQmFBSjFXcHQrelJKVmVwVEkwUzJvRGNpZ1g2VHFJd3FHVDhFY05P?=
 =?utf-8?B?UkRNaTB4SGRaM2FJMGRlcCtncmZFcDZ4Sy85S09JTGkwUE1TbElTK0VjSmVz?=
 =?utf-8?B?YTNZdDVKMDlrdGdibFl4UGxXd0wwOG9wQWJJalUweS9nSTgwbXg4dGZDek44?=
 =?utf-8?B?N3U0aW5HWGpXWlE2OU1ZcEZFTFRPTmcxKzZZQnl3b3RmUm5oamU0V1NFdnJ6?=
 =?utf-8?B?K2FuYVNGR1dDQ3BtaklNelFYN3duQ2R2Wk1KZ3UvR3BxVzNnK2J3S3QwWDl2?=
 =?utf-8?B?S0ptakpwd0ZwQWN6bEo1MWpJZmx5MWl1Nm1Bc2ZOM3NFN1QraWNWa3R3RE5i?=
 =?utf-8?B?SzBsT0RrNkZ4YmpRNWk1cmJKQ2tMaVByOUlhK3hOaWRNZlh2cW1LdG5GaFUw?=
 =?utf-8?B?K1VMN3FNa2JjR2dxcmFZV2RnR1JiODQ3ZVlFK3pLaHFWaGsxZCs0NUNmR1Zw?=
 =?utf-8?B?aHV2WGt5Zk40TnlMZmREYWJiT3RFeXloci94NU55b25uZkpIVmtoNHF3dHRW?=
 =?utf-8?B?UStTYjFnWlFvN1hCdy9iSjJuRHNxWDZjdXVUcWdaVUFFNDVYL3I0WWtIMGw0?=
 =?utf-8?B?LzNWWFFJTGx4MlI5MGlCWW5vY3lYcVJlckR1NXVia1A5NE9vQmYrRjRIVVMr?=
 =?utf-8?Q?oMwXgbfu53BFovAo=3D?=
X-Exchange-RoutingPolicyChecked: gjmI1oAJtwP1GsBRcEmJpU7e/pxevY4N7LuwZAdEEK7lp6FF1LcGLcdGu4sy4B3waEmeFLl3DoAIlqGoDHXCpVRGBNcy7nh+2SQcnTBSz2/Ty0HKpBBBNgUV2YJFSh0PSUX+MQTICdQgevLeZadCDb8SC2+C/StNv4GppvFGoYVZ/vfnJLZNrcPi9YMeiajV7fBZQ3i7cbkHYF+ZJ0sROzr+UbEc1LEa1GInDxb2ymPyztb/Y4ZaLiDvhaSIn3H0HZ1Tq33ipSjDVXcYrklSkNlITSdq6CSLiLNU2TtiYq3cB2nc3hb/v+72wzhOthSIReWkCiWxjdMMdJl9iTp0Ag==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d814c00-5763-4504-98c8-08dee29e100d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 18:22:43.6828 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IYgcranYBhr9MEOlD2IqMf5re9EOJqM1FP5qGzOIb/OnSkVLMECY/T15FcYjC16a/F9u+cISwAiVhVgAe2ww5fYPsVNjlZw9DZvt5zJON90=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA6PR11MB187491
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784139768; x=1815675768;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=wlsj13+PlgrH/Mf/B+m2RW0vBcD2CyeQWeubGtrnbF4=;
 b=acPlON8VntBs8V/lspp4bE+IPCMG9GJ7Xh6W4NjTgDbfMqgNUWn3DcJy
 BE68L6zpxz9YAJY8mzriNAynLclGlutVsfwPhrAX8HLsNHjkJpdQuxHba
 9yWCpaE4GaeOrb/KG8+b+FB3/A6YQOLUJkPW2q3iT1gEzm6UJTibYxmMl
 yja1L4nXzwrJWkuK4SQUuVwF26rofSdBfJDuyZxuAZKmOtlNQZpCcPmbE
 pgL3oq+AVNIToUJOvY0VfHhTsGAzfQv0ONCKvgGC6E7Xp+pldP23EIuiu
 IPYMLCE8A552owuVi02JdfaMHLNnWLUHDQMu9GqKqHl3sVvm8f4ffFWLU
 w==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=acPlON8V
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH iwl] ice: acquire NVM lock around each
 flash read
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

On 7/15/2026 10:04 AM, Tony Nguyen wrote:
> 
> 
> On 7/15/2026 3:22 AM, Robert Malz wrote:
> 
> ...
> 
>>>> -             if (status)
>>>> +             if (status) {
>>>> +                     /* ice_release_nvm() issues an AQ command that
>>>> would
>>>> +                      * overwrite sq_last_status, which some callers
>>>> +                      * inspect after a failed read. Preserve the
>>>> read's
>>>> +                      * AQ error across the release.
>>>> +                      */
>>>> +                     aq_err = hw->adminq.sq_last_status;
>>>> +
>>>> +                     ice_release_nvm(hw);
>>>> +                     hw->adminq.sq_last_status = aq_err;
>>>
>>> Does restoring hw->adminq.sq_last_status here without holding the Admin
>>> Queue
>>> lock risk overwriting the status of a concurrent AdminQ command?
>>> If another thread acquires the lock and sends a command immediately
>>> after
>>> ice_release_nvm(hw), this lockless write could corrupt its error status.
>>>
>>> [TN] I don't believe the AQ lock will work as desired we can't guarantee
>>> that we will have the lock directly following the release in order to
>>> restore the AQ error. Similar to the NVM lock issue, I think this is a
>>> small window but wanted to bring this here in case others had
>>> thoughts/comments on this.
>>
>> [RM] Agree, this can cause issues. We can't drop sq_last_status as
>> ice_discover_flash_size depends on it.
>> Proposed fix: drop the save/restore sq_last_status and propagate the
>> read AQ error through a real return path instead of the shared global.
>> I could add optional enum libie_aq_err *read_aq_err out param to
>> ice_read_flat_nvm(), capture sq_last_status before the
>> ice_release_nvm, and have ice_discover_flash_size() test that instead.
>> The log-only callers (devlink/ethtool) don't care about it.
>> Let me know what you think about it.
> This sounds good to me.
> 
> Thanks,
> Tony

I concur as well. In theory we should probably try to fully refactor the
send_sq commands to propagate the error out from the lowest level
without sq_last_status at all.. but thats a bigger ask and I don't think
Robert needs to be asked to do that.

The approach described here seems like a reasonable compromise fornow.

Thanks,
Jake
