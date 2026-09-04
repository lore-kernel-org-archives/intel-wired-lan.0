Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A120C624DE
	for <intel-wired-lan@archiver.kernel.org>; Fri,  4 Sep 2026 07:01:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 49AEC81115;
	Fri,  4 Sep 2026 07:01:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oOo5YqbjRqUP; Fri,  4 Sep 2026 07:01:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 69AFE81119
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788505262;
	b=lUc0gXJPEeJcJqy5KZxHoaPB704kolTvJWi5EWjaZjVHIgr5cVMoKXPjCnvIbjH6+kD6
	 GswL8VZjpwrhAf2iWU3kqT4ZTDORPN6thQzHSUPdUfM6aOxgTJU9i/7m8Njwetql2/gpQ
	 /Mv8NA+/09LO6mdT8KKs1tWYTGSa/8B3nm4e0wZrQ/WW4yqliHNBVZEFJNMHLjDpy1MBF
	 MV5Dfp3or8XaFe3ynR35LmFacQlSNNSidU+BpHagunaoCBTpEuxrqrVWQofI7mLgon+Cg
	 vP/GriPi5KQaFhkhFaamUkI0hHolez4LGfVzNnOwKdSq916IKBNK4QUD64pLUFeFi/A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788505262;
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
	bh=qL/b5vN1g/ND3L8COfQb97WFgTnc5Ho78Be2lhXnXck=;
	b=eGhAiMqV1KqoWOw5hPNpwTCgiZUUU9HRch9AxIgZegEBW6JeR4qeBIK/Z+GO163hp83Z
	 HWE3Kv1mlBCr0Z57mfdGgRwTmPv8HEkipql/whcz/zlgNtJL7zj5uiKTLQCzHql2ubzGF
	 paEoObX8n/lUoGoobVrYvhq58Pf1l5h1ei2ZJPLjAW0jAT16A6IoUPtlYdeBlidlgzK8m
	 u4j7lTyvP6N2oGCVSrb+fVij6klT1o0gRltDuR20eVFVLZxi0zmPhgWvxbgPlhoSj5v9U
	 UT1otQ90quqOoe1mIBL4gVmg/ZnOVSMO9LEEymxFv6Gx0JJWrX2te+uvNLBi059ykyQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788505262;
	bh=qL/b5vN1g/ND3L8COfQb97WFgTnc5Ho78Be2lhXnXck=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vtFRVE0+OxVGWgpnyL6uYKwpVkcSmgdA7GB0rFO7vhyV70NKJ0RjELtdpSLvRnRew
	 mJBLnALskHxssvE7dM1+f9bE/htTLAduf6rYAzYyWyowgke0dpaqHPFalaFOW99GoS
	 XpqvJoL/iXoH42BsURMPbrw9blM2P2C239vqvmq6JKifjQWZRD2sbegZ6d1940eYnJ
	 uNIwGQUBYxXudr7dY2eT1QwMMQ0RtccIMKheLZ3KybI6yj0sMdogU4xY2jw6qe0r8w
	 Kw08EyNBKaEALtdP21BmeC2CsZ6DQI8Rs+lrBca+96eyTikx3460P0i0gkk4ztBGgM
	 QUUw+WcT3PRsg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 69AFE81119;
	Fri,  4 Sep 2026 07:01:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3E17D2FD
 for <intel-wired-lan@lists.osuosl.org>; Fri,  4 Sep 2026 07:01:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2FD9540B69
 for <intel-wired-lan@lists.osuosl.org>; Fri,  4 Sep 2026 07:01:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8wVqbo6mZ-KA for <intel-wired-lan@lists.osuosl.org>;
 Fri,  4 Sep 2026 07:01:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5C69C40B44
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.14
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788505260;
 b=IcEW/LQiDLNnsekqG0KwEX2rMQyLUo5Xdk5mvvFVVRXSdwR9t/fvZQKC/K5gV7cIr96x
 6XtGADTU2fEN/vwWx3zAKLMlUWznHWWSxtAkGgA3DjqomF+nrc/a172qM4YyRzBgUkadk
 V5if5u3t71xiadZNOzHCdCVEYwVbT2zHEjHLgA6jH/8mR6MkH+R+5FOV4Bp0PrJoUpj+/
 I8vsADkDABqIw7CaPLON8T/PMGNwVRGNQYTwCc04nosy0v73FnNqF25zr5EWS4jH0KUYi
 Vd/6IpZSPKvR5stTdLInh5I8Hm9PAaAtigvjEYxpeDlxK+eB0HFOo7CGCIBtpsVYroQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788505260;
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
 bh=qL/b5vN1g/ND3L8COfQb97WFgTnc5Ho78Be2lhXnXck=;
 b=LTeeyPPmXCIxKTvGBTO8+rq18lC9XWFFVBK1DSiiUZYkNaXuGkb0Q/B3uHxJjhEw3cXG
 KqqNBuxCsw1/xvaffLJoc4x5mSyu+BeD9HCWEwCvDzDWeJGlZMIjF6VlQPbun7KaxJYnB
 wjk0A6erG9VN87SBMbQ/ieeVSoLcuQeqLBe5powhr/7Nqbqg+vOVbxqY6TNJP68FlWlUB
 kjtXvElJh6fXU2kcBP/qRjETcfeqhX/1KnZ1lbCJxUNDHNR3ZW555xdwhiWTH1U5UwqS/
 URgAme2yGvyQCFuVMOImFHzLt0Hm287fvi5ApTRKrp359XxSvMw/PHMgQsfL7MN1s2w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Nt45TuuF; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.14
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.14;
 helo=mgamail.intel.com; envelope-from=sx.rinitha@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Nt45TuuF
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5C69C40B44
 for <intel-wired-lan@lists.osuosl.org>; Fri,  4 Sep 2026 07:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788505260; x=1820041260;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=kTqa2sU0lk68GvufnMlAsr1OuegjPzxJxQiys+ivnoQ=;
 b=Nt45TuuFyUm5byGwLBoJs1jyNJa4/ryTtg/2i29c5R0frJIEJemd2PHB
 MzejfURDO8SJXpJCwWKrdsVtqIhsVqa/kV8bW5ZZD3Pw77o9Bks5mC2Qa
 mMgPFCjfm1Dy1MrL4yD5omh8JwRCgxszTiYJ8Ek9xi9rWzUsQq6G0D0pM
 tKo2P1PqIJhjcsCbzYZOaMBV52cu+3p/xbQVZa1G0/wC6soQxIUmmOPIZ
 D4Nsj3fUt/I6uX7+HwB/G2vnRJ/xWg99Da0l4l+BFsdXiM65POCAa/VRU
 EMLfjFQgVvFyjuZHR2xv6uWT7SEHRISwmKY1r9thpLvgtBDFBF644QyPe g==;
X-CSE-ConnectionGUID: 0z0Y78PfQIyt08yC6lyAvg==
X-CSE-MsgGUID: 3BjBgz4ITb6tNq1UyVRPxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="89023127"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="89023127"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2026 00:01:00 -0700
X-CSE-ConnectionGUID: ZqrLgRP7RXmDfDCVKW1hYw==
X-CSE-MsgGUID: lxh0Jx1dSDmuGLyvpHQLYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="268225641"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2026 00:01:00 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 00:00:59 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 4 Sep 2026 00:00:59 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.68) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 00:00:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DFeguPPuHVfqBlTOSu9jbBI8w/FwmezHXnPgA1iLPiRECBhuqNYog81TfZj46vK2CWthX1GGn/WMeRQzUEEivgzHtYaZXZ12jnmRAd/bX+8lhCJeG+JAWxZU46UpxDGLKCU1vQ7rFEXA1rhSgeuwZTk1Y3KTnUzbv16Vof+zQLZhi60NOPvEsNSH7qUpiC7i4JqXmds5xYmlH8Cu+p/utj0MI0CTFbTVpfdhX0osNyPNgOgwkbpxImqzWPTYxMpj0LN4i528nfZ4WQ+fSKsS9qL280d8mvFw4jhBE96a5Z/TmRRHK8ltoB5ihs9j2NTLC94n3BEjR3/EeWqGV03RKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qL/b5vN1g/ND3L8COfQb97WFgTnc5Ho78Be2lhXnXck=;
 b=WO2WmJ/P+LYI54tLtZbYEhra0kDsVJ2vrJRMz1J1cehiYtOTf7RB29OmDGZEZZlPq/XSo+atnPqVCfuk2V4AXLlknhlboVHf2UHYz8Dt7FGCFWCDDXPwQ/Vp2sFVLgHIHCO6/hJ5gAFs91vBTRUBTyhrTLUF7btmdlxfCaYAadPMv9+6l1ONVDwFgUeiMCsqpMAQUh59bsTQ68/aNeuhOH1dOspwhY8Pnk1AexdOy6UP9z8Zb68XvXMJ8y09vsruBszUxYLFgwiItLm7RJ3RhR4Mj1lO76Al7VK40TLJRZTTN5hRy+Q7snVhbGbCE45t7bN5ilSuiGU6oBY1HNYzcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by IA0PR11MB7355.namprd11.prod.outlook.com (2603:10b6:208:433::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 07:00:56 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%3]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 07:00:56 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: Marcin Szycik <marcin.szycik@linux.intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Penigalapati, Sandeep"
 <sandeep.penigalapati@intel.com>, "S, Ananth" <ananth.s@intel.com>,
 "alexander.duyck@gmail.com" <alexander.duyck@gmail.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Cao, Chinh T" <chinh.t.cao@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v5 09/12] ice: program ACL entry
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v5 09/12] ice: program ACL
 entry
Thread-Index: AQHdChZMx73UbbaosUGIXoqVlH3i8ba+VkXw
Date: Fri, 4 Sep 2026 07:00:56 +0000
Message-ID: <IA1PR11MB6241A905E30ADA3D9AFC9D718BB52@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260702103007.97020-1-marcin.szycik@linux.intel.com>
 <20260702103007.97020-10-marcin.szycik@linux.intel.com>
In-Reply-To: <20260702103007.97020-10-marcin.szycik@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|IA0PR11MB7355:EE_
x-ms-office365-filtering-correlation-id: 151bd5eb-bed0-426c-4b41-08df0a52446b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|10067099003|56012099006|4143699003|11063799006|22082099003|3023799007|18002099003|38070700021;
x-microsoft-antispam-message-info: Xy0n9Z8eD3AsEn/uF14oylDMhFn/5568qMV6Cl91CmncNviy2Qrm9ZNJHvGWdW4MtauSPsO2dxNbak7c71Buo7kK+Mz3489/80yjxHcMjEgabyp2TxDC/SbBeLz8S6PSXQdQ/wQMGuYuc5rryuam3udyEqjjjlDHyYVXLv1ulRtsxN0Ary3I2cupjN7Yksr/VrAcYXnkey4KLeC+v8OOTlK2nLiaZrEP3U2DDNXlGow06WuHDJVmAWMqDkZkPyVgZKQI5xyvaWlmMnHoHNCuZ8s0aNAP/BoqU6as/Cg9Vkn0JB1xBPwa9MtA4OspNP5Gr5/yOF9imnqZ0+iHU5W/AnUXS4Z3tjC0SX6QQdfVjXeZ1me79RadynBtn02EcBkFzf78O+3r66ilhtDPx3TYsNr8ngzfEWhiSa6JML5p0fJHp2VZTSkE+b+Q2wlqlklV/4HIjFJhqjVeryxQ9qzTwEgyGzggZJnJFpIm6cx9sH+1RyNrIc4o/x6YrDMt3tjiOifdd8AZl5Ikaw1k6nHjpwbhcl+K/sMAnjz49q1k6NwVhUTm4AdR+4QSA4xqA6zOQWTx7NlAWaYuNvSgxzaJs/ztGHlNhc+D4MR9bkOuAM5Rr4DmwvCu0EwR/8aihdRl2q2S9pZUz3OrQZ7G5yCD+Bo02v6Izv+mvbm7e3b6VXS2vsdXWkOxu5a+HJPcCpLI+Gj/yo0kxAsMjNil/7ciy0J+sRJn8L71+DMa/4nBsts=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR11MB6241.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(56012099006)(4143699003)(11063799006)(22082099003)(3023799007)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HyRDUT8a2e/Sz5pjKhnemszClHECs/kH0EptNrGESbOEvbpIGF2z+M/8TmGS?=
 =?us-ascii?Q?dMjYS4pYiuTbTRtuYDR6Afd4zJ8mshQG5GRBLzYHG23nVYwbhJlNhaUyh/6K?=
 =?us-ascii?Q?742ZWNkypyaMQPeH2c6bvlnV/QxzzDNPyJjcWRyxu4Jrj40f1PbJJ6QCBr9d?=
 =?us-ascii?Q?KOvmGgffXRGl2gnscKsp97zuqgU2S3pRbga/h14fFXh9kcfjjdl5O7kRZj3o?=
 =?us-ascii?Q?znZfphvqIMcHT/1Uc5HT+PeB/J/cZ7qUmm7RzR8j9Gyo6XuzU5I95Ruvzik1?=
 =?us-ascii?Q?I+PQscM2nB8QIKu2iEaHe6lmu1WWT182qO49XBeLDckqRGyfRCARFJujXcfp?=
 =?us-ascii?Q?w0qPZGINNl3z8FewhyjhbHfxtPMN5OHp8/69GsI8W3d/NOCyG/q9McOMlVWt?=
 =?us-ascii?Q?33UqFdlMgUvyUyDsTZW3AK+Ch1cyQFR20mOpFFG1Jq2n4jA5Baw6rBcQmdeF?=
 =?us-ascii?Q?CvBfXU6sh7UgQCxpKgSq+RV8bOM0t/UHKgjMcjUGb4hDR3w1An0oYrTUGMsN?=
 =?us-ascii?Q?Jrkg09Tk9wiXFT6WaDT9/UIpDLp2lp9zyzt19iqA9fPmastXjTNi3XLqndbz?=
 =?us-ascii?Q?qtzBOeBxjIOZxDCOeyCA0Py/DvZSX/HQToQQuOqydWh1tx7as3s02NPZDTvF?=
 =?us-ascii?Q?xuNfQ20stmbcJ4gK4HFBCrk72qHu+a6arO2uCLyp8K3/RnNyW65qVZ2ENdWD?=
 =?us-ascii?Q?qThz94JjYg8rm/LLMt0TfFt27S12A3urHXZkRsPhu1JCVtBmK3Nezn0h4qyB?=
 =?us-ascii?Q?0VN7a+H//ZK2vzQbBey66xPcVwftTMD0zhqwCiUGH9czW/NksrdWwKfeqNgg?=
 =?us-ascii?Q?vAv7Z9iZTp1I+hen6PYum8HQisT9lTRFdWcrgno3oVAcPHwQ6Y6IwMcVUVEm?=
 =?us-ascii?Q?tn/KeI7lVaDAO2euJRiqIxTNf+zrrK5EathpEaFxrR8tnNIml0ia7o14Eye7?=
 =?us-ascii?Q?BdCmuvV7X9hcQZqPXjSJLROdNf6wUHR6XtZ3DSEdquj3cELGAPrvE8U84jfL?=
 =?us-ascii?Q?927dJsvNjzoiRA9J+0mEIl8BE2yWo6mDRCo/Dk7Q4VaZPdYlcwaaIKTkrY0G?=
 =?us-ascii?Q?6q6SMHiA3Noz9TX5GimhcmfFgyy+e0rXGkirVKSSdXgVN7gSPtFi6EPcbHRJ?=
 =?us-ascii?Q?PGsYiMOwdrvVJ1yIiMW4GzslEtRadF4HxhQ5BijejB3wWxXdzxulfELsa/d6?=
 =?us-ascii?Q?FKIL9MhFB/HZ3090DRf+CFJS4/yztbtpaFvXl24s1m4StcnOmXxSV8Zv+Ig6?=
 =?us-ascii?Q?fPKdoowZwrSyE8PUp6I9aHTWXQb3Rf6lQMNxD0P3pwjzTDXWtb1wOREr0MHC?=
 =?us-ascii?Q?psGyyMlJTvAmRVvZx37Cr/1Jmnf+7+05Fq96M0hVdq4I10BgTAArlvOk2oyw?=
 =?us-ascii?Q?2p0u6xOj/IEs0yMs2TGSnelV7Uf5OjUa0SkErV92XGnrCgBpOrTt/c3LfWeb?=
 =?us-ascii?Q?OisX7n/BjOqudbQ35RVHqZCD044OE/Q1Id60JreInnrv6ZAFoVYiKGGzSlfj?=
 =?us-ascii?Q?TbWde06bdjsY61uJJa/R8FS5TCaiLVBmAsRwG+96JKE4XE0oXsHpZ15k/Wjh?=
 =?us-ascii?Q?if8cCS0LVs0YpCebloj8MLPL5toWC77Lo8H2TMjEchEbWDyZGGHBlCQ5hLwf?=
 =?us-ascii?Q?ZSiRXcTQaPtLvUQhTyPM2RhfjAV//taSO7zGuimtY7W8RRd5qMAvDVnSuutf?=
 =?us-ascii?Q?y4CTjgvzjm71vsgA9kf+dQMk9U0uzQ0CTa80uhjqkY3h3edj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gMFvuAmvkddv316Bz3sFWmL4Z3kmPQreuXzNquX3NCeBIb5k7lp9+xfCJNdFqpogK1XqrWaZ1CxgKG72MIsMKW/OEUModdvXfXMMG2aYP+xbBm3B1+afzMi2srwDVKBbrApz55kUwKSyt7Mas+136SEhYriaqXzXvdqb+0IsvJxJg+KBveKwXBkKWxL8ySdGX+ymvSumZuxf4CS+al8NJsq/W3rOIf0twl6es/29fFELlzzPNHg9OqyRPeIeQz+tVrSPeE65LwObt4koDnj3/6qPjF6WIXP8b/HQa+8shDhwiRBDN9XGFsK5SAiFBqK/pPXwAbsYoMTQrKaQjfCprg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 151bd5eb-bed0-426c-4b41-08df0a52446b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2026 07:00:56.1049 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FxDVev11jsKlSFw3cKGQSFGbIHkqqYiV5CSZiX0sWEXxyzvat1X8XW/H9ICpk2Mptkuo7VKctp2fHwv4+1b/WQ==
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
ux.intel.com>; Cao, Chinh T <chinh.t.cao@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v5 09/12] ice: program ACL ent=
ry
>
> From: Real Valiquette <real.valiquette@intel.com>
>
> Complete the filter programming process; set the flow entry and action in=
to the scenario and write it to hardware. Configure the VSI for ACL filters=
.
>
> With this change, ACL implementation is complete. Filters can be programm=
ed by specifying the 'm' value of ethtool ntuple command for currently supp=
orted fields (src-ip, dst-ip, src-port, and dst-port).
>
> For example:
>   ethtool -N eth0 flow-type tcp4 dst-port 8880 m 0x00ff action 10 or
>   ethtool -N eth0 flow-type tcp4 src-ip 192.168.0.55 m 0.0.0.255 action -=
1
>
> At this time the following flow-types support mask values: tcp4, udp4, sc=
tp4, and ip4.
>
> Co-developed-by: Chinh Cao <chinh.t.cao@intel.com>
> Signed-off-by: Chinh Cao <chinh.t.cao@intel.com>
> Signed-off-by: Real Valiquette <real.valiquette@intel.com>
> Co-developed-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> ---
> v5:
> * ice_flow_rem_prof_sync(): reset profile extraction if it's unused
>   after removal
> * ice_ntuple_update_list_entry(): add a missing ice_fdir_rem_flow() call
>   for ACL filter
> * ice_acl_rem_entry(): set err in loops only on failure. This way, AQ
>   commands succeeding in the end won't override errors in the middle.
>   Final cleanup of entry index will now only happen if all AQ writes
>   succeeded
> * ice_acl_add_rule_ethtool(): remove old entry when updating an entry
>   (same filter location). Without it, old entry remains in hw after
>   update, in addition to the new entry. Repro:
>     ethtool -N $PF1 flow-type tcp4 src-port 8080 m 0x0fff action -1 loc 5
>     ethtool -N $PF1 flow-type tcp4 src-port 9090 m 0x0fff action -1 loc 5
>     ethtool -N eth0 delete 5
> * ice_flow_acl_add_scen_entry_sync(): free hw counters in exchange
>   actions and if the entry is being disregarded deallocated. This was
>   previously done in a later patch, but makes more sense here.
> * ice_flow_add_entry(): same as above, move the change from future
>   patch here
> * ice_flow_acl_add_scen_entry_sync(): store entry ID so it can be
>   properly deleted later
> * ice_flow_acl_add_scen_entry_sync(): zero e->acts_cnt on success, so
>   that ice_flow_acl_free_act_cntr() will be skipped. On failure, free
>   exist->acts so exist won't carry stale counter references
> * Commit message: add ethtool command examples (moved from patch 2)
> v4:
> * Remove last side effects of using struct ice_fd_hw_prof for ACL
> v3:
> * Cleanup comments in ice_acl_add_entry(),
>   ice_flow_acl_find_scen_entry_cond()
> * ice_acl_rem_entry(): clear entry from entry bitmap only if programming
>   succceeded
> * ice_acl_rem_entry(): catch ice_acl_scen_free_entry_idx() status
> * ice_acl_add_rule_ethtool(): add fdir_fltr_lock around
>   ice_ntuple_update_list_entry() call
> * ice_acl_add_rule_ethtool(): catch ice_ntuple_update_list_entry()
>   status, add unroll
> * ice_flow_acl_find_scen_entry_cond(): remove inner loop when checking
>   if actions match. Previously it was effectively checking if actions
>   match *and* are all the same. Note: ACL will always use 1 action in
>   current software implementation, but it can be extended in the future.
> * ice_flow_acl_add_scen_entry_sync(): set exist->acts_cnt =3D 0 on alloc
>   fail
> v2:
> * Use plain alloc instead of devm_ for ice_flow_entry::acts
> * Use FIELD_PREP_CONST() for ICE_ACL_RX_*_MISS_CNTR
> * Fix wrong struct ice_acl_act_entry alloc count in
>   ice_flow_acl_add_scen_entry_sync() - was e->entry_sz, which is an
>   unrelated value
> * Only set acts_cnt after successful allocation in
>   ice_flow_acl_add_scen_entry_sync()
> * Return -EINVAL instead of -ENOSPC on wrong index in
>   ice_acl_scen_free_entry_idx()
> ---
> drivers/net/ethernet/intel/ice/ice.h          |   2 +
> drivers/net/ethernet/intel/ice/ice_acl.h      |  21 +
> .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   2 +
> drivers/net/ethernet/intel/ice/ice_flow.h     |   3 +
> drivers/net/ethernet/intel/ice/ice_acl.c      |  53 ++-
> drivers/net/ethernet/intel/ice/ice_acl_ctrl.c | 256 ++++++++++  drivers/n=
et/ethernet/intel/ice/ice_acl_main.c |  31 +-
> .../ethernet/intel/ice/ice_ethtool_ntuple.c   |  51 +-
> drivers/net/ethernet/intel/ice/ice_flow.c     | 446 +++++++++++++++++-
> drivers/net/ethernet/intel/ice/ice_lib.c      |  10 +-
> 10 files changed, 862 insertions(+), 13 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
