Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A4E1CA5FFE
	for <intel-wired-lan@archiver.kernel.org>; Tue,  6 Oct 2026 01:49:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C9E7B80A90;
	Tue,  6 Oct 2026 01:49:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RR134mpt8xxX; Tue,  6 Oct 2026 01:49:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 07ECF80ADA
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791251389;
	b=F9mliCc4sab6ve7M1asngoKBqyh2VWj+Rublif9IDvLfTTzeMkdJcZk6ZQRyW9ZoYdVa
	 EeitLkGdK4qLo9XUyXt3F2HjYKkpMXYrEuwc+9Pjib45M9LgviQ7dHZtDwQGSeB/eB2aT
	 STgvs5HDh+ZSRwqj+OUffrWzve8KYOVd2qMGAuM4ZV4fwutHaWwb3DAIon0zlc7oUZ6jl
	 mGNtroVlrRPMdWcjdVAXLzIC8eJ61nN6EFHzj8CajyQ8OmyKxVBsRaa4+C4CPJLDBU/C8
	 wncisAezNUwb1dPRkrSKJfWUBF/j5IM/KBXns1UtF+pLG3onYLdeJH74MXZIn0tcX7Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791251389;
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
	bh=IIiwInK7NbylDlzOL1CBLz0GuqB2juxeHcAFdYaWE40=;
	b=WYNXXoUimZYubAz49bJupTWPBIfxyBSOSGPMR4Gwldd/J3qdlzqKzK7cSDG3riUtzF8O
	 2XIqZAzNWmoDVVBHYLpcr98zLIqo5lGhbdbSUyN6r7qireskOq3BEfstovD2+vevY+Vkz
	 g5PeMdFE7vO0/KhRBbFtJN82KQ/Fbz6//vDsjom7B0iTr2ngWXLkaLPjQGXR1Ho0rTbel
	 49ABRhDtsWov42Q9lec5qE/HjQpmRtCZPUcr034s2Ae2XNAseIbNxayb+K1iMfUWyZp4Y
	 0/yEXDc9g84EtI65eyrkavjjgXmGvKXvhLj1/g786oh3Xw6TL9I/JS/NSdFkndeEpSw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=A6fk8dQn;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791251389;
	bh=IIiwInK7NbylDlzOL1CBLz0GuqB2juxeHcAFdYaWE40=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iSXKzcCzgSLRmKoBUdmMl8frqgtGeMvPM1KF3lBl9bJTQqwHbnDXpKCE3EiyB13So
	 gsnbR4U3SLXxPsMIaC8FyWPIP48jSNJ2VbMwsT0s1Y49kJylaTuUIRZzpsf17/9lWV
	 q4zQBOxWNGYt7vm/xuNOrtPAuekBe0+vHZ4TJ90kS2O7sKIT47EtEfSGhNc2EOvaSv
	 rYifYtaLZf4Xux/ceVwz7Jqj7unKPIwFBlsR3exSp0QFld3aVkqq4tUWGNWnCZgtBe
	 V84IGb1KiVOxcWCqEuz9HWjCenWlEp9geTkaiX65qBYw8kH3Fgx8IhLPcTQima+q1X
	 tGGEqldpQZ7nQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 07ECF80ADA;
	Tue,  6 Oct 2026 01:49:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id DE40D32F
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 01:44:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C18D380A87
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 01:44:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ip412RbdS5r6 for <intel-wired-lan@lists.osuosl.org>;
 Tue,  6 Oct 2026 01:44:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 99D2380A80
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.18
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791251073;
 b=bB39KL9bq2+5MLaKqMtzfrOKgTloIIgFRciNsqZSYpT7MH0zOh3iFPgkUI8c9bvLyjFa
 GStTQ43O0pLCib48gxf2JYKdMfEtdqIS639PoAGDltE+j40+3A3bzBYXeOtupCrIKJiAl
 6q8YFgWdMUDvDumqev3AOD7QeSg80St9yMWTQPDvS6K6KT++bvoU8TLdI7OK3M43ZePZ9
 F65y0W3u6R2ZmNMVp3A59eAJ6GJkZNv0qtE8X5RYkMz0+yiCiGRUK1uzTFMCDKSDuDpoP
 ignGWfGMopZgfFvYwmEyecyCC/nFtueuZNhYE7uvo7FuxnkI1JgtKBKobFSuAr2UL5g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791251073;
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
 bh=IIiwInK7NbylDlzOL1CBLz0GuqB2juxeHcAFdYaWE40=;
 b=Fph3lPMYQ1rwtP3wzZsDiZfQkkUBMabBqfV8h/DMDCFJrLAMAXDc6Lew6FdDHgE/DJ2d
 PFbl8ZfNpTC2ghtNB6Igi17D2isYgzNa0x3OAtgKg0DHqQrN7Ue9YZ60Xylz0F+kag2fN
 DYyapEp0N1SaY8TvDNdiFh8ow1yHQtrTZ0qdG8jEIxTzsUBEUtpFffztMD5l207xg7ZOr
 C+mqYx8FH6PV8r8y+6Ns8Yag8vTmw2zDP2BolGcHLA2CUTgkgIoIKJMRYey86Dgtxlcvr
 gZ8AMqxHpcj9v73Mb2UEVMm1C5gW6Yk8h2NCNVn8rJIzX9A/HWZaQxvLbwZW7DGj7Mg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=A6fk8dQn; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.18
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.18;
 helo=mgamail.intel.com; envelope-from=alexander.nowlin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=A6fk8dQn
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 99D2380A80
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 01:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791251073; x=1822787073;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=IIiwInK7NbylDlzOL1CBLz0GuqB2juxeHcAFdYaWE40=;
 b=A6fk8dQnf2T0MNf0hN7qqmRi7U/SZlR97RETb5foHxQAehiI1qzty0of
 E3i+hxAw4AtoNuTPzxM0lt4NI49wx/09DUuHvGcoYquAVcx6GYBqgbV6R
 ESpO38cUjcMtCpl9AK8/ro6a4gcMFLH6nlvHOpSxFr3aqo7o7dV4cERQb
 a4fEzPzL9ZPfKJvVTxL3X7TMmbASKzTzKus+BcYhip8qUqiGqiVvbCfYD
 OcWDbVK4GbPyzKQqIZ37J0XcirJmUG24jgT4HmNon19Ewdb+7s407hvzq
 +2O8VtF4NTMzY12FAB+IblwmDNLUYCrMu9Nz4IgqmcOfMZINnRm3nP9j2 w==;
X-CSE-ConnectionGUID: i0AxjF02QUSfak5A06pW1w==
X-CSE-MsgGUID: d/wqgo4sSai2QQxCHa+oLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="91067219"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="91067219"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 18:44:32 -0700
X-CSE-ConnectionGUID: 3Ph83ZKoRTGlpk2aRcF6Aw==
X-CSE-MsgGUID: cTz52zL7Tymk4e2yG6eysw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="273373127"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 18:44:30 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 18:44:29 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 18:44:29 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.9) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 18:44:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ib164rLICdDoaxd9Npwu929WbRi30wxITJ2r/sU0+yFxUZHdSbvBO/E3BGkairTYdeWtxdsJCm/G4pdYxTB42Q4prqDLAdt5SK8P1vW6qF/J2s0ZGIJX65lDrAg6/LeNr6wUCKpjryvg7PGEq+sdi1kDY+4tYPkOMqoy2tjDCCj0MDk/E8oygL9UyfDkgM2NKrgZh0QpVMrKFPwoPxqdZU9J2k6UMZC5ubT0J/vYvt2IT0631mif3VZu31DrlPW/JpBrGC4n5tp0CWdDytn3BzfR32mfGDOJEHw/UgB/lfXmlFyUUHRCHJrmVy03/eSEfveP5h36LeR7I+ZPHimGGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IIiwInK7NbylDlzOL1CBLz0GuqB2juxeHcAFdYaWE40=;
 b=YNjSt3MpwGKfiLGbedxkRrFCKpTPkBJ5qDKU5z4192I+WsePc2nTAtuO+shh89HXCb0aGvKu3OQTy0tQfd0EsKYYLVVv7wP9yTT8z0/nZySIuqQkCQHDmyGeePZ+c/+miy72hhOSdWkS6VbFqj1Rm+mTvmkqZmmeW46/eXDPvAY7xGvgrLaOzZ1NPyaQn1LCXjQdUdX1bE/lwdh9nL229YZq62hBrWv5Ve4zHRLyT1HjnEGjx4CqemmiQZSN+7OgLMG71Y1pKYjHG1fKocCtPQFWyY9FW1GerTTttriajHial2ZpKhQ+LCyGFHyLfcS9QBOaueY6JeUTBhmLzeeqVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by PH0PR11MB4824.namprd11.prod.outlook.com (2603:10b6:510:38::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 01:44:22 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 01:44:22 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, Intel Wired LAN
 <intel-wired-lan@lists.osuosl.org>, "Machnikowski, Maciej"
 <maciej.machnikowski@intel.com>, "Keller, Jacob E"
 <jacob.e.keller@intel.com>, "Korba, Przemyslaw" <przemyslaw.korba@intel.com>, 
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Nitka, Grzegorz"
 <grzegorz.nitka@intel.com>, "Kubalewski, Arkadiusz"
 <arkadiusz.kubalewski@intel.com>
CC: "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: RE: [PATCH iwl-net v3 13/15] ice: skip reading Tx ready bitmap on
 ports with no timestamps
Thread-Topic: [PATCH iwl-net v3 13/15] ice: skip reading Tx ready bitmap on
 ports with no timestamps
Thread-Index: AQHdTUnGg+CdxUuclkarEwF1wCHFFLbvzaxg
Date: Tue, 6 Oct 2026 01:44:22 +0000
Message-ID: <LV1PR11MB8790AB5EDFEE40D09F710A2390952@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-0-6532598e8da8@intel.com>
 <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-13-6532598e8da8@intel.com>
In-Reply-To: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-13-6532598e8da8@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|PH0PR11MB4824:EE_
x-ms-office365-filtering-correlation-id: 086e8ebe-7d53-483a-d52e-08df234b587d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|38070700021|921020|11063799006|56012099006|4143699003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: a9XE8bSGfxQirvIN1VfIptM2Gb5Ceed4N2UKkciAOwhNs8uHtqkZ9ObiApdKGbtk9FpFFy1sy76sQdQuMCl81BaTlMf+34W7Xmzhzule31yWVLG8j6OBQbXBCV66NO4ZTGf5pWflx9pCg4zJTXYW5XAAPUIGBZaGUJHIelKdT2j7njktU+aRy6BG0p0AJiKS5HLLzgH9a/bEQYVUuMtTUL5LNnxGI+DxPqibDRaVw+dSthNaBX8ioFz0e7QCcYkOIq2UJaHYkNIGtWkyRswtgwagPpM3bS0YT0SxZcHtwVBKiB6iDjGLV8O2yIo3J7b5ajLx/hWQ4tvLSFgm9yn0PrUlyGfhOaBkK/0fUhw2XuipyBmQJlhyv1r1ubHOn0yfMPWGORwaxgec75Z5ahDq/OpYMkgNpGF9R+geeQ14Ubybp+AZ0mBJELBnN8kFHtP/MikUPYF0esDRHWCqamaKtmRg1nzUTeT0vBhGD9GQ5DOtEx0JFL3QpwO5oef4O3EbK7dUsRMWKWOeCZCuOX7NuS4XboQ7H3pPI+iuRg2/wnAbrgy1V9wqDucbFTCYr9CQgGPQGbY2X7zEeiRNn3yg86w4T2dOIGhsMEfqH9ahTY5tYWP9EuhaUY40yLDVyxofNPGY2/l/kN1Dq2oAL076+okU9MpFSqbxFeNbg9icHVoK1Cf7IHGbhcYo0dXQxQN1gQWn+EynPkBAUOz82W9KfT3i61ULnL20AbdqgPzMZiDGv3Njp9RsgHkk6sPhKAdw
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV1PR11MB8790.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(38070700021)(921020)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dE5EZVN6dk55OUNNWUk3N3RLMFNET2Nyak9EeHNSdFdEaktWS0gwSXg1TVFQ?=
 =?utf-8?B?K3NhLzAvT280cHdGaFJUZUMxOHBUTGViWGpxMmNiY3hCQ3l0UGx6c1BINFNB?=
 =?utf-8?B?T2FUWDFwR0s0cEZrUW1SbEVacG9Zd3phL2lqazI3UHdqdS80Z24vWEhqd3dx?=
 =?utf-8?B?YnBMNjRraU90bCtmVjBMaGhxRVl0MDh4bjlxWlhrYVFLQTdkUjc4djhwWVRG?=
 =?utf-8?B?ZHdnMFVIRHFJaVJSaXdtcDUyYnV6Vzk5TG4zT010MlYreE9hMmIyTVhMV0Rt?=
 =?utf-8?B?b3pNODVvQlhNK0ExajdydzZUQUZvS1FLWTRZY1dYMVZQcTJ5UWVLL2UyYk0w?=
 =?utf-8?B?WkFxTnZmUnlqZm42UlZSUDNETFNId3h6VVcxY0pGckl3d0wxWjYzZWg0bkh1?=
 =?utf-8?B?eEtkbVJmYURXaVFZWmFuV1NvcURhYXUweHg5dGNTV1ljYlVUSkNianZWbmpC?=
 =?utf-8?B?RWVUbi9BVWFmQWx0YysvZ3M3elRmanpEWk54bW43T1ZLbUNSOExCV2NZMVdZ?=
 =?utf-8?B?dmIrcXo2MzJoQnNsWVhLaVhESGxrWU5BTkdJbm1wc29qVkpIKzZyUkxHd1du?=
 =?utf-8?B?YXV4Z3ViSng4M1BCWjc0dXdOSG93OFRqamNwamZuQVZHYXFnaXpESWt4R0VY?=
 =?utf-8?B?ejNsTVRoVmdaYXlqc3BkYVlQL2lXT09FeGswblA4UFZBQ29mUVBLdklZNStp?=
 =?utf-8?B?d1FBcmRTUWsycDE3MkZLQ0NZWE1wdVNYdFdJSDJyUzVHMGpsalkwY0FNWTIx?=
 =?utf-8?B?NEt2dmo0am1OV1JzM2hJbGxmb1F5SHdNM1J2RWI1TzluRXVoMGV1ZEpob1Vx?=
 =?utf-8?B?dnFZK09DeHYzUFFacDBack9YK3FZVHVYZUpJYUJUcld6TENINnRIc2RYS3c3?=
 =?utf-8?B?aHNlcnM1SU1zNVhHSFBSc3o3NHFySFI2THlyS1hnZXNkOHY5NGh5aGxlUC9n?=
 =?utf-8?B?OEhmZGJFN1Q0TEVVOExNRWt6dW42azBsOCt2Nk4yYklCSStpSzgzV3k2Y3NU?=
 =?utf-8?B?WXA4QTNyQjY3dW9PUVZuV0xQdWgxZTRSSDNkUlMyVzJwa2lsZFJkQzNCZExh?=
 =?utf-8?B?eTBzU2daMlVaNkRLOXJsY2tRZ2R0NkpRQmxieDhEOFo4NGpzRjI3aEdia3RD?=
 =?utf-8?B?aXpDcjFYbitxVkx4NWxzWXBGRy9pUkJMOHhTeHQ0cGhQSlAzaVM0elZzSEpV?=
 =?utf-8?B?L1E4ZkVGN1JQeFFMV0JucWFvYWpQcHp6QWUyQUI5TkR5Y0NzQmIzelliSzFV?=
 =?utf-8?B?OFN1Sjc2Z3VoS3hkK2wzdFNCTDZPbTZMNkpIcnJyOS9zeElLYVRneUNjVFpn?=
 =?utf-8?B?M2NRaGtrWUcvU29MMTJZMjl6ZFZRMFQrV0dlYU1vc3lwSWFNajc1bE9GdXdL?=
 =?utf-8?B?SnlIcnYvaXQ5SUhPaDA2TGE2ZEJXb0hDNUNXbXcrcFRxOUlzYVc2YlRobUFQ?=
 =?utf-8?B?MXlpUjhQS3ZMbDI2WEhleFZGK29UWUl1bmtxRVA1anpoK1YxVS9TblN3c2Nq?=
 =?utf-8?B?QWtJZ3dqdWtPTEl1SjZPc3FqaC95SXQycTR3UmVOanZ3bitxSGRreFphVkVX?=
 =?utf-8?B?cVFJT0UvQ0NtZld4OU5oOFJHZE9xUjhyUEc4Zk91UWJlbFpWZWF1VHJIZ1kz?=
 =?utf-8?B?aEdVd1VFak5QczhyejFZVlh2S0ZZenZmYVFVTDRNQWtGdFRSZHlMYzBwWm14?=
 =?utf-8?B?QUpYZk53L3MzQWIzVjZXWmRGWmtsbi9lVU94R3RCdnZJOHpZMlNCakF1QkF1?=
 =?utf-8?B?M0EzRjJHeE9HenZwNFlLVE12UndRdjdEbS93eXVjYk9sbi9XSmpIS3UrMVBy?=
 =?utf-8?B?bWNNVSt5d2FoRWVCZjB4dnErckw2ZHExUjdzd2ROS3JxdmJHL3VKbUJhQ0Zv?=
 =?utf-8?B?OFIxZll0WDlWcGtXNHpLV2IrMTFYRG05RVFyM3BDczVWTmNzZ3J6VFNiVzNw?=
 =?utf-8?B?Q2w5cDloUmkvOGxMQUx6VzIxbGRjblI1NWh4bHRua0RsMHpJckp3d0hGVi9B?=
 =?utf-8?B?a01vSkIvMWZXVXJlZ0IyNm9NWWdDZmJRZC9OZlh0V1YvcGZ3V1lUdEZoVjBu?=
 =?utf-8?B?a3dCTUp4MUdZbFR1eHdEOHhqdStlaWZPN0NQeSswWTBsZW9xa25ta1h6ZXJz?=
 =?utf-8?B?c2lFd3A1dVBZV25ibnVGRUxUTnU2UXZ3NzkwL3VyUm5GY3RTRDd0S0hObEY4?=
 =?utf-8?B?akR5SGl4TjhIeHcyNDNBWHZ6NU4rakV1blpaTTdNbFg1eGdBQytIWDRhWjB4?=
 =?utf-8?B?U1Q3NzV4OURPNFlSNEFkc1hsaC93OXNJK0NEYndCUUUxb0VZUWRhSDB4bGxP?=
 =?utf-8?B?bFEvV1JycWREZDNlQlpldkc1YnRjaHo4MWlDYjV1Nzg5dXp1R1ZaZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: LAssd/nlfpuXp2OJO9/cbdoMYJP++ykF/mnwh1KHMj5DH3l6Dr+QmJSucsS+4XfISGCtz3zCDRnt5ZLP7ZmS/psl7qokSTpWIyd7Klk/wbyaAUJbgslHn9aet5CfgBhjIiu1vH/TJlPmLH0VN8Py0sIy+4lcYcsIQimMdYX4dQeHS56akSx+f9yGow9Ego/mnthElfB8zXAQrDrdaLteZo9GP+wcLxIouYNoQ8VrtR+XFwfva3EDBnF1l4zm8BjBAfIW/6fD5BAuX3VGI1i3pciD3yfDivVI/hHRwmKfOl4nal8516aE0AAjgRTltVEmmd69JD2WC5VL7Nwm/dlT1A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 086e8ebe-7d53-483a-d52e-08df234b587d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2026 01:44:22.3835 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8iRz2Fn0SPQ8MOyf4FzN1YBFSpo7GpqyyMPGlBbIZ9OqMl9QqWTf1ZhGYvz0rlJTDYlj/HQuZkVzbbKoSK6kOL+2elKtFxE1y7ZZBz5ifmU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4824
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYWNvYiBLZWxsZXIgPGphY29i
LmUua2VsbGVyQGludGVsLmNvbT4gDQo+IFNlbnQ6IEZyaWRheSwgU2VwdGVtYmVyIDI1LCAyMDI2
IDQ6NTcgUE0NCj4gVG86IEludGVsIFdpcmVkIExBTiA8aW50ZWwtd2lyZWQtbGFuQGxpc3RzLm9z
dW9zbC5vcmc+OyBNYWNobmlrb3dza2ksIE1hY2llaiA8bWFjaWVqLm1hY2huaWtvd3NraUBpbnRl
bC5jb20+OyBLZWxsZXIsIEphY29iIEUgPGphY29iLmUua2VsbGVyQGludGVsLmNvbT47IEtvcmJh
LCBQcnplbXlzbGF3IDxwcnplbXlzbGF3LmtvcmJhQGludGVsLmNvbT47IE5ndXllbiwgQW50aG9u
eSBMIDxhbnRob255Lmwubmd1eWVuQGludGVsLmNvbT47IE5pdGthLCBHcnplZ29yeiA8Z3J6ZWdv
cnoubml0a2FAaW50ZWwuY29tPjsgS3ViYWxld3NraSwgQXJrYWRpdXN6IDxhcmthZGl1c3oua3Vi
YWxld3NraUBpbnRlbC5jb20+DQo+IENjOiBLZWxsZXIsIEphY29iIEUgPGphY29iLmUua2VsbGVy
QGludGVsLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIGl3bC1uZXQgdjMgMTMvMTVdIGljZTogc2tp
cCByZWFkaW5nIFR4IHJlYWR5IGJpdG1hcCBvbiBwb3J0cyB3aXRoIG5vIHRpbWVzdGFtcHMNCj4g
DQo+IE9uIEU4MnggZGV2aWNlcywgdGhlIGludGVycnVwdCBmb3IgVHggdGltZXN0YW1wcyBhcmUg
aGFuZGxlZCBieSB0aGUgY2xvY2sgb3duZXIuIFdoZW4gYW4gaW50ZXJydXB0IHdpdGggdGhlIFR4
IHRpbWVzdGFtcCBjYXVzZSBpcyBmaXJlZCwgdGhlIGNsb2NrIG93bmVyIFBGIGl0ZXJhdGVzIHRo
ZSBsaXN0IG9mIHBvcnRzIGFuZCBjaGVja3MgZm9yIHRpbWVzdGFtcHMgYWNyb3NzIGFsbCBwb3J0
cy4NCj4gDQo+IFRoZSBleGlzdGluZyBsb2dpYyByZWFkcyB0aGUgUEhZIHRpbWVzdGFtcCByZWFk
eSBiaXRtYXAgYmVmb3JlIGl0ZXJhdGluZyB0aGUgbGlzdCBvZiBpbi11c2UgdGltZXN0YW1wIGlu
ZGV4ZXMsIGV2ZW4gZm9yIHBvcnRzIHdoaWNoIGhhdmUgbm8gdGltZXN0YW1wcyB3YWl0aW5nIGlu
IHRoZSBzb2Z0d2FyZSB0aW1lc3RhbXAgdHJhY2tlci4gVGhpcyBoYXMgYSBzaWduaWZpY2FudCBh
bmQgbWVhc3VyYWJsZSBsYXRlbmN5IGltcGFjdCBvbiByZXBvcnRpbmcgVHggdGltZXN0YW1wcy4N
Cj4gDQo+IENoZWNrIHRoZSBiaXRtYXAgYW5kIGV4aXQgZWFybHkgaW4gdGhlIGV2ZW50IHRoYXQg
dGhlcmUgYXJlIG5vIHRpbWVzdGFtcHMgd2FpdGluZyBvbiBhIHBvcnQuIE9ic2VydmFudCByZXZp
ZXdlcnMgbWF5IG5vdGljZSB0aGF0IHRoZSBjaGVjayBpcyBkb25lIHdpdGhvdXQgYWNxdWlyaW5n
IHRoZSBsb2NrLiBUaGlzIGlzIGZpbmUsIGFzIHdoZXRoZXIgdGhlIHRocmVhZCA+IHNlZXMgb3Ig
ZmFpbHMgdG8gc2VlIGEgbmV3IG91dHN0YW5kaW5nIHRpbWVzdGFtcCBkb2VzIG5vdCBhZmZlY3Qg
Y29ycmVjdG5lc3MsIG9ubHkgZGV0ZXJtaW5pbmcgd2hldGhlciBvciBub3QgaXQgc2hvdWxkIGRv
IGV4dHJhIHdvcmsuDQo+IA0KPiBTa2lwcGluZyB0aGUgY2hlY2sgaGFzIHRoZSBoaWdoZXN0IGlt
cGFjdCBvbiBFODIyIGFuIEU4MjUgZGV2aWNlcyB3aGljaCBpdGVyYXRlIGFsbCBwb3J0cyBpbiBh
IHNpbmdsZSB0aHJlYWQsIGJ1dCBpdCBpcyBhcHBsaWVkIHVuaXZlcnNhbGx5IHRvIGFsbCBkZXZp
Y2UgdHlwZXMgc2luY2UgdGhlIGV4dHJhIHJlYWQgaXMgdW5uZWNlc3NhcnkgcmVnYXJkbGVzcy4N
Cj4gDQo+IFRoZSBhdmVyYWdlIGxhdGVuY3kgb2YgYSBUeCB0aW1lc3RhbXAgaXMgaW1wYWN0ZWQg
Ynkgc2V2ZXJhbCBmYWN0b3JzIGluY2x1ZGluZyBzeXN0ZW0gbG9hZCwgdGhlIG51bWJlciBvZiB0
aW1lc3RhbXAgcmVxdWVzdHMsIGFuZCBzb21lIHJhbmRvbSBmYWN0b3JzIHRoYXQgYXJlIGRpZmZp
Y3VsdCB0byBjb250cm9sLiBIb3dldmVyIGZvciBjb21wYXJpc29uIG9uID4gbXkgc3lzdGVtIHdp
dGggdGhlc2UgY2hhbmdlcywgd2hpbGUgb3BlcmF0aW5nIHB0cDRsIG9uIGEgc2luZ2xlIHBvcnQg
d2l0aCBhIHN5bmMgcmF0ZSBvZiAxNi9zZWNvbmQ6DQo+IA0KPiAgIEJlZm9yZTogbWVhbiAzMTcu
NDMgbWljcm9zZWNvbmRzLCBzdGFuZGFyZCBkZXZpYXRpb24gMzQuNTENCj4gICBBZnRlcjogbWVh
biAxODkuNzEgbWljcm9zZWNvbmRzLCBzdGFuZGFyZCBkZXZpYXRpb24gNDMuMjQNCj4gDQo+IE9m
IGNvdXJzZSB0aGlzIGxldmVsIG9mIGltcHJvdmVtZW50IG1heSBub3QgYmUgaW5kaWNhdGl2ZSBv
ZiBhIHByb2R1Y3Rpb24gc2V0dXAgYXMgb25lIG1pZ2h0IGV4cGVjdCB0aW1lc3RhbXBzIHRvIGJl
IG9wZXJhdGluZyBvdXQgb2YgbXVsdGlwbGUgcG9ydHMgb24gdGhlIGRldmljZS4gSG93ZXZlciwg
ZXZlbiBpbiB0aGF0IGNhc2UgYW4gaW1wcm92ZW1lbnQgaXMgc3RpbGwgbGlrZWx5IGRlcGVuZGlu
ZyBvbiB0aGUgYWN0dWFsIHRpbWVzdGFtcCByYXRlcy4NCj4gDQo+IEZpeGVzOiBkOTM4YThjY2E4
OGEgKCJpY2U6IEF1eGJ1cyBkZXZpY2VzICYgZHJpdmVyIGZvciBFODIyIFRTIikNCj4gU2lnbmVk
LW9mZi1ieTogSmFjb2IgS2VsbGVyIDxqYWNvYi5lLmtlbGxlckBpbnRlbC5jb20+DQo+IC0tLQ0K
PiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9wdHAuYyB8IDIgKy0NCj4gIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQpUZXN0ZWQtYnk6
IEFsZXhhbmRlciBOb3dsaW4gPGFsZXhhbmRlci5ub3dsaW5AaW50ZWwuY29tPg0K
