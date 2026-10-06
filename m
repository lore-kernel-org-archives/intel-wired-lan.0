Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E7B5CA5FFE
	for <intel-wired-lan@archiver.kernel.org>; Tue,  6 Oct 2026 01:38:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B27D240600;
	Tue,  6 Oct 2026 01:38:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uv7TKIql5Yca; Tue,  6 Oct 2026 01:38:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4DE19405F0
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791250721;
	b=Jtwj80t2+6yWmuYj10aQh9Z+P9ultnah9/sjWVtiBkFMazMILrabwn3Uj6tyqQGytwLL
	 PqBM34SVnApdcEzmWze3Xl8T4VNAUJ47+dLrfcEkmp1VeFfKwWNWjnEqEcNnbCiOjDKqq
	 fJRnfMWCkNuRU+DXBDSKFmWbClTttpJqcx2Rb2QKPZy2HAwYD1JiD9bctAlD20KDjGIjI
	 XVyO4j63aTkHEsCl6TZtSllRHmq+GGX2IBVawZZk79xs2l498yZ+0rCJJWkTy04TzbTxs
	 FwEBeauaYeRAaMMfRHNbmWWY5oCXoUuazgKwUULZSjpYfPHAe/lvApjuHpmM3stoJUA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791250721;
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
	bh=ZbQEQh37ek7azwa58KSRtcupvLfwYA50KrdSP8M7y7U=;
	b=Vge1uEMXacFIbKAlZsmoZDL26pF+Fr+JPZEWO7p+rmTlhk39WNgWXc19CdJIebtEpAOe
	 FXLk4gOMnrYl3Iq9I3P9FTLqP2mXJZFqZnxFcswdwZf1cEGyrPXQRmfEK5NXMtRlP656D
	 OwEXdtF5AtQVw9jgb5KdY5o13krosi9Cj4KBiItx2FdKHttd6QsyQCM6edCQywKtahJYx
	 uXRZuOBWzQCz7KBr/ljjAnE90rXan7rCc1kC1+dS0JGdJHMEy57jmsUxDVr1wLi42fLN/
	 U88Y1mHFXBGcAEdInzQ8vnPR5VLYaccqssuYzoRiDzk4ypqe7VMQ+xVPjBoyeeF4vLg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791250721;
	bh=ZbQEQh37ek7azwa58KSRtcupvLfwYA50KrdSP8M7y7U=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pMMAwoEQffLixWXd9f8C2wRoBkp2eU9czCk3iSsp0iFMZMMz/SxzhVTK3C0y44ykU
	 jPmegrgnVAP2nM7ce/WZxGqL80KIuEArdoEzRBXCUg/ybBoUpL+pfEU/nGxDZRGN1W
	 kLN20voUJNRSvCQ/+fc1FWVzfyN8LaueVK6oC6v4cWsb7/UxV+GrvBkd3GepR2fQ3s
	 wx0ntS0urUEaHCHRuA04UWg33ETqzY8F03kmadw9+KbbG40zCaAqHQmz5wSd65H8Fz
	 dY+xC4RYrGp/1VJe0tfAUqsrd6KYwkp5jvqj0a/BuQewqy1PtSuS4lf7hCqvJL01dT
	 krwdAIBk++eOw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4DE19405F0;
	Tue,  6 Oct 2026 01:38:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A507C1D2
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 01:36:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8A9786073C
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 01:36:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pLetwlCddKmW for <intel-wired-lan@lists.osuosl.org>;
 Tue,  6 Oct 2026 01:36:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C881A605F9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.9
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791250602;
 b=TM+gIjCHyS61fvA10N6DILspukuKN62m3C14WuJcb1XuL/Jpwdq5+hvHNEqLe/gN3LBg
 xbHipetMC9inY3LG2nJBhey0A6fcDdLAbiP+GX7N2NMjWvo8ZkO4aH1boyNO1AHzRB2OD
 bajxiyiL5uOAKQ2k1w6g4v7WNpx049EbQTKyG2Matuj7nKb97MDfhOUiWl+T1vL4h4+LJ
 IVrByzm/bOghhMIVeHdPw263Knx++JKG05AB5z75/y3iyGvNolsON7zksArCtGKXkazUI
 3oaCMPzbUsO6I4NDpA+YYU436rS6QuXvQSi9OjZuJmLlboFLLERmtwm9RrynIapaLCQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791250602;
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
 bh=ZbQEQh37ek7azwa58KSRtcupvLfwYA50KrdSP8M7y7U=;
 b=fvau9nQ33GA5gaeKRtJANA+c7O6wiU7tL+rYjM6w9UdFFST8zoWEuepOmqlrBEzYBJOB
 b7TvGg/i6IAfElc9tWQzdLo80fPMskTc61R1uWb3HIA0Ub+iGX3P7iahxNGHZ0uMkoEuD
 TVIUyTn7tkR2sK2fXKjhW6a2bLZCb15FTCgEweyIxJ/49J7/YkpQAntlLmDuQcd5zX+ZR
 WyF65KNSLapXxk0w4AeTP+ndSSbqr7J2l1+jfWyfzSAOufctQGa8q3qEcOsTEZhrbjcof
 1NnzdjAPxa19W/cE9fbEMreoRfoAsGpx8VxxMLNunxQ/3pWMzfOVVuR7w5fFgwxJYUw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=W5RhIH1F; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.9
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.9;
 helo=mgamail.intel.com; envelope-from=alexander.nowlin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=W5RhIH1F
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C881A605F9
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 01:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791250601; x=1822786601;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ZbQEQh37ek7azwa58KSRtcupvLfwYA50KrdSP8M7y7U=;
 b=W5RhIH1Fc9WPDWE/ETNMFFJb2So6RLTegxSI4mjuPC23As7SiSEMRIil
 YYPPSIL+XPEfC+PZ18FBLSiBRZMXCHUgeGY9XdLcQVf9Kioh8okUQMTQu
 yHpilJghg4PTTecGycQrXhfOABUe6XQWf1zkeoPyDFRuWqRTb7dJ25hN6
 XlCA/vyqSGVpJbwGHSxvgCH1CK0u0FJqXiAXmUh85m4q+h2P+RUBygTRo
 ycakQQGX3Qh4GTKu901IjSoPd2DzRFcWIFs2JaMW9VRz+6pAZ7l8bhM9Q
 CPVcP8LjZW7OC0hi05bhUBtcRbCcHhkWxgiirbPe37B8YI2y6RdTJD7h4 w==;
X-CSE-ConnectionGUID: KdvSUrLzRcGYd42zyn9UBw==
X-CSE-MsgGUID: jxCTkfTYSAC4hmFihwHGYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="113716144"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="113716144"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 18:36:39 -0700
X-CSE-ConnectionGUID: WzL27z1GRgmLO0ZLWJVvAg==
X-CSE-MsgGUID: jlJhybFMQKuibPgXJ6/V+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="1045742"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 18:36:40 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 18:36:39 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 18:36:39 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.45) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 18:36:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TMHK3XltxfBJhSqgLUifhw9wbmDe4kRBBzgkKuogzWb9FATX5hbnFGh0cG9FiBDFcTPgBB1mS0vb/jiomYz7B85LY2THZTWnw0LWNO5CrIVSU3SmKjf1k7YuQUEXezbzU2iXFhi8J0u65kfuoYALfCIhCjxU2yEJVZ/FVVsotgKZIqcNaDUI/2hXsI0WoBmG8iEciD1b5pjN88UUxiGv80fq2yv0rL6K1azQzXW+Vy6LotQrjaNw1c6zBrkAiaZaNTXQ8TY68YdRblnzHz9tfAgYqj1nuaeajBMvQSpi4adYIJ9wYL2x84aY6P3LjD/+mDHOZZZslfaaQWoEpp/jDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZbQEQh37ek7azwa58KSRtcupvLfwYA50KrdSP8M7y7U=;
 b=lA1iFAJo+PtPxdSoYiJ8f71BahQPJkhppQFGlAyL6hOGiMt2eZQrxHfexKzwmwOtCLzAOWTwb19rfb0DbhU9KD+kEwfuchz2wvDiRs2ayTCKAUExeDUrePqC30swwgRTSjoKILD6X9g2bF2jI8tkCVZcuxau7MOcvAduo5X36+j11v8DhJI5fu6d6Frhs1fBmgHdyk+rd135lqXrlPpALGGwHgY6yCSf2BxONhqF4v56DN4dG1JTEKDJKXWvCxZp7B3ooDbv6zmDYal3gS4VWkjy+ZVHQBmEfG55L0Iwuj271lt0Pc0+xWZuATFlp39BiGBBc09uMt5ev1cBbsbL6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by MW5PR11MB5907.namprd11.prod.outlook.com (2603:10b6:303:1a1::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 01:36:34 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 01:36:34 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, Intel Wired LAN
 <intel-wired-lan@lists.osuosl.org>, "Machnikowski, Maciej"
 <maciej.machnikowski@intel.com>, "Keller, Jacob E"
 <jacob.e.keller@intel.com>, "Korba, Przemyslaw" <przemyslaw.korba@intel.com>, 
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Nitka, Grzegorz"
 <grzegorz.nitka@intel.com>, "Kubalewski, Arkadiusz"
 <arkadiusz.kubalewski@intel.com>
CC: "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: RE: [PATCH iwl-net v3 01/15] ice: fix removal of PTP timestamp
 tracker during reset
Thread-Topic: [PATCH iwl-net v3 01/15] ice: fix removal of PTP timestamp
 tracker during reset
Thread-Index: AQHdTUnFeyBpQ62SfkmY7YXdsqqPIbbvy2mA
Date: Tue, 6 Oct 2026 01:36:34 +0000
Message-ID: <LV1PR11MB8790B8CF074570452F69C0AC90952@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-0-6532598e8da8@intel.com>
 <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-1-6532598e8da8@intel.com>
In-Reply-To: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-1-6532598e8da8@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|MW5PR11MB5907:EE_
x-ms-office365-filtering-correlation-id: 32b12a4d-4fdf-4527-cfc5-08df234a4178
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|6133799003|22082099003|18002099003|10067099003|921020|38070700021|4143699003|56012099006|11063799006;
x-microsoft-antispam-message-info: yEO6gNpas7Q//A20thJHsUdzXGFMSNv4S5LxFMZYJxU0VLYOEnEfBl92HIdeC4BFs//8/igoPdc/hK3ewiTtOMKbHJQa+pRwvRRZ3iXz5JbeUA++/B97ddVxReFTLvtfWZqNDkiE9izobU/a2nDeHP2mcfpGjcT82ZedrolBdnERoFAwPauwyxPkC6C90GjsznAxtXC+J9omNfIyftjPqwqiwysRPgsCNVHfPBYym2lAJg1hFeS+kzijo/1X8D+u1QRK5CAqu71VAYGSDzhqfSBH8WVHF+JtIl7E8ItPyZTpxh+y1EdIhhXHtQp095ffqePXVLxk1iSuFG6DUa/QcR2Kbj8nPtbzjZGO7UhcZWjntsVtTfTlRU98yL0HfSrwXUZH0DHyHqSslAtvvt5nS1cSDl7taNwGZwNyohUytkJFLBlsHgmz1T/hSzz7l3ikMyj7ZcOqe0cv/k4zsmQ5Ds0jUr9/naze48d4gZP9iPRMFBnEZXjX+sz975P1LJubcLo+y0KGkDaVGV/M+qv0/cqQzZfSz+TqsNdt2YfibzmJECTIqTDbmXOimS6sLNTzOqsQqo+Kv7c6mm2RdVbbYfNODypkqFdjcJABn+ZTWqWjb8KNI9Yez4BmXrQYo1BnDGF7srlW3+G93Z4RBIgA74seeHQbQjuecD00RxI3LxW2v0timemwpekTCVVFlTAR
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV1PR11MB8790.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(921020)(38070700021)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0ZzbmxVSUpZeWoxTVlkS2FNeWpsN3ROWkM5SXgvQTZDR0dZR1VidE9NeUFq?=
 =?utf-8?B?UllldEgrekhkZFU5U2hRZVRBbmJSNERPQWZUK1ljcXhmdDVXWU5VT2FIU2Rz?=
 =?utf-8?B?NkdvR1NCZDhqVitVWStpRWFRK01FN1BZMnZwQjBlemh3eG9YWkxGNVl6M0VZ?=
 =?utf-8?B?emRBZTNtTjVGdFhaS2tmbHZFenFLNnVGRkV5dG5PRFVzeW12T3Y3UEcvUGRT?=
 =?utf-8?B?YjFkOU41MzIwa0l2NkdwOThUeHg4Y0VMWXVibUQ5ZTRocVp3WGdESTRjS3F5?=
 =?utf-8?B?K0NCME8zVnY1YkhiY3c1YURVN1NoMjRHQWhaeG5ENWdyR0hmeU1NTGlvWWZQ?=
 =?utf-8?B?VDVFeXlSZUVFZ040RHBNUVFrc2NEL20xcU5vU1djNHMyS1hIS1pONUFkOU5u?=
 =?utf-8?B?WksyRFFlZE1pRFB0OUlyQWl0ZTZwcVgxWG9tZ0VuRDd0bElMUVgyY1VVNnZX?=
 =?utf-8?B?Z2wzUlNTaEhaK0loQlNUbGxtK2tIQWhvelNsNFBzTkVIdTY3YkJ0SjJWczlp?=
 =?utf-8?B?eFZEVTIrWkhlZVhVc2gwQXRLd2F4a2plZDYwNWk5UXhDK0xxV3FmdTRYMUhX?=
 =?utf-8?B?OW5MdlMrK0cwSmZqbUpnZjRBeEpwWXJEVW0wV3ZFKzhTUXJGeHF2TmdscWdU?=
 =?utf-8?B?V3MzS1ZJVXJjTjJQaHl2QmJsZERrN0RnbGdSNWVYV0oweEVEaGZhbkdxYkhq?=
 =?utf-8?B?Zm85RHowNUZ5bTJaVWJOQmU2dFRzcU1tUEh4SEFaOUhyTDdLT1FCbXJKUFhS?=
 =?utf-8?B?NTVpZjdMY0UxbmdXSUJRYXRoWHhUcXFmcjRaUGNpdWFOSExJY2RveC9TckIz?=
 =?utf-8?B?NWtZdzVrMmliMlZWS2JuazhEWUFVNHpFLzA5dld1LzJtRHJwZTdPVHd6UStl?=
 =?utf-8?B?RGYzSXVVY1JBbzBZSHJUY3BZTUg2UUpxcmY1cUdqdk51NHp0ZkZSNG5NZitJ?=
 =?utf-8?B?eVBWaEZHWi9oNUZ4bUxjcWc0aVdIQm80ZjlhNWxHV3d1MWovSWM0STJYVEFN?=
 =?utf-8?B?bUhtZFZMOFpncW1pY080WGZ2RVpzbTFjckE5VzZMdDVTNTNzSmpzdjhuQWNu?=
 =?utf-8?B?YUQrUmRhSHQ3SmZ1enRUTXdycDZoT05kdXltdm9xa0V6RmhNeWc2SmF6SHhW?=
 =?utf-8?B?aHhZM0x5UEZycmV3Mng2b0Z4bWNVWkpWbmNjN0EzU1dwK1FiSU1YMEp5RlFv?=
 =?utf-8?B?YWV5NFUvZ2x1MXlkSmQ1VmRFd1VGSWUzREJvOC9kMFVHVS81cGVhMXpXTmtx?=
 =?utf-8?B?bnlaSENUWStiSldLZnA1SUo1V0FsMTE4OFpvY1FNTmcvTFltWWl6YVMrOGgr?=
 =?utf-8?B?L3pUUmNPNWFxRmg3WHFQSEF5MkdSSlNzdklPMEhVeERSS2Y0NFJKMGhKSEU4?=
 =?utf-8?B?dEsrRzRmSlNBY1RDN001VFhLTHpCR3g5RGxTb1VpN3N0VXYwaTVhNU5PYm4y?=
 =?utf-8?B?MHBBUCs0VlNjck1iczBWSXgranpIM1F5RHZycGdjMTBvL2lTUXZ2M2d3WHhw?=
 =?utf-8?B?U2xaOE5qRXRKZkFwU2hacWFYSHZPV2FvbGRFVGFnek5GMFRRcndFSy83U0V4?=
 =?utf-8?B?NXJVdmVXOWtER2VCT1lvUFdBa1k0V2J3bjcvRVk5ZW5DNG95ZXlwcEFDSGUy?=
 =?utf-8?B?d1VOREpVMEd6ZU1Dc1o5Q0paOG8yUjVwUU8wc1dCNHJWdko1TnppYVRPU2p2?=
 =?utf-8?B?bXVrczM1elYvWlMyN0NKcDFKZlNMaEs1N3B0aWxEd2UxRkZ3YWZSeStJanFH?=
 =?utf-8?B?Wm9STW4wNVhGeWJyOW01dUNidnFXaEVoaWxlVisxMi9henhEWklhV3F2TTJG?=
 =?utf-8?B?WE1JY1lxMEhySTJ0dHRHSkFhVU4rRTlic1JQWUd4blh1dWk5T3VCdUY4NTc4?=
 =?utf-8?B?MGNFcHBVRHErMDA2YVVuaEF5NW00Q29TWmFYZkl1T1lybTZIWnEyVzVBdU85?=
 =?utf-8?B?dE5yOHdUU1AxendNQWtJR2k0K2ZvWHhyWFBneDBCemtBUExXUEU1Y0F6V2R3?=
 =?utf-8?B?dldYM1U5Yy91bGxTZmY3ZDAreGM4dHc5eVZjUVYyNEZycE5oMXJyTEZabDZx?=
 =?utf-8?B?WTltTVFESlErMEhXNWZDNkY2em5wbDR2SFptc2xkRjZFV1J0TGhQNzlXenF2?=
 =?utf-8?B?QSs3aS9vZFZwK0N4NzJlS0dCSlpnSEZPaFl0NllBeXRPa0hSZEZKZkIxOVJJ?=
 =?utf-8?B?S0dmMDVLaVUvNU8yZjlQSjZBRE83dVJlckNWeXRaTkpBcWROTTQ3MXFYWGdL?=
 =?utf-8?B?UWtYT051QVMrbUZ6TlBJSDlKMzRKVytrbFdjeHJwaDNrWjd0NmtZNGUxOC9X?=
 =?utf-8?B?Y2JkQ3daQ1NvY2lhUTg1dFBid2Y3WlkxWFdlcU5lUmRERElCS2o2UT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: GeIkURO5tNq/fNRcp2mE7n/NhT8+aluEBiW8m9eISxgXA1EOixLPJyEc/LSPzm2o9gfifJc2fDduimK+rD+8nKTDCVL10X0ZmtW93NyV6Li21Ew25ZBc3XhdsOh2C3ih/z4QVO7J9niYNCk1oKk20Mk/pJ/aqzUi3rBnqoXBIWxufwkHp3zlCZM2pOFQOa4uCq4+6xXpT4OvdXDChqdE+I0bvL7dpmGB1vv5DDWy58Vi4sCE3mRKp99qv8c7k6IiQbqlhtphmxB8DzOiUqtsgKxb7z0UbfuLd+XOVcvRsTUv0sRH/S+UhLtCtRgsHa6IZk2K+P7Rb1QWU3nXv98JTA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32b12a4d-4fdf-4527-cfc5-08df234a4178
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2026 01:36:34.1314 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tJ4YK4jScJkWFib11kuppnkgQxyCfv2c/cL/ksFL7dtCzLP8PQcslhIWdteIxVfMt/HZWOF2mJ1cN0T0BVR9+FZw6wrGljVXP7f7uU9vq8k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5907
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
QGludGVsLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIGl3bC1uZXQgdjMgMDEvMTVdIGljZTogZml4
IHJlbW92YWwgb2YgUFRQIHRpbWVzdGFtcCB0cmFja2VyIGR1cmluZyByZXNldA0KPiANCj4gQ29t
bWl0IDdhMjVmZTVjZDVmYiAoImljZTogc3RvcCBkZXN0cm95aW5nIGFuZCByZWluaXRhbGl6aW5n
IFR4IHRyYWNrZXIgZHVyaW5nIHJlc2V0IikgaW50ZW5kZWQgdG8gbW9kaWZ5IHRoZSBQVFAgcmVz
ZXQgZmxvdyBvZiB0aGUgZHJpdmVyIHNvIHRoYXQgaXQgc3RvcHBlZCBjYWxsaW5nIGljZV9wdHBf
cmVzZXRfdHhfdHJhY2tlcigpIGR1cmluZyB0ZWFyZG93biBhbmQgc3RvcHBlZCBjYWxsaW5nIGlj
ZV9wdHBfaW5pdF90eF8qKCkgZHVyaW5nIHJlYnVpbGQuDQo+IA0KPiBVbmZvcnR1bmF0ZWx5LCB0
aGUgY29tbWl0IG9ubHkgcmVtb3ZlZCB0aGUgY2FsbHMgdG8gaWNlX3B0cF9pbml0X3R4XyooKS4N
Cj4gVGhpcyBmaXhlZCBhIG1lbW9yeSBsZWFrIGluIFBGIHJlc2V0LiBIb3dldmVyLCBub3cgYSBD
T1JFLCBHTE9CQUwsIG9yIEVNUCByZXNldCB3aWxsIGxlYXZlIHRoZSBkZXZpY2UgdW5hYmxlIHRv
IGluaXRpYXRlIFR4IHRpbWVzdGFtcCByZXF1ZXN0cyBpbmRlZmluaXRlbHkuDQo+IA0KPiBJbiBw
cmFjdGljZSB0aGUgQ09SRSBhbmQgR0xPQkFMIHJlc2V0cyByYXJlbHkgaGFwcGVuIGluIHByb2R1
Y3Rpb24gZW52aXJvbm1lbnRzLCB3aGlsZSBFTVAgcmVzZXRzIGhhcHBlbiBhZnRlciBhIGZpcm13
YXJlIHVwZGF0ZSB0aGF0IGlzIG9mdGVuIGZvbGxvd2VkIGJ5IGEgcGxhdGZvcm0gcmVib290LiBU
aGlzIGV4cGxhaW5zIHdoeSB0aGlzIGhhcyBub3QgYmVlbiBjYXVnaHQgdW50aWwgbm93LiBIb3dl
dmVyLCBpdCBpcyB0cml2aWFsIHRvIHZlcmlmeSBieSB0cmlnZ2VyaW5nIHRoZSByZXNldCBmcm9t
IHVzZXJzcGFjZSB2aWEgZXRodG9vbC4gRm9yIGljZSB0aGUgZm9sbG93aW5nIGNvbW1hbmQgd2ls
bCB0cmlnZ2VyIGEgR0xPQkFMDQo+IHJlc2V0Og0KPiANCj4gICAkIGV0aHRvb2wgLS1yZXNldCBl
bm84MzAzbnAwIGlycS1zaGFyZWQgZG1hLXNoYXJlZCBmaWx0ZXItc2hhcmVkIFwNCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIG9mZmxvYWQtc2hhcmVkIHJhbS1zaGFyZWQgbWFjLXNo
YXJlZCBwaHktc2hhcmVkDQo+IA0KPiBSZW1vdmUgdGhlIGNhbGwgb2YgaWNlX3B0cF9yZWxlYXNl
X3R4X3RyYWNrZXIoKSBmcm9tIGljZV9wdHBfcHJlcGFyZV9mb3JfcmVzZXQoKSwgdG8ga2VlcCB0
aGUgdHJhY2tlciBtZW1vcnkgaW4gcGxhY2Ugc28gdGhhdCB0aW1lc3RhbXBpbmcgY2FuIHJlc3Vt
ZSBhZnRlciBhIHJlc2V0Lg0KPiANCj4gRHVyaW5nIHJldmlldyBvZiBhIHByZXZpb3VzIHZlcnNp
b24gb2YgdGhpcyBjaGFuZ2UsIHNhc2hpa28gcG9pbnRlZCBvdXQgdGhhdCB0aGUgdGVhcmRvd24g
Zmxvd3MgZm9yIGljZV9wdHBfaW5pdCgpIGFuZCBpY2VfcHRwX3JlbGVhc2UoKSBjb3VsZCBwb3Rl
bnRpYWxseSBsZWFrIHRoZSBQVFAgdGltZXN0YW1wIHRyYWNrZXIuDQo+IA0KPiBGaXggaWNlX3B0
cF9pbml0KCkgc28gdGhhdCBpdCBhbGxvY2F0ZXMgdGhlIHRyYWNrZXIgYmVmb3JlIGFkZGluZyB0
aGUgcG9ydCB0byB0aGUgcG9ydCBsaXN0LCBhbmQgcHJvcGVybHkgY2FsbHMgaWNlX3B0cF9yZWxl
YXNlX3R4X3RyYWNrZXIoKSBhcyBwYXJ0IG9mIGl0cyBjbGVhbnVwIG9uIGVycm9yLiBFbnN1cmUg
dGhlIHBzX2xvY2sgbXV0ZXggaXNuJ3QgZGVzdHJveWVkIHVudGlsIHRoZSBQRiBoYXMgYmVlbiBj
bGVhcmVkIGZyb20gdGhlIHBvcnQgbGlzdC4NCj4gDQo+IEZpeCBpY2VfcHRwX3JlbGVhc2UoKSBz
byB0aGF0IGl0IGhhbmRsZXMgdGhlIGNsZWFudXAgaWYgUFRQIGlzIGluIHRoZSBlcnJvciBzdGF0
ZSBieSBjYW5jZWxsaW5nIHRoZSBrd29ya2VyIGl0ZW1zIGFuZCByZWxlYXNpbmcgdGhlIFR4IHRy
YWNrZXIgYXMgYXBwcm9wcmlhdGUuDQo+IA0KPiBUaGlzIHdhcyBmb3VuZCBieSBTYXNoaWtvIHJl
dmlldyBkdXJpbmcgZmVlZGJhY2sgZm9yIGFuIHVucmVsYXRlZCBjaGFuZ2UsIGFuZCBpdGVyYXRl
ZCBiYXNlZCBvbiBmdXJ0aGVyIGZlZWRiYWNrIGZyb20gU2FzaGlrbyBhZnRlciB0aGUgaW5pdGlh
bCBmaXggdG8gcmVtb3ZlIHRoZSBjYWxsIHRvIGljZV9wdHBfcmVsZWFzZV90eF90cmFja2VyKCk7
DQo+IA0KPiBDbG9zZXM6IGh0dHBzOi8vc2FzaGlrby5kZXYvIy9wYXRjaHNldC8yMDI2MDgyMS1q
ay1lODI1Yy1taW5pbWl6ZWQtZml4ZXMtdjEtMC05ZDA3MzFlYjQ4NTglNDBpbnRlbC5jb20/cGFy
dD04DQo+IENsb3NlczogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbmV0ZGV2LzIwMjYwOTE2MDEx
MjEzLjE2MzIyODYtMS1rdWJhQGtlcm5lbC5vcmcvDQo+IEZpeGVzOiA3YTI1ZmU1Y2Q1ZmIgKCJp
Y2U6IHN0b3AgZGVzdHJveWluZyBhbmQgcmVpbml0YWxpemluZyBUeCB0cmFja2VyIGR1cmluZyBy
ZXNldCIpDQo+IFNpZ25lZC1vZmYtYnk6IEphY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50
ZWwuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfcHRw
LmMgfCAzMSArKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgMjAgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pDQoNClRlc3RlZC1ieTogQWxleGFu
ZGVyIE5vd2xpbiA8YWxleGFuZGVyLm5vd2xpbkBpbnRlbC5jb20+DQo=
