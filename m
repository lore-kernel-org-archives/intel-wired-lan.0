Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E223606A337
	for <intel-wired-lan@archiver.kernel.org>; Thu,  5 Nov 2026 17:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=LYKbby5R;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CX72fcaX
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0515740338;
	Thu,  5 Nov 2026 17:06:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9VCVwhehb9XK; Thu,  5 Nov 2026 17:06:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3288440330
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793898369;
	b=L0jaiOgxXPZ8kfLxnl/FcUrhmq+IJNq/0Cd2o6aDgCdndD7tj688FcBgMPhsL9Hm7egt
	 iNg07mmSqDPGytpWmy7bmq5TVbmNbjVwK9Sf5WBOA7l3uhSDW6wbsoWK0Z2UZspUQ5cZh
	 yQvyNYF8zB9Iqr8i8Rx0b+/JSGalDoYgOomI6ZrH50uJNm4QthTLUwLZVw4Q/D1Tv5xGy
	 bLqjej6sV0mQb2uN6Ow3208yamDLh8m+v7XsxmNzV4L8FPkBR8hO4gBOspnTyG/NAaQ86
	 +gnvG0w/o9A8I5K3F8ho4y5KzKyfR7MmMOuBwsVSD83uXM/AGBjAH/4+CAozV7dZxog==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793898369;
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
	bh=lxxP4ADc/MXR9e08ohQYW63ecmgXboiyS/UeeV/TdWI=;
	b=eTEpyCQZV6Hv/EgI53JxDvh2jYXJbICaSWcTHm2xXAf7L+HoOXSdhuRRDO+/gVhcjj6G
	 6EX/XgxMaLvFBd4INn6kYQVz3HrIqn23512d3jxUhDtpxBjgSXMCtD3vR8jv6P5uqdMzm
	 UJVGTOiNAZvvdBeu3BopGu6CY65b/d9reXAZrpah9Il+NSnBawn8Lx9F6JHtle3i8Id3A
	 sJe0zvan0RO6iAt6DE6r2bKoagPZJJN4G+J37OgaTs7478UvqOhoOdxlobBGQare++d2X
	 zBOdVwXWgrkHvKcJ4sKp5dC3vgvHgOnFw/XlYzmqH45fkKoP6SxPZTSV/mz4Lky5gqQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CX72fcaX;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793898369;
	bh=lxxP4ADc/MXR9e08ohQYW63ecmgXboiyS/UeeV/TdWI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LYKbby5R+TtqHqiW9y5xHeNOIps/gicGJDvIZ9jpddhLp3pUuhQ9kO5P03bRuLE6x
	 U817eAQQc35NNgrsMQrLfUqX6WYOtwRGnHUeaZbZKDFZppb7zRbnkTGMjnWAWgNZS6
	 9jhQ8I1cHGkIb07YWUlDOhu1betPTTiO+k6B/M4IqSZE5AvHYLn7B11xiQhGk9cgDI
	 dhgiZifO+US37yw8FaNLD+aI8XQhjjcKw/bD9z1Ha3U+SDOUBRy8krO3Z7aU19Y2eV
	 UaKIxeEisbPzZN49aiafqtzQ5mfFwnlZSH9YcPQAtc4w60hj1wnNCE3eGxBV+kYaRG
	 EiT8GurvVmtwQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3288440330;
	Thu,  5 Nov 2026 17:06:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 65CB8B00
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Nov 2026 17:06:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 549234033D
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Nov 2026 17:06:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h5Bu8A2m5m6K for <intel-wired-lan@lists.osuosl.org>;
 Thu,  5 Nov 2026 17:06:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E183640330
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=198.175.65.14
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=CX72fcaX
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E183640330
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Nov 2026 17:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793898367; x=1825434367;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=17URKYTxSC3SYaBfBATJnPC41XN0sToQxf/+gHQdMBc=;
 b=CX72fcaXYOPnDFOkRayxjzeaHX1FRuZPyZxdSsBERtKo1xEWgloig/DE
 MaVvGN66ucUClaK8CTno1EBjhheGmwrGPaTx4LbbnMXShI1WJ/zyY538H
 srmVo+z+sna1w29SIL1cw+v+JzWLAlap227z4W8wpe7bGgRMCQ+/Kdpzm
 7RtVZYT723H0R3zD3X9XACZcsLH947HEg+2oZKZiJnRzg52SWFW4GkKfr
 1wcT+qoN4tHxRZIOnGY6O9Pyp7UJTvxM9TfLgIft4uNkExJZwgLjT3083
 u07tTZs+8mfc3a0QG+xc1IrjS+PyBP003ackVd3/YTCfBpC5im5R7tFEC w==;
X-CSE-ConnectionGUID: ollvFXSWQ3aabPhgXgOHyw==
X-CSE-MsgGUID: 75ZK0rJMRf2FsUhLVeg8cw==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2588644"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2588644"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 09:06:00 -0800
X-CSE-ConnectionGUID: ZuffTt1uQ4u9ZCQcNfniDg==
X-CSE-MsgGUID: VfN1FDHgRAuqQR6fGxMJlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7209139"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 09:06:00 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 09:05:59 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 5 Nov 2026 09:05:59 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.33) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 09:05:59 -0800
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by SA2PR11MB5082.namprd11.prod.outlook.com (2603:10b6:806:115::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 17:05:57 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0569.011; Thu, 5 Nov 2026
 17:05:56 +0000
Message-ID: <3427da31-af9c-41a7-81b0-ddc1f7c058e9@intel.com>
Date: Thu, 5 Nov 2026 09:05:55 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net 1/2] ice: ptp: serialize E825 PHY timer start with
 PTP lock and incval
To: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>, Simon Horman
 <horms@kernel.org>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "richardcochran@gmail.com" <richardcochran@gmail.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kubalewski, Arkadiusz"
 <arkadiusz.kubalewski@intel.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "Machnikowski, Maciej" <maciej.machnikowski@intel.com>, "Neustadter, Marc"
 <marc.neustadter@intel.com>, "Temerkhanov, Sergey"
 <sergey.temerkhanov@intel.com>, "Olech, Milena" <milena.olech@intel.com>
References: <20260925222824.270640-1-grzegorz.nitka@intel.com>
 <20260925222824.270640-2-grzegorz.nitka@intel.com>
 <20260926170543.GA13925@horms.kernel.org>
 <a71ec0bd-bbce-4801-b79e-8b7d648aba6c@intel.com>
 <IA1PR11MB6219BE8C90BA9A3BC9E2A9F192772@IA1PR11MB6219.namprd11.prod.outlook.com>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <IA1PR11MB6219BE8C90BA9A3BC9E2A9F192772@IA1PR11MB6219.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0128.namprd04.prod.outlook.com
 (2603:10b6:303:84::13) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|SA2PR11MB5082:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a7661cd-c5c8-4e7c-4ba4-08df3b5f0ece
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|11063799006|4143699003|56012099006|261009223027099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261102123227099003|261026140227099003|261026121527099003|261028144727099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: lNmfO8FWX3OUMu2/PNWLt0qn25XyZnlTciDC8HdHLsU0BlUzM/b/A/csT4xhS33frAaJHHEVvV1epsx8HlKN0ouzV0BkeLvtAEvUjhrh53IiVEFlXIUpngt+zqWIEl93C2pcbm5MbYIBoRypONPNePBiBZtKM/2BlzzDaJCI2z2YNww3LFRqQtt7OfGsVzOx7dsh5famGX/uVWEOj95Fq5x9IZ8R7F0wQvx4DEacriCHxAM52EwY1wkiOUM3NBdLkU5H4kbz2Izddg0pLjr3znorwG/XbRkWFuQhnR/kPZSynj7gMluFUkG1BuStiZlrxrnV19aNlT3bFYlO79fIrUUryn4l9/JsAsjOHDryaXaLi8KbgRBum9uZkMsl+sf2DzUWpVcOnyJSGKk/fg/dh03ERYLwKFTJRE3gUb7zzVJ37gA9XXYvaCjb4jAZtXihrHi/N6HOlSajnWYwOq05NH/KQkcAZSWXNvkf0fjn9hZ/6Qyka8Ii/VZTLs8Q+5KaXMeumaj5hFr9VrcFkC9auZ8xQQatQWvy3SM8pPNwg63i225EOJ9+eBTyswnT3QB7aB9BqNOBmxkQEzk0zgqmtu4kAeBklX2gMt956TPYJz6OM7AWE1FL/PMsSY81JxuTBjZp0GD0h503XsTeMNRwaATp+kU8x65FGyEY9Q62K+E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7381.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(11063799006)(4143699003)(56012099006)(261009223027099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261102123227099003)(261026140227099003)(261026121527099003)(261028144727099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTNYZjdBM1ErRVlSWGc5aTl1VHI4QTBZcWkvclljM0oydE5UZndySWRwTnMv?=
 =?utf-8?B?aDFXL3pUdlZMYlQvRWd6VTFWSm8rTWhYSE5aOFFkOXFhUUw0dU1aV0hsREFY?=
 =?utf-8?B?elZTenB5SUcxNWhKeFcxQzJDZzdBOVhKZHNwWUFJRlFYYXJ6YlplaUowMmFr?=
 =?utf-8?B?Qm5IQm11M3kxUXdOWjlHS2JqZ2daNWhkS1R4UUpLRkptUDd0Z1l5OWg4VWdw?=
 =?utf-8?B?WmppbElKOTVWZThmVDl5ckY0RHZNZ0FTd1hFQlpoSEhzWndhSmNSNnVQUmpV?=
 =?utf-8?B?c3IxVjFHSi9Fb0hwNkhpMTFZejdzQm9LcTlPcFVQa1pLWFJxM2o2cVJtaXhU?=
 =?utf-8?B?U0FRMStBYytKS2hURXZDVDRSajlDV2xxRXg0THZTaVRrU0Zqc3hleGlmWVUz?=
 =?utf-8?B?YTZnMHJsZ092VmFPUDFZWkxBaDFhbm92bUl3ZEQxS1I3VnNBMUdpNHEvVUhn?=
 =?utf-8?B?bUlPYnFDTlJIS1VYcXFTcU1oaUJhRHM2cytnZWVpTlRYeFNUTlFDOTFrMUhX?=
 =?utf-8?B?K0ZVdzV2V05KTU1LVjRjb1ZjandUTFo0c1dQYmVtdDlxNnNEQ0trZk16RGhQ?=
 =?utf-8?B?ZkM0WERsL0w2eStqdVdHelFZMnlrK2xaa1BhVCtRd1pLeDZYUWpHMUJZZzE1?=
 =?utf-8?B?bzZIeEVLU3RFTGhlMThJa285YnQ2dkY4Y1llOUM4MDJEYXBDMjltcVcwd1E0?=
 =?utf-8?B?UURSQVhpaUREVHJnVjZIVHlFMHN5QmtrM25SU2IzNXE2TTZhRU4xOURxbUln?=
 =?utf-8?B?MmFMM01FWnpkSlBUZEZodi9ZVk9RcEtGZlBGeHRaK0pkWWQ3dzNTcUNPcDQ5?=
 =?utf-8?B?czNabDdXQTIvamRCQ0tEWm8rdjgyYWhSeWs0b2piR2pBeUEvb2h0RUNHOXVP?=
 =?utf-8?B?djVoM3o4WEZkNzBRY3I1MDJBUTFYWXlzT3BaRVZ2RkcwMy82NTY2dldOWU1P?=
 =?utf-8?B?cDdsbTlIWS8xYUhaNkdMQjdlVFhRTzJRVlR3TWUyc2FxbGx5V1k1aDNydkRl?=
 =?utf-8?B?dllCMzNrZzMrL001bkU5eUpEN0E1M2ZRSzFtR1RoRHF3MDRhajFsa082NG96?=
 =?utf-8?B?MFRYTTU2T1VNOHVEVC9MK1hoQkoxUTRFNit4VFJwUVFRT2RKQm9ZdWVjRENZ?=
 =?utf-8?B?Sy9nTVRmNy9EZ1Y4TEtwYVZvSkhtZHFZTTJyNzZEMEJTeUNYbUpGM29KdFYr?=
 =?utf-8?B?Rm9GdHgzNnRBY20yK0RXeFFnNzA1R1M0Mkc5eWgzemV2TWl3ZjkxS1BLeThN?=
 =?utf-8?B?dGRYV2ZBcysyRkNtRnZoNEQrRkpSQklPRVVjV2sxRW1OdEFOYnppaGhFWVNS?=
 =?utf-8?B?bloxWXZaSXd5RVBSS2NGTzlRZW42QjR2NFU2L1B6dzFnT1RZQ3VlSUNxSGls?=
 =?utf-8?B?WGxoNHZPUFJiYzhzVzVFR0ZIallkZ1JCd0hueVBOQkJKUytkeGx1MS9pSW1F?=
 =?utf-8?B?ckhoa2QzUVFRZXJQSVJteVRnOGEwZzQ0WUJpemV6V3lxYXhYZTROZFBhWGpa?=
 =?utf-8?B?QVJacVdPTlFnem9zd3YxOWVjQXF1a1BYQzMvUzVObzAwbmpVL0NYUVRwV1JC?=
 =?utf-8?B?Y1pVckpDYncxcElmV2xIVzBDUktyZDRZdE5CYW1EaTRPR29GVGZkVTRSc0JM?=
 =?utf-8?B?eFRNNEVEUHJGbEhwR1lWcUJqRy9kamwzQnJTdzBhb2YvdXdweTRVUXhJMjBW?=
 =?utf-8?B?T3JqTnVSV1dZaFUvbDFVQXB3Zk9xQ2pPNk45cUluN3RzaW1vbGx1RDk5NE9I?=
 =?utf-8?B?SFh2ZStXRmlJeVJ2QlNGWGQ4dGRGbVNFcG41ZEZsckZwMUtJNGtHZitCOWRs?=
 =?utf-8?B?ZlhtT2tiNG00czNEM1haTUl0RVpWazdLa0NVbjQzZ3VIWFZ6MDVsSmNsaVcy?=
 =?utf-8?B?MnZzcUh6VndjdGVnNzNITWNTWnZ0VHlPclZQREF5eWR6aW5COFlObDBTM2Vu?=
 =?utf-8?B?UklyOFZ5SVlTc3Vyd2dMN2dNZEFiV3pjcDF0THF1UVRXSkwvNUZmZEl5MXp3?=
 =?utf-8?B?WlRZVExQQ04rZWZqc1Q3ZkxJNmpFZWEzR1c3VUxWSFU3ZS9YYjRPcVlJVy92?=
 =?utf-8?B?UkFxQjhEZXp2K2p6dCtFeEZsMjVEdk8rK0ZDMTVtdFIyc2tNR1ZFMnBuMWZI?=
 =?utf-8?B?Qys5OEVNQUtMNXIrci9xSkZrbFF6MkNoYmJEUjV4YnBrbE1jeEp1TjgzcHNP?=
 =?utf-8?B?R0Z6U1FzQUJUaFkzVXdiRE9BbDYrNW9XZ0N4Sll2SC9aYXBBanhBN0xXZ3Vx?=
 =?utf-8?B?WU0vS3E1bzR5M2N1UHAvRWRuYWd5UWhZbVVSaERxWW5kNEZGMGtlaXVNYTdz?=
 =?utf-8?B?OUI5akNjKzVpM3k2cll5Zy8rTFF2ZjV5eFJOSGtnNE04amFaNUI1TlJPNGly?=
 =?utf-8?Q?AmojV+nfkpxVhtaQ=3D?=
X-Exchange-RoutingPolicyChecked: Vex4jh0e+xPyR1OjSe8pcOp04w1bJCXA+PyAkULV9NVBpWTpI6kJWqVRKesjr+jpLYkgFzaWKuo6dByjv8il6vHEm/WTivIGKz4tEOUm+ewX5eoK8BDA+3lucfYS57cFmnDQVcGEhUWG/2hR4GAaiy+gpwIOdqzszk+ZlOU3W2bmjcUtVcKOlGwvuTBRXLsVQuuZt7bb73+lPaDhm1gzn6NDdEIZxhBypldZO2tdXH9rFTmC95XDk6XfSIImT9gt3Nhh3xrzzO6m00p65/STEQS2MDf8uiSqk9vMCpSnKxgi04nMtxnQ+YCF38htDBQwojdx1GDQGI5QWSPxz97pCQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a7661cd-c5c8-4e7c-4ba4-08df3b5f0ece
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 17:05:56.8282 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lq5wx3g001WS/S9PLjtdCqP/W6RJyuAe1mVgXuX2/chI0MmrD957+nXCvJDNC+M7UOtJgP2DG9NTvTUfLQx4EHMY6C629JP60ywjd+58GC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5082
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/5/2026 5:20 AM, Nitka, Grzegorz wrote:
> 
> 
>> -----Original Message-----
>> From: Keller, Jacob E <jacob.e.keller@intel.com>
>> Sent: Thursday, October 22, 2026 9:10 AM
>> To: Simon Horman <horms@kernel.org>; Nitka, Grzegorz
>> <grzegorz.nitka@intel.com>
>> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
>> kernel@vger.kernel.org; richardcochran@gmail.com;
>> andrew+netdev@lunn.ch; Kitszel, Przemyslaw
>> <przemyslaw.kitszel@intel.com>; Nguyen, Anthony L
>> <anthony.l.nguyen@intel.com>; Kubalewski, Arkadiusz
>> <arkadiusz.kubalewski@intel.com>; davem@davemloft.net;
>> edumazet@google.com; Machnikowski, Maciej
>> <maciej.machnikowski@intel.com>; Neustadter, Marc
>> <marc.neustadter@intel.com>; Temerkhanov, Sergey
>> <sergey.temerkhanov@intel.com>; Olech, Milena <milena.olech@intel.com>
>> Subject: Re: [PATCH iwl-net 1/2] ice: ptp: serialize E825 PHY timer start with
>> PTP lock and incval
>>
>> On 9/26/2026 10:05 AM, Simon Horman wrote:
>>> On Sat, Sep 26, 2026 at 12:28:23AM +0200, Grzegorz Nitka wrote:
>>>> From: Maciek Machnikowski <maciej.machnikowski@intel.com>
>>>>
>>>> ice_start_phy_timer_eth56g() programmed the PHY increment value and
>>>> performed the PHY-to-PHC phase synchronization in two separate PTP
>>>> semaphore critical sections, and touched the shared source command
>>>> register (GLTSYN_CMD via ice_ptp_src_cmd()) and read the source incval
>>>> before acquiring the semaphore at all.
>>>>
>>>> Because GLTSYN_CMD is a single global register latched for the source
>>>> timer and all PHY ports by GLTSYN_CMD_SYNC, a concurrent adjtime
>> (small
>>>> offset, <= S32_MAX) or adjfine could clobber the source command
>> between
>>>> the incval-init and the phase-sync steps. In the worst case the source
>>>> timer command written by ice_ptp_adj_clock() (ICE_PTP_ADJ_TIME) was
>>>> overwritten by the unlocked ICE_PTP_NOP from
>> ice_start_phy_timer_eth56g(),
>>>> so the adjustment was applied to the PHY ports but not to the PHC. This
>>>> left the E825 PHY clock permanently offset from the PHC, showing up as
>> an
>>>> intermittent clock drift.
>>>>
>>>> Hold the PTP semaphore across the entire start sequence: acquire it
>>>> before the first shared-register access (ice_ptp_src_cmd()), keep it held
>>>> through the incval read, PHY incval init, and the phase synchronization,
>>>> then release it once. Since the hardware semaphore is not recursive, split
>>>> the phase-sync helper into ice_sync_phy_timer_eth56g_unlocked(), which
>>>> assumes the caller already holds the lock, and call it directly from
>>>> ice_start_phy_timer_eth56g(). The locking wrapper is removed as it no
>>>> longer has any callers.
>>>>
>>>> Fixes: 781ff8f2d575 ("ice: ptp: serialize E825 PHY timer start with PTP
>> lock")
>>>> Signed-off-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
>>>> Co-developed-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
>>>> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
>>>> Suggested-by: Marc Neustadter <marc.neustadter@intel.com>
>>>> Reviewed-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
>>>> Reviewed-by: Milena Olech <milena.olech@intel.com>
>>>
>>> Reviewed-by: Simon Horman <horms@kernel.org>
>>>
>>>> ---
>>>>  drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 48 +++++++++------------
>>>>  1 file changed, 21 insertions(+), 27 deletions(-)
>>>>
>>>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
>> b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
>>>> index 20bd1813650f..d3e4aeb7e496 100644
>>>> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
>>>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
>>>> @@ -2045,7 +2045,7 @@ static int
>> ice_read_phy_and_phc_time_eth56g(struct ice_hw *hw, u8 port,
>>>>  }
>>>>
>>>>  /**
>>>> - * ice_sync_phy_timer_eth56g - Synchronize the PHY timer with PHC
>> timer
>>>> + * ice_sync_phy_timer_eth56g_unlocked - Synchronize the PHY timer
>> with PHC timer
>>>
>>> nit: I'm not entirely sure renaming the function is warranted.
>>>      But it's your call.
>>>
>>
>> I agree, renaming this is unnecessary, and I think slightly confusing as
>> usually "unlocked" should mean "this will take the lock" while "_locked"
>> means "the caller is already locked.
>>
> OK and agree. Let's keep the original function name.
> Thanks!
> 
I have adjusted the code on dev-queue and I have made a note for Tony to
double check what we submit uses this name when going to netdev.
