Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AAB606A327
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Nov 2026 07:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=IfiX/hqh;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ccIcfG9f;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=fIDWe/Mu
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C961D40642;
	Mon, 23 Nov 2026 07:04:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AxGtM1sT-wR3; Mon, 23 Nov 2026 07:04:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5E8B940635
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795417451;
	b=PVAEMAco5P7c3HCfVA5EzH/2BGJ0RtF4nXR+1rz1kzmNdvanGS+KcsWd+Rg0ISZl35yL
	 IzOhiNHl4skZrzcMiUb709s8OiC0fiAZ72aPVwDn/ohzlN/AM31G3rbFe8kqzVWkJPkmD
	 sw51PQfUZnjmfq4qwcawMyob/jFPHzzrWk4aXdVZZdczhvhWdmczGkaXh+SRF/vTR7jWe
	 BM3vz5mDw3Bf7dopEQLQEwj9CypuZxwBPfeUm2nP1+ganFw4EF9h04PP7qtb0e4eryg/s
	 sN5TRYgsXFF5DYeaH/5A+Nq5Ms3t4rrtxSsmnc0F3DvE8trXaY5+DYSNq9Da0nVz0jw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795417451;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:DKIM-Signature:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
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
	bh=jYy3FRxMVtx+6Up+UIZJwFzCbifaeBYI3I78Q8jrunc=;
	b=BHEP3WS3d5RXb0ygy2rZi+JBz8AFfj1cyNufUFCYb0QXtY/8RxS99FUfoCisB1F6iV4H
	 XRRhF6QkQKS7Blm2kHmPBa9SYTBr+Ggl4v7j4GzQQorxTElr1BvxkeK9i7bZUPbsnBd/Z
	 xuk3XNvZ32+za3HsZoiMEjktxH6MudEtXN4pzemi+Y1M/IOHGrKiDXHQ1A44h9BCbGrHu
	 dde54l/zGk53jBAsUuTL47E6lDjwdFTDUCoh924TsEv51IhUDKVn0Sat8KYOujif60tNS
	 /kfRSrwJLaSDamqzrRqOV5KZXDQ4PUVoEzlnpje4Mtbve9O499H7WIQZy9rdyUopFyA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795417451;
	bh=jYy3FRxMVtx+6Up+UIZJwFzCbifaeBYI3I78Q8jrunc=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IfiX/hqhO5C/oHI6i+Vz9fvP3xCn8pP7mei/mOabR4ENioHrZYFWpZSAiva5lme6s
	 tZEqbRzL1UD7E/NjtTKvhwVMKqndKq3TYNK5u7WRP5pqd6FVYCwwrsaVTy0ED4IBJt
	 XTTJRK7GgeLQc8cVBNVoDK3cjJ1O6iQIlilNUWPkd2TfKMfwPcUBEHAx3Z+V610tUw
	 r7y0YdYahYb02SrrT57hRH+N0aGSo/J/7iuuvudSCqyIKo8BRfwJc414LSOR2j0TUX
	 wKSaxYCk7eMt3mb0B47HpD+44SwgA9oGKNhV6qViI6qwrCJraM/FfeBenOQU2kuejG
	 VqNx9Z35v0vjw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5E8B940635;
	Mon, 23 Nov 2026 07:04:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4ACEC310
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 07:04:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3C8676065A
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 07:04:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3Ag1U29Y08gi for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Nov 2026 07:04:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AB7A7605D3
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.19
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.19;
 helo=mgamail.intel.com; envelope-from=ayush1x.singh@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=ccIcfG9f; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=fIDWe/Mu
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AB7A7605D3
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 07:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795417448; x=1826953448;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=jYy3FRxMVtx+6Up+UIZJwFzCbifaeBYI3I78Q8jrunc=;
 b=ccIcfG9fCm+D/rPphvxoXeTIlMw5yYrnHp6pFFttdpuv+3vVCV1yzvj5
 tkUzSi9maov+Qoa86fWh7Nnn2qya5tJJHPWfHpT+BVue2mWT2PSAnAjKi
 4UBjmGWLm/0kcwWIxHCTLDKwC01J8yKtRKcZwnrvXrbkIUTdTXXHuRvh7
 fZEDmeoIn4qfdbgWoZ73WCZh+ecDX5Nn5xj8Xb+kYKifYUB5mXiO1tY9v
 SgyhseP2oTUgtQujaLW6IR9kywURrB7WeIjAn9UNE0avT6GkrZTfjvksy
 rAkrLwFRqwsWuO2QmKADcJ954CND41seGNTvwMhyKcRUolzUKE89ShhH8 w==;
X-CSE-ConnectionGUID: SPh6dtknTr2kvOQzxVXq9w==
X-CSE-MsgGUID: 2qxmiFf9TJix/vyrlWhGQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4319048"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4319048"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Nov 2026 23:04:05 -0800
X-CSE-ConnectionGUID: Zx/mjT/MSBaB9hSbeV6zXg==
X-CSE-MsgGUID: IvD1jfF0Rce5p2m93SHQzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; d="scan'208";a="11316160"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Nov 2026 23:04:05 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Sun, 22 Nov 2026 23:04:04 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Sun, 22 Nov 2026 23:04:04 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.30) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sun, 22 Nov 2026 23:04:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jYy3FRxMVtx+6Up+UIZJwFzCbifaeBYI3I78Q8jrunc=;
 b=fIDWe/Mu+ixlwoI7Yd/tKEi9UxcBMmPiwipDLs4iLlgQ/yfuEEfWuebcvVops2rkHKh8MMzMPkHqs37NjLK2GKIO15hJXUZrNJLW7ok/gNMSkQaE6bAl1/JF0FYwI9JS49T6EtFSQjT6UMVkuA8Q8rS530gNsHiG/Rg+6pMXM1c=
Received: from BY5PR11MB3976.namprd11.prod.outlook.com (2603:10b6:a03:187::14)
 by DS0PR11MB7213.namprd11.prod.outlook.com (2603:10b6:8:132::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Mon, 23 Nov
 2026 07:03:53 +0000
Received: from BY5PR11MB3976.namprd11.prod.outlook.com
 ([fe80::c23a:c952:eb75:d4d4]) by BY5PR11MB3976.namprd11.prod.outlook.com
 ([fe80::c23a:c952:eb75:d4d4%7]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 07:03:50 +0000
From: "Singh, Ayush1X" <ayush1x.singh@intel.com>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>
CC: "alessio.bogani@elettra.eu" <alessio.bogani@elettra.eu>, "Kitszel,
 Przemyslaw" <przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
 <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "richardcochran@gmail.com" <richardcochran@gmail.com>, "horms@kernel.org"
 <horms@kernel.org>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>, "jianhao.xu@seu.edu.cn" <jianhao.xu@seu.edu.cn>
Subject: RE: [PATCH net v2] igb: initialize PTP state before registering PHC
Thread-Topic: [PATCH net v2] igb: initialize PTP state before registering PHC
Thread-Index: AQHdRrX6CW79ZeY6PEa7Q54LUMhz7bc7pCXA
Date: Mon, 23 Nov 2026 07:03:49 +0000
Message-ID: <BY5PR11MB397674E55184C5C97C5EB9C7A5452@BY5PR11MB3976.namprd11.prod.outlook.com>
References: <cd12af33-ed01-4eca-88e3-703b59c05453@intel.com>
 <20260917150247.2562991-1-runyu.xiao@seu.edu.cn>
In-Reply-To: <20260917150247.2562991-1-runyu.xiao@seu.edu.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR11MB3976:EE_|DS0PR11MB7213:EE_
x-ms-office365-filtering-correlation-id: a85fddf4-1477-4eb9-61fd-08df492fed23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|23010399003|38070700021|10067099003|11063799006|4143699003|56012099006|5023799004|261021123027099003|261009223027099003|261102123227099003|261021121427099003|261026140227099003|261022075727099003|261022105027099003|261028144727099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info: r2QVV/En8Uc88kAudeFyqtjMpzl+4AA1Yq5v+Gfy5y+wDQsKWcTnU+EG3KZ0L7zUTazW9NqLYUGW26hWqOM+c0S3ESRpoc0wJpg1e5bwsFFqVsIzGaKg+e013PAfCotTkJ/hs2loNVLUhgyEbm4SY663juWZyE3qr015zZ+6GktmNRXtp8L2FITIHcUdiTpH28oB/acKkktJ2JF2rKR7xUUQsQ+kVlPzPaCPol0cH0hC+tPEDJctpWrQoQB9CA+sCGCi86zAD+cSdiII+GFAX5RglLCLTy0uBZBLhGPz+TKaHn+nAY+OU7h/KkHtNtWh4HZK8aR0zYL9ZykAmcyUQDIjcKB1HnWmC/1gtlsv18HTnMNTHkfcaB8fQNnLZco4NxNPUpl4S7YleAJD1jcQJheV9Stn5N3eZQHyjJPFMBxv8to/bmn2f7mCslpZKkVyu/cKEgCsFwK+f/hNqZHuqATRAS/87T1CCtc2vks75s5rShsz1+i468Op8vOHfk/3zSrE7+Doj2Uxws7pdqgUKjmvOBy/PZqVlTF0gTxhMjS8lkUtgrgdsj3TehjuGRRBV0XgrV8BqhuzcS/8pJWhE0XRxBoeu/9R4r2qCPMCrUGpybISAQKy/vl3UCooqAqkHAV6L8lA/lsYSHSSgNPMDxBepsyOgJUdXnA6GcQCsYI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB3976.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(38070700021)(10067099003)(11063799006)(4143699003)(56012099006)(5023799004)(261021123027099003)(261009223027099003)(261102123227099003)(261021121427099003)(261026140227099003)(261022075727099003)(261022105027099003)(261028144727099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rw2S14hXRsqml49cRPPN2JhS66bdAxAcUxZ4lCogzmZx5QAqWKXnIRm9x/Tq?=
 =?us-ascii?Q?q88+sja9dWgLw9rq6yQhTVpcHvePkymbUWBFePb8GdsR+hPHukaGkeUckPt8?=
 =?us-ascii?Q?0frTka8IO4uqrohJvu094YK8ok6ewv217ouqZcOBIt83gBXLNOd4VZd4TYWF?=
 =?us-ascii?Q?uHYJWOisrxncm4wT7n9gY+jG0RaCwDKaTIRlpbyQwqbAjmP62TRDcSrtbLl8?=
 =?us-ascii?Q?OfW/Uowrtw0LsVc/ybLxGk9C9Fh6bXtXqpAokUUMU1vKMQRyQR+fDJYT5UXd?=
 =?us-ascii?Q?23lGx9gaSBaAwvjHPGbdKFtbSyZ3RmPaXHIAFrB4KA0ZmbiGDDx+477V3WW+?=
 =?us-ascii?Q?5++4SZfTD9dEd+C5muPMkHVHsOXWtxOa+nI2kJC3nqrs6Mj7ZdxIDbBbJ62/?=
 =?us-ascii?Q?UMhQwvQx6xITiuEyMbZZ+tpGCysbNQWq65TOjH4OQVIVsQQ6wWksa0AxlfoT?=
 =?us-ascii?Q?khzYkFmv9JnVoypPybIWJhrB0GPPARFfccLCn3+QiGgi1Dcp3pA3iabNnwHf?=
 =?us-ascii?Q?k/kh6Y4IITskdTEwwT4/nu1MaSrs7arUR4pJxyqyANcsN//OV2+z1VswQ3rA?=
 =?us-ascii?Q?iCUAwpWIxxQQzJSN1Gg17abi6mVkcK48UlKcz0XzNnoQDDfKtoyxHBNJUE9T?=
 =?us-ascii?Q?Ra5+YNvzuY0Bb8FW95m6DBRW/4EuTSjCqcS6EDr0ukZ1o2pDCuH7qScYjJ0T?=
 =?us-ascii?Q?b/PCR3pTIegz6dEjUOrJzGPUYSVdMgX1dzvYY5olkNhlYtYX6wSSRV6WiyxV?=
 =?us-ascii?Q?B2gR2IlgdKinAqAftPDzTEw1g/nl1sUNsw/lgKxrr10Xy6JPV4/HgR/pQXDe?=
 =?us-ascii?Q?ElETB9Xus6X+5RdPS0i/+Y0WbZFe/RdhA2sSHcZhMZFSqIkklGG4Msw6jtpE?=
 =?us-ascii?Q?9kcxPKQ64gweL9UvZcolwt5cwHY81LE25sYe9VAs10vC2T3ZRLIbat5uAeNN?=
 =?us-ascii?Q?dzi6fSf6zel4Bkd+bweasomZUfWs+Y+W3LZQDL3igU4VNWjAMyLUPIcLAYLZ?=
 =?us-ascii?Q?wRlOAch76soVoK+4g9Gzn6RZwRuRndI8ids++niD2P+kJj3OpAQQmxuk8kTX?=
 =?us-ascii?Q?Z0VX/MOqN5gukphJIVT3+OS5CvQxZAZvYlMF3ytNHKPUNE6hJX0wMdx8FOOm?=
 =?us-ascii?Q?FTeEX1vWT2FOLDOMwUDf3/yB8Q8a2TnX3D32t3+oeQ/sLqoY2a/F2oHGx3tD?=
 =?us-ascii?Q?gL0Z4JWu2808s0yKLwQ1xftw/dAht6wsuyzrckTKcSYCAAjHvFtzWOYj0gbP?=
 =?us-ascii?Q?62NS1M6BaUXTYXIns5g+s6rCX7NYWitYeCF7eBsuPvUUvz7k5mscrSYRXTWj?=
 =?us-ascii?Q?ATx5U+pA2xCkFNsz8g9/bAyp4VGognfFNprpbEUb7SmASfHSBzfSYfHuvGlN?=
 =?us-ascii?Q?qiDAf13XlsTYtUZaCryTY3pn5XixKp15WXV6d/tO/UqBuohYngpmnB+EmPNV?=
 =?us-ascii?Q?avIvr0TTwnQy2XLeVdfH1sESgz4LhuGY8jKtx660j0WP4Xb66VLLODydf+C5?=
 =?us-ascii?Q?JmQtAijqZC04RrIpYgI5Fa5GMb0/JPDFxaFP97j88Di3CMu+dAQNmEg2gXMf?=
 =?us-ascii?Q?b1fSKkZGff3/FEKZ69K0WxjLAKO/FGs9aKbiHghK+Nfrfe6Z3r5e8CaGoYMK?=
 =?us-ascii?Q?445Sp4zx8rIsopUq3pKkHanFYn3tVUo33FmYNFbo1eXhIz90BQN3bSXlqajg?=
 =?us-ascii?Q?AHKIiMc1PDkxoqPrwHOeytEbM0cCxxrQurrPzZSsWHbC1V9l87EQ2Q8Ci9ex?=
 =?us-ascii?Q?jFOERB0nGw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: GSw+qvbb1Dr9PLMOlKuBubxn7tM1KIsl38GEjXwPjPx2zPwrhWJhKjbwqcSuCspa63XfDNLXLCPfFo6JJejbF4ZOkO8vTfyybkx9VyT836FcHe2+9oP2Za6z9JTK8c1mC1tLBjrvrdmRhmAyhGXfkGi/MtV7i5LzYrDnULGY2W3TxXTrbKHb7OwOk2qynp15Vu3s0TOohcdLLz8wc3Bb4nokxUVEx2/9ko8sVBul73BE8DbYJfzTm+8O5qs/o2coyXvbGT9EaKBfd5CycV5veQXNHR0YVKUILFhxf1f9qpMi9tkkbvPUo9tqhfLP7pjy3VLJylMoB384Wt8nk1NJYw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB3976.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a85fddf4-1477-4eb9-61fd-08df492fed23
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 07:03:50.0407 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7NHKEQgrWOs2k+yycMWIGuCuDCdpMjMaQyZeUnjZBQp2yFVWvG+pf4IHuFedfPNNoquvkYmA3Rp8W9GYsF/HQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7213
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
> From: Runyu Xiao <runyu.xiao@seu.edu.cn>=20
> Sent: 17 September 2026 20:33
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
> Cc: alessio.bogani@elettra.eu; Kitszel, Przemyslaw <przemyslaw.kitszel@in=
tel.com>; andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com; =
kuba@kernel.org; pabeni@redhat.com; richardcochran@gmail.com; horms@kernel.=
org; intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-kernel=
@vger.kernel.org; stable@vger.kernel.org; runyu.xiao@seu.edu.cn; jianhao.xu=
@seu.edu.cn
> Subject: [PATCH net v2] igb: initialize PTP state before registering PHC
>
> igb_ptp_init() currently initializes the PTP lock, work items, timestamp =
configuration, and timecounter after ptp_clock_register().
> The PHC is published by that call, so PTP callbacks and timestamp interru=
pts can run before those objects are ready.
>
> Initialize the complete PTP state before registering the PHC. Skip the se=
tup when CONFIG_PTP_1588_CLOCK is disabled, since the PTP registration help=
er is then a no-op. If PHC registration fails, cancel the work items queued=
 by igb_ptp_reset() or a timestamp interrupt before returning.
>
> Fixes: b888c510f7b3 ("igb: Avoid starting unnecessary workqueues")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/netdev/20260830154912.2712900-1-runyu.xiao@=
seu.edu.cn/
> Assisted-by: LLM
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
>
> ---
> v2:
> - Restore all PTP state initialization before PHC registration.
> - Skip PTP setup when CONFIG_PTP_1588_CLOCK is disabled.
> - Cancel both PTP work items when PHC registration fails.
> ---
> drivers/net/ethernet/intel/igb/igb_ptp.c | 31 +++++++++++++++---------
> 1 file changed, 19 insertions(+), 12 deletions(-)

Tested-by: Singh, Ayush1X < ayush1x.singh@intel.com > (A Contingent worker =
at Intel)
