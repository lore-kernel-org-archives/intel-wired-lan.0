Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32DA5C79F99
	for <intel-wired-lan@archiver.kernel.org>; Tue,  8 Sep 2026 13:05:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CB109403FC;
	Tue,  8 Sep 2026 13:05:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ErgMZcw5zElL; Tue,  8 Sep 2026 13:05:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 19D7440562
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788872709;
	b=jiqB1Chu5VrASSX4N57NhkQxzSuZqygakXtpfociuHTgr+OAXKrRXeYFNwhduJnvKaIz
	 mXmINl9f6UuqmG9qGEAaxKAo/4HTajsDBE0CkF46jBRglJ3zR6biHap63YIe6dedU5e9q
	 UxPn110shC+R1wDNFC7MIJTZlN4n7NK1Unb3kNvUJcXB6drPlvukag8243BA2gHE+Y/G9
	 q02x0KsEsTHOEABHraEPvcDmM6AzcRT7hBatVl7xtttIPBcpnLJnQYeYWgkz1oR1csLsQ
	 XAUErJIUIIXMBX3Qg2zUeTFGgrCEJU+drtWFG6LG8ljlV0uOkOiQ9gbPBSWkifHoI6w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788872709;
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
	bh=jCXPe3ZAKm+iItbhx2eR1LocMtAGEcDifNn2aVLipIk=;
	b=nHN5tNhYqTj7f6mzXPfKcGwpObKiDLLGsSL+bjbZm1eeT/DsxJEtXD0SZY0ReG4bY3UR
	 2aR3v8xScIAkv5y/5NKdBvqZ3Dh/kDrlk3+dX9/w0+baxPj2NYTOQX4yCe+j7u0fOxcDc
	 FEohdKFEeQzuWATxkn3yv6GLn+Wdf6zLfCxsAKwDcEiAVxUv6f8UnZJd18NlyTkIh87Aq
	 /fuaYWvwQEKi2prQuU7HzMqfGmvtaqn2NBGYiif/QuSRqisMQ8wbREwJR0Xl8uSU5Y99C
	 ikvn8y8ShMsG94cnbMUb6DuwqGNMLOoz0CBR2Bg9qBpgOs0ULRq5e7Qj/DcvRBPlxxA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788872709;
	bh=jCXPe3ZAKm+iItbhx2eR1LocMtAGEcDifNn2aVLipIk=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MN42VtcEXlFQtmREtw6OHbXKG2Pv0ia3fVLee8eZhTWHuILrXspBBuEBhlNCAK1Gs
	 Qi1CYWJBqvPA+dECCmcdi+5GpPO9wFbR/JDR7/j/P0tX26MVwF7pL1xbAGmTCdRdxK
	 hnBE7dyH44C2fZPYotN/aj+KbB6g/ThalgF6ZCYu6I593wauQ6Nk+ACNAAO5pyV7TV
	 FuL7SN3+C6jndIRgEPzbKtCp/a78BktbaghSeFG3Umtj5Yxjzup8L+jSCj2glvCbL1
	 LwPObrfBs8m0Tnncd9My71qkHKzH76jSOLqLC+yUzdn0hi3JEqDWuZ/QX+T0RTH9MK
	 mh9JXDesli5Jg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 19D7440562;
	Tue,  8 Sep 2026 13:05:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id ACAA7372
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 13:05:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9E1D840176
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 13:05:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rKcLa3U-4trc for <intel-wired-lan@lists.osuosl.org>;
 Tue,  8 Sep 2026 13:05:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 9A1B74016A
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.16
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788872706;
 b=CLBvIJGtPQ7sRxFaEF6AYmqeqSYK850VmTeSg6mdC+XKb97BenCDQjzNo2j//XRn8rxY
 AZJS9RJVIROSrqHI6Q6cOsdB/9DYfZyhOIqFOe8Azezi1NetrQ8VxSGzfG0ECbvYogtF2
 AUrBpAgPahsLnXJ3spwwpm4wHxOqTVUi8gmVmdiwXpk4NLEGTI/ec8RqSQUDVwDMm0Olj
 aytoYBuIumjdyNMRK4thaiZTCE1aJTldWVwJKIJtjhNbZ7+RVU++I1BSvRNxGq9PrSSsb
 JUWX4kOS9JPum35T2VzJXkhRCy8A/ajriIAm2nK/qirQfZBdSNPTz5jwo4y4ieA26NQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788872706;
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
 bh=jCXPe3ZAKm+iItbhx2eR1LocMtAGEcDifNn2aVLipIk=;
 b=FDGCCIbYaMrr69HiKphJHz/JxBeFLNxGqdmjl5zJ5VfsnXVYIaKOL5AS79RI6iux76q5
 GXnLzZK/n1sy6PQohB9L754dQ3PQ8VuKFV9q1KAODtXTMIV9NiMdSRs8i6sHxO1/PH3Co
 QPVh4rUA9vJSMo8gCpI/PkZtesntIZ7HLO0b/EINJQq8KUqoMcqatj/QXN/P+KflxBYXR
 AiarMXyoJyPjMRHpj15XwaocOoeB/jOvIb2x5W1DQTk22WR1tySO4GtVRQ9/y1tVcxoWq
 k1I2Wa6S4oTHyMK2b9Bc8Fyt0HY+BxUcmOZBMc182UjalhBLLK92ClgKNRuFt5zkOLA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=mfzNatPa; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.16
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.16;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=mfzNatPa
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9A1B74016A
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 13:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788872707; x=1820408707;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=eLplvVneBGdu2tdOkXSMaM534nOW+rxSy/uZ8ZcSM3g=;
 b=mfzNatPaLjsbRPjTykUcWt0frEajckgufgjol4vj434snlLobBkQGfJG
 BTiB+i+V95yVARQ1LRj2mehYeSa0P1R/NsCgJ8AuMjZVuW2n6CH7kGA9V
 rg6LErb2yQFT2FED3cOlUdo2ZQDZIZIk4m8/DCvc8VdOnIiq/SEtREgXH
 dmnqBUYiuKLVO7LaldEY/4Wj2ILNJzcHW4y0DjnErCCGhMbjroUSb6jRv
 8zJXOgS0FG78CsU0Fj2p5nVZmaAueqBtIYroalRVr7MYqnwaMRKwpZxe6
 Y/DRqWL+5JndhUaxB1tAqp1viiqla7F0phIIoKUDMx7p/QDOgt3oaPm4C w==;
X-CSE-ConnectionGUID: 9rmpCZQoQx+NO3l6Uqlt8Q==
X-CSE-MsgGUID: D5gvdpCgRo+0wRmWIh9ewA==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="89477269"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="89477269"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 06:05:06 -0700
X-CSE-ConnectionGUID: lR+dkYpBQNy2ATiPAe6vmA==
X-CSE-MsgGUID: cpM16zqyS0KgXtGB7+iDTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="268419728"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 06:05:05 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 06:05:04 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 8 Sep 2026 06:05:04 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.34)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 06:05:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZjfO4oklZdRw8HtEVi95rhN5YaRzfj+1NNfjlb+1ragqH+PxoNcaap3XlJLLAKL+FczhX4hj6Dr7BM/ss0dbv/D6mzu/ROT4q9sj0cKojyMdGwN37fA2E//cHuC6PdWkIEqpnAESCgFuFurYX9/WKg+rlMd/Zgv9+ZmZDVn2ncBvzloAP0ZFKz8k8xIc6MNZYUcgW7+hRIy/w0uo2sjEG7MTNhbkypuCsuSIOBVgmVIYMsd/8Qai194ufkU7YjOxUWvD0Sdo1OB2+0sO69MX307ovjFK1dhkgP4scFAG9T/1ODagEL9Sw+5BQN7NxW4soN61604XXXqE7xTQfUrNUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jCXPe3ZAKm+iItbhx2eR1LocMtAGEcDifNn2aVLipIk=;
 b=eItXO4tyTnUqG2Z9y9awgDSBnWzDA5vKEF5k0EsJZFCD1QUkJfvlE3+E31uO58y1urVtBeg19NJDBeGsdO862XD0ueVWJo5sOpM0+GcX9ogkdsIi0WMV+cYVIxKKR/siMd61UPxFSHIY95RWii7YsbTmkeeaPpXyVsBdPEaVl4oKRWAH5uj1wD7OMK/RGSkbzUrTbLyIagLI7thYEqas+5BmkL+p06+HWPvBEn/p8KQ2n0ctgcV+zdsGH+nF+I2Lal95CbxKakWsB5ktX6HU9gGIyajE/+JwBvDDiMYowa9UTnI44B5raicY9fCerTz+Bxkmc8+zDNxrGBBWEt2L+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by PH0PR11MB7658.namprd11.prod.outlook.com (2603:10b6:510:28d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 13:04:58 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 13:04:58 +0000
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
Subject: RE: [PATCH 3/9] net: amd: xgbe: use linkmode_and() return value in
 xgbe_set_link_ksettings()
Thread-Topic: [PATCH 3/9] net: amd: xgbe: use linkmode_and() return value in
 xgbe_set_link_ksettings()
Thread-Index: AQHdPxOKAYokbZq9REOHwoM7/ccIcbbEpxFg
Date: Tue, 8 Sep 2026 13:04:58 +0000
Message-ID: <IA3PR11MB898628CADBB5FB0A020C271FE5B12@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260907215439.409858-1-ynorov@nvidia.com>
 <20260907215439.409858-4-ynorov@nvidia.com>
In-Reply-To: <20260907215439.409858-4-ynorov@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|PH0PR11MB7658:EE_
x-ms-office365-filtering-correlation-id: b6fc79e0-3f70-4b96-fc78-08df0da9c916
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|7416014|1800799024|921020|22082099003|18002099003|38070700021|56012099006|11063799006|4143699003|10067099003;
x-microsoft-antispam-message-info: zOPKG7NlqVb9a8IhWrLmiypQOtMpxPGPA9RAh6RH0UMgQO0YI+4tQyz5ui2IANno0UKfTR7c7KWwaweB9QZXMlWpTZOc8uA6lo0Z63AxTgtETGz0jz7Cj0TZ2KRkBfkbuUHS9hMoTiGnb0bc+T6tVqXmLc/IzJ1Jw1i7Oy+8wxLd8wH/eAD40zDCzzYFwr8xJi1MIBKAMIXoPi2kNB/MEFrP1jchp3xN3ygy69HpzOv3ujJlIr00vo7Rv035oQ8rD9SuoQdPaIFyIEzWegZwsVuudcv6Oo8lSu9i7s9EBu5DdKmvOWXAJbz0b/I3rkWFS6n3EJCNOnMrk7IPviTiccDZD+vaWmPO7IbikdczVabCyHcQ1RESIs3fQ4QcFrDFiv/a3hBujEReqEY5cHjx/56RZiGGb7oEyj/k7ySy67+esIPvBGC8uRhJMZkKBwf8AZrfUQQb4yYsgyESW2r4xY/yk2dS8pK7xXBHO7i1owDVyrKS+3/mkEHnmqpkkIUMqA0Wjt3cLGj61LHqpRtjql//1/1W6X3+2yjMIeWgVhU1B0mK99d/v+nfzO9EI9lW2J95yZDyJoNvYbGQ4ewdHpgnRaqX5gAOkX91l6uwb25FqyAq3W6LLnVQhdVjYdlA4t9hI87MxS3WXVSCxZSTDFGUV+C2wTLGBXmy0t+Njj1CnheoBskAuFeAHfgyhAUoToxqZjtz/cXJxIz06T6EA0+tJm9axMLzZWhRXksonZU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(921020)(22082099003)(18002099003)(38070700021)(56012099006)(11063799006)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?F5qibDitGdwEsStXqhSp+eYU1/wPHlZxoA9declvsuE1Ca2Y/UuTLUVxlIRf?=
 =?us-ascii?Q?/98o0G1COvGORtxUsJTrRU26sCFKThM2Y7S1wK0ot3OUKYiZ1dooO6bM/VLP?=
 =?us-ascii?Q?TArhSgazwq7uhwOZ+rJ6+yeZFh0Nav9UIzfutRn+LlFFfWrWrGYXNCAbTf0B?=
 =?us-ascii?Q?gsBbiWj3v4vGMMYJPoBaCjaB74MTlaP5olcBqBbaT4atU9A/Sbq9LFFWq+gA?=
 =?us-ascii?Q?YQsnH/U96VSZ1Sq0xe0gH1VaJ89akd5ruoMOA0rzC2BiLJdUXwMyABu7mNS5?=
 =?us-ascii?Q?fgDta+2l7+X+PJ82bO18mibhdt5uXM4ERtc4/dl8u4nzHqpUFngK0pCt2o7u?=
 =?us-ascii?Q?wNsF2y4nb16XgF02PUSWdRsWhu6fXArKlzoFiFU7+6VDYC/VMrZ9JlVkid7w?=
 =?us-ascii?Q?tismbz29pwB/hIVagQm8HAlu+Ff2STB31Ty9ZwiZO9Uqn17d+GtEe66KPFDE?=
 =?us-ascii?Q?wORMPnEpEdWlp0y+yk7iDS/ry7uBhgS5hL8m9KnX3gBeTC6LCMNBGq3J14vA?=
 =?us-ascii?Q?on6dhjjp+EW2B5dwuCzf5arndoeZYzV9NjqU0SakooR+z4tbOPWM1tfn79hU?=
 =?us-ascii?Q?nDRnyLQspVOX4CxZnHm5idXm0neuEpCO1s4jcR8I2LB7XCi1gbdu4JotFaUl?=
 =?us-ascii?Q?4WYBAXaFKnR/71eN0wPeUWCs7XjwjmbdlsvD6VaPvZ1WKUZWFRyGmK8BwPUc?=
 =?us-ascii?Q?01QFf12Nb/RKpBjY5EazVKCFIB0ezHW32mskKyLmOwUWP64KtQufdM95lJLi?=
 =?us-ascii?Q?St8l6fjscSC7ksfIXE2QKwaag64uZnRir2wYGbgZ96JsgINZXJmLkvU9TucX?=
 =?us-ascii?Q?pNkqRgEXaa3XmcOcS6Zx9hWudo0z1TuHTccQDnWXE5hE79GBuqY4YFNGFAVR?=
 =?us-ascii?Q?dN74O6+ZTXNLWCsfBFl1igeoCFSEnS9d9cJO5EH06dgaXmZUyLd1jOrguOcw?=
 =?us-ascii?Q?AdeFlJox78eNV0rsOW0Js8C3m6x+flMblOumg/nhdWhmfT3h9IyqfjGJxVe+?=
 =?us-ascii?Q?swuX2w0DvOTB1OTWb3Yf3AG5CD4prYl+K+zjY78lmoRz/52/6S3ZW1dsbA45?=
 =?us-ascii?Q?FbEf8qLjhr145ZIHRJ8oy7+j0CSHrisqE2SHIyYeq1ZIcSAG7jWjjHFAuVAj?=
 =?us-ascii?Q?r3p+2xnCfJp0OX0TP+qFnGFn6gHMUSjLSIjMbYwbPIvIPyy9cUBwVoZ0zz+d?=
 =?us-ascii?Q?I0QcSdkTgTgKEspPf91ufPsSQLYZxQTiXhfPsRBfaCvlPk7lQ7ixGsyF05VM?=
 =?us-ascii?Q?vIx6dYqFAEOaiks00ApLljHgrPuBmHw0ImuPBdCSknjEIaC/w9mG9+SEsq1K?=
 =?us-ascii?Q?g7TPzLFLCY6RhwTqGItmg/gUhvvdBQxequQGQ9AwLcW4T+tJrohMikMVn4G3?=
 =?us-ascii?Q?QtpNId3UTAa4u9SX1GvJO8I7hgt0YbAdt4bEi2EM4O9nWNz3/ppQwEhKXj2U?=
 =?us-ascii?Q?eqRs+cTgWQL/D085cVN9bAfipFNRmUEwqTg5xeVpl37SuCxTtv5hM522AdnA?=
 =?us-ascii?Q?28DauA3oDMhCV9PmHyqzyLcL/RZpYtGMFwj1tMs993pTBkzxc5L88OHxaA87?=
 =?us-ascii?Q?/DE0b8Tcpg5C5oA4iqqIX6wlfjf0rmGCfTcy0mc1T66XZwk6N4gUXxt1BtdD?=
 =?us-ascii?Q?5nUWAIMUvXxqXcrfrLZxAVqKswJS7zAgg/6gc3z2Jki7cw6IgA+xSJLD3sJ1?=
 =?us-ascii?Q?7+xvfjArjNIhcu/hnBCXlv2oq6DTOFCaBEBNdP6p0WGFwJhOcPDqHA5lXl61?=
 =?us-ascii?Q?cx7Zd5V1O+Ir6O2a2Dygx5bepymw5/g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: cwz51ivmEVGdxPVDgv/RRd1DpwdWTv2x0mQLR9Jf0SeL9kQr8Mjb3f3wmRvcRxaqLbinDRm3qEYP3VPzWaIKtXyBa5/GlgTwVM3yRYsQNBcWbUEKt9zUkyktrkvNQtSu2qAfottXoRTXk4Uh4s94ahuCGCip3fm8AYxg6M/YDUwhLx1wAPILJv/CgPt1TlmeQEF/2kOYIcNy83o3fy4oUsDEiDJ85dD4tJlvknXA4WGOe2L39mBn1fnlaelmyTJzLkx5lb2ddGS398r1XHJDPQFvLEQ+9ImpWGd9x+lkDu7APYDRxeW77Y7vmY0j65dBcpjK//hRLQtukxzKOnjK+w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6fc79e0-3f70-4b96-fc78-08df0da9c916
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 13:04:58.3855 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TE+OF7LcvJk61cqQsJ2jwssw1iQRGSNGffBDNeUAa6u2Msq0Tptt3ZwCn9l2GUy4022bFMNeHGCMF5kotlfko9JLdU2IaAC36F1nZhmgoeU=
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
> Subject: [PATCH 3/9] net: amd: xgbe: use linkmode_and() return value
> in xgbe_set_link_ksettings()
>=20
> bitmap_empty() is O(N).
>=20
> Use the return value of linkmode_and() when validating the requested
> advertisement instead of scanning the result bitmap separately.
>=20
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
>  drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
> b/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
> index a9f4fcc4daae..113a10855938 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
> @@ -231,6 +231,7 @@ static int xgbe_set_link_ksettings(struct
> net_device *netdev,
>  	struct xgbe_prv_data *pdata =3D netdev_priv(netdev);
>  	struct ethtool_link_ksettings *lks =3D &pdata->phy.lks;
>  	__ETHTOOL_DECLARE_LINK_MODE_MASK(advertising);
> +	bool has_advertising;
>  	u32 speed;
>  	int ret;
>=20
> @@ -267,11 +268,11 @@ static int xgbe_set_link_ksettings(struct
> net_device *netdev,
>  		  __ETHTOOL_LINK_MODE_MASK_NBITS, cmd-
> >link_modes.advertising,
>  		  __ETHTOOL_LINK_MODE_MASK_NBITS, lks-
> >link_modes.supported);
>=20
> -	linkmode_and(advertising, cmd->link_modes.advertising,
> -		     lks->link_modes.supported);
> +	has_advertising =3D linkmode_and(advertising,
> +				       cmd->link_modes.advertising,
> +				       lks->link_modes.supported);
>=20
> -	if ((cmd->base.autoneg =3D=3D AUTONEG_ENABLE) &&
> -	    bitmap_empty(advertising, __ETHTOOL_LINK_MODE_MASK_NBITS))
> {
> +	if (!has_advertising && cmd->base.autoneg =3D=3D AUTONEG_ENABLE) {
>  		netdev_err(netdev,
>  			   "unsupported requested advertisement\n");
>  		return -EINVAL;
> --
> 2.53.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
