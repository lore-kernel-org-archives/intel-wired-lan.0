Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F2CCC5AD5A
	for <intel-wired-lan@archiver.kernel.org>; Wed, 12 Aug 2026 10:32:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2E1C280F5B;
	Wed, 12 Aug 2026 10:32:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K0yOf3kwldfd; Wed, 12 Aug 2026 10:32:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 957AD811B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786530740;
	bh=LWM2zf4UMBhJ3B3XH++5MRBtCGUd5WaKgC0NGCjYmJM=;
	h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JhWnIJEqzFja+ZZck/Z24e/qAxvJKmzJFy6yYQeh0GDx67Y9Xc6RnlqN8hNqTj4oe
	 g3lTr5z+ND9IpsYS3TZweL95Yw0aEDcrA6I7JahLccs2DObXNoD1vH2MGLuUAskOI9
	 3K/rauHitTx2+j5p7t0d76BE+rWjJhwFBFBgx9YWs0ueneCpKQJDQJrhtI1m36J5jZ
	 1PfhlpA6PeXhgUQyb0tq+hLjRolfIsPcogO/e5YGBNoXNNj0xjhj9RyudKbo3HIad7
	 aOjT2hQF1I/dOef41s6VYcizmWszrskaTVZ5as/UTokO8O1Vjw38gvFT27Ev4CSbYt
	 t+y6jXQc11nyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 957AD811B6;
	Wed, 12 Aug 2026 10:32:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id BDF211AF
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Aug 2026 10:32:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AFC36608A2
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Aug 2026 10:32:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yD5BZcSImEvq for <intel-wired-lan@lists.osuosl.org>;
 Wed, 12 Aug 2026 10:32:18 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=sx.rinitha@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org BBA2F608AE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BBA2F608AE
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BBA2F608AE
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Aug 2026 10:32:18 +0000 (UTC)
X-CSE-ConnectionGUID: etVxHHjDRMCfWY57f+Rqpg==
X-CSE-MsgGUID: /TFudak3TLqRUCIIpD1qUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="112624490"
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; d="scan'208";a="112624490"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2026 03:32:18 -0700
X-CSE-ConnectionGUID: 6jP2gAdJT5KRuTfhu6v3fw==
X-CSE-MsgGUID: eVSw4qeaShKng0t98+feeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; d="scan'208";a="260289251"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2026 03:32:18 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 03:32:17 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 12 Aug 2026 03:32:17 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.26)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 03:32:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=df+JMjvUqZFyzTyEsJgMOTW6lYFmWWnk37dml43Ggj/1tNuh7aMCyI05fQlIV08Zjh0ErAkFmk14/ZD2Yu0mJtw7hzHfb/Jf2eBvDJtyMtkl8riwzcic5T/b2gSaD2Ea7TEqE6pP5wb39OQtrH+Qo22SFEK49ydSvjsgExcqRSBQPHroh8eZy1upZuqXtIbh0p54JcyxrqnD9ggm/aljkEeajE4af4HY8RKmdi32b4sKHTlM/rJWgo5jsFiF2gxqNDCAWqDTz54DyHQIQBSNVCzWwZUn2UcFHoyRr/EYqAkB92LZbjD14aBCNRrflYCUdYlwXb6+qCj6Zp84Lfl2ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LWM2zf4UMBhJ3B3XH++5MRBtCGUd5WaKgC0NGCjYmJM=;
 b=HWUl96YGQFwBUguQZqUBH+T0BkHtvm9TNLqH/vxZJX0Yy+f+h+XRtJmt58No+UbX0uZsu21dxEpn0MxRrkgyA1JBtCTsYC5qvXZKALuoCT83zHvuMNk2zEidk2FHHzZccLODsLdqQmYIbXUaANhPwcNH+YskebiAG6QjH9US7PfaosVr8FZauEQAihu8qoOYYCiurwYChwvd8iyzWi7BuJV+u3FRaw1ZMopwBNDSpfY9malNDWrGLJtnTgFgkVoyOutpgvelOhOzT8Pc7jbZZI9vRZN39Y+hx51IDU76se3BEPDAGVpD+TCTMlSZ/Kr+hhkEs+PNj+opLy8JXUEy7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by DS7PR11MB6247.namprd11.prod.outlook.com (2603:10b6:8:98::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Wed, 12 Aug
 2026 10:32:14 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%3]) with mapi id 15.21.0292.024; Wed, 12 Aug 2026
 10:32:14 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "Jagielski,
 Jedrzej" <jedrzej.jagielski@intel.com>
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v1 6/6] ixgbe: take rtnl lock
 before ixgbe_reset() is called
Thread-Index: AQHdCgYu/iJo3HcxaUiXXYNHdu5UbLaadbRA
Date: Wed, 12 Aug 2026 10:32:14 +0000
Message-ID: <IA1PR11MB62416E1ED1A43185467712378BDC2@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260702091553.57112-1-jedrzej.jagielski@intel.com>
 <20260702091553.57112-7-jedrzej.jagielski@intel.com>
In-Reply-To: <20260702091553.57112-7-jedrzej.jagielski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|DS7PR11MB6247:EE_
x-ms-office365-filtering-correlation-id: 5bdaae1f-6efa-4040-43f4-08def85cf9e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|4143699003|11063799006|38070700021|56012099006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: WJiNQ03r3Jgni0FUAoZieweFW9No/FjkS/Zuv0zxL9t/Gk3QonJH7kdPHwndnOylz8zzVe2jguJ8Zd5F4dhDe4OTGpJoW9VPQI3I95niM0mHaE12/eDvK1lUDkoYTjA7CRhUYTikm+T3/leye13NMFH3vWXZGCK8U3SYMTFq0jrBlK953L5zR/ybv4roEaLmn4hOG1DgTZp4oPOXszmBXiZjaKcNHsFqnu3DpS56yf6RLDAzwRlpqe3WpxZ/54En/KBzPUYvmOVALlrK2eV9fyE26AtmZFtQXT2uNwVAw300vSkforqq9j379fDpTNSLrzmZSWmo+MnZbDk0UKKF5mHTlcVA9MqiLJpjfLXxpqCJK9BVX+faVKUweeAiqltYYDhTRQkv7XUJhrV0qksqrDjIwF6gLg+tlU+186FZnxk8VEESQGpfjiUVHqT3a61NHU9j6R96rnDsAmOI8FrHw0b9WeKOwgUc61jYlOnW1BAwbCOPdBA7kI8iPMOR8sjkaPbzy8o2b7mkz/ouByK3jJTknco3I9bAiS77wGr6lukrBgmSXp0tkzn/T2c2oopI/v5FdHLgBOHbOAXarjkfagE4dSrwJApYLNZFSG0xyWIbHoz0gW83JAtBj8SwF0mtSo9Ht1Fzy8yn3dyUxr1oPDkLaDcYTUW3tiPZFxjCjovLqLOPonF7gRH4V5TJtKyY7DknqVcdmmX/T762D+PWVvLLbiBNpv9BAWDtfeN0Ukw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR11MB6241.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(4143699003)(11063799006)(38070700021)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mlxfl/GRqybZrNYLIHrcE5/4YvoHklfnDcuJSBFWqx3GugM8KtTF/WYRP1XD?=
 =?us-ascii?Q?+wNygEmKXyrTIvO7EhbrETC45kctsRUJSwaCMVENkzAFEwdWy0sV+3lSrG0a?=
 =?us-ascii?Q?Uj11sZTOIYWvw6bNkTkY1+nIQGRMqMAY0LcDgqyviVTTq/uSc/nAw5Av7QXH?=
 =?us-ascii?Q?rb0wdxNLKAt3PwbTa5W3R6XbhGPSdBWrqEGFBplFi4s7i1BF3RUSyt19Quqe?=
 =?us-ascii?Q?edzGock+JV/dG4QyZiAgot6Nqb7dZ/ffp3MhCAedYPjMwlhGjlMQUXuegDUm?=
 =?us-ascii?Q?UZELBEbbuuBwGuTY8FUbgOoJNMBmWO20hldvvaoVIXLCrhnitnLkryfP7OW3?=
 =?us-ascii?Q?aPRKYA0Y9E5NlnqJ+pNH88vVFpbXieS3fbHIHW2gG1WUKiFNVsh3Hu75+AXw?=
 =?us-ascii?Q?xhyk6SLPmBytKXuvrKIAqRVABGMU7gnhDod5Kp9o23IDiM+TCFyuNp7+93uP?=
 =?us-ascii?Q?roPr5MTxedHQgXuXa5j37rsHNPEQCJFiWlw13UXGAMdwBZGStGpsCXSzrUDT?=
 =?us-ascii?Q?m51CtBNJWzroe7a25VarXa/cBBUwzee2VlqqIetGbhx4870lN0uAIdTBsRBn?=
 =?us-ascii?Q?pDdHDnjVUCmQvcFB90GluiGS4wI8EeOSH3Sr/IL+5gB5b03/u7O6ecI5wJir?=
 =?us-ascii?Q?GJi5axbcJtGZhz3ZO/lGeKb7UrIPAPr+cmd2/KlRaU0ApnTUrzah8biMxBex?=
 =?us-ascii?Q?Ir/0kMWfHKdvKGBrYpERbsPm3tjngeJ05aRiohwOsm9zyGGhzHVhnmgZTBWr?=
 =?us-ascii?Q?q9YCtjy/2eRL2debvltangO00Sb0B/vxoqllfXQS2Z7obU04JJVpjJkeeDFe?=
 =?us-ascii?Q?lUzfEujGKtN5U4ZCQiDp1Q1lm9U908stpHIn2as/L9+5wTCyHdalgdAyxPX4?=
 =?us-ascii?Q?dc3ms7ntmUZ2CqVwM7pomvH8IJoOe/bUO6hiqiR9E6Ac9xPy/jiydy5L9XcT?=
 =?us-ascii?Q?LHth3b5Fg8P1thL3k2GMGUSOaUU3NbViyJ8SwhCN3zTQ4QS6zUxe8OT1mc7O?=
 =?us-ascii?Q?hOHe3d/O7qnw3KdFRmGbIeZtQ5n7XjgoB3Q24Lnil4yP3BAwFVZeOUkz60Es?=
 =?us-ascii?Q?OWBj8bv1SIJhOfPdP6XkFHoB5DjpUQCmXUV/T5J9p8/EBsqHP/nB/K+oVTKw?=
 =?us-ascii?Q?7QtU66usVIK0/hosyj61S+n4djKMKWOku+ThBkGfkA21EEM4O1Tigm3NNSt9?=
 =?us-ascii?Q?6zAsIVlkC476LU49kJ7KrWj7Zyx07J1OdA2ocl0QKMXgL70O5K/CD0aEhtRV?=
 =?us-ascii?Q?dzt7JpoRPvsuV5dQnXR9Pt3whoPvTkMFO+YNXcNH6Jim0wHmqepjvd58nh/X?=
 =?us-ascii?Q?0PRBvU1Aw4TGxpIpCpuBfth4xjZqEAI6jlBgrg4xfqieJISzCmXPQrqqlSNM?=
 =?us-ascii?Q?iUuXcDXicIz5HmvI3ma5AO0KGNfPC6tpEZLQBNtU66DcDb7TIod+5cnzQxDW?=
 =?us-ascii?Q?o3bVDojuLQfRlipGUDVRfeH9ROSqBzXUiHVgNhAmnjh6Pth8tOt3n+rNt8qT?=
 =?us-ascii?Q?boQ7rtQ+4EygL/drWxTNpF/fqjoq2NRuTFu4KYnfbyj1xz21yZkGWP9k2l30?=
 =?us-ascii?Q?WYLNK2TboQxBDyVc/gUZFkXqzPRueOnnP/5M6gQUSQe5nr1UDAZ+bTZSIGiZ?=
 =?us-ascii?Q?pWzll0hwF/yEiEvb6pj3JdBe3IUoHHqRjweW730Xd2NB1ZCv/krrPyP1myW8?=
 =?us-ascii?Q?vdMoKFfV46fw1sAZAAszmkS4V1L3Id/c2OxVCfH2csotlLHE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: K+rB/RkSNljhSNCVRgm21YWwEr5xaAT2EJpcqA7X96in/B1Z2G+PWnWrIQok1zTFo9NGJ+ARq1s8ALJyoUroHbQVT4HR7agX68+j8ln3IEQ6+Zm6cxqss90LL8EzeFQvzBXUrxPUZQDVRVqOG9c3U8+E1N+lajglYXypI3sNW0+YJM3/p2+9pkCnZv7/62QEHXFkuJNngFDFE2fANhO/ZIv+3yWr3eWN8Rr8UwgW5ijngP721Z4oSqBngx3f7BOzly41L/YcX6P/qF6rv7cwIfGP6AB3tQWDMTYr4UTqewHc992pJrZrpJqNMF5hyKaJTrczOlh002JQsElg02X4PA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bdaae1f-6efa-4040-43f4-08def85cf9e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2026 10:32:14.6194 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: veGCASvMZ9RZTL4EYLDv/mY94JkJ7t7U5yQcdp+w8xD71dRo4NTKzDCBDTyrk5uRVbDGCU1lsNOaJtyC+vQnRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6247
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786530739; x=1818066739;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=LWM2zf4UMBhJ3B3XH++5MRBtCGUd5WaKgC0NGCjYmJM=;
 b=jYIIEjWjcTKM6jZu3bKS4TOaMnLdoV+h3OnsuEmMTcQ8VaY0zHU2LzT1
 MLHrHp/crISRP/YsKfKQb0SWZ4raYd7ZcgiorjDBxqbTr7KdS9AiKubep
 FQxzLS/fDNrdebArVduPECWrkCkzFaQTMdf10n0Cimn55nDaOi058XTzu
 eL6BSA83BjBSThWoWdscW9PbzcjbF6+9GeO/s2ajq4LxErVWIj7YMDT5I
 hF2YopYHOONX91wuqRYiUfwegML9A5yrQt94U8BQUzzuskJzkBdwHz38/
 fuB6g0XakwBPuVuG9tUMkUSoKx1sHDySId0369r6ci47ORinNbdY586SL
 Q==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=jYIIEjWj
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1 6/6] ixgbe: take rtnl lock
 before ixgbe_reset() is called
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
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of J=
edrzej Jagielski
> Sent: 02 July 2026 14:46
> To: intel-wired-lan@lists.osuosl.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; netdev@vger.kernel.or=
g; Jagielski, Jedrzej <jedrzej.jagielski@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v1 6/6] ixgbe: take rtnl lock =
before ixgbe_reset() is called
>
> Previous commit introduced ixgbe_mac_addr_refresh which touches netdev st=
ruct by updating mac addr. It should operate after taking rtnl lock.
> One of the callers is ixgbe_reset(). Most of scenarios when ixgbe_reset()=
 is called met taking lock requirement, but there is a ixgbe_resume() path =
which calls ixgbe_reset() -> ixgbe_mac_addr_refresh() without taking the lo=
ck. So there is a risk of > race.
>
> Move rtnl_lock() before ixgbe_reset() is called.
>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
