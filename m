Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76BD2C98321
	for <intel-wired-lan@archiver.kernel.org>; Fri, 25 Sep 2026 14:31:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3F3A860DA5;
	Fri, 25 Sep 2026 14:31:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2nzVQKIuIM0r; Fri, 25 Sep 2026 14:31:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7E64F60DA1
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790346701;
	b=Rmx6GuBqh+YtDSWQfnSYW/pZoRYh30niQID0mG1RrmE1t/vpK7971V/2hPa4ffxQXR5t
	 2MxLPUYRi89kKMUM8uZkJ7eSasbfFviLigfmt5xIV9w74JWHGTR0hZL4NpNqKjJ0VxCaE
	 jCqB0KdfNJBh1Mw3l57gu6/BItgmVytdwXHntVG/k9B+BTm+YuYsIuBM1Dbztdflqg796
	 0flMGIkqIvAurJfKWcPkNdy1lVYK0Y/6fCeU4nJGJF85cBo0+Q4JrcV9dFtTdcwTqcDq/
	 PXJulrpD5wHo10MpdyGGOC9vGjZDA0+vlvIvVcg5Fkn1bGJc/TMYTu75+5A3BpVMfaA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790346701;
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
	bh=+jAPfhV4MD+XElmJtEVYRauCWJv0x1By3JwAoudSwWE=;
	b=lFEZyq06skFhTHidUjZ+dcsnISElVi3TMb7f44wL4gt9XvwerApi9AVv59ydWmjvMwNx
	 wpmPtCrlnPl6wOCMDTJ9zxNCnQDSbcRXE344Hp0yJ9RBHOaSLNJ+nyyFPAtSuL0T17C1C
	 duwd3yrBU8f/xMeWcws6es0/hxH4MsPWnptF68br+03Hgp99G4IYx2MazhmHcTKYLNBEq
	 O6Y3mTsJ4geiXZ0iADDhWl7uGnY63qUhn8XSdTWUTZK69ab8k6zpK1BWdFUdp5Zksw4aC
	 hSrNThtoQZMcOEBPBXMz2TNPozLro3gdgohCcpzSSa+dLuYi62dPT7RnVxiZeVYf2Fw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790346701;
	bh=+jAPfhV4MD+XElmJtEVYRauCWJv0x1By3JwAoudSwWE=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=f1hl2NMCQSwP0t4Yrss8F/m7jLJ/SN3lg30y/PD+DPBgXZegsABtt0BQ5o1fivJ8w
	 riwU9c+C5guIEcD0/L+O3M0KRmZkEfOsNcX4XMycfAkv2e96t8TnbeM+09/HllTMfC
	 mnbfbjkojmKX93hChDqsB+axp3JSa5PuXiN5DqW4rEodFTt91WeZa1FojmvriR1CAR
	 isCxlt9CRt/Vvt7OIert39AAeBuXDVeUCs0N9hRcxJRLTxjp7JukVgPy4wlbs6D7QN
	 BzjBakfU61n6umsGRwFX4jJpD8hmPcDuCt5RYrha1LP7mGkJYvN8fIISUkSn+ZbOWH
	 5bVG6ElWVj4ug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7E64F60DA1;
	Fri, 25 Sep 2026 14:31:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id ACF63194
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 14:31:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AA62881329
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 14:31:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b3VW_RQD5DvA for <intel-wired-lan@lists.osuosl.org>;
 Fri, 25 Sep 2026 14:31:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A81EA8129A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.19
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790346699;
 b=cwUMRUI4RCaAow6MSPjCIPJbBlSPh/T7l2rZ+eqXS/5+QYQ9suM20/G/m/supf8oH5cG
 VemjWcv/0sAFUee90WYdpPttexJCu9sJEG+C+dsKABPNN2iVi6nlZuQ1PQdiqZmTIq8VR
 m8IBH94tVSXeXFY8HkJLusFvKIOYGkzk4ozaciOcavIMwZV1s88pd04SqhaWlHmf+oAqV
 Nj2CI1ib+r7Q9AJxVbCENx80X661DQGlLHoo0+fJeuucpLP3Wf/cx4yqHnuDokMKYVGDL
 n4+aFcciwfaHL2dXD3LutmXN64jUKRMpuIruHJYvE/cU4h/6bmivorDZoaStWCSmxcQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790346699;
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
 bh=+jAPfhV4MD+XElmJtEVYRauCWJv0x1By3JwAoudSwWE=;
 b=bN8UReawwU4fNhCuz2cVVr+LDU9BNycWzIEhq1YmxeT3BDo3p6VGc+Ic9U+DgKhYvqYk
 zGYF1i+y6wxBwC9dyWQ0p3Q7FdcKQp8M9mBMXJ5pqUfSgT4wXSSYLNqV7AQP9FJ82cE4o
 xYrslSDwbBXfP38QaHk9tE+sIPPVL9526xIeeMzUB+igJ6MiIW+oQ+tz/17GqQ4PcMoia
 ZTBSfkVX1IMqFWDPaTXKmlTIdWzClFXQQZjIgwpq/OAxAxaf43503rXb6ddtfR0qAwDBx
 QQevQlf0gXlMaiN5WtkjYqPRizHcKrCC4s4kh2toB9SCGePU6t59aVr5slETD44uc+w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b="Zb9S1s/X"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.19
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.19;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Zb9S1s/X
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A81EA8129A
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 14:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790346699; x=1821882699;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=MK13TqIPoAkZJclfeBusX0KcJCW9sGSUckD3DZWQ+LA=;
 b=Zb9S1s/XtbJ/k2LLjUwwtZG5U2ooqjNujKl46KlrLlMFg1rhNjW0gIsP
 7rfw7VnzuhbTyAUu3Jhizujv1Fwn2cxg0P6/Us1/ePmq1i+vwOPAO6spQ
 KrXb0vKMBP+jghJ7Y0nWmAQyE8lKfcMC1V0kVK0qY1+dwf/KAA7vWdb9+
 polCvYcos/W6DnRpQeLLxfxbbIsa7Ch/DbcGEZiBZ6k8K31rhMFGM5TKf
 3WOOs+hMgabq0/iiDucPeJxcUKL7UNqKOK/YMKVlXabag94TIu4wR47On
 BqI6aQFS8q/ETjNmtNWKQpEu9AiOEyE0en+6YdXUF/hxe9AzM3QYtLtws w==;
X-CSE-ConnectionGUID: KqQc+NznRqadAEvTrIBKvQ==
X-CSE-MsgGUID: BHTK79XdQMmedIiwAQUSUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="90091121"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="90091121"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 07:31:38 -0700
X-CSE-ConnectionGUID: Q9QW38JTSQK3dF1+wMDVAw==
X-CSE-MsgGUID: 929+enCaQpukFDZBhID8oQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="279052635"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 07:31:38 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 07:31:38 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 25 Sep 2026 07:31:38 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.40) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 07:31:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R4WaEce9pg49/ltWgXclLeHsaeYGKlC8Q/eOOyHVu5S74DeiWhbqVl2r2qCr1vZkV7NVGMBmHmPVC7tXkvpALsYyjm7S8Jswziqi51R+EwJaZ3BRUfFfVNnMvoZce7DuqneLokqNcj6jzAGwJd0rGCx5BQH0brsjttvEjpTXioNoKPwymmEb0EaclgAh4szpbOJMTM5p09xoED4Tac1fxq7mFw+B0uhzvgB5yfU6acCDExb+0cno3L7Y1mCqaIOY8CyYQssxlfSJOOECDFHCTbTTBGIINnEoQXvI2817jMEh2M0+1/oFWM0gfwS9/J0ANRiAFTO/o3lcRPV8CnSyjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+jAPfhV4MD+XElmJtEVYRauCWJv0x1By3JwAoudSwWE=;
 b=APYIV5eblnup8P7haiD8DQVqdD/uGIqqN5kzbNr5oOzomELJu942UJKdmbY5tvo1OhRIAA21O3IFXhFjddRCJfJKLOOk84rXKn54ePy9DMu+LUkFAiS3uC3GOb51/w/bgavZ/dF11sw/SDumlvK4v1amU8TSxvnQh93fblpMaQP3N8YOtIYfOAcjOrIfqZiveB7/QlGgV0SgXBktkKL4SYaac+06fux3vGbGTT8idp8WRkT9dd8g4Z4vifEqT3n6zzxdSuQ8l4z1yqod/ThJpM2pIwY1MPqMg7fAu7ICUauWCY5HMcgSrr6xcYRRqNAWHgZOUliAVW3yCYorEQOlKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SAWPR11MB9572.namprd11.prod.outlook.com (2603:10b6:806:4e2::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 14:31:33 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 14:31:33 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jakub Kicinski
 <kuba@kernel.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Schmidt, Michal"
 <mschmidt@redhat.com>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, "edumazet@google.com"
 <edumazet@google.com>, "horms@kernel.org" <horms@kernel.org>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "davem@davemloft.net"
 <davem@davemloft.net>
Subject: RE: [PATCH net v5 4/6] ice: extract ice_vsi_get_num_qs()
Thread-Topic: [PATCH net v5 4/6] ice: extract ice_vsi_get_num_qs()
Thread-Index: AQHdTPGTurIYsE9W5UyANBBfRCGCbrbfWxZQ
Date: Fri, 25 Sep 2026 14:31:32 +0000
Message-ID: <IA3PR11MB8986B2B607DDD392CB1C2D6DE5802@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260925132636.123300-1-przemyslaw.kitszel@intel.com>
 <20260925132636.123300-5-przemyslaw.kitszel@intel.com>
In-Reply-To: <20260925132636.123300-5-przemyslaw.kitszel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SAWPR11MB9572:EE_
x-ms-office365-filtering-correlation-id: 98218fee-2b3c-437c-aa6e-08df1b11b250
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|38070700021|11063799006|10067099003|56012099006|5023799004|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: oa9P+2PLrVgWRTRlpGep0gDVvu5rqn0QnsuyeROt7nV1aateOEp7kqn9vRc94pwqKt/xFisjAJEQOH+Nf9P7bvSLpZBoMroBc3bzkMKuSYG+Sxz6+JvIGwDAvalayGZr7By8LzJowGt1DpzhmB9Mos49DG/G+C/151rE8iRrs7SWjDMZtKGhTlEB11rLRB1ZfNVFDx++A4R98A9KKOuXY94uHpj3MMmjoeYZaS3ArsmXbabTgAf+J5yX6cSSrrx+lzkpaE8+laY92G/Gu8VLjAsaPAzqqv+0dcjL9pvGAHT+8rgbdYWu9A6qS4f6g3cRVYuHWP+AEIdSlCcLpyxgwY75IgICCTAsE2FtA5Omsw7x3kU8eQFDAxQyFnV65azIn0+AalnXqxHPzSarodIfk7TuJMnB+N7v1zUCr8vhY5ag2cblPQHCakzri7j9+Xnhbla/oSJIc7lU7Gc63XdvLD0KtGS0geiR1BbPR89D8zLdt9YqHeoyonWKqISC8csJ16uc99HEg2XfZxkfMg4n/fC2h7VtoZ2Jwc3ZfF4JgpWmZQinMMgQDyU8T7uC0SNTSE6epR+CgKp1UdbU7zTmkPNwu9Chi8dTJuajv0ZeVmOnJvxzCkt8Z4ZRDdnvCqyiTrlFheTiVlp1baCycz6A0eP9NwC9RPmIgtjliTXEY39exE9d2jPdrLJdVKXM8X8ZLzSmXvxZGIVEi5D5p7/UTHnbTXqpB8NboH5upZL7TR4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(38070700021)(11063799006)(10067099003)(56012099006)(5023799004)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aWj2lusSYYCP+fxUOApudDzrj9WdEBjgkQgwKs2wKizcmFuxMoESn+w2uqfv?=
 =?us-ascii?Q?ShZQ2QZalhzXGDorevmrZBruSCHX6d+7pcbqpioVyeVJJwIElMH0+HIaOqQt?=
 =?us-ascii?Q?GIWSiIk1yg8+R1d1o6Lrjo/+re3DrHDPXUeHppPmWbOWM1vvfyF690qaPEZU?=
 =?us-ascii?Q?y+hlLKErEEX8tQ1JkHT0N371t34KwUX6w0cIOOTPsb7uLFL0ue4/etIPnfef?=
 =?us-ascii?Q?2V69tjrX0koEpM19dNtauDDI6Utvl4ODe+XJIhJbKTICCPhqKii7oUey76yf?=
 =?us-ascii?Q?VnpQcorv/dvAiCS7eUM7MsMcX7hou19h8rM+zcy7Zp+RtbGyNvsXuE/67s50?=
 =?us-ascii?Q?lC4LUbDwrTx5pUFxVuou6f9PBq5cpzim3kspAymL+RbFi+k/35hDBn8HFxT5?=
 =?us-ascii?Q?19LKgNTibtg3vZB58c6CaTnWp2Yu0fyYLShibgkGhOHbVk7K/V8HBZeoNq2j?=
 =?us-ascii?Q?DsPhtOQXEFnuBjCdfB+4Vtv734XQVHV+ucZah6NY70iZNs9JV0OIgvAbMXb+?=
 =?us-ascii?Q?fAfQI3ldVELZGdO6KiB4lB/X0wSPj2En/yo8+zRpiIe7cLPQBxluHkA8cy7n?=
 =?us-ascii?Q?9m2WvtCWuhALe3RjX5cJ9tbBJyLI8rq209N3kpOQVIVTcWaGJZ4E26djWieV?=
 =?us-ascii?Q?Xy2ZNwptYR7Yki64EWJLkn+8w61T4xWluEbxmwIEkpXWi9YXztR4pOZrh50Q?=
 =?us-ascii?Q?hV4FvaFx/C2qDDP0/4xPpLHSkZUMu36NpfyihgPllwTJvfR/BWKJ4aBJ+HoA?=
 =?us-ascii?Q?fEX42wmlqaSQC0h4ZSt2lfRwKrRwVShQ+3OUVZPDkuaU8L5vWJSZP3guW1gZ?=
 =?us-ascii?Q?Lwbc1VIVJqGPaSPGo1pg9PHsSamVxINZs5/0b5FMHN+b1xBpKb9WXuXmXqMz?=
 =?us-ascii?Q?QuIvSiEaIRRq5Hg11VAmTypnGvna/10TUbXYhclGE+zC8ht64vk9Y3upPXLH?=
 =?us-ascii?Q?hnuFqd6ygukOWmEA4+r78QD7Q5/CD0xCgpRnHdnC0VOYONYSOqNM+onZQsLX?=
 =?us-ascii?Q?nwVmK9Tk2yjJ+L3BMKidp2q7ORPaFwurdfi0zYh8wZ6CgL/yJTLDID08swyY?=
 =?us-ascii?Q?bvTKdx/gbBpOBtg3ecJFIfrvSpClp6tVdTu6UUvHLBLV9z0fV9Wt9gJ0+wr0?=
 =?us-ascii?Q?RvYuWi7bP7nUS1un4TUcgtQCz2m41zVf7Q8lQWmIQ5n/h2R6JTiWJiPqGG33?=
 =?us-ascii?Q?qlaLZfRqHsetX7wYex0or/UQRGXW0sZMtnyZzmUA8ZBtv/YF1/rr0oFkpYSB?=
 =?us-ascii?Q?fUHLjDBKLKs45zq1mPhqkoOfaUy8TTsrrqQ05hI3zVeiQc8oOg8i+wjzSlQl?=
 =?us-ascii?Q?vuoB67Oqw2LDaMA0voShGyq/KrqsCgvChvk3iWEDKnYcj2Ie5BmO+dlnGnxm?=
 =?us-ascii?Q?xty5MC1nc2efx0u+ijvpgVL/b6gQObuHO9HfJavsI1CFl3VFSP/EKzhtVXg7?=
 =?us-ascii?Q?0G8lefRTH1oK/y+LUE1MlpXJx7itmEN7daElwfNLGA4bN/LP337uX5RkEpfI?=
 =?us-ascii?Q?b0/QCtboiZ40AFbMqFUNqP6jVos3aEMHQGXXbS3ZMyaa1NMvPnMBAmTzh/lx?=
 =?us-ascii?Q?Jnd/lg1D2GZBu/rEYOj5fadiw6o2xGXTIcgqSI6L2uK0aze6SDooh4VAY6Fg?=
 =?us-ascii?Q?7ZgkCxF+XrNWD26xYo5KusfeJ8KyasPWAseNm84Te1D5F6pBml5QG/HwJ0Ej?=
 =?us-ascii?Q?tvCjR181kdyek3UOLnE33hR9t+u607hl4rljdfOLfZStuJ4wgx9p8MAn8xZ1?=
 =?us-ascii?Q?K3w0xabBwg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 2sMzWqD5IhKLciSHBYvqCf2z/hxD/a4v8c+DH+1XlI7b5bAsfApRSlqbUIyEjvugmlhlejJsgGf4Wifpi++Kf3gtxu3S+Sdn1mwa/fkBWcb1nq3nQ4H1cdewllrbVLKmrVPvQlVLlqjBASn3XNX2dLk/bFDUGDwzGS3AphO7W4leP1MiHRruBZiZus13YsW2aUYoQjxW/RAflyvPLN0iqzeFYfFJXRDFfH/glfDMExVi7Jk3xFnP1N3nMb84+nq/8BF+KJMr5L7ZdljwyrRBmksCEZ/WOoEkbY76eWPgbJ8qHpHwXrTVwutJEYU11J8wOsUMB6fphzD9s4XQgBMjGw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98218fee-2b3c-437c-aa6e-08df1b11b250
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2026 14:31:32.9581 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dr5dsZ9LTozUNi16s6+AAJDFTlDk9fVP1hqYwGf/Y2/aFtFyaQ7zTLwEiXKf8V7DFeMZF4kjF+yvav4xYbwCEWoNQy7wmt6ACgae3W4e2pk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR11MB9572
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
> From: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>
> Sent: Friday, September 25, 2026 3:16 PM
> To: netdev@vger.kernel.org; Jakub Kicinski <kuba@kernel.org>
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Loktionov,
> Aleksandr <aleksandr.loktionov@intel.com>; Schmidt, Michal
> <mschmidt@redhat.com>; intel-wired-lan@lists.osuosl.org;
> edumazet@google.com; horms@kernel.org; pabeni@redhat.com;
> davem@davemloft.net; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>
> Subject: [PATCH net v5 4/6] ice: extract ice_vsi_get_num_qs()
>=20
> ice_vsi_set_num_qs() mixed two things: deciding how many queues a VSI
> gets, and applying all the side effects of that decision. Split the
> decision out into ice_vsi_get_num_qs(), returning both counts at once.
>=20
> To make that possible, group alloc_txq and alloc_rxq in struct ice_vsi
> with struct_group_tagged(), which gives the return type without adding
> any new storage. Field order changes slightly, num_txq now follows
> alloc_rxq, but nothing depends on it.
>=20
> ice_vsi_get_num_qs() takes @held_txq and @held_rxq from the start,
> even though the only caller so far passes zero for both. They let a
> caller ask what the counts would be once the queues the VSI currently
> owns are back in the PF pool. A later commit adds the caller that
> needs this: the rebuild path has to size its ring stats arrays before
> ice_vsi_decfg() releases the queues, yet the arrays must match what
> ice_vsi_set_num_qs() computes afterwards.
>=20
> While reshaping the whole body, drop the kernel-doc line promising a
> return value; ice_vsi_set_num_qs() returns void.
>=20
> No functional change intended.
>=20
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
> v5:
>  - drop the stale "Return 0 on success and a negative value on error"
>    from the kernel-doc of the void ice_vsi_set_num_qs() (Clashiko)
> ---
>  drivers/net/ethernet/intel/ice/ice.h     |  6 +-
>  drivers/net/ethernet/intel/ice/ice_lib.c | 88 ++++++++++++++---------
> -
>  2 files changed, 55 insertions(+), 39 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice.h
> b/drivers/net/ethernet/intel/ice/ice.h
> index fadfe94bf1c8..f1ba86d066be 100644
> --- a/drivers/net/ethernet/intel/ice/ice.h
> +++ b/drivers/net/ethernet/intel/ice/ice.h
> @@ -403,9 +403,11 @@ struct ice_vsi {
>  	u8 rx_mapping_mode;		 /* ICE_MAP_MODE_[CONTIG|SCATTER] */
>  	u16 *txq_map;			 /* index in pf->avail_txqs */
>  	u16 *rxq_map;			 /* index in pf->avail_rxqs */

...

>  		break;
>  	}
>=20
> --
> 2.51.1

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

