Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 162B6C79F80
	for <intel-wired-lan@archiver.kernel.org>; Fri,  4 Sep 2026 07:01:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D952A81153;
	Fri,  4 Sep 2026 07:01:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D1qDIp_f0FPg; Fri,  4 Sep 2026 07:01:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7BE9881140
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788505282;
	b=ABFmPAuetjR9TVzIuXQkvryrbTIEcqoNsNOYhTuCCuXPC9jA+FXZ2l/pKT5CckYu3agO
	 TJenkzUayaV1LW61WQCKXolqfxp2aXHGev5ZfmjpDGFjO/tS1NCI24ut2gHNewG38KTt0
	 fvN3lR8ApJ7oDsq/gleBoplSy4WALQNtx/FtTVJMOSsEQZkMwbYUEXbYR8RSWgV89pEjX
	 9Q3bHp3DV8at3kDTHcUfePm0uT2SJid4jXaFlTbPypQ5RNcYqrv5oz2NB8dzkJLUQUGVt
	 HMB3rVXKIL9LOWLgKE81Z/4RdzBVqj+5OgQ8oBuYl/UBEIyjWYq0arc9dKESajSPCvw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788505282;
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
	bh=JW0pL46r1jumeBuc06vjoCd0oN4F0n7n4EO3HQIIN+4=;
	b=jswLelV9aByPfO/+4VnghmwvRr7DRt9nsUBJavO68qCiEcOOFGbFZulbniL6FP+XvKbR
	 03OsC17eQEFFdHuShedFgme8wFghNQXEyH8KbPjTs8SFuvyx+BXX0tbOsLZgmTPrxCUGN
	 mULWBGKqvgX9q5Y1fqqK6GlER9GDlEjJ9ucEhpIO9NdOTLDpTfIcpKYjcz6yPbjfG33+x
	 sN82ywd48lzFyR23lFSiHPblV9ILx9FLmGHtizDY+s/XiM3IB0YCTYPWypp5qi5cMaEIU
	 0xwQodQn5zMU9N/t1sR/GyvhzIhyTFuZ1qgPUxV6hqI9/5Tj4+2rXF+qewsS8Ebxa1A==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788505282;
	bh=JW0pL46r1jumeBuc06vjoCd0oN4F0n7n4EO3HQIIN+4=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qynzK8HYTeINsxhsFZVDbytfjl7xuyK7INQ7bhGS61JRmqrKXJ06vH+4sgErKZpnb
	 fv7SAOpeGKejJtA+afD8aSdT/1t5GK+DYAcOgqbx8k+wXQJy4znz1BpdhEKkcGoi10
	 oiL1jnj7iw9Z35MRckeGoIJ8SgYw1v+0nD5l+m0sP3YWK5h/Cg4KeeXRqLgGBHYRuU
	 lQO6cGJ9pIXBZcR4NMYL7Cn6pi54Kul+hDBXkmHrXF+Y9JrGbARZzbzjj5fruowhYC
	 8kuZeRyC8MD4Dy8LH0MIw0gXiwve/JOTFk4FFXg5Ox8uA3sBJ93Ulo9BsjDd46oFH5
	 QGBCYC6CRQweg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7BE9881140;
	Fri,  4 Sep 2026 07:01:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 99550B2C
 for <intel-wired-lan@lists.osuosl.org>; Fri,  4 Sep 2026 07:01:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7FE94400A2
 for <intel-wired-lan@lists.osuosl.org>; Fri,  4 Sep 2026 07:01:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CBb7nm1w0JO8 for <intel-wired-lan@lists.osuosl.org>;
 Fri,  4 Sep 2026 07:01:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 627AF4039D
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788505279;
 b=czE2ieUBKCV1pWwMKAhhBBWfz8hHn69Gux6hsN6MmaDLwfNB5drgiF66SQcGdjxKwIFe
 KqSa90ShC7H2H0mvJo9m+aMOPkXf23a3BIvbXWE3kavjBLfv6TKHaEMOo3s0Qwd9A6v0j
 BCAa/xE+8QwI0Kt1BaFmEc39xf+Y1V3ylXQ147ZUrS4R6+IIWTE/vc8pXIRvBh5DcNY5Y
 oSjCrXpvNr2RVUBqphPl6IQrSrksrEpjGW0KZHZvsz4SvUCOvaMj+fbPovLKGGka+3nsd
 BvI36MXm1Rb4qoWy3K6N3dMNxd+eOsVxeHM40YVzlyd32Mxeu8muGMQAzP07Fs/B6Cw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788505279;
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
 bh=JW0pL46r1jumeBuc06vjoCd0oN4F0n7n4EO3HQIIN+4=;
 b=rQf54G+cTlJlLbH//hoRhv0fDyI9+op0eEAT2huBinl7M9QQ0rf4bsi8aUI7WKRgYemD
 v0BMnVdhoEwUMP3Y6qy3b4qP7t035P3y8ODmZggROsp83EtPjJQwE062+f4vG6mMdqFDB
 tXe7xwIvTC7BHolNbvq3fdbJZeb2E2JQ9rjHrkDZNMD1uDsoGO5HP7+MkEPcQVZd12dpz
 0nzBI89nYIK/Hs1GD1efvY718ZP+VqUlIcsEf1bjKAX8V60LRxApkLxwnjnHwcY43yrep
 cGl8rThsmoYqGkqbPt2AjF37qaFNpU+jPVo3aOOGivAkLA5IrEySqQVKE5I3sMoqsnw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=S4JDdASy; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.15
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.15;
 helo=mgamail.intel.com; envelope-from=sx.rinitha@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=S4JDdASy
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 627AF4039D
 for <intel-wired-lan@lists.osuosl.org>; Fri,  4 Sep 2026 07:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788505280; x=1820041280;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=3K+3xKELdu92Te+HKa5fHEoqNwsmdOcZhbqHsK3n1k0=;
 b=S4JDdASy4qDSB0owc+3NoS2i+5RjNLqVfceszIEx2NeQv//93b15irI9
 B8y2XsDVfqDyUDD2xYDPfv0uzV5FlmRt4JJuWYLpeitv2KTBrERjsPMti
 nYHu8gBYJu/+rlAubuYthR6F5zqCGgQs+GKT9hqEh4RkfJjyQEMAc/VaE
 Y7E0sOejAsbX3ThgvgaP7cUzE9hOSkPAW5APPb95LRUX3i2MXC0qpx44j
 o6mtA/94rsvUlbITpW1Tq07o+EymAzsjvmxx4vyBoOox0OtMbcdhmoUmZ
 sY5jA6yYcyMd+k8OewQyIN/fMHs38M/treHEcvcvKja8SQpwCOHAORJXv A==;
X-CSE-ConnectionGUID: V5fUwq55TFi7QvMhum3JPQ==
X-CSE-MsgGUID: IKHiRvm/Qe6qk+hNX1EWiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="92699552"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="92699552"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2026 00:01:05 -0700
X-CSE-ConnectionGUID: njrGRnSIQyWt3qHcHU2wLw==
X-CSE-MsgGUID: q65cM3hZQDi5CBuFu+788A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="299826672"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2026 00:01:04 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 00:01:04 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 4 Sep 2026 00:01:04 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.53) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 00:01:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nUlMBsw7ObS2TtI9bnmHTvuFB+pPawyoPLxOFsmI1DbtD5o50LD8u6N4MzouILpUjpYjLbDH1C6hZt10XDorwRw5rAqXRQ16XiSvd0KrL8JWjLL+5xRoSQOE3n5hzLqsnN2AYwDzlt2ctgcQovnYRll61fRtASl7VOz4syxakKpliOICKjhsvHmn/VApYzxXSDvj24VKXQcBrglolzppVfXVZCeTPGUyNxZtbsh7wS99SQNvSp1eJcz1gLzMtztsyTMHfR/+AaCygjfC4tcVV/iYIuyzE/gS90k2JgJoo9fFiPAEREorKzLvV+EUHuKD1ocjjA54ocpsRyqXCV4XTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JW0pL46r1jumeBuc06vjoCd0oN4F0n7n4EO3HQIIN+4=;
 b=fVRbedYfIhfSJ2UScpLo6l6vZA7QoI7IVfAtGmlrNNPJCuuw9na30AAsmiSliNafjU2O4Wsry7mkwrSbkAJfiUAbAcWKonY5IORxtpyYJHxFmzFOJseluGbQB3K4WEUimcTxmXsZzE+uNIWC4EgE55cDrNc1mA2u8S2cSGD70USvj0By9o/Q/gTG7vnemK9OxdEtU8SHo3bQPD0N+dE1C3kUxK45Z9QfhQ4zM+BEtBiRqPuJ5m4C4KcVmQDY3OAfvA5ZeyiVwICn2FGpS5vkp+tsGsTFah9w9c9xP56W3BMLK2L6wJglGhn19nzkTo0I6ETqHhPMkj878nzNL3Pq2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by IA0PR11MB7355.namprd11.prod.outlook.com (2603:10b6:208:433::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 07:01:01 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%3]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 07:01:01 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: Marcin Szycik <marcin.szycik@linux.intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Penigalapati, Sandeep"
 <sandeep.penigalapati@intel.com>, "S, Ananth" <ananth.s@intel.com>,
 "alexander.duyck@gmail.com" <alexander.duyck@gmail.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v5 10/12] ice: add ACL reset
 recovery and NTUPLE feature toggle
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v5 10/12] ice: add ACL reset
 recovery and NTUPLE feature toggle
Thread-Index: AQHdChZO6iSMKIgjIEy9y6nMHumm6ba+V6cA
Date: Fri, 4 Sep 2026 07:01:01 +0000
Message-ID: <IA1PR11MB624173583898AB9E343DA0E88BB52@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260702103007.97020-1-marcin.szycik@linux.intel.com>
 <20260702103007.97020-11-marcin.szycik@linux.intel.com>
In-Reply-To: <20260702103007.97020-11-marcin.szycik@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|IA0PR11MB7355:EE_
x-ms-office365-filtering-correlation-id: dd164554-2edf-447e-98ec-08df0a52477a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|10067099003|56012099006|4143699003|11063799006|6133799003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: Vorhytj2KP/flRojBZmHYKCAam6CZCFJwRbOA0ogs0G9rvT+PvMlTX/FpObu/sqG21QXhMn0HixebImSIuHbo64YcFh1PAEj2JqLtwQ7MKANH+W/byOd7hiYwUYCF0OZR9QVVwEH23l22YYE/gh9b/GLucT1UtXsvA+U/kkm3LTe7yFPM5mIKM2sXJvSqzHJTzh55/LSi1pDKewa4QO1W8YMLNgENZxmLlozmHCzReXnJxQxe57hxWPbjTmRJ9jAqnLUonQ2yRy7dhb2xzINymhtQf5qJW5+gYwfKqZtqNHeCzQziguIAxFaSF68jOe88GzAISwKWguLOyWiUXOTrIDKldkUWoPa341kxlBPmsHyF+P7vimLZtu/fdZT++SZqifnRgxYqEE3pdJZvzSB8Lku4lhoVdWcUMDYwMUNfMGFXL8dujHO3MCmtLPxzk0SOs6tsXSu8DCocgU3SqU8oYeHDkuuRsTviQtHXsQSko4/cmQFE4ZqDi6pLcjieT2YN38QavfmfwuYrP8HSlE4yFPys4oEG10iym5stT/EcMkwJm6MxAiS/Ajh2PIS9vjoa9nJdyB3a/VDWsnyBNtveP6zitryXPjqD5vRziNiGDN5FvkKj1yu0KTYuf3BgFoArGZnQsJas9DaYt/2EMiIkCK1EESNBqGNaTRiTAZhsvoqnCrAa1/FQmleJ1OW273gMSkzWJpVz18ZXmOm+OpTpZ78sSj5JGqH5xkbiF3AdN8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR11MB6241.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(56012099006)(4143699003)(11063799006)(6133799003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?y8DAx9wCGP3BM3801CtLl/ZBu1YpsdOR8zZxwMR9Ag+n8/b/zTbH5l+TaJM1?=
 =?us-ascii?Q?gmNNUVAQJMlv8FKtXaOcco9pnMgePDpV6QsRT1wSw27iiHLdWtajVATC+y5G?=
 =?us-ascii?Q?DvvUHvpsuEXAwLpsyV9fmY+s4y6KVJqDWYQWZ5SuvRBpdQ2b+i5qP0jiCEwg?=
 =?us-ascii?Q?PJ099u6qP3mdVPFt9hXCwP0WQ6XiySbAKeI9ZQB92IY03oOUVvtj7AsSRIwz?=
 =?us-ascii?Q?nVvGBrrXG8IToF15W8ZoZrROS3VCAC24nVL+0ZeReSUhPLb4ST2kUnAy57ys?=
 =?us-ascii?Q?f898/Q7lCb2rjIvhwoNvxlkW1FEJSbTVbHnqeIMllWMPC9qS6hZ/YCvkQPSC?=
 =?us-ascii?Q?XzQHEaHbhs6N67TqajiUH0ObGnNjCFLhBcu3c67EdHrrYVBZ+TmWXArHvLIN?=
 =?us-ascii?Q?0IhfQCUpwfpwGbofZHJS6mFJouhlU23+E/3rvFKuLBNh39dyoAubX/0Nicq/?=
 =?us-ascii?Q?bV/IQKTQWKDR1/bs54sRncbpKaVf1x2SqK1mQTGYcTI1N/maV4hQ2ZgIrraT?=
 =?us-ascii?Q?tV/LhNAzqGjlopIpP4PY+gPaTmqHMB2oAzW89YAurINKNEUYg3lJ8Zhp54xI?=
 =?us-ascii?Q?EN5XH/Q/FJOvfG2M84fJH/m+LykkJ8LMsqCp7bYOfrMzdg15AZ3Qr2DspVRm?=
 =?us-ascii?Q?HK04Ua76f/Axo3D2CKpHHNDqKuSa1cx+beqLCF6BLRlOVM9gYG5bTHadmlso?=
 =?us-ascii?Q?IchqX2XohmAL9w2/ur9GAojTsMGhzFN3QbCIOSV+7e36MWIcytZ0RCz//wIT?=
 =?us-ascii?Q?05bqUjoITHSajRMrFItmqBnXGiF10Q3un1CQFbsfIKsivo00NhWqP8MjnzJ6?=
 =?us-ascii?Q?baX3xOTS1W2xzUf0GmypC+P2PM3N++CWJBPfiHGOkBNEMEtHweWGngfLhQ4O?=
 =?us-ascii?Q?NolxyULGFhN6SHSOlY9ndMM0vAA3xqJjKx2Q6vQ+TmhGvvJrI02KCLmyOnun?=
 =?us-ascii?Q?orXKNp/+aA6WWDWFMAhJjJrEKMeitTmk93Q0IePQFabEdRVIRALAL5/2bFMt?=
 =?us-ascii?Q?YJCLMpMoWVDC4TU01zAsumBt4v5/jpepIJx+LbWfbxE2GO9RanEm4aaJTkwL?=
 =?us-ascii?Q?lI7c1vQMxksE2aNhSmgPj4VbGikVuJodOQDBNC+rXT7jUoqvf8iiOFt7NMHQ?=
 =?us-ascii?Q?wih7mPYEF9dHT+siQPVcxu4gPXyVSEfJ22R0siH7ks8cTUw/6kpAzcBem6hE?=
 =?us-ascii?Q?YQzHxcEYhxbo8mfr7VLQpoakNYtwqRFrrWitOBHYgxOz73eCVTtC7/U8+vUa?=
 =?us-ascii?Q?3XxECSIbsGES1p60T/D/pjgHU0qA6EOzi2BRWSQIajQUjPtqlUoK6v7GT92L?=
 =?us-ascii?Q?7e6MlZvwpmwbHXYdG/UL4YevWt7WSz2DGgV5Axku3f6KlKQhBojH5FfyMUP+?=
 =?us-ascii?Q?4kJrKlqmoIeW9HeBVG8hlxN9YwHCndJ3wFKb8Mm6IwEF4/YuwExhFlHDwbae?=
 =?us-ascii?Q?zgy6lA9DT0FzEO7tYK7ptj947HtVmLfdoDcf7oeXe5/zmrv73RwFaxks1NFQ?=
 =?us-ascii?Q?otGv2Kit/Isinc7H+MAWAVfXUtk0AqSedV+fDqsPD4MUoUoyy5As/jlTX8Kl?=
 =?us-ascii?Q?2g4MVr95HHvpoRA30pq4cGKz2fCm4L6ShzcWGF06ZuTVkJGqXGwKw8dv2w6j?=
 =?us-ascii?Q?JPZXD3+3HUsXZc+wGSQNPM/Lo6GFNLNcrjVoGnbd+W93zGtG9yoUxacAxmj/?=
 =?us-ascii?Q?Xu3+npyjCCbD775qtC/QysAqrSfFZMzue+3ITRd+81zdkuMh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Q1HN6rzg6l/8opGoYbxnFSCV1lYm15LUrt43VPky+cE9ixpjVvIXHOkzb/naNT6BeRlVbel6trKB9oa67R2tndeRWpn+NMZmHA47n1eEKyzgxXdZrVmF/TdpQGi+4I83r6CIaPn31vq+9x6YiLJJhIPxyn03ovUcAUyZklk1VgAyLM4zXHKB7ESS9c+neECUq795Xzizr4NkgeC4kVYJYjt+4xuaMh9yv1ue17mPgQAVsUtEd2LHWhtxDHkTea1EsvpYdDCtF8BLuj/zoniN/NjTLxBnkT6k4eXRrcqk6YNMvEYyz+mRJ+mVjZ3S4GNoDLwEH0bocDNYyg2aem/8Uw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd164554-2edf-447e-98ec-08df0a52477a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2026 07:01:01.2375 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZaEoVetGEuiESmQRc+g2a7HkTfxGFVcGmSsTiYFbc4Lt8SlAPBfr+3Pju9Yudb6l6DBimp1WkmR/CwjLnsoeRQ==
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
ux.intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v5 10/12] ice: add ACL reset r=
ecovery and NTUPLE feature toggle
>
> Extend ACL support to survive PF resets. Add ice_acl_replay_flows() to re=
build HW flow profiles from preserved SW state, and
> ice_acl_replay_fltrs() to reprogram TCAM entries from the SW filter list.=
 Wire both into ice_rebuild(). On failure, don't fail reset, rather delete =
all ACL filters from the SW list.
>
> Reset per-profile HW extraction sequences and range checkers for all prof=
iles inside ice_acl_create_hw(). This state is separate from the TCAM entri=
es and survives a PF reset. Explicitly clearing it ensures that the old con=
figuration is erased.
>
> Add the ICE_FLAG_ACL_ENA PF flag to track ACL status. ACL is always avail=
able, so set it unconditionally in driver initialization. Use the new flag =
to track the NTUPLE ethtool feature flag, alongside Flow Director, as both =
blocks are used to implement ethtool NTUPLE filters.
> Like with Flow Director, disabling the flag deletes all filters, but enab=
ling it does not reprogram filters.
>
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> ---
> v5:
> * Add this patch
> ---
> drivers/net/ethernet/intel/ice/ice.h          |  4 +
> drivers/net/ethernet/intel/ice/ice_acl.h      |  5 +-
> drivers/net/ethernet/intel/ice/ice_acl_main.h |  1 +  drivers/net/etherne=
t/intel/ice/ice_acl_ctrl.c | 43 +++++-----  drivers/net/ethernet/intel/ice/=
ice_acl_main.c | 47 +++++++++++
> .../ethernet/intel/ice/ice_ethtool_ntuple.c   | 79 +++++++++++++++++++
> drivers/net/ethernet/intel/ice/ice_main.c     | 47 +++++++++++
> 7 files changed, 201 insertions(+), 25 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
