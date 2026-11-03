Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C39606A31B
	for <intel-wired-lan@archiver.kernel.org>; Tue,  3 Nov 2026 19:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=G2vDfHUq;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZUr1olF4
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4BA0E405F9;
	Tue,  3 Nov 2026 19:59:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BGw5yPY2xGNq; Tue,  3 Nov 2026 19:59:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 32F8140576
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793735975;
	b=d13gdyvorxIAL58KrvnePgphHt2beaSODR68vPkWdhiTHnniIKBNmc5YBTp3LpfjYqzY
	 JsB6ZEScNdiSoGCA8x58XpMnKw9WpjUFoACZb1L8Yq+7W8izdj4G7tOGOPaGyWhF+Y62h
	 yxeiDrWFiaToQBGUZPMseHdXy7XOmH76A8Wv9/KbgghDCovRpXCIMqj2S1j4qZby0WeqU
	 285w6d8fJraBlkOupiYXXD+Nj7IW0mESNu92AW2W3GpKnBpQTcwyrqnp4wlQsJCgnKOwZ
	 GT0fG1i4c12FKt7JUbAXGMRkwpt6rn4WobIn0lygmZ81yGo+kEemOqnDS7gMnXbGR3Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793735975;
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
	bh=srC0PgMeOCv+qSXfvcQjJtg8LsVIJB+PHJxtPzA2zms=;
	b=tTLy90wGuU8HyN5UwqStj0kh6Wj27HRTHenzXxOxCfFzTkMzpkXEeNeUu0EKN9eEdTA3
	 99UIVseE0rLwArQ3dO88VF+yYBAUC8V6eGXcDqb1x0qryXdLfD2UYIcbOeGXxYSig0o/a
	 +LtBoj7OPcfdqI4ZSSOI22t2uOhrt+kIeBTs5bKOLuqdL3WmVnz3I1J1WQmOW4XJj56KB
	 3/r3D7GrDrj0y8A27BXM4ALfnUBzkdkCow5Sh0Mu2g6ARVmsP7Id37NxRzQgqxoIyLYLU
	 H3qOc/8vaB6qwD48PSpAUQx0dyJ+fknL0SavPhBjSSjhXqk0MD/jrITbQpywY/yMUBA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793735975;
	bh=srC0PgMeOCv+qSXfvcQjJtg8LsVIJB+PHJxtPzA2zms=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G2vDfHUqokyK17JNfcTXmyXS6T2CFMdY6FLw/ZJc359hewDtd2SMEJiKa27Pii1NZ
	 vlCP9y530+GMQEdoI/1FtEbsxq9SCtnMIJVMBPGBeT47ZDwysPzv/8dX5ZQBxmHWTF
	 u6ZQqc5CZ9BGojYVymSUsN8gWxZE8fkhV6S4TmIyG1SeJ3U2w8MsM1EqSR3tBuKbwL
	 FUVMx3K+kPDFxM7dzP526NKGvyuXzSePPrq5GA4RjdTS7YF90n2wAAftzK1llb2BQ4
	 9Innvmr7ENoBHGzY1YD8+GALPj3RF2pBUCEBsXu3p4G6KZ6F3Iwa++hMIA9JRBl4Jx
	 h+Pr2PZToBkUg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 32F8140576;
	Tue,  3 Nov 2026 19:59:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id F39E437B
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 19:59:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E4E8E809C4
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 19:59:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rTo3-CQfw8vt for <intel-wired-lan@lists.osuosl.org>;
 Tue,  3 Nov 2026 19:59:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1E061808C7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.18
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793735972;
 b=Zc6lX8iw7i0dcQO6N1wvKUFhO4I6RqvDPve/Injkpg/evABzdpCub7lq76YygLgOtUyR
 WinyQmrIosEnItfTj91E3a932a9XrSrrl6gvbjebJGK0YvgTKm1U11hdwIYAEbZ91s9nt
 qzI4AOTHa+lwaHfffSvgOttL8F4LC3wE5/Cdf12NcBh/FzTuFaBWgvu9fqCniNjnYGlV9
 1ruR+LL++tllzW6Uz/KIYihXzunSa0n5gKJJ0rmRz5q+/YsXmiprxy+r+wDcId/8cPOxn
 QCbiwa5S5ZOtFH3843WWj6rXVaKxaORLeNqjDQOxG6KUFbyoei8wt2Yjh++lZAMvUcg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793735972;
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
 bh=srC0PgMeOCv+qSXfvcQjJtg8LsVIJB+PHJxtPzA2zms=;
 b=QM/x8sJKtMCsoJbabBGXcIAdi97AcWWQd7kNL3UGqJ0vyXt4gAxdVcl879i74d6laZDT
 QgtS9UGKaenn8b/br+G0B+PASpupE/yiaIm7XFFlk6synyNxpeap5mpXa9rCpDiMZKzmQ
 04F9tK4eyQ/hCzD2Af7C5sM7sXXUmNa4Cdr/ojxwOZLK27DEgzsdqCmU6WyQKlENDJPkk
 F4GFIT1XFq/OO4nzj2hNUlnZc1IngVnfqagPtgUyGD6bJcdW3+J8plocMEO0dkP7WmTE+
 2Bf3Z8uZZsKxvLVdhA5RaIXB+nFAZdaGKGUuRIsrwuJzr9CbU81EnArWH1CLUJyWqKw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ZUr1olF4; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.18
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.18;
 helo=mgamail.intel.com; envelope-from=alexander.nowlin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ZUr1olF4
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1E061808C7
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 19:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793735972; x=1825271972;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ryuHyCxV5vGbFuZNI3a8E7dvb6F7sL4cN2ScFRvl0bc=;
 b=ZUr1olF43ojy8XWw6FpeUAbzmazshm4e30P4m7u74qNrX5YFsI+OZZwv
 A5dRtOF0Dgti8hwH2H1nW2vtXHC98TDpevhMP1qECu2/1M7M/YyrKMgrM
 sA/inXC2az3tpQKhl5rvFU9/A/xM0b2+Xf8sYuOetqQHQRW9I7k42DBGL
 TQFMu5NrpdFkiaBStJ2HORMdFRASOGJpX3uvCY535TC5sVAbK8AQb0xqF
 FOsFEP1ym4iRLFWSA5FEi8LpcbZjtNmhG9Ht5NH+kFJfjw+839TFO2eeU
 AiaiJX3NSz9mq/jBP6A0gFhzZb0uBnUJqUMhxNwmnUHW6DlKZ8eMH+mUC A==;
X-CSE-ConnectionGUID: IHL6zW37TgK8GvJiFL01JA==
X-CSE-MsgGUID: LfQIVBQwSl+AHuHzGdhEQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2487864"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2487864"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 11:59:29 -0800
X-CSE-ConnectionGUID: QR8HggSkSduTkx2DDIPwMA==
X-CSE-MsgGUID: S3tHruijTNqNLm6I0A7ZUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="8294771"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 11:59:29 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 11:59:28 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 3 Nov 2026 11:59:28 -0800
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.26) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 11:59:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lLBtcxDTY7NEjHnFjPmQzOOf9S5ksHrCSvvHWCDRefzha3bYuLyiUmEefvj1D+mmUfPs5woCy+sAWABVN43YyAWdJp8vLYNG1EfLScYttclx74ugCcsziCa9sZP4lB7opk1ASfQ+mA/svM21+REG/iRVIgpaLurKCns3xRP28hcSGN+RFwEL21sauo+m80XBqYuUMm+W2yrrLeD1+oDhdFGDAM1NXzmCoO488c2Lu2TenGH+UbufYoYdg53qRYgSqpUFQ9B0H5nlewsJOxV9N2DTYUP9+iFWscu70rkE3M5P3eAXBHs4vezT8g7X1Rc6Uelxazwm7mi1hI5U7Gkr0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=srC0PgMeOCv+qSXfvcQjJtg8LsVIJB+PHJxtPzA2zms=;
 b=yD/sTxxKkDi0dhbIJx38tv4T7ah+Yf/h34YJgMTv1kMO5GqhqHpbyQv00gxAeMkp5Hk1WYGuqLkunkpKLCMyYO4s9w3n9Df6XXBwPLDSlzY9DOo7ZHEI9ydMTzn9BNuFPy6mMHicYtrIjlmXebSYil/Pmn1Txe6fkqreQchaqCluq8ZaE+9YghddM415ayDzNVhzW2Hfabi5M0eXfgfk8at8sktR/ZcaMdnRNH4DTfng4HPwrvpB7dnJr8sQv6dcOkySo3ZPktVw8Wp8aR56eEAZkgM3yYRk/H8NQL9TDamRB3xuc0au/sYVHeGhYJpPtSReLpisQL/FcMbtPuigKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by DS0PR11MB7629.namprd11.prod.outlook.com (2603:10b6:8:146::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 19:59:22 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 19:59:22 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Greenwalt, Paul" <paul.greenwalt@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Greenwalt, Paul" <paul.greenwalt@intel.com>
Subject: RE: [PATCH iwl-next v3 3/3] selftests: net: hw: add devlink info test
Thread-Topic: [PATCH iwl-next v3 3/3] selftests: net: hw: add devlink info test
Thread-Index: AQHdPJkQCFo2Fn1mHEys5JHJBZyasrcdIfhA
Date: Tue, 3 Nov 2026 19:59:22 +0000
Message-ID: <LV1PR11MB87901D66E219675E7CE4F3F590692@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260904103714.978256-1-paul.greenwalt@intel.com>
 <20260904103714.978256-4-paul.greenwalt@intel.com>
In-Reply-To: <20260904103714.978256-4-paul.greenwalt@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|DS0PR11MB7629:EE_
x-ms-office365-filtering-correlation-id: 69e172fa-1aff-41c6-a10b-08df39e4f479
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|38070700021|261009223027099003|261022105027099003|4143699003|11063799006|56012099006|261102123227099003|261021121427099003|261026121527099003|261026140227099003|261028144727099003|10067099003|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info: xoRxNJxKbxaf4xkqfAAh5sClT5To8wkbphh4qnULJuXLVrkO2QiNFjOb2jlBJzCUsS59lSv9Toci8WoerUj6RQF/xjvw5E6SARIlQ8RaR6C4PwvVFQbStfWhPWTcMBWiHkbltWDwiFcwu2PRgm1MU+SrByWBOBTi9D4i+MYZGXZak2KdaqA1zl5h/ohJ45MGbXQEE/7F8r3Qr8ZVWCBzWNGI2O3i60baYB9hsjU1tDrkNQtAio6kEVEy9yHK+fHC7FCSlc7dpusHkEH7voq7Kp1/HIU5/z/ZWJKQziF47ZzzmWCD5xOg02s6uqbDWuI2Ag0R9UYGWKuuEPajiUcP+x3nW/ZdueqKHCKhE2KDjO1XqbYbI3CR43h+hEsUI8AcT7Q0UwPDv0PCBHGPtVJP2YmumeXwWj6Ie1QESyuqFx/EqBUcqwNKY+fn/FiSVo6NOo8i0D9MQt/QE8ZdNBHVdxlIzG2NbwYYrHfAfu05oqw3LFxvwPgN8XwdquqXaRe8Aq98PWXVagjFvP2OoLtkzS3KxnfaJdeTkhdMSFIPedFgh0UDMUDqv/j9fMxIIccT8T8fJj5tLNZiEX9+AMQNpK1UaHxlefyXG3vqpZUYkIm9dWO1oScHJjwKpyMM1D+bvscjrJ+yVwWA8s6ZYAgv60EX+3QFqTAfMhAJmmZkVgPUkvOjmdN1hF8SeItt2/pJwQKTk6SAJj+4FMmjPwPhvqLnJyLbxgNzkjze6wqmlBA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV1PR11MB8790.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(261009223027099003)(261022105027099003)(4143699003)(11063799006)(56012099006)(261102123227099003)(261021121427099003)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Tkod9OKipgHWeVQJoIiWjsLAgAy+yQ7VYKZCVcppdQuGWDBHVGreD46dKZ2z?=
 =?us-ascii?Q?8fFVMcPkJ5CzTOrNaFqIXsf+9gt/uAtQnlDrz6O13B7RVBvNha2STLKsrOQQ?=
 =?us-ascii?Q?FGFRFh+o2OgdKKXmN33gs7BDLLdfNrpyN4NQj3zRzqiLjru5Gan3HTRNe8Wv?=
 =?us-ascii?Q?CtZdlMq0Mr476omwRPU7T9SI0q+FlXdQk4/7CaroO1XOopZtTx/9xIql8TGh?=
 =?us-ascii?Q?5cg7PaDOhI2sn5iqEw1+TIDNZjDPi+JqochgZAuew2wUbnE/0kFCYBzIgj39?=
 =?us-ascii?Q?Oerqsn58+hF8apyuVs7Cwe6B/N/6LeZPlPXxhOvZHvzbqwVAcKJrwfF0hJ/m?=
 =?us-ascii?Q?nnCZQNAuqd5+AMbrJU9EtG5VtjGGDdWeAlbbE0NJBoq1t70xX3Jpijn0izU/?=
 =?us-ascii?Q?EenjUyYLVgr131XEh8WgoW3rQpD430JGKvONngF5MVBGr9EOWVmTlqZFRj7X?=
 =?us-ascii?Q?OyNNbDBxVITGTYVDcs+Swi1slAcQyJWKu69RWCHc2SVdnecNlz3g89cjTEhr?=
 =?us-ascii?Q?iRDASApt99kHj7raVyn61wKbOHIsSN65n0iDdflEbKlkl7gdTR/E0m69QlVV?=
 =?us-ascii?Q?JnSCOWCivrAqXD6OK5imZOox7PS8LBzLQ7e9MuxyOS8SFD/mLvk4MtSRwGs+?=
 =?us-ascii?Q?rPWQ9MJAqSilwwh5ZEDwkUx7viIjEil4kSE7toi/aRqxrO2Q/PVY0asV9suB?=
 =?us-ascii?Q?TxKCwdMwdOmKoKSBaPsPw6IJPaymM8NFuDC+/wNVICTShuK/N5HZl4dGCcCf?=
 =?us-ascii?Q?9j122c/uf/Ky87MWSqyvIlqn276RNstFsQToM8SmaZk4K9TjaZ1Qdek1DjNC?=
 =?us-ascii?Q?8rNhjgsR5sOt9v0ZAtfjQspMgg1Wpn09w635MgH9n7sePuEXc0dARiaKbCyl?=
 =?us-ascii?Q?NYp7rsbeYOeQw1W2DbbU+eMgOYdsjnkwsOG3OuTLSJgLajaYuy5z9nXNEMdh?=
 =?us-ascii?Q?c/T58Rvoq786Pqu1DmptMPfBvMSQro1I0BG0NksV2ApdFZiKmxTvvUocmXPL?=
 =?us-ascii?Q?6H9RCCWpwRRijRmARuODfEBpSKOPXK6CdzXOniFY9RNvlVPspeDFnNi7Qv6m?=
 =?us-ascii?Q?LEn8I/HH3ttAjUkNfj7VhxMT9+ibUQBJz5O/Xe3RcHfcGwZk+UZ6TsDIZnWl?=
 =?us-ascii?Q?fDa5Ntw1U3Z8Kp2QAbM0kbMuQeO+GuJrbU1IrEHRVWZ5ZK7f2RZRFjZtJBbF?=
 =?us-ascii?Q?iT5JhEGp3Jn7pViqwzSfNPayA5O93paoEsSAg5JL2GMDGTH2+fT4no9o6oA+?=
 =?us-ascii?Q?MndB4mPkBJFYeXAfz90kR4JoCr9ZaGbIg0H9ngApWMFdG6zYinerwh1unUXg?=
 =?us-ascii?Q?KDGioQWGq1kSnddnuv0yO2k8foOQmh5HkNE4lLnCD53nuC7iu7NJ5PiPsJrQ?=
 =?us-ascii?Q?EFkntTGqWV58RH/1wL9P65xg5klrHDFaNf7tnKpIuUa03dLTMYcp5ttaFWK3?=
 =?us-ascii?Q?pVd/ntfndmLn4mvk1VeLGNTN5Jwyx4HyTWATbMHuWA3PBXi5FgSLtVzRTHaY?=
 =?us-ascii?Q?j1VlYz9N0FO0OFWJI6AZ15T8V8T85eeWWj4b1xtxpnBQRFjhE6x2+XMClAbW?=
 =?us-ascii?Q?FCfhPuZhd7roK5rPzsBRfYO3nGuI3VbvKzn+nhYIfr6wlhI23t9sCz18xQ8+?=
 =?us-ascii?Q?dIPi86K3cjZm/hy6RnFywyJenLaoTmPPVTKdW8sLJuaSYRtvlp0K/RWjFMev?=
 =?us-ascii?Q?JQRo6FNP1cOKMm194Q635YkyJnU1RBu9qexdXZf2Q+TIKKHP2QCGYYJvzuPb?=
 =?us-ascii?Q?nxUauclumw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: QlL5czmg329PZLmnhgYtj0/1IQlGlK9AnHGS1nrc6RjoKmjO8OGkFwT2YcaGH1cUg/1y661ylxF/9022uVSv7Jovk3wv0308vlKTA98njjSq4CbC6gIvDuF4OkIGr2C9d6Hp8NBoTVUdezA0aOnL+njpm/F1BNTWqGJV9gr1eRrRTJRq7EIaL9PpJBGaaV/9XFFEsfMNog7/FbMsU7m8+ouA8JNEX8ViXZ0YuVmlBbkZH4Ryc6jEQuJzPo6yHNxM7GYlBdNNaRD4THtPmSn9fiT8WYoPCL1ZpVpjNHKubIvcGdo1xOd1LBn1ptWzLS5Sa5JXuA6ONmI0FnsgMeHVvA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69e172fa-1aff-41c6-a10b-08df39e4f479
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2026 19:59:22.6648 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hzwliQMM2fx7Rd7aJGg9WmtM9FGCIAWeR+GGfpA1GIZnymtz7LW6nI0A7VGT4winXe+ucT/UFn5Xn4GWPj885opyUK/l/PfhJ8TQ28CVCkc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7629
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
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> -----Original Message-----
> From: Paul Greenwalt <paul.greenwalt@intel.com>=20
> Sent: Friday, September 4, 2026 3:37 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Greenwalt, Paul <paul.greenwalt@intel.com>
> Subject: [PATCH iwl-next v3 3/3] selftests: net: hw: add devlink info tes=
t
>=20
> Add a selftest that logs the device information a driver reports through =
the devlink info interface: the driver name, serial numbers and every repor=
ted version, in the format NIPA CI consumes for device regression tracking.=
 This helps maintainers identify pass/fail status changes caused by FW upda=
tes.
>=20
> Every devlink info field is optional, so the test reports what a device p=
rovides rather than requiring any particular field. devlink reports the dri=
ver name for every registered instance, even when the driver does not imple=
ment info_get, so a device that reports no versions and no serial number is=
 skipped, as are devices with no devlink instance. Whether the driver name =
itself appears in the JSON depends on the installed iproute2, so it is logg=
ed when present but not required.
>=20
> The devlink 'driver' attribute names the driver bound to the parent devic=
e, which may legitimately differ from the netdev's ethtool driver -
> mlx4 reports mlx4_core and mlx4_en, and DSA user ports report dsa - so a =
difference is logged rather than failed. ethtool is only used for an option=
al fallback handle lookup and that comparison, so it is not required to run=
 the test.
>=20
> NETIF is read from the environment or from drivers/net/net.config as desc=
ribed in drivers/net/README.rst. net.config is sourced before net/lib.sh so=
 that it cannot clobber the framework's globals. The test needs only a sing=
le local interface, so it sources net/lib.sh rather than the forwarding lib=
rary, which requires NUM_NETIFS and a configured remote host.
>=20
> Example usage:
>=20
>   NETIF=3Deth0 ./tools/testing/selftests/drivers/net/hw/devlink_info.sh
>=20
>   INFO: driver: idpf
>   INFO: serial_number: 00-a0-c9-ff-ff-23-45-67
>   INFO: fw.mgmt.api (running): 2.0
>   TEST: devlink info                                                  [ O=
K ]
>=20
> Link: https://github.com/linux-netdev/nipa/wiki/Netdev-CI-system#device-i=
nformation
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> Assisted-by: Claude:claude-opus-5
> ---
>  .../testing/selftests/drivers/net/hw/Makefile |   1 +
>  .../selftests/drivers/net/hw/devlink_info.sh  | 158 ++++++++++++++++++
>  2 files changed, 159 insertions(+)
>  create mode 100755 tools/testing/selftests/drivers/net/hw/devlink_info.s=
h

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
