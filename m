Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AD87FF8867
	for <intel-wired-lan@archiver.kernel.org>; Tue, 28 Apr 2026 00:59:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3574080E82;
	Tue, 28 Apr 2026 00:59:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MNtUhM8S7NH3; Tue, 28 Apr 2026 00:59:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D5E9380E83
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1777337996;
	bh=AW6HEluHVhryRkFH10YXo2rj3ScnfKJ/6toUbeiNFL8=;
	h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AzdvXXLXodSSTeP449czauwemY8GtmftvZJHoQ4d9ZC9ulHbk3iXC+kshAB6U/sPQ
	 3tLIP5/jEyi1dtKHp/r4NBxXEy+Lqxh3dgDD0Ewj0KY4VdcQh6BoCkIsjQXo6H1s2w
	 WipVyDoV7Kj+pu/CHTPLwL0FYJKBEdVR2bEUaRIJGW1hctzLpZmOm4opI2wjGT0yIz
	 LS9ol9V50OLCX9DoLLDs2KEQdZnWTYeUi6mngq+EqezFmS5EH8EpmOiFElQY39arsM
	 mDjRh8lUGd4q+FhG5E6fOUac8OPimAc52V4fgZRw9cZDF+Jyz8cPHyoGzpMzXfpMAQ
	 h3HoLtPQK1o2w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D5E9380E83;
	Tue, 28 Apr 2026 00:59:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 22D9723D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Apr 2026 00:59:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1007B4054B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Apr 2026 00:59:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LOv16-rXKfFu for <intel-wired-lan@lists.osuosl.org>;
 Tue, 28 Apr 2026 00:59:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.8;
 helo=mgamail.intel.com; envelope-from=alexander.nowlin@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 36B6640DE9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 36B6640DE9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 36B6640DE9
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Apr 2026 00:59:53 +0000 (UTC)
X-CSE-ConnectionGUID: BuNGLCN7QnuxfhWMgfUdOw==
X-CSE-MsgGUID: ig0Zz0tNRi25pc3bkZnHUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="95806295"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; d="scan'208";a="95806295"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2026 17:59:53 -0700
X-CSE-ConnectionGUID: h8kD4422TX6k0nM0huULyw==
X-CSE-MsgGUID: sv7zN9rKSOGtXfQef7qvyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; d="scan'208";a="264190800"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2026 17:59:53 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 27 Apr 2026 17:59:52 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 27 Apr 2026 17:59:52 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.10) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 27 Apr 2026 17:59:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Py82f3Y179/pWQyv2/S6lSwoobMrL1C+d67PDw6Uc9VsQXp+RvK69BrnXYlV/BK0IFK+M/oazFcig6Mz8SRg9PNqJjZLi2FsxQUgmbeaT3EqOY63cwOryvstY704M8jcYbRqaZ0c8k+KIezDNc2ZoOMm9ueo5dQez4LOSvLBYjjotlJmSgCmDqfPnTKpWcKCNbl7b+AlGQTSRg/YkX/7kjk5xfOqXE0sBDzjl4Vr7ITzqbRK21L5exB85crmJDV3VUjwUc79goJacPyZZofy7PCswvT6/cP8C1mNE9in3aZJ4qFYqEf114cC65GYI9W+wd2F6m+8ixqzEIk6wNRhKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AW6HEluHVhryRkFH10YXo2rj3ScnfKJ/6toUbeiNFL8=;
 b=Zts5gC0yMzTlLBoixX+qHvuHhIX0SjE7aW1RTXHDYU4xYgHpsYdUfjimpTGOHMr7tbpXmTFo6SOuwxdv5ZunEwcdEgxU51klkHXclibJ1JFsQ23zaFKmZ9YInrtHgl28oXENLd0QAgFAAhWnnDmvTf+yQ3ddGxn4r7TynEuEVyDz/3KviWroGbhCiEFR8TZzV7igW0VlJrLDaB6Nq8dOCfVKFIGA0beXDr+ARszXsArDFp8KOqPrF8JMLzoAbL5QCxGXJExhFLpi4vkHcSru+cjQb1d14G/1cZ5E+OHyBjYeb63IugUjxpY9m/dSQzh2Rjx4oV4mx9AlDuKf6+CxdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by IA3PR11MB9061.namprd11.prod.outlook.com (2603:10b6:208:57c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 00:59:46 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.20.9846.011; Tue, 28 Apr 2026
 00:59:46 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kubalewski, Arkadiusz"
 <arkadiusz.kubalewski@intel.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net 1/2] ice: ptp: serialize E825
 PHY timer start with PTP lock
Thread-Index: AQHc0lSiSfN5kTDxw0CwoXyh4+q8MLXzr6HQ
Date: Tue, 28 Apr 2026 00:59:46 +0000
Message-ID: <LV1PR11MB8790EB41FBA8E1AD1559684590372@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260422123144.485930-1-grzegorz.nitka@intel.com>
 <20260422123144.485930-2-grzegorz.nitka@intel.com>
In-Reply-To: <20260422123144.485930-2-grzegorz.nitka@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|IA3PR11MB9061:EE_
x-ms-office365-filtering-correlation-id: 8d976353-9cfc-479e-e3f8-08dea4c17126
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: PMcesPKghk6/AQ56GNgpu4quPS0SNoSWJca/3KK5hBrml+Ta3G0YDWMyGFe9gdekykjKBgaY3ff+7oemoAuJLbCI3kiU334dCsyw06x4qs2+FNh7N3SjfpFLQOanDfMlXWhHMzS6GQhKBVEy8AG30y3fYsg/G+sKCtMEVFr5GYDFmCNWAGBRoEfbSEo7Fmc32FK54OhFmTEJVDkXWGvo7W456X/UFqZDFWM02PgaNPRAhu0hHSJTZjM25vmNbtUuXJ9qATIeIdW4onTc39Aoyqt/DeCSW07wyRhHJK6Sr3XU+1l3ZnSWt0b/v5i5LqhnNNW0nqDGIi1iSPwxPscWgFmnpGFHxCv6UQrpOsGTgBlVuye3C68OS6drcOIqNYLJ2ru1TNLKk3r+Dg5uq/FBDEaEJfcHl0J9i03fNPyuhl9oa7Mxpqu0GSpET9HY6skP3ULWYW+S59M692bN14HlHAQki7rHeiGyomS7tqh1GB+GFMNhI5wQfZubZkXljwdxiy1GKKjNLbIJ9Oq3UzvkENCmk+TxjhJ9jZA3A9u7S//8BfUxq7pXyMiSA+5VMiJRiejAlFEERyAM2DINe2BMdlfiavjypLc3efYCtlqJJjfXd+exDcsQ9gwVgbxr3QOMTBV44KzURemLmhOZCJQDw2uAiuFgRbeSdksy9bWzneDKNjSStJIY2HBNkzC6djYibNxtgLN3XzGDrHXpfSjo2qdehKE8IN2oFC7UZMaVWOo+TF4qul1l7yGlb+mO6P02qIj54QGz1CX/rn8f58TGyN/ut8pMaW3CsTJ0ns6rXYo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV1PR11MB8790.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YYjnfiK99UYm7SJ+DlI0QstaBWmp0UGnXwuyMHUhyjFKK43Bu5NShEnnC4pK?=
 =?us-ascii?Q?v2LYlFLTk827mZf7r5/Hhx7/ek0DNfkjNDRNYrew7cNeiF8nqLpNpiSLrOe8?=
 =?us-ascii?Q?KHBljvvPhLO3bGQ02Y0VCihvm9zRGtxS4A/lItNb0zYCkSi9X3hQbiHXXXsL?=
 =?us-ascii?Q?JDeysNYz5zTUlSzdFm9lX2hMlYym/ZJ1mVaaIr3Z0PGB8hKX1e5tT8/R4CW3?=
 =?us-ascii?Q?0Ee4EpD32ffqtieR/fHfgBqt2JkaW6cj2/A+mT9JVG8Tl5UwLA+o+JcG6Af9?=
 =?us-ascii?Q?lZvtJco9YjEmJr6v4LCieRMjMqWonpad6IaXTg+BNYXrTSoWkOvtI0+2RcbO?=
 =?us-ascii?Q?RAGgDeyfhPA0yXFZnwUEXD7NUaWENwifElRypwSAQ8ulIYCXX5fpM/pcv3e0?=
 =?us-ascii?Q?Q0Ucrl9Ra+73ne95fHsXUCKqVJw1sS4QXtTo9vAecGK6x4gIrN+6b+ewxiip?=
 =?us-ascii?Q?+PQIqirNyMq+jTh9lfrlbJ+HCpOEbXCfSWVQ+cNh0U8/8fB8hijP4CrfmCxM?=
 =?us-ascii?Q?Kg0iU4x1WhlCcF05i3QL8IAfKudd6chkAKmjO7nUUOnGmkPnPoXokR6lmgip?=
 =?us-ascii?Q?nnInFUbVVm9qsWPQEE/d4fh0CI0DeQR7CXNbKao+YQ+eaQz3pe1w+rXaLKIh?=
 =?us-ascii?Q?EHnFQIo2JH6R6gwb5O9E6nJ1gCN+0mxAxB24RNyNLvJW/ODfm2df30m2VHM3?=
 =?us-ascii?Q?cYM/BqpEZ/3glmLuW5wd6FmMsFoWz2tRbrZ/DYC2zo2Hzlat4TnSQHEX4R+7?=
 =?us-ascii?Q?9R/NagBTYEceLcW67Oj1hjHIixQIQZ+Xoo8iAfHWk5ZYZurBL+aNMyEt7Aj3?=
 =?us-ascii?Q?jcAchgzrhhh1AYd7sAYTmhkYvbbLkD25KR2vnQq8Wh3QnwW2Fi0NYvvf5CUh?=
 =?us-ascii?Q?6C0J5xYdCVpyIBADfWTxiZR65bfYoJ2pwyGF5ZSKloUZiX0xKZbuLfvThnRQ?=
 =?us-ascii?Q?kk/Qae5iQDJ1NVZCrrT91yRN57qAYQR6tAzJgJC9jTu0Xpu1GMPfVPUPL8gc?=
 =?us-ascii?Q?MVIDQhapcdcuhrmB2qsc6ObDk16MISPBgNzcoUTfYhr7JRjzWUfXLAaq7wn+?=
 =?us-ascii?Q?4eJxG+bTTKfuNU3i8utIoLlIH8Sv7pjEDtRN6/kwVT1Wl4VHrGa+b7ZEIegi?=
 =?us-ascii?Q?gcIrvPSbYjCbErGRVjVXmDjr17gaKGwG/OYsXLZCFWRgkFCrizdYwHg/Uzhx?=
 =?us-ascii?Q?1708ZwonTTndaI0KjhZj9hPcjmD+EGKkkYp/BOBByCilvazjQwt6tGtnTZeh?=
 =?us-ascii?Q?EutYwurJwR59X6uspZrWjOA0v66X6WVTeJ1boCFKFYK8eE4ErTML7Y2g0mrx?=
 =?us-ascii?Q?BJePHIV2pvL6iw7w4KIewOkSiZsQKe0ALshypF3EAxs30URb9+tgsvC3UeeI?=
 =?us-ascii?Q?JtpPVXyVMozojVu1W0nrfSExVaeD5uKSeNTUYpDhKfzdzVSIvcYZnS5wReUE?=
 =?us-ascii?Q?AF7Usn8228VDBnDhDC1Hqs0ollPdweIJ1pF2QegaC1LPznStJ+qRMNWwBJhO?=
 =?us-ascii?Q?+/FvjqKH7tQfwJlKh2WIdr/Lqtzy0yAdieU5fzWFbtkPThoYQd6S8habk66X?=
 =?us-ascii?Q?GU0HiBe2881D0ziUT91IW6x+o1yw3vwbifJeebqXdEyHFiPj+nGGy17SJdda?=
 =?us-ascii?Q?fhzsOK59SkFntgbPwtywB8ulenuOwCSA5/qP2h8qtx2MH9C+B9/oew4xKaS/?=
 =?us-ascii?Q?1R4rODCZx9/xQ0L9mnm/+k9MDQD7U8ZUZlzw5LtDy+e8pdZGHZB4fD4Q0Pbx?=
 =?us-ascii?Q?Wv93jLX1jA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: U+Kwkco/hFQ9fiCXQhU4ZjQtuy5kZ+1GMbCmHYETMPw3Dr+mur1IDGFbZV2QhyNR+uqwSPCs8+o2m0AC10nWv6lClz70YsmEmBKQit85oX8DY2lim6z5jEoo/cBvi1wZmR55VET6Fz5JbTi+xH/4Y7v5Nm9hJNuX2DrezXNvcGqsc2v/0XN3L+mqXdiHQ1LQoTXso8dUSdqK2ceGX4Nr/ftUhNu1MzYyCdoyf7vCOUg3N5Io48MjXvEArQoWEGJ7SROgcfu2n6xmLY+FuL/yhCUZMLV8Vp1hs1OA9Nx7DrVScyO4lTH0KSxmeyV1AmbJd+apIO/2u7T2v+lS3RpTLA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d976353-9cfc-479e-e3f8-08dea4c17126
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2026 00:59:46.6686 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M+/KkpVqjvqYuLmZ7+w3GEf6JjANdqhedbeizAnK+SvpTbCK07U78JWsAA30QIJL+kC5NODp3UDl98QR/R5Pbf0CmWpnjtw7jyma+Byh7ik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9061
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777337994; x=1808873994;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=1rbVxcjTnO/VAPlU5Z6JHbif+diw5WH4BpnqqDmHKWI=;
 b=bEEjuHw3l/Qy8xxPbrkHfmjJFJnuhZabGhcsIP+eTklfaBle+Vc6QBIo
 /at3+Oq054XRYG1LteyEtD2xmHfM2U6F2vSZFvjtCS/Y37HFQCltmIJXf
 kAl/1JRBv3qI92yuxAb03saF9r00IniBE/v5z5v/Ot1VSbzt91Pl7OxzJ
 9KAhAnfPDs6wILiTgfUh6YDY+3lYBDlZimkkckoAB5M1zHOgxEAjbDxub
 OT+vuv+/ktDGsThVmxls5jYkh9JIa+2jQ5z/Lyvc5pOBcv9s3nCupPFri
 5PHepvA0uZT7k54nECNxhChlxqHAZXYTlOgXHFo9u8YY2kdFeTiW7U/J/
 w==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=bEEjuHw3
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH iwl-net 1/2] ice: ptp: serialize E825
 PHY timer start with PTP lock
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
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of G=
rzegorz Nitka
> Sent: Wednesday, April 22, 2026 5:32 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Kubalewski, Arkadiusz <arkadiusz.kubalewski@i=
ntel.com>; Nguyen,=20
> Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <przemyslaw.k=
itszel@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-net 1/2] ice: ptp: serialize E825 P=
HY timer start with PTP lock
>=20
> ice_start_phy_timer_eth56g() programs TIMETUS registers and issues INIT_I=
NCVAL without holding the > global PTP semaphore.
>=20
> This allows concurrent PTP command paths to interleave with PHY timer sta=
rt, which can make the=20
> sequence fail and leave timer initialization inconsistent.
>=20
> Take the PTP lock around TIMETUS registers programming and INIT_INCVAL co=
mmand execution, and=20
> make sure the lock is released on all error paths.
>=20
> Keep the subsequent sync step outside of this critical section, since
> ice_sync_phy_timer_eth56g() takes the same semaphore internally.
>=20
> Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products"=
)
> Reviewed-by: Arkadiusz Kubalewski <Arkadiusz.kubalewski@intel.com>
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
