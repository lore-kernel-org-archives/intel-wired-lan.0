Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B816C606A32F
	for <intel-wired-lan@archiver.kernel.org>; Sat,  7 Nov 2026 04:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=8Xtx35if;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JdM44WZR
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9AA9B81113;
	Sat,  7 Nov 2026 04:52:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZRH2UexgZqsm; Sat,  7 Nov 2026 04:52:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D7C3D80F34
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794027166;
	b=Go7CvfEutvlLUOO61OZUlgH6yjZWMU2xCzwa1oe/HFKHK/emr5vo+Qz1Ka34Jx25S2xf
	 5yK/huU1EMX0Iam+9E8fBz0VVtCXb9F64oJHy3NdAonqDsL/hvQTLhOzf6rmWuIsERxPX
	 JlCSKnCzSxvI3wiWk/VDosYuGz0Vnm78G/lCczRD4tM+mDIOQr6tGNrPTt2LlzNi0T87v
	 8qdW71z9FjgZMPLeGA8Q921NkfaBby+MYABUxuPX1Thv5yZR7lzhSskRyvKCLTrRf755F
	 rB/fW8MujS9xQ2++551cDbOF7JD5ms9EigXoVVuAs/au2ltZuYdLEVvp7vtyRBit7Hw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794027166;
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
	bh=DQ2CxmvT3XsseZe5DoIlvXuw6SrwXzjZ4D697go2oq8=;
	b=Wsw2zmr2V6VfDSa7Tk1HsrV16K9X26sMwwovkO/DK7xaQASngZBobXGxiz+0ph5SnzJw
	 juqWYFUFYQWXpcXm9yfClFEvF+0i2LG8hHZdhWH3K+EFBxeykB+k3gWre+dYJndqwoMjQ
	 3B6KYgJucEwVRbe3Y0CXFi+a8VEp6vp2DWSZfjwkZORTWkiv4pS9MxO2wv6dEE7QJw2WR
	 pFGl5h1gvaoKv79vv/GVZHYPY6yaFRVA1Fx06xwGUghuaGVtZi/sFCYRTyFl+xxo+RxaW
	 jYmcfQXGJDCTA2FlLZgFaEMeKmYPiQzQKnLK9xgENErKUAm7INQaMQlzAhza6/dYwqg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794027166;
	bh=DQ2CxmvT3XsseZe5DoIlvXuw6SrwXzjZ4D697go2oq8=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=8Xtx35if7EKk/l6URvxJHjPgDo/DftHfCaWnbR4TMMtT1izwYYt+O2mibQxgy3BjE
	 tvGmpB7CdV3g5WrTG5zH6wmEQoCXvvFtiPku6mDFemSGNsPDB4G42DIYjILA78+f65
	 db253W4xsM8r+u1NYVr3YPeONKzLlWjcz7Mm1D9/rFQhH8QCVVOOkDZhopp3EeppUn
	 aHdb+S0YtekU7+KLFjpEGPNO6rDZtoKnrwTHTKG4wfE0RUncVo+ctJ14vQgelmtC1Q
	 vQUd1aiLz2vntQV6V4hnRPdCW2qT9hIzX+X0CbUPvzw2aEJi8ylUMeaga70X589mnA
	 FSfJwP7ohdXJQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D7C3D80F34;
	Sat,  7 Nov 2026 04:52:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2CA2E362
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 04:52:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1E7B540993
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 04:52:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YZ1DIDbC0vov for <intel-wired-lan@lists.osuosl.org>;
 Sat,  7 Nov 2026 04:52:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5077B40994
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.17
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.17;
 helo=mgamail.intel.com; envelope-from=alexander.nowlin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=JdM44WZR
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5077B40994
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 04:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794027165; x=1825563165;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=BrOgqVpNkiAmgOwKOCyDdYSBHrCp+Ld5uPyu2K2LqJw=;
 b=JdM44WZRJK3t8XQikRQ0X5rGPtDKEzTFtHcy9mK2feaAmLTmYj8az9mc
 OEpzF0LD43TAYzdzeIC6iU+k5JprHnShRd725sBE/0Zs3hSN/zlw53od2
 Z13ceeIBf+abMBf1m550D4VWLCA7gcYMPDRrOwLsIV5gB1yA8jdf3sbzj
 7yITye3VVTSuRNOQVMLKugzx9iCwq/RRitgZg99T4C4dDNfhA/h7Fes1X
 Al/1yKc0iv891vzYpcCr0WvJcoOtPbkAWiGlYOi7wDwPskWMOctHl4JPw
 4cQUZiVECd+oA1JIU0Sruc+3+2f6HABDOHoH+d8Wmv1bjMfDKeB4OWgKu A==;
X-CSE-ConnectionGUID: WfNjYMAsSMq4vLTRd/7YBQ==
X-CSE-MsgGUID: KbnfZZIIRkCuNJzazwLDaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2842079"
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="2842079"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 20:52:44 -0800
X-CSE-ConnectionGUID: SZmUTUuGRJ62DABdluLsKA==
X-CSE-MsgGUID: Anvd7501Rruv+xPSCsdkZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="7777599"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 20:52:45 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 20:52:43 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 6 Nov 2026 20:52:43 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.22) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 20:52:43 -0800
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by PH0PR11MB9727.namprd11.prod.outlook.com (2603:10b6:510:399::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Sat, 7 Nov
 2026 04:52:41 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0592.007; Sat, 7 Nov 2026
 04:52:41 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Oros, Petr" <poros@redhat.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
CC: "Oros, Petr" <poros@redhat.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Lobakin,
 Aleksander" <aleksander.lobakin@intel.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Henry Tieman
 <henry.w.tieman@intel.com>, Anirudh Venkataramanan
 <anirudh.venkataramanan@intel.com>, Michal Swiatkowski
 <michal.swiatkowski@linux.intel.com>, Jesse Brandeburg <jbrandeb@kernel.org>, 
 Preethi Banala <preethi.banala@intel.com>, Kiran Patil
 <kiran.patil@intel.com>, Dan Nowlin <dan.nowlin@intel.com>, Stephen Hemminger
 <stephen@networkplumber.org>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: RE: [PATCH iwl-net 03/10] ice: stop the LAN Tx queues when
 ice_vsi_open() fails
Thread-Topic: [PATCH iwl-net 03/10] ice: stop the LAN Tx queues when
 ice_vsi_open() fails
Thread-Index: AQHdUm8vQOWWpreEhEihZFaCQaUJq7ciQqEg
Date: Sat, 7 Nov 2026 04:52:41 +0000
Message-ID: <LV1PR11MB8790E5A86995DE21D2BEA39290752@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20261002130752.2597259-1-poros@redhat.com>
 <20261002130752.2597259-4-poros@redhat.com>
In-Reply-To: <20261002130752.2597259-4-poros@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|PH0PR11MB9727:EE_
x-ms-office365-filtering-correlation-id: 0add34df-491a-430b-72cc-08df3c8af498
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|23010399003|38070700021|11063799006|4143699003|261021121427099003|261022075727099003|56012099006|261022105027099003|261021123027099003|261009223027099003|261102123227099003|261026121527099003|261026140227099003|261028144727099003|21046099003|18002099003|22082099003|10067099003;
x-microsoft-antispam-message-info: 5jbifSLhdjY8ETQFy5OQiZ46ppj/ukCUmiX7HKf7n7yydfhuA1DojBo2TdamvDRC3BfPfNE/JuE3i3ej8pkZPopwPNxCDX/pUadYRYo/j752YHuDF3C9nvr5gdaarftU5GJQzYo7/BbuoBoN0iQCc3Ln8j7LJa0cBtS0W+nQ/S9TW8eTM6hXclgSd/vfOLXxb39Trc+ctr8soFAR9RlPDXViqdgfd3Z0lZGZQuWxltlwNrfZjVYaDNpJvH+s9tbxrjnvJrgH/Ou+nK40uUk11O21OimHxPemJmPZL3StmyPil6Rw02OCtWp8AoXfqi3S5X7D2JZbWkDYhIObg0KouX/J0mw41TtvynI2/BnyCN+tts5VUd/OLHCKziksPch4nP5NMohxRcEu1Jg8rc+giiXP5lHhsICI2NK9I5Kxk32XyAUZoZinEHpjaE/s7W0Du1lNP175z/h6Ahd7d3ICRSpCpwqT3z4R6fkTa38trFsDUj9QawbgZI6HUEKt3Hv64COt48rHUaPhZVgXO7SZDxhzZ89p82oGXfuFrnEN10LS6oF6PYyDlebLPVYR71884Q5RH4QqWmZ7yYK9IjXyI0LpbubkMZav8ECD2Oveb/WGLWuSajhWaEoDeXiUdXNHOlOpGXJSqwNJTBh4ngEcni7sIeb1PRjAsK2mEtzaCNGBKZelTIpk4CGPQFPjdaGMRByWqrn2qz4MI9xyPqcIiR8+ZzAgtty0eesvwPk4hig=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV1PR11MB8790.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(38070700021)(11063799006)(4143699003)(261021121427099003)(261022075727099003)(56012099006)(261022105027099003)(261021123027099003)(261009223027099003)(261102123227099003)(261026121527099003)(261026140227099003)(261028144727099003)(21046099003)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1n6NgU16cN2hFC92Na7F0/vyICvkLe304hKA0vpMONlPwVS9ytI0zFLeaTF4?=
 =?us-ascii?Q?JW4IjJ7pcDI3KvNaBjyp1n1md8rVMm9OI6f9F5jYZ+rKwnv315ij6Pd0lukf?=
 =?us-ascii?Q?UEIgEsF1vwWfoXkYaUMAy0ful73SpspVvyfHtH0vcxXdxgnODucJS41a9zSh?=
 =?us-ascii?Q?Yh9X1Xd/hHyaoKout4OCk5fSJgOweU3+UmEWr63FImG8msfIvP97ZUHeai1p?=
 =?us-ascii?Q?yKjOhahy3PVDDMMZPeYA6z2VzaW3vlhaVjNW0lQ3xIeJRaQbO+nUu5uLwd07?=
 =?us-ascii?Q?+x7JGQ95SMNahHuD/Xgebf+hClO7fXwiaqA869m6DhBKyeacfLKH+FOel1ln?=
 =?us-ascii?Q?2G3FQyvE1IMhH/7hZuCjmtamRueeWN9CvlV8gTSdSaI/OKBm7C2dHMZIHEUH?=
 =?us-ascii?Q?gHqRAJYsxvwt1RYZfNo87aOlQ1/HbCpxnxNI6W0HRoUdXr/rlXsincHH8joM?=
 =?us-ascii?Q?oyKRiGVudIrFUtI8kSqPH/DGQeTCt1kp+bfJfK6nyXAIgfKeC9TX+x1AuQSj?=
 =?us-ascii?Q?eu0X2GJQYO3V7xeifG4YOqqYFO7D4DxDTSqhC5VqJd7dwM6QLNvViCaNd3n5?=
 =?us-ascii?Q?XPUW7h1zx/ETi1tSB54Uk7QF/Jl3olIIFUo6V3qSnuxrQV5CyJjQz6auTi4d?=
 =?us-ascii?Q?dFHgQGukmi2mkF9vtFKRC+aoKyJSvx2wWiSIOSRRMAcrDWCp5NxTcgyyGZ94?=
 =?us-ascii?Q?J7iYCFVWvwQu479/XA903mz7jW9laeNYCNtmfqULMs864NQOYPTkzw2SCx1s?=
 =?us-ascii?Q?NvVb1HN5/fr1BpPg/fkwZ6pPjfQf5fI/boayU82MhQo3nTo+vGFxBmKqfP0j?=
 =?us-ascii?Q?AOYOe6govxkVuxYoCimTtyN7FmUBf7xop6ypxeE61jxnSqtXYF3MVAXdJa5W?=
 =?us-ascii?Q?hYOL5BykTFqvd8BZ/S+/kG0sindg3qqgcX32B0AhSL+v/xvtOYT5U8vmyoQX?=
 =?us-ascii?Q?Uu+SRmsIKtfGEJXhrGgdok5VoV7d2RqMXcJ4t/np1SuzQVbD4Pdq5ITjh56H?=
 =?us-ascii?Q?u8RYORzGsXgc4MWxOAGEub6PL1iI34eZleQjRbIY+XGXROcNlSXTVlQG6Oqc?=
 =?us-ascii?Q?nGhEuNizVYGXlEvaMcxohWnstbxlI06+sCPqSNo2GAtm73L53iR6eRfOpOQI?=
 =?us-ascii?Q?W7vT76uzC1iGM8JKOt1EowDdWyRg6FoHmfyZ4ycIWIZPcu8DZ6q2q7P9q/Yv?=
 =?us-ascii?Q?46lIX7mWeOi593QYHjtbMrfhVOA9onKkha9J5ioShqJOhAXWp9eTbnEQIL5A?=
 =?us-ascii?Q?uM/EZUOXE0DweCvQkxQIy4CVcb7QaLaOsWEus/H6Y1xwK6X5NeLUVkZyDJ4/?=
 =?us-ascii?Q?S/gNwRLEIq8J9xhkUxxzc1sANrwh5zOMbPf5HF0Ew7b+QFqMV8AHZjnsJ9iT?=
 =?us-ascii?Q?W92IYj+4GJF2HIYrDZNfor3sGavEDgoEzAGqCRTTI9Ocr8vDgneIUQyuTGh1?=
 =?us-ascii?Q?1yZUKb4gj0hffD8xt3t5atffV7RmGWfpCYSON70bIytqSZnPUIVCAtt5vJZW?=
 =?us-ascii?Q?Ct/OItTzRwMJU0GVQ/FZM3B6z7zbEvObaqwbJHgFxf1mFmGznqlnUxXMKkVv?=
 =?us-ascii?Q?1OytMydsKyFK0UpdUiPum21V6SEYqzOxAIN3++Rfr5z9nHf2o9RoRPcEVy0V?=
 =?us-ascii?Q?XBogUl//cWxjh/Zu607u1nOE9nhIJ/0+e/zRSdinw0/1jeuxcuvIOFbC/inl?=
 =?us-ascii?Q?X2pR0PAjMhzZvCk3senJ0vA+ui9cyylhIysLTUsA0GbLUApkWAkJ6svFyRS+?=
 =?us-ascii?Q?IkOzq4f4yQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gyNQfBdZRtsapKsMEG53TF/8ODbDQqn6mLBjdg8RdldAqV3DEm3FQvMfmRdpnttZW4+hErjeoBE9bR9BL1BwfCULzu5zeXq162wXjWZ7aPmePQyAnG1CymUkI7D6LTXO5lpPywoftyaYU4qNnuIsqPqiHq916lsp0NK2uQUTZhJBdR5zpf8JUC3gecJpnNRaeu3j07UHiKpw5RjlKpQdzgO21DQl4kHEgDph1/qzJ2y5Q0OaPp7bxbRNx84tYt0Mo6u/B3BUTS0BjX5eutCSF8KLzrz7n3qbuJ3LruU9U/n2N5Jv+ScuqVDkl2VhiH3NOOkTwtdP/CQismwpH4I2hg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0add34df-491a-430b-72cc-08df3c8af498
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2026 04:52:41.6184 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g6eyzVvZmkt59Vl9p7wW9dkVnCAi+sN2eghEVp54/qUUsPLPgyMTG62xUp3N88FGfANhQ433yahBndl+YxF6IID1xDaK6buYXeCtjL9jotY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB9727
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> -----Original Message-----
> From: Petr Oros <poros@redhat.com>=20
> Sent: Friday, October 2, 2026 6:08 AM
> To: netdev@vger.kernel.org
> Cc: Oros, Petr <poros@redhat.com>; Nguyen, Anthony L <anthony.l.nguyen@in=
tel.com>; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn <=
andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric Dumazet=
 <edumazet@kernel.org>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabe=
ni@redhat.com>; Lobakin, Aleksander <aleksander.lobakin@intel.com>; Alexei =
Starovoitov <ast@kernel.org>; Daniel Borkmann <daniel@iogearbox.net>; Jespe=
r Dangaard Brouer <hawk@kernel.org>; John Fastabend <john.fastabend@gmail.c=
om>; Stanislav Fomichev <sdf@fomichev.me>; Henry Tieman > <henry.w.tieman@i=
ntel.com>; Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>; Micha=
l Swiatkowski <michal.swiatkowski@linux.intel.com>; Jesse Brandeburg <jbran=
deb@kernel.org>; Preethi Banala <preethi.banala@intel.com>; Kiran Patil <ki=
ran.patil@intel.com>; Dan Nowlin <dan.nowlin@intel.com>; Stephen Hemminger =
<stephen@networkplumber.org>; intel-wired-lan@lists.osuosl.org; linux-kerne=
l@vger.kernel.org; bpf@vger.kernel.org
> Subject: [PATCH iwl-net 03/10] ice: stop the LAN Tx queues when ice_vsi_o=
pen() fails
>=20
> ice_vsi_cfg_lan() adds the LAN (and XDP) Tx queues to the scheduler and e=
nables them in hardware. If anything after it fails in ice_vsi_open(), for =
example requesting the MSI-X vectors, the error path only frees the ring me=
mory and leaves the queues configured. Every following open then fails to a=
dd the same queues again and the netdev can not be brought up until the dri=
ver is reloaded:
>=20
>   ice 0000:04:00.2: Failed to set LAN Tx queue context, error: -5
>   ice 0000:04:00.2 enp4s0f2np2: Failed to open VSI 0x0010 on switch 0x000=
2
>=20
> Stop the Tx queues on the error paths that run after ice_vsi_cfg_lan().
> The ice_up_complete() failure path already does it through ice_down(), so=
 let it skip the new step.
>=20
> There is no i40e counterpart of this fix, i40e does not add its Tx queues=
 through the admin queue. It was found while verifying the previous patch. =
With the IRQ unwind fixed the warnings were gone, but the netdev still coul=
d not be opened again after the forced request_irq failure.
>=20
> Fixes: cdedef59deb0 ("ice: Configure VSIs for Tx/Rx")
> Assisted-by: LLM
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
