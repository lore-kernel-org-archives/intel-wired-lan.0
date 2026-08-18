Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44D73C5DF7E
	for <intel-wired-lan@archiver.kernel.org>; Tue, 18 Aug 2026 10:25:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E01B680F15;
	Tue, 18 Aug 2026 10:25:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SEWIN7Rx37ny; Tue, 18 Aug 2026 10:25:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 40CEB80F0B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787048702;
	bh=nwaTXbZP9IgeWhQMcVwVDBnuMWLmnzRay7bmtSd1FEE=;
	h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mdZZAH3f7RAk7XhJCxF7NIa7zkXpeQ+qF6FhxqIfTaJ7u7vAuCkPlEnIsgv/HK5fg
	 ozrAsyZvpEt8/Zq92NgrLHu0AeIxD5j7dRKD5Oy6nufLZVL+7DWFUSarD/4Jrx+DN/
	 8KO1ENvAUbQnQ/BxtHfS0KuXqU6bOQ8C43bJRk+HnxdL9WxhKra0oQdnM011oRiTCm
	 JscKJ9W+kCVtG4n+ab1vjjdzLnI0lBFlQp7wgqAQLY7Jty20wtGGhtwzuBvLMpEuUo
	 A090ZxLvIPcZC5Ev8mXG9wvHL6arc7PZbwQ49mwBGEEo006Hhua4Fx6y/DDOTgss5w
	 84J/Pc52AaQTQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 40CEB80F0B;
	Tue, 18 Aug 2026 10:25:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4EA32333
 for <intel-wired-lan@lists.osuosl.org>; Tue, 18 Aug 2026 10:25:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4034260878
 for <intel-wired-lan@lists.osuosl.org>; Tue, 18 Aug 2026 10:25:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ISUpC_Wixnlj for <intel-wired-lan@lists.osuosl.org>;
 Tue, 18 Aug 2026 10:25:00 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.9;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 25EB360645
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 25EB360645
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=gETdVfvg
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 25EB360645
 for <intel-wired-lan@lists.osuosl.org>; Tue, 18 Aug 2026 10:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787048701; x=1818584701;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ihuEEw7ltwxt3se37K7KTc+EydpOAS2wnUYh9QbIAN8=;
 b=gETdVfvg8a7eH4Hwb3G5sVBxhJOVUvfjnJe6knEcIQfKwzFiAMMzzmXD
 i626/1LaH7in0Md15WkrC24xMAWZzQjFZ3OfI/19Zf9yD9qwmPJpRhkJ6
 fqqqRggylZpW75QmkhH+VdI/lrYIiM/KqImsSb2w9D6XNLPrmG8r8TkaA
 Ua++9lJDn8lRwqmbiKhMWNjxdAzaKsMSYFFbFhRdfbX8USiP8Mvtnu84W
 X6vJIkbD5iyfMvcrKKiykHDbxwFWIH0FIsA2HW488CrJnjtSpZ1WoOeKC
 5jHN6YjGP8ghGM1CSGAZx43Pf8ydsCGMMqIEvAJarYoiHnT5i992hAjO3 A==;
X-CSE-ConnectionGUID: yb1+C9W9RAWr9cXp2dr3AA==
X-CSE-MsgGUID: LdLiUOJ2QOCYS54jxc6h/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="110323171"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="110323171"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 03:25:00 -0700
X-CSE-ConnectionGUID: 0xM0YUOlQbWA/G8wojxjiw==
X-CSE-MsgGUID: oNEpyj6ARAapZEWZ6kD0IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="269494226"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 03:24:59 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 18 Aug 2026 03:24:58 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 18 Aug 2026 03:24:58 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.57) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 18 Aug 2026 03:24:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JBdtWkf/9Ib+KM5p3EoBchfLkLgr+Gh3pNkHwXhlVH/4Z9Q9D75s8r3NAWOAi4mPK/++h/jWc/WsmRxeNncRZMFC/wPFl1ZVvSWxtUIBXL6dJl4uIAcCe2l3ILnm6FCyvR2QwycMnfyFvgBNe+4PWUUBGvKdpnSVqN9nhGlji1VF6cmpAM+nSbDV97b4y9fq9nutQI2BpXRvYEud6CRBmDKiVtWP6jij4BDewFA/abTe0tSSrsmdoeoWH6wr95bJKZpUhEceBCNz6P1u5w4no0xHCJCeUSGC7fkWcjkOm5UDpSHUwGTUlswHr5paGxyXg2PxGdtGfM3mpD8AgBTzbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nwaTXbZP9IgeWhQMcVwVDBnuMWLmnzRay7bmtSd1FEE=;
 b=tyl81dx5ZTSkGqdxTlVW0adfghMgdLGtLJ3bw7PVG9IJ7onwPnuILW5VnWMoZ2bKd/icjcGS/7LM1L8R1KrBZu0k8oQCmcGlvGWDm22lZRhvQPD81Wopz4uGSTcI8nguAFHjoYUJJBWARqDVXCVTKlOKAdcz5MWKTggFtpvaWUPkcWDqXLS7TqBQ+6thvN3yR94WgzPwNpPHuKllzX6/xv4tQiPpaWec2Q6/vvhGa/fh8Gvz8nSHrZA1UzV+5avxTWP62/sA2nVg9fxzi9RXW0prxXCNPlMolBJo6c57FcsHqrzFGQegg0gpn/Imy1oZ4sG0YIH57ROKHnCLEt2nqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SABPR11MB9938.namprd11.prod.outlook.com (2603:10b6:806:4ee::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 10:24:56 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 10:24:55 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Shivani Gupta <shivani07g@gmail.com>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Simon Horman
 <horms@kernel.org>, Alessio Igor Bogani <alessio.bogani@elettra.eu>
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net] igb: Reject hwtstamp requests
 when PTP is unavailable
Thread-Index: AQHdLlzx8olbICj1P0esppdeHK+iXbajmtXg
Date: Tue, 18 Aug 2026 10:24:55 +0000
Message-ID: <IA3PR11MB898650266A215A004F63927AE5A62@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260815010815.91898-1-shivani07g@gmail.com>
In-Reply-To: <20260815010815.91898-1-shivani07g@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SABPR11MB9938:EE_
x-ms-office365-filtering-correlation-id: 6b47fbbf-3f5d-41a4-fe37-08defd12f2c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|7416014|376014|10067099003|56012099006|6133799003|22082099003|18002099003|11063799006|38070700021;
x-microsoft-antispam-message-info: Lpk5E7hI7Dwm5xKpey2Rd4KxxrsjalDkMVdFPcpyArtOdFNR/Df6H/rJAB8z2kTQhGLG0gyx32gpdPx+s7OX3iJqWI7mA4FYQDaU1k2eZj1KLzyLJbu1ckXPQi+xF8tHcYWufcSrBIoHMxebse9buaWoH0DJZJqUFUSoFzjS+5hWJBRP2QVnB0vrwMQLt6B+gdIdAUdDX2rBVma/9C5eUjxW1sJ2/OF72/hfejr8Rj7I6kEndK5ZzCMo2c1/2DFmodkcB60y56SPZPGxNYgh7SLd2m1iBHdS0tAStqQKlvOAzXqb60hpfbUeg1K6iu70sWktFOEudqVk+b9PUkj9/+Zhbav4svIExkTpj3A6tND8MrTdR1nG8umac9ZIdC5SatgANK1gpm05aVNRnRZW72gpP3kWVTP3ngJWVS2GQKiOvk+LoqXpbPs/IRVpVuR+c9U5GJK5p2P7n+cCZS9uITzhVzTAgItW6N2QvMGZcYdsPiG+CuC7Edc6fTf2HKDagIGaYkOIAHUpDQEUhAkyhgov4f4rwrcXM4n24CSxvc6sDUx3YoPIvFz4a3u+zp8Vn7dSbhQ1aBjZ+bIShzzIgmHsYnseGJ+8APWlYt+LmtMvQDfS3a3H4a6ueZSstzJ6RsfbFIO3C9tSARsYan+EW3aOFOlonzVzMVch6fqgSbJYa77U0VoKtBzacvFsb95OJf1+nZ3lNQ7gUOPSOIBqRfki7mOglK8k6tf8G2ZfgUw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(11063799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8yAR8/cjxl/tBoz6lUTANg7hq7HPkHyuUeJvAWzqTT7ud8ShT9qOjhEaV+gU?=
 =?us-ascii?Q?ohsHsKfVZbC4zC/BxXlByfTgQtNOqzNT1JQpuPvOaat66/2bSrUHjPXVrUHq?=
 =?us-ascii?Q?s98rIOiHFuTsfpUNV4Tz22091IbDAomZvCO5HLqZcm3RUaEdQYQPKagX952O?=
 =?us-ascii?Q?S5h1NLCS5yDdvJqdD0GJGI+6dEmJHiRXfM8bbr/t6r/0+x53oX3kiuQ6Gsgs?=
 =?us-ascii?Q?ciovtP320SVx5X+kuyK80kuL+F3xVUaiiVNE1D/fXnmH4o2i7TqGPR8CHgIn?=
 =?us-ascii?Q?YteXh3VXzHJTy+mgge1JlLRFamiSEAdg7S3UbtG+0bw18OCXfXVhHCcsBAbd?=
 =?us-ascii?Q?2F2Ioul/DhiKx/Bkg8ASMM6KHFkfwwLTSXrUzwXj/uIQr7lVcMH9Cy4iA9Tr?=
 =?us-ascii?Q?Wx08v9d+r/YwlDzNGTxA4FQ6Vcgj2ZrRhh6c1t7Bhpmz7O8H0GTRCkJps5kT?=
 =?us-ascii?Q?B2m1Ir0KjY/5ldi75aKeCvXA3VZcyXL/L7yQDJ9C406nn6wPIL2Shm14Gfn5?=
 =?us-ascii?Q?lGKhsPfl07XFqr088HW4dRugaT0RO0HIMF/uy83o9dPFKUHrojIytHrPMARo?=
 =?us-ascii?Q?IL53oHmj8eLpMxPy2206rMLa33UbrF7g+kDSgbKo/1ulSm1kFhZnAZOZKSUc?=
 =?us-ascii?Q?jmvMv0qPGf1/lG59Ixkaoy4XHsL+Opx96goc8Z5vB2dee3WgUbcpPy5z8EiJ?=
 =?us-ascii?Q?n5nM+Tsam2tva+Wo0fJu+2Lxg3rtNyyqwyIzdtRtiEDui968X0C+2+Z5Exel?=
 =?us-ascii?Q?HF7NAUIWgghAJY7B2N+FoWdw81SV7Oz077ltq0xGdPZwniQWkr3wdfw4Pkk/?=
 =?us-ascii?Q?zWHbXtFe/HkVgrTd+lzQGEee6EA7vP0RrqDzvv54NaGik8aM1VTDyMzYKGPq?=
 =?us-ascii?Q?K0YubQcc2/E7q9mQkxioMRQlY4Nsb37yFWnbNc2GXCw0M/J9ap/C+taqNiSj?=
 =?us-ascii?Q?3m97LKoYpLgLjXcxosIePNZ1tr+vBF7rzJwzrX2F6hvkRO0Xur76POuw2D6M?=
 =?us-ascii?Q?lARtnI7k3GJe4UY0qGmNNKsqEdDw8miiqIl2WrXDwZuNbZqsJTNE+mHihxgU?=
 =?us-ascii?Q?f7ioZqo3sI9tNkrmdzrTdhsdV4yCo3+BBLmUnUrSS8U9M8FFiXB+VKG9Pbfw?=
 =?us-ascii?Q?a7NJnMHaCqXjqr4CHagepkkAbtA/sH2tYUSC9F3IB6u20RznLMJ4kxdP6s/T?=
 =?us-ascii?Q?q7Xauu8tgCr9Uk2YAH90SNHmNDmSR7RfCyJrsagESKpFCSFZOXi12X3/xbbp?=
 =?us-ascii?Q?oWm4fA7Nu0i02VzSy8wX6pcSqynoCgh2kc+xU3HglbQGFgqO/nJ8xmkxgHpD?=
 =?us-ascii?Q?xS29w98xGs1Arf/x/D8OrBCbAi/6zjOFhVq5A4cL43ugFbZCNSqhEmjmctRS?=
 =?us-ascii?Q?9q1zh4slE+rZ72IsAh7vcKXGyWoBsDNuCbn896hFpd5gurNRmtGnUHlnz8ls?=
 =?us-ascii?Q?/ILurkXEGiywrsPEG07vxVafhX1IuClUaJPOlYzKj2+4+AR1AW+f+7m4uZGc?=
 =?us-ascii?Q?ablTd/Tq5VnkgZOgoUG0WVCmAGRgjYHii+jkbayMnp5h4HLM1Nid5rLUxgul?=
 =?us-ascii?Q?nGtaS393gkUZAYgxD5xvpoM+YSiQReQUPm+avtfqEQLT0YY1JqSW0NxeRCot?=
 =?us-ascii?Q?43dgHPFW1S2OJfwVp+USCDgD3auGvhiZGaTpzcvrXKjVTd1ZOnyfPjj8VcCk?=
 =?us-ascii?Q?ByXXSUKLq9/rNpVb01mJvWsESY8HQM2E09UFgArJod2hw8dS/Rzxf/VR1O7p?=
 =?us-ascii?Q?2bOLPlwC6NWnvDIuOQFoLNvO5NC4mhM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: cTvoYUlCCsLbs+Zh3M0lQpASJck49piSgIM8k9RI4SIAlevkV3j5xfc5sfjr3lJcW9LS9ZuGdm8dJG3G5GSruGS74nwuE0qVY6pFuH7nR6hVz3MyThnHV974Hbh+B53kcJs7uVWM7LSaU3ke/w0DlxCN0RTusuUkyltjka7NuiX0jmBF0DTjWUdGQJQ7q4bnp1QW4o6mmcUA763/i5BVSNTvhYIFJEg3l5khRNaXA37gE/BKzIAIkdyFARWqHFDKgTQYOsi7ZU91qc02Gg0DZVp9EugvLu8r1JmXL1w3cvOvnSqLl+PBxfab3/OOtmdG+SzGxaZuRVvXYk1INaj2Fw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b47fbbf-3f5d-41a4-fe37-08defd12f2c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2026 10:24:55.7416 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /jaT3PbDJE2mWVBRA585lFj2yVrB6cDJxhXQuo0+Qb/9w36Ga76zsJDpZu1MkxE3+8uNGGKSBH4jv/PIKbnC6pmt0gXKUq5bQ2l/PhV7/nY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SABPR11MB9938
X-OriginatorOrg: intel.com
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] igb: Reject hwtstamp requests
 when PTP is unavailable
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
> Of Shivani Gupta
> Sent: Saturday, August 15, 2026 3:08 AM
> To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Richard Cochran <richardcochran@gmail.com>;
> Simon Horman <horms@kernel.org>; Alessio Igor Bogani
> <alessio.bogani@elettra.eu>
> Subject: [Intel-wired-lan] [PATCH iwl-net] igb: Reject hwtstamp
> requests when PTP is unavailable
>=20
> IGB depends on PTP_1588_CLOCK_OPTIONAL, so ptp_clock_register() can
> return NULL when PTP is compiled out and can fail at runtime.
>=20
> Commit b888c510f7b3 ("igb: Avoid starting unnecessary workqueues")
> moved the PTP locks, work items, timestamp configuration, and clock
> reset behind successful clock registration. The netdev is already
> registered when igb_ptp_init() runs, however, and the hwtstamp entry
> points were not gated on registration. On 82576 a TX timestamp request
> can therefore schedule a never-initialized ptp_tx_work.
>=20
> Initialize the passive PTP state and hardware clock before registering
> the PHC. INIT_WORK() and INIT_DELAYED_WORK() do not queue any work;
> the overflow work is started only after registration succeeds. This
> also ensures that PHC callbacks and the netdev timestamping paths
> never observe partially initialized state.
>=20
> Reject hwtstamp get and set requests with -EOPNOTSUPP while no PTP
> clock is registered, and advertise software timestamping only in that
> state.
> Successful registration retains the existing behavior on 82576, 82580,
> i350, i354, i210, and i211. On 82575, an OFF request that was
> previously accepted as a no-op now reports that hardware timestamping
> is unsupported.
>=20
> Reproduced with CONFIG_IGB=3Dy and CONFIG_PTP_1588_CLOCK=3Dn on the QEMU
> 82576 model: SIOCSHWTSTAMP(HWTSTAMP_TX_ON) followed by a hardware
> timestamp request warned in __queue_work() before this change and
> returns EOPNOTSUPP afterwards.
>=20
> Fixes: b888c510f7b3 ("igb: Avoid starting unnecessary workqueues")
> Signed-off-by: Shivani Gupta <shivani07g@gmail.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_ethtool.c |  9 +++++
>  drivers/net/ethernet/intel/igb/igb_ptp.c     | 40 ++++++++++++++-----
> -
>  2 files changed, 38 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c
> b/drivers/net/ethernet/intel/igb/igb_ethtool.c
> index f7938c1da835..4ebd447117cc 100644
> --- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
> +++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
> @@ -2396,6 +2396,15 @@ static int igb_get_ts_info(struct net_device
> *dev,
>  	case e1000_i354:
>  	case e1000_i210:
>  	case e1000_i211:
> +		/* No PTP clock, no hardware timestamping. Advertise
> what
> +		 * igb_ptp_hwtstamp_set() will actually accept.
> +		 */
> +		if (!(adapter->ptp_flags & IGB_PTP_ENABLED)) {
> +			info->so_timestamping =3D
> +				SOF_TIMESTAMPING_TX_SOFTWARE;
> +			return 0;
> +		}
> +
>  		info->so_timestamping =3D
>  			SOF_TIMESTAMPING_TX_SOFTWARE |
>  			SOF_TIMESTAMPING_TX_HARDWARE |
> diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c
> b/drivers/net/ethernet/intel/igb/igb_ptp.c
> index 638d8242b66b..01992a73b37b 100644
> --- a/drivers/net/ethernet/intel/igb/igb_ptp.c
> +++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
> @@ -1104,6 +1104,9 @@ int igb_ptp_hwtstamp_get(struct net_device
> *netdev,  {
>  	struct igb_adapter *adapter =3D netdev_priv(netdev);
>=20
> +	if (!(adapter->ptp_flags & IGB_PTP_ENABLED))
> +		return -EOPNOTSUPP;
> +
>  	*config =3D adapter->tstamp_config;
>=20
>  	return 0;
> @@ -1285,6 +1288,9 @@ int igb_ptp_hwtstamp_set(struct net_device
> *netdev,
>  	struct igb_adapter *adapter =3D netdev_priv(netdev);
>  	int err;
>=20
> +	if (!(adapter->ptp_flags & IGB_PTP_ENABLED))
> +		return -EOPNOTSUPP;
> +
>  	err =3D igb_ptp_set_timestamp_mode(adapter, config);
>  	if (err)
>  		return err;
> @@ -1378,6 +1384,25 @@ void igb_ptp_init(struct igb_adapter *adapter)
>  		return;
>  	}
>=20
> +	/* Initialize all state used by the PHC and timestamping paths
> before
> +	 * registering either interface. INIT_WORK() only initializes
> the work
> +	 * item; no work is queued until timestamping is enabled.
> +	 */
> +	spin_lock_init(&adapter->tmreg_lock);
> +	INIT_WORK(&adapter->ptp_tx_work, igb_ptp_tx_work);
> +
> +	if (adapter->ptp_flags & IGB_PTP_OVERFLOW_CHECK)
> +		INIT_DELAYED_WORK(&adapter->ptp_overflow_work,
> +				  igb_ptp_overflow_check);
> +
> +	adapter->tstamp_config.rx_filter =3D HWTSTAMP_FILTER_NONE;
> +	adapter->tstamp_config.tx_type =3D HWTSTAMP_TX_OFF;
> +
> +	/* Initialize the hardware clock before ptp_clock_register()
> makes its
> +	 * callbacks visible. The overflow work is started after
> registration.
> +	 */
> +	igb_ptp_reset(adapter);
> +
>  	adapter->ptp_clock =3D ptp_clock_register(&adapter->ptp_caps,
>  						&adapter->pdev->dev);
>  	if (IS_ERR(adapter->ptp_clock)) {
> @@ -1388,17 +1413,9 @@ void igb_ptp_init(struct igb_adapter *adapter)
>  			 adapter->netdev->name);
>  		adapter->ptp_flags |=3D IGB_PTP_ENABLED;
>=20
> -		spin_lock_init(&adapter->tmreg_lock);
> -		INIT_WORK(&adapter->ptp_tx_work, igb_ptp_tx_work);
> -
>  		if (adapter->ptp_flags & IGB_PTP_OVERFLOW_CHECK)
> -			INIT_DELAYED_WORK(&adapter->ptp_overflow_work,
> -					  igb_ptp_overflow_check);
> -
> -		adapter->tstamp_config.rx_filter =3D HWTSTAMP_FILTER_NONE;
> -		adapter->tstamp_config.tx_type =3D HWTSTAMP_TX_OFF;
> -
> -		igb_ptp_reset(adapter);
> +			schedule_delayed_work(&adapter-
> >ptp_overflow_work,
> +					      IGB_SYSTIM_OVERFLOW_PERIOD);
>  	}
>  }
>=20
> @@ -1513,7 +1530,8 @@ void igb_ptp_reset(struct igb_adapter *adapter)
>=20
>  	wrfl();
>=20
> -	if (adapter->ptp_flags & IGB_PTP_OVERFLOW_CHECK)
> +	if ((adapter->ptp_flags & IGB_PTP_ENABLED) &&
> +	    (adapter->ptp_flags & IGB_PTP_OVERFLOW_CHECK))
>  		schedule_delayed_work(&adapter->ptp_overflow_work,
>  				      IGB_SYSTIM_OVERFLOW_PERIOD);
>  }


Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
