Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AF4BC61DE8
	for <intel-wired-lan@archiver.kernel.org>; Mon, 31 Aug 2026 05:55:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1C2704054D;
	Mon, 31 Aug 2026 05:55:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cQq5veuRk_N9; Mon, 31 Aug 2026 05:55:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788155707;
	bh=4LhLowcjceiBOleNX3vMjuY1OAZiNdOE8dnPp3LdqSU=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NlI38K6EQCky/VZaPLvOhZT71mLgdube+DrcXSN3j3XpaWwJyIkeWgRKfr/duKSj9
	 Vx6zuStgRtW1SDbCxjpeU71kIqUBQhgcpLFOCu8k6bGJPNmPJMfdx19jU/uO8T7YHO
	 r8gspTrWofT7CIGfV2oPRu/rqsdIZDltc2pR5yFmjllFJoWIzr89mUXM5Iehoj/mex
	 BJgnPLjpOtbgOl/A7ZSxzYaB4Avg4u/181QkVxM3gu96BNjcYPmvhADhw7knnWZox9
	 xbB00Q1vk7LxftO/lk0/WFDF7CRNgX+d8FO+KaMGXU8IjwTHrkHePu8QGYLTao4NFi
	 ovOKYnoVrzAIw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C91FD40301;
	Mon, 31 Aug 2026 05:55:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 80501355
 for <intel-wired-lan@lists.osuosl.org>; Mon, 31 Aug 2026 05:55:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 718E740073
 for <intel-wired-lan@lists.osuosl.org>; Mon, 31 Aug 2026 05:55:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E4TQRznj7bAX for <intel-wired-lan@lists.osuosl.org>;
 Mon, 31 Aug 2026 05:55:05 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.12;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=gkZPg5dI
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A5EF64004C
 for <intel-wired-lan@lists.osuosl.org>; Mon, 31 Aug 2026 05:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788155706; x=1819691706;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=OpL2Y2lRNPBkayrOZ0xRpzHYewWgPgVd+GzgqOcVaS0=;
 b=gkZPg5dI1nsbsip8Ak1VkWUIvmUTNju2MauZvzvhH7QC8bTBBWWtInNu
 3vLTLOwzihm7vF8vH/AcvDhtkxdIoyJa43OV8iTDPCFQtx7FMu8TCAWbD
 oBR/PpuQB6Kms/hUkKOoTYnlRJVO6pQc006AvxnPjTAhqs+kO/6URYfhd
 8hgjdh63vSXveE4pV7M7VEts7QE+svdZWF/ze3mMSJwNe4gINJ3eNac4m
 4glPaHMEgr+eOuoeDuODuPSOYAh94PGIpo8WSAuJLvMOuBCIAc7xzrAN0
 KmVmKmnNa0OSs7ddxi4gspSIPT9ms0g+tx9IwxCf7HYfnFn4uzVxNRZLJ A==;
X-CSE-ConnectionGUID: NdfVH55+SIukXm9yqDkfOw==
X-CSE-MsgGUID: 3xUjk63uSHOKGAicSSwlJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="92363822"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; d="scan'208";a="92363822"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2026 22:55:04 -0700
X-CSE-ConnectionGUID: ID03gijoTtueWtXMz6vhSw==
X-CSE-MsgGUID: VbeDbNo7SmSGzfZRBWPXQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; d="scan'208";a="268136225"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2026 22:55:04 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sun, 30 Aug 2026 22:55:03 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Sun, 30 Aug 2026 22:55:03 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.8) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sun, 30 Aug 2026 22:55:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wWWDp6NqYEet5c00PSYn0Ska/dBnS3X/n52AyVeHPnds7P/i0tRT0wAHUJNxGW5FZ+Ifc1mFg1/qYa1URvdzTMSkoG8QbZPtsuFwgQgdSNmBUADbfc3f+2njAv76dVFBQY5ncW7YkQM7S9eTH2XLav5oG/OA2kKVrgQCDCoXwNpkaKZ478O8+4Jm+S9FWCthMlaLt46/6rId5NIWhXQ9imgtE4cILwaogv0QMf5WjoNFS289wZRQzEsDnPBsikOvKuA85BTajO+7K0+m5Oh4xhg0LQOQLsX2sn3Dgi4A06PW3nJDCptFQzwhCMPeRskhbjZD9KfrQMUP3z9416E5gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4LhLowcjceiBOleNX3vMjuY1OAZiNdOE8dnPp3LdqSU=;
 b=eXVeeCD9QjDCVBKJ3kHjmKDhBmImK+xawgz4P+flwM4xI2eweFWClqB7ZMpPaPIFi/UOCov5hirr8xz4YXSVPRGcn6GsrXWyJPATXR5XQ/dW7XMKURRiPEjbMkaMYugE5SOoSCPXrlDq1fsfJbmpMwrGLXpVNxujE/ozWW3AQrFoU8zq5xBycKERCXJ63Ts5CameYbPZBThVivxKRXV+4/fNyYY+49Qvur8ehu4DaYBO9MMkmc/u7SxZAWGskdIVQK3TOSWgYVLE3v5EVkIMJYspuuc/iNMo21pl0dT7N/3kav8QKXDou6e/Qsuak/5yXY/oEEUlcKB17TPINbhOTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DSVPR11MB9765.namprd11.prod.outlook.com (2603:10b6:8:351::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 05:54:55 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 05:54:55 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Matt Vollrath <tactii@gmail.com>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "Lobakin, Aleksander"
 <aleksander.lobakin@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH iwl-next 1/8] e1000e: add jumbo Rx CRC stripping
Thread-Topic: [PATCH iwl-next 1/8] e1000e: add jumbo Rx CRC stripping
Thread-Index: AQHdONZzI5p1SKTGpUCDhu0YiM0U5ra3qKEg
Date: Mon, 31 Aug 2026 05:54:54 +0000
Message-ID: <IA3PR11MB8986FC61317321A94128B4C6E5A92@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260830232146.36948-1-tactii@gmail.com>
 <20260830232146.36948-2-tactii@gmail.com>
In-Reply-To: <20260830232146.36948-2-tactii@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DSVPR11MB9765:EE_
x-ms-office365-filtering-correlation-id: fa8fe2fd-943f-485e-30c5-08df072461c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|7416014|38070700021|4143699003|10067099003|5023799004|11063799006|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: B37VMlX8sZ0Jxm3HYI2yO/YT5Smb019N6b1tPiDRTC3z5gYhBRNXE5YhE1jdQHHH2RncwSraI1Stl7yV2IwDmO7cQwV44MDQ1bOzfOLLnEPbaOcI/UyW/V4gAdmIGM92PzRtjDzY7YR945QwnzcnD905x5ZUAjmEKEP5EYqG3TM/9kk0AZv5m5jQJUp5kmFci4ymkNw7iju1Zp2UYhTFpFpmiZ7vkikBck6O75NHlNOrODdP0hSQCjH0dnZjpbiO6eBQPRIQJXCjfh+xmMqUSLBetN4Cx9rHF0DpL4/e8ge3btr26V2V/eE0ky8D60u9JeLHwGeOYUo8j1AtGH6vKq+MOX0xIociqhoR5iteJq89pCOAL/5P68jB+IUaDU9lWEhr1mCAEK1kveWmeqfBIS5CqTtWTakfZoLguIeXRg1oUeKXSnG6A97qSzFTyOpiKbSRwihrxOwagmekhUks4B4Xla1cAseGDP7cxrnx+N53knGy4Wkjc67oHKoHdPaogYdWpPmM+RzjgSB1lg4rAYO7QBM2IXRpXOm6UjLMzH/4s3hhAOaiSusIyqNt+43UX4zk+O5HUqiQvpeV4jaqA3qg7c/QMdhRMnYXBMhMlHYTqfo82YORkl0+ljqbRtGaX9NZZXP+HHovqWKmXYb88eYh2mO0cEga9HNO0Zc92Rjz7dWa7zbqihblVBVQK922le0iERPBkp0b+ZlLdMlZx8S9+NKCl98b+OqLs7UfJ64=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(38070700021)(4143699003)(10067099003)(5023799004)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?im/mLS05h+eUfvvFvgehc7kEW0dZX8rfZlIBE06YZY3WO9LB1yhihm16h36P?=
 =?us-ascii?Q?ALsSD4vEjWShBuluD8UrX4ZMbF+zu/30amUcehynpEZAEtKZFofR/MjHUOwq?=
 =?us-ascii?Q?wN0nFJ7EI7i9ySNIhuDnMuB5uVCFtwkkFaHzqyvjR9el4NZwWPZkyhZ0HFQQ?=
 =?us-ascii?Q?+rSsRaVULFnbEFuVHiAXib2Np9Mwx94Qo+V5iTV+EGbvRI79Yl5SmVVGRo+u?=
 =?us-ascii?Q?i38nHpde7dvYHSqAwFQGbzXbTT3wY2QWZyLICT9x1ik4LlZgrRyzbBf6EO5r?=
 =?us-ascii?Q?98BoVyqy6zQhhr3+K8ifVxdJRD/+5+gNsAuicwGFQLEFKEWNJQ/4n72XglDr?=
 =?us-ascii?Q?MCS5+bGkB8o6yCKt5rILh2NrDqiC1wdkTxTPKQJbE/r3fj3mqJAykzvodKeo?=
 =?us-ascii?Q?hFp0JdMmmNQ96sTcY2DfLwrBOx0iBZBCdH10UnAyWe/miVOme8jY1cn0HD7a?=
 =?us-ascii?Q?+xzD0PfuiHIFt/BxqsRm2HiIigoWwUB71GzVTaQxjGybjoH6Glvz/9frGxga?=
 =?us-ascii?Q?81556lPx6idIRUdbLYaiW37e9zs7pFdhtGPsGgGTaO1hTL1DcbNuhUa7G/Pt?=
 =?us-ascii?Q?FuHwByGxge3arl2hJReHZd6hnVSQul6uFzo0h3aYL2PQLziWv4mThX5vReo9?=
 =?us-ascii?Q?CuVLp7MuXOLbSk0PDjzOV0vAM5gEAmB4zklRi1/cmO9v6dqE/7CxAA/ZOfHf?=
 =?us-ascii?Q?BlNt+dy2A9NR9H44cgHKsZvuRTewdKLFoDdJtBlB+aqcvaxWi+ZlgYPO/u28?=
 =?us-ascii?Q?yePC3sxhXjqEACpkMASLVWKIv+Vrea8S57afENaWFMsn6EtwwXZwGvfd4NnX?=
 =?us-ascii?Q?7uaGWH72Xa/03Dn30d86lIEjO8T6bqWVECvCkKQ7g4X3zv6fNnfPjAeFE64i?=
 =?us-ascii?Q?HQXeB3MV6SF2BTIqGd0dIRf+2OyldWku0zT+HoTzQ6BfONxKgC03wW6HolQt?=
 =?us-ascii?Q?OUoDyJ7OmjSOS9y4nAHmh5xVTppm9JHYXJ973CtNI5VJsCq1+VSlJJ7sNXRJ?=
 =?us-ascii?Q?wLzfimkNcezjxpLj9a9mZ0MPUWTiibs/Hn41X3IOrU4Tdjlo+DDFgpJAE9+2?=
 =?us-ascii?Q?ArKotZp9Y5Hq6hslgvHJh7ASjEx+a8TJDfFl737rMG/EFW0kTOengw5NSOvz?=
 =?us-ascii?Q?i1KfuTAhs85TuhuY2BwtufBS4aG8nFW3Onqy3wmLiLc8DG9jKxEKiwVydxks?=
 =?us-ascii?Q?ok6yq2bhcBTD8q40Ck/FNKNtJbsUaxIF7sPTFmqJY+puKdtKNEmsqDEtbNJX?=
 =?us-ascii?Q?DfFZ4PDsbfWVJB0HPCEvEglIHi94OKLexfTbDtLjVXIV5ZSzItYFvx6Ikj6j?=
 =?us-ascii?Q?aR9q9xseEAPmaSgF07Gb/Y03rxsrQ0J2BBWiL/XtVfI/o5lKslOl5Fb94GGj?=
 =?us-ascii?Q?1+MT3xtDsodEgNYGjblgLiRPzzlTl+6ZTrK08ZZ0vTUQgpDrBoBBzlrXIalO?=
 =?us-ascii?Q?ZFFLbhH0Bh7SBXhC35ooQTXL+YA/xf5oXXCP3bWeQ2VFqHwu5koOGhYM6De6?=
 =?us-ascii?Q?lnECYQEzlQMOu8ABaFqxbo3RhP4Yml8PN7VMJidYTGrVbkvTF1SlYcRgh9a3?=
 =?us-ascii?Q?FAQ3YIiUCacu69tCH2IRL7wP8+eAVBscYlFD/bEABzz2LQjnWlBu3MQZ12ic?=
 =?us-ascii?Q?Pq0EufQ/MhBvgbttMQqwqJv7VIou4688/O4ZStjlA2h5PxIQqaPTbpMtn+NK?=
 =?us-ascii?Q?eNK3U04YZyGaTA1xtUoMrEWYBmkJddEeMqoEPLoJuyO78jJ0Ae0oNerk9hDc?=
 =?us-ascii?Q?a/KLXGdUH9AUxbXV2kOBtKCiXY2u2bo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 5imZQ4GMP4CgmnpFWSaiM5I68ChxWATVO2Bhx5k/UpHXLwFQm1uEbPUm3D2Qezfdd/ftBjFM8Jr6seYrnheFQ3fCec5wdw1D9k67qMUirdT75r+u377y078o7xKxWPRQy8jLLeJVjUZjE74g1PhINgyB9CgB38aoeC/fyyeEHcytVvBCsi8bRi7LJ18CM91XfON896+S9PIjSuNNt3QohAbypHAMk7X9ru/VbDimH107auVdeGNQEqOmORsRKeu8J4Imigzxt/Xn0OQYHz3wSEG7gFnspFuhbAvEGESsWFGafaUGEFPxBatasXht0p0l0+JSZnvM9upkRdRm1lwR3Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa8fe2fd-943f-485e-30c5-08df072461c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2026 05:54:54.9984 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lTHBRKg0tmuMhmbZozxKxu6tQ5HEtcfUMdobNwyr1KM4ySccYM/rzLfc+jRfvqlY3wugYP+tqSGPbqrAuF7bKB+fKXElxlq5teBqnq66A3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR11MB9765
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
> From: Matt Vollrath <tactii@gmail.com>
> Sent: Monday, August 31, 2026 1:22 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Lobakin, Aleksander
> <aleksander.lobakin@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> David S . Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Simon Horman <horms@kernel.org>; Jonathan Corbet
> <corbet@lwn.net>; Shuah Khan <skhan@linuxfoundation.org>; linux-
> doc@vger.kernel.org; linux-kernel@vger.kernel.org; Matt Vollrath
> <tactii@gmail.com>
> Subject: [PATCH iwl-next 1/8] e1000e: add jumbo Rx CRC stripping
>=20
> When the hardware is configured to not strip the FCS (CrcStripping=3D0),
> the jumbo Rx path would deliver frames with the FCS still attached.
> Follow the standard path's convention by stripping the FCS at EOP and
> leaving it out of the byte count.
>=20
> The jumbo path was omitted when the CrcStripping feature was added.
> Since v3.3[1], the jumbo path has only been used where the page size
> is over 16K, which practically rules out LOMs, BMC sideband, and the
> need to leave FCS on frames. The bug is only reachable only by setting
"only" is duplicated

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

> CrcStripping=3D0 on a platform with nothing that needs it.
>=20
> This change prepares for convergence of Rx onto the jumbo path in
> following patches. The set of h/w routed through this path will expand
> to include LOMs.
>=20
> [1] Commit 79d4e9087a6e ("e1000e: disable Early Receive DMA on ICH
> LOMs")
>=20
> Signed-off-by: Matt Vollrath <tactii@gmail.com>
> Fixes: eb7c3adb1ca9 ("e1000e: fix IPMI traffic")
> Assisted-by: Claude:claude-5-fable
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c
> b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 844f31ab37ad..599600ad695c 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -1631,13 +1631,23 @@ static bool e1000_clean_jumbo_rx_irq(struct
> e1000_ring *rx_ring, int *work_done,
>  			}
>  		}
>=20
> +		/* strip the Ethernet CRC; it may span fragments */
> +		if (!(adapter->flags2 & FLAG2_CRC_STRIPPING) &&
> +		    !(netdev->features & NETIF_F_RXFCS))
> +			pskb_trim(skb, skb->len - 4);
> +
>  		/* Receive Checksum Offload */
>  		e1000_rx_checksum(adapter, staterr, skb);
>=20
>  		e1000_rx_hash(netdev, rx_desc->wb.lower.hi_dword.rss,
> skb);
>=20
> -		/* probably a little skewed due to removing CRC */
>  		total_rx_bytes +=3D skb->len;
> +		/* If configured to store CRC, keep the FCS bytes out of
> the
> +		 * total_rx_bytes counter
> +		 */
> +		if (!(adapter->flags2 & FLAG2_CRC_STRIPPING) &&
> +		    (netdev->features & NETIF_F_RXFCS))
> +			total_rx_bytes -=3D 4;
>  		total_rx_packets++;
>=20
>  		/* eth type trans needs skb->data to point to something
> */
> --
> 2.43.0

