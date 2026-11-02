Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1B6606A326
	for <intel-wired-lan@archiver.kernel.org>; Mon,  2 Nov 2026 10:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=OcFewWOT;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BrdCewde
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3E92440766;
	Mon,  2 Nov 2026 10:21:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id puL5cymW1XBj; Mon,  2 Nov 2026 10:21:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3F22240719
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793614870;
	b=rLGwJK6Pbc0wj4rQLYCbZLTGKgYcXZEkX3ytJxA/VbkZYlj7EZQ+ikprmUFshMvl7rfI
	 k/Zwx03MfsMLYIxNZaNHct9OHU5Rl/LUOcEYY10tHeVywQ+sIXJA+WwcFnNvImcq6eVRS
	 Y+lwYl+eI0GGEXVP4EO09vAGkAGuOCFpr/jk3U2FLaRoFQ6pQ5dlSkq5YDvEI0oJkdJ6Q
	 ENiSw+8k7nfXKn4zEVD5s7diQEdLDGDqGHIbSGAhYXKZRZ/fYIqJCsAbPicbSmsHdsFiG
	 xBE93yhLpFOLLSEpRm72HYcn6xVIvoBzZxvdxsXX2qKiyOcIT57uOQnJ9+5/lJxXK5g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793614870;
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
	bh=6KEDT6TRDycGzYmSMzbZWcytOawyauqZwUu7yvRoW9U=;
	b=rzUqqOSSXYQkf32eMhr0BKf4V8ueJVl74fiAqK96gIeAGMk06WI+PywzSruL55JSTajp
	 dRdArJkbjbQc/MJioJS2noCwbhnhJ+5wHDIFJvwtGe6wV+hV+T8bd8BJS22wHdzza/jzJ
	 TDxRSekqfAJNA0iEjLgHMceGWrhgjuUy9Wyt6xy8K5i1CakiW4ZiegwzCpHDQ/BijFMiR
	 umyKBbuahTPHS7iNA4gRz0raI+TFnPIM3p+L6TWwBKSTFa/EZPN7XqNhe4c3QUwv7J91n
	 stEPfUHlBDKWneHbn3cE2EimAEOVNgk9qKSq68ylXMzKB0kbPCLXUXQYpPwejDQafdg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BrdCewde;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793614870;
	bh=6KEDT6TRDycGzYmSMzbZWcytOawyauqZwUu7yvRoW9U=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OcFewWOTYhwaXHVV2y/DSmKgkI4WY7qdBmVmVC9SwcE7FV5LKYs5fS2jTGzZDnw1u
	 1EY4CxdQKlcE+7EZala9fpR0WQUXaBsS4jRJpCR9S1WQKltQwKl3CajP8hL1MZwYgd
	 T0KHQ0WBhlr9vUa0DcARRosQ2VsKy3ZB8tJnor/RhMmRbgHN+2c2jJG/91PhVplaqu
	 VIAqOGLFCcGdRt/flpHtkPCFjX/As6Qr0QzHxg40BEVc5l1UvyWG4Ms4VkSU52I8dg
	 qycuG+x4fR9tQubgcWx1apP90ygLVPQQ8Zak6JbVVVe3sobScnMRZW1HMKsQ7Epf6g
	 hGHYGEjixgRSQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3F22240719;
	Mon,  2 Nov 2026 10:21:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 30153362
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 10:21:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2187440719
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 10:21:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id THsC2ErUnnh0 for <intel-wired-lan@lists.osuosl.org>;
 Mon,  2 Nov 2026 10:21:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B08AF4070C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.9
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793614866;
 b=FMHrci/FYS2TpovLEfXmF3TC+b7AdqIzJnnv//krZ+Cf9ZMFLXnjN/mXoM1rxNgtXTtt
 Gv43UAMVW+dvwHFWcUefCngs1IAFtNd9ZMP5xQ8kvvzjndKQIeOFHAkvgeAFpKddH0akh
 yJwX8v/ZDhkaqWxKRb9BF4PzFCGu5abZlhKm4aZl6wicPMxyhIfrDNsBeXpRN3EQg7Vda
 x3MI4bUVRVlelZk6mWDUSVAK+Yiq7YJxlELulqMn8LKEFnbAB4qZM+93UGgONXmAVERTC
 ZcAw0RniHPuCuiOqEwsoLPPPbaQjfeKbDqY/t8NPNP9i2CQOtXhA/wR2MDJKlysAF7Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793614866;
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
 bh=6KEDT6TRDycGzYmSMzbZWcytOawyauqZwUu7yvRoW9U=;
 b=DiWz3qDal5LntwVHqNiepBXgjtv9gSfFdREIWg5vscWv4ApFoLHXmHA/0g26ktMEhHky
 N0M7An2BVmdcAFCkKBjfCUnZpAm8/DiPb+idLhHd6NIJHvrD/YCi33OraI/IG6LbbvADw
 9dG5wCD2tajXt9WscTOd1AgSiGMlfb2jq+l6zItpkAp30L45MpdNbe2darCPOZXAyLxwX
 Lk8bOJI+3lejC1S4nbd1Y0O6dfNQ8EGL5rJ5DXisRLgeL0dsr+oCyygo9VMaaFuT0L2f/
 pANp13H2HcCAK5XioIT+UnE2BaigQJ0RUPqOszlAKSQGDb4xSKUijrrC1QaYC4OHpKw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=BrdCewde; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.9
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.9;
 helo=mgamail.intel.com; envelope-from=rafal.romanowski@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=BrdCewde
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B08AF4070C
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 10:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793614867; x=1825150867;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=pZJeuX//qRNy/v7snjuqrHeqJexk8aczLBnyqEALhps=;
 b=BrdCewdeMOajfo2gnuddwnUjcXcabYvMQl9aXtT/nE1GDB3zKYEegwAM
 6arSveRGvAGaxRmBXpxEmh7E8fctUXhWago/qc73W32UWkWGpHZagY3eV
 m+LhEz8zl6HcJSUyDpxCOcHGoWUYerAmXTJ4d0b1ouz1z+dXdXC2eASIF
 V+KSro/5KGu+qN/S7D9qW4YRFrzdT3dFJrevcEYvBTRMAjhlwNIkrbKgi
 1gVqCl9w2IIwAHiujtm0e6JkiwKeRb4kpAEh29Ljh0PBLGYahJvI1JWos
 7tXkzJPCQTjl+3TYxrWhNa5ffbDsHD7N+ZhXr5Hv4LkTYj6hBEKDU2f5t g==;
X-CSE-ConnectionGUID: wM0yeJKKRy6uF+eqnprKVg==
X-CSE-MsgGUID: zSj5xYTBS6uYsThBMO5L6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2182403"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2182403"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 02:21:05 -0800
X-CSE-ConnectionGUID: lhthASbMQqeTNWRlMQe80Q==
X-CSE-MsgGUID: D1lFyYUwT36OeKKJ7HEm5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="7854241"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 02:21:05 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 02:21:04 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 2 Nov 2026 02:21:04 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.55)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 02:21:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NXGVuP5om9GBKgD9FoVz3eJWTK1a+GYGHBvQk0G7la0ytp+9OfnZO/5oVJYHhc2JjyfuE6HOZUHn21f6hnN2bCPsWlu11ndPKkt+W+jrl3ST5Z4zKoO74QIxwGMQPy6sCetL6h7r8cwgJ2dzO1zhXMTxMbg7JQADHc+ucqOsNsQLNULURT9P2oRNCyX0eU8iqtJpuaPGOYj00nPWZZ2NGpoKI+GT55L6OOJxbl+SarUiDISE8wqadtKCpso4zG9Rg6BrRw12uYsZVyqRF5EdmPleoeyvUeZi5WEPfPBKaktrvcakPpbJr/6BmZnuRkxUPlqRJ0s532WxBGpg6bKSlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6KEDT6TRDycGzYmSMzbZWcytOawyauqZwUu7yvRoW9U=;
 b=ywOeYIaARxAqVlIijNH8Y4MMwz/1YeNxQXb+jX3ub3std3rpGRMUZy8aIsCLBcnEtAu3ht/S6Hzavi2KLkMn6GFRIIxWCnN/UAYSmg3cjxm+M6QyV3PljwMiYZWP+j54PMC3jr1lpl84kVhcxsVuXGf6bvF3+JmufeHUVRjJdYJOZbXYwRAi7V/kPcePk1RQEgZINsaUqkPEBkoX5UToP3HW2lO//4FFlTNIs6hu4wglN+CUOWGpLEJsFKusP8mMdWrw7X0mtpTSwVGufSxd54e+IDgYo6gOu+DgpCxiV5LZ5EsaJ1g97X8o1vgVoHh3XELTEeDaEaaARWHOWiLClQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8985.namprd11.prod.outlook.com (2603:10b6:208:575::17)
 by SJ2PR11MB7574.namprd11.prod.outlook.com (2603:10b6:a03:4ca::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 10:21:02 +0000
Received: from IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d]) by IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d%3]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 10:21:02 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: Thomas Lamprecht <t.lamprecht@proxmox.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "Jagielski, Jedrzej"
 <jedrzej.jagielski@intel.com>, "Kwapulinski, Piotr"
 <piotr.kwapulinski@intel.com>, Don Skidmore <donald.c.skidmore@intel.com>,
 Radoslaw Tyl <radoslawx.tyl@intel.com>, Michal Swiatkowski
 <michal.swiatkowski@linux.intel.com>, Simon Horman <horms@kernel.org>, Andrew
 Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Viacheslav Tyryshkin <s@tyryshkin.me>, Melissa Romanus
 <melissa.romanus@proton.me>
Subject: RE: [PATCH iwl-net 1/2] ixgbe: fix NULL pointer dereference on MDD
 event without VFs
Thread-Topic: [PATCH iwl-net 1/2] ixgbe: fix NULL pointer dereference on MDD
 event without VFs
Thread-Index: AQHdVN36drhzjl4K2ky/j1K7AGXQw7cavemA
Date: Mon, 2 Nov 2026 10:21:02 +0000
Message-ID: <IA3PR11MB8985C5D424C51283247650B88F6A2@IA3PR11MB8985.namprd11.prod.outlook.com>
References: <20261004193704.2895700-1-t.lamprecht@proxmox.com>
 <20261004193704.2895700-2-t.lamprecht@proxmox.com>
In-Reply-To: <20261004193704.2895700-2-t.lamprecht@proxmox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8985:EE_|SJ2PR11MB7574:EE_
x-ms-office365-filtering-correlation-id: 6b32309d-e485-4b82-c87c-08df38cafeee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|23010399003|1800799024|10067099003|22082099003|18002099003|4133799003|56012099006|11063799006|4143699003|261021121427099003|261021123027099003|261022105027099003|261026121527099003|261022075727099003|261026140227099003|261009223027099003|261028144727099003|38070700021;
x-microsoft-antispam-message-info: p9PxXC3Eup1+aDmyOBM+6SxuTwdpDnPduvn5JUDBKAJ7gATpP6/9OCGMqZIMBmRxdQ7cPDFmNtwLguRuAXJQXEw2I35uVUJUmPhm04C6RW0fW5M6XKEZ8jFTmYtOyiIXND5L2W2x/322HQalQ/xnLE7bKQaElsnbDtYF0CpSUliYlwQqCmhT54IffMFzttKnOG6ZrSFDMVt97z+1GEbvoChx8Tcn59SNWsudKxSvTu15jTiSEerFUJBE+8DG/xEA3iTBS/Wy/gIZL1Rgs70Oa5kFZb4jL7t+hqM/BaSdEleG87z7wjGgPCiDjLLm4+xcPHi7LqBxHUQ7a3JErtzosfJwNKUkWSlTZ5jy+srWJOkJEBB8dgv+siiBziE4qJO82d6wb75Lp4MIRnPIgyAm5g2ABv3Itqmeb7A+1jx38ab2DrHYuufIbFEnFwmytikHrapW5Z1KfBrHDFPgtj5U4vAvhWKzaRCoUYrdvNKqrCyQEahyBTH2gAjNoJO4mLUudfdWA5e8yg2tsMrKp2FA2SFywC7/EORVIWHbl761ziGJWoSb5v3cXARTZEZa5ikH4EDdMBwU3K2UWJSN7aILLug9bkzT1IiEZQ6uSAtQRtA0SmPSOGHRJocQ+THSNJl8trNSAl2dFuMfRJ2kAMNzYNjRyAQrYamwFKJ/q0Wrn2g=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8985.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(10067099003)(22082099003)(18002099003)(4133799003)(56012099006)(11063799006)(4143699003)(261021121427099003)(261021123027099003)(261022105027099003)(261026121527099003)(261022075727099003)(261026140227099003)(261009223027099003)(261028144727099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aDx+oyT01XHofrkzrz20pskyyDjHPjA+/WZt/Og3xCTfEOJUuRChXWfQh9H+?=
 =?us-ascii?Q?uYQCxiQX9gL+yY3/fJ/Cj7otWL1YGuYPwynnXjvwELFchSuHh+a4NHYvL33K?=
 =?us-ascii?Q?Eblly0z/Jpe0Da5i7ZG4odUz/UDGp7jAbDGwiLLOR3+eZFzad6Uc8gUYR9gb?=
 =?us-ascii?Q?1m2YuRk08UESJRhMBpdToTOyEAnsBiLlGXDKZlByQ3ruO3tEjbuau5204yJm?=
 =?us-ascii?Q?T0fwgMCi+A4TPBTCxr4OmV6Y9CjO5J8BxrwiXaYhfuiMO1dqaXSb+7XhWH7X?=
 =?us-ascii?Q?RE2VqUpPbnsWDzPbIhb9CRc2TJ+z4iyzCO8prqC43chiPkFiAZTw7om0A87C?=
 =?us-ascii?Q?RLNVqLFlJuTHYa+4XUtc0kbt2Jbv2C6+P7EeQDh3NbNa7q4wjMKOrLPbs4Bc?=
 =?us-ascii?Q?nhc/+jcI8sobCTidt9nlTazO/n1aFxqkEY7EtZfykdDFDuzxFr5wc4n97/kH?=
 =?us-ascii?Q?iqcfIgeAD2SD7HsreWABZJZQInPEOFaw5vek3pxxp/BIVwBCacYdkDxfkrs7?=
 =?us-ascii?Q?unLoyf38RIcHXLhRNgISp1vcMLujwB3ZyVwz9MY8OcdrSEICOAWsjRXCTgIe?=
 =?us-ascii?Q?d4/GtSbbQKF4xWWReiqSNTGnpZ1fs0wQ/Pq/kNGrDv9X7XDaMBcKnrPnHxdq?=
 =?us-ascii?Q?hUfT5eTtg7lURbsuAzlTQb8Ew5Yx/o9IV2G4xElg1dM0X6JDONfcS2PFaRCU?=
 =?us-ascii?Q?adLRCC47Bkmka8fQtthDOGKzMVcm1lQg2oTlOIoV5Z4IE16IlE8jZq+S+I8I?=
 =?us-ascii?Q?9n/qLJRCHrN1a/hZiFZFWHpM5FIWuxAjcWAGaPHso8orkza5frIIqpd30DfI?=
 =?us-ascii?Q?/p0mQkbe0Jt6NgUPirYiByrM+9bR6PGpcS/G7aMMU0FUaEu+oL8S14WVT/jj?=
 =?us-ascii?Q?Z1mfVxlaXXmNwgJsv7YcQvOqhkFdcF++++/qe/C1h+XuQUQmhxdsUuve5cNe?=
 =?us-ascii?Q?rk+LzA2Ve5YnUEl4akJlTjQDMRWkPdc0cOferMmZlUd7Y6O5Pt0350aV8Ih6?=
 =?us-ascii?Q?F3JegDi+nHf7Sw6129yp5bY6lEchUfYaoS/3fO+1QiBgHsWMEx22984snLN1?=
 =?us-ascii?Q?3r0CDt0XK6EeOTt7gVHc9l6SJj+NfTxCTls0OZ7tgJoNWlkTyrwE/yYQJAff?=
 =?us-ascii?Q?1yQyF8mLjqV5ynygwoii4dZzr//SJ7tVzwrNTQwx1zzGHsJR/TED+6ItBDhx?=
 =?us-ascii?Q?++YqbGBRJRbFq8A4K5rhA4uxBVeBKUWcJol5ZJ9wWHCwrVE0DqLvlUeEJaNR?=
 =?us-ascii?Q?32Ek1LB6rXtFkuVnMRerhGKHjsq5l1LogzFURBWPlYpDrprtgjIAnioBEMlo?=
 =?us-ascii?Q?zo67nNCLFpvMy3Nrz6ZE5aawr7aKqdLDrBb44fpmpk3AKO1yQgmkIAREvbI4?=
 =?us-ascii?Q?HzrKFTZh1YLDD+4OimyWIz0nIwHXMWl0kx8XqT9B2wOZiFEqCKeZREJwFaas?=
 =?us-ascii?Q?K8pXtr1gxjMgnwE7TH4cQUyp60TWEwuSzA5oI5Gs5oFnmxrQi+h636BmnhJz?=
 =?us-ascii?Q?gNhx5dGE/jEFGqe1ndfhzvEFfpUtO+w8X8l9PVd3Jc5CCtO8WdthudwsGTs8?=
 =?us-ascii?Q?wS341tWlU/jdHp98N0v2zrofEGWSegPuA1Xf43x/YwXkyPzeE1qkvdvOHmPn?=
 =?us-ascii?Q?4ZXQYotOUSTh5gSePRyQArZMNKHCQolwpPjEfKS2FLYrPLVZYX6q9p00nG5A?=
 =?us-ascii?Q?s/sen+uYuxDxOm1E0Uprt4UXnVxSSsqRDM8nL5wNlmyr0WYbAGXn2dY1HWNz?=
 =?us-ascii?Q?EbeQsZbp6Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PHciSN3MAfWxWPgholF++sHc1ooFdUYGM6HsyhmUvRQg+xtOafZ7JJxF8qdb/K6Yxf/49eNXotjLmAYB8KE/8ofXGJgvocjOLo61rEjjqPfoCtITqWCtccTejZUKUcdQ3YHyOG6hHiPEH6EjBX/AmKI4kObMIEcZhn4nPHwJ0x+N4EekyBohHmuuCsZpeSWPtkm+rZqu4bkTnqVG2GXcubLujbs7L5EsieXvNbAmRlnwBVs88znq/lKU5q6D1mGJzsZhRSk2s9qok0Tg9ob/9D+XYOXVhXKL8m71QU7bdpjh24KFW3R8sIEQdxiUrdwE7UGOR2qJcB0ZAQoUO+JLoQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8985.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b32309d-e485-4b82-c87c-08df38cafeee
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 10:21:02.0856 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T2SKSxzkvrtWmGuUA4cu1UbGRVnbj7nMFxG4Y7+G5v9L3lUPbQ34FcsncJGyJzPRIoEcg/N7lITQXSOFqnQhFcsotSw1/EOOVRYtIq+gK7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7574
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
> From: Thomas Lamprecht <t.lamprecht@proxmox.com>
> Sent: Sunday, October 4, 2026 9:37 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Nguyen, Anthony L <anthony.l.nguyen@intel.com=
>;
> Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Jagielski, Jedrzej
> <jedrzej.jagielski@intel.com>; Kwapulinski, Piotr <piotr.kwapulinski@inte=
l.com>;
> Don Skidmore <donald.c.skidmore@intel.com>; Radoslaw Tyl
> <radoslawx.tyl@intel.com>; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>; Simon Horman <horms@kernel.org>;
> Andrew Lunn <andrew+netdev@lunn.ch>; Jakub Kicinski <kuba@kernel.org>;
> Paolo Abeni <pabeni@redhat.com>; Eric Dumazet <edumazet@kernel.org>;
> David S. Miller <davem@davemloft.net>; Viacheslav Tyryshkin
> <s@tyryshkin.me>; Melissa Romanus <melissa.romanus@proton.me>
> Subject: [PATCH iwl-net 1/2] ixgbe: fix NULL pointer dereference on MDD e=
vent
> without VFs
>=20
> ixgbe_check_mdd_event() treats every flagged pool as a VF: it clears
> adapter->vfinfo[pool].clear_to_send and pings the pool's mailbox. But
> PF queues can be flagged too, and ixgbe_msg_task() calls it on every mail=
box
> interrupt, also with SR-IOV disabled, where vfinfo is NULL. An MDD event =
on a PF
> queue then crashes the host in interrupt context:
>=20
>   ixgbe 0000:01:00.0: Malicious event on VF 0 tx:80000 rx:1
>   BUG: kernel NULL pointer dereference, address: 000000000000004c
>   RIP: 0010:ixgbe_check_mdd_event+0x124/0x160 [ixgbe]
>=20
> With SR-IOV enabled, the PF pools follow the VF pools, so an event on one=
 of
> them writes past the end of vfinfo instead.
>=20
> Keep releasing the queues of every flagged pool, as PF queues would other=
wise
> stay blocked, but only notify VFs. Check num_vfs under vfs_lock, like
> ixgbe_msg_task() does, as SR-IOV disable frees vfinfo after clearing num_=
vfs
> under that lock.
>=20
> Fixes: da3ab95f9b06 ("ixgbe: check for MDD events")
> Reported-by: Melissa Romanus <melissa.romanus@proton.me>
> Closes: https://lore.kernel.org/netdev/bqzPMb-
> F5iRWe7S2DWkQDhsK8u9ZoIaK34sF2pHpAjP6WHFb70Weq3pc8ZIVUoIx2EbPHd6
> HLBzz1HHd3xb5rxRZ9F3w1L6TQAd87S18CPQ=3D@proton.me/
> Reported-by: Viacheslav Tyryshkin <s@tyryshkin.me>
> Closes: https://lore.kernel.org/all/abc23ed3-f194-4546-bf99-
> 7152464b93e2@intel.com/
> Link: https://bugzilla.proxmox.com/show_bug.cgi?id=3D7874
> Signed-off-by: Thomas Lamprecht <t.lamprecht@proxmox.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
> b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
> index 431d77da15a5f..7edb84986a312 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
> @@ -1444,6 +1444,7 @@ bool ixgbe_check_mdd_event(struct ixgbe_adapter
> *adapter)  {
>  	struct ixgbe_hw *hw =3D &adapter->hw;
>  	DECLARE_BITMAP(vf_bitmap, 64);
> +	unsigned long flags;
>  	bool ret =3D false;
>  	int i;
>=20
> @@ -1466,11 +1467,16 @@ bool ixgbe_check_mdd_event(struct ixgbe_adapter
> *adapter)
>=20
>  			hw->mac.ops.restore_mdd_vf(hw, i);
>=20
> -			/* get the VF to rebuild its queues */
> -			adapter->vfinfo[i].clear_to_send =3D 0;
> -			ping =3D IXGBE_PF_CONTROL_MSG |
> -			       IXGBE_VT_MSGTYPE_CTS;
> -			ixgbe_write_mbx(hw, &ping, 1, i);
> +			/* indexes >=3D num_vfs are PF queues, no VF to notify */
> +			spin_lock_irqsave(&adapter->vfs_lock, flags);
> +			if (i < adapter->num_vfs) {
> +				/* get the VF to rebuild its queues */
> +				adapter->vfinfo[i].clear_to_send =3D 0;
> +				ping =3D IXGBE_PF_CONTROL_MSG |
> +				       IXGBE_VT_MSGTYPE_CTS;
> +				ixgbe_write_mbx(hw, &ping, 1, i);
> +			}
> +			spin_unlock_irqrestore(&adapter->vfs_lock, flags);
>  		}
>=20
>  		ret =3D true;
> --
> 2.47.3
>=20

Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>

