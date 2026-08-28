Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6189AC61DB9
	for <intel-wired-lan@archiver.kernel.org>; Fri, 28 Aug 2026 06:57:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 049DA80E93;
	Fri, 28 Aug 2026 06:57:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HFMDVRue5cWh; Fri, 28 Aug 2026 06:57:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787900263;
	bh=cgUVtDQBwskV/tQJyYJKfB4+17GNDz4SG2Zh3Nz0smo=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XOSQ8PJ3bvSklCzPToR/sQK4XWjqeyziAO+EHs3SJqgp80Y7jX1+LRJLxWKfgdIWy
	 m6naIZA1+McWdZasfyzrwgpFR4AihoKA0m/CcmpucF3P/SqN6wUO/K6K5XdY87LAyq
	 UALy2CvEL/srZqTl6M9l9vnfgrhL1+uzSLeOQJ5tdqWdZCdop9mmw0P63KLFFGVBY8
	 mzo5YiJhv8Cy5AHO/IU0SMFAf3W3CkCVgJ+u3mUeFkc19TP9lMklLRjEEWJANfSbBz
	 80MSQWMZbFpNog6RoV0UGbU8tSJVsBSEFQ3NDSmgksEgiewwR1pgqTMhjCz8+ul6dk
	 c6Jr+eC3acEgw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A415080E37;
	Fri, 28 Aug 2026 06:57:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B4DE123E
 for <intel-wired-lan@lists.osuosl.org>; Fri, 28 Aug 2026 06:57:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B2311403F4
 for <intel-wired-lan@lists.osuosl.org>; Fri, 28 Aug 2026 06:57:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uyc-DcBsDS8E for <intel-wired-lan@lists.osuosl.org>;
 Fri, 28 Aug 2026 06:57:41 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.12;
 helo=mgamail.intel.com; envelope-from=sx.rinitha@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=fJmAEyRX
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B6D66403E4
 for <intel-wired-lan@lists.osuosl.org>; Fri, 28 Aug 2026 06:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787900262; x=1819436262;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=cgUVtDQBwskV/tQJyYJKfB4+17GNDz4SG2Zh3Nz0smo=;
 b=fJmAEyRXZZ1/A+mPd4cjlfMqT7TlluZscnIXPGrERcoSWSb7xjvW1HDk
 WqtlRxEuxQjr9hJJPPJQtSvYLUfZJ7WcjrVEZzOgalNs4R8jnXcYL8uN2
 mFLAEiSEmSOp5DrDuzo/rOIYC+iVbWKtl7zpjO1PSKTTipV6GGSEbgPQg
 BdP0Se00OJaj0qSTDY+d0xg32itvur9NVFx3vq5TuTApt8JltKi48zdBT
 zj3gceEffURSy39EjmQtZih6uHeeqRTx1NDhYVpBM5LcxjJn5GWiDNHQ1
 AUpNkhgkRyPdQ8hbMj5vd9a8i5SKJtRyR+reGHQbnqjdqSitCBzXbAUmq w==;
X-CSE-ConnectionGUID: JTkFMtANSbKUzkljeOuBJw==
X-CSE-MsgGUID: jzpQMs2tQr+dyyYHYBAJ8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="92219500"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="92219500"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 23:57:42 -0700
X-CSE-ConnectionGUID: mz7be9BgTN2AJTO7M8IZdA==
X-CSE-MsgGUID: VsSUDiR+Qnq0qFgabmqf8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="271602203"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 23:57:41 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 27 Aug 2026 23:57:40 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 27 Aug 2026 23:57:40 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.28) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 27 Aug 2026 23:57:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kp52kKT9h8pDYYpSXnb7hX28uOOzQdMlyKdNdDf9VNWKbaDinpSKQ87eRooTSmpaMFxt9x60+vlrYBzQbvH8FGVYX9Y4GeoeXobRomo7Uzm3NML8g5c/PUz5aeC9qpf+pLX3aZlhXIVCs0HGNyiULjo4KTMg9l1II+jM/i7IqkLKeSKWC/wVEsQ36xsrA6KQQj218vJdMoUtm06AQ+7rCfXA2Fkodg/bvfHlphAWJFGwQ+uaPmeA+IicQBP+BEvl3S0kRahjXPwABw4vAlnVxvDvQVxa1lEDxCUAYMKaulJMP5MZjlR9dS8D950HKl0uZiUVFtXCJ727xCHQmwAFCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cgUVtDQBwskV/tQJyYJKfB4+17GNDz4SG2Zh3Nz0smo=;
 b=Le4W34PTGHkoPsJnoPUPGGATmyfWruGdscNEA/ij3xd4nTZwFRMJOD7KVaLc1p//22w7OMWWJCySbVcHohR7KnjuejQNvb6EbyKBqPR9vpNYI8gI8z4I9hJTCIwc3uPkAWH8QWrHsN/MMr9n49/8fBwB/IdUQGaJCTjy/FaguHozTkjaLQ7Hj1Yg7cvAGWnib4Q1dCtt+dLrt1r0ILeQD1YXUuot/a9rgZYLYscMv1QsctglugD8oM1EXL+3Qu7iHNukYffN35524Bwwi7lAY6erBmRWEVsP3K+ZONJgAFyPvyQ/9yZH0kUFSehBb06yLiQSZrZ2u4o0SpTRoG6wyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by IA1PR11MB7725.namprd11.prod.outlook.com (2603:10b6:208:3fd::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 06:57:30 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%3]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 06:57:30 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: Pawel Dembicki <paweldembicki@gmail.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net-next 2/2] igb: read SFP module
 EEPROM through igb_read_sfp_data_byte
Thread-Topic: [Intel-wired-lan] [PATCH net-next 2/2] igb: read SFP module
 EEPROM through igb_read_sfp_data_byte
Thread-Index: AQHdGFuNu3j7HrZg7ECNnORWilnKu7azM8Pw
Date: Fri, 28 Aug 2026 06:57:29 +0000
Message-ID: <IA1PR11MB6241EA3E3846E7AF5E0B1F258BAC2@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260718165637.3621784-2-paweldembicki@gmail.com>
In-Reply-To: <20260718165637.3621784-2-paweldembicki@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|IA1PR11MB7725:EE_
x-ms-office365-filtering-correlation-id: 0b82a59b-f0c4-4c88-92b4-08df04d1a0a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|38070700021|56012099006|10067099003|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: bZj3dDdDS6ZVf8daOEW0M1aJc6R0M6WBF7vKnDm14jAavS8E5e2PsBeIqYn6cgkY7fYE7dxa8U6D41F+RX5VWatTyUYiLN8CK7hqp7kEiMtaxEubnPcLmczMI1+FLaxeQA8HYNYHZPxg0C2RmDkbUWotVhjJdO8rKS+3IYaTqNDV27nXxf2zc4Zs9jrumzvTmEPbgGJ//k+MEVZ9WmHrYOOhdXbnzACg6G+ZiRubiXgXw0yl47MWJGAVxVpWRIMvq8d1+1rM+ahAVH9Yl99gTvEyoC8Qw8LiF3+4gzMsunHo2VR0FOYQ5NpzHQVq3e8hifLy46AvN0h6RB/X2ObjIud6PoiopM9wQXik0iWEntDXhp7a3ws6LICCEWgfjLU/41pIIGYQ7RI6/uDwUlM/b+Hnzc+lF1hSQRfkwPhrJtUKDCltBkof0E+DK/4Mq1W4/JRlEFHXwAZUIIq8BdOCY/aaU+WRzrtVJd6VngeM4pPCy3hsUWCIajFdocCFra5Jn2vF578NFFRvazoR3fnO3XSOSpadoaqi22b9be1i6R0lIzvd6XjBDV7ujt7OPY2ASCUtCzRgKF1vW8bSPsh9CRdmcqHPnpZjmAV6pE0oUjvAX/Ek3Ar8NhVDHrPfm5eYOqT3CRIOzODn9A+ZpsNf+9AroIc8h8sARDFmqhEYxnZWfLG9y+PDPJQzO3JYqrP0MXj2XOU2FlhLb+m/BlnYdQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR11MB6241.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(38070700021)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sOluoyqoiQCZTA6iRSpVuaDKQ8jX9qoj6DWhh/1eqGg3sFbv14sR9QmjXoIB?=
 =?us-ascii?Q?/xYpEZITqNcY2uQ2fcdvOAr4Gi9S/YZfXJGRFMvT1kst90cS0ADe+WG+7Sq5?=
 =?us-ascii?Q?eXCig5Y7r3fBNeWB8Lwh06oh32lBPjdXF9hvWGJrFx/U7XfA2hhGqKcsItdg?=
 =?us-ascii?Q?zAnybQRiDTpuD4nYk0X1bmLZBS+bmSgU18GTr/fHau+aIc08xCou03qVUtCu?=
 =?us-ascii?Q?e0sx8+8Y5GZK+gWy9hnauPGI8JH5ldwqSsNmg5B7hEq1Hp7Gi0XoA78/9C2A?=
 =?us-ascii?Q?UKYNiq8bWBUoICSWH4/MVNYd8e1IhG5P4fDZify9N56BZoUAIRQdh8XIMGsx?=
 =?us-ascii?Q?7mqDBHWLFeQ30jYdfYdqjhHzeMmMd/VIPn9ddx22f+VWLYsoT08aZQ3WqSuw?=
 =?us-ascii?Q?HLgVr4YoYE2pqrqKq1YmNwBynrLLrECP6oBefxWtJgPkfJ4CMyMLcungjIIb?=
 =?us-ascii?Q?pLIyrXVn8R2QJfLVdeXuN3C358+LL5ItHgQVV1jJTW5YpwMGfzdFMa8OZEjA?=
 =?us-ascii?Q?v3g9q/kTmYzktXJe1jMnpRw9X8jLZxBlrrQ0qE1gU6WXBJnlnRNq2F/llUlJ?=
 =?us-ascii?Q?Ok6m7MIwsf2Dom2gnmvmdcLHfTkR38whAgHoiydUFzSorOCC25/ZPKTIRpkQ?=
 =?us-ascii?Q?gUcukBreuQ68kOQrDJDJMGl6dm4TnIjV2q5tLC4pulEBk+0NWk6ya7RRA74U?=
 =?us-ascii?Q?cnVrFAD6Nqg32ESCgtTmmiY+kl+tX/5N6ezB4dx5sNxivEfxsGlPpwlXTWuU?=
 =?us-ascii?Q?zq2ySmUEf92/cKPpbWie+N/ig18vDW6h++Ln7neutP3k9H0qxCmbmJD1bYCc?=
 =?us-ascii?Q?faLKrc4woZDeor5ew9ZKLbft/f8XS4WN2e89Ot2IX9mtlBkGH15VlbWp2j2N?=
 =?us-ascii?Q?Bauhth2qBdwOLbVj4BeTMddc2Bs0K5l+ErkQl2y3ALVTS+n5elt8zhSzUxQx?=
 =?us-ascii?Q?Lslix71+JHGgN+0gMyZb+IcWsbW0oRMjIdT+mSk4zrgGw8SFRbiaXGW96aZy?=
 =?us-ascii?Q?xhYRKAbJy1820Iq/TCePN3B3bL0kfPNtmjo5WrCyXy3jdL7aqj/WnwHi1gqj?=
 =?us-ascii?Q?xMv6YNju6omzeGVNHb4QXXLf+BD97VEYCwr0878x5uBOVIMMCoZd/BDRgUUB?=
 =?us-ascii?Q?VhfCFCuIdMEdrh/O40hda4/FYXs8hhB75tck4ypJhgNicq8ZHaM3tZDhRaJw?=
 =?us-ascii?Q?Fteh+3Sg0jQ9Unava0MS2OWznGX2VlZcLNO/XuGhkVUhEXmAD0F6E7U3Fu5l?=
 =?us-ascii?Q?j1FhbXMx6q2aL3KzSN9lyRb1fDcMfNE1efscC6HoUqaaNxmc6bLDAwodU1KY?=
 =?us-ascii?Q?7hN6+ZGmdrGk5C8l1mvJQ/P19KqIIqWXXx0ZUD6DSK59gN9D2rgThndNCA9d?=
 =?us-ascii?Q?we8lyfvrGFWAfAauDNT2vHTsRwFclLs4RMRR1P4b6nfjhi1SdTwWwfihiOGK?=
 =?us-ascii?Q?jk1eQFgQa1s8lF+PwTgHpTcs/KpOXu5DgRGI9GC5i2LHIU94u/qyZ7XPQAGF?=
 =?us-ascii?Q?dxkcuFdZfHcYUrPd9Q238fgf1JSzWsk67411NKxcwNmAdhUVj7ytE6NzUJSm?=
 =?us-ascii?Q?43tuJoDis90rcvtLPuEdgjtgAIPzSjmyWNueGJrdm+dyrsWFFAdLLpw0u3Ry?=
 =?us-ascii?Q?/mjMaO+OqXCKug3MfXD0NA3qcn2OT0MOIAdjGelom07rHwrP931UuYB2XYVX?=
 =?us-ascii?Q?sO/k16wuX9Er0SB3l3b+fJM00/8MmOagYrGniDySA1flFyBr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: oLEkVsuWqYqMmLYZNKzJO6tE7HpQzfO3aDn6maSWxmDg++Yo3EUsa6EwdCnZ5FoY49ki1lJERalVNHB6z807p7D3x1dMaLSOv/tS6JV/UjXkGfYN2zz5eZBdMZOOgHX8QFAFOalwiH2YwYJGfS2K6qrj2L2lQJEn+U+9+bB1/mwh00pK4cPPqwPNQnxl7pVmt9s+gGl7fHbjmnLSY24En+JSwQMLrGTNSulg75aLhrmcdQLX3/UAcQ+emDPP7sSMLRz4WkTprPIdnR9nLLP2KMAUEYPi7PvipS8jf+ydZZ8RHPsdBKNQ/qNx03s5Vp8Ns61yCaNOs3uxW5ZLgXiB5Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b82a59b-f0c4-4c88-92b4-08df04d1a0a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2026 06:57:29.9533 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XgHkpNEEPmkRcnZJwMpNSJe2lU9yz0YJ0vAaFIsb9FaxfPat1zqf/Qq4W9l0t40VhfH3qGxrlqcIcuGMohP19A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7725
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
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of P=
awel Dembicki
> Sent: 18 July 2026 22:26
> To: netdev@vger.kernel.org
> Cc: Pawel Dembicki <paweldembicki@gmail.com>; Nguyen, Anthony L <anthony.=
l.nguyen@intel.com>; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; An=
drew Lunn <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; E=
ric Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo =
Abeni <pabeni@redhat.com>; intel-wired-lan@lists.osuosl.org; linux-kernel@v=
ger.kernel.org
> Subject: [Intel-wired-lan] [PATCH net-next 2/2] igb: read SFP module EEPR=
OM through igb_read_sfp_data_byte
>
> igb_get_module_info() and igb_get_module_eeprom() use igb_read_phy_reg_i2=
c(), which accesses the external PHY register space.
> On designs with an external SGMII PHY this returns PHY register contents =
instead of the SFP module EEPROM requested by ethtool -m.
>
> Use igb_read_sfp_data_byte() for module EEPROM reads. The legacy ethtool =
module EEPROM offset space maps directly to the I210 I2CCMD module address =
space: offsets 0x000-0x0ff address the SFP base EEPROM and offsets 0x100-0x=
1ff address the diagnostics EEPROM.
>=20
> Assisted-by: Codex:GPT-5
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> ---
> drivers/net/ethernet/intel/igb/igb_ethtool.c | 40 ++++++--------------
> 1 file changed, 12 insertions(+), 28 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
