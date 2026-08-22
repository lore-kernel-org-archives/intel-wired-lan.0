Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 775E6C5B572
	for <intel-wired-lan@archiver.kernel.org>; Sat, 22 Aug 2026 04:17:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3BF9A606CF;
	Sat, 22 Aug 2026 04:17:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Dx6QBPQJC75f; Sat, 22 Aug 2026 04:17:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787372274;
	bh=ZkjvfCmQEwX/5/gi58wsBeQSJ+zYfABgBE4P0d3QsdU=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a6EjCBm9tTvLkqAg7gUJiRuSOTwbwRsFWdWmFj4ewRU1apbTN13KFyuxGW93nStZ8
	 4nPQBnMbbQRRBjiwa9dshIzVWtIjq2uap/jV7/maLJ3IOUbe8tUaSq5Ats4Z4JzD6P
	 WXhO/PnFtVRjHB/45Du5b9DwAnOr0m9ZSYasW+S34TBtwZwZSTeF0T6ZVLq8tVgVy5
	 EKlaOZUkyqhEtnIkmofoKY+vtLIbWW7mJGproVo0CsGmYh+UXL1PwQ7t+ha0AG20S0
	 jSrGV5Qad8oC1OibjLUn1bxCNpMR84LCzPGaZF+0UpybciofOMzr7T3LnUm3TDLQMj
	 ouWDPuI/chu+A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 515CF606C7;
	Sat, 22 Aug 2026 04:17:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 57413336
 for <intel-wired-lan@lists.osuosl.org>; Sat, 22 Aug 2026 04:17:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 49321606C7
 for <intel-wired-lan@lists.osuosl.org>; Sat, 22 Aug 2026 04:17:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8tbsuulHcAyW for <intel-wired-lan@lists.osuosl.org>;
 Sat, 22 Aug 2026 04:17:52 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=alexander.nowlin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=YKEiEerW
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 36C8560679
 for <intel-wired-lan@lists.osuosl.org>; Sat, 22 Aug 2026 04:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787372272; x=1818908272;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ZkjvfCmQEwX/5/gi58wsBeQSJ+zYfABgBE4P0d3QsdU=;
 b=YKEiEerWIk+HONx3YB+Yh5MESTBi3KCIjPbp7q1kOp6tUBL5xb+q0y9G
 1fcXoWmq3PtVK0Jvxuh9nI0obVtvpNuxQ4Jt7XOqLSA9noASLvRbdvwFU
 bKWJYU+pxkFix3eAZyy1QLbPjFsfYpZB6YWsiKY9AcxKJE52gAV7y6eaE
 7yYr2e0JtC/JCXf79drsGkYI3gWel2ItFpELM9vpi1LfbdNFHo6AcXnDP
 Et9NZzu3uB3GvJNcdzchmhBR34nnvZHZIxtWkOk8ZE6QeZSHI0NpswOIc
 Yv+aIOXxM3zQVNhsToRwTW/yZXEabgHnyba8MHRekWz0n7oeVihoNvydr Q==;
X-CSE-ConnectionGUID: erOVUTddSnSmPeVYxcf2gA==
X-CSE-MsgGUID: dEwjPwBbQkGuXVGtiBezSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="91791203"
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; d="scan'208";a="91791203"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2026 21:17:51 -0700
X-CSE-ConnectionGUID: aWUtMgkXS1SItpHN7cQvlQ==
X-CSE-MsgGUID: 2wisMJnVSJqbmf9SrjdyYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; d="scan'208";a="268467083"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2026 21:17:51 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 21 Aug 2026 21:17:50 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 21 Aug 2026 21:17:50 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.56) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 21 Aug 2026 21:17:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h+9VpP07QXqFG14S7YBy0CZzILyBjk/y2vEbhtyHBWnd1MQQMmT5H0OSag3O6NqQunKFvdm4qmWqjbuwJ4r6uTQGPtIz1t7lb8F0T8L99+V+RuVN6GXVei+QWEX4o2ApC5nh7V9cIhZKUMJ7BLXtjqbJGkH5O0Nu2qdmY8v4FzKMAee7kkyBuZGnYHW8gZwzMQ9t1WnwG2+ktOCgoKQ56uAitjb85XnuD5gg7dIIXY6ML7BjkOvRIchOu48lVDKTQ7s500qTpULC4uD7gQeuMFmlUQcgDhVLXsthiXihYLtqfCSjA7M+VUTQBj/thK3ak/lmcEXIRp8Sd4vdOs11ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZkjvfCmQEwX/5/gi58wsBeQSJ+zYfABgBE4P0d3QsdU=;
 b=xld5mNySz3eh4t8JdUOpvAJB5jF3TPIBcm11To3hMN/xOFuhwHNQOX/nGRbV78J2BSMlaJXFPQuUA8YFpCEu0Yq2jonKDMxRfQb6LlNtSSJ4rhxeTjXnEDmQz6w+JGErwWJBTqTwS+1yhe3ZodM2FT7Rbl3ETxfGiP1sthJP/crp3YDb5SLC2bPSO2tjYNLb4ldeqfQ/Uzm/UKk7JugsqbjUwJOJLzvzI9lgnq57SE7vdeqBkVS983j6l5XbTJ4PHrIWXTJPIMk4kM5rswd3KsvTEZA+jykEc00CQtE0GE42kC8G7N2KuEI5oZ3wKj3AfFLwAbSTOkCqRSvUeYsplg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by IA3PR11MB992400.namprd11.prod.outlook.com (2603:10b6:208:61e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Sat, 22 Aug
 2026 04:17:48 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0315.014; Sat, 22 Aug 2026
 04:17:48 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, Intel Wired LAN
 <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Machnikowski, Maciej"
 <maciej.machnikowski@intel.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Korba, Przemyslaw"
 <przemyslaw.korba@intel.com>, "Nitka, Grzegorz" <grzegorz.nitka@intel.com>,
 "Oros, Petr" <poros@redhat.com>, "Bross, Kevin" <kevin.bross@intel.com>,
 "Cavatur, Ranjit" <ranjit.cavatur@intel.com>, "Machnikowski, Maciej"
 <maciej.machnikowski@intel.com>
Subject: RE: [PATCH iwl-net 08/12] ice: wait for in-flight Tx timestamps
 before flushing the tracker
Thread-Topic: [PATCH iwl-net 08/12] ice: wait for in-flight Tx timestamps
 before flushing the tracker
Thread-Index: AQHdMctNi+h8U5Ox9EOCkpBggnZFUbapdq8g
Date: Sat, 22 Aug 2026 04:17:47 +0000
Message-ID: <LV1PR11MB87903F420FD65B7FE1A7715090A22@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260821-jk-e825c-minimized-fixes-v1-0-9d0731eb4858@intel.com>
 <20260821-jk-e825c-minimized-fixes-v1-8-9d0731eb4858@intel.com>
In-Reply-To: <20260821-jk-e825c-minimized-fixes-v1-8-9d0731eb4858@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|IA3PR11MB992400:EE_
x-ms-office365-filtering-correlation-id: c845b2f9-f58b-4819-5a2c-08df000452dd
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|56012099006|11063799006|38070700021|4143699003|10067099003;
x-microsoft-antispam-message-info: ZlMzh1y3UtNBCJ3xIyMqtlNXpPOt5QF51Ci8U2cjcUZbngyfgfeYM00Uf5i4NnaxA9c80ZQtST5/lWNNi00+QxSFAnCOg44RntPUzGXiXplkThvRxezogEgfdg8RKHVUDVZlJyTlXYRuRMRJNHsGdY3wclGGyBJ9I3k4Szk5tnrKiDp3bbG7ZloyaEFjW9VxwVzwfDHQBO7rC1MC09Ka6C4FSQGFtmEK2E12IziJEw5jguD40Ebmyf5wYQ6NmhVlMkMgIjGPaz65o2VrXjRVqneaF80whvK3fHVztiExnBAwqVg/Y9Aj7HBC732WLxKKE9au+/u+e3lynW5sviyS4yG8HGu75j8ZA5zDucwWOw0lvZWq9CQkDWbOPXMG429xFJzgaNaRDRx2fsLo9GTH5qJ4G6a6AyZqNNN0OJwx16o7nuck70Nxkhx2kBHeFoqlbU/K/SvVhcnqpyo/wberW6K6em6YCgEEdBLYmk2qx7Yc1rLLEVvnrmHSK8xaG9sc0X8X47odJgnJXrF4WQYIEKMgIwkR1vGsDsQAZFfEUnWwC9rhkocyXbVPD8RqemwhMtn8cs3zCdeapZGETNgaYOspCQSv/VJWlo+HEYWk4vOAGIimUlGuZQ/B9DXXenRHMkZlc7+LvLjisufcS8E0KnPwx0X40i/NSriE2TnqhweKnMnPGh4cbgFXLzt6GfVigF2hqUgQzOP9reO25sSIFg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV1PR11MB8790.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099006)(11063799006)(38070700021)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RUlBQTlrZ3JsTk9mVEEvRW0zRVo0RHZSRWJ1N0ZDTmdnRE1OK1hwT25yTVVl?=
 =?utf-8?B?NHRjU2l4ZGlrODNDZEhDYytVZFVOWjhXYWdhTFZpRUtjNERreVpFMTdOQkVL?=
 =?utf-8?B?amZEa0M5RGRjNkFqaStVVE41M1U1YTZIditHQzdJRy9FZjNLcFVhZGdDMlRX?=
 =?utf-8?B?ZElPR080bUQ0SzB5ZmlxNkhMeWhNN0M4UHpBeHNkR1ZjS2MrMS9TbFIycjY3?=
 =?utf-8?B?Z0x0TGRPQ2JORDJrZlEzRm01bWVBSEJIcGVLRlBrMjZkYTlTUi8xZWVpOU1H?=
 =?utf-8?B?VitoRDBEM1ZYZWxsR3QzcXlwMVh4RFV2eXBXUzlkVHE1cVlxWDZSMWxTaldX?=
 =?utf-8?B?a2pUSlNnNXErZTBJd1BGRnh2dGtVcERtV2YvREgvTFlJSzlFWVJqYmMydmhw?=
 =?utf-8?B?d3dHS2UwbjdOVXZqTmNiZXdET1NqRDNCUmp2ak0vdTZaZDBrMmFSdnFXUFZ1?=
 =?utf-8?B?YUNSUy9HYUJlTU1YNDNTeGptcjlxRng1Nmk3U1VGOVI5UllYTVBrZUhudjdF?=
 =?utf-8?B?SkdLKzBWb3BsUmhhTFBmQXl5aENKeWVvb3M1dW4wSDlKVUE2VENQSW5SVjBY?=
 =?utf-8?B?MHFBU1BQUzZlamNzREJqY3pUS1Q0RS9QOUF5ZnNDTXhJQWhzcy9lRTJ1Nyto?=
 =?utf-8?B?QytKQXZGdndlNjVGbHhyS1N4QTNvT3poZ0Z2SDY0blpmNzhRaXBldlZ6UEVn?=
 =?utf-8?B?ajRQSzg4aUlFWGwyRDJxUHVJWGFtMzhjLzlpRzRUM1lrbForZkV5NFh6eGM2?=
 =?utf-8?B?RGd2S2ZEbzlQcjIrVkMzK1BkamFjZmtmLzA5eEYybE5OY1VVN0hINGF5SVVs?=
 =?utf-8?B?S3UvTGhtWld3dmNLUldQOTBOcmdXaHZaT2dKOXRsUGtpVXZaUTJpV0lHQmdv?=
 =?utf-8?B?TUxZYld5bUpmcTR1dHB6ZmhoY09XZkFyL3NJK2RneHZ5OWdCWjk1OXhOd0xK?=
 =?utf-8?B?QXRrVlhjRTAvMmlQcGZxYThCT1FkTDRQdVJHQ0x5SC9uMVRGaG1mLzJrNGVB?=
 =?utf-8?B?Z2hUSkNCVmFPaUtKNThGY3p3V0ZGNm8xaWtGVVJjZmF0Y0hQY24yd1I4Misx?=
 =?utf-8?B?UVZyRXk0Vk0vdi9oZFc0Umo4a0YvbEpDOVRIQ3k4ZVlaVEY0SHR5V2Z2TUJJ?=
 =?utf-8?B?bWJ1Q0RHM1N5blR1QU1nd3NwcGIzMWZoY3ZEcGtYdWRXQ0FKaEE1djZPYTZp?=
 =?utf-8?B?Z202blROOWNld2EvcmdlVHdRelF6eGN3d0N5c1VVajZhL0xienYzb3lzc3Ro?=
 =?utf-8?B?UGN6THJkSUl0Z1ZMbG9FQTFTT21vRVNVby81b2hFZ0lET0VVTEhPWVRkWEFB?=
 =?utf-8?B?elBSMlJPb0dpaFpIWm8wT01hRnJIanNWT1pwa2MwRDdnREk5S2lSREdDdWpp?=
 =?utf-8?B?OE9MU1hxaGdHTm1TZDVtbTY0ajhNekNSY1lpby9kVWdyNU9QSk4rU1dtbUVq?=
 =?utf-8?B?OUpHRk9TR2JkZ1JHblBua1hnRFprbS9RdEVDL0YxUzlVVE9pK0lKcndDVFRD?=
 =?utf-8?B?T1FBd2VkUEtoRzcyclltMHpBNnB1NTQreEdQaDBuNGFpdFJHSThJek5IUEJH?=
 =?utf-8?B?VnZ5MDNKTklsT1dCK3B6YldTS0ZrL0ZyZ2ZlWiswQWJBMVpMekFTTlJrUWVC?=
 =?utf-8?B?UmMyemRETGw5WDVwMHpJZlROQ0E3TUxoRFFnbXJGRVVSNFNERDdUeDFpeEM5?=
 =?utf-8?B?bFYzdmI2NkRxUEFlcVdqWkhPRTVESjFaZVE2NGFCT0dCUk5EMzFsTmNseC9G?=
 =?utf-8?B?NCs2WFcwcjBzSlJHd0hBd0FJeUg1aTgydXpzSkpxT2dhcGNLQjR2TW02TDFn?=
 =?utf-8?B?TG15YUZtMzRvaU5OQ0ZHWHF6MUFTamFlTWtxVG1NcXp1STVnNDJ2MTUvOWxB?=
 =?utf-8?B?MjhQbUR1TC9wWnhsaWtjU1JIbVdvUzY5dXdBY2h2Ujd1T0pzTS95Njc0K1Ey?=
 =?utf-8?B?RlF0azhTUDFtVkVsZGM4bVBrYzcwcTRCWUlqb1UyMTJYYWQvU0JtNTVWaFVv?=
 =?utf-8?B?bnM2QzFtdkIzajdIZW1JY0dhdHVhblVrcmVoQmxMVkZBbmpBSC9KMUdScXFV?=
 =?utf-8?B?V3h2NWJpVEpvS0VrV1RqVnlGdStOa05DTVNqUnRyMFg3RTZFK05EK0lvRk5R?=
 =?utf-8?B?c3dxSFFaR1dCWXhlZlJ0ekpqUFhuVWZjN3I2QmNiRlUzc0h2TWk4Wnkybzk0?=
 =?utf-8?B?TU9MRXVPeGhHb0tpZXpYRzJ3bDc0SGQ4TitkU1NBVGgzNjhLK21RUExOcnYr?=
 =?utf-8?B?QUVvN21lK0RBUE5wT0Q0dDBSUUg1NldOMDFpTWtBb25HdlE2Uk9odFJuaUhH?=
 =?utf-8?B?cFJXNzcvdUV2cTAzTGN3TkdnVjBzYVlsS2huUzdrdU0vcVpqVnlvUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: s3CrDb3nk4mrZL43YLp/WhuP0zA3RUklVWGLDVdUd8PFotf3lbiwVcb5vXo30qd1kOhSBoRDVo/YFrNvSCiuwQTi1xFSHUorjt6C3tL32n/k2e7+yO1Qfhdw9GiLLfBnhnGI6/C5thTCZf4MLPWl03+O+biV/Q+Eqx0XSCxvLUYb/3A4qZsTb/uqR7hfGPipkRO32YGMcW1/lI+lhkTCh+qH08eBSgEWP9HP3GXXH+mpbqM4CsgYMXJHPl8oJuTyfU4xzSoaAvfPrtZfxsE2PnQALP/K62GA5l0DhdLDcm8u2oiiFsd0OkrXM1Hb1Srsj4Lp2/jriz7Hi+nkMZVIHw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c845b2f9-f58b-4819-5a2c-08df000452dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2026 04:17:47.9823 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NTVs4lc6ez8+GZ4+PWdSwkCEIIoaHDdXHK6P7b26TDWU9BehdG2CRkPSZAMOGCwTBjLCNSQ189A66JzS/YYOYps9N5dTZ60hQKGfYPcPfoE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB992400
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLZWxsZXIsIEphY29iIEUgPGph
Y29iLmUua2VsbGVyQGludGVsLmNvbT4gDQo+IFNlbnQ6IEZyaWRheSwgQXVndXN0IDIxLCAyMDI2
IDU6MTMgUE0NCj4gVG86IEludGVsIFdpcmVkIExBTiA8aW50ZWwtd2lyZWQtbGFuQGxpc3RzLm9z
dW9zbC5vcmc+DQo+IENjOiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBNYWNobmlrb3dza2ksIE1h
Y2llaiA8bWFjaWVqLm1hY2huaWtvd3NraUBpbnRlbC5jb20+OyBOZ3V5ZW4sIEFudGhvbnkgTCA8
YW50aG9ueS5sLm5ndXllbkBpbnRlbC5jb20+OyBLb3JiYSwgUHJ6ZW15c2xhdyA8cHJ6ZW15c2xh
dy5rb3JiYUBpbnRlbC5jb20+OyBOaXRrYSwgR3J6ZWdvcnogPGdyemVnb3J6Lm5pdGthQGludGVs
LmNvbT47IE9yb3MsIFBldHIgPHBvcm9zQHJlZGhhdC5jb20+OyBOb3dsaW4sIEFsZXhhbmRlciA8
YWxleGFuZGVyLm5vd2xpbkBpbnRlbC5jb20+OyBCcm9zcywgS2V2aW4gPGtldmluLmJyb3NzQGlu
dGVsLmNvbT47IENhdmF0dXIsIFJhbmppdCA8cmFuaml0LmNhdmF0dXJAaW50ZWwuY29tPjsgS2Vs
bGVyLCBKYWNvYiBFIDxqYWNvYi5lLmtlbGxlckBpbnRlbC5jb20+OyBNYWNobmlrb3dza2ksIE1h
Y2llaiA8bWFjaWVqLm1hY2huaWtvd3NraUBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCBp
d2wtbmV0IDA4LzEyXSBpY2U6IHdhaXQgZm9yIGluLWZsaWdodCBUeCB0aW1lc3RhbXBzIGJlZm9y
ZSBmbHVzaGluZyB0aGUgdHJhY2tlcg0KPiANCj4gRnJvbTogUGV0ciBPcm9zIDxwb3Jvc0ByZWRo
YXQuY29tPg0KPiANCj4gaWNlX3B0cF9mbHVzaF90eF90cmFja2VyKCkgZnJlZXMgZXZlcnkgdHJh
Y2tlZCByZXF1ZXN0LCBidXQgYSByZXF1ZXN0IHdob3NlIHRpbWVzdGFtcCBpcyBzdGlsbCBiZWlu
ZyBjYXB0dXJlZCBieSB0aGUgUEhZIGF0IHRoYXQgbW9tZW50IGlzIGZyZWVkIHdpdGhvdXQgdG91
Y2hpbmcgdGhlIFBIWSBlbnRyeS4gVGhlIHJlYWR5IGJpdCBwdWJsaXNoZWQgc2hvcnRseSA+IGFm
dGVyIGhhcyBubyB0cmFja2VkIG93bmVyLCBhbmQgdGhlIFBIWSBkb2VzIG5vdCByYWlzZSBhbm90
aGVyIFR4IHRpbWVzdGFtcCBpbnRlcnJ1cHQgdW50aWwgZXZlcnkgb3V0c3RhbmRpbmcgcmVhZHkg
Yml0IGlzIHJlYWQsIHNvIGRlbGl2ZXJ5IGZvciB0aGUgd2hvbGUgcXVhZCBkZWdyYWRlcyB0byB0
aGUgcGVyaW9kaWMgd29yay4NCj4gDQo+IFdhaXQgdXAgdG8gMTAgbXMgZm9yIGluLWZsaWdodCBj
YXB0dXJlcyB0byBwdWJsaXNoIHRoZWlyIHJlYWR5IGJpdHMgYmVmb3JlIGZsdXNoaW5nLCBzbyB0
aGUgZmx1c2ggY2xlYXJzIHRoZW0gdG9nZXRoZXIgd2l0aCB0aGUgcmVzdC4NCj4gDQo+IEZpeGVz
OiBlYTliODQ3Y2RhNjQgKCJpY2U6IGVuYWJsZSB0cmFuc21pdCB0aW1lc3RhbXBzIGZvciBFODEw
IGRldmljZXMiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBQZXRyIE9yb3MgPHBvcm9zQHJlZGhhdC5jb20+
DQo+IFNpZ25lZC1vZmYtYnk6IEphY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29t
Pg0KPiBSZXZpZXdlZC1ieTogTWFjaWVrIE1hY2huaWtvd3NraSA8bWFjaWVqLm1hY2huaWtvd3Nr
aUBpbnRlbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2lj
ZV9wdHAuYyB8IDMzICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMzMgaW5zZXJ0aW9ucygrKQ0KDQpUZXN0ZWQtYnk6IEFsZXhhbmRlciBOb3dsaW4g
PGFsZXhhbmRlci5ub3dsaW5AaW50ZWwuY29tPg0K
