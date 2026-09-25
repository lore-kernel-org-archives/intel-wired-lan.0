Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C35C9830D
	for <intel-wired-lan@archiver.kernel.org>; Fri, 25 Sep 2026 14:30:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B9A218129A;
	Fri, 25 Sep 2026 14:30:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MC2MnTCxOD71; Fri, 25 Sep 2026 14:30:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 156C08132B
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790346600;
	b=cIIEHmkAJR1TlvajY396yGrLnrLvhkwbVxmMB2q3qZBQ3CxlVbOtSEJbTPBI1zniZvZp
	 DR2MbnVjXJpvZg0h6FV4kBXP0KTZs2NCFZxIhQykSH+BLEzVUw1QE8IBuQXBJ2Md3QCpF
	 RDgMyT0OK6PI0v8UsOWJJyk3V1EIaz+jd3N/drIm/0EYwhAWtaBqnuqHJq986ekNMXD8J
	 wF2aNA0xM5pxZ1BuNes2kHOG9nnwQs4mnEEhN+4uMeeV6MrkdhYQ8yisdEGed65HIlMR9
	 alHC/UwZI0cVvH2eCuOCBRwlxZiE0CPivRqHdZ8MrR6zkwN06JS++BcVhfwQMTrhC4w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790346600;
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
	bh=kkKH25TLMHrsnoO4wAGlC7xEQhbFumGDT1ZvrvEiD6o=;
	b=YMK80jPvb6XNYn5upo1B+IvFAlrDzL8vKUgPShpbyCSikOSQYWdipZXAFVuFpBNKAOIw
	 dfxhSYQOli7cq1AQdkc1W1WgEXG6WME5oo2jfwmRXUVBopMfvlp4hpEoSv6cBRpOeFFlA
	 R8Ql6lwR3EeY12KxkutQs+utuZP/G6M0nzjG7IPvDYo6Cwzq0q7VdOU2Fpplor8Jf+zXN
	 yk2J4tJNHD94RG9RyzlTN7X4kJ1RztRwhMHg7rYKeNeCeLx1IX7mRb2N/gkmcqVTv6u3g
	 W7a1xTbb9wsRFvdPOthCOFBbWErl33DWQxwr040slVhAfQCAZkGBeKUBk9/gRtimflQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Jol61L7t;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790346600;
	bh=kkKH25TLMHrsnoO4wAGlC7xEQhbFumGDT1ZvrvEiD6o=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=db3wSPVHDACW8Cd4IeVnhXi9TCWDutGzvvZddm1hI+uWDXuGr1qIpMHcUa9Jq2nI5
	 +Ptb0uNFabtUMtvLv9qUynDUlUg+oUYBe2xdRPkmfOrFul45Zo4KrRvgxl71w+mYDz
	 yUu57UjrcmoJvq/AfaLnCOPh+7nsF4kRkPBgbI+rQOgcv7mfGw7PrsWAjKR0UcA+OL
	 yOYBOstrynWqa5VhUbZqjY8PPgU0MR1ilsBDpXLo+BzR5gsLRDqfDL8R9Lk4q1Y+c/
	 9IoLRo8DaXiOZUr9AgA6+zxhQD8Ra6D1IDChAluFGz4pJGdmb1IsbytsP0Ke+xw4pn
	 jdV96+WWdtMRQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 156C08132B;
	Fri, 25 Sep 2026 14:30:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 12037194
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 14:29:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 037B98132B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 14:29:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EXiKLSnkv1_p for <intel-wired-lan@lists.osuosl.org>;
 Fri, 25 Sep 2026 14:29:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2880B8129A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.19
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790346597;
 b=CmyKL33uH5+NmVjCz/LuV0wlEQkqMaNdZb7XLdUxCjSXovOsWiTLj9CApvpcLeCW7Cer
 j8j2i4FI5RQnx5JCXszpc0gQ5B9huYpBc8o1UyJDAoOH3P8kQqgwkXK4EcN/nOO5NMEd4
 sJONgH2GEuux7lKO6t4IbPOUMCNbgKYvIJJbsx6fy8tINrtmwryb7RsZ5sS1c2Q+72nY9
 sU7QCTLmo628jqOQK+fmgvdSxmjrqKSs2by77kWQZYX+6eDj9slmZtfrniAWYiUqdiQq1
 XjKk4UTmDiY42D3tIxDLdK5v4I6oCvpi+YnWGwxX8/rSgQuHkaBU9kOceBzCRnXGWTg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790346597;
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
 bh=kkKH25TLMHrsnoO4wAGlC7xEQhbFumGDT1ZvrvEiD6o=;
 b=aZy7MvpSl73831x1QjM4FLY5SQZ+AbpAvDAEwvlDhqWbYp4LGoyUWjbq26MS5gbEIFZe
 rJWLAyOy5ZC4+rjpfJAOu82QXSkymTux2yCV1isu+m7b97ftpwlUjvy2QdrIb/cg/0p3A
 uoxbHQOKNPbANGULihZiavXOc9LdLiwcKlyo6tebk4XimilRtwsCAgqkj9LWk0yEm2raa
 snhiq6xpM1OrGFInUFpoZw/BTC+N81N2bKr/r0O9occGAjCG6za+WaarlL7iTs1GSB5hi
 4jD4k2w7Av4Xv9R6J/iDhsF2mW9GSikgIJGekfz4QY7f2u63N5RDA5fwlAN4owt9DUw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Jol61L7t; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.19
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.19;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Jol61L7t
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2880B8129A
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 14:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790346598; x=1821882598;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Tg2PLFi5PYWfCQFNV2cCIaRyDjiprbEi5LleqlovYOA=;
 b=Jol61L7txta/9DyATe/A0nmvFTINzSYuOt7Sesj0jTHwMyUN6G6JxKpJ
 fNSR2fvI7yDuECBiB9vj93QmI7Hzpmwic06iH/PCusRyYloEWfsSz/cIk
 0HO5LaxRSsLszKhiP0HXQrEyZ8L5xQw13ki2W9hXzaeB9i6Y3wWEGnAar
 hR9ZQCs3ZKO3b5MdiET9chWv7noyE5Bu5m3SowmHQ7pYpNl1a8b6Wi3t1
 UzFBaOSvigRYJa8Ewrhqbf7GEWSehO48mwlBUuDhKnj9T8oDdFj7XF9n7
 yTA5f4e9wFbAYJp2JK8Z47cgPUf6BK2/fPfiaaXLVEc7rR1NnFvmiNHnJ g==;
X-CSE-ConnectionGUID: p0w2K3UZRIakl9BoA0PRZw==
X-CSE-MsgGUID: MjrzqFlWQy+4uXasGEJnOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="90090944"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="90090944"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 07:29:56 -0700
X-CSE-ConnectionGUID: Lp7djxwlSc+HyPZo3ScOeQ==
X-CSE-MsgGUID: Bg7vcnpxRiKuXAOcmDgsDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="279052281"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 07:29:55 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 07:29:55 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 25 Sep 2026 07:29:55 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.3) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 07:29:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JVZINY0zHscFpR5b20a7HykzfoKJVI48FaNNoaWbsifDY+vPzl3d88obiujS1RE4q9cVZs6CH0HBoAjJN+wwVR4kHV+2dvGBs/MlYdxrBZ56hjnO7qHKIYS0cRWkF6q8vaMjly/iPenq2bbV9G9XTxGF8Rh9WueeBYGojgsITQ8LR4edBEDI2JGHDLiXxtjVPSP34WP3MhIpoPJJXaecbZyuxYSKLOFN9RFoZTUSWMjd/V2eJEgUoqdOW5pOCIL5U3K616Vbku1qRDS8MT3mbIQMxHssrHrAmFkMk+6gWqc4hZA7qd89ZR2WehApqkVoi0QWR3BOlJIcqdBFITtx/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kkKH25TLMHrsnoO4wAGlC7xEQhbFumGDT1ZvrvEiD6o=;
 b=clDgG8V+5874nV9E6Er85mpHPjPK/CEbHbJZ4S3F/0WHj75iOCXaO8O4JhFbnes3hdgtz56m3yOeZeawKW3O0CopbhgFIIsDSw1zM6MsNvcDhrkb5xk+ufAOoylzgycMLU8+WrFhxF8D/t/B/VokRFZvZES7uSjiPWLw9FRa19d9Odnx2g2HFAKxrS4k0bd1ztS95aOMPUIMRsAAtrPGUURnqaGzA4ItLR+8EHLt8hD7mIlXZ0IGoSEFy7gv60I7R3ZSEjCwMmWpK9GVBKb4CBwwoEOG6A0KYYjOAxv+uuXsjkbEBalk05pVevOyjoc1mm2VgHRZYzZulOTnAGWAjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SAWPR11MB9572.namprd11.prod.outlook.com (2603:10b6:806:4e2::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 14:29:51 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 14:29:51 +0000
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
Subject: RE: [PATCH net v5 1/6] ice: skip stats handling for channel VSIs on
 rebuild
Thread-Topic: [PATCH net v5 1/6] ice: skip stats handling for channel VSIs on
 rebuild
Thread-Index: AQHdTPGSTUxh1iMuyEqVcnZ3gN56W7bfWq/A
Date: Fri, 25 Sep 2026 14:29:51 +0000
Message-ID: <IA3PR11MB8986BC24C4403CBAA28B8092E5802@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260925132636.123300-1-przemyslaw.kitszel@intel.com>
 <20260925132636.123300-2-przemyslaw.kitszel@intel.com>
In-Reply-To: <20260925132636.123300-2-przemyslaw.kitszel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SAWPR11MB9572:EE_
x-ms-office365-filtering-correlation-id: f6ba2a26-24a9-4902-cedf-08df1b1175c2
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|38070700021|11063799006|6133799003|10067099003|56012099006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: RPULwszzDsrhs8kG9BgqvYRXbriTqD3EwDdr/efbNqCt0+N/Ox3m7lGivP1zjA6vF5b/+gVDEWiQWOyJObrBrXq6Pi03JFp2O2qVo+KGZSlbuU/gYlXh73r+ya0//XYnCi3oHsGStdRce6i2LoabInNFakTl5H/upfVht+mOrstw+qHulOP18JjSfM1pkMG38Ha1W00k7u7ES5ciSdxYxGOQYoLTpLPBzL4vTO9eIp/0Z5bl+nnJmKsTraf9Ibz3EEFThvRua9lz1L5qn/WkrELfkX96+iihY3oD/jL5aC0MqFdkC2J4fuF9Wu455N5joQSJNM59zs0N+QJfqNY0LOE+U6UsIUnlO79XljU+v2lZa6bz5EAiIjh2/i8VLNYpwbLa9qpzrcHdcXWtEnHdHY0aRnV7xUK16Ix/7jpHRQ6eKJtCb+mLFtjvyCieypdXuOgVHsrHrq4GkTD4Q8PyQf/HXvL1G7Wo8fJpcVma2Bdm6tSf81mGEaijRlsMsEvwzwnFf+wb4moBf0BNQxRB5ohDjKKuvVewjT6xQIGaNJ9MkIWoNNCH0HdP+cZ506rCUq143VjHGydAmYbPca5aQ529AKMy+HOSdwIORccPOkKo/BeCkQgV/3zFLJDg40naI6oVZ3hySoE5Q6wcgAoF/xG0APeooUaMISI4T/nvP67N7MH7bJ66j6N4RYMkgJj5AZiCwT04DSeqNSTu4OTgN08FRXdGMPdjuOjDgu4yp4E=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(38070700021)(11063799006)(6133799003)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4Q3YhcCQOm1UoC2EtbOHtb4cEzGQxIxYELjEu2UfwA70XIgIb6oSQ98TjRdD?=
 =?us-ascii?Q?PxuhyTzHLI/7149qBlbLrIRPi2KLjw+2wBfSlLmm/0AgYPM6yJMYmiVcBKHt?=
 =?us-ascii?Q?UQJ/N9aWQrmpzNBanFW3+ORZNAmCRiqkf1QO0V66khKz2Kg0qcjyFBGKZ4Oz?=
 =?us-ascii?Q?GXnE9uu07ePHaoRcjtOwQCrsLbJsHrcMsKmOVvLPLFEa6FklvyNjboJAh7lk?=
 =?us-ascii?Q?OUimrSlDw5maCNdruCqi3t2i+6FrtkrG3dqlDEGpHVr6QeaoRUJpOaFDNpop?=
 =?us-ascii?Q?QatE9NGl1NMBGjZBw6JJZSxuir8LaLq/ejThRYSobskZ7cZ6Y9jbT/aBcwEg?=
 =?us-ascii?Q?5cAOUmKydOMj8PebbTcMId4MsClpcF9oAVy5Rs8rY/G0avT0Uks4iExuDQ44?=
 =?us-ascii?Q?b7jS4U6YreoTXNWp0ZQ5XD2IrTTCn3Gbs5QfjPvjiTGfNCD8l8I3cdBU8QTg?=
 =?us-ascii?Q?ORf/meqhE4fgetNUh8Xnor85oCOs00eLp+u0iUsr8/h92juGEGV2QGvKmSJo?=
 =?us-ascii?Q?0gshQi6KKIW9l9x717xxknA3EG8Gp3D+zWB4fCI17eB7RGGMzlMp3tmkPg5D?=
 =?us-ascii?Q?ASlgv9yducEAhjdURyyb55rwxfrtia3IxqLmk3xucqhMb0wq/4VJTKAMrAcI?=
 =?us-ascii?Q?i8yXutRgzMrORKzjtYpMDN0Me0oeOzEXiWjISV3iJ3zWG/AqDL4AYedAuYS2?=
 =?us-ascii?Q?O7f2M6trPhRyZwgKCA04LPMylpZkbGlO8TWaV7sh4eW9vrD83zxdqtKpZuIy?=
 =?us-ascii?Q?pqF8e49QUlUIKOLJqS4Lkgcm4S4SkygYUJaKwtAUKZIFVCCRf4WStvY2rfLx?=
 =?us-ascii?Q?n5UOq8rPm2Gc/WYfXPTbPa5230NS/Gi9RpCu7AqPtCD0/oTqCi98Fj63gciN?=
 =?us-ascii?Q?9UuceswITAvH2hGlbW+iEE6UDsMHyCq6Oer9SwAbL8O813FXagyXFIPEHAYA?=
 =?us-ascii?Q?2vFsXkT58xWonus6sGJ6K6Mznye+38l1Qtxn8s6JwVdxg4vUEr8vlZ4FtuOv?=
 =?us-ascii?Q?k2oXnc6+RBO/yETjJtddqs6b+yaCNGP8RPdg+GGyB+bpw2xsRnRG/OfifQMR?=
 =?us-ascii?Q?BrMokcc8rCb+9y24cp+Ayrp2BYEeqk3QNVjqPDgDAzvxpFWKt2qtEw2qsSUB?=
 =?us-ascii?Q?dZEHWXwk2JFSpVJntumX2PFwCWtu/Iit49llcC8FbrsKum4sKmWYaDyoYto3?=
 =?us-ascii?Q?0+9yIxFZFacYHToUnvTcl9oqpicGzgJ/CjNatKdBHJL7wPr+3mUDYyFJ7u3J?=
 =?us-ascii?Q?YO69RXZlphEQAybBY0TUb0BAZPYO/ZS8LVj92BCA6Xa2ya+/JDjbKtV/N0yd?=
 =?us-ascii?Q?dMg8Z+AHruFo3IXA/q0gIH17l0S1SgFufF7u0oQF2N0G1iYZNq7Fa9gB1IcN?=
 =?us-ascii?Q?qWK9Cy/IXS56EOh5eVCNRa8T47lJlu+NtecgXmzF2APv3ni/B23leLagPSuZ?=
 =?us-ascii?Q?lrZCMyyP74TrAVlnowCpgOtJxuEtrcOR+/C1KRIHsxry6Aya8V5jngJ6rmZ8?=
 =?us-ascii?Q?vqirTlJSAk83udI40OS+oqCGd2wjCulSZOVDTfFzRE6t4dAmy1qYpD08rSOL?=
 =?us-ascii?Q?leU0I4cpF4qwKndNiVNZPLPdHKbdvOHOXmBEmkYSS1FFvtrF39FWPm6a9QNC?=
 =?us-ascii?Q?MZXW7aRjyWU0TA5CshpYlDK0vbUnECaV0DXhID/wWStNFbP7KSJvekZsFC5O?=
 =?us-ascii?Q?GuVMmb/rnPsPY7//Lpe8u12smdKgtb4DhvKVEv8R//N0j4/hF719ttLlmTrY?=
 =?us-ascii?Q?q+Kkj4w/Hw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ZVKlC6rBT5GcQw4NbjPMX2TqvzY8AzWuylM7Xl6aE1AY06Q+ZSqENJDI6x+Z8rECDi55ANyWB9Kr6qmm+3mc3WVBHz+Obt2BJ8B9/MnFVLj/6HFZeLZuik2NOiruwEM/9ocWZI6ekPm2fDqVKPEqqEAUEha2JBF0opxc0S7nT1e2nMNgeBgocKFB2rZbwea6fK+KtQu8XJ1f+NRGHT5yJknkZGjnur2986oEE21WuCVY96bf9UO4AArun06c0rOZ2V14bRSjsdpb/WsN3t1iA645xqrW3DMQqLEJnTkGUy/9vTGsRxMjQ5Bt16jUgwwTrquikifYmq+YUBmXNucMtw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6ba2a26-24a9-4902-cedf-08df1b1175c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2026 14:29:51.2998 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ++cchGyafpb3A2TDGGC7JmneIF+MqKKpHmmyM3E22bemFFKbTJIlxBu10WlZAxiVM3iSYMxT5J6A7NYvuTqhAjcAYrGZw+2szoCAEMk5uXE=
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
> Subject: [PATCH net v5 1/6] ice: skip stats handling for channel VSIs
> on rebuild
>=20
> ice_vsi_alloc_stat_arrays() returns early for ICE_VSI_CHNL, so a
> channel VSI never gets an entry in pf->vsi_stats[].
> ice_vsi_realloc_stat_arrays() dereferences that entry unconditionally,
> and ice_vsi_rebuild() calls it before anything else, so the NULL is
> not filtered out anywhere.
>=20
> The path is live. ice_prepare_for_reset() removes the queue channels
> only for resets other than a PFR, so a PFR leaves the channel VSIs in
> place, and ice_rebuild() then calls ice_rebuild_channels(), which
> rebuilds every ICE_VSI_CHNL VSI it finds. A PF reset with ADQ (mqprio
> hardware offload) configured thus dereferences NULL.
>=20
> That combination is reset recovery on top of an active mqprio offload,
> which is why it went unnoticed. It was found while refactoring this
> code, not reported by a user.
>=20
> I'm leaning towards removing our limited (compared to OOT ADQ)
> support, but it's outside of this series. Bug could be triggered by:
>=20
>   tc qdisc del dev "$IF" root 2>/dev/null || true
>   tc qdisc add dev "$IF" root mqprio num_tc 2 \
>     map 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 \
>     queues 2@0 2@2 hw 1 mode channel
>   sleep 3
>   ethtool --reset "$IF" irq dma filter offload
>=20
> Workqueue: ice ice_service_task [ice]
> RIP: 0010:ice_vsi_rebuild+0x289/0x380 [ice]
>  ice_rebuild_channels+0xd6/0x320 [ice]
>  ice_rebuild+0x4f6/0x540 [ice]
>  ice_do_reset+0x9f/0x1a0 [ice]
>  ice_service_task+0x4a/0x460 [ice]
>=20
> Fixes: 5995ef88e3a8 ("ice: realloc VSI stats arrays")
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
> v5: new patch, split out of "ice: rebuild ring stats arrays instead of
>     reallocating them in place" (Clashiko)
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c
> b/drivers/net/ethernet/intel/ice/ice_lib.c
> index 9e08db376d3d..31af378aa0e7 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -3031,6 +3031,10 @@ ice_vsi_realloc_stat_arrays(struct ice_vsi
> *vsi)
>  	u16 prev_rxq =3D vsi->alloc_rxq;
>  	int i;
>=20
> +	/* channel VSIs have no entry in pf->vsi_stats[] */
> +	if (vsi->type =3D=3D ICE_VSI_CHNL)
> +		return 0;
> +
>  	vsi_stat =3D pf->vsi_stats[vsi->idx];
>=20
>  	if (req_txq < prev_txq) {
> --
> 2.51.1

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
