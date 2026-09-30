Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12F18CA5FC5
	for <intel-wired-lan@archiver.kernel.org>; Wed, 30 Sep 2026 13:34:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A9D5260A4C;
	Wed, 30 Sep 2026 13:34:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AcemlT7cws8y; Wed, 30 Sep 2026 13:34:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D4223608A8
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790775265;
	b=gE3SIRC2CHHsVh+5pWq11OJL5FVxUitfKSw93y3FLbWpl20+p86Awi3AH5wznSU2t5zi
	 WhNpWiX3xyED3Fl4rJnNlfAnee0a6zizqFe3frWvN++ziLSwMqWa1C2pedYb6DDpKZjQE
	 2ZockaDLRInu//T/yhTX5vID9Mk3otpnF4RpyeLMCqBjcxS+MaVqiRHjdYH41AiQJE1xt
	 o5Yx0Je+i+ced/slsMRg3JHaNmucadoBsjeurTB1j12wZCirbzMi29SuDMCLXeIckYpiZ
	 Pym2DIRy5wSe/yqEQrSX68q9sITpkQrj3dLER8KdTL6zK+x9XcYJ00vKmjAyqMD6MbA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790775265;
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
	bh=PWeyBWU7v7V7rtu3Ifwc2x/SAdiZqtjKTxh7xnpaKnU=;
	b=l/J+ZSyMW4WQYP2KtyMNzIniafYvjDAApXXBIRIKX8P3zmmRFEogQo1ovMrzAoF/xoIU
	 aowzo3x7C2P0KbmUTtNPVUng+ZVPWi3aFquj+bw8N31z9RHrITk5oAfso8rXE3iIQUPXx
	 j2x+eK5YfhMadQAvbsrh6NyrPDN3peplHg9vUWiNgcfygLdGIcjNgB/m8TpLFPgWAUAoE
	 42Dpk+ebiu/G2ToLqt1f7BvacQDwoUqRuWvI7gejPMkI6Je3HhCCORGPn3resG6F8tnCa
	 eJEGT53orLADrQnn+tq43nVsaIcZc/nCQ/e78w0vIn7lbKfRW/x/ojuLxCO0UuOP8qQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790775265;
	bh=PWeyBWU7v7V7rtu3Ifwc2x/SAdiZqtjKTxh7xnpaKnU=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NSGvdJGC9bHuYskAD7IQ4+pQxj4xp6UAcJDmV9Hn/fBOzvoq7POc00nDPFzfAcqML
	 eMIyWScFmu8xb2uiNQyXSgBH5QiawYZphC/IK6ofdDthL3Wh+nJU7+GbgnSbsW195j
	 27bWEPCclyio8BMG552prg9Wo3GaOgnW0AhG02IwYZ40o/npz6H34X9tZx+fiUIHJb
	 qIoARryUNZxgLU0SYmZ32nDaNOYLJhD9LdfYqLVRizus3+tI4PNBlhL9TdHj8zXD5o
	 M4otvaqkN3BycFzYmSugGFhEv8Sm/7abIgQMYJCq55G6fXKccK9z0BUm4hX642vl9x
	 ApnVk3qehRMIw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D4223608A8;
	Wed, 30 Sep 2026 13:34:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5BCFD380
 for <intel-wired-lan@lists.osuosl.org>; Wed, 30 Sep 2026 13:34:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4C84D40508
 for <intel-wired-lan@lists.osuosl.org>; Wed, 30 Sep 2026 13:34:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E4DtpyYkiQLK for <intel-wired-lan@lists.osuosl.org>;
 Wed, 30 Sep 2026 13:34:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6D1E1404F6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790775262;
 b=MxZpoPFkkOYNpKdxFIQMBIbRR+t/uqhng4bp4ZbD+ghojS1p6bm5jIhwEtloyzVjqavP
 NcKxlXj5pIzqsfdTkl+ppVdnsqBHAgLZHQb6gA/mrXQpWm1vjsBBWI1Zl36kaV9bVIhEw
 VvStr3zksmOQYVkHhb53XGlm1nRTZGjUqWpPRQNtYRmTZFW7+QGsnZ4adWtMiZhQ45WKC
 /mWBXLuxH2tVjmUIUiwpl6jShFMUlkiGHD5w6V8Kc+xzSyqzQ39MBXO3GjVegSJ2NKogh
 /dZWAuzPU0aMs45WQLEfzUyazha1BBk7N1G36c5wC3LN3mlKgsmEaeYKjJzmC7GcvOA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790775262;
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
 bh=PWeyBWU7v7V7rtu3Ifwc2x/SAdiZqtjKTxh7xnpaKnU=;
 b=T4prdSVuEjjNPDv5sz94DSrT0ow+zRgnsJNwYUH5lnnV2KbN1+pH9baG+5l1ptp3K2Ls
 HJWyN1BU4zDwwge889n7fWWokfRoPCXO8CKqo/ocuiGe+pQW6EBqQOvUM+mK/rgWcydlV
 beUZfOd71tjFyA2d815AjBq6RqdfGhzJOsLj0imOOigxWCyhGNlYJ/s6RcjHIkJXTo+OF
 uOqTSS4QXq4sW+9ULrSfhTTuL4Ye5YLH5NaY44wMxNOYDTZVyV+pbrzsB2QcHYhqkKO5l
 ETU0Ll0Ys8Ra0Gr3qrgmjsbFzkYMpIU9ll3RqKKpDOJs2YMetl0/4v7aCkMFUuadUwA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=GHMFWrbf; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.15
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.15;
 helo=mgamail.intel.com; envelope-from=patryk.holda@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=GHMFWrbf
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6D1E1404F6
 for <intel-wired-lan@lists.osuosl.org>; Wed, 30 Sep 2026 13:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790775263; x=1822311263;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=nFoRjWavtmb4FYNShmCUwuZ4lKV8mF5Sv0xe6ULw3Ds=;
 b=GHMFWrbfb7uXqaAJI7TbZ/OjKmwVfBsaQbF7gDwYZmfXS9Y9L08MLH3S
 GYTdKPxieQgargoso2pEFz27WOWLFn55Wkw8Zcggcp9SwxAuSgKxmT734
 wt2TeSZKGrcpNqQwH4XAD/Fb5oZAEA4zt4fYh6d3zhkdh+5uiVmwe5DEu
 AlUHKjlKBnpqZRfpCOflOqIdX4TEfWfy/Cd7hbX07hV7bVCRtaBhjvtvp
 skboKraSf0vhm0LecruexuKIe8btyWD2B5T7BLa8OvIBRrLTka1CRMez5
 VWcjsWB4U3de1iDS/rOlhvBf49hyzjjjVME4IjJp+aDfofZwVwgADdlu4 g==;
X-CSE-ConnectionGUID: ai/XA4BCTn+r9s2lC5crNQ==
X-CSE-MsgGUID: Rf4S2D3ZSvmTwzAAL5RHYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="91610433"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; d="scan'208";a="91610433"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2026 06:34:21 -0700
X-CSE-ConnectionGUID: jzelRSdKRKWwIRaZ8sJJTQ==
X-CSE-MsgGUID: UWRIawXZT5ed/prVd+wIdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; d="scan'208";a="273492272"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2026 06:34:20 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 06:34:19 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 30 Sep 2026 06:34:19 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.23) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 30 Sep 2026 06:34:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n3KgMD0ssqdKxyYVLXvt92rymbXtRKRCj0knflIFvjIkOwF3qcnizdw9xqL3k50CrVII09sFTeT6w1CcE2UAu69F/dlRwqhBYbhQhh/U/DvwPMqy7hf3TqJ1nbUS+fLX6PDRk3ukTJJ62QMK4CapGRvpAul9VJyEYeqIuX1/n9keC89SCuY0klmWwhAs4xwW6S9Kqtqge60IRnbAD31F21K7x2snUqLNiM3HE6gtvepHFU/ydXaP4wXbu6DdfhAcd9CVyPP4gBV2mbVUwzNw4QhXnkSNUTvAlHDDW8lRFKUW4vdzyox2kU9OfuvSpUkm4X8aGMf1LTQ6pXEkA/KuIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PWeyBWU7v7V7rtu3Ifwc2x/SAdiZqtjKTxh7xnpaKnU=;
 b=o7m40I9WTA1cYWLFHcPK1apqKm+vr0Mq7iMdap1Uvg1dcV91Soys99afbAxyh4BXNabQkxOVx72Z0VtClhqIx7pmn5FnB1KIjoUyDROq4BPxceOStakrpFuylSteZo9TIT+ZHsjWJc2blDeG+nj6TlHzytdsicQmKLTESlqBnOZiEWluEyR4Mt/Vh6iZvBMFsS32U0anKWKAht8fyE9V424+1Acs9WXAJxeDixQCD6FMj1TUG2F0+n8jDRd6dgmVBm95/d92qs7dZIB0Hx4X69iZRHeT3ZSY2Oj0DAztuTYzB2IQOWcLOEI/ApHE6OFxyoEEtw1hTM51GMIIDGrSyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9301.namprd11.prod.outlook.com (2603:10b6:208:573::20)
 by SA2PR11MB5018.namprd11.prod.outlook.com (2603:10b6:806:11a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 13:34:07 +0000
Received: from IA3PR11MB9301.namprd11.prod.outlook.com
 ([fe80::714b:7d3e:aa0:104c]) by IA3PR11MB9301.namprd11.prod.outlook.com
 ([fe80::714b:7d3e:aa0:104c%5]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 13:34:07 +0000
From: "Holda, Patryk" <patryk.holda@intel.com>
To: Chenguang Zhao <chenguang.zhao@linux.dev>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
 <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "kerneljasonxing@gmail.com" <kerneljasonxing@gmail.com>, Chenguang Zhao
 <zhaochenguang@kylinos.cn>, Mohsin Bashir <hmohsin@meta.com>, "Loktionov,
 Aleksandr" <aleksandr.loktionov@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH net-next v4] i40e: xsk: use
 xdp_build_skb_from_zc() for XDP_PASS
Thread-Topic: [Intel-wired-lan] [PATCH net-next v4] i40e: xsk: use
 xdp_build_skb_from_zc() for XDP_PASS
Thread-Index: AQHdIykNFPsZlxO0Z0K5sZrc5BrK4Lbnelpw
Date: Wed, 30 Sep 2026 13:34:06 +0000
Message-ID: <IA3PR11MB93016E5AA9C2716B99927BC58A8B2@IA3PR11MB9301.namprd11.prod.outlook.com>
References: <20260803091750.1084506-1-chenguang.zhao@linux.dev>
In-Reply-To: <20260803091750.1084506-1-chenguang.zhao@linux.dev>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9301:EE_|SA2PR11MB5018:EE_
x-ms-office365-filtering-correlation-id: de9e3144-2c53-4017-f534-08df1ef78067
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|376014|1800799024|10067099003|56012099006|3023799007|6133799003|22082099003|18002099003|11063799006|38070700021|921020;
x-microsoft-antispam-message-info: oIWWf83T9X1f9p6lkCri8Bpu5R2TvMR4qEpRGwYASRaQanZcbdhLzQq9nv/m9KP9VDqeV6WKifCvxH9ugDehLkpIbo3JmN8rvEg17QZdSHCYtC59D8+r7a34G6dTCA0sxD086w1DioMAYJQ3eZXMjCWk8Tf6bWqM8XeZWuD8+9usreZl4tZi2ASeBGnL39X23Ph2Fix6p/JLx/6F8dYSJFWui3S1Lr1vOfKcRpt6DM3j+YK1/Bdbdh2XBeBQjlk/OwtE5ucFbeXGQ5vlVUAkKnqn50IJwvQcdbLN91z6UgsPtnGZ5IPPSm9oxKiyK3JBQnast5IJ4dm4wFv5zO2cRzd2z4vM4B7Yj3U6yV3iqwh3kcG40C7ZGoLJ3VINSFxhpS6rRJ09j0BRLdDT0SOzWRKmmFTJDBHg5CO2bsAJEmtfiMiX5MOKuuCU1ToZvsfbpPQ/61sqoaPljukycMjcAbQYtdbhR71k2pBDS73h2iIfeDWBHHs6xUapUr9W2/TRL3opDJwCaeXH1haH45AdNWjJuQcI2soPYW5Pu4BSMfWkTpO9yndhjaqwwMaZ4hS0v01cCkrT/aenh87qF3GzsXcQd6WSwlGPdp7AFbzalJPBC7Lu2kVl7TeADEXU2Wn6CY+ArA3p4t0+K8oZjnrqd6+FncATcy5v8fwU1flVglYQIzj/wEqxGnpO4qtWzANR+NSLYTxuUY/YQs6hKXs1FE7ziZxyCb0/krof54UGa4k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9301.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(10067099003)(56012099006)(3023799007)(6133799003)(22082099003)(18002099003)(11063799006)(38070700021)(921020);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?fIywnOA3CswWg+poGXX7tnkLkBaToGE7kCAG24gyKmwiCWT6Jgq1JgCvpH?=
 =?iso-8859-1?Q?B44+HotkoJi03YuDRMTPzv0SZ/IimOY91H/yI/S5E+Fp1aPEIKbh5Xgkuy?=
 =?iso-8859-1?Q?SutjwCeAuZ16RuO2R1Qg4p0IFB5g8EcxKNAu46M2C1HDPG6dC/lSoqI67a?=
 =?iso-8859-1?Q?ii3VNTim74DWIbEDatXtM/nkzFMM/usE1T2lfM6X4qVzY1K4l3ZhpTqX/8?=
 =?iso-8859-1?Q?pqd6OuWaKMw1WKWkTl0i9Dmje7hL6eqUEr5vxR6bX6GvyXw2As6UADySS5?=
 =?iso-8859-1?Q?fm1lcriXQBrdKQq9qsk3HYFnpejx+F2rl5q0/X56IZu4y7X/dY+JT1LW8M?=
 =?iso-8859-1?Q?RnA7a4LLjNiItNAQ9jmCmHWRXKrZTE+bN7EbwiLD4BKx4omMz2mwy5Gflt?=
 =?iso-8859-1?Q?N2ykh7QXMaoBBr/IJPcxyN4tGtWe5Ey+/1Xx0MdGC+aXO0O8ZxiB4JmN4X?=
 =?iso-8859-1?Q?CvYnzLKUYIRvfHxlILunrBEZcM3+sEXuxfHeWlCnZYtc0Dkha53eBHW9f1?=
 =?iso-8859-1?Q?+sbKsVqWKXEg/i8Q6GXQ7G5kvD/+0B+E4+uem7Bvb7AwQmm0kbjX5C8lVl?=
 =?iso-8859-1?Q?l7TKieJO90nk31WBIcG0+KC/o9SNSsi8n6VEibRVjaj+CpvKcK0MLBMwJ8?=
 =?iso-8859-1?Q?QbbEf4CY+HbV06ffX5Efvn5EJOi265HLAwtnX/GoV+LtWSIr2Cj4QKU4je?=
 =?iso-8859-1?Q?VPBPJkEl10SKzoT23QJMJIux0EyX2558eo9ae3IxaISb7epXn1hhSsNSRl?=
 =?iso-8859-1?Q?4ML0Di+m0p+UFthhMayJ0zrmkmTx7jkYz5YYygB8HmbizTGyQZn6h/79Xf?=
 =?iso-8859-1?Q?NlC6ZVF3ipALRw2d8T0CT06WDA5LWNbI8kgXtU9z1s2h2KGcjC+kUPInHi?=
 =?iso-8859-1?Q?a3v/MnZdDFsuHS0N4SWk1xgMPAJc/eHFf8+QVMYw34bbND9CJrdknBX42P?=
 =?iso-8859-1?Q?xaTCvWDcH4fDBzXLY4lPaKNphVeIOmk29WSpJMO6v5M9e1Sev9ZQhUjUkT?=
 =?iso-8859-1?Q?+fKNGH8c/aPz4H2woWnTTL6vjQMzRtRB4Nd804jYcR+0RScsbO69Xrih9Z?=
 =?iso-8859-1?Q?WR0nWxoFrgubsC+n/W2ZRygwncvrZSDdh4WP8qVKZgGa/Eo2lpMbIsHQM6?=
 =?iso-8859-1?Q?t1h2HE85zIWyty3aBTA5GpSdqfHAKS/CtYLCaJolCL5C3ihp/wFskP/LIx?=
 =?iso-8859-1?Q?YzjoqQKXqwKz3mo3LIInVTA7xsnqIYOuebkpPXXJv7zTz2Y+XrFKD2nLpS?=
 =?iso-8859-1?Q?gfMUM8rP4vcOPjECBBVfBxz05gns9O6s7HHztBwQ25ESb7NP0V5PMRrfgw?=
 =?iso-8859-1?Q?XBeDCuCyx4RKshC142ZjUKA3TMJ33mo7k6kj6H/28tSqQ8LaIVrcc+Ir2k?=
 =?iso-8859-1?Q?yOH8dirGRop47/lx5N0j4GnCJNbtHyo914ykqJPN4bOHevLjQEJGahJxs3?=
 =?iso-8859-1?Q?i27D9B21joIPn9KoGjNJrnvrFZgccmt5tjQMmc66JBIJnxONLY6bLC9IsU?=
 =?iso-8859-1?Q?eBib0vssX7YsL6+/xlBC95BkyyWZGTDnkcTelcNL5HMQXYJiF4DOZM4ziv?=
 =?iso-8859-1?Q?8jxoXWXiWgcnb1Z4wylLbS08NKYivQvvGvwoilPYsymws88rpokpFN2Brs?=
 =?iso-8859-1?Q?z7EACWrmnXbb6rX5I+JCV6Np2OxDdeg/jUyVlBHdNvUKeF53AhehPLu8Sw?=
 =?iso-8859-1?Q?0kHXk4KBE3foeZVtuDOPKU//fyrlwxdm6IPFd9y0XMN3OTCvPvNeMDHVsa?=
 =?iso-8859-1?Q?UychAINwV3xZh69QXb0kM0ROcNKhZN+hMXnPPdBf2hO0CHhNYrOHVV7vzD?=
 =?iso-8859-1?Q?8Sqbk6NvBw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: LdCwDZI3CJjBO1LpnVCC3pvtf1KF887132n04zBBm7Fe/pRuvmNgE1e4aT9fvSfhk6vR7j/Jv+S2fTJZZRABThEexNgle6SJCRxLSsNzRM51A1JYBhmUbvyt3yzJwsJqqg6Y4e11xD8X4p5skdyUZnDjMxbolhgU9H3eIxhG28ry6xuvgKUSxm03ZxSFl67ic62tgkaPBfXyaNj5lSCItSVmSkDYLB5iqDJG1ftbow38MFnNWTPWizeekk/Kl7pUgf7BE+di5F0i6B89V2fPiAdPaHSW5hqcdMMOoxIBw8bLuAd7YrNvHXv/Ee728PlDIermdDwf7plzFlGRN+U0gQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9301.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de9e3144-2c53-4017-f534-08df1ef78067
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 13:34:06.9418 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mpHB1lJ9M3GI04S5bjLZM8/GUh/6uhAjfJ2iGuZ1p8GWScZdaBW8ZCl440vgRO1ooyMQNbvi5jiTEbawTxVUHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5018
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
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Chenguang Zhao
> Sent: Monday, August 3, 2026 11:18 AM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org;
> chenguang.zhao@linux.dev; kerneljasonxing@gmail.com; Chenguang Zhao
> <zhaochenguang@kylinos.cn>; Mohsin Bashir <hmohsin@meta.com>;
> Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Subject: [Intel-wired-lan] [PATCH net-next v4] i40e: xsk: use
> xdp_build_skb_from_zc() for XDP_PASS
> Importance: High
>=20
> From: Chenguang Zhao <zhaochenguang@kylinos.cn>
>=20
> Replace the driver-local i40e_construct_skb_zc() with the common helper
> xdp_build_skb_from_zc(). On failure, free the xdp buff in the caller.
>=20
> xdp_build_skb_from_zc() already calls skb_record_rx_queue() and
> eth_type_trans(), so pull the remaining descriptor field setup into
> __i40e_process_skb_fields() and use that on the XDP_PASS path.
>=20
> Select PAGE_POOL in Kconfig, since xdp_build_skb_from_zc() returns NULL
> when page pool support is disabled.
>=20
> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
> Reviewed-by: Mohsin Bashir <hmohsin@meta.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
> ---
> v4:
> - As suggested by Mohsin:
>   Select PAGE_POOL in I40E Kconfig so xdp_build_skb_from_zc() cannot
>   return NULL due to CONFIG_PAGE_POOL=3Dn and drop XDP_PASS packets.
>=20
> v3:
>  - https://lore.kernel.org/all/20260731020736.170485-1-
> chenguang.zhao@linux.dev/
>=20
> v2:
>  - https://lore.kernel.org/all/20260729054916.720750-1-
> chenguang.zhao@linux.dev/
>=20
> v1:
>  - https://lore.kernel.org/all/20260724020125.246333-1-
> chenguang.zhao@linux.dev/
> ---
>  drivers/net/ethernet/intel/Kconfig            |  1 +
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 32 ++++++--
>  .../ethernet/intel/i40e/i40e_txrx_common.h    |  2 +
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c    | 79 ++-----------------
>  4 files changed, 34 insertions(+), 80 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/Kconfig
> b/drivers/net/ethernet/intel/Kconfig
> index 288fa8ce53af..75d1ad6e361d 100644
> --- a/drivers/net/ethernet/intel/Kconfig
> +++ b/drivers/net/ethernet/intel/Kconfig
> @@ -234,6 +234,7 @@ config I40E
>  	select LIBIE
>  	select LIBIE_ADMINQ
>  	select NET_DEVLINK
> +	select PAGE_POOL
>  	help
>  	  This driver supports Intel(R) Ethernet Controller XL710 Family of
>  	  devices.  For more information on how to identify your adapter, go
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> index ef5e657816f0..87553b14d34a 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> @@ -1833,17 +1833,17 @@ static inline void i40e_rx_hash(struct i40e_ring
> *ring,  }
>=20
>  /**
> - * i40e_process_skb_fields - Populate skb header fields from Rx descript=
or
> + * __i40e_process_skb_fields - Populate skb fields from Rx descriptor
>   * @rx_ring: rx descriptor ring packet is being transacted on
>   * @rx_desc: pointer to the EOP Rx descriptor
>   * @skb: pointer to current skb being populated
>   *
> - * This function checks the ring, descriptor, and packet information in
> - * order to populate the hash, checksum, VLAN, protocol, and
> - * other fields within the skb.
> + * Populate hash, checksum, PTP timestamp and VLAN from @rx_desc. Does
> + not
> + * call skb_record_rx_queue() or eth_type_trans(); callers that already
> + got
> + * those from xdp_build_skb_from_zc() should use this helper.
>   **/
> -void i40e_process_skb_fields(struct i40e_ring *rx_ring,
> -			     union i40e_rx_desc *rx_desc, struct sk_buff *skb)
> +void __i40e_process_skb_fields(struct i40e_ring *rx_ring,
> +			       union i40e_rx_desc *rx_desc, struct sk_buff *skb)
>  {
>  	u64 qword =3D le64_to_cpu(rx_desc->wb.qword1.status_error_len);
>  	u32 rx_status =3D FIELD_GET(I40E_RXD_QW1_STATUS_MASK, qword);
> @@ -1858,14 +1858,30 @@ void i40e_process_skb_fields(struct i40e_ring
> *rx_ring,
>=20
>  	i40e_rx_checksum(rx_ring->vsi, skb, rx_desc);
>=20
> -	skb_record_rx_queue(skb, rx_ring->queue_index);
> -
>  	if (qword & BIT(I40E_RX_DESC_STATUS_L2TAG1P_SHIFT)) {
>  		__le16 vlan_tag =3D rx_desc->wb.qword0.lo_dword.l2tag1;
>=20
>  		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q),
>  				       le16_to_cpu(vlan_tag));
>  	}
> +}
> +
> +/**
> + * i40e_process_skb_fields - Populate skb header fields from Rx
> +descriptor
> + * @rx_ring: rx descriptor ring packet is being transacted on
> + * @rx_desc: pointer to the EOP Rx descriptor
> + * @skb: pointer to current skb being populated
> + *
> + * This function checks the ring, descriptor, and packet information in
> + * order to populate the hash, checksum, VLAN, protocol, and
> + * other fields within the skb.
> + **/
> +void i40e_process_skb_fields(struct i40e_ring *rx_ring,
> +			     union i40e_rx_desc *rx_desc, struct sk_buff *skb) {
> +	__i40e_process_skb_fields(rx_ring, rx_desc, skb);
> +
> +	skb_record_rx_queue(skb, rx_ring->queue_index);
>=20
>  	/* modifies the skb - consumes the enet header */
>  	skb->protocol =3D eth_type_trans(skb, rx_ring->netdev); diff --git
> a/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h
> b/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h
> index e26807fd2123..3c52e0e60487 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h
> @@ -9,6 +9,8 @@
>  int i40e_xmit_xdp_tx_ring(struct xdp_buff *xdp, struct i40e_ring *xdp_ri=
ng);
> void i40e_clean_programming_status(struct i40e_ring *rx_ring, u64
> qword0_raw,
>  				   u64 qword1);
> +void __i40e_process_skb_fields(struct i40e_ring *rx_ring,
> +			       union i40e_rx_desc *rx_desc, struct sk_buff *skb);
>  void i40e_process_skb_fields(struct i40e_ring *rx_ring,
>  			     union i40e_rx_desc *rx_desc, struct sk_buff *skb);
> void i40e_xdp_ring_update_tail(struct i40e_ring *xdp_ring); diff --git
> a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> index 9f47388eaba5..dfa519c30a0d 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> @@ -3,6 +3,7 @@
>=20
>  #include <linux/bpf_trace.h>
>  #include <linux/unroll.h>
> +#include <net/xdp.h>
>  #include <net/xdp_sock_drv.h>
>  #include "i40e_txrx_common.h"
>  #include "i40e_xsk.h"
> @@ -277,70 +278,6 @@ bool i40e_alloc_rx_buffers_zc(struct i40e_ring
> *rx_ring, u16 count)
>  	return count =3D=3D nb_buffs;
>  }
>=20
> -/**
> - * i40e_construct_skb_zc - Create skbuff from zero-copy Rx buffer
> - * @rx_ring: Rx ring
> - * @xdp: xdp_buff
> - *
> - * This functions allocates a new skb from a zero-copy Rx buffer.
> - *
> - * Returns the skb, or NULL on failure.
> - **/
> -static struct sk_buff *i40e_construct_skb_zc(struct i40e_ring *rx_ring,
> -					     struct xdp_buff *xdp)
> -{
> -	unsigned int totalsize =3D xdp->data_end - xdp->data_meta;
> -	unsigned int metasize =3D xdp->data - xdp->data_meta;
> -	struct skb_shared_info *sinfo =3D NULL;
> -	struct sk_buff *skb;
> -	u32 nr_frags =3D 0;
> -
> -	if (unlikely(xdp_buff_has_frags(xdp))) {
> -		sinfo =3D xdp_get_shared_info_from_buff(xdp);
> -		nr_frags =3D sinfo->nr_frags;
> -	}
> -	net_prefetch(xdp->data_meta);
> -
> -	/* allocate a skb to store the frags */
> -	skb =3D napi_alloc_skb(&rx_ring->q_vector->napi, totalsize);
> -	if (unlikely(!skb))
> -		goto out;
> -
> -	memcpy(__skb_put(skb, totalsize), xdp->data_meta,
> -	       ALIGN(totalsize, sizeof(long)));
> -
> -	if (metasize) {
> -		skb_metadata_set(skb, metasize);
> -		__skb_pull(skb, metasize);
> -	}
> -
> -	if (likely(!xdp_buff_has_frags(xdp)))
> -		goto out;
> -
> -	for (int i =3D 0; i < nr_frags; i++) {
> -		struct skb_shared_info *skinfo =3D skb_shinfo(skb);
> -		skb_frag_t *frag =3D &sinfo->frags[i];
> -		struct page *page;
> -		void *addr;
> -
> -		page =3D dev_alloc_page();
> -		if (!page) {
> -			dev_kfree_skb(skb);
> -			return NULL;
> -		}
> -		addr =3D page_to_virt(page);
> -
> -		memcpy(addr, skb_frag_page(frag), skb_frag_size(frag));
> -
> -		__skb_fill_page_desc_noacc(skinfo, skinfo->nr_frags++,
> -					   addr, 0, skb_frag_size(frag));
> -	}
> -
> -out:
> -	xsk_buff_free(xdp);
> -	return skb;
> -}
> -
>  static void i40e_handle_xdp_result_zc(struct i40e_ring *rx_ring,
>  				      struct xdp_buff *xdp_buff,
>  				      union i40e_rx_desc *rx_desc,
> @@ -372,21 +309,19 @@ static void i40e_handle_xdp_result_zc(struct
> i40e_ring *rx_ring,
>  		 * BIT(I40E_RXD_QW1_ERROR_SHIFT). This is due to that
>  		 * SBP is *not* set in PRT_SBPVSI (default not set).
>  		 */
> -		skb =3D i40e_construct_skb_zc(rx_ring, xdp_buff);
> +		skb =3D xdp_build_skb_from_zc(xdp_buff);
>  		if (!skb) {
> +			xsk_buff_free(xdp_buff);
>  			rx_ring->rx_stats.alloc_buff_failed++;
>  			*rx_packets =3D 0;
>  			*rx_bytes =3D 0;
>  			return;
>  		}
>=20
> -		if (eth_skb_pad(skb)) {
> -			*rx_packets =3D 0;
> -			*rx_bytes =3D 0;
> -			return;
> -		}
> -
> -		i40e_process_skb_fields(rx_ring, rx_desc, skb);
> +		/* xdp_build_skb_from_zc() already ran eth_type_trans() and
> +		 * skb_record_rx_queue().
> +		 */
> +		__i40e_process_skb_fields(rx_ring, rx_desc, skb);
>  		napi_gro_receive(&rx_ring->q_vector->napi, skb);
>  		return;
>  	}
> --
> 2.25.1

Tested-by: Patryk Holda <patryk.holda@intel.com>=A0


