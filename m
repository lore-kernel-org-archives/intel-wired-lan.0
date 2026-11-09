Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E44E60A2612
	for <intel-wired-lan@archiver.kernel.org>; Mon,  9 Nov 2026 19:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=ABdtm9jo;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eGVsWXQl
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 48D97405DD;
	Mon,  9 Nov 2026 19:05:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fZTwVcKt84cc; Mon,  9 Nov 2026 19:05:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 03181405C4
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794251121;
	b=iMieume/joLlRCvFNMNO/mD8pV9qFBEmjykeCtgnPQNw/t6uvK71mXLcoKCrUzLRscUV
	 Qzke0x0RhaTrgIHR/RSnNjjJ5PduLTpU1sgqrOwtg9HsvJuBJ8xB4UPS0MKieOiDfF2Dc
	 29g7AX/3sYDGPEnwfTFaiq8i+mjVZKPq9Otb7Eb9xAjJDsUn/MRyBJiz4CLJApPQYt2dm
	 fpfJ0o4TkajWV3AcYFSFjDMWLJlIroOkIWXc/TeS1562Y0IXt/PQ5CglDAyCHGfLEivqh
	 8c2k/9oQScaugq15vYcXK3eVJGGegKvcOKqsdgPrKOFyWba2fLL9oHe4SAshvAenmxA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794251121;
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
	bh=6+YZxQ13YOJ8UtOzew8TbdktPjj8yu1brjnF+SKC90w=;
	b=qyLaf2A5H/OzUGZq8MJYwg+6ds4cQyohJ5qGntVfGRgCtjo/EWYzRRkrANfgnTfEw79V
	 IDwbNLAV2S/5fEpKfscllcf08uV/pZBi0CK240p9KaZjKtHCDHclEZ6pdz5GD7UB2h29b
	 eMclPYiF58uzgY2V1l1iU2X5PQEkfXRWZx73Vwkc/ezRrTkK1m2xK76l6N2ELeX9oeMs5
	 1wXfCeKQEn5Th8qqbIhdk2a1DD8Tc7P8HQmRc3WW6Krp0JGGzdDIowjF6HNI9mNUJBCnp
	 H/eSgg//GVkfaVX3cI5JNC6a7h6eIyJbTOcKC99UuFITRXYxsfhJGa3iiRsIfWSHXRA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794251121;
	bh=6+YZxQ13YOJ8UtOzew8TbdktPjj8yu1brjnF+SKC90w=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ABdtm9joxlxSc3sj/yCDlHSoL7ulRr+2fyeLeW/5Va60kglbsCC9iOOWo6fKfISnU
	 NFpwx1qSqSYd8YE83/JHVJu09DhbGKGN5FUWOKhIuZ2DqLuh1BfM2+er2RyBenPgXr
	 MNkX/qKgmtWsOH37fw/2WTUau8+JssNiCervWC81/KL0y8MG2rMBRIQpSsmthsm8H6
	 GJ6tXbE8slJCbQk5LL1xsc3PW6WTzlFOfu2rBodtzP5/748Rfr8qpHJep5+psMUmCI
	 9012msf5s9iNTl8fwbgWDzHLGyrhKnpmdaD8HXd08qN/KqSrmPULO1+KLzoE8bZHAE
	 iuOz6Jf6Jf4YQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 03181405C4;
	Mon,  9 Nov 2026 19:05:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id DE1D62AC
 for <intel-wired-lan@lists.osuosl.org>; Mon,  9 Nov 2026 19:05:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C35B1402CF
 for <intel-wired-lan@lists.osuosl.org>; Mon,  9 Nov 2026 19:05:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GIn8dlQL_Z9I for <intel-wired-lan@lists.osuosl.org>;
 Mon,  9 Nov 2026 19:05:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E328C402C8
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.9
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.9;
 helo=mgamail.intel.com; envelope-from=samuel.salin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=eGVsWXQl
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E328C402C8
 for <intel-wired-lan@lists.osuosl.org>; Mon,  9 Nov 2026 19:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794251119; x=1825787119;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=eMXrUJ8UKbblsKqu4OOWX155UBWvy+vGw9iUtUMdPK8=;
 b=eGVsWXQl10LtVwaeT7X22O62dL4uE/6xj3PvhDYlzNn+J96lZUSGO7MU
 0jXq9C/37hzRJuJg5h5Bwm3zlFn/Ugug430CuKT0qCNPBNgDCfkFs/zl1
 Kk83/zyBHiX8uHKwJF+zTnUZzFvgIme8qurCZBbhMdWBicad3MEUx2NFS
 pZiVBIl1ujPhIhfMyvKc6DulUCGkow7IfMOXd+n6CBuzwdx7Zi3vKgeZG
 7oSKq2BsYg8InY3FOsfA5lXFVhVupSCUG8OPoC9cbgIKRgXcQ8t693xhL
 KnhmjDeTIvypo8xBl4plTcm+T+n6QJKhcKFXjCQjm3MDblvH2pYRVItPG A==;
X-CSE-ConnectionGUID: soWVKE0qQQ2I45fyM34v0w==
X-CSE-MsgGUID: qOVf2sXVSjS74FVmfwJv7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2866447"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2866447"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 11:05:17 -0800
X-CSE-ConnectionGUID: an51gV7YRqiRJ2Fu+cVWyw==
X-CSE-MsgGUID: Qh7mzGfjRbuG2X+tYCjpIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="8128919"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 11:05:16 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 11:05:15 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 9 Nov 2026 11:05:15 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.64) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 11:05:15 -0800
Received: from IA3PR11MB824491.namprd11.prod.outlook.com
 (2603:10b6:208:626::16) by DS6PR11MB704522.namprd11.prod.outlook.com
 (2603:10b6:8:412::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Mon, 9 Nov
 2026 19:05:12 +0000
Received: from IA3PR11MB824491.namprd11.prod.outlook.com
 ([fe80::c2b7:5964:96e1:8ffd]) by IA3PR11MB824491.namprd11.prod.outlook.com
 ([fe80::c2b7:5964:96e1:8ffd%5]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 19:05:11 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, Brian Vazquez
 <brianvv@google.com>, Brian Vazquez <brianvv.kernel@gmail.com>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "Chittim, Madhu" <madhu.chittim@intel.com>, "Hay, Joshua A"
 <joshua.a.hay@intel.com>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "David
 Decotigny" <decot@google.com>, Li Li <boolli@google.com>, "Tantilov, Emil S"
 <emil.s.tantilov@intel.com>, Paul Menzel <pmenzel@molgen.mpg.de>
Subject: RE: [PATCH iwl-net v2] idpf: wait for the reset completed state in
 idpf_check_reset_complete()
Thread-Topic: [PATCH iwl-net v2] idpf: wait for the reset completed state in
 idpf_check_reset_complete()
Thread-Index: AQHdWBpXjfwJ6tBorUC2IkGjruvcB7b84mQAgClnuPA=
Date: Mon, 9 Nov 2026 19:05:11 +0000
Message-ID: <IA3PR11MB82449130BE44CBEA89183442F79B732@IA3PR11MB824491.namprd11.prod.outlook.com>
References: <20261009181553.582029-1-brianvv@google.com>
 <DS4PPF7551E6552686B1C0E5EF78B23A44AE59D2@DS4PPF7551E6552.namprd11.prod.outlook.com>
In-Reply-To: <DS4PPF7551E6552686B1C0E5EF78B23A44AE59D2@DS4PPF7551E6552.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB824491:EE_|DS6PR11MB704522:EE_
x-ms-office365-filtering-correlation-id: 8a890474-3b63-4d8f-1fa7-08df3e94614c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|7416014|366016|376014|1800799024|18002099003|22082099003|6133799003|10067099003|38070700021|921020|5023799004|261022075727099003|11063799006|261028144727099003|4143699003|261026140227099003|261026121527099003|261009223027099003|261021121427099003|56012099006|261022105027099003|261021123027099003|261102123227099003;
x-microsoft-antispam-message-info: gdM0QarQeMSzvrpxyPItFH60zMMjl2apv9mNqdffAJ4/peJmn3yN4wHPcctid+cCidhnTqQ231A5N92KLuu/h1ohQTzq+phAtrrRcwJgKfwuwzQYbUEdvOW2mwlqvqNDEvzxQqW7VQ2yOYCEmjA60fS9ZerbWxSx5y2Tti+NwuEgMW95V7B67cwvP3UAiY4uYuUtsMtsrgN2Tkc0/zAtZ2xs62xqAAR1IG5FQU38ppQNNAvrVursApf3c8SaSRmUKL/hSOSlUJdYzclzr2+jRqMhy4wtrsJ4Uli6JekZdGyGvGsXEKNRLT5PhcrB+zr5cbvzJ9r6HhLbGCBTklpYjqpFVZYtvbPvzblKPVOuvF0A1/B9U2VaEek+vJnjyOIwmaBS869GA0W4eBBxgbGK2wZVDDPzSZKL9sF+LwvUidrcL7dq+Z29lUQEMi3DNplHgwI8hv9s7rUaesWuS0VXbMHpa3/nEtNVY+9vKekehDT9paeSI3qMpjxJqIqn3Ud/nuTy7jE+DMYSWn/dIgkttYLyJsHMdqqUmlwBu/8iX7rloNLL0ev0sAlO3uerbKH9gOjw2djPnYnQhzGBwB/Lcnm6bkGndogX+VC/wbzAqm9PnKPoMAtsyz+vr4mrECzAEXw8MNtRK46+73vHy0ITMKxNMClyknLDCdCTq5u3PBAYsTqvoQaZACCcBuLxIaImMIB2Fo5Iye1tzTSNOYK26bzayGeUSVtdHMsoTnfM/VqdBU2Y14EM8QsTtdai17TE
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB824491.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(366016)(376014)(1800799024)(18002099003)(22082099003)(6133799003)(10067099003)(38070700021)(921020)(5023799004)(261022075727099003)(11063799006)(261028144727099003)(4143699003)(261026140227099003)(261026121527099003)(261009223027099003)(261021121427099003)(56012099006)(261022105027099003)(261021123027099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0VDDK8XODffBS1Fd2jmttnknFPRzGt+rhs86P8rAA0bLQcfxLe861/eXg030?=
 =?us-ascii?Q?gLmhpYhA0c12lKmUys5E9zuy9Zd6XR8wdZesFG8kg43tOezCIDuiulAs0OTM?=
 =?us-ascii?Q?XCi7mMEAVItcuZP0rGVyyrJCucwe55T59KvKdYrDfbJD8KPzYkmZpKnKt6h1?=
 =?us-ascii?Q?JZAqI40UEa/hq1fUbiyjlwHAB3PvPJ4dV4cNqGM8yBYoPi+HDDozj7qhDwNB?=
 =?us-ascii?Q?ROoeyTmfHAP3Oqdn3F87TfV0E6Hkxkve+wmVHTy9Ro4USUM3ygSQiU6PtDoH?=
 =?us-ascii?Q?+n1SVVMDWCblLm12lRbPLXvHIOf/WNzVBR9vBCRXxLkyDaqkKRCqM+c88Iej?=
 =?us-ascii?Q?tWjqXpH/flv33f8ItLuDqX/56EwofGfOcj1j1+faFV/T6XAeW3JSb2tjTYfa?=
 =?us-ascii?Q?cetUATzONN3+ddfbm/gsjA8r5WxYe68R4cmqtkF/94ObXX6Lp2wDcAVISQ1T?=
 =?us-ascii?Q?U++yOLCxhpobQ8bisAcCpnYWIViIQ7ciVRTG9mdacTWnfHSC/p6Wnr63OU6p?=
 =?us-ascii?Q?umLNF41nFVqLkCIQmznH0HHYrnuoGNrLkRxjb/Ce+HamX6etR9+cMwnfE2Ti?=
 =?us-ascii?Q?4g8G5hoSghSckTpuQD/mz5XY06n9JoU9Nj1vKzOBU7Tfh4OXnThDOVv05AMr?=
 =?us-ascii?Q?hTIC2RPB1mX44Cu2aT/tsYkFTXR4GbhtMsxdPm8TGiQ9Bz54E79QbUMUTBxc?=
 =?us-ascii?Q?cC44a26kg04FkkSYpYyPW7OuLtnX5h4WaUGt7E3o6kUVhZmsWgZkTBpg653B?=
 =?us-ascii?Q?8dKpJqHhQqQD4mIWe8qVn3BIsBt84pEuh0yr0/D3qFz67xGCjqlFSZlLsTqI?=
 =?us-ascii?Q?YqQgijIHLzve/TAMCj3Kue2ZHmiu5/+TJaguh8DkdyXl7SUTeVs9Kvy+ijGH?=
 =?us-ascii?Q?JgcPTJIT/qNSJU0w9b7AGB65G/7J2RJWHPrq/cZ/MppC4Ult1M+B/l91Vj4w?=
 =?us-ascii?Q?hDce1ZBmZYHr2qyxdXH55KLAYUuKHmb2ZNbCxB/+eqad6i4nfSP1Xy/Myvk7?=
 =?us-ascii?Q?n9lF+ceBzm/pzU9wtLwoexS2x6ROHqEor4m/JdptEmF5/ddKvac1bS1qGZOB?=
 =?us-ascii?Q?R/hk9YA0K40dJz22/7YaRNLrCYwfYsDJl+IVKIMJAZPiq4dNTNBGC4E3XKD7?=
 =?us-ascii?Q?Fk7pQmLFf0FIedh+4FEiPxy6Jqj9EBYEil8kOUKHrtDbF5HlhRM4DYbwd3jq?=
 =?us-ascii?Q?pVT2btthWfNxnO/augixFLKfo/yypxS41DkfpxrzhD5xu578jvHxkUkdh0Yj?=
 =?us-ascii?Q?GZZCZTxKixLycQ9IzI1IEFb76J+pfgD3UfKOdUHmveEhQA6FtaUC8B9RQpvv?=
 =?us-ascii?Q?atNpWUEL6/cOGbYvVeUGlqy0vBzimRNqQE8zqvjC8b55H0TqnHrQlXzMo8PA?=
 =?us-ascii?Q?k1urv9kVf9YXgykEGFs+ZL2QmUq3Dkn5B5yVKX2R+wnTUoAr9igW3y0dD3YH?=
 =?us-ascii?Q?MPkn0Bq8loPaPQcRJKtbEWucfd/EjzwRA5TnfnHpRPi8S9bgRUwppbiO1sXN?=
 =?us-ascii?Q?GjYCojhbzAd2L5cHLUtAYTDjNk4kA0PfJvxvaHhapcWJlWey0WW6A75Xh3Vg?=
 =?us-ascii?Q?HB93dYW328CZauvQnWawueRVaTAmrjo9SjU/XgBD4MRzRQhdR5RipzeTDq/b?=
 =?us-ascii?Q?E1JHiiVMCC7okViKKi1PgdWT7aKDd9gIo+4rRWN1K8D8YTJt1K+rb4lvtFIl?=
 =?us-ascii?Q?nu9EqcUZhxO4seoSL+z9AC+SW274okNLjRKhVE+MyrZ+dcj9EUInhPLq128c?=
 =?us-ascii?Q?MWv1cmq01A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: h8ot16HJWLYEPOoU4pxWofqQNRDxwkOPrjpuQCf0savpdIfIBNDpRCAHvsehJhjuZYiw6/yyBjFbc0jtGIXIqX8Z5jS6BwiFQTTw1MiCWApEIqz1MLjIBSxN2bQRQ4ycelRrqZYzEbFwxjkhQnm+de7ggiPrycbjegQJm8d3A47Kvht25y573bjg/GWZqU5qhWVQMJTDnrWdaF9bvoDNs5R9afKyoWQu5wKFEF7AViJ84Cqvy3QDTGRM1QcxTDiDJlmmBDZtmWnaPIysFlMZnXMOsYtHRRgMzjWcesvRq0zuqe24DGE5WHGGLhswqu84lv3HJaNkaGc4AAsJI7XQSQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB824491.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a890474-3b63-4d8f-1fa7-08df3e94614c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2026 19:05:11.8227 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MM8NtEKaCSmdDP2MQfUcz1Bb4kH/LtQ7gLc3BbET988Ehbdy80svdYxQri9LM5J2v6lbJ9c+IpzD4skwDRKeoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB704522
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
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> -----Original Message-----
> From: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Sent: Wednesday, October 14, 2026 3:47 AM
> To: Brian Vazquez <brianvv@google.com>; Brian Vazquez
> <brianvv.kernel@gmail.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@kernel.org>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; intel-wired-lan@lists.osuosl.org;
> netdev@vger.kernel.org
> Cc: Chittim, Madhu <madhu.chittim@intel.com>; Hay, Joshua A
> <joshua.a.hay@intel.com>; Samudrala, Sridhar
> <sridhar.samudrala@intel.com>; linux-kernel@vger.kernel.org; David
> Decotigny <decot@google.com>; Li Li <boolli@google.com>; Tantilov, Emil S
> <emil.s.tantilov@intel.com>; Paul Menzel <pmenzel@molgen.mpg.de>
> Subject: RE: [PATCH iwl-net v2] idpf: wait for the reset completed state =
in
> idpf_check_reset_complete()
>=20
>=20
>=20
> > -----Original Message-----
> > From: Brian Vazquez <brianvv@google.com>
> > Sent: Friday, October 9, 2026 8:16 PM
> > To: Brian Vazquez <brianvv.kernel@gmail.com>; Nguyen, Anthony L
> > <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> > <przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> > David S. Miller <davem@davemloft.net>; Eric Dumazet
> > <edumazet@kernel.org>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> > <pabeni@redhat.com>; intel-wired-lan@lists.osuosl.org;
> > netdev@vger.kernel.org
> > Cc: Chittim, Madhu <madhu.chittim@intel.com>; Hay, Joshua A
> > <joshua.a.hay@intel.com>; Samudrala, Sridhar
> > <sridhar.samudrala@intel.com>; linux-kernel@vger.kernel.org; David
> > Decotigny <decot@google.com>; Li Li <boolli@google.com>; Tantilov,
> > Emil S <emil.s.tantilov@intel.com>; Brian Vazquez
> > <brianvv@google.com>; Paul Menzel <pmenzel@molgen.mpg.de>
> > Subject: [PATCH iwl-net v2] idpf: wait for the reset completed state
> > in
> > idpf_check_reset_complete()
> >
> > PFGEN_RSTAT[1:0] / VFGEN_RSTAT[1:0] (PFR_STATE / VFR_STATE) encode
> the
> > function reset progress as a 2-bit state, not a flag. From the IDPF
> > specification [1], "PF Reset Status - PFGEN_RSTAT":
> >
> >   00b - reset in progress
> >   01b - reset completed, written by the control plane
> >   10b - function active, written by the control plane once the function
> >         has completed VIRTCHNL2_OP_VERSION
> >   11b - reserved
> >
> > The "Function Level Reset" chapter of the same document has the driver
> > poll the register until it reads 01b before re-initializing.
> >
> > idpf_check_reset_complete() tests (reg_val & rstat_m) as a boolean,
> > with rstat_m =3D GENMASK(1, 0), so any non-zero state is taken as
> > "completed", although only 01b carries that meaning.
> >
> > That only works if hardware moves the field to 00b as soon as the
> > reset is triggered. On the Intel IPU E2100 (8086:1452) it does not:
> > PFSWR transitions PFR_STATE to 00b only when the field currently reads
> 01b.
> > When the function is active (10b) the field keeps its value until the
> > control plane finishes the reset and writes 01b, which takes a few
> > hundred milliseconds.
> >
> > Consequently, on a hard reset of an active function
> > (IDPF_HR_FUNC_RESET) the first poll sees 10b, returns immediately, the
> > driver re-creates the mailbox and sends VIRTCHNL2_OP_VERSION while the
> > reset is still being processed. The control plane tears the mailbox
> > down underneath it, VERSION is never answered, and the driver sits in
> > a
> > 60 second virtchnl timeout (-ETIME) before going through a second hard
> > reset which then succeeds.
> >
> > An FLR on an active PF is enough to reproduce it:
> >
> >   # echo 1 > /sys/bus/pci/devices/0000:01:00.0/reset
> >
> >   [  299.685030] idpf 0000:01:00.0: HW reset detected
> >   [  299.715710] idpf 0000:01:00.0: Device HW Reset initiated
> >   [  362.916087] idpf 0000:01:00.0: Device HW Reset initiated
> >   [  364.318246] eth0: (slave eth1): link status definitely up, ...
> >
> > Nothing is logged during the 63 seconds; the timeout is silent on this
> > path.
> >
> > Make idpf_check_reset_complete() wait for the state to be exactly 01b.
> > This is the stricter reading of the register definition and it does
> > not depend on how the field got to its current value: functions that
> > are still in progress (00b) or active (10b) keep polling until the
> > control plane reports completion.
> >
> > With the change the same FLR results in a single reset and the link is
> > back after 1.5 seconds:
> >
> >   [  206.856635] idpf 0000:01:00.0: HW reset detected
> >   [  206.887106] idpf 0000:01:00.0: Device HW Reset initiated
> >   [  208.368721] eth0: (slave eth1): link status definitely up, ...
> >
> > [1]
> > https://github.com/oasis-tcs/idpf-
> > specification/blob/main/idpf_specification.md
> >
> > Fixes: 8077c727561a ("idpf: add controlq init and reset checks")
> > Reviewed-by: Emil Tantilov <emil.s.tantilov@intel.com>
> > Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> > Reviewed-by: Li Li <boolli@google.com>
> > Signed-off-by: Brian Vazquez <brianvv@google.com>
> > ---
> > v2: reference the IDPF spec, name the device and add an FLR reproducer
> >     with before/after (Paul); collect Reviewed-by tags. No code change.
> >
> >  drivers/net/ethernet/intel/idpf/idpf.h     | 2 ++
> >  drivers/net/ethernet/intel/idpf/idpf_lib.c | 3 ++-
> >  2 files changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/intel/idpf/idpf.h
> > b/drivers/net/ethernet/intel/idpf/idpf.h
> > index 470bc23c844c..ce8a1bd0ec8b 100644
> > --- a/drivers/net/ethernet/intel/idpf/idpf.h
> > +++ b/drivers/net/ethernet/intel/idpf/idpf.h
> > @@ -166,6 +166,8 @@ struct idpf_netdev_priv {
> >  	spinlock_t stats_lock;
> >  };
> >
> > +#define IDPF_RSTAT_COMPLETE		0x01
> > +
> >  /**
> >   * struct idpf_reset_reg - Reset register offsets/masks
> >   * @rstat: Reset status register
> > diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c
> > b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> > index 827c795afcb6..92eb3e9de77c 100644
> > --- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
> > +++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> > @@ -1874,7 +1874,8 @@ static int idpf_check_reset_complete(struct
> > idpf_adapter *adapter,
> >  		 * register for us yet and 0xFFFFFFFF is not a valid value for
> >  		 * the register, so treat that as invalid.
> >  		 */
> > -		if (reg_val !=3D 0xFFFFFFFF && (reg_val & reset_reg-
> > >rstat_m))
> > +		if (reg_val !=3D 0xFFFFFFFF &&
> > +		    (reg_val & reset_reg->rstat_m) =3D=3D IDPF_RSTAT_COMPLETE)
> >  			return 0;
> >
> >  		usleep_range(5000, 10000);
> > --
> > 2.56.0.385.gd3acb90ef8-goog
>=20
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Tested-by: Samuel Salin <Samuel.salin@intel.com>
