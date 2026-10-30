Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09830606A31D
	for <intel-wired-lan@archiver.kernel.org>; Fri, 30 Oct 2026 09:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=SpKZfcbG;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=e6wCkStF
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DBFEA810C5;
	Fri, 30 Oct 2026 09:00:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nG4uxoetcUMm; Fri, 30 Oct 2026 09:00:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3CB2F810D7
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793350825;
	b=TZlV7e+xCJUpeqMcUZp3mo99fO+OffsYtQRNICTmUxn3xiEJd0VjxAPzkzeJW/wkno/d
	 Gyfl8L8ElKVHPMIFs4t0d1MrC0v0J5Adw9JmMnH9TufnYJfkEIKpU1VlRhNhLZ8J0rEO2
	 wqy2AZxoDNXLvcL4cJQMhhY1rNgNrcc/lzDzEhPVbZL/Lrdd57NJYPTRCddTyO16PrG9s
	 P/v6jrTHqg987gQmEWFtbUrVbf6WRrgeo3Vw/2oGQxJ/zcpawNt2V9js4L1j7K3AqMCqZ
	 uFjutdeNJszKCq5/m6wnQguDw9hGnrvxFaiSbXkL7N9umufc8iKNKhfVSVUR4MVnO9Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793350825;
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
	bh=glZcQYSRVJkOnTkHRIu/qHfcx9HhryvidNSBZ7ph8Kg=;
	b=pZ83cETy8jRsN2aqF94ZEWLQ2DJay6VJFO21vB5nO7O9G3hqegnzeijuN5xujHkEIuSz
	 ag+O4zoKd4gA4SKZrL1WIef5ofij2PvG1hUSi5ReLsgFTwpfQVPTD8NIY3tShIH/QXpfk
	 2R/0SlK5nz0binva34cUHHGdUrqxbO0VJk4UL+yNqcsCSCX6QktwRAX0MRQS/kYgLLezN
	 +FnPgs9nQJ5hM0xs6nfo9i1yOhdBAEJiyscKAlSlbbV0y5zmO+/yPRT0HP3OX66fdvzot
	 YwRxgFRt2lwc1f9JDfz0qoWXT/UHTgi0a/3fmZKLTd4WQJ6evGJgieuJP9WO4brgzMA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793350825;
	bh=glZcQYSRVJkOnTkHRIu/qHfcx9HhryvidNSBZ7ph8Kg=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SpKZfcbGqTrd/ZREON9eKkp8vL6Rc/m4atrLep0BoXpO17YKXOhxspCcamRjfQd5s
	 qUvENV7bR7AKG5U0ALyzJM01wwIwBxmtXh18yyTrXaCFrvHAiLNOIbD7AEJB3s80Jf
	 wx5PmzcAjl3HRg59P9Hdc4gA16x2v3jCJ3dMqFOKJUkkWQbIv/crAE93HQWQ6rHXAC
	 k7Hcojo5Qnca89R84OXeIomo2rt5hmP+rh4BR6+9i0/T15Q1UubY5XCXGEh9hv9sVP
	 tCSJVqABKdrTMLuszLD1TEtu+mXSOvi40/DDwjhBsO4XfczpfQ05T6pZsmlw/NPDjh
	 IcBFSh1EYEawg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3CB2F810D7;
	Fri, 30 Oct 2026 09:00:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6B124529
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 09:00:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5CA084051E
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 09:00:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RazrTKw1SGTF for <intel-wired-lan@lists.osuosl.org>;
 Fri, 30 Oct 2026 09:00:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 865594051A
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.12
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793350823;
 b=bEc3oKseBkC7JGvHveuep594W6pKRaET4FbIkSukbFDyK3BdUk+dwnbeMBEjpUv0PLD6
 RvPq+CvuKyAQ+bmgRKbAA8mkq2Rfk0SlEK3ruMzeltoc7j1/QGdZUhjrMi33pX7tbX0dI
 wTlIC9lm4qUabg+u0vcS7RtOZkyfkHT6cN09bjlkOG4g0QQS0LWD1nHUMgYO0Xy15BHeb
 ut1MLolpNpFIMPta24geRq2O1qf4lBHsmsYiOLiCUiqQHtS6X5UkOKFTFfTJP52h68yHR
 xfoMWzP0h6ksJjCPP76COFwdg9Hjt1pT0EOKbJmfXJ9jNUjijhrbiT+jAFnWE+mfnEw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793350823;
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
 bh=glZcQYSRVJkOnTkHRIu/qHfcx9HhryvidNSBZ7ph8Kg=;
 b=LhYWSwMWS5bSFDGrnH9BylKmyw6GgrqmSEb59QCzwfZF4+ejM/qadxA00HHhwGAR5bXw
 hd6RQn+yOBaaEzA1jXAkzXXF8lxhpy2Rx5266TOWlOfds1QF0EdthLl4jZXnf4ZSXY5eL
 32z+HBuIxerXBpz5LPH6lgnujGvgHmi8lEzptma57vsjortQnFFX/7RE7a07tkLS/Jlaa
 u0F6w0H6wJoGAOyLm5wUzcAhoPBAmrNvh4X1HaqlU/2ssjUgx3Y5g0bhQerOeCN2XV14l
 RJgnj419A4oI4RdYTLoCFI3/5Q0I7Fc9ZxKLrPvPEdnzh6BsWIXkvUFzjMaf14aRZXw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=e6wCkStF; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.12
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.12;
 helo=mgamail.intel.com; envelope-from=rafal.romanowski@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=e6wCkStF
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 865594051A
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 09:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793350824; x=1824886824;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=glZcQYSRVJkOnTkHRIu/qHfcx9HhryvidNSBZ7ph8Kg=;
 b=e6wCkStF8JSyfkJdaUcdDCDsxtLRSd4Di+u4R6phOGoYeXoAWKxKa1Jo
 s3yozP/ep1FbmKt/eN6uLZ4zF655ufwAmH02BC8141+J6eq/NyWI9cin4
 QbNsZwgzM+yFsjWoMVWReYmHNhsYJnDCcGo7ZP4CN7weRp95sPOfm9Gk+
 d/WHzDHue1fUChLNU7NKKxw4TgQt3JTAJu90vxrcNPnP07qxgP35apCxi
 W8N9Zx5zdVBcDPPEEcAbZSra/uhqwH3QjD4ufRow71p03FdmAC7z0nF6m
 DyE0KjnO6RUF/KT1heEg/zcyTcJUMBHWt96x1+zrZYPom861ha+O6ybH0 A==;
X-CSE-ConnectionGUID: O0v6nk78RUO13JMv1xqLHg==
X-CSE-MsgGUID: 990fDrSCTayB7y8MmsRgyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="1989858"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="1989858"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 02:00:22 -0700
X-CSE-ConnectionGUID: pwgekfbSQvSYIeGqZQpeWw==
X-CSE-MsgGUID: qUHGtdg8TZS9jFeOtY7djQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5405938"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 02:00:22 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 02:00:21 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 30 Oct 2026 02:00:21 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.13) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 02:00:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CaGKHrCZjyxDigf0vuJ6b9VHZWnrjpNGIoEnJOhsg/a9Yxc5PbyxzLBzntsYfMBWqRUXyVTMDqo0t0/8gI3Saje126nO9fYVWn7bxeeZ1Hg84da3tC6nof5iAn7v1Ungr7bADPziAP+neKwbsO9VkSLmI91wmkUoGl4G+mFQeKP+/KeIHkMas/LQ06dH/PiZXBHMP6KYanMkU88hU7EHQqhIM3fnj8/6JLaplTqyw1atmCg92NTCKkCtps2g0H5e0Id2dwARnv8Zhn7YLgmp+6euVzBMxUF3u4QfchZvZB+LF5ShBajhS/bsl5cEdf1BPy1v1LYcicm7pfwOp6EooA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=glZcQYSRVJkOnTkHRIu/qHfcx9HhryvidNSBZ7ph8Kg=;
 b=tFrCsVsPp8+u255BjkT5L+gzNaMRLVr5D42IVEqaFLkSGu20ok88/EFMkNc+HLq2aTEBYN4VF3KIsofzTKCGHZGbIVuiu+NHoM16WOx4sdLEBmpbtaQJ7dx1L1FgUeGqZM2DqdbVMCWmKtwoCCTV4xGMpVJ9WGiip7T+WhkQJcjI0dbyyX6dBnTWa6JhnUzw8fvpnsprL34/ajzsPZNmEu8uWdOyybKC0poWEJk8KoO/dYAWEzd/U+2vUn/Nkd/qTi5N2C2rhAA7Ln7w0F3elv5MquKAn7tsA6Js7EFDbNsSOVECHQmLd5cqk4GgdoHg8B5sBmHDRX8j5pU4p3n8yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8985.namprd11.prod.outlook.com (2603:10b6:208:575::17)
 by SA0PR11MB4686.namprd11.prod.outlook.com (2603:10b6:806:97::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 09:00:19 +0000
Received: from IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d]) by IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d%3]) with mapi id 15.21.0546.021; Fri, 30 Oct 2026
 09:00:19 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: Simon Horman <horms@kernel.org>, Yuho Choi <oss.patchbox@gmail.com>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "Lobakin, Aleksander"
 <aleksander.lobakin@intel.com>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net v1] idpf: Fix vport IRQ name leak on request failure
Thread-Topic: [PATCH net v1] idpf: Fix vport IRQ name leak on request failure
Thread-Index: AQHdS7zLkcLSEXzP506sm8yCvqVRYbbjvG+AgAOXfACACV5ugIAlUEuw
Date: Fri, 30 Oct 2026 09:00:19 +0000
Message-ID: <IA3PR11MB898533A11C5F053CDAA3F38F8F6D2@IA3PR11MB8985.namprd11.prod.outlook.com>
References: <20260923234819.702327-1-oss.patchbox@gmail.com>
 <20260928091551.GK13925@horms.kernel.org>
 <CAGG=RgBNpQLy3s7Zqf1=TpN_grUOha8Cu_UVmjou=qPe0RBqiw@mail.gmail.com>
 <20261006151107.GJ83879@horms.kernel.org>
In-Reply-To: <20261006151107.GJ83879@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8985:EE_|SA0PR11MB4686:EE_
x-ms-office365-filtering-correlation-id: cf669535-c9a5-4b77-55d7-08df36643945
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|38070700021|11063799006|4143699003|56012099006|261028144727099003|261022105027099003|261026140227099003|261026121527099003|261022075727099003|10067099003|261021121427099003|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info: /UFVV5WVzFw15kAhNWZvzYt2WSG4lOFTroyVOFSZRFarctHmA6I8B+8wpd8xWc8QVWUhwNtyNsT4CYp/y+V3rF35+kLx1eN86j9XhZDLN4lCZcC5IgRnpE5hMlen3e9AGG3aQ5Jqjpdzwwtpe2zMPLP8NOjMtGk+GBN2m0zwDznB0mJOihIAY9PzWsvzJZcjZnDkmOxREDeJzel0NGRiMT29SU6VWhEUNyow31pPoLKim79nFQBAeLQ30svjuFEsmlnrZk4a/SSAZsdZGCGXHukibJ49yR/1SfGJ9vjJcJggVK6nmi4RYkeY6CH+NnlQAGJKlxaICjREgFxfoQMt0PlcFSNNIBgYZFlRypLrBrI2CErhog1fH+1piYMXGE9fK8qBwAG2Gzp5PITeLwPlV+Mhy3bxgmRN+XUI/4eUTCOpr1kEQ148qqLZnIHvh5aVoqHpHpAnkviLsZBBs00cJc8CAlWMnh8PDXaLp3QtE6CKxJd5RADULxR8YUuFmOfbr7mapTwmZyvUUX/PJuCbQtJME3QhCBNvkPEv23y4K1fck3Ayh5/Rv3HnDOfPJ9bsVelaR/Ib9gRtSYyC6YuCpJTYBFd1XqnhdDo8dvYctPxyRMBXnS2GdVStNqiEuo2wxHsXCdDh971usWBZRIGvKc4cER5/SQf5QX3Di0es8e8OHh/ajddZy8fI7vmkTRYnE0FdBIPv131qPjYbz21EskptX7yh8Evg8HdJ/yaY94o=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8985.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(38070700021)(11063799006)(4143699003)(56012099006)(261028144727099003)(261022105027099003)(261026140227099003)(261026121527099003)(261022075727099003)(10067099003)(261021121427099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rQUHbRlbbFbeWl459YmSFxoxAyx9/S5JS1IIn5W64rxlkb0BWi6JKv5b5kQE?=
 =?us-ascii?Q?BzPNQgCOSRMJO3o3IxMNB5Ls/zqsM64HOk1/UQ+nS2TKCI8WdPBCUg8NbGki?=
 =?us-ascii?Q?gve6f9MMEpYSRr41c4tqYIsIha9pgj8opdTYi5fz6kOo2rwqoiDm4KXt9WrP?=
 =?us-ascii?Q?A9DlEqbS9uKJKdWZvy70sqZegTCHftX5DXAbLBTb5PcLcOeJPm8TcTM1UWHp?=
 =?us-ascii?Q?kOVL3l1g2JDODLoWO0Whba7ZaYwy9S1nM2CdDh82KRo4Mo0ZwQtGqCP8KORV?=
 =?us-ascii?Q?1LklSLzl0YUmpEke+8emwnmytW6XZiofR8/2CazsSqpI3MCqUO7ze3XO22bT?=
 =?us-ascii?Q?W7PMypMmCXS5rjidGK0g9QsvYuVkrLidsavDLD2eQSNUqJC7CTwApBtrRar4?=
 =?us-ascii?Q?/zCJcWipKHiAu9DHxWHD3/vbY4bCViGemdWbeHLPQiyf9CT9rAE8G9uu4rKY?=
 =?us-ascii?Q?25rHGanhdB9zU/xQm3aKppNK6UW5GEay7dysV53G8QHwjR1yxm9ALyzX/Ccx?=
 =?us-ascii?Q?ukv2YSbJOcWmFcA+sDl+vw06lkaA0LlN3+bbRZGLSJgmtHmYCLD9LZe7/4NH?=
 =?us-ascii?Q?e+UYLx1lTGhiTpR46JOflLjTjT0bIs+/mIJHZJqCRTWH6cKVoCy3G6wwsHLS?=
 =?us-ascii?Q?iPAzS2CmAVuUCms1Z28b/GZh8mtbXG1W1ggw//Zipi3ZZRStqZ+/AefF1PH1?=
 =?us-ascii?Q?Ncmz+xE98jEGG4a4JwuUuW4ESmE+j2bCA6SXbCbEjBoBe4VvNXhFw15qEsu3?=
 =?us-ascii?Q?hhPm5RgyXGir5To+n1vRTnKAW/K1X6ynPBBez1H7juSw70xInyZv9aR1kE/B?=
 =?us-ascii?Q?BXBsL/DNiGWHwwaFXEJ5Mf155juq2rDhaNmJVNcHBIJAwJMiG7vDiChdzzJS?=
 =?us-ascii?Q?+xKHtPio8jfXoXw/wNm0VJJHiOA5Z6YbluRbjKB2rx9dUM0+aO3fdVBCtR5r?=
 =?us-ascii?Q?9GqpBDDRKfwltVA6vnwsZQXEyGwTOF/N2wttYWtWgJNpwzeNGLo0DxGixGyU?=
 =?us-ascii?Q?f5gyWAbq0zQwUTtk5PoVklFHdjTZkaxMb+1JmK/OJoEoN1/Djx4LTp+nBM3/?=
 =?us-ascii?Q?AqAF8wSdsB1tdorOyZHCpqGm79QdsqVxFvdfaMOPISEqG/anz182I72vmzrO?=
 =?us-ascii?Q?fpoF/qnclTFf4JZlwikQKHu6XVk5bfIuLpV7uUtvGFDbaLQJNymjgK50jPFu?=
 =?us-ascii?Q?us0ojGyS2u/ge+Hm3TB1vPw8jtf6Q4Erfif2agWqkXcfe98+8SnFEY6vDzm+?=
 =?us-ascii?Q?DUlOFBMn3TsOkTwPVPH9XuBDtyLXcEnUul6AUBdl0KB9NB9MumjR+O1sGcUf?=
 =?us-ascii?Q?H3gmpn1rZ4RCbNiN+OduptcIIhM2z9XF1kFJhoUcvB1oC3xoYRhjljdGNVik?=
 =?us-ascii?Q?EkEZvKMqyNH85XVKtaDn257oysA2mhzh5x3AFZN94GdP+5GuwLkWCa95ktc5?=
 =?us-ascii?Q?fEIoqZ6v+84QjBrwIu5nfthS3d34TD7gnGvhS87iLmbeQWkXtgpENGmTpeNk?=
 =?us-ascii?Q?A6N1s4LSYcs7v7pgJu4ErJR/XHc87w2nFce6ZQvgKou3Kfuj59UVsxgQrF6s?=
 =?us-ascii?Q?tkvxi5BVeauJFvRMYRFeRMr4W1H2S4NvT+1TF+kVAz1NBKConPMvVUs+50kR?=
 =?us-ascii?Q?k4hEuyyBB++UXrveNdTmgNpoLutkZAkN4BhyqiJw3wKPtEv24y704J0n1n+k?=
 =?us-ascii?Q?Hll+v5MITRroaAckTNWSUqsOOkkecXTO0Ef8261Cq6UU+8FFJeeYCUBl8ds4?=
 =?us-ascii?Q?1MSDvlakBw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qxeXfTl/6j4jGRzYqLqHKy8iDWsKe/Ao+rwrFk4MxD7i3r3m4Nt3SV19G8ZiZAS6FHDO9Ds/OMHherdNCyW66RMiPYbOvbmlCzcNbogqfVCMMt6e2lExTtIizxW9M8Y9/agLMJjnL/efzHs2h0F2vsIUVUXYEp+/+cpBxfmR9kcTxEm1u6WqRoKMmQ2di2ESbPMWP7DR7Y98tftslHyngV66x4vgOYS08tBDnadTWsxHrv14/ng/2comluduECJAhvdKG5yoeGkZNRrw59i1L5nJOxX0thgGYFGVUbZViiQ/MoX4De8DYXxFMVbWjMYGO3C9WtUKtvuSmU4R/2fLgw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8985.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf669535-c9a5-4b77-55d7-08df36643945
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2026 09:00:19.4767 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zP5FgGBJIF/AkWp7hSVUpeATMKc0x9w4NLXQxLZ/Etizdj+MXWmXCn5Cn2Z68ouWd3jxgFRpi0edYx5BtHTs8/X6d5lgWMEZ1FpHyUT9PIw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4686
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> -----Original Message-----
> From: Simon Horman <horms@kernel.org>
> Sent: Tuesday, October 6, 2026 5:11 PM
> To: Yuho Choi <oss.patchbox@gmail.com>
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Lobakin, Aleksander
> <aleksander.lobakin@intel.com>; intel-wired-lan@lists.osuosl.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH net v1] idpf: Fix vport IRQ name leak on request fail=
ure
>=20
> On Wed, Sep 30, 2026 at 12:06:48PM -0400, Yuho Choi wrote:
> > I appreciate your time to review this.
> >
> > On Mon, 28 Sept 2026 at 05:15, Simon Horman <horms@kernel.org> wrote:
> > >
> > > > Fixes: bf9bf7042a38 ("idpf: avoid bloating &idpf_q_vector with big
> > > > %NR_CPUS")
> > >
> > > I don't believe that commit introduced this problem.
> >
> > Thanks for catching this. I'll fix this tag.
> >
> > > name is allocated by kasprintf() which is a wrapper around kvasprintf=
_const().
> > > And kvasprintf_const() documents that it's return value should be
> > > freed using kfree_const(). I don't think it will make any run-time
> > > difference here, but perhaps it would be best to follow that conventi=
on.
> >
> > kasprintf() uses kvasprintf(), not kvasprintf_const(), so the name is
> > always kmalloc'ed and kfree() matches the kfree(free_irq()) used on
> > the normal path. Please correct me if I'm wrong.
>=20
> Yes, of course you are right.
> No idea how I managed to muddle that one up.
> Sorry for the noise.
>=20
> >
> > > Also, for completeness, shouldn't there be error handling for the
> > > case where the allocation of name fails?
> > >
> >
> > Agreed, I'll add it in v2


Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>

