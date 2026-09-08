Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE0AC79F82
	for <intel-wired-lan@archiver.kernel.org>; Tue,  8 Sep 2026 13:08:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9970D40593;
	Tue,  8 Sep 2026 13:08:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ARIx864WjKTb; Tue,  8 Sep 2026 13:08:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E20C740562
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788872883;
	b=IQrIdlkDaxfQIQ27Z4DI2+p8WhrqkNES0jISe77AAmqWDxyRJawIkAnk1dnMY6Jm0PoG
	 Yl8V6DTSwuARmxQWhlGkbBDQ7nmGh2uAyXJMHObEn8meryY6Ai7L5PUkYI9h/O1s8l0qt
	 goG6+QvU11sIuS84nUTaETzkJXMRo5lRgYlsqEp0UlafE09miSGX34IfMvQpDn5slGbQz
	 +tMky9rcq5dpnWSr4WPirpOrQ0xjrhmoWi6C6nwHoLBkKvzPEqXYBfaSxcaggT2GRnlsc
	 zVqRdilK064YAL02ZdaSyrAyEdWRc0YJvYPhvXB3W44es7UOYeTTvRUSrKZC++5XijA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788872883;
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
	bh=if0foLFhHYVuXRsUN+3aDrwwVtMdJ5dguaRKbC48EFk=;
	b=fp6ztvBlolR8T5yq9HJ0Olx9XBXbPiIR6EKaqBr9XGSSCWWajDJ8Uy0aE2dlxgPIDceO
	 idUnCeasqD6m5MTgx0t5UKTDhMh+HiRh4GuobDetAQm5qBRF356oYaEoaACC/4c/+6B+Q
	 f9/zM2XhlgXJE99Hwk0/1ataYNhaqpgvEbXdTjiwAnvwkwdXDpvASvw/EqPOnapnQ4L0c
	 5ZH42C2/Hh6VCe+qIKV4UlJ/Ir5fubPGIwMfGgjgnl6pKsYbJypb+FNm5wxcH7q7ZvEpv
	 1G89pru1YEOXCk2tfIr2Qe1QTCKHfnsM+keUmf3JbWWGDSe728J2yvoP/d/5Y9XHP2w==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788872882;
	bh=if0foLFhHYVuXRsUN+3aDrwwVtMdJ5dguaRKbC48EFk=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T+FRZ+OCO/zS7p2Yr33lwIB5Zc2vZI2QURB9ZQblTIEKICZuElyJVSJdZkx9kPbVV
	 FPddHIqKtwdm2l58LG8RNfpp2b0FaWv3Y/ghp6CQFc66YpWvwcIHk9RaFrXBg5DGX8
	 oQTxe4ANr7dZ7VR+pg/+z/7V/dXvE6qtZX3CviukAxdJf0ygFpnL6uH0QSgn2OBVNH
	 181tLfnivFUe9woqbK+dk0BgXPq/peK3vkW3yk0eQD1QQTyWS0C42w5/7JlIktnZOS
	 X3VHpCMHW0/RUT65LtX0fguvMUjTzhMV9YHyHT0lvIadysBPgaIHIYca0ockyKyVG6
	 MZUtvSmUo88Dw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E20C740562;
	Tue,  8 Sep 2026 13:08:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id DFE60372
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 13:08:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C54B58083C
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 13:08:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yVpvKnCUuPlD for <intel-wired-lan@lists.osuosl.org>;
 Tue,  8 Sep 2026 13:07:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 71E89807E2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.11
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788872879;
 b=g0LN81E/3Ec/7aF3uoABkW7vVsNuc4t+dCHWX5cplZPiyVFePYHK9W/PP/8827BPoRDw
 BLvIczSt3o545X4EaBwRRoaNN0s+rFstE55SQH9OU7RooiV+Cy68LNvyquz5RV6p3FvU2
 OChOjJrKC0R/oCYVZsFgPZubruvx9rDPh9uYXE9iNo+ZR/fQRcWx8e77PapPv/LW2iDQD
 n2dS0Ia3guvcz3WsRLKU1bACDhqZvvBeTmGs28LUTD0a9UEB6UTTj8gMBWwWIi0ATSkVD
 qnMtA6As84fKte7kYhE+1NvyMzqOGzxYhQdzX2nWJxqMEtFNE75gPrnLrrWEl9iy7cA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788872879;
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
 bh=if0foLFhHYVuXRsUN+3aDrwwVtMdJ5dguaRKbC48EFk=;
 b=Faq2C7d/bYqrPej/lz7QCOgDkdyamEpHKGnJ8lXkompCSwiyBp+o4oVX35dGbhWScClU
 LveEqqo3CbFT9BUjIBs5TuJzZAQJCmJdRusm2zwv44RkdV+bUKVuMToKRWt2fwvG5+Kf0
 Fr8KP3tG2uCP30J159paASJk8XOJ3r03Uja7D6TxT12H/pkaY8+fjtmIS+VQqh1KwrFXs
 lOXuvYS8TR4eWC9AJlF4vnF5kMm+Qk2ZJ2juM5r/uX0adipSaO69PU/L37ZAli6lo+gQU
 Ze57WrBLSRjTV3grQZEeRfOHyWDnnBfMlSlZN9jLf4DDljCmQiUeaFkZHBXFDgUyqLQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=f0GpniR1; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.11
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.11;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=f0GpniR1
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 71E89807E2
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 13:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788872879; x=1820408879;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=rKUa69AmUvOWHcqcYmo3bRTpLpcd8N6P8vG9Bv2ge7g=;
 b=f0GpniR1MnVB199/aGSi7Qt/pKO5ozGpMIWw9Cdu0LXjvn0zZ4i8BFpx
 gp16FeYBHRjM/bXQQvMqoLzUT0pcFyUaa+9cgIDOgIuowhgLGp+3ZdgVt
 tEm5jCgsg0BR0G4HEwl1fEdXNua0Wth6sxrreWl6/G+AgcX58A8DDT3LR
 Oxi5RRdYxrHFjrR9rbhbT4sqa5hsBC0SVeMA7JitZygWTTs5P0zfrOUOs
 +3f5m/qKAWgfYsrO4C4W/WWLD7cIrEkXRC/qajRlRjRR7/8+ubd7ATdUf
 5SWhJta2pNoEOK7+NthS5569OMRipKO0W6OlOPftKd9tmJjoKuX2yPwWW w==;
X-CSE-ConnectionGUID: bIZMUwiJRyib2GnwWwPefA==
X-CSE-MsgGUID: jLkUpt4lR5CJvVhMGz6bXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="99866404"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="99866404"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 06:07:58 -0700
X-CSE-ConnectionGUID: cWr1mgRrRYW4lpH75hjgWw==
X-CSE-MsgGUID: nvnyBrMCQKutQXKXujSgug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="295904391"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 06:07:58 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 06:07:58 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 8 Sep 2026 06:07:58 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.64) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 06:07:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hjic4Ij075TGuhD5BAOcXQE3ytvzs2xQ9IJ+ahoaP+LHfuFYTDJTFyolRMeSMEmEROeaN5lzlAkYgobiauyQs30Y32xfmYKYkLnX5e920pMX736BDR+oKWA2bOZpjzfx0SFBd3euQRstwn4QfdnIEnwYeckhzYKZRE6FSyDpDTmqcaUCrlLU5oFfhmTw6VULaO/mPfaOyJW9j+NIoxYa/Og9X+3DqSiPxZvjdOFA6DIZSI/40s4T93aJiNBrMVO/p0POjr88XBclbCeo00+pQ5TjjfMth22h0I4qfRUrVMIoR766rS7ynEZJKUuiLsIXYlqN49ly/rIz/vVIdatyuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=if0foLFhHYVuXRsUN+3aDrwwVtMdJ5dguaRKbC48EFk=;
 b=frMhgrUtu9Ea3ulTRyilXzJgjO8PFPtlPsjS4INUTYdL0eOHgqK2UIrdlESX5hjgBpBXROjXPpWaqkMC+yAV9UahrKtB1GNwJgTh1SHxs8wMTvrPb5tB4Ba3GrZXJoi0dTg0lLPHsLzQPf0itt6Aox4doxiCP3Q4mPqjmQsFzFVaNkr22cweLHlAuMf7AQWoz27VQVW9xtIQSzt4O2dKlB7aRCMnB8zkpGwqD9LDgrvaiHMXErzdOgx9Fm+IojX+x/JKVNIaKYSIbIIWjP66s9pus8/pWtL38iTh8euJ7CJYsiRYftDpTcD+nyuqKa3gt6moO0X6tDMepiYYmy3cxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by PH0PR11MB7658.namprd11.prod.outlook.com (2603:10b6:510:28d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 13:07:54 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 13:07:54 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
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
Subject: RE: [PATCH 7/9] net: phy: use linkmode operation return values in
 phy_device.c
Thread-Topic: [PATCH 7/9] net: phy: use linkmode operation return values in
 phy_device.c
Thread-Index: AQHdPxOOZVYU8Wsvxk++P9pUHXqKb7bEp+lA
Date: Tue, 8 Sep 2026 13:07:54 +0000
Message-ID: <IA3PR11MB89866E1B62B7C7E2F773B7A1E5B12@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260907215439.409858-1-ynorov@nvidia.com>
 <20260907215439.409858-8-ynorov@nvidia.com>
In-Reply-To: <20260907215439.409858-8-ynorov@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|PH0PR11MB7658:EE_
x-ms-office365-filtering-correlation-id: 88bba9c1-6483-4fb4-3fa5-08df0daa3223
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|7416014|1800799024|921020|22082099003|18002099003|38070700021|56012099006|11063799006|4143699003|10067099003|3023799007;
x-microsoft-antispam-message-info: S1vzNW01uZ5I/+U3w6z2TM5gTtPNxy+r5gnAxm4M7b0uw04a/NlAKOdvhsZPAd2oDmQLVa4CpKwfi3JC4igVEdY2QG8ko4olUTnjm9O6UtA2/1NQpLRRob1RtvwVGH4Fb6A47xJ5YBVdpC/G4rA4CaW1tfu93Qr+NcQhl7PcAgAwIEd8oKGUFJPB3FgPxPSok0zmMXuVkXd5kbe9UjDAs7EWb6gqNaZGmScs8nPUqc14RqGVzox7EZ4aGbS331knOpTO5kReWVpVuxJ5pkcJeake5/JlsJBEw2aG6NEOShxOvOGU6taTo6P5BZ5ZO3KO+cIQj2firhX7sLPlgR2POc7JFNIWqbcw3+y8oi8FDbVoF4AJrw+mNNWP91wlfDHAY4o8Y0qGEOMz96K7fYkRh6WoACw8iCZQv+Gmv+XVTnCT+AHn+qWU1O7WprxCDEDdeL6NAC7noG3KY9m+3niFluplbTzAyLp0raecMvoHoUJ8ngGDRqcCO6w1JbBl0OSx1Lrski/fo8vs3X09LtiCSHKX3LeFXf51iJyn4rV661/V/7Je9XrZJ9MhSBCcpLDMyZLE79k14pOO18dHBVNtmzWBYXvo0snrgGlNEn7DQGkHXJvGTzwdeTLZ7uqqo4ftvRVHw9Fj61TviERjxvxVUmG3AjX1FT6A/TbMDRh855lSNU+po+4Y/juqegkggtvVhCIDm6tQ2SVrnxgskJoe3NzJBRpEjoc1GgSV5Yg3jOpmJ6QOyF9SInU4kaN/x2WP
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(921020)(22082099003)(18002099003)(38070700021)(56012099006)(11063799006)(4143699003)(10067099003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lij61lSWolb4oXgd1RPHWtgzXlndLVlbT7jxVEdmc8gY+FCGLVLBF4jXkp41?=
 =?us-ascii?Q?v3wyqBpBII4eL7l9+jNw5mSYCk3MVABokmXOIYzkuBdC7dQnLcReGETmVa4b?=
 =?us-ascii?Q?77Dl1zkGtLvxyB/JepJEW91lNeSGjMEwLMXf0ee4L/Qr95zZ+nPFOpPDO/w4?=
 =?us-ascii?Q?DP3OpgXefjmfCSc/PoQGzcXokmsMcI8UmInt5yWqlglP/ZZKLauVjEbOfW58?=
 =?us-ascii?Q?t3u4HVnnI5LSAxvh6FCcEqCUBIue/p0tQ2xvthRihW126DwBDjVrNSINhabp?=
 =?us-ascii?Q?yMTlIvDUH7hfAwQ8xc9U1sW5LwW7WjhnL07niflnxRcOn958uiS2BlOhwnU6?=
 =?us-ascii?Q?OoLdo4vM2uXCD9JUvIyIDlnRPImPtLLZBjbZMWTNd8FOvZjc49lwd1q3YkAg?=
 =?us-ascii?Q?NPCWOrTzi/LnTH6fRNbuCr7fceWniYL5DrApOyJi+uBtH0aHaAorhhk3F3Lf?=
 =?us-ascii?Q?PGcZ86eAe8wrHN5XaLDLFj9UO/qfoHUvfe0hvJVKcTSbSea/EIRD2lWarVFM?=
 =?us-ascii?Q?c6fQNTR5qEcq4rVEqrL8V/tCKmqwnlM0To82L1WOvY9evllnA19Gg+HN2B74?=
 =?us-ascii?Q?RmVwa1reBo4OKclE9Q6Oup3r4HyYqMOg1vsQwBmxO3yt2GAWrkqx/uA8EqI8?=
 =?us-ascii?Q?/AW9+Hj3UwwmCF5C9AryGMoFiUXv4cFXOf2EbBGLfHAOTiu0hWgkNP6EY2fU?=
 =?us-ascii?Q?yN1ZAUmO1iFLUgtbVRJ13t8hTCD2gBnp7tnxqtFI4k2Tdjn9nSH+aTT8Ifdv?=
 =?us-ascii?Q?pdzzcaKzxr3PARnQWQd+P5hoU6twS3QKHZKka3lj4FUxy9uZ/kLrZga4uHTX?=
 =?us-ascii?Q?en9aZnvlcuI9+Ins5ggHJPIP0g8//26tncVNU8/zvX25x6JKmQa4AHWQir6L?=
 =?us-ascii?Q?1Jsi1/tIgEjsTbKzZY4ZT4ZqtDRuTvjuW9XkUsR0EwWwzQVmiHFun5i+wPqF?=
 =?us-ascii?Q?H1sB9CRfu7dzyMrJ432DN/v+ffTLF+Sn24IXcx2hdokDHZIgxfa7pziqMRLH?=
 =?us-ascii?Q?TBR//Z/H3h9tTrfcz4crLLSweYJ0yELhVnvSEVlviBoV3Ik6SJmMIO10KWYh?=
 =?us-ascii?Q?/iAm6RyUga5HI35w/zOLhLA6GgaI1Sc8pzea6oo+jfby4S3Ms3XWReoIaafk?=
 =?us-ascii?Q?mcBrsfxruQE8cN1i3kTk6gOGzeabLNAF+6WpVf9x5AR0MNe44WVjY7q2FAFb?=
 =?us-ascii?Q?yqosiYVMJaK2vchUqK1v8gRY5KAfsyVLV6pPZCATXdGGbObbjlcqeVjd8u3u?=
 =?us-ascii?Q?g9ffLVN4JYcooxGjJrxzcfXvB4OPfHJkdw1clbbxCKmfjlRKQx01ZcxuYDl5?=
 =?us-ascii?Q?Kfbgyrcbki2ZkWKb/tyEZ2hoOFMDVqbGbQgrIcOaa1+NbfIaG1vXcmNvuVOh?=
 =?us-ascii?Q?cISR1/BdRtRXxC2JdHO7rCdTE2/4tRWKmUgWGUCwmyGHaAtTCpH/nd4mmIfp?=
 =?us-ascii?Q?AIVRUbMnKu01pPNaP8HcIxdOCChTu8lZcsWOp/3L4qBVTdFDR0xmUAdt62mV?=
 =?us-ascii?Q?wwxFw2ASlH/eC0wyUhOPywlAUs6rAdBHxUpvJJeR4+lM1IghZbI8QU3mQ5+f?=
 =?us-ascii?Q?E9Ohm38ya1RPyfb1hfh3OhGwBbk5S/65GF0cFQ+K+0kDGiPAKE4a17aCyHy0?=
 =?us-ascii?Q?+d5uFyQJ6VAoVRW5HJBFhVIALFIpwtv6vy2x+x9uZzAXxRhRm0Y6Qc9Eq2sp?=
 =?us-ascii?Q?i8djK+Mh0rGHt1p9ne42CvVcEC2Co7mRl/wz3qZHmXgfErRbVCt4h+nfxmfg?=
 =?us-ascii?Q?WGApzGyZd+CpZpbPOI1DpX3dBnJW5qk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: egyQ6vaPceCsNT4D91yRekyLAhwrbofny6a7qiNTtmxQcqHxUFZWovbrskU7Qp5zWGbsyqJk8RBTobVEL58nP8J9WIR9+A1JBvxi6/N7J7jK4YAmJvr9CjaS/7YQhSrCIDtUkSBOry2JlmZIYA+2ZJILPfqGLknSYA2EkUWHsn4j/dR+aG7IeUC2tU+AO4mMxXRBslnW0Z5zK+INzFtiqr4U7cgfmK0LUaFbna+LVwTHP73PjXOo+8I+Fp+GFPZx9Rn82y/MJt8VqTA3G8soKbqy0hwHCXsfXf7HOscvrt2ppX/eTvSb0uednfaVty8JcchavytYIXByhmqLvEXWxw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88bba9c1-6483-4fb4-3fa5-08df0daa3223
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 13:07:54.6456 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nh5V2biya4QOZmDdhfqlToIPMK2azJiahgMyeWlMKbJUWDm/yXt4qO/p8eG+jIF7xktb7GTjMWanPn0KrJltcmjJ00ORBTHUJ8u6cvgTOBo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7658
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
> <hkallweit1@gmail.com>; Russell King <linux@armlinux.org.uk>; Raju
> Rangoju <Raju.Rangoju@amd.com>; Prashanth Kumar K R
> <PrashanthKumar.K.R@amd.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Jian Shen <shenjian15@huawei.com>;
> Jijie Shao <shaojijie@huawei.com>; David S. Miller
> <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
> Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; linux-
> kernel@vger.kernel.org; netdev@vger.kernel.org; intel-wired-
> lan@lists.osuosl.org; linux-usb@vger.kernel.org
> Cc: Yury Norov <ynorov@nvidia.com>; Yury Norov <yury.norov@gmail.com>;
> Rasmus Villemoes <linux@rasmusvillemoes.dk>; Andrew Morton
> <akpm@linux-foundation.org>
> Subject: [PATCH 7/9] net: phy: use linkmode operation return values in
> phy_device.c
>=20
> Use the return value of linkmode_and() where the resulting mask was
> previously scanned for emptiness. In phy_probe(), combine the AND and
> AND-NOT operations and use the return value of linkmode_and_andnot().
>=20
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
>  drivers/net/phy/phy_device.c | 14 ++++++--------
>  include/linux/linkmode.h     |  9 +++++++++
>  2 files changed, 15 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/net/phy/phy_device.c
> b/drivers/net/phy/phy_device.c index 94b2e85e00a3..3430605695c5 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -1565,8 +1565,7 @@ static int phy_sfp_module_insert(void *upstream,
> const struct sfp_eeprom_id *id)
>=20
>  	caps =3D sfp_get_module_caps(phydev->sfp_bus);
>=20
> -	linkmode_and(sfp_support, port->supported, caps->link_modes);
> -	if (linkmode_empty(sfp_support)) {
> +	if (!linkmode_and(sfp_support, port->supported, caps-
> >link_modes)) {
>  		dev_err(&phydev->mdio.dev, "incompatible SFP module
> inserted, no common linkmode\n");
>  		return -EINVAL;
>  	}
> @@ -3761,15 +3760,14 @@ static int phy_probe(struct device *dev)
>  	/* Some PHYs may advertise, by default, not support EEE modes.
> So,
>  	 * we need to clean them. In addition remove all disabled EEE
> modes.
>  	 */
> -	linkmode_and(phydev->advertising_eee, phydev->supported_eee,
> -		     phydev->advertising_eee);
> -	linkmode_andnot(phydev->advertising_eee, phydev-
> >advertising_eee,
> -			phydev->eee_disabled_modes);
> -
>  	/* There is no "enabled" flag. If PHY is advertising, assume it
> is
>  	 * kind of enabled.
>  	 */
> -	phydev->eee_cfg.eee_enabled =3D !linkmode_empty(phydev-
> >advertising_eee);
> +	phydev->eee_cfg.eee_enabled =3D
> +		linkmode_and_andnot(phydev->advertising_eee,
> +				    phydev->advertising_eee,
> +				    phydev->supported_eee,
> +				    phydev->eee_disabled_modes);
>=20
>  	/* Get master/slave strap overrides */
>  	of_set_phy_timing_role(phydev);
> diff --git a/include/linux/linkmode.h b/include/linux/linkmode.h index
> c08632c10c3d..49587a2e0f69 100644
> --- a/include/linux/linkmode.h
> +++ b/include/linux/linkmode.h
> @@ -26,6 +26,15 @@ static inline bool linkmode_and(unsigned long *dst,
> const unsigned long *a,
>  	return bitmap_and(dst, a, b, __ETHTOOL_LINK_MODE_MASK_NBITS);
> }
>=20
> +static inline bool linkmode_and_andnot(unsigned long *dst,
> +				       const unsigned long *a,
> +				       const unsigned long *b,
> +				       const unsigned long *c)
> +{
> +	return bitmap_and_andnot(dst, a, b, c,
> +				 __ETHTOOL_LINK_MODE_MASK_NBITS);
> +}
> +
>  static inline void linkmode_or(unsigned long *dst, const unsigned
> long *a,
>  				const unsigned long *b)
>  {
> --
> 2.53.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
