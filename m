Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8136606A31F
	for <intel-wired-lan@archiver.kernel.org>; Mon, 26 Oct 2026 22:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=ngg9CFI1;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=M4hxijaa
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C6C0B605EF;
	Mon, 26 Oct 2026 22:10:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aRTmvNrYkPd8; Mon, 26 Oct 2026 22:10:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3FBDD606CF
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793052630;
	b=PMF1hvoPOnG6PPz4Vja+DPnMI/KN8tdM6JU4cf26c34p2Bo5f8W3dSj3I/8E89Fw2LUt
	 MaD/P7fP5XPIGUR5oxzt+KaE02gDdQd1RLW5t6csos9epRRptq3htNAldg4Mj1Ob8zkTK
	 yLQM6f9z6ZjX21XnYWKt85qIbKqDZixd5zOTalfkG80H4ujaaolpSviKepQjNQ/p41Rtq
	 LET5TOeK5gquwU7ifaIb3d9Jvr+SxwvDweBofFHvHzSsrg+Pb+cHI5fv+Vkt+BCYkTbw6
	 Bvio1aV+XaC/NyysY549aTjnG3Tl+mQ8b2Hq2SyB5x6qwCG9xcwoOlFi0IfMgr07geA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793052630;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:Received:Received:
	 From:To:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
	 In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
	 X-MS-TNEF-Correlator:x-ms-publictraffictype:
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
	bh=0sXESsr/DILuUt9jn98EN1zEvdqmg9pXiJkRlyPowjM=;
	b=TdCMhonu3MywAVUktx/kAYKzwaDO1Y5IffNBRqTFgEMq5Nvlc5ahig7AAkrQNpZvPiyQ
	 UOnEw3pIzeIskytXCLWovNc7b30XWikp2KyUqv3W/X9gqhnvQKYlHelVh9OUZRix7M/qi
	 ZAW98eG1USdSwc5xkOCVAlG+uxy8D+ioeCszr9s6+tUNncjo+paESEYZNifOYZ/qXtqRX
	 rimk8ZQ0BHOtAoKCq9Wca/8FMMbKJCeJrHhL4iBuipGHn7FkzRmW1+bxslIUzwZfyc/8U
	 WkPunyyVT0PbJOAS8ipPFqxqeJmFMebAaxFcdO5lvS35G2TXozyHnFVES7tVxpkNhDQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793052630;
	bh=0sXESsr/DILuUt9jn98EN1zEvdqmg9pXiJkRlyPowjM=;
	h=From:To:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ngg9CFI139oYQfohU4eYgpSJQha0U2oRVhmMwhbWfmTAG3P+Ag/frl9hHce1D2z3x
	 AeJndGMFldhvJof4B53Vnp6Zv0WhMP8xKMHyNxvQlZQndpT9VNcEF84EYT+9OZDPDv
	 gLnOKJ0SckRMSWtzUN87RizumnwCe1FebTX9molH0+oVzxyVTVuONSWIirWKhtmCmH
	 vNdE350zvi6spSVhCV8y2m6QN2QVDBwoWCbNHlgNXQ0yqCaA3Ru7FNjSVlI5QZGing
	 ydo+fBrg7SIlM+5HDfc68WUyd2xbOQQnp1b2FP6pgkuhiG0hld/7Q7b3x/4hqK+tr5
	 7iqew4EFr25HA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3FBDD606CF;
	Mon, 26 Oct 2026 22:10:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id AF0104BC
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 22:10:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9544E40611
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 22:10:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J5K-vsiXdxjL for <intel-wired-lan@lists.osuosl.org>;
 Mon, 26 Oct 2026 22:10:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DC9084060A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.8
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793052628;
 b=nN4ZrsI+5PMTxqO+9zXd+D8Qr4hPkOvMwBDpedKrzmpaKHcwbKY8Wc7F3D96nitdayN3
 7J1HAW1hjyI2+6BBgmqMAlAro2AXQWrU4bN89LsXkFNjBYMhRdY5IZ1SPiewZcokkN9mm
 BcAnYggRRnoTfz4rPqOCnlwJWXPj7cHyy9nyZirdf32+u9gk9CR+MepX0fUB49lxucXpa
 l0ZJhXmuMffQ5/m+BvQbxxDJ62u+IPI4np1o2ZYEx3wNbnDPgTpqjB/MyRm7+TvJ4blCn
 iDRw1B0Yn9B5Q+5MPJI9KIA/EwT/KvgCU2nCTvajehSzUDZAFBR84MbU6tvzmggHAuA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793052628;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:From:To:Subject:Thread-Topic:Thread-Index:
 Date:Message-ID:References:In-Reply-To:Accept-Language:
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
 bh=0sXESsr/DILuUt9jn98EN1zEvdqmg9pXiJkRlyPowjM=;
 b=pipWFyWSByLPLLl/fPFUDNPciMD5yncHpbRKh2IhgxvlVJo0gKfh25EtHyCb39KW79r/
 yk3rjSrzLrOo/6ALhdA82kUb2sfbmXRvXccF4ju/ykrsocMgKyHk0U23Y+CgVvFYX8LMs
 BonOlu9aGW/vuq5B0PK96bzJwWzC6detvH/82P+vmyIl7oiwXoTztrdtdtuiLd+X18T/b
 AAbeOgeE/IJJRIJk9BoQ6sNnHVAXycSXfu31cLDQ+3rIbknys6CyLRoeo424Rh1KWdKw+
 e3IFKHmQ+FygRN8D6dcwZEO2Ql00SCrjLABfut1xQhclrB0RvzxyAH6Rv/4OnMbs6pA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=M4hxijaa; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.8
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.8;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=M4hxijaa
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DC9084060A
 for <intel-wired-lan@osuosl.org>; Mon, 26 Oct 2026 22:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793052628; x=1824588628;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=6WrO6JIthLhL33Q0jD7INe33aZ4/Ya9m4GAT31t6mSk=;
 b=M4hxijaafc6v9hRimLcq4KdY2AFesm0aBsel5CUBA59YXSiIEL282rPn
 CDOTpZsLsc99h0yzAxm8Yv9Rxhn9onvnkDz738YlNmiE+yR8kgyoJ3Zjj
 vtDqGqzc9zaGg3fvyZU9/ZA6RbN439As3QH24TTCpFQ/VRZr3qIAAsD/j
 b1xMakDf0yB8/H+OVACF51CUNeN/LPrA66L0/UsLkmBUTwClDziVJ6+j5
 fixCEDrM0mhKhfBUo3nIkTiAv4Z7gpZnL0q4eO2ZehqwU5wahZODF6tZz
 WtLsLzu/Snz24Tn19EQwI/bZHxeFlB4L4robaP5Xm7dxjFltwKBpYd9/7 w==;
X-CSE-ConnectionGUID: 08PuFRkaTF+riVFXbGNxxg==
X-CSE-MsgGUID: WClYm1mFQ9SL05hrtKWfJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1634250"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1634250"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2026 15:10:22 -0700
X-CSE-ConnectionGUID: OeVCtk1KTOCqjkgPzD79nQ==
X-CSE-MsgGUID: eJT9Ic8nSSaH/CO7e+8VXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="6133787"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2026 15:10:22 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 15:10:21 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 26 Oct 2026 15:10:21 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.67)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 15:10:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ukb3qTP8HxmbEkOwyGd/GUnfAokA+SAU2U0UmZeQJ0skKVIqX5Z2uqy10ogoF7VpKNzL1lAUn4xlUkDoiJztTdUbrO+g7FchJJ8lphmXJPbN7oF5pYMGBe9iLDQTxzyFG5Kt6nmf0SbnwEOr5mxiJiQWN4PyN4M3bX9GxISyk5Hylu9xQEd8ElIi3yIT92wsVYN8uC37dEA3WS8AD7M0OGStaCSMtneIp7oeKKd99RAqllIK80jYP+Y/CV4vU/1jySZYeE94ip8VDmUGAl1UmNTbPuM45nu/TCU3QlpQQJIL0apMreth2ESEz/soId6uxgy7spRQZB8PV9Mm43xFNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0sXESsr/DILuUt9jn98EN1zEvdqmg9pXiJkRlyPowjM=;
 b=ha7ptF3ao0SZi3jBgl2uIzYN2UV+fYDMomqAV2yhPdp/kfSVxhpxm9dHm3CxR/LDmL5P6IgReogY27w/qPrQSjCnnjx5zm9bcetrnZ7fBAy9BCvW7OGw5Pn5ENdT3HiFobd04hUyTgbyD5ywNT0AhR2Q4+BZzCsVHJjoj+4CCpCjb9t3R/gYBBicISSlFxb/Ucp9KgXqonlLfiO7c/n+suLvq7URftqBJrDqbWwL4kXjCwmHgrA4tpRTNJf+CHLWYgTBEauBiQ0SaE8KRD7KEuQQ/nh/pLdtinMnKuZkjKAbs2VNz2dup/E2C7KE9Dbg/w7l5LenCUpkE7iksK9wzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 (2603:10b6:610:34d::22) by LY0PR11MB123582.namprd11.prod.outlook.com
 (2603:10b6:404:226::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 22:10:08 +0000
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584]) by CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584%7]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 22:10:08 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Sasha Neftin <sashaneftin@gmail.com>, "intel-wired-lan@osuosl.org"
 <intel-wired-lan@osuosl.org>
Subject: RE: [iwl-next, v1] igc: remove redundant igc_hw.h include from
 igc_main.c
Thread-Topic: [iwl-next, v1] igc: remove redundant igc_hw.h include from
 igc_main.c
Thread-Index: AQHdXzITMjpA31oHtUmbGjlSEgmJUbcQbxIA
Date: Mon, 26 Oct 2026 22:10:08 +0000
Message-ID: <CH3PR11MB56689598D8863CCA41D427B7FBE5612@CH3PR11MB566895.namprd11.prod.outlook.com>
References: <20261018185352.46199-1-sashaneftin@gmail.com>
In-Reply-To: <20261018185352.46199-1-sashaneftin@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB566895:EE_|LY0PR11MB123582:EE_
x-ms-office365-filtering-correlation-id: 39952c89-0256-454b-e907-08df33ade568
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|261022075727099003|261026140227099003|38070700021|11063799006|56012099006|261021123027099003|261022105027099003|261009223027099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: DEwR2riFeIjzUGFhRWxDjPZWnrhiv4K1NBjvv9aJ12qC628JL2r2SvY9/7/hd6BOOpO6/oVYVnipu779pu12FLt7Y0St3OxzW+6OY472T5Wa+7Eefl1KPAI7Bzjt/CVDlb/FP45CbzoivaRh3oQ0WCjFP0mm1YiUU3hHTuJbalE4voZt5vbXDdHrFtVe6ZzWXYmZH1XLFhnCiisSk5BTj9xiAvNserr/BbaNZKZ0e2Bv1jJ1HCRHrZlnQgvgSW//CP5xaLX49rX8newAynTwDpBsh9nJOtJzZsHNzUUu0xUaqW5wtOv0cx/tWrW+PEQSEmi8KkdY7vovp4aV/YnKhvFNYGJEp5prB8B+abLfbgrN95ibaVNZvIyGOu7q/exHFD4oaij0nCR65nZb91pmhEwExDwfGqlchfu0OpGH1eBMErOf8s2Z0SfgKXpJvvByCmakCSfEWOgx/fy72m0LCDKu7Fq+EVYsxhXYzW4rgeHCjnbotlL/M8LDIQFiPR2UJcCggMfdGkw0nBtQim6KtOQBC63+0jDP0StV+FNLoufsJi+q5n32yD6g36fyPoIhEb4LzFYzfcZGRV98Ww0Altq5B6x6QAva1/ZOGXtHSmka4jbQ47GRMZOvYxhhLgqlbvAiDOqPxuyHWsVKTSMm+O4qaSlLiwHubdKAvQ4z2hf23NpGt/34y+wb6dSlx5NnBsPeB9v68ZohxeQacVDKsg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB566895.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(261022075727099003)(261026140227099003)(38070700021)(11063799006)(56012099006)(261021123027099003)(261022105027099003)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?x3VJXSr1K+RBu8R733+9gk5mfbzQe7pYUZ1XXbAL67RM3GH+LQMrWx+esFzi?=
 =?us-ascii?Q?Uxbsg/cJ4CH/Rz9fkuRnljSXPXkoPnwXlePkIfRNxHopodyyuNqsW7EeOaVc?=
 =?us-ascii?Q?GysSCi9Jtd+rXaWsr3u1GFa1LZPFYx0AR0erjAwL1rlFo/60FVz/cQLjb8iM?=
 =?us-ascii?Q?ZEfYoEJpaaxFPS9XG51ouJ+jTsXbKMMEfis81VltHAaunRjVbMxp97/Rjz3I?=
 =?us-ascii?Q?/B5jr+8wLsf2AiIcdaUqA8B/AEGpwD9xK47zDRuJMVlXmWZLnLqT6+igkb50?=
 =?us-ascii?Q?ehWhedeYnOrAYG1s3eszNQC571RlzKIhKT3B21rOYfVme/l2i4jRX2Z/jRva?=
 =?us-ascii?Q?iJbJ0JwH8z+wtdQ4qwr3/TIekMOGclywVw6msiJ+Yf7n820HarWkhQ1ITZv5?=
 =?us-ascii?Q?Kuv3gm1674KLoP8dWQumn6AfF6tSANeUd7vp7CMbpodFJhub3mDFRYx8fgyi?=
 =?us-ascii?Q?EG+mUXo9oBVtJ7i0/KKo8Yxi5/FHKRrKLEk8FIukwysDIVLi9vQy17ujdKh/?=
 =?us-ascii?Q?wCweEwG7es2CzylMCEC1VIkfAIoa6eVPQyk2FWZr5x7FOi+MHm0Gm5lK50yf?=
 =?us-ascii?Q?86tcS11RREalY4kNIlFgPRULqf/w0Pp7yhoGTIBrULId0bAJ0sM8huPrtJjh?=
 =?us-ascii?Q?hdTNSCoKYA3h/c3+YEbl8NI6XPSbehcZUvg9YwYD6amRdEXjbpWOWS9+/CQv?=
 =?us-ascii?Q?lfdJnH6zJ+EzK+fYICC15CTDNf7R84osEPF4NOgWBKMTNm1SeVO9wAqXMxwJ?=
 =?us-ascii?Q?bxF9qpfeVRopwJkX7+lDTDWT+vtKVqU9hkGn2av1YmOsVZEbgTpUf3uRnUo0?=
 =?us-ascii?Q?yD+N2ULRY4CsydF9GOFI/+nmoJjLnrUQF+JwAQVG2ygT+YcFZiz4KCmSAZEv?=
 =?us-ascii?Q?DYak5wfFHJrDtnWBQu/RVvbdyKJZG2hoGR2l4QnamybqXfFN6lfNBneWkmVm?=
 =?us-ascii?Q?6IUj2czZx788uQoqv2cmSvyjoItWWQkhzUS5c3UVPmu2/B+6di3Laj2G7jsj?=
 =?us-ascii?Q?TtwaPlIBLjPkasqJ1h/boF4zj+W1j+Inh0eQRX97DHl40Yq4hfXTxCOAQYju?=
 =?us-ascii?Q?jNddKw+DsvRgYHx147aTZvp2Dc/WLWKpQiUMr2kE45geekIEGLXkUVl3srfZ?=
 =?us-ascii?Q?1Jul0aF1eHZIJ4LfxFZNKzQUh6N7l4N1FuXC3I2wxFBXCV7TK6FGPE66SRaC?=
 =?us-ascii?Q?PskBiDyZJQYy12pqENBb3uQ7Ofo+Nb17o+vVrf+zWQwOT/efCbGxXmT3dgVn?=
 =?us-ascii?Q?sIaf0ReX5IrCZio4LP4YIZORteAwJW1EcqFqWY3LAdp5ydzJlmZKsD38xR56?=
 =?us-ascii?Q?ndH7Xs/fSZM3TpkxrPdC4EWCwtYWhz/SXYFIOPPuQywPiMNA8B72jRq8nTR6?=
 =?us-ascii?Q?rhpjMramiEoLJ3VeYIqUEHUZprIjqj29NstQLKvKcpUva8KUbkoW4wFVqOGD?=
 =?us-ascii?Q?8H4+eJpI+hkTPqJuRRhK3J64VzRhCqIOJyM9X8U06Cs4GIKXmnzn38o0kmEg?=
 =?us-ascii?Q?vVYYL27IWbe4la+Mhevo4+K4EAOke20HslK8CV+xh5O2wn4WMjuT31jhMbOR?=
 =?us-ascii?Q?/wIDqyFZONuHdvKFISRI6D9qh5l/dQG67GdGdcUJ4VGVlMDOr+NX/0oRaPcc?=
 =?us-ascii?Q?t0y16GlBBFYwWfhAB3lrapmzyelgPwWuCV+31rUzV+wLKv1DpdsUXxo8k0b/?=
 =?us-ascii?Q?hjElkgZE8aDUKTrDzZt5RLOxm9I7Cc1w4BX6NC8RfYrY+Fc/NscV9G6hgPgt?=
 =?us-ascii?Q?DDmJ83DAYb6zpGEQQL4TES/78HZU+Ls=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: AnqGgSvdUrJI3/rf/Rr+mQmBy0P0JxrT4QO4lJpPgJf5fdRagN47wsS1oCwiaiZVAEYPdzcl6gOfofBU4oTgLp+4+gaFOjIqTrsdg6E1RjGgTYwcRpktOK/pm2gP5MBBbj/VKMlqJhkX9dGNVO6dpJj18IfaGeqog16VbaIgjoeX+PWqRmU2wVNFxk8DmTmQR26Ro6JBP5+NLxZJ470wZhFlbiggBbVZc1YnIz5ARs5Pbkw5mRwFqLarIRcjnMF2ml94bXjI0chsZO+5jXIQpTtzazIq0dT9HhmNr1vUlEYWUq0Dhg3MKjUtYJ62BU+qCN6yk/SSUO7fmgjutBxWJQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB566895.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39952c89-0256-454b-e907-08df33ade568
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2026 22:10:08.0618 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1jlZahFp/p0pt94HdkIrOTe/D6hs/ODRa+9Z64EKvqldutyulPvCxB12LdTiZBGByVznh2/yiqItJVolgQ5EfffvwyrIwIbvg2Y2rUC/oDw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LY0PR11MB123582
X-OriginatorOrg: intel.com
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



> -----Original Message-----
> From: Sasha Neftin <sashaneftin@gmail.com>
> Sent: Sunday, October 18, 2026 8:54 PM
> To: intel-wired-lan@osuosl.org
> Subject: [iwl-next, v1] igc: remove redundant igc_hw.h include from
> igc_main.c
>=20
> igc.h already includes igc_hw.h, so the explicit include in igc_main.c
> is redundant. Drop it.
>=20
> No functional change.
>=20
> Signed-off-by: Sasha Neftin <sashaneftin@gmail.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c
> b/drivers/net/ethernet/intel/igc/igc_main.c
> index 3b7dd104d8d9..208840a5bb78 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -17,7 +17,6 @@
>  #include <net/ipv6.h>
>=20
>  #include "igc.h"
> -#include "igc_hw.h"
>  #include "igc_tsn.h"
>  #include "igc_xdp.h"
>=20
> --
> 2.53.0


Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
