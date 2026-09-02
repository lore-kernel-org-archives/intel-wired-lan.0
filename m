Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDA02C624D4
	for <intel-wired-lan@archiver.kernel.org>; Wed,  2 Sep 2026 16:10:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B031E60708;
	Wed,  2 Sep 2026 16:10:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9GoyBTdqm0Na; Wed,  2 Sep 2026 16:10:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788365408;
	bh=b52r7rbW+uhNEFtJhC5efJc6q9mz5b8WUe8Yp2ZQhig=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MpsJITJcl1eJ1FHLWoM5FM855Es8CBj2u+Xtzaq4UWIAqzj1uAWqR1488vKS2RiRq
	 0qFVFZ7xIwpJUCznUy+Hn4H4xu89NHjPzGCiAXuzU0qtS3jkHrbxICTGrPYvKRyMb+
	 v7ZIxOI0lW2qaZ5Ho3uQ54i5aCmci+oqlQuwXNHuieUWyjcHG2rivhGzEn+dkwYlQn
	 mZk1KXnjBwBuqJ4iXNq0c4cXYIC9V7YsglCGICWcdZkZC8bvFGqmCRs77NwTDqudPi
	 5Jj3VVmzaH/KEYPb1sA2eWf7ANtDJwTiDd343xTtTS90Ftk22frHS6BNxM/FqjEN0G
	 hHm8s1HUmTU/Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 857EA606F5;
	Wed,  2 Sep 2026 16:10:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B0A592B2
 for <intel-wired-lan@lists.osuosl.org>; Wed,  2 Sep 2026 16:10:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A11A880F04
 for <intel-wired-lan@lists.osuosl.org>; Wed,  2 Sep 2026 16:10:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QZe7YaRGJnjF for <intel-wired-lan@lists.osuosl.org>;
 Wed,  2 Sep 2026 16:10:06 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.21;
 helo=mgamail.intel.com; envelope-from=alexander.nowlin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=AQBjKQ2M
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 65D4680EFD
 for <intel-wired-lan@lists.osuosl.org>; Wed,  2 Sep 2026 16:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788365407; x=1819901407;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=+S52uZrs1uGpL2PfEoBhWoudcJ+dmHb2ELQpYOT4GYU=;
 b=AQBjKQ2MS1KbpoV9uEecfQbQDIFFMjIbxOMVwMpL++UlSPEFBGWLMoxz
 YMpknkzMqz0BZS0praoQ7Dff8U4SMML8jpYWGzBIjcumMbHuCuj8l5dYz
 VADGot68C4G1jVndpkorLediLRipDLvF9fTeA5zGZzAwLkRmEHS4vJDm7
 26P3J5rD1O0K3zcNsMjeRNrvg48IzFW3cHdwwLhKSEM9ndb7mw9KxMO2V
 YZOROqe09L9JIcRFXP5foCgNJEvNm7auEsWDO8AGNnUHT/Q/e5br6NMJ7
 GavCHrm13Sdu/Ab94nPxMw+/7GP5PfS3DH1RVeGkHp14SdiW4gmjtNCdK A==;
X-CSE-ConnectionGUID: bsdR1MtuT0i3EMVOa652/A==
X-CSE-MsgGUID: x91SURYyTyeWdmj0k4FcCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="88679422"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; d="scan'208";a="88679422"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 09:10:06 -0700
X-CSE-ConnectionGUID: 12Y7aUI8RziOhw37lBxCJg==
X-CSE-MsgGUID: nNtFItc/QRma7Zwci5N64A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; d="scan'208";a="292959836"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 09:10:05 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 09:10:04 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 2 Sep 2026 09:10:04 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.60) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 09:10:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MQp6Ge3oTGY2ROBszlW1Zo/ozBcIYIvxB20O2/r6n1+O4nuJXU0I0+Xs5eAfg/njZd+WL0grVd0GCE8XryhDsIBNwa2WrmNY09WWnzLw6Y0qDX448PEkNc8TEQo2+WCAiyyXAD2X+xz+LeIEM9XK4T09EBnz14M8qXwWPQflpkPM1y0u0CBNAP6oUykK6bh9/7qJFwoYXynEfxDAX8rpvbuwg9mdubLJvKb1YFGm45l/xLA4loC/0HpgUluatHUHRj9t+e4SRQqeyMk7FSvBCDpMOjaktRohDZ4qmk1AlhTTTPMlTV+FIydoSoLKiMxs3kFGfEdI7Iu60xkFBEcLvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b52r7rbW+uhNEFtJhC5efJc6q9mz5b8WUe8Yp2ZQhig=;
 b=oe3CYGQe70nLikFrXKpjdAvVEWE6BxBRoGVUy9Q82uufFn5UVXVrEwwSeHOdtkIMg/mnJrgyIbV4aIlinf38sP1DwqeozrGI3nZ5Op+7S/3Yag+v65mO+L61RLMouzvCxnIuAwsadBA9DmrvoW3GUDHv1/hNP/GzHu1BZcoAXdbSDiJaMxjsy+CQcLG+pWgdKB+z/eZVzRBnLCKpd5rjYzNc474coWurtuT9jG+8BGsEaul6UT1Bvr77At3Nlt8K9WR16WBzEzeuJwkDgx0TbPs6VHByW4xH7XhWB3A7drFRsw01B4lej4oEeXZVgQoqJH3xqnIsG44VsOanVs5QaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by DS4PR11MB180604.namprd11.prod.outlook.com (2603:10b6:8:50a::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 16:09:58 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 16:09:58 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 "richardcochran@gmail.com" <richardcochran@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Kubalewski,
 Arkadiusz" <arkadiusz.kubalewski@intel.com>, "Korba, Przemyslaw"
 <przemyslaw.korba@intel.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "edumazet@google.com" <edumazet@google.com>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "kuba@kernel.org" <kuba@kernel.org>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "davem@davemloft.net"
 <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH v3 iwl-next 2/3] ice: add TSPLL DPLL
 device and TIME_REF pin for E825
Thread-Topic: [Intel-wired-lan] [PATCH v3 iwl-next 2/3] ice: add TSPLL DPLL
 device and TIME_REF pin for E825
Thread-Index: AQHdIz0TwxBE803lmUq8pg5qX7H0Tra7pDkQ
Date: Wed, 2 Sep 2026 16:09:58 +0000
Message-ID: <LV1PR11MB87902E4E023BCE6E6856C8E890B72@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260803113507.1858083-1-grzegorz.nitka@intel.com>
 <20260803113507.1858083-3-grzegorz.nitka@intel.com>
In-Reply-To: <20260803113507.1858083-3-grzegorz.nitka@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|DS4PR11MB180604:EE_
x-ms-office365-filtering-correlation-id: ca85e285-c8d3-4073-d238-08df090ca2e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|38070700021|10067099003|4143699003|6133799003|22082099003|56012099006|18002099003|11063799006;
x-microsoft-antispam-message-info: aPMTHAdY0C3xS9dPkAjO1wY5OgrkMLrUuE7JmDjOYDBEzy5n02gXkgJgfYkP6NtvrfF4/B/JXjbogQtlDkmvM0nQnckF7jOLpxj2YboTFIfe6diE3oorvoedikD7sriGA4W6TFIJEeWUfPChbYebN9lJNvbbPgCW7YE2mL4Ihrx4iVQRPokQz8lkJOHKyRc3L52PTnLZBzA3l0pelK4XGt2FxTMSqTMjkZkysHvz6POC79bFm8eITsl/1Y2KiH3OvLxoeU8t6bECuABJrP1cb0HE4H4vaix+jzaPKJmb9utQ0ctMKLOvfY7QcbcwSB104iY0ZiMqb5tKGniMuH/9HAxPVcik34+azmDmSXhYJublI6dZBdYYVEMIdQAsalAHqhZTj5b5lgRyxyr9l6danuuaJQ+lpBPzeSk4Rw8YKcIRCCwnurUXUdFvwrBtnr0y3xUd0SjkfKF2pB1Dl6X4zit491MUN+wAQ0kT1M/mBpl+mGJyHSDwvqygHEVaOsDAez4I6i3MZNYfAlJ0R26nnkxKjQ6pVreGknjZWMIjiveuCNnch0Tsm0ZyFuEtscgFEVSd21O8qSdOEmPlA9PaE2OoiBSVy8NBr7rwmBbr1JYHXQoAIuP3AuLozJcviUyLgqyok/FqWt6w6s0YYgfKoYhUhIsF2LuSoYKNiYWXDU8FUcoe44P171/ueZNWJxamI422qLokHQ6Btyy91VmjnXqf2VJU4phszRK9gMIpnwU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV1PR11MB8790.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(38070700021)(10067099003)(4143699003)(6133799003)(22082099003)(56012099006)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?em/i0kpJh6MrZV6+CLimAytnpI19GcYdtrMkCAORVJOepXI/idA6r4UF3mVd?=
 =?us-ascii?Q?9pKuaGivH9PikaeUlHAeGMoicsJBItyMAKOrURKYWsp646iRF0Xc4GUnQDds?=
 =?us-ascii?Q?824/UO23cWyEKwU35s0lvgEbHMlq+i7IGDE4ikj+JP6Pq9V/BwFzNTo88DrD?=
 =?us-ascii?Q?CMKkbCFyD5v1kA/z29jE5Irmi+3dhHKb0UoT/I8N6M1gG6QSGXMXN/gRnMZG?=
 =?us-ascii?Q?yVffoyKtyQaSAofr9e44GkCMaSaQGhCGFgMjBkbAWmtliqcuT8W7QhSHnbx1?=
 =?us-ascii?Q?n61xdiuzckTUByvV8hCZg2hQDs1wU439QViZlicyp3MX57B0eQHzelEAwQaD?=
 =?us-ascii?Q?d6oMSUnawbGjXRNfIJg8OP0+AJFCwUFc9wopUGYzEfb6ZTT9y1Y+DAFXPo4W?=
 =?us-ascii?Q?v3Q3JdboveoMq9aSm5ZIoFtFA2gFox1rGamYyG6gK31HDWZ2CHcz8J5gTo54?=
 =?us-ascii?Q?hfRljq8eN4yDwF+F0Z1kgc1ThTChhFthZe6L0dcRp4vidTySigKTp6EmjVG/?=
 =?us-ascii?Q?VXYPFgKmrUMJprr+9hFc3oBP/CnYLzfkVriYdwq6cpqalek/g5OH3fFdw2Mw?=
 =?us-ascii?Q?9c8V5SHALF/ncKzoh9pybxCJKu7Xk55E1Abx++dLIn7wm0mymHv12P0cxWm1?=
 =?us-ascii?Q?GrHqRE9b0kRYEVJbgvA8709e6kWaWdbzMKNa/2nylt3hUwSnb0RgChBKM8I8?=
 =?us-ascii?Q?u6FBv1oxI0AlST0czPH7cPLeDVVQbu76zA4Xohv20E9zyXzSwuplji14SnwD?=
 =?us-ascii?Q?XxuOfkjSkRoUTDyQu8ASbFbL1zQWjkLW5NQHG6yHlfyeF0ObRurSTDki++Ml?=
 =?us-ascii?Q?dMY59Yj91caf0qbuA7rFxIA+GSR6mBbn/IGWNhP7YRQNH905nxUt40JvatIi?=
 =?us-ascii?Q?glUOJWpKtvn1cx1JdDnmMrzJcqn9X4B0sZf/IUJzKaegTeJ6TWUV7dZz883F?=
 =?us-ascii?Q?433GIb5keiUbsyzY2bu7SYPYw5Lx61toaGh2A60TaaaI3v6SrKVG3oggWuP0?=
 =?us-ascii?Q?dOhSLvgakKlK8IccR9nRR6HVTnIcDLq75H/qpwKFsgwe2jI6wfFz4EFN/ULg?=
 =?us-ascii?Q?k1VukNh+vwkVO+OtHiY0RxJ9Cx6BxxvvIhcKvZVmw1h8C9WExL80Day5eSAw?=
 =?us-ascii?Q?R5BO/6kbmnKTEfkKkrCMCKpBK2AgrPUFB8HcRD1MqLNvG1uJEA1As/SLlJ36?=
 =?us-ascii?Q?rybL0xq7QmzCIeR1S0by2MUzjn/xuHneeZcwOlIXH6xH+f/jlo5pATAj03Ps?=
 =?us-ascii?Q?CTfd+58t5v+cfrZ49q/MaiuC/uA5pGuTcwsrBPgFwwiBB2Sdjmw9aspxAlls?=
 =?us-ascii?Q?nUrnhiTDEPX1UYsWLPFX1Re5UC15ltYGKogycR1VBID2NSDCjs3Pt0saSoWx?=
 =?us-ascii?Q?bG52osj2Gt4rKEGD0xCI42IdTIc6VQwmZ6EF2kbEguKhoI5Ee45r3Ce2BnrN?=
 =?us-ascii?Q?Y3QGBKY2/TKFsosV3u8dr+lvHFY1wK5y7gIuKmcOGuam2B04knhPc7ES4GjZ?=
 =?us-ascii?Q?dc5eAQT/RnH3WKqYStQXYbcOV/TlToi74S1Ys4fQe38+KJdnhinjvoYCSqZt?=
 =?us-ascii?Q?5Ri6UwgRsXLY0Rm67bXDF3NmmLrcdqjvjqTJVYtHfLEf0knAZemRG4NcQaje?=
 =?us-ascii?Q?vWPfDfg3Q1RrUL1MfvPW/TF8EjPlxn0wS5U7kbsPgxpLwsWcVby9FpyHhpqW?=
 =?us-ascii?Q?6X1MFzR1drYB9pTFHwyRU//pFGTWQ3UtLkfmh4KjE1Fu7rnDN+uPPVvHhmC8?=
 =?us-ascii?Q?8RssQNNYdw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Rak3xDgQkHLIRvaI1HBH8xnLtUEU5tiH4Q+r/sc6UXeeoce0fYbVJYiMq0Bam+vwvip1hCgGdJYeoQ34LynYybD7qT8Qls3rE7girlR8jZ/kcM2+McRsNyRaSOfvbNmTYEa+X75eQLx95EGWPc/ef41rKzLZuboRAk0YUswjzwE0ZT3EFlHdvh00rM9FY5rll2qwQVvtwVxP9rmbJAtK3XxNajNiAdPKNFnGXQM/MQLg5JzrvTxJflcOD48jRiTRQCjtlIBfCis+yYvub4y+P/OPM8deM8RvrAPe5JJzBy45knwqt0p8F+LHbtGdWZLskrhEevvsY2P2nBPzrnGOEA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca85e285-c8d3-4073-d238-08df090ca2e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2026 16:09:58.7076 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UiikAQCSqYVTovCVP07xqX6pPChPK1KQ63YohKaIM/K+MHZWbeJsRPdhy3N2Ui8NIEanWckG0IoExgmjYwb+pO3vZ/25ruExNO0LyVAoqEc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR11MB180604
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

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of G=
rzegorz Nitka
> Sent: Monday, August 3, 2026 4:35 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; richardcochran@gm=
ail.com; linux-kernel@vger.kernel.org; Kubalewski, Arkadiusz <arkadiusz.kub=
alewski@intel.com>; Korba, Przemyslaw <przemyslaw.korba@intel.com>; andrew+=
netdev@lunn.ch; edumazet@google.com; Nguyen, Anthony L <anthony.l.nguyen@in=
tel.com>; netdev@vger.kernel.org; kuba@kernel.org; pabeni@redhat.com; davem=
@davemloft.net
> Subject: [Intel-wired-lan] [PATCH v3 iwl-next 2/3] ice: add TSPLL DPLL de=
vice and TIME_REF pin for E825
>=20
> This extends the E825 advanced sync-timing support introduced by the tx-c=
lk series, which added the TXC DPLL device for TX reference clock control. =
The TSPLL, the source timer PLL, is now also exposed through > the dpll sub=
system so that its lock status and clock source selection are visible and c=
ontrollable from userspace.
>=20
> On E825 devices the TSPLL is the source timer PLL, distinct from the EEC =
and PPS DPLLs used on E810. Register it as a DPLL_TYPE_GENERIC device for o=
wner PFs.
>=20
> Add struct ice_dplls::tspll_in, a fwnode-backed input pin named "time_ref=
". The state_on_dpll_get callback queries ICE_CGU_R23 via
> ice_tspll_get_clk_src() and returns CONNECTED when TIME_REF is selected a=
s clock source, DISCONNECTED otherwise. The state_on_dpll_set callback swit=
ches the source between TIME_REF and TCXO via the new
> ice_tspll_set_cfg() helper. Registration is deferred via the dpll notifie=
r path if the pin is not yet visible in the subsystem at probe time.
>=20
> Initialize TSPLL DPLL state from direct clock-source/lock reads so the fi=
rst published state reflects hardware and prev_dpll_state matches.
> During periodic polling, the DPLL worker consumes READ_ONCE(pf->ptp.tspll=
_locked), maintained and recovered by the PTP periodic worker. When the TSP=
LL clock source is TCXO (TIME_REF pin not selected), UNLOCKED is reported u=
nconditionally to reflect the free-running state of the oscillator regardle=
ss of the raw lock bit.
> To avoid stale lock-status reads after synchronous source changes, the se=
t callback now refreshes tspll.dpll_state immediately and emits a DPLL chan=
ge notification when the cached state changed.
>=20
> If a TSPLL reconfiguration is applied but the PLL has not yet re-acquired=
 lock, treat the internal -EAGAIN result as success so the PTP periodic wor=
ker can complete recovery, while real -EBUSY failures from reset/SBQ paths =
still propagate to userspace.
>=20
> The TSPLL userspace reconfiguration path (state_on_dpll_set) and the PTP =
periodic worker (ice_ptp_tspll_monitor) both read TSPLL HW state and write =
the pf->ptp.tspll_locked cache consumed by the DPLL worker.
> Serialize both with pf->dplls.lock across their HW-read -> cache-write se=
quence; otherwise a preempted monitor could overwrite an accurate cache upd=
ate from the DPLL callback with stale HW state. The mutex > lifetime is lif=
ted to PF-features scope (initialized in
> ice_init_features() before ice_ptp_init(), destroyed in
> ice_deinit_features() after ice_ptp_release()) so the PTP monitor can tak=
e it unconditionally regardless of DPLL init state.
>=20
> Extend ice_dpll_deinit_txclk_pins() with a "flush" parameter so the
> E825 init error path for the TSPLL fwnode pin can tear down TXCLK pins wi=
thout flushing pf->dplls.wq. If the flush ran here, notifier work items que=
ued during earlier init steps would be blocked on
> pf->dplls.dpll_init, which is only completed at the unregister_pins
> label reached after this teardown. destroy_workqueue() at that label drai=
ns the queued items safely. Existing full-teardown callers pass flush=3Dtru=
e and keep current behavior.
>=20
> Reviewed-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dpll.c  | 420 ++++++++++++++++++---
>  drivers/net/ethernet/intel/ice/ice_dpll.h  |   4 +
>  drivers/net/ethernet/intel/ice/ice_main.c  |   9 +
>  drivers/net/ethernet/intel/ice/ice_ptp.c   |  12 +
>  drivers/net/ethernet/intel/ice/ice_tspll.c |  34 +-
>  drivers/net/ethernet/intel/ice/ice_tspll.h |   2 +
>  6 files changed, 426 insertions(+), 55 deletions(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
