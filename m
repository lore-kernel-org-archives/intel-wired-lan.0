Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06FF2C5AD5A
	for <intel-wired-lan@archiver.kernel.org>; Wed, 12 Aug 2026 20:45:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AA32A80FB9;
	Wed, 12 Aug 2026 20:45:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wExQjAQc0FfD; Wed, 12 Aug 2026 20:45:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 72AC480FAF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786567553;
	bh=JImFx0V/oFYjOj1XtNgJgGF8psIdmIxzHP3TLl8R+rs=;
	h=Date:To:CC:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cCqNR/teXsDJETQWSMhwbsIfb01pUUdg9vT/xqYic7iBVG3k8hTnHZeT1iwcVzDJO
	 Y1yOpi/tzFT7twHnjX8YeEGqipPlHGHf60KvMb1yaqWm6jmDnaaceAnqmA3lJZbM90
	 YmPULZlghWoFTx7msn8YlUFzf4thdgkPVYsKHDExIol/SPfJG4DLM81SuWiUr56EE0
	 CgPP6Prse0JrP2XjTxXJzFdDocSiUW6toNrdCLLwIHEbbJ3XpS6qsOif7Q3G3Tpu79
	 H1V12elgeOZ8h2tj3qp+OsAndnHNP33e5p/cnXllQPpcfdQjqSuNyJHLfas8eOodqg
	 wQHxRzcoNZlXg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 72AC480FAF;
	Wed, 12 Aug 2026 20:45:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 389471B8
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Aug 2026 20:45:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1E0B94082D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Aug 2026 20:45:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xDLS9oEgNzLe for <intel-wired-lan@lists.osuosl.org>;
 Wed, 12 Aug 2026 20:45:51 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.15;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 23D4A40820
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 23D4A40820
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 23D4A40820
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Aug 2026 20:45:50 +0000 (UTC)
X-CSE-ConnectionGUID: 20p/lVDBRJu7u6HwPu2cng==
X-CSE-MsgGUID: a7CRl1M7QcSNceWYpBdaqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="87258909"
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; d="scan'208";a="87258909"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2026 13:45:48 -0700
X-CSE-ConnectionGUID: 31r9oT3EQd69uA3zn9g5GA==
X-CSE-MsgGUID: XPr4NHeEQvasIoHmbpYSqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; d="scan'208";a="260444833"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2026 13:45:46 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 13:45:45 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 12 Aug 2026 13:45:45 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.46) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 13:45:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cBtNzKcC0BisoCnJCxk6BH7BjThNRXXEGMRxc0Fxcl7rtIroQHX/u1Kwl635ztzpk01yjTEKKA507DQhNgZ900hnLsK16NzTQ8CfC5vpCGrSYHuSToHaO9GW0rWbf3DJn31QHoc5LwPqO9slQcCZ+oO2WGrWVk/SX2aGMhQ8y/o02JwhomrwzBtK4C5aGoD5FnxMZPKRCxz29CSaI/RU3D8Irwiaoii8j2X0Htxb0YJjwPi5ibSQLGK6wkOPy4ajHLl9eBEAGgXi8fZMvMocABQ8i96R6Zjq030TdSmt4emGtEQO+sL9lOUGNnUUDAOclDBOCZkCTUS5fqC7jUklmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JImFx0V/oFYjOj1XtNgJgGF8psIdmIxzHP3TLl8R+rs=;
 b=S5eZ09nC0e1LSMnW1TOWDBZx3BPgq2IFSb2jgE0UOIHAc7mVDGyzeY+Fmg6Et3gCZKKSR/hivCqd7P7Yj4wAwmUPCs3cGLCXTbO6Bz0frgoJIPoCRdotHn3Yf+gGlEDavCIpUeIa+41zEetK5QgPHuxzVs7j081DUfkOKmFd9F1RSPBFHSoJ4w+Ch/bAI9iqvc7vyyPgPqv0xGx0rE6Ce6dkg+d+5IKPe7lpKw5WQQyM6LvW5kI6Bf43uMIfoSgq2Quf/N9T/mDMi18QK1V9+0cbOATSFI+1JlyjF3ZanhZeBKiUnCHueGdVfgTelL8Y3H/+dz5ebnAIT4pumuOJmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by PH0PR11MB7586.namprd11.prod.outlook.com (2603:10b6:510:26e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 20:45:43 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0315.014; Wed, 12 Aug 2026
 20:45:43 +0000
Message-ID: <d84bac6a-68c8-4e62-9592-1226f97bc785@intel.com>
Date: Wed, 12 Aug 2026 13:45:41 -0700
User-Agent: Mozilla Thunderbird
To: Paul Menzel <pmenzel@molgen.mpg.de>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Maciek Machnikowski
 <maciej.machnikowski@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>
References: <20260811231058.220370-1-anthony.l.nguyen@intel.com>
 <4173a6dd-8c82-4b2f-8532-84db150e3965@molgen.mpg.de>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <4173a6dd-8c82-4b2f-8532-84db150e3965@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0081.namprd03.prod.outlook.com
 (2603:10b6:303:b6::26) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|PH0PR11MB7586:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c40d97e-4f5b-44ae-2da5-08def8b2ad65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: n6OuIiROd2+ala8YTCBObflLn5WdoEUXNkaFE+Youo9gTBcQfxzxKV3CE8449V64Liuy752GR36G3LWREcIeaqBiUNw/Tdjc3Op+i8f+rr7SiBlJE3h5X833m6m9Hyt3vzLy7Dgnf5GRJ2QgcdhFrBiAgghFSMg2J8y3oTJ9Jicy1r7yeWnjVbKlfITmRycRrOJuRj/97H0C9oieTGKsC5Rf3QXXvwZlkBBhv9y088JYqnW2Nid22NjcF2YdXsiI9oHMejrv7Il4LEkuRjUxJQBooG+MVtj/Zjz/qOJT47ptLJjt9o/3FW7+ShsNlbeje2sveHXQn0Epz6w2m0r6X3mvH6H5sZFrm+OJT+N9HIH5XGbwbDW3eRJ2SOqhofTinHlpiwcqWejN3gdiOE12vz7SnMnV5r+E5VQAznBudCxDwtMKjPA0mbv0webrutArXmO/khPxyT1sQNbqvhDSo7VmDFSNmSyv+KMbNMEWLLJgOX13LQsXkiOqLRr6Ft56ClU5VjzQy1zMZV/PBboVuO0wlZOHR70p9suOYt1aKzon/gn05D77rpo3BOkKMUbSjYfLOlomwko5cvp6DTCactenDufSSNlxZpNVQ0eWwtWtYTXvv10gKP82FyeKeGxvyxY7ny1AcclVhur1MCLZlf26LZFYDza3l9i3EtHwtG4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7381.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckxQV0pybFd6dmY2WnpnUlduS3ZFaHhxZ0NudG1IWGlMNjJzWmltZ2labER2?=
 =?utf-8?B?aXRzTnRSd1JDbzhNeVR6YmpITmxXOTJRRms1U1BrTWtKcnJuUG5WZ0dvQktu?=
 =?utf-8?B?YzF1SmVHanBRdVVLWHBiYW4waHJsaFJQMW5FeUdUdzEwa0JOOE5MRC8vTjVL?=
 =?utf-8?B?YjRIdHZ5Q3NsY0xydG1hZEF3STBsa3pvNEErVGpId0R2STJKSVV5MHVzc2ZS?=
 =?utf-8?B?YmZjakdQbUxNR2U4THRJazZkemcrQ3FHQlJnUFpxek8zbEkxS1hvaUZLNHF0?=
 =?utf-8?B?WTVPM2NNUkM1WGk5dHd3U1JSdmplZngybURPaDNzcUt5NXprelFHMExDUzJr?=
 =?utf-8?B?NWdnczVoRXZoalE0d2M4NlRiak1CWWVDMkxmM2EvSERWeTBIYjJiemV1QVRX?=
 =?utf-8?B?dkIwR2xlcWE5ZWdDYW10ZlNaR1VQTUE2Uk1LcEdZTEFkYkE0N0dBLzkvKzVt?=
 =?utf-8?B?TkRJeGlVRVNZMmw2WEs3eStuSVVhNGN3NmFzZVJ0YlI4WGdUemFxRlRpRmZm?=
 =?utf-8?B?YjMyZnQvZkRIdXVERTNpTVc4SFRGeStvV0lyZmxhU2ZLUjdzc1BuMktrblZV?=
 =?utf-8?B?Z3IzcWhzeE5QYlkvaTVlTDdXbG1IN0FKVUt0d2RNWllsNUlHajhXbHUrR053?=
 =?utf-8?B?aHZheGczOUp3UHdqV2xxSXhZZnRHblNjSXRiZVFWR3QwTFhmS3FicG56clBL?=
 =?utf-8?B?SFJwMWR5ek5qeU1GRUl1eVJKZ1hYWXprbnhzWTZvMXkyekVLU0YzV1lSUytx?=
 =?utf-8?B?T2htU256eEZUTVVkazkxb1BJYjRQR2kvNGpUUUhoTGtuRHF4ck1YYjUvMitx?=
 =?utf-8?B?TUJ0dUc5bTBEZ3kvMXppYkdWZ2VDeXAybDYvUTdrVlFSbXBiMDl5MlFWM2wy?=
 =?utf-8?B?Qm1WQW50VHpoSVNCNXhSRW9wQk1VVSsrdnF1ZEpONHMxdEhvYVBZOWVHdTNI?=
 =?utf-8?B?N0RqUXRWSWxuUkJIVGFXNkN6NFhqQmhzWEdwNmR0M0c0SjZKOXEva3FQdUZq?=
 =?utf-8?B?OFdtZzByL09UbTdTUXkyNXlVZGxmNWthZVZzZUlrN3p3VzJmUGFqTHBCb0V2?=
 =?utf-8?B?cUIyQXMyL09nQ09hVXl5YnIra1NTRDJDOC9yV2tqVjRhU0g0Ni9EK08vd0Iw?=
 =?utf-8?B?QWRlbENvVnhwZ041dmlKa21ybUNSaUVvaWtaamJITUhXOTVZTUNvTHV3b1I2?=
 =?utf-8?B?b082Tk1PTjZDWXVMRVlic3dSVEp5eGZ2UjFTd2hoZStscks4WitqQk8rRitD?=
 =?utf-8?B?OUd5SFVFUjE2WElhN3N3dXVmZm5acDltZ0VHamlFVSszeXNlL3haQ0YvZTd1?=
 =?utf-8?B?V3RVSWpKVE1XMkp0dGVOR3pGWEVGdEdTZkdnMWRuRjF2VVYyMTBNTmNxcUho?=
 =?utf-8?B?MlhoRWpxNVplNkdFWTFBS2ZIMWpqZ1kwMS9ZYlBxZlF5WlhGdWN4TlBXYk9i?=
 =?utf-8?B?ejJKZUIrZEYvMnJqOE9rV1h2alNvdFpaTUM4bmJEWUc2R1k5NHkwcWYrbjli?=
 =?utf-8?B?cjFwTXplcEtjemh1TXBpTmJzUERhdmxBdzZQUzk3cCtnVXBpZ1ZYZnRZdDJn?=
 =?utf-8?B?SytSV25GSlNsSm9VWXd1MnBLVkUzZkZkRmFnbnh6bTdXSUxYRGpxOWhwQjYv?=
 =?utf-8?B?MCtHZ3I2OXV2WjJFdG5zdHhNNEs3aElpVU9sSmY1TFhLcEl3b3ZFeWZMNkJh?=
 =?utf-8?B?aHlZa0VoRUNpRTdMVE80ZEUxYmRmaWtiQVBJNW1wYmRVTGZOdC9pazI0N001?=
 =?utf-8?B?UFRTVXlEM3pEUlU3WEJRZWxNNzUyaTJGL1cvTzlsZkhTRHRmR3BoWTlnNml2?=
 =?utf-8?B?YXFMdlU2d05rdklGRnV4TS81d0NLbzIxWWNpWkVKQzQxQ2FpRTFYOWQvaVBx?=
 =?utf-8?B?SFI3U1JBOWdxQmNTaTIrK2lZQVdiWFdZUXVqTFdmWkt4OEpRTjdqY0ptZjdR?=
 =?utf-8?B?aThTSzFWWEZkdlJSSmhJblRDdFNKUXBENytrdHh1TjdwcUlEanJ6V2RTenJN?=
 =?utf-8?B?dUVtZUhnaENhNGIyTHMzTGJZWmVHbmlCZEpPNmY4eGN1ZGR0Q1hvOXZWdTZS?=
 =?utf-8?B?QlU1WmI4RHJMTFZJMDJSbm1jSitORlFxamdSaWQxTDd1SndoWGVYSFRnalF6?=
 =?utf-8?B?MUxJTWZNa25MY1IvaG9NVXA1cEQyZHNncDNBbHhieGx4M1d3NjI4cHNqQWd6?=
 =?utf-8?B?d2hlcitGeFZjYzVqUUh0TGxNRGlNRDRtK2NTVFR2OGVaN3JJSDA2ekZZMkVo?=
 =?utf-8?B?VDNicW04Z1lUUXJoek9WV3FoQWpibUwxY2VNVHN5THNpU0FldWtvTnFOWVBO?=
 =?utf-8?B?WCswYXI4VUE5ZGswZUZqUnFUNmpyZ29OejZNS1kxRUlmRXlobzQraTRYS2pR?=
 =?utf-8?Q?rggS0nLWiDMTprdA=3D?=
X-Exchange-RoutingPolicyChecked: fA932PT05HUnmZjIFfTxzQcU+CcAG/cQOGY477ju3XOxnwRx3X86huu4D7mbyfuR5yTRisauB79PvbeQfdCWK/T6Ox9Ci7ARjGJeKhGDkbloB5t+ehe8HCC+Ea6KgQWzkBFYlEvZpRTWeiyty5y33IqGB9rILtL6m2gUBkW1si6alpuJ1188EkRWQmik5994VPLBNx0kwRX+UPVADgebNXNw6IrfeLDGLJ2rjuOnNskRu3OdtKktvXYENd9cuC/n4zKzuD1gCQNPktGushi095aB8VnKtQtmvQv3Pa68A0DV8mEm6fbXXZwYanQ2nHKDaO9Dc3UQ+t7TnDe52axfdA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c40d97e-4f5b-44ae-2da5-08def8b2ad65
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 20:45:43.2204 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4JynRmDC5sXf7Tt4KxCcMzB+ZD7iLHN/slMCCweK0Iz06noA3nVpkbxkQZhgjzaIcPhcvmbwLRjA5QGLJ1qVNR26MQxtgwBXaqk2nxdIVIA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7586
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786567551; x=1818103551;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ws4tKrrAW/m1bPII3FVCdAfT1lVCeyT7a6et2AD9STY=;
 b=iLnraWrE695N+lV2hoi87Gvrt6uk6et5HYh5nBwrfWbPQl9Jg2YOLswC
 DA2ycao5dlHnnjB3QYBSjP5iEJfHBMuFW9iVGYjfyG2bJM83BOaHzvtxN
 JjMVIiLiNNw7mX6GnoOD13Jx21GKR2QkfIqzWaHL3F3Rh3n0dFa0TWhsD
 /qql8RLeGY3YcZ+AOMSARN0rIDRVZNC3l/4YStmsjr0cDcNwXoVPphiIh
 Xh5Y9Rjym4IWROZ4Dvns5XeG/fb7yLFvyiwYwukfrDv7DZfEZAI9vjlsu
 76S9ZJQLMs5+AsYiMDhIsAviCBsNIZIb/Fq67uMSH4oX6xt60NZPKaUuA
 w==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=iLnraWrE
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] ice: Recalibrate PHY after
 settime64 on E825-C
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

On 8/11/2026 11:11 PM, Paul Menzel wrote:
> Dear Tony, dear Maciek,
> 
> 
> Thank you for your patch.
> 
> Am 12.08.26 um 01:10 schrieb Tony Nguyen:
>> From: Maciek Machnikowski <maciej.machnikowski@intel.com>
>>
>> The PHY on E825-C requires recalibration after large jumps of the
>> system time. Add missing PHY recalibration also on E825-C.
> 
> Why does it need it? Does the datasheet say so? Hardware errata?
> 

If we don't perform this step, then the PHY timer is not synchronzized
properly to the MAC timer. This step is required and indeed was done for
E822 devices previously, but was accidentally skipped due to oversight
when we added E825C support.

> How can the issue be reproduced?
> 

Without the fix:
> ptp4l[12591.505]: port 1 (eno8303np0): SLAVE to UNCALIBRATED on SYNCHRONIZATION_FAULT
> ptp4l[12591.951]: port 1 (eno8303np0): UNCALIBRATED to SLAVE on MASTER_CLOCK_SELECTED
> ptp4l[12592.027]: rms 752851973 max 1102277559 freq -84408798 +/- 53560133 delay  6009 +/- 92308
> ptp4l[12593.038]: rms 91302045 max 136894784 freq +100000000 +/-   0 delay 93700 +/- 24153
> ptp4l[12594.050]: rms 16036314 max 35711594 freq +47433070 +/- 46746070 delay 44899 +/- 45255
> ptp4l[12595.061]: rms 5558880 max 12292103 freq -13092285 +/- 6627317 delay -13499 +/- 6560
> ptp4l[12596.073]: rms 759533 max 1081638 freq +837063 +/- 802691 delay   711 +/- 979
> ptp4l[12597.085]: rms 60485 max 106800 freq +146706 +/- 263535 delay   145 +/- 263
> ptp4l[12598.096]: rms 16428 max 41896 freq -46707 +/- 34325 delay   -40 +/-  34
> ptp4l[12599.108]: rms 3049 max 5356 freq  +5337 +/- 1730 delay     7 +/-   2
> ptp4l[12600.120]: rms  284 max  381 freq   +104 +/- 759 delay     2 +/-   1
> ptp4l[12601.131]: rms   42 max  119 freq   -124 +/- 143 delay     2 +/-   0
> ptp4l[12602.144]: rms   11 max   25 freq    +39 +/-  12 delay     3 +/-   0
> ptp4l[12603.156]: rms    2 max    4 freq    +14 +/-   5 delay     3 +/-   0
> ptp4l[12604.167]: rms    1 max    3 freq    +15 +/-   5 delay     2 +/-   0
> ptp4l[12605.179]: rms    1 max    4 freq    +16 +/-   5 delay     2 +/-   1
> ptp4l[12606.191]: rms    1 max    3 freq    +15 +/-   5 delay     3 +/-   0


With the fix:
> ptp4l[12834.266]: rms 27178238388098 max 30079328952737 freq +479164 +/- 1040869 delay     5 +/-   1
> ptp4l[12834.522]: port 1 (eno8703np0): minimum delay request interval 2^-8
> ptp4l[12835.315]: rms 86919 max 139746 freq +111289 +/- 539214 delay   -35 +/-  28
> ptp4l[12836.376]: rms 5415 max 8884 freq   +579 +/- 22798 delay     4 +/-   5
> ptp4l[12837.429]: rms  335 max  559 freq   -305 +/- 842 delay     4 +/-   1
> ptp4l[12838.471]: rms   20 max   45 freq    +79 +/-  33 delay     4 +/-   0
> ptp4l[12839.512]: rms    2 max    5 freq    +44 +/-   8 delay     4 +/-   0
> ptp4l[12840.545]: rms    1 max    4 freq    +46 +/-   8 delay     4 +/-   0
> ptp4l[12841.586]: rms    1 max    3 freq    +46 +/-   7 delay     4 +/-   0
> ptp4l[12842.637]: rms    1 max    3 freq    +46 +/-   7 delay     4 +/-   0

Without the fix, we fail to converge quickly as the effective adjustment
requested is not applied properly to the PHY timestamps, so the readings
from the timestamp are incorrect.

With the fix, we have significantly higher accuracy in the applied
update which reduces the time required to achieve synchronization.

Additionally, I suspect, but do not have a good way to verify that
without the fix there will be a persistent offset between the MAC and
PHY timers resulting in a persistent incorrectness between the Tx/Rx
timestamps and the results of clock_gettime() or PTP_SYS_OFFSET_PRECISE
and the timestamps generated by the PHY.

@Tony, @Maciek, we should include this or similar data in the commit
message.

Thanks,
Jake
