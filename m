Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE2BBC624D0
	for <intel-wired-lan@archiver.kernel.org>; Wed,  2 Sep 2026 11:26:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 73D40607B0;
	Wed,  2 Sep 2026 11:26:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aZNjCTJ0HBgc; Wed,  2 Sep 2026 11:26:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788348389;
	bh=SQ6KHOqh0bqkErP6PcpbFd94o3FhY7HRyHc4scOMqvk=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tJM+tWKLAzqWUMw3wU2Z5z+Xd0EJN4egMkkQlGFDQHo9YRxlGeox8K+6mKWfYGYrF
	 FSAxo9sUH2JkEQpIXLYFr1ENuh2sMAGiivQbZrJDXHkVynusiqWXpyWE3646hDe01O
	 i2Ic0welZ98YxjAuWQ864tZeEPuMABKtikzP/HudAd1ZPhpvkk9GOYtSPQsr50ot9T
	 t2M4WrtuXpmfISYl+v+zcboi3FgjIizOmmKlbJNTJR3hGq4Gfi4DkWwZMRItl72iEx
	 0ZI6jbWiR0XNqpcAuoTSpsO7+7BZ6VW9mExlUmQVVeyBXsHi/45Rk6pPLfG/FCzjgh
	 ybgyHK9XNaC+w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9471760726;
	Wed,  2 Sep 2026 11:26:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3299C118
 for <intel-wired-lan@lists.osuosl.org>; Wed,  2 Sep 2026 11:26:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2FDCE40815
 for <intel-wired-lan@lists.osuosl.org>; Wed,  2 Sep 2026 11:26:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9HqYzfAeHgKn for <intel-wired-lan@lists.osuosl.org>;
 Wed,  2 Sep 2026 11:26:27 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.17;
 helo=mgamail.intel.com; envelope-from=avigailx.dahan@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=GJkRiAXP
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E4EBF40810
 for <intel-wired-lan@lists.osuosl.org>; Wed,  2 Sep 2026 11:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788348387; x=1819884387;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:mime-version;
 bh=E0IG2/2l7Vk1+uRNeJCoXajEpLf8S+LLexHDTLzKmxU=;
 b=GJkRiAXPQF9RecihLocKr9PbDYTdd1lnK1s2ZddHFRPTWAHWOC0iBciP
 6B/bSRwdRiGQoEmAKpk6eRZVkRElZLXgoNr5dFcjj8bgZliqLrdOPXr8f
 o4OVQT3czsRdxqJqk7NzpVd6EbeqEmB+04lqCqWFmPnvdZzhTazTWFc9i
 yi5XbVD+QgHPH4rNnAqj7wUiKojU/38ryQng+rpONXjI3ssMSWjyq9nOq
 +SdpO5IaYBLh8tIuuTUsf9/KqiaQ1I56UGJ3GOrCsH/DE59gt5/COU7Yk
 sZM+DoEZJ5h0UIwncYEgfArgvM0I1fMibJJiKdk2kEBXMniqzi7RjC4dQ g==;
X-CSE-ConnectionGUID: iuGRCf1GQP+lAnnTKJmiuA==
X-CSE-MsgGUID: BjO3gwfaStuZNlw30+ix3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="88679789"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208,217";a="88679789"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 04:26:24 -0700
X-CSE-ConnectionGUID: nix3MGkHSLW5nf+JiEnOXA==
X-CSE-MsgGUID: jwVM0KWQRxyv7rYyVnpBig==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 04:26:24 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 04:26:23 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 2 Sep 2026 04:26:23 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.20) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 04:26:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uHmEmZSVnlzskcJuLSzw9ca15WVQdgotgp+18eo1HuTClHLVgx2vOYvFf2oIOLYH1sLyKYw+F3KU/BhGndhzstmq083DlTpX9wS46AZZOSNVpr5domdSH/gjvr+H7e3gDuIpHWQzCv7Q1VxsJUrq5XvFhkF5YJKwjkHtP5vXCGjRTKcKHqjvtFg89IQvp3tss9wtqI8gkRpiGax2kaSidW3c8aObNIPVyhYRTAziHDB/aM5izAxUzi8obP9IZ3EB0ETueFM4O2MaGmLb4aLfFXqHlPPz/C2di+DGE9CUSbIDiLFgqfWFm67IJtprzmYCstKs2mrzSYIQerEWty3Axw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4olPrEDwZzsp6Hb4QXsi6jv354DB4I2skuoPZBL5GY8=;
 b=IaziRGfsCnvG9p368rlGNElsSLI47UFJcBbJjz0TaDd80XaD5aW+9xEBw2RR2/7U8zHdANjHbHT0lqnPKtQxxsAT6nFt8mYxcatlWqdpjuNysEbpl8sHgsS8MNso8hDHuFa5s8WNQVuy4/lprM2tR7gdTCv5XEZ+bFiAgtyMFEx3FZ1G3VNc+7jSWadhXtDVMu2tkUG7Dqww6+SzT1se7g8d1tX2+FlEDMrsqBaE97bTSGRlz6zNydD5Vu7EJzcMUaloK7LEDZXdYB5lzVHJLd7eRJvI3XXsmdgHsVgXp9l/t5vlxBRZ2fnwELigYIFy5i7gusYQjKAhtEPmV6EeUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8013.namprd11.prod.outlook.com (2603:10b6:510:239::8)
 by DS4PPF93A1BBECD.namprd11.prod.outlook.com (2603:10b6:f:fc02::3c)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 11:26:12 +0000
Received: from PH8PR11MB8013.namprd11.prod.outlook.com
 ([fe80::26a5:58f7:7e5d:5572]) by PH8PR11MB8013.namprd11.prod.outlook.com
 ([fe80::26a5:58f7:7e5d:5572%6]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 11:26:06 +0000
Content-Type: multipart/alternative;
 boundary="------------pPbkuPLi0SWrhqDca07Lk5uT"
Message-ID: <b1625848-4207-44a7-be1e-435afe483a4d@intel.com>
Date: Wed, 2 Sep 2026 14:25:59 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net v2] igc: Fix RX HW timestamp
 reporting when NET_RX_BUSY_POLL is disabled
To: Ding Meng <meng.ding@siemens.com>, <anthony.l.nguyen@intel.com>,
 <przemyslaw.kitszel@intel.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <jan.kiszka@siemens.com>, <florian.bezdeka@siemens.com>
CC: <intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <wq.wang@siemens.com>, <pmenzel@molgen.mpg.de>,
 <stable@vger.kernel.org>, Aleksandr Loktionov
 <aleksandr.loktionov@intel.com>, Piotr Kwapulinski
 <piotr.kwapulinski@intel.com>
References: <20260630112056.885071-1-meng.ding@siemens.com>
Content-Language: en-US
From: "Dahan, AvigailX" <avigailx.dahan@intel.com>
In-Reply-To: <20260630112056.885071-1-meng.ding@siemens.com>
X-ClientProxiedBy: TL2P290CA0020.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::9)
 To PH8PR11MB8013.namprd11.prod.outlook.com
 (2603:10b6:510:239::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8013:EE_|DS4PPF93A1BBECD:EE_
X-MS-Office365-Filtering-Correlation-Id: 300b6bd2-358f-414f-0253-08df08e4fab7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|366016|23010399003|376014|6133799003|10067099003|5023799004|8096899003|18002099003|11063799006|56012099006|13003099007|22082099003|921020;
X-Microsoft-Antispam-Message-Info: Har9C0Wk/5MT9w3Yvqz2sl0NbwGMiuondUgn4B/Ah4vd3vybPinXJsf3vvhN5r7MuLUZORGRMmV+67gU2jswB0TD5f6UPNJjBjBjX/u4BDKi80RPi6JrNHiXhfoQQKrNCrqj+HyEGTnK/IyNAObx2B7ZUQzYNRXDDwh8l5zlON9y2uJUUnLs4pSE0rDk1GtHKg/WSoVdtwZf1Q3dzqUUQ7yK5umnI5sfpOerTy29GUWbY4bHj0nQkV2JtxKnN2j0A0OtZS1LuyKemK0lQsiONJN6XHkRwczU4L8QGtM9XUguEkNDZFPo5C2CuDh/ykA+5mJTA0TiUZUslU0009OyVe7GQ9a+4rbCGlYVupHlDgGBBtbOYeII2GcGQGW3XelXyimI/klZ4OfkU0Lw10wbgJ+SjTQ8kYZR3GpZRckVrp2ov8kHhPjlgB4u0C/PgrX4Ahrry+jXGNZx8K4XDY/3l3jH5kXoLgdyrA1RYQvgVjmqlY+RRiQ4C1mlYiTsD+jeLZM5ba1U5cw4HXZzabD9U6FJPenk5AlWFvf4piZZxNKWyLH18U/awh0olvjK1OjR2F5wmY7boAHN/3yIiuxKpDwaisjmUGVEo+QErFpUB5UjH7zIMvMhbhdVZYf7S5yAKMCSiLZHLeEwuA4VxTFwiFsD7cvvSM+qaeposohRCq88UUTtJHM9gj6pED9qDV5FZ5Pq6+w/oLkV2xp3/e2AEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB8013.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(366016)(23010399003)(376014)(6133799003)(10067099003)(5023799004)(8096899003)(18002099003)(11063799006)(56012099006)(13003099007)(22082099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NU1ZNGxUVFpiLytUQVFkbG5xYjc1MmNPYzNGZG02ZUlrTVM4WE9VaENMc3Bq?=
 =?utf-8?B?S1EwVGF4Kzk3YzhMblhUYU9wVXVieWFRVk9NZzlLMytZT1ZmTWJXNzZrRE1Y?=
 =?utf-8?B?RmhTVWtJbnNFc3pld0VRT3VWVmJLdmJxTDB5N3Y2ZXBOVy90bkV2SzVYL2xR?=
 =?utf-8?B?Q2g5aUJ4ZThVSzBPMDFiS3J0Si91cnMyekFIWFJEM0orTHd5a3dsWTZQRUVB?=
 =?utf-8?B?TndjUU5EQlhEWjJKUkJGOE45RExMKzg2bk9HNEFOWTdSbFVQSXRsdE1meGM2?=
 =?utf-8?B?NGxJLzJCS2N6enBzTFhETWVmR012eEpFSmlQYzRSd3lBTHEzejl6cjNMcWQv?=
 =?utf-8?B?RVhnVEZYcEdpR0F2NkF6L0EyWFN1dFIvNjR0dWxtMGhmQlJpSnhpOThCRUtP?=
 =?utf-8?B?YmhVMzVaakRVRHVvVENRQ08wTmw4aTMwd2pDdmdRWU1KV1JySWxVUmZ1S3pN?=
 =?utf-8?B?eFJJalNFRVc2VVFjQUFvc05XZ3NWYmorTFh2Ny8zc1kxOURuMHBCQVdPVUlm?=
 =?utf-8?B?aE5PTVN3NmdjRk05UnAzRlV2NU5heFBHUUxvMElnZENtNmw5OG5nMkdTa2hQ?=
 =?utf-8?B?ZmhXZ09YOGdsVGpTVEtvT205NkRzWEYxaHJiM3VkTDBQSzFYWFYrWHYybmpS?=
 =?utf-8?B?SEtwdnN2NDE1R0xGMkRSdWRIK2hRQzV4WmxacjFlVWg1US9IK1RjL3g3K2Ji?=
 =?utf-8?B?WDVoL2pJa21wQkYvZVZmcmJndVFEOG4yRk1maWtJRG5qbFplQW52enhndXZm?=
 =?utf-8?B?U1lFTE45bEFzdjhGd25ZVSt1RGNuZnVIamM5a1Q3SUZ5MTJETE9LbU9acmJV?=
 =?utf-8?B?enV2Q3Q3RE9LeEt0ZytSMm9rM3VsSGJuY0s2SVNCVU1nSlFZczRPTzNNTXo1?=
 =?utf-8?B?RUpFbG50QVNTTzdBVlArL08vWnpyS0lVMFJrWFNQQlNlZnZUMWlrYzFGbmRM?=
 =?utf-8?B?VUQyOENtL0tyZnQ0RDU1RGV3Snk5akY3Q0p1eDdEbDJJQUlxbW9NVVZsYlps?=
 =?utf-8?B?UkJWWjlldTVsSm84ekxRVlplcUFtSXU2Z3FoSzFVTW0wS296QnJhQmQ4dXdo?=
 =?utf-8?B?SlkvZUlzb3JCWkxkQld4TEJaSDVWZWtuSDAvZWJmZHVXMi9GTUhtZE1HclVF?=
 =?utf-8?B?bXR2bWV3RmRkNW1BdWlPQXRQNHFpRjIzb3k4TlppRkpsQUlvdzh4V0QvM3Jr?=
 =?utf-8?B?RVRzSS9iWlMwYUpDTkZyaHRjS2hUK1dFVks5MndHUlo3MndYeGQ1Q0NlTnFs?=
 =?utf-8?B?MlZzaHV6clhpTlQwcWJzUkp5TGc2M0JwUkdlaUM4M0krbm5hM1UzclYzR3dC?=
 =?utf-8?B?UWhxRmg1VWk0akZiYllteWt5c2N3TzBjcllMUFpNOWwyTDdZMnRFV20yVkxl?=
 =?utf-8?B?SXlEWXY2K2hOQk9YWVRoZXBLTVozMmxXWmUySnlIOUJ3WFoxQVN5WUdiaHRG?=
 =?utf-8?B?K3ZGQkZKSEtlMDEzaER6c1duWER5Nk1lN0xzSGdpVHpadE5aNVplNUVtSjVt?=
 =?utf-8?B?alp6MzA0MDhDQ3Uxc2orK0RjVkFJK3A5SzY0dUc3SUNrZ0hYd2lId21yZGdE?=
 =?utf-8?B?dE45R1lRc2xQVUNCa1g1eTRvQTJTS3pQdnUxM3hyTG1md1BkRHplK3lscW9N?=
 =?utf-8?B?VUVER3dXcURhdUNnSS9Wb0tBcDF6VENlRGdTMVhwVE5VS0VvRWdmei80QXhQ?=
 =?utf-8?B?R2U4SGkrRG51VE5iaUJ2blBVbnl6anFPVTMxQ3ZUMFBwQVVJdzdVMFYzWkh1?=
 =?utf-8?B?SlhYbE5HUkxOMCs4SUFpZys0WlByTlJpOVV4U1NXaTRlUHV3OU01UkFpa2FW?=
 =?utf-8?B?aGJqL3RBRWpQOW1zWis4Z21wb2N6SFNwQ1VvVEZIWTd4RGI5Sm9YcE5ZWnl4?=
 =?utf-8?B?L0tPckc5ZDlDeGpRQzdZbG9CQkRwemZIR1JBeDJKekMyYk52RzdQZ2xVTW5Q?=
 =?utf-8?B?d05NN25VZVR6TGtEdnQ4ZWljV3AvM3BHU0dOT0ZTaHI0bG5OS0R3RGFPVmVm?=
 =?utf-8?B?MWpueDhUYy9tVnpIZ014L2U5a0tuQUdlMmEzdHpVaTJLUGxNNUh1WDJ3SGdS?=
 =?utf-8?B?ZDZLTzJFZEJFVzJobjNLSDFkRWY5c1FueEc4YmRJelVIRDI5WlJYZzlvdE9X?=
 =?utf-8?B?VlhNeTY5N2d0Q25KSkRVK3M0TnljM290NUpCY3pUSkozdlZRZTJkUFluQkJC?=
 =?utf-8?B?VmtLblQwUFBPQ1pBa29yRFM1aGZFN09LSmJQaGdkRTlYUTFRUTV2ZWZmUGps?=
 =?utf-8?B?dkRXbVhpeG41dEVHUUlKVDhXbW10clA3S0g5ZzdtcmhmME8wL3ZzNktrWWRG?=
 =?utf-8?B?UzFBOFFNdnFESC9MS0ExVEZ3VWdjNGxWY3VldHNad3ltTmZYYS84cUJmVkxD?=
 =?utf-8?Q?PZCgJfHSmROL28iY=3D?=
X-Exchange-RoutingPolicyChecked: cULq7aSiIPerSh/QG9Oexxf3MI9r+d8PBGOIESFtOWbr4nn1JMinpEW1jIc+Wi5345IndddVIhSKtNYy79Lf8a6v+Pfkn4XMj2sD7/ijoPMLudTAcY9eBHttN3qMrgWLxRt5v/bIHMU0vXq5eISW1xT+ZuCrmwKRFlsb0ZBK0gKNjVcIPO9sjKIivHlWy2iXG18zBJ33jVrMxj/9Zipz6PAqghx/rI+ARpks7OzFSe8CX9tyLIWSaecC7Zu42/ZbKFZK+5ApY9PvHGKPO4/XB7f4/z8ehaZJlX7NID2gctq5lMb70MrHYh0D/UjUn9QeT3sP2YW9TJE6+mlug8G87g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 300b6bd2-358f-414f-0253-08df08e4fab7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8013.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 11:26:06.5138 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YLA/8UUkpCnhWIpH8d5eCqkl9YhhG6tyuL7on3gruyiRY/Paqhab2h9PFG+emg3b/L8hL7oAquPUS76T4CcA/P45s878K9mjh9PS3EKFQMc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF93A1BBECD
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

--------------pPbkuPLi0SWrhqDca07Lk5uT
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit


On 30/06/2026 14:15, Ding Meng via Intel-wired-lan wrote:
> When CONFIG_NET_RX_BUSY_POLL is deactivated, fetching RX HW timestamps
> from the NIC no longer works as expected, often resulting in incorrect
> or negative values such as "HW raw -121948.050407424".
>
> This occurs because disabling CONFIG_NET_RX_BUSY_POLL disables the
> SKB NAPI mapping in __skb_mark_napi_id(). Consequently, get_timestamp()
> fails to perform its driver lookup, and the igc driver's struct
> net_device_ops::ndo_get_tstamp is never invoked.
>
> Instead, get_timestamp() falls back to use shhwtstamps(skb)->hwtstamp,
> a field that the driver has not populated. This results in incorrect
> timestamps.
>
> Fix this by populating the hwtstamp field with the correct timestamp
> in the default timer when CONFIG_NET_RX_BUSY_POLL is disabled.
> The "igc_adapter" is passed to igc_construct_skb() to enable
> igc_ptp_rx_pktstamp() to access the necessary adapter details for
> adjusting the timestamp.
>
> Test case:
>   Disable CONFIG_NET_RX_BUSY_POLL.
>   Sender:
>   # tools/testing/selftests/net/timestamping en0 \
>          SOF_TIMESTAMPING_TX_HARDWARE PTPV2 IP_MULTICAST_LOOP
>   Receiver:
>   # tools/testing/selftests/net/timestamping en0 \
>          SOF_TIMESTAMPING_RX_HARDWARE SOF_TIMESTAMPING_RAW_HARDWARE PTPV2
>
> Before patch, receiver prints
>   HW raw -121948.050407424
> After patch, receiver prints
>   HW raw 1760648763.746974064
>
> Fixes: 069b142f5819 ("igc: Add support for PTP .getcyclesx64()")
> Cc:stable@vger.kernel.org
> Co-developed-by: Florian Bezdeka<florian.bezdeka@siemens.com>
> Signed-off-by: Florian Bezdeka<florian.bezdeka@siemens.com>
> Signed-off-by: Ding Meng<meng.ding@siemens.com>
> Reviewed-by: Aleksandr Loktionov<aleksandr.loktionov@intel.com>
> Reviewed-by: Piotr Kwapulinski<piotr.kwapulinski@intel.com>
> ---
> V2:
>    - update commit message(suggested by Paul Menzel):
>        add error log
>        explain why need to pass igc_adapter
>        add test case
>    - move variable declarations on top of the function
>    - Ccstable@vger.kernel.org
> V1:https://lore.kernel.org/intel-wired-lan/20260622041718.6106-1-meng.ding@siemens.com/
> ---
>   drivers/net/ethernet/intel/igc/igc_main.c | 41 ++++++++++++++++-------
>   1 file changed, 29 insertions(+), 12 deletions(-)
>
Tested-by: Avigail Dahan <avigailx.dahan@intel.com>

--------------pPbkuPLi0SWrhqDca07Lk5uT
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 30/06/2026 14:15, Ding Meng via
      Intel-wired-lan wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260630112056.885071-1-meng.ding@siemens.com">
      <pre wrap="" class="moz-quote-pre">When CONFIG_NET_RX_BUSY_POLL is deactivated, fetching RX HW timestamps
from the NIC no longer works as expected, often resulting in incorrect
or negative values such as &quot;HW raw -121948.050407424&quot;.

This occurs because disabling CONFIG_NET_RX_BUSY_POLL disables the
SKB NAPI mapping in __skb_mark_napi_id(). Consequently, get_timestamp()
fails to perform its driver lookup, and the igc driver's struct
net_device_ops::ndo_get_tstamp is never invoked.

Instead, get_timestamp() falls back to use shhwtstamps(skb)-&gt;hwtstamp,
a field that the driver has not populated. This results in incorrect
timestamps.

Fix this by populating the hwtstamp field with the correct timestamp
in the default timer when CONFIG_NET_RX_BUSY_POLL is disabled.
The &quot;igc_adapter&quot; is passed to igc_construct_skb() to enable
igc_ptp_rx_pktstamp() to access the necessary adapter details for
adjusting the timestamp.

Test case:
 Disable CONFIG_NET_RX_BUSY_POLL.
 Sender:
 # tools/testing/selftests/net/timestamping en0 \
        SOF_TIMESTAMPING_TX_HARDWARE PTPV2 IP_MULTICAST_LOOP
 Receiver:
 # tools/testing/selftests/net/timestamping en0 \
        SOF_TIMESTAMPING_RX_HARDWARE SOF_TIMESTAMPING_RAW_HARDWARE PTPV2

Before patch, receiver prints
 HW raw -121948.050407424
After patch, receiver prints
 HW raw 1760648763.746974064

Fixes: 069b142f5819 (&quot;igc: Add support for PTP .getcyclesx64()&quot;)
Cc: <a class="moz-txt-link-abbreviated" href="mailto:stable@vger.kernel.org">stable@vger.kernel.org</a>
Co-developed-by: Florian Bezdeka <a class="moz-txt-link-rfc2396E" href="mailto:florian.bezdeka@siemens.com">&lt;florian.bezdeka@siemens.com&gt;</a>
Signed-off-by: Florian Bezdeka <a class="moz-txt-link-rfc2396E" href="mailto:florian.bezdeka@siemens.com">&lt;florian.bezdeka@siemens.com&gt;</a>
Signed-off-by: Ding Meng <a class="moz-txt-link-rfc2396E" href="mailto:meng.ding@siemens.com">&lt;meng.ding@siemens.com&gt;</a>
Reviewed-by: Aleksandr Loktionov <a class="moz-txt-link-rfc2396E" href="mailto:aleksandr.loktionov@intel.com">&lt;aleksandr.loktionov@intel.com&gt;</a>
Reviewed-by: Piotr Kwapulinski <a class="moz-txt-link-rfc2396E" href="mailto:piotr.kwapulinski@intel.com">&lt;piotr.kwapulinski@intel.com&gt;</a>
---
V2:
  - update commit message(suggested by Paul Menzel):
      add error log
      explain why need to pass igc_adapter
      add test case
  - move variable declarations on top of the function
  - Cc <a class="moz-txt-link-abbreviated" href="mailto:stable@vger.kernel.org">stable@vger.kernel.org</a>
V1: <a class="moz-txt-link-freetext" href="https://lore.kernel.org/intel-wired-lan/20260622041718.6106-1-meng.ding@siemens.com/">https://lore.kernel.org/intel-wired-lan/20260622041718.6106-1-meng.ding@siemens.com/</a>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 41 ++++++++++++++++-------
 1 file changed, 29 insertions(+), 12 deletions(-)

</pre>
    </blockquote>
    <p><span style="white-space: pre-wrap">
</span></p>
    <p><span data-teams="true"><span style="font-size: inherit;">Tested-by:
          Avigail Dahan <a class="moz-txt-link-rfc2396E" href="mailto:avigailx.dahan@intel.com">&lt;avigailx.dahan@intel.com&gt;</a></span></span><span style="white-space: pre-wrap">
</span></p>
  </body>
</html>

--------------pPbkuPLi0SWrhqDca07Lk5uT--
