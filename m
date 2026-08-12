Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64DE6C5B56A
	for <intel-wired-lan@archiver.kernel.org>; Wed, 12 Aug 2026 10:32:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0C0CF608C8;
	Wed, 12 Aug 2026 10:32:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id phOi6uy6HF4C; Wed, 12 Aug 2026 10:32:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 586FF608AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786530730;
	bh=XbOFkehMqtKN49IOrKJT3Ue2E0ct3r9+fFNlvYJtPwA=;
	h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h0ohimI9ViF+Em1bIQILds6O6QKwtL7d/vEow/bXLwEbOMOvncpfAn7EgV0keyctW
	 PWXaaeQO1xh/JhRq8CDUi7VlLPakBx4rv+Ev/cVrFMWGvtGnjPjD0ZS4Grxkv8C4dx
	 4QeQnKq1aTLjJIaxjPZdwsQWclGbNLhVvShMnCuGIAu/+gygPDJs+HXqQLSv3B+oH5
	 R3a9q7bS+/Phi53SNdEUEwK7W1wUnLrXUMWOUWsmGduAIQaj+2AQ70U98tqDBw7u+U
	 V8INRFaqrfxAeK96P+UxAecpCjGOyujK4Tdk+USP6QEZgiruWDWBl+9iy6adMdDq1k
	 1kFzuAJvcao3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 586FF608AE;
	Wed, 12 Aug 2026 10:32:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 514D0361
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Aug 2026 10:32:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 42DDF80DF5
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Aug 2026 10:32:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nGT7BsVZ2yrn for <intel-wired-lan@lists.osuosl.org>;
 Wed, 12 Aug 2026 10:32:06 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.8;
 helo=mgamail.intel.com; envelope-from=sx.rinitha@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 8B01780F5B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8B01780F5B
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8B01780F5B
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Aug 2026 10:32:06 +0000 (UTC)
X-CSE-ConnectionGUID: +BwgI7jCSEKf0qoja29U4g==
X-CSE-MsgGUID: AJthfxNgTEyJagtn4NwqGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="104613883"
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; d="scan'208";a="104613883"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2026 03:32:04 -0700
X-CSE-ConnectionGUID: lTxPE9gsScCqIEeKW694sQ==
X-CSE-MsgGUID: aIlGhVX+T0OXG4GjXh7hvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; d="scan'208";a="267101718"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2026 03:32:06 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 03:32:05 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 12 Aug 2026 03:32:05 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.53) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 03:32:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FhYKV2VxmffLPohc19rSpzF5rafWwnF3A5pkZp2nbnqugpm7YBBnuPIlfO2zjrrMk8VFSx23m2vaQZB20n+TiiCIGGCDtp6T9j5Cby1HiZg3+gie71/LnCdru4KPdb2LA2oQGxpbsd9sq784YiZhelPqYur8qegL9lNRBAABFoVlscGSFIrczZ3nDM6iDVgQ33GAHr18V50h2NcIy6B5ibZtLr24fGFklexskoc8zD9PNGMxAN8r0sHIR2rwbLkfhL9h60j+wE8dCLGDTFfiia7C82kBldMH6oM7AwjnVrVsPGhrjbl/x+z1xC5LLksOI30VkCeGZ6A0qiT0yie5mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XbOFkehMqtKN49IOrKJT3Ue2E0ct3r9+fFNlvYJtPwA=;
 b=wM6JeZ/M0ayS6YqzRubweAcIlPiKA2QcBm579vg5V4+32VZREdYvZPv5WHNmkI+KkvVLLw0z3yc0dWWhm2Fb/F5RUL4I1w71OrGq9fmOgMKb8dSi4Q8/TdU5Ktzznidx//2lw2pKjaNR5wbdy3yxLZR1j8VW9hUK2wSYgNXIOwlFMD0pbh/450VV6d7U5+Q0xzXhWRibglraRu+RBd60+lr6y4ZvEdRG8N/KXnVCeN6LKbOBIFEN62mVgqTOVJ7YlfjgimuF8r79tFfsAuT4ZAKT7Vb/D1hUitLRy3J9U32P19/2GTjGHHtsZSHmNsfmazRcgQ6R7LUmp6A8SuSpmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by DS7PR11MB6247.namprd11.prod.outlook.com (2603:10b6:8:98::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Wed, 12 Aug
 2026 10:32:01 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%3]) with mapi id 15.21.0292.024; Wed, 12 Aug 2026
 10:32:01 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "Jagielski,
 Jedrzej" <jedrzej.jagielski@intel.com>, 
 "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v1 3/6] ixgbe: E610: do not
 disable LSE on driver down/remove
Thread-Index: AQHdCgYn9qcYcLnfVk6IF1+WPXpo67aadBBQ
Date: Wed, 12 Aug 2026 10:32:01 +0000
Message-ID: <IA1PR11MB6241FCE02F3C4A4754AC691C8BDC2@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260702091553.57112-1-jedrzej.jagielski@intel.com>
 <20260702091553.57112-4-jedrzej.jagielski@intel.com>
In-Reply-To: <20260702091553.57112-4-jedrzej.jagielski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|DS7PR11MB6247:EE_
x-ms-office365-filtering-correlation-id: 19ae897d-cbe0-4e95-3f80-08def85cf1dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|4143699003|11063799006|38070700021|56012099006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: PFVvmpp05XA+sHFt508DQh81mKQCZzSwVvtEzH2e/0N0W5t93rOJoPuIJiNEj3XHXmXhqwpoIFtTrlcOHpxZw/7nk1Wn8uY+McG0sVfS292lgR6EODQ9EeVMzx9nNK6sl/Asvc2gchBRDTlpd0FVlc5OFTNcGVwcX/sMSLloINi+Jbf8T0BYLbFGU5izEUhmzqnaR6jfoIRJpMiaKqQJNQt29Be9bRbJRk33oSKtvBFMwv9lssKI32+r/6ZdyKzTeQ6VPhYMCGWzToa1g7CRtv9hWrZ2dVDCsgTy3HmfGoci08inELCN4yHPJLM1Nn1xh9LuUrU+SbSK4YiIB/lQxJlNAVhmS5W/MvMD84bBovvV85Er54m1iy20hvv81gkxliMxw3ZzioYYnoHGhHTCf/yrqjnu9RUe6ji2W2LgXTegi816nCd83oDoOIGCIFQ1f2IQOP7xZZbpJtuc5PhvHg17b9p5KjSJYExvfvn0RbDY51HYUu49jwYfIIKi48NqOuBTbruRsK3tvNKvqucN52+ssqa3KEHG24Tlg47RjExTQrDgbqrGAbvjcG2q6kv7vBabop/63mKtsVlS5qXHBFuZXljplEjDEnDPjvxrXvNEMLK/r4wGR5X0ba19wzmSID+KAbb1qLHoCW+KM2LKHSydkJOBV1KVoHFbFiruzwCFeaigy3iedqTnJlp4FETXmQnHKEG9sOYDk4bjMROpvg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR11MB6241.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(4143699003)(11063799006)(38070700021)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PejxPFdUP1ZntEx+xe61f8uo+SiV82yhJq9H8WZv9VbzklxXn+923P0385v1?=
 =?us-ascii?Q?pBFo+chhdCzdKn0LJQiXCNSJLsZ+yEcyFf5M3/OFb0hMfnUJYk1/8e6NaURI?=
 =?us-ascii?Q?GMQiJIiNg4qaTUUH5fi78900ScqhYB7Nl5hFPAiOi5KRrRV3eJHYf6Buh+Zm?=
 =?us-ascii?Q?5tLQmESAajB19fb01DR4E4twMR5eNQjd1pRHm5lqL108ABiJ8E/9zed8xEih?=
 =?us-ascii?Q?wgDkKo7IRosIiTtDYrl9rihygsukelZXkoCpYHp9obTkh/cNuodcbK880KSQ?=
 =?us-ascii?Q?257MBxrqUBIdn+IGppm40FG7/zl7xUKF4I97aFJ5zUWwLZWZ00FLPHKztrsz?=
 =?us-ascii?Q?wfIkOLxlfvy2PFTPh8NxF3HoGD/aIxpIPwdMN0UBnXshmkhHrj05NmEFrv70?=
 =?us-ascii?Q?YAM8oLA4t3diVbkoj96RDXiBsbQie34+ycg7LHraD0iFZRFIFqa8jSDIQ2EZ?=
 =?us-ascii?Q?wTI9bqbDwC4R4dXY305OIk38twDeW0BAWyr5VtOCEtR1zqLdTwaZ0ik6MIps?=
 =?us-ascii?Q?ZXoBc22Y1h/1M8mW6N7x+ZA7+WnVXcaEWPx7a9pp72bKyiSOvsqAkHn7nMNi?=
 =?us-ascii?Q?cwarShZ6jtiFlols1wwLHHyJJEfmifIhWEm6Cl8kKUflfZtMoF6vhKVG4s6E?=
 =?us-ascii?Q?KpIx4j6kT0jMEZiO12PhWTdsCQ7JUjeZ3riOpDyNuUbhRnm7BRrHvI+xn4Aa?=
 =?us-ascii?Q?I3hYiIDfHw0bwOg6YwJQwtXip7t/L9NAtt+dL4QFTIZiSU/oJzzsoyJzLt8i?=
 =?us-ascii?Q?gse8ik4zmbXfwn8M/D+7iI3i+9SCNPRbWig2NtW9/gb4sHxitVrhWdwd/b6e?=
 =?us-ascii?Q?nui6GRUT8dvtZK3BU8bEa/LTXQsokQpx+FYA8DWp7nOBCayDK4yvF1uinMw+?=
 =?us-ascii?Q?0W3Y3coOa9oe4TxgnovstZt2WPmplm6sbSW/1l3cyxy2a1/M8vJSLxJzQ2XA?=
 =?us-ascii?Q?7V0sBmfbq+aRh8TFBZt4EMIye/dH/TRrGKlWawf0ZD1Ay+N0SXMbGj20HPHN?=
 =?us-ascii?Q?jXFaxhI/CExlxHkvIN+bWtndTIwLiETFslyM0ZEEXc7Izul+P+RpVJI+VL4B?=
 =?us-ascii?Q?B7g4LzT3H/5M7x9xT6+j1vShmEFVL7RgvA4UXRnCFFnwJ5l5Ei4v8SZKjQGU?=
 =?us-ascii?Q?gxSVhk/+5DjhPt88kKF0YO0VEDRb9Tp/tPXAcKwe17FmEImX403ak65c6vj5?=
 =?us-ascii?Q?zk21e4r+yGdgTygqCmSHxQy/4IcX2CcqdwXZ/7L5ZQm3qKqyVcNtFH14Dg04?=
 =?us-ascii?Q?yYuElZP0BtCyvbJkGTPDb0ZwAdcwAlQwv03fZfQnn9LI64Cmwb22/3BHdbmy?=
 =?us-ascii?Q?niKxC2U9rZKvtmZOKxbfGup7Bh8yUu6wkD/rdzNok9WCDrY+aSLfbmYlqXMm?=
 =?us-ascii?Q?amGvk6YjH0bD5xjANh0+lNPa0y+yUHXFKD0bO9y24RtIJUx4aY24KdSq9PXj?=
 =?us-ascii?Q?Nrt6QU64G7qPtqA+jiMqNCZ6UE2q4jezgts5U8VvkSnFu4RWe1B5Kyeiur9N?=
 =?us-ascii?Q?diN5ygRjmswq8jegJbr+bQncVT3qIOVcZoGnKQZZXNpxikg+72t6R00zP6Wv?=
 =?us-ascii?Q?DYj/vDcg24Ge4M7AbBkyhMN2nvjG8dZGmmT8SEPm5veOammh9SJPPGVmoMXy?=
 =?us-ascii?Q?M6pzdCNx4ecJ4RLVHUUGpQKnIjWDiHW3nZT6KSeuC9aD7/O+zKKPbL0uNdMU?=
 =?us-ascii?Q?0iOJrzSoyQCfNxAVwYNJv/JKGfR9f1+UO3ea7H65gwJ6EgVA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: IyNYGrrKmSS71EuZDTGY9USfAuruLPRFv/2ZXfwvBZGpMB0IHw/DBrUKbkXb1oZEYmtYOoj8LRRBtBJ3k1lov/VInMa9OKBvn61oqEMVhtnf+MDlFTNIBgqaVoOeclk9tDa1nWDqayqlVL7YUVeSxkrImXEEugCFvGyTxROgca7bMLQ+ykTj/tk0Qi1EemiVKn/KVnaELIaOyPoUUPlb6xHUDKFSDXUPq4YTf/yzxTA82najsco8gIMxdX3oSGgotbpuNzBBCHanEuDAcWD/3y10lM2s9GZRnd6uib/6IcrpqPdWSsy7cH5fhV0GCv+o/aLD+Pvbs1yCzBjWOBahgA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19ae897d-cbe0-4e95-3f80-08def85cf1dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2026 10:32:01.1578 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tVPY4ONdCzcsdG4gTEDz1c/AZ0XHeeW5jYjDObV/7mbYdfw7gmNHv5YQ+rsrb/q/E7xIW1IMREYU4gNpR1gZ4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6247
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786530725; x=1818066725;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=XbOFkehMqtKN49IOrKJT3Ue2E0ct3r9+fFNlvYJtPwA=;
 b=QH/gIprNczPyHtL0NSW80eyAWdZDW52iu7xtZIUQmOnpdRSjJurwiBBU
 b5rEMC/UKUUcVW3UtxPfRyHjLdyveSVzlnzteS+tPDRLUrOvHpoxsgzoD
 wAxiWjS7iQtrKPFOT/iS2ZER99XFX0MlCsxzR3odMM/MLF4fJ4f3q/4kZ
 nHzM9MAjRtFfIQf3bvh/vz3S2TKusWeZRcKgy0AK3k+NQmAFPCe6dnonR
 9XN+fsK28EJIciHs+u8tyuiWkhw2OAB1IwO3DVG+++Gkk8tE2zMF4HhMe
 QM2HVTvqoyzHgVFgU5tpTGV05y4rNslpx+WHZNoZ8DA8n/f6HD/R/En81
 Q==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=QH/gIprN
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1 3/6] ixgbe: E610: do not
 disable LSE on driver down/remove
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
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of J=
edrzej Jagielski
> Sent: 02 July 2026 14:46
> To: intel-wired-lan@lists.osuosl.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; netdev@vger.kernel.or=
g; Jagielski, Jedrzej <jedrzej.jagielski@intel.com>; Loktionov, Aleksandr <=
aleksandr.loktionov@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v1 3/6] ixgbe: E610: do not di=
sable LSE on driver down/remove
>
> For the first case:
> LSE especially shall remain enabled when interface is down and link watch=
dog cannot track status of the link. Then the only way for link update is b=
y handling LSE.
>
> For the second case:
> There's no value in disabling LSE when the driver's unloading is about to=
 be terminated.
>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 18 ------------------
> 1 file changed, 18 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
