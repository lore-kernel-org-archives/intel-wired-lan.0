Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCF23C79F99
	for <intel-wired-lan@archiver.kernel.org>; Tue,  8 Sep 2026 18:03:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A29B080A9A;
	Tue,  8 Sep 2026 18:03:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qUk6SgjWvzN5; Tue,  8 Sep 2026 18:03:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B386380C47
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788890600;
	b=EbPMjWoK6e0H7JziCbagC/F37XEi3ck1Ld/tActe3Fj3JntXfeEOlPstMe5KaKQqDn17
	 7qJP4T6eQu/I2CfGkOUquIR+KEbWRTrMatzaeWeNCimgaTimFosNF2WtgS0dFCzlLL0nk
	 0O4wTObuYyQXbP7iSRG+oaK5Dx7pMc5kPAiSq4R53IH7oezQIl2IkrnGns0ux/S6TaH1V
	 UsNiClXVQZgthsSdbrWyqMd6g5vufK5OePIpc5xMRZvyObjut3AYQXiSo6m+W+u31VBfJ
	 +m4BNxlX2fVJxuNM7VcfPESe6eJFm6yHbDVVRfhZd6BF9Evu+kNl3WX+n8drT+Ieiow==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788890600;
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
	bh=uPTZzmoo7A9TSrxehjGIN0r9HthGkiDO9cUQy+v1G3o=;
	b=o4Gob0wKPaxSm4tqsUaz2ORtqBQzyO53LoJDbphhVP3pAxh52LgHjfrhM74TQHGP9pB8
	 2yg+wOIT217nP1aaD77mAUla2dXAz2KLIv4hfOpc+iabOUhMQ/tMHwVg9UN8ofGRFGA/D
	 ba7eHmbTjFVU5VfXi1SC8WHq/y9Erfn9nl6u19aRfyPmUpwMRyfOzCxn99eGOsi/h037g
	 ll4gN/TAQAP3IFPB1ZDZmRY+DAiTcnwchTGkmtHsto/i3xENzaM1zk6TPKTyK3xEZVbVC
	 J4WZT/eqgS34aaTbg5G1Ef0rS1ma32levsy7iTRNN5bewrCTtY3uisQsZcFlBsCMxuQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788890600;
	bh=uPTZzmoo7A9TSrxehjGIN0r9HthGkiDO9cUQy+v1G3o=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=J156Qcx4idYVX0twx59E5ufLkN5TOqJNmnSDKhKrml+ZXtnG4nSBp06QBP4hOyx4w
	 Pm/t3JPiqQmDr7QQYEP3cM+bAbq27j/IUotglnAQGU0mTqsxoKvtEI9LvRPryevOt0
	 YOGObOcprssys8PUnW3vhXpf7jyDZxn5UWH4zcsYccciFy1MoCMMPcX9pX0eSq6V/x
	 Bx/XACqT0M987z4WNACIMr3nAiB6HOCorqmSUV7T4ZV5/RHKSFxlP2+iirmFxh6SBo
	 ijZ2VwcP7wX8kjs34Rlf2Xr54adSWnfUeKBUFDFEQewH0WCAyF3sghyhtToeuGN3qw
	 VIru+m4SOyYhQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B386380C47;
	Tue,  8 Sep 2026 18:03:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7462E2D2
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 18:03:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7153F60726
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 18:03:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2yMTH4q6fjE5 for <intel-wired-lan@lists.osuosl.org>;
 Tue,  8 Sep 2026 18:03:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3FCFF60724
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.13
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788890598;
 b=PGhK3podWrtoL321+foChOdny72/x3HMksA8LGn9URO47Q68FMYxPLUwfqkKReB0d+s6
 YvRVynyAw8y9AAoLUb5DUUknh6Obnzsdty+3KSDFPnywVnHHQXaJGgijgl93Rdbd8alMy
 PIpi3sl+tDDHZkD5k/+v4dZ0FuWxMzQ1rgT4DZqCzLvOCKMSCwzWxB66vnMq8xHBzOafO
 Gvu1aQx9kybml+ONcZcU2x7VqmRnyvnot+hZRhvB0n4+nfEAUl5ZmVFSX++KxzWgA0GUl
 K6sLRzDncU5DYycfff1CIVB5ThiJ32ssHiWWmN6i1Pa4ss+oEENGit3KrG4/I0HBzKg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788890598;
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
 bh=uPTZzmoo7A9TSrxehjGIN0r9HthGkiDO9cUQy+v1G3o=;
 b=Nwi0Lzfet1t8bM+oyRqVlbnSdBeCGxMq7rwjeXcuqgtACHndRsKVC9Opz4dbjEoMLVgw
 2B5YiAb72nVIOwEL8S4VVaYK9U+tleOBq1J1WF/WFciKFlarwbPCHFXJD2sA0B8Vd9O/z
 V4DnTgajx1BOcBIygjro9314zlmKMLUqE21IMLrY9p/yhw5uVALPNdaHULM6y6dODF+Qe
 beoqyN5dDrde76IYV/QnIODIoXK3ZBAR7haen80AKwZgfITzXmzcsvGxOL8HhTGIABxoL
 J7yq0C673qo8d87gk5V9HFD9zTzt6QR+ADC78hg8OkmNe6T7VxJKQeQLVguuXWc/7+A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=f9jcxiaM; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.13
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.13;
 helo=mgamail.intel.com; envelope-from=alexander.nowlin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=f9jcxiaM
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3FCFF60724
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 18:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788890599; x=1820426599;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=uPTZzmoo7A9TSrxehjGIN0r9HthGkiDO9cUQy+v1G3o=;
 b=f9jcxiaMJ52OCIfCKtS0/P5s47lPGT80IDe6WaXzRjoPOSRRg0MYknz4
 n5awpmA9RbqRU59s1UHo6weII2DWW3H2G0kgEFT4pmWp64oUi58bdHfza
 7nEv/iBb2H878FRodEKNnffuGw++e/ZEGUv9hWMpQkgCxNgJLvKGu8fQd
 zaqG7J8or/fakGXTmX0rVqWipiJNsvxbtZAaaFkwmUB57Yh3MDOEK4B8j
 YNrV6l4+TMm96Hi+wD7ZEqWMODT2L+O4pqhe+gSjbhOJJ1sUBhCIMCqsb
 rNyMidJmqE4c2M56B9XuBv5wRZ1VEbncMaOCnz6idq8W3ufDIC81nW/fu g==;
X-CSE-ConnectionGUID: 7pnLKoKuT7KiZ3I9Jhu4Yw==
X-CSE-MsgGUID: XiQdw+KSSRCCq+ek8G80Sg==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="100461264"
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; d="scan'208";a="100461264"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 11:03:16 -0700
X-CSE-ConnectionGUID: Id1nn5TPRbmcFi2Cd4/DTg==
X-CSE-MsgGUID: cl73ohrQRoWVyIeoGd+FMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; d="scan'208";a="274618698"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 11:03:11 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 11:03:09 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 8 Sep 2026 11:03:09 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.30) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 11:03:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G1VMg3XmGgiuzP3jkY0XqLPBRxnY2C05f5IO0FovuwIcM2j9fno99Mbb6JFrIkzrU3ziSc3TEbVikDi7+f6kM8+T4yURiGpVg9RwEWrJYx4jJO9UQ9PU8eUs+p9UPrWb1piEAHrLmBRjxWo6Sm7PYzT6RqoKCNXE1GBmuMKgLFVUS99WB/eq7LId69BPDoCqkbk+F1PL2e2XGnUkb4ZMU8KlUAU7q5rjue9Mm/+vRTgsqi+zHFaTnZrOdcR0OxDbfSwTJ68ej/sgwm0qyH40XDtExFnaqqAoI+APRVto7TPgBtyqdkNCKcMS7JWiP/eyVfaxErXHnrxRz++HmR4K7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uPTZzmoo7A9TSrxehjGIN0r9HthGkiDO9cUQy+v1G3o=;
 b=E3fpx5aIVlxVHWA/kVKRKZcR48iAqS4PSF1S4hRHjQwnJVXAYxs2TFR4j8O+Fe/PzoWiT8cGdFVajub4g6ey+oKllPLzPpKDwVDdUpMItePUZbhZHf9OClU8161dHAub1sD068w6SkVpIwT+UZMgVNKxNQOY3N9qxbMjbKQeS99PAk5PqV0JFF/UaKRsEDws7g3Zj3O/goee5uIte0ABkMjLwXLXv2A3bbjh04+VjZ8m4J2fLxpCKgNbVDMVmNoVCdN4SbB+yRtjXVhHvytk+QQBTEwaZLhfiTlhooAnIZTySuCRO9n0NZ8PfIM7tGtrYdzobm2WcnDwVdCmEYxTWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by BL1PR11MB5255.namprd11.prod.outlook.com (2603:10b6:208:31a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 18:02:58 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 18:02:58 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, Intel Wired LAN
 <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Machnikowski, Maciej"
 <maciej.machnikowski@intel.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Korba, Przemyslaw"
 <przemyslaw.korba@intel.com>, "Nitka, Grzegorz" <grzegorz.nitka@intel.com>,
 "Oros, Petr" <poros@redhat.com>, "Bross, Kevin" <kevin.bross@intel.com>,
 "Cavatur, Ranjit" <ranjit.cavatur@intel.com>
Subject: RE: [PATCH iwl-net v2 03/14] ice: set in_use only after preparing Tx
 timestamp index
Thread-Topic: [PATCH iwl-net v2 03/14] ice: set in_use only after preparing Tx
 timestamp index
Thread-Index: AQHdNOTOTcGSs/j3M0+V2rUedidqJLbFDqJg
Date: Tue, 8 Sep 2026 18:02:57 +0000
Message-ID: <LV1PR11MB879077F1820A56F53AE4EF7690B12@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260825-jk-e825c-minimized-fixes-v2-0-8223f95d26e3@intel.com>
 <20260825-jk-e825c-minimized-fixes-v2-3-8223f95d26e3@intel.com>
In-Reply-To: <20260825-jk-e825c-minimized-fixes-v2-3-8223f95d26e3@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|BL1PR11MB5255:EE_
x-ms-office365-filtering-correlation-id: 02793b1e-55f5-4928-5a26-08df0dd36a20
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|38070700021|10067099003|22082099003|11063799006|4143699003|56012099006|18002099003;
x-microsoft-antispam-message-info: Etp6fx6nTyLHuCS8iP3yWC2GOJZk4UdmDHnD0x4Os+dT5JHBpzYezihkEflzWmOOBqFD7ttEXA3tsjKQyOPWI6ORi178ppKz0Kgk1zmue06vqz+iDfHIooyOGX//niKDyLkduGSoNoX1No6YE/iug1IYo44H84MCDu6ovUODGONPnMDPTMa1HWEolr33dgemGoDBgMwhMybwDJZy4/ATt5FQG3u5C5xzeSyHBLM9ykZaN5QJYnXGzwensXOVlRmUpGAdzF8y3LG4kiySDiiEvHInDIhiOB8vfpc9AGN1DSdYlKzHFC/XgzI4CUPpUvjVwMrWJbmvb+4ajXDLvVC7DONE5LisnBa2Efx1diVN5R5IqUFkDCuhfuqRMRMNu0p/R8JGvUrQeDCvYpSadho8H4BBdDfUJztzDPQ37+43SeSuLKefBt0EnxcksRYkczuaSccBdGXyIVyaNv9w+aacHjWhjZWfZcOmLaSsdrWh03N8dbBcsDwHRCcCX0vHnUfXOCL4MSq/yoGm8QPaqcr8/f7RruFD1mUyRFJYc1Yzt9PLsNvgZ2nHZt+xFt+EKYPhcPQG5VaeWGYk4f8VSU/i7rX9C6uC8mRZbdDT80g8NMkkG6fPS5eJCwcmoi+rBjiiObyZid3ozaT4YrxoXaABDbBH4JKMD0y/bkYvEgRM/ek=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV1PR11MB8790.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(38070700021)(10067099003)(22082099003)(11063799006)(4143699003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UWtnQlBGdVBBcUt0SE40Ri9oc3VYS0VYSC9xWjJxQVhqSkxXYVRqRVJHckcv?=
 =?utf-8?B?a1hDK2hUS2QzT3pCS1RKTjJlczVxcUNFOUZBdlE1dWpjcURvSFJyNTV5dlhw?=
 =?utf-8?B?M0l0Wi9ORkhpb3AvNzRnUkhOWGl0REFuWEo1elRZNCszRTFwM0JkbVdiK1or?=
 =?utf-8?B?QUJmTnZBa3dkdFMrWUdKZ0phdlZxN0Q5TkxjKzJNR0s2RDFxa3ZxSkxEZ0ky?=
 =?utf-8?B?bUVOSFFzcS9vOVlqbmhrUVA0elNqTFhyVjVQMlZMNzNHNlZpYkdxWFR6RW9z?=
 =?utf-8?B?dmNMSzhudWhuV0xPc3VaTGsxLzQxR1hOV04wYkNUVGQ2WHZseWlocjhOczJq?=
 =?utf-8?B?UDhmeEN3MEtCRUhja2FvRzFNZDhTU2JFa01pallXSEd6UjcvWmttUmxubTFE?=
 =?utf-8?B?Q1NlMGVYbzFnNkxHQnJqV1ZJR1cyenpreU90UjY2aWlIUFZVdXRxVFMzOS9m?=
 =?utf-8?B?enc4aVhBZDBqWjFwZituY3JQaTYxempxNFY3NEFhWmhVYmlpMml5YUNKMXVV?=
 =?utf-8?B?VlZhbHVEWDczWW56OUswbFdvb1YycjYybUR4WkxDMzc0WWVKNm5IZ0dCQkJH?=
 =?utf-8?B?V2MwekduYlVyYWlTVVcwbEJXOVA4NkgvTUxiMks4TzFaZGZVa3ZRblhQdmdv?=
 =?utf-8?B?VXd2YmxJd1RhdTdocmw1OGhaRW1ZdnRvK0gyeDZTdm9SM04zdUc4aFdmOXox?=
 =?utf-8?B?TUVxR1VBRFhZSXh3SW5sV003ZFNTS3Y4aXhoL1FPK3NBRTFNYjZodUhHS0Z1?=
 =?utf-8?B?S3dBcVI0NTFackhqVDhMWGd4dEMyK1RsRU0xMUk5OGN0clFCeFBjOE5vRGEv?=
 =?utf-8?B?QlkzeFhSMVcyelRUQ1VjV3I1QWE1a1hpWDdnNUJWamhsKyszVmtxeE5RNkdR?=
 =?utf-8?B?OFRRNzdEeWRUR01TZ1hRTHlGcmVuU3FHWFZPUVZoayt2MzBpemk1Viswd1pL?=
 =?utf-8?B?SnVxdCtsdGlFN2V5eTB4ZklUSVBLa1h3US9XK1hwQUFPeWZYdzFCSTUrS3Z2?=
 =?utf-8?B?YnIzVE9jcUFsWXg5eGlXWmZkL3NNR2VFZzhFZ3ozZktNWFpiUUtxdFpYampB?=
 =?utf-8?B?cjdMUWo4clZTb3ovb3pFR3owZG1zZEpBZy94eUZiRTlNcXZvTmlIOUlkeUky?=
 =?utf-8?B?b2haemZEdmVkU0lFQk9QdDZadzJjY3JBQndmNFJicTdWdW5VWFN5M3JnSGox?=
 =?utf-8?B?TDhYZ2h5dDB3RXhtRVYxYU4vVWZhMTFZa2hlNjF1SmplN1FRa3lZcVFOUjly?=
 =?utf-8?B?bEZ3SjNjWmo3U1dpdjloT3pjQ0FSR0V0U2s4dElWcjlnaGszV1Q3SXZ6YklN?=
 =?utf-8?B?VE1kZnlwZDNadUNwdG1wcHA2TGlMTDZ1V3hpUGh6QTZmSmFmNHlPOUl0aXo4?=
 =?utf-8?B?VjcyVzNVZHZOVjQ1N3ZSdEZsTXZFbDZ6WlAwbEVLa2t3VkdUNkJpTUQ2VnBD?=
 =?utf-8?B?a1R6ek1LV0hMb1NqQytadUtXZHR0L0RGVGg1UVFQV0NmRDlVZ1BtTGUwdkZy?=
 =?utf-8?B?WmRva2hDSWdmQUJqcXZuOHlJQ3YyTWdLclZBL0F3YmN4cmVieFdqR1F2RHlM?=
 =?utf-8?B?MFowWURMMUZBT1FGVU5BRDJFREQ1RGprT3NYVTRoMHoybEc0eTVqUk11blNp?=
 =?utf-8?B?TEEwTFNHSlVmNml2ZVJiWU5yandYY3NucHduUXpaUGJGUVVNNkFUWjBycUZH?=
 =?utf-8?B?OGptUUQ4eU1zWFAyc1dqeU5TSHlCVVU0Qm95WFpBMFkxenIvNWFZT3gyNE9T?=
 =?utf-8?B?M0YzaGpiZjgwMjlQTG9iWTF6bkpSRFA5N1VhTUpQNStvYUNtK29MZXM4d3gv?=
 =?utf-8?B?eG5RL3l4cTJSajBHSThCbXBxRUo4WCtQeE41TW1iNTA2eE5SclkyZEVGTDZi?=
 =?utf-8?B?azNwYUZUMUpiOHJWcW1ZcjBZQ0lOSmxjemVrN0hiWFFVMS9KazB4NkQvSy8z?=
 =?utf-8?B?VDFIeG9HYk9IZ1pxZWZJMHNMOXN3NG9YL1RRbFV3RjNzQktVOVZUL3MzaGZX?=
 =?utf-8?B?NVZLWXk5elZEYVFEU2VpVHhYOGk2bldybExYb2xVNEY5b1hiMnJnS01GcTd6?=
 =?utf-8?B?SHNFVzYreHdZTWczci9mc2VRNFcyanltb3p6NEFpOSt1U29uTFhtclAwbXgr?=
 =?utf-8?B?KytMaDZCMkxJaE1WZGdNak1SUWhEQmVGQ3FqS045NVNPbVlsaERMWnFxR3hV?=
 =?utf-8?B?cnRFZWwyT3Fqc1ZFeEFJTXhJdVZSb1dzcldJNzlFWFBxTEFlYTBGOGllOGtW?=
 =?utf-8?B?dTNzSUdtSVVjYStlbkNueXhDWUJNMjVuQnp0dDRLSFRPZVdOTC9yRW9YZUkz?=
 =?utf-8?B?SlFTdHFhZUkveFE4R0dUNUpwcWJSaVIxQU01K21wQ1Z4cENQZ1AvUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: yOBpJW4Bibuqw68Kwzc3v71CemoD09CbHnY+Pzal6dLhQZ9zHix0K6Kf1kAJxe3Dgzvx3QbLSqnvTQWpFv3skF51soReV28tosGP4gnf6Y8Rt5i/vdS/FaiYJtp677p4viJRrBrSjQXNkLdYxZNtyjxplM3yz8hoT5o8+sxA+zyGz+N6lOBGR0btene3vJj6lrSeFFmRbDAmcQFW3YWnmnUP9YXq1B6v9Pzsy477Xn8W0ZprbKQVnxJ+sKxNr3MocsGHwqPbDlZzSZJog20sp+kLcIke1y+9n5+x8SZbgnH9+B4BrZXHaI0Gj+71Nva96l202nraMKW5ZgKzVJH3yA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02793b1e-55f5-4928-5a26-08df0dd36a20
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 18:02:57.8934 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fLzkvaLO6Zu0IHX00uP/ii5DSEOizU0ZZy5oVgYkd/hGzzoOJB+7ZyxoAfYQVa0MODkbXqKKr1nHabVz2MVJ2sBcvvSmj1Q0kdkvWxQfFJQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5255
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
bGxlciwgSmFjb2IgRSA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBbUEFU
Q0ggaXdsLW5ldCB2MiAwMy8xNF0gaWNlOiBzZXQgaW5fdXNlIG9ubHkgYWZ0ZXIgcHJlcGFyaW5n
IFR4IHRpbWVzdGFtcCBpbmRleA0KPiANCj4gVGhlIGljZV9wdHBfcmVxdWVzdF90cygpIGZ1bmN0
aW9uIGlzIHVzZWQgdG8gcmVxdWVzdCBhIHRpbWVzdGFtcCBpbmRleCBmb3IgdXNlIHdpdGggYSBw
YWNrZXQuIFdoZW4gcmVzZXJ2aW5nIGFuIGluZGV4LCBpdCBzZXRzIHRoZSBzdGFydCB0aW1lIGFu
ZCBzYXZlcyBhIHBvaW50ZXIgdG8gdGhlIHNrYiBpbnRvIHRoZSBhcHByb3ByaWF0ZSBpbmRleC4g
VGhlIGZ1bmN0aW9uIG1hcmtzIHRoZSBpbl91c2UgYml0IGZpcnN0IGJlZm9yZSBkb2luZyBhbnkg
b2YgdGhlc2Ugc3RlcHMuIFRoZSBJUlEgaGFuZGxlciB3aGljaCBjbGVhcnMgdGhlIHRpbWVzdGFt
cHMgcmVhZHMgdGhlIGluX3VzZSBiaXRzIHVzZXMgYSBsb2NrbGVzcyBmbG93IGZvciByZWFkaW5n
IHRoZSBpbl91c2UgYml0cyB0byBkZXRlcm1pbmUgd2hpY2ggb25lcyBhcmUgaW4tdXNlLiBUaGlz
IGlzIG5lY2Vzc2FyeSBhcyBhY3R1YWxseSBwcm9jZXNzaW5nIGEgY29tcGxldGUgdGltZXN0YW1w
IG11c3QgYmUgYWJsZSB0byBzbGVlcCBzbyB3ZSBjYW5ub3QgaG9sZCB0aGUgdGltZXN0YW1wIHRy
YWNrZXIgbG9jayBvdmVyIHRoZSBlbnRpcmUgc2VxdWVuY2UuDQo+IEFkZGl0aW9uYWxseSwgYmxv
Y2tpbmcgdGhlIFR4IGhvdHBhdGggd2l0aCBzdWNoIGEgbG9jayBpbmRlZmluaXRlbHkgd291bGQg
YmUgcHJvYmxlbWF0aWMuDQo+IA0KPiBIb3dldmVyLCB0aGUgZXhpc3RpbmcgZmxvdyBub3cgaGFz
IGEgdmVyeSBuYXJyb3cgd2luZG93IHdoZXJlIHRoZSBJUlEgaGFuZGxlciBjb3VsZCBzZWUgYSB0
aW1lc3RhbXAgYXMgaW4tdXNlIGJ1dCByZWFkIGEgc3RhbGUgdmFsdWUgZm9yIGl0cyAic3RhcnQi
IHRpbWUuDQo+IA0KPiBGaXggdGhpcyBieSBvcmRlcmluZyB0aGUgc2VxdWVuY2UgdG8gbWFyayB0
aGUgaW5fdXNlIGJpdCBsYXN0LCBhbmQgYWRkIGEgbWVtb3J5IGJhcnJpZXIgdG8gcHJldmVudCBy
ZS1vcmRlcmluZyBvZiB0aGUgcHJldmlvdXMgd3JpdGVzIHRvIHNldHVwIHRoZSBpbmRleC4NCj4g
DQo+IFRoaXMgd2FzIGZvdW5kIGFuZCByZXBvcnRlZCBieSBTYXNoaWtvIHdoaWxlIHJldmlld2lu
ZyBhbiB1bnJlbGF0ZWQgY2hhbmdlLg0KPiANCj4gQ2xvc2VzOiBodHRwczovL3Nhc2hpa28uZGV2
LyMvcGF0Y2hzZXQvMjAyNjA4MjEtamstZTgyNWMtbWluaW1pemVkLWZpeGVzLXYxLTAtOWQwNzMx
ZWI0ODU4JTQwaW50ZWwuY29tP3BhcnQ9Nw0KPiBGaXhlczogZWE5Yjg0N2NkYTY0ICgiaWNlOiBl
bmFibGUgdHJhbnNtaXQgdGltZXN0YW1wcyBmb3IgRTgxMCBkZXZpY2VzIikNCj4gU2lnbmVkLW9m
Zi1ieTogSmFjb2IgS2VsbGVyIDxqYWNvYi5lLmtlbGxlckBpbnRlbC5jb20+DQo+IC0tLQ0KPiAg
ZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9wdHAuYyB8IDYgKysrKy0tDQo+ICAx
IGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpUZXN0ZWQt
Ynk6IEFsZXhhbmRlciBOb3dsaW4gPGFsZXhhbmRlci5ub3dsaW5AaW50ZWwuY29tPg0K
