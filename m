Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E62C1C5DF7D
	for <intel-wired-lan@archiver.kernel.org>; Tue, 18 Aug 2026 11:20:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 96C47606C5;
	Tue, 18 Aug 2026 11:20:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xk0tYp-pkPSA; Tue, 18 Aug 2026 11:20:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8EC89607E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787052038;
	bh=35Hpo0x428JCwmPfXjyTngj1sTZBezAEOldTG8bDljc=;
	h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=4h4/yHgiJKR1XlZNwQ9qYGiPKS3ghXU5L9wNRozmzzE2GxDK7uCIjkgRVU3YqSs+O
	 sBVttC5eyMKBJ+Jbs+ZlqhQikTXv8BpSVVfacV5gMiarm70B6rbtHbRhyZmwD+DFr6
	 95UziccfAFBSQeiWBAXgNc2VVgQlHH5PhOndZtdHll17A7xC1t+K7vxW/+0CBmrO2L
	 3fkZb8W+T1LMfNXh84ujWXgxbmpWMaEQ2M9W1K3TM5c2isB+9e2/cOPO+Z2p3lZweY
	 2mMkMQXaFNLWGw0BJjLUO091uQaDXfY3jYld0RqgKaJDN6BK+sTYPQ9T7nKmSN375x
	 SIkt0pUFHPtlA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8EC89607E7;
	Tue, 18 Aug 2026 11:20:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E3B602EF
 for <intel-wired-lan@lists.osuosl.org>; Tue, 18 Aug 2026 11:20:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C100B607E7
 for <intel-wired-lan@lists.osuosl.org>; Tue, 18 Aug 2026 11:20:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uxRvkLvIrOGM for <intel-wired-lan@lists.osuosl.org>;
 Tue, 18 Aug 2026 11:20:36 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.8;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 7B26B606C5
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7B26B606C5
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=m7o5y/VZ
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7B26B606C5
 for <intel-wired-lan@lists.osuosl.org>; Tue, 18 Aug 2026 11:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787052036; x=1818588036;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=6C0Fc+HeBfOZyG4mWZKqHsHaw+bN5GHzNi8WxJJ/csE=;
 b=m7o5y/VZeFhTOOKG+ouqj66l9p+R8/D580PxM3MwYD3/Irml1rEjDfs4
 C+4tDLDFvWzc8guLB1xCaz3FBRGyJU0bBJ9UJGIJnyaAfUZvIxdUbanqH
 g7Q0uwE/wZsUH3qFlUn6C9HLoYG+s1S1WHIznMHjnbSkRsO8j8JCyPJyv
 MCOW33HjDimumytjDnDUFWpR/suzbhhv5EQi4VQa98rorj2fasguxTbxo
 5HxwZEQ0JWn8hohP2SQXMu5TQYfjzxGUhwK29bz/HGAKdtd0VpIESDxLi
 CqwJ8Qt3S1XG3UoXqkNhrj8aUX8yl66ZS33igqpQatLR+vChKZNMm+M5+ Q==;
X-CSE-ConnectionGUID: fHACF98OQ7KK6nzomD+3fA==
X-CSE-MsgGUID: 0SIaF4dWRmWPhNG6FS6xJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="105074329"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="105074329"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 04:20:35 -0700
X-CSE-ConnectionGUID: bzYOpc0CSYqfmIGZaV5Eyw==
X-CSE-MsgGUID: lH1YifgwRRC28ASFUIu0pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="269038801"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 04:20:35 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 18 Aug 2026 04:20:34 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 18 Aug 2026 04:20:34 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.30) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 18 Aug 2026 04:20:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kbSEJB9WhSt5dRLJ45qiuQv1YxdX7OM4FVGcdsBlGZ+q27M9dbKcdRJvd41pkZckrDCbWlbptj5b3rVR/SsSEUKHe8MX58soVZ6kBtgexLpEAR/5XHCmviT5iip/Kk55NmwX7FfsOElH+Pv7N2iZ/c74x1GFl/oLQPQ77Pu3SLIcSsGQ3r/nxiSUqdF/ssqq4hXYikOmCnyjzBoEMTOKEuCyPjiFBO/DVmxmusQfFVq+p7Elc6Lt42IJmDNByU6uh2x8exKvHaUAIVIA4mN1C20x9rxuK8Xz9UalQDSLn/SWdFi0dLnLeXlce80XF77h+32yd/F/kSZB5jOX9iWbjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=35Hpo0x428JCwmPfXjyTngj1sTZBezAEOldTG8bDljc=;
 b=U4tmyZNHrqZ/yjQPvBYXM/gGi4vKu/x+uBVRGNNizA9YZDSkALGVyPbCbEF8tmlZEyE0qxOGxzJzIVP39dMDyFJ/8gntSxV1Bo2j9I+RSU73zWK9KW+fnAdLMq85q2y9ELU7612FrFHoCODdGzMs7ooBtRFC1RzCQIxgxoxe7mEDI4LCjjZSvdmFErutIjohRCZWy8NYoWu/jxvjy09M63GbLIOoFm4iRhSCGpdOhhdcorehQvXFiW8NhUoux9pLQA2sYZIgxyvjyRSP6Ge7l84uP4qL6mVHPt7dveXGHf4lK6b1nPEJZgDVT0AwCtEvoFO2mDJY5WnqyYDNAUnvKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DS0PR11MB8184.namprd11.prod.outlook.com (2603:10b6:8:160::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 11:20:26 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 11:20:24 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Kshitiz Bartariya <kshitiz.bartariya@zohomail.in>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
 <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Topic: [Intel-wired-lan] [PATCH net-next v5] ixgbe: implement
 get_queue_stats_rx
Thread-Index: AQHdK/m6OIaDRGHOQ0Cm3vSRgCns+LajrrQw
Date: Tue, 18 Aug 2026 11:20:24 +0000
Message-ID: <IA3PR11MB8986DC62208AE5F2F56DF80CE5A62@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260814141446.90544-1-kshitiz.bartariya@zohomail.in>
In-Reply-To: <20260814141446.90544-1-kshitiz.bartariya@zohomail.in>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DS0PR11MB8184:EE_
x-ms-office365-filtering-correlation-id: 6a09f537-2809-49cc-13f7-08defd1ab2c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|56012099006|38070700021|6133799003|11063799006|10067099003|921020;
x-microsoft-antispam-message-info: OlZAjP21D/QvpefC+I4IFKsDkUN90DDoLv/BYaql4yArM25re0xD9tXIjvqEDvgnLyuNim8ZBXnU8rzP99lyId6fuctMsm8AIKo3NnTXvDB6r33CIbAV0nrbf46+6uS3FjJvEQFU0aeve/mo0uATJSHlsGVRUACUt8Rc3EW+VMsGS786fSfWW+tKv3opPpi4N+mQ2hqctQG0VUJbs+gbm7dW0CkZcqjd/wtAQDKlb2PLWUVD87jvEzwb6URMHbKSQKR4MrVjiWl0bxFYap0SKjrpZX/1GQf3JbLlmaikaEvEzin0vhHydiqoPLnLveIebtriDs9kNO11A3H6eOAZxx1KNH+yB4Te5lHmG5S06EoY044zgFSZGrw+ftBCd0w0+yXjYEJ3aCQT6lSQqDeiQBFKFP4JRbZnez2uWotF9nqAW42WYTCVteO9rGSkfnS8zv0mdwrSLS5aGu3KmwLjcYryplBFFj+U5trfnMudGlWjLNLD+CX8aADGZpTLm9j7EBXTxlNCBIkFtwlyIpTi9oXllC3oTIXE9BItWubgYY6SR9uVUvdnT7puOlovjCAPUXzPZr5jbivP5IC/odch9x90+wDdL+QEtdRDZXCAU8++IiMN71akMKPtWP7/FjN17hOPHmfV/mVo4Eiguz1Q/OPsuku3iJSFLhWistnQqCXWPmU2ZxJAHi6082uuZY/O
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(38070700021)(6133799003)(11063799006)(10067099003)(921020);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3mZGB3R4pfh1n420pIiSjHAhWCvqejTXUl4E5Lpe22Ppb//V3iYVSHjyIiRQ?=
 =?us-ascii?Q?DXiJFxwnot6Z8c72eYQrQu60Nm5Fs6s2r/yM8hke258TzyeMWZIojKnd9FMd?=
 =?us-ascii?Q?F+1XH48gTFpAzSGXi7RlGyTIFUweHkLLs4OulKpID3pz6jgFocqygyN7Y1tA?=
 =?us-ascii?Q?RRxFlfqKpqBNuUd4U/8P5OToTFBRg+QCQaO2Q1m7y5J9QxP1doRxKGS+VTW1?=
 =?us-ascii?Q?PMy7+LKAa1zYHxXkHHP6TZqmY7+BaXQxtfGr3Uwnuoc3yAsXNTioBTwpkeX8?=
 =?us-ascii?Q?CnPPeVnA1/62EgnAYecE4hTCGUEb8FYxssp7GF2C7dm6h+NlZFD1drH4EBHZ?=
 =?us-ascii?Q?sL9tU3BaB/89hsDrDLuxYmbdhm/Z5T3mf10oiEmS0abZTHPl6wb2fNUuPIWS?=
 =?us-ascii?Q?h3LZM00u/4u/eum3Hg2It7GlA4jGKpRxZZyP/8tGhNqcFgBpekKsBeQ/8TPk?=
 =?us-ascii?Q?nyiz8NOCLhL00ZvWl9/ZOBdG5WUe8ayrNJBRlnTMvR8vqK8NhfaQaGCuLkOK?=
 =?us-ascii?Q?caVqMDUK3bOLMxGEV1D2tkcywJeoi0182bXvAdJB5ySblrgI1iLPQ9D6AbLU?=
 =?us-ascii?Q?JfS6V1dzOdNCSYsxGkeQM6Qjv5bprqf6SetujSspzzNVUu45Z60xATBpg5NU?=
 =?us-ascii?Q?NjK6ycot7xqRfRORq52cH5w6aBQOPyAMn+xKWb1znCsGECtz8zGQTduSXn1F?=
 =?us-ascii?Q?0jQMhJQopI0ADoBoddVU/17bySthyvsz0CjjxFMpxl4XKg/CcSBVmV/TQBns?=
 =?us-ascii?Q?YOyXYMBn9F31WXaS3Q3whbY1eVnCjm8sNW+q3DkW/rh1NHlLV+wvjF4fpkHR?=
 =?us-ascii?Q?8+JfDzqL3L1ulknzRtgvgtWhlMh0e2HObHu9YaRerBg+r2RplzlcpKXaS/Xo?=
 =?us-ascii?Q?vWsyoQdUi7X+Ng4YkWZzXj7nTlrviY4/D7qbCwgaF7NM4CSsv/IXiClRzUS/?=
 =?us-ascii?Q?GOQ581KEDsFxnyI7IpOq4M9VlKYV7bXMWNxZc8qhqplUpbLQwtzgZRDccdPD?=
 =?us-ascii?Q?PZt8EpnHynXtN+vULttaJciGnAZ4Q/OffzfFH5ErSxACmhvzY6Knsjq7KVMB?=
 =?us-ascii?Q?zmx2visoiGbdsjJ348iv45QefqdH7H3ACrlPYvaYlVUjtden6RCV/ydqBBJL?=
 =?us-ascii?Q?eoTrvp1ii2v0x1qU0scK6VGwrRAL0/Oj3si0X8uWjHbBHIwgXbUQIw1g/Znz?=
 =?us-ascii?Q?8MBtXy78oofzIQsZsbLT1d2A0o61qvVAwCbqDXDH2n56Z7IGbMyg2J+qsEg/?=
 =?us-ascii?Q?DINr+OZ5fGx6LvgXTUKvBgR3vHdgGR7sUpCiNNXSCjD/9TFNqdahxXKSP4jE?=
 =?us-ascii?Q?dIslVofwfnHNaLZ8TDlV4+SWW2kvuZJXRx24Ez45zvPZJ2BvwG1yulkvnwaO?=
 =?us-ascii?Q?/VQdgupda2Xh1r+200zaNhCDnSZSM4FLmFYnAZdJ9r9rA8M9KaJRVOJnVdZs?=
 =?us-ascii?Q?H+F6xEd/zDrFxT7/bZNAGLC/hHUI62uJAmgFRDv/ol+r8ijPQdMtJPNb13dC?=
 =?us-ascii?Q?et6OqT2sW35IBZdpJy7tfjqhIQ0IUeDNn7mlJrlg4HiTlg6nNeXNUIGdzx/W?=
 =?us-ascii?Q?Y1o2A8kUqnOmL514Q9JGyNZHsPnUIpiQ9uh+VhKtO2QVZ8BCjgDVtItCoHe2?=
 =?us-ascii?Q?o1lBvaRzUWXac59DATbG8eEijEEQT8APNQZ9y5+lwiemStLqRwpxyVLQAxHz?=
 =?us-ascii?Q?QzLGgqHsf8Wtob4I/AYeKKbicctwt9kIpKLvEcrF6cTjB3S6H+PxNe2kWzCp?=
 =?us-ascii?Q?hWW35eyO4AXmFIFp1EvapmuBqEOGCxY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: XmsE4kicEev1KKTj25CIYPp3iMdY6IGFshYHff3hFTtMrLC8lUJjRIn59JCMs14IMjT6JfKDqKUoarfZ+nX+dmEoWdh5rqUlRfnnt0BxBF/dGCGGoGKIv4TXh89v8kDoxlV/rtbxEETz6u6e8o4JeSLnveGFoNy7QJahjIg8g30bCtMNsFtGSlecA3PG0ragw64YRCdi08p26V6WBesI8i8mXszwoM8emYRsVDSmyZBnxEcPULufo2HH3FrDIQ6Zyur6xsFRoJAtCPmWJTYDa7HIGrLZCH/xpX4gJdcC0SOef+6+XdPYCqTssNcInAz496I+zXX4xf7Q2daAGKa3Cg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a09f537-2809-49cc-13f7-08defd1ab2c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2026 11:20:24.3326 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xq5BfBGLuTrJH4NiieFzJC/iMW6BYSJz04WaPG+MDjYIkF5NAw9iWvKJtdJSzFY8v/cPwPhga6wHiEir23UiWD3rXibjk9UsUjr1N5yPvtA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8184
X-OriginatorOrg: intel.com
Subject: Re: [Intel-wired-lan] [PATCH net-next v5] ixgbe: implement
 get_queue_stats_rx
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
> Of Kshitiz Bartariya via Intel-wired-lan
> Sent: Friday, August 14, 2026 4:15 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com
> Cc: Kshitiz Bartariya <kshitiz.bartariya@zohomail.in>; intel-wired-
> lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH net-next v5] ixgbe: implement
> get_queue_stats_rx
>=20
> Hook into the netdev_stat_ops interface to expose per RX queue
> statistics through the netdev generic netlink API.
>=20
> The following counters are filled:
>  - bytes: maps directly to bytes
>  - packets: maps directly to packets
>  - alloc_fail: sum of alloc_rx_page_failed and alloc_rx_buff_failed
>  - csum_bad: maps directly to csum_err, which is incremented for both
>    IP header and L4 checksum errors in ixgbe_rx_checksum().
>=20
> The new per-queue stats can be observed with:
>   $ ynltool qstats show scope queue
>=20
> Signed-off-by: Kshitiz Bartariya <kshitiz.bartariya@zohomail.in>
> ---
> v5:
>  - Added READ_ONCE() and NULL check for accessing adapter->rx_ring[i]
>  - Added u64_stats_fetch_begin before reading stats from rx_ring
> Suggested by Simon Horman
>=20
> v4:
>  - Changed comment format from // to /* */
>  - Moved ixgbe_stat_ops declaration next to the ixgbe_netdev_ops
> Suggested by Jedrzej Jagielski.
> https://lore.kernel.org/lkml/19ed3cf767d.36a9bda531830.501701716215039
> 2549@zohomail.in/
>=20
> v3:
>  - Added bytes and packets stats counters
>  - Implemented ixgbe_get_base_stats function  As suggested by AI on
> https://netdev-
> ai.bots.linux.dev/sashiko/#/patchset/20260603174857.78666-1-
> kshitiz.bartariya%40zohomail.in
>  https://lore.kernel.org/lkml/20260612084605.19785-1-
> kshitiz.bartariya@zohomail.in/
>=20
> v2:
>  Amended commit message with command to get RX queue stats as
> suggested by Jedrzej Jagielski.
>  https://lore.kernel.org/lkml/20260603174857.78666-1-
> kshitiz.bartariya@zohomail.in/
>=20
> v1:
>  https://lore.kernel.org/lkml/20260602100932.21838-1-
> kshitiz.bartariya@zohomail.in/
>=20
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 45
> +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index 8873a8cc4a18..560177f135ff 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -9760,6 +9760,45 @@ static void ixgbe_get_stats64(struct net_device
> *netdev,
>  	stats->rx_missed_errors	=3D netdev->stats.rx_missed_errors;
>  }
>=20
> +static void ixgbe_get_queue_stats_rx(struct net_device *dev, int idx,
> +				     struct netdev_queue_stats_rx *stats) {
> +	struct ixgbe_adapter *adapter =3D ixgbe_from_netdev(dev);
> +	struct ixgbe_ring *ring =3D READ_ONCE(adapter->rx_ring[idx]);
> +	u64 bytes, packets, alloc_rx_page_failed, alloc_rx_buff_failed,
> +		csum_err;
> +	unsigned int start;
> +
> +	if (ring) {
> +		do {
> +			start =3D u64_stats_fetch_begin(&ring->syncp);
> +			bytes =3D ring->stats.bytes;
> +			packets =3D ring->stats.packets;
> +			alloc_rx_page_failed =3D
> +				ring->rx_stats.alloc_rx_page_failed;
> +			alloc_rx_buff_failed =3D
> +				ring->rx_stats.alloc_rx_buff_failed;
> +			csum_err =3D ring->rx_stats.csum_err;
> +		} while (u64_stats_fetch_retry(&ring->syncp, start));
> +	}
If ring =3D=3D NULL then bytes, packets, alloc_rx_page_failed, alloc_rx_buf=
f_failed and csum_err are uninitialized UB.

> +
> +	stats->bytes =3D bytes;
> +	stats->packets =3D packets;
> +	stats->alloc_fail =3D alloc_rx_page_failed +
> alloc_rx_buff_failed;
> +	stats->csum_bad =3D csum_err;
> +}
> +
> +static void ixgbe_get_base_stats(struct net_device *dev,
> +				 struct netdev_queue_stats_rx *rx,
> +				 struct netdev_queue_stats_tx *tx)
> +{
> +	/* ixgbe has no inactive queues */
> +	rx->bytes =3D 0;
> +	rx->packets =3D 0;
> +	rx->alloc_fail =3D 0;
> +	rx->csum_bad =3D 0;
> +}
> +
>  static int ixgbe_ndo_get_vf_stats(struct net_device *netdev, int vf,
>  				  struct ifla_vf_stats *vf_stats)
>  {
> @@ -11117,6 +11156,11 @@ static const struct net_device_ops
> ixgbe_netdev_ops =3D {
>  	.ndo_hwtstamp_set	=3D ixgbe_ptp_hwtstamp_set,
>  };
>=20
> +static const struct netdev_stat_ops ixgbe_stat_ops =3D {
> +	.get_queue_stats_rx =3D ixgbe_get_queue_stats_rx,
> +	.get_base_stats =3D ixgbe_get_base_stats, };
> +
>  static void ixgbe_disable_txr_hw(struct ixgbe_adapter *adapter,
>  				 struct ixgbe_ring *tx_ring)
>  {
> @@ -11663,6 +11707,7 @@ static int ixgbe_probe(struct pci_dev *pdev,
> const struct pci_device_id *ent)
>  	hw->phy.mdio.mdio_write =3D ixgbe_mdio_write;
>=20
>  	netdev->netdev_ops =3D &ixgbe_netdev_ops;
> +	netdev->stat_ops =3D &ixgbe_stat_ops;
>  	ixgbe_set_ethtool_ops(netdev);
>  	netdev->watchdog_timeo =3D 5 * HZ;
>  	strscpy(netdev->name, pci_name(pdev), sizeof(netdev->name));
> --
> 2.50.1 (Apple Git-155)

