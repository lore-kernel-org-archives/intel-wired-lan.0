Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36594C79FA1
	for <intel-wired-lan@archiver.kernel.org>; Tue,  8 Sep 2026 09:09:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E36178081B;
	Tue,  8 Sep 2026 09:09:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0JyX8fsQPpWs; Tue,  8 Sep 2026 09:09:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org F26F4808D2
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788858556;
	b=tGUWLPKyAsPLQoAnCZI3cP6OUDkYIJXi+s9NB7OcduxmmKtuLTDc34tKYcn+s1TRcA37
	 94cJZEZ9SamDuq5IIDTfWrQO/l/jXV62KRF7Qy8TV7TQ+W4Omr0//YvLHM7eKUMWG6rBP
	 DD0ioEp6qb1dJyD5j7XsY0fYjgZuCdYXlzwgzY4TBkBqaiE9j52IVDYircUiO1lslZklY
	 v+8YVDJjRq8WPpoLCrLCIo1jfIv8ZXLuD3zXNeRX/6smeFleJy9NwtCDKGJPGzSrpq6qT
	 QrNncGC/pAXzeZcDsGg4ZIawMfbxttrT4IRSN6qV3Xz75qfFwZ3ZySa1iTtpOcQ6WBQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788858556;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 Received:Received:Received:Received:Received:Received:From:To:CC:
	 Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
	 In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
	 X-MS-TNEF-Correlator:x-ms-publictraffictype:
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
	bh=nIKfPFDrBegPC2tzdtJOfa/VgLHEGbs3RRFjWYinfoA=;
	b=adWYOl/a3PCrkgrZ41t3XJXz+qeMC1raSdUqz2Mm4eNZxos2YmPH8rJ/0XEm2+59Ffc7
	 APvYmESK1i8J7B0elcqj7/ty50r2wNGd4wl00nWX/2vbJ0utjYBM7feSxE8fyQD1l3UMl
	 I/2PDHuA8zzCI1LcK4psPzYCaWqqCfxkCXGNYG34Eknnhg/Bpfm1UJBcdswS8vzHhbuLv
	 3ybMJqaYyrWs6yXYXdTalmY6+ewfsd5avGfXolqeGFMw4Tj7Aom+PkCVwxWXfbbbd8Ly2
	 c0lT/886ySyR6Kym1PEZ42Q3jcPIxQF4EEv6j5vXpl/UVx2f95lzlRctKFtFH+Lvqkw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788858556;
	bh=nIKfPFDrBegPC2tzdtJOfa/VgLHEGbs3RRFjWYinfoA=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qs7Zw90d5hVwXR1qPiZdyjruR6KmlPaes5rv/FZEtnWiC0FNEgc4gesIohaB5ZwA3
	 107y0Ylk97cyV0u9tnAbFIS9T1dsudg0W2hZi/FB+rWkA3q8NBg0HvBZecypJN2U04
	 9GZLkJnqwjTLnc1Zq/cDRPSEWIbiSqtzi91NcUvU0mS5JS8JQ0p+YvlDfsNGY1HEoZ
	 T+Xuf364qbzVHvp50ylIKEcBnm2Jj9JP3vT3inRHzTrr1drgATqw76mNyJtg9/xxD/
	 ICHCf/pqUDNiONEPGRkuUvdQZiZ7xXjazOrfZUjSn82JWX9JrpYtFtQvuHCTIaEnb0
	 1M1c1bAlo0ILQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F26F4808D2;
	Tue,  8 Sep 2026 09:09:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B164FD5F
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 09:09:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 96DAB60690
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 09:09:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0A56JP_JvRED for <intel-wired-lan@lists.osuosl.org>;
 Tue,  8 Sep 2026 09:09:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6968E605DA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.9
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788858553;
 b=qWnIb6Y4m7KyqFI4gTzYy2w3JaGeeUpkQc27CBcgyZVXXyFkx7hv5Ejyo/wLNz6RSYDm
 RUERSURI44Z6i8ZG1EnOcgLFHGp6TDOolM51+srwD7LkJuFg9sUHO+u+xqETbsiM2LrZg
 jwh29O7wFEv2/ZjYYCPjVcnw7HGFJMTYNZGkSET25TYTfUYtg0fnD/t1ApOutq8CjvQOC
 HcKdpf/tv0cQKDKOEa3HA4gym3WqOibkEb56R1UjURaXBrTH8FSL/zvFrjHYfYfMugNkk
 zT4HCiSHaVZey+JqTI/lUguHYm274/Lwp3iBc9yVK9Cz/Bu3UhynnczVlT1Wq0KA88g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788858553;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:Received:Received:Received:Received:Received:
 Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 bh=nIKfPFDrBegPC2tzdtJOfa/VgLHEGbs3RRFjWYinfoA=;
 b=QXVHC7m7LMy37c6Idqp6G9iPYrUDgBe2tU3rcL0lLADni+9o1lbigrBGLQkEtJgmBekD
 pIMGPkziASxpyYabXS6Yaf4f4AxNPg5Z3niOSyYhWdPKGP/7ziohTa123pYcBAjZHGRRn
 QOwKfNeUxv39o7UVnN1uzh8b7v1JKK4F2ZCCxSW8GdNP5f4d6qR9rjrE64X0WEeSvOYT1
 ydDOt2gtmRl7EJMvKBdAahYJ27OTzvzvFcOza/ITzjn1E18ll3quIGrVAXQe5XleftLiP
 jK73IcCcgDXMWt+g2ihMHfg6W+Z+C11DKHrndR8GMjiIvwu6e1s7Zzx2B2jv1JkCCxA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=kaY74CMl; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.9
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.9;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=kaY74CMl
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6968E605DA
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 09:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788858554; x=1820394554;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=TOIoWQVoE2U2VNq5gphXANTyZkTlsBkjnVnUUYjTddA=;
 b=kaY74CMlr/9w63xCzhlabEGiJcsC108Bh8m2+b7TMJIurAaytAA8zgGm
 RmnBBVBFIh74LZtTDiNh4NZFif3qCJtB2WFkE+4X0vkeutugo3NqeDVtJ
 O0A1hGmHvprNO+jX5pc/ptH00KzHalZuFSKmG6i2xUbiNlhuDPz5Gtqq5
 F4ZXZieND+X+g/CugrpBgO2hAsUKOwCow/txwBpLZStiAYxk/LVyAUZW9
 nGcEiW9QFD0vlzF1SpsK0Jv85W5Jo4vmEqTDZWGePJzFrWgJ+Hh0AeKrC
 cmh7GQ54aorm7Y/vSZUVWJNcJNlf5HJwF5NUr7opY32HwYU9Snf/kSXSj A==;
X-CSE-ConnectionGUID: FkMu4/b5TzimAyvGQ/z6oQ==
X-CSE-MsgGUID: Vv28SHjXSlurpeK7IYUEYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="112030783"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="112030783"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 02:09:07 -0700
X-CSE-ConnectionGUID: t5CgwVYaRlquuBg+utYBzw==
X-CSE-MsgGUID: 9qsgQXVGSHCDxGE5Qs2BFg==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 02:09:06 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 02:09:05 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 8 Sep 2026 02:09:05 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.49) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 02:09:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mg7ShjCWgJd4wiGbaRJ+wWZieqZgHu+PzAs4iTTMyic4huTcgcjB/A5ovh8sVgPaxnI7RcoSfs36yMOQeygKFkVkVeHUgPeQ49jIrGpAYORqWsbTtSBlxf6r1bsOk0J9AbP+wAZzTLBIAhAuiwFBsHoaokVUgHvOAkDaVADQZEZFfUBZwz25E/b2sdXLoOnSqBN7Do2sRapV21URIu+ZJyY4ZIs/tGKXsgz9d8ZN1NDNRJ9ClvFJT4nPNkuhzgEv2UgpoTFZkgK8GGBc608Zpenpf0AH2EmUEO1CwPduglBs7uvQcvfWy4YTZcDTA1JmRKJ4Qjeivfj2EmDuiRCJQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nIKfPFDrBegPC2tzdtJOfa/VgLHEGbs3RRFjWYinfoA=;
 b=PU/jXDqGVHR1EFtYS2yvl0pE8OnAjtj5T8t7ZIZcbeqzl1ZAVLRNYXH9IujuDlOZ82RT8Y2HvuU5Tpgw1zglafunw0b3zaaLRef6W458zfVbVlHIb6yY1gJQLewkZLq7bpZvPWQdqPSLCEwrThZ19NnyfCOcq/iyq79/cESDRhuSBignNEccjNyuL2BqMs3rEf4ls8+91xuN5wZk4InbnOYY3xN6Tz37kF8Jq7pOOZBJgC9KJZhsU9VDFueAVVvNJVwuz43SsHZx/WPVnt8VHDwL3edx083sW/HCl9XxkN080xIToVKnrdW+Aa1l5HelvJGMrpBMf/vqnY9gJBA4xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB6864.namprd11.prod.outlook.com (2603:10b6:303:21b::16)
 by SN7PR11MB8043.namprd11.prod.outlook.com (2603:10b6:806:2ee::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 09:09:02 +0000
Received: from MW4PR11MB6864.namprd11.prod.outlook.com
 ([fe80::3cb9:afc2:1be5:5d7b]) by MW4PR11MB6864.namprd11.prod.outlook.com
 ([fe80::3cb9:afc2:1be5:5d7b%6]) with mapi id 15.21.0382.012; Tue, 8 Sep 2026
 09:09:01 +0000
From: "Temerkhanov, Sergey" <sergey.temerkhanov@intel.com>
To: Yury Norov <yury.norov@gmail.com>, Andrew Lunn <andrew@lunn.ch>, "Heiner
 Kallweit" <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "Raju
 Rangoju" <Raju.Rangoju@amd.com>, Prashanth Kumar K R
 <PrashanthKumar.K.R@amd.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Jian Shen <shenjian15@huawei.com>, Jijie Shao
 <shaojijie@huawei.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, "linux-usb@vger.kernel.org"
 <linux-usb@vger.kernel.org>
CC: Yury Norov <ynorov@nvidia.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Andrew Morton <akpm@linux-foundation.org>
Subject: RE: [PATCH 4/9] ixgbe: use linkmode_and() return value in
 ixgbe_get_eee_fw()
Thread-Topic: [PATCH 4/9] ixgbe: use linkmode_and() return value in
 ixgbe_get_eee_fw()
Thread-Index: AQHdPxOI5Bym4XcAaES50yR2ug5Ww7bEZP5Q
Date: Tue, 8 Sep 2026 09:09:01 +0000
Message-ID: <MW4PR11MB68640CF830DA38CD3057348580B12@MW4PR11MB6864.namprd11.prod.outlook.com>
References: <20260907215439.409858-1-ynorov@nvidia.com>
 <20260907215439.409858-5-ynorov@nvidia.com>
In-Reply-To: <20260907215439.409858-5-ynorov@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB6864:EE_|SN7PR11MB8043:EE_
x-ms-office365-filtering-correlation-id: e77079f3-9906-4c76-4fed-08df0d88d300
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|7416014|366016|1800799024|376014|10067099003|18002099003|22082099003|56012099006|11063799006|4143699003|38070700021|921020;
x-microsoft-antispam-message-info: Cahm8HGkNeu214XG1I3lkALNeWbCShDyqIQTyx/g6qt4cnFPH8uK/3FiFap1N9PbNJmAHVBtXbncvg1mlGXaCCfmC95AIBI8755YHDlBSKmCgo6DIzB/MKYhgYgu0qMmA4YIsrVNGqshTXWxjJQuG34WUzo20JUtf8sYkHtYMzObS1ApltmDA9rUt44L8/+kHCqLD6Dz4yI2k8IOcsWx2ewiUvODMIIhTUl+mSLGrp3dwcG+NsbHqb2u+/FGTPw+9Rq1jIBOldN2bqj/LvMaSgPFPqBzVZ4Tu7zsBMCiiawePCE21DFE1iUyKQNGxpjHuGzEPBQVffjDeVmHrR60GN/EEIqbmvRyKGbz+9drqLdEP2U1T3OY+CiHcaVL7iM3+GtNIRKSE1giRy/H9HPYC9EMvnJRQde1rMpUk0OELfB5mHOGVHFjvzL2UaeGVukMR0FCd3mbgtwpdghm/p0vUy5Uauwv49Ko/8xKRvkNoEtrXoBj7WKCfRvvszEWh2LfqhKkxgF3BCpL/+o0iexo2yoxykEmYI3ECeRvTKxf91ud77Rofy0jGnDXdxJ9z+Tr/gDcpPAmpjbiFxFH8uI4dA1LBIvoiMx7mWHvXchS1TM3AojOWeUEI3ExGvw8ifPK6mJdxXBbQdedQj/IBxuitzthpQsRiKi1xGpa7KLj3IjLMzkfVs6AdZK/ScyvxQs/6+2kga7nFPXTQPW/JarwGhJwByoHj2N1cuFe4xn+VFY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR11MB6864.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(366016)(1800799024)(376014)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(38070700021)(921020);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rjlJXXoYZ1vfKoyqfRKcpe6aVkym0AGE3/Zpo2q8g2zkicQgnCVkEEIJ9TlW?=
 =?us-ascii?Q?nRy5iXv9FrB6ZYokg4qa4gNnNHtCyH6osbZwu3uxISNyRSxmbB7X+jbe+xCq?=
 =?us-ascii?Q?2RNWGFpGDlCsJ9e3CvAFMOGzJkiMcXIjlaBu5n2Effa1iBIA8mctzCdvrqH4?=
 =?us-ascii?Q?IQZWJnfV8zys8b3edNAzqezDspjIhlEv28jYu8OZV3mbPE2ZOhV6pwNTLkWz?=
 =?us-ascii?Q?PqQMj53HdXFd3F4OO6NgVTHXjWCgvHKpN1n/ZL8vv8KhLlN8Rl3SIt2UaT7d?=
 =?us-ascii?Q?UWW3TrDaWLlVgTKwhtk7hn1ts7L16WJS/LZrjYCse2ZidXhVF2Tg+hnHPkRx?=
 =?us-ascii?Q?ezE4Z+nf3zp6FE9frQbi9Bk+PvrPALdJttt7h8zgAIIC41o59QUanny5PVcC?=
 =?us-ascii?Q?ypAJIw7UOMCKnAqFef4jstt/seKxqhZiCkEaP7uU0H8WP7xU+S5JuJoZhwCl?=
 =?us-ascii?Q?YSCxW1qGXNwJTqQgKz0m10PFo3X29VvjWhaLYodsQqxR2fta4cDq7wMVdJB7?=
 =?us-ascii?Q?mLgCR6yV4g4j3B3RZ68FXjiiJ/CyflIskQ1dhHdGTUvigxLGlS5W9L02L6Qw?=
 =?us-ascii?Q?feuk/wZ4P4xOA4mn09nY8Ayt2EEf9/HSEbe/uAyhCTTqiS7n2CQxVHFlAPEa?=
 =?us-ascii?Q?MEnnk/OFFlMyJjhI17ERcbYtdSKiVGRjWi34f4wZ5uK5pPSY6Kb48zUfjCgp?=
 =?us-ascii?Q?uytVRBu3SY3B43phHpgomN07T8ilwi9IXgipLAE6y97wDNNc3+nllSmXIJP5?=
 =?us-ascii?Q?X1YnfzZvGpPL8hDHWq5E+L5g4YEjo17eVrGFpxmvFMydOIdfLrUNy9boZedX?=
 =?us-ascii?Q?KMxw+oHoYjYMZ4b0S3l4T37hneZZ4q3WaZ8chUpYsITaJqXpmfFcEb1J5Ogz?=
 =?us-ascii?Q?UC+C/N/kGC4OHT4uq99DK4uTqyXa6+G59FvUZp9rp9scMV7dIuSuYgNanmSA?=
 =?us-ascii?Q?3VDVlh2nqhgG3G7aYV5D30fh+o/xKRxPPp40pDxh2p+K821vBHf8mqI4kACz?=
 =?us-ascii?Q?ecBb5UsAljN18I19ir5gA4McnmqR8wWV57Bxe7J/Dm96txTjBeaIISGlciOs?=
 =?us-ascii?Q?CGMvEDl6u3yPGqjcxfsfikcCRbRy+Ggavr5d9auFFOLWO4//HwOF12Fl1Vy1?=
 =?us-ascii?Q?6qr5YHKAUt+JPFayED0r6QZM1hSVS5qBY8LEZlMEmSVTaLADcmKmvk96uhQ2?=
 =?us-ascii?Q?iTB6n9Xicii7pd43hQLpqxZf1PPy0dcVrEC6DiIlLAY1KJK/dGysFJFEH4NC?=
 =?us-ascii?Q?EPMekh9X01vIG1phw1iIpelOd5Ju2UoLpOqrmdAlKkxeL8CR/+SW5k7H08mh?=
 =?us-ascii?Q?+6J4LFi9fuhkD7ZS07BzewV/BbLst3FWsImZH+KHNe59WEARZy7NHNT4LioY?=
 =?us-ascii?Q?kXF7KOAvsofRSlBfjjXsu7f4JK1+C42EELn406sOprr0/3ACcJGexa7BDVIz?=
 =?us-ascii?Q?21kHIZIEC7TZ94QSv92QAt12WSMWmhbkcp1AdOMFkAThTfp1xpy8pyYro4sg?=
 =?us-ascii?Q?6eKM6s+Yp6f1QzzR5n3T9MXpfFS4U2tUyqV5DeLgu2ZYNZYy/PrZiHLxBQDY?=
 =?us-ascii?Q?2LkhhliFDL9ZJIMDX7g6ydvfynqrZ8v9P7lx1CkRNW9XKXMDqbTx1Yd72QK3?=
 =?us-ascii?Q?5FwRHY+tEokfyXx1jY+7sxZDYnrQ6KUYQTLY5Ir5Aq5Umk0qvaUdE+IW0g0y?=
 =?us-ascii?Q?dRwieX9LlT0EJVXj8uoBAH5JuZMDwH6K0T55ZyfBGw3XvB2NL+gvhq7B+fAN?=
 =?us-ascii?Q?eXI1wMasLg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: uEWgWIKLpro18f/+T9MiHholtlb96hrBGow4Pi5b5LaHBcBL07XrhR30BMXhJopfE/l3d/HsTwdXKlZyP2ycGHRyrLsoM9OYdpTVtt7zs06gBzM1Q27htRQXBpKlH7g9Vabfj+sM3yLGtKOmFYFwY1wE1ntGcAkWHbscPQieq354anlCZYfx4Hh7I3v8U6qv8cWytP/iahS3UImk4Hl89hi8Nz/DHHORWcVe84PKwq5tPwuRqT8wo5XtDh8wTUFddYonaE0irlL/GxqO8goP0ZjHr9m+i/XITKQQoccndjxzAl6XMmCE+C3zdBFZ8HkwVJhEMKIUvUGIkr84qXI4fg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB6864.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e77079f3-9906-4c76-4fed-08df0d88d300
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 09:09:01.6228 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kgr2Mn5XoQIPnMfA3VGHeplTuVDMtmwf/rMj/H1SvSV8nhE5x9kT+u1Cwersk2BP+zKNbzaCL9j16pMAZBJTvS1ZE13nvtHoH3ly+M3NVK0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8043
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
> From: Yury Norov <yury.norov@gmail.com>
> Sent: Monday, September 7, 2026 11:55 PM
> To: Andrew Lunn <andrew@lunn.ch>; Heiner Kallweit
> <hkallweit1@gmail.com>; Russell King <linux@armlinux.org.uk>; Raju Rangoj=
u
> <Raju.Rangoju@amd.com>; Prashanth Kumar K R
> <PrashanthKumar.K.R@amd.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Jian Shen <shenjian15@huawei.com>; Jijie
> Shao <shaojijie@huawei.com>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; linux-kernel@vger.kernel.org;
> netdev@vger.kernel.org; intel-wired-lan@lists.osuosl.org; linux-
> usb@vger.kernel.org
> Cc: Yury Norov <ynorov@nvidia.com>; Yury Norov <yury.norov@gmail.com>;
> Rasmus Villemoes <linux@rasmusvillemoes.dk>; Andrew Morton <akpm@linux-
> foundation.org>
> Subject: [PATCH 4/9] ixgbe: use linkmode_and() return value in
> ixgbe_get_eee_fw()
>=20
> Use the return value of linkmode_and() to determine whether EEE is active
> instead of scanning the common link mode bitmap separately.
>=20
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> index 36e43b5e88d1..a7b7f89f29e4 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> @@ -3751,8 +3751,7 @@ ixgbe_get_eee_fw(struct ixgbe_adapter *adapter,
> struct ethtool_keee *edata)
>  	edata->eee_enabled =3D !linkmode_empty(edata->advertised);
>  	edata->tx_lpi_enabled =3D edata->eee_enabled;
>=20
> -	linkmode_and(common, edata->advertised, edata->lp_advertised);
> -	edata->eee_active =3D !linkmode_empty(common);
> +	edata->eee_active =3D linkmode_and(common, edata->advertised,
> +edata->lp_advertised);
>=20
>  	return 0;
>  }
> --
> 2.53.0

Reviewed-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>

