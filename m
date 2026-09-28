Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C2A7CA5FA2
	for <intel-wired-lan@archiver.kernel.org>; Mon, 28 Sep 2026 15:16:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5EBD880EDB;
	Mon, 28 Sep 2026 15:16:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HjxWTdXBj5M9; Mon, 28 Sep 2026 15:16:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6BA3380EFC
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790608579;
	b=NDUbFEIymUS048phkTfFqDhVn7kwmsaFljujnffob8GnB1018sitkE+wOzLI20aes0FF
	 zIhJk0OEh5EDdZUBh0Mi+s0eMesYAkBmtlfUvtCTHlAo7KAPMtR14wIqHGMxClO3fa3JR
	 pmyaTfqSskf6s05iNPPMBgOwcAYPomH0SwA5KY46WtBtYvOz2ZEepbkmXKx68kt9j0oHT
	 hPKBsx12eAzr9jdeOXseMx3HMBXCusrLtDXFzmsozxUs1bUSYHgtM+iOV5h2Hq+Rm0yRz
	 RX7zjgDk9lCwZKBJcb3GgzFcK6kWwlYgBUHHU/1sbNf3IqjdUSSdL6qTtUnPA79vlMw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790608579;
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
	bh=JTQBzEkZqklHu0ZSi1yLWyF7ujK0+x6GXhNReNZW0fw=;
	b=IZEQPjl0WU5LRM6szSZAYZ1B457FWuOBFpgRpVUyq0Cpm+by3CJ7jIFRYyeWI3pMe7RX
	 A1cixr8BXzDuSKJQdEpOcXI2Kerc8bgVaXg+dzxdm8qmsf9r6SEx/5O0hSMgMAW2wusOY
	 NwDVOWzMg3Z2c8HINF7jjklBkfYtnBgPZE7vJCfaxioKJa4C5bhsHS4zwzvY194N2kdN5
	 u/wuEs2G4PKJHs2qIfRKw1oYECzgOcM/vwOZAfEU2f/+8YyO+342fV5Uv8Of1BBHlFwAO
	 Aj0lADdcC4I04NGMqrMRP/TLTqTJd7btSV7jziHzeMlGqroYranl85OtXFeFF3Vv2pw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Iyyl3Dde;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790608579;
	bh=JTQBzEkZqklHu0ZSi1yLWyF7ujK0+x6GXhNReNZW0fw=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CfTV7K2MOCnGqLXG8RopGX4PshHCWvDEzCVJczOksCQ+A413N9+1OUtXVSWarEFzQ
	 A1Lq6uYEU0Uq+HoeylzuO+fy1X24NEZWCk+WyIW2nMno2ksjwA+zbWUPIAmMf7zkP7
	 LKLPk74I4mb96IHlR65sGZh3kpIJAWY1KpuTXGW6Y0QIfUShaTmFm/XxCv77aAoHMC
	 6Hb79tiV9NL0pFj5gnjrhIS2qXI79JiZjjeQjfSOfPknGYSYOjt0/yS+lDMJ8O1ePr
	 V+xRrKpt1mBf1e82rs0gF3FqiRunFfmJJCvodBoIEzQx586UL0TLQEFVCP+NFH6S9x
	 wEJBAkgdfiasw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6BA3380EFC;
	Mon, 28 Sep 2026 15:16:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A64AC3D8
 for <intel-wired-lan@lists.osuosl.org>; Mon, 28 Sep 2026 15:16:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 97DDB80F09
 for <intel-wired-lan@lists.osuosl.org>; Mon, 28 Sep 2026 15:16:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ysAmZFKnPDKA for <intel-wired-lan@lists.osuosl.org>;
 Mon, 28 Sep 2026 15:16:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 66EDD80EDB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.16
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790608577;
 b=frTks5kAOHjACUNNaw5ksgWcnijkKX4XDtvDsUNy6/ggNMvKQCVSx0IY3nyCR5IpOwk7
 SOrquUda/Nv06KwZ8e7rSM6FMnztc5N+C2sN3XukKlOwCEXn+1waX5SZpo/hSZ9QXNDqn
 wfjXAUTij9QS4TcK0JRm/vXUb4sy9YgO4Naizh5d3JtByFDAqD4rjvrHvBPH2sTIj10Tr
 TR3z8ADmerDlS4b+TlFBX5e1rHSiue82rYwHJqE2pe2Q8xqfApzjjQ7nSJor6DLufIiNN
 awb9jr0Q+1ZpnWv6Uoh9SXVqiYIKTDP+r2Hiuqsz1PvAzBHbcADF1T4Qbfs4t/2xMGQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790608577;
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
 bh=JTQBzEkZqklHu0ZSi1yLWyF7ujK0+x6GXhNReNZW0fw=;
 b=gETPPwoK28DPY6crSjge51/XSHYZ9vv7Y8CZWHM0r0SyEmSUvwAbvTWkdozrmW9YBvWE
 LnpOw/RZ8SGz7d8Qf4KSl5fdqBSYzG3EZJEiJr3aMjdfdwPeV5QtJmdaeq/4+EFMv9O9c
 3snA28NTxRXtF5dFBJ2fJwnzbFDNjCmy6+L8nnecZ8kMWV1OqgVIZ/jvh2XPD/KV0jQVQ
 p7F5U4X12okdCCMM0DENilO8DHXyGmHi0FOWJeJn20gPfoKyss+Q2qzYNR4DJ+UdoVziD
 9Wy117ZJY0oY/NSN3+UBbyg1+qhlEYUBaOQ4E4ep31FJoChW28y7v8b+jvagibupoag==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Iyyl3Dde; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.16
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.16;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Iyyl3Dde
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 66EDD80EDB
 for <intel-wired-lan@lists.osuosl.org>; Mon, 28 Sep 2026 15:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790608578; x=1822144578;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=6JxAISqXjtcZI00PwlbwH9U4tuMmoNocb3B18c5kVNU=;
 b=Iyyl3DdeHHaq7C7Xh9CXdQhBtVjVZl3FKxSGKpHXmQuVpCrs9QEOhMig
 ejZHvetSr1EiU5zOpxhxAgjiXj936Fg9CnTMuP0/CeLZd34C3yFBBY/q0
 xgKHcjiBPAxavpOpz4QpUOnN1/af1ooK8eL5vD6pRW65ikOUookjCZgKu
 Ej82YnlnWdeIow0n/D75mTY9H2DsQjGISXi6Y2KjyZMAlnoaDO/R2BbKh
 VM6tCygO+HDdQaE0RKQU7HapfRHEvBRn4vyCVv8i0Hfmd+6QX7VMU5pK8
 jzTIRS0X8ErWKgSdr1d8tr1X/V3isnhn+u3giKMt3w5LQxJdIN5STXvlY Q==;
X-CSE-ConnectionGUID: /oQXhNWJQyy/1UfhA9rIEQ==
X-CSE-MsgGUID: hyanD7XaQxOtjts7jBFtQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="90528100"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; d="scan'208";a="90528100"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2026 08:16:17 -0700
X-CSE-ConnectionGUID: ytJ4wWyWS32/a1rAxTfwGg==
X-CSE-MsgGUID: dChWqrxRS4mAsfhabOQY2Q==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2026 08:16:16 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 08:16:15 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 28 Sep 2026 08:16:15 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.43) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 08:16:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hnu+G+7twnCFkFjYxwd99xfNK0YyUpWz8bER+kqepIC9XJvIHZsUH3//Tk0Uk2oH9xtkSMPxF5HSSbyVPzEHX11UJZfnOBcZGFT5rZm3ynfGKFJo1i/UAK/hjlheCnr7EKyKPQ2SsGRFA+e9vKNfSNRhS88o3khLhPa7wUT0l4mXhixxYVxxrSnmLnRAh+XddM4n0YARA3E8ucVLSRdugAYyFU/RmUGpsy7uuibLDHV1AiCtC9h6M3Cqo6eCiOUwh6jvqhAgtigbuXjCh13t4femw+9uD7U3U+7SLErMziCnwaKGnEwIwWub4PwOMVfBLScNAL4w3z1DlFJehKNwkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JTQBzEkZqklHu0ZSi1yLWyF7ujK0+x6GXhNReNZW0fw=;
 b=gXxjFQNat+3V40s1befQ2RtnatJJ2f7kF0h1OpVPS7vWKE7I75/Rs2wfq7a5UdxSr6Dw8WIGKFhQG9PSZLuGEXE67LhrUcOPIJqIHFezIbG5VRIcOWusoEc07nocN3pgqIj63Gh1DFpRF0EHydRy22T7HswOH/9iPEc2YUfTDKtow1goKHtLNxYmVVONdzbCbJPEC2tENXAAcVwTnbzeUmIXqOduqoHlUy/Vv1JMHD9BGBiotaQmUlMRm0jtwzQ2GcOpuOLQ+ctrqeOCg3N2BaypFIGfhrdn0NgDhx/T2XsnNGO4sWL0nkcs+DS+N+Xp+/hboTsd5iQniEZt+ClCZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by CH3PR11MB8750.namprd11.prod.outlook.com (2603:10b6:610:1c7::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 15:16:12 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 15:16:12 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Linkui Xiao <xiaolinkui@126.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
 <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linkui Xiao
 <xiaolinkui@kylinos.cn>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH iwl-net v2 1/2] ice: detach the VF representor when
 ice_start_vfs() fails
Thread-Topic: [PATCH iwl-net v2 1/2] ice: detach the VF representor when
 ice_start_vfs() fails
Thread-Index: AQHdTxY0a14Aw96pW0+uUnXMOywRbLbkGleQ
Date: Mon, 28 Sep 2026 15:16:12 +0000
Message-ID: <IA3PR11MB898646A1C8CA657FBC6ACB9EE58D2@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260928065306.1514795-1-xiaolinkui@126.com>
In-Reply-To: <20260928065306.1514795-1-xiaolinkui@126.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|CH3PR11MB8750:EE_
x-ms-office365-filtering-correlation-id: 8e22b8c0-d809-4763-07af-08df1d736ec6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|7416014|1800799024|376014|366016|10067099003|11063799006|5023799004|921020|6133799003|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: SQ48Vkij00a+ZW9qfyRCdUNELBpHYRD0g52aGq7YNqJ/pwZsjf/yvL3ecp4szPi06JuSE/xYAJpnFb7DFZxEkdjIPEWPq9G/NTNbPdV5qsmRpAjV/T3aiK3JQxCnlieBWqrLu/IMIA9LiN81oOejkXWFiWxeD8+OVo46TzhOAF97A0E6sYvikUd42XIX+Achf/fZwsHWMsO6xbjK5l0OfNqNY5QGKEAriAaDwPG/OgBIzSJaqZ/weCepUGnVOtdtin6QZdJbh+fBq12HLD7mMwZZPzPf1+pgbdEhHgqXMeSjfM/vi8uamd7KAYSd2h5kGxsOxrfP8K/5/93dgibZcCwBmjNhEQeLNhLCcNMjvKpKFbAbw5uC5JFo9xuQPYUwP0RQoowYvb7jsfWniRKsDvEDZ4AoDVWippQIbH9EFnksHTmacoI639F5W1O4+JvP3h0xuWaPjV/y+z58dkafn0NUqB7oT4TYJ2XU7oZmvt0Xiui0NCVBrmjMenHlUaVPvysOznIAJDYGDD/ivpx/ibd+KvQJplgCEA/8n0yAYcQNSEUpld3b8Po6ST3WChyhFJh03+ch/iYGP7/iA26PjS8b64Q/Ny4UG+2/pLUJ6+Hl+YhlC+CMycLgqPPOFa+LJ/gLoPhLxlDs4jqeXpSLsbUP96FQlyC6FZ2bLIzIKbBulPOAZ++Hr4ojKEpMzpe2
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(1800799024)(376014)(366016)(10067099003)(11063799006)(5023799004)(921020)(6133799003)(56012099006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YdePcX7uXhnDT2Mpol9PCitwXJII+0/jmZy9bQbQoryNij1pr4hoL7eWBbRy?=
 =?us-ascii?Q?3o/PRcwGTZyPBkXDzXvxLuyr+wFABf8XVDJ8B/XqW0CXZalcUh68+84Ra+ix?=
 =?us-ascii?Q?rqxLlmE4L4IlBQpKTAFsDMOyMJyMLqdyXh8VUUFryxsqJUY4pp9MAIM6oEVJ?=
 =?us-ascii?Q?j6Ff04DI8nQg+HI9b334ckiE9hQ1XKxINNmmiPqYwsj0XELoQIOsz6g9JsMN?=
 =?us-ascii?Q?f3OTq/kJVzD+V0woItiBnUKpPJbINpJO7hD0O41RMn1ftVgHzlCRdDTSR7M7?=
 =?us-ascii?Q?7UMZkUUM7nb9MiYvVyzg6Tof0Mk+SYWiTez4UTGAVmMFQKB7LHFK6bYqkGUd?=
 =?us-ascii?Q?q9mIdT/jkSWQe73ZJN68aFwk4CoQKumeB1S/EJqBs2Kz/cCSMxwvTRYDa+HI?=
 =?us-ascii?Q?AsW3K8hfkzWjMQ9mnWrmF1LLc0beVprx0uMd8XTdoL/HcvjhUYvpPCxkxZnP?=
 =?us-ascii?Q?qdTFhwcNQJSqhH35HndgwCcngQxcCNFwgVLL5Os8VuivzH4z4hK5ZEVSUJ9A?=
 =?us-ascii?Q?+wMIMPVXI9htK0TQ3QdNPhHGC7pUlEbEFcuuRy61MHhgjpoxXa8p6WlcebuZ?=
 =?us-ascii?Q?bGC8btrQK88HeRQWTWVggqYQ1Rj4vKfxu3bGxO3yGIcEbOU3+tTZLibBsAva?=
 =?us-ascii?Q?8lQod/BJkt8DsupiYdIztz+wDRflbyUa4CSc1poNAxWkhiApiWcf4PyBfgA4?=
 =?us-ascii?Q?+zA4hqa/aPXWJBXrFCuROXRRcYEjGIDkN8leZ1D6NWEz/Kdwe3++pz48dksa?=
 =?us-ascii?Q?GJWBb+C6MO6XOTx6M2MIrZzC3E1u1m1E54xHpf1mdHN3D5uYuokTaaBjB0Ms?=
 =?us-ascii?Q?dfqhYjrLKng2Qf9GfCjJAGpD0hTNdOJ4TFR3xWDeSlMvVkBm0SOY6tCAtPvp?=
 =?us-ascii?Q?L0MxSQH8nKcFukAfG1f5rrhwWL1CTL/R5YLGndhtoIDmk6GCy1PzoDAcaQDJ?=
 =?us-ascii?Q?JOp9peyegE97fkVUWhA3Fbp6qRUdRPnhRkNPxoPREoWaoyjKamWBCeBFzta+?=
 =?us-ascii?Q?EXrhkNFiKQURudK5EZwjbzR/z//fIZs6hDOG9I8ustEJmM3G87/bLyx5gdYl?=
 =?us-ascii?Q?k+fKTgb19gkPb+8ftATpN2BMdo3uKvPm5gffLUpD41WiyhE5J8FCAcfg8PZY?=
 =?us-ascii?Q?Wm697itmFGfYkzNo3gZeEg9ZKFL6IupnO3X4SIZsAzsB5xikzlUpNMwuQcRB?=
 =?us-ascii?Q?tAsGAB6qrJqmyBqAb1bVahxkbFoxWwNT44HVSdGGKEO0F7W0Q7s0MdMHws4a?=
 =?us-ascii?Q?mqmmNiV2ksoX8HD8OtSYBUS7XiClYYDrINgSVpqAbyJgSd9q2KiebQSeMFvI?=
 =?us-ascii?Q?o6WsZy/u/d87LnEYQOCBJcQG6aLnnTgdxjyYuya8rYGnNhhlXEoBhUlht02J?=
 =?us-ascii?Q?PldeQN1q8AFgeQk1G0IGZjHJelqzmkbDrV5HzbnfRd7RL0IWpkFEbBvjRC+E?=
 =?us-ascii?Q?izCPNZk5kaeeEm7IrMy+1pyA/dsY1Hv+3vFbo19SvOVM/ilUqkKmSYZAHkpm?=
 =?us-ascii?Q?OoG/XcgNk3b9pfaAXrIUCjT56TqkfCK5Zma/g1AuY0PsaHRzsAxEVp/k8xTW?=
 =?us-ascii?Q?bZkuGS5mpR9eK3b91NqhQ2ZsDacYmwGPkvIjyZvFq96JgYzpUbZ6Z1B50Xkb?=
 =?us-ascii?Q?zrRINqnNuToXLXuDV47Vx+YBzXG/gP2BY+GofUQwPMutbdSKmmUOYONxcsSB?=
 =?us-ascii?Q?55bwMZmsrAeg+BfUxxXzA7nGQCU5GYqMe5vSgst0mpMV180u2ff0ze8PoIhF?=
 =?us-ascii?Q?/XAG9zaKKJpThi68q5IS+WRwOH8lno8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: P+ZU6EMMnvGpHhu63T1seGTmGi6JFdPdCdE9UMDZgPlt/cHM7EKPtlpIWSAhG1lxKdoZ6FX1F+bpqA2ryEfcHr71+TMkkqJvNsFQTAzCX2FpTq6LNomlVP/G08G0NwLEz5FalVTfrEuud0WjroGLgBVcRZCAlLfguvcoZElQRcRzVqpq/eCByX/cSD+unrowaqhVq/DbjQX1mUsZwMt+BP9xUYpMRIJCDNUZg78BpQBY2GHkOrkhsK4rR+QlRCl+PvE77C22jwE/qnTq2j4FO/y7VP5V1F268TEiqUxi8nh/zpg31WwvGo4Fg4tKvX9E4EkttyYFVKFHnewPRGQWoQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e22b8c0-d809-4763-07af-08df1d736ec6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 15:16:12.6199 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wP2AUS2DZzc/BU1DTRqv2fzv0+CRmDWqlCehfULkm1a1yKN7+pKuhrAYW1PebIp25Kp2bCnDyy85fJxknXNkroPGs8XY01dn6NVRG9ZvEYM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8750
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
> From: Linkui Xiao <xiaolinkui@126.com>
> Sent: Monday, September 28, 2026 8:53 AM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; Linkui Xiao <xiaolinkui@kylinos.cn>;
> stable@vger.kernel.org
> Subject: [PATCH iwl-net v2 1/2] ice: detach the VF representor when
> ice_start_vfs() fails
>=20
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
>=20
> ice_start_vfs() attaches every VF it brings up to the eswitch with
> ice_eswitch_attach_vf(), but the teardown path only undoes the queue
> mappings and the VF VSI. Nothing calls ice_eswitch_detach_vf() for the
> VFs that were attached before the failure, and the caller,
> ice_ena_vfs(), goes straight to ice_free_vf_entries(), which drops its
> reference to every VF.
>=20
> The port representors created for those VFs therefore outlive the
> failed VF creation:
>=20
>   - the representor netdev stays registered and its devlink port stays
>     registered too. That port is embedded in struct ice_vf, so it ends
>     up pointing into the memory that ice_sriov_free_vf() releases;
>=20
>   - repr->vf keeps pointing at the freed struct ice_vf, and repr-
> >src_vsi
>     at the VF VSI that ice_vf_vsi_release() tore down. The leftover
>     netdev is still visible to the user, so even a plain
>     "ip -s link show" of it reaches ice_repr_get_stats64(), which
> calls
>     repr->ops.ready() -> ice_check_vf_ready_for_cfg(repr->vf) and then
>     reads repr->src_vsi through ice_update_eth_stats();
>=20
>   - the virtchnl ops of that VF, which ice_repr_add_vf() replaced with
>     ice_virtchnl_set_repr_ops(), are never handed back to
>     ice_virtchnl_set_dflt_ops();
>=20
>   - pf->eswitch.reprs never becomes empty, so ice_eswitch_detach()
> never
>     calls ice_eswitch_disable_switchdev(). pf->eswitch.is_running
> stays
>     true, with the bridge offloads and the devlink rate topology still
>     up, and ice_eswitch_release_env() is skipped, so the uplink VSI is
>     left in the switchdev configuration that ice_eswitch_setup_env()
>     gave it.
>=20
> Detach the representor in the teardown loop the way ice_free_vfs()
> does, ahead of ice_vf_vsi_release(), because ice_repr_rem_vf() and
> ice_eswitch_release_repr() both need repr->src_vsi to still be valid.
> Every VF the teardown loop walks completed ice_eswitch_attach_vf()
> successfully, and ice_eswitch_detach_vf() already returns early for a
> VF without a representor, so no extra condition is needed.
>=20
> Hold vf->cfg_lock across the teardown of each VF as well, like
> ice_free_vfs() does. The VFs unwound here are the ones that already
> reached set_bit(ICE_VF_STATE_INIT), which is exactly what
> ice_check_vf_ready_for_cfg() checks, so a host administrator can still
> run "ip link set dev <pf> vf N ..." and a VF can still send a mailbox
> message while the loop walks them. Both paths take cfg_lock and then
> run ice_reset_vf(), which gets to ice_eswitch_update_repr() and writes
> through the representor that is being freed, or reach
> ice_vc_process_vf_msg() reading vf->virtchnl_ops while
> ice_virtchnl_set_dflt_ops() hands them back.
>=20
> Fixes: fff292b47ac1 ("ice: add VF representors one by one")
> Cc: stable@vger.kernel.org
> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
> ---
> v1:
> - Link: https://lore.kernel.org/netdev/20260921031616.3390259-1-
> xiaolinkui@126.com/
>=20
> Changes in v2:
> - Hold vf->cfg_lock across the teardown of each VF, the way
> ice_free_vfs()
>   does, so that a concurrent VF reconfiguration cannot walk through
> the
>   representor and the virtchnl ops that are being torn down.
>   (Sashiko AI review)
> - Patch 2/2 is new and returns the VF MSI-X window that the same
> failure path
>   reserves. That is a separate, pre-existing bug, so it is not folded
> in here.
>   (Sashiko AI review)
> - Not carrying over the Reviewed-by from Aleksandr Loktionov, as the
> code
>   changed after his review.
>=20
>  drivers/net/ethernet/intel/ice/ice_sriov.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c
> b/drivers/net/ethernet/intel/ice/ice_sriov.c
> index e04de0215596..95abc6704820 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
> @@ -508,8 +508,13 @@ static int ice_start_vfs(struct ice_pf *pf)
>  		if (it_cnt =3D=3D 0)
>  			break;
>=20
> +		mutex_lock(&vf->cfg_lock);
> +
> +		ice_eswitch_detach_vf(pf, vf);
>  		ice_dis_vf_mappings(vf);
>  		ice_vf_vsi_release(vf);
> +		mutex_unlock(&vf->cfg_lock);
> +
>  		it_cnt--;
>  	}
>=20
> --
> 2.25.1

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>


