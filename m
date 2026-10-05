Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE70CCA5FFC
	for <intel-wired-lan@archiver.kernel.org>; Mon,  5 Oct 2026 17:56:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A1D7860770;
	Mon,  5 Oct 2026 17:56:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ruVD-Ff3eX7D; Mon,  5 Oct 2026 17:56:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 19E7A6075F
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791222995;
	b=cWEmsUL3FRnTR/+viZkVyeuoEitSbtca49IzDn2x1jKUPjpHGPuVxziyUXhO5G9BG4uz
	 AAHCXHYAZj+Ope8HH0/YzovFbzSrvYajNMHd4c57g/5HYQ9xnr1VdBiTc+rUg6ktTXUJM
	 iW7Q3yLiNiZgqeq7hqUgD1pyL4o40nxIvzk1OuZlITfgFaAoUaPc1fZYW/Q+ivkYYCr31
	 n49dtsflmG7i5lSXyrm0A5hwimF6Mej43YBxiQswR2rUx8THp3C3jHIebh2LMcSYlWCBQ
	 gfjND/YRMM5iZANo3eVyV0OzTGWP2KA11j/au4ci4Zg22jaOugI4VEnmw3Hi8JmLLBw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791222995;
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
	bh=eLjrwRb0fvT6doMBO6DWEGpNnf/q4t/BWCNENn6f2fU=;
	b=akxTM2oEJookpgScMMsETFlka0wTC72atI7T+1EsZT0vFMwiJnjb7fGG3Wvy+bfhrWUw
	 8trYyXzYtrRWKlQyarEaJDYjObZ9j8GWu05zhAc+I3KMT0mOC7dxiIv8H7CLLshudA1/+
	 tbsqvyAZ5Lbgl3Rd6AKT/BbqfdbnntZaP4TshGSQPp8SfemkxholC/kUDatw+0zoW/Tft
	 ze4j+TkrbukSb4B1x1YQdLCgfWasOrbNNSIKJseieTnQ/RsCqS4C/2fKlZGnq3akQsLuM
	 qeFzLuuldg5woVpJojleEwyQAKsFJqZW6pZbzKfIYY2yaRWaNDVbVp7ih8WUWKXKLRA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=M1Fcm4v3;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791222995;
	bh=eLjrwRb0fvT6doMBO6DWEGpNnf/q4t/BWCNENn6f2fU=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aEl3IK8zRtWlaQ21+DEhQaOBwA4Mrn6wYc2kELzYZHpcfvM8AVcCipEU3L4ukN3if
	 HxsgOhpKy/iz6ePf0BhVBDPPRCFYylIVuMLN3YLpvQsghSvb4YN3WPD5pCkaBmIQ9h
	 XC/MXPwRXPHw37yDl9E5NvTEVQJVtBt5NJ18FoMrbcUTTszdvcB4L4MadLunD+XsUH
	 T6Z6hN2DI2TVPQvfP9yyvFtvq7pYev4TG055zZ6DUVBW8JSOggiXyL40Tfr9MUfvt0
	 xfJXjMQy/L1Tfa3SOdSQ6Myc0Rd9TaggZQ/JhvJ1XgZkcP5weURPVLWSLuDWYfPX+Z
	 3BFxGPzMpEong==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 19E7A6075F;
	Mon,  5 Oct 2026 17:56:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id F3F531A6
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 17:40:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D92CB6073C
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 17:40:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bnw2ySCxqDYI for <intel-wired-lan@lists.osuosl.org>;
 Mon,  5 Oct 2026 17:40:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C7F2C60718
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.20
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791222023;
 b=RfZqb98dJ7Wy4K0+zrl4XCMEDiaBzp/j15ilptTJI5Bt4XLNcBGPFx0Avaqyvq/1bH0Y
 2RJjkkL5O3Q85MGDZVLzKSDa7eS4AGB/GlJ8pVpg++8i8OarpycTyu6CsYZGl2BflcEgS
 A2yHZ4X/B6xpzClGyUyGuGTT3a6XfFjoC2bxdIKITjcs0cfBgoznZYBrzjXHPE5ia7Jt/
 lISHbnHNPdAXu2ndJEPJx0gDLmk4b4jYYURZ+IbsKSMRIn1ilO0N3rUTn4aZbSVwH34B5
 vJD/v6M0CYXaex5+gaCGAbsw8aLQFBQa+Dzq/C1lDat4/HSMsrlSW6EfawJqE4fuvwQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791222023;
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
 bh=eLjrwRb0fvT6doMBO6DWEGpNnf/q4t/BWCNENn6f2fU=;
 b=n6JJiWZRhRxADVjbkX1zlVrJxvWS1kU+lLmXkwIZ967gfFy/tWFFdixb9pwOUGRPpMib
 jSHAvI3NneFjDIKpysvqjohO6e+LW22WjhNX+VDpz/Rv35kViOkStmZKI5DrMsXrQqva0
 r8EVXhVBT4px3NOPUJwnDvhEqEtczrVb1ursjEPkScG5m9Vo/nlP9FLg3yChLMipD962h
 9CT5herWx1N2P71f1XqXxgHw96qD/KukEPzUzUpaASDeBoaJ83Qd+A7K+7uK0QbFJDgyi
 usifuhAlUXiH5CHsiAdnivxbncqTMVOD4DTQ7BWY3oCNBNjCw97FaTiw3OnxqkdW0CA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=M1Fcm4v3; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.20
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.20;
 helo=mgamail.intel.com; envelope-from=samuel.salin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=M1Fcm4v3
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C7F2C60718
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 17:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791222023; x=1822758023;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=eLjrwRb0fvT6doMBO6DWEGpNnf/q4t/BWCNENn6f2fU=;
 b=M1Fcm4v3BLWRlYa4U/jlm2h6J9tzR+plRZTQiHRHI2rcaoxYIbkkZbiu
 OIaX8ltOFSiuNGGpB8gLPrJeDm27wzyxaQh4o0Hd629sPTqux8dml6024
 FjkdtS9kzsQB39+nVOpXZJakiLMaiTLCgJlSx96JDnwKsou9JVi5uhcTQ
 CI+F07RxQNz3IkIfo9Lc7VISoMFJtPYIloOEFe+O593f1bqY72VxCZ7Ga
 1Q4elAJBhk8IP4JVIMAzvFvif2cnJPB8aTs+D+I+oNdG2JS5W6SaSbsiL
 JkyRBOL+vGUdsmsVIvny5jg2lcqx5N+Hes7i5woxJiULLvM2szcdoXL4q g==;
X-CSE-ConnectionGUID: IBarh0NQSWmj9QPA/EsXwA==
X-CSE-MsgGUID: ToibAXGkQOKIjRE+UM6v0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="90670966"
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; d="scan'208";a="90670966"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 10:40:20 -0700
X-CSE-ConnectionGUID: ohKNCsp2S4C5don/8x7Ulw==
X-CSE-MsgGUID: 7hmm2+qqQAaD9JhbfhktHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; d="scan'208";a="276422773"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 10:40:20 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 10:40:20 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 10:40:20 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.36) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 10:40:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bx+ePaAlNfIXJmjOPAmJoZIHzq2lhWCOYQHt/sZlMa5GOlD02r7EedsMfcNmCjvzdOX+lGPYLluA37A4iFguF+hiHmaY3hOLVD59ahii08v3wVDcmNnDCSBmjw9WUenNIfBPrmMoUOKJvesfdW2Z/+DGofZOMDUoh25ynYKlY3j+kGBQsWXExXsU+yX7goFJ7rWUfcZOETqmEfZ9PEhjmfjlz8yAg1F8xn5dIgQlq9pYdyqUOQqS13tjGGkcF+tUvsXI67U3V6Sfj8q511tSLP45xPnoAgzreS0oRAL3ZmmTrAPfvrpn35UwffPEBWqMeVTInMBLcQVcaV8KQwTw1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eLjrwRb0fvT6doMBO6DWEGpNnf/q4t/BWCNENn6f2fU=;
 b=SdAuKpIKTcX8jIUVjzdbWNLXnoquxzTYjGIqqys4UULX/FxJEZTf//6uTRowcgkGa2p2D0DQhdfGjogyPiLFacQfy5jXgBR4Bo7OnS26ZoXyKiUyZ/H9zAAZWPba6ti1zjrLeWLe/dA6TMqf/+rRiIhivCpEFe2XAqTDsZmkihR8HhNaA4usovcGb8hnXP88QCgOkDCJAUxPiMBlKp2+f4oU63v2pdCR0tOFJpkmitJeORllRFeKz+16zFMrggSvaeWz0155nyIQRMBExwpxQeim3vOkZLKBVeF6jj8vOgnWT6yh2XYdx9g+zP7jYlV2H6h/mlvLkvo+XBXjwTdolg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6422.namprd11.prod.outlook.com (2603:10b6:8:c6::21) by
 PH7PR11MB6834.namprd11.prod.outlook.com (2603:10b6:510:1ed::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 5 Oct
 2026 17:40:16 +0000
Received: from DS0PR11MB6422.namprd11.prod.outlook.com
 ([fe80::d257:46d9:13f4:adb7]) by DS0PR11MB6422.namprd11.prod.outlook.com
 ([fe80::d257:46d9:13f4:adb7%4]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 17:40:16 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: "Greenwalt, Paul" <paul.greenwalt@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Greenwalt, Paul" <paul.greenwalt@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "Loktionov, Aleksandr"
 <aleksandr.loktionov@intel.com>
Subject: RE: [PATCH iwl-next v3 1/3] idpf: clear drvdata in idpf_decfg_device()
Thread-Topic: [PATCH iwl-next v3 1/3] idpf: clear drvdata in
 idpf_decfg_device()
Thread-Index: AQHdPJkEsicTGJajcUKCiQURY3Z6jrbvZ9gg
Date: Mon, 5 Oct 2026 17:40:16 +0000
Message-ID: <DS0PR11MB6422190D8F4E4219503665469B962@DS0PR11MB6422.namprd11.prod.outlook.com>
References: <20260904103714.978256-1-paul.greenwalt@intel.com>
 <20260904103714.978256-2-paul.greenwalt@intel.com>
In-Reply-To: <20260904103714.978256-2-paul.greenwalt@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6422:EE_|PH7PR11MB6834:EE_
x-ms-office365-filtering-correlation-id: 625f3466-a0c6-4c97-223b-08df2307b78b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|6133799003|38070700021|11063799006|10067099003|56012099006|18002099003|4143699003|22082099003;
x-microsoft-antispam-message-info: btV8uqBnaIDGvv2fOiheFNm7H63lCayIOy2/tDHRbBDkpbcJLIjGs7SK8myRfFNQJcV1/Dnx+JV1lsITLxI2rAKFfFGihCUWj6zKIn0dx5vFmng06hZwpFVYLsOZiAZLLLHywSgtzu3VwDChXfESCQ0c1AC/gTlVRb8Q4oyPs8Lyu0SgoPRlrR88fQjRnccXynSn4W2hGVMVdNuR8xp6v2BUj9d90xKb1Xv8Xc9+eDaCeQhmCKQqvbvlRJ7+jD+VZsWJjjzImzgGFwI1Z+UW6rfuIRqNchp2CKeoDOajfrW5k0fMP+WwhMtCN/mTYUMOZNJAfxLTkE39KqENle71Krnferc4R6wNk4MBqE4Qg+WzOELg984Cr+K4LMSlSXBaGz2uC3Ix8o0hJaZ2QKB0HtceyI3yLEFAeed2qIfXXcy0KM9KGkRPfLrAFUPS81UQC+Zk8qeUjFZA6xLpw4oIumgFm7jap2WheOdFp98k7Rp0Nb9YSNmen9deN+jCOF7v9msMxN2BjreWk3cpRk8WGlD+ORzoLLOU6aIjVPO1ceCTYNSfDMbm77MyvIgEBJ2uvhIFqH1k5ZAuYV+vU4kHtKrOqyrojW7aSPneFtKpRZYM/GuPGC8WniBbXsPmi9OV9Bzckw9rZ+2G2N0hvaUjw8gFoUuOQYrYxN34F8eIb5Gq6+qlmiF61TvPE/I3ZbHDgabX1L5JTnDsj/jR2wCfJjLTcxjsZjVPkT8saNXghrs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB6422.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(6133799003)(38070700021)(11063799006)(10067099003)(56012099006)(18002099003)(4143699003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aRKhJNeJ58vzIyhlm9tCYdzyMU+MIbsjCVWQduQoBMeSU4XEFtbSny9vozXl?=
 =?us-ascii?Q?R+MCqCIqDh9u1cWap7c90HFG7iAHfgbSU90orFs+V+EB03KoXj7Vmfl05phO?=
 =?us-ascii?Q?5LTqsxYKq+N7yFIXXQ4jXxwTJaTCTQUT8poi8aGmHcOTqOShZ6f6GUbxBPf7?=
 =?us-ascii?Q?5bCyMnkZgIvRxpdnC8aJuzQcQRZCTgR3Aq7njXUK8A1M5OtO/jOYfxqFZf12?=
 =?us-ascii?Q?wpxWfcWi210YlmNWSDRwG2IAQ/YhW0INdrG9Z+BT5qWDLpaHmZslw3nCjPun?=
 =?us-ascii?Q?pFcjwdxg1+JDJmA2RBjjGdwE2WRYAYtcCEYQ5/8nL8XHjkTK20ufNsRZI6ri?=
 =?us-ascii?Q?7R5WxEZDI+pVdah02urdTRp2zgiBdvJMfv/FbEu1E+4O/q0yF0RxZuW5eGWM?=
 =?us-ascii?Q?T6FRAMCeLLbNMePgKxeuIlbWEJThJ3CLpyivkkE1GMKqvsfzNeAekGLA1k+0?=
 =?us-ascii?Q?Sqk5yECgP+3rjgwpkbleR66/IUQW4nP72FX2tJ/DaRnib8C8orphIB5GFb18?=
 =?us-ascii?Q?no9N1O8bE0mR2mVHcaIxgeuACpMcBf2YQLku2Fw/P2+tog9VF+amMJOYE2P0?=
 =?us-ascii?Q?IRfXUnwcB7NygV47Gm5QtPiHwiZzBnZswWsn0zseaj2UiIGOr1IP71Jev9ZS?=
 =?us-ascii?Q?IruTd4caxrBFYwnVv61Cxl9mpPPV60K5oo5LnZeA9yTtLjZjCw0OewyCuoxS?=
 =?us-ascii?Q?5Zyln55CmSIeg/wqfWfxnFo3b8lrQK6Qseym3/PjsK5SrEYpR/HiFO9CD6QP?=
 =?us-ascii?Q?N42SmKO56mDwd74IVXT+fTyJmt5G7NqiUOXYcnib8DXPq+OiKiQLTOtakieC?=
 =?us-ascii?Q?VZACeUIb+5tw1smB73Qyh7wKui4zBFI8kgc2kdkiKS8Vd9C1nFsQ3xLjy9s1?=
 =?us-ascii?Q?95VpoBDwQUveo6QlOIbVAvvmXQKI+3r/lnAfkmhvPkxNZLtRRhC5jv0mlaRt?=
 =?us-ascii?Q?8smfhzWxumVZVfki2XRMe7uI+E6JzCVX3V+dFzMqboGtDLTLBnm1PF1iz3Kv?=
 =?us-ascii?Q?AlAW5uVO3xt76sbNYUK+uWswzfZrTbluaUpTSr02fy82USCKPsYbOgLGymiA?=
 =?us-ascii?Q?m0fp7OYQ9TZ2xhHQu7AiqDEDAUDvMeJJTcux0Th4YgoRFLiun5L/a5GObA3Q?=
 =?us-ascii?Q?LqCvHT1zm1SMnT924uecp9DEf+7mi294Awn6iKg782mOtyAN9NUqreLIscVv?=
 =?us-ascii?Q?IVO/xztCM3M2rYN9U9A3ygvcSNzNqP03k+JLZTYdU55flN/EcTwJhN9R4h2F?=
 =?us-ascii?Q?+qfq3WB2xQZhl+goYmU4jCoejLoQcN6du65jDBRJdHwT7hm8k/X5f1Ipyaj9?=
 =?us-ascii?Q?HBALr5xP2+g6M0ItiTUPLtg4ZHxJeWE36vfyOooYYnb2YAPiLj4hJUOUG374?=
 =?us-ascii?Q?N9TyRvfzj4zq/J3amqk+isaxs5X7b3yGaviXU+k2+aEV02ROfblOMB1WlDEh?=
 =?us-ascii?Q?hOOv/zwCAhMNj0V+f77EPoJF+5EHYPFshAbGCiQRCx15Zxp4bEMxn+/D5iG3?=
 =?us-ascii?Q?ibe/IeE0BnPnYSqnphwS11d1OhChu9j4mkpE1T8bYgMWdq/kLW7TazABchKk?=
 =?us-ascii?Q?3QcpcG/A6dnwv2aujd344sFWbjoqfp77aIZZm6SBU1Vkh9xTumNaMxjbRBLC?=
 =?us-ascii?Q?MNRtdbvURYEec1ZqcIojLhM/BElKrCXM2Xch/O33Ig5iWEWTgebfnnZXxMRD?=
 =?us-ascii?Q?0Wcp/HFzCLTmwXe3sjCv1cLODjtBufce6RLaToDxPRQtBel7Up35wexbyQMC?=
 =?us-ascii?Q?j8tWvWQcVw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: HQfw9oF2d/w4rlRJ5kRJ+VoLtBy8/ZQny4EbvNi6ZDOZnhbsk3ylEerViotMvj4XNABSTrzB0E9suNiwwGKsUAxRLXKE7+0I2zQg7YdmnmdL395pYgXFtaOPIupG4zwaREIkfwVMKQhh4meUkS/d5AmbI71LPFkjAlnl1vu6XghZNcFd+A3UZZsaAUZu1OTA3lFEm5Z5vwARJDn0F6j7Yoz+ZGUwJDt2at2SjiqMh2JfLt5K1IpdfrLTUy9krZIaDUMdu5i25UHwouBjYrCAO2ROhvVNPqXq57tfZyjRub5rIx28Ssx4Mq6uRyKE8hw8qetk8NGxV3eoCtCyiLOIaQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6422.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 625f3466-a0c6-4c97-223b-08df2307b78b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 17:40:16.0850 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ysNGfRiwZWaZvxmftM/bA+7rjDp0NAW9AWCwpoAohWR1lPaKO7LQwvRMhz8Lf/cuT5Quqg1YawhA9pXY2DpfXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6834
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
> From: Paul Greenwalt <paul.greenwalt@intel.com>
> Sent: Friday, September 4, 2026 3:37 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Greenwalt, Paul <paul.greenwalt@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>
> Subject: [PATCH iwl-next v3 1/3] idpf: clear drvdata in idpf_decfg_device=
()
>=20
> pci_set_drvdata(pdev, adapter) is set as the last step of idpf_cfg_device=
(), but
> its inverse, idpf_decfg_device(), does not clear it. idpf_remove() open-c=
odes
> the clear right after calling idpf_decfg_device(), so the two functions a=
re not
> true opposites of each other.
>=20
> Move the pci_set_drvdata(pdev, NULL) into idpf_decfg_device() so the
> set/clear pairing lives in one place, and drop the now-redundant explicit=
 clear
> from idpf_remove(). idpf_decfg_device() is also called from idpf_probe()'=
s
> err_init_wq unwind path, which did not previously clear drvdata at all; i=
t now
> does too, closing that window for consistency with the rest of the teardo=
wn
> path. This has no observable effect: the driver core already clears drvda=
ta via
> dev_set_drvdata() when a probe function returns an error, under
> device_lock(), before any consumer of drvdata can observe a stale pointer=
.
>=20
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> ---

Tested-by: Samuel Salin <Samuel.salin@intel.com>
