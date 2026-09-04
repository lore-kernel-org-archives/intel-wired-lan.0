Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93ED4C79F83
	for <intel-wired-lan@archiver.kernel.org>; Fri,  4 Sep 2026 07:01:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 61ABA60BC2;
	Fri,  4 Sep 2026 07:01:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RZlkzGzudr0r; Fri,  4 Sep 2026 07:01:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 629D760BBD
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788505283;
	b=rG6YOI9nuwQXqxWwwHDQsNKitXTekvS8apAxWNfD2j6yjnBBd/rrVyIQdBgN3iCPNvHw
	 QE0iu9zvIwmSPiegrXx9RZwxvYD23m63gCumy+dlYLfU4ad4wJh6OFfbxHFsOmSyd3Af6
	 taw2WPoraaxKAcdfxmgzU9XvpCpqbQDahDSn9xn8GrwRNEdX9/tmYcQBbZicVrwhh9bA/
	 hYCGYsiEjApXAqVD1YPYYyRxd0oAtFu54va12fsExa6p/0/JKmLGQiYFSBH9UcJ9iPiIX
	 slVqJw1bTnInDKudN9Uw8LKSmzLx63O7JszoBiL3FZhAmYHgrYijGT/HinIaNOQfKNg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788505283;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=OSVzlTVSHMFGsIj7jwSiefh49fDkjQaInlYvN0MbJRg=;
	b=BL6lYQ2LVhnFTZ2zfDPCddiW0bY9m7+Uh9G1SXARLqb3/DcDeHuRy46YDHKojcbBzUD3
	 tqZ0JkdpXtgGT0/xz8YJVWpPin2R/Vzy5KrQTWNH8jFoPsKeuiOKsmtMTw2I46D/UPYdb
	 NAT/Ii0oHS0BZKwao9OyH7ej+uregxcoaqte1GpqwLaBOnG1jz6TDnq13oZP0Igy0IuAD
	 n/jVz6iXV25GhWfO5KmZAHe1nDrB67i/bSCmnNdyS1XzuocCg7gdtjxHAb+82CDJkDHex
	 YzpOLoaEMs6IUwrlC6hwlNGkUTXavmlVHxyGsvKRH+xDtShOMAWLDax7XzJQoRUQEbA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788505283;
	bh=OSVzlTVSHMFGsIj7jwSiefh49fDkjQaInlYvN0MbJRg=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X6rjltk7tQTzLdR0MgQ+G5UUauPG0HG89vCplKG2HhPHytaf3YkdZ7EC30laBmB8N
	 1jhELLw2pTAsMiOJlFBrRoNbI9tDGurZa057D3diSV9XGhKk2GfYmRwG9f2MzrMlJk
	 taezd7EozNmDkt6tRo4wEMR5RYV2IqufLTzxOv18Frr+NQHsK9XxJVdK4WvOv8aSAe
	 vs3bvVOslU8odwdwOnumGecPRBzu/qm/Ql5iZ634hsOBMBTRlulLxYc5LRmVX5NKGL
	 oVr1S62MF/7vrCvPvQRuLyYDWDaR6sNxPirIpDmJLxJpyhSkDW9GNvxyN/qOr9KQ0o
	 6fIRuk689CMdg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 629D760BBD;
	Fri,  4 Sep 2026 07:01:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id EB8522FD
 for <intel-wired-lan@lists.osuosl.org>; Fri,  4 Sep 2026 07:01:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DD12181140
 for <intel-wired-lan@lists.osuosl.org>; Fri,  4 Sep 2026 07:01:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EHlcwNaERSAJ for <intel-wired-lan@lists.osuosl.org>;
 Fri,  4 Sep 2026 07:01:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D5D7181119
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.14
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788505281;
 b=AyVBUNjK6IAcBBA5wc+YEnszEuivjbsJq6e2DhWRFyWKqJrO8/b79FEmhvmcjqr6SA7T
 fKav2pNuBQnseSlnj4waGMaV4a5w+B5b7Nf270cDdWg8QAXrRtVmn459QXBXDDL4+IPzO
 gAMF1YISAWIDh0YBu03SBDzHfQbi3LDXrerh+rq014eB0T6GBeY2OZC3fSCaNeuI2wRe3
 huXT6QlqK73HhmL7jfl4MpaXVQJ4QtWvzHH2dPDJQKyCdr8fG2tcVIoJkTDghQVEgT05q
 cyq6xZaydqxH+7XuzRUu9ieBKype/36p33fMy9EX932As1zsGTAWLAPm9ejTbBCIoug==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788505281;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
 x-ms-publictraffictype:x-ms-traffictypediagnostic:
 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 bh=OSVzlTVSHMFGsIj7jwSiefh49fDkjQaInlYvN0MbJRg=;
 b=WFQd3hZqFlOt3+SHuAgfmW2ikkH3RVLhvt0eNZXUAkQnfoMfHKz3UaKPEg0NVgxEG2dt
 rESzYhW4TPDZEdoJy1KPtDzLGvZd41kBADQBmHRzNrdjFyeLhWri3r+jXbFGmclKRNme9
 3u15EtdSugwIcyevYKfp0xv1XYBe8Wd3R1qxP0Wk9U5UC79c807qWS1vWcg4kiY4J+vEP
 GCtUtrOYdxiH0RbJCVO8Bodq+RINZved7szRC9jeVnM5KcjmioIda0QCrGVIaFT2sYbVi
 WnDtac2pA7R92w7aRuBTwciV+9CJqrpNHTHv0cwyLrpcmvU7dg9pPehqF3sp6kAhijQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=hXVkPYua; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.14
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.14;
 helo=mgamail.intel.com; envelope-from=sx.rinitha@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=hXVkPYua
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D5D7181119
 for <intel-wired-lan@lists.osuosl.org>; Fri,  4 Sep 2026 07:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788505281; x=1820041281;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=w99922MFiD+HWXW5Yl51/quSzGGQjnkMQ1tp0B8ifIs=;
 b=hXVkPYuaM3J9b9nypY5yqQ0Rhof1I4zeJuVfyYxZFAHQEftAcUdhBXpz
 NL2RbNafpTFDowQOUsDMtEtjN1raqyCN5fCpSFjZ/vRzVBTPWrs3breOs
 2/XsT1GNxe1dVoIJlQxJcEfUmbUxYDInIqfDd6JAOHOEKDwijn/DsU/bn
 KlqAUa82ZFFP8dCZKp8y2eeWVgrC6+HwAhDYiecNI8YVJkLl9GsT4yEsQ
 9lBOO+iivxB/FAzM9gb1SLrGVtlr4gGbg+BPmbCSMPL/UaSttOnNHbbgz
 1E7ease7k9dupJxb2m9+gV8TP9w/bxH5tLehPkGmCmZXZXgYf5nwmbu15 A==;
X-CSE-ConnectionGUID: l8GGSZDNRSSKhjeDMwBe8w==
X-CSE-MsgGUID: /nzGNqSoTXatwDyMoqpALw==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="89023174"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="89023174"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2026 00:01:20 -0700
X-CSE-ConnectionGUID: LkSjzuQYQB232FNEFHr5lA==
X-CSE-MsgGUID: 1345We84S3a4kCXm4//OBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="268225748"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2026 00:01:20 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 00:01:19 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 4 Sep 2026 00:01:19 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.44) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 00:01:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GaAMayYPCyLT81iKrUyrLGmbwAJqWHKDIWVXec7f4KEpkrg+wHp+2afaJT7h1gUFJWY/6ibsY6tbrFoCHO2rX2HSNH07JAuPkFJozV2C3fCmsAEtaIJhRismaHrCQFY7uexETFd4utS5PSY0MvRdfenejxCqo/+cnVxk1EbSlJi74VQZMunJV0lYviK9iqWtzDPJTkUtsZfLEIF2n8aLCoYsi6bDPQ2h8YiyybfWnEBV+/3PsWeeXnlfG6FirSA/5qujIKJ9D9iaTR2cp/Z730UYKWeA6QdtplYAUBnWCDRJKdg6HXtoXX4Y/PIuSePXVBciJ2yrDRI+zy9tj/pG6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OSVzlTVSHMFGsIj7jwSiefh49fDkjQaInlYvN0MbJRg=;
 b=zO2+Hu/u7hAF0iE8inCDlgV0oN/M4qy3MFQJCKi24xaI+HoTbb83BHU9Iy25XWSmUZLga5z3osvNWUQWwdGcX4/5QXXzy/GWIV9hrO8F1HXftjZiAh3BCRgRpzAPg3u4gA3JgXO4KZ85nhG9GOoOFuoEXn8rEmMuu+XJbf4sQ0b9gXtcMyIGslht6xbcEg/F0i9rKjEbAQoL/y1R07pUJjVwxKsOZRH+8dQ1ONq29J7fpKTOsfWSh4rDNyh2CG0jO6DsPjhOHLvc/taG9hxRRQM1p+9ZQVhLX3fXdenaoJ7jwFP9QiwtpNZjyWm9p+t7SvU68A4QSfh3N1ETivMgOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by IA0PR11MB7355.namprd11.prod.outlook.com (2603:10b6:208:433::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 07:01:16 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%3]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 07:01:16 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: Marcin Szycik <marcin.szycik@linux.intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Penigalapati, Sandeep"
 <sandeep.penigalapati@intel.com>, "S, Ananth" <ananth.s@intel.com>,
 "alexander.duyck@gmail.com" <alexander.duyck@gmail.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Czapnik, Lukasz" <lukasz.czapnik@intel.com>,
 "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v5 12/12] ice: use ACL for
 ntuple rules that conflict with FDir
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v5 12/12] ice: use ACL for
 ntuple rules that conflict with FDir
Thread-Index: AQHdChZJDh7YNnXfEUylNicMNG3eura+WjFw
Date: Fri, 4 Sep 2026 07:01:16 +0000
Message-ID: <IA1PR11MB6241EBEF55403E74840E60C38BB52@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260702103007.97020-1-marcin.szycik@linux.intel.com>
 <20260702103007.97020-13-marcin.szycik@linux.intel.com>
In-Reply-To: <20260702103007.97020-13-marcin.szycik@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|IA0PR11MB7355:EE_
x-ms-office365-filtering-correlation-id: d4ec5d87-bdfd-4c05-35a3-08df0a5250a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|10067099003|56012099006|4143699003|11063799006|6133799003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: 9KVUqqJA8xxRyHch9fxAZQrdBCqSG4afUiXIhurp5ruljOWPZ0N21c2DmWUJwW+4yrbaAdF3m3N7Vn05e4fFvTGMFni0wn+ShnRd+EiOC/RKiv7mAd5aeSknWStQCIJTLqASLb3EPJgh8t2BHPihRhPFtBrHNpJ1j4jj8CyEncXLAiJtuoq9c9MqJGyZWjXAwCj2tqWoObS7eTJSdpaetnzLfl92SPRXtqKw9A5Z+P8ftTD95p0W0M/EYWMWPIDlfk1Oh+K6e/7669fSKRMUDb/Z4A41JaTeWa/nFLlLeAFVdj8d4/ZvCtjCvJSzQc9ALjTNwSB2Y3F6W6q32xl6wp6QnaqouYBI3CwrtmnoNU0T1DTlRRf+5CBosRvbDfn/skIw2fC1rBbQ6rz5uU0VaiwHUpvqiwYaD4FUSRe0c4IfsDt9XgcUanPKcyI7Tx7Kgck+/YhVKWGSIfHROtk1sMvV7QGzpq4YpW8t2vHZbexGzVJNeG4JmL4xdtimPK9tzyKgmbmKqENJAR69KomUJ+W2BSgUQoapZMn39oEmCEkTqHe3EIDVjSR6lIAUbOVYcjqUNxAkS4ysrm9OZlBFbWjEL9M6EbYD9oyQNMCnsIAJnrkTuL19Wuz4zynAFBp6jp+V2afdnElGzGXBN2z8/gNdg0cCiGIeeJvAcoOZ8/fVe1HyvJUDaLa8/HWvCM5SOYhdZgauflv2qzW5x6Gtvw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR11MB6241.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(56012099006)(4143699003)(11063799006)(6133799003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?prU1ub0ikQtvaaFVxqAHwJBy2jSQ9148a4QwE8Ru4oOFw2Ew7gYntU48gyVJ?=
 =?us-ascii?Q?QxdvBiolY0W8zF70XuFXO70rojMZmXb2gAV4l3LU/lz09927a06GNA5yagYP?=
 =?us-ascii?Q?ysTOJ+zBUz0pyPGDaF5dN6wvKrPdHuPLfOdbv/DUg/hWEq1Q0P7d/G6Kjn7g?=
 =?us-ascii?Q?buMCrrFqibVWhQvGya3CWj0Y6vnWQUvOBbM+Hy+kVCgD9zF8hnQiswIMvPBV?=
 =?us-ascii?Q?himm5sfKyy1pPWmJp49QNb51Ak7fsFQj5sCeTyHQF7IOQ+QDYmOrcKcLDjMl?=
 =?us-ascii?Q?3cZuslkIh4tmZRa8H/aE/5/68Pg4HrI4Zy6O0LsIc0e1ug6MH4CFtP0BhbBP?=
 =?us-ascii?Q?6WdAdEo5CL6ZDPRa+eY2aw2ilwI4Sx4K/2ZE435pqIoQKZ3rW4BsHQ2N4l31?=
 =?us-ascii?Q?gbYItP1VabcTS5aGN3ZuC5r8xzIDM6Z3faKZcVtxaKTWyequ6Q5pL5Qxtpc1?=
 =?us-ascii?Q?LSsJz0+M5dtLTwHhwFeNCND9nIWIx3XJb0amYDWHvHLyIiGp9sBfAh8Y++V7?=
 =?us-ascii?Q?m7ahwra8Ou3Mom4QFiZG/ez23eLrR37WMxOCN8USre0br+Hg45C8vcl1U3FO?=
 =?us-ascii?Q?qtXVizAR/GsXqVu3GUnRuSRIm9RY+dmujEAdXr9lImVErLmJn/FrSZbg67kl?=
 =?us-ascii?Q?rWwQW79jKg3zJhQ5bbUDfnYHPLcguCSj6l0+loFZVqT/uoVbrs0LHFDdHSw8?=
 =?us-ascii?Q?xblfdh7UHHDGLJrzGl0ORmlk5SWt3npRGtFU0oGI/BTPg5YS/hTLIQ8bTg4r?=
 =?us-ascii?Q?mtTICk7o7qtNdC+YhEvu8l1iICVZSXdp+2UVDV81blyzT877nCCslFCXDKhJ?=
 =?us-ascii?Q?ONy+5R+RnJDn7vffsiNBFNEF3x6B55Z3oLmUmDeSSGiug7nMtS9OD1Afjypj?=
 =?us-ascii?Q?PPpBZoSixCt8yAnoDPt1RNLUsgjC71Cr++x4RK5SSYUV41EBLwBz9Fucs7pP?=
 =?us-ascii?Q?D9P0si1YnqS16VpfmJJjAZG1s+2qdSo0KPS5OBpGaLvJbF+7v27pAqVGMVTK?=
 =?us-ascii?Q?SXIElLONZKLJldyRhK+zXkPkhCJPODi8sluaPHwpCqse/C16UjMBsDsVn81O?=
 =?us-ascii?Q?LopOwQuRJq+xuKg/TxPPrDW2ulCTw9CmYipvG6Fsp773lV+NT0i3QPaVAvXl?=
 =?us-ascii?Q?2KUjFTTMi7hkp009ca47oa+6UwZI2wzIf5MFzmDqNaMarLP/qmIilPR0noYL?=
 =?us-ascii?Q?1hMWNcoM0nDRbkPY/2rfB0J+Sc8mcDtwmX+VwX36436WKLzAW01T6zB87lx4?=
 =?us-ascii?Q?Y3ZL83PuLlviHDeSCvDmWV/fvUKe+wQiZOgJPZG3UFwAIMuqVm+YpRhqFBaw?=
 =?us-ascii?Q?5OUwjBQBYWVJziIPBRleSjrITg866WNqcsTpUbxlJgtNLZ+QjsVkmJDgHOWB?=
 =?us-ascii?Q?pIiNm5ZSTj8FHsVZ+ONZuUXaGBmgIROfJoWXrtn7LJjxYmcioZAyyNdA22Wq?=
 =?us-ascii?Q?faim33L9IZi7LBWnRbpSKE4d5Ahp89JXNEGKZubGy5CSZUtYU99GY0vwJ6yp?=
 =?us-ascii?Q?JGKNbtrk4WO40GMdEI5SDA7+XsR3/yKFcl/bpBA3uvkGpR0R6AFN3qNatoVu?=
 =?us-ascii?Q?uepfwoi0CXkRvTntdhc1gQHW8E6oKlSjwdK/6kqQ5q54VEbyYrDoP7Lt4Fvc?=
 =?us-ascii?Q?Ry06wt2mSPDuaUS+b04Nd9+lR3oO1U1KB62bYnuAlyyaArptBPs2j0lvF35z?=
 =?us-ascii?Q?oUZhZMWoI+fzAks+cCdAmwDfA+07JhMxIFA4PsCkjtWFKuID?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: CnPwBK2QNcB1LunSuekAQL5FDR+W4CormoLaQyu0p+sF3qdi8JUA4b0WCm47pxntVJjcLJfUt7g1QBepUg/TKy1g8RmJggnUZhg3YQHiFJ+fYyVGO+6cII3PWsgvYFW4wAtCwgaor3ixN2uKgM9436LK4Hp+WkXcmUGZ26E7POD9eA5uuuEJL/mUu03GsQg3ZWfmlE/DWBrAT2h/NXQu5vta1cLBKBV8UYAs2E0VX0NamRegq12gbAV3bclHG4eLi1xwTDVx6jDQIx2OIJa3WrrWcASZHQn9HejEafZJxlT05DkjUQXqDN6jTPr/dvOyINFcoAZ/4fTAj4EU3IYbdA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4ec5d87-bdfd-4c05-35a3-08df0a5250a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2026 07:01:16.6046 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xePPI+KfXXEjM3rsckD3H4OTlnzh35/ya3ht42walzDEBF0i1cc9ZWBgYNKlteBZ5ON/J1CrHkx+CvArfxzfbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7355
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
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of M=
arcin Szycik
> Sent: 02 July 2026 16:00
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Penigalapati, Sandeep <sandeep.penigalapati@i=
ntel.com>; S, Ananth <ananth.s@intel.com>; alexander.duyck@gmail.com; Nguye=
n, Anthony L <anthony.l.nguyen@intel.com>; Marcin Szycik <marcin.szycik@lin=
ux.intel.com>; Czapnik, Lukasz <lukasz.czapnik@intel.com>; Loktionov, Aleks=
andr <aleksandr.loktionov@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v5 12/12] ice: use ACL for ntu=
ple rules that conflict with FDir
>
> From: Lukasz Czapnik <lukasz.czapnik@intel.com>
>
> Flow Director can keep only one input set per flow type. After ACL suppor=
t was added for ethtool ntuple rules, the driver still only selected ACL fo=
r rules with partial masks.
>
> That leaves a gap for rules with full masks that still require a differen=
t input set than the one already programmed for Flow Director. Such rules g=
o through the FDir path, build a different extraction sequence and then fai=
l because the existing FDir > profile cannot be reused.
>
> Detect this case before programming the rule. Build the candidate IP flow=
 segment, compare it with the active non-tunneled FDir profile and, when th=
e input sets differ, offload the rule through ACL if ACL is available.
>
> Refactor the IP flow segment setup into a helper so the same logic can be=
 used both by the extraction-sequence configuration path and by the conflic=
t check.
>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> ---
> v5:
> * ice_fdir_has_input_set_conflict(): add a check if aRFS is using perfect
>  filters that may cause a conflict
> * ice_add_ntuple_ethtool(): add a guard that rejects flex-byte (user-def)
>  filters when they would be routed to ACL (since ACL ignores the flex
>  constraint, it would silently offload a broader rule)
> * ice_add_ntuple_ethtool(): join subsequent conditions that call
>  ice_acl_add_rule_ethtool() for clarity
> v3:
> * Include flex fields in test_seg to avoid false conflict detection
> * Skip conflict check early for ETHER_FLOW
> v2:
> * Add this patch
> ---
> .../ethernet/intel/ice/ice_ethtool_ntuple.c   | 189 +++++++++++++-----
> 1 file changed, 140 insertions(+), 49 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
