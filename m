Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56985CA5FFE
	for <intel-wired-lan@archiver.kernel.org>; Tue,  6 Oct 2026 01:44:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 235C6406D2;
	Tue,  6 Oct 2026 01:44:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A3fsdDjq_MUr; Tue,  6 Oct 2026 01:44:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E313B40681
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791251069;
	b=HcEjP63E2wGH84Shv3zpyyeG2v8s34awmZ0XHg/aWKC/YqORgOExH2V+vfoW9vjzCRY6
	 F8UUlT8GoTsDXaqXkQ/wW6W0Hc81JmwjFkfsl3VTfUwFJYToR/XIU7L/VJu+EfWG8csha
	 QL/AAOyZH48TYGgPWT+mhZbzsOF5SyqaRqbA8MB2CgQfcQE4ombD8CohB59aDUryiWDk8
	 d8zkNxp4wubYr1yaWjucOsn7figul9H/qL0xc4nGn2O26jbeuqORZGclTMYzMxzBRpYjw
	 Dkp1vzeIQPOdVSLagnwpaKXFU9khU0nQA9lRljdwHXqQ/yxzZQJWUQGnrF3YnFnujBw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791251069;
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
	bh=9iAzkHlQ+cTjP8CkBhYOuhmN0dxO5E3rFsc0TTWpUno=;
	b=mFQoAJxwbJPfq8LBw9F4tBw63QLVYYEYLBR8qVMoZcu1SfkNGnub+hNrfmDPy+TvpsMo
	 DKNnSSbGwBLu4G+0ciY4Rxq4uK9Nk6YR4+L0AIzteeceKIi7lW+TBxawzs3nUVuCbVJr3
	 +ASbWkXMCC64XCdjJWIgyaUUUjTUhzIdfIChvv2c+JrUh2R5V0rThnnTeDzYFkTtvNKUx
	 ehaupHuWA9Q0sRDUvDEPx38ssTeCpb7nV0aNCtMxv4uSAvBMLRhO/M5D9Bto+SidbbfEL
	 BO5Dv+uLJWJjXR2iuJGtSCPkWpLOM9pmB+CqrWcOSeVSGp7Zm/9NMNCdAUmCYFYI8TQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gCDKpnxH;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791251068;
	bh=9iAzkHlQ+cTjP8CkBhYOuhmN0dxO5E3rFsc0TTWpUno=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WhtCd6eT/eTe2l2T5kB3NV3ngvR241GehKiXrcQjISS4DwNACcnT2CvwqAiRPIEwA
	 1YI6DJsPQJQCwagvnnklIu+2tj4fb0LzZ6AWZgMxV5iwz+DmAsbR92j49OcmtJuNd0
	 wgQI0BZO32XIhaZXBrQ5ySkpKWCRPXR2avSrgiK0WH8Jc1DFgEH+urkB9Vgizh7QLL
	 HRg+ds/flyg8xSPW+3RdLqfilE50+Xocutd+5vuEiFN56XQFnJcNA7TVFvp7TUCKiw
	 4CqE2+Ssrj1yw2NnnLtg8Db4tuZSEFN+bdoIv45NVyTjC/NzcCxIgHoxFSjym9lHj2
	 lFyOJaeFsUsVQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E313B40681;
	Tue,  6 Oct 2026 01:44:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 88A6E1D2
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 01:42:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7A1E7402E6
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 01:42:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PXBT0KcEmb4G for <intel-wired-lan@lists.osuosl.org>;
 Tue,  6 Oct 2026 01:42:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9DF60402B3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791250955;
 b=ruW3B53gbdBT2blJLttlIJPgCPW2iwA8FHvKWK6HyZkDAExgucmPkxK4Y2xALnWCwBMv
 aQr1HGrzbWoDvZuvKtinrwDKXaKUW/s1/uyNg5HJ8CF3yb/0vJP5/Td83hjCfKLiCEXqG
 m3XlAbuDUzveyhYs5AXSio4R7Do6nESVXbX0xe6xC8PPPX/upanKnAgEEER708oDBcIIZ
 Cpstt0kS8UQCHZU9xvxbPkQU6Lc+FP3qkQL6/DMrDr+EY4Kc3CCKMKiqCaeo46bnRGiiu
 FGW5d8wDXGwTWZ02OsH1w6msBHAdrlK3KlQYcnC8VbMTOBY1uDP8AcUE5KBh/OTFZ6g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791250955;
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
 bh=9iAzkHlQ+cTjP8CkBhYOuhmN0dxO5E3rFsc0TTWpUno=;
 b=UQq4JBqIK/Q0u2D0SNQQgvyr47Zpb9s7iP2HV+qpWFDhy38j86ziJWjaSDLSMI/8XRKH
 CoaMUw1c3HogpHllBEps3pZGx+arAWfBKxiToX+wSkrGXGgm7A4/ATPQXAGENuUjuFWV/
 qaYQeF68OMKOK7vWTnCA4UbrXQ+4Tq4vmZnc3RU+guSLBpKDu074hTMTdyjJfqcQc4FvR
 wtKDFuzxTT8+TCvEFBlF2AZftz/Vb5L7tSEDFoR1yG9v0U2t+qMzjn41FUNEZEEw+rLW+
 74A0jooBSnut3riM+tNXViYiSIqf/bqe65tcLvwWaa1ambUsRgd22lg6bi7af4C3BYA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=gCDKpnxH; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.15
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.15;
 helo=mgamail.intel.com; envelope-from=alexander.nowlin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=gCDKpnxH
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9DF60402B3
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 01:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791250955; x=1822786955;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=9iAzkHlQ+cTjP8CkBhYOuhmN0dxO5E3rFsc0TTWpUno=;
 b=gCDKpnxHSPbA33NvNvjguI0IzK1oi7knE93anO9oah375T5Gkioaw5R0
 XFg9Ot05CM8QcTgTNr2ocDFau1M7Yw9LSbAoSPJgAHoDkw3Hp/vnGTAvv
 ui2Qg5kivZHnKPo4Asdn6txwoTUrlIaXW5TcBSIoQE30s6cNnQxyxyGEY
 EDmwgFhx6Go1Wzw9zmzDbHohV2AurDxSG94DIL+hyvnzwzpJ4z+f1Wfnm
 3mr6/xmmkRjPbbKW4zGgcoygxiLlkRJDet+MszZmP6yAGaf2fO06bkpa+
 9Uqy1c3OuopZmMr2uOKfl3dpcxulYrrz0dpu9w9kYn5TOJLbWm/RAwJ5g A==;
X-CSE-ConnectionGUID: JjatVCO5TtuOSI6Ij0Ggvw==
X-CSE-MsgGUID: F/X/Wxh6T1yGKWSi1xO91w==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="94642047"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="94642047"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 18:42:34 -0700
X-CSE-ConnectionGUID: JrcQZnzGThWfOlypcNyjpA==
X-CSE-MsgGUID: Tkq2vizsQdCEVB++XOidiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="276518358"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 18:42:34 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 18:42:34 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 18:42:34 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.56) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 18:42:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I5agMNqRTmIusThHALDtv3qZKqCmc5Bw1C+BXJHFGBw28mZ348BC6ZCBSuVx2UjnwyrYQUP0e4zR/+jxBzsMPGyoBqMBpbuSsnJRdRxS2+qHl+5wJRsD3Q/DC4KwJgXk/41YcXoZRzT8ejgiCjiFtFWewceHxolqqfPiPjmxZByfdYdKVVFXwp0QiitNH4WwANdNAXjFDVZev0S22D+STqf8IIYmyLHslnyH+uTXveyMXPSZ2TOY1PhrSdYceswAyc44Wfw5Dd907UWYeWaniwwNtgoOkY10HjgNkOVp4LP4Pg9+WoW8QaamQea5B27S/f7Xw7s0hCKlitZlmlhaMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9iAzkHlQ+cTjP8CkBhYOuhmN0dxO5E3rFsc0TTWpUno=;
 b=AYgt76HRwTjDuoQLPrjt9+ef6rR6mEO6DoV3ZYowaF2iNSD+pBreYtbreptYYnjGsp4tjTpJAPUKd9fLGeXVdTEVNP6YTqETA7aofp/nbRNa5zP5nuE+uZxgbYWCuV4swR9TWN3o29UYpS43aKQKY/EWB8RpNRMRhxZhy+N9mmj64JiUX6KQtWsabWEjwOyMdmEl31sO2JMhHsjOJSx05IsclkjR8D7jY/VB8rdW7UGIyN55Vo9SlO4mDprp1E2sqAkD0NlKk6X4rF4qRupzbRfkFmf6Xp4fDkIBayi6WQjVInwKRJmKQbY6a+3UKxTc1JgGm9W4S5KISM7fIWEGgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by MW5PR11MB5907.namprd11.prod.outlook.com (2603:10b6:303:1a1::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 01:42:22 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 01:42:22 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, Intel Wired LAN
 <intel-wired-lan@lists.osuosl.org>, "Machnikowski, Maciej"
 <maciej.machnikowski@intel.com>, "Keller, Jacob E"
 <jacob.e.keller@intel.com>, "Korba, Przemyslaw" <przemyslaw.korba@intel.com>, 
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Nitka, Grzegorz"
 <grzegorz.nitka@intel.com>, "Kubalewski, Arkadiusz"
 <arkadiusz.kubalewski@intel.com>
CC: "Keller, Jacob E" <jacob.e.keller@intel.com>, "Machnikowski, Maciej"
 <maciej.machnikowski@intel.com>
Subject: RE: [PATCH iwl-net v3 10/15] ice: E825: perform a soft reset when
 starting the PHY timer
Thread-Topic: [PATCH iwl-net v3 10/15] ice: E825: perform a soft reset when
 starting the PHY timer
Thread-Index: AQHdTUnHGWBxKC7LLUy76hSwUlMA97bvzS/w
Date: Tue, 6 Oct 2026 01:42:22 +0000
Message-ID: <LV1PR11MB879022706FEAE1638BC7A6D890952@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-0-6532598e8da8@intel.com>
 <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-10-6532598e8da8@intel.com>
In-Reply-To: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-10-6532598e8da8@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|MW5PR11MB5907:EE_
x-ms-office365-filtering-correlation-id: 8b927dcd-0df6-48af-acb2-08df234b10fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|6133799003|22082099003|18002099003|10067099003|921020|38070700021|4143699003|56012099006|11063799006;
x-microsoft-antispam-message-info: XE39KMn95uynRlHFE0jfdoAQ+G/xcjPYRDZeYFGsUDHK5Kz3sbFQwedIP5LpBnUwMl39wAbKiysElbi72HEfHckPDt/0sLUOGCdasW3W8nCbahYf1N/vtBV96d3geiCI9fhp9sM0ONq5WCD+SzuG04H/r415HnCv0f96xBbETOxaByD/jBUdbu8tQdWio7956DvW8RrJDXSpOwpU2xj8haaaMgc9l77GNa0ZH28UIt0vXJDvVuxXwZHV+5nnogST1t/B2aK6JmbokWA/8Ty7+O4PS/8IGbUhajf0+N3uxqU10Jng1ZbTOzQiesGmV5hsqOj+tvrxXVGhKL8aB44IKahediQabnl5P6JKithmBTQdFoz5GN6m4hPbxdUg1bI/QVRc1WregfZaqsQHkMlYUsVfsje32u5kwx/jVbwn1M5QumcHKixOaTd10ScYRK5CFh0C3L+2ey8s0DykE1Rd4UZBYC/fETRgwmrgTFhKmWY/HRmN+tqcZTsItLAe446MgbPgtMJqJ+V/WpdaCiE39vqjTRPb3TT9T5NE2ICcNXrLX3cE8M1uj/EbESCLmkw8MqI1Ub9LGsJ8uRj3hc2BQvJrLXsQH+04KnZYzbB7cQIJAwv5HQsK74soeVQz55HZ/ieXOWNffGNIUWdnWoMLKkNEh7zx3gH1XXjW1WERGCd6RUIGHW1XerNDbIRnx04yRPrR2jC8f+7XqzGJKYtF5qF79+nnp0CkaA59e0M6rUzLa7zbyS+dMidyof/MEieN
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV1PR11MB8790.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(921020)(38070700021)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dlYyOWNTWkEzZHlFa2N6RHZFNlFJcnZhOWRBaXNzelgvbVFlRjRhY0NmVkdz?=
 =?utf-8?B?cms3dTVJRlB4VzlQVHNlVzBrbkpBdWNZa0R0QStpQ3NVZXNXd1Z2MysvMEJt?=
 =?utf-8?B?bmJkSWo4bmtNSnF0ZFhSVEhWRjZPVEJmUHdhS01wZ1BsMkJ3OHZGejF1YTZP?=
 =?utf-8?B?WjlxbjRwZTUvNFRCZHlrRThCa01sYXBlU08yQUlITGwrd2FJb1ZiTG9pU255?=
 =?utf-8?B?cVNPKzd5NTFXREFZVk5xaTBhVTJmamZjZ1Z3cmhIVTF0cTNvZ2RLUUViQ09p?=
 =?utf-8?B?dFBYa2pvNnJlOGVwb0loc3BBNWFTZGRKK0dXSGVQWHljWWkwZEREZmdQWWpN?=
 =?utf-8?B?b2Y1bmdUSSs1U2ZyMzNlYzRvQkhpUDhQczJFeWRtY2lFQ2FvOGNtS0Q5TmZu?=
 =?utf-8?B?czVTaUJ1a21qalBDQi9LSG1KZS9GS1lIZ1NCRnFyWnVJUlpvSXBXbVdHN2Rz?=
 =?utf-8?B?RTlqTjAyclNiNUJIYU9mMCtJM3BMc3dpdHZJdHlSMzRmNUhYaFRma3J4Nnph?=
 =?utf-8?B?UE5zUWZkMHBBdkZpdGRRelF5bHBQOW8ydUlJMmdPb3RLTTNmQnlWV20wbVBk?=
 =?utf-8?B?Ykp3UmIxZFNnNHRFTUxlb1krWU1Ec0ZzOG9oQmZOTmR0NmZ2SXI1Mjdpdkx6?=
 =?utf-8?B?Tlh0Y0JBc25STzFBUUx0TUtrcWZlbmxXYmdReG9xaUVlbGczMDFnVklGYm5U?=
 =?utf-8?B?WE0wNVFDNnJGZ3hrUHBMVm50QXJPQlR3Wno0Q3hWV0UxdGR3VktjUWN4cUx6?=
 =?utf-8?B?OC9Zb1hKOFN2OE9hc3dGSGYxVWNKTk1WMmNITFM1SWVkRHM0OUk1c1hmWGNZ?=
 =?utf-8?B?NGpUT3hGYjFrQjJJak1rc01TUlgxVlJ1QXAxSUdYSWFUaGxKcHpXeGdRQkFu?=
 =?utf-8?B?aERCUTBMWWlkSW5KWnBLbnpibXo4dUVZQkQ1K1lwczJEWEZaWFdQL2hFZURI?=
 =?utf-8?B?MHBrRzg2dEprclB6Y1Vhb3FIa1JmY0xpYVpBMGRnVTlaVHJ4SXhNYVB4TExv?=
 =?utf-8?B?UkcxbGpscWJuTzQ5RysvV1EwbGJ3Q3A3eHQ2blJCMFBNcmZxZUVpL0orVWM0?=
 =?utf-8?B?VlJURWVKdlBHa3RXdXJNeWVId1dvVzlaaFFDcnNwNDFOL3dwam9ELzFaSlFr?=
 =?utf-8?B?cnZBWWFNbmFyN3ZOTE01dFFUUVBhSlRlNldGL0lwdVlWdk5GMThkc1QxYmpr?=
 =?utf-8?B?MzdsV2IzLzAxN3FKUWRLdkZNdHIwK0pFMkRMRTAwTEZYTHBNeHpPb3lGd2ll?=
 =?utf-8?B?NkduYlJJdk5xQzNaNFp4bmowZExxOFNFKzBpVnM0QlVJdVlJUnVUNFpCa25r?=
 =?utf-8?B?amY3VnBBV25CWnNSTFp0WnpWSkZrUmsvTTNwNnJWRUs3YjVNODFldnJSTjdy?=
 =?utf-8?B?N0xhL1dQMlBZMmJSVXVsR1E2UG5ObGdYVkppbm5hbEdHeWJ6L0cwMDFjSlF1?=
 =?utf-8?B?emlhVHlKWmNQMkpZaG43MHNUTWhXaXN2alZqWnV5NUdWNGRTVTNpZzdoVkxu?=
 =?utf-8?B?NVVVSjVSTjRmVE1yVGgxRUd6T01tWHNLQjJJSjdBUW4yMGt4WGIybzl0aUxI?=
 =?utf-8?B?bThpVXFDYmZFTllKOWxYTi9CU2RSRjdzc0ltSWVKVWhiTmdqUG5DMFBRemRI?=
 =?utf-8?B?MUVmWC9ycGdwRHljd0o5NkxKYzgvdTh6MjJOVkZRdWZDem9ONUx2TEp6ZzBu?=
 =?utf-8?B?aGRDejlMOGFYN2FpL0UzMGhkWjVxYlBDY01OTW5CSWRaR2JiN3VncVhJMEY4?=
 =?utf-8?B?L0w2VlUzbldaWDlEV0RrMFoycTVPd1FCYWowMWRPOUh6YkI3aDA4RHJQMTdm?=
 =?utf-8?B?RGZIZGs2VDJGWEI0VjZYay9QOWQ2SWwvRVphWVVjaHEyNGtlWFBpY1J4MFVm?=
 =?utf-8?B?d2lVbEhpZjVGQlNEZ0VIL2VobnNWaW5hVzZueUVoM1FiT1loYlNNSXdFYjhi?=
 =?utf-8?B?RG0wV3Z3OUxMdVdoUnBvNjIyd0tCRm9TNG9EWGN4aVhMSlMyeTJtMmN3Rm4y?=
 =?utf-8?B?ejVmNDVOMExCdnY3YzYxUklYYzh5eWsreEV2MGRhMlNrMzJ0UXZSYkgxNytk?=
 =?utf-8?B?Ulk2WThpZW9XTjZTK24ydDJiYVE1Zm1iWFQ3Tzk5djdodTBhSHhQRXlodXQv?=
 =?utf-8?B?OWZ4ZTVXVlMreWltY2F5VnVBSFE2RTNRQXhIU2xRMnorOFU5SUpOSWZGVlBO?=
 =?utf-8?B?UnlZZW9pcTJCZlBYSkIyUlVadXp6YW12QlFIUGhFNk94VW9zYlJ2Z09VSDFB?=
 =?utf-8?B?Y2d5RnRqVlcxOVJXZ08rQUM4VWhOaFI1VmdJcTVZcDNLbXh5TU85RkhqY2gw?=
 =?utf-8?B?SWxqeXFVSzYycGJTY0V5Rk4rY1VYZlF4VGI2QXo2czViWXhwTTV0QT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: VM843JQfqRH6acp2ji9NsWgbI4iRiuLPkrpXMTnja5JmpXpoznI79yInvEPIrc6WdLdc2aJqyLCG5FnXJPM0FTl2/owoUmJf7NgOa7Wx5jlyUcOqHC4tEya2lUXC3JzT/30Ee17QL/EMTO4wMDIS31UBZm1PcxSEx9mYPuY2LCYfRn6wZWIiUMHdimssVJc0Qggz/bkKkCTj3eqwY0gf+SmxATeJmpKDf3LbOkjJpsCXwg7Fbo5W/WkCl31qim2oSJ5X5fUzlXWA7GR0VdN6SkC/znNs3STiV3tvTQRZAYGj6XvzdRdq6IbqrMVfNxhLT7tLfItKJv35RRmrRAeiyw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b927dcd-0df6-48af-acb2-08df234b10fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2026 01:42:22.3762 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E2SWClJ+LGUnL+c4Dk940ZK5OlwXxa6RuvoLnyfGynI7wDxvD890po8qEg8yfnm9qpJmQXpWuHG28yP65t7iNHhUCZsy76brmTt0nWwL2bA=
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
QGludGVsLmNvbT47IE1hY2huaWtvd3NraSwgTWFjaWVqIDxtYWNpZWoubWFjaG5pa293c2tpQGlu
dGVsLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIGl3bC1uZXQgdjMgMTAvMTVdIGljZTogRTgyNTog
cGVyZm9ybSBhIHNvZnQgcmVzZXQgd2hlbiBzdGFydGluZyB0aGUgUEhZIHRpbWVyDQo+IA0KPiBU
byBlbnN1cmUgdGhhdCB0aGUgRTgyNSBQSFkgdGltZXIgYmVnaW5zIGluIGEgY2xlYW4gc3RhdGUs
IGluaXRpYXRlIGEgUEhZIHNvZnQgcmVzZXQgcHJpb3IgdG8gcHJvZ3JhbW1pbmcgdGhlIFBIWS4g
VGhpcyBlbnN1cmVzIHRoYXQgd2UgY2xlYXIgYW55IG91dHN0YW5kaW5nIFR4IHRpbWVzdGFtcCBt
ZW1vcnksIGFuZCBlbnN1cmVzIHRoYXQgdGhlIFBIWSBpbnRlcm5hbCBzdGF0ZSBpbmNsdWRpbmcg
aXRzIHRpbWVzdGFtcCBjb3VudGVyIGhhcyBiZWVuIHJlc2V0Lg0KPiANCj4gTm90ZSB0aGF0IGRl
c3BpdGUgdGhlIG5hbWUsIHRoaXMgUEhZIHNvZnQgcmVzZXQgb25seSBpbXBhY3RzIHRoZSB0aW1l
ciBibG9jayBvZiB0aGUgUEhZLCBhbmQgbm90IGl0cyByZWd1bGFyIFR4L1J4IGZ1bmN0aW9uYWxp
dHkuIEFkZGl0aW9uYWxseSwgbWFueSBjb25maWd1cmF0aW9uIHJlZ2lzdGVycyBzdWNoIGFzIHRo
ZSBQSFlfUkVHX1RTX0lOVF9DT05GSUcgYW5kIFBIWV9SRUdfVFhfT0ZGU0VUX1JFQURZIGFyZSBu
b3QgcmVzZXQuDQo+IA0KPiBGaXhlczogN2NhYjQ0ZjFjMzVmICgiaWNlOiBJbnRyb2R1Y2UgRVRI
NTZHIFBIWSBtb2RlbCBmb3IgRTgyNUMgcHJvZHVjdHMiKQ0KPiBSZXZpZXdlZC1ieTogTWFjaWVr
IE1hY2huaWtvd3NraSA8bWFjaWVqLm1hY2huaWtvd3NraUBpbnRlbC5jb20+DQo+IFNpZ25lZC1v
ZmYtYnk6IEphY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPg0KPiAtLS0NCj4g
IGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfcHRwX2h3LmMgfCAxMiArKysrKysr
KystLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0p
DQoNClRlc3RlZC1ieTogQWxleGFuZGVyIE5vd2xpbiA8YWxleGFuZGVyLm5vd2xpbkBpbnRlbC5j
b20+DQo=
