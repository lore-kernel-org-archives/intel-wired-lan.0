Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30975CA6007
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Oct 2026 15:36:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C513B812D5;
	Thu,  8 Oct 2026 15:36:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TSPHWeqK-t5l; Thu,  8 Oct 2026 15:36:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 22F9C8125D
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791473770;
	b=F7+mqyq9Ajnc4SiXGicD4MILOI5zDcM+Hbeisy80VtZDEKMYIUa/rwJOgY06A5JbFv+z
	 XRTTw0ey7r/7Ljej+hmPhmc4ZAl4NWphQFWP2GRXO80b7O2NrwROOCCuH7hbH3Vzbv/nh
	 55mI/QWDETFQrP9b9owCsky6yjwpv/B5r3hxc4hFWUNFp7OTnkoeVHUfFYd4WXR/yvWUd
	 5rpQdYPzhvQ5TScveDYyYM5DqO4GAo49igFHbeVFYa2cVxwrUfeVGBNbOXTYIe4ZowP8t
	 kaoZrmnT20a2m6cLXPPaaxG9fHdnECLwGKYy+m4ykPsasw+6iazCDTASva9+OFbyTQQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791473770;
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
	bh=BRPyGSdyIc3aJk6aM86/Yha5U7Byp4QE77sipQ3Em40=;
	b=FW7Zljhg0wMk/eQMrL8MSyQZwhNtwkXhGrIixmM95jE5lrs/WJn/N8kS268G4RlV5uHB
	 cKVazlh6O8fftCauLuYyDw5bOcojiRPLl3SM1J7EeGmQlj5MYMUXA9TbbpnliEGh9pKsH
	 wppCUs+NVqbJsbi6R316gNajGPGjWy+nI2WARCWYALtIePXAOxmr+JRM6cmmykjCBSbUC
	 4NZCqxlt7Dv72x8ArOjxzFCthcthn229b2khSJhoxiJdPRgRyRasmPdIB7KPA19i2ajmm
	 2Lmxb0IiLjRaGcRMPqqZ8/ifocDCGY4GAxhafQ7elirQtySmLTC5OcJ74MYSZFMEL0g==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791473770;
	bh=BRPyGSdyIc3aJk6aM86/Yha5U7Byp4QE77sipQ3Em40=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jfyYKr6WhmqNenUgvq95Vvu7tzFJNwzAczSWiA/S8qAvlWP6BlMYBFrt7Tlj7Uft5
	 VyddjquTS6evuEarepqoW8FkB1noPYsJIrL2Fd+NvuGkk2LlEDQWmRl0K+YItRqiPT
	 /wyUXwf5AaMS5ftaWtF1/dBq7HMSw77hjUqTUmI6znrOGpedSbqq1nYSAn0X1oYm3D
	 SighB+LjXdVaGMJXJkRhRy6JatbselVZJHg4ax6qvGJIQSLmuCrBkdaYJg0mlpNgA1
	 HOm5VN6Ql2XvRqmQ3texqxla4nY30aZmubsc9byNQ3X3xLIXCUep604zrIyudhQgRf
	 a2F8P75YGOS0Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 22F9C8125D;
	Thu,  8 Oct 2026 15:36:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7A5791A6
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 15:36:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6848860BC1
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 15:36:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1lkvg5e7Dmyv for <intel-wired-lan@lists.osuosl.org>;
 Thu,  8 Oct 2026 15:36:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6930E60B70
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.20
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791473767;
 b=CUmy4sTX9VHbEjIRfyTmmMpbaiTnzjBsQtE+oTS9o/qojiqlUJpM+x/j47XIJL0eQJvw
 N/MhAoepRrBpq6AtQmlJBmutXddZbJYHSxniRemYYvkd/qs2BBJyqoU+s1u742q62zMym
 48WrsDNTq5LXbXkP3szjijgqbHXLJyvYXOTqEi9xMUM0E1dw9oRKUQ3Qh7vziD8Y3iiez
 BeH++z9dcczLn017pRrhXDH9Npni95uLa9LKeKXzZWBJdcvrhO4MXxSIR7XSCjhlWIKNB
 1vYs1iqlq8VJuT9D0LPRk4HbEsoWRfVVGalqJuoQwkJZoPzcVollg7Yu3c+b6FPvV0Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791473767;
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
 bh=BRPyGSdyIc3aJk6aM86/Yha5U7Byp4QE77sipQ3Em40=;
 b=mtr9Lu0MOL2gcJqT1X0rD8Y5W0e4QWZwd5ftQ+g40tV8lnjiyGkR3cdYO6kXhFdUXGNp
 P752mCsIltMKtjDJXOkfOjpwGXgprmQvz9XmRxTnCagF2bSXvDpEqvxjfEI7CwnvZRrZv
 2L2bMQ8qSQycdk8ZNumKWT4dzF5x9G1wp22lNHwfpU3iLY614wWOSJ+l72HU/JW5gsz6Y
 Gt3r0e2I0F0Cz7ba/tOBZPgEZZ5dCUFG2LVBBC20vn+3vwU6v9yw9msXid3y6Fd2gGh+g
 5EeoR/9kPasid8CAX5OgSxnurVQ3YdsCgWxQnXi5I1CMD8qihqDrQvH+qoxKOPL70KA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=dYhjZ8tZ; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.20
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.20;
 helo=mgamail.intel.com; envelope-from=bharath.r@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=dYhjZ8tZ
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6930E60B70
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 15:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791473768; x=1823009768;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=vr/NU3BBrlY+8g9gFvuiyX3h422KLtxi3adQwju8W/U=;
 b=dYhjZ8tZ6W8T2FwTwbbmQTBJdRQQHhgSP8xypw+H42o0vK7VCoRnrl9K
 4L2htrAeT4ZR7RmTjWMVosqitDhYZbY3umBV5/5BimvF2pAu/N/GhFPOi
 aD4CiVgOYf8lAjhc4q2u0/Xbp//nn1x5usLZisHjq68dIWgGvmYjJeJ5V
 g99lY0nyaOB02rMCsbylAtCPwyOt3gRhBQrYxEbu0rZr6XL7u7mi1Qsd3
 SaVqXdMZya6XTbhz6Sg0BKuD7+6txUEIm2XaidH/xV42YCIkFLpGSrE5c
 MuUKQ09OLnuIPMhpskAwRxTyYtU00FW0CTuyDSHAv4K4qLKZIHxediV54 w==;
X-CSE-ConnectionGUID: Wnm1GQItRUqzhx83DS1+TA==
X-CSE-MsgGUID: zxylddd1TMeLRlE3yFqd8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="268155"
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="268155"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 08:35:54 -0700
X-CSE-ConnectionGUID: gpBOthnxSYCbnP0CVbfbwA==
X-CSE-MsgGUID: KhdP1jF2T3SplZV5tSUZ4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="432784"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 08:35:54 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 08:35:53 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 8 Oct 2026 08:35:53 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.18) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 08:35:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y5rw4w1yoyO1iMowU1uxRDjDZBUdeJmcaB6H2jBOPmKZgmV4e4ol+AB9jqTHL/9Mt06PilnzH+r6j2WcS6lSBAkxkdUj/08/bu9G9Uv6mGwid414paH6DP67KHz/AScrkntBb+YRFN3bM4L7cWCJcicVmgiKvj78L/LBJWTNkbjDnI2lLN9P/s3jyoAPxGGcZAPL3xzlxhope/EegPalVzZ1jZQbq/VnRKCHJgf7iFbC1k9j5Ha6SYoBw8DUI3Usd5CyEw/ZZBS1JaZeH1C1wOoecYKjGKgeALlG415AEUvndMINTsNqrzjQFIGhrNBw753kXgCbtdf9mk+Q1B4g4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BRPyGSdyIc3aJk6aM86/Yha5U7Byp4QE77sipQ3Em40=;
 b=mKpfpQaYbRcsM2YC8kn8CcTLWW/8Exc1bI76BC+PIUaC4j3znrW3NdU/KBavBd5Peb0DNVFtZGiN7Jw460P51m1E/tctm3VapmsrBRNfD11pip+5I801/iCHmQgPSyhWtTNXHjddRQVo8xaVGshXefjB8EoEonNn+uT4zhItcDr8PbXrkCEsenfafXcqS3fiRAAZe/Jm1ZAudQLh+NAa7YpzZ43NRzi4XmJvmv4J6oHLr9yykM+CVi9XAfYiAIt3PP6hAOffQ177agUAiJ+UQ1WYI/jFZTYOSUp1tcfK5/TBoZ68TKY9smtvDx205PDYbNXgAYCjmjtk2LEfTeHksg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB8012.namprd11.prod.outlook.com (2603:10b6:510:24b::7)
 by DM4PR11MB7184.namprd11.prod.outlook.com (2603:10b6:8:110::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Thu, 8 Oct
 2026 15:35:48 +0000
Received: from PH7PR11MB8012.namprd11.prod.outlook.com
 ([fe80::71b7:7099:a6b4:4bbf]) by PH7PR11MB8012.namprd11.prod.outlook.com
 ([fe80::71b7:7099:a6b4:4bbf%4]) with mapi id 15.21.0472.016; Thu, 8 Oct 2026
 15:35:42 +0000
From: "R, Bharath" <bharath.r@intel.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Loktionov, Aleksandr"
 <aleksandr.loktionov@intel.com>
Subject: RE: [PATCH iwl-next v2 10/10] ixd: use interrupt for mailbox
 communication
Thread-Topic: [PATCH iwl-next v2 10/10] ixd: use interrupt for mailbox
 communication
Thread-Index: AQHdQfHXmiTjuBGW3ECA1/NYrqX8PLbz8TkA
Date: Thu, 8 Oct 2026 15:35:42 +0000
Message-ID: <PH7PR11MB8012E49EF17FCF121EC4CF91F7932@PH7PR11MB8012.namprd11.prod.outlook.com>
References: <20260911124921.2881348-1-michal.swiatkowski@linux.intel.com>
 <20260911124921.2881348-11-michal.swiatkowski@linux.intel.com>
In-Reply-To: <20260911124921.2881348-11-michal.swiatkowski@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8012:EE_|DM4PR11MB7184:EE_
x-ms-office365-filtering-correlation-id: 1d606c21-a4c3-4e12-1077-08df2551cff9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|38070700021|56012099006|11063799006|4143699003|18002099003|22082099003|10067099003;
x-microsoft-antispam-message-info: FEpDi0GKLI+zSlpBQWIpfAcwxXfDI5h6dCk5z9jUrjlVgE2DDi/AGSqkW+jEnTipM9bjRutcU/APFa/S0IgPR5JMTv7YfEGn8jr9gB+ZmCJJPvt1OsSeBH4OSfnfoRuuN1GgNwKHPA3wKOIcYBHZQkvgZ4fUlrbbKLZs/6AEIC7gj4W7Qy06FEb+NBLy0e9lnAKh/Oo9ebpKxgYS4mkvm79xSCRMZ/0EXotKdnCPhKjdNukHuO9+rI5706CpBKoGkVKt32nlEidZ7URP0xFRfkiDduJ9SuYBuVmAo/GNk2KbYfymzgMNi+6WmW35DKcjYh64VgyFuhcZyEYQG+WQc0wsj5Eh6PcwA1F1aPBb+CxM6u+VN7jCcLF6WSk1BGidhvOdZWMYGiUnhYZsRv+h0FLEDYrTXVeCD/IPdaeqnI9EXtLaHPXKXvRv0YV4TQQ0HimW3mmZSxpXGDbnb/gBXsKdJljCcRjWqgQdhyR+kIk4NAKLqnKG02q9uGuP//Ag8U4MX7b7DPxZWnlcQY61qFjMRtq8lzHXI8kIddWQxdZrxBWw7TFQrBMR7wTC+VPKLiHGOmOaYo8IWshXFm2aEkLXKGZ9FurguHrLoMhXGqeALF5PWQpvhPuwIUy0HhhGS3QaYLqspBsU0Bft7fOb9UJLE24Auek5enRTUZWBBI//hzsSXSk6izVW3NWSYzCpNjFV7zt4YiRGW5cXOSpSAmRuVGdDfSfDhsDden4xYdk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB8012.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(38070700021)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZliIgqBj7krK7rm4nbhQOYfc4AyfgrovKD24OCIhWMvpYcAsqOWtnjxPXPZ9?=
 =?us-ascii?Q?AQ5aBKG2BOcCLJgxQN+lRoxh3l5C/PMocnhcZQccq/E5jTK4fjceir7gcORl?=
 =?us-ascii?Q?gSXsPI4ojnCaWx7wC/MJibm4MAxHSB6+7RDHb3TxyNEBczKcjDxqAGfZLIH6?=
 =?us-ascii?Q?WImtwYi8QnMhW++xi4ZVMMRjWTklhkMwX55cgJG2LA2ZLTy2IlzoDy6pzr9I?=
 =?us-ascii?Q?fY5uNwGXaqIBbUzvQKakEiQ4vlo23AkLSKzBUQvT5G5sgvIz9gW9OyUd6G6P?=
 =?us-ascii?Q?2fMFV3WphlHNfV/cSKu/EExDtAepUdjFqo6K01qLZAcAzgnqjNGzcZrNJam8?=
 =?us-ascii?Q?QONq9kmUIJWvpAOSRFXiBdXtIqHYoLczr56BxLIYtJwBOSdrML+hq5l8VYIQ?=
 =?us-ascii?Q?IWcS3UnSojLznSqphTdaUOmzaN3C6LiEKnCD3GB4ToG0Jg1bft3K1rXuvuaH?=
 =?us-ascii?Q?WMt1AgNAjuxNcMRH3HC0sWq5Rpl04hrq7kkBQj4MfQ8e7y0AUlqOTweV9AOY?=
 =?us-ascii?Q?GOzuS/cGRQbNE5ZZN3VuAl53us1o+qmzkhrhVFQm3U2MKETtvP6vSIOQMuWb?=
 =?us-ascii?Q?BEtCFmKzW38Wx/KH/wJnmxV20/YG2WLJ/cymtvAcoRpN8GLUaJWQM4efMuRH?=
 =?us-ascii?Q?Tx81Ys+zdst9kBvjbzgXXsx0VylucUwZRJilmosD/kYTiA0+7lOk+/61j4Nl?=
 =?us-ascii?Q?vJRSZV0q2yKk+Xbyw0CmiehOcrBTyh5mde2G6uuEg524axgX/Xp3ewL1fDA9?=
 =?us-ascii?Q?wI7ehjLmy06fNbUHX274bMgUb28ymenIevH5YneBhF7a+xr8sG9CFxHM4JZJ?=
 =?us-ascii?Q?mMU17qP6H+h/NAPbpEANVGrTYPAg3jvwMzHt9EtMk442n3R+/Lj8Yr6kQSb4?=
 =?us-ascii?Q?QJAK0LEHO8g4VbaEFKGV1Yuvq78K3zqpyZmEOUZUeye86Si1aZYI5ulzP4y+?=
 =?us-ascii?Q?PnjGnZbyxWDAWvQhHo2iopEDz+QqPhXAFmF7Zf9FLH2SBc1eEXVkZ6u49Zqk?=
 =?us-ascii?Q?y+fEpEhqKAREq5frJWd90rOQ2xti+mVfgsdzO/+40UxIeASp6w6UTLg3Ooaw?=
 =?us-ascii?Q?i2S2sj05frKZJZ5AXpkcFFUNd9dhehwn8spQaYVbbIC9V9H36yFZF5HOfvzO?=
 =?us-ascii?Q?l1jrjm3g7FdWUJ5hqR1syGmUl4JjMx7hakvJbDJU9D0v9N0cEKC80mhwRB4j?=
 =?us-ascii?Q?dkmx9xDgz2SZM9Pj2Y9yKzpgCkFcIyBlr3DflZZ5/3NZRzKWkA2/4xWyYhGU?=
 =?us-ascii?Q?lfZMVUs4n700nVINGogQzr0XPukTEfZ5OSY33kN5Bd1e5HVGs4d1r7Gh28EJ?=
 =?us-ascii?Q?4favR8Kc6l3wH7iJZboSGXoO7ihkz2mauJ0D+M2IoTjeuSBhmqYFkC9C8NXX?=
 =?us-ascii?Q?i5w+HRZQfMTZoExRfFbQ9Bj0JGXy7HTxary2jFDxHx64da3znWHrs+7bPWVl?=
 =?us-ascii?Q?S9ozVrExWhhxuDNUiahYw8hDcJ2cp9GPJS+h5Vu7l6AKyKdAFUAC+lSWaFoM?=
 =?us-ascii?Q?P22/XR0CfeGUwfyP2KrVnfoyvLovAoRJGXV0ICwnJ481g3aioVWrSCKxlN8V?=
 =?us-ascii?Q?sddEUSdgXFX7f0qudXkH+1waj0LHWnJLPQHVrIBxPniHDI27P4tDECzJuinA?=
 =?us-ascii?Q?3rHiR+FLZ6u/+QZdJE0K8MmpndgPRVwLPqMEVjCJNhPbh9bLh6al6eKzZbxD?=
 =?us-ascii?Q?4R99F2A7aLFpLsc48sYh9U/dQvRUwi62KlQQJipXkTosQcE1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: zS92KNxYHMLrj9FhHruFzguvrj9Bo0chEttWTqL8Y+1tksWI3k5PUwQvLuq3Ihe4Z1UkC7eYk9RbcURqEL269S8dWJI0Jt9ox9gistKCz9sjKex0spDlOSr9DuJYvhC65ejEYcR8Ay16f1k2SSx2uhLsB56bZYt9PMwiKFGkdUirzg2U8Souua1NMf5HuIWUJjzTfqGb/lqk357th/b+MDrcrjCkzf2LKa+No9Q8R2QnNYKmOkeXI4CD329tbOMZT6Tmx1A3Oo+og5Wbpot8zRgv2lHFCf4UH0t+VGyM5c+muYwf7WKr5rC+8TmUVNj+0BCRJkuvW3kML6LlIx/Ufw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8012.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d606c21-a4c3-4e12-1077-08df2551cff9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2026 15:35:42.1649 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v+15jIej+kZBzhY1uqLuuNldS0gyjg2Fmyjrs/b6G5gvMrs48RsE/rEAq0OSb2u7jLQA3DCBhR9sHdUvmjkSGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7184
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
> From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Sent: 11 September 2026 18:19
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>
> Subject: [PATCH iwl-next v2 10/10] ixd: use interrupt for mailbox
> communication
>=20
> Switch from polling to interrupt for invoking mailbox operations when it =
is
> available.
>=20
> Add flag to store the information about the mailbox interrupt. If interru=
pt is
> turned off mailbox will be handled by periodic workqueue.
> If it is enabled interrupt will take care of it.
>=20
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/ixd/Kconfig        |   1 +
>  drivers/net/ethernet/intel/ixd/ixd.h          |  28 ++++
>  drivers/net/ethernet/intel/ixd/ixd_ctlq.c     |   8 +-
>  drivers/net/ethernet/intel/ixd/ixd_lan_regs.h |  10 ++
>  drivers/net/ethernet/intel/ixd/ixd_lib.c      | 126 ++++++++++++++++++
>  drivers/net/ethernet/intel/ixd/ixd_main.c     |   2 +
>  6 files changed, 173 insertions(+), 2 deletions(-)
>=20
Tested-by: Bharath R <bharath.r@intel.com>
