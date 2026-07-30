Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF51DC54FDF
	for <intel-wired-lan@archiver.kernel.org>; Thu, 30 Jul 2026 07:42:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 908DC607B1;
	Thu, 30 Jul 2026 07:42:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gUdCiGyEzX8u; Thu, 30 Jul 2026 07:42:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CFCD660794
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785397350;
	bh=6vPo85ThYaRyqGQs1x9A8JW0OXH0ceqdtdKc3iNp/nE=;
	h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=6wBFyE8XpWe46MWVKsy5hAT1P4O9vcmlEmEYv2OLYgMrPHqGseKGVJxWh7Jp474gv
	 zF/fuec+Ps5kwG26CGqDv3sDPuMuew/fAkQFRA//y0/+Jo4W0vlYVs1FGsLArVM7eZ
	 1yg7091IJb99YvKxufEWcihMNMyT7Eexqb7kGPysNh73zYrdM7UPWitB+p1djZGHMj
	 Wg5HWDGS7Z4CYK338zEYgBFLHh8vOkdA/J6x8OqPwm9200cHYmWuD7znset8p1r2Pq
	 ZHhDStkXI6BiwD8X8H/v3XVDPFz1v4rwhwzF48ZRlkAOEi+iD9gjPiokoJm8d8LiZR
	 AG4r/0F+/GeEw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CFCD660794;
	Thu, 30 Jul 2026 07:42:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E7170350
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Jul 2026 07:42:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CD39860794
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Jul 2026 07:42:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YYO7XRJZx1sS for <intel-wired-lan@lists.osuosl.org>;
 Thu, 30 Jul 2026 07:42:29 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.13;
 helo=mgamail.intel.com; envelope-from=sx.rinitha@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B4FCD605DB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B4FCD605DB
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B4FCD605DB
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Jul 2026 07:42:28 +0000 (UTC)
X-CSE-ConnectionGUID: xSthsAcqSj6wzpmtXt7Lmw==
X-CSE-MsgGUID: roTLxUz0S/SXneXbVqkV4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="88549156"
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; d="scan'208";a="88549156"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2026 00:42:25 -0700
X-CSE-ConnectionGUID: KBGLnTdeTHWS/hUFeB9EPg==
X-CSE-MsgGUID: RozBi8X+TVumD4MdtbaTsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; d="scan'208";a="253898510"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2026 00:42:25 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 00:42:24 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 30 Jul 2026 00:42:24 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.40) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 00:42:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=epQOepc79/3D+7FDI8cfSX2tLjUWjNVjVprPL2uPFhuWt0v2bFB1vNGAPfTZZP1P6q6GA9NoUO/KEHUMyjAviPsuhKW7IOgmGcs2m4yPn3VC/48mcMf4eykFAXLQtW00pTViDEk8U52WlDiUUchAokAtaFj3KWWJBjNIIYxLODVBFq4/rj75Ssy1uLbPqL2OiNsFPnfkoQsqow8iSwGJlNd2AZFNt1aprp3/5R3quf6ic8/xqquJgY/Wjtf1lUIQFG0iOTjfCsTMlIRDMZ8PuoriETdTpAE4VC6KCRVfkIwELisfsFw5i7BmcQB3dAqPAhaJjjtDDMekJ075b3rLTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vPo85ThYaRyqGQs1x9A8JW0OXH0ceqdtdKc3iNp/nE=;
 b=qdy+kFSwFiNBWPcadZL0/Ng4tiGu/DbV1SrlcDls08Oj153qfJDQpBizmzi78v7hC2ZfOSif+6UV7NyO9/uANIUy64J+b4PU2UEXL9TmPAYz/8Kv24J62OkLwDEG+jN/jyCR3L7WTpvr0MyJkXEQkDRJR83UNBKiG2q1FbnMU+XxCpIqGcTwkL7AITt0pPqHng8puGp7prCKDwcwn9WM005eSQeVv79GC88Drw4YlNysGjZ+NNlyWVwRNqXFrqF2h6Oz4GOnO1QY9ToYdYjZpHvSAlx+a61G11Liq6DmEWQTZ65bKac+fEPUhlYl2wpvP5fZwvCWksulJCuzLJvL4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by MW4PR11MB6888.namprd11.prod.outlook.com (2603:10b6:303:22d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.14; Thu, 30 Jul
 2026 07:42:22 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%3]) with mapi id 15.21.0270.009; Thu, 30 Jul 2026
 07:42:22 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Loktionov, Aleksandr"
 <aleksandr.loktionov@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Simon Horman
 <horms@kernel.org>, Marcin Szycik <marcin.szycik@linux.intel.com>
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v5 2/4] ixgbe: fix cls_u32
 nexthdr path returning success when no entry installed
Thread-Index: AQHc5J2+OZXKNx+/kUCaE+YJ3WRawbaGIglw
Date: Thu, 30 Jul 2026 07:42:21 +0000
Message-ID: <IA1PR11MB62417AA148D3DCE4032761148BC92@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260515090000.5112345-1-aleksandr.loktionov@intel.com>
 <20260515090000.5112345-3-aleksandr.loktionov@intel.com>
In-Reply-To: <20260515090000.5112345-3-aleksandr.loktionov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|MW4PR11MB6888:EE_
x-ms-office365-filtering-correlation-id: 32d1825e-2e12-4d55-f8d0-08deee0e1742
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|38070700021|56012099006|4143699003|11063799006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: v8JHzNZ0szz+Gt130A2uWGap8/lnWIFarTcS/Tf/QW65GIMqUoFZEr4SSJzXq8+7hGkwB0A+pgwVwWZB45dqP3CBVMJVbXaU073fehducHwfnd2v0r4DwQ05Q4KiDy5Yqc95plcGWwKKYPyl4tHAV7ZdSZDu+bqXGbMCu+WIdNrJWtSXpbuaPSrOn/4I0g4TPqRfYMe4LvCqdC3ArlY17tPicsTTR1vYJn3k68W7l1WIQzM24fOLXZe0Df8vdmzVnWz9WBWRzM+g8AMs24NUyH9/QuYaWqMqsIFyqo8aqmRWPoB73VT2knMyxNSbffUGddCgyy8aBBtp9nnUSoaF8MW/Vi/sokX2tTGzfE5XYDKxoygQTH4zYZWSoU0r8VcHHg9/XFMhdy85NGGHIzZdigbu2gHQzbePM5WTdyu6A2wzA6b+CSI1o+9N6wm3VAAZ1xPCuoIsP4NqKB7Jm/oYFc5gG3XfGEOjrl9OofbeQP9F2Ry27L4E8ocLNyPWkGFwZDUY93VE4K1kzcu72HOR8pT694JYqU5AJ5ynv7+xNDuv1tTszmpMhOcSsmv1gDDaYAwCyx1Yz38yQ6/UT29jzA2LyowUj3FG4rpAhDXTkkR4UTNOJntGNXt0nPgXZRQrF5rJ7J/blWKqpDw//RT25zX4OMdcJhAmWlHYQkCFNpibXiOJBCZdIDevNiNrR89r1qn49BC9WLvqVTiuJEfaKLSIleitr8BYRo3vJccvD8Y=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR11MB6241.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(38070700021)(56012099006)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TlYzS1dXOGFiYk9uOU0xaWlwb3cyL0E0eUJJUU1aK08zTWt0cnR4TGw1ZGJx?=
 =?utf-8?B?TzlESWgxN0haMHU3WUN4M0RzVnRFZVg4RWRZSnpLUU5wSzF1d3ZVeFY3ZDVL?=
 =?utf-8?B?c0tiUkZPTFdrYXhZZi8zaFNUM25wa2xvRjg0RlQ5d2pEK01aZ3JFbmc4QkQw?=
 =?utf-8?B?Vm9oTFFtUjBZalhrTmNhY2RxRmhaVVBZTzJUUDRvSFRORmdBeExPNFh0MjBz?=
 =?utf-8?B?eXlndXNmU2RlUm5NSW5Pa3p2Z1NqZWJPNkhxa09Dd2pqSnZhaHBqQnVsUzFy?=
 =?utf-8?B?ZTZ5NDQwOWozWS9LODJEYW1VWE1sRjVTeWlGeFlwb1Y5eHNCQVFqOGZIc1I1?=
 =?utf-8?B?UlNhcWZtVEVsSzdWV0pUY2FlT25GQkFrQXkvOFBNbUlzVFZZK3JVTWx3dmQw?=
 =?utf-8?B?M0U3VkZDVnEyd1lKdGJtK2ZnZmhyQVJqTXhLSGFNWjNLR0FMWW9Zc0FBZUlw?=
 =?utf-8?B?N0FFTUVMK3EwUUZnN2Jra1FsWVdtMHgrYW9nUVNLSE03aGtHcnVtN3gxN1Nu?=
 =?utf-8?B?THJGamlCREEwdXZ2Z3hDdUFvTjcwanpGRHJNM2R0THFvRC9lNS9tSkxmRHFW?=
 =?utf-8?B?VFZWRjFzTDhBZTZLeG1tRGdSWGZDUU5hWDZRVW5laStXTXVKdklVTVhrdnBi?=
 =?utf-8?B?NmF0c3NGNWRwaXZ2dmZBQTViVXl4RkRqUG0zYmdGcWh4TmtDWlArSzAxQmJw?=
 =?utf-8?B?RU5xOEFvL0NrSmx2cEFRWEtpUkpNRjBkV3NEZXc4TVJSeUJJS0lMMGwyS2I4?=
 =?utf-8?B?TTZjdzNUbHoyTER1cXpnNStielp4RjZ4NjNNRHY0NkJHZ0ZheVZkcy9tZjVY?=
 =?utf-8?B?aGhqU1dWd1pVRFMvTFlpcnplZ1NuTVhFT1lpRXdMK3lNZ0tUdmE5d3UramJW?=
 =?utf-8?B?ZWlRUk9XN0FFZWVHc0VocHhyNXYrK1Zyc095SW5kNHo0ejFhVU9ZVS80clAw?=
 =?utf-8?B?YlI2ODV1dk9GWnJVNUo0VUJCNzMxWjBLUkhrVU5INHltSEpBYzNtUUJwVlRm?=
 =?utf-8?B?b1BOTkREdVdTUXIzSWJXYktrU2lIRzRzaXZVdG40dDBndm9Ta3dwQjc2RmZS?=
 =?utf-8?B?UmNBeHA3SFp6Q1RiRHdmY096S01YZnZDM1hEMFdtY1B6bTFxWkN2Q3BYSU9B?=
 =?utf-8?B?TWkrekRtNWZlTkpTOUxvUmUvRkxJcHVaTmY3VE04TnN4ZThXaDBlY2xZKzU2?=
 =?utf-8?B?NnJYODNVU1FKWmFsYzB2QS9BT3dTSkxVSmYxbEcxQVdJZGhvdk9rcUlCSWJZ?=
 =?utf-8?B?RmRnbWtpVGl4Mi9OVnZocVpMUVdhTnBmNzEzMUw3UGNoNXZXZldNQ3BJMVcw?=
 =?utf-8?B?NFYrS3BmVUFiSnE3ZWcrRzIxQ0tLTHJ6MERtcHlZTm5OVWUxY1VodVF6UjlD?=
 =?utf-8?B?RVphVnVLMFlaSUtnVm9Yd0x1UWFBYjRVa0RsVXNuL29zNXJ2WlZOU21OdEVa?=
 =?utf-8?B?ZjBZTUNnazRQWFRFbzlZK0xXWnhEQVNRZEFZTDNrSllqVTZTaklqdFZkdWVJ?=
 =?utf-8?B?M1pIVjFaYkhOVUUwdW5UajJXZVZicU81bTFJL0NodGdQcnJzcDgyT3BuNjJi?=
 =?utf-8?B?ZElkaTIrZnk2RVVpQmFTSER4a1ZyVWNCb0JHTnlSMkE1OVBiWS9oLzY1NjJ0?=
 =?utf-8?B?VkZvZFFENmlaU2c3Y29kdVhkajlhdVNBNk5La3pKODd4UDkzZFdZYnRrUlp3?=
 =?utf-8?B?NGtKN2o4Y3h0RkhVbnAwZktlMDg1OC90N2ZOc3FUcEU2WHUxdndKdnRTRHNz?=
 =?utf-8?B?N0ZCSk13MjlCM2tVUlNESUh2aVF3bWw2UkJyQzhqWnpRL1hPdktJLzF0bWg5?=
 =?utf-8?B?NUtIenE3MzQxazBPaUh6OFlCQVV4UUxaMzlrbHZxWkRaN010UWp3cC9zbUVG?=
 =?utf-8?B?RXMwaEIvSHVFUnd2STYwYkNvL3l5a3VQRXZTZmoxWnNGYmIyL0gvUm9zMkRR?=
 =?utf-8?B?OW9ML3pPdWVjb0NhU1dQTndjZmprd1drYllaNGRZNlBmN2ZZM0dmWS80QUhi?=
 =?utf-8?B?am56SGRiSmlLTmtMU0s2L2xlTlRHR09oeEc3WWhrc3lady96ekhVM0loaUhO?=
 =?utf-8?B?b2VCUEN2WTl0RGFjOTZtSCtWKzBoUmErZDUxdy9Kbk9ZNlppWGtGNk1DalJ0?=
 =?utf-8?B?ZnFzbUJlQ1QzenA0V3lLcVk4MitWWURyQmY0MjUrUTVmQ2RuWjBwQyt2WjRK?=
 =?utf-8?B?b0pSa1ZwVnA1d3VzTUU1cy9CaDg1YVRWRmlndFYrVXRHbkF1UTJkSFBxbjhy?=
 =?utf-8?B?aXBqSm9YVjVtQVJZVDF5bEhaSVZXVjhDMTYxYVJ3L0t5MDlCS0lCOVJ1R216?=
 =?utf-8?Q?x+rHPQyR8wSSrecYOA?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: WxhmCpdh8VXSisnlArl5/DVBMosFSy1C1dbyIocWept/uIG3c0Y7KrtCAOvRBZIFMWsECu0UXta1Y03gEKdmPYRWIbnGFcjIecyXI+C3Ve4tOiSw8AeGMPmCXNSPVCqhJX8AAxMlxY6U/FeRcuhoXP82JM+t0MMLwHW4gf4OS9Ho/gF318gdicg+Nt9dMTXRrus74M8WwmZwku1yll8ETzlI0UqOMmDwXgs5T1OqKU7UedsnnY59BiE5tg7PuCzBYQvqA27O1i9Hag3mStq269KPvIR5bHQPTN1daWNrEQ+DaOE5vADSFu1MDTpExmvUMDSXwEJoUhPvCN8NVdIDQA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32d1825e-2e12-4d55-f8d0-08deee0e1742
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2026 07:42:22.0012 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OYP1uCquLpmzgKki7g5q6ZML6ggRqFU9Aesmd4aIV+doo8pVdW0+MxlQ+yB9pkUzMhbCNUMeWGL0FrzkmVxnTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6888
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785397349; x=1816933349;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=6vPo85ThYaRyqGQs1x9A8JW0OXH0ceqdtdKc3iNp/nE=;
 b=dqDykH05aGxYn8w6VB/U/WpPmTOwvDJ3rtoawp0gRfdAu81eNUL9bv2u
 wzKyfZVOk7zpK/CVDFrxNhmgcLwO6gt2rYF7xVUW9kPW8TolSYD3hEkCX
 dNihGqq+nzpWPH7TsddzbRcslvnVls9fNnFItM57mn35/5VK4p60+P1VF
 MvI2ikSaw0Ghip01YhSmeqB+YFNlW0PHnN0pz78dzXoysdmSQGn4k87ID
 YHi/GrYEkVERYacqi8Yt++IDQqeX36MKxlcfnLRH19RatW6g4rdZZ9a7a
 Y+UP5Blx01pkrVQghGUdI0EJv5B+GHRR7nkeg4iC3Yo8I4SWEXqLE0Ku6
 w==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=dqDykH05
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v5 2/4] ixgbe: fix cls_u32
 nexthdr path returning success when no entry installed
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC13aXJlZC1sYW4gPGlu
dGVsLXdpcmVkLWxhbi1ib3VuY2VzQG9zdW9zbC5vcmc+IE9uIEJlaGFsZiBPZiBBbGVrc2FuZHIg
TG9rdGlvbm92DQo+IFNlbnQ6IDE2IE1heSAyMDI2IDAwOjM0DQo+IFRvOiBpbnRlbC13aXJlZC1s
YW5AbGlzdHMub3N1b3NsLm9yZzsgTmd1eWVuLCBBbnRob255IEwgPGFudGhvbnkubC5uZ3V5ZW5A
aW50ZWwuY29tPjsgTG9rdGlvbm92LCBBbGVrc2FuZHIgPGFsZWtzYW5kci5sb2t0aW9ub3ZAaW50
ZWwuY29tPg0KPiBDYzogbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgU2ltb24gSG9ybWFuIDxob3Jt
c0BrZXJuZWwub3JnPjsgTWFyY2luIFN6eWNpayA8bWFyY2luLnN6eWNpa0BsaW51eC5pbnRlbC5j
b20+DQo+IFN1YmplY3Q6IFtJbnRlbC13aXJlZC1sYW5dIFtQQVRDSCBpd2wtbmV0IHY1IDIvNF0g
aXhnYmU6IGZpeCBjbHNfdTMyIG5leHRoZHIgcGF0aCByZXR1cm5pbmcgc3VjY2VzcyB3aGVuIG5v
IGVudHJ5IGluc3RhbGxlZA0KPg0KPiBpeGdiZV9jb25maWd1cmVfY2xzdTMyKCkgcmV0dXJucyAw
IChzdWNjZXNzKSBhZnRlciB0aGUgbmV4dGhkciBsb29wIGV2ZW4gd2hlbiBpeGdiZV9jbHN1MzJf
YnVpbGRfaW5wdXQoKSBmYWlscyBmb3IgZXZlcnkgY2FuZGlkYXRlIGVudHJ5IGFuZCBubyBqdW1w
LXRhYmxlIHNsb3QgaXMgYWN0dWFsbHkgcHJvZ3JhbW1lZC4gIENhbGxlcnMgdGhhdCB0ZXN0IHRo
ZSByZXR1cm4gdmFsdWUgd291bGQgdGhlbiBmYWxzZWx5IGJlbGlldmUgPiB0aGUgZmlsdGVyIHdh
cyBpbnN0YWxsZWQuDQo+DQo+IFRoZSB2YXJpYWJsZSAnZXJyJyBhbHJlYWR5IHRyYWNrcyB0aGUg
bGFzdCBpeGdiZV9jbHN1MzJfYnVpbGRfaW5wdXQoKSByZXR1cm4gdmFsdWU7IGlmIHRoZSBsb29w
IGNvbXBsZXRlcyB3aXRoIGEgc3VjY2Vzc2Z1bCBicmVhaywgZXJyIGlzIDAuDQo+IElmIGFsbCBh
dHRlbXB0cyBmYWlsZWQsIGVyciBob2xkcyB0aGUgbGFzdCBmYWlsdXJlIGNvZGUuICBDaGFuZ2Ug
dGhlIHVuY29uZGl0aW9uYWwgJ3JldHVybiAwJyB0byAncmV0dXJuIGVycicgc28gZXJyb3JzIGFy
ZSBwcm9wYWdhdGVkIGNvcnJlY3RseS4NCj4NCj4gRml4ZXM6IDFjZGFhZjU0MDViYSAoIml4Z2Jl
OiBNYXRjaCBvbiBtdWx0aXBsZSBoZWFkZXJzIGZvciBjbHNfdTMyIG9mZmxvYWRzIikNCj4gU2ln
bmVkLW9mZi1ieTogQWxla3NhbmRyIExva3Rpb25vdiA8YWxla3NhbmRyLmxva3Rpb25vdkBpbnRl
bC5jb20+DQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IFJldmlld2VkLWJ5OiBTaW1v
biBIb3JtYW4gPGhvcm1zQGtlcm5lbC5vcmc+DQo+IFJldmlld2VkLWJ5OiBNYXJjaW4gU3p5Y2lr
IDxtYXJjaW4uc3p5Y2lrQGxpbnV4LmludGVsLmNvbT4NCj4gLS0tDQo+IHYyIC0+IHYzOg0KPiAt
IEFkZCBSZXZpZXdlZC1ieTogU2ltb24gSG9ybWFuOyBubyBjb2RlIGNoYW5nZS4NCj4NCj4gdjEg
LT4gdjI6DQo+IC0gQWRkIEZpeGVzOiB0YWc7IHJlcm91dGUgZnJvbSBpd2wtbmV4dCB0byBpd2wt
bmV0IChmYWxzZS1zdWNjZXNzDQo+ICAgcmV0dXJuIGlzIGEgdXNlci12aXNpYmxlIGNvcnJlY3Ru
ZXNzIGJ1Zywgbm90IGEgY2xlYW51cCkuDQo+DQo+IGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVs
L2l4Z2JlL2l4Z2JlX21haW4uYyB8IDIgKy0NCj4gMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxIGRlbGV0aW9uKC0pDQo+DQoNClRlc3RlZC1ieTogUmluaXRoYSBTIDxzeC5yaW5pdGhh
QGludGVsLmNvbT4gKEEgQ29udGluZ2VudCB3b3JrZXIgYXQgSW50ZWwpDQo=
