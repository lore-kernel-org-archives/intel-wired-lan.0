Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71E59C5B572
	for <intel-wired-lan@archiver.kernel.org>; Sat, 22 Aug 2026 04:19:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 37A07810B3;
	Sat, 22 Aug 2026 04:19:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YD3rqRE1R2k2; Sat, 22 Aug 2026 04:19:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787372394;
	bh=o2U5C0YEmPLUDUuBpUlH4vgdBuXugZs6ezizCrYZIUU=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1hcPGS7OlRPbyNAigCpviMjXpPdUR3R1iDsdIODvtEwkx8eEo80e8RAC2LgNvZMBI
	 ioRpqn4Cz2MmcJBMiOkeAZERV/FIsg6TDpmND/zhoXKMybqCYcHT3Wo4gzr9I6dIjN
	 Xy/MhCowVrnCveJT6MC3rFqg4BedcQuOBPoouKYYnAFXptYapvXCfJqRU63PL7G1di
	 QDeVOuqLj7KLCtU1D36rQY4mdxvUUhEDC5q1jWskQqIv7PGVcts7nqC6X5YYoy/4cD
	 lTINKYrlCfmxAEjw35EG/us9K6Q5sSEUdp+nYwscfyKdNrtRhh704pYGmxTCe3Htc8
	 y1X3+NYkHtNjg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5DFC6810A3;
	Sat, 22 Aug 2026 04:19:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 789BD476
 for <intel-wired-lan@lists.osuosl.org>; Sat, 22 Aug 2026 04:19:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5F0E960679
 for <intel-wired-lan@lists.osuosl.org>; Sat, 22 Aug 2026 04:19:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eRWW6e4hpk4q for <intel-wired-lan@lists.osuosl.org>;
 Sat, 22 Aug 2026 04:19:52 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.20;
 helo=mgamail.intel.com; envelope-from=alexander.nowlin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=fW3EoW2P
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8300760643
 for <intel-wired-lan@lists.osuosl.org>; Sat, 22 Aug 2026 04:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787372392; x=1818908392;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=o2U5C0YEmPLUDUuBpUlH4vgdBuXugZs6ezizCrYZIUU=;
 b=fW3EoW2PydyluaRJ7UbJGTsha0YLQ0SdvmaEtifyi2b/qP+ziJj3qK1y
 9uX8bdPIX/AUkivpB5EENAFXn8oksxRbbBUdWVGbkmBmKt69qBibZd4z0
 1lg+6W4z2qcw/n9Kf77PpuS5R0L0b3YC8N7SFm+y8aHB9tLNVMpLR6DiO
 kqfaE2Or7iZAv+z94AM01dTaMxC7evF5ActOA8TzFiUqlEM/FciU4zQHK
 Tx8zfuKI5AmfFCvyivxFWi4UZ+uxKBDrnDP262sg64aylemddfiiLF8rf
 8kiCnurPojplWewkvEBdl2uUZ99/dmQ/bl6lmb3cdta787bLFZjvnIGSm A==;
X-CSE-ConnectionGUID: FSWnVehjQYiPQcr7m2TdpQ==
X-CSE-MsgGUID: MfcqvN6aTtmBwef7qQtAxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="87682317"
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; d="scan'208";a="87682317"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2026 21:19:51 -0700
X-CSE-ConnectionGUID: wfs1reUBTnuG7t+xTfP3rA==
X-CSE-MsgGUID: 6lQigIJZQW+vPxYjF7l6fQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; d="scan'208";a="262248150"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2026 21:19:50 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 21 Aug 2026 21:19:50 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 21 Aug 2026 21:19:50 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.66) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 21 Aug 2026 21:19:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iKBRBPvXSWPkICepPFI8ljJsdzkXo9COZFw1i/NYleOmV0dQVQHNHrCTJxo0rZVv1kFIjh/1TZvP34YDqn/jomnlaS/Ymol4UaygAqzpSFJWqUPXuAVFv9DuyylCRmXEUdjtnTy4jOYZl1GHtqTQJVZn4rT/L0KOEwnX0hhoSa1AIqgh9BpmfPYxUyWeMxmNvl+2Of4Lpn5UM3BFxbG4oKOBo5k42jvpgxrGJSuaDgZNoSgSO1ZwaCrZA+HcNAK4a1ckMMWPkkL8c6xt4hktlMTiBYuCqFeQ1xg5dUQdgXsKLfEdo6JOE3ZSx91gTCJRjCveF1M/znVNGr3ffte9XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o2U5C0YEmPLUDUuBpUlH4vgdBuXugZs6ezizCrYZIUU=;
 b=KdB1iRNYmW/+kjCKE50hyyFzvv1AXRSqbstCRCil32AV80nCVzJMnu4kNcuVsLK2o+VVcTViNFss4bpvQYjomIaNu3isTRDvNTVCIgaKO/UoVKM9OgGy8PgOgC56BlRVGQRpeq+qhDZ9Y8z6wcIB9Rx7yCHfPIUnZBUSiMeuzjDT3L9i7htuqDcjlkcFU3F3ybQtwL07amPZ11FDjOVRzoriRllOlNpatbKBEz/WPCKau9BeVZCTC+tWYsHWkbxstOowyzaHCUKrnWz1JJbAc3JhmKw45URUEcdd/s5zExMrAzjLigoDpjmnaQdPWBM1gy/H1m1ZtswkI6XNn4zxgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by IA3PR11MB992400.namprd11.prod.outlook.com (2603:10b6:208:61e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Sat, 22 Aug
 2026 04:19:48 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0315.014; Sat, 22 Aug 2026
 04:19:47 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, Intel Wired LAN
 <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Machnikowski, Maciej"
 <maciej.machnikowski@intel.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Korba, Przemyslaw"
 <przemyslaw.korba@intel.com>, "Nitka, Grzegorz" <grzegorz.nitka@intel.com>,
 "Oros, Petr" <poros@redhat.com>, "Bross, Kevin" <kevin.bross@intel.com>,
 "Cavatur, Ranjit" <ranjit.cavatur@intel.com>
Subject: RE: [PATCH iwl-net 11/12] ice: skip reading Tx ready bitmap on ports
 with no timestamps
Thread-Topic: [PATCH iwl-net 11/12] ice: skip reading Tx ready bitmap on ports
 with no timestamps
Thread-Index: AQHdMctPdGQw74Tbx0CpuU6Bz7QFq7apdzgA
Date: Sat, 22 Aug 2026 04:19:47 +0000
Message-ID: <LV1PR11MB8790D5E00B2D017A071B337490A22@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260821-jk-e825c-minimized-fixes-v1-0-9d0731eb4858@intel.com>
 <20260821-jk-e825c-minimized-fixes-v1-11-9d0731eb4858@intel.com>
In-Reply-To: <20260821-jk-e825c-minimized-fixes-v1-11-9d0731eb4858@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|IA3PR11MB992400:EE_
x-ms-office365-filtering-correlation-id: 1c8a6619-1650-4eed-e892-08df00049a4e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|56012099006|11063799006|38070700021|4143699003|10067099003;
x-microsoft-antispam-message-info: KHhsvMKBdNBUqC+GOSQH0NhYzrbL8qCbGDoTdc04S5sjko6wcQVI9gro7IQcbNAIROc/PHXqYKyhfiDwxQE1CMo1DTL2aVZBzylBnH0tbAu3bMkYpt+dQ2AjQp38TTyKkX5BzDHHo/Z4G+Z6dUtJ5bWx6dzJNzO3ThlHZbZ//JsXmO28Pdbc+EJqsFCIxv5o/zz3afFkgZmvNWT2vbB08Fm9Yrax5EUHR+bFPXo7oQATQYmLZZwhvDchdcZ+GMEHK+kgdczfAT9AP6em/jbZ8CWIBDfAOl+njf+FVKQAm5maCkvdMRauZcg+JIeQBb1yBO5p5413EZpFNz9KYGE/268Yg+ffGsiODvu5h6aEJTDEEz+3PhQ9KZJALq/qFmFg1FgHLBAwj3ypphD/OolJ+68OpzCll2GmzbDXNxK3vle6lvvepCqIlDNHLuYNw/RQyWwTTpPhh3KUMclOKPQMFykoqesX/ppFsiQt62w6HMlpqaPg3UtTZ71W3DnsWRM2tTbo0GQRMJ6oY5xk9K9afoNYd4IkpcNpJsAW5WOZcfhdD8Diu5SC6/r8N3kZci8j3aErhoDUA98K3hKmp3l1nIez0zO9kH5Altq0B+AHaJIycxztK7tSz8cJvKlM3q3NnoXfFoL9puQpFWw1GPiX679e0g22FWAtx+wznghWOosazLfDCtVu7BBZuEGQHyC//UJDTTEYd/7X6b6aZ+rx2w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV1PR11MB8790.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099006)(11063799006)(38070700021)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OXB0NTZ4MmorbWZmZVJkeW4xc2FkaTdwYVBndlZBTVdTSm1xQmVjdUZaWjZH?=
 =?utf-8?B?RVNsN2JkQmhJODNWVkxVc2lQbndmVnEwcTYrWElxZEM0SmRNaEdVY2U0dlVw?=
 =?utf-8?B?UkpsRGhRTWREc3NnVVhVRTdSb2xkb2VmbndsMmtTU29GSDB4N2tITzBNRXBJ?=
 =?utf-8?B?dHJMZ2xiYjd1MDZYUi9VS1hKeldOVjBXSTkyR0ZmTDlpMlZmUTloazBNM1hI?=
 =?utf-8?B?MW1KVTJoZzhaVkUyTi8rYXcvempseFhuMjRqZ29GSkxqRDIvcXBDSkJXVFJi?=
 =?utf-8?B?aDhjZXcwaUR4YXAvanhEZklZdklDbUZrdUdpVDdZWEtwQ1JQaWRERlVyZVVh?=
 =?utf-8?B?ck1rZkcrUzZ0TkJnc2FkaCs1WnlQdVcvZllKdnBtNWhhRUNKLzBta3MrYldE?=
 =?utf-8?B?QVBxM3ROWCtLMXpoSkwxNFFJREJORkR2MHNLUHZIbThPQy9pTjZpQnpWZ2to?=
 =?utf-8?B?Z0dkdUdvc2ZjYzZ2UkJPL01yNHJlbXl3WkUwSElRTVFLVU5NNmlaRnVFSnhB?=
 =?utf-8?B?LzBjTUN5TXBjeUE4bmZBSVFpcy9PMWhmeUY0ZENRT2lPeUlUNjArVFNPWkRo?=
 =?utf-8?B?Tkw2bndjWFQxQUNRUGJyQVVOWGorNktsbE8vZDBrcmRKWkVzVzdYeXZvWTFZ?=
 =?utf-8?B?c29pYVdZb2JEK3U5ZTNhRDN3amY0REsxaEs5ZU9RYmJFRW9uazNXL3ByUE83?=
 =?utf-8?B?cHRpMmlMaUpicW53MnRyeHVwbCswL0ZQSXVQYm1Zd0pkeWt2VllXZ2UrelM3?=
 =?utf-8?B?dnMvR3pXUjJPa3Zkb1pIWjZKV3IzYi9uT2xXcVdHdGNwdEIvM1p6MUwxYndU?=
 =?utf-8?B?UUl2MldFZGRTV3diM0ljWkZBY3VsQkJackR1SG14blZpYk9QNjdzTkt2VEdt?=
 =?utf-8?B?c0M4eG9rRmZtb1pEU3IrZDBMT3c2ZDRBREt2NXJIdFZUYWE2aElTTnM4bnFw?=
 =?utf-8?B?NUZ4bExkSFFjek9BSnkvNStlWGZWSzByeGRCcnlqUmlvcFFLRlZyN3lERmZF?=
 =?utf-8?B?SzlkbHplazBxMVg4S0xoRWV1RElyR3FrZHpBUjhacnVSZXlhME14T0Vqdnpj?=
 =?utf-8?B?ajNNRWNFWjhnL2pJTDRma0FKcGQ1M3g2cWFaZk5ZTWUwOGxnZHY5VktMK3Ri?=
 =?utf-8?B?SlE2OFo1REVqTjVFeG5ydVdSa045VGgwdXFkT2dPZ2IwVzAwQlhScmE5eFpr?=
 =?utf-8?B?MmNBdDBIeDNJTUxqQ0phODUwcFJYdEJWSjIrMmxpMHNiQ1E2WDJLUFk1aFMr?=
 =?utf-8?B?UWRZUVRPWWJ2RVZiVGd3YUdtUHZpU3NLelRQelMwbHlKa1VQcUc3d2NpR3NY?=
 =?utf-8?B?RVBaL0hSNHdWKy9nMjNXdThBT214TGZGYUZ4SnZhNGwvc1doN3E1eDR0bTQ5?=
 =?utf-8?B?bDdHdVdQMDFPL1ZKNVNINU44Q3J6MW84aCtHcVVPcGRJd1EzVWU2UzYybk50?=
 =?utf-8?B?YW8vRzRPampjazdheG5tSEdBZXc4WmVjQ0VOVE5aaGZQazFPcVNaM1lCeUNa?=
 =?utf-8?B?SXc4TnpwRW11VUFMZ2pmWFF5STQ1bUErZWRKbnVnNVZNMWxuSGpNdXJCMVZF?=
 =?utf-8?B?cklDUHVKODlJYlMyVlZ0SUxKZTFsYlhEdjhEQlN0Wk9ORVl3WVZ5Mm84Tkgr?=
 =?utf-8?B?NzZOeVEwSmR3Sy8xNW1ralVadnBmVkV1YUlnUDdoMmRIMk9TamNwUURoU2sw?=
 =?utf-8?B?QXZEME11Y3RoSkliNmZOem9CUHZPaGFvVmgycWtsb1RONnRrSEdWa2tTOTY2?=
 =?utf-8?B?VTlPMFROWE9aSkFRVnV5TWpGTVZQZURuZ0IwUTNEWVhUVUl3WkIrU3hyTlJ5?=
 =?utf-8?B?SmNLWXN1U2xNRUdBQ2d3S3F6QThETE4xa1BPS0pXU0ljS2h1M3NGendBZEQ3?=
 =?utf-8?B?MVVVcUp6R0dOa0JMUGZnWlJPZlNDUDRyQWlONFczUVMrUGxoZFBQQlkzcXhq?=
 =?utf-8?B?ZkdpZkpVUGN3UEpXZ2FIeldrb3FhMXFib0krQWxVVVJEdE9HQUFPck1obGVI?=
 =?utf-8?B?YkxMTHVranlPb3VYL29nYmJOMkpMWVM3Z1BHakI3dTNiTjRrb1BvOEFsVUNw?=
 =?utf-8?B?UE1Hb0JrbHJERHVIVVBMMFJvdlFFZDFBL1NGa3BibW1FVnJXNFlleE5qcUY3?=
 =?utf-8?B?NUdnZmtJRjU0ZkdMU29OdUZYTHFGZ2Z0M0RWZ3BiQWExNTR1Q0NLamVPdkNO?=
 =?utf-8?B?VjJhS0FiUXI3VzU5UzgrZVRNc0p5SkZYcXB3NDRrSWlYTXRoYyt3d1ZHTTVP?=
 =?utf-8?B?Zm1odmVudks1YmdLNTFGTDFDS2NSQm40d1FuL09pQmZCa0xNZkJrRnErbXgz?=
 =?utf-8?B?VFdja2xNS2dJTGE0cXpHdlpsSE5xdlEzTDVaNmszVlJrSGl4bVhqUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: AEnqeali0kUPSGT1HU8Ltp5QnqlDSxlBl8ZIZKg3N76IfAMePpKM1uVjQkOYODmOK61d6hcxhwhxPFaLv73IrZYdUkZdnZU9RMPz9vYAN9th6J6qTT3Y+G7nt148YNpSQesY/oRVulVsjBkz77f2YdDKK40N0WB1eABlJ5veY74SUyAr6qeaqk7jQdLdTonGdF1N2QpX5H9qUdVkRpiDeFhMDC7lYiiymI8Y1vUEs8FzDOiA/O9c9OjBU3no1uyXEkGDenWHGqek68/vHTFvsqRR4iJJd++5s/YqWDljN7gLhzyY1JEezn1AwiIU1bdZKXEy26SXeirs0fX7EI0flg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c8a6619-1650-4eed-e892-08df00049a4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2026 04:19:47.8447 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XQ2ELMkbqgtcVvCRmQoBRVTymB29G9oFXf1H5Yb81nvFdTNtxWEtghjsIFPMalD2tq0rCm/h+8fbHgjqt1oSKWQii85f2q3VNR4VuduN+Yw=
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
bGVyLCBKYWNvYiBFIDxqYWNvYi5lLmtlbGxlckBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFtQQVRD
SCBpd2wtbmV0IDExLzEyXSBpY2U6IHNraXAgcmVhZGluZyBUeCByZWFkeSBiaXRtYXAgb24gcG9y
dHMgd2l0aCBubyB0aW1lc3RhbXBzDQo+IA0KPiBPbiBFODJ4IGRldmljZXMsIHRoZSBpbnRlcnJ1
cHQgZm9yIFR4IHRpbWVzdGFtcHMgYXJlIGhhbmRsZWQgYnkgdGhlIGNsb2NrIG93bmVyLiBXaGVu
IGFuIGludGVycnVwdCB3aXRoIHRoZSBUeCB0aW1lc3RhbXAgY2F1c2UgaXMgZmlyZWQsIHRoZSBj
bG9jayBvd25lciBQRiBpdGVyYXRlcyB0aGUgbGlzdCBvZiBwb3J0cyBhbmQgY2hlY2tzIGZvciB0
aW1lc3RhbXBzIGFjcm9zcyBhbGwgcG9ydHMuDQo+IA0KPiBUaGUgZXhpc3RpbmcgbG9naWMgcmVh
ZHMgdGhlIFBIWSB0aW1lc3RhbXAgcmVhZHkgYml0bWFwIGJlZm9yZSBpdGVyYXRpbmcgdGhlIGxp
c3Qgb2YgaW4tdXNlIHRpbWVzdGFtcCBpbmRleGVzLCBldmVuIGZvciBwb3J0cyB3aGljaCBoYXZl
IG5vIHRpbWVzdGFtcHMgd2FpdGluZyBpbiB0aGUgc29mdHdhcmUgdGltZXN0YW1wIHRyYWNrZXIu
IFRoaXMgaGFzIGEgc2lnbmlmaWNhbnQgYW5kIG1lYXN1cmFibGUgbGF0ZW5jeSBpbXBhY3Qgb24g
cmVwb3J0aW5nIFR4IHRpbWVzdGFtcHMuDQo+IA0KPiBDaGVjayB0aGUgYml0bWFwIGFuZCBleGl0
IGVhcmx5IGluIHRoZSBldmVudCB0aGF0IHRoZXJlIGFyZSBubyB0aW1lc3RhbXBzIHdhaXRpbmcg
b24gYSBwb3J0LiBPYnNlcnZhbnQgcmV2aWV3ZXJzIG1heSBub3RpY2UgdGhhdCB0aGUgY2hlY2sg
aXMgZG9uZSB3aXRob3V0IGFjcXVpcmluZyB0aGUgbG9jay4gVGhpcyBpcyBmaW5lLCBhcyB0aGUg
b25seSB0aHJlYWQgdGhhdCA+IGNhbiBjbGVhciBpbl91c2UgYml0cyBpcyB0aGUgbWlzY2VsbGFu
ZW91cyBpbnRlcnJ1cHQgaGFuZGxlci4gV2hldGhlciB0aGUgdGhyZWFkIHNlZXMgb3IgZmFpbHMg
dG8gc2VlIGEgbmV3IG91dHN0YW5kaW5nIHRpbWVzdGFtcCBkb2VzIG5vdCBhZmZlY3QgY29ycmVj
dG5lc3MsIG9ubHkgZGV0ZXJtaW5pbmcgd2hldGhlciBvciBub3QgaXQgc2hvdWxkIGRvIGV4dHJh
ID4gd29yay4NCj4gDQo+IFVzaW5nIHRoZSBpY2UgVHggdGltZXN0YW1wIHRyYWNlcywgd2l0aCBh
IHNpbXBsZSBwdHA0bCBzZXR1cCB0aGUgYXZlcmFnZSBsYXRlbmN5IGFwcGVhcnMgdG8gYmUgYXJv
dW5kIDE3NSB0byAyMDAgbWljcm9zZWNvbmRzIHdpdGggYSBmZXcgb3V0bGllcnMgdGFraW5nIGh1
bmRyZWRzIG9mIG1pY3Jvc2Vjb25kcyB0byBiZSByZXBvcnRlZC4gV2l0aCB0aGUgY2hlY2sgdG8g
c2tpcCBlbXB0eSBiaXRtYXBzIChhbmQgdGh1cyBza2lwIHJlYWRpbmcgdGhlIHJlYWR5IGJpdG1h
cCBmb3IgaW5hY3RpdmUgcG9ydHMpLCB0aGUgYXZlcmFnZSBsYXRlbmN5IGRyb3BzIH41MCBtaWNy
b3NlY29uZHMuDQo+IA0KPiBGaXhlczogZDkzOGE4Y2NhODhhICgiaWNlOiBBdXhidXMgZGV2aWNl
cyAmIGRyaXZlciBmb3IgRTgyMiBUUyIpDQo+IFNpZ25lZC1vZmYtYnk6IEphY29iIEtlbGxlciA8
amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0
L2ludGVsL2ljZS9pY2VfcHRwLmMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDEgZGVsZXRpb24oLSkNCg0KVGVzdGVkLWJ5OiBBbGV4YW5kZXIgTm93bGluIDxhbGV4
YW5kZXIubm93bGluQGludGVsLmNvbT4NCg==
