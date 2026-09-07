Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 185ABC79F89
	for <intel-wired-lan@archiver.kernel.org>; Mon,  7 Sep 2026 09:30:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B4A91605F5;
	Mon,  7 Sep 2026 09:30:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9Ov_yxMfIeNp; Mon,  7 Sep 2026 09:30:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E90ED605D5
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788773450;
	b=WR8j0WHfZHfnipaLY5FYv7p++A2Edk6Ea9T/2tsExgmv1fNhmjx1XiK6CmxItSKcNHGv
	 T6t3xwdfAI1MBQdnb/hx6NtVg2LvvuygoeEAPka+Ja6+FucXcGla/MYOPgTlRyrNuBBkh
	 zlgOsMiuyb3z1m1cCNa7+1mY37EDvdZlGsjpR6xT6fhYJ40Yn9aKYiW4u+YKgr7MFZ9Qg
	 lJyPswljnQqAQHOtKPg6oW13VP0X5eD1JtdpLKPXu5wCeySpQGFH6nDXFzU/CK84LWrru
	 sVLyu12XthwxO/xsXnu+9YlBq1okdjQLZZlPPs9Y0iCj2JI6tcYXaLDSmGbnxJC3JxA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788773450;
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
	bh=4job4vW/NzT/5QnpWg3v6wwYZW2MDrkl6jWTrAb/QEk=;
	b=NYZ51cz/rljVWRBhqeVjfqg2umoPDrN518IdrZrGXLcNkEhdDDIrLpoaM/HWXxZRclzl
	 GT44imWhKZQ85x5Umqhgc3TTA4d2s6mphGkCn4BBdeGtp1/Ov6D5/Dg4FppR5+eELcQkb
	 6Qhuigx3Nl6F+FymW9dpKenwnc0DzwfSkWSpzD7YmAeaR5HrqlhKwpQlMENPnMtjPeIuY
	 MkA6bESDiFkKtQ4KU39eBQ3UUFISk8hjInHrxkk3ZYQjM0GcNf1T18wfYqQp9WEk2CvUD
	 dk9W7t/T5dQCuwZekxmArnW1pPuIX5UyeMOmFylh4ckbSDJmBjU6XgnEwI1W6vVq8+g==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788773450;
	bh=4job4vW/NzT/5QnpWg3v6wwYZW2MDrkl6jWTrAb/QEk=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S+mmyjZpAk9mkSa4QDXD27x9CBl4/f7MQRiGimjF7L/0/4OZCVB7l6n9SndDNL+OQ
	 Fao2A/nMp3qUV+p2mzSfJSYic4ofOmCuotxOgS884eC1x/eXINiYL31IiN0qqaUIm8
	 YoJhNQnYOf9sotkkz6mkhKr1SuERQlD+o/qBnsVGDTt2gLLpfEKgcynUM8CCkH9TYk
	 5nEmomrlJkNrwCrz+Upli1jzE1OENWGrPzb5UXQGIYmwxZGlaFdxdx6QIRfKB1XMVz
	 GLzf85xu9V43j8V/4JZXokOtNCZ2CQqlziraOLTFCTx9LjxvgXFZoKsRRbsAkux36B
	 j4QRCKM6RWRUA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E90ED605D5;
	Mon,  7 Sep 2026 09:30:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4AC8749D
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 09:30:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3092B80C5D
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 09:30:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ihl_5TLJKSXD for <intel-wired-lan@lists.osuosl.org>;
 Mon,  7 Sep 2026 09:30:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org ECC6C80C5C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.9
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788773447;
 b=lfxaY1XO2XnwhA80Pj5PmicsWx35L4IuJPrgk0k6T4T9HFJiY85DjOzBvCqPv8JFqAvm
 4e5tEGJgZQemeIgqFAh6LQB+t6BjqdQYJvgbzarXeQ3cNyli202qPPz56lmiARytvD/bZ
 58Pt+MztVvjL8Xv04bL8L3WFkFmdOIuHasnov4cYFQG3mITkR7yCk26e7u6NmHP7PRPHg
 lmXybvKqwNBIpfDtnzK71pW4ALIUK0+ZzHbps2ZThX6HOXtc+LNs8zP/yC91DYbgHvv6P
 fCXgCd6f3MECl52+rSEqTpur6ENJjgHjAT7uceZbCxpfDJ9yOBz++/LfthGfIFo1K7Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788773447;
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
 bh=4job4vW/NzT/5QnpWg3v6wwYZW2MDrkl6jWTrAb/QEk=;
 b=Q6vkXgolM4aJVf8cv7d5J9aF+JX81LPYvrXf/Q+3EPIQua8PrGaUGO9Yy7qrR+bgGGK9
 0AYmR80Jf+cLoL2OUtbdaZVJOiXnv+RSC4kclXW0XePy4KdJ+6N5zbcmP/NLJtKPtriAe
 Cm6+GOAbGesnxGzE5KaQRCYUr5jZpyhNstMIS0jxtWt0+Ez8qHs3oY1Xw1xc04+/kwc/p
 V6JpPY30+vC62eNgrvNQO/jdxvf8Ht90sfduvrkutLaZ2k4IR4gqjbtbIPQEn32HdBLjb
 On2O7xdkK/zumvPoEIODBujbFMtvgqhRimAhRAt6ubCVdpPeS6aU4RQ8InQAQQwdMew==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ePhOR4Os; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.9
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.9;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ePhOR4Os
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ECC6C80C5C
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 09:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788773447; x=1820309447;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=G2/eqbuN1pSMgygwz5BL9X9rvfKklGADTIL5941ywj0=;
 b=ePhOR4OsDLyoK6Vy7D1F5ICAcwqTK/kx1j2qKHrKPkCXRhndpUE8x6/9
 fgRUoNoh5y8ZmR+inMP+oxOX5kGwV8lOt3Zem1dLMeEzFcWKhf66TODo+
 Hk5YOC3ZqQgbLE1B2nbWhPhvAjulIvASR1hjNxDrN4VJq8pDTEFvG5fZl
 86f8mXVtqkRT3YhCeuqiEBjrStr/58/FJiCNdFKorWljF12M9C6tu58qp
 GNmoGKbHzaMU/S25MAXkXHNBw6+qgmb8Yb+28f70tW5tp8izw3jypx3su
 jFrLLOoWS8rzXBEJooG+X+unq5+2BTDM9Xpml9rewEHiiQ5CLDRt2VtWf g==;
X-CSE-ConnectionGUID: uEG3TxtCRVuSq8d2xu9yjw==
X-CSE-MsgGUID: kIEs9exfRYyzNkOafslrLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11898"; a="111950372"
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; d="scan'208";a="111950372"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 02:30:45 -0700
X-CSE-ConnectionGUID: R8Tute09QaStB9QpEiOPew==
X-CSE-MsgGUID: JUz7VqAyQreFTI3TcSFsNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; d="scan'208";a="271176256"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 02:30:46 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 02:30:45 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 7 Sep 2026 02:30:45 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.14) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 02:30:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a/A4MQmYP9g0KvhBoN3FQLEyF1zyRO3NcZXcWcLEeO5DKC00vE+6Ux1TJ272Ztfhgj1aXphQ4k6ol5ZOTarjr9jaUUa4G3E0ShywhicXlV1fJUt7VnbJ52zG/m7iCKU31gyK5yoagSJQzbTyQpkfrlbCzDV9lHruQumB85ewNHr0OC0RdW4nhbfkhPrZnFzdf/NxOV9yDZ936sFwLppGdSV8QLLYJgN1ayH0S6WFcpDxIAWGJghjg00VfbM97MVPOoion6kLQc9CDMFbVHhq0REW937zxfSaPQ5C2iYUJdYanotlTDyhr1mpmDW1rOUuZTD5Yg3PF5+U3ZyJkg35OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4job4vW/NzT/5QnpWg3v6wwYZW2MDrkl6jWTrAb/QEk=;
 b=Hi1jz+W0DYsWCK15MzF49LvQkJNd4BvMousoegB2s4vwiO4PT3jAl9zjXLlTlDjV0NOR7YMYF/+ilmC4rWVRTj6hbfmrdKeDrnJy52MFphGtBUv1hJcLYmAzn2MC1PwFfrKZlGaFtVGSL0J3NF+4kDI8qeME5qcqa3BmPPKZ2sXbqr5kuh9My4vp6T7g/dweF7/tX94aCuf6uhZzsOWRFP3Di7ZxMaMJOLhEFFNY0ris1I33l3huZO9M+7P5fwGmPKMs3Dga09CA7XV5aljp4+8xrBrWadq8aNQbOV0kWR37OZAQY0tAS0zu7v6xJMEz1rQh0h39mrPIeDTo55Za3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by LV2PR11MB6072.namprd11.prod.outlook.com (2603:10b6:408:176::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.12; Mon, 7 Sep
 2026 09:30:39 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 09:30:39 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
 <kuba@kernel.org>, "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
 <horms@kernel.org>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "Willem
 de Bruijn" <willemb@google.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "Hay, Joshua A" <joshua.a.hay@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
Subject: RE: [PATCH net-next v8 3/6] idpf: support pacing offload
Thread-Topic: [PATCH net-next v8 3/6] idpf: support pacing offload
Thread-Index: AQHdOwd0zdy+Q+hozk61dck9ZI0iZLbC37tA
Date: Mon, 7 Sep 2026 09:30:39 +0000
Message-ID: <IA3PR11MB8986BD23939D98382AAC3971E5B22@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260902181747.2483351-1-willemdebruijn.kernel@gmail.com>
 <20260902181747.2483351-4-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20260902181747.2483351-4-willemdebruijn.kernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|LV2PR11MB6072:EE_
x-ms-office365-filtering-correlation-id: 564516f3-15ed-4b65-5fad-08df0cc2ae0b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|7416014|376014|10067099003|56012099006|18002099003|4143699003|11063799006|6133799003|22082099003|38070700021;
x-microsoft-antispam-message-info: UYj6cuq1dT80ajCElKn7KrrSUn3sBwsTlFT+QxVJArkG3cpryW2bf88NGG99SYWMwtlnbQZ9uYrPp+V7QycirLO/iIIZJClpcVE8+lC1x8iecvt6LPmeuPN/u2dwg7+73l3jgdXiBfrnLc1+G8B37noAr7WD2+Ar0L2oDw4HSc+SLtQIOqDOqDP1s5v5UTPlUbQ1CKBTiZxmzAschCrAhzkwm460jwvv+EBgqaIR/pMAQkymibrICPwjsIialATZZ133RXoR6y+e21E3e/jaelaQ4hQlCTFHg2mHLw38ebDD3fOvnXsIYN8QcoF+UEVNUJ02Bt+mS08zze1FmdB6pxOfZAHyqAZGxT7FmhaFhG+7HAXuu1G5Z/Wmy/w5dLjrzt4uGIvSOWh3FRwSozOlbwdeYenouBksvge76D8fNkn/gBdEc8uAcyvegpna4jry1wY0N2U3VeS8yxIItX36nM4tA6fXcL44Wfuedr7X+ltni6if217PG01S0y8/QYkoCkR8NgsoSeA6Rl6cKPL7i5xHqGset6xt6FSp824Jl3MLwcZk1wYZSdyRG5KqJNbki2spkja+eIb/SbsnStErPSbN9RLyhy6ZxtZnN12G1aDlwAoVT+0YJXaaiUrev2YJYad5156dLiLEWKWv3leoR6Z0OjtILGbuNBKEmHM1ezPyr//OkqvO64lBF9DxmTfNhA7i+Hivote5fJlROPiS9A91AySKMhj2ig+PltVsG+g=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10067099003)(56012099006)(18002099003)(4143699003)(11063799006)(6133799003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UdqD+lwLo+fYFQlsqRvepqG7bjgkX8phnrp1o949/qjDKHSruyXbC8uAhxSP?=
 =?us-ascii?Q?Yy2iRQRA4KXnp9Mi/BQ1c5DiDvMdPFuRqofjMs8a9joSlf6GTlkcszZv7Fv4?=
 =?us-ascii?Q?6xx+6HW1232LHFLzFyOSfWkqy3kGJbQmdkQ+mh20DoUPcLCVaYtwpvSEmWix?=
 =?us-ascii?Q?nQYOriz4uxFAWDZWiZE/UkOJPD9AKwqzebMIw4AJZz8PSNV9EP9O752NrjlR?=
 =?us-ascii?Q?Ml2er7/Cn9YJxND4VRpC0FUr9QdDLvPbXwquCH/ja37VH/rV9/o3bND3+sDL?=
 =?us-ascii?Q?WQqE/sWCa58B5edGDUXQwqgaf4kPilUTt2/wd90K+PWJR6ovfMPCKJRrH18N?=
 =?us-ascii?Q?vFOWvdKUYIxwBtPbqof1rxejvpcJkoItm6gj7iRIz1YznYEk5dhb574P8E49?=
 =?us-ascii?Q?mCFu7oLXSoGjvls629E4yyUxv8IpqyTC8yr9LHRi/uQj7UGoXUOGDMhssnnn?=
 =?us-ascii?Q?CEHlN6b2JHbvGeZhXVAR9+Ku3qT+UrwrWvfSTS4acnvU74SkCVx+KXMFGNqS?=
 =?us-ascii?Q?N9Au4mYo71ZxhBZMP+h/hUu5R3h5KlTl1dtRS//O5+gdGz0xxdUpa/PY299S?=
 =?us-ascii?Q?DLSs4Tnqg5R9fCJD1oc4XO84w8Nbv0AHlk1PLC7BX1Fb8UkdXZVqJPut2U6X?=
 =?us-ascii?Q?Hxh2+yGAyccAFDhvyhpePdlZkHQsgl6C6I9/cjxXsiqiyEYDy+b0ZglkYbas?=
 =?us-ascii?Q?vzbqSQeKAAVjKgzeTUtBH7SVnENMQwOTH+/sW/jJpsnV+lJQ6SzB6/ZrjwD0?=
 =?us-ascii?Q?gW91FeY1CU3E+Pg2+gnxLMAUCL1Zf6Lmd2rInEnbhj8967/nGAAVyPjNgXDo?=
 =?us-ascii?Q?NNQXfjkanafLjgiNAOYepaCgKn0iadv9qVaZ4NymIUJMSMeA7BDF6zsAiWFS?=
 =?us-ascii?Q?tJIDi/EHo7po7kIsc2XZvnoapvj2oSMaRVs66OIyVEhH7Q2FFI6t2bjtZc3g?=
 =?us-ascii?Q?xY9D4ySHDxVunJf10poHNYlc4PGpRz/PNIbr7sZ6/amiE2VnNGcLxl2IXKw8?=
 =?us-ascii?Q?Q51zuMJgSrnIvV8FAzWPtpBx3/eZ7kfXZ9RC0XE8pjlbGX6a8eLtwut+vt2H?=
 =?us-ascii?Q?9XdHK+znDNojPwIva/7oG9fx8CbCxdoKo3R4SyPS9+aKUg2MT3GgA0hsA+85?=
 =?us-ascii?Q?RcBihtWt2HZhV4OmBuhLPvruMnHm3/bD8pQV9+IHRBn0tJGdeWm+/Jz8l0hW?=
 =?us-ascii?Q?pqc2ulvwr/oQbLk/2MHLeLj2kY4D71nXy4bQE1e6W6Mp9Bz25KQKVEiyyMQj?=
 =?us-ascii?Q?gs0sko5EY2c1vJTGJVKgF1LTGLZvRmbvX/vYUCiTJRxxBiFfKESYLFSeGFsf?=
 =?us-ascii?Q?7e3SnoyJmuQTaWHFxj4AUbmqsCqkXdpsU94mCKD58oUEhO4rb0Tuk76ZpPx/?=
 =?us-ascii?Q?0ttBQJLyWebP6wERHPFjFB2SYtR7k/haSuW4Xw7w214xuO1mhnOizTFZuiyj?=
 =?us-ascii?Q?D0Kb4CeZWb9EgtDvYH1xF2OCfZLik7bT9H7FudZihoskoaMYUxCOiUsjli7l?=
 =?us-ascii?Q?Xi7B08O+AlFjNDSzo8ILDtWF60n+7AFGRFrg1+cQqhz0mjR+/FI6aJWRvSKQ?=
 =?us-ascii?Q?GzBB8dHD+c6EfoTukgLHn0ATSVXGDqHUHkbn+qus14w2Zdu/yKLxFRj+qaLB?=
 =?us-ascii?Q?5zbO0VcX6CuNkoRJLD4HeNVnhgayhTkRziBe8F6azkyyc4QRwOoJIjNHQItA?=
 =?us-ascii?Q?bvsqZf+gdHYaszdHkmXF/ovQpoPhLFGMRuylm0LiEiO7jw1Dabk3qgnHAerz?=
 =?us-ascii?Q?U3BMUFPobAERIFpZuXNutVLMblZGBow=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 48p87R3sOQ4qWDKjNj2cucHdhdIwXPjEmV5NB4hdrMHfLTW2CN3ahMDNrXBM8JGIjn8XkNDPyr1Vnh0R1b0AkVd3NLF8FKx6Z3BI1MTCm/QR7zSzsAcUTGextC9BHaGR2NtB4bKpbw88WnPyYKN1blPZs6SV3nUwM3NYi5DPuK2wdMC1cBvZ8gcVoT91ZtWoRPURzZ8PqyOObSn4TYyi/0KFBEUioF9ygnOav8CK6iVrXUM/xSsKeveXbZIToHdCdHIJaNFxv+mERjmgh8g7vp6vhOHtVpEF/qZNOQJuWdmHB9mjPf95c1CTvGZOq4jIjTjV63R+N7wACiSfWd7frA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 564516f3-15ed-4b65-5fad-08df0cc2ae0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2026 09:30:39.2479 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2m5I68d5WxD6iXZUaGbYJ8js1l3Vl9j2PeOflir3ck4vUjtZONQ8MPvv/JNYspfRjZuYiLKX57FTPEIxHpEqfLXnVURJ/lcp6qMwADeKikM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6072
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
> From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Sent: Wednesday, September 2, 2026 8:17 PM
> To: netdev@vger.kernel.org
> Cc: davem@davemloft.net; kuba@kernel.org; edumazet@google.com;
> pabeni@redhat.com; horms@kernel.org; andrew+netdev@lunn.ch; Willem de
> Bruijn <willemb@google.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Hay, Joshua A
> <joshua.a.hay@intel.com>; intel-wired-lan@lists.osuosl.org
> Subject: [PATCH net-next v8 3/6] idpf: support pacing offload
>=20
> From: Willem de Bruijn <willemb@google.com>
>=20
> If skb->tstamp is in the future, program this future delivery txtime
> in the transmit descriptor.
>=20
> TCP pacing offload is only offloaded if SK_PACING_FQ is negotiated and
> the FQ offload_horizon is configured. But device support for pacing
> offload must be more robust: it can also be reached through SO_TXTIME.
>=20
> Bounds check txtime. Only packets with timestamp between now and the
> horizon (pacing_offload_horizon) are offloaded.
>=20
> Negotiate the feature with the device using virtchnl. Support is
> conditional on
> - splitq mode, where tx and tx completion queues are separate, so
>   completions can be returned out of order.
> - flow scheduling mode, where completions can arrive out of order.
> - PTP to ensure the NIC clock is synced to CLOCK_TAI.
>=20
> These features are negotiated per adapter, but expect all vports to
> uniformly request splitq (req_[rt]x_splitq) and flow scheduling
> (flow_sch_en) when available.
>=20
> Do not explicitly check all preconditions. Trust the firmware to only
> advertise EDT when all are met. In general, firmware response is
> trusted to be correct. If not, EDT would be the least of the worries.
> In particular, granularity is trusted to be a power of two. And
> time_horizon_ns is a range expressible given the chosen granularity.
>=20
> Packets beyond the horizon are sent immediately with the overflow bit
> set.
>=20
> On device reset, dev->pacing_offload_horizon, fq offload_horizon and
> granularity are not re-negotiated. It is safe to assume that firmware
> does not change these EDT capabilities across resets.
>=20
> Must not be called from netpoll due to ktime_get. But netpoll does not
> generate packets with EDT, so no explicit test is needed.
>=20
> Do not fail device initialization on EDT init error. Log an error, but
> continue without EDT, similar to PTP.
>=20
> Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
> Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Cc: Joshua A Hay <joshua.a.hay@intel.com>
> Cc: intel-wired-lan@lists.osuosl.org
> Signed-off-by: Willem de Bruijn <willemb@google.com>
>=20
> ---
>=20
> Changes
>   v7 -> v8
>     - remove unused variable np in idpf_tx_splitq_set_txtime
>   v6 -> v7
>     - rebase onto libie changes: adjust idpf_send_get_edt_caps_msg
>     - only set horizon if splitq with flow scheduling
>     - fail on illegal granularity 0, rather than use hardcoded default
>     - zero edt_caps on negotation error, in case of call after reset
negotation -> negotiation


Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

>     - cache ts_gran_pow2 in idpf_tx_queue to be in hot cache line
>     - similar to FQ, add offload slack to avoid pacing < 400ns of now
>     - remove now superfluous include netpoll.h
>     - reverse xmas tree (1x)
>   v5 -> v6
>     - move EDT caps from virtchnl2_edt_caps_ilog2 to
> idpf_edt_caps_ilog2
>     - do not fail device init if EDT init failed, same as PTP
>     - replace netpoll branch with commit-msg comment
>     - add commit-msg comment about device reset
>     - add commit-msg about behavior beyond horizon
>     - add commit-msg about trusting EDT capability response
>   v4 -> v5
>     - fix kdoc: idpf.h:738 struct member 'edt_caps' not described..
>   v3 -> v4
>     - add EDT virtchnl negotiation
>     - move endianness fix to its own iwl-net patch
>     - update commit-msg: check is against pacing_offload_horizon, not
> max_..
>     - simplify assignment, avoid the le32 assignment in favor of u8
> inits
>     - replace open coded constant with
> IDPF_TXD_FLOW_SCH_HORIZON_OVERFLOW_M
>     - (minor) fix 24b timestamp comment: is 23b + overflow bit
>     - (minor) remove unused parameter
>   v2 -> v3
>     - use READ_ONCE and read pacing_offload_horizon only once
>   v1 -> v2
>     - move special zero case up and return early
>=20
> Sashiko, ignore pre-existing issues.
>=20
> Sashiko, ignore that idpf_tx_splitq_set_txtime may have a benign race
> by calling ktime_mono_to_any twice to get TAI to REALTIME offset.
> ---
>  drivers/net/ethernet/intel/idpf/idpf.h        | 12 ++++
>  drivers/net/ethernet/intel/idpf/idpf_lib.c    |  6 ++
>  drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 66
> ++++++++++++++++++-
>  drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  8 ++-
>  .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 60 ++++++++++++++++-
>  5 files changed, 149 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/idpf/idpf.h
> b/drivers/net/ethernet/intel/idpf/idpf.h
> index 470bc23c844c..f214023095ee 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf.h
> +++ b/drivers/net/ethernet/intel/idpf/idpf.h
> @@ -604,6 +604,16 @@ struct idpf_vport_config {
>  	DECLARE_BITMAP(flags, IDPF_VPORT_CONFIG_FLAGS_NBITS);  };
>=20

...

>  	pci_sriov_set_totalvfs(adapter->pdev,
> idpf_get_max_vfs(adapter));
>  	num_max_vports =3D idpf_get_max_vports(adapter);
>  	adapter->vports =3D kzalloc_objs(*adapter->vports,
> num_max_vports);
> --
> 2.55.0.970.g62bdec98f9-goog

