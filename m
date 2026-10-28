Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E6E606A329
	for <intel-wired-lan@archiver.kernel.org>; Wed, 28 Oct 2026 18:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=yT4T342K;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=K7fBaWBI
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2E36840A9A;
	Wed, 28 Oct 2026 18:33:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cMfOSZzXJFYD; Wed, 28 Oct 2026 18:33:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 56ABE41922
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793212350;
	b=ZKOk+/O/lC6sCsrcJ4HCOEhQd6Y4zNf0KYZmjk01KOzMms1nTYU/gDGfzSBKgWk2datN
	 2RRSJ7REq5jypzcSZya85q/CKy5qnfnH4WShqa1gYYBhP+3qPebAtFk8xAtt8S+dE9oZR
	 33e0TKGGTaWy1TJw/tGHkPaiI6zAcUR/TyASG9pB8ovX/TVUk02N17yfJFl4UEKlVPxGr
	 6WhL4ONjAmM2T/sNSrbhL9bfszSgFY04rYZcIa62bPFoWJR27qG/zDJbsIbjVZQTq+R0g
	 S92iHc7EVJTJnCsI8sMOjB9LPw6l5+d1ffi33pP63LBoUDkJvQ8R4TyLWiQnOd7RbwA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793212350;
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
	bh=KCNE2POEWKIGax9H9ogWdo8P5YF+/3Dhj4Jakf6oBdM=;
	b=LAWWFvIN2lzz48E8LmjUDSxMRwDXhJ/dnDrLtwlYKxvU85qInoGYMigOTsidQGcrbOAR
	 GCaXVMpIzJgw5I0j3iWQrgboLpqSw4hI9Y0pLT53LIrwLtPB6XxxZpnk4Mo3UIHxrS3P8
	 mx7UcHyJVubCjf5bbP+LlS2oRNwG0zKw1X5NiMExoBRJE8jFtxQiiibTUVaEOxhKtaQ70
	 a4/+oDsEC5bFuIzqd9qXSsS0j4EPxRnzwTD8+ZYfH0c2i/xFiS0RJHQ8ZBVOtHU36iWV9
	 1TfVuBIBGOiwOELV9UGH7leROp7y+JMB6UIBo2jdNF/P1IRi1BhRwbEXiFi6jG11RzQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793212350;
	bh=KCNE2POEWKIGax9H9ogWdo8P5YF+/3Dhj4Jakf6oBdM=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yT4T342KmbYlczk/Ny0MlAUsD2iun24yY77ITL/hlk43UfWUXb6YHUTym49IYTjtV
	 /cs7amKra6+D2P+wHGKPG3RWjsbg5h/Ya2psXt0Nzz2e+ze633rKee7fW//QyGGAVj
	 JY3ZTVFgcBchF6QUy1FHgGCvYCf35KGdN/e2laGTmXMOxNPLSPmMmM5tcyrY0ik8lP
	 X8/Mxr722u3DBXdNUWkavef+WvdrlvcNJC2BZ7fld14T010keEA4bU3EYV8/OZGLOm
	 F49mqb46X3Py7sl4YgeN5+pfq7ghsp0vwhlG3KQ54mPDOwKPdJfPam75N3wiHy7fX/
	 bD+PWnnbtqiXg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 56ABE41922;
	Wed, 28 Oct 2026 18:32:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7932F529
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Oct 2026 18:32:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5939A40725
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Oct 2026 18:32:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kMBUmtf2r037 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 28 Oct 2026 18:32:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 33B95403E0
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.17
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793212347;
 b=C1SP42udODKQhn3dHA8A8dnOEdkf1SaVetvrwn6N6RvdmPhc5nm61NayMRBVNn+4Gfvq
 gUwRI5kkxZ+oWiFJbmabkW23h5canTkKcPumAQk4UqM/WJSGYgnFcENwQ6muYaimFfzrF
 F9bAG/M93dKSWO4ns11AwKjFybg2IzXzx/goDSOlq/Y1ai2FmKeoFYXOfshYrrXXCTzqB
 d2nGERwKjMsr3KJx9F8omGGtQuCtFPqORjYNre6fkhuI1PURvkbNM5FybnfmKw/0PdO+t
 Tn3Chl5Zezu6uM5T1W/zgyqjAWH/fbhO48nUbGqLP4OYZjNTnMfna3t096WPrpTaEzA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793212347;
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
 bh=KCNE2POEWKIGax9H9ogWdo8P5YF+/3Dhj4Jakf6oBdM=;
 b=qBgumW/3lN9yFbcFXgCTk+Mukk8BIum/aUibHqkxuCxICbaB6mKUsVjYdt/UIzyyebNH
 gLRyiphT+JFyuGt8tvBOUBlpqPoQgKMWPSv4v9dBxQFYrRAEPHgS/9pCs+e46riguxzJJ
 NUGxmweCDdYNs1EhQ3s8UyRTujVvQHfqBcn9IuIUfxQ61AvlaCNvudYrDL2Ic7XPzr54A
 lS61xjLccLqz3w+Uv+AmnzjYhVeoCt4vzAyzPJIxmfnat8G4qj/Ls9tDpPGDyNW7qLIcv
 axnG5AzGtRH2gp69uIEuMCO4usG8lw6vG4PFkk6aq288Ff4i6/0QurFiH0Lp0WX08dQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=K7fBaWBI; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.17
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.17;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=K7fBaWBI
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 33B95403E0
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Oct 2026 18:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793212347; x=1824748347;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ZdeVNkTEcRlSUY02aeUY6ynNMvMyvh77HyZ8z6qPG7c=;
 b=K7fBaWBI2uGIUFg24rbnx7Ev8jk/C8ZxmsRDxoNsRcI0eYIyEug+I1yL
 jyTF/t1qoDM47Y6ftvvm0HlwxDPyeJDIeF6Rpx6RkaqqZN2se2pWrgr1u
 lnNhI5Kfl0T9ymR2SGj44dfOLFMN1TKVepKAywUfiCObofY81Ib/eidyS
 6pRTY3RYT4iasN+sffomAiDKwlo2nPCNXSYwwdGuNZsZhd299E8yG4muK
 lSnm53ujUKSEr3n2gsq9MIunOSswrg6TcaAGC2sUV0A2OHStxLTqhdRfV
 x8Es7jpV7lyLayNCIWHrYpI0MqM2tZmc/kW2arxza2kIjK+vMQIgb8+xh A==;
X-CSE-ConnectionGUID: IAcYIYwoQhaw1/1A8LZKTw==
X-CSE-MsgGUID: SxOrTGSSRLmUeaKRSzsykQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1959386"
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="1959386"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2026 11:32:26 -0700
X-CSE-ConnectionGUID: YER+YfgPShWUScNiRHy3ww==
X-CSE-MsgGUID: dHt1uNXESF693RGzrhTSKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="6682889"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2026 11:32:26 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 28 Oct 2026 11:32:25 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 28 Oct 2026 11:32:25 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.71) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 28 Oct 2026 11:32:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nigTHlsFm+5Dt431lJul954rOmV0ESZkqiK692b7WEFbtb46sSikCI9W9ZlDC41WC/J42Eg40y+fM46rEd1mlP52DCL+idRVL7zs+Ngm+keKdW1K8LQ0d2BTp59UQWUCvton00eoS9htQd7Ei3c+ZUgzR+2VJWfZzylD7TF93FL6m9EoAOrvtidZDEAETmsSag+VxIy8iYwhAo5SFvS4OIHZ8Vt2yd85XFZ/v4QHaADPh25KuyW9QU78d5N7coMlHZTzyhacMWyFnnUvCm2qN3Ydg8SEpa+a+OJ5LipIOctgXaWVAw6NLSq2EC0s7gPoGTkQwW4ITvbd+wpIuaRJCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KCNE2POEWKIGax9H9ogWdo8P5YF+/3Dhj4Jakf6oBdM=;
 b=NPB+B5JASi0+ylER9cs+umISC1TIF8kRqN3n59aFk31GiAXt9ZHtL8cGDwYoDajDNF8NLJXlH/SkTh7auQa44AnLKTlB9n2CPg+WNV9a1VntqtwJkfIm/2Ls/LrltS/IyJ/MTl02v1HXwhpxcbW+jCLjZKBapm1oer9T4FFhTQGqfueV5ePkPAsgG0BmmIxCawQEVNNFYKJ7nYlFfwzus8mdHVo63c5qzS4J15wo0yL7IiH3ZAcmQ5uFloEYCPgETjH8E+Dl/HY1MFoN20FKPNhkn3ObeloBWd12JgN3VGTeH1wSwV00M3TdI4L33bG2LbMbZUZY3BEtduxkC0TzQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 (2603:10b6:610:34d::22) by IA4PR11MB9395.namprd11.prod.outlook.com
 (2603:10b6:208:55f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 18:32:22 +0000
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584]) by CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584%7]) with mapi id 15.21.0569.007; Wed, 28 Oct 2026
 18:32:22 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Linkui Xiao <xiaolinkui@126.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@kernel.org" <edumazet@kernel.org>, "kuba@kernel.org"
 <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linkui Xiao
 <xiaolinkui@kylinos.cn>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH net 2/5] e1000e: do not cache the hwtstamp config before
 it is applied
Thread-Topic: [PATCH net 2/5] e1000e: do not cache the hwtstamp config before
 it is applied
Thread-Index: AQHdZruLRSZYTrtwcUOvkRugQlvGEbcTR8sg
Date: Wed, 28 Oct 2026 18:32:22 +0000
Message-ID: <CH3PR11MB566895BB8161C896AFE24A0B7AE56F2@CH3PR11MB566895.namprd11.prod.outlook.com>
References: <20261028090455.2291659-1-xiaolinkui@126.com>
In-Reply-To: <20261028090455.2291659-1-xiaolinkui@126.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB566895:EE_|IA4PR11MB9395:EE_
x-ms-office365-filtering-correlation-id: d6fe669f-0566-4f91-44be-08df3521ce59
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|23010399003|6133799003|22082099003|18002099003|921020|56012099006|11063799006|261026121527099003|261026140227099003|261021123027099003|10067099003|261022105027099003|261021121427099003|261022075727099003|261009223027099003|261028144727099003|38070700021;
x-microsoft-antispam-message-info: o4ho07AFuYiAB0sCsHEQvJ+d2jsaOTuMA1q7D1h2kh1SICE2a+3ice8DOhMaoo+Z7SWy5tskpL+njsxEnt2YoO5fxt5yf6wzPCcCMUyX7EiOIABPO3W4OZgJVkBnChcfGdNXhYPEe4V/1LNPLrp9x5e0BibhbLZts4xdsJ4gcCATVsHAztKCfTFRpfLr3UdOcnb58Y3/j4uUMk1Q1Y34dUIr6tSR0ptv89bQcDnUwcCkez5imlZcnQ/wW3b2UHhDqIBaOGwWgX8EPjcom5YXcZHiIinDIKiDvnUaEZ9Q2lCDtrRi6qUGm2gN23DgNz+2tx8TpJaAeo+IxAMLfjMiLJTWS6O9zkZu5fJjOSC3Rhb3YaRRXwrUlzBPx8/ft3YBQoDhKTc1z049BQ2gvcNpJtGzs637YHcA8dJsgrbqCfMAYleOfwQfFLaiumakvBCBzUc19In/Ny8ygsrI8C54W7TfgYtAOVEzsegAkSmUrk7g61mq7JMO3s8Fmr9lZDZoXmCC7sTAgPTfjtDBlWf8lqtIZKGLUw+lXF5qwpzVZOzPmNsiGPvNysUF0PBLqm9gpnjeW+SMeuVfk5fXl+K12RwR3ynDaf4cOFRLrHiOImOaycqiF4ammxFZDmZJnVHif5xmvmUcc90Z+DMtj9ffIEaHTZPKnMNYtm1xFp6Em6Unz4/hrc9Pe+5cjTzaPt2/FVwsAoRyyKhx2nhd/34jvXLfBepUT2CiT79dj8lDfJJPc3qo9yFVLX+oAs/L1+Au
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB566895.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(6133799003)(22082099003)(18002099003)(921020)(56012099006)(11063799006)(261026121527099003)(261026140227099003)(261021123027099003)(10067099003)(261022105027099003)(261021121427099003)(261022075727099003)(261009223027099003)(261028144727099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?m08/vvgH2NpK8Yy8XHMvZfjqhymTMpYaw6jkeakIbdvbaNfIVXNXfUJcDRpR?=
 =?us-ascii?Q?3hO/2Z+8dYEGS9GxaOAw34a7M/Pb+BHbypwxxaa4g32HCgOJAsnC1iwohhZl?=
 =?us-ascii?Q?wNS2vxdm7ul6cY8qNwlvb/mVfIXmSBHNx02YSOIaTdVccB/maKLGsFv7XHSQ?=
 =?us-ascii?Q?+xin6heNFkfadmpdhpqTeVsHSzxy60F3N01WSEvp+c36Tlg4khHsrX3Qyunz?=
 =?us-ascii?Q?Wbn7jEsvueG8y1SZ+EjE663nep7rpmkYsPWCXa227XpmQU0c8xOYeyKD5Xfz?=
 =?us-ascii?Q?oswGSslfMA9ROX+ur9Zr1iPFyng/48SlYpt/45ncUtqyfoBFJbIoOe4FwmI7?=
 =?us-ascii?Q?Gt9QY9jGp905apVtdSrqlV9oJj+dysi9VRCR34z3PC1qQPtHWbVCO5tIwZYO?=
 =?us-ascii?Q?SZ3AWRfxf8iR9yAmnUEzEaPhqy4wUZE8EggqG+QZtev20mEicOxdR3/xGfmE?=
 =?us-ascii?Q?/DOmQsmUFP09wn+nFiXasv410G3vY284eR7aoWOAUYnh2DBA95EkQryGG1Q0?=
 =?us-ascii?Q?kU0aroZFRqcBAeR6dc0ApJtvh3sLWLuyX9APpgETfa+wMPnYXVLW8U6fkVVY?=
 =?us-ascii?Q?quXrrKCHdtCXX3QT0mnA7eT7Vf6JdHAvH6plQZTCNtQph0DFAqduhje3icVd?=
 =?us-ascii?Q?fckTdGjQ2QmHmyxtgk9yUnRtJxLpQD8WtII/9BZ3ZlQEy2BBUVUm7dfa7lFO?=
 =?us-ascii?Q?f1jNxSFrv1S3CMLiH0NU2LnoSuFu26hGMeeiLcMCPRThAyDSGODbmOInmfDr?=
 =?us-ascii?Q?5l8euP0a9qiiBspbZsrU5BPdAW6hvac6ISOBTWNdF+4ZHVx0SA3V0NG6qvYD?=
 =?us-ascii?Q?QvFGxF4Z3FssC/lWoB1fxFAVZpo1mtriz1vK4e4L2ZCu2ov4nI+Ys3QU4xAJ?=
 =?us-ascii?Q?TNBuQQeOQ7iNVsXr3F8uD43Zt1VZ+/Dp4A0/sI1OXRf5EwbeXF+eNpg19ASo?=
 =?us-ascii?Q?V2TTTbTlRqNK/FXZcRTJ+uw6w9j97Tc6JL1u0lwp5vXRDW/Fe2xougsu3cbc?=
 =?us-ascii?Q?cDRb1YtfHb588G8hCeAX8MSXFV8zyc/yulQf0iQAvDc5O1qScThWviC4cxje?=
 =?us-ascii?Q?hhlkOVZzj0auYpf7BXOVoD/TtU5kbftvwMK2p05jlhpS+Ji07hjkHmA+HNLG?=
 =?us-ascii?Q?wmpNi84aQWtORaNr8VInNsuyEOAcf3iZrDpQVp0OXkIsWTdJEsipszAqRvYN?=
 =?us-ascii?Q?ZDBBr7JtAbRYWL9sOZqxpDXzdITgC/FX98yC002dLNNxVwp/JpvPBoWJJr7M?=
 =?us-ascii?Q?HQ1LgcuvuWVVWouTFkDo4HObl3juN2v98wuX+aI8ObRhf2UpDh/3r/1beR11?=
 =?us-ascii?Q?UrnRe5uZJbsd7X8xGj5e0LYo6fnfq4HH4qxR7yVgYtyjHTZan6ik8vYV5GF1?=
 =?us-ascii?Q?68Ihs6uyvue+YUdPqvLRCHcSWZAuw3wbIzV2Kw8oiMaeHtQxKLLQ0h+mSuYt?=
 =?us-ascii?Q?5mnuWXmlPIM68IrfJtaiT3a2dQe/5IKWtKqm5o1G57qu6fGezOlZDA8fWwJb?=
 =?us-ascii?Q?WgZvDrf0zkU78C01Xgt8y/2Rw09/wtrHEDr2zUmuhJwmWdD2r7J0gA9+4Cul?=
 =?us-ascii?Q?gSu42FpnEFNR1tGsFGIAtc42vQ1c4WpRFuU9j7C06+5rzFMznulOqKxCtnrm?=
 =?us-ascii?Q?JHr/6r7cSfPmqBZqH+CJ0cFqUjkBP5EgvXVSVXMIUhM/xcppkoMUS+f9yBVg?=
 =?us-ascii?Q?9XdqRTzIHPrLCUNS273s/lyVmaZcKeNeXFL+MsQyL0VYHxkmTLXhANKrqQSK?=
 =?us-ascii?Q?xxlksAsf1gOIvlXlU5qlpahu2i5wVhc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: jvdtUx4K06zBIVeg63Q2JBb3g72kQZ+hzruDw2FGXaQMw/tiohKiOmTkteQaqYYpyAlOy/lFo/dl7R3cf0JEkwgppPPMSlmO2GThfBnMFl65TIdm+DEitKso4D64er34DIlhOD3nj+M6S1ZEYUJc8MWGXjD3jzc/B0AQW9t5nN+hQdYvNbPEqFVuJvfn/qtrD1Jk5JYEZ+fG/O/ld9GigYy67JKVSJhrpp+asPURYQunyPkOapeDPaZdicJx0VwDkwUwgw81dkjNqCoxYyB9wkIqzhg0kc9oHTVhqfVnSuHFpfpvQ5QKfZ+f4ELDOQ51q66cG0uwng4OUhfCKj6Ojg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB566895.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6fe669f-0566-4f91-44be-08df3521ce59
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 18:32:22.1469 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UJ8oPKvAiqOdAQr3ueaV+41CcfkN+NR2gMcAdknxsPOQwQtVG63PR4AQNcAD9nOdS/t82zACpTMpsBdVoyX5l8t2GFVo7a7bMvDwy7AkLl0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9395
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



> -----Original Message-----
> From: Linkui Xiao <xiaolinkui@126.com>
> Sent: Wednesday, October 28, 2026 10:05 AM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@kernel.org; kuba@kernel.org;
> pabeni@redhat.com
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; Linkui Xiao <xiaolinkui@kylinos.cn>;
> stable@vger.kernel.org
> Subject: [PATCH net 2/5] e1000e: do not cache the hwtstamp config before
> it is applied
>=20
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
>=20
> e1000e_config_hwtstamp() stores the requested configuration in
> adapter->hwtstamp_config right after the rx filter has been
> translated, but the two register writes that follow are verified by
> reading the registers back and each of them can fail with -EAGAIN.
>=20
> When one of them does, the driver is left holding a configuration the
> hardware never accepted:
>=20
>  - e1000e_hwtstamp_get() hands it back to user space, so an
>    application that reads the configuration back is told that
>    hardware time stamping is in effect while it is not;
>=20
>  - e1000e_systim_reset() re-applies it after every reset, including
>    the ones the watchdog triggers, and keeps failing;
>=20
>  - e1000_watchdog() starts polling TSYNCRXCTL_VALID for the cached rx
>    filter, and e1000_xmit_frame() still parks skbs that ask for a Tx
>    time stamp because it only looks at FLAG_HAS_HW_TIMESTAMP, so they
>    are eventually dropped by e1000e_tx_hwtstamp_work() with a
>    "clearing Tx timestamp hang" warning.
>=20
> Cache the configuration only once both registers have been verified, so
> that adapter->hwtstamp_config always describes what the hardware is
> programmed with.
>=20
> Fixes: 62d7e3a2d006 ("e1000e: Validate hwtstamp_config completely before
> applying it")
> Cc: stable@vger.kernel.org
> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c
> b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 35f5590228eb..7ae33273734f 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -3715,8 +3715,6 @@ static int e1000e_config_hwtstamp(struct
> e1000_adapter *adapter,
>  		return -ERANGE;
>  	}
>=20
> -	adapter->hwtstamp_config =3D *config;
> -
>  	/* enable/disable Tx h/w time stamping */
>  	regval =3D er32(TSYNCTXCTL);
>  	regval &=3D ~E1000_TSYNCTXCTL_ENABLED;
> @@ -3763,6 +3761,8 @@ static int e1000e_config_hwtstamp(struct
> e1000_adapter *adapter,
>  	er32(RXSTMPH);
>  	er32(TXSTMPH);
>=20
> +	adapter->hwtstamp_config =3D *config;
> +
>  	return 0;
>  }
>=20
> --
> 2.25.1

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
