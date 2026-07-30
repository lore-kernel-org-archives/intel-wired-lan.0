Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B5EC531D0
	for <intel-wired-lan@archiver.kernel.org>; Thu, 30 Jul 2026 07:42:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 427BD607C0;
	Thu, 30 Jul 2026 07:42:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RLapX4xVf5Jd; Thu, 30 Jul 2026 07:42:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DD828607B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785397353;
	bh=MSopA4S5cenhVgII3qBmoBxlcSjtaJPYug1Ue1VbfQE=;
	h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OocZUNdm6F8/X8YHsQB9L1rqwXMix+n9xxYo+I7dGgg+v7z9skhoEjfN6/KmgHFBC
	 bF876/D7N8MMj8T6S7LGQ6UYYMqZ7YAxf1x1Og50lM2MvjsZJIczkHk6I614JmiaFu
	 lRyY61J36gqvGOWVdcx1Xzi5J3TWBEaTrcmTB19Fw8r5+gAIaNuwD+wVYndl7TYsv0
	 NboxfMP4I0ObxDLeMU6IwsqVnMK8vQjmhLkZsOcxb0lbxunJkuJb1x/snOE+xinXWy
	 vlqvxWgF5Mbhqjj7xld6av8hESX7xmXAGRXihpPECgpUpnFfy8rIUkPAl90HYraJYG
	 EXyrs0HZhRxZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DD828607B3;
	Thu, 30 Jul 2026 07:42:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 719AC350
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Jul 2026 07:42:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 63B67408A1
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Jul 2026 07:42:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3pEaRfpq4lBJ for <intel-wired-lan@lists.osuosl.org>;
 Thu, 30 Jul 2026 07:42:31 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.14;
 helo=mgamail.intel.com; envelope-from=sx.rinitha@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 5BC4F408A2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5BC4F408A2
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5BC4F408A2
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Jul 2026 07:42:30 +0000 (UTC)
X-CSE-ConnectionGUID: J7r/OhKtQ8uDKaoXcVyUpQ==
X-CSE-MsgGUID: cdvDlfroQsGq1/iTRK9anQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="86048342"
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; d="scan'208";a="86048342"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2026 00:42:27 -0700
X-CSE-ConnectionGUID: bkMkJpNRSvK/XDlXMxhlwA==
X-CSE-MsgGUID: T7Cd1TBoS1CS21n9PKDdoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; d="scan'208";a="264043949"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2026 00:42:24 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 00:42:22 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 30 Jul 2026 00:42:22 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.18) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 00:42:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bDH7tgHQoBnuGH1tQRBw9cPXe/82EzQayP4abzB06ZQVqRXC3uc9GCereDRqA8BkfjMM6OHovUG6K42gq0kpM0n5WxcB4147sfD1DQPIurFxbQ9J/F1OywdEQblPAy2LNjp5yCr6Oe//xSGOu07/ExIg1aiDIp3gda4zoKgn0T7Cak0PhO2kDizpLHquC8owsoqUOWIMYgAtW2aOa+DrJlzgkQswVqb7p8Fufumhfu4He9nSyXGSKz9BY07oAndISodNqMdstg83Kon+Ai5oNJ2mhbcYjN9+H7eW2eLpnDlnvDmFmgRdXW6NouD/KmlLujc6Pn06X0QXsfm97jhJ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MSopA4S5cenhVgII3qBmoBxlcSjtaJPYug1Ue1VbfQE=;
 b=kssq8pbIFdZNf0M04qHkXCIxdsmOSftfcHZrNat/pVceH98xAYz6mwf1mnsEtWi/YrW6ubqwejcI6sKyN3MSQ5boX7J+TFbqL1X0ZcqKgMKFCw3jJtCqW6ugq2W/Fyyl0pcEmlR9OR0JdMV9BLeSBxYxdflqe8wxgp4P7AZ2rxJWFBN5MtnC7d1K9dc4Yek/o6XdHt/64f/pIPLgJBkCoc5N7NZW71OdXj/C06ZQqt8zseOVzJTtxiHjxfHpevJy25LTP0QdWsB0xiouW5c03a/mSjt2Uvzb9NwwipO5Ty3NTFf4k2wvOhPko6wBmZh0Q+uSuIXZ/5G7Nb0WCdRH6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by MW4PR11MB6888.namprd11.prod.outlook.com (2603:10b6:303:22d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.14; Thu, 30 Jul
 2026 07:42:20 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%3]) with mapi id 15.21.0270.009; Thu, 30 Jul 2026
 07:42:19 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Loktionov, Aleksandr"
 <aleksandr.loktionov@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Simon Horman
 <horms@kernel.org>
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v5 3/4] ixgbe: fix ITR value
 overflow in adaptive interrupt throttling
Thread-Index: AQHc5J23r+sBxTScoUyTL4rhwgZLyLaGJDnA
Date: Thu, 30 Jul 2026 07:42:19 +0000
Message-ID: <IA1PR11MB6241D8BCE8460789FD0CBCC58BC92@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260515090000.5112345-1-aleksandr.loktionov@intel.com>
 <20260515090000.5112345-4-aleksandr.loktionov@intel.com>
In-Reply-To: <20260515090000.5112345-4-aleksandr.loktionov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|MW4PR11MB6888:EE_
x-ms-office365-filtering-correlation-id: dd623fdc-c41c-4b36-823a-08deee0e15a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|38070700021|56012099006|4143699003|11063799006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: nCMRb3TBc4TKEqO5SH1SbfAwSww4IO+WypmpqKMIpqhK+CedjAP8ut7jVVlz565cVyFXFxTka4441j8otOCAUsaJKEMVaYtBX/SHnPg+Koe0/MZht40RYOqnUkjpv1QGguBJiyHAQu+LzsvEqN8GAXqHa1A2MniLiOINY+Aiv9yjsd1WiaJjMAqIOkhPba4gSdnsln3ug1vHgeSIajnNP2FmQ68/c/+HRy+29wnpjwQrYQGwivF/pUJ2OSJ1XA/r+VBxkZw1xBy5LVsNatHtZaU5dQ5vRIJwAfMYJt9VR0Edr+spbJPJDKoNReVB3AbledzV6cWyTrs9X8kNMuWBp2J7r0Jary5qWJR6+0Q5Wendoo7lIKrxiz4vSE7ePn6HmKcX/cce+Ab7ctcNx9C24x5M9O0+1i7FR8SizDQM2cLebxIIRkuXPcgm05PJndK3dlUdidSdoFHQxphPRfFjzjqJYdYl4AWW5+2eaguR/iCTkpzcgigCFmEGJOvcP2epsiNbg6PNyL3u6mP8mB2o8ALE9cfZBD2vrjfDYj3Ll8NBbtx8SnV8iqTmQAiO8Fa5srXD+WXLkPXAKSc9wZKmZEkfbKEXSTQjAOF9ryhA0KPXkny+UYy5K5XGLA7FUyWlP2mO0RdgqdHcvpB3YjfpdZsamFQjCuS6IDXWjKoZBwnYB3Lmn/mxSU0bCBNZjJFSuT/HfpTDJ+zkS2RGFE4xojUd56dgMBvanQPdCa2miH8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR11MB6241.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(38070700021)(56012099006)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eXkrV3cvN2lHNTJzUWx3MXgwUmQ1cnVUR1JySW9mVkRLYWVnQ1I0SjhrenhF?=
 =?utf-8?B?d3RoS2dqUGtzSXNsTnVRNmhjN1RJd3YvQjB0T1pzSlRZZEdFaUFwZnBySHBN?=
 =?utf-8?B?MFZBY2oycHNCbG1Xd29ZRVE4UC9VSXNZWEYwZzBCTnlpL2Q5NG12b0RWRS81?=
 =?utf-8?B?bjhCcUNRVm1EL1BDbDhYakw2QVRVRGxGb2RWSjh6MmtJaFFjSDFWVHJkaGVm?=
 =?utf-8?B?NnpyRTBNQVI5bWxVMzluYlFUblkrTTFHaFhNdGNiaDRpYTYrdzN4bkQ3K2VO?=
 =?utf-8?B?d1U4UFlIcFpDdDg4SGJhQjBEV0JUWjY1VkEvNkdyOHM5R2EyUklTNVQ4Wmh2?=
 =?utf-8?B?SkV3SUoyNDk4RXNwRytWQWxUamJkZkI2NC9ybGx0eEdib2k3WEN4OGhVelN2?=
 =?utf-8?B?ZWhGN3Q4RDhGVU9wT29oNXdBcGU4dW9TSVRGMXU4TXhqQS94Vis1WWZoVW5E?=
 =?utf-8?B?c2gvamhETXY2Q1VZTkpVaUR1Nk0zcWhuL25PUHM5Yzh1TjN5cTN3K3h3K3kz?=
 =?utf-8?B?eFhFUUNWbkdoNGZ4Vkd0S3Q3SEMwZGlFLzlHNHF4RzlncEg3b1pncnFhK1Vi?=
 =?utf-8?B?ZnVPWXdvRXlBcmhLTjZYT0J1MFlTNEZKZVkxSlVxWVhSMG82T3ZvOER1ZmIy?=
 =?utf-8?B?am1nN0UrcmZWVVNCeTFyTW9tMVdtNnhMM3ZZZUdsMW82TkV5S2ovTU5BSHQ1?=
 =?utf-8?B?SStvMncvb1FKckFZaEp6WkZ4Q2tmSytiZmVSSWN3Y2hTRU95RndqMERURUNs?=
 =?utf-8?B?OE95bWFuVzIvNThoTE5CUGNJN2k4TmZQVXBVZm55Z3E2ZXV6bnAvM2tiYllq?=
 =?utf-8?B?clFheVlmUlB4M2hnbER0TDVrZ2RlVVg5d2dGNUZuRGF2L1BiZXFISHpMdW5w?=
 =?utf-8?B?V3k4bUdxMGlkVE5NalFNcU5FTklQK2hCcjNyYUVieXZzNm5Qc29Ub3ZXYStJ?=
 =?utf-8?B?SDdxWjFWUXlmdmoraDRHWWZ2czJpMUk0czhubEJzaXAzRFdFblhlRllXeTJZ?=
 =?utf-8?B?TXh0dmtjVUlYTkE5S1Y1ZVBTTDdJcmtNcm51eTF4cERvemx2K3dhcU03cWxE?=
 =?utf-8?B?Ny81K2VucHZabllaVEdoMmRkYVl0MTFxWmVJQ09oaVk5a2U0aFdmR3ZKZEJs?=
 =?utf-8?B?WkM4UXF5cVpVaVpaTUF6UXpEMVVhRU4rV1dnQmh4bzAySWJnNWtxTjY2U3VX?=
 =?utf-8?B?eGJCbFpFVThPN1VmbGlGY0dpSFZhWlJpTEtYTjBOOEpUeXV3RElQOUNEZ2Fa?=
 =?utf-8?B?T3dOcE01MjZFSmlBa0JoTUVYYmdLUmlaeEV6eGhMRnA5d2FnZGtuSDNsNUha?=
 =?utf-8?B?Q2VPM3I3NTVrdWtzcCt5QkIrZHFwQW5uY1lMRFpUT0hKeGFCUkZJSHhpNkFH?=
 =?utf-8?B?M25HUFhzZVRPbXVDNEhaaWZlMFo2b1orT0FPc0ttZ0xxcDc5RGYvWk5ld2hw?=
 =?utf-8?B?ZFk0Q3h4d29QTm03Uzh1bDNKcjVOUDBPeXBpb0RReE4za0pGQ1lxaVRsVHli?=
 =?utf-8?B?dFY2UmUrWHdMRDJCY2xvdTA2cUkwTWtKNU82Um0xaHZkYklyRFBhRXNWMXJY?=
 =?utf-8?B?VmpESE84VFQ1Mys3dU01VXpDc3A4cndGbElURm1pRTJHK2piYWVCMkR6MmpV?=
 =?utf-8?B?Z0crN05pV2FpU2dHL1gyWmVFY0JPbEZHeVk2SWhLdGhnS0xmeWJSUWt1UkZZ?=
 =?utf-8?B?dnFQZkcybmVrcS9sRE04MXpuSkhNOGJ3VFN3SVlYZGZseVQwU21qOEhxTTZF?=
 =?utf-8?B?NlFxaTZ4U0dGTll1NVlLa2JLd0VsVXRhVnRxL3RqMVFxZGQza1F4ODRkM3dw?=
 =?utf-8?B?Z0pJRng2K3B2NkpJdkN0aGlMQTdhL3ZJcGZxSjY5eENjOUNVUXlxYXU4anBW?=
 =?utf-8?B?cmt4NUpOSnZRYjJMNzJTZml3QlZPRTJXd0t0eGFZc0hNaHp4cUJ5aVg3aUY0?=
 =?utf-8?B?SWt3bWg0aGJldVpLNklBb3RYYmFDeE0zcDZ6aGlnY2gzS1g5ZUZ1RnB5VzZL?=
 =?utf-8?B?ZE5HdkVEdkFnYVRIdUlmWkE3ckgwYWJqMzlOOUpKdmRxMk9aT1FUbFQyMXJR?=
 =?utf-8?B?YWhJdzZxRkdDTXJQMTdYZ2JhWG5FdjdOTmE3dDRaZ3U2ZS8rZTF1TUEwZy9x?=
 =?utf-8?B?QlRCaE4vRnA3V21ETlB4Sk4rcWhaSVpVWkp1SmpqODVMU2xvV0VYNGZWakdk?=
 =?utf-8?B?bHkxcTBRYXpVelQ1di9aZ3lxcGlBVm05Y1hHakJOaThNVStTK3daRWhBUVJL?=
 =?utf-8?B?cUp3OEdpNGRFNVdQUUcrZFdSeFNIQ2xHMXRHN2xxdEwwQkJlQ1VEVWRkamtL?=
 =?utf-8?Q?0sGCVji5hHRoXyN6it?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ZLB77pFoADOiDQZWq1Ea0+wl+f5rkj8lQls96eLBoKLmNyEcPfImH9YezG1IuQwSpcqlP+sEEf5SHn97XaDp6V2koygtjGJ9vUO9GR32gfXpoBcpThDTjxrj/E9jnRdCSbrOIjq1nHJsTxTIb6sqECdVPfP4tLqL5QPH12/C3L9q54bxDoUqSdyPHW6Y/Tp4ykY17DGbfB69b6z4JHzk15yBsqc7ujRmP4MRydfsvgMOaxa7gkjlOI1xZZQ1Ow3kDNPR1JxVEmTfrfoNPaAxqm0w7mR84BVcBo18kHs8bT7OGZz5O4M699gVGvMIDKw6S7JW8+rZX4BZn4w/eSIhHA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd623fdc-c41c-4b36-823a-08deee0e15a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2026 07:42:19.3276 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vdPDIe9UNCue0NZ6jJZSl+8Fn9u8Qu0ha5VyuqOR8LMEHBermQ2OUv5bjOYE2KT6CFvBBuK2OwNnrvXOgZZ3xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6888
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785397351; x=1816933351;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=MSopA4S5cenhVgII3qBmoBxlcSjtaJPYug1Ue1VbfQE=;
 b=dxlezvU8TxPLv92fH649SKucuIrSNZYzFmpaZPMnnXn5B/+52VjX/Pae
 jvZrCrE0j/7VVtN3PD1xA95awjc4D/L15JX7eRpj86kY1rrj833AfBMAB
 XppYbbLI0CbEuyCsJNCcSE/80NEScza9mW770ByIhabSR0O7mAClTr6K8
 7xT1VFu4ftdY6C4BneYoTOpUCpbaDVTqEEMtxry0DgBroX1Z42dGix8A5
 8pkmlE6Tw/DiR7zkgXF2/JlfDWbtYBNk1IW+fnmEMfvIs0X2SmuUbvQZC
 cN9zizWK/MgJjx29z1u2Xrq71XIoPsNtytq9gf2sNXxtPMJY9a3MMUndn
 w==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=dxlezvU8
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v5 3/4] ixgbe: fix ITR value
 overflow in adaptive interrupt throttling
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC13aXJlZC1sYW4gPGlu
dGVsLXdpcmVkLWxhbi1ib3VuY2VzQG9zdW9zbC5vcmc+IE9uIEJlaGFsZiBPZiBBbGVrc2FuZHIg
TG9rdGlvbm92DQo+IFNlbnQ6IDE2IE1heSAyMDI2IDAwOjM0DQo+IFRvOiBpbnRlbC13aXJlZC1s
YW5AbGlzdHMub3N1b3NsLm9yZzsgTmd1eWVuLCBBbnRob255IEwgPGFudGhvbnkubC5uZ3V5ZW5A
aW50ZWwuY29tPjsgTG9rdGlvbm92LCBBbGVrc2FuZHIgPGFsZWtzYW5kci5sb2t0aW9ub3ZAaW50
ZWwuY29tPg0KPiBDYzogbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgU2ltb24gSG9ybWFuIDxob3Jt
c0BrZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBbSW50ZWwtd2lyZWQtbGFuXSBbUEFUQ0ggaXdsLW5l
dCB2NSAzLzRdIGl4Z2JlOiBmaXggSVRSIHZhbHVlIG92ZXJmbG93IGluIGFkYXB0aXZlIGludGVy
cnVwdCB0aHJvdHRsaW5nDQo+DQo+IGl4Z2JlX3VwZGF0ZV9pdHIoKSBwYWNrcyBhIG1vZGUgZmxh
ZyAoSVhHQkVfSVRSX0FEQVBUSVZFX0xBVEVOQ1ksIGJpdCA3KSBhbmQgYSB1c2VjcyBkZWxheSAo
Yml0cyBbNjowXSkgaW50byBhbiB1bnNpZ25lZCBpbnQsIHRoZW4gc3RvcmVzIHRoZSBjb21iaW5l
ZCB2YWx1ZSBpbiByaW5nX2NvbnRhaW5lci0+aXRyIHdoaWNoIGlzIGRlY2xhcmVkIGFzIHU4LiAg
VmFsdWVzIGFib3ZlIDB4RkYgd3JhcCBvbiB0cnVuY2F0aW9uLCA+IGNvcnJ1cHRpbmcgYm90aCB0
aGUgZGVsYXkgYW5kIHRoZSBtb2RlIGZsYWcgb24gdGhlIG5leHQgcmVhZGJhY2suDQo+DQo+IEtl
ZXAgdGhlIG1vZGUgYml0IChJWEdCRV9JVFJfQURBUFRJVkVfTEFURU5DWSkgYW5kIHRoZSB1c2Vj
IGRlbGF5IGFzIHNlcGFyYXRlIG9wZXJhbmRzIGluIHRoZSBmaW5hbCBzdG9yZSBleHByZXNzaW9u
LiAgQ2xhbXAgb25seSB0aGUgdXNlY3MgcG9ydGlvbiB0byBbSVhHQkVfSVRSX0FEQVBUSVZFX01J
Tl9VU0VDUywgSVhHQkVfSVRSX0FEQVBUSVZFX01BWF9VU0VDU10gdXNpbmcgY2xhbXBfdmFsKCkg
c28gdGhhdDoNCj4gLSBvdmVyZmxvdyBjYW5ub3QgYmxlZWQgaW50byB0aGUgbW9kZSBiaXQgKGJp
dCA3KSwNCj4gLSB0aGUgZGVsYXkgY2Fubm90IGV4Y2VlZCAxMjYgdXMgKElYR0JFX0lUUl9BREFQ
VElWRV9NQVhfVVNFQ1MpLA0KPiAtIHRoZSBkZWxheSBjYW5ub3QgZHJvcCBiZWxvdyAxMCB1cyAo
SVhHQkVfSVRSX0FEQVBUSVZFX01JTl9VU0VDUykuDQo+DQo+IEZpeGVzOiBiNGRlZDgzMjdmZWEg
KCJpeGdiZTogVXBkYXRlIGFkYXB0aXZlIElUUiBhbGdvcml0aG0iKQ0KPiBDYzogc3RhYmxlQHZn
ZXIua2VybmVsLm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBBbGVrc2FuZHIgTG9rdGlvbm92IDxhbGVr
c2FuZHIubG9rdGlvbm92QGludGVsLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IFNpbW9uIEhvcm1hbiA8
aG9ybXNAa2VybmVsLm9yZz4NCj4gLS0tDQo+IHYyIC0+IHYzOg0KPiAtIFVzZSBjbGFtcF92YWwo
KSBpbnN0ZWFkIG9mIG1pbl90KCkgdG8gYWxzbyBndWFyZCB0aGUgbG93ZXIgYm91bmQNCj4gICAo
SVhHQkVfSVRSX0FEQVBUSVZFX01JTl9VU0VDUyk7IGtlZXAgbW9kZSBhbmQgZGVsYXkgYXMgc2Vw
YXJhdGUNCj4gICBvcGVyYW5kcyB1bnRpbCBmaW5hbCBzdG9yZTsgdXNlIElYR0JFX0lUUl9BREFQ
VElWRV9NQVhfVVNFQ1MgKDEyNikNCj4gICBhcyB1cHBlciBib3VuZCBpbnN0ZWFkIG9mIElYR0JF
X0lUUl9BREFQVElWRV9MQVRFTkNZIC0gMSAoMTI3KQ0KPiAgIChTaW1vbiBIb3JtYW4pLg0KPg0K
PiB2MSAtPiB2MjoNCj4gLSBBZGQgcHJvcGVyIFtOL01dIG51bWJlcmluZyBzbyBwYXRjaHdvcmsg
dHJhY2tzIGl0IGFzIHBhcnQgb2YgdGhlIHNldDsNCj4gICBubyBjb2RlIGNoYW5nZS4NCj4NCj4g
ZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaXhnYmUvaXhnYmVfbWFpbi5jIHwgMTAgKysrKysr
Ky0tLQ0KPiAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0K
Pg0KDQpUZXN0ZWQtYnk6IFJpbml0aGEgUyA8c3gucmluaXRoYUBpbnRlbC5jb20+IChBIENvbnRp
bmdlbnQgd29ya2VyIGF0IEludGVsKQ0K
