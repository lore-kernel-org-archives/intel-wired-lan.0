Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E322BC5B572
	for <intel-wired-lan@archiver.kernel.org>; Sat, 22 Aug 2026 04:17:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7EE8F80F6F;
	Sat, 22 Aug 2026 04:17:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xFZpu2m-Bt3X; Sat, 22 Aug 2026 04:17:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787372246;
	bh=sH8XlxX9eyUGWLOc7uy215rz91rZx2DYyu3aO7l/+xg=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MOGRkq0gTj1+nn8Ox1T8ufBpsgGmuNJ+bNmxZSuqQZjPimV4ptL0K8CceqmCSRyoD
	 cv69vazX5DBU34gt+twGtaZSTqfgmFZapjUWmvoD3ZEANqRTxi6Ty4wysWjzVJ6RxQ
	 IvEmLa7vKrUMWDf/vvXTON/2taRqVXuM3HCYsSI7Ls+TBlY8VXXXOPTzwCY6TNW2b9
	 yH6nhKD3E3+zCwN/eDa7cZk2DQioZUardLOb5OnRzghsIzfXqfceiOMU8R1GJSG4Q5
	 fZux/aDDc2CozWkVA5EujC11G1x4bScMExTZDyUk9blMajN4wcKO5zuzBtHzkg6lHF
	 fvARxIcvt3oVA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4D99980F70;
	Sat, 22 Aug 2026 04:17:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0103A336
 for <intel-wired-lan@lists.osuosl.org>; Sat, 22 Aug 2026 04:17:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E6E04409D7
 for <intel-wired-lan@lists.osuosl.org>; Sat, 22 Aug 2026 04:17:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WS75mjxutXRR for <intel-wired-lan@lists.osuosl.org>;
 Sat, 22 Aug 2026 04:17:24 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=alexander.nowlin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=TeiYQi1Z
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 33A42409F6
 for <intel-wired-lan@lists.osuosl.org>; Sat, 22 Aug 2026 04:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787372244; x=1818908244;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=sH8XlxX9eyUGWLOc7uy215rz91rZx2DYyu3aO7l/+xg=;
 b=TeiYQi1ZOqGZIPoxYcKIb9VeBYBRBcR7KCTMfdB9St/j5mHHXlVjqHT/
 VStEnni4KzJbg1ggnvRLo1XWwS6PMtgwQJxw9B6edx2Wp/UYSSc9aJhbY
 ljh/B3rFVVroGgGSEua+v/dssHSJT5JbkJvz5a2NBc9AFcQCyDtdNZL9j
 ohiKLhqG7g+dXkZt5EYokK22j1uW5RHbekvWh/Vt7xfasLh41pYfRhKpf
 cr8mKdSctYBPyvuel6YFafv9IH3EJ8zLMfPhnjrnk8zoqPYcnp8Ywa50B
 BANe+U7Rpc+t1WCxmALlsnTJO9IycUCRXDhnvWXI9LkhQ0/5woQcf6Mpr g==;
X-CSE-ConnectionGUID: gOtnwrU/QGu84VhSlgKBiQ==
X-CSE-MsgGUID: NMiXcBRvT56mudnRQ9QMcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="91791169"
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; d="scan'208";a="91791169"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2026 21:17:23 -0700
X-CSE-ConnectionGUID: Bdt/ZK+qQCej8tz5e+7IBA==
X-CSE-MsgGUID: 1iPxJv5qRPqTUBwXp1LTwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; d="scan'208";a="268467035"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2026 21:17:23 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 21 Aug 2026 21:17:22 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 21 Aug 2026 21:17:22 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.66) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 21 Aug 2026 21:17:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eFt/TZ8okq1NSnrI+fqT8RHF6W7VQx7PT6r1wK/Kqs5AmXN1lrqLA+ZbF4YqmQbCuT3YcsGvTMC3Bbi/7yLnN12eDsDmLnM47KoybueDCLsQ0IfRTpVewODRh4HmCHZhdUpRD4oD0Gq3agz4NLB8OXpBVL6hINmKmfpC5WtAAqAdGoRy1htPaGXzD119V7HKx313CW1tCYyfQCusEoYeoC0zowIseyy37c9IkugVWetRP16K9u02jzhONr/zCFWRFVhyp4xqZTrRieIATAbSg6gemzjhVUFN5wQ1bC9Adf85jpMpGldCuZFdiBv49Ifv5mdh4PHMYgcMXwZbR9Pgww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sH8XlxX9eyUGWLOc7uy215rz91rZx2DYyu3aO7l/+xg=;
 b=AXTbHt6aTsCYpt6I7y/T138l16/+IH4P2HBT/fBhLHZ6wLN7lqGZiyS3tAe64ShYQZ34ICxcpK9MR2BzcSDtQaUfHTbsrHszNlk+cMWt5/+FMMkiQnac3im0Xhc5cKCyJw4FfSsqGJRYN1zLeqBcjQsIgLSVd2u4CBrrYU7mYLljopuMHKSO/w0KMjJqwdNKCxk/4J1Iz+7s01d8WY1w8dIkVd3RE5AuyShzIhsmIgEQyungyUACCZgeh5Qa+sR0k8efmUpgD2uHL/HpQ5uKQlFX0dIJE4mcfaSizO5lJeQWLgbbWEF/JvBcq5lQfoX9I0voAaP5PC8/eW7wzDSGfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by IA3PR11MB992400.namprd11.prod.outlook.com (2603:10b6:208:61e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Sat, 22 Aug
 2026 04:17:20 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0315.014; Sat, 22 Aug 2026
 04:17:20 +0000
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
Subject: RE: [PATCH iwl-net 07/12] ice: E825: perform a soft reset when
 starting the PHY timer
Thread-Topic: [PATCH iwl-net 07/12] ice: E825: perform a soft reset when
 starting the PHY timer
Thread-Index: AQHdMctNxNnmSx0Vbk60X3uMzaqghbapdomA
Date: Sat, 22 Aug 2026 04:17:19 +0000
Message-ID: <LV1PR11MB8790030B067B6A8D6B19BBD990A22@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260821-jk-e825c-minimized-fixes-v1-0-9d0731eb4858@intel.com>
 <20260821-jk-e825c-minimized-fixes-v1-7-9d0731eb4858@intel.com>
In-Reply-To: <20260821-jk-e825c-minimized-fixes-v1-7-9d0731eb4858@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|IA3PR11MB992400:EE_
x-ms-office365-filtering-correlation-id: 771babad-0ade-4031-1c82-08df00044234
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|56012099006|11063799006|38070700021|4143699003|10067099003;
x-microsoft-antispam-message-info: GxRWXT1h81GREU81leDBlwM1XO0q87mjbQphyH/zJOFZ2TtxpPEzQUW9dPgVkIEJcOo282HYGA/CnBQtchWFo7qS6w6psDXNbhBVP6z+R00h2S81kXHtCcRFcIXb980y7TaImCbx9UkOlkJe7bF4FBiG9N9oRni3kyWv1gCY3mFufd/d4zKTwqo8CGmsTRnjULTo4O1AICD9zG1GE80HxY7nPaVbKH2jGHS1CI6BfgvOtUdiXBW0H9jWH+fa2KZHUHaeWDxzIaLuuUHYX50bWIvXpQThwOmYIH2X6vFvP3CJBW8IOGE/EINrA4nABcXuo2SMbYQlLt/nfHkJIVT7KaHeMXfmRMrv8umoDcJKDU9QHSXnyF7QS1lmVwu/dtVh/nQnddmz94wXEfb1ArW6yd/uRguoAIBj1CfVQ5bMUPHR/ciSl5ZXccBXzBXtgb9B8N1Ly3LRitP36+DJi++TgtJTHimnYMU+oCy9QgwE+mkNbZCPe8KQ8z+fd/lZzyC5c36DfrmxNc/K1IdbogRlUyulB8iNSCysvgnUVQ3OmRWULzvn08KTdKLHUYlJ6tfzu/GLn2iRf78vhrX7spY9NGynfsphAj11rXk5pJFrIth3g2YqHJ+ZFz/9Ei9vcG6KyQP30LiMZuiGD5yGBHn9VvULq4p6+HBCDgmSuOiaSdgtsj31Mz31GoZaR4OB4b6BHDv1qbx5UOZN10F/3CRhB8nxFYjRR/uZTP6xIJnXrJw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV1PR11MB8790.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099006)(11063799006)(38070700021)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YmtyYzdJaE4zb2dWbXZiSnd2U0xUWkRBUVBSYXA5d295MU9MNlcwZ3A4VVha?=
 =?utf-8?B?QmZVcHY0dFp1K3kxckRMa0FzYkhNVk1tRitpVkJiNXErWmdMRTFoaURaOWJh?=
 =?utf-8?B?WFBTdEtKRFpzdk1ER0J3cmtGQ25sVE9XUzA3V2RqeUJLemNUZEp6cmxqRm9Y?=
 =?utf-8?B?OENpNlR6ZEMydmk3T2k1d2tLY3R6Ukd3S052Q09uQ002UDBxR0IvMjA4Zkl6?=
 =?utf-8?B?MG56K2toaC80VE9MUCtXN3YwTXdsbVNaU3hmaVJKTVV3bHhSeHlvUkVUVWQw?=
 =?utf-8?B?bnJ6K09hNFpjcGZ5UG9ic01aUUFlYjcxZFFENzRyNWtSZm03YVRZZXcrTWJj?=
 =?utf-8?B?N1AvZnZRREtkbHNjQ3JIdGkwOEx3aDgxMTc4aUJRWU5UMTgxUllhQmFpY21s?=
 =?utf-8?B?NENTQVhRMCthQzhVY1hYSFhiYWhLN2wvbUdsQWhJZThqczU2RzRaQXpDdTNt?=
 =?utf-8?B?Yi9remwybFZ6T2hKU3BDaGFaRWFjTTFJVjhYRXJiaGU1SThzdGVYUkdHWlgy?=
 =?utf-8?B?eHVWVUxJM2NqaTk3NjAyK1BUb1VQbUl0akl4N3F6ek1NU0pvNXM3VFRYUDV4?=
 =?utf-8?B?bDFicW9nTndTMzZrbFJ4UFFwVnpYVlVqQk0wU0kxcURqR2lPVEc2Vlk5dE02?=
 =?utf-8?B?YjFiUTBpdTlHRm9PYVJuazY4VDlNYjVEUFBTb3ZtbkJtRFFQYVA2RXRVdE81?=
 =?utf-8?B?Q2RxTVhKUGhLSkdiOU5NeENxKy83b0h3S3NXUmxMb3JrbjBQTjRJL3lRRDJv?=
 =?utf-8?B?UzRwSFNNZTkzU1dzTHZwVlVtN3loV1g0aHQ2MXgwZ3VKYU1ZVCtHenVBWHR3?=
 =?utf-8?B?MEc4dVh4QXd4dXBtVnEyeVJWYjFWV3g5S1ZZQUNHMXpwTEI2V0FFTnNTcnZI?=
 =?utf-8?B?d3dxUG5yZlk0dktOL2swdUtFeE9pcTI4SEZWZUJuNm9TMGhXcHBUYlRmN1RI?=
 =?utf-8?B?ZDFOb1pQLzViQ0JLNUk3SmhvTXR4c001b1c1TmIxOGF6ZEtiaGdTN2YzMDhD?=
 =?utf-8?B?UlM3ZkNKcllZVjNWcEl1ekU2NDRLQTZCUGZqcnZyMXBCd01lS21nRG8vbGxV?=
 =?utf-8?B?VHVNQ3lyWGN6MzNyeWhIb2FFVHU0eXloUys1V3l4eTFTc0VIcjlUUjdtRWZ6?=
 =?utf-8?B?czBDY1UwRG9BV3FURnIyWEFpSTczVTJOQ0dMdjFFcWFXTFBMeXZkQ0tIRm9Z?=
 =?utf-8?B?ZUozdUUxeUJGQ0hUcVNRVktOYUpjZnpheXQyUG1ZbjFsd0pkbzRvV1doa1kz?=
 =?utf-8?B?U2tTdnZjcERmNUlFaERmQTg1eTUzMWduaVduV2N4SmlPeFpZZkI5bE1PeWU3?=
 =?utf-8?B?akJoYmwwdVNYM0tlbUZOY3htNnFGaVhFa05UUnFBbHdyM0w3ckE0NEViYzQ2?=
 =?utf-8?B?L3hvTTF2RWVpcDNKYmhaU3lkTW0vUGVHbDJNWWwvdDdPSWFwU2F3SHJIZVAw?=
 =?utf-8?B?TTNDSlZxZVFvbEJoOUZzWVNSNk9HNnhZb09wUXp2TUU0cHBHcHU4Ym9VNDZh?=
 =?utf-8?B?VUF6ZnRjT2dLeUVONDhIL3dMY0NvNlA3czRuOVA2bjZabUxTNG9pZnRaM3Qr?=
 =?utf-8?B?UW5aS2hiaVkzRSs1VjN5eDdPVTBWS0YwcjVhcTNQa3pFMHh5dDNCeDVoZEN3?=
 =?utf-8?B?Mm1TV2QxNHhUa25vVmNGbllwQU5tYVc0VmNPTW8rVmJITzQ5eDA5RlJ4TEk4?=
 =?utf-8?B?ekU5aDQxSXI5VUZWUWgzV0xTdGJnKzFhWU1ZOUd0aXVtY0QyRFRsT1lEV3FD?=
 =?utf-8?B?cXN1NGQwQkhXUTVNeTRiVDdBdHp0dTZvdnJ4N3RsVmppb0xTb1EycVNNdm5k?=
 =?utf-8?B?RUljdGloUlhXRTlvbkQzdkh1b2lTODBLTVRLbmdLZndkbDFYQkZROEtWbEpC?=
 =?utf-8?B?ZzBBRmszQmtOcVF0RnVvK1lLTjIvU1Nwclk3MG5HVWMvTGdQZFBMa1JnQTBn?=
 =?utf-8?B?enJka3Frb1dOcFdZTEd3VDZGTzdhbEdnUTFLY3AwelljYStnZzNueFpLZ0pZ?=
 =?utf-8?B?bTBKSm5hZU1YOTgrb2ltMUwrSk1NZENNcVMvaGJRc3c4cG1IVEJTaGhLWFR3?=
 =?utf-8?B?dzdscG1JdUdQajQ0ZmozVFM5UWNBMkRoNm1JMFlCTEtmQkJHaldBYm9tMnpj?=
 =?utf-8?B?UkpyMVd4OGZmclRpVDBZa3BQNm1SSHNHcG5XUzQxdmRXTHFLSUMxaGNja2FX?=
 =?utf-8?B?bzlmYTVuNGNOM2lSN0JzWTdlUE9jWWJCcmZkT2JLNm82ckUwSitZNHFkbVhQ?=
 =?utf-8?B?Qmp5Wnh0U3NLR0wxREZDMitqUDRUMitCWmlFNXhqZzhyM3VkTmJ5SU84M2N6?=
 =?utf-8?B?UjZkam5JcGRhdHI0RlVHRTNOV0lpU1c2TnBRcEVnNXl3SEFoYXNQQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: FVQn5xsyzwDqgZr/9yEF4ujMTwa9aoOkKBwDGq/HcxkZyTN3X4Cew7IWmotMrZNTmp7RoGwtWRWHoeq4RUaK6Hh2NuUw7E2a2Gfq2rw61SPqUtWWRB/v297OxNTZcbhxggrQuzpDr7xjAQmxVY5tzdmFPuTeqEvv5fpWNG5Z9bRtbmXUr0BDzUV2r0CrxOcl4q49V/uFlwcwdowLkCgt0ikvcMLYTXG+wx6XCSXnrB5GVqUCF9FKWR/iRUDgaWTF4Bof5Aitf1ipm+cRY89XNF1HykM/O9GS1RPm/K3+vA5ljPsl/omLSlmTEqNkB8zAK7cbdTHDz7mdwvTuXuLwmA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 771babad-0ade-4031-1c82-08df00044234
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2026 04:17:20.0434 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3i8SdRl0BbaAcp9UicnFZrpYCEk6USv2i/ppxnfLVeD0XYaK+5kBuoG+QvjtBVuF0Iukmv/vs7fTR5ZBRDeNEnFcGmTNO9y4tb2Tpl9qMpY=
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
d2wtbmV0IDA3LzEyXSBpY2U6IEU4MjU6IHBlcmZvcm0gYSBzb2Z0IHJlc2V0IHdoZW4gc3RhcnRp
bmcgdGhlIFBIWSB0aW1lcg0KPiANCj4gVG8gZW5zdXJlIHRoYXQgdGhlIEU4MjUgUEhZIHRpbWVy
IGJlZ2lucyBpbiBhIGNsZWFuIHN0YXRlLCBpbml0aWF0ZSBhIFBIWSBzb2Z0IHJlc2V0IHByaW9y
IHRvIHByb2dyYW1taW5nIHRoZSBQSFkuIFRoaXMgZW5zdXJlcyB0aGF0IHdlIGNsZWFyIGFueSBv
dXRzdGFuZGluZyBUeCB0aW1lc3RhbXAgbWVtb3J5LCBhbmQgZW5zdXJlcyB0aGF0IHRoZSBQSFkg
aW50ZXJuYWwgc3RhdGUgaGFzIGJlZW4gY29tcGxldGVseSByZXNldC4NCj4gDQo+IEZpeGVzOiA3
Y2FiNDRmMWMzNWYgKCJpY2U6IEludHJvZHVjZSBFVEg1NkcgUEhZIG1vZGVsIGZvciBFODI1QyBw
cm9kdWN0cyIpDQo+IFNpZ25lZC1vZmYtYnk6IEphY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJA
aW50ZWwuY29tPg0KPiBSZXZpZXdlZC1ieTogTWFjaWVrIE1hY2huaWtvd3NraSA8bWFjaWVqLm1h
Y2huaWtvd3NraUBpbnRlbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50
ZWwvaWNlL2ljZV9wdHBfaHcuYyB8IDEyICsrKysrKysrKy0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQs
IDkgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCg0KVGVzdGVkLWJ5OiBBbGV4YW5kZXIg
Tm93bGluIDxhbGV4YW5kZXIubm93bGluQGludGVsLmNvbT4NCg==
