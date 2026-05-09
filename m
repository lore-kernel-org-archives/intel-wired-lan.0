Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CC24CD37AC
	for <intel-wired-lan@archiver.kernel.org>; Sat,  9 May 2026 00:22:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 132C861C92;
	Sat,  9 May 2026 00:22:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mFkwKZ-JbzSV; Sat,  9 May 2026 00:22:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BD20861C8F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1778286151;
	bh=bkf88Wfqb8KBPOvOm73v0edjzM02ZgtvfZzYvGxAFoY=;
	h=Date:To:CC:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l2newtl5tg4+djMsQcjf++fGy5DlXnFpZHoE2hu1RgwxFyqrUEb+aJuNojHsUKMQT
	 Zu7QI+2RjZ3eHUZ45+hQn1VSXf5L04n0+UPslstxmbvMN6g/r5vyMh567PW2wUjzul
	 kCX+2EqeLJEkiyzu+95ctLEyrX8eWCHrrKDaZx+30q+4rsYJfF78Ecvic5B8TUQ8X0
	 ng6efznL1ML/ZaQnJ9xttEGJi4FCeIC7I2Ze0WQ7GOM5/baVxAOcwPajvSmHpfsZk8
	 Vabj4K3GWFIUiikq+W5H9sUdndYzuEBsuT13YSa32m8fLgcSwYS34QgUYx18yYYC94
	 JVAfg/QFMgjhw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BD20861C8F;
	Sat,  9 May 2026 00:22:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 541AE25B
 for <intel-wired-lan@lists.osuosl.org>; Sat,  9 May 2026 00:22:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 39FB061C8F
 for <intel-wired-lan@lists.osuosl.org>; Sat,  9 May 2026 00:22:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uLTqjuKl55XO for <intel-wired-lan@lists.osuosl.org>;
 Sat,  9 May 2026 00:22:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.13;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org ED6DA61C8D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ED6DA61C8D
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ED6DA61C8D
 for <intel-wired-lan@lists.osuosl.org>; Sat,  9 May 2026 00:22:28 +0000 (UTC)
X-CSE-ConnectionGUID: pKl/mYA8Sb2HzMgB7Sf2Xw==
X-CSE-MsgGUID: SMJZjPDcQx6/LBPu2h/iQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11780"; a="90370735"
X-IronPort-AV: E=Sophos;i="6.23,224,1770624000"; d="scan'208";a="90370735"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2026 17:22:27 -0700
X-CSE-ConnectionGUID: 9U5f9cGwT6awotwEX7iVBw==
X-CSE-MsgGUID: fS5woHXxSvGQQ+4GIe2zLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,224,1770624000"; d="scan'208";a="230511962"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2026 17:22:27 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 17:22:27 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 8 May 2026 17:22:27 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.33) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 17:22:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YIadrBvulDlXXLyLobY6DQnC16vfluPUVQoRAccuSVDcdrgp51hPPydpt5Hymv0yVrKrK/MU3e8zLWSkgao/Cr75d5XqDhpyRwmbX3oP3Of+wchKNq/SmV4KB6gEMdFjDnhJKp/WnTyo/7pqPLxaXSOstTfhjerRojqOVj8pYjG6QzmobbqGwa5NtUBLeXRS3IQS47wgkL+BNblyFgH9Jot8EP30sKtXYHPX1aDtDbL1lyWlxKhVjrDXhgIKgGgbkEk8KWV781DzpkQ4AxLnvtwqv9ZgxQmLu/sUBkb9P1HlA6V+/S16gkO+dQTPA6UMYhG5xkxlB5Pyb4ppyTs6ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bkf88Wfqb8KBPOvOm73v0edjzM02ZgtvfZzYvGxAFoY=;
 b=OPAIpGForPO3Pg7Kt+8jzH2jKUw/uCmmRUyWOP6+R/FWaDhL+TvtFqBd+He++Rbrq3onbfOvwny72opMV35D9H69VPDZH5qwYJssv2f0NxwPEqwI9qbue33+FCwx+vC5+KmTmDBN9NvCsMFep7OJ69O1qF77mTS6v4QUcERyjca6gfwK4VaPWv+ZgOMNMsCDAsjPYwfoiXpAWUasjm0P3flo8x/39Ry+fsnhk7UDlj6WnqWajtgnZZCuyKUuzy8fjHtab+cgwURclOEH6EwPniiaTAg2icGsaVUuSGt84chIigqXoRRbKV9jesOkiKxE/mCTk9YYtCk6iG7xbhHqPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB7592.namprd11.prod.outlook.com (2603:10b6:806:343::16)
 by SN7PR11MB7707.namprd11.prod.outlook.com (2603:10b6:806:322::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Sat, 9 May
 2026 00:22:23 +0000
Received: from SN7PR11MB7592.namprd11.prod.outlook.com
 ([fe80::3e09:8700:df72:37b6]) by SN7PR11MB7592.namprd11.prod.outlook.com
 ([fe80::3e09:8700:df72:37b6%6]) with mapi id 15.20.9891.008; Sat, 9 May 2026
 00:22:23 +0000
Message-ID: <a55c7754-43a5-4ad5-a429-61c428544b4e@intel.com>
Date: Fri, 8 May 2026 17:22:21 -0700
User-Agent: Mozilla Thunderbird
To: Matt Fleming <matt@readmodwrite.com>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Aleksandr Loktionov
 <aleksandr.loktionov@intel.com>, <kernel-team@cloudflare.com>, Matt Fleming
 <mfleming@cloudflare.com>, <stable@vger.kernel.org>, Simon Horman
 <horms@kernel.org>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Eric Joyner <eric.joyner@intel.com>, Paul Greenwalt
 <paul.greenwalt@intel.com>, Alice Michael <alice.michael@intel.com>,
 <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
References: <20260501095717.1032151-1-matt@readmodwrite.com>
 <531aec13-c33f-4e77-ab48-de8861f9b6c6@intel.com>
 <afxbZjldi1OC3HmS@matt-Precision-5490>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <afxbZjldi1OC3HmS@matt-Precision-5490>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::15) To SN7PR11MB7592.namprd11.prod.outlook.com
 (2603:10b6:806:343::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7592:EE_|SN7PR11MB7707:EE_
X-MS-Office365-Filtering-Correlation-Id: 12b57a80-d7de-46df-7ddd-08dead610a87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: pb8W2qHR5MBKSh36Ft0GYzFP62z+eGSwOKuoBLy9/BXYXuZJxOK4i3IbLgXDCnXS2fe75INdrZDtKKbjRxEMmfnBAx37v/Qv7JFrDRrbbUaEU8sG/ln86K3bks0HiVio5Fi5f4IjzwfkLJSfFuQWa6ekXpgvm4Ic6xFYU7W71yxLYKt0Lv7OQN36sEllsnW15ivd0X6PXzgV4BI/A2HRPXLM88sdoUN6B+RVbj+eOlYybZoa4shfrZH22l9czBnA5vbTOnL9DjB3jeG/dTpFYeZDTK8EiyTHate+Z8+QwZcnzM+3HOXTTi07maUnGy1DuCHoFytciMV7PZgsGCAO+Ms3fDBoqOIl7ZNGqhjXK+210uvpxd4YQDABt/RXrceWRdiGRGHn7ajL8iU7qn3RtJYm7VpAXyBLGy1nyMTLc0L068rGn9TCqC/bmTG79Aq5lWHAyO203BQZ2xRJvpqjg/f58P5XW3eEtTvlvZ7igyQ8sKVtn0MM9v519KIMsQ08qAteT8oLpeD+dhAOdLogZjdLb2OrB92SVac6VBS5OlM/qHJfGtqLX+B7gBj7qpboM8C9R7zdjvMYKroZiNFiE9ZJ1qnA3EOzt1UP0epA0lgC6gKa9PtdKhlu3z9uVCeQQkmPPfCYCAkIae/hUHnVtUWVQLr8IGUQZSJHe3Cju/6NZSkKHkT9PWGm0m2Vcw0/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB7592.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1d0Q3JsakVzTlUzWDBPMkh5cFVkQUgybndFaDBKSlF4UkRwcFBXVUNFQ1Nu?=
 =?utf-8?B?WndzSkt2NU11NWcvMEg2WjI3VXFZV1ZDQnpTL1ZLV3Y5VjBqYlVvcjVIY0JE?=
 =?utf-8?B?RXBORkkyNy80V3Qvb0o4cWg5UTgvTi94QXJMWm54dmlkd2YvTGpIRlF5Y2VB?=
 =?utf-8?B?cXkyT2dVZlZna0RaempTTldMR25KRkllS1BxT1Z1VmMyZjBoWDVvNVlSZHFZ?=
 =?utf-8?B?RDU0UGJHb1dpTUZ0UDR2d3RLdkY1RlJzdm5Yc0tqbDVzVDdSMW9XcmFuUlZ2?=
 =?utf-8?B?SnBWMU1XUlI0dWFjWTBSQkFRTHNod0lJSVk1UVpWa29uZWdmb3hxc3grNmUx?=
 =?utf-8?B?RUlUOURKb2lqZDBVaVYrUE14MkJRY2pCSnhDbnROeEJ1cG9VaGJpMkovVm5I?=
 =?utf-8?B?UVlkV2JBbXQ2ZzZuRDhQOXRUVElwUnA4MldwTk5qZ2JTUW02c0xuZVRGYllC?=
 =?utf-8?B?TEtQYkNWUjBwVHA5Y3pwT0YrNk84d0ZYM1ZmMGZaZENEcE1VYjNwRjZmTWVT?=
 =?utf-8?B?cUhiK2RTbnJML212TzZUWXFEc3V0RUxSa05xbnBvUFJSRjZYM0FMZkJSTWp6?=
 =?utf-8?B?Q3NibW9mVjRjVFZZNXFidHU0eG14ZTVnMFNMbkpwVEVSQzB0SUE2VXpkTXg2?=
 =?utf-8?B?RndtOExVZWxkNkRQY3l4YjRnejNmYmhucTErajlTVG95UlY3dFg4UnkrdXln?=
 =?utf-8?B?ZFdZYURqakdvRVJiMnpzMzRwdXJGVUNQMmFGeVlxb3l4b0t2eTR0T004czVn?=
 =?utf-8?B?VnBFVFA5NlNyT3NXWnMvT0d1TEVwZTRjandxTk1wMjEwZFVhV1F4RUJUQk5r?=
 =?utf-8?B?c1ZwMXM4a2NQdkdqV1VDQmJKcExIZnlIMEhYRDZ2b0lUc1dTWHVRUTY5QnRN?=
 =?utf-8?B?UzVWRjVTaEVZRmJKNmZqSTBJRXExMWVlVzZFdlN6TktxWVVuOU1KNHhsV2pY?=
 =?utf-8?B?amNTamM4RnZxYzR0cFpHVUN4T2xmUmdZdW1sN3pFUlROQU5iS1FJRzVWcFQz?=
 =?utf-8?B?ZC9FOTIvQlVBN1kwWUNDWXlNOFU3d0w3VURsTld6Q1Jib1NyaUJxeFA1VTlp?=
 =?utf-8?B?TFZ0ekNXcThGZ01BTVZZNDdJMmtCYVQ2c0FpU0tBZU5xLy92ME1hUzhmRWdT?=
 =?utf-8?B?Y1ZkdjZuRHpFZE5DMkFPYnM0YVJwMEtESkV3Q1RsdzhvSVFacHIrVzdLb0tC?=
 =?utf-8?B?Wmg4b2l3MTVQMmNiV05zc2s1cFBDSzFVa2Z0Wmk1UWpBNHJhVStOSWtYUnQ1?=
 =?utf-8?B?WllDV2Zyd2loTndYcC9UeWhKTlNYVDR2TFFHSlN3NDM5TS9vSlZlayt4NzFh?=
 =?utf-8?B?eUkzNEJ3bWcwYndzZ1Y4bUVVVFFSNXRjNDJmZkJzbnVLOHpsc09JUytIQ2ty?=
 =?utf-8?B?d0J4TWJ4UHA1cXJxSFZjRUpWNGl1b01kV2tBcXNoMktjeHlPNUJsSEpCYmd2?=
 =?utf-8?B?K3NDOVFKNFhER09uN0VTTlRjKzVlUWVGZXRNaGcrYk0vWHBMODA5b2JTc2s0?=
 =?utf-8?B?Q3E4V2tneWg5aFhqT0ozVjdPQ2J6Y0x6R05SUGRUcXc2bzhWMmMzLzQyYktp?=
 =?utf-8?B?TUFXSUZZSGF0cWlXNlZJYVprRmhuRE91aDVpbGZqb0xrcWZoTkFtbmJYSDgy?=
 =?utf-8?B?RnF3VkZ3T0ZMZWVwYnNoUHl1N0ZvMzBiSXVuR2lPdE1lck4wTWtpVVJESlhQ?=
 =?utf-8?B?MmluTUxXY1VJQTRsc2w3azN6QWxmYmN5c0VNcCthbURmM0JKV2ZDMnZKK0R4?=
 =?utf-8?B?RnA1dURETlpiMnZrNTdjR0t0R0xjRW5xN3VRcnM1ckRINWRNNHVIbTZHejVh?=
 =?utf-8?B?Q09NU2JLMi9veGRRYWd4Q2F0OFdYMkE5c0IyR3greHphZ0R3ckFQUkJDNlhl?=
 =?utf-8?B?WGRHOWRJTyt2eXBjcVJXbmU0STRkZTFtampWV09LcGs0UkhiVHozWGpGWmRk?=
 =?utf-8?B?WlNZaWl6NmNiR05MRDJFUjhkWURtNjdMb24vcWIzblJRUURscXlXaTBTUE94?=
 =?utf-8?B?SHp3U0ZPUGw3VWZpUCtEOWU0YndKY24rSEEwSkh5ekpPc3ljSWwzczg4NjNH?=
 =?utf-8?B?N2toTDJONWU4enhpNXlkN04wUjFyc0xpODFNYkVmNFhVQ2NpNldtTDdmb2dj?=
 =?utf-8?B?TjVnc0hMaXRoQVVUUm5IVm82QytabnZaZURFMUtFNlcrck95bGxoZWlicE43?=
 =?utf-8?B?Y241Z3pRQk8wdkxKUGRBN1VRODlXTFdwU0dMRWNzR3VGV3crWmM4WGJUT0Ur?=
 =?utf-8?B?L05GcnV0Z2pkWGViMnppVEt4L2JlSHZIeWFGN0Z0c2hPd0ppMjVySTN2eWsz?=
 =?utf-8?B?MUxYUUI1MEVNVkxPU2NhTXI3VlRmcUY2OXdjcVJPTTZzNE9EOVo4UT09?=
X-Exchange-RoutingPolicyChecked: lR5Z7RCGcGIq5NdHTM4ccpzB7ybA1qCMlX9aliSTxuKMHzJI6Fs67E5i0a+iL3eOvSRm6tr0xWGM1Q86KJckfGNjYKCi63ocOUTcu2zRsUFLUb/1Mqqutxk+oRnjY0WDuT+9YnUZmbLy+6OMYFTmaSavulLOv62D4OA1Nax7qusNUAJJI55Rtk+3WFrXY3Py9iiVlMvqXbmpMC74Nyz7H60BbE07RjegJiJzaeJhWR8fOieTYSgvHWb41GRqWAMGcoJSc6dkx/5XPGzNXi5LK0YTjHRS4W7JtJn/3Vzg3jt6NKT4hXcZmsxYInGO2JPF+0hjrBWwTjOEFyQLsYmmmQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 12b57a80-d7de-46df-7ddd-08dead610a87
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2026 00:22:23.5032 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hzqf34uL+/gbvwuYwbWiOVOIQ4ziCu1wdaNvzGKW7jV+Q2ncYv+rgYtd7naVYavW7x81jjyYGgj7Re+fVCqZj6NX+6B1k94VpYGddJSWu9c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7707
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778286149; x=1809822149;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=KDUg8VV3+b2iktAOc4/Lfi2H2n8E81Y6849w9tS8bUo=;
 b=Y+5GZrOsjWkde1mh4uTnkHFxjr/XU8XBfMEOaEYH0psUcppvw7HuOqlj
 5MNnWJ9Spj+azUG2WMAy02ZjSD160qW6GfFdMqRyPx8u59LZ3lZRZlPaY
 fdyr2bek8N6Su6j7JIYCFLU/Tk4eu2jvjbWDDIi9yAifusI6p4w2qIsfE
 iBE6wOLMpO26crNgnJLEv77LEGMbgSPw6IjKqDWtc5JuGD7rBf6vcYwmC
 Lqm9DuSxM1Yxe52+gpEr2HJH8fMw0YNbdCGhCpX13wp+aJncwLP8BULx3
 5J1mO+JnEGkmviV9ii1ynlAPuKOrHGZpw3mb119KVK0A5GWf4hkrbz7zk
 A==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Y+5GZrOs
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH net v2] ice: Fix missing 1's
 complement negation in GCS raw checksum
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

On 5/7/2026 2:34 AM, Matt Fleming wrote:
> On Mon, May 04, 2026 at 05:10:23PM -0700, Jacob Keller wrote:
>>
>> Hi,
>>
>> Based on your patch description, I assume that you've tested this on
>> real hardware.
>>
>> I dug a little through some of our internal changes history and sawe
>> that it looks like the hardware has a register setting in its
>> GL_RDPU_CNTRL register which determines whether the checksum value
>> reported is inverted or not. In E830 hardware, it is supposed to be off
>> (i.e. the checksum value reported already matches the expected setting.
>>
>> Perhaps your device somehow got the GL_RDPU_CNTRL register set to the
>> wrong mode and that results in the swap being necessary. Hmm.
>>
>> I'll ask the team to see if they can confirm this behavior.
> 
> Hi Jake,
> 
> Thanks for digging into this.
> 
> I read GL_RDPU_CNTRL on our affected E830 and the value is the same on
> both ports of the NIC:
> 
>   0000:c1:00.0: GL_RDPU_CNTRL = 0x0020a275
>   0000:c1:00.1: GL_RDPU_CNTRL = 0x0020a275
> 
> Decoding bit 22 (E830_GL_RDPU_CNTRL_CHECKSUM_COMPLETE_INV) gives 0,
> i.e. the hardware is supposedly in "not inverted" mode, which matches
> the default you described.
> 
> However, looking at the data on the wire I see:
> 
>   - netdev_rx_csum_fault fires ~65 000 times/sec on this host.
>   - bpftrace at fexit:ice_process_skb_fields shows skb->csum =
>     swab16(raw_csum) directly (no negation), e.g. raw_csum=0xfb4f
>     -> skb->csum=0x4ffb.
>   - At fentry:__skb_checksum_complete the upper 16 bits of skb->csum
>     are 0xFFFF on every TCP/UDP packet -- the signature of nf_ip_checksum
>     adding the pseudo-header to a value that was the un-negated raw_csum.
>   - fold2(skb->csum_at_fentry + skb_checksum(skb,0,len,0)) ≈ 0xFFFF
>     for every packet, which means the two values are ones-complement
>     complements of each other, i.e. the driver stored S where the
>     stack expects ~S.
> 
> Negating the checksum makes the failures go away.
> 
> Thanks,
> Matt

Ok. This is getting strange. I checked a system I was able to borrow. In
our setup, we need the existing code (no negation), otherwise we see
checksum failures even for simple pings, including the initial
DO_ONCE_LITE stack dump, but I can see with ftrace that
netdev_rx_csum_fault is firing every packet.

I have the following on my system:

> $ lspci | grep Ethernet
> 17:00.0 Ethernet controller: Intel Corporation Ethernet Controller E830-CC for QSFP
> 17:00.1 Ethernet controller: Intel Corporation Ethernet Controller E830-CC for QSFP

> 
> $ devlink dev info pci/0000:17:00.0
> pci/0000:17:00.0:
>   driver ice
>   serial_number 00-01-00-ff-ff-00-00-00
>   versions:
>       fixed:
>         board.id N31483-000
>       running:
>         fw.mgmt 7.9.5
>         fw.mgmt.api 1.7.11
>         fw.mgmt.build 0x2bbde9a9
>         fw.undi 1.3910.0
>         fw.psid.api 1.20
>         fw.bundle_id 0x80017eed
>         fw.app.name ICE OS Default Package
>         fw.app 1.3.43.0
>         fw.app.bundle_id 0xc0000001
>         fw.netlist 0.0.1100-2.53.0
>         fw.netlist.build 0xf77b1d74
>       stored:
>         fw.undi 1.3910.0
>         fw.psid.api 1.20
>         fw.bundle_id 0x80017eed
>         fw.netlist 0.0.1100-2.53.0
>         fw.netlist.build 0xf77b1d74


I checked the GL_RDPU_CNTRL register, and indeed the checksum invert bit
is clear, matching your report. Even so, I see the opposite behavior you
do: we need to avoid the invert otherwise the checksums are reported
invalid.

Interestingly, I tried writing to GL_RDPU_CNTRL to set the invert bit,
which appears to have stuck but it doesn't seem to affect the behavior.

I wonder if there is an NVM difference here. It is possible that our
boards have a pre-production image still installed, and that might be
impacting the results. I've asked to try and have the devices updated to
confirm the behavior...


I'm suspicious that somehow there is an NVM setting that toggles this
behavior and which doesn't seem to respect the actual register setting.
I haven't been able to track down more information in our internal
documentation yet :(

In the mean time, could you share the device ID and firmware data from
devlink info? Feel free to reach out to my Intel address directly if you
don't want to share something on the public list. It would be very
helpful to know the device and NVM data from your setup so that we can
try to replicate it here.

Thanks,
Jake
