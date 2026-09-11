Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DABB6C88E53
	for <intel-wired-lan@archiver.kernel.org>; Fri, 11 Sep 2026 21:00:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 88C9280F1B;
	Fri, 11 Sep 2026 21:00:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id amNc9yamA0qu; Fri, 11 Sep 2026 21:00:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 58A4880E8D
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789160431;
	b=HNiQOWvDJj6FI8OaqxvLHq6oJEL68+q5jK0jCHBJMIMRAc1K6bTf4EXTK7uq1e7RI8JW
	 DodyKICJK7HXpC//1ZJ0Nw3+aohY2owdQzbepLiC8NV1XMSFlJ4MKkb2Bw8jjC3QdAvWH
	 YwHDTJymiafn095IbLtWitOJSBIYHJzI2lgQzySlR8ePAuVHVnN79QSMd8pERYhsX6SuU
	 tg4zi7c6mn14fGNn93whHeJrl4EW5iGBdnzol46X19mS3wx9h7VOokS3mx55JuY9DhXgE
	 t/V0Hp13OFgHAozBU+HO/xWsT49Fow/w09yFI5kwzU4YggkNy29+2IphBEStt1umKnA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789160431;
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
	bh=NiujYm0KweIkRdEOga+RrGK3fP3lxdnOQEfzq1vrC84=;
	b=NXpZvhVFV+lkcp4Lf6hf9dMU4fc44o+tPqb106UT1LlohosDTtz4CKbu5fQfsMPrc1rC
	 HCffgmNSflxdkDn8rdQ/TYYsF7h/pOriChLc8607K3HGCBb7sJ+/Y/IeUxnpS8xTwLq+n
	 3YvOINXaT7FLo32LO40qzi2mI8o8T3b/g5Uz52jqLNak3J52Hkj1/7aKlgNvIcIdB+kyS
	 kvXGTx6V089Fo+9z0WcX9owqFmyIXJ40ZqwINJCsaVF3xYnZMBBGQCgEC2AwSuUMsmJKe
	 4HvclYNqtNp/gfaocE2zfC9xtnIlrPujCN8IvecOOM2nHLJ4G3Y7Yt0wmLN8q52JH7Q==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="MWxQcZf/";
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789160431;
	bh=NiujYm0KweIkRdEOga+RrGK3fP3lxdnOQEfzq1vrC84=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mJFgb44IhLRMIMfh/+x4nhpBOgGkUvIdhc2uvKQGuod6ENWwNY1F7Xyv+JcDMqyaq
	 5jl/+7y4E24Yq4/g/5BiyDNlDWyzvCaz67TIr3dFMdMWkxVYurhb2i1i5+R32zcHFq
	 s81/fEKqqyN9gCl8gpTBn5gPzE4+Ubpli+Vnqhsf03XDy+J5gGgLCCMVIURS29JU2q
	 V+eDvrqfK8/a17gtxdV7tM6kTpdJBEiFEEUuWcbilSKq4iaWr5a2dH4CvwgkTiCc1+
	 bo85w4zJcqVWQcstk/ka6DFcx04L0FwXqGzJmM+RgzFW1eBN4jluRKZX5dxPCt40Vh
	 1/WKkChioftEg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 58A4880E8D;
	Fri, 11 Sep 2026 21:00:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E9E0232F
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 21:00:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E71E080E8D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 21:00:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nLEFz4rR4vQS for <intel-wired-lan@lists.osuosl.org>;
 Fri, 11 Sep 2026 21:00:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org BD72B80E85
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.4
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789160428;
 b=DzLC+dcejzx1cKHK8aoF/Ugq59U+FikoLfkZ030yoLGJtQe2XAIb2Z4z+fE251rtu/A5
 gwoIvgjLgw9V+mxu7/cIKoqAnLbpYSBM0TDvIzohYuQVbTzTIrRcSVlJqps0nIaHMlvCA
 GfZkRINFPv+xv607felWsyj1KRBpjqRhFdPKl35twEfqVU6wZzc7bxCxt4UxcB/5ALeOQ
 HhTF5LhEd5UDWtdafVQx2lyDulxpmv+qhM6jTf+yFL+MWtvxCXCGqr92fT7hLQ/fWvihf
 8XGs51wli9xQ1Ib/1yXhiE6ml7fPoUNjHSgM1+Wo7sOTQ847u0Noaf7Tu9tCQm68I7g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789160428;
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
 bh=NiujYm0KweIkRdEOga+RrGK3fP3lxdnOQEfzq1vrC84=;
 b=cThg5YlPLXjfquS2uidaimbdutzM/fTQjXVsA5m2WhukQytQhCFa59FJjh5/XDjqOHAD
 G2Q/w6h1WbLcXVWmHjnfHkvRQ8vHbeuP0PzAtjpsEMhgiG1BB8XUDYpn/LbRPEuBJjQfg
 HgcpH9KyKGD74Pnywv7XfqF7TXhWHY1bqrmWgsD8Z7y/7sM3AxkXUqRw+e68ew9yrO9Ta
 ngWqbp7ncvkmfBSJRVs+R4W/2WjEgyORV+hXZypAQ/VugQbWPeuaMBZ46/cMNbEPJcBcv
 PonU2H2BwQxDL06OXk5mU0dIluvJj5a1DEhiLXBxVDOYfzzjOF8I9J3tMrNbIjGytng==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b="MWxQcZf/"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.4
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.4;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=MWxQcZf/
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BD72B80E85
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 21:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789160428; x=1820696428;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=PzTTbzb+2Dsu8Azjr4QTNuiLYmr5Qo0Vgp/xMUSBG3s=;
 b=MWxQcZf/KNhy6BSaHifghGVofan57gw+31kLVaVJjWQwivdegA8ICQtI
 IDEu+67Q2qcA7bOShb7qj6+9IMfL4mJX2AwgtSvyn/539mQHxzb3WI/Si
 oOiDc34z5zMsetnieBB4y39KoZ3iAih/PIH1leBG+b2gmAssNGtHvFoH5
 rvoDXuvU8MpqfriXcSNdJT45xzu7xxIKAguwfEWdy7jsIwTf+3MKmE/OU
 UELqWvNpIe5XPuWnfX3wgVGR+POl2ndU5IjJe8BGVtXJTWSVxpZJeE599
 32BcbD/UP8GTc1r6j+vUoiLbuDi9zdvYaFGzpFUI6evdpeg6rp3svqpqz A==;
X-CSE-ConnectionGUID: 9ryENj+0Qr+m61A3aM3WbA==
X-CSE-MsgGUID: psEgHFe5TYOUz0NYeunSGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="139134"
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="139134"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 13:59:23 -0700
X-CSE-ConnectionGUID: RSLolxC/QpiAr8wdPRX9Ig==
X-CSE-MsgGUID: XWqiLyXWSMW7G38Ofbqq0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; d="scan'208";a="275776372"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 13:59:23 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 13:59:23 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 11 Sep 2026 13:59:23 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.18) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 13:59:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S17Q4gblpHgPgyIognkf9sX7bQ4IhkE+sSO5yPpn17EY1lDSfUtsYj5KfvWmzNrh3xKNfl98jJTyi7g6EmtFow+5rTJXsbzlkk5hGE3V1ukFHynEO3oWwObtRN4nplwX6oF7xeozImWTXmNoKu+yI/OCtAXco51In0/G2hVb0ZVCXUk7XDEKLL/5bC0oP2eOts0VvB2VyvgY1pX8/ORnQv1kNn+IcsmAIaukTeMhhOUigAIiENxY5sA4qqztOoJ8N+UtuOTvUFnYLp7Pmm+RjZAf61e9V0NbvcbLipvEIukxtYMiEhqOpOeVONrA+MCl4KnVni5f1uJwWGG32AEzGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NiujYm0KweIkRdEOga+RrGK3fP3lxdnOQEfzq1vrC84=;
 b=tD1BUmBn2BMezF3Fvtf8n963Y+xcGE9+h5JDB8DYHlUR2mbdvFa+TsDzQXAmdlSapReO3lUcgPLqQS3Amdl+4aF79SbO+HjawF7MAyyj2TqkNC0FrRfZP5SgvOhDgAIEvTVPxjudh0at55yXkb+zXPDnSvcbThz5JUawnZLn6hhbcYsIiOqqu2wwYCCnHkI68V+3CsDvMf57lX5FgETE25ZyaqVf5dcR+RTOzW0NkZgee4GLY7PUr9J32MSZDNt/JfNl1jg6iHphobbTtq9GV3kOebUXV8iNthVkztK3wPS5569dMPsozEBNcOzgQAno0iPTRvJxXUzPT/aVLBhowA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA0PR11MB4655.namprd11.prod.outlook.com (2603:10b6:806:9d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Fri, 11 Sep
 2026 20:59:17 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 20:59:17 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Oros, Petr" <poros@redhat.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
CC: "Oros, Petr" <poros@redhat.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Kushwaha,
 Priyalee" <priyalee.kushwaha@intel.com>, Kiran Patil <kiran.patil@intel.com>, 
 "Drewek, Wojciech" <wojciech.drewek@intel.com>, Michal Swiatkowski
 <michal.swiatkowski@linux.intel.com>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH iwl-next 1/2] ice: fix TC flower filters matching more
 than the ip_proto key
Thread-Topic: [PATCH iwl-next 1/2] ice: fix TC flower filters matching more
 than the ip_proto key
Thread-Index: AQHdQTvzlGOPnpTJw0uNMOiI1xpi87bJ3kRg
Date: Fri, 11 Sep 2026 20:59:17 +0000
Message-ID: <IA3PR11MB8986D323823F1A6A0F205B20E5BE2@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260910154824.3603687-1-poros@redhat.com>
 <20260910154824.3603687-2-poros@redhat.com>
In-Reply-To: <20260910154824.3603687-2-poros@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA0PR11MB4655:EE_
x-ms-office365-filtering-correlation-id: 7357ff11-b50d-4c8e-8130-08df10478b50
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|7416014|366016|18002099003|22082099003|38070700021|3023799007|10067099003|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info: jeLhF+BsGhkr7fF4WqD2rfaH16vE4StQUHuW+jOK+Wow2qSj5hX/LfmWp5cBujUd3ecRpJjgp8nTMJ/O+ibqJs936SOaMmmOYgFJzDDxaoWIpR0OOWkJVOyu5wwCJzvPbtj30yj5KQ54YqOkIzq9VA/ZbrAk7RHWBcAsUv2t1EisFwZ9dUvDRZxkkqcRRmdKTxs41VrOLhVYcAOghnaFcSCDTew/uDi6IzkFjEN/yjM+4qsl3CcXzYOeg69TAppvSRk/pWy8Q1uhw5TZ1W37xDN8pY+zQc1hnZhyUu9g6F+s+8QDNRW+xKsFAkY23Q6m8eJ1kWz4pRBkGA4aSOu0baDP2ks90hpFWlabIsXMusX4JGKMBEic1PGQXuq6wLowET2j0ccdtU7yIkyWggT3h8Wl1qSW3e3L/1pOLhHeq+tRIWCT+qC1Fmryj6CdLo21R5oo/7EurZksBxAEIYEeXwI6oshPBoG/mYUSJVxI5pHwd322tOWBHI9zrx+k6jIlDCc5VTtZCHcjsjDVYNVGek2Pqj2+8vSEpdCZnbRG30Im0ZBd2tPHzteLhyOijXLmy2rYGDlA25Db0aGe6gLj1KnodpiShFZWGSaJMse6Dq/GeaQRnTPN7hO2D8O/Q/S93BS8FL2WRN+jccCkNraVFJYOntW/fmS9/LIP8J0g4Kj1bO0fs45nLtXS8kBsunzQVzg0+Qtlakoq514Adl2OONnO0UQrI6fOha9y/vDyYgY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(18002099003)(22082099003)(38070700021)(3023799007)(10067099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UOtBEJz1cX03A8rNPQKcdezxkeH8+nLYPjuFrS7uTqaowMV5cFomNLgdNMx1?=
 =?us-ascii?Q?emI1dUq0W93aUzhuW9PirNTbjmQRHlkgiZPOHe/lyl+bUM/7gcLWmS9L5kzN?=
 =?us-ascii?Q?CnwAJcokYvUHt2VlFmFTRk8GysbKJr3YNuhyJEBFIlrGatasUSvNFL2TfkSS?=
 =?us-ascii?Q?nXesS3vYEzSgk4rUxwbdLlHy1iLXRD7a4HHGDsptQrCNKFSGX0nTlvAIPYpb?=
 =?us-ascii?Q?OSwWtDFj1n1S0XFIdK7DwA7H2rGkEVg7cAWlRizn6u6E8NtdNlmc3rLmeCda?=
 =?us-ascii?Q?cyEXiC3AYP7JvK6XSxmhKp+vCf21JrLwryDLz9ALNHFIXMx123u0ZSEag3wm?=
 =?us-ascii?Q?LdcjEJua3HhHtY5sWMsF/EKg6QXoVyt0C+wMfUAuMv+USAdjNcLPjoLsG0IS?=
 =?us-ascii?Q?oZsSl3T1I+yrlju73cGU28iYZV4gdtSpDrv1+liFlURp0Pv3BiWlA94gv0l6?=
 =?us-ascii?Q?d4RDIXRdkspUDjKcWDgBvq67xWBqjLpPKH4wcAF6ThlCTVREe5DPhJBBh6jm?=
 =?us-ascii?Q?fYxQ3tFm/MSFLdRSWkOJv54ptXm98UuWXUl3XT3TPeJl0y0rbk5LI3lbIkA6?=
 =?us-ascii?Q?ojoeDvvqwn9IBfgWM8dxByguaZg3/5fHxwwdgAliH65vSUmtcRDpo3k9a3UK?=
 =?us-ascii?Q?0H4wgRJHo1cm0dVjp+LKUBun+d7rvcH1zcBc85/qO/PwAx5dpzdgQ5vcOqtZ?=
 =?us-ascii?Q?RTEy4eeJ7WeCEtY469JRfrPdfrf2+zVD2DNkzfZQixEEJWhgZuVBtVQe35SO?=
 =?us-ascii?Q?fCpS2bnwoGHExDY3BPjQyBZynV7czx13wLycbDCS1w0ub776mxbKbaaBZ6pi?=
 =?us-ascii?Q?kftvjZb0LEE4qC/y/PBLYIg0Mmea6fN1UR1bdQ/07zXGqJjoraEnGNJFRWwk?=
 =?us-ascii?Q?660lel5QyfvvZ+fZKVZwBkSsZT2Uo9csCSYWJBeIlb32MDwtB54ZLHsK8V4i?=
 =?us-ascii?Q?TB5zHLt7coV/QVzW/BPltx4mO4iQRAG07Nh6kd0RBgj111tLmd8DA8Lddc3q?=
 =?us-ascii?Q?Pvvz5yVg95iEuD2xNWLReFJIBcI0UcKI/GBv7K++E1TjyyuGhM6C2EL5Mt10?=
 =?us-ascii?Q?QvJ9b8tWw9vEfltP5739ccQBGm+9A/3Q0BJfQKjLWW55ieZARnJFtPcwJjIW?=
 =?us-ascii?Q?zSRs4BnmtCMrwfpkCmd+xQQBdUz01JeaY+LRBKgWgwxgbDkPyvkBE7yPx8Mb?=
 =?us-ascii?Q?z/T5r4IIpAqFtvlyD7uHgT3WoQGGedAS79hWh9s3yOrl868MjavzO/Ub/utt?=
 =?us-ascii?Q?k6iy16/R8Rj0TMvaSsTbXU7hhuTyMfBsRYATZosLtp6JzXN5V0F+9OrFI6mD?=
 =?us-ascii?Q?U7M6F6Kb4rJq0oSjlBTjo39gzFZHOmf8c9TN+9XrQ0mxWEH8xUOdXyThfKzp?=
 =?us-ascii?Q?IkuJ3ZdgyA0/+TbZf3jBmBfHT4rMllrT6RP5NLVAMFM5N0yk+UUVeRHGtCF6?=
 =?us-ascii?Q?1E677mmKueiqawOddvFcZDi6Bq9O94fMl9deVWJMe41HN8NHg/9/d8CFSV1p?=
 =?us-ascii?Q?VjE2BeyFsufyo4O9jcISyijPaVnMpQObNQHk4JPDZHq9zkdI/9eVh/mhpako?=
 =?us-ascii?Q?YY4KcoQUtzV/5IThu+S3G8Tr199rcvRMrnCEovFm+cU3G9sf4ngfQgNvkIGj?=
 =?us-ascii?Q?4XFnU/qOzkHXTUJvKmUwKO1saKaZ2IYxG7rYKZ3SReE1djd/11XrSHt4Ck0H?=
 =?us-ascii?Q?o1CM86MG3ugukGciGTMD2zyKDUDVAqSB/j/u0bluwjgPLoj+rUc93vHRVNkq?=
 =?us-ascii?Q?RR2dPsAjlA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: EsCqIIM1pUO0q9G0j+AFzyiFJPxa+0OLxJ5+pXZ+U0VXjqKM23nZBJSDJf2cVKjmn9+4IzSaXzLYeVI9b55l//RPb3bLjtjKqE/JyJgaeO1G2vQKK+TDM51+/9gVI4Y6cByZtpEU8CVrk7Yf51SILgm4sq54JAovZ9I8BPsEEXvlGe/JeQeUovxIfQ6Vahc2O10lDzduJt1UThT2+8QK8fRMxcNm0Qti7IBc+d54s1CH6nU9SoEgnklALjbK7z4pugjW1+nwEbTDgYz5OeJ+n0IaZu8ypt9Ihtwg/poelCu3smmw5RWtcsQR25TESY/g5a9xarNBqjNQNO9RsbF95Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7357ff11-b50d-4c8e-8130-08df10478b50
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2026 20:59:17.5511 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uidg1+ZiJLP6mALrGScmhBl7l7j0XCCR/LugpZM41yVp03D/YsK3VuTDYWaQEMaI4/txHoyC9Zx/wxlPEik3yfYvCAD+ngNdnZDGjU7yAkU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4655
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
> From: Petr Oros <poros@redhat.com>
> Sent: Thursday, September 10, 2026 5:48 PM
> To: netdev@vger.kernel.org
> Cc: Oros, Petr <poros@redhat.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Kushwaha, Priyalee <priyalee.kushwaha@intel.com>;
> Kiran Patil <kiran.patil@intel.com>; Drewek, Wojciech
> <wojciech.drewek@intel.com>; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>; intel-wired-
> lan@lists.osuosl.org; linux-kernel@vger.kernel.org
> Subject: [PATCH iwl-next 1/2] ice: fix TC flower filters matching more
> than the ip_proto key
>=20
> ice_parse_cls_flower() stores the ip_proto key from the flow rule but
> never programs a matching lookup unless the filter also matches on L4
> ports or the L2TPv3 session ID. A filter like:
>=20
>   tc filter add dev $pf ingress protocol ip flower skip_sw \
>       ip_proto udp action drop
>=20
> is silently programmed into the hardware as a match on eth_type ipv4
> alone and drops every IPv4 packet, not just UDP.
>=20
> Program the IP protocol match through the protocol field of the IPv4
> header lookup and the next header field of the IPv6 header lookup, the
> same lookups that are already used for ToS and TTL. The OS default and
> comms DDP packages provide no profile that extracts the IPv6 next
> header word, so the IPv6 rule programming currently fails with
> "Required profiles not found" and the filter falls back to software
> evaluation instead of over-matching, and the offload starts working
> with a DDP package that can extract it. Note that the lookup matches
> the next header byte of the base IPv6 header, so packets carrying
> extension headers are not matched in hardware and fall back to
> software evaluation, which under-matches only for skip_sw filters.
>=20
> GTP tunnel and PPPoE filters rewrite the parsed ethertype, the IP
> header lookups are not available there, so reject an unconsumed
> ip_proto for them instead of silently widening the match. Filters
> where ip_proto is implied by an L4 ports or L2TPv3 session ID lookup
> are not affected. Based on an earlier unapplied patch from Michal
> Swiatkowski that implemented the IPv4 part [1].
>=20
> Link: https://lore.kernel.org/intel-wired-lan/20240222123956.2393-3-
> michal.swiatkowski@linux.intel.com/ [1]
> Fixes: 0d08a441fb1a ("ice: ndo_setup_tc implementation for PF")
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_tc_lib.c | 37 +++++++++++++++++++-
> -  drivers/net/ethernet/intel/ice/ice_tc_lib.h |  1 +
>  2 files changed, 35 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
> b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
> index d20357c0412731..fbd8cbad150a98 100644
> --- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
> @@ -78,7 +78,8 @@ static int ice_tc_count_lkups(u32 flags, struct
> ice_tc_flower_fltr *fltr)
>  		     ICE_TC_FLWR_FIELD_DEST_IPV6 |
> ICE_TC_FLWR_FIELD_SRC_IPV6))
>  		lkups_cnt++;
>=20
> -	if (flags & (ICE_TC_FLWR_FIELD_IP_TOS |
> ICE_TC_FLWR_FIELD_IP_TTL))
> +	if (flags & (ICE_TC_FLWR_FIELD_IP_TOS |
> ICE_TC_FLWR_FIELD_IP_TTL |
> +		     ICE_TC_FLWR_FIELD_IP_PROTO))
>  		lkups_cnt++;
>=20
>  	/* are L2TPv3 options specified? */
> @@ -552,7 +553,8 @@ ice_tc_fill_rules(struct ice_hw *hw, u32 flags,
>  	}
>=20
>  	if (headers->l2_key.n_proto =3D=3D htons(ETH_P_IP) &&
> -	    (flags & (ICE_TC_FLWR_FIELD_IP_TOS |
> ICE_TC_FLWR_FIELD_IP_TTL))) {
> +	    (flags & (ICE_TC_FLWR_FIELD_IP_TOS |
> ICE_TC_FLWR_FIELD_IP_TTL |
> +		      ICE_TC_FLWR_FIELD_IP_PROTO))) {
>  		list[i].type =3D ice_proto_type_from_ipv4(inner);
>=20
>  		if (flags & ICE_TC_FLWR_FIELD_IP_TOS) { @@ -567,11
> +569,19 @@ ice_tc_fill_rules(struct ice_hw *hw, u32 flags,
>  				headers->l3_mask.ttl;
>  		}
>=20
> +		if (flags & ICE_TC_FLWR_FIELD_IP_PROTO) {
> +			list[i].h_u.ipv4_hdr.protocol =3D
> +				headers->l3_key.ip_proto;
> +			list[i].m_u.ipv4_hdr.protocol =3D
> +				headers->l3_mask.ip_proto;
> +		}
> +
>  		i++;
>  	}
>=20
>  	if (headers->l2_key.n_proto =3D=3D htons(ETH_P_IPV6) &&
> -	    (flags & (ICE_TC_FLWR_FIELD_IP_TOS |
> ICE_TC_FLWR_FIELD_IP_TTL))) {
> +	    (flags & (ICE_TC_FLWR_FIELD_IP_TOS |
> ICE_TC_FLWR_FIELD_IP_TTL |
> +		      ICE_TC_FLWR_FIELD_IP_PROTO))) {
>  		struct ice_ipv6_hdr *hdr_h, *hdr_m;
>=20
>  		hdr_h =3D &list[i].h_u.ipv6_hdr;
> @@ -592,6 +602,11 @@ ice_tc_fill_rules(struct ice_hw *hw, u32 flags,
>  			hdr_m->hop_limit =3D headers->l3_mask.ttl;
>  		}
>=20
> +		if (flags & ICE_TC_FLWR_FIELD_IP_PROTO) {
> +			hdr_h->next_hdr =3D headers->l3_key.ip_proto;
> +			hdr_m->next_hdr =3D headers->l3_mask.ip_proto;
> +		}
> +
>  		i++;
>  	}
>=20
> @@ -1737,6 +1752,9 @@ ice_parse_cls_flower(struct net_device
> *filter_dev, struct ice_vsi *vsi,
>  		headers->l2_key.n_proto =3D cpu_to_be16(n_proto_key);
>  		headers->l2_mask.n_proto =3D cpu_to_be16(n_proto_mask);
>  		headers->l3_key.ip_proto =3D match.key->ip_proto;
> +		headers->l3_mask.ip_proto =3D match.mask->ip_proto;
> +		if (match.mask->ip_proto)
> +			fltr->flags |=3D ICE_TC_FLWR_FIELD_IP_PROTO;
>  	}
>=20
>  	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
> @@ -1910,6 +1928,19 @@ ice_parse_cls_flower(struct net_device
> *filter_dev, struct ice_vsi *vsi,
>  		}
>  	}
>=20
> +	if (fltr->flags & (ICE_TC_FLWR_FIELD_DEST_L4_PORT |
> +			   ICE_TC_FLWR_FIELD_SRC_L4_PORT |
> +			   ICE_TC_FLWR_FIELD_L2TPV3_SESSID))
> +		fltr->flags &=3D ~ICE_TC_FLWR_FIELD_IP_PROTO;
> +
> +	if ((fltr->flags & ICE_TC_FLWR_FIELD_IP_PROTO) &&
> +	    headers->l2_key.n_proto !=3D htons(ETH_P_IP) &&
> +	    headers->l2_key.n_proto !=3D htons(ETH_P_IPV6)) {
> +		NL_SET_ERR_MSG_MOD(fltr->extack,
> +				   "IP protocol match is not supported with
> GTP or PPPoE");
> +		return -EOPNOTSUPP;
> +	}
> +
>  	/* Ingress filter on representor results in an egress filter in
> HW
>  	 * and vice versa
>  	 */
> diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.h
> b/drivers/net/ethernet/intel/ice/ice_tc_lib.h
> index 8a3ab2f22af9ba..752af65e70b7bf 100644
> --- a/drivers/net/ethernet/intel/ice/ice_tc_lib.h
> +++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.h
> @@ -38,6 +38,7 @@
>  #define ICE_TC_FLWR_FIELD_CVLAN_PRIO		BIT(28)
>  #define ICE_TC_FLWR_FIELD_VLAN_TPID		BIT(29)
>  #define ICE_TC_FLWR_FIELD_PFCP_OPTS		BIT(30)
> +#define ICE_TC_FLWR_FIELD_IP_PROTO		BIT(31)
>=20
>  #define ICE_TC_FLOWER_MASK_32   0xFFFFFFFF
>=20
> --
> 2.55.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
