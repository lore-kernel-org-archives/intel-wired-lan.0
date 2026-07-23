Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CD92C531CB
	for <intel-wired-lan@archiver.kernel.org>; Thu, 23 Jul 2026 09:23:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 218FC6071E;
	Thu, 23 Jul 2026 09:23:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1zyD8h9R1r-E; Thu, 23 Jul 2026 09:23:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 488566075B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784798583;
	bh=9VeCSrF00zz8hA4FZx+TSNdStgGhkWBzp+pT+4b5+fw=;
	h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=5sk1XoMIHUnEjlpUuhy5XzYTwKqW3FMrd/AU3dAqkRRTPPAGcob3M870O6kJ15pNV
	 mJnlON2eVwOQJA8t75piJhTXRxXhlLjpkAXFOS/0qjsrNVhABec2ZubJltM6NV0EJ6
	 o0JYNu8igmT0XIvFzbeEpTf2tRBmw03/rFVXH05jg+lRicdKXXVZmWtNx4V57ajNua
	 1mXSrHgcGdLxxIuU/oltmgTRnRMZiwMUy38m/qd18Ms9GppwQBfgUGEJm0LEJykQKm
	 OHK+zClhVrnoLAdnuxSVFHlit/gUxIAa1L633L6Cr1zeKxmBAs+skLVkxiwo8l+zXo
	 hK5PVDvJHO4Dw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 488566075B;
	Thu, 23 Jul 2026 09:23:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E69BD3B1
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 09:23:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D88F16075B
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 09:23:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rnQRd1ioV3IV for <intel-wired-lan@lists.osuosl.org>;
 Thu, 23 Jul 2026 09:23:02 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org C88286071E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C88286071E
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C88286071E
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 09:23:01 +0000 (UTC)
X-CSE-ConnectionGUID: hdwxt3ZpQPSfB20XouIWiA==
X-CSE-MsgGUID: JUHLvkF5Tqqs2CJkJ7tUPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="89342474"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="89342474"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 02:23:01 -0700
X-CSE-ConnectionGUID: rP6TAwC5T+GdRKiJZTpTYQ==
X-CSE-MsgGUID: EPBWrjt3TOKwKscQKK69lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="262666824"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 02:23:01 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 02:23:00 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 23 Jul 2026 02:23:00 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.29) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 02:23:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w+BYQ3zk8yxX1OVp2axzYqirKWkmIsMAZ0D4Q4eUP4Q7LxPHCgVt4IQOBt+PpP9fqFBuXREn54dVPmzT42tGZjiY7xTxXna0KvHu/Q8iMzGWrWbxOXVIA8o5PV5E+GJiryY5ZurFI2sZEh6BW8LXn6bB9OOMJJpu0SQe9E3WiLb78spa3szUkrZFUJ9IvXvpxKOC30CErOPGmbq5znirhJRHma3VC1M5IXA0q/ICl9VzK8uVgeYkWBKAfVUCD3gzEZu0B+/R6mxIIh4plUsTFlqT00JRco/FfPpg+LPXHjGhqXv/4mxIC79sUtXgWTLz8OZKDQPsi1DSQHO0DgVCog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9VeCSrF00zz8hA4FZx+TSNdStgGhkWBzp+pT+4b5+fw=;
 b=xsNp4fT/ttoKfJ+6XeDSCy3ZxE/VxIKUW2jG3Eurfh1RAbCtE6riVXxVEM5w7miLtKSvSSzSi/kx6YaNWxwTAe0G9OcOHuT8agGvgm/PIY5uad1O1yWcLlJaYPEIMjMxQTlYSq3HS/SMpQ7xfy6Te/w1WwPxVxJQZ7e8jUH4+KO0sQs+ZWKDctmn7vRdDONCnezj6CfYfZq4i1acrlmFb+bwLdybnqGqNydd692lGF0TE1p6Rnj+Ppw++11i7BGV8jCsEm0VPEAJHGAoMxaoTi48xP0aBsXpNsFic36SotHEeOCqfnHQsCf+thnpxDi+5CrU19oqZQVzJm55z01TiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA3PR11MB7628.namprd11.prod.outlook.com (2603:10b6:806:312::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 09:22:52 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0223.017; Thu, 23 Jul 2026
 09:22:52 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Korba, Przemyslaw" <przemyslaw.korba@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "Kubalewski, Arkadiusz"
 <arkadiusz.kubalewski@intel.com>, "horms@kernel.org" <horms@kernel.org>
Thread-Topic: [PATCH iwl-net v2] ice: suppress DPLL errors during reset
 recovery
Thread-Index: AQHc6E7SOOXRjE/6aUqwOBbTBJWctrZ7OP9Q
Date: Thu, 23 Jul 2026 09:22:52 +0000
Message-ID: <IA3PR11MB8986BE99F5DF5FA58BD2F8F4E5C02@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260520115213.10864-2-przemyslaw.korba@intel.com>
In-Reply-To: <20260520115213.10864-2-przemyslaw.korba@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA3PR11MB7628:EE_
x-ms-office365-filtering-correlation-id: 79b37dc8-ea03-43dc-c331-08dee89bf8d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|38070700021|56012099006|11063799006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: oRy3bRnlkOlNILBuFS6OMVxH5cnF/syrJtpXwzmUtb/FCeqBWmBNHLhWMx2wBLHSErgwfxBTZUv9OB0nnd/vbkyalraKStNLOROz4AFAxiTPFZO1d/QZXk1WSrAVZcA4w9p2Hn3lp9XqaPIbAg3lb1mPtDJzGfCLwPOzQ/TqjeLqXYZ5WGtCiEOOp0rKf/qJEDPpwcrJMUfUCrXc+M3MycaMlotDcwo04aOzd/qFmh+5VujZfypoifi2Oj4x6TWd4/kpuaL66Sj9xOWt9qms+c3PEpafFdItQdp+q5bfirNwNLXmuYol8rfZE9I+jIXjDarOqV+zuLsJPRYXfxLPQ3NviECp3vVXMk2QTwP3adgSMIeVXUghnhGkzLr1PsUq3K9wYg5CxTCghV1l9Q6+5zwa9/YOfCyj93QSoaE6u3G/aEwo7PW8RTwZkx5+TaGv9U5HoHGMTfQeTQZNmppdKXCizqlnnECHwqc1A/2OibG+jZ6TqAFa2MVpBS90WqjvcAVLMFZhGMH1uHBqhAAor6XivwXEZaiyqNdzeLbxg39XaN06+VJcKiop+C6X35W6LdwmkVVd1v7SljQ63TvJckxteRFGDMaOzvmUt8P4v2f8u15qfkzMmF/PTmme20aiTNVLrVrruL6tHgkZhtiC9FS96oJCVeO63hWi+qsnZR2ivUojGtrwGk3MBF5FLp5Cd8hh2mvCqYVa8kaHf5sRcgDBOUEQkR7KHn3V+jQ3ukQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(38070700021)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nguWcQWNmO+rQwQ3QjkEBuQyPPij4pajFxA6J+QUuwbXqTkJi5IvyUA94XYZ?=
 =?us-ascii?Q?CRHueMMNWki4UIxZzPccXO7cALW63m5KPthuWFqbFam4mHsPfKzzw7uIl0kw?=
 =?us-ascii?Q?v6bjnH6B5Z867qiiVmTYaBPKPlg2WWDFIWzH2fYhk31ZcKLABMwFv/C8LWBD?=
 =?us-ascii?Q?Fj48PMGVNm3MUDVWnFVF9MArjc7f++Il2Bmws++rXy48ptLxDK2EyvhYni8N?=
 =?us-ascii?Q?stUKuBoJccN0nDIsy+eBCOHeB+j+KvaZxlSMa2tuLtAZgjCM2tsiLfkG3lot?=
 =?us-ascii?Q?qf8cBxlJtSPWD6orEUY9nT3OuQD2O5224yTmauHfEFrvjzMpqQfURLc70tUL?=
 =?us-ascii?Q?KJ+vR6r+o4kJ2i7eKnElvm+z4KShriiDzXTZOxac0cVLxZ0Ftnqm94Q8S78a?=
 =?us-ascii?Q?qY6Fjl+BdbUYW5Lkuluv9iCpRle4ARR9nEfZkmhE+Ytr1sG/YdskaH5hT4eP?=
 =?us-ascii?Q?ff9yjV0vIVnMi2cy29/WVsA95UQF31BZbI5U4mT1xVyuOvcnu3LNF4PcCeAv?=
 =?us-ascii?Q?WuSuNj3FcjUmijHVTqqchK6gU1RhUYnePPDCYuBR1ZaoT9QpIchPktAmw7Dp?=
 =?us-ascii?Q?FxAzhPynC6DLN3SnoGwzDYvJSLU1UjQAnR6ml2yCaEvgoJOHughruVSaL4D5?=
 =?us-ascii?Q?BatLtEsjkx6g9/1nMF67V9OCc2uygkoMMfqKiS2Eq2kyKKFkL3nPILYt9vTQ?=
 =?us-ascii?Q?XZ+02mSEo1LL2yzBiZ48tsUrfC7RQzaqHNHKa0QpWu/Vq/FIdT1gpumQrimu?=
 =?us-ascii?Q?PFtkoK7j4qB/5FbhWyhsEs9LO9j/G4kN7SBYWY8R5ngAyK/JP8WsiFMq8rDe?=
 =?us-ascii?Q?dM9BHdOKSfzVQLnBFBHK8DUFNju2+zKkUeJtUQSICWoZGYiboD03ACPYBLFG?=
 =?us-ascii?Q?2tFTyyLKA0YK0wGBwc+72KnGNgnoYBWIQKyJrElfKJIvEZ8puGIeLGgJrewc?=
 =?us-ascii?Q?3+DlgU1hUfqrZi+y1rFRHGnUbOipmpgXYQ+UsfFRtNSPae9iQfx+qCSwqZCT?=
 =?us-ascii?Q?luhe1AyUoWeMrzTGwrMTag4d2bn3wDBzboWwd35KCtMTjw89xEvEPInVNLr9?=
 =?us-ascii?Q?BlyscTWI4/rnln+ukYpKiUSgtOnGxXNcIDBUuTOLoakGDLFiwUjkrcjVcbDA?=
 =?us-ascii?Q?IiPgNBQFxK0KVRia8XCka2O99Y9jqZsI8akkkf2c8UQ8MOWd1sRF2PMvAZis?=
 =?us-ascii?Q?36k6hNMUDXjM3jPYqg3w05fiyu3kSFOne7eF5TD6+/JpC9ERSTKCa8PQNwEl?=
 =?us-ascii?Q?wW//KHhYhPcMWrxqrzSHGw81JL33jHgzN3HiTv8W3EN7LUOBp2AbcJjbjIT/?=
 =?us-ascii?Q?a99iXCkHjBM3brBJl5hKGDqGgWtfvceN0lA+eXU/X84DD9Ed5z4duqJKo5kc?=
 =?us-ascii?Q?AYptTUELJtYo5RvH/IOuhPhZbnGnHZUX4SbEASQ+lFwji1163yaG043/9ual?=
 =?us-ascii?Q?UQlu5xpIkfqn+LTkj+NYGH/106PWSoaKFCWHwkNdgFDoEH41djT0yKkE+4bs?=
 =?us-ascii?Q?gnr8X+DaOtlhuc9uDdAmxI3zrrg14WdeFEDzug6S7q1lRKjjYEpJI1ixHyPo?=
 =?us-ascii?Q?lj8l1k4A1UXDZN5IoLhzjTWn+ydMirt3rRtTfqeg6HrmC9V6oZdHgdKT0NuQ?=
 =?us-ascii?Q?zZXSknnL4X9m8wjm2qWQeZJKABAQL0t/gIP3YEmI20n0b2tWw7d+RH/8zHXY?=
 =?us-ascii?Q?B9R7xKmzvovbG0L8qGAiVtYQLXU6JQ0T6Fjo32N4oIrAdJtFDLsl48XJ0Wvv?=
 =?us-ascii?Q?MoW0BfCTtL25lTDnSyUlyhl3HIoBhFo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: GGyOgdJX5xknVGa//hkvxesAazPtw2o+1aO0uREMI1bi/s75WjNJ7YwgrL500YEQY6MyvqGIvKMYoh3e/EN3fhHBtRtxzDgZf3dR7v/uGiLJW0R+zSWxBu8EmLcU+um1CHJMXP6a3Qml+PIU/63gl/uTRdsoZarRnTd9ttlcsDE/6BMUpr8i+w6nq/w9s7Th9Fede/gZc9+2pHanF8nMIObTI4HvwyKt2L7/2uT4p9vVwo4Xd7HeMjmq5eBMLExJX9HfP+jhJNpTPCXIWDi+2e4MBsmlhAIwOONQdpfcVKpqwqdjhNK6Ms1Z5lQVFzkTn+nMiRh0xNFhflvSMgB2oQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b37dc8-ea03-43dc-c331-08dee89bf8d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2026 09:22:52.5117 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4xCe9i8r8Gjrd9pIGFrPLKRQaR8OdkJIf8x749L+qbUG/PFy3qAFBqvfuv83EP7EDTm4J2f6A/5X4oLoitJz9+c8hHtx0sspXDNojMMr7PA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7628
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784798582; x=1816334582;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=2FwOATW/IU3hCSRYK3VLD5NIVbWqZxLw/T9GlEQDOTc=;
 b=bAvNuJ1WZXZae5YVigNabP9udN4BX4JZv+mgBolfsEUiFciWBf/n0IiT
 Hr+z0kbM5ChUEAXdLFwgjXG7ucrJdEzXPDlJHb79pTNJaGeKHlgoxjpJn
 tskZvfG2jSQ6No5kG85JhC6tnp5kMmzI/Ewk9h88QRQOOY/vqyMCh6P9B
 b2+7A5kErE/9RSitEFzUIG1yyZ47qYQIAsjiHnlrq/cZyBB9+epnS32hu
 NvnpJY8g/RO0kr4J3ssD9MjilFDBxZBGIy1Cfk2NsUd2WL9nqmTyjzBQs
 90q2J2oeUsOBgC8ecqzIrqgiH7qqq7qryjy5hGCa1OEJiA1yrAo2y7UWi
 g==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=bAvNuJ1W
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2] ice: suppress DPLL errors
 during reset recovery
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
> From: Korba, Przemyslaw <przemyslaw.korba@intel.com>
> Sent: Wednesday, May 20, 2026 1:50 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Kubalewski, Arkadiusz
> <arkadiusz.kubalewski@intel.com>; horms@kernel.org; Korba, Przemyslaw
> <przemyslaw.korba@intel.com>
> Subject: [PATCH iwl-net v2] ice: suppress DPLL errors during reset
> recovery
>=20
> During reset recovery, the admin queue returns EBUSY which is expected
> behavior. However, the DPLL subsystem was logging these as errors and
> incrementing the error counter, potentially leading to unnecessary
> warnings and even disabling the DPLL periodic worker if the threshold
> was reached.
>=20
> Suppress error logging and error counter increments when the admin
> queue returns EBUSY, as this is expected during reset recovery and not
> a real failure condition.
>=20
> test case:
> - ethtool --reset eth3 irq-shared dma-shared filter-shared offload-
> shared mac-shared phy-shared ram-shared
> - observe if dmesg EBUSY errors are gone
>=20
> Fixes: d7999f5ea64b ("ice: implement dpll interface to control cgu")
> Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
> ---
> v2:
> add missing EBUSY check in ice_dpll_pps_update_phase_offsets()
> v1:
> https://lore.kernel.org/intel-wired-lan/20260520105311.5336-1-
> przemyslaw.korba@intel.com/T/#u
> ---
>  drivers/net/ethernet/intel/ice/ice_dpll.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c
> b/drivers/net/ethernet/intel/ice/ice_dpll.c
> index 0704e92ab043..815792567a94 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dpll.c
> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
> @@ -784,7 +784,7 @@ ice_dpll_pin_state_update(struct ice_pf *pf,
> struct ice_dpll_pin *pin,
>  				   ret,
>  				   libie_aq_str(pf-
> >hw.adminq.sq_last_status),
>  				   pin_type_name[pin_type], pin->idx);
> -	else
> +	else if (pf->hw.adminq.sq_last_status !=3D LIBIE_AQ_RC_EBUSY)
>  		dev_err_ratelimited(ice_pf_to_dev(pf),
>  				    "err:%d %s failed to update %s
> pin:%u\n",
>  				    ret,
> @@ -2821,7 +2821,8 @@ static int
> ice_dpll_pps_update_phase_offsets(struct ice_pf *pf,
>  	*phase_offset_pins_updated =3D 0;
>  	ret =3D ice_aq_get_cgu_input_pin_measure(&pf->hw, DPLL_TYPE_PPS,
> meas,
>  					       ARRAY_SIZE(meas));
> -	if (ret && pf->hw.adminq.sq_last_status =3D=3D LIBIE_AQ_RC_EAGAIN)
> {
> +	if (ret && (pf->hw.adminq.sq_last_status =3D=3D LIBIE_AQ_RC_EAGAIN
> ||
> +		    pf->hw.adminq.sq_last_status =3D=3D LIBIE_AQ_RC_EBUSY))
> {
>  		return 0;
>  	} else if (ret) {
>  		dev_err(ice_pf_to_dev(pf),
> @@ -2883,10 +2884,12 @@ ice_dpll_update_state(struct ice_pf *pf,
> struct ice_dpll *d, bool init)
>  		d->dpll_idx, d->prev_input_idx, d->input_idx,
>  		d->dpll_state, d->prev_dpll_state, d->mode);
>  	if (ret) {
> -		dev_err(ice_pf_to_dev(pf),
> -			"update dpll=3D%d state failed, ret=3D%d %s\n",
> -			d->dpll_idx, ret,
> -			libie_aq_str(pf->hw.adminq.sq_last_status));
> +		/* EBUSY is expected during reset recovery, don't log
> error */
> +		if (pf->hw.adminq.sq_last_status !=3D LIBIE_AQ_RC_EBUSY)
> +			dev_err(ice_pf_to_dev(pf),
> +				"update dpll=3D%d state failed, ret=3D%d %s\n",
> +				d->dpll_idx, ret,
> +				libie_aq_str(pf-
> >hw.adminq.sq_last_status));
>  		return ret;
>  	}
>  	if (init) {
> @@ -2955,7 +2958,9 @@ static void ice_dpll_periodic_work(struct
> kthread_work *work)
>  	    d->periodic_counter % dp->phase_offset_monitor_period =3D=3D 0)
>  		ret =3D ice_dpll_pps_update_phase_offsets(pf,
> &phase_offset_ntf);
>  	if (ret) {
> -		d->cgu_state_acq_err_num++;
> +		/* EBUSY is expected during reset recovery */
> +		if (pf->hw.adminq.sq_last_status !=3D LIBIE_AQ_RC_EBUSY)
> +			d->cgu_state_acq_err_num++;
>  		/* stop rescheduling this worker */
>  		if (d->cgu_state_acq_err_num >
>  		    ICE_CGU_STATE_ACQ_ERR_THRESHOLD) {
>=20
> base-commit: 7fd738d8cf34f46a7ec485426e2a5423ade8a63b
> prerequisite-patch-id: 45f595ded339d5f7feea2ea7ff196db3c08e3503
> --
> 2.43.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
