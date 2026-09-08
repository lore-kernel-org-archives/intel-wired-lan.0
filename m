Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F28C79F99
	for <intel-wired-lan@archiver.kernel.org>; Tue,  8 Sep 2026 18:03:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D79FE80A9A;
	Tue,  8 Sep 2026 18:03:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yCoMfQalk45J; Tue,  8 Sep 2026 18:03:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2664980CDE
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788890635;
	b=d/j7kGlJ3fO8NKk9SUJJc8oeyBHmE11tEKmyWMNUuyV40OjPEQy7RfpzSF52yL37pDxI
	 uyYkIKhJh4GHLeReIY7BHFQLC6J/kPyqgRvoo836jLrxVGzHh/nguPF++trWD6aV6Se1J
	 AUJe4U5083Xtdx18+ynBtF6wF7kg2dQblwZpwUVcWdgjHVtntMePD3YfX+hQy8iXDqEIm
	 UcXJSe38SM0itACpbKBNa6L73ISedyiZl9U/IBOmNiD4DSE0qCwMcRhgQV38LXjPAr5sM
	 6qqk29xnswj1K50bG9xW92tMrcmfBmdyXB4bfzeO4VOZWvP96kXJwCVpLJ7m4Y8LwoQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788890635;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:Received:Received:
	 From:To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
	 References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ld-processed:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=boqyKA5JyqdPNxuSbWxs/LKKKErzdeF63yFA3/7USPw=;
	b=EolbGvwRs5o59hHXV++tWolUCnALSPoD3vx2EIBiWftd/KssZAUKvDp2QNdl/WWN8L7k
	 9VUhS2rzD5bpTRpLkQy6xcd8XHIJGFIxJUL3YQo5AnCM99eqA59wwB0KZMql1LWpFV+ZC
	 kkfqK2sOxTBCJoGyf8l3vtMkOdkROzRZnry1cUxZWi6sa1wGDfHa8bVryD33drQXvUos8
	 1JUUDUfnme1eBDraFP8rq2u6YppjsVb/NAPhpZgPfEOmbNyQf04ZOScI3QSC1pe3wTlja
	 RcNNnqaPnLKt8gru+um8yz1sq/TBdAaCA1JGaFX2xiFuqs3gHq/Au87cLxnJdxpiDJw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788890635;
	bh=boqyKA5JyqdPNxuSbWxs/LKKKErzdeF63yFA3/7USPw=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mSzriZ18YMQeuwr3IpJmaAzhf5vLkJBhJH0lyEtu6LsFHfXUG1tftnmoVpCIsV7M8
	 SaPYS/trTvTAMQinuCJMSeT94xSIrfO2e61ognacfSgP57sxjL2AJ28WW7syCU2ewn
	 D5ORBPHvNqz8gA24O+tR87Ib/zeqcw7wDyuk0lMeDPn0OH2BJJcQsbTwwL15RXakCT
	 my4LlDvADcopexG8on/j4jmOneOA7m/vjmWTX5zM7MZEnLO14+FcihVvR1xbhVpM0v
	 pWn3cynygaP2AHXxKNwDC4/Hr0FrP+GHtDWlEJm6SOEevD1Odb/ZQPjD8ecLX/0KB0
	 SIrseqn7sjD6w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2664980CDE;
	Tue,  8 Sep 2026 18:03:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A7D6C769
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 18:03:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 99FC340642
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 18:03:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n4ZYwiZMVmtA for <intel-wired-lan@lists.osuosl.org>;
 Tue,  8 Sep 2026 18:03:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C189540670
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.17
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788890633;
 b=cMLi95spwlyVu00pH5FW/UI5rDC456xeJrHxw0azcMrsCpHjGEpHUkBu26FGlSrf98wU
 8WBYj+48Y0if3Hs2H6EjlBasEguGBpRxKVDhCh6fs3/Z2OsYN2Am8U0EitoF6xHLyF3tq
 cxU5BREYgqhwHwReltcEms58jOrbeHPtN8YAZuu6WH4ojnijhjAa4IiM/ym9v9LEj6sZM
 jun5aGG/4T2TYrAyKUF/y5FFH7NJdDpaMxVuu+HWbpv4Sfqe2b5XfzvygkwdSFosY2f/2
 DaBFvJIXgf8JP5hoLpUGlDtXAm0v5b4pTtc+TmbAqdw+cw+8RhXocbnUHwmhG7lAbRQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788890633;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
 x-ms-publictraffictype:x-ms-traffictypediagnostic:
 x-ms-office365-filtering-correlation-id:x-ld-processed:
 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
 x-microsoft-antispam:x-microsoft-antispam-message-info:
 x-forefront-antispam-report:
 x-ms-exchange-antispam-messagedata-chunkcount:
 x-ms-exchange-antispam-messagedata-0:Content-Type:
 Content-Transfer-Encoding:MIME-Version:
 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-originalarrivaltime:
 X-MS-Exchange-CrossTenant-fromentityheader:
 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
 X-MS-Exchange-CrossTenant-userprincipalname:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 bh=boqyKA5JyqdPNxuSbWxs/LKKKErzdeF63yFA3/7USPw=;
 b=mIN4XYgyc7X26JBvgydxqqsth3hdDpkCjJ+Y4QmqAxlQF1JZDYg1QDGVb0cZAiNhC0NK
 47oNMyZ/BimmKP09eCUF32Fo/jjsgAs9RiWp5F/2K1hcICReDDU0eBB/RxBYjGr2GDI+e
 uRfcvKUcY3GqSoj/aSbpQX+X4rKTYOytiC6y4JJVugCLo0NKNmOZNd0zmtSJkVEY4J5ZN
 CQuB2CakfazkYR+4ituRokU6vNzB6cUPex87u0691W/1n8stDV8VQGPF5XAxiGoSdOL3W
 J1eZE1ZOZIqGR6s5QsQVNTYXZV32JXBnACjQtyQmHpRacTa40ol2mgRGlBNOaEkaiUw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=TcPJSerQ; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.17
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.17;
 helo=mgamail.intel.com; envelope-from=alexander.nowlin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=TcPJSerQ
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C189540670
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 18:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788890633; x=1820426633;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=boqyKA5JyqdPNxuSbWxs/LKKKErzdeF63yFA3/7USPw=;
 b=TcPJSerQoQ5TPHSRC6mUbLOGk9p6h9z8vstPq2ENtMCc3uWRj8tBKfRX
 VvkbuJBYwSLOXL90xvCGqPKdqUKVNysTxBpKEihMc3F/b9mluMcHUuQaE
 FIV89WOiLvsMg6Mjl92m22sNwJvpqJAz6p7Toex0jTEzUEfspdXqHZLsg
 LKJqglM/FKSrINSc6FSPIBJlsMsO7xrE0vnTNxlMebHFAoLRxE+XoPTUF
 5kFjLHHSs5k40DTVlIdd/+y97VTa/pmuGEDxhVO+AjRiwr4FWen5RxgXq
 C/64mEGqjXaD2AsCobXTK2L6lDQrnHqSOrvT+fEANcXGpA6ur2BdDOdhQ A==;
X-CSE-ConnectionGUID: thyZFRPpTc2OUiV92PhC9Q==
X-CSE-MsgGUID: ImsPgSK2R3CfFsAzqTVgIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="89334831"
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; d="scan'208";a="89334831"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 11:03:52 -0700
X-CSE-ConnectionGUID: jeDAH5A+Si+mG8G5FnHNqg==
X-CSE-MsgGUID: GWmV8xmATTyEPkqBgX6oXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; d="scan'208";a="275204622"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 11:03:52 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 11:03:51 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 8 Sep 2026 11:03:51 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.33) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 11:03:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kNChODvd/q7GPDIzu43762BcQmt4kWGZQLYxclxpuRVHmhCdqlUtuJugbfeV6yaXg89vMAoQ2UT+rFzWsOTwxNz3W/hkecEVV2hkcf7GXPjcw97WOMTp8W576cFToCSDzEKFkrjxwf8p0lg4Q2tu3l2hhUd9SCK45k5g5ynTQXuXC9P9DC4vRbvDfKkUi0za1LWjkx+IrV04TLOuCa+9vu4Affj8kqUeHOwR5iUg6kVHqQUTiecdIdrFbXz8QrIdHSGzU+/TN71adUsM7pTXJzovZIYwkeUnIPtrj8XrIZ8xzAVMPbjpAW9JzSOA9DpROej+F3budSX4+SgEAguFPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=boqyKA5JyqdPNxuSbWxs/LKKKErzdeF63yFA3/7USPw=;
 b=JXsI7v7kpZO0sLSNed+UuKy4E675eDI9LASaTFvYqJL2TbJ3tamVAbkeQNQF19BhQlDjdzzHKTxkRVDKYloldgNlbGcmxaS/SCgFtw4FCUnbr+d+l3hRvQ/w/DPwiIl/J3RfxHLXJS8aRl2bDrQtFNaawmmDMzQoI7R+5SV3T3rCpp+rUfqFPx5ufbA2WnFVHxUR3/+JFyTdwjHx1V3nxXtToEGwMSvCxBm20yFUFelkOWaJl4E3u6gUTi+jOhWilRI6lCRxZHTnrwFm6d+Sem2LHH2V7KxosQyujeW2Fo0/YaCFIuHflAiKYERoY1rfAFO3dPJC5aISnhaIjGnOKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by DS4PPFAC42FDD50.namprd11.prod.outlook.com (2603:10b6:f:fc02::46)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 18:03:48 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 18:03:48 +0000
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
Subject: RE: [PATCH iwl-net v2 04/14] ice: E822: keep Tx timestamps disabled
 during offset calibration
Thread-Topic: [PATCH iwl-net v2 04/14] ice: E822: keep Tx timestamps disabled
 during offset calibration
Thread-Index: AQHdNOTRZLkwbZa41U6rB8WqY/OUAbbFDspw
Date: Tue, 8 Sep 2026 18:03:48 +0000
Message-ID: <LV1PR11MB87907C9549234C90B6D9280E90B12@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260825-jk-e825c-minimized-fixes-v2-0-8223f95d26e3@intel.com>
 <20260825-jk-e825c-minimized-fixes-v2-4-8223f95d26e3@intel.com>
In-Reply-To: <20260825-jk-e825c-minimized-fixes-v2-4-8223f95d26e3@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|DS4PPFAC42FDD50:EE_
x-ms-office365-filtering-correlation-id: 09cc6712-a9ad-49aa-35f9-08df0dd38801
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|38070700021|6133799003|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: GjuydrRfgcGZNsTAW2QCHhAv9+uA4szgm97awsSJY0CHwFFQC8SsL0MF9M4jDeKaBwQCjwg0dw/sjU9caXd5l07Y3dcB8qda/eCyKqOfh3MWPgJCXNgH7tempewQUmlQm3iH/y+LE8GUehcNPju0nQgOJR6dNFceMwSvM5HoZNqMQRYGDhUlor0qrn+QRQYX/RbdRbsma4+no8gO2rh/YCuLol0H7uZLW0UszJCFLMAyqvD20Ep/s1pl6S2W6ab/O3hT0wckOdy1fJBpdHATLYYnN7F1gqKSC0mUySI9xlQzE41VgCPBuTA0nlqfHbAWVXh+XOFzK/YW8CHw06Mh8LZcAxXzj4hgQ5TYL9xYLYz4E4NWO1Ys2cnIhTsaRFxxs78cLLkhGDdZPNwZPAO7SOF14fpwsv6optmQzIHht+X4dybZ5dZHVBTNblBDKn5jtf9tf3AEdpmKA/tXPfS0/VOrPTrlbH3sJIoGAHJ/MR9tt88D2tzynbNbZs8GYKUJCESaF7hriwnJnkSpx/LD319p72konN7Jybj5L0ptWzxvJUxrcj43JUSz1eOxgjWYLr3FbqJz6Wucm/wxQxszfY/V5vWmI9dlZj0bKeEa6jjfEgGVOdVBZuH8KGclIshD8H4YjZUgaRsDW1igzKwHOuyfnKrIGcc9q4wADpJ18K2E2pEJLd1HiYR+TAKWkovr3VuAXqT7I2au+Ud/Ee12FmAdmqwoZrbRzw6TJfYeMTA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV1PR11MB8790.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(6133799003)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RmFJcUMyRHN6SnJWYU13YUs4dm5YZ1l3RlBVZjZZcENZQXgzRjdKTjBHUlB2?=
 =?utf-8?B?SGZraEkzWkZFSGdNbVZZVFZ1NU9NcklBVVFhbFd4RVVEMm1xY1U1WHl3Ymlz?=
 =?utf-8?B?MGtVVGlYYXRENCtrVXUzdGk5U1REZ1FQOGpOWmFEbUJnQlBwY0t2aURSMElQ?=
 =?utf-8?B?TFUrNzhZalVWK3VHdzBoanRjYUdWWmdvbGsvcTZtbGJYcnhVdkNodVQ3MWZN?=
 =?utf-8?B?TUp0K1RqNWpvQS93cGxLWXN2dnNlT0ExeUhLN0liRW95azl2N3R3azkzRVlv?=
 =?utf-8?B?dmFLZ0ROWXN1Z1dibTFubU9hM2d4c3hEZ0tTQWFJNXNWa1ZSdWVIbk9xZmlG?=
 =?utf-8?B?SHpyTGtmMDBOOGM5WDBrMUNwYkRGU0J3REF6UHBzM3kwb05MQ0FZVTFpby9S?=
 =?utf-8?B?UVBlMmM5a1JneXpicDFjcTVvZkdVYnhhd1g3UEVHWVl3OUJiSWVQZTdsZ1JF?=
 =?utf-8?B?Q1orSzZaK3ZZUVlPbVZFNTYvazBYTXNGV3o2N01reDQyU3ZKTE55bU9EdHhx?=
 =?utf-8?B?TVZmcEZUUU1zbDBla0lZcmE4TENlMkZsQkdRTVp4bUhvQ0o4SWhkblpaZVZt?=
 =?utf-8?B?TDZDQ2YvVy9lU0xFVXdKa1pNd2MxL2FFNU0vRTBlNTNvUXBiMUlUMjFxUnI4?=
 =?utf-8?B?aVB4dFMvdG80NWJiQUl5SGMvYi9zTUk0TVR4ZFU3ZUJ0bU9TT1FVbTNFc09t?=
 =?utf-8?B?cGIrRzh5ZVhOMjdWeGhCK3lwdklIUk5VL3lWMzBYaHlSbWpaaytSS29ncDdU?=
 =?utf-8?B?bFpyRHA4WmMybzNXTmQrTlc1eTd5aS9jZGRKS2gyY3d2MEdvcWplRlRTTzdU?=
 =?utf-8?B?eS9Vak5ZMHE5Rnk4OTc2cE4weVJnVGlGVDM3SEpjQXN1TFBmMFVaeFJLaHQ5?=
 =?utf-8?B?N1ZUbHdWcmZvYm5JeTVFSDBLRG5sSVJXd1dJNDBZSUcvdENJUlhJK3Q4M0RB?=
 =?utf-8?B?S09pcUZPVnp1NEVmL05sOGdyVmVwS3RKUDJTMUJlZVpQM3NCQjB6S0lMdnVG?=
 =?utf-8?B?KzZySHp0M3BNZmhPRmZGVlM5YURXVEc4NU9xNmtGWTZRbjVxUTNIcXo0Umsz?=
 =?utf-8?B?M1RRMVVZeU4vQVdScnNEUFo2Z25qWS9MSEVEMnRIQ0I3ekFCcUhYUUJEd0pZ?=
 =?utf-8?B?cDByMmpadmFTVlR1RDdxOEVRd256S2I0N254V0p1dEtIa1RnK0NSL0FJRE9I?=
 =?utf-8?B?SXpvU1dhK1dVdHVQQkJjTXRuTmxIKzQ4N2NFcmtjNzhONjNIMGhFMDlGZzk5?=
 =?utf-8?B?SW0xKzRDaEtzSXlNNnRIaUpRUDNPWk11ZG1DcktZRUJYTE9qdHo0Y1JNMjZV?=
 =?utf-8?B?UlcvcHBrNENlUGg1cnVXdlBHUytKWEVMdkhyRkpvTUpqZzJwODBkMFZ6TVNi?=
 =?utf-8?B?d2xoS1d4Wi8xNmdvTmlPcnBmU0xHV1Ftd2pTb2k5WUViQWJvVDA5VUhLRnFy?=
 =?utf-8?B?WmQvRnA5N0NnTlNYcmRYVzlHNHBPM1R0dS94YnJIZGdSREgrTFcrblRFbk01?=
 =?utf-8?B?YnVVSFU0WHcrT0Z1MmNSajBwZW9TVEVPT3BPSUp0YzFXZCtlSE5uU1g0UWRi?=
 =?utf-8?B?SmhvWktWemFHdUt5RWdYK1JyckxHZnNVRWVQdTdSTkVXNEF6VlplZkdSRGps?=
 =?utf-8?B?QXlRZmpOcWNQbU0rUTlEMDhlYUhORWJmZjNyT0FHK2F6bG1Md003RDNSeUYv?=
 =?utf-8?B?MUtlOXhGK2NWaWs3Zm81Zno2Mmlkcm9jTG10Q2ZhdjljdlpEK2JOb2t1V3lR?=
 =?utf-8?B?cDB3UnNacFVwQjk5bjVYU0luYURVRjNLM3I0SHRpTkZyb1ZtL3ZrOWpyME84?=
 =?utf-8?B?YlpZNVE2Vmg0WUFMYWV0Q2c4dnlQR3ltM0lHdWhUOUF0VGZWeHlSaE9NRVlN?=
 =?utf-8?B?S0ZxMGU0V2lERlFtZ2FYVmErWk9oWkw2RWV6S25HSFFoZUJnK1J0cWFocmFv?=
 =?utf-8?B?NWJKa1hBaWFSQkR0ZnluanVzMmRzU0tud3Y4cll0ejJTbVdJZXhYNGF5SUIr?=
 =?utf-8?B?SGJ6SDNLTlcyWkRBbTkxdmNkZVhSL1dCRkhwY3RpdTJCdlNkZXVTVlhYN0FX?=
 =?utf-8?B?WmY0WFZDZExqMXpVSU0xSW4xY2h2SzJhZ0UraW9yN0RROGNYVnk4R29yVVhY?=
 =?utf-8?B?cXVTVjFMMFpINVZFNHc4dHZ5bTRidllzWlJXRkMxRE5kWEtvb3JtZVZ1alhV?=
 =?utf-8?B?Nkxocjk1emR2a0dkUzgwRUY2OXM3Q1VWT0lRSGlkRnhHby9OK2ZQOGFwVnhX?=
 =?utf-8?B?WHVuU2EwdmRxSVRjWDkwOTVVYnhSMEczRHdOL1M0NzZvNlRKNzc3SVVqWkIx?=
 =?utf-8?B?V3pXYkduTFFZTFdtS1pJWm0vanlpdXY2ODZ0R0ZHeStiMVZtZUwzdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Gk2Bgfmz+zHXMsmKu1TNNl6w6H2l9lTs/ZYL76s/5HP/HFy6csVgvnEQJZhliFYmg3XdgPzxgpIm/P6feVe2fnB45njdSHZl7HVp7L0Ztu8xIEtPp4Fw3U2ndZ43yE+R29JCnIkgFTPRVrFBntPcXAo6bACzQ1PZ47vBBEfszcZPt3r5GcInSztDNFziYRRelolUIK/FBsc++VpTCgg5mUHBOaxnCZWe1C6CvPQTExUojX0oVJ8c/VkDZW7CTDW5CrRXHfgeGnxdDdIgYu1WuBF3iYqvgCLXrrc332+L4qXDX++pXXmqjeNTpsEkw+71s8Ud325kj2TRXr416vk6OA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09cc6712-a9ad-49aa-35f9-08df0dd38801
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 18:03:48.0876 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xjYJBz9zoYleS43oaOfuG7RpC5GhMcmiVVpOyJ3f9H84dExOXegHnHstr7nKcmwXAe5DvFvV2WiSUOL8ygYnUzYMKD6s0nYm9OLa+E584og=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFAC42FDD50
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
Y29iLmUua2VsbGVyQGludGVsLmNvbT4gDQo+IFNlbnQ6IFR1ZXNkYXksIEF1Z3VzdCAyNSwgMjAy
NiAzOjUzIFBNDQo+IFRvOiBJbnRlbCBXaXJlZCBMQU4gPGludGVsLXdpcmVkLWxhbkBsaXN0cy5v
c3Vvc2wub3JnPg0KPiBDYzogbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgTWFjaG5pa293c2tpLCBN
YWNpZWogPG1hY2llai5tYWNobmlrb3dza2lAaW50ZWwuY29tPjsgTmd1eWVuLCBBbnRob255IEwg
PGFudGhvbnkubC5uZ3V5ZW5AaW50ZWwuY29tPjsgS29yYmEsIFByemVteXNsYXcgPHByemVteXNs
YXcua29yYmFAaW50ZWwuY29tPjsgTml0a2EsIEdyemVnb3J6IDxncnplZ29yei5uaXRrYUBpbnRl
bC5jb20+OyBPcm9zLCBQZXRyIDxwb3Jvc0ByZWRoYXQuY29tPjsgTm93bGluLCBBbGV4YW5kZXIg
PGFsZXhhbmRlci5ub3dsaW5AaW50ZWwuY29tPjsgQnJvc3MsIEtldmluIDxrZXZpbi5icm9zc0Bp
bnRlbC5jb20+OyBDYXZhdHVyLCBSYW5qaXQgPHJhbmppdC5jYXZhdHVyQGludGVsLmNvbT47IEtl
bGxlciwgSmFjb2IgRSA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPjsgS2Fyb2wgS29sYWNpbnNr
aSA8a2Fyb2wua29sYWNpbnNraUBpbnRlbC5jb20+OyBMb2t0aW9ub3YsIEFsZWtzYW5kciA8YWxl
a3NhbmRyLmxva3Rpb25vdkBpbnRlbC5jb20+OyBLdWJhbGV3c2tpLCBBcmthZGl1c3ogPGFya2Fk
aXVzei5rdWJhbGV3c2tpQGludGVsLmNvbT47IEtvcmJhLCBQcnplbXlzbGF3IDxwcnplbXlzbGF3
LmtvcmJhQGludGVsLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIGl3bC1uZXQgdjIgMDQvMTRdIGlj
ZTogRTgyMjoga2VlcCBUeCB0aW1lc3RhbXBzIGRpc2FibGVkIGR1cmluZyBvZmZzZXQgY2FsaWJy
YXRpb24NCj4gDQo+IEZyb206IEthcm9sIEtvbGFjaW5za2kgPGthcm9sLmtvbGFjaW5za2lAaW50
ZWwuY29tPg0KPiANCj4gRG8gbm90IGNsZWFyIHRoZSB0eC5jYWxpYnJhdGluZyBmbGFnIGltbWVk
aWF0ZWx5IGFmdGVyIHN0YXJ0aW5nIHRoZSBQSFkgdGltZXIgaW4gaWNlX3B0cF9wb3J0X3BoeV9y
ZXN0YXJ0KCkuIEluc3RlYWQsIGtlZXAgVHggdGltZXN0YW1wcyBkaXNhYmxlZCB1bnRpbCB0aGUg
b2Zmc2V0IHZlcmlmaWNhdGlvbiB3b3JrIChpY2VfcHRwX3dhaXRfZm9yX29mZnNldHMpIGhhcyBj
b25maXJtZWQgdGhhdCBib3RoIFR4IGFuZCBSeCBQSFkgb2Zmc2V0cyBhcmUgcHJvcGVybHkgY29u
ZmlndXJlZC4NCj4gDQo+IFByZXZpb3VzbHksIHR4LmNhbGlicmF0aW5nIHdhcyBzZXQgdG8gdHJ1
ZSwgdGhlbiBpbW1lZGlhdGVseSBiYWNrIHRvIGZhbHNlIHJpZ2h0IGFmdGVyIGljZV9zdGFydF9w
aHlfdGltZXJfZTgyeCgpIHJldHVybmVkLiBUaGlzIGFsbG93ZWQgVHggdGltZXN0YW1wIHJlcXVl
c3RzIHRvIGJlIHNlcnZlZCBkdXJpbmcgdGhlIHdpbmRvdyB3aGVyZSBvZmZzZXQgdmVyaWZpY2F0
aW9uIHdhcyBzdGlsbCBwZW5kaW5nLiBUaW1lc3RhbXBzIHByb2R1Y2VkIGR1cmluZyB0aGlzIHdp
bmRvdyB1c2UgdW5jYWxpYnJhdGVkIFBIWSBvZmZzZXRzIGFuZCBjYW4gcHJvZHVjZSBpbmNvcnJl
Y3QgdmFsdWVzLg0KPiANCj4gV2hlbiBwdHA0bCByZWNlaXZlcyBpbmNvcnJlY3QgdGltZXN0YW1w
cywgaXQgbWF5IHJlamVjdCB0aGVtIGFuZCB3YWl0IGZvciB0aGUgbmV4dCBzeW5jIGludGVydmFs
ICh0eXBpY2FsbHkgMS0yIHNlY29uZHMpLCBjb21wb3VuZGluZyBkZWxheXMgZHVyaW5nIGxpbmsg
Y3ljbGluZy4gVGhpcyBjb250cmlidXRlcyB0byB0aGUgdGltZSB0cmFuc21pdHRlciBwb3J0IGJl
Y29taW5nIHVucmVzcG9uc2l2ZSBhZnRlciByZXBlYXRlZCBsaW5rIGRvd24vdXAgY3ljbGVzLg0K
PiANCj4gTW92ZSB0aGUgdHguY2FsaWJyYXRpbmcgPSBmYWxzZSB0byBpY2VfcHRwX3dhaXRfZm9y
X29mZnNldHMoKSwgYWZ0ZXIgYm90aCBUeCBhbmQgUnggb2Zmc2V0IGNvbmZpZ3VyYXRpb24gaGFz
IGNvbXBsZXRlZCBzdWNjZXNzZnVsbHkuIFRoaXMgZW5zdXJlcyB0aGF0IFR4IHRpbWVzdGFtcHMg
YXJlIG9ubHkgcmVwb3J0ZWQgd2l0aCBwcm9wZXJseSBjYWxpYnJhdGVkIFBIWSA+IG9mZnNldHMu
DQo+IA0KPiBJZiBpY2Vfc3RhcnRfcGh5X3RpbWVyX2U4MngoKSBmYWlscywgZG8gbm90IHJlc3Rv
cmUgY2FsaWJyYXRpbmcgdG8gZmFsc2UuDQo+IFRoZSBkZXZpY2UgaXMgaW4gYSBzdGF0ZSB3aGVy
ZSB0aW1lc3RhbXBzIGNhbm5vdCBzdWNjZWVkIHByb3Blcmx5IGFueXdheXMuDQo+IEEgZGV2X2Vy
ciBtZXNzYWdlIGlzIGFscmVhZHkgbG9nZ2VkIG9uIGZhaWx1cmUgdG8gc3RhcnQgdGhlIHRpbWVy
IGF0IHRoZSBlbmQgb2YgdGhlIGZ1bmN0aW9uLg0KPiANCj4gTG9nIGEgZGVidWcgbWVzc2FnZSB3
aGlsZSBvZmZzZXQgY2FsaWJyYXRpb24gaXMgc3RpbGwgcGVuZGluZywgaW5jbHVkaW5nIHRoZSBz
cGVjaWZpYyBUeC9SeCBlcnJvciBjb2RlcyB0byBhaWQgZGVidWdnaW5nIHN0YWxsZWQgY2FsaWJy
YXRpb24uDQo+IFRoaXMgcGF0aCBpcyBleHBlY3RlZCBvbiBldmVyeSByb3V0aW5lIGxpbmstdXA6
IG92X3dvcmsgaXMgZmlyc3QgcXVldWVkIHdpdGggbm8gZGVsYXkgYW5kIHRoZSB2ZXJuaWVyIG9m
ZnNldCBjYW5ub3QgYmUgY29tcHV0ZWQgdW50aWwgYXQgbGVhc3Qgb25lIHBhY2tldCBoYXMgYmVl
biB0cmFuc21pdHRlZCwgc28gdGhlIGZpcnN0IHNldmVyYWwgaW52b2NhdGlvbnMgbm9ybWFsbHkg
bGFuZCBoZXJlLiBVc2UgZGV2X2RiZygpIHJhdGhlciB0aGFuIGEgcmF0ZS1saW1pdGVkIHdhcm5p
bmcgdG8gYXZvaWQgZW1pdHRpbmcgS0VSTl9XQVJOSU5HIG9uIGV2ZXJ5IGxpbmstdXAgZHVyaW5n
IG5vcm1hbCBvcGVyYXRpb24uDQo+IExvZyBhIGRlYnVnIG1lc3NhZ2Ugd2hlbiBjYWxpYnJhdGlv
biBjb21wbGV0ZXMgc3VjY2Vzc2Z1bGx5Lg0KPiANCj4gRml4ZXM6IDNhNzQ5NjIzNGQxNyAoImlj
ZTogaW1wbGVtZW50IGJhc2ljIEU4MjIgUFRQIHN1cHBvcnQiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBL
YXJvbCBLb2xhY2luc2tpIDxrYXJvbC5rb2xhY2luc2tpQGludGVsLmNvbT4NCj4gUmV2aWV3ZWQt
Ynk6IEFsZWtzYW5kciBMb2t0aW9ub3YgPGFsZWtzYW5kci5sb2t0aW9ub3ZAaW50ZWwuY29tPg0K
PiBTaWduZWQtb2ZmLWJ5OiBBcmthZGl1c3ogS3ViYWxld3NraSA8YXJrYWRpdXN6Lmt1YmFsZXdz
a2lAaW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBQcnplbXlzbGF3IEtvcmJhIDxwcnplbXlz
bGF3LmtvcmJhQGludGVsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRl
bC9pY2UvaWNlX3B0cC5jIHwgMzAgKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tDQo+ICAx
IGZpbGUgY2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCg0KVGVzdGVk
LWJ5OiBBbGV4YW5kZXIgTm93bGluIDxhbGV4YW5kZXIubm93bGluQGludGVsLmNvbT4NCg==
