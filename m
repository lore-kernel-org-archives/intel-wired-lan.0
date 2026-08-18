Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4223EC5DF70
	for <intel-wired-lan@archiver.kernel.org>; Tue, 18 Aug 2026 10:38:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EB22B80E25;
	Tue, 18 Aug 2026 10:38:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aB666ZWxL38S; Tue, 18 Aug 2026 10:38:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BF2E880EB5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787049486;
	bh=1u4sZ6Xw9rT5cC8pqzoR4vhjim77PQCgmxLFG+LyZnE=;
	h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=orex5dPaGwKqo7GGgfyJQijDIB4CuOZNLNk4Xa30J0b8GjeYKqlymQkDKVJvAHic3
	 YHDNyjB9nqyiir0y/xIIW5q6oyMkVyXDMOwzY6KmS8SpUsZuUfbj7JU8Xe8dVH4gcd
	 GyVIWKcADh1ARrqtWfZn7Tuj7TZ2Azw7/ocggMvILL1cQDqRfa5+KDUHRvdlwwZW7u
	 sFwhhYisnC8uqdimfuY9NEhoaZKnh/l/TjJWpV2gcLJn37WOTINnR+OprMYd/Wdh5m
	 qyJeI025qVUnxiYuYjhlhIlCaW+A1GomawjrlS0Aj2O6gAHUsudXM82UiHHFEAaS5O
	 UZ/lKuBGLoc0Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BF2E880EB5;
	Tue, 18 Aug 2026 10:38:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 61490194
 for <intel-wired-lan@lists.osuosl.org>; Tue, 18 Aug 2026 10:38:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 539F66071F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 18 Aug 2026 10:38:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sQbSsXU4lhIZ for <intel-wired-lan@lists.osuosl.org>;
 Tue, 18 Aug 2026 10:38:05 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.9;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 824FE605E0
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 824FE605E0
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=VUlKaSaf
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 824FE605E0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 18 Aug 2026 10:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787049485; x=1818585485;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=8P1wwjRd09LrkwRZxctKNgZ8L5o8JTX4QOVexRE/53Y=;
 b=VUlKaSafpLC7vDUwGAnbDnopP/Jv1ur0tOKi0KN12QBJZSlKVMAmFsYF
 8cWx77fRcPUjJLhKEe0cNuVLMcwRyjSLoo0lgvnTRmks84jAMkr3PNw/m
 9Cp2M6ISvNKGl7y+62djG9TgmSrGrSVzu4vmPBWdbWHLmNR8mP9QZBC0Q
 H9Pu/W7VoLy+k6Eg5D3L7h0M8w3PXCFPyVDb5wZOo6emcq26ydS8OBh+8
 wx1xsNFxdUYM6hMb5tFJQUhsGmfqx/4ULTQK2zKZNVMFLtagmexIpSYqW
 702XdnpexFZe+PWHDRVTnHN+UWwnQxag1lhyeBUNf04e1Ao+r4dmQ2Son g==;
X-CSE-ConnectionGUID: 1pa/faS6Sh2ggFqeOQUnbA==
X-CSE-MsgGUID: 893FlLezT266iK3wruEqHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="98204532"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="98204532"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 03:38:04 -0700
X-CSE-ConnectionGUID: GSaqtj3PSceOE3CNTgspvQ==
X-CSE-MsgGUID: z9u9z+dkRzO/sPunTMrhWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="270408287"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 03:38:04 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 18 Aug 2026 03:38:03 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 18 Aug 2026 03:38:03 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.60) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 18 Aug 2026 03:38:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lCN7VGflIzFU/prNEDmJFngo3VEnSxausdzPLSit5nSvkgZKk1HyQ900IUv/TfvWaacB3w9zeETdOj/VaQvu92J9dCVKXB8jfaWnDSA8qavmfsv/D+ppjPEwJeSksKyqncv2yCUjICBkefU1bIWH7mUF2/6Lkn5lt0irqKIN3Toi7B7nK98AvJzlVMGuQMVxduIyupOouYS8SeP+EchhRuwGTv/aLDU+JVKLihNdkZwcMPNXIswj6fUdfe3JboO8DI2Ayt1BBesNye2s3PBNaueuh8aefk1AMRz8A7qmTThv+N8jNkv/CH3ieFHgpK7tgwD4W6+wmtUOMn8sTmAm4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1u4sZ6Xw9rT5cC8pqzoR4vhjim77PQCgmxLFG+LyZnE=;
 b=izqYFd4cneYlikXA7LiTFbqs4saUo/AZ0bAD34JovaAkH71m3a/FoL5ahwptkswa2VfoY2JYPtyk1tbaLgkIgOvHxuWnAzYMDJBdLU5xBwTjFwhCiDZvekhSR5/vOlwKyN7/rsVSdXyPLt+fTEFBWZJRCSLeziU4tvT73AWT2ChMdOpGf8PoH2A0GgBWMgBXK36zKus+97NgzPdzqF150KCWYQM8iW8bfC8RSIw9bQCZXuSYpjRDUe0uX+m2FVCGeNiYzigl3Ygiv0yihR8O0c66Gpuhr8ACsDZnRnHKkms0+QBtUTu2mAumXMsadKDIalY2OZO/+AMjJfZJr9VeqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SJ1PR11MB6225.namprd11.prod.outlook.com (2603:10b6:a03:45c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 10:38:00 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 10:38:00 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Stanislav Fomichev <sdf.kernel@gmail.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
 <edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "saeedm@nvidia.com" <saeedm@nvidia.com>,
 "tariqt@nvidia.com" <tariqt@nvidia.com>, "mbloch@nvidia.com"
 <mbloch@nvidia.com>, "maxime.chevallier@bootlin.com"
 <maxime.chevallier@bootlin.com>, "mcoquelin.stm32@gmail.com"
 <mcoquelin.stm32@gmail.com>, "alexandre.torgue@foss.st.com"
 <alexandre.torgue@foss.st.com>, "Lobakin, Aleksander"
 <aleksander.lobakin@intel.com>, "horms@kernel.org" <horms@kernel.org>,
 "Karlsson, Magnus" <magnus.karlsson@intel.com>, "Fijalkowski, Maciej"
 <maciej.fijalkowski@intel.com>, "sdf@fomichev.me" <sdf@fomichev.me>,
 "ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net"
 <daniel@iogearbox.net>, "hawk@kernel.org" <hawk@kernel.org>,
 "john.fastabend@gmail.com" <john.fastabend@gmail.com>, "witu@nvidia.com"
 <witu@nvidia.com>, "martin.lau@kernel.org" <martin.lau@kernel.org>, "Song,
 Yoong Siang" <yoong.siang.song@intel.com>, "G Thomas, Rohan"
 <rohan.g.thomas@intel.com>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com"
 <linux-stm32@st-md-mailman.stormreply.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "bpf@vger.kernel.org"
 <bpf@vger.kernel.org>, "leon@kernel.org" <leon@kernel.org>
Thread-Topic: [Intel-wired-lan] [PATCH net v2 3/3] net: stmmac: skip
 queueMaxSDU check for AF_XDP
Thread-Index: AQHdK1c06XfjrYSIkESOiZKw1LkOvbajpHHQ
Date: Tue, 18 Aug 2026 10:38:00 +0000
Message-ID: <IA3PR11MB89868E697B08DE8977FCA9AEE5A62@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260813190800.222527-1-sdf@fomichev.me>
 <20260813190800.222527-4-sdf@fomichev.me>
In-Reply-To: <20260813190800.222527-4-sdf@fomichev.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SJ1PR11MB6225:EE_
x-ms-office365-filtering-correlation-id: 5c4adbe8-fa63-4755-4324-08defd14c690
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|7416014|376014|56012099006|38070700021|11063799006|4143699003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: zFiIsmINcnLjvAUujPHcpwh7AWIlUlvkZl3ATyGMvljumItuMixGiKgda6sJF/goWFThxgaku+T3v7eeokOI8KzdZ2ReiodlFvXuYOCJLHT0ryPaE9hqFZtNkAEJuTqYtBwqn33uCjHG+Y61iF5RCQ/wIed9PKoYZkfELKL/5M9xN3EMlzgjLum7y5T8DYYMuAvQBHuo4zsWMECIgN+9pDEvnB1pC012Ibq+WiLxP5mI1TaAtBRj8ao/bPmi4VqMr4r6x8jrQix7dGDCLDWzd7M9avb11mVkeixV4QXHcvBhaoY2MtqDJ1GkDXeTbhB1wkylpaWfQUaJ9R7lJrCBdE+akAeRpPfe33sSK2i7iAThQQUiQsgT34M+C76jUEM/beJpRxoU27324bIZeJaK427VGaIUu6JtjjUHfmIquQtvZamNhJP8irquV9+Nw6vC/dLRRjv2AwHV50Fx+F8MiVcOrMbxuwh2jgSnUarbRvAJJVOEoR+9KaN6zvOLa13u0aHdKJTIMMdpAtOYX5CWLxKaYihSG4GQL1Okms/DskFhY1SMos1Eo1qC53+jO8B0a4QXzv3vjJxjxCu+MPO6IYAGdL3X3sCUpG2Z7brp4YMNuNeHe1J7MmZxKzWVNVDJgLRLbxtqSchN7vG71GZqxbGwNh6o1uu7XCyw3jXYd+fJKgDl8k5Qvdq2HTE0dPSTcfdy5aTet/2DFiQk+95Oh8HuCAH57GG33NV8klmlmPw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(56012099006)(38070700021)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sAXtvJ8s/qskFquQtEj0ZG88FuCqtuUNOY2e3+i/BcMNu7hyFTRVmX4IWKTL?=
 =?us-ascii?Q?S8Wx5xj+Bm5gNTD8IXhIq5mvgu0OREkudxbAkppuMB3LycO6OQRVRWXD8Zp5?=
 =?us-ascii?Q?qMYsi/95MQI00DNmMvPIYMpHJ72b1u7o1QOrXDAkop7AucuXe3F3RYzBEWCR?=
 =?us-ascii?Q?3N9emP1UMV6JwIapVaRPGu7U8/aefdmmx9BtOfSfZu/P/Myt1Hf7+hpaBHal?=
 =?us-ascii?Q?BZfO9yYefjQv/vFSNLn9HOsfcnenDRr7bRdNbPomhODs+1zNvCRRevqocadp?=
 =?us-ascii?Q?U1VjYxM3VBuk0nsen8l0MBLR2wGtv9jS9U9EhqWZ+H+5Qudb0Ttn1ff7ozJf?=
 =?us-ascii?Q?lEo+LP0vCShWAhqh9XbL3pIVFOfi3W3fSidEwYVBxPEC+JUwOCwR2foyc0T0?=
 =?us-ascii?Q?u46r3yB4v3eE4lgBBGqBLEwUVbkM5e7fbdPNDaBtDrf5l/e/fbo+IJmz8gAH?=
 =?us-ascii?Q?FhlngJ73iTmgBj8xzQm8Pu6ET7hZftJ8icibpXnBvWZxQVs+hasqWqVo5c3a?=
 =?us-ascii?Q?SMGOpKUz0j7aisHjLLPHikVkf5I2veyDQBcii8EAYqCweL8/7eDmQ5UWKShQ?=
 =?us-ascii?Q?B0ZQia+zNHaYgC/FZUDpcT2c/SAjXKUxZ1VDbJgoNQ0XrCqr3r1mn3idpFZg?=
 =?us-ascii?Q?lNkp5stcOJJ93B4JvehsAWbZTr1Ip20bq64GzKkPNaKzrfq+5or2eAaQjs9M?=
 =?us-ascii?Q?DPh4Kn34yabwxvnIzlWlA7vyjwTXUEHAhEyMUimz1nqbmTcB6lIfk6V/0nGa?=
 =?us-ascii?Q?K12WwhAHwCmTW0HIKWy99FgsGsBSR/E7w3CSDERF3+fTzN7TsRpEs10vmDIL?=
 =?us-ascii?Q?fMVkTIQJyQoQpRZXEqQlV7Sd5ffJIUAYdrHQYLAQzfZYfxkPRsb6hiVs7JAe?=
 =?us-ascii?Q?2+uDQ/OOl6vVZcsm2fmoLz5ngEcFJ5G8+X3ThrqM9wkM24sdlH3H83ECdlew?=
 =?us-ascii?Q?VJF3kB8WHfSgTDWXtu/ki2tpocagsvaS6WpIPWEzBzC0yFT6RgnKofhmqwhr?=
 =?us-ascii?Q?5GMIpKQvJkSPZsZvx1IuCJFbekWolUh6cPrVpb6ZbZ6+/04EAJvBGVCLNNGd?=
 =?us-ascii?Q?/xwXIX1se95EnkqktxRRmf5OvftpCbZIaGQUebh09QAXi1h+hR0X9UHzrUdd?=
 =?us-ascii?Q?wPm9apdXLgRrHGAQ4CjGAFJ6JD6aG3JQmAAIkCP5ybfUvHGfxv3jjT76VOaQ?=
 =?us-ascii?Q?3lbtNQppkIDCJUV2Z5mwdrmSH12inLODANgFnU/dRKcfis/ts43T6ZbEXtyz?=
 =?us-ascii?Q?SkEGlfBLEJzzQj1a/wzUxvBVUlBBqoYX1YFDIYqUaOxO3H1aMmhTCslIpr2d?=
 =?us-ascii?Q?FPMEghmPKtyphsbHGiYjhVrltU2ak28ZhmH0oEBufw50SxzQvRYz5ibcqA1Q?=
 =?us-ascii?Q?UKPUeVyFlFrovlVEgcAONoFQ1z4LURqjXiLae21oh1JU3ni/H0mPxeVp8NPn?=
 =?us-ascii?Q?wBiBvBzZlL6gFAWUuOJVtpFMKKCvpbgrE/xbGkMykZ75eV948x4W0johOYBg?=
 =?us-ascii?Q?pP4O7iAB7AvYFmtLf2ZhmCA/bKNfPETE/quXZhEjZ3PbkrqA1XF7gY2K3f9v?=
 =?us-ascii?Q?8PmOoIQ0LvUvKaBANyyojlawSEXu7l+h1/JL4jnk/MqHrv9KBL5/XxSgx6Pl?=
 =?us-ascii?Q?HKGINSaMX1jphAaBwLdpX4MX0Of6dgLE62cjpYM8Lwr/JLvvyNuxsyuipusk?=
 =?us-ascii?Q?U5SNf9xCPWjgjEAq/za7OZ4Uiz2rmWrMsOmHs36tnk2vVapgikZ1Iy/FmYSl?=
 =?us-ascii?Q?9hKe3JV2XAM8IQNDWVy4GHw6jAa1YpM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ZhGk/WGWtrZdq89CCr6tggeMOnrheqROH2DEFcfp4Y2fLB1psOwETceRTjXfbaTINuwV582L7HXkZqFGdnaqSywgVXrophDkb7uNC87TklxTOBLanOpOLZEJkhiNe6cyiietb2m94dhtDNw5uWoVJrp7UXsmsMFDkeY1jClF9+0IH2Ei3vSbEuGK5ceejJQyZNrR6YlMHXt0zWYzmHe3blQEh2P7BRSyT81VuvpHh8Sex+qnl3f9H72VPap8MOkw4gk6WwRIZthoegFdGPUscjt3cCkKDZ4G6gbPFcEuv9ma7lIXprjVI9HErf1qOvn/K8HJxVuSdW//nk/EPxGqHA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c4adbe8-fa63-4755-4324-08defd14c690
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2026 10:38:00.5096 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cuuO1R4A/OsGl3VuLVT5Pc7fbhm019jTZxrG0UEsjp3WqsL41Yur3bvzmGN4O9nudTQeItTRtKoPaTHtkMAlqLRUcfBwixUiCLNJ6GABrKA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6225
X-OriginatorOrg: intel.com
Subject: Re: [Intel-wired-lan] [PATCH net v2 3/3] net: stmmac: skip
 queueMaxSDU check for AF_XDP
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
> Of Stanislav Fomichev
> Sent: Thursday, August 13, 2026 9:08 PM
> To: netdev@vger.kernel.org
> Cc: davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; Nguyen, Anthony L <anthony.l.nguyen@intel.com>;
> Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>;
> andrew+netdev@lunn.ch; saeedm@nvidia.com; tariqt@nvidia.com;
> mbloch@nvidia.com; maxime.chevallier@bootlin.com;
> mcoquelin.stm32@gmail.com; alexandre.torgue@foss.st.com; Lobakin,
> Aleksander <aleksander.lobakin@intel.com>; horms@kernel.org; Karlsson,
> Magnus <magnus.karlsson@intel.com>; Fijalkowski, Maciej
> <maciej.fijalkowski@intel.com>; sdf@fomichev.me; ast@kernel.org;
> daniel@iogearbox.net; hawk@kernel.org; john.fastabend@gmail.com;
> witu@nvidia.com; martin.lau@kernel.org; Song, Yoong Siang
> <yoong.siang.song@intel.com>; G Thomas, Rohan
> <rohan.g.thomas@intel.com>; intel-wired-lan@lists.osuosl.org; linux-
> kernel@vger.kernel.org; linux-rdma@vger.kernel.org; linux-stm32@st-md-
> mailman.stormreply.com; linux-arm-kernel@lists.infradead.org;
> bpf@vger.kernel.org; leon@kernel.org
> Subject: [Intel-wired-lan] [PATCH net v2 3/3] net: stmmac: skip
> queueMaxSDU check for AF_XDP
>=20
> Commit c5c3e1bfc9e0 ("net: stmmac: Offload queueMaxSDU from tc-
> taprio") was inspired by commit 92a0dcb8427d ("igc: offload queue max
> SDU from tc-taprio"), but the igc change does not apply the check to
> AF_XDP.
>=20
> xsk_tx_peek_desc() reserves a completion entry. Continuing without
> queuing or completing the descriptor leaves the AF_XDP rings
> imbalanced, so remove the check from the zero-copy path.
>=20
> The assumptions is that AF_XDP zero-copy traffic bypasses the qdisc,
' The assumptions is' -> ' The assumption is'

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

> so taprio's queueMaxSDU check does not apply to this path.
>=20
> Fixes: c5c3e1bfc9e0 ("net: stmmac: Offload queueMaxSDU from tc-
> taprio")
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 7 -------
>  1 file changed, 7 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 62de03e65a90..4a82f4351303 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -2710,13 +2710,6 @@ static bool stmmac_xdp_xmit_zc(struct
> stmmac_priv *priv, u32 queue, u32 budget)
>  		if (!xsk_tx_peek_desc(pool, &xdp_desc))
>  			break;
>=20
> -		if (priv->est && priv->est->enable &&
> -		    priv->est->max_sdu[queue] &&
> -		    xdp_desc.len > priv->est->max_sdu[queue]) {
> -			priv->xstats.max_sdu_txq_drop[queue]++;
> -			continue;
> -		}
> -
>  		tx_desc =3D stmmac_get_tx_desc(priv, tx_q, entry);
>  		dma_addr =3D xsk_buff_raw_get_dma(pool, xdp_desc.addr);
>  		meta =3D xsk_buff_get_metadata(pool, xdp_desc.addr,
> --
> 2.53.0-Meta

