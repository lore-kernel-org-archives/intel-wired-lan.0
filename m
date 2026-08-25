Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B750BC5DF81
	for <intel-wired-lan@archiver.kernel.org>; Tue, 25 Aug 2026 00:09:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 751FC60672;
	Tue, 25 Aug 2026 00:09:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lCrkUB-1UsHh; Tue, 25 Aug 2026 00:09:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787616575;
	bh=i73ENW3yyrZZPk2QqWpCQ7r4/9cEKT7777BVbVWIcsA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kT7AcR2ZHYL0lFZIXmZgong2x8Gr1TRuRRkKl384z3EobA7Bp+TBCvsiQfncDrqsJ
	 WfLMuFKcGRkE2gbjh1zzpFeIZJx7GQ+Ef6ptPzPaRfp6iuaUKqq6KG1wVTG7oK3TDt
	 bBcW6pM8Q0+3efaJRjfEWthrcACn0HeZZBucn7jC+E3wE3zrQOvjP9QPpKrFAeCwq0
	 mk712Skpv8ulF08zYqsDjcEffC95Az8OmJbUrJqpJjwPz9UFYO/zxijHyVzhivMKeb
	 SrjPVw+a0OSwfJRf6qqc77s2Pbc+tfE+z/b9Vj8m5c4qDRfwrqidiSEoDezgr0qQSJ
	 PoQtouSCAy5dw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6B46D60667;
	Tue, 25 Aug 2026 00:09:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9BDAD396
 for <intel-wired-lan@lists.osuosl.org>; Tue, 25 Aug 2026 00:09:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 881804005F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 25 Aug 2026 00:09:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nNBfGg_ZBCn7 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 25 Aug 2026 00:09:31 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.10;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=iLtXDja4
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8239C400AF
 for <intel-wired-lan@lists.osuosl.org>; Tue, 25 Aug 2026 00:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787616571; x=1819152571;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=NiuED2kVJLAZsNM2PrPC+Gl+U5y2YooLxAdbC3cGxaY=;
 b=iLtXDja4ruKzL7plpV0UB4cJd1ZQSiBjk6yrpXngzZqmiq8Lj19fol0j
 I5/T5WAI9bZYln7Dlrif7Kr6e1tho8e6gCXKsuh9q+ShVnUrpBQGW3GeV
 1cyDAjAs/q6m/XZd6EQ2fWy4/8Hio0XjQQ0kFnpT4V+qGEQI+hVBQMyDA
 CsepR9+vGW60vijupfczP33bVT1hbxkAszqM7doqL7WwBqUNbPbBxMeY7
 gupyNQzLMIZ+DU21EeRt0gauY3nNCjnbbP8cQxyJNcuf0dWP1tB68mc5s
 ed2/w0OC0DooQFB/9rg/b4AcQA6DQsXDkCpqc4P5BK4MdZ2+isHUKSu7b Q==;
X-CSE-ConnectionGUID: VAVDzhWXSAOhHMmwxUpmOw==
X-CSE-MsgGUID: dhSAN8ziQp2oy7Vlb59T+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="99427676"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; d="scan'208";a="99427676"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2026 17:09:30 -0700
X-CSE-ConnectionGUID: 58arPPBvTSKDRVL8fMCVvQ==
X-CSE-MsgGUID: kGrbIh4ORvaMxFeZT0sisw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; d="scan'208";a="267719007"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2026 17:09:30 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 17:09:29 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 24 Aug 2026 17:09:29 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.56) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 17:09:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xVMLjlhDT01AuFePXLjgcvMoBJeIksqjdutMzf4jh2jn1t36xtXaf+o6qAM5HL/qusT36nYxp77/MW447YtBErOLnMdNdxxGFZOjyXqJxbi8P9gi2lyDl9GqK/Is/Hd0MliOoSz+oXwWS59Ut/PXUAEXvF7bkW2SEyd6WG7lwBPnEytjK3/BnYHjKIdoOnMwzPOtzpVILpJ+9c7DOWK8WCEhDqSXsC43FjJYO7RPmrW4UYLcoNqG7NB9xUSz/QUxtaLz+dK4bqOnnA1T4gyEzaN5R6xQM+907kC80BuZN3wCkCpPK4LDDdb126oOzgCkdJrY/2pnqrGV/aMKvtpAWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i73ENW3yyrZZPk2QqWpCQ7r4/9cEKT7777BVbVWIcsA=;
 b=NhPsFuVM5Su0H5tmjE6GWiBLIDMsTqKCvf8NeI96JWO7ntkst2x9X0g17sNNtiMMgCMqFBuDzNqFHm6rSvcWRVU0lSZNKNZdPguMIfYQDOago+XL0gfRUyICN+3/wbJ9zbTPK3d/XUFNaI2RtmiPWlNdIH7L9UcKcD3IRcvOaRG//5swg8X5jSNKPCGPR14SaoqdJVr1pjsWuBTB3QX1eCntET6rlQgg+0lrcp+Hb5bgqu/pi4R+S5s5UwhUp4QhuuZuseDxR6xKG9Duj2zdU8Yfad8eQhwsFSlux6JdAewK+i31qO7AWVX2O61nOCp3qasham0J5JQFGBmyIJpyBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by PH0PR11MB7635.namprd11.prod.outlook.com (2603:10b6:510:28e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 00:09:25 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 00:09:25 +0000
Message-ID: <943347fa-f386-4cab-aad6-9d1914aea76d@intel.com>
Date: Mon, 24 Aug 2026 17:09:23 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net 08/12] ice: wait for in-flight Tx timestamps
 before flushing the tracker
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, Maciej Machnikowski
 <maciej.machnikowski@intel.com>, Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, Grzegorz Nitka
 <grzegorz.nitka@intel.com>, Petr Oros <poros@redhat.com>,
 <alexander.nowlin@intel.com>, <kevin.bross@intel.com>,
 <ranjit.cavatur@intel.com>
References: <20260821-jk-e825c-minimized-fixes-v1-0-9d0731eb4858@intel.com>
 <20260821-jk-e825c-minimized-fixes-v1-8-9d0731eb4858@intel.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260821-jk-e825c-minimized-fixes-v1-8-9d0731eb4858@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0142.namprd04.prod.outlook.com
 (2603:10b6:303:84::27) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|PH0PR11MB7635:EE_
X-MS-Office365-Filtering-Correlation-Id: 376a9b25-fe4b-498a-0c0e-08df023d1f34
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|6133799003|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: AXzqP6PuizwsyG36DeAia14qjb+zKiVfFRJBIXUm9D9D7p6TJ5eZnx8ncsgevASSq4twMvyOJCwsmm51RSTmUrvPjxMThd7qxEqZ0DWLlbAoTuK+1MjhCXad1AhnHHGHfY7wLGFnB4iX2eYiRtdSKjBn0Fk6hmZxdAONLwOOH20GxkB/fsBx4FA6xyZbbvxd/aoDHa60ICfrXv8/sflL28ZqLZZe72kbm/AjHuz56A/wQdqZYYZEUsCDt5zz6hdyw8juUOynXL0uXLex76nSM3d+1AsiWJ7LlMKM0gs6sSnmUZX3K6bC+mFEU3YAX1oCCro6UG4pxGGqTcwiknEWl0T/HsLvV6TDSc/MbQutM96bYJq5ybMoV8+g2Xr6iJJoLJt7UAJSuXutMwJLElmgULTGy4Jvhjvzyzp0a8OxTFACEjZdxo0eUhogoU3poTJPyFQywsgcImqzY14yNjCpMgda8LeoXwe+I0Ab0Mpy3l1iEQDgmYeK/HFGTA1Oz199PVStVi1Dj4IvXKBrDauCeTKBlCZnzqERJI1PxNOAS2IxIycSKurURXqJrgkPvZVPo+7kBNzBB75lxna847bWoMaAp9HhrfdplsQfhLYo30oihrtyxBrvtQiQTNU5Uw2DP04bIYkgp/f4GTX7Lz1QcqrNBIv6H38hvCJJpk+MK5k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7381.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NE5WWjBoVVAxWmU5eEJEalVyMVd2b2ZqUnNSdjZUcE1TRVVQandIWmVDT3cz?=
 =?utf-8?B?UWR0YjlMVXhJMTBmb3pyd0Qzdk9wc3lrT2dsYXBzUmVXZGVvUWlYWTBiVm9j?=
 =?utf-8?B?Z3VlL1NhV2dYUCtNMXZkQTFzT2ZBWVFLOUZQMjFIeFNrMFRCakVjazlNdTB5?=
 =?utf-8?B?aS9KSlUvZ2NvSkRudmJwYmhXa3R5MVFTY1RoOEhXWGVMWGluMWZGVXBIb2cx?=
 =?utf-8?B?T3Vyd2xIMEc2WGFQbmFqMkJUMzVGRmxLeGNhK0RUWmdvUHM4TXVhek9yTzdu?=
 =?utf-8?B?ZGFvT3VaaUE1a1c1cGVLNU4xU3hZOEJhRys2OWt5cmFWc3QxbDVXTHBVOTk3?=
 =?utf-8?B?TDhWVzNqbzJkVGtQNGtyTGoyeVJjWWtVbWdSUlRJdTFCZ1IzWnNlRk1nS0hQ?=
 =?utf-8?B?QzRualdpaVdxOWltM3FuMGFRcVBDUTNCTUQ0N0hWRzFERFBHUFJ5OHozQ3Y2?=
 =?utf-8?B?U1A0WUhhVlN4THhaUFpOdzdNK2N1NDVnYUlvTno2bVJ2OVVTRS9JelpMWFBx?=
 =?utf-8?B?NXMzdzNKVUxaYm1RRXhsM1VDalRVamdLakpRVGRHM045WVdwdEhHd1pLMzhT?=
 =?utf-8?B?Z2JOMEJZbE4ra3NXWXpEM3R0MjBBWk1ObktZaXVHcVpXOEV4b0s1TUFEeWQ4?=
 =?utf-8?B?ZDZYSUNNRVZqaXhhUitlRjlDMHdXOUFyWWJhQktPbTVKcmVtZ1NUWHBYNDdJ?=
 =?utf-8?B?VnB3RisySHJyWVNQYkVaUUl6L2Z3akpWeGcwNVgxdysrbkYxeldNbkp0bmtr?=
 =?utf-8?B?eUJGNm5Pcld5VUNaUEwwZWNMWUVHWnJyeWtMb2NtMklyTzRVSTZ3bnZGeWVp?=
 =?utf-8?B?dVo4SGZYeEdlOWwxclVJemlrY29jQTBZanJWRk5xQ0puNkNLSUdFK3ZBT2RU?=
 =?utf-8?B?bDlMa2g4cVJvb0tzT0hEamRJL2RvM3plSWVLTitGemEzWlFVSTl4cW1EM1Rr?=
 =?utf-8?B?bm9ya2RpNHJmQWFhOFVhaks1OXlkTStWY3lEK0FIaXBVMWdvTlhkTDRpRmR3?=
 =?utf-8?B?eDBmd0dLWld5U09XOXczeDRQcGNpZWZMdzBuT1dGejVCZWt4TUU2dGpDU3p5?=
 =?utf-8?B?a0ZHbnV0d0Vwek9ZMnhtMzkzSE1WSCtHMjNxRk56VW0zOXM2WU4vVlpVZjNB?=
 =?utf-8?B?RFdtVDVuakZaN21ZTVlCSFBLaWluT1U3NnJXWlZqeExPeGllb2tSa1RjaUta?=
 =?utf-8?B?a2t6eG9mVlJzRGNsT3ozMGZRbVorK0kxVkFrQWZNUENNM2JacEF6cDRoVEY2?=
 =?utf-8?B?T0NpREcxMFkvZ0pYM3ExMEhGZTc3cEMzaHI3dHJvZ3I4RldVUnpxZzlLeGh3?=
 =?utf-8?B?NFhETVdTMjJldmZ6WWRsNFRDQ05PZUFpSGVRY2ZUdXRLeFJTMVBGOU5NWWhG?=
 =?utf-8?B?Tm1WakpIWEorT1lnTGRpaDVUbitaQjFqNWhSKzMrdmk1Kzd1dlNqWlBldUNj?=
 =?utf-8?B?SEFkOGRNUFA0dzF6NGVRcVl5c01nUVdhZHA2V1dNRk5RcXE4LzB2bmh6TEdp?=
 =?utf-8?B?aGhYTWZyMkhxMCtqQndtWGVod250dU1BVkxBSk9HZk9kNzdrM3JGMldOVU56?=
 =?utf-8?B?MDZKNmE1R3FsUWxiajE3S1dtWVU5cDlkOGJWMUlKcFdUeGVpSlZNVmRGNnFT?=
 =?utf-8?B?THpwaUtJOVFNUGRVeDg5cndocXo2WFVFNWJGY0g4NG90Q094QWpJeDlQZXp2?=
 =?utf-8?B?OVpMNkVnczlBVTUxSndKZkpQSzRHekp0RVZmd1cvVmRTSkJhL29UWkJUVGpy?=
 =?utf-8?B?NHpSNWg3SkQ3RTMzRUhKTm5XTnRzU3JQYW41NHJMRGVidTVoWUZnUU9icHNa?=
 =?utf-8?B?WWdqWVczSU1vS1pjQzM3amZwQ0U0ME0ya0xVMXJJNU52c24wOFNEeXNQb1Na?=
 =?utf-8?B?MDdmQlYwRHhEblhjWXZmV2JSbG5CdTBFaXV2a1Q4eGpha1RvZTkwTzhlN3h2?=
 =?utf-8?B?cTR2NlNIR0RRY0xtaGZmTEdLMGZjYkhOdzZrT1J2V3AyMnd4ZzhLRGhCWUdo?=
 =?utf-8?B?ZXlNK3c2dHEwcnA3cFdMbkZ1bEczMDB0Nkt1M2xSWHVabk9XUzF4SHZoWnBo?=
 =?utf-8?B?aWh1ZmpzYkpSR3lNZ0tBMWRhcmZHMlBhZlhXMEZOZ1JzOGx5MWhEQmVqTGJF?=
 =?utf-8?B?bWF3R00xakE1Vk42WXRoNklhd3dmdm9uUUtwaGpjZ0RyRDhNWXBzYzZUTXVQ?=
 =?utf-8?B?OUZnRm1iaXVGbDlFOUZYMkptazU3ZlplaTQ3MVN1Z1RtWjFtQ1hXWEZ0djNE?=
 =?utf-8?B?YVJSaEdvTEdPTzJHYWU4TWJKQTZveFlWbXBwbVpkdDBlMzhBdUM2YXAxSGY1?=
 =?utf-8?B?MEthWU81T0RHYzZEa2pFYXBsYkE1LzFJVkM0c3Fhdk40bTdESTBCdz09?=
X-Exchange-RoutingPolicyChecked: xBvHBJUw2AwRz1ht2+mLXxezf8y7s1QBnw/3Qm6cK6U8YPzVu8kPUrfUqnYA5roWghxAHfiUH1eS/Yuc3ygBnt1H5acjknBbyV2KSf/d8D5rFyza5v3YmLpAwy2w2P+cwHSvrzsGUz8QEmJ2k0nYBpf87vxxCBOkMQ73rT1USt+g9Mw1RiE3AfbSsKe+1g3EdeVZXsibQZnEtlLYUALEfUJKrr+a8D3dqSRr6nE3DulYRxIDi8LMwCFct95A4LyoGCNpVfDZ6OhTcsPW1WbuB4xYi72zjgAWx2NUhp03I9fJeex4wHuoohQO4gA4rMlJLtsjUMA+EdEgX4VrVtZNyQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 376a9b25-fe4b-498a-0c0e-08df023d1f34
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 00:09:25.1151 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a6OApZlebdRwFMKWnvUsmTIYDKwZ5D38FJ7p6u5aF0tX1kHNRdrsMGM0rh1F7Dkm4KSukKND6EvnMHboyrRSQYyC3grHbhiU0HYvhCA7YVs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7635
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

On 8/21/2026 5:13 PM, Jacob Keller wrote:
> From: Petr Oros <poros@redhat.com>
> 
> ice_ptp_flush_tx_tracker() frees every tracked request, but a request
> whose timestamp is still being captured by the PHY at that moment is
> freed without touching the PHY entry. The ready bit published shortly
> after has no tracked owner, and the PHY does not raise another Tx
> timestamp interrupt until every outstanding ready bit is read, so
> delivery for the whole quad degrades to the periodic work.
> 
> Wait up to 10 ms for in-flight captures to publish their ready bits
> before flushing, so the flush clears them together with the rest.
> 
> Fixes: ea9b847cda64 ("ice: enable transmit timestamps for E810 devices")
> Signed-off-by: Petr Oros <poros@redhat.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ptp.c | 33 ++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index 8aa49dda90a2..a049dc7a2241 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -740,6 +740,37 @@ ice_ptp_alloc_tx_tracker(struct ice_ptp_tx *tx)
>  	return 0;
>  }
>  
> +static void
> +ice_ptp_wait_for_tracker_drain(struct ice_pf *pf, struct ice_ptp_tx *tx)
> +{
> +	unsigned long deadline = jiffies + msecs_to_jiffies(10);
> +	struct ice_hw *hw = &pf->hw;
> +	u64 tstamp_ready;
> +	bool pending;
> +	u8 idx;
> +
> +	if (hw->reset_ongoing)
> +		return;
> +
> +	do {
> +		if (ice_get_phy_tx_tstamp_ready(hw, tx->block, &tstamp_ready))
> +			return;
> +
> +		pending = false;
> +		for_each_set_bit(idx, tx->in_use, tx->len) {
> +			if (!(tstamp_ready & BIT_ULL(idx + tx->offset)))
> +				pending = true;


Sashiko says:

> 
> This isn't a bug introduced by this patch, but does this loop risk a NULL
> pointer dereference if tx->in_use is NULL?
> If ice_ptp_alloc_tx_tracker() fails due to memory pressure, it leaves
> tx->in_use as NULL while tx->len > 0.
> If a concurrent PF rebuild then calls ice_ptp_flush_all_tx_tracker(), it
> will iterate over the list, find this partially initialized port, and call
> ice_ptp_flush_tx_tracker(). This now calls ice_ptp_wait_for_tracker_drain()
> which would dereference tx->in_use here.


I am not sure about this one. I think if we fail to allocate the in_use
array we check and bail out and fail to initialize PTP, leaving the PTP
state in ICE_PTP_UNINIT.

ice_ptp_rebuild_owner does iterate the port list.. And if we fail to
initialize the PTP port it will get removed from the list. I guess it
may be that there is a small window where a concurrent rebuild could
cause a problem before it gets out of the teardown?

We could possibly delay inserting the port into the list until a later
step or have the loop check of PTP initialized before continuing here. Hmm.

I'll try to address this in v2, likely as part of the first patch with
the kref and RCU.

> +		}
> +		if (!pending)
> +			return;
> +
> +		usleep_range(500, 1000);
> +	} while (time_before(jiffies, deadline));
> +

Sashiko says:

> This is a pre-existing issue, but does adding this sleep here exacerbate an
> RCU use-after-free when iterating PTP ports during teardown?
> In ice_ptp_flush_all_tx_tracker(), the code drops rcu_read_lock(), calls
> ice_ptp_flush_tx_tracker() (which now sleeps here for up to 10ms), and calls
> kref_put() on the current port.
> If the last reference is dropped, a blocked teardown thread could wake up,
> complete synchronize_rcu(), and free the port.
> When ice_ptp_flush_all_tx_tracker() re-acquires the lock, it will evaluate
> port->list_node.next and dereference the freed port.

I think this will be fixed by correcting the locking and kref use of the
first patch, ensuring that we can't release the port in this way.


> +	dev_dbg(ice_pf_to_dev(pf), "Timed out waiting for in-flight Tx timestamps on block %u\n",
> +		tx->block);
> +}
> +
>  /**
>   * ice_ptp_flush_tx_tracker - Flush any remaining timestamps from the tracker
>   * @pf: Board private structure
> @@ -756,6 +787,8 @@ ice_ptp_flush_tx_tracker(struct ice_pf *pf, struct ice_ptp_tx *tx)
>  	int err;
>  	u8 idx;
>  
> +	ice_ptp_wait_for_tracker_drain(pf, tx);
> +
>  	err = ice_get_phy_tx_tstamp_ready(hw, tx->block, &tstamp_ready);
>  	if (err) {
>  		dev_dbg(ice_pf_to_dev(pf), "Failed to get the Tx tstamp ready bitmap for block %u, err %d\n",
> 

Finally, sashiko says:

> This is a pre-existing issue, but does Tx timestamping get permanently
> disabled after a non-PFR reset?
> When a non-PFR reset (like CORER or GLOBR) is triggered,
> ice_ptp_prepare_for_reset() calls ice_ptp_release_tx_tracker(). This frees
> tx->tstamps, tx->in_use, and tx->stale, setting tx->len = 0.
> However, the rebuild function ice_ptp_rebuild() doesn't seem to call
> ice_ptp_init_tx() to reallocate these resources, meaning subsequent Tx
> timestamp requests would silently fail.

This is a bug in commit 7a25fe5cd5fb ("ice: stop destroying and
reinitalizing Tx tracker during reset") which tried to remove the
destruction of the Tx tracker during reset. Unfortunately it looks like
that commit didn't actually remove the actual destruction of the tracker.

I'll include a fix for this in v2.
