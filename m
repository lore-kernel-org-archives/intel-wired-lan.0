Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05ECEC5B572
	for <intel-wired-lan@archiver.kernel.org>; Mon, 17 Aug 2026 19:02:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9D7BE406C9;
	Mon, 17 Aug 2026 19:02:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xtNwPBc1vCNe; Mon, 17 Aug 2026 19:02:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C179A406C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786993377;
	bh=LWLAU4a3pHuSN7xs/cS0S2Js7QK/SDuKsnhppZZT6RE=;
	h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tqxleWMBroMEFHwlD+ge9SizEuyYYw6NzMjGr2c9ZehGVe+tnQpfdGdnj1knZpdT/
	 4cQmafNYkfkmQdJ41TsqCmrjn8W8p26yC2aJ3f7CfnLWd0PnFoo27dPzjsCX/0eh/b
	 9jNmBEQz0I9ZFlqVTDP4BstjY8IdgXzsER1hPwF9amFmRgkxUG9o7rOQPRn8pX/BEm
	 2SHSHtaQZguTKp5ZmLCOAMsGvdE9q4Hf1u0VnofA85Kr/IiebtUuqgjnhCOfLGKL8I
	 hOpdEEGC6o6XTsBwJixDdEErdcb09FScusCRVyCAOeeyyLND/uQ0P7n5HXQImcdyRO
	 7ctt2jAugvP+w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C179A406C3;
	Mon, 17 Aug 2026 19:02:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 201C923F
 for <intel-wired-lan@lists.osuosl.org>; Mon, 17 Aug 2026 19:02:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 05ED760831
 for <intel-wired-lan@lists.osuosl.org>; Mon, 17 Aug 2026 19:02:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iA3p6ydi1MEb for <intel-wired-lan@lists.osuosl.org>;
 Mon, 17 Aug 2026 19:02:55 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.11;
 helo=mgamail.intel.com; envelope-from=alexander.nowlin@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 42E1D60727
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 42E1D60727
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=S+VMOyK9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 42E1D60727
 for <intel-wired-lan@lists.osuosl.org>; Mon, 17 Aug 2026 19:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786993375; x=1818529375;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=BQCeD0/GIAD4Ezv6PfuyFPkbTt0RAsB2LcMeAEc6V9s=;
 b=S+VMOyK9lpc0cvcWQLnRhLJ62qNJvqAuRmxvWIpgL3uXxCAMtQzUmF9x
 46s8HF+3kHcSyY3i08kp2/se/T1yrGwJOkPwmlhEc7CgTgxBzZek8ki95
 1lPqTFREoTDu8/pJaI1v+Of72rIghwrfJxhWtR9cJ7QfuGFo8uMSOYN/A
 99Z1zpficqS6eisf6Cmyn1BILJ0MK8oZYrng+TOhlsIxAj401dduETuRD
 IYS0kRVUdzMkbTVxKu3UVwl6vIwwvNaSoRfxJ131uR7j3jSEr2GaQZC+f
 /xqKiIKmEddEYQ2b4rVHxoTwKnXc7NxdeIZxdQzStI5JToMGc8CLY73Lz A==;
X-CSE-ConnectionGUID: 5xKLWE5/RGmJKNd3irWyAA==
X-CSE-MsgGUID: TFqhUMGRTpCYGQk2H4mj2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="98067965"
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; d="scan'208";a="98067965"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2026 12:02:54 -0700
X-CSE-ConnectionGUID: BwtDV+79SqqPmYjj4pJRsA==
X-CSE-MsgGUID: kYx17EeMSduXM25l3boNTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; d="scan'208";a="289802363"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2026 12:02:54 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 17 Aug 2026 12:02:49 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 17 Aug 2026 12:02:49 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.22) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 17 Aug 2026 12:02:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EkqjnXy5A1+9ekngXrztRHOd6yJXkrtKFruM8YQUgTQvH5zM/7809gM2azf7MCu+ZMTRIHACvrLuPdBZgsO0QwcK7c+ruxlxyCPeL0Aen+Tqzp5tAMCxq5us671RsJYdY2k1cYFIe8JuP5U5IvGdtudiy/RUGg+yIGC+QkcGEuQbhbfjN3ySQlIBSQlqcfhQoCpzOQPYLoLezgP6uA5epXV46IMUJHu5nZrpwA161LIMzmOdCpkYj0u6oEDuYLmW6JtDxPzQUBYoO1I/cbQ/3CFQOsou77ZYYzApXnFSL7qTAt9Z7xRrJh8e1jJstC81oUNhQvk1ho7Q43GHR8ooNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LWLAU4a3pHuSN7xs/cS0S2Js7QK/SDuKsnhppZZT6RE=;
 b=NcXMZt5+KO71iI0wQPk7Z1aH/o/8z/3rrqyrER2rVp4YzyHaAXUCVdiqJg9I1o6dAerNZ7SCfFoqrh3xe7ssych5mbr5WTm2J98mneOOiu76cid0Btr4aPhMhbZgl+JzoMaPnDLsDs6w5ANLOUGr1zJjTe+aKlTxChnqc1ONrj4qzIsz9RZrmBeUDRI/paL9FwnCja6B4XgQS/BLSuvVIHc7EM6n8BUz2hyinJ7+GiGzBhnwVX0cubwjD2vNgEuy+b/GeVgxooKy5SsDi4d5HEstCzKgXQ/22/da4O5y2CJQeEnW/uj+pYl4V7qqX2HuqOecNOaoSZKHaSqwSZLCFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by SA2PR11MB5162.namprd11.prod.outlook.com (2603:10b6:806:114::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 19:02:26 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0315.014; Mon, 17 Aug 2026
 19:02:26 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Machnikowski, Maciej" <maciej.machnikowski@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Keller, Jacob E"
 <jacob.e.keller@intel.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net] ice: Recalibrate PHY after
 settime64 on E825-C
Thread-Index: AQHdKea+JJsxgEzuQ0eG8EPc32EXsraiodgg
Date: Mon, 17 Aug 2026 19:02:26 +0000
Message-ID: <LV1PR11MB8790231044E735B3BCC64B8290A72@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260811231058.220370-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20260811231058.220370-1-anthony.l.nguyen@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|SA2PR11MB5162:EE_
x-ms-office365-filtering-correlation-id: 11590c0b-1afe-413a-50f8-08defc92141c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|56012099006|10067099003|18002099003|22082099003|11063799006|38070700021;
x-microsoft-antispam-message-info: xenlRhF/IHAq4SMwu2oE7FIeGAGT/xkvGTVrzAR/f8ekQQOX5KS9HPuB7syvgK5gYXzdGgliX8RYeoAvaVOdY8trifFDwN1eKrrNFSeIAu7rFcIbTyVAli24XFTierYqGeP2fupCStb8mbkMt2EyphQ+QuJ3eEdx8Qq6DiWNvy1+y+ZcFdmQ6KULPXwGhIio8sHFs88S0uaAurDoMfBXmjX3RU/IcGCCLX0sQbyWvB8pz+9e7Uy8HL9l/qVl74la1QB/lrNQjXLNitdhj3ULlAYvI6U843i3W7miQaNgSrOLjSJZ/S/pYE0b/TupTlzEHwAEJ49ygNZwN4+VFvB35YrPNVc9G4AXgjPCjIbo6NP5Pprdi75Yo07zOrOluskvFohF0n1RaCNJDFvhRgMA7TosmrZM/6V5AWExvM+CrxgpaHjQJP25WJWKOjfTD/YXPQF+jbDvLUDTD5YGCCGTbFtA+HIB1dMtLx7NJMJzh8JFZqwfT4FcYWcg+EIQiv8ZUSGZhu+JLIZEM8PUVgtun5nRgx3kO/77GdKmMKnYlpXympQF+lwxqMTrVJ10ScTrwrr3Ui89NBhwj5RovUCaat9QZaCRfygglvM9dNdbxM5WetEUry6gT8xU54MpqoEem12hA3NuUfEdmBwzdspHZOJ9QaDls7BbezvwWZpn+ccHP3ccbrjO+dXDo39nDYoUQ/MQd+iWslP3ia6wZ3njLfm4qbODCCOfsk0PoFFTd9I=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV1PR11MB8790.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(56012099006)(10067099003)(18002099003)(22082099003)(11063799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hh9HkddNctrnkv3pCR2hQSbLLT2imSn6PYZp5Q3OH1y79pwbRXMUnkw6TMG2?=
 =?us-ascii?Q?WSGjsvgi/RtalouSjYm7uRKUVXpwYRW/w4L6SrDmFmKUNLk0Q+beXXMbh4J6?=
 =?us-ascii?Q?fES958ahtxzdQIFlHflXRENq9MOQChrGITR+qPspRMF7eLn3XDLPWNRX9y2e?=
 =?us-ascii?Q?ApTrvb7nylRzfnma4mdzBOQlxX1zBk4Tc4YWQUwd8s5uq/mfE2/rG+/hbAq1?=
 =?us-ascii?Q?kvC2UW/Y2OXhm9yAbP7GJ+KzJWEQyzD/WXrauaMKnoueF9OnAo2FR0Q8IPti?=
 =?us-ascii?Q?Zk2DA2u+qIEKXJjG4V04Wke/ZBGAI86X19bJuEZ+iW7dq6YtNyRrr34+lHoI?=
 =?us-ascii?Q?8qgiYw4OPW6PItohpeLBaVK1JDGtP/C3yFzkWwIgjWzCRjLWQ5+hTCkM3nsW?=
 =?us-ascii?Q?1gQyzLAXoMvE/shob/ICBxtzvA/1SnWnY777qs8w+ssYoCidzSrVxpfzg3CY?=
 =?us-ascii?Q?kAb95L9nqECbtZPJlRzEDundB8HxbiMyk/w64mywSKTg/28w1fts7Y7fCHtC?=
 =?us-ascii?Q?U8u15DoAPYCcwfeejuRftc96f0TPVGCwc6/RuR3zCWeYPHD7gcABTNIZz04B?=
 =?us-ascii?Q?cHgHfEOk0w+boOKd62HfVyMgFclI0GPXPf9xy+81wK29AQ3trKzFNGA3rQw+?=
 =?us-ascii?Q?VCPlxCUqGKbcmaijN8z/e1rQ4esAAXx/FqCWLTPta2/rxEGSMxDCNhQgQR7v?=
 =?us-ascii?Q?lEujn9G9Ga2MKurqsHr92TphRUpqI2/+x2MEjclYv7GO4vAT80qNxHsi9NQs?=
 =?us-ascii?Q?COKPMewYEA/+9VzfTpmBsl+qmGWViZc2uYLzlpPqKbS8aC2dSQKxI0ntuakl?=
 =?us-ascii?Q?46kkFV1YeXQBlDy4ublAAlg8k3nnESsSBU9tbmw0NowD0+ayNZFZTfbV6V4a?=
 =?us-ascii?Q?HvlI65Gma/MH16kYS3uFgs28cbNwkMMvL2yhRmKNrjOtEOz8h9MmiYiWctuz?=
 =?us-ascii?Q?QeCHMcOO4qXg7bwqka9EsFbfitJ7dueZd7yO0vh5oiM4SevIzJDVv9uqH1YG?=
 =?us-ascii?Q?oFoKRDaP10tIlvHHUXw2rxaO5wBRQcewiUXncH45ENQO8ndGSV7Eo8mcPIXU?=
 =?us-ascii?Q?HLh0OjrIJhjuvryBPf09ibz49sTlBF7gcjhC/wcliHVOvXSZJ1a3eFpZMvzB?=
 =?us-ascii?Q?e6Av6vMDpF+EmRM82X3LPP2Nyo+5PxumMb4+wqfHRk2f1H9I/nmnO6r7qGbr?=
 =?us-ascii?Q?Zntlcwullq1QtNu8skU6n9XNURsMd/1F7/B/jzTzAoiw9rLTz3QAFD10ATHb?=
 =?us-ascii?Q?+RPH8AsA+ARnEMS1k6W/ww5hh2OxXN5irliFK06aHIFcxWK8Yrv7aFn5hzWL?=
 =?us-ascii?Q?tf81QbP7eD9290potrjiQqY2/8HysAOxqb6ORWZwczfrC2CsWDZkGsCJgNCx?=
 =?us-ascii?Q?DWDLoNEf/SuypDeDueuoZJB5PEMhGXy0B1iU3vB5vQH1w6KoD4NHVgFEEDda?=
 =?us-ascii?Q?mE4TGZvxHPDCuKAYS1dYkT8c0cwgkG5RhrxMtvOvsEMzyRRAC7iYUCUrhVPO?=
 =?us-ascii?Q?NKjACIkQFODUJ0xLuiMUi79yXBqxEN6EvhhLlpnPlH89KK6jZN0SNgodBPK2?=
 =?us-ascii?Q?DJx2VXCB9W4Dw8w8LF5tMJxEZMVHO1bYMZi8OT7qfiEPKa12BEoDxyWZd1Um?=
 =?us-ascii?Q?LJV0MEYST2AuDHEvqJrOrCgZF3kkoCXBPFPHfnX/GpXNhE683siKTUOTWr0z?=
 =?us-ascii?Q?S69tn+AargF0IxDm4BiTDDJ6VYmU9m6dxDNB2GS+uMbmdSF9Vpu6U+4Le4Gj?=
 =?us-ascii?Q?DmYseeU53w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: H4UT6VVWJnFSO9JmySwPFS9Uyse3ymzBbg7WtFqvGwEzNziw/Ab3FWb7M91e/f0chN16g14A3K6ZEGbftUoYFKHjfBZoJIWqmzRb8fEUNXYHpNmeLAGyi6DzsU/UICfIar6WuRXKoLy0qbGkxQK/HPPhWDGdDRcN7Z6PmGKf5wZo8EEoSNvn9ajd3PhNXiJJLUTBIuqRvLrU7MsCSEACdJzwgtYrfg0uYCNBDi8RLXgvBs0b9Wi8F4ySil8Yrv3nR9aDz2jCdI6J5ApTi5Yr58OwCts++VxYufG0ZIL2KMC7uS6EA+uAoiIMVMoz+u0uHKcx963jWwXlVSklBqYCLg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11590c0b-1afe-413a-50f8-08defc92141c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2026 19:02:26.5760 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9W92z1QZXoF1JgtvVpC9jt3lTHdTLpo1EUdfWKnSy8FyCbZdRJQjrtZJcciENoulr+uqJqnOP9dP1A8rQ8CHq1yBPL/JaS7y92JoMYZSg2U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5162
X-OriginatorOrg: intel.com
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] ice: Recalibrate PHY after
 settime64 on E825-C
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
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of T=
ony Nguyen
> Sent: Tuesday, August 11, 2026 4:11 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Machnikowski, Maciej <maciej.machnikowski@intel.com>; netdev@vger.ker=
nel.org; Keller, Jacob E <jacob.e.keller@intel.com>; Nguyen, Anthony L <ant=
hony.l.nguyen@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-net] ice: Recalibrate PHY after set=
time64 on E825-C
>=20
> From: Maciek Machnikowski <maciej.machnikowski@intel.com>
>=20
> The PHY on E825-C requires recalibration after large jumps of the system =
time. Add missing PHY recalibration also on E825-C.
>=20
> Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products"=
)
> Signed-off-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ptp.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
