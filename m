Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4C9DCA5FFF
	for <intel-wired-lan@archiver.kernel.org>; Tue,  6 Oct 2026 01:40:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 68502406A3;
	Tue,  6 Oct 2026 01:40:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GDDycMckaTDC; Tue,  6 Oct 2026 01:40:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 969284066E
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791250804;
	b=JKCresfRyn1CPdJAP7MYeJ0mI09eyPHeLAJJ8vR/2NBlaIAhNypFkT8o9tEy4LMi0Xly
	 pcWdESLvC1P/e7hMKBAuIr+flP6qzvqLFpx3jZRldReAoURvUtpEmHF/go3QksycDa/Ej
	 gHwgB4BcQwR1ULmDYKOUGhHXJitjNO417o8zLiv8x0e0ysC4heWLSJEdIxOlif+9Dt/4w
	 KYx3cXFRFTb4X+6AhOsB8DN9LOfrNz1y2Mv3pJNi0wTutrYZgw/k5ssZW46vdD+tOAYZz
	 tgAGlBeur0pF5IN3qJ6oo/OsJfv48pJbM84wIEKdd1R4WF4D9qgW1dGwfSwHB3kRPEQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791250804;
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
	bh=TxTjO9RdFuQX1uRk2sMkEQjQatcPivDtg38OMYpGWMo=;
	b=HP0VlTKr1sLZ77DvM/HYu7bsKSy6bv7qQsak5DfIDr7nENEfyp/sXKfS4Vri2ggcsQIC
	 So0JVyBtHI1t8jWnBYvs7a4XEydunBaKjwwawosg/Qe/8g2eUBem5kT5y8sKS9uKxZu2b
	 JahxsM79IqLs45oNwpHfYx9OstzN0wR+mOtC0Mz74GNv4YEw7HAFoctnMsLq8WrCyJKUu
	 VT8utA9+DbEhk8zqr7KBrqEleimppqnJr5zzR3ekq9imBivFf4DtFaUL80QX3AiNRiOBL
	 NBh/rC1/tnjvYHz02FmE2IoKji+VGVECFM6QDOJpJuObfeARWEIUad/KHyR7BSDCEig==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="YvrXm/si";
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791250804;
	bh=TxTjO9RdFuQX1uRk2sMkEQjQatcPivDtg38OMYpGWMo=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M92jpeWdj1JTT0oUc8ncgVaapYkclDiD/rJtK7ezFv5TlwRKon9lIxc0fpOK8I0W/
	 nFpZ996pRadzQ4QX0ld4sJZ4LQOamw3dPzIbGBIt/Fge7PMRlAMDtITLEfCELo+I0H
	 SFIVXdJcmRaoEIMWGQM0vsc4M4biPemNw1kglZcf7HzFzfQqx5+GqpzyynZbNEl8Um
	 XtCsZ4HzjBrStwCQC4JeA3FLaIHmpq+HwoTZAsN6kUmeSWZmuSTnCBBYIDzKoSV0r+
	 SfH3fonV58QFrUCbioJ51n/1hIIbBb1AK6YSo8rp7OBXqiNyCdcfJ/thV+NkurTAmu
	 /BDygh7tIVnRA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 969284066E;
	Tue,  6 Oct 2026 01:40:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id CDC5332F
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 01:40:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BF741405FF
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 01:40:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V718LZTZtF9f for <intel-wired-lan@lists.osuosl.org>;
 Tue,  6 Oct 2026 01:40:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C4EA740600
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.9
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791250801;
 b=sAsuhefVCCDtgs0K6CeqDgEtqoBoUqMwCXza/djXhBUm+2yKq7YvBaYwl/GbGauXO5Ou
 1IRRg+HdpL6X/KbdE5VAVKWyfD4VUJmg15cquyAyYQGkBePk5TaoYAs4QkWT9uiyerf7W
 L12Cg7xe/ELl0D20g/2DArp8Yih8uS0zfckfzo6lgz4XW03qh8SP769PA/pz01HvJmWA0
 B4tcCMW4PLKq7o0M7Nkw/xbE5PTTnIV5bXuKnW8C45EPHksa9q7QUhXzEhrAzyLaKB/j6
 KhQTWIrLyFpgMTWRj0+dk5ydkKJrWLEXoCGFkZQT8kdGPSgdK1jyLITxs2mIgSYj9HA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791250801;
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
 bh=TxTjO9RdFuQX1uRk2sMkEQjQatcPivDtg38OMYpGWMo=;
 b=r5E8uhy8OsHyDIxD0yxK34Q8DfcjyMMx/IUFK3qjjTN1WrgU8Nj33Ms0aSwb+JCFgsFS
 MIZzS/Bs9cg7fEG4dFy2mDwzWEQya2qfQ8D5XIuOsM99H3s2Kc0cf89lxfVV9GAoNtum0
 zEy9B8lO5TSYACXtTtn7prWDNYrIzjD+uWHODkw+X+wEwtVQ6i0yNnMoHS7qJ+oDAIlFZ
 fJH+At+hqhlM4/yE55R5xP2oYtPmNvj2h98xA1kOsghxmISQG/RMDmUZObktUDrOBIyj1
 03xaOmsGd3kRPKZeW0GxUB+gQ+BBj2vfqEINFnzUSqlB3Jl9lJEHqSiO/P/rT9Pogsg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b="YvrXm/si"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.9
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.9;
 helo=mgamail.intel.com; envelope-from=alexander.nowlin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=YvrXm/si
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C4EA740600
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 01:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791250801; x=1822786801;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=TxTjO9RdFuQX1uRk2sMkEQjQatcPivDtg38OMYpGWMo=;
 b=YvrXm/siTyCpAcdBVIv8DQE0SdnhPARpJFL+TqOzOhGpw18353ZCl23S
 H9L3vhCwiYYxA8uN4ZCzGsCY8kVJImD0hphDMfmrdVzVGSK/qrdU2LGjB
 p12MDUeu0XCekS8K+AE7wvCtTV672u3/fQhJTJXNtGvN/8Pc+vCd0uNwO
 hoP7PhCMEsw2wYUrZqERh+ykpTyKQOtXkVqn5UyH3SZUyylq+fyPZ6hf4
 MNyXNc0hLF3rbuRm1nFElOvJxamS3CV/C45i4GIy3SFHuwg3CGwvOcOhE
 IL8BupqNeZP/ylsze25sRWWawqin6VdqZf9xYjHUnzlWxKzLqa0rHUOZm Q==;
X-CSE-ConnectionGUID: G0MlGZJbSMSatm+n+TV70g==
X-CSE-MsgGUID: cjrXEb0WQameXCfhXqgSjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="113716367"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="113716367"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 18:39:59 -0700
X-CSE-ConnectionGUID: XGVv8SuERaCE8QdRyAFTUw==
X-CSE-MsgGUID: iJDZ37UoS4Kwv0VKa3VD7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="1007977"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 18:40:00 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 18:39:58 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 18:39:58 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.50) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 18:39:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NW2CWFlK6I4SziaaZL78iyJNFv++9ILo0MDZT7R0Qj9PxqFVjBpvnopekma1H35dtssSCX0Y+OKtjcinmY174Fem8wzP8DNHgueejTu5TXREVrbXpsdIYQfFUX0M3gdubEdk2cvORCHDoocrdf4vfofMasLJElQpPfdzufqA3tuy/epQN996uymS1DT6AUyPnNvlzWp3mHi8V8S5ThLKk/1+4EM3bwIMLZCx8Uj+oOXGTqRBKTybc5YViKGdrHpSLc4cHXAEu438qmOvXxQBIGY3rWo2nXqdQHkxqj0ww6sE+RQ0n2JT8UZ+AAqKJlXIsBhYYkOfFqp1iBQZKGJqHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TxTjO9RdFuQX1uRk2sMkEQjQatcPivDtg38OMYpGWMo=;
 b=rKNxhy8st9uir9p9dqB/DUreLSGv1worZ3ZhDGe5RPs5sSB6BHPYg1qU/0EVgpx5se8DVpSQEbwueOO9LsxkAzOOFQTEBs+aEaq+hd/I9mAdytgDXc4499gQgd2RhBMUKpkbXXGIWlCAuFSl1IkJmqFVQERO0+PtajkwsHaXdPAlGwFa0LMUXfTDFYnLxrLr6gMqISamBUSwpL28jXcfds4gfFDTtt1GC4ZKRflZ5NKH/Rxr/lHR/QUDAPXTaYYOAZXyYCvrlCSYjEjSAYCzElaGuqw2/OoLth7KEIdP102iZorAHkttDch0dJfQDlQf1+CtzBA+nzLNY3IVdGc1/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by MW5PR11MB5907.namprd11.prod.outlook.com (2603:10b6:303:1a1::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 01:39:38 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 01:39:37 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, Intel Wired LAN
 <intel-wired-lan@lists.osuosl.org>, "Machnikowski, Maciej"
 <maciej.machnikowski@intel.com>, "Keller, Jacob E"
 <jacob.e.keller@intel.com>, "Korba, Przemyslaw" <przemyslaw.korba@intel.com>, 
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Nitka, Grzegorz"
 <grzegorz.nitka@intel.com>, "Kubalewski, Arkadiusz"
 <arkadiusz.kubalewski@intel.com>
CC: "Keller, Jacob E" <jacob.e.keller@intel.com>, "Loktionov, Aleksandr"
 <aleksandr.loktionov@intel.com>, "Kubalewski, Arkadiusz"
 <arkadiusz.kubalewski@intel.com>, "Korba, Przemyslaw"
 <przemyslaw.korba@intel.com>
Subject: RE: [PATCH iwl-net v3 06/15] ice: E822: keep Tx timestamps disabled
 during offset calibration
Thread-Topic: [PATCH iwl-net v3 06/15] ice: E822: keep Tx timestamps disabled
 during offset calibration
Thread-Index: AQHdTUnEN5TWscrHBU2uvpY+tAcH87bvzFTw
Date: Tue, 6 Oct 2026 01:39:37 +0000
Message-ID: <LV1PR11MB879023C9485E3867C092012D90952@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-0-6532598e8da8@intel.com>
 <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-6-6532598e8da8@intel.com>
In-Reply-To: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-6-6532598e8da8@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|MW5PR11MB5907:EE_
x-ms-office365-filtering-correlation-id: 8624da15-737e-4797-dfa1-08df234aaedf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|6133799003|22082099003|18002099003|10067099003|921020|38070700021|4143699003|56012099006|11063799006;
x-microsoft-antispam-message-info: koEZU2o+zNHD9uLeeAmABuzDu8yNSO4B6DFKZZdPcYcQaErrzRSrw/Vs4PI/J++urGtK0RF0OEcLPVjcidCuIYM7RhWEe8SLZ8NzfHArhxQtxz/b+BvvRDXt1ekLEikca7DbGfUU/eVgC9oXglhoRnhf0C8c66Kx4nTvs5llW+qh1xs53J9QXIDOii3TzXOFEHmfTj1JSgfjbmNqXG7YC1Ra03n18MdC7ZDbtA/BpIA0+SJ+0JTm349gFWeBPDjjuFbF9yptbjEN4EA5VKgZcjmBvJm6lnty1TEyQ2Jura/xWto150rHFiHXtGZ3ywNI7v/D8WarFkuRj0l/hdTxJRPdaq4k650/qYFCaBotw3xR1juULArux4yyjCKN+gSc3Pd7id+bok9XYnIUHlHCUIWmxqcBvWDq8GSi7yBqds/7XM6UVMEPHZGRIMdb46o9IYCuxEFd7/ja2nvjJFq7/I1jVCxhr88+2fHVr/OEKy/HRBumyRse/mA1dtC1MfBQS9gXPZdpu/t3mysPW1wjkcsr310LZC/2JK3hee7MWbEy6rAre7lXb0exPiG4+U9tA14IoTV3MUtxmWkax4NPVUKO1pCdq+utlsw43HrXAfcHUNHU3DkERAnGjSy9e6Xg9kbDX8+OkrU+XGDHkIdsko1UJvseAq81B7bn7sOIgn7aM028rMeVhbeHyifcgio1QzoW/HiiN0lN6PgeUK0QRh/l5Kz9S1G8GK7hbufgKPn7pPd0aEH7pZC/FSGwibOt
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV1PR11MB8790.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(921020)(38070700021)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SjZwSkIwTHlKbUFPWTM1UlpiMWlFa3R0RDRwSXUzQy9kejQyQ0sybks0VWJK?=
 =?utf-8?B?ZW9Ta2ZzbzJkWkdLUU5JNmpRRFloeUdlUkJLWmR4cE9FcHNYeFpRR0VsaGlr?=
 =?utf-8?B?QmFkTVVEamFQVmNTMitTTVYvdERLSUR4dXhBSURWd3cxSWNmR2wxU2piWVdK?=
 =?utf-8?B?eTExRTF6TEpkYjJmZUtMektWUzVsZFkyVzEwT0ZhV2tJQzVXaXV4bm4wNEQy?=
 =?utf-8?B?VGk3S3c1dWxNYktuRG93Q2hjQjZaUUZLWVUwaHhSVVZoWVU2SlgvbGJXWW1V?=
 =?utf-8?B?SWVSTVB0Tmh5Vy9tTkRDSHRhTkozOTk3dWt0SytIL3VMc2pKeFN0N2pwSDBs?=
 =?utf-8?B?b1ZZVDJDbkdoR29xYW5wTkgzT0F2R1RjMGxQRDRLNWdmSlRpT01XTlRocnZz?=
 =?utf-8?B?ZTJKYlNEK2d2K0o5L2oza3pYcURMeVRPd1BxMDhpdkdHNGtyeC8za3J0SGx2?=
 =?utf-8?B?OERQancxZ1NaMGJmU0lpb1BsZmVTUDcrbmt4OWl0akFORm4ydmgxOEo3S29D?=
 =?utf-8?B?UE1FUDFiT3huRXZHdDNGQzVIQnJOOXkwV3VCM3lzaHBCQU1zeXFYTWh5blNn?=
 =?utf-8?B?eDJHc01TeGR5LzIvd0p5VXZEU0dqa2wybm12V0Z0akltdU1tamd1UTAwWTJ3?=
 =?utf-8?B?MXEwUGNLWVZ5TEQrZWV0ZVlaM1hjRWt5enVwWXhXYlppMC9ZUjAxdGFiSnZW?=
 =?utf-8?B?aVFyeWU4RDR1QjJtSTVEalZMOGxmT1E0VVZxZmpWbFdjcE9WN2Fma0lqbkNx?=
 =?utf-8?B?L0JPK0VKOUpuSlhmTURXR2hzTVNkTU8zK283L1dwRFlLQmJ1ZkQ5YmJ5cUxw?=
 =?utf-8?B?dURSSnF2d1FQRFRQbEY0NTZ1SXhhUmQ2ejVJc1I3V1pobFUvUG42ODM2bkxU?=
 =?utf-8?B?MVl3MzZtWUptVExhK0JBLzV4VzRuUmVWUU5VZExzRDRMU3lEUjYwdWlwQWxO?=
 =?utf-8?B?QmpiYWNXQUsxcVZnMjVvVlZCbGZ0K2dmc3NReUtTcnN5TEp1MW43SWxxUElu?=
 =?utf-8?B?cGtpMmZUVVJxQUJiS2h1YWZsR05uK3JSWGtWOHlGQkpVbUUwMXlja1R2U1Nv?=
 =?utf-8?B?Uk9HdG5wUFQyRGVTNFF5c00veVd4YTFrbDdXMzNJV2dQZjdqTWxMQ25iY0wr?=
 =?utf-8?B?UDMxanlwN2FZVUc4ZVh6cHJlV2M0QjIvZFJ0MDZWSE1qQnYyNUxrQlNtdUxV?=
 =?utf-8?B?TkttaS85SXFhdlgvZjYzL2VQRnFSMWwwZURxZ2VTaCttQTR4U2ozRGpXYkZ5?=
 =?utf-8?B?a050YWxIbHJkWnlheVJkblF4UXdHeldhcjBMK3BnVUFCNUxpRGw4cGxKU3d1?=
 =?utf-8?B?NTZJcWY2YVMyR0dlNGdsUlUwRENSUU0wR05XWmw4dy9WeDFQa0hmMDhTcHVo?=
 =?utf-8?B?OFBXS0YvK3lwYTNFay9qN3J3SUc1dVRmZHR4b2RFaGZiRE5uaXBIZ3BmdnFE?=
 =?utf-8?B?Tkxvekd2NzhMU2dwTUZWMytPQ3JabFk2a3VrODBKdHQwQzZVelB2VGxRbTQy?=
 =?utf-8?B?RmwycE1RUm1RTGYwL1I5OUpmYi9CL1BpNjVhZXVUQkNoVUlscXlWT1lrSHdh?=
 =?utf-8?B?QjByVk9Ha29sNHEwcmdSUE00bHBsZXRHU2VIeVlHS3JsOWNTanNRZWFkSWZq?=
 =?utf-8?B?YWp2WVVITlB1Und2WWt4RHExR1gzRHBXS0lZa2R5RWFwS0ZwcGI2T0FQMUcr?=
 =?utf-8?B?amtVNDVOYk54bTB2ZTNXWlRWNmM2YzNoR0FZSDN6NDAzMXE0NDlOMEhPSktw?=
 =?utf-8?B?OWxMYTFWbTAzbWttL05TUlhBTk5ZTGtFS1ZJM1ZKeHBDL2JTN0M5eDFKRXU3?=
 =?utf-8?B?RWNkdlVDRkljZ1hJMGk0UmRaeUpERTNwNzFKcWllVkdpUUhPa21qWTNEeVgy?=
 =?utf-8?B?ckN2Tk5vN0tMWlEwT3E3NXBrOWErTFVaTzBvdEQ2UFVxK0p3c0cxanliWGJy?=
 =?utf-8?B?RjBEekx5TGJoeFR1bFNzUWxqcWZVeHV0RjNOekw0WitjZENLNE9mUXVpT1Ix?=
 =?utf-8?B?ZkU0dStsOVE3QUFRbWIyeXVEQ3VyOGROZnhjZHBvQk9ERDZWWDgrN1dNR0xi?=
 =?utf-8?B?QU4rdElEd0lxWG5GVXBrMHFxd0FsZVEvdy9TalRhTlVvMW5aTE9MOXgvYW9t?=
 =?utf-8?B?VFd3YlVXQ0thc0NDSHc4QjhtNzQwMjVXZThSTTlOdi9EQWRmQy9reThBT1F6?=
 =?utf-8?B?clluVHdKZEVNbmxQZy9GSnVzUzArckhsWjZoZnFJellna3lFZ0tTbFhhMHVR?=
 =?utf-8?B?QUZjSjBOeWVHYUY5M2twK0RISzNLZkNjUFNqODhrSVBxdTZDdVRkLzcyUXZV?=
 =?utf-8?B?TmNGVGVPRzFqTzJHMDBnM2ZUYTUvc3ZHY2tHSTMwTnJSVUtOSlZmQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: cM6IPo4nbK/4rhOH5nY9UwA2XHp/NjZqCc1l9cEAasP8s84eavEKagv7TH59jpQGe4QYoEDpgEWnA66kuugqGpxO1LqDOFhQySEs3zlHcHbzdpTTfe7kTWM5tn4hGCKeQW3i2ZIE/pYrTLWBiDK+12RoyHefs7AxNkfqKkz3eO1Ig/aagANI0lnfk3FGCsNaeZYFcmiHN9ltol8xeuYdlHnhqpNUb6jgeBNwATtIJBdl3R21FbQOrxqSgGJQZQOpmztCU2wzSdiq7/8DIqPRmZHsVSv6N4dwPtTk6AEmvWZM/oGwTKHZYMj09UViewRoN6EbcNu1ap+bO2AOJfIpTQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8624da15-737e-4797-dfa1-08df234aaedf
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2026 01:39:37.8101 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Ke7uNaUSU/wOyqcJrK9WUTSGGnFh7I7gTb+Ccpy3swyMw1rAdmTL3qrbqvxma1HpUzWzEpQmgS2DOBu2e3AKIe63SFWefR424MHr9W+dYM=
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
QGludGVsLmNvbT47IExva3Rpb25vdiwgQWxla3NhbmRyIDxhbGVrc2FuZHIubG9rdGlvbm92QGlu
dGVsLmNvbT47IEt1YmFsZXdza2ksIEFya2FkaXVzeiA8YXJrYWRpdXN6Lmt1YmFsZXdza2lAaW50
ZWwuY29tPjsgS29yYmEsIFByemVteXNsYXcgPHByemVteXNsYXcua29yYmFAaW50ZWwuY29tPg0K
PiBTdWJqZWN0OiBbUEFUQ0ggaXdsLW5ldCB2MyAwNi8xNV0gaWNlOiBFODIyOiBrZWVwIFR4IHRp
bWVzdGFtcHMgZGlzYWJsZWQgZHVyaW5nIG9mZnNldCBjYWxpYnJhdGlvbg0KPiANCj4gRnJvbTog
S2Fyb2wgS29sYWNpbnNraSA8a2Fyb2wua29sYWNpbnNraUBpbnRlbC5jb20+DQo+IA0KPiBEbyBu
b3QgY2xlYXIgdGhlIHR4LmNhbGlicmF0aW5nIGZsYWcgaW1tZWRpYXRlbHkgYWZ0ZXIgc3RhcnRp
bmcgdGhlIFBIWSB0aW1lciBpbiBpY2VfcHRwX3BvcnRfcGh5X3Jlc3RhcnQoKS4gSW5zdGVhZCwg
a2VlcCBUeCB0aW1lc3RhbXBzIGRpc2FibGVkIHVudGlsIHRoZSBvZmZzZXQgdmVyaWZpY2F0aW9u
IHdvcmsgKGljZV9wdHBfd2FpdF9mb3Jfb2Zmc2V0cykgaGFzIGNvbmZpcm1lZCB0aGF0IHRoZSBU
eCBQSFkgb2Zmc2V0IGlzIHByb3Blcmx5IGNvbmZpZ3VyZWQuDQo+IA0KPiBQcmV2aW91c2x5LCB0
eC5jYWxpYnJhdGluZyB3YXMgc2V0IHRvIHRydWUsIHRoZW4gaW1tZWRpYXRlbHkgYmFjayB0byBm
YWxzZSByaWdodCBhZnRlciBpY2Vfc3RhcnRfcGh5X3RpbWVyX2U4MngoKSByZXR1cm5lZC4gVGhp
cyBhbGxvd2VkIFR4IHRpbWVzdGFtcCByZXF1ZXN0cyB0byBiZSBzZXJ2ZWQgZHVyaW5nIHRoZSB3
aW5kb3cgd2hlcmUgb2Zmc2V0IHZlcmlmaWNhdGlvbiB3YXMgc3RpbGwgcGVuZGluZy4gVGltZXN0
YW1wcyBwcm9kdWNlZCBkdXJpbmcgdGhpcyB3aW5kb3cgc2hvdWxkIGhhdmUgdGhlaXIgdmFsaWQg
Yml0IGNsZWFyZWQsIGJ1dCBpdCBpcyBiZXR0ZXIgdG8gcHJldmVudCByZXF1ZXN0cyB1bnRpbCB0
aGUgZHJpdmVyIGhhcyBjb25maXJtZWQgY2FsaWJyYXRpb24gaXMgY29tcGxldGUuDQo+IA0KPiBN
b3ZlIHRoZSB0eC5jYWxpYnJhdGluZyA9IGZhbHNlIHRvIGljZV9wdHBfd2FpdF9mb3Jfb2Zmc2V0
cygpLCBhZnRlciBUeCBvZmZzZXQgY29uZmlndXJhdGlvbiBoYXMgY29tcGxldGVkIHN1Y2Nlc3Nm
dWxseS4gVGhpcyBlbnN1cmVzIHRoYXQgbmV3IFR4IHRpbWVzdGFtcCByZXF1ZXN0cyBhcmUgb25s
eSBhY2NlcHRlZCBhZnRlciB0aGUgUEhZIGhhcyBwcm9wZXJseSBjYWxpYnJhdGVkIHRoZSBUeCBv
ZmZzZXQuDQo+IA0KPiBJZiBpY2Vfc3RhcnRfcGh5X3RpbWVyX2U4MngoKSBmYWlscywgZG8gbm90
IHJlc3RvcmUgY2FsaWJyYXRpbmcgdG8gZmFsc2UuDQo+IFRoZSBkZXZpY2UgaXMgaW4gYSBzdGF0
ZSB3aGVyZSB0aW1lc3RhbXBzIGNhbm5vdCBzdWNjZWVkIHByb3Blcmx5IGFueXdheXMuDQo+IEEg
ZGV2X2VyciBtZXNzYWdlIGlzIGFscmVhZHkgbG9nZ2VkIG9uIGZhaWx1cmUgdG8gc3RhcnQgdGhl
IHRpbWVyIGF0IHRoZSBlbmQgb2YgdGhlIGZ1bmN0aW9uLg0KPiANCj4gTG9nIGEgZGVidWcgbWVz
c2FnZSB3aGlsZSBvZmZzZXQgY2FsaWJyYXRpb24gaXMgc3RpbGwgcGVuZGluZywgaW5jbHVkaW5n
IHRoZSBzcGVjaWZpYyBUeC9SeCBlcnJvciBjb2RlcyB0byBhaWQgZGVidWdnaW5nIHN0YWxsZWQg
Y2FsaWJyYXRpb24uDQo+IFRoaXMgcGF0aCBpcyBleHBlY3RlZCBvbiBldmVyeSByb3V0aW5lIGxp
bmstdXA6IG92X3dvcmsgaXMgZmlyc3QgcXVldWVkIHdpdGggbm8gZGVsYXkgYW5kIHRoZSB2ZXJu
aWVyIG9mZnNldCBjYW5ub3QgYmUgY29tcHV0ZWQgdW50aWwgYXQgbGVhc3Qgb25lIHBhY2tldCBo
YXMgYmVlbiB0cmFuc21pdHRlZCwgc28gdGhlIGZpcnN0IHNldmVyYWwgaW52b2NhdGlvbnMgbm9y
bWFsbHkgbGFuZCBoZXJlLiBVc2UgZGV2X2RiZygpIHJhdGhlciB0aGFuIGEgcmF0ZS1saW1pdGVk
IHdhcm5pbmcgdG8gYXZvaWQgZW1pdHRpbmcgS0VSTl9XQVJOSU5HIG9uIGV2ZXJ5IGxpbmstdXAg
ZHVyaW5nIG5vcm1hbCBvcGVyYXRpb24uDQo+IExvZyBhIGRlYnVnIG1lc3NhZ2Ugd2hlbiBjYWxp
YnJhdGlvbiBjb21wbGV0ZXMgc3VjY2Vzc2Z1bGx5Lg0KPiANCj4gTm90ZSB0aGF0IHNhc2hpa28g
cmV2aWV3IGhhcyBwcmV2aW91c2x5IGNvbXBsYWluZWQgdGhhdCBsZWF2aW5nIHRoZSBjYWxpYnJh
dGluZyBmbGFnIGVuYWJsZWQgInBlcm1hbmVudGx5IiBkaXNhYmxlcyBUeCB0aW1lc3RhbXBzIGlm
IHZlcm5pZXIgY2FsaWJyYXRpb24gbmV2ZXIgY29tcGxldGVzLiBUaGlzIGlzIHRydWUsIGJ1dCBp
dHMgaW1wb3J0YW50IHRvIHJlYWxpemUgdGhhdCB0aW1lc3RhbXBzIHdvdWxkIHN0aWxsIGZhaWwg
cmVnYXJkbGVzcyBvZiB3aGV0aGVyIHRoZSBmbGFnIGlzIHNldC4NCj4gVW50aWwgdmVybmllciBj
YWxpYnJhdGlvbiBjb21wbGV0ZXMgdGhlIGRldmljZSB3aWxsIG5vdCByZXBvcnQgdmFsaWQgdGlt
ZXN0YW1wcyByZWdhcmRsZXNzLiBUaHVzLCBrZWVwaW5nIHRoZSBjYWxpYnJhdGluZyBmbGFnIHNl
dCBzaW1wbHkgcHJldmVudHMgbmV3IHRpbWVzdGFtcCByZXF1ZXN0cyBmcm9tIHNvZnR3YXJlIHdo
aWxlIGl0IGlzIGtub3duIHRoYXQgdGhlIGhhcmR3YXJlIHdpbGwgbm90IGNvbXBsZXRlIHRoZW0u
DQo+IA0KPiBGaXhlczogM2E3NDk2MjM0ZDE3ICgiaWNlOiBpbXBsZW1lbnQgYmFzaWMgRTgyMiBQ
VFAgc3VwcG9ydCIpDQo+IFNpZ25lZC1vZmYtYnk6IEthcm9sIEtvbGFjaW5za2kgPGthcm9sLmtv
bGFjaW5za2lAaW50ZWwuY29tPg0KPiBSZXZpZXdlZC1ieTogQWxla3NhbmRyIExva3Rpb25vdiA8
YWxla3NhbmRyLmxva3Rpb25vdkBpbnRlbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEFya2FkaXVz
eiBLdWJhbGV3c2tpIDxhcmthZGl1c3oua3ViYWxld3NraUBpbnRlbC5jb20+DQo+IFNpZ25lZC1v
ZmYtYnk6IFByemVteXNsYXcgS29yYmEgPHByemVteXNsYXcua29yYmFAaW50ZWwuY29tPg0KPiBT
aWduZWQtb2ZmLWJ5OiBKYWNvYiBLZWxsZXIgPGphY29iLmUua2VsbGVyQGludGVsLmNvbT4NCj4g
LS0tDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX3B0cC5oIHwgIDIgKy0g
IGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfcHRwLmMgfCAyOSArKysrKysrKysr
KysrKysrKysrKysrKy0tLS0tLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCsp
LCA3IGRlbGV0aW9ucygtKQ0KDQpUZXN0ZWQtYnk6IEFsZXhhbmRlciBOb3dsaW4gPGFsZXhhbmRl
ci5ub3dsaW5AaW50ZWwuY29tPg0K
