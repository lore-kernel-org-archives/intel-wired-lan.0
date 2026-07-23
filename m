Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58A51C531C7
	for <intel-wired-lan@archiver.kernel.org>; Thu, 23 Jul 2026 09:16:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F40FA80EB8;
	Thu, 23 Jul 2026 09:16:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5VS9cAlLjqQp; Thu, 23 Jul 2026 09:16:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9C2FF80EA3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784798188;
	bh=N/QlqrCGENffoQMhsl2zUtKaH2ePvD8H0ClaIAFAzmo=;
	h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ppyjjf5uXUG1/yhnaKvswdhw74wE1AgdSfk3sgJGH5ChIMsyb38644xBptcvEmQUe
	 WFOZjkrLPb4bP2KInAUxGY+G6BRtv7gqqJC6wrupI97I+x1V5TVi3EvhskFM3WeBfO
	 ldBxlFljwiuf+flL8dyGZLjFHAYz0/+Dp6lyW2mFjTne2c8G0s6mOL41DWxIs8w5zZ
	 TaLnLT69ehnGKEs4eB7IKJ4spY45+LTMkbJeYy75dr4WXoKrxdspdq2lGJ+KnGic5N
	 azmMlpZGT6vWJXPngPFR62zShJH1wG8KvDzhdBdLrplSotjLCdy32i5zrOC62NELlE
	 4y7zM2aUqJkow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9C2FF80EA3;
	Thu, 23 Jul 2026 09:16:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 76E31347
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 09:16:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5D560403F8
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 09:16:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IadnHi93ajmq for <intel-wired-lan@lists.osuosl.org>;
 Thu, 23 Jul 2026 09:16:26 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.16;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 8BDAE4034A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8BDAE4034A
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8BDAE4034A
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 09:16:26 +0000 (UTC)
X-CSE-ConnectionGUID: sX5rdoJvRQu2DMNbRquApQ==
X-CSE-MsgGUID: Slg5FP/HSuad8Ngn2ZqYfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="72990901"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="72990901"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 02:16:23 -0700
X-CSE-ConnectionGUID: 8bPdaGtrSoWklttrEGyPow==
X-CSE-MsgGUID: qWRyW9mrRlmG3bnC7fLCxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="254006596"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 02:16:23 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 02:16:23 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 23 Jul 2026 02:16:23 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.7) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 02:16:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y9r9mdbAzdyHndVtru3JTOzfA0NjVYqyL3Guf8wrqjGIqVgwBJ/bXsTVZhDKrFJY5znGT6qhPlJU4/Ud1Z5UOsJ6fTisDTjP4ZQGwrPYWnV5iyDbkSma5ETbYP/sX+nhBzAH/dzh1qTNp/oiwsCkYdjgtznii2CgMGx1oyZIZlrHSdJIGP+PunmHTzVsIpXyM8xIPXiHU+T6qbb4en3XdBGRI+Gr1rWqidMDkm40Rhxt1w3YtQuiaZYywsNDK40tK32rWVrtqBVrLhxXD2Te3LoXapG4BdR+Mof3ZM2OS47HSy9t9Vjp0WSccvCht9AYAPMUwH4GE+bS9uAPo8bNnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N/QlqrCGENffoQMhsl2zUtKaH2ePvD8H0ClaIAFAzmo=;
 b=JVU65kuV3x9baDqTyRGuzEWoY5wnHX2rursqD6kfcRIDpuEaDYQ3zIsDGdrs19Cegpb3qRDnRDTpvYWF3WEkzDKNz7PxYzUpE1SYvVeE1vQT4pT05qBTvmsWqzqP8DHluXNoUR7NeiGBXJOjKzAFrhOMe/paX/C00hOPW5UEjAaJiyPjk2Sk10IzIAt+DL9RApmseA+3A0yTG0xDd0d9ReVgi90VkcNKuK4RCGn8l94I5+JXJ3adhAuXWgYaopBCgiLm5+Sa1sCwlET8BfFICYOlpGdcioIzgFBbiPAAV7rUO6mBIG4CtxmURnqKPxMUC24JIx3nufZCMeL29vxZTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA1PR11MB9633.namprd11.prod.outlook.com (2603:10b6:806:4dc::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 09:16:21 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0223.017; Thu, 23 Jul 2026
 09:16:21 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "xuanqiang.luo@linux.dev" <xuanqiang.luo@linux.dev>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
 <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "roel.kluin@gmail.com" <roel.kluin@gmail.com>, "tactii@gmail.com"
 <tactii@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Xuanqiang Luo <luoxuanqiang@kylinos.cn>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v1] igbvf: fix DMA mapping leak
 on Tx error
Thread-Index: AQHdGPLYzl7rsj8140KWgBobvdMKKrZ61eLg
Date: Thu, 23 Jul 2026 09:16:21 +0000
Message-ID: <IA3PR11MB8986476BDAE21FAC38BE45EFE5C02@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260721092323.39372-1-xuanqiang.luo@linux.dev>
In-Reply-To: <20260721092323.39372-1-xuanqiang.luo@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA1PR11MB9633:EE_
x-ms-office365-filtering-correlation-id: acbef284-b213-4a17-e063-08dee89b0fb6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|7416014|10067099003|11063799006|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: C7yAxL+NYMWqHke9QQBdp5DRim2fYaXt5QA8UPUcmUi+4VeEioYH2/w76zAIbIcR/FncLstjJmOBDpdHcoccC9QdRWTWO2UVAasEPIzXAP2U3fdMA25c/xMpLp2twEm61zYa80CE2eIZZbFFQXnU8B5cZW/xDJWg8yBMp64gnnc+uFn+PeDpJ/o73OgBz/M5BW0PHX3t1JkzP2kBy9sXFco4VAkfpQ2iv4khkK9QZMlmkMTszItD0e+g4e07X4XTBDf+NinPJxJO8IIzNTpzBn5PfPB8lVE7grU+kIfMeZ7q8HGwYgPdM91BTsrQjP6eQD8C/HCMJ9+yKVxg4aduJDJzVt+EpSuQdP8UBUKvZ/vIYoA7DcTGeeO+NhbhHCtXwbtwxdywoRlr//QzGEj8cL7pOg5LyHd/fuP39/QwEjNx9mHVntit1a1Ez1HbCXqzL0nDydkq4mxcq+bT+S/L02l1Hlcvz7qo972sMZKcGjGT34By0M0MENU+ElXh0Kpc5kFxREtbMy3TFzw4s7giOsEKYT1Z4LQF7lUJbYJhGPG4bC8f82KthkC3I/9JpsPr9rbd/mQ+XWdQLySlzLFfF37EozDcGAtbBR4PkVNF0yiZK05xNlMp2HNkfaGclkHAT2FdNGciIFwzsws8OO26ce+upxgGJBw4H6tDHYtuEKOvELmli3Bi9jnp7ZL4DkvglxtQzyXdp2tGwU+HqFkhEXFvZstMFV6VuTPC5grnwLk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MzaAfrwaZf9psZAR+zGf5gOw76C3lNiZ6hh0a5PZJZdSf4+wQ4f9CSHThb3/?=
 =?us-ascii?Q?aAezImu/twoInWFjr96is2qvXpgf4WktZ20xzzWISTaT7ZP6/+AFe7ymq6XH?=
 =?us-ascii?Q?weSa/+wIv/YBx9QLdLjUNldkar3XIGMt3bT60VzUAB+VcHM534Q9/k5+UvMn?=
 =?us-ascii?Q?nmF/zAP1yGgUOVwpyQyqbXzcFI/IsxA/ZeLAsk2jbWB7VncnAdCV4qOc918v?=
 =?us-ascii?Q?YUKjl/Mdx0J1/7kvAshNv93igbuNAWU7QSB9/+LD23H1VWPeAPRFBqWiFpxK?=
 =?us-ascii?Q?6+VE8nMkFl1WEBFbF+Sd3UVyFqGwIKoOUEMnHPWHauzznppi3UjTFSopNyHl?=
 =?us-ascii?Q?Pwb+MgC+zaIk38YWNYK5hFzbHO0OjyQuvIOovnUOQla/kF1VorAbbAUe/6Rv?=
 =?us-ascii?Q?gH15Vt6sWQy4raqMFukbGWzRIrxOWzNpcKkrw/jIks/EVdKS7s+yBJUHipLU?=
 =?us-ascii?Q?Bd3FGllsww1Xku/i/6KvE4V8tCZDtmcYftSPrufaKu1nk8aIKy+ETDxZjkmQ?=
 =?us-ascii?Q?4ZsrYjuOJGuB489V+ddJV1FbmrZep8ZivzojYSKHl4rVTG4nDHd+hfqzFco4?=
 =?us-ascii?Q?cMkk+hY7mRWgJmxcxq+G7l3OSyQWP6rdstZuGsmUPOHyYNWZ2kdBvPMmsYrS?=
 =?us-ascii?Q?KgWXK2rv5BNym45BhZ1cKhky+2cNwPQgeiW1rZ5ZJg3l968OZUdn95ZA5U4S?=
 =?us-ascii?Q?I8xUH2TfSmga7VhA1WX7IAfXwMLv9j/PmfHRncqncYkKPK2Sb5Duy3pxAP0X?=
 =?us-ascii?Q?1NXuYBC795nrJVHG88gzUzEB9saXQMzN7ApHCPXzKcrA7HfZD1fNtnbG2yKZ?=
 =?us-ascii?Q?wHYoCc1QIH2nLWzrDsWpG/6otxurSxin2NSuKgcFd0H9cxHh5n2kb0/QaStG?=
 =?us-ascii?Q?gbtUScFhJGxAC4TgiO6Ji9HRAZRlArt85UIMSmWdC+unCGQ2E/fEWrZWi465?=
 =?us-ascii?Q?iZywhtZ1HnTdSa8JPepEcy0rwtAQzQMQV7394gRQNIM7who6I79Qf5+dzTOO?=
 =?us-ascii?Q?GxtQoZa2mRl0EI7Cjm3Zpz3Gr22SzGmx3Jrt2Y87NLGMuffXyGOuy0vDSiQv?=
 =?us-ascii?Q?bR5+PTrF3I3KErTfsFmVbAMp83RrIwqkC627IhCtCmoekGtutB665bGFiE3m?=
 =?us-ascii?Q?Eb8M5kXudhkM5YMZ8SYD901o01xGSM17YMtb9iZOs4/M5Lchka93u5aFgKf9?=
 =?us-ascii?Q?kUfwCaiKqPgDfw1g5235BxbFaPPbT1ZoU2EI0fnerm9QeqanvX8La01x20ew?=
 =?us-ascii?Q?vMunsAmkYbRMCPi+6uHAi8jXzEf0HlJGTVOzaYlg4IINrsudWW2re4aLuRlg?=
 =?us-ascii?Q?03KwdkLvANt6vf7lF/Lz8rRFLT7uPKUPQaHfpPczf6nvg1r0t+3JZ0aablCR?=
 =?us-ascii?Q?OzUe6ta9xWlvvJWCM8KgRrrY0E0+H3ahS7hn8YxDPkzXHGS/2Is6W2y+zjVr?=
 =?us-ascii?Q?P6OcIciJUZ5z9RGat7SwJmt3qYaSyi5IKu6JQITgw0nBjQ0RSnpToE+Aht8A?=
 =?us-ascii?Q?W3FuzYfvIjiLtVR6COD6h5mxg0cC0eSkv/WO7gT7lpoEHwXBM+xABo209iCe?=
 =?us-ascii?Q?CgtXBIGmITRmCqL5VHdX12KLRIGD5qFCAo2Q9sojU2nyhtPa9OaZPAR8Rnpx?=
 =?us-ascii?Q?ZiNb5HEXjESPmyY6dZt6k2ZsiLa1rih2TgZki0OdpoQKBoBaK6k2LzK0iHMK?=
 =?us-ascii?Q?ZuMaIF8YPex9imhHPzdD5HfhMhCQL6cpbPSdGr1mzpRm9fO0jv9+V4LEP24A?=
 =?us-ascii?Q?RsIYzs73nb/bXBN12l50yB4VLwbth6U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: WsDIFv5Y4X9QmcReOa+8n69eu3gkl0r/m0U4Hsb2NYr2sBMJeYMs54yb3+bB9wzSS7Z2hnKurdYY0RHYFyPoa9qW3urnsSXaJHtFe2aZNLFUKTzPgidC2vlVl7/q8nWRNLExzVFpvy+CBM25UwoLOr0i0KjP8lBNQ+utDsNZKh55BGVshvXjZgF89338HwbVpkpA3NZe3ntdl69ftO/HW66SzC8Nuu4yWbYdIfLYuYCv5QWirHj48HqGL3yL3mBvv5nlDmFDpL80iQaWB9dgg1delBIYFl6rBHx0OONVwlaH/RSNxV40jXkz+PjKFGNkPi5jsvmD4/3Ly3WwDwXQAA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acbef284-b213-4a17-e063-08dee89b0fb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2026 09:16:21.4195 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F5fnEr6gzylrHeUXxQS9AieLdpeyTdwxs8xJwBRc6BRXyNwqsf4QGCK96iwsSbgqe+mBkH5paDvOeOLjLTR4KxD2EfnMb0NGdtRypgZ7/8s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9633
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784798186; x=1816334186;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=wX1JgAUUiBlsH7ZDDUK5PgRCBtYBkMPpibvC5M/+F2I=;
 b=n2XguhTNudph3YJVCTa5cYSqRf1AZOdkJbt0UingYztiTikxzstUabcN
 33QrQSV3BWDiq+sfYTawkxiFr3C1+Uyj3bQCUxNTHjzvZobpzbgM3WN25
 5gI61+K5gT8/mzqU06JV10YbThDpsIZDik9b92x6FY2AdrsWCn/ymIeuO
 +Q0j2tDzPBKaEJ00vRrgEAobfyUU7buxAhvmS+aBK09Wi7Gv07dC+79lE
 ElVUIjsqWmPk9s+i/Dduk8okc5Ym843OqlDIJ2AnbbB1tDppxxbqqeXrL
 99o9Xt623z7RQOnh5EfiyyXHcxm86/U1/KNOGathOhd80YlhMa/qwdYoz
 A==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=n2XguhTN
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1] igbvf: fix DMA mapping
 leak on Tx error
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



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of xuanqiang.luo@linux.dev
> Sent: Tuesday, July 21, 2026 11:23 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; roel.kluin@gmail.com; tactii@gmail.com;
> netdev@vger.kernel.org; Xuanqiang Luo <luoxuanqiang@kylinos.cn>;
> stable@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl-net v1] igbvf: fix DMA mapping
> leak on Tx error
>=20
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>=20
> When mapping a fragmented skb fails, count already matches the number
> of successful mappings that must be undone. Decrementing it before the
> cleanup loop leaves one mapping active. Reusing the descriptor then
> overwrites its DMA address and loses the mapping.
>=20
> Remove the extra decrement so the error path unmaps every successful
> mapping.
>=20
> Fixes: c1fa347f20f1 ("e1000/e1000e/igb/igbvf/ixgb/ixgbe: Fix tests of
> unsigned in *_tx_map()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> ---
>  drivers/net/ethernet/intel/igbvf/netdev.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/igbvf/netdev.c
> b/drivers/net/ethernet/intel/igbvf/netdev.c
> index c5ae15fcdca75..3d2aba5c3f126 100644
> --- a/drivers/net/ethernet/intel/igbvf/netdev.c
> +++ b/drivers/net/ethernet/intel/igbvf/netdev.c
> @@ -2190,8 +2190,6 @@ static inline int igbvf_tx_map_adv(struct
> igbvf_adapter *adapter,
>  	buffer_info->time_stamp =3D 0;
>  	buffer_info->length =3D 0;
>  	buffer_info->mapped_as_page =3D false;
> -	if (count)
> -		count--;
>=20
>  	/* clear timestamp and dma mappings for remaining portion of
> packet */
>  	while (count--) {
> --
> 2.43.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
