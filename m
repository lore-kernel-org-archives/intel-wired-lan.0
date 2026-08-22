Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE81C5DF97
	for <intel-wired-lan@archiver.kernel.org>; Sat, 22 Aug 2026 04:16:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8BE9660870;
	Sat, 22 Aug 2026 04:16:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NHbNiBXi4qvH; Sat, 22 Aug 2026 04:16:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787372214;
	bh=Elf2g/5CPkSVPGK/BPIAfbkMqi2fGTnzd+Pu36gpmfk=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AdpeAPEBcYfzSPw7cUtZ8/bqDZ1KpMcUj7daMqXHqoDs5CrtzCYoxC4vaP2Hpaf29
	 tr12EjARU+nC/kNMHrIh7HLquuiVRnRJJEM2anhZeqmCbloPs8KnpQwryp33y8Gps0
	 BbkqFRiM8GRItBMSgOCnmWGYQbUA0mCKPXNQJ/6QitjQSCAfYyLKvngvR+exZ9EB9o
	 vEJg0O9lLTLjXWiwge5Q8jqVDkIObaq2xuUEdZONWR1MlEhzsFTt1evrueSoWbzDg0
	 B8J7PtOB7q5c6yMu1ERDBBqUFTvq9c6WRNEdNPrpyVbWgpEW/goXdUKfHKd+J3wDuk
	 9EMl6ptbQ5GiQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AE79760679;
	Sat, 22 Aug 2026 04:16:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D491C4B8
 for <intel-wired-lan@lists.osuosl.org>; Sat, 22 Aug 2026 04:16:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C68A040097
 for <intel-wired-lan@lists.osuosl.org>; Sat, 22 Aug 2026 04:16:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KZixvWoV1CRS for <intel-wired-lan@lists.osuosl.org>;
 Sat, 22 Aug 2026 04:16:52 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.13;
 helo=mgamail.intel.com; envelope-from=alexander.nowlin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=DdEk30/Q
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B45E840125
 for <intel-wired-lan@lists.osuosl.org>; Sat, 22 Aug 2026 04:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787372212; x=1818908212;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Elf2g/5CPkSVPGK/BPIAfbkMqi2fGTnzd+Pu36gpmfk=;
 b=DdEk30/QXqxc/QGfz8Ba53bICuakK5YMdTnvTwJduTHzXjA6EbZh46ZN
 7bW4/VhmJGjHe6OKeHjP2AfQ/sX5+YzW9wIX8qDK/CBfS8YJH2bjPiMsl
 QBjS0Deug0o7xU853LA/ntcNE8oL8YVog7NpvGksqFdiCuJwFl3ItarkE
 K7rSA4O5xcZFJoPcMjkITNtPphC7l2Iek5XDWMgBvvRNTUhuvjA/OEjgG
 3nc8Huq1YGX3BA+U+ESnG6Q6z+pbDE+xt1xADSh+G23/UfbUu7TFsgYOb
 x9gxN1J5GkiefVVKX7nFa7GRAhknlXfop32L+lopMr7d7+ACrP4DlAGzt Q==;
X-CSE-ConnectionGUID: AI0X/C/KTEaY5/si/mmhLQ==
X-CSE-MsgGUID: PySTyVCsTVOyJwC0JSuiXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="99074589"
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; d="scan'208";a="99074589"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2026 21:16:51 -0700
X-CSE-ConnectionGUID: 2uSx4vXPQG+ldxkwRhmJcw==
X-CSE-MsgGUID: D2D0W4EHQDyjsLBKUNaiIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; d="scan'208";a="296423314"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2026 21:16:52 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 21 Aug 2026 21:16:51 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 21 Aug 2026 21:16:51 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.46) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 21 Aug 2026 21:16:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XE4HnFgU3f+qWkRxN+9UUD0OrlnpF9/AS24Igoqi5V7CAWAhK8LBAHZjbRhSduLrhNiNVgHxCKs1hNXAcdTdmkvbB2lMyxE1dCcVgM5unw1cTkSUrNu6QyCgl/qt0FDBgsJAxA9QRXIghOs/D+vCOHqeCgEaxrf5UkjfUOX6OtXYdSnBOgG/JbUWGtF9GAHPEB7oHZ69LUuEjtH6pMbMPmTksntvs6mx7BLbCq+27UVr/vwl7zZQ5rlsf3qjma02rATdC+Rm/POvKu2nOCWTe48KV1czgNloApHduV0F40f0SXdLHhoD0vweQjhqYNrUKOnMshLYA/xroGlWskA3Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Elf2g/5CPkSVPGK/BPIAfbkMqi2fGTnzd+Pu36gpmfk=;
 b=wcQFGAt9Mi1c9PcqyTbPPUktqwaSm99sNRf2BUvDoxqVkRclcaEck4KAq6YGxPpK7QdRQ3NKpStsAysdMoe41vZiNz1+aFumfWl90mHW0ntmLwtyadn9XeE3MhTmP+3lsO/QWb4miKItDVSjBx6AhfnncLnhy02COdaLuiVFCYDlcNJT4uiI/DhxNkYX1++sYKXtGTs1zq19QWEk8YDCMbmVzgfz/Z+kQPYXe0u2yh327atBeu3xUe/b9CiZ7mfahSjPNSqsjQiGQstWKlPDLdEEUuZ30k7NSRYfARfm82zDkSi1gy1NFly4XtxLx/Np/LSwjBEq73H863ENl/Txkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by IA3PR11MB992400.namprd11.prod.outlook.com (2603:10b6:208:61e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Sat, 22 Aug
 2026 04:16:48 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0315.014; Sat, 22 Aug 2026
 04:16:48 +0000
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
Subject: RE: [PATCH iwl-net 06/12] ice: E825: clear PHY_REG_TX_MEMORY_STATUS
 prior to soft reset
Thread-Topic: [PATCH iwl-net 06/12] ice: E825: clear PHY_REG_TX_MEMORY_STATUS
 prior to soft reset
Thread-Index: AQHdMctJJFbyZYMn1EaViwiz6aliU7apdlKw
Date: Sat, 22 Aug 2026 04:16:48 +0000
Message-ID: <LV1PR11MB8790C9556C9CEEF54A10B22D90A22@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260821-jk-e825c-minimized-fixes-v1-0-9d0731eb4858@intel.com>
 <20260821-jk-e825c-minimized-fixes-v1-6-9d0731eb4858@intel.com>
In-Reply-To: <20260821-jk-e825c-minimized-fixes-v1-6-9d0731eb4858@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|IA3PR11MB992400:EE_
x-ms-office365-filtering-correlation-id: 1e0d29de-2447-4771-0944-08df00042f72
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|56012099006|11063799006|38070700021|6133799003|4143699003|10067099003;
x-microsoft-antispam-message-info: gSFWXfz69WY4sPI3HytgE2240xiUd6NY3laPPwUIKS16HcU6SXDaxehHNFD1/wh04EdfGbocs+fG2P9kYnW2C3fRu592ZGGpUAfGTjdbw+wUvqSmqawb8lYriyj+NnU5RrY/+b/FnC3OXBY6TofxHy/726jdgPk25f7pzdFt/uXF5w/BMD6xQxTQeBR9c2h1Fy1Z/43NC57s+RviC4pMWluU00LcYVj+N/zhn9FW2lUaUgDfHnqvIYR1TyzECd0mTTP6sdJPizawj6+yxm5t1WKPmLKd/9KXeOxm7gTjWq/CvMfRlDcSzXAscAGEGWZ+CRQLCrNEnSd/7Owmk9uMwYw2ajBVp7WaCtER/NAXjL58htqFIPlzGCNyLKCI94JyZWJoxFfb+BU6qUssOOsIxMla9zY0M25aVvHeNy63y3OyxWgmEn799fIfnNLa5b90ZWxNGvu49m1pUToSA9UW2LdQm8yD2LEOuLzmfYcMCDfz5r0Tm0Oe9wuzSRsH4u8SEaJ6fNZ8lreEctHh9HhKdFIyT8L87dWwzQVNqH0GJj9cwszTwu93LZcfuHn03bJwSkvt/cXDqi8oAccAlYQADuRAzx5ePf2UyKCWDTIiRdiMoicLA4Wunh3CoUz0S/IjDg2bipXyrt1Bwzj5OHmaLuqjOeb2cdisQF+j1TDw91vpt6qRr3v2DhYFFynXrsm4JjIeG8iRGEFfTombqFqUtygm548PZg+AkmsSVZ8fWfo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV1PR11MB8790.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099006)(11063799006)(38070700021)(6133799003)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N3V4elc5bTd3MmdjQ2pNK3BZMWk5SDF1UWI0VUNlRkYwQnhodmpOTG5CUUF6?=
 =?utf-8?B?b080SkhlZzlReWwzaDM5ZWJMMDBkY3YzY2t6YlEwZjliaW9GdzMwZ0NqbXM0?=
 =?utf-8?B?K3Nka1NwVlZCWmoyTXFKOThjd2FOZFpYamo3cWNZTG1JWVJidXgzUnpNWGk2?=
 =?utf-8?B?ZWxZelN2akJMVzBWcW9MeDFSUnRZT1BReWdJOGZyZjErSDdJMFAyQml5UENR?=
 =?utf-8?B?Uzd6TVdRNzZYNWt1aXdCQkhIS0s5WVpuNGg5eThlaU5vUmNKTnNBVmhpT1hs?=
 =?utf-8?B?U09UN3VZZ3l4dGkwUmFJNURwZG9TU3Z1dHN6TVVSUHIzbVg5enFVK3lLQWRv?=
 =?utf-8?B?eGM5UTJDak5wTkxlQjg1SGNQQitLbWd2N1RwcEM1VDFrMHR2S0hjdE5icDJQ?=
 =?utf-8?B?NzdqUWVSV3FGMGJhaHVqcGN6aHNqYkFCbGFmUWhrOXhGY0dwSEtFbkNRdm5T?=
 =?utf-8?B?LzZUalFmb0JpYU10OXJDLy9IaVpjVHBxNlpEVjc2Y0dveHhBOVIzVFNZM0JU?=
 =?utf-8?B?djBtQ0x6UDgzdUV0WHVOUzBhbXVhSGlmYVBGc1VYdkdxK0xLM3hsY0d6akZH?=
 =?utf-8?B?OGc5cnFyNFZkSCs3b0tHVE5XYlh4RlIrWTRKZ04za01EZXkzTlU1WENCWVAy?=
 =?utf-8?B?ZWpIaUcvL0dhZU5LMDc5N3ZLZFJmaHRTMlNsVW1kWGJOS1NFRWxZQUNrRGFp?=
 =?utf-8?B?RDNFQlFSeVJKMHRaN3VlbXFGL0FOTldHcldwRDZZdjNmNkJ3ckg1VlBubCsy?=
 =?utf-8?B?dUVVeGZBaldvdExvbXN0TWtQaVJ0OEJvZWNnREdtSEJkbmcwd205VEQ5Tm8z?=
 =?utf-8?B?dUdURFY2QjE5QjdEVFdNR0RKVHN1a1BmWVFhREtMRHNJODJsVjloSGxXbGo3?=
 =?utf-8?B?RktkL05YV3hlMjRKbnVpWmxDa0E5dk9qVDZZT2pHYkgxOWd1ZTNkKzJuQXRQ?=
 =?utf-8?B?WHZpVE9YK0Q4NHh6emVQaCtxV21rUjRGZmNMKzd0REpnd0JEaGZPRTl0ZkxH?=
 =?utf-8?B?cHdRNlo5Ulc5UWtpYW41T3dWNi9rNTZzUzI3M3pFUkpSVjgwVk9wNzJxMFpB?=
 =?utf-8?B?NUZuTWRKanp0RkJQV1FMMElmVFg1TkFLQll6L3dacE4rYjc2cUlxa1dOaTBZ?=
 =?utf-8?B?UndwbndLSEZaZmozNXdodTdWcVNmcWtqSmxRWHdhcHVtTHRQSmUvN3hoUVpK?=
 =?utf-8?B?aWZ4N1hGYXNUUmhJNU5KbU9Lc2NzZ2ZuVEs1RExlSloxb2JXeGxEMDRnZjZi?=
 =?utf-8?B?L1RuaFJaSU91T2ZCakRxQ3o0Rk1aR0pWMHpZTDVBVkRoSXZwbGY1QUF5YzI2?=
 =?utf-8?B?QnQ2ZU1qbjVCRU9kQW11eWx6QzZVSUxnbW9IR0pIaFRoZXRJZE5hT3VERGxS?=
 =?utf-8?B?dVZWMHRFenZHbDFxQkl0U1EzcUxQem1lREU2YnhING1IY24vNkN3ZHREdGpa?=
 =?utf-8?B?M1RhUXJHeWNmMWdqdlY2a29EaGlnVjc0NnpySDJhbUVYZ2QvcXlJWUhOdnBl?=
 =?utf-8?B?ZFN4VWVJWWx1cUZGbURUcks4L3IyWHNDSko1dzIzZ1VJVE44VHQ5TWdSYzQ2?=
 =?utf-8?B?UUxieTlRU1B0L0MvYzFTb29TUThNSkZyWWVXdUtJSzVrWFBDd1FlMmc0VUpM?=
 =?utf-8?B?SnZvSllPbTVtN3JkZ2RWMGNvUjJRbHV0THVndVNMVTh0dlNVekZwMHpoRkdi?=
 =?utf-8?B?eDRKMkZydEpkRnpGZDJXMVliYVhEcEZKR0I5RlFWUVp1bjRKOE5ORlNsM3Bm?=
 =?utf-8?B?NnJ1VTI1OTBuZ1RQcnhhaXJjdk5pRWJJbW5WNUkyVmRkQU4xK2VnSVM1clJu?=
 =?utf-8?B?QnM3K2RGSmRHTlZ4MTJDbStQNDZQTEVpL3p5alFJK0lyWHUzUWtaVVhVMkxz?=
 =?utf-8?B?NHY5NVBrOGVSVlgzSzlwdlVGaVFlR0VCQi9wOFdrb1puR2VodEMwN3dQelE1?=
 =?utf-8?B?M3FrNFoyTlNVK0kxMFlyUDlBSUhFVHU5UllYdGNUbzBUc3hUaC9icUxWVU9D?=
 =?utf-8?B?RXBCclp4QmFZSEJScit5Yk11WkVGU05iUHFhS0VzME5YeWFTNSs1ZzJkNzJF?=
 =?utf-8?B?eW1aREhhcFhLTHJkWDJsb0o5ZnByNFFOOFhiOHZLTTIzazVlTCtGNlBIV1I0?=
 =?utf-8?B?TU1RdWFVdjF0elVKK0Q1RmppMmhtVEFJZ1RRWmhVMGZ6Z3MvWkt3ZVZUL21Q?=
 =?utf-8?B?SjRvVWRjb2NGTGpaNDc4T3FaU0c5Q1EvaVlTNHAycXBxakZHbHZwRXVHNmM5?=
 =?utf-8?B?VlBqVGx1c2IvWlVUKzhUTzBJQ3plWjNpRG5zTm94Q2U2aTlwL1hYaVV0RVJI?=
 =?utf-8?B?cmNIcnlKWGdIMm9HelBpVldrNWZKdDVNOVdWbFBFRkFmMlQySjMzQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: nCfTZMzZGnTF0wmgNyjUJyScPkUYX++pnmVxdY07khETVgxUAHk8Qo+u7OmRKJEHYJd1s8D2S95KBtQGedNaRTwfiOsX28+34+tZ1OT8gLOwaC0MyBYm9yGjN/Rojzg7LJehjm5P8wuIyxy/0c/cFUhoZvbcQZol5By7TZr73tW5aKx4IGlhvfktHU3aGg2/bF0Gjw61paCz4j+pZNbkLMqaYsS3tCKNx6456P6wrThp2GI9gIyQNkDL8w6aIatQi7kWyQ61fWaox3xLKZ0OCdAeNFNXQLcq8crB4BovU4wrNpwASf+PknC8/tYGSVI+FXZZBBKIbzwMmxzeclS7Jg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e0d29de-2447-4771-0944-08df00042f72
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2026 04:16:48.5426 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zcpueVSVTI505z8T+E+YAePkTsVirqO3kwvioiYBhFk4B0h3KRFP3WQddRN/mCDcwpBOCDkf5GwuBcl5lw5+g8XVWI4K36AqiqaRVeXQ2O4=
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
d2wtbmV0IDA2LzEyXSBpY2U6IEU4MjU6IGNsZWFyIFBIWV9SRUdfVFhfTUVNT1JZX1NUQVRVUyBw
cmlvciB0byBzb2Z0IHJlc2V0DQo+IA0KPiBUaGUgZHJpdmVycyBjdXJyZW50IGltcGxlbWVudGF0
aW9uIG9mIGljZV9wdHBfcmVzZXRfdHNfbWVtb3J5X2V0aDU2ZygpIGlzIGZsYXdlZC4gSXQgdHJp
ZXMgdG8gY2xlYXIgdGhlIHRpbWVzdGFtcCBtZW1vcnkgYnkgd3JpdGluZyB0byB0aGUgUEhZX1JF
R19UWF9NRU1PUllfU1RBVFVTIHJlZ2lvbi4gVGhpcyBkb2VzIG5vdCB3b3JrIHByb3Blcmx5LCBh
cyBpdCBkb2VzIG5vdCB0cmlnZ2VyIGFwcHJvcHJpYXRlIFBIWSBhY3Rpb25zLg0KPiANCj4gVG8g
Y2xlYXIgb3V0c3RhbmRpbmcgdGltZXN0YW1wIG1lbW9yeSwgdGhlIGRyaXZlciBtdXN0IHJlYWQg
dGhlIHRpbWVzdGFtcHMuDQo+IEhvd2V2ZXIsIG5haXZlbHkgZG9pbmcgdGhpcyBhcyBwYXJ0IG9m
IGljZV9wdHBfcmVzZXRfdHNfbWVtb3J5KCkgaXMgcHJvYmxlbWF0aWMuIFdoZW4gcmVhZGluZyB0
aGUgdGltZXN0YW1wIGluZGV4LCBoYXJkd2FyZSBraWNrcyBvZmYgYSBjaGFpbiBvZiBhY3Rpb25z
IGluY2x1ZGluZyBjbGVhcmluZyB0aGUgcmVhZHkgYml0bWFwIGluZGV4LCBhbmQgZGVjcmVtZW50
aW5nIGFuIGludGVybmFsIGNvdW50ZXIgaWYgdGhlIHRpbWVzdGFtcCBpbmRleCB3YXMgbWFya2Vk
IGFzIHZhbGlkLg0KPiANCj4gVGhpcyBjYW4gcG90ZW50aWFsbHkgbGVhdmUgdGhlIGludGVybmFs
IGhhcmR3YXJlIGNvdW50ZXIgb3V0IG9mIHN5bmMgd2l0aCB0aGUgYWN0dWFsIG51bWJlciBvZiB0
aW1lc3RhbXBzLiBUaGlzIG9jY3VycyBiZWNhdXNlIHRoZSBQSFlfUkVHX1RYX01FTU9SWV9TVEFU
VVMgcmVnaW9uIGlzIG5vdCB6ZXJvLWluaXRpYWxpemVkIHdoZW4gdGhlIGRldmljZSA+IGJvb3Rz
IHVwLiBJbnN0ZWFkLCBpdCBpcyBmaWxsZWQgd2l0aCBnYXJiYWdlLiBPbiBhIGNvbGQgcG93ZXIg
b24sIGF0dGVtcHRzIHRvIHJlYWQgdGhlIHN0YWxlIGRhdGEgcmVzdWx0IGluIHRoZSBoYXJkd2Fy
ZSB0cmlnZ2VyaW5nIGEgY291bnRlciBkZWNyZW1lbnQgZm9yIGEgdGltZXN0YW1wIHRoYXQgbmV2
ZXIgaGFwcGVuZWQuIFRoaXMgdW5kZXJmbG93cyB0aGUgY291bnRlciwgYW5kIHByZXZlbnRzIG5l
dyB0aW1lc3RhbXAgaW50ZXJydXB0cyBmcm9tIGJlaW5nIHRyaWdnZXJlZCBmb3IgcmVhbCB0aW1l
c3RhbXAgcmVxdWVzdHMuDQo+IA0KPiBXZSBtdXN0IHJlYWQgdGhlIFBIWV9SRUdfVFhfTUVNT1JZ
X1NUQVRVUyBpbiBvcmRlciB0byBjbGVhciBzdGFsZSB0aW1lc3RhbXBzLiBCdXQgZG9pbmcgc28g
bWF5IGNhdXNlIGEgZGVzeW5jIHdpdGggdGhlIGNvdW50ZXIuIFRvIHByZXZlbnQgaXNzdWVzLCBw
ZXJmb3JtIHRoaXMgY2xlYXJpbmcgYWx3YXlzIGFuZCBvbmx5IHJpZ2h0IGJlZm9yZSBpbml0aWF0
aW5nIGEgUEhZIHNvZnQgcmVzZXQuDQo+IA0KPiBUaGUgc29mdCByZXNldCB3aWxsIGNsZWFyIGFu
ZCByZXNldCB0aGUgaW50ZXJuYWwgY291bnRlciBhbmQgdGhlIHJlYWR5IGJpdG1hcC4gVGhlIHJl
YWRzIHRvIFBIWV9SRUdfVFhfTUVNT1JZX1NUQVRVUyB3aWxsIHJlc2V0IHRoZSByZWdpb24gdmFs
aWQgYml0cyBlbnN1cmluZyB0aGF0IG5vIHN0YWxlIGRhdGEgaXMgbGVmdCBiZWhpbmQuIFRoaXMg
Y29tYmluYXRpb24gZW5zdXJlcyB0aGF0IHdlIGFsd2F5cyBoYXZlIGEgY2xlYW4gc2xhdGUgd2l0
aCBubyBzdGFsZSBkYXRhIGFuZCB3aXRoIHRoZSBjb3VudGVyIHByb3Blcmx5IHJlc2V0IHRvIHpl
cm8uDQo+IA0KPiBGaXhlczogM2VjNDZlMTU3YzdmICgiaWNlOiBwZXJmb3JtIFBIWSBzb2Z0IHJl
c2V0IGZvciBFODI1QyBwb3J0cyBhdCBpbml0aWFsaXphdGlvbiIpDQo+IFNpZ25lZC1vZmYtYnk6
IEphY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPg0KPiBSZXZpZXdlZC1ieTog
TWFjaWVrIE1hY2huaWtvd3NraSA8bWFjaWVqLm1hY2huaWtvd3NraUBpbnRlbC5jb20+DQo+IC0t
LQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9wdHBfaHcuYyB8IDg5ICsr
KysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNDcgaW5zZXJ0
aW9ucygrKSwgNDIgZGVsZXRpb25zKC0pDQoNClRlc3RlZC1ieTogQWxleGFuZGVyIE5vd2xpbiA8
YWxleGFuZGVyLm5vd2xpbkBpbnRlbC5jb20+DQo=
