Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0781DCA5FED
	for <intel-wired-lan@archiver.kernel.org>; Tue,  6 Oct 2026 16:12:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9FFB860624;
	Tue,  6 Oct 2026 16:12:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5ikuNjW7G8vY; Tue,  6 Oct 2026 16:12:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 934126076D
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791303152;
	b=m4iYi0ExnzKRcGTDZEmraE2rflhsPU9dg+HGHqnj2t0Jg7H6Dy7XMtR7qRK+sH1dW/zq
	 9jgvQP38+clnRLg6VYcVY40wDBU8/eXSS/nCH+lvPgtAJXECeLcAaboUfCH5HkfOtFTqB
	 OD8G+6ONy4NIdlLADrIed6XHgJyKaqyPaDMVgr2xlrCtf+qJgGjklys/5tLziX1/zYI2f
	 ndQzypk1TRrhsxNHd9iuTrJQ/pp5TphAesMECNKtidi357orX7aRy62X5VjTvVvnXpr+4
	 AZqbXGwcD/mAVqm9w4TPK9tXDdJfhIXJLDQFC5W3KftJh7CRHIpALfwEcWFmSxN1nkQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791303152;
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
	 x-ms-exchange-antispam-messagedata-0:Content-Type:MIME-Version:
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
	bh=9vzrzwGGkmKuxgqEkgQ8FfAatDDlpqz2u4wilvI1Nqw=;
	b=FAA1naY3ae22lM0iXVn3f/Mb9TqbThaBIPsZlroTxt9e3+1OvRWpKxEpjWaUB5cjIQ24
	 3GEMtWSEIRWNsasAHwFchuFWUoFTrbXlIPNVk7oO1m1TPvuwP4+2UmJJru86Rk+SjyJqI
	 rPai81k2IN9xfgbpOQLOFC29nVjF3p+qrulEcydvE4iBMeToYlNoJWw5t6eQjxjw2EIKr
	 zKnnsK6ZvT9uRFGZgIl3Fxdd/TC/q1nRSH1y12qMXrLJY+IMTJmWAJybTxMespYw2MG9j
	 EOlzz2nxsaLLmeifY4DFbvXMctApnSMj1etuftPQs7kL+gcmaNraT5wM7DTWtNaa3hw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="cF/vwIQB";
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791303152;
	bh=9vzrzwGGkmKuxgqEkgQ8FfAatDDlpqz2u4wilvI1Nqw=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PlrDX68AzWf5hQLtprzvL2nQ8rQ7KeJoUWsdshTfv0hzi6x+kfdFpX/x692UAasdM
	 NdsTII1MnkuKBAdc52EZ1H40MrEb7kdc9joYBlgxMe2YRabNeyoDSOGwMKCAFyvCUg
	 5nmxkmkFGtCideR88XdmOt8KiqwZ7xLG2Jt+cXEWnueIRzCo71cmG/Wf+txiE/oNy5
	 bZ4qsvSAqit/M1sVEPZ0owPndozCvF9jhvxJUBF+aKGSFRHrJsyEk8R9vAD+PvGQeC
	 IgzGqP1+MbRAoV4r6IskCa5VY+LRaVkheXfneBAWwdZYUuCkZuquCvJ35dhX/Ccj6W
	 FArVSwuY8/faQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 934126076D;
	Tue,  6 Oct 2026 16:12:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4A6621D2
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 16:12:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4799A6076D
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 16:12:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SkIpOypWVpNK for <intel-wired-lan@lists.osuosl.org>;
 Tue,  6 Oct 2026 16:12:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1B1BB60624
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.13
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791303150;
 b=F8k1ywZ6c9c5owiLnBT4Esqi5RGwhDYvLmwv5II+bHxCpVQAkgtP3B0qMU0I8A1ss4V3
 /jD1PeEe/C9v/I6y9tyH24n1EbedmsgX3mtoanQLRfKlbkdVOHVrXialLkAFZI6M0IaBW
 U+VYgFpvyL5dEhMf+oV1HpPmoViErJB/rRUMNU1S9kze+pLu8sFlvgOZ4FQOsU1fmNLl+
 Jk5rl04n67ZEUw5TpwgeJc9lDfR7Rfw8qFiDwCa6jx4RAYg3dJDHbbrgezA2aOyDrR8X9
 LATVxv9CB6KrVPJF/w2BjHqiUSbG+2GuQ52i7LiecBXFJ/CIDtESAKLnc9KZ4+laUhA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791303150;
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
 x-ms-exchange-antispam-messagedata-0:Content-Type:MIME-Version:
 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-originalarrivaltime:
 X-MS-Exchange-CrossTenant-fromentityheader:
 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
 X-MS-Exchange-CrossTenant-userprincipalname:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 bh=9vzrzwGGkmKuxgqEkgQ8FfAatDDlpqz2u4wilvI1Nqw=;
 b=NaTNhSv9PMRUxN9vJoKWwVYuSfO8khUZqDa8LOKVJGcuWzxei3nNaJpFkwAZBnIar2+W
 2QXYawGq+KqlkKqXHT4alsYvJNgsaP+W4mgjIeDy25Bsn24PxugpKRyt7Y6/0dX5sg64w
 c/aDVY2UQ8lVz7HOH6IisMdvg/pLZ2L8gomV1uJL7g02HeZiO+zszL64/FMWY+T/RKnBP
 rMkUbJieyeRgHOn40BkFkPAjDjJcCexgSyHAUup3/ubp/jzxJKKcKYoe6f4ZRlVdocY0y
 CchB7ImHsc8lyfNb24MjB1vQhzQM4NaJd53N6znjwEqLIJz/FzY/3KTXrKNBLN1GEoQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b="cF/vwIQB"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.13
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.13;
 helo=mgamail.intel.com; envelope-from=dima.ruinskiy@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=cF/vwIQB
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1B1BB60624
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 16:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791303150; x=1822839150;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=9vzrzwGGkmKuxgqEkgQ8FfAatDDlpqz2u4wilvI1Nqw=;
 b=cF/vwIQBMgqOhPQoo/ReoPc7tnlx25MOx1QU5nYq89VtRrxowY/IEL6V
 jEaJiltvSrYibZfR/0cgnHhOCvrrT/1hCQjgoOLfbAcnF3vdpNQefSBTm
 XSjcAWG+IJPI/QW7TcYca0xE7par8JaNuDD5mOW4gvuqbz5s1j4KfakOX
 mzKtc6dgC8Ezthx0IKvIin8onKmbYOpNhAd3Ropst6c0Euz0Ctq3zvHxb
 mvKjFFZYS1WRGcDTB5Xu3aB4msNJY3I+Sl9XMDH71JAKvkmL7DBYzHpTM
 7x318GYQhuoCqNI7PjQgB3yoyrkZJFgDpA+pxU1h4JkMmRYtvgtQIKFD3 g==;
X-CSE-ConnectionGUID: z3mMWdsYSEyNKwbt43g7gA==
X-CSE-MsgGUID: Ww8PWkabSSe7kBUgk9BA8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="102160410"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
 d="scan'208,217";a="102160410"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 09:12:30 -0700
X-CSE-ConnectionGUID: L1GbT4qIS8Glf7ZAj5BW3g==
X-CSE-MsgGUID: z2Gihp3BSKS+UPhfaO7Lnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
 d="scan'208,217";a="285104461"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 09:12:29 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 09:12:28 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 6 Oct 2026 09:12:28 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.12) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 09:12:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dHpB96VUj2X3RgABE8jBo2ZwOrODjDeiASWcbzaDI3JYcGdIlKMdV9C3Y5VWDtE/9TWjB5/YL0JpDFplRz5pSE1jN0wAt3kdfylOGbB591BbdryDRusry0fsb2c5LnSgs6wYxssPfrjNfazSlc2+BXkoMdFPehXc/MRHnYFV6luiFwQwezxmi/z9ZXpTR1XihzXMGF7JT3bNNf+DNYRzYll+plyRGMvH5Ja2I/k6St/e8Rvo9oQ5x9fRSQUlaeljRxoQnyQ5oKCsXgeat6eGN3WXylRl0vFcW8PiWOBWz+8Ey2+nBnxASonueWDAXtc66gcz4pPtGBv7Qbu2QbTu8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9vzrzwGGkmKuxgqEkgQ8FfAatDDlpqz2u4wilvI1Nqw=;
 b=j3o5CEhNBKIcZM+lL2C/DWhrG6+kd7NGLOciHymM0WPlctyl29xPAtli7BkIvCFr59AbmYpZO4uM3iJ0GN59DeZos2rsd4VC6ysUnI54eNfPbEhlrmO66WKvBYU0KkB7UdL8oZWXh+El3nAPNpQl0ZYgTAgs92LOdzzrBX8Ri6zyb+TxlXhbY/uE+7gP+3ETwrqYpeuzmUe4iL3kJKZ5IhsvhLZ04h9bteVvX8WXwDu1J0ZLMlI4SRoQl4InXpFLPKJxuimypBIzHbrgOQUxCnnDBw54mvZS4XdCtF0haPDzyy9lcSIS6tNFUZZ6NBNDUPZDCxtILD7jKaVv85JPXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PR11MB872716.namprd11.prod.outlook.com (2603:10b6:8:509::16)
 by LV3PR11MB8695.namprd11.prod.outlook.com (2603:10b6:408:211::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Tue, 6 Oct
 2026 16:12:25 +0000
Received: from DS4PR11MB872716.namprd11.prod.outlook.com
 ([fe80::ae5f:9b62:3239:2e85]) by DS4PR11MB872716.namprd11.prod.outlook.com
 ([fe80::ae5f:9b62:3239:2e85%4]) with mapi id 15.21.0496.010; Tue, 6 Oct 2026
 16:12:25 +0000
From: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>
To: ghrafn <ghrafn@proton.me>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
CC: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 "vitaly.lifshits@intel.com" <vitaly.lifshits@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: RE: [REGRESSION] e1000e: heavy packet loss on Lenovo ThinkPad P14s
 Gen 5 (I219-LM, Meteor Lake) after K1 re-enable; fixed by disable-k1
Thread-Topic: [REGRESSION] e1000e: heavy packet loss on Lenovo ThinkPad P14s
 Gen 5 (I219-LM, Meteor Lake) after K1 re-enable; fixed by disable-k1
Thread-Index: AQHdVPq0E0GgDgjla0W7ZDNNoA0izrbwsJZA
Date: Tue, 6 Oct 2026 16:12:25 +0000
Message-ID: <DS4PR11MB87271623B483AE673BFAB281E0E8952@DS4PR11MB872716.namprd11.prod.outlook.com>
References: <_kB6DUeC6oOmJnK0FobVVJHADewewO3wzeFw_GrempgMu6s5CUwHpkT16Bwn8tXRq0k_CN4b2NY6API37M6mVciEpH6DKbTqK7f13KMpmgI=@proton.me>
In-Reply-To: <_kB6DUeC6oOmJnK0FobVVJHADewewO3wzeFw_GrempgMu6s5CUwHpkT16Bwn8tXRq0k_CN4b2NY6API37M6mVciEpH6DKbTqK7f13KMpmgI=@proton.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PR11MB872716:EE_|LV3PR11MB8695:EE_
x-ms-office365-filtering-correlation-id: c2b18881-3dff-4bc7-6b3c-08df23c49c34
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|10067099003|56012099006|11063799006|8096899003|6133799003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: UpbaHEFYg0XDffdyuF0+2sjqri+PJo/J2ANSVd/UZbQ4UHs/6CkMNdsvzHyHoz6XvhjSpMyP8T5rhFQiR6GARsHTU2Nmghx3BmvG+DqtL1uuMB4yOwJatk9yQBwQv5zmAoa5y1w0nYJsXNGskA4VAjSd+5/WrmF07v6h3U1baSVfMYfa87SCxEPVkZPMdQ6YhmqQnMTViQInibgoSF54fqmoc8EBnnHxdGxZHvFe8rYNbS0NI4TSyjkIjhn2Yz8vut4EIwneEXCLBD7UzAUdoUX2cMZYwf8Y2UBLQ/Ei3u8DgmEXDTqvAB1laUKIhrWzcJRx28FQ+4n60ZoGY4nVfGcjYHEN/RIhlsiWNaJ2YdQSK3EFUfROyChP/AYGz3NGvyXw5gMGit/ND2wfWHr4w+f2DpEPPjO2ESXJdwA1SlxQMa6RFxMjcjfZjIcyxd/iRocA9CSHjuqGWus3wcN0PrCSDKRiYWIUoHZbqowkR48DsivITRWE1t8BNmgOcvCNIgxg93cLvSZXl/dOnIblnIKciiIGSnAlSrbF4N1RKvS4TOcQDnjZ9ofe58idL2mFMo1nQZKW5S4KqH3F/EKmkXyp4RoZfnqkZENbP9ZOFAWl9BSDhDDJ/+csOHtWfb3pOzCPp08VKrcrZk19WjkiGUAvyK8CoZs5jf5znHC45Yg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PR11MB872716.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10067099003)(56012099006)(11063799006)(8096899003)(6133799003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UmlZL0MyMG1qMWw1czViSlN1UFo5S1Y3dWsyZFNsNDJodWUxNmprbW9lMGlt?=
 =?utf-8?B?MGxWaDA4YkhQUUtTY2F4MFlVOEVkM09ZMjNzTkFZT0N3WEdleURDRE1kTFV5?=
 =?utf-8?B?UGU2cktvRlZZbTlpb3JoVk92Y1d5R041dTM4d1FKajBrOU52UXhXQ1BEb2Jr?=
 =?utf-8?B?NmMxUmhkOE1LSUsvWDhxZHZIZHNmSEVRVWVKSTBmUjUvRWI1YkJ4eVFjbFJB?=
 =?utf-8?B?am44dzZCck1JNFA3QTdWZVJvRDhIdGF0RENldFkzYlUveTJaYSt4VVlmUnll?=
 =?utf-8?B?bTVabjBlQjRtQ0xLUlN2dERtMWNSN3ZBSGtsTmt3a2ppbnBZTkZ5NmtHcEw0?=
 =?utf-8?B?anFTNHF3N1ZiK0luRjJLejd0L1NFWXdvSjg5YkRKaWdnUkJJU2lzWThzUUt1?=
 =?utf-8?B?dHZPYlpSY0dQMjc5cnVnb0g2bzMxV2VpcmZaUFVzWHRXRlE4UkJFaFIwK21W?=
 =?utf-8?B?SDQyc1B6MUJWQlpuOHNyV2RYVVczdVdoMTNNSTg1M2c2Q1p4UmR3OEk1TkVH?=
 =?utf-8?B?Q2p6bWh0ZmhuV0xLY0tNQTZaQi8yc1BrdTRqUVg4dHM0UmJZbDNVUXpQUTM3?=
 =?utf-8?B?SkZ2RFE4SmRWZ083eTRQcnFBZ2Z1akd5bThpVmtWRURXY0l4cXJUWlRNREpG?=
 =?utf-8?B?cHdpaXcwVEdZYktMKzNlYXhTWjRRMUJqekFBcmV2MU15cS9KSVAraXZNRXQ2?=
 =?utf-8?B?S2JhNGI5R2VzWUM2VExKN3dIZ0lwZ0UrbzZkM3R1VVpLTU5MOWtRdmVUNDdW?=
 =?utf-8?B?S0VwWnFucFZjNms3RWRDVG1PVlhZWFhtVkUveENNRjQwdWlYSXYyb29pVUpG?=
 =?utf-8?B?amFvZ0dSbHhKU1UxSEhReDRUb1RtQUdoUTMwalJtTDRUK2pDYVFKOFhkQit2?=
 =?utf-8?B?WHd2d3ZEQ1luekh4dWhmU1Z0cXMydFBUVktMdFlWc3psWjFJRHIwdkM0YVpJ?=
 =?utf-8?B?Z1FWTWZwb24yRW5DanNVdm95Z3lIWExiMndKY2NBQ3U0bzBBd05vM1JKcEZC?=
 =?utf-8?B?cTAzR0R4a1RIZDdwcTM4WmxLczhFZmRZWk0veXF0TEVmMndhM3I5ZFNmWVBZ?=
 =?utf-8?B?dmU3dSt6VWxpS1hWVWJrQWswZVIwQUZwN3dBMFQwU0Rua0dqK3FpMnByVHFq?=
 =?utf-8?B?eWdvNkRQQk5rMUpNYUYrcGVKOXdrNGwwSHowQlcrM0M5ZklBeHYxTFUyVm9s?=
 =?utf-8?B?RFNHcktnOVNkSnNNV0FubUdxV1Y5NnFrMWtKMTAyY3dFcFV4T0l4aEZORExQ?=
 =?utf-8?B?WjRzZlJjMGlDYjdDaWthdDVIQTFNZFZyZ1labUpLWnY4cnI4ZlNPUlNYcjVz?=
 =?utf-8?B?RDRyRGVEK1U2NktqeWhmY1RaajBxVzRRMTg0Z3UwVFZoZFVJT29uZENRRkVN?=
 =?utf-8?B?NXA1SVgzZWFrRktBdG5MSGNpVzErRWdITVNtdm5mTm40ZE1zRklDU1RvSkMy?=
 =?utf-8?B?cTZVR0J0QzhrUlIzU29ydW9MdEdiL1oyTUoxSEhvbitkdzMyN2F2d2ZrL3JH?=
 =?utf-8?B?UnlUczMzM3FhSFJaNVpYRElTcnhVb2hwaXZObThEQkRqUUNCVmRQNnNSVTQ5?=
 =?utf-8?B?emRaZTNWamk5SGd4MzBmc0FyUi9oWW5Ud0wyUTJGd1ZJZXlBWkl6c1BDbExk?=
 =?utf-8?B?K2ZMSkU2R0wwbUF6TkNEWHVlYVlLejNRb3BsUjI3WU81RUNiUDdNV0NIVStI?=
 =?utf-8?B?NVh3eTJEck5RM2hKbEY0eG1MRXNMTkdXL3NVTHlHYklpQU5kY0RqRXg1dkFK?=
 =?utf-8?B?eXl6Ums3ZkM4Ty9GVlF3UjVqbDdZNlFQVDdBOGs3Z1l5ZjdMNHBOaC85YUd0?=
 =?utf-8?B?OXRVc3J5U0ZqYVRkb3VKZU9SQUwxYkd0dzd4ejFuU040WjU0TklGTlBmcXdr?=
 =?utf-8?B?cFJyK3pPQVVKVUpqUHpSeDJIc1hXdWRYSDRCZkdXNi9teGRTWk5wamJtQ1d0?=
 =?utf-8?B?YjF1VXQ0U0VLcmp5dGZtMm51VmR1aittdTJTUEJBN09IZzRKTGpaa3Z3WElH?=
 =?utf-8?B?TmJqNkJVOUFYZmFtT3FHNDVsOHhDbHNRMjhpRjRtTVVZOUlINzM5QVpaN0o0?=
 =?utf-8?B?SkZGbmtnWStlSFBtNE9RT1lWMkR6UVNDd0s0MXNVWWIyN1pacEN6RmxYRC96?=
 =?utf-8?B?Mmx6MTltdFV4b1RPYWdNNXFWZlQ2Y0V5N29qSlZVRFNCODRzZTBCaDFxV0dZ?=
 =?utf-8?B?TW5xdUMvdU52KzFQTmJMdmduRWlqaG9uOXAvWFhpYmVtSVN2SG12ejVoaVlV?=
 =?utf-8?B?T3pkams2K2xLQllOUk56R1o0cWRoUlJneFI0Mk1UaWhScldTNXQyVmFReUkr?=
 =?utf-8?B?UTFEUmx4dmFVd2R6ZXdIZGlubisyVi81UG5VeFhUek1KNml1ZXVCZz09?=
Content-Type: multipart/alternative;
 boundary="_000_DS4PR11MB87271623B483AE673BFAB281E0E8952DS4PR11MB872716_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: N/jhBln5aXFczye1ixu7kZaAcbyssgBu2PJ1r6i4+IoRcZDxm+yfgCAAfqHDsFw8yWJchIwq8FFlY6xZQ2Ps5xTAVw3M3akQxwIl5R6q3u6ZjRS2u8BCaIizmMkebzpOs1/PEQD+R5RI0AvV5ZR19qQcRo2RyCt20+kZb6S5/9BFX4yom6Pyl47KtvwwyjeyJHV+LqiU1PHQ/ES57IAx0iJSUYXVzkhfPKXh1MfpFnvMc9Qfe1Eg5doHAFCLgZa6uYqDYthOMf2ejr/LFN9+An7N73KShX+or5kLKTM01tumkzkRJsctKPabDSnxdQVkrWhqFDk4ULCM2Ha6jR5AFw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PR11MB872716.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2b18881-3dff-4bc7-6b3c-08df23c49c34
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2026 16:12:25.0573 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gUBOUbqfbIVmJoUhq23iQR184p4vLUtWIaOvbc47qdiD4lClk3Ly1/esTq/Y5NpxF48HqkJ4xpcMyxKUEvki8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8695
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

--_000_DS4PR11MB87271623B483AE673BFAB281E0E8952DS4PR11MB872716_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

V2Ugbm93IGhhdmUgdGhlIGFiaWxpdHkgdG8gc2VsZWN0aXZlbHkgYWx0ZXIgdGhlIGRlZmF1bHQg
SzEgdmFsdWUgb24gYSBzeXN0ZW0tYnktc3lzdGVtIGJhc2lzLiBJIHdpbGwgc2VuZCBhIGZvbGxv
dy11cCBwYXRjaC4NCg0KRnJvbTogZ2hyYWZuIDxnaHJhZm5AcHJvdG9uLm1lPg0KU2VudDogTW9u
ZGF5LCA1IE9jdG9iZXIgMjAyNiAyMTo1Mg0KVG86IE5ndXllbiwgQW50aG9ueSBMIDxhbnRob255
Lmwubmd1eWVuQGludGVsLmNvbT4NCkNjOiBSdWluc2tpeSwgRGltYSA8ZGltYS5ydWluc2tpeUBp
bnRlbC5jb20+OyBLaXRzemVsLCBQcnplbXlzbGF3IDxwcnplbXlzbGF3LmtpdHN6ZWxAaW50ZWwu
Y29tPjsgdml0YWx5LmxpZnNoaXRzQGludGVsLmNvbTsgaW50ZWwtd2lyZWQtbGFuQGxpc3RzLm9z
dW9zbC5vcmc7IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IHJlZ3Jlc3Npb25zQGxpc3RzLmxpbnV4
LmRldg0KU3ViamVjdDogUmU6IFtSRUdSRVNTSU9OXSBlMTAwMGU6IGhlYXZ5IHBhY2tldCBsb3Nz
IG9uIExlbm92byBUaGlua1BhZCBQMTRzIEdlbiA1IChJMjE5LUxNLCBNZXRlb3IgTGFrZSkgYWZ0
ZXIgSzEgcmUtZW5hYmxlOyBmaXhlZCBieSBkaXNhYmxlLWsxDQoNCg0KKEZvbGxvd2luZyB1cCBv
biB0aGlzIHJlZ3Jlc3Npb24gcmVwb3J0OiBodHRwczovL2xpc3RzLm9wZW53YWxsLm5ldC9uZXRk
ZXYvMjAyNi8wOS8xNS8yNTM8aHR0cHM6Ly9saXN0cy5vcGVud2FsbC5uZXQvbmV0ZGV2LzIwMjYv
MDkvMTUvMjUzP3V0bV9zb3VyY2U9Y2hhdGdwdC5jb20+KQ0KDQpIaSwNCg0KSSBhcHBlYXIgdG8g
YmUgc2VlaW5nIHRoZSBzYW1lIGlzc3VlIG9uIGEgTGVub3ZvIFRoaW5rUGFkIFQxNCBHZW4gNiwg
d2l0aCBhbiBJbnRlbCBFdGhlcm5ldCBDb25uZWN0aW9uICgyNCkgSTIxOS1MTSBbODA4Njo1N2Ew
XS4NCg0KV2l0aCB0aGUgZGVmYXVsdCBlMTAwMGUgY29uZmlndXJhdGlvbiAoZGlzYWJsZS1rMTog
b2ZmKSwgd2lyZWQgRXRoZXJuZXQgZXhwZXJpZW5jZXMgc2V2ZXJlIHBhY2tldCBsb3NzIGV2ZW4g
dG8gdGhlIGxvY2FsIGdhdGV3YXkuIFRoZSBpbnRlcmZhY2Ugc3RpbGwgbmVnb3RpYXRlcyBub3Jt
YWxseSBhdCAxMDAwIE1iL3MsIGZ1bGwgZHVwbGV4LCBhbmQgdGhlIGUxMDAwZSBzdGF0aXN0aWNz
IGRvIG5vdCByZXBvcnQgQ1JDLCBmcmFtZSwgRE1BLCBvciBvdGhlciBSWCBlcnJvcnMuDQoNCkZv
ciBleGFtcGxlOg0KDQokIHBpbmcgLWMgMTAgMTkyLjE2OC4wLjENCg0KMTAgcGFja2V0cyB0cmFu
c21pdHRlZCwgMyByZWNlaXZlZCwgNzAlIHBhY2tldCBsb3NzDQoNCkFSUCB0cmFmZmljIGlzIGFm
ZmVjdGVkIGFzIHdlbGw6DQoNCiQgc3VkbyBhcnBpbmcgLUkgZW5wMHMzMWY2IC1jIDIwIDE5Mi4x
NjguMC4xDQoNCjIwIHBhY2tldHMgdHJhbnNtaXR0ZWQsIDExIHBhY2tldHMgcmVjZWl2ZWQsIDQ1
JSB1bmFuc3dlcmVkDQoNCkEgdGNwZHVtcCBvbiBlbnAwczMxZjYgc2hvd2VkIHRoZSBvdXRnb2lu
ZyBJQ01QIGVjaG8gcmVxdWVzdHMsIGJ1dCByZXBsaWVzIHdlcmUgYWJzZW50IGZvciB0aGUgbG9z
dCBwYWNrZXRzLg0KDQpUaGUgTklDIGlkZW50aWZpZXMgYXM6DQoNCkludGVsIENvcnBvcmF0aW9u
IEV0aGVybmV0IENvbm5lY3Rpb24gKDI0KSBJMjE5LUxNIFs4MDg2OjU3YTBdDQoNCmFuZCB1c2Vz
IGUxMDAwZS4NCg0KU2V0dGluZyB0aGUgZXhpc3RpbmcgcHJpdmF0ZSBmbGFnOg0KDQojIGV0aHRv
b2wgLS1zZXQtcHJpdi1mbGFncyBlbnAwczMxZjYgZGlzYWJsZS1rMSBvbg0KDQppbW1lZGlhdGVs
eSBlbGltaW5hdGVzIHRoZSBwcm9ibGVtLg0KDQpBZnRlciBzZXR0aW5nIGRpc2FibGUtazE6DQoN
CiQgcGluZyAtYyAzMCAxOTIuMTY4LjAuMQ0KDQozMCBwYWNrZXRzIHRyYW5zbWl0dGVkLCAzMCBy
ZWNlaXZlZCwgMCUgcGFja2V0IGxvc3MNCg0KcnR0IG1pbi9hdmcvbWF4L21kZXYgPSAwLjM4NC8w
LjUzOC8wLjg4NS8wLjA5OCBtcw0KDQphbmQ6DQoNCiQgc3VkbyBhcnBpbmcgLUkgZW5wMHMzMWY2
IC1jIDIwIDE5Mi4xNjguMC4xDQoNCjIwIHBhY2tldHMgdHJhbnNtaXR0ZWQsIDIwIHBhY2tldHMg
cmVjZWl2ZWQsIDAlIHVuYW5zd2VyZWQNCg0KVGhlIHJlc3VsdCBpcyByZXBlYXRhYmxlIHdpdGhp
biB0aGUgc2FtZSBzZXNzaW9uOiB0aGUgc2V2ZXJlIGxvY2FsIHBhY2tldCBsb3NzIGRpc2FwcGVh
cmVkIGltbWVkaWF0ZWx5IGFmdGVyIGRpc2FibGluZyBLMS4NCg0KU3lzdGVtIGluZm9ybWF0aW9u
Og0KDQpMYXB0b3A6ICAgICAgICAgICAgICBMZW5vdm8gVGhpbmtQYWQgVDE0IEdlbiA2DQoNCkRN
SSBzeXNfdmVuZG9yOiAgICAgIExFTk9WTw0KDQpETUkgcHJvZHVjdF9uYW1lOiAgICAyMVFDUzAx
NjAwDQoNCkRNSSBwcm9kdWN0X3ZlcnNpb246IFRoaW5rUGFkIFQxNCBHZW4gNg0KDQpETUkgYm9h
cmRfbmFtZTogICAgICAyMVFDUzAxNjAwDQoNCkJJT1M6ICAgICAgICAgICAgICAgIE40SkVUMjhX
ICgxLjE4ICkgKGRhdGU6IDA2LzE2LzIwMjYpDQoNCkNQVTogICAgICAgICAgICAgICAgIEludGVs
KFIpIENvcmUoVE0pIFVsdHJhIDUgMjM1VQ0KDQpLZXJuZWw6ICAgICAgICAgICAgICBMaW51eCA3
LjAuMC0zOC1nZW5lcmljDQoNCk5JQzogICAgICAgICAgICAgICAgIDAwOjFmLjYgSW50ZWwgRXRo
ZXJuZXQgQ29ubmVjdGlvbiAoMjQpIEkyMTktTE0gWzgwODY6NTdhMF0NCg0KZTEwMDBlIGZpcm13
YXJlOiAgICAgMC4xLTQNCg0KTGluazogICAgICAgICAgICAgICAgMTAwMCBNYi9zIEZ1bGwgRHVw
bGV4DQpPUzogICAgICAgICAgICAgICAgICBVYnVudHUgMjYuMDQuMSBMVFMNCg0KSSBhbSBjdXJy
ZW50bHkgd29ya2luZyBhcm91bmQgdGhlIGlzc3VlIGJ5IHNldHRpbmcgZGlzYWJsZS1rMSBvbi4N
Cg0KVGhpcyBsb29rcyBzdWZmaWNpZW50bHkgc2ltaWxhciB0byB0aGUgcmVwb3J0ZWQgUDE0cyBH
ZW4gNSBpc3N1ZSB0aGF0IEkgd2FudGVkIHRvIHJlcG9ydCB0aGUgYWRkaXRpb25hbCBhZmZlY3Rl
ZCBwbGF0Zm9ybSBpbiBjYXNlIHRoZSBUMTQgR2VuIDYgYWxzbyBuZWVkcyB0byBiZSBhZGRlZCB0
byBkaXNhYmxlX2sxX2xpc3QuDQoNCkknbSBoYXBweSB0byB0ZXN0IGEgcGF0Y2ggb3IgcHJvdmlk
ZSBhZGRpdGlvbmFsIGRpYWdub3N0aWNzIGlmIHVzZWZ1bC4NCg0KVGhhbmtzLA0KR8Otc2xpDQo=

--_000_DS4PR11MB87271623B483AE673BFAB281E0E8952DS4PR11MB872716_
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: base64

PGh0bWwgeG1sbnM6dj0idXJuOnNjaGVtYXMtbWljcm9zb2Z0LWNvbTp2bWwiIHhtbG5zOm89InVy
bjpzY2hlbWFzLW1pY3Jvc29mdC1jb206b2ZmaWNlOm9mZmljZSIgeG1sbnM6dz0idXJuOnNjaGVt
YXMtbWljcm9zb2Z0LWNvbTpvZmZpY2U6d29yZCIgeG1sbnM6bT0iaHR0cDovL3NjaGVtYXMubWlj
cm9zb2Z0LmNvbS9vZmZpY2UvMjAwNC8xMi9vbW1sIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcv
VFIvUkVDLWh0bWw0MCI+DQo8aGVhZD4NCjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIg
Y29udGVudD0idGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4NCjxtZXRhIG5hbWU9IkdlbmVyYXRv
ciIgY29udGVudD0iTWljcm9zb2Z0IFdvcmQgMTUgKGZpbHRlcmVkIG1lZGl1bSkiPg0KPHN0eWxl
PjwhLS0NCi8qIEZvbnQgRGVmaW5pdGlvbnMgKi8NCkBmb250LWZhY2UNCgl7Zm9udC1mYW1pbHk6
IkNhbWJyaWEgTWF0aCI7DQoJcGFub3NlLTE6MiA0IDUgMyA1IDQgNiAzIDIgNDt9DQpAZm9udC1m
YWNlDQoJe2ZvbnQtZmFtaWx5OkNhbGlicmk7DQoJcGFub3NlLTE6MiAxNSA1IDIgMiAyIDQgMyAy
IDQ7fQ0KQGZvbnQtZmFjZQ0KCXtmb250LWZhbWlseTpBcHRvczt9DQpAZm9udC1mYWNlDQoJe2Zv
bnQtZmFtaWx5OkNvbnNvbGFzOw0KCXBhbm9zZS0xOjIgMTEgNiA5IDIgMiA0IDMgMiA0O30NCi8q
IFN0eWxlIERlZmluaXRpb25zICovDQpwLk1zb05vcm1hbCwgbGkuTXNvTm9ybWFsLCBkaXYuTXNv
Tm9ybWFsDQoJe21hcmdpbjowY207DQoJZm9udC1zaXplOjEyLjBwdDsNCglmb250LWZhbWlseToi
QXB0b3MiLHNhbnMtc2VyaWY7fQ0KYTpsaW5rLCBzcGFuLk1zb0h5cGVybGluaw0KCXttc28tc3R5
bGUtcHJpb3JpdHk6OTk7DQoJY29sb3I6Ymx1ZTsNCgl0ZXh0LWRlY29yYXRpb246dW5kZXJsaW5l
O30NCmNvZGUNCgl7bXNvLXN0eWxlLXByaW9yaXR5Ojk5Ow0KCWZvbnQtZmFtaWx5OiJDb3VyaWVy
IE5ldyI7fQ0KcHJlDQoJe21zby1zdHlsZS1wcmlvcml0eTo5OTsNCgltc28tc3R5bGUtbGluazoi
SFRNTCBQcmVmb3JtYXR0ZWQgQ2hhciI7DQoJbWFyZ2luOjBjbTsNCglmb250LXNpemU6MTAuMHB0
Ow0KCWZvbnQtZmFtaWx5OiJDb3VyaWVyIE5ldyI7fQ0Kc3Bhbi5IVE1MUHJlZm9ybWF0dGVkQ2hh
cg0KCXttc28tc3R5bGUtbmFtZToiSFRNTCBQcmVmb3JtYXR0ZWQgQ2hhciI7DQoJbXNvLXN0eWxl
LXByaW9yaXR5Ojk5Ow0KCW1zby1zdHlsZS1saW5rOiJIVE1MIFByZWZvcm1hdHRlZCI7DQoJZm9u
dC1mYW1pbHk6Q29uc29sYXM7DQoJbXNvLWxpZ2F0dXJlczpub25lOw0KCW1zby1mYXJlYXN0LWxh
bmd1YWdlOiMwQzAwO30NCnNwYW4uRW1haWxTdHlsZTIyDQoJe21zby1zdHlsZS10eXBlOnBlcnNv
bmFsLXJlcGx5Ow0KCWZvbnQtZmFtaWx5OiJBcHRvcyIsc2Fucy1zZXJpZjsNCgljb2xvcjp3aW5k
b3d0ZXh0O30NCi5Nc29DaHBEZWZhdWx0DQoJe21zby1zdHlsZS10eXBlOmV4cG9ydC1vbmx5Ow0K
CW1zby1mYXJlYXN0LWxhbmd1YWdlOkVOLVVTO30NCkBwYWdlIFdvcmRTZWN0aW9uMQ0KCXtzaXpl
OjYxMi4wcHQgNzkyLjBwdDsNCgltYXJnaW46NzIuMHB0IDcyLjBwdCA3Mi4wcHQgNzIuMHB0O30N
CmRpdi5Xb3JkU2VjdGlvbjENCgl7cGFnZTpXb3JkU2VjdGlvbjE7fQ0KLS0+PC9zdHlsZT48IS0t
W2lmIGd0ZSBtc28gOV0+PHhtbD4NCjxvOnNoYXBlZGVmYXVsdHMgdjpleHQ9ImVkaXQiIHNwaWRt
YXg9IjEwMjYiIC8+DQo8L3htbD48IVtlbmRpZl0tLT48IS0tW2lmIGd0ZSBtc28gOV0+PHhtbD4N
CjxvOnNoYXBlbGF5b3V0IHY6ZXh0PSJlZGl0Ij4NCjxvOmlkbWFwIHY6ZXh0PSJlZGl0IiBkYXRh
PSIxIiAvPg0KPC9vOnNoYXBlbGF5b3V0PjwveG1sPjwhW2VuZGlmXS0tPg0KPC9oZWFkPg0KPGJv
ZHkgbGFuZz0iZW4tSUwiIGxpbms9ImJsdWUiIHZsaW5rPSJwdXJwbGUiIHN0eWxlPSJ3b3JkLXdy
YXA6YnJlYWstd29yZCI+DQo8ZGl2IGNsYXNzPSJXb3JkU2VjdGlvbjEiPg0KPHAgY2xhc3M9Ik1z
b05vcm1hbCI+PHNwYW4gbGFuZz0iRU4tVVMiIHN0eWxlPSJtc28tZmFyZWFzdC1sYW5ndWFnZTpF
Ti1VUyI+V2Ugbm93IGhhdmUgdGhlIGFiaWxpdHkgdG8gc2VsZWN0aXZlbHkgYWx0ZXIgdGhlIGRl
ZmF1bHQgSzEgdmFsdWUgb24gYSBzeXN0ZW0tYnktc3lzdGVtIGJhc2lzLiBJIHdpbGwgc2VuZCBh
IGZvbGxvdy11cCBwYXRjaC48bzpwPjwvbzpwPjwvc3Bhbj48L3A+DQo8cCBjbGFzcz0iTXNvTm9y
bWFsIj48c3BhbiBzdHlsZT0ibXNvLWZhcmVhc3QtbGFuZ3VhZ2U6RU4tVVMiPjxvOnA+Jm5ic3A7
PC9vOnA+PC9zcGFuPjwvcD4NCjxkaXYgc3R5bGU9ImJvcmRlcjpub25lO2JvcmRlci10b3A6c29s
aWQgI0UxRTFFMSAxLjBwdDtwYWRkaW5nOjMuMHB0IDBjbSAwY20gMGNtIj4NCjxwIGNsYXNzPSJN
c29Ob3JtYWwiPjxiPjxzcGFuIGxhbmc9IkVOLVVTIiBzdHlsZT0iZm9udC1zaXplOjExLjBwdDtm
b250LWZhbWlseTomcXVvdDtDYWxpYnJpJnF1b3Q7LHNhbnMtc2VyaWYiPkZyb206PC9zcGFuPjwv
Yj48c3BhbiBsYW5nPSJFTi1VUyIgc3R5bGU9ImZvbnQtc2l6ZToxMS4wcHQ7Zm9udC1mYW1pbHk6
JnF1b3Q7Q2FsaWJyaSZxdW90OyxzYW5zLXNlcmlmIj4gZ2hyYWZuICZsdDtnaHJhZm5AcHJvdG9u
Lm1lJmd0Ow0KPGJyPg0KPGI+U2VudDo8L2I+IE1vbmRheSwgNSBPY3RvYmVyIDIwMjYgMjE6NTI8
YnI+DQo8Yj5Ubzo8L2I+IE5ndXllbiwgQW50aG9ueSBMICZsdDthbnRob255Lmwubmd1eWVuQGlu
dGVsLmNvbSZndDs8YnI+DQo8Yj5DYzo8L2I+IFJ1aW5za2l5LCBEaW1hICZsdDtkaW1hLnJ1aW5z
a2l5QGludGVsLmNvbSZndDs7IEtpdHN6ZWwsIFByemVteXNsYXcgJmx0O3ByemVteXNsYXcua2l0
c3plbEBpbnRlbC5jb20mZ3Q7OyB2aXRhbHkubGlmc2hpdHNAaW50ZWwuY29tOyBpbnRlbC13aXJl
ZC1sYW5AbGlzdHMub3N1b3NsLm9yZzsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgcmVncmVzc2lv
bnNAbGlzdHMubGludXguZGV2PGJyPg0KPGI+U3ViamVjdDo8L2I+IFJlOiBbUkVHUkVTU0lPTl0g
ZTEwMDBlOiBoZWF2eSBwYWNrZXQgbG9zcyBvbiBMZW5vdm8gVGhpbmtQYWQgUDE0cyBHZW4gNSAo
STIxOS1MTSwgTWV0ZW9yIExha2UpIGFmdGVyIEsxIHJlLWVuYWJsZTsgZml4ZWQgYnkgZGlzYWJs
ZS1rMTxvOnA+PC9vOnA+PC9zcGFuPjwvcD4NCjwvZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+
PG86cD4mbmJzcDs8L286cD48L3A+DQo8cCBzdHlsZT0iYmFja2dyb3VuZDp3aGl0ZSI+PHNwYW4g
c3R5bGU9ImZvbnQtc2l6ZToxMC41cHQ7Zm9udC1mYW1pbHk6JnF1b3Q7QXJpYWwmcXVvdDssc2Fu
cy1zZXJpZjtjb2xvcjpibGFjayI+KEZvbGxvd2luZyB1cCBvbiB0aGlzIHJlZ3Jlc3Npb24gcmVw
b3J0Og0KPGEgaHJlZj0iaHR0cHM6Ly9saXN0cy5vcGVud2FsbC5uZXQvbmV0ZGV2LzIwMjYvMDkv
MTUvMjUzP3V0bV9zb3VyY2U9Y2hhdGdwdC5jb20iPg0KaHR0cHM6Ly9saXN0cy5vcGVud2FsbC5u
ZXQvbmV0ZGV2LzIwMjYvMDkvMTUvMjUzPC9hPik8bzpwPjwvbzpwPjwvc3Bhbj48L3A+DQo8cD48
c3BhbiBzdHlsZT0iZm9udC1mYW1pbHk6JnF1b3Q7QXJpYWwmcXVvdDssc2Fucy1zZXJpZiI+SGks
PC9zcGFuPjxvOnA+PC9vOnA+PC9wPg0KPHA+PHNwYW4gc3R5bGU9ImZvbnQtZmFtaWx5OiZxdW90
O0FyaWFsJnF1b3Q7LHNhbnMtc2VyaWYiPkkgYXBwZWFyIHRvIGJlIHNlZWluZyB0aGUgc2FtZSBp
c3N1ZSBvbiBhIExlbm92byBUaGlua1BhZCBUMTQgR2VuIDYsIHdpdGggYW4gSW50ZWwgRXRoZXJu
ZXQgQ29ubmVjdGlvbiAoMjQpIEkyMTktTE0gWzgwODY6NTdhMF0uPC9zcGFuPjxvOnA+PC9vOnA+
PC9wPg0KPHA+V2l0aCB0aGUgZGVmYXVsdCBlMTAwMGUgY29uZmlndXJhdGlvbiAoPGNvZGU+PHNw
YW4gc3R5bGU9ImZvbnQtc2l6ZToxMC4wcHQiPmRpc2FibGUtazE6IG9mZjwvc3Bhbj48L2NvZGU+
KSwgd2lyZWQgRXRoZXJuZXQgZXhwZXJpZW5jZXMgc2V2ZXJlIHBhY2tldCBsb3NzIGV2ZW4gdG8g
dGhlIGxvY2FsIGdhdGV3YXkuIFRoZSBpbnRlcmZhY2Ugc3RpbGwgbmVnb3RpYXRlcyBub3JtYWxs
eSBhdCAxMDAwIE1iL3MsIGZ1bGwgZHVwbGV4LCBhbmQgdGhlDQogZTEwMDBlIHN0YXRpc3RpY3Mg
ZG8gbm90IHJlcG9ydCBDUkMsIGZyYW1lLCBETUEsIG9yIG90aGVyIFJYIGVycm9ycy48bzpwPjwv
bzpwPjwvcD4NCjxwPkZvciBleGFtcGxlOjxvOnA+PC9vOnA+PC9wPg0KPHByZT48Y29kZT4kIHBp
bmcgLWMgMTAgMTkyLjE2OC4wLjE8bzpwPjwvbzpwPjwvY29kZT48L3ByZT4NCjxwcmU+PGNvZGU+
MTAgcGFja2V0cyB0cmFuc21pdHRlZCwgMyByZWNlaXZlZCwgNzAlIHBhY2tldCBsb3NzPC9jb2Rl
PjxvOnA+PC9vOnA+PC9wcmU+DQo8cD5BUlAgdHJhZmZpYyBpcyBhZmZlY3RlZCBhcyB3ZWxsOjxv
OnA+PC9vOnA+PC9wPg0KPHByZT48Y29kZT4kIHN1ZG8gYXJwaW5nIC1JIGVucDBzMzFmNiAtYyAy
MCAxOTIuMTY4LjAuMTxvOnA+PC9vOnA+PC9jb2RlPjwvcHJlPg0KPHByZT48Y29kZT4yMCBwYWNr
ZXRzIHRyYW5zbWl0dGVkLCAxMSBwYWNrZXRzIHJlY2VpdmVkLCA0NSUgdW5hbnN3ZXJlZDwvY29k
ZT48bzpwPjwvbzpwPjwvcHJlPg0KPHA+QSA8c3BhbiBzdHlsZT0iZm9udC1mYW1pbHk6Q29uc29s
YXMiPnRjcGR1bXA8L3NwYW4+IG9uIGVucDBzMzFmNiBzaG93ZWQgdGhlIG91dGdvaW5nIElDTVAg
ZWNobyByZXF1ZXN0cywgYnV0IHJlcGxpZXMgd2VyZSBhYnNlbnQgZm9yIHRoZSBsb3N0IHBhY2tl
dHMuPG86cD48L286cD48L3A+DQo8cD5UaGUgTklDIGlkZW50aWZpZXMgYXM6PG86cD48L286cD48
L3A+DQo8cHJlPjxjb2RlPkludGVsIENvcnBvcmF0aW9uIEV0aGVybmV0IENvbm5lY3Rpb24gKDI0
KSBJMjE5LUxNIFs4MDg2OjU3YTBdPC9jb2RlPjxvOnA+PC9vOnA+PC9wcmU+DQo8cD5hbmQgdXNl
cyBlMTAwMGUuPG86cD48L286cD48L3A+DQo8cD5TZXR0aW5nIHRoZSBleGlzdGluZyBwcml2YXRl
IGZsYWc6PG86cD48L286cD48L3A+DQo8cHJlPjxjb2RlPiMgZXRodG9vbCAtLXNldC1wcml2LWZs
YWdzIGVucDBzMzFmNiBkaXNhYmxlLWsxIG9uPC9jb2RlPjxvOnA+PC9vOnA+PC9wcmU+DQo8cD5p
bW1lZGlhdGVseSBlbGltaW5hdGVzIHRoZSBwcm9ibGVtLjxvOnA+PC9vOnA+PC9wPg0KPHA+QWZ0
ZXIgc2V0dGluZyBkaXNhYmxlLWsxOjxvOnA+PC9vOnA+PC9wPg0KPHByZT48Y29kZT4kIHBpbmcg
LWMgMzAgMTkyLjE2OC4wLjE8bzpwPjwvbzpwPjwvY29kZT48L3ByZT4NCjxwcmU+PGNvZGU+MzAg
cGFja2V0cyB0cmFuc21pdHRlZCwgMzAgcmVjZWl2ZWQsIDAlIHBhY2tldCBsb3NzPG86cD48L286
cD48L2NvZGU+PC9wcmU+DQo8cHJlPjxjb2RlPnJ0dCBtaW4vYXZnL21heC9tZGV2ID0gMC4zODQv
MC41MzgvMC44ODUvMC4wOTggbXM8L2NvZGU+PG86cD48L286cD48L3ByZT4NCjxwPmFuZDo8bzpw
PjwvbzpwPjwvcD4NCjxwcmU+PGNvZGU+JCBzdWRvIGFycGluZyAtSSBlbnAwczMxZjYgLWMgMjAg
MTkyLjE2OC4wLjE8bzpwPjwvbzpwPjwvY29kZT48L3ByZT4NCjxwcmU+PGNvZGU+MjAgcGFja2V0
cyB0cmFuc21pdHRlZCwgMjAgcGFja2V0cyByZWNlaXZlZCwgMCUgdW5hbnN3ZXJlZDwvY29kZT48
bzpwPjwvbzpwPjwvcHJlPg0KPHA+VGhlIHJlc3VsdCBpcyByZXBlYXRhYmxlIHdpdGhpbiB0aGUg
c2FtZSBzZXNzaW9uOiB0aGUgc2V2ZXJlIGxvY2FsIHBhY2tldCBsb3NzIGRpc2FwcGVhcmVkIGlt
bWVkaWF0ZWx5IGFmdGVyIGRpc2FibGluZyBLMS48bzpwPjwvbzpwPjwvcD4NCjxwPlN5c3RlbSBp
bmZvcm1hdGlvbjo8bzpwPjwvbzpwPjwvcD4NCjxwcmU+PGNvZGU+PGI+TGFwdG9wOjwvYj4gJm5i
c3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBMZW5vdm8g
VGhpbmtQYWQgVDE0IEdlbiA2PG86cD48L286cD48L2NvZGU+PC9wcmU+DQo8cHJlPjxjb2RlPjxi
PkRNSSBzeXNfdmVuZG9yOjwvYj4gJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IExFTk9WTzxvOnA+
PC9vOnA+PC9jb2RlPjwvcHJlPg0KPHByZT48Y29kZT48Yj5ETUkgcHJvZHVjdF9uYW1lOjwvYj4m
bmJzcDsmbmJzcDsmbmJzcDsgMjFRQ1MwMTYwMDxvOnA+PC9vOnA+PC9jb2RlPjwvcHJlPg0KPHBy
ZT48Y29kZT48Yj5ETUkgcHJvZHVjdF92ZXJzaW9uOjwvYj4gVGhpbmtQYWQgVDE0IEdlbiA2PG86
cD48L286cD48L2NvZGU+PC9wcmU+DQo8cHJlPjxjb2RlPjxiPkRNSSBib2FyZF9uYW1lOjwvYj4g
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IDIxUUNTMDE2MDA8bzpwPjwvbzpwPjwvY29kZT48L3By
ZT4NCjxwcmU+PGNvZGU+PGI+QklPUzo8L2I+ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAm
bmJzcDsgJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IE40SkVUMjhXICgxLjE4ICkgKGRhdGU6IDA2
LzE2LzIwMjYpPG86cD48L286cD48L2NvZGU+PC9wcmU+DQo8cHJlPjxjb2RlPjxiPkNQVTo8L2I+
ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7IEludGVsKFIpIENvcmUoVE0pIFVsdHJhIDUgMjM1VTxvOnA+PC9vOnA+PC9jb2Rl
PjwvcHJlPg0KPHByZT48Y29kZT48Yj5LZXJuZWw6PC9iPiAmbmJzcDsgJm5ic3A7ICZuYnNwOyAm
bmJzcDsgJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IExpbnV4IDcuMC4wLTM4LWdlbmVyaWM8bzpw
PjwvbzpwPjwvY29kZT48L3ByZT4NCjxwcmU+PGNvZGU+PGI+TklDOjwvYj4gJm5ic3A7ICZuYnNw
OyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgMDA6
MWYuNiBJbnRlbCBFdGhlcm5ldCBDb25uZWN0aW9uICgyNCkgSTIxOS1MTSBbODA4Njo1N2EwXTxv
OnA+PC9vOnA+PC9jb2RlPjwvcHJlPg0KPHByZT48Y29kZT48Yj5lMTAwMGUgZmlybXdhcmU6PC9i
PiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAwLjEtNDxvOnA+PC9vOnA+PC9jb2RlPjwvcHJlPg0K
PHByZT48Y29kZT48Yj5MaW5rOjwvYj4gJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNw
OyAmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgMTAwMCBNYi9zIEZ1bGwgRHVwbGV4PC9jb2RlPjxi
cj48Y29kZT48Yj5PUzo8L2I+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7IFVidW50dSAyNi4wNC4xIExUUyA8L2NvZGU+PG86cD48L286cD48L3ByZT4NCjxwPkkg
YW0gY3VycmVudGx5IHdvcmtpbmcgYXJvdW5kIHRoZSBpc3N1ZSBieSBzZXR0aW5nIDxjb2RlPjxz
cGFuIHN0eWxlPSJmb250LXNpemU6MTAuMHB0Ij5kaXNhYmxlLWsxPC9zcGFuPjwvY29kZT4gb24u
PG86cD48L286cD48L3A+DQo8cD5UaGlzIGxvb2tzIHN1ZmZpY2llbnRseSBzaW1pbGFyIHRvIHRo
ZSByZXBvcnRlZCBQMTRzIEdlbiA1IGlzc3VlIHRoYXQgSSB3YW50ZWQgdG8gcmVwb3J0IHRoZSBh
ZGRpdGlvbmFsIGFmZmVjdGVkIHBsYXRmb3JtIGluIGNhc2UgdGhlIFQxNCBHZW4gNiBhbHNvIG5l
ZWRzIHRvIGJlIGFkZGVkIHRvDQo8Y29kZT48c3BhbiBzdHlsZT0iZm9udC1zaXplOjEwLjBwdCI+
ZGlzYWJsZV9rMV9saXN0PC9zcGFuPjwvY29kZT4uPG86cD48L286cD48L3A+DQo8cD5JJ20gaGFw
cHkgdG8gdGVzdCBhIHBhdGNoIG9yIHByb3ZpZGUgYWRkaXRpb25hbCBkaWFnbm9zdGljcyBpZiB1
c2VmdWwuPG86cD48L286cD48L3A+DQo8cD5UaGFua3MsPGJyPg0KR8Otc2xpPG86cD48L286cD48
L3A+DQo8L2Rpdj4NCjwvYm9keT4NCjwvaHRtbD4NCg==

--_000_DS4PR11MB87271623B483AE673BFAB281E0E8952DS4PR11MB872716_--
