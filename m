Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E74C5B572
	for <intel-wired-lan@archiver.kernel.org>; Sat, 22 Aug 2026 04:11:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 47CA580F70;
	Sat, 22 Aug 2026 04:11:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eF80kuWcySvR; Sat, 22 Aug 2026 04:11:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787371902;
	bh=xwXYWKFyRDh9jjPg1tQiyyMIthnmJ2A26O5qPGsGC6Y=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oKCgstY6ZAEh+9gXxmmBzLh4W0isBzRJVafT0GSsvS/1zXtWZuC0c4TBVs/sqRKjC
	 7efqtGYAPRdWUc6rGt943YCh3fzqO4x/mrASD84MANv+fT+aPtdFVWvE0pLiF2CFQz
	 bTND1IpgwNClhKJaAScnbCwVz0e9cNfbupLjf5+ucc47awAPnxxxDtNoxjvYcLSs0G
	 /eUQbq4tBobZeibCrrkuoLjH1CDCsA0LOWZVijFBlLWJ9v6++j4kXiweJpA841oHaN
	 DmYU21ikONoAiQENTrv/htN87wQu5/f0hJkBzeFb1crUxQJMl5VDpu4LJev53ypLZ7
	 t+8ocFpW4jr2w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 62B8880F67;
	Sat, 22 Aug 2026 04:11:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A7C8D386
 for <intel-wired-lan@lists.osuosl.org>; Sat, 22 Aug 2026 04:11:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8E2E64013B
 for <intel-wired-lan@lists.osuosl.org>; Sat, 22 Aug 2026 04:11:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id brz3uF1_Tycm for <intel-wired-lan@lists.osuosl.org>;
 Sat, 22 Aug 2026 04:11:39 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=alexander.nowlin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=OzCPZqA6
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6B98F40097
 for <intel-wired-lan@lists.osuosl.org>; Sat, 22 Aug 2026 04:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787371899; x=1818907899;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=xwXYWKFyRDh9jjPg1tQiyyMIthnmJ2A26O5qPGsGC6Y=;
 b=OzCPZqA6O8lFwSMpCaWiYB7il3oAcJPaQ9H0tvyudd7amJgsch/ruuXG
 JkU73RNeKjZpt02jWJErA8ToxgYEddrv5nm/Y0+j6WLKK2D/aj39cnIVE
 saGKgZ4GUpvu+a4TVAynjQkI/1QItzR31xgsC+d2kAbQuFVoPK3ynV4Xl
 r86ra8KG2yzbU7Vq+1LvEwlp9AcRw0jf75EclljXajug2eg+wxI0fqIXJ
 yf2Dzg58c7vn7GjvBqBglo2VjhvTjZMvLZe3WwB14WUM9xPp+DFWdbN8k
 Il2k44wEtKXDa2qtmsZskKLULfqi9HtPddE3qJcA/JtwyYYaa1RECONg4 w==;
X-CSE-ConnectionGUID: E4F08h9dSKKKw44DbOqtMw==
X-CSE-MsgGUID: +V3QFBTCSVCdMbcQcupboQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="91791021"
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; d="scan'208";a="91791021"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2026 21:11:37 -0700
X-CSE-ConnectionGUID: nU2Gv3HwRXSKy07B581fSw==
X-CSE-MsgGUID: APr8hKE4QeOsh3llifZfAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; d="scan'208";a="268466619"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2026 21:11:37 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 21 Aug 2026 21:11:36 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 21 Aug 2026 21:11:36 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.63) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 21 Aug 2026 21:11:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dqHXBXwHudWXngwEN/8LipDvdQPgivFx2JG7+HWpXnDUq38p4KNrFWUpvbYuLz7R1LBQuEb1dvO7BcmaloxhrZzfuwfjacIT8Ha0Y1YSy0aqIJkydJk+RUZfKt8E340sNymYZfOmqNs9LqVv40a5Hgz50huv8OA4p0vVpOIVetKI73jWTG8DyXckTimJWxZCRs+/U9GPV0icurbTSTWuy8D4Ye6hmFWR+UtbvO69a9HCGfGuWeiaLEzKIdGZYjDBVQXTKBMFTcpTiCKWW0FuFODjT2eQeYEij9lgzhoKM+AW3WIokou/SkPsEJLFRA3tAAkcFFIuQj5AufYhSZmaYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xwXYWKFyRDh9jjPg1tQiyyMIthnmJ2A26O5qPGsGC6Y=;
 b=joMhPtTEodwlDcKeu2R8YyVMu269j0oE2F1VEzmR8F9jtY8psZEsB9VR6bcjC2gbibCUWC3GxSuNnZq+b+7nZ1TLv833e13sHmdwt+A9FRPHfAytZhln7SMa/pul2foZAx4wvjYKYhd+hVQPtErAwPgtgbVMbsdKmC/rx3pxxc1EObT9TscHasBZ3nv6J9jaN/LKjvbC1/JjkwyWiFpjEymPkSvSuGFyJszD8EpobBK/IO23tA10+0igJtOY+twYX+Fqa+T79C5g8W/xP74Byv35gKJQaWQzyRFtN5qQ0iKZUJ3ec9/kSL49X6V/NS+O8rf3UtX/EY+Xe1YnxOVgrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by IA3PR11MB992400.namprd11.prod.outlook.com (2603:10b6:208:61e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Sat, 22 Aug
 2026 04:11:33 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0315.014; Sat, 22 Aug 2026
 04:11:33 +0000
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
Subject: RE: [PATCH iwl-net 01/12] ice: use reference counting and RCU for PTP
 port access
Thread-Topic: [PATCH iwl-net 01/12] ice: use reference counting and RCU for
 PTP port access
Thread-Index: AQHdMctMN7TdwO7zqEGH6jurIbdeGbapdKlg
Date: Sat, 22 Aug 2026 04:11:33 +0000
Message-ID: <LV1PR11MB87909FCB7E24DCA7E52CA4EC90A22@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260821-jk-e825c-minimized-fixes-v1-0-9d0731eb4858@intel.com>
 <20260821-jk-e825c-minimized-fixes-v1-1-9d0731eb4858@intel.com>
In-Reply-To: <20260821-jk-e825c-minimized-fixes-v1-1-9d0731eb4858@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|IA3PR11MB992400:EE_
x-ms-office365-filtering-correlation-id: d34bdaf6-b276-4ff1-1d47-08df0003738d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|5023799004|56012099006|11063799006|38070700021|6133799003|4143699003|10067099003;
x-microsoft-antispam-message-info: /VibYqoUv4BEc/f/kZmrDBh8OMNpRe2XDtEOcUZtndeiaUlXAHzlPZrLO6Rt4M/Y8KWWqnN8gA9cYAyC8FKP7LKkjNPpq+FfYYJlTyUnWpaySS1SMGH9x64v//IB/ZUz//nNbfNy9lveC5i0RuCAsUHZHDuvzGQ2v4T+n0A4HmGkeMLyc9Eiop5uVDtFblqEGUhsuPQwZEcDg6SQfdjStRiThwom8Acg61r5okpQTaiQZUSmqjTb8ladLdoDLtna6qlQtBxPYJLLj9S0Bmj5fXrmXwoH4w1qnwzVzGcY/qVVB4PoAotmdFHLeUalFOtsB3w2k+fSY6fx1cLVs0JbvVoA+BdYPm8abdM4lFWOFrlhPDJu8utIzCKeadIuhsskxI0SRU+Qi4BaxIGIUcXzko/p63hF0FdZwEIaq2xZAoTWF64V478T1CIbfflYNeLtAVMMIyfWdkuI5EiwFyIg4oyMFSV4qGyhbBrAKOd5N3JusbEGYJNKje05bIDs5VA9WR/rQq72nwLYu1o2+FnsVk+45hW8wvEfcIaD0Wd7CVPCZra+5GzgSun8WQrMvcMkpKCL084Yan2tUcZTFONpd9ZE1mUli1Okm1NZbYJv4byLSpWmThCaug5HeUKVgQ8WdJWzw4+5DomthNc5QznttJ5I4ZCYAnZumwRp/7dnTOPKmomdaDVCfg4ur2+EsOYoaiZA+60bhEXlDvC2CkhLN0/gqQ3L5EEUQvR39NLSIoo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV1PR11MB8790.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(5023799004)(56012099006)(11063799006)(38070700021)(6133799003)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3hRYzlwUktnaUFzMEswdUI4RkhXQzhlMk5UK3haczdUM0ovaGJhOEs0NFVm?=
 =?utf-8?B?L3AzOWErQnBuUmliRWVUM1I2YzN4MDBtcGFnVmFrM00ybi9HNFhieGU4SzI0?=
 =?utf-8?B?V09WTmFuTzZ6WnQ1M01aTVBjMmo5K3JoWkJpWDZnNFFZZWxlMGxzL0N3Zit2?=
 =?utf-8?B?Wk1EZG5yeGNPS3ZPNVUyRjk4Uzg1KzNaT054OGgvaFY1eEMxOG5sNW8rZlZL?=
 =?utf-8?B?clg1SWJkYkV0OEw4Y3dzUlZGeDJqbUd3UXEyVHc2d1RLSzJXRmxsTUJXaHJy?=
 =?utf-8?B?dHEyYlMxaG1vYTUwMnpjRGt5b2Zoa2tsNjJJbGlIL3N3V0w3bzRjUG1uNVU5?=
 =?utf-8?B?NmhqYTdjU2tJV2Z5aFJ4MjZLQm1nYW50UW0zaytTdWxlTUsrWGxzTTdXVThK?=
 =?utf-8?B?dUJ2TzU4R1pkY2RSRnpJUlFRLzkzVkZBQ3hzVDA3QWlzb2x5TkRXWjhocE5T?=
 =?utf-8?B?U0hsRHduOWVIZ1pJU28vT0xHNk02MjVwd1V5U29hKzUyWnRrQ0o5WFNEQmlm?=
 =?utf-8?B?MTg4RFREWGlxMWVkbThITlFiVlZ4aVZYUlVDWi9yWUcxc0FwWjhkQWM2N0Nj?=
 =?utf-8?B?ZWFmejZTYWlMSGMySDRkL3p0Q1VTUGZETFZraUdOYmQ1WVB1enVwdXVnQmJB?=
 =?utf-8?B?RHMyT1JqaUtrUlRsV3czTUZwVS9uejZoMXZ0bXNZbGljV1k5eWtlTC9XcVhY?=
 =?utf-8?B?RWRLOEVpVkZVMG9IUkdEbFZiczJpZ0Q0WDcvdW5DcVNpQ3JLY1FKNWp1Z3VZ?=
 =?utf-8?B?NHp1UFFtYWtSeGpNT01iM2pNVDViRWQrUUZYRmZLNmtjK0w3S04vRzVmNzJE?=
 =?utf-8?B?NENSWUY4UVY0S3AxQXgvbGtaazZHbFI5Z3hPY3JwZWJ4RnVvQzFZd2xHdXVx?=
 =?utf-8?B?ejU3amVnVEJDenRBaHNCci9vUnZoMGM1TzJGTUptOEpxcjdxOHZYRHppUXpZ?=
 =?utf-8?B?WXZFTWVZSzBJVXpzcUIzZmJJWmkzcFlVSU02RTBjTU5adG9ITFNGdUFvYXY0?=
 =?utf-8?B?Z3dWM1lXd2o2VmE5ZUt4ZjdDNVFlbU1LVGs1WmJWWU5JeDZUZW5vcWFTVVd0?=
 =?utf-8?B?L0RKL3FjRDJZWEQ0N3dMN3BhWmVNbFZpanZkMkRPa3dzZmcwbHpYUlVJNWNj?=
 =?utf-8?B?MHlhK21zZUFhejNoblhiYnFuelZWajZydHMxeDRJeHB3SWR1LzZnVXRsTXU1?=
 =?utf-8?B?clBvYjBxaWdwTVlKMU5kOThkcGlhUXBFQi9qWGRDaGMvcDlURTVIaENsUXhY?=
 =?utf-8?B?eUVqcXFtVHlkM3ZOMWsvVTJ3WlMzVnhzVGlIajJYYzBQcm9xUFora2REM0Z4?=
 =?utf-8?B?c01JRlU2OTNPbTVQSW5tTm1uTXR6czMvNXl5M1ZPNkNHTmJwZkg1M1Z6cTNh?=
 =?utf-8?B?Q1h2a0o3WWJUYXFSSWhMMkRSQUg3cFFPblZrbjh1MnlkSTJaY2dyYm9XU3NJ?=
 =?utf-8?B?ZzEwcFdUeU40UzM4aitJR1M2MlhZNldjSFRwRHluUDZveXpiZWZsdTVBbnZ2?=
 =?utf-8?B?d1pxOW1jOXVSL1hjRVlMT3N4ZDFmRTdwMUp3Nnl6OW1GaUFnWVI3Y0NzY1h0?=
 =?utf-8?B?MXpQRGJ5d0JiUEZWYUlOYVFjcURZZWFiL3YxVU5JbUg2OXpqeUFzVjNuRlFI?=
 =?utf-8?B?RHVqMldtYzJsOFNsQy9UTDdPVnp0eTZRekNhK2xpNXozMm55TEdRdzU4ZElm?=
 =?utf-8?B?eGdGL2wxLzFFRnRaTUVMdVlzdGJJYmpXTVpKRWx6QXJCWjF5elNzc1dKanJU?=
 =?utf-8?B?QzZxYWg5SGNIUGZXdWdBeG83Z1pGMWZlMW5kL3JGem5PRW4zRmY3UDJQTTVm?=
 =?utf-8?B?eWNOZExLRkQwYm1sOE90c0cwWjFIa3ZCTmZQSE5WN0ZrNkp1Q1daS2djMk5H?=
 =?utf-8?B?TTZ2Qmo4UjRmWDBLRUZPb0dxR3VjV3MxNTNIdnRQSERFVnRRRWpzbGNGMjZF?=
 =?utf-8?B?NW0zdHlWdGZob25HdTcrZi9QeWgyK0N6UHNKYTB6dFg5SXNaZTJDR2QvWHlH?=
 =?utf-8?B?bXpMdGNqNi9LMnU2elZvRzBrdEFmOTlQWlpjTmZmd0w2aEdSVEZpZjJ5UWlK?=
 =?utf-8?B?QlYxL21oTWZkdjNjVGxJR2ErL09XaGhwdkY5RDZodEJzR0x1eWlCVnlLTFI4?=
 =?utf-8?B?MDBkN2ZEMXgyblNQTTFhUXB5QzNZMWxLU3BnUk9YN0JhNGJPSm5ad05QQWND?=
 =?utf-8?B?OHJHOUR6QVB5RGRjZUNVcUtXblg2RGpPbHYwQTEweXFQWXhnOUowVk92T0VI?=
 =?utf-8?B?OE45RFMwVitadStkTE44MVE1YmI1UkJSUndkSmV4Q05EeEFOMTd2YUVSclQx?=
 =?utf-8?B?L1ArNjN1NzY1TjJnOWg3a2w3MFRIbnJHTmtCcG5xT1RWcDRieDNBUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ef/o1n/s8uaL1wqM8k601PVYI9KQC5eKefy80NASaYoYYxj41SFg6FB2SJti3Y9R5Ixi6cb+4WddJNQ/SpbzXbme+BG24pZxVDB0bPdoG+z+Os6Hhnta2xFTdJZpOBAr5o67MCVPCOybVoPcxoIDD0q7N4ju+ixQGj/Wi6MJ/erSw2T4GdFyI6Fr4MM9ljClxydjV6crjpuJJj3E/ONo4hfvjyuu2BTlakLejW6ee36TDY7RkCJ0szvENZWpnzUxg/bjPoRaL0T6Zic2u7nhUoL91ALt8iV1+uvDRPt7hN0Aq4+AtRCPP9UyI5OrM1l6kM76q5CWnv/A6J4c7TDp/g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d34bdaf6-b276-4ff1-1d47-08df0003738d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2026 04:11:33.3192 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uxlZyUkMLw9yRdKW3phddXDbPtvaHuav1hnhjMKHmMzMubrJyBiGuJp4hOxGRm54bmhuvVh7e7BLRovigUZxkFRJR4dJc98kXwvmziF/gEE=
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
d2wtbmV0IDAxLzEyXSBpY2U6IHVzZSByZWZlcmVuY2UgY291bnRpbmcgYW5kIFJDVSBmb3IgUFRQ
IHBvcnQgYWNjZXNzDQo+IA0KPiBUaGUgaWNlIGFkYXB0ZXIgc3RydWN0dXJlIG1haW50YWlucyBh
IGxpc3Qgb2YgcG9ydHMgYXNzb2NpYXRlZCB3aXRoIHRoZSBhZGFwdGVyLiBUaGlzIGlzIHVzZWQg
Zm9yIHN1cHBvcnRpbmcgUFRQLCB3aGVyZSB0aGUgY2xvY2sgb3duZXIgbXVzdCBoYW5kbGUgbWFu
eSBvcGVyYXRpb25zIHRoYXQgcmVxdWlyZSBhY2Nlc3MgdG8gdGhlIFBUUCBwb3J0IHN0cnVjdHVy
ZXMgPiBvZiB0aGUgYXNzb2NpYXRlZCBQRnMuDQo+IA0KPiBUaGlzIGlzIGltcGxlbWVudGVkIHVz
aW5nIGEgbGlua2VkIGxpc3QgYW5kIGEgbXV0ZXguIFRoaXMgc29ydCBvZiB3b3JrcywgYnV0IGEg
ZmV3IHBsYWNlcyB3aXRoaW4gdGhlIGNvZGUgZG8gbm90IGFjcXVpcmUgdGhlIG11dGV4IHdoZW4g
aXRlcmF0aW5nIHRoZSBsaXN0LiBUaGlzIGluY2x1ZGVzIGljZV9wdHBfZmx1c2hfYWxsX3R4X3Ry
YWNrZXIoKSwgaWNlX3B0cF9yZXN0YXJ0X2FsbF9waHkoKSwgYW5kIGljZV9wdHBfcHJlcGFyZV9y
ZWJ1aWxkX3NlYygpLg0KPiANCj4gRml4aW5nIHRoaXMgaXMgdHJpY2t5LCBlc3BlY2lhbGx5IHNp
bmNlIGl0IGlzIG5vdCBjbGVhciBpZiB3ZSBjYW4gc2ltcGx5IGFjcXVpcmUgdGhlIGxvY2sgYXJv
dW5kIHRoZSBjb21wbGV0ZSBpdGVyYXRpb25zLg0KPiANCj4gVGhlIHBhdHRlcm4gb2YgdXNlIGZv
ciB0aGUgcG9ydCBsaXN0IGlzIHJlYWQtbW9zdGx5IHdpdGggbW9kaWZpY2F0aW9ucyBvbmx5IGhh
cHBlbmluZyBkdXJpbmcgUEYgaW5pdGlhbGl6YXRpb24gd2hlbiBlbGVtZW50cyBhcmUgaW5zZXJ0
ZWQuIFRoaXMgdHlwaWNhbGx5IG9ubHkgaGFwcGVucyBkdXJpbmcgZWFybHkgYm9vdCwgdGhvdWdo
IGEgUEYgY291bGQgaW4gcHJpbmNpcGxlIGJlIHJlbW92ZWQgb3IgbG9hZGVkIGF0IGFyYml0cmFy
eSB0aW1lcyB2aWEgYmluZCBhbmQgdW5iaW5kIG9wZXJhdGlvbnMuDQo+IA0KPiBUaGUgdXNlIG9m
IGEgbXV0ZXggZG9lcyBtZWFuIHRoZSBkcml2ZXIgY2FuIHNsZWVwIHdoaWxlIGhvbGRpbmcgaXQs
IGJ1dCBpdCBzdGlsbCBjcmVhdGVzIGNvbXBsaWNhdGVzIHdpdGggbG9jayBvcmRlcmluZyBhbmQg
cHJldmVudHMgaXRlcmF0aW5nIHRoZSBsaXN0IGluIGFueSBjb2RlIHBhdGggdGhhdCAqY2FuJ3Qq
IHNsZWVwLg0KPiANCj4gSW5zdGVhZCwgdXNlIHRoZSBSQ1UgcHJpbWl0aXZlcyBmb3IgdGhlIHBv
cnQgbGlua2VkIGxpc3QsIGFsb25nIHdpdGggYSByZWZlcmVuY2UgY291bnQgb24gdGhlIHBvcnQu
IFRoZSBrcmVmIHJlZmVyZW5jZSBjb3VudGVyIGVuc3VyZXMgdGhhdCB3ZSBjYW4gc2FmZWx5IGFj
cXVpcmUgcG9pbnRlcnMgd2l0aCBhIGd1YXJhbnRlZSBvZiB0aGVpciBsaWZldGltZSwgZW5zdXJp
bmcgPiB0aGUgYXNzb2NpYXRlZCBQRiB3aWxsIG5vdCBiZSByZW1vdmVkIHVudGlsIHRoZSByZWZl
cmVuY2UgaXMgcmVsZWFzZWQuDQo+IA0KPiBGb3IgcG9ydCBpdGVyYXRpb25zIHdoaWNoIGFyZSBz
aG9ydCBhbmQgZGVmaW5pdGVseSBjYW4ndCBzbGVlcCwgd3JhcCB0aGUgZW50aXJlIGxvb3Agd2l0
aCByY3VfcmVhZF9sb2NrKCkgYW5kIHJjdV9yZWFkX3VubG9jaygpLg0KPiANCj4gRm9yIGxvbmdl
ciBvcGVyYXRpb25zLCBvciB0aG9zZSB3aGljaCBtaWdodCBzbGVlcCwgd2UgbmVlZCB0byBjbG9z
ZSB0aGUgY3JpdGljYWwgc2VjdGlvbiBiZXR3ZWVuIGVhY2ggbG9vcCBpdGVyYXRpb24uIFRvIG1h
a2UgdGhpcyBzYWZlLCBzdGFydCB0aGUgbG9vcCBpdGVyYXRpb24gd2l0aCByY3VfcmVhZF9sb2Nr
KCksIHRoZW4gYWNxdWlyZSBhIHJlZmVyZW5jZSBmb3IgdGhlIHBvcnQgd2l0aCBrcmVmX2dldF91
bmxlc3NfemVyby4gSWYgdGhpcyByZXR1cm5zIDAsIHRoZSBwb3J0IGlzIGFscmVhZHkgaW4gdGhl
IHByb2Nlc3Mgb2YgYmVpbmcgcmVtb3ZlZCwgc28gdGhhdCBwb3J0IHNob3VsZCBiZSBza2lwcGVk
IHdoZW4gaXRlcmF0aW5nLiBPbmNlIGEgcmVmZXJlbmNlIHRvIHRoZSBwb3J0IGlzIGFjcXVpcmVk
LCBleGl0IHRoZSBSQ1UgY3JpdGljYWwgPiBzZWN0aW9uLiBUaGVuLCBwZXJmb3JtIHRoZSBkZXNp
cmVkIG9wZXJhdGlvbnMgb24gdGhlIHBvcnQsIGZvbGxvd2VkIGJ5IHJlbGVhc2luZyB0aGUgcmVm
ZXJlbmNlIHdpdGgga3JlZl9wdXQgYW5kIHRoZW4gcmUtZW50ZXJpbmcgYSBjcml0aWNhbCBzZWN0
aW9uIGF0IHRoZSBlbmQgb2YgdGhlIGxvb3AgYm9keS4gTm90ZSB0aGF0IGtyZWZfcHV0KCkgaXMg
ZG9uZSBvdXRzaWRlIHRoZSBSQ1UgY3JpdGljYWwgc2VjdGlvbi4gVGhpcyBpcyBzYWZlLCBhcyB0
aGUgcG9ydCB3aWxsIG5vdCBiZSBmcmVlZCB1bnRpbCBhbGwgcmVmZXJlbmNlcyBhcmUgZHJvcHBl
ZC4NCj4gDQo+IFRoZSBpY2VfcHRwX3JlbGVhc2VfcG9ydF9yY3UoKSBmdW5jdGlvbiBpcyB1c2Vk
IGFzIHRoZSByZWxlYXNlIGZ1bmN0aW9uIGZvciB0aGUga3JlZl9wdXQoKSBjYWxsLiBUbyBhdm9p
ZCBhIHBvdGVudGlhbCBpbmZpbml0ZSBsb29wIG9mIG5ldyByZWZlcmVuY2VzLCB0aGUgcmVsZWFz
ZSBmdW5jdGlvbiBzaW1wbHkgdXNlcyBhIHdha2VfdXBfdmFyKCkgY2FsbCB0byB3YWtlIHRoZSBj
bG9zaW5nIHRocmVhZC4gVGhlIGljZV9wdHBfY2xlYW51cF9wZigpIGZ1bmN0aW9uIHdpbGwgcmVt
b3ZlIHRoZSBwb3J0IGZyb20gdGhlIGxpbmtlZCBsaXN0IHVzaW5nIGxpc3RfZGVsX3JjdSwgdGhl
biByZWxlYXNlIGl0cyBwcmltYXJ5IHJlZmVyZW5jZSwgdGhlbiB3YWl0IGZvciBhbGwgcmVmZXJl
bmNlcyB0byBkcm9wIHZpYSB3YWl0IHF1ZXVlLiBGaW5hbGx5IHN5bmNocm9uaXplX3JjdSgpIGlz
IGNhbGxlZCB0byBndWFyYW50ZWUgdGhlIHBvcnQgcmVtYWlucyB2YWxpZCBmb3IgYXQgbGVhc3Qg
b25lIFJDVSBncmFjZSBwZXJpb2QuIFRoZW4gUEYgcmVtb3ZhbCB3aWxsIGNvbnRpbnVlLg0KPiAN
Cj4gVGhpcyBmbG93IGVuc3VyZXMgdGhhdCBhbGwgYWNjZXNzZXMgdG8gcG9ydHMgdmlhIHRoZSBw
b3J0IGxpc3Qgd2lsbCByZW1haW4gdmFsaWQgdW50aWwgZWl0aGVyIHRoZSBSQ1UgY3JpdGljYWwg
c2VjdGlvbnMgZW5kLCBvciB0aGUgcmVmZXJlbmNlcyBoYXZlIGJlZW4gZHJvcHBlZC4NCj4gDQo+
IE9uZSBtYWpvciBjb21wbGljYXRpb24gb2YgdGhpcyByZWZlcmVuY2UgY291bnQgaXMgdGhhdCBp
Y2VfcHRwX3BvcnQgaXMgZW1iZWRkZWQgaW5zaWRlIG9mIG90aGVyIHN0cnVjdHVyZXMgYW5kIG5v
dCBtZXJlbHkgYWxsb2NhdGVkLiBBcyBhIHJlc3VsdCwgd2UgY2FuJ3QgdXNlIHRoZSBzdGFuZGFy
ZCBwYXR0ZXJuIG9mIGtmcmVlX3JjdSgpIHRvIGp1c3QgZGVsYXkgZnJlZWluZyB1bnRpbCByZWZl
cmVuY2VzIGFyZSBkcm9wcGVkLCBhbmQgaW5zdGVhZCBhcmUgZGVsYXlpbmcgUEYgcG9ydCB0ZWFy
ZG93bi4gSWYgYW55IGNvZGUgcGF0aCBsZWFrcyB0aGUgcmVmZXJlbmNlLCB0aGUgZHJpdmVyIHdp
bGwgYmUgdW5hYmxlIHRvIHRlYXJkb3duLg0KPiBJbnN0ZWFkLCBhIDE1IHNlY29uZCB0aW1lb3V0
IHdpdGggYSBXQVJOKCkgaXMgdXNlZCB3aGVuIHdhaXRpbmcgdG8gZmluYWxseSBhbGxvdyBQRiB0
ZWFyZG93biB0byBjb250aW51ZS4gVGhpcyBoYXMgdGhlIHJpc2sgb2YgcG90ZW50aWFsbHkgYWxs
b3dpbmcgdXNlLWFmdGVyLWZyZWUsIGFzc3VtaW5nIHNvbWUgcGF0aCByZWFsbHkgaXMgc3R1Y2sg
Zm9yIDE1IHNlY29uZHMuIEhvd2V2ZXIsIHRoaXMgYm90aCBsZXNzIGxpa2VseSBhbmQgYSBsZXNz
IGJhZCBvdXRjb21lIGNvbXBhcmVkIHRvIGJsb2NraW5nIGluZGVmaW5pdGVseSBvbiBhIHJlZmVy
ZW5jZSBsZWFrLg0KPiANCj4gRml4ZXM6IGU4MDA2NTRlODViNSAoImljZTogVXNlIGljZV9hZGFw
dGVyIGZvciBQVFAgc2hhcmVkIGRhdGEgaW5zdGVhZCBvZiBhdXhkZXYiKQ0KPiBTaWduZWQtb2Zm
LWJ5OiBKYWNvYiBLZWxsZXIgPGphY29iLmUua2VsbGVyQGludGVsLmNvbT4NCj4gUmV2aWV3ZWQt
Ynk6IE1hY2llayBNYWNobmlrb3dza2kgPG1hY2llai5tYWNobmlrb3dza2lAaW50ZWwuY29tPg0K
PiAtLS0NCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfYWRhcHRlci5oIHwg
ICA2ICstDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX3B0cC5oICAgICB8
ICAgNCArDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX2FkYXB0ZXIuYyB8
ICAgNyArLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9wdHAuYyAgICAg
fCAxMTggKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tDQo+ICA0IGZpbGVzIGNoYW5nZWQsIDk2
IGluc2VydGlvbnMoKyksIDM5IGRlbGV0aW9ucygtKQ0KDQpUZXN0ZWQtYnk6IEFsZXhhbmRlciBO
b3dsaW4gPGFsZXhhbmRlci5ub3dsaW5AaW50ZWwuY29tPg0K
