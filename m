Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74EC2C5DF97
	for <intel-wired-lan@archiver.kernel.org>; Sat, 22 Aug 2026 04:13:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 24180409F6;
	Sat, 22 Aug 2026 04:13:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3YVG0P1BXgdG; Sat, 22 Aug 2026 04:13:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787372017;
	bh=2yz0f35bJfxXj3wQf4Q2JGX7yogMcyqyFv/fNTLhqQg=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=w9b+WDkpdYcMUOorou2DUE/LnUil57O+gXWMB5MWUzPOsnkDZVfouEanbU5Q+ECS1
	 ogkf28s6BTGnw46oOtinIJUWDsumJ9+g1ExD+QPr6ZUKO4+knhDlTJsU2sYk0CVEiu
	 0mR4IQ3sebpIX0oyQxGN4jxJlXJ94TcI7UhmuYJaTmmC4mwW1W6mA9wAyzGfO3AecD
	 yWcNBV55t49FxQshoA2Zwjjbm81vX3UmAyTfyrjG59pI63GhcQhFjZS5g+cn833gV+
	 mE23OOYOQIpj+Ztb4CKuefVh+LpQfWrQktdFf2yCRhlT0lc/bZZbGJglMcMa/Of491
	 hqZMQBXbL22NQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6002A409CE;
	Sat, 22 Aug 2026 04:13:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7911F476
 for <intel-wired-lan@lists.osuosl.org>; Sat, 22 Aug 2026 04:13:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6AB56409CE
 for <intel-wired-lan@lists.osuosl.org>; Sat, 22 Aug 2026 04:13:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O4JCprDB39yw for <intel-wired-lan@lists.osuosl.org>;
 Sat, 22 Aug 2026 04:13:35 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.13;
 helo=mgamail.intel.com; envelope-from=alexander.nowlin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=P48rb2eQ
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 74202409CA
 for <intel-wired-lan@lists.osuosl.org>; Sat, 22 Aug 2026 04:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787372015; x=1818908015;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=2yz0f35bJfxXj3wQf4Q2JGX7yogMcyqyFv/fNTLhqQg=;
 b=P48rb2eQ/eMcFZuElT7fWEke7b1dKaY/dV0h9CURSuRbFYEC66sYOTL2
 sBN5XyBR4JSdbEZgdkvl1VH7lJkToEhUy5DS/Q1yJjhFkKXN0pTrf5zR7
 eCWXAKDOQg++YWWpCnikx+wwWfLqWqc2+teO5CgG6Ag8a+8CWemgChjEr
 9GP4m7gGwyempEebMlzx5qMlGVvH9bX+TdoEJvUUmaV/YjhmLJ1BC57lR
 /h3vGV97m+WS0WIHqDzKuTsGFgWBUK6H8+622d9CidGc9IX/lZhr/2Ezs
 1r+5x3gjDoVPbWIKduTae4oG3zSqH1Gdpi0Qbgl7xBzAidSVQgWj/uuiG A==;
X-CSE-ConnectionGUID: GiLXxpXWTAqjz3kysiN8gg==
X-CSE-MsgGUID: VnmX6gCpQGyzi4/CcYj+iw==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="99074460"
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; d="scan'208";a="99074460"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2026 21:13:34 -0700
X-CSE-ConnectionGUID: 4SkPGCtpQVeGUj4YIC1q+g==
X-CSE-MsgGUID: j1p7XW2aRzCAFpHKX9w1Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; d="scan'208";a="296422685"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2026 21:13:35 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 21 Aug 2026 21:13:33 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 21 Aug 2026 21:13:33 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.38) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 21 Aug 2026 21:13:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D0jWKaY79aZU+EKpZWkqluVv9F53nP6TaCMwSxNoYZXPKpSqFlmZm+hAj9nznY1zDY11rjGaD2dGRVuIn2lNCnYlEdghrPrjYn+LUGOmdE7lydKDk/bt+GmyBi1w1tplpbSsYy3ndQbVf4N2HCZCkKIh9krxYIPKpUKdgkTY4hj4pIz0QIjBLiViPOqNbqCVniDdUukqVtdCYN8qU6GoZyH8j0ZsPvdvWWorG5IKd/2ogIW5+dD1BQYj0s0IeLgNmJkaCt0iVROc1Y8huuHJyo/2bx1EcHSsHsQlKC1XWKzGzXvdRNwse62LC3fthgEe/YXEfAriE2hVK/mhHagIOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2yz0f35bJfxXj3wQf4Q2JGX7yogMcyqyFv/fNTLhqQg=;
 b=iIXEaIl6n96paEFO1sRtTNVFnn8Lf1crsWyQlPOTxX+/k7BTAOuJ9E9bo0VOy46AGBQQUksteL8W63l+0ee2zrlfJKGqzLg/2SrxzoojtaKNM4CpW9CZWLLA6x9WHKnc7GOcjb6ioVbv2punTGM9UZfkuaZxdZZC40IQ/X/IM4QJYcAWCGovnOPq4mTu7PV/DWd0kcUc4Q9v5wOy0+3zrOgIftod6tZHwOjoowq0KoBfCVsB/TQTttDO9ybDCVPVMT3Hxg55+vCQKa0KYgyK+pth6YkxIg0yr+lDaukWRsw9bhlUGiB8+qvEhWhzP8OiFJL3v8osF9noUDeRRWneHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by IA3PR11MB992400.namprd11.prod.outlook.com (2603:10b6:208:61e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Sat, 22 Aug
 2026 04:13:27 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0315.014; Sat, 22 Aug 2026
 04:13:27 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, Intel Wired LAN
 <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Machnikowski, Maciej"
 <maciej.machnikowski@intel.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Korba, Przemyslaw"
 <przemyslaw.korba@intel.com>, "Nitka, Grzegorz" <grzegorz.nitka@intel.com>,
 "Oros, Petr" <poros@redhat.com>, "Bross, Kevin" <kevin.bross@intel.com>,
 "Cavatur, Ranjit" <ranjit.cavatur@intel.com>, Karol Kolacinski
 <karol.kolacinski@intel.com>, "Loktionov, Aleksandr"
 <aleksandr.loktionov@intel.com>, "Kubalewski, Arkadiusz"
 <arkadiusz.kubalewski@intel.com>, "Korba, Przemyslaw"
 <przemyslaw.korba@intel.com>
Subject: RE: [PATCH iwl-net 02/12] ice: E822: keep Tx timestamps disabled
 during offset calibration
Thread-Topic: [PATCH iwl-net 02/12] ice: E822: keep Tx timestamps disabled
 during offset calibration
Thread-Index: AQHdMctKG7cUTHQKsEuB41HF0mkwLbapdVTg
Date: Sat, 22 Aug 2026 04:13:27 +0000
Message-ID: <LV1PR11MB879096CD257FD128205F4A0890A22@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260821-jk-e825c-minimized-fixes-v1-0-9d0731eb4858@intel.com>
 <20260821-jk-e825c-minimized-fixes-v1-2-9d0731eb4858@intel.com>
In-Reply-To: <20260821-jk-e825c-minimized-fixes-v1-2-9d0731eb4858@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|IA3PR11MB992400:EE_
x-ms-office365-filtering-correlation-id: 4c9b9cbe-8f58-48d1-34ee-08df0003b7c1
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|56012099006|11063799006|38070700021|6133799003|4143699003|10067099003;
x-microsoft-antispam-message-info: KiE3x2W5oLF1toS+s2iZooAXGNh2gikqKRErB4Bdd2AD/qqOPE7dXaA/gjOFG5Vl/hmOf+Qz+IXRsx9c6Lgf7zi9EeIs/HZiixST8xTEIN9OmJ/uCUM6yAUBVD18mJpEodZcnR6z1hYcdd9xkmbb4x7hwyiwE3ESGjZR9cxvA8ef85Gn8KHII2TvkL0mk1dRa/ZJqW8EpSULL3IfhVsPp6ZOcwzctqwx5ps7hCceeLC7AmHMR5E+C2E2BrWhHPij/H7rYYrvLQmRKbp/Oa+QcW+vtR/EadeHsDnrCmbvif5YhEz2j0uA3LZXNw5+LkTUhctXZrRMAzdjkH9hsFsvDVYQpNq9JmFi4G5L98PJBIHhWWcPjrDJ8EYIvEmiiRzBJQEQ+rcOLd7mkl31OUKju9yKRVVQmhXDnw5nx6wz/R4Jh3xAo56Fc1KOz5FPZEpMNvXBhbvI3BfwwsZ1JQKSV0sKiFESjnjIxCxCML7h+0QSC+eXTcsl1AKStP1eUGxAsncwiGjQz5es/kBQXHyOhaj/FDu8nKOyRE9L1A9fgeTX/bd7msyMu4VU7TZERu56c4wndcggpX2HeUSLaoyYsoTKNS6KHMo/8jZps3CMayBjMDX9CQJJZS1aVTZ5Mbw/0W+wo4zHi/OS5ohPcZcxUvIMNM/y0WouEomB3l9K9R9DP92gHseS/e9iR40jx3x8y+blSLw/haZ5MqgovY7qEdHSa9zc0Zs4wzF3pHkk/7c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV1PR11MB8790.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099006)(11063799006)(38070700021)(6133799003)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bXJ5QlJscVBhMDRCTXNSS3ZlWWN3UEh2MERYd2o3VmIxM05ZYjV0cWRpOXNX?=
 =?utf-8?B?MWU0azJxelYrc1VwL29NM1A5eVEvRG9ZR1ZUTTNQN1VWVjBzR0twVHRGU3R5?=
 =?utf-8?B?RWxqNWFmUzVSZ1lGOXY5Z21tcE9kdzZCQitXUzhvRWJRZC83alhMTHMvZGFn?=
 =?utf-8?B?RndOOTRTaFVxNFpJMzFGVGo2MEtlcG9oOVE5V05GaDJVQzEwaDF5YlpYREFG?=
 =?utf-8?B?NzBneUV2TFhtbHB1L2MyTkJHRmVnTHVhZjRTK2xWNytJd2x0MUNiZitabHhK?=
 =?utf-8?B?N3ZCcGpyQ09haXBnQ0prYi95R3drd1RqcEQvUUsxeWI4UVVJbGlxaTR6L0Zv?=
 =?utf-8?B?NmdYVmJlTE1RMkVrS1d6Wis4Y2JUandRbWhOb3FPRjBTTGRVMFIzYXA0SGox?=
 =?utf-8?B?eXIvcGRIQ3k2OXA4WmVOREtPU1ZaQjN0b0doSFVsNmZTbVYxeG44UVhvMG5I?=
 =?utf-8?B?bGtYRTJHVXF5QjN0UElzZmpiZmhlMUIwNVAvQnM1RG54OE41RllLSzllOHIy?=
 =?utf-8?B?ZVlvTFdWVW9Zb3VuKzZWNWM0Z1VLK2JMbjd0UEdNajA1NS9tNU1zZXN1S3g0?=
 =?utf-8?B?WE9UMjZ1SkYxMnlQZkNxZTBiV2R6c1I5VUxtd2o0aVhlWEJvem9zQTNjejM2?=
 =?utf-8?B?TXdoWWlqQ0JNNXJ0LzYzTy9FU2ZzbFFacUdhenprTERGL3NiQ2s1RU55c3N3?=
 =?utf-8?B?cjJIdGNuM2h2djVMMDJTb0lwN2JtbmpRaTN6ZENGMWVhc0tQVm5PV0pFT1o5?=
 =?utf-8?B?cVkzU2hFMGs3KzVYUXJEVDE4eGtidzI5dlNaSmdBWGVpYkNFYVZWWDN5QVdw?=
 =?utf-8?B?Wk9DWXQ3YmswOVJQRHZtK2I4bk92MmlBVXpUS04veGJ5a3J4TUM4RnhTREty?=
 =?utf-8?B?b3F0R2EvRCtYMlJkS29QNVVXWkMvekMwUGtId0RKVXBGSkdXcE1ma3dnZnIx?=
 =?utf-8?B?Yk9QeVpGMEl5clVGbEJ2VzhvWGd3U1NaL2NuTnNzUlZVdm1SbmlNRHh0NVhI?=
 =?utf-8?B?N214ck8xWlA0amwvRjA5N3pZS2cvL2FhVW11YnYvb25JaGxxUXlvL1Y3NHZo?=
 =?utf-8?B?cjlINnFpQlZqTG5SMmJRalFPQUVnUDYrSHFVaTdRNldqVUE1OE5DbjJkUXFL?=
 =?utf-8?B?bC95SWJpTFpFNStaMDJVd3l5WUtWYmpYMXpoTmVIMHBzb1dWTTNpVzV3ZEZq?=
 =?utf-8?B?TkFUWmNUeldoNVJKV0txTDlwdWdGYVFFSHhRcGExTG03L3pQUXN5dS9XR3Fo?=
 =?utf-8?B?Ujd1WmNPOHFIZ0hEdytLYWJVb2oyMzk0eGtrMjJkNWFuaFo3R2gwWFg3Nllq?=
 =?utf-8?B?S29BMzZBMDMyWTIxNE5Za1hMeDFmTWZOalVkMzRnay9wT3dxZDg3YWNEenFS?=
 =?utf-8?B?b0RVM1ZvZkU5b0ZsR1l5aGp3aWZuOHlScDJ2N04zaElOY1dwWVpoZDE3TDFF?=
 =?utf-8?B?bDBvaE0zNHRDZXI1LzFsOEl0L3dNTitIMDk5OExTYmNRdjdiRGlKMmR5dTla?=
 =?utf-8?B?RDgzaElkMmlJYnAxendxZ2FWaktPWGx6YUZUUGNXNEU4ckYyTzlMTWlNWGJ1?=
 =?utf-8?B?VnVaYVZmQnhZamZTOFovRTVKZ0JNamZsSFovRkdkc29uZFVUZXZFd1VwSXRL?=
 =?utf-8?B?cGNVSmJYRWJEMzA1dkJVQm1UdWQ1am0ySXNrZ1gzOFExVklJWXVUdzhIeThO?=
 =?utf-8?B?KzliVWxTSytXZzlScWFQdHJHcnRXY1pxQlcrK3B5d0drdGhaYzdYQng1d0NO?=
 =?utf-8?B?eWRaU0xmRVhORmxFY21jWTdJbEtlUWU2aU45K3lwYlNRYXBEUW8rTUF0Q3BG?=
 =?utf-8?B?Ky81RVdQbnJhSlp3bnB4NVBHYVp5SHNoaCtUZGcwRjV0a3N5bFRmaGpYVEZ6?=
 =?utf-8?B?NENWaVEybmNqc0hGM3FTaGdSS2xwVjVMcWNYRWhiUjM0MFFreFZrWHpjd29R?=
 =?utf-8?B?UU1SUjZPaXlrMHE5a0hNNUs3UU0wMytRdVNvUHlieTdpaThxTUVkbVkzUTNy?=
 =?utf-8?B?ZVZDMDBUaXVrNGJWRDd5TXpuY2hPRDhRZmlRd3hnKzV4b2UwWHh6enkwa2x0?=
 =?utf-8?B?UGNtV2dIVTluK2tGa2QxQ1dZVVJpQUpMSW50aFdSSlVieENBSjluWDhiamIw?=
 =?utf-8?B?WEtYR1g3Y3ZmQmhqQzRBakNSWWRkeURiMmtEV25ReFhzSWNMV2xMRU51eFdP?=
 =?utf-8?B?Yld0SGplc2QvRVNBVlJpYTlXQzdvSkVtNEJVSnZZT3IyeGZ5STU1T2FjTXFK?=
 =?utf-8?B?OCs5ZkdEUDFjUWs5cWQ5bkt4SW9UVjY4T0QvTEQ3aHA4dTF2aUhvNkg5eFg2?=
 =?utf-8?B?ZDMzdFV5UnM3VUJWdEZrdHJsTnB4NHYvdmk2cG5ScUFjdVRVV2dHUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: F6eucxh6FwvjpUOHdScmzyL1cgk7joYm4hhI29xHoTAtTM3HkudZGRiJP9wD3uJPBAyiHl4VdTISiUOTqHxqMp5Merc7JNW5DhN5soHsyKYF8UI9kMN1WXO5jufpfjIj8Q/g+KgJ927Bv8OFy/QJBbz1bhLHzhGN3JBTZcJOeskm2peNEn+VdX79MljypczZ9ZmUwY7oVzTc5+4GKYIcAtlz8EPQkfc21re2Lq2MafqJzwb/pzpnGiobLoEN+MzoHwmI4BoipN3KsHDB998x7DRdrI7QkNY+JMsLIgGSo2lP2kS4Ang5862H4zMpcqVxhz/WXLGopeKkniGtoQ8QLg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c9b9cbe-8f58-48d1-34ee-08df0003b7c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2026 04:13:27.7313 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OstPj02pxmOH2v9XTanQiLB6+OOYD6+nhGu7cW3QDxXYKnRteXa/K6Vpok3JBuUy4OX+TFCVKmHD02C1mDgHK3LW9aD5X8JHxUQS8k3vBZ0=
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
bGVyLCBKYWNvYiBFIDxqYWNvYi5lLmtlbGxlckBpbnRlbC5jb20+OyBLYXJvbCBLb2xhY2luc2tp
IDxrYXJvbC5rb2xhY2luc2tpQGludGVsLmNvbT47IExva3Rpb25vdiwgQWxla3NhbmRyIDxhbGVr
c2FuZHIubG9rdGlvbm92QGludGVsLmNvbT47IEt1YmFsZXdza2ksIEFya2FkaXVzeiA8YXJrYWRp
dXN6Lmt1YmFsZXdza2lAaW50ZWwuY29tPjsgS29yYmEsIFByemVteXNsYXcgPHByemVteXNsYXcu
a29yYmFAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggaXdsLW5ldCAwMi8xMl0gaWNlOiBF
ODIyOiBrZWVwIFR4IHRpbWVzdGFtcHMgZGlzYWJsZWQgZHVyaW5nIG9mZnNldCBjYWxpYnJhdGlv
bg0KPiANCj4gRnJvbTogS2Fyb2wgS29sYWNpbnNraSA8a2Fyb2wua29sYWNpbnNraUBpbnRlbC5j
b20+DQo+IA0KPiBEbyBub3QgY2xlYXIgdGhlIHR4LmNhbGlicmF0aW5nIGZsYWcgaW1tZWRpYXRl
bHkgYWZ0ZXIgc3RhcnRpbmcgdGhlIFBIWSB0aW1lciBpbiBpY2VfcHRwX3BvcnRfcGh5X3Jlc3Rh
cnQoKS4gSW5zdGVhZCwga2VlcCBUeCB0aW1lc3RhbXBzIGRpc2FibGVkIHVudGlsIHRoZSBvZmZz
ZXQgdmVyaWZpY2F0aW9uIHdvcmsgKGljZV9wdHBfd2FpdF9mb3Jfb2Zmc2V0cykgaGFzIGNvbmZp
cm1lZCB0aGF0IGJvdGggVHggYW5kIFJ4IFBIWSBvZmZzZXRzIGFyZSBwcm9wZXJseSBjb25maWd1
cmVkLg0KPiANCj4gUHJldmlvdXNseSwgdHguY2FsaWJyYXRpbmcgd2FzIHNldCB0byB0cnVlLCB0
aGVuIGltbWVkaWF0ZWx5IGJhY2sgdG8gZmFsc2UgcmlnaHQgYWZ0ZXIgaWNlX3N0YXJ0X3BoeV90
aW1lcl9lODJ4KCkgcmV0dXJuZWQuIFRoaXMgYWxsb3dlZCBUeCB0aW1lc3RhbXAgcmVxdWVzdHMg
dG8gYmUgc2VydmVkIGR1cmluZyB0aGUgd2luZG93IHdoZXJlIG9mZnNldCB2ZXJpZmljYXRpb24g
d2FzIHN0aWxsIHBlbmRpbmcuIFRpbWVzdGFtcHMgcHJvZHVjZWQgZHVyaW5nIHRoaXMgd2luZG93
IHVzZSB1bmNhbGlicmF0ZWQgUEhZIG9mZnNldHMgYW5kIGNhbiBwcm9kdWNlIGluY29ycmVjdCB2
YWx1ZXMuDQo+IA0KPiBXaGVuIHB0cDRsIHJlY2VpdmVzIGluY29ycmVjdCB0aW1lc3RhbXBzLCBp
dCBtYXkgcmVqZWN0IHRoZW0gYW5kIHdhaXQgZm9yIHRoZSBuZXh0IHN5bmMgaW50ZXJ2YWwgKHR5
cGljYWxseSAxLTIgc2Vjb25kcyksIGNvbXBvdW5kaW5nIGRlbGF5cyBkdXJpbmcgbGluayBjeWNs
aW5nLiBUaGlzIGNvbnRyaWJ1dGVzIHRvIHRoZSB0aW1lIHRyYW5zbWl0dGVyIHBvcnQgYmVjb21p
bmcgdW5yZXNwb25zaXZlIGFmdGVyIHJlcGVhdGVkIGxpbmsgZG93bi91cCBjeWNsZXMuDQo+IA0K
PiBNb3ZlIHRoZSB0eC5jYWxpYnJhdGluZyA9IGZhbHNlIHRvIGljZV9wdHBfd2FpdF9mb3Jfb2Zm
c2V0cygpLCBhZnRlciBib3RoIFR4IGFuZCBSeCBvZmZzZXQgY29uZmlndXJhdGlvbiBoYXMgY29t
cGxldGVkIHN1Y2Nlc3NmdWxseS4gVGhpcyBlbnN1cmVzIHRoYXQgVHggdGltZXN0YW1wcyBhcmUg
b25seSByZXBvcnRlZCB3aXRoIHByb3Blcmx5IGNhbGlicmF0ZWQgUEhZID4gb2Zmc2V0cy4NCj4g
DQo+IElmIGljZV9zdGFydF9waHlfdGltZXJfZTgyeCgpIGZhaWxzLCByZXN0b3JlIGNhbGlicmF0
aW5nIHRvIGZhbHNlIG9uIHRoZSBlcnJvciBwYXRoIHRvIHByZXZlbnQgcGVybWFuZW50bHkgZGlz
YWJsaW5nIFR4IHRpbWVzdGFtcHMgd2hlbiBvdl93b3JrIGlzIG5ldmVyIHF1ZXVlZC4NCj4gDQo+
IExvZyBhIGRlYnVnIG1lc3NhZ2Ugd2hpbGUgb2Zmc2V0IGNhbGlicmF0aW9uIGlzIHN0aWxsIHBl
bmRpbmcsIGluY2x1ZGluZyB0aGUgc3BlY2lmaWMgVHgvUnggZXJyb3IgY29kZXMgdG8gYWlkIGRl
YnVnZ2luZyBzdGFsbGVkIGNhbGlicmF0aW9uLg0KPiBUaGlzIHBhdGggaXMgZXhwZWN0ZWQgb24g
ZXZlcnkgcm91dGluZSBsaW5rLXVwOiBvdl93b3JrIGlzIGZpcnN0IHF1ZXVlZCB3aXRoIG5vIGRl
bGF5IGFuZCB0aGUgdmVybmllciBvZmZzZXQgY2Fubm90IGJlIGNvbXB1dGVkIHVudGlsIGF0IGxl
YXN0IG9uZSBwYWNrZXQgaGFzIGJlZW4gdHJhbnNtaXR0ZWQsIHNvIHRoZSBmaXJzdCBzZXZlcmFs
IGludm9jYXRpb25zIG5vcm1hbGx5IGxhbmQgaGVyZS4gVXNlIGRldl9kYmcoKSByYXRoZXIgdGhh
biBhIHJhdGUtbGltaXRlZCB3YXJuaW5nIHRvIGF2b2lkIGVtaXR0aW5nIEtFUk5fV0FSTklORyBv
biBldmVyeSBsaW5rLXVwIGR1cmluZyBub3JtYWwgb3BlcmF0aW9uLg0KPiBMb2cgYSBkZWJ1ZyBt
ZXNzYWdlIHdoZW4gY2FsaWJyYXRpb24gY29tcGxldGVzIHN1Y2Nlc3NmdWxseS4NCj4gDQo+IEZp
eGVzOiAzYTc0OTYyMzRkMTcgKCJpY2U6IGltcGxlbWVudCBiYXNpYyBFODIyIFBUUCBzdXBwb3J0
IikNCj4gU2lnbmVkLW9mZi1ieTogS2Fyb2wgS29sYWNpbnNraSA8a2Fyb2wua29sYWNpbnNraUBp
bnRlbC5jb20+DQo+IFJldmlld2VkLWJ5OiBBbGVrc2FuZHIgTG9rdGlvbm92IDxhbGVrc2FuZHIu
bG9rdGlvbm92QGludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQXJrYWRpdXN6IEt1YmFsZXdz
a2kgPGFya2FkaXVzei5rdWJhbGV3c2tpQGludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogUHJ6
ZW15c2xhdyBLb3JiYSA8cHJ6ZW15c2xhdy5rb3JiYUBpbnRlbC5jb20+DQo+IC0tLQ0KPiAgZHJp
dmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9wdHAuYyB8IDM2ICsrKysrKysrKysrKysr
KysrKysrKysrKysrLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMzAgaW5zZXJ0aW9ucygrKSwg
NiBkZWxldGlvbnMoLSkNCg0KVGVzdGVkLWJ5OiBBbGV4YW5kZXIgTm93bGluIDxhbGV4YW5kZXIu
bm93bGluQGludGVsLmNvbT4NCg==
