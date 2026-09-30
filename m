Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DFADCA5FAD
	for <intel-wired-lan@archiver.kernel.org>; Wed, 30 Sep 2026 01:16:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 128E560841;
	Wed, 30 Sep 2026 01:16:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2rvPa7MSKwPi; Wed, 30 Sep 2026 01:16:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 69D4D6082E
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790730992;
	b=eriuesq+s0sa0MstORcKxzDzregqBemWSsotHu/e+AJZFKtdrN81uTp6ACga4SY17y1b
	 BsIpfFGqgwylA4C9+weS5BmYUyvriVPWVov/38HfgBXwh4VwaUEzo+ljyC2EUAcowFkaP
	 +Oe49FdCtCUu3cjEWNDKVE25oGOGr/0SJPf/761/QNb8F/Sds62zZyRCEbuZJzkNrF+oC
	 S64IF5iAKXHNiiSqMnfxVTQYelytHCevtksOyjhqDRQnRb2tqpoLjwachnYkUXTrO74vz
	 5+mtaVVFEmXyGeI0ggvCyPjkZ69Y5HXOYB3sx72cBbz2Xg2eN1UyRijartz/o3CAGyA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790730992;
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
	bh=vuvdE/1hXLu2AT4PgcUw9sIxnGbHOYrMHHWPG6Kakoc=;
	b=BfYxqkdBoL7NKl0cQBGKg8yZgP8q2j5OGQsyikUhj93c9ZnKlIQruSYwyiC/yqX1BEAO
	 jrg4DG03geEHER1H/3F4Uv9dKcmTjw5s3Y23BoN65jcjALcGve+EBwTyOxS/mptWznhAs
	 xIFYJadgS5CEFdWTbEmvLeGP8+Yxz6Gqo78YDpShPTIQ0grjCs/yo3tJ2dvWV5yp+ON9E
	 IckqGULmTozRoF8H5G9bBzoMF7WPFUDfrckiNZy7Qgmw/4aK25+0XfiFrNnEbuffe1bwj
	 U0q2O/7KW5y6tYif/oEwCsvM8cRICDKPTHl97u/bTHkMGOPk6SJGs6o/8OQdNnIqygQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790730992;
	bh=vuvdE/1hXLu2AT4PgcUw9sIxnGbHOYrMHHWPG6Kakoc=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZZqDYJ9a1hFVpQfoJ9rYPak680ZBHRCak1iHzBTCyDoo9900fuNk06KkYBDhdkcsN
	 iQlWx2IwbUyrcDGgcTPvfDy7jmhg3CutTVk1kaMyNjCk4sUDukwXwG2hI/xDJAJrKt
	 DO+raHKkjm6EIbnbe9zPEkXbreyg8IYvDLgXirFBZO5fAyXiOXPCrgwmBUERf/CbGR
	 FLW/o17iDCad1H+lIrL4t9wiSJxw284OJ9ueVPnjXaY1os5Thn3wyJ+E0k1U2bJnEn
	 9w2iaeg7uScexwjebkIlcoqfQtC1beOvaF3Gp1ijZelKTh+9LIJhhpaZP7ecavO9C/
	 2CqNpk0KXcpbw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 69D4D6082E;
	Wed, 30 Sep 2026 01:16:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id F15AB24E
 for <intel-wired-lan@lists.osuosl.org>; Wed, 30 Sep 2026 01:16:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E3739400AE
 for <intel-wired-lan@lists.osuosl.org>; Wed, 30 Sep 2026 01:16:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v28OcaQDoEPO for <intel-wired-lan@lists.osuosl.org>;
 Wed, 30 Sep 2026 01:16:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org D8C6940098
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790730990;
 b=bcTJEyyJtp8PAQCtzXp8roY+uG5yxFd2caWzxu1uUnCZpSl1r+3fQfpNvZFaoIDZSoQD
 Bac/0G0E7kPf9eG5EFuEY+TLAKMb1cPBuX3/6HcBEAepEjXWzfwTktG79IzM+s9dEQ4L7
 hzgO952yafkyx/nM/OG0w8dh4RRIuhdwCyWLsljqBZkH1DZI/OB0dMUHlS5rfdt31551d
 wWb8x+wKE6ctBsfAK4fDXTpwlQ2LIE8/GDWv+PA6hY5ndk9peyNnCN4OL1l1tpPmb5n9c
 xnQltPwAfKtlhOjXppiSZTk1tXJDNf0Bcz6JlpmsASnv2J5NNOeLySblmOIabAbXOaw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790730990;
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
 bh=vuvdE/1hXLu2AT4PgcUw9sIxnGbHOYrMHHWPG6Kakoc=;
 b=fktJIncvs650YgkXJG7S/zJI8nathJfgYyuCKuGxm6UFbSqxUyz8eoi++lwEwAG5XO5h
 ngWMYZOz/QFvb9LsJFm+nQssMIGD4iyB8sUCnJWnI7dGlmdHdZUtDzLZfzhM9X12tNRie
 7urXY491jzF/Hqu+XJTXXUbwDhuoJwr621D78wYMHlUjRtqoh05wJg/nFBB4jYK6NVnGP
 YKXgZTiBrwIJBCFwDVGqtha9tC4LPnKN9VopTrn7fm+uoAcPbZF8wwuEFb2T7B+M6mTCG
 EQw4xjs4pIEgJOA8++qMWDFsMbJXDcP57yq7gXsGUXL18KSTkbI7hsNe9up44eVxYvQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=DUaKmXTd; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.15
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.15;
 helo=mgamail.intel.com; envelope-from=alexander.nowlin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=DUaKmXTd
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D8C6940098
 for <intel-wired-lan@lists.osuosl.org>; Wed, 30 Sep 2026 01:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790730990; x=1822266990;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=bklFkuzOIET+CNVd6mqqtrw0BeD496uAaEkZk+Nezlo=;
 b=DUaKmXTdqoSCU5p2NSLrjLcWrEqrrv+cyh0mHM82nHKQRsuiT4PD+wC7
 mVEZPQ/vnalmqhFVFpRLJRgsPigeK4ANKfmsl8BP/YqJF7bir44cb42nH
 YUXxkxzAabdQq282Kbw8k6KgAwQmXU2Tlep28FeW+3i8o8yuuEIvXIJwo
 3abJaPn64K/IPK6W/f9Po0sGQ0d4DCR5neK0fKwrFSGTxI3w4KeBDfj6y
 NO/8GNfav8eU3u1Uk5BLpSyCTZxBryl9yNN+A3vYVX23VjFQuv+PcZxn8
 7UQkf8G0hnc19Txm4AQ430y/sQyTbklVbs/1DfGDDPkFGPBQQv1u+8CJf A==;
X-CSE-ConnectionGUID: ej7QOQrpRi2/J2PKR/3NPg==
X-CSE-MsgGUID: kkhYBahaS6a5FxNi4dlVlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="94175757"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="94175757"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 18:16:29 -0700
X-CSE-ConnectionGUID: MkD+Wh/JQeqRwfQzKUXRYg==
X-CSE-MsgGUID: LoreFt5PSjmnZzpte8WN2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="274733226"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 18:16:29 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 18:16:28 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 29 Sep 2026 18:16:28 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.19) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 18:16:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mb3G8dV5iTY+d0a7d2Shou/uqnE3hTY7bO6dc9F8vn4PBzljGNfcZ1odGf0F3OQmVI0Nz5UJoEHUPTqDOXbzH0ll3JJKJ49Y3+FopFD9pnCoFV7n9JrKHEophPQpgnW9AV8ud+QGzm5qa/2xX18p+JXG7uwu57kc/TxwLpliMKwTmhjfKK/m60QaSqiuI/ATdAANTecbxa1CHq/VGsnibplFKiCihWq/rlQq0lmsRsDNRqS3DnrSpRUbLFVdNcZsmTePIju1BTblqRAptC1hDcniw4S1ijO5UftKyvP2vZwEGRkABibjISaUESAr3Cfkxc6/9acjFi5+gBqmS/tfEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vuvdE/1hXLu2AT4PgcUw9sIxnGbHOYrMHHWPG6Kakoc=;
 b=xucjDUfoYI1Ch4sXyieOfaSZtjB37aaV9z1TwMOGYOxZhJTbXv1O7Rx/0O1LtB43/ogShu/yhySnGbqAzeJZApZOQjlcRNkhKAdHXf4RPWQca6mw1r7li50Io3T7QK12t6qNrub6QFv5feEiH8yMH+ObreiIdeYq8DUQMyV4k5HNWA/PMYJ6+cm82q2eSWRQid8aXt4iNfxLtUZ9LcBlKaE5Own6ddNcfXIYHbpGsYLGao10ozdc4khJ8kl6tYzEotnWJzjrYM3vIHEnq3mNUDkteGP1dGfFVhkYxtYkCxn+dSG6STgjf1q7qxb6zCSa9OozQaC3TDoaOxalXYCCoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by DM4PR11MB5232.namprd11.prod.outlook.com (2603:10b6:5:38b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.25; Wed, 30 Sep
 2026 01:16:26 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 01:16:26 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "xuanqiang.luo@linux.dev" <xuanqiang.luo@linux.dev>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "horms@kernel.org" <horms@kernel.org>
CC: "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, "Nguyen, Anthony
 L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
 <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "richardcochran@gmail.com" <richardcochran@gmail.com>, "Kwapulinski, Piotr"
 <piotr.kwapulinski@intel.com>, "Kubalewski, Arkadiusz"
 <arkadiusz.kubalewski@intel.com>, "Loktionov, Aleksandr"
 <aleksandr.loktionov@intel.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v2 2/5] i40e: serialize
 timestamp configuration with PTP teardown
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v2 2/5] i40e: serialize
 timestamp configuration with PTP teardown
Thread-Index: AQHdJKcPD1ONr5tqskqBEuAQdZMBRrbmqTZQ
Date: Wed, 30 Sep 2026 01:16:26 +0000
Message-ID: <LV1PR11MB87902F76C5CD8AD36FE90073908B2@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260805065132.148625-1-xuanqiang.luo@linux.dev>
 <20260805065132.148625-3-xuanqiang.luo@linux.dev>
In-Reply-To: <20260805065132.148625-3-xuanqiang.luo@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|DM4PR11MB5232:EE_
x-ms-office365-filtering-correlation-id: 954af86e-c956-4e1e-f664-08df1e9072df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|23010399003|260925021311599003|260925022911599003|260925021911599003|10067099003|56012099006|11063799006|4143699003|6133799003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: d1MpTeU+nNTlyW4BFFDROCL7vFKp+b2/bdNXSV7++skIc3abCnbRcZ+NqNgFyx5Y46j2JXJ6Bc8hXHJSqBjcT9BTa22gkxNI0A+JVtQCkm5jAEihi5vK5b4fwj3uClosQGUPklms/cWu8+bt58bPHqYQllTLr5HHFvFUUe1nZpWKmnt18utc0R/qZNWao0Hg1LeKQz+9iEz7+2EONkAidul+q2+DXtkiQnUdB2Sl09g1TNEjj3xeq5oD8OESZxitmo9BV1kSmvF0u1vb9aAfi/lQU+BFbJvtj8shf3m5uT6Ctklhnn0RxNsa7llY7InJXWi7qP2KxF1rlVlOa1AtH1LjsHbNaDiZ4PCqktWTl/oXX5gSKqUgj8Qm6HUjcelaJEd1jbHivM4eBmLS/6Bxhuo6ZxgGS6qL+YyV9v8hVi1B9Lhwu4p0QpQlATaMstqeBVM+7SrLdb9qmvWav8+tr3j6oqzqIv6nTadzFBco1oDHMbpwlkJmkqG2IBLen9Xeb7XbBd2poTcF0M6NyvRLHwDMCgeXRdmJsuEj9vac+zM6h26klnI3J9TiOTHgBUwHgZyZDoP+uLofZ4w8jALBcEHCX2Sf8dyd52vGols/2ilPukQvdxNLhhYROO8k7owyLQKf6JLjI7uNrqBhrFwk1827ofmPJ6VBwCqJoznGBwNKnx1aZhjXoQCkkI9vjW3EazBtd0QTEhomUytFhALlUNF0JfHJj8Bx6w55vzSxmdo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV1PR11MB8790.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(260925021311599003)(260925022911599003)(260925021911599003)(10067099003)(56012099006)(11063799006)(4143699003)(6133799003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MnAyZYVwIO88IbwfuwK+EYaqySUKssLtmS3lMxSZaPUyYtsp3zLfkESrU3Cf?=
 =?us-ascii?Q?y4xG8n4qZAh9SUvs4dvM47gMbk2Tr1PsQKH3XJLxbMBrndUQvE5LjMT2aUiC?=
 =?us-ascii?Q?XZjkJ6ZYimegone/wwidOhE5MQ1NifKJAzXTMwVQLwPolyKvupDRAWgGsod0?=
 =?us-ascii?Q?s7aAoIlyrO+1SpDxP8C9qY+d1r+ofpd1YNyoqTFJeWUThMgpEm5FJOC3IyhP?=
 =?us-ascii?Q?fMTf59ba9rmWlY1sRTV7vvfGjsZDVHFyFQu4J1XcQP88EO7LwqsE0RHouaJC?=
 =?us-ascii?Q?2IwlxDwyzPb/GI1A/EDOdwXJppM8eqQUJ2wcV8kCUzNJ/FfEMTzRUQsFYd0+?=
 =?us-ascii?Q?qvWxFbkQOgRKRI3UDl+Uo0bHcAgNBwwOE8GcLM5S8llWUQLmtm/hHTkYCOwa?=
 =?us-ascii?Q?ffeiximNgUAIZbi97/1pVUGxhWAuSz+n6kEpIzO3ZlCCU67U90eMLmKaVtSn?=
 =?us-ascii?Q?B5yOxIoaXsmJAL3mOM2aFZtaDTRSTJjyJQCZZNoe3Gjh1Txq1fDNUPNgaX2C?=
 =?us-ascii?Q?RQ/zEbD+Idg5Js3vw3dZPLdwfMWY3qEZ/4ItrBYvtjlH5ADTzbRFQt/dEteJ?=
 =?us-ascii?Q?tdNEi07h2jn7ihZGlATH7op6VJkM8TwMWeB8ytw59VqWQ6Z4s646635GjGkV?=
 =?us-ascii?Q?YHsY6zsdeMTSsSnA5M+uGSnPcHh7+sV8gO2Qujm+Gj27Mbsc9w+x20ePbvVo?=
 =?us-ascii?Q?uXQxVs4dc21zukRxZNrBHnKBkGrAcNfA6U6l8d8/tXAVCebdkwKOME90zwOK?=
 =?us-ascii?Q?FhlFO3g2cH+S3S2N0cDMJsMWwu6yVlYXWn5fVyfPfoZjm5p+ypcRRRPOHUiG?=
 =?us-ascii?Q?V/jNnMEqxE5uChZADTf7h7RHQzBQWegxzRPFoIkWdn3fCUQKKMe6ZcUI0rLv?=
 =?us-ascii?Q?22Fv6EaCTIGmS2OxSdYB6BUa3ZumSgaYFSrE3kthexid+EjfAzG9wDj73cl6?=
 =?us-ascii?Q?3wqVo+u/DjWAB4Tqq6eOI11YrMvK31wFezv59BSq1e6aL77+WpNhFvo4pe/K?=
 =?us-ascii?Q?Bq5kD5OpG2SpFWIZHnT6Wzd4aVgiysdVhqjvSGQjdIHlA2HEOd6lxCRZ9bpg?=
 =?us-ascii?Q?m9BeRFHVsVgBQO46s3St1AMvoa4o/bnzH5OCSj3teDCdgY52KIwvDxaeDcTL?=
 =?us-ascii?Q?1Hok/yQUHj2CIAAY0VgUnmUBWZ1DWf35tHYjqnaiApUKvVKuknXqNbkc3o9i?=
 =?us-ascii?Q?o+7MSvFGxtRPZKMn1BCcTyNI8D2Cq+JrYjgtsAVWJYAWUq9p0FwrUPRc8Aaf?=
 =?us-ascii?Q?rx3YuY/XVWn0NLOJ1/A6C9p9vAuM8CZc9AB9x8bezIlj/yEu98zjufmqSEGQ?=
 =?us-ascii?Q?m1espTI71j20Fyp6HBANM8VbkyHz1nUM8WNVTJpTgdPjie1uHV/gWfKxWIx3?=
 =?us-ascii?Q?mq9ah4lHS+MZ2NVURXA+2bAdJIbYUTu4bmf65aZaoZqTkUNmf7Ut0QL3QPda?=
 =?us-ascii?Q?J9FBsmEfEmg33fef2uW7DNrcdjjmjb1+wWQ8q6BwM96N8s84+19UvA1+lC45?=
 =?us-ascii?Q?kwC0zCXcmLFA1MWLnx0RNgDQpOhMoVaNsX/H6F6U3oqFB7s42U+kQ/LhzAJf?=
 =?us-ascii?Q?FYfuIPDaSQB1Lxq3I/r0anOimks+tarxFb8hq3ctAGuETUQ96to3EwICHSuL?=
 =?us-ascii?Q?kAP1NVpGTeJ4jIrlI+CzuJl1QG9AvUDdw1Xr703iJap/R2Vh74yZxXjlBXxY?=
 =?us-ascii?Q?BapVfOcLQIKKLw84OsJsNKdRzpIwr+s6phWQuSzraIvYq6+S1s4Feye6L9Zk?=
 =?us-ascii?Q?ufDEtF2/cQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: nrRkPnaKm0cDz1gSBlWEM6xwh/WGdFznpbUYm5R/jEHn9SAb5RKsolp2frL/Lp0OGD1AJDNVpFnidqsT/KEmfK2v09T/35Dku5U812FDqPHEosyeN4snykK0uOuii8kAZr9DSD78vm80M4mhWZxebTl/eVV+ptKJDSYbQaNxHGffZOkHVNwM7PImNgAQzKK8FdgF2esCI942Y1jHbAsng4Bin9nHFpQhH/bOoTaAQUGPiScZ1XWSctMnZu3A/j7nIPUO5bUj3XUqGr5A2pk4iaM00N3CNo4kT9YC+m5PamfZOYWNsxNzrPfLTs66CGsTl3CV8LWor/D7BSdzFYim4Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 954af86e-c956-4e1e-f664-08df1e9072df
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 01:16:26.0735 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hfDNq0c7bRKvig24Ar+G6J9YkY6wKgU5apERPJq9dxO7aoZJchNBD8YNC8lKusd+uN4USn+1rIcaeclhZyfpGarkDyiSLmBjQO5J0AdIvDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5232
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
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of x=
uanqiang.luo@linux.dev
> Sent: Tuesday, August 4, 2026 11:51 PM
> To: intel-wired-lan@lists.osuosl.org; horms@kernel.org
> Cc: vadim.fedorenko@linux.dev; Nguyen, Anthony L <anthony.l.nguyen@intel.=
com>; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; andrew+netdev@lun=
n.ch; davem@davemloft.net; edumazet@google.com; kuba@kernel.org; pabeni@red=
hat.com; richardcochran@gmail.com; Kwapulinski, Piotr <piotr.kwapulinski@in=
tel.com>; Kubalewski, Arkadiusz <arkadiusz.kubalewski@intel.com>; Loktionov=
, Aleksandr <aleksandr.loktionov@intel.com>; netdev@vger.kernel.org; Xuanqi=
ang Luo <luoxuanqiang@kylinos.cn>
> Subject: [Intel-wired-lan] [PATCH iwl-net v2 2/5] i40e: serialize timesta=
mp configuration with PTP teardown
>=20
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>=20
> i40e_remove() can call i40e_ptp_stop() without the networking locks held.
> A concurrent hardware timestamp request can observe I40E_FLAG_PTP_ENA bef=
ore teardown clears it, then program PRTTSYN_CTL0 after teardown has disabl=
ed the event source. This can leave time sync interrupts enabled during dev=
ice removal.
>=20
> Add ptp_config_lock to serialize the enable check and register programmin=
g in i40e_ptp_hwtstamp_set() with the PTP state transition in i40e_ptp_stop=
(). Requests which observe PTP enabled finish programming before the state =
transition; later requests return -EOPNOTSUPP and cannot re-enable the inte=
rrupt.
>=20
> Fixes: 1050713026a0 ("i40e: add support for PTP external synchronization =
clock")
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h      |  2 ++
>  drivers/net/ethernet/intel/i40e/i40e_main.c |  1 +  drivers/net/ethernet=
/intel/i40e/i40e_ptp.c  | 17 +++++++++++++----
>  3 files changed, 16 insertions(+), 4 deletions(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
