Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32D6606A337
	for <intel-wired-lan@archiver.kernel.org>; Thu,  5 Nov 2026 12:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=VpM/Bktr;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fs0629YE
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AD4BC40743;
	Thu,  5 Nov 2026 12:51:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R8n6Bhv_vOYV; Thu,  5 Nov 2026 12:51:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EAC9340511
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793883099;
	b=l/VxnClW8OY1VPIq1Tnhv9YYaKElZ2tHZSO3uKjoVYdHW3ft4mJShAcPmi+dpdRd63kh
	 O6oA0ouezolkCkp2ejxqc9PDnRFreYov3ApzvLfObVx0vqCwW7xxn/P3vig9ak48sgrxg
	 H4TpAP8X1zAOF949amhdtFAOeqWsKi8bFbCLrrnsp6c05Vc8B46zXnEfbhkib9kjtcqRW
	 bzH/lyoTutoaH2wW0AbcvPItwtay5dax6Xm3aWvg5/IQ/7cFviq4ceaTMjCV1XwEprBIh
	 uLx5bpWEVKny1qsGEMfkI4vv+WWo9W6CfMZQRgSd5tEJnSp9zF2H0KBQz7+fiwL6AXQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793883099;
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
	bh=8skIC5iU75GJszF8sxnnl0uGOGTklkzPu1m53Rdr2ts=;
	b=OzPWEjmoyySVF2v0+GTQdxMNh8mHSIPPZob4/lWeEdC/+LOPheP2Yg4/Mk49HlYaW6iZ
	 7G6PK1/gOEmlqDU7MIyGVpy7yWRYDp4Z6VeudR8LEmg9ZyX+Ky3BamMaPcvcwGtVDyOO4
	 +Tks0tusxsOpNxFxyP/ZGaWijYnLbgtX2GVbGb+ujM2T67aI+ZiyzW1DzRS6PYyUvDhHL
	 A6x5QXRjoX1lIaOvQijT5ZtuaNRoo3Y8YYC0OdN9FQlkzpT21iyWVq4bMMB6VsxPNuh+j
	 4OQmeJ/6hlBtOFuOWnpuEDEKO9Bu7WKcGPw6nAClPHssdrI/AwOIE3dM4AtMO4eDfvQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793883099;
	bh=8skIC5iU75GJszF8sxnnl0uGOGTklkzPu1m53Rdr2ts=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VpM/BktrkSf5wtQWWjJWnQFmvqmEc3hlhTh0FxpkDjaogoOSNdU8Kh7t//4h61lME
	 PyKb9t4uLwqnZ35XkvnZhOQy3T9rRg1/Yxo3bGVJxZzL6cx3DznzZXqCHvXdDPCDFL
	 Hx9mOgCYgHBUKnoL2nrnuOc8bdfpF4yUittyuNWxF6maW6NMr8A338uuE6A5JZRFKr
	 wcpIUXGIq2dj+KvX3wa9dT8ACrsM+rTQYNmk1n+mRQ1tSyoB/9oSFUK2TAR/gk8c+W
	 H/JzApnicthCkfk5oX3rd/DPy62YbhvzXbQHNJ1lW3TCBQBY+UgwPndKbq3p21TyLw
	 o2J1Cel2K75Rw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EAC9340511;
	Thu,  5 Nov 2026 12:51:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4951ED3A
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Nov 2026 12:51:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2F64C400F3
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Nov 2026 12:51:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bb-WqIoFF0DO for <intel-wired-lan@lists.osuosl.org>;
 Thu,  5 Nov 2026 12:51:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 323D54008E
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.19
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.19;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=fs0629YE
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 323D54008E
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Nov 2026 12:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793883096; x=1825419096;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=7DrVuWNI0J+Mc66vviySa3knCfovhZzMM/paxCCEK08=;
 b=fs0629YEbr9QkIYTJO//IJwcIDlipWlV9Ws4VhIqJRI6n2UTuIeKOYqn
 sTSMDGn5fn9gmJRl66gVaf8Ejhh1N3dasQQC3fq8LHXySwcju3z6X7+H0
 6JSNwU3/u5+IM0FREZTP8D54zW9MCOK3dotyYsgRPsM7IyHwRQG07KRnr
 3kyC+fFZu2j/rtC8N65VilDK594ohASIbYZAKfR9jxjFCFcHTDwgzxsz+
 ICxC6H1ON6He0+2bJAGZsb0jzyj2cKf/ZwpAFS+LAcX1WLieSGgeLf1n5
 HYpjEsoIhMgPYcIIvMEDtrmMPAazMagOWK6hHdCCtx2iJVBu2stq1z6Il Q==;
X-CSE-ConnectionGUID: mRnmPnX3RAG+scsPA+W/Ww==
X-CSE-MsgGUID: DNmPCJYVT/ux08te3eC5ow==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2768626"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2768626"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 04:51:34 -0800
X-CSE-ConnectionGUID: IaH8hPtvRPKmbpPIZP3Fzw==
X-CSE-MsgGUID: 0dTQdu1dRjquCE6wYBuV/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="6886982"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 04:51:35 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 04:51:34 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 5 Nov 2026 04:51:34 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.16) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 04:51:34 -0800
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 (2603:10b6:610:34d::22) by DS7PR11MB8827.namprd11.prod.outlook.com
 (2603:10b6:8:254::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 12:51:31 +0000
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584]) by CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584%7]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 12:51:31 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: David Hu <dhu@x6u.co>, Mustafa Ismail <mustafa.ismail@intel.com>, "Shiraz
 Saleem" <shiraz.saleem@intel.com>, Leon Romanovsky <leon@kernel.org>,
 "Jason Gunthorpe" <jgg@ziepe.ca>
CC: Jacob Moroni <jmoroni@google.com>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "David, Hu" <xuehaohu@google.com>
Subject: RE: [PATCH rdma-next v4 2/6] RDMA/irdma: Register irdma UVERBS ioctl
 namespace
Thread-Topic: [PATCH rdma-next v4 2/6] RDMA/irdma: Register irdma UVERBS ioctl
 namespace
Thread-Index: AQHdaxojrDxuDh2kf0qbAEHzYwg5RLcfcnpQ
Date: Thu, 5 Nov 2026 12:51:31 +0000
Message-ID: <CH3PR11MB566895AAE815D00C51479B31A8E5772@CH3PR11MB566895.namprd11.prod.outlook.com>
References: <20261030181512.2056056-1-dhu@x6u.co>
 <20261030181512.2056056-3-dhu@x6u.co>
In-Reply-To: <20261030181512.2056056-3-dhu@x6u.co>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB566895:EE_|DS7PR11MB8827:EE_
x-ms-office365-filtering-correlation-id: d41de504-81a3-44c0-5b62-08df3b3b83e4
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|18002099003|22082099003|38070700021|11063799006|4143699003|261022113327099003|261102123227099003|261028144727099003|261026121527099003|261022105027099003|261026140227099003|261009223027099003|261021121427099003|56012099006|261022075727099003;
x-microsoft-antispam-message-info: qUAjTAbOIY6aqrRcafE/E/i2jrrFvhgtAkvUWuQJRuMQ2IbdnnB439SkfWiw9YSG92qK9WHvU/1oEMw5DzuO3TCWhOYymaP4jzCSSSCX6XSD7ylHQuf8K8LIFhh+Ne9tx60snxkUhg4CffHbJvigCcSIS+rVha8CvLawBfR1PjNfdRbbAHDESDBsIGcMJGyfj2/l9sS9KKc9Amb7OpcP6jzbz8JOH1TyCd8Tnl7yYc2thqWVXol05ZATGyz3ADAo5pxu/2LpOpJh9VKdyEMRC+nN7gfANl9QYSIO8JGdP2NRfxVQ974CCUc4JoQNxE00z0NTKQ0/fmSmWUL6tfhFMwxDNRq7AVBpSEDkckcw2mKlG+DRzc20HElNFIjDQf1deNyW9uiHMH8lYXAB5I9QPvv4l6TWkicEAaSKmOFjfs90sv6eTmKsevegdLcxvm3F73RqNSKN9ES0axdpnDb7kKI9LOCKV0CUj+c9wCZ2kpbEVk7WGIIfIH8BfESc4LOEyAQG44jN6Jrt9dOW+bmayfYedC+x0rMvj3Ea9VSsS1NoSB6xxIqnPSTmoh4m9hKBrV2/R9Qr98s2erKszwFXZTsjDij4uz0zGmsrfk/UuZJYx2WlCbIaDEiQdQUfuJogmioScE7UttNmDJP18+6mZCqry0rMLG3KI6ryvcpGU8A3Rp3bqjZFDC23r985FyBjE4ql5ntzkcTtHnblHZns2N5+XPiX19QBe/t/f3dBdWA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB566895.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(18002099003)(22082099003)(38070700021)(11063799006)(4143699003)(261022113327099003)(261102123227099003)(261028144727099003)(261026121527099003)(261022105027099003)(261026140227099003)(261009223027099003)(261021121427099003)(56012099006)(261022075727099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4ao3He2gEFCOoPyx1MSNUYuRetCBVOxA95znQGeHWjHGPFX1+DvbIsoegcmq?=
 =?us-ascii?Q?NpKt0bFLtx3em/pWMIwrke9f3C7Y0gc5YcvVUnl2GkBmlVErfO5QzSREQBi8?=
 =?us-ascii?Q?UoC+zgiQSAlDUH1BzQqFW0WIFgWtL0WQqxZz08tWlGAGVfStG+C7zJTv4rna?=
 =?us-ascii?Q?ryMpUuk7gfZBXbyO4pObTXMzRzGqJtjkeOE8siCuM0bb2STgiknsiK/Dk0Au?=
 =?us-ascii?Q?Uo7/Bb13S5eG1/lax4cr8i9fkEtXDtuTC7Akr+0vEwkwbQDg7UR7HtNbKhYN?=
 =?us-ascii?Q?f8IEC/emlZ03odkEIOrnbUkAD63dnMx13h5ziVjDFEOYlK9QuZwAhfglF8au?=
 =?us-ascii?Q?i/DKFasOXBXbhNRYN2tJbaDWIRUR2qkP9KmIBE5bOe4SO83JJmIPexjHufww?=
 =?us-ascii?Q?l7QrCbWagcX8ScMRFNL0V5s3KCCSt00Q3TR4Tf6PZAFih14YwTwqDVQ5ARHJ?=
 =?us-ascii?Q?tvRx+jZ1EEIZ/QcgyVtnZZBfTNH9xvLZMEe1xCJMf6uqv71jvZ/SEmsVl3mh?=
 =?us-ascii?Q?OcdTydQUqWFObMv4cAF5GLn+ZVZ6AbhR1CcONRplERq/GtYtLUBhkY9YiNIb?=
 =?us-ascii?Q?Od+OQN6c1YkfRrp+8I+iByZDqNYW6nY2pags5FwiFk8cjPDWY4CXYxATTJND?=
 =?us-ascii?Q?n6yMNsgaWTF0IiAwZnN8drUiOP+DdZ56QTJAlkhq8cbf0GX1of8y6+LLAdWi?=
 =?us-ascii?Q?bZX+1dakWk5Wz2hXshb0WQWfCYWvbJ6wbfjOGu1XAHaI2nNw5k9QkBME1FJW?=
 =?us-ascii?Q?yIIfue8xT0NL8XYuP+yWSDZ1kdkCZszuIMlYIOYvRk5eRisvxI9uVARJVtrl?=
 =?us-ascii?Q?1DXnoHf24FaAYVAeS8D2OH52H9HTCiBw384aqkOrIOTDkdYclsW4s5qfbtZ2?=
 =?us-ascii?Q?CQo68kFoPxdtckAz7egSqaBSJjbNg02icX0YIDn/L8XDjgPK2oRG8drYz2Ci?=
 =?us-ascii?Q?weQ5QMz8vjPfKp3M5+MYCiwXVjJTShchzO1d1w+8cUMs816qFcaL4DQ46PJ8?=
 =?us-ascii?Q?7RohrpFMgY+3QOAdNHXRqR6tGxenRzu4ys0XnGVRDwyyzQastBYHc8HJ32a7?=
 =?us-ascii?Q?ItysYk+8gs9NkYAfoDf5Yc8vAiLMV5DCArKq/BHFM2UChohP87bDAAmUYXQ0?=
 =?us-ascii?Q?UH0GbrIWSmITHg8Vs7kwWJ+D1ohS1E5HVsG9L6cdy+oE5t9HnpfxJ+akNz4X?=
 =?us-ascii?Q?bhJM2fMMgELssFiVztXe5pf2ptR2+ZyWCy+za8XeGB8PYDvRkU8Q3ZCWvl97?=
 =?us-ascii?Q?WQhCbwQ13Nwvge/+Ndp0pCcF+ub/Jprf9mgIM/xkYYT7DQcKvZ9zI9k2b4N6?=
 =?us-ascii?Q?PAutr2wNyng3B8qOLiXS/DrBB9fWObYkY/18vDnS1W/TN/6zmNkGN0vChKhB?=
 =?us-ascii?Q?nb1q9ca2yhRVNfddK7dxHwoKB99WvhWwBK9sIyqv5fszWyw+sXb6p4bPOnQR?=
 =?us-ascii?Q?CxPbQYTpCxbWjRJkHuV+CzfVjo1+NPF0okO9goMN7IJIeRd7NjS3tqWzBSlh?=
 =?us-ascii?Q?+LImAlMoEkeDGpXfPXMSIdL1pQpUMFGST3wFRajW1get5ZNp3g2L2S9Pzq9a?=
 =?us-ascii?Q?gxp2XDLgvJXF6mm6gHc1JSMWLnHDnWkKZUHGqK6oVnEgt90jii7d55VBPJPg?=
 =?us-ascii?Q?55y+Ufl3T6B6TioS0PhRzs6hbBGs1pamI2+u69EhrG36OKamE4RurqKVcgj+?=
 =?us-ascii?Q?boGyUnd/mVwQMBK+FyUpN0G/b99DpxK6lyuAeZiRRfIf1i240Yekt+9J5nkS?=
 =?us-ascii?Q?8qp8pHpIjcjmLNOuGSWgXjjceWLi0YQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: J7mq4q1tcT2ujggBwV45m1/Lq52umM0m9XlLSQ3bi3p+K13Wn0uHG9eP7g0Kgox5JbHtWYidky4PMfdecF1zz+s7lJu27dhc446onrmNJj/b9wSvbXGd0+amseFCA69SMJ1LGvKoaSFI1JeeHtZIIjlg2H+AM09rO47uuU7MvYWEKSFEPDZtuU46g2Ei5vPGLTC9yd9x+03J3I+c0zNu09QW1HEmRLDpALi0Tmp4322/9Iu4j22LutV9695aeMg9dFRYV0yN4s6VodvTr1H2SBEsoYNexMN5UEvMpAYup9EcjiO9/W3QWg2avUss8WFq/5HB4Y2oBiQOG7lpy0tNJg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB566895.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d41de504-81a3-44c0-5b62-08df3b3b83e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2026 12:51:31.1483 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m7O3SPLdaMiVdT2tnx/pH5Dc/sGF40ceFzOnP7i3azpojWKU8+OuMHaDS2nX+uAEhIl0uh3NVgmKuOa8TI1UpUtg5hBj3hQ6Pk6F+JbD2hY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB8827
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
> From: David Hu <dhu@x6u.co>
> Sent: Friday, October 30, 2026 7:15 PM
> To: Mustafa Ismail <mustafa.ismail@intel.com>; Shiraz Saleem
> <shiraz.saleem@intel.com>; Leon Romanovsky <leon@kernel.org>; Jason
> Gunthorpe <jgg@ziepe.ca>
> Cc: Jacob Moroni <jmoroni@google.com>; intel-wired-lan@lists.osuosl.org;
> linux-rdma@vger.kernel.org; linux-kernel@vger.kernel.org; David, Hu
> <xuehaohu@google.com>
> Subject: [PATCH rdma-next v4 2/6] RDMA/irdma: Register irdma UVERBS
> ioctl namespace
>=20
> From: David Hu <xuehaohu@google.com>
>=20
> An irdma UVERBS module is now created. An irdma specific shadow buf is
> defined for CQ, while QP and SRQ reuses core's uapi definitions. This
> works since core builds shared core ioctl parsing tree first, before
> adding driver specific `uapi_definition`.
>=20
> Destroy paths are automatically handled by core dispatchers, as objects
> are now registered in the parsing tree and no additional driver
> specifics are needed in destroy ioctls. Resize, Query, and Modify
> continue to go through write() cmds.
>=20
> Signed-off-by: David Hu <xuehaohu@google.com>
> ---
>  drivers/infiniband/hw/irdma/verbs.c | 18 ++++++++++++++++++
>  include/uapi/rdma/irdma-abi.h       |  5 +++++
>  2 files changed, 23 insertions(+)
>=20
> diff --git a/drivers/infiniband/hw/irdma/verbs.c
> b/drivers/infiniband/hw/irdma/verbs.c
> index 811b1d532599..dd824720671c 100644
> --- a/drivers/infiniband/hw/irdma/verbs.c
> +++ b/drivers/infiniband/hw/irdma/verbs.c
> @@ -1,6 +1,22 @@
>  // SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
>  /* Copyright (c) 2015 - 2021 Intel Corporation */  #include "main.h"
> +#include <rdma/uverbs_ioctl.h>
> +#define UVERBS_MODULE_NAME irdma
> +#include <rdma/uverbs_named_ioctl.h>
> +#include <rdma/ib_user_ioctl_cmds.h>
> +
> +ADD_UVERBS_ATTRIBUTES_SIMPLE(
> +	irdma_cq_attrs,
> +	UVERBS_OBJECT_CQ,
> +	UVERBS_METHOD_CQ_CREATE,
> +	UVERBS_ATTR_UMEM(IRDMA_IB_ATTR_CREATE_CQ_SHADOW_BUF_UMEM,
> UA_OPTIONAL)
> +);
> +
> +static const struct uapi_definition irdma_uapi_defs[] =3D {
> +	UAPI_DEF_CHAIN_OBJ_TREE(UVERBS_OBJECT_CQ, &irdma_cq_attrs),
> +	{}
> +};
>=20
>  /**
>   * irdma_query_device - get device attributes @@ -5602,6 +5618,8 @@
> static void irdma_init_rdma_device(struct irdma_device *iwdev)
>  	iwdev->ibdev.phys_port_cnt =3D 1;
>  	iwdev->ibdev.num_comp_vectors =3D iwdev->rf->ceqs_count;
>  	iwdev->ibdev.dev.parent =3D &pcidev->dev;
> +	if (IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS))
> +		iwdev->ibdev.driver_def =3D irdma_uapi_defs;
>  	ib_set_device_ops(&iwdev->ibdev, &irdma_dev_ops);
>  	if (iwdev->rf->rdma_ver =3D=3D IRDMA_GEN_1)
>  		ib_set_device_ops(&iwdev->ibdev, &irdma_gen1_dev_ops);
> diff --git a/include/uapi/rdma/irdma-abi.h b/include/uapi/rdma/irdma-
> abi.h index 38155affc8b4..a1a26529aa85 100644
> --- a/include/uapi/rdma/irdma-abi.h
> +++ b/include/uapi/rdma/irdma-abi.h
> @@ -10,6 +10,7 @@
>  #define IRDMA_ABI_H
>=20
>  #include <linux/types.h>
> +#include <rdma/ib_user_ioctl_cmds.h>
>=20
>  /* irdma must support legacy GEN_1 i40iw kernel
>   * and user-space whose last ABI ver is 5 @@ -23,6 +24,10 @@ enum
> irdma_memreg_type {
>  	IRDMA_MEMREG_TYPE_SRQ  =3D 3,
>  };
>=20
> +enum irdma_ib_create_cq_attrs {
> +	IRDMA_IB_ATTR_CREATE_CQ_SHADOW_BUF_UMEM =3D
> +UVERBS_ID_DRIVER_NS_WITH_UHW, };
> +
>  enum {
>  	IRDMA_ALLOC_UCTX_USE_RAW_ATTR =3D 1 << 0,
>  	IRDMA_ALLOC_UCTX_MIN_HW_WQ_SIZE =3D 1 << 1,
> --
> 2.56.0.317.g454f8302e1-goog

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

