Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B88C5DF97
	for <intel-wired-lan@archiver.kernel.org>; Sat, 22 Aug 2026 04:19:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F3BFE606C7;
	Sat, 22 Aug 2026 04:19:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rpFrDpEfnUlI; Sat, 22 Aug 2026 04:19:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787372367;
	bh=DL77IpUxmp0na2TTsphEXnASykOGyEB7xU6p8tRHr+k=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RrdiIQav3c3mddDK/zUFID3n2hAgoxkMgwp8NfsKHxCxSgVmCwpjTUoc7Wajma9kU
	 WK7Z1CXBUGaPcHWIr7GQm6C+Ob9a6rZ9ENiaqFlZhEeknkbuvHY/Q90BGZ8kbJ79Ai
	 tYNsuqr/NiWhFaAWHRBKqg4Q2TxJGBhW19SpXC1kskMQrxcXCQ4x/gmJox6t0O0f3p
	 neHNbnbT5A7NBmQSNI43yn7Q1SwVdIwjScumspflUysEhxz/j3QJsU8CygR8eH7aLf
	 qy+BlogKo8Xaay94Fbmz7gYKHk5arZz1AiohkVHHqy9lx5dDze+e2M01NXPQpk20a8
	 m/oL/DSrgYy3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CC31E60679;
	Sat, 22 Aug 2026 04:19:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E8B78476
 for <intel-wired-lan@lists.osuosl.org>; Sat, 22 Aug 2026 04:19:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DAEB7409BB
 for <intel-wired-lan@lists.osuosl.org>; Sat, 22 Aug 2026 04:19:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VW1x0wnTLG04 for <intel-wired-lan@lists.osuosl.org>;
 Sat, 22 Aug 2026 04:19:24 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.21;
 helo=mgamail.intel.com; envelope-from=alexander.nowlin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=dvizI/Qo
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D9308409C3
 for <intel-wired-lan@lists.osuosl.org>; Sat, 22 Aug 2026 04:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787372364; x=1818908364;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=DL77IpUxmp0na2TTsphEXnASykOGyEB7xU6p8tRHr+k=;
 b=dvizI/QoSLOBqkNEbvxcOddoTga5D9rV3OlJ1HdVx09xK4JdyNihUtzr
 n7+OSAY3OuLIAVLXl/utsTzoTAXl5pHE93bm54lgygohrbNao66iVHYDf
 MblFD9BeVJk2merek62Vbwv/fzwhdS1uiX6TU5VP73xOi2pJPbO+OKujA
 5Djf2S3MVDlIqBariyY1ix8GCOt+PLgLahVP9xyhjlEXFMOAXYPXHE7YJ
 Y82WTpw6PIYoM7FmiHataCfYugjCTxSyqACqqEXqQ1bRARcSmQ504458w
 /3GRCwSCHcgklPAeIpH2Qunon4P8VDpF8PRZluxjJzTCsDjr4v+V33WVK g==;
X-CSE-ConnectionGUID: PO7Pc9XTQtWtvL2iqLr0Lw==
X-CSE-MsgGUID: JETSMzAQTqytRpfefDSJFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="87775158"
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; d="scan'208";a="87775158"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2026 21:19:23 -0700
X-CSE-ConnectionGUID: d96jZzrQTWqNUyd/WpREqw==
X-CSE-MsgGUID: lkOj+phGQdmmGrkwe6PTUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; d="scan'208";a="263247178"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2026 21:19:22 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 21 Aug 2026 21:19:22 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 21 Aug 2026 21:19:22 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.2) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 21 Aug 2026 21:19:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F1tBGzdg9jhkycTz3EcZ+faMTRSXI9SMe45DBP3oAZtfvGA/wdkMAj7uiRejDtOCIDd/7GtUYrySY6fN8PEenO9LLHbea3nWbvJqRPbUZ33q5ZTsSClLHpTcU9v0AO/8+e6jPOc96OxeD68ZyTOjv13yd8K0o/KIHUY29ulEmS4nsi1j+CYWlMEahdcCyxJ55sv4Qwxsu++vCbmGi1LY7G2HyDJcAvBXwJmOESBM55XT9EmuYGcl9V7La5TMKnY7WRhBWVLAWmbZu2+/MzxIXz8Da+COPPPiJ6rIBAEjeLHkruOvWIbK5BlOcoyb9OKXGcrHOMYKNCEMp0KEnxNajA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DL77IpUxmp0na2TTsphEXnASykOGyEB7xU6p8tRHr+k=;
 b=tKpsYaeCX+vXEavsa0ScBI65tcvBmWj6lVPbk2Lv0yhoSy3kZCz3Q1b+JlSypIoS3yvyEf3HRlbQakEZO/N/8C0eyv3m/MsIFwCcZktuvrT1orzT2ffbbiKO3NLiTtv5cdLa+vdKydzxEKgBkCV9cyn0lIh0xql12fXPNXr2Zh+VpH56xcJjMl5wmHKdv8GWSZiHLIdBZbfLTaJQMf6ErYy+wcOBlaBZfnzE2DOf0ITmDvfLZqbvES2YH4NYabVNBwm3nUlI/uuJjkMPMMeyMxo3nIICiqDDu9Z0gUCjipE7vPcI2qbZKRfyymluHKvXcwqWlxMGbRTwuZ1YLHhE/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by IA3PR11MB992400.namprd11.prod.outlook.com (2603:10b6:208:61e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Sat, 22 Aug
 2026 04:19:15 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0315.014; Sat, 22 Aug 2026
 04:19:15 +0000
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
Subject: RE: [PATCH iwl-net 10/12] ice: remove unnecessary discarding of
 timestamps after clock adjust
Thread-Topic: [PATCH iwl-net 10/12] ice: remove unnecessary discarding of
 timestamps after clock adjust
Thread-Index: AQHdMctLDAYw/tWxNEqu4hxZq6iVO7apdv4w
Date: Sat, 22 Aug 2026 04:19:15 +0000
Message-ID: <LV1PR11MB8790FF9C2F5E25ED3E804E2D90A22@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260821-jk-e825c-minimized-fixes-v1-0-9d0731eb4858@intel.com>
 <20260821-jk-e825c-minimized-fixes-v1-10-9d0731eb4858@intel.com>
In-Reply-To: <20260821-jk-e825c-minimized-fixes-v1-10-9d0731eb4858@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|IA3PR11MB992400:EE_
x-ms-office365-filtering-correlation-id: 0507e987-b976-4d02-1a11-08df000486ea
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|56012099006|11063799006|38070700021|4143699003|10067099003;
x-microsoft-antispam-message-info: Zng91W8R8muQywlH8CBaLRzoGyYXiJszHnE+FT5I9ZJu/si3q3tjqwtPTneuRFKlrxDL2FSbPDDzD5hm5E6qtR2b3T0oymdtjSqsTVtUMBw7DVMAnrDu70EZSWrXHw/Ov6PGpZS3zuihsktI8S9kgQzj6bTWw8Un72xtYVqq0taLQuiaxCJv0ZAwuVytfgZS6Bgqmn3cotFpy5WBB3tvCkANA+dQfQ+PeG0s+fiky9/hCmtET1OPKFc2TgZqRvfKJ8Ytze6FriSIa1L3rZb9Qp5t4IY8ePBH96BXZgd2zcqNU4oL06w5Bg3bdwvy3pq83wWM+xUFJdqMqGh/bLDtnpkrJAM4DcsY86s2lkkCrfLPqmgJdI0xyhutB6RjzPn0NCrlcUxYByFC+tOGlIbyQ0KmUBjVPQ7i7IWaPncbbTx4yRC6xQaGCR87F8Km+Ip9+znPwUhFxubaBMQKMP5TdPFIjjH91nNcKa59N4puTdttUF4oX2bUMKM+XyVrcaXutDA4fBIaFCdmdJkBdGQ5+JYJDom1jB0MuVtvD8xxiYtkold7JH9J611cPTqFv4bclCPRuPFy8yuOP35A9gBcFNdvR9sf7XCeY2aEU7ZVVP2lOx31ANfUNOh2DgX6gzvlBeu4kbE52RUINhArAjI1Hn13NwRQT9uorIXrcS85cB272i4lIl6+PZyDYSQjeOVGPhRH6BQIc2AWqjGmbgfb98BKH87qCSZzS4FWm5EnTN4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV1PR11MB8790.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099006)(11063799006)(38070700021)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0xhVkNUTjFYTWNsdXB4QmU3bFZRd0lEOVNvSGtIZUI1aEM5bS80TGpMRjZn?=
 =?utf-8?B?VjhLNGNIcVZPYmNFZjFHRUt3cWlob3RhOXRtMGEwRWo0N2IwZ1lGaUpMT0Vv?=
 =?utf-8?B?M2IvTHlRQy8xeGlqOXlpTVVkRmovR1MvcEI0TmZFZnBUTzdPdXpidFMxQnAv?=
 =?utf-8?B?eVlzWkRUbTFYOEtrTFhxU3ZIaTlqaklGbmtXVEdtRldNZGJYbFM4TUEwZUhM?=
 =?utf-8?B?S1h4b2pnT1NiVUxXTmFod2xML2lHNWh1Ny9GdTZwUm13MkdYQnlWRjljQ2VM?=
 =?utf-8?B?RE1UMWc1QTdRYjRPRE9SNWlPYkJSOW8vTStIZGVxRVdwdzZIdG84NFdWYUJL?=
 =?utf-8?B?REx5b3FwOWZ6dStaWDRYdUp0MEFmRW9hWWd4YzNZQ3RnZ3pwQWZUSVdhUk1o?=
 =?utf-8?B?c0w3emluL1hKaHlETDBjSHN6VEpqQlRwbVU0aXFrZ0RtN1g3ODFoTXFLRVJI?=
 =?utf-8?B?QWVnaTZHc3R5U2tFejhuRkdCQ2JCWkt4MjJDU0U3cGVSMFRDUVhGY0wwMC95?=
 =?utf-8?B?aU5MMnhTZCtYV0t1ZjhaU2RhcHZzbnFJdEVDN3doa3RiM3ZOTURlMGlqWnE4?=
 =?utf-8?B?T3M2N2QvVHNLU1FOdFVkNWNPVmNTaEM2b2tWQ056MXhNYmdJZkY1MVhITU1O?=
 =?utf-8?B?alhaYWt6di9TYVpQczZvU2J3TVgxbHl3M2h0dDBaTmlRcjRrNzZjbVZLZWpn?=
 =?utf-8?B?QzAzc0Z3L3Z0UHExLzJTc1FNa0t3ZE9veURES0JkSHZSMWt1dGRISnVvSnNX?=
 =?utf-8?B?Z0t5SzlkNzhGODFicXlPRDdHVEU0clZDSXcvQlVOSXZUV3pjNE5IZ0o2NTFV?=
 =?utf-8?B?TWhxRk1taHdwMXV1OUFHZnJwMEdVeTYzcDVSeC8zVllraXF0SlFUM1k3Vjlw?=
 =?utf-8?B?ZGlHWlZURTJiaWdseEkwUzFSWnd1UERJOE00WWRUNGtWa1NvcG84YVZiWitZ?=
 =?utf-8?B?a2UvUXc3U2VzOUJtM016anJ1aGxUSTNLdnJDMjdmbm42SkhxbnVWNCtkSmcr?=
 =?utf-8?B?Ty9td0lxUnZsY2RSU3VSdjVEU3JjRkhYbEdyRHVkWHl1ZFo5eDA2V1FlSVMv?=
 =?utf-8?B?Tkorc0VuSHIwb3dBOHRzOXQyMU9acHpUK3NjMVRoKzNQNmlUTkNCUWVRcFIw?=
 =?utf-8?B?ZEtPYTF2N3dqK3lmdW1HbVB1M1Z6emhVdnpDYXoxei95Q2lhK0F1SW45ZnlC?=
 =?utf-8?B?cW9mekx6UUljS2FOaHlvYWdzTmRjNE43Wk4xSS9Xdkt6MFo1OGNtMUVyMVlo?=
 =?utf-8?B?dmw5VHU2c2ZaNVFDOWZXRVNta1B6OFNyRVgvdzhLdGdySU04WktqYkE1L2hr?=
 =?utf-8?B?REZ5OUJBU0M4L3ZXOGVoeDZMT2pzYVpJbTlEZkhSUTh1WEpmOWJvczh0eHZI?=
 =?utf-8?B?bzBoN09OTmVTM1dqek9GanBtKzZqY1plbFh3STFROGQydEZwQTFxWk8xQ2da?=
 =?utf-8?B?QzM3NlV6NTNBQVBSaEEvNzkvV25obTlUa2lmTk9aL1FMb2Z2NW1JYXg5NHp2?=
 =?utf-8?B?cnloWEgwRStpM051RlZZT0xKMzBIeWJhVEpvQWE2ZTJMOHhJZys0TkV5bXZz?=
 =?utf-8?B?ZHoxWlRldDJpZXJ1ekU3VVJHMTY0aWFINW9RYTdMUGQxdkErS05KWGVlMERl?=
 =?utf-8?B?WWdvVnRETDVxTHUwbGpsVnF5QmlySmJVeTBxRkV1c2hlODI1b3ltVkxGM3Zr?=
 =?utf-8?B?U0ZWMzJZR1RadHdaYmt5NTBjeEtUWDdkSVgwUmpJNmlFWm1aRGU4Wm5ENWU1?=
 =?utf-8?B?NlZ5SThRQnltaDZhQVdmT2gvL1hBdEt5VEhsZUlGMDlQRTFheUd1QndoWTVG?=
 =?utf-8?B?YkkvOHVkUWQ2R3dHS09zMmovOVdIQVVjQUVsb0RDczVodmE3Q1BWK1R2KzFM?=
 =?utf-8?B?SkFpcTlab1YvWUFiTHRVOXBJYXJUNXA5U1FsclFVWWR5QjE2eFkzc1kyM3Uz?=
 =?utf-8?B?RndtcHduWlBZNmRVVHVZdHNZQTJPQkFpM0lkbUxmSE8zV0Z6NURZVEpBaHhx?=
 =?utf-8?B?TzNxVkRXTWpnVi9BcVhYaEhKZDM3OXlwaTNjcjNBZFR2Yk52enZmcm41ekF6?=
 =?utf-8?B?Nm1uMVlDU0grZGR3RHNvYXFXSTkwOURyN3I3QWFzYXVKNVZWdzNwU1ZqT0tm?=
 =?utf-8?B?Wm84bkZrU0hlOFp3V2ZkbHNEQVd4c0RmM0gyWGtaV2M0U3UxRnpkN1h3bWdh?=
 =?utf-8?B?SzFNb3NUaTl4bzh0aVRmMlFWa0F5Wk5rdWNnRWJ1T1Q5QTlNMkhrRHMvQkxi?=
 =?utf-8?B?L1pXMG1TUDVTeHBDNG1oRkRscWZXN3hoeTFIZ3RxSjJBaGVtcnlBRWJ0VnNq?=
 =?utf-8?B?dkVVREpyc1lPcDh0RUFwU2t5R29RR2NoL2ZoV2NybGh3R3pIdnJ4dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: UEHjSK18xAjf47sacE807zA1lAPcWlcLhC2D5qetWMevoOOw0F0QqXnBNwEOxqhQjLqqqRrdAAFDYtYU41KHSYfwNwW/K2IQn/0bi12gIiuB/aU3AO77slr/PUvts9ghsUF1mYgIrXgqz8JhP9Yo+UHaG5I9AAn0hmnYSOOLCVXsGyOgSF5yC6A2B8e/45kiTFTxqQ8W8lqnGwyHcrYDwnUtbi6KLLO+t0+YgKh2hEZGfo/h1w4d6imYjNSnI4DU4k6FKUZeTSHerfY9kjw/E96drd4FeW1Ry0D8o+qtmJI/lH6/5fitpyrdpVAwIHAb94Z2y/JlRXHNqMAksCmPUg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0507e987-b976-4d02-1a11-08df000486ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2026 04:19:15.2723 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yZhi6Um8XGMZ/XYDpZgWls7izFbW9BgO9Z7SIFG1dw3SuOsiKZ+oktXT2hyD+9amSN6fnJLaQvkjKHEP21G7hk4gc4mlPhbNm8wg1YgyatM=
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
d2wtbmV0IDEwLzEyXSBpY2U6IHJlbW92ZSB1bm5lY2Vzc2FyeSBkaXNjYXJkaW5nIG9mIHRpbWVz
dGFtcHMgYWZ0ZXIgY2xvY2sgYWRqdXN0DQo+IA0KPiBUaGUgaWNlIGRyaXZlciBjdXJyZW50bHkg
ZGlzY2FyZHMgYW55IG91dHN0YW5kaW5nIHRpbWVzdGFtcHMgdGhhdCBhcmUgaGFwcGVuaW5nIHZl
cnkgbmVhciB0byBhIC5hZGp0aW1lIG9yIC5zZXR0aW1lIGNhbGxiYWNrLiBUaGlzIHdhcyBvcmln
aW5hbGx5IGFkZCBieSBjb21taXQgZDQwZmQ2MDA5MzMyICgiaWNlOiBoYW5kbGUgZmx1c2hpbmcg
c3RhbGUgVHggdGltZXN0YW1wcyBpbiBpY2VfcHRwX3R4X3RzdGFtcCIpLg0KPiANCj4gVGhlIG9y
aWdpbmFsIG1vdGl2YXRpb24gZm9yIGRpc2NhcmRpbmcgdGltZXN0YW1wcyB3YXMgdGhhdCBleHRl
bmRpbmcgYW4gb2xkIHRpbWVzdGFtcCB1c2luZyB0aGUgbmV3IGNhY2hlZCB2YWx1ZSBvZiBQSEMg
d2FzIGEgcHJvYmxlbSwgYXMgaXQgY291bGQgcHJvZHVjZSBpbmNvcnJlY3QgcmVzdWx0cy4gVGhl
IGNoYW5nZSBkaWQgbm90IGRlc2NyaWJlIHdoYXQgPiBzdWNoICJpbmNvcnJlY3QgcmVzdWx0cyIg
d2VyZS4NCj4gDQo+IFRoZXJlIGFyZSBubyBzdWNoIGluY29ycmVjdCByZXN1bHRzLiBFeHRlbmRp
bmcgdGhlIDMyIGJpdCB0aW1lc3RhbXAgd2l0aCB0aGUgbmV3IHRpbWUgdmFsdWUganVzdCBtZWFu
cyB0aGF0IHRoZSB0aW1lc3RhbXAgaXMgcmVwb3J0ZWQgaW4gdGVybXMgb2YgdGhlIG5ld2x5IHVw
ZGF0ZWQgYW5kIGFkanVzdGVkIHN5c3RlbSBjbG9jay4gVGhpcyB3b24ndCBwcm9kdWNlIGluY29y
cmVjdCByZXN1bHRzIG9yIHByb2JsZW1hdGljIHRpbWVzdGFtcHMgdG8gYXBwbGljYXRpb25zLiBF
aXRoZXIgdGhlIHRpbWVzdGFtcCB3aWxsIGJlIGV4dGVuZGVkIHdpdGggdGhlIHZhbHVlIG9mIHRo
ZSBQSEMganVzdCBwcmlvciB0byB0aGUgdGltZSBhZGp1c3RtZW50IChpZiB0aGUgdGltZXN0YW1w
IGNvbXBsZXRlcyBwcmlvciB0byB0aGUgYWRqdXN0IGNhbGxiYWNrKSwgb3IgaXQgd2lsbCBiZSBl
eHRlbmRlZCB1c2luZyB0aGUgbmV3IFBIQyB2YWx1ZSBhZnRlciB0aGUgYWRqdXN0bWVudC4gSW4g
ZWl0aGVyIGNhc2UsIHRoZSByZXN1bHRpbmcgZXh0ZW5kZWQgdGltZXN0YW1wIHZhbHVlIG1ha2Vz
IHNlbnNlLg0KPiANCj4gVGhlIHRpbWVzdGFtcCBleHRlbnNpb24gbG9naWMgaXMgdmVyeSBzaW1p
bGFyIHRvIHRoZSBsb2dpYyBmb3VuZCBpbiB0aW1lY291bnRlcl9jeWMydGltZSwgdGhlIHByaW1h
cnkgZGlmZmVyZW5jZSBiZWluZyB0aGF0IHRoZSBpY2UgaGFyZHdhcmUgbWFpbnRhaW5zIHRoZSBm
dWxsIDY0IGJpdHMgb2YgbmFub3NlY29uZHMgaW4gdGhlIE1BQyByYXRoZXIgdGhhbiBiZWluZyBt
YWludGFpbmVkIHB1cmVseSBieSBzb2Z0d2FyZSBhcyBpbiB0aGUgdGltZWNvdW50ZXIgY2FzZS4N
Cj4gDQo+IEluZGVlZCwgSSBjb3VsZG4ndCBmaW5kIGFuIGV4YW1wbGUgb2YgYSBkcml2ZXIgdXNp
bmcgdGltZWNvdW50ZXJfY3ljMnRpbWUgd2hpY2ggZG9lcyBkaXNjYXJkIHRpbWVzdGFtcHMgdGhh
dCBvY2N1ciBuZWFyYnkgYSB0aW1lIGFkanVzdG1lbnQuIFRoZSBpY2UgZHJpdmVyIGJlaGF2aW9y
IG9mIGRpc2NhcmRpbmcgc3VjaCB0aW1lc3RhbXBzIGp1c3QgcmVzdWx0cyA+IGluIGZhaWx1cmUg
dG8gZGVsaXZlciBhIFR4IHRpbWVzdGFtcCB0byB1c2Vyc3BhY2UsIHJlc3VsdGluZyBpbiBhcHBs
aWNhdGlvbnMgc3VjaCBhcyBwdHA0bCB0byB0aW1lb3V0IGFuZCBlbnRlciBhIGZhdWx0IHN0YXRl
LiBSZXBvcnRpbmcgdGhlIGV4dGVuZGVkIHRpbWVzdGFtcCBiYXNlZCBvbiB0aGUgdXBkYXRlZCBQ
SEMgdmFsdWUgaXNuJ3QgcHJvZHVjaW5nICJnYXJiYWdlIiByZXN1bHRzLCBhbmQgZG9lc24ndCBs
ZWFkIHRvIGluY29ycmVjdCBiZWhhdmlvci4NCj4gDQo+IFRoaXMgZWZmZWN0aXZlbHkgcmV2ZXJ0
cyBjb21taXQgZDQwZmQ2MDA5MzMyICgiaWNlOiBoYW5kbGUgZmx1c2hpbmcgc3RhbGUgVHggdGlt
ZXN0YW1wcyBpbiBpY2VfcHRwX3R4X3RzdGFtcCIpLiBIb3dldmVyLCB0aGUgc3RhbGUgbG9naWMg
cmVtYWlucywgYXMgd2Ugbm93IHVzZSBpdCB0byBpbmZvcm0gdGhlIGRyaXZlciB0byBkcm9wIHRp
bWVzdGFtcHMgd2hpY2ggPiBtaWdodCBmYWlsIGR1ZSB0byBsaW5rIGRvd24uDQo+IA0KPiBGaXhl
czogZDQwZmQ2MDA5MzMyICgiaWNlOiBoYW5kbGUgZmx1c2hpbmcgc3RhbGUgVHggdGltZXN0YW1w
cyBpbiBpY2VfcHRwX3R4X3RzdGFtcCIpDQo+IFNpZ25lZC1vZmYtYnk6IEphY29iIEtlbGxlciA8
amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPg0KPiBSZXZpZXdlZC1ieTogTWFjaWVrIE1hY2huaWtv
d3NraSA8bWFjaWVqLm1hY2huaWtvd3NraUBpbnRlbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9u
ZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9wdHAuYyB8IDE3ICsrKystLS0tLS0tLS0tLS0tDQo+
ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxMyBkZWxldGlvbnMoLSkNCg0KVGVz
dGVkLWJ5OiBBbGV4YW5kZXIgTm93bGluIDxhbGV4YW5kZXIubm93bGluQGludGVsLmNvbT4NCg==
