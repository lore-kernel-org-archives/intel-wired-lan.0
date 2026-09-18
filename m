Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B8CC982D8
	for <intel-wired-lan@archiver.kernel.org>; Fri, 18 Sep 2026 15:47:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 90E4640B13;
	Fri, 18 Sep 2026 15:47:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tscBfkA9yWpf; Fri, 18 Sep 2026 15:47:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org CC99C40B24
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789746428;
	b=aF5ar9I6UIwyUwFIPepAXzCObbOpZoSaX0s/ZcBSYT2FLnhEiGOiuVkqNwMnUV5OQqRC
	 gCMSCd+Za3B62H/Z17QLqtnp2sOFYj8IFGlZRy4+1EhAWX2sRH6MYZZV7Q/BU6udgmMiR
	 2zKv6IKH+9CTc9abBV4R5n4RuSnUDF42vh/yvhxWRQeTeMrFeLJOOyXEqX8Dl57v5sme5
	 gPyNRkuv/t8aggDEwfTZfVqS9kKl2UnLXcfkcFUOae5odbCWGCY0V2TkFgJyF1jcBpQ8/
	 9kNmSnfrYzDwoD1ubSB086kLjG3Qg6McjuvwiG1YXa2YfDL1iACGJs69nWZSB1X7U/w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789746428;
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
	bh=oTm+mOa/3kfI2w4gneXyeLLsFADLvmrkEVIgDfauLG0=;
	b=GRqhLvEn4fvAKwob3OJh57vPnAi1qKAlX6U2e3rAqoH6aD2JHl1LQVvFbiy0yocrJZ1P
	 45Yu3+IIL/hsAnvnwNkPvCZMmNTz5ydcm8rndLtD/s4RibKOk/6FjVUjVjRGm3JvR4qh7
	 Ga+KuiazAYkuFVVIc4Fv0Dj2jeS3aDN9cl7eynPzbyVu3xv0X1JFTBUqluuAR/oUCEseJ
	 EfwG3SxdE27+0p1nwnGjYHh33laDPPsn/SlQz4Hhke63GghybGyRz0wgx2mevlCBQkJPz
	 qsGU3NT5E+WVWdj+E77+20xPlwfFvhgxXYJVKhDTEkEAfCw32+q4ozhRiuEgZqw/ohQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789746428;
	bh=oTm+mOa/3kfI2w4gneXyeLLsFADLvmrkEVIgDfauLG0=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XMoVxOaZAQ5SPbWQJTPwtcaATnyaEUPExIXkSDkUtMjj+BYOL8fkunFBko9jCZv72
	 JBZxZb5F38Ul5+D+7DfT+sB8/F+GVMGFKoLaPQ1Mp6F39FANL/D+pJvENQvkjWMTQW
	 T6FAG2fnL0UJAbFqmonRUNEu9Gh9V1NPZvma6Y4MQP/T59OncMmompgNmwtEfnsFE0
	 MdGjU9ApIHkwZj732ypdFxKfMdiByk4sX+GM2opxrrdSjBdevrbrLJTRCtGO8eVz4O
	 0uYHDfPak1s7vfcU42y90rh1tmz5Uataz8kZJLB14wGQP7Bt75hzsQJYxwj9a9K53w
	 cSq0HT477e7bQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CC99C40B24;
	Fri, 18 Sep 2026 15:47:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B79CE25B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 15:47:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A8ADD80C3D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 15:47:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4tyLeLhD3Ft3 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 18 Sep 2026 15:47:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org BF23E812E5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.16
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789746426;
 b=GsQ760iFL5cBadb+HKIZMLYnThyYO7Kt90eefkSqMPrWL5TP/G51ZRH1bLYYMBKO1P0u
 b6PZCntUbLNhDw+YX3Kmlt2JdQJgpfYw8S6zP5Ruer4ie73AEnIetydmQBpMMUMwd6+Id
 TwYTtkhx+IcUdtpIo8w93Er/oeRTZcd9ZutGR1Eg+Wpfm8iparD13ZyEGpdaXRtMRBWde
 NfQAUWX/Yo8zE8KGjANIKtRj4cmMP0LR/CyBpHgebm6KD0mvRgjYoP7ZxX0V4SuoZ09XC
 p6vj28TOXaaMNc63IkPdhLPnc7PSNgcFbSglJIynMOXPit/ZMyP0y7R0f0ZMSXK30JA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789746426;
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
 bh=oTm+mOa/3kfI2w4gneXyeLLsFADLvmrkEVIgDfauLG0=;
 b=GnEAwB6sliBJOgOBuwpEShJSG+sVVkNm6i6rQP6dLgmBSio9R6ahP3LAt7uC2vjLT8Mf
 zTultuJ2N3zLDg6/qw9doJ50cBAKNhJcqN3sGxzz3Oaxr4kFdZqMjz8Tm6N51M6sj6zAL
 TNMgM4ncNhV1X0r/miJQbrR1hIS3los54opSZsqAKgzHGzMvTWgXiHzi61TPh1ND6LRDX
 p2KHWbkvtVPBrWcjOio++SXG0evN5fiAJS1oWyNjeUbbRDGdAnQl7oEou/4AnGOe/T4R4
 wI6MsNjehBPONEzu5RKhBoJKzJYTwArq8ITO8lE5RhGoWlHg+hiMsPSRLtVURSH4Yuw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Ha1dgzYY; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.16
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.16;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Ha1dgzYY
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BF23E812E5
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 15:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789746425; x=1821282425;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=vBhQ40+EGMmS2dJCnpqHe2133zpynOdnM7Cq8/KHDRc=;
 b=Ha1dgzYYmYFL+iP/Kw1y2VmDTOBDbczte1NfrZZQZgYt2rZmXIwpBfjY
 IxMNEXNDl+exZx1VBncklsyggm7FAGywuapUEX9pNhs6u1yx7HuZL09cN
 E++NdtbEK0C8iqmMUUHVLiNGDZZKTmGDrS+bZAqTdCyt7Vc9MLGuvJqma
 /iPwwJwwd15xFyMMGpdGMmnc/033ri7GR/02N2o4WqJgCtlTLvZS8di6c
 LnwWJembxeT+gbwemx+MgGwSpghYYpI9JQGcmRB+2D4guNrJKG7cPof8b
 WTU23wf5LamnD4E3jPDNGIMm5BVqlOQKk3wIkZfjl3vvsHaxqtCNiqUHD w==;
X-CSE-ConnectionGUID: WDzkZxCySMWPA+/eq+lGTA==
X-CSE-MsgGUID: 0CMARqcbTHy8SuQ86Y/6jg==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="77825638"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; d="scan'208";a="77825638"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 08:47:04 -0700
X-CSE-ConnectionGUID: alRMwpjkSNubmGZsxd4rqg==
X-CSE-MsgGUID: MpdKuXETR06IKrggRByd9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; d="scan'208";a="271129863"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 08:47:04 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 08:47:03 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 18 Sep 2026 08:47:03 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.68) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 08:47:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GAgUOQVxsJhVw6Oau3aUew6eZrDBR80ipriX8ez1/eK34w8DvPHuwYTCOrcchYZt5upSqlE/CSM+VMRUHjZXBBUSho6O1IbAZHXR5oN7vs3XgJY1xuYgwPF1EaCrT1EQe8Bj4tGMHQEQRm/X3qlt2vBRQi5fMq+nOdhzDkHwBORW+Y9xbl5pN0+xDluB4D/TBBidJZKTdWGaCwWuJ0d4mDPqR5GXuLa7F+1ICUP1uS4NXeH8b2phMItFRwuvkTH7k5Xy9Vu9Bge68OB6QVgED4wbBLWMIQLRHdZjcVY7iSfHGqwAQzkYNI6/5jZlF0Jobt8oHFIqQRt/5hM350OGpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oTm+mOa/3kfI2w4gneXyeLLsFADLvmrkEVIgDfauLG0=;
 b=PIhnVNWR1N6c6sR2pJu8OymfX8k8+pa/u934HB5xnWZwfKzqVajb8Hx1zf7lFITmNakOOtJhv95zSSKGnwZ8dzlXV6QY6lC0ygcz+CPVALoG9cllVmXBm3KDiWSZhNEjcYdmB0EohhxEpspeht9jSpsGYihx06ZIU+ahQMQA+BWczZYRQlNVhk5ulJzaG3Ndb72Hcik4/QVpN8wZzr1CM/wM4bpVLVlDMFZ+yhmerLfNnJKqHlhb8gTww8A/hfpjFphOholEYBsq15eWAWngwgb6yLip4zVWUDFIOuQnWDuTkceIsx5u3qcTg3Wt2fHElLp8VIwIzSNBt/HcDgfPaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by LV0PR11MB9791.namprd11.prod.outlook.com (2603:10b6:408:382::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 15:46:56 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 15:46:56 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Matt Vollrath <tactii@gmail.com>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Ben Greear
 <greearb@candelatech.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH iwl-net v2] e1000e: fix NETIF_F_RXALL buffer overrun
Thread-Topic: [PATCH iwl-net v2] e1000e: fix NETIF_F_RXALL buffer overrun
Thread-Index: AQHdRpKmFht1Udkeb067uJv7TxqLXbbUfKOQ
Date: Fri, 18 Sep 2026 15:46:56 +0000
Message-ID: <IA3PR11MB8986A894C026668EB33ACE2FE5872@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260917105144.11308-1-tactii@gmail.com>
In-Reply-To: <20260917105144.11308-1-tactii@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|LV0PR11MB9791:EE_
x-ms-office365-filtering-correlation-id: 21cd3b72-9e86-4680-c117-08df159c11b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|23010399003|10067099003|11063799006|22082099003|18002099003|56012099006|38070700021;
x-microsoft-antispam-message-info: 3OrDaobl4xtLAQuf5PcnEkFrbHTnNFfcqHmCzMC5PiB5Xhit7xTjaqeMGcvSHmfSIUG4bX9pso1G6OwzTSr+YEuryhAeXIU37AywnvhQJgexWfGV01Hew2B56p0QmLjwTi3Cn6NHDvxKKwl6sxUjogrUAsapaDosZPeJglrJhrEreFTz/vnDi94oJsUMbR3zGxj6UWtBFZPjALwtv0NX2qc5gU6zVyZR60K8T13ktdFrGDaAAU4HcnMKHeoKdVvEBmkJwN/3LYacmKI0IYr+08G2o1Cj5VCrEn9M8EN2aceJVaHcMWw3OYvzF1//h0uCo/SLIa+uBSMhS7K4YlzpRs2L7qTSC3+rcuT+os5ws0uK40Ke/A4ONjGwtXa+LrTRBUp2pvqc+w/Woa9azTRNbK4tZm/li6/DBZcnbK4F0e4o/Q7aR2BAgeUzQoNR501XHO9ygNHc1g22R6ugBq9mPWX8zby07N8fTLcmmVRN1asGoavzEdI5XdUt5x+6HeXBHAm7j/VQ9IKw9NHHu6PCTWqxjPMn5TBjCr1IezP3VCLaTPgpDcSQTyFXAy9M8PCKN1wyeJsLj/K7h9nFGQuRA+KxI6k2bL0IAUizN+ztwYvNLJevtuMVgihFrUzL/MgLEzoVkovkgkA5RixdFMzmDVW343kby/CAhb2SMYqgpMi6/itdJf1LXG5c1N8iDt2LFMrTS3EnvSSoWDz2c0Gzccm3P6fn59zYDQuCDGOb3lY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(10067099003)(11063799006)(22082099003)(18002099003)(56012099006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FYSwYS9ehJo47+6h321GkWGkJJOLdY4yKGgReJLreN7JHpa8mcQLg+jmSZxx?=
 =?us-ascii?Q?IiHmvB5jh+H0QO6Qjwelebw0ieb9zJT8KsaJNtu+l/Hx0aZHeNFPgg1Mn6XX?=
 =?us-ascii?Q?X0V8Whd0ZWs5uiE6wnHBKMISFQoYkmU3NE41hi+dM+ryKxVeprWUTnB0kURz?=
 =?us-ascii?Q?urwfLB2A3j1obae94CCVVCQYNL+/by2mopGAOYHMJA1N72O9yV1zYbbq7H/M?=
 =?us-ascii?Q?Tk6Lrohzzc7ud48gvZp5rbSjWkStOV2mq0obXn0veJcF3nrA6VkCFoekfxPT?=
 =?us-ascii?Q?/uqOA660UbKl15OCQr0CBd+obYCFaw3UfgDQeO7n/BUFQP7k16guU0eFxu+E?=
 =?us-ascii?Q?VvDYQ0xW0B46a9GD4MKSHi7++KEJ24pa+UwMaN1D9DRWb6rZhI4h3cgu7CAJ?=
 =?us-ascii?Q?rtXp4TJQh2leiZ4FeYWPxH8f/l5ASoMJnhqm0nib27o3Kk4d+BmzGc5CIwN3?=
 =?us-ascii?Q?rS140HErPTNgU4MEV1JPX74oi9DEhAoYqFjNKa7OuH/MrRv6cfnIG7mga5JG?=
 =?us-ascii?Q?L96r3KtqffmwutffyXG3gVcBZOK2cH/erlfDvOGwP789zDdHApJj4knrSex5?=
 =?us-ascii?Q?5HoKSaT8VlE203fPm4lnEWEQWxW7EY14OzCqC/8asA2K0h4gkCeQx4i0pZqo?=
 =?us-ascii?Q?2YVQb2UH3E8aL5WWqxfBicLIniRnN4a6+v7xh1i796X+F79RwdvEwJ0HIL1e?=
 =?us-ascii?Q?dtLi+qV95xgpTyyHGNVixZEsMlJw4QGdQZpi0n2Y5u3h8auhWayEqd1iGO96?=
 =?us-ascii?Q?0tdvbxtZLOZ3YOQLfx2xEQJbFPKHUXyKujn3hlZ1a0G85+P0TqEwf77udnLQ?=
 =?us-ascii?Q?N8mxybZQVRaHlNol4j0QgkVvtEVj+nc25Sg23xrzBnV7zsp/vp1qlm0/Ux3a?=
 =?us-ascii?Q?ajP0BuWCAjm948yYXQ8A9Lp+vwNTKdebFW9SecM+1ag4E4oIkphDX4a/El+d?=
 =?us-ascii?Q?8WWGVlTV1v9T0GWgkbyGgW/FQM/cTZBKaJSQMmZNXoq1pXq3Cl8uo1M0aaRf?=
 =?us-ascii?Q?I0HZn52R0E9K2how7AiNIMIkgLzKNy+wzGjbAdWFPp11dPua1+KwFij/SaXH?=
 =?us-ascii?Q?/e1h7IV9p57/kofQfbbG9HL9Me1PVoEuF0MfNMxMDtQJEGLwmq/nAmjW1aRc?=
 =?us-ascii?Q?dUT6KTekaNAXkv5z8YkJBlfOlKF8sKf5NEoZUK+uBBzE0B6ruukezsrlcQdx?=
 =?us-ascii?Q?K+q7D/lK77vtvxdW18//aXT2LnJhpqnmiyUW/kXuSku5xOgcfxBU/242UkwA?=
 =?us-ascii?Q?yBDI7EMzXFvseAOHP1jQYWTPCgUdN6enkQEfdWXZVtBtq3c6KDowMn0O05oS?=
 =?us-ascii?Q?z2ScbLkeh5M0oLQghID0VJ9b0f8Jlv7SZDFlnL57mbBebVT1ml5hQQxPK/J5?=
 =?us-ascii?Q?tfZf+9C/EU+Q3PIpbPc0epusZdkoOrALEJBYvErv4uPddApqr79U5KkhLPiN?=
 =?us-ascii?Q?xZIWXVkuZXP97sDqvC8kwUEFCgocWOamlhEVZDZcXL/L6wwA5y52mjSMDbWT?=
 =?us-ascii?Q?niL0VmF73H/5V1yKYQejO1bwOC8ORMAQXNoGY24RpCcU0gs0xBDdR0L9KE0i?=
 =?us-ascii?Q?G/cTo1/2iWvXk8oI/SPeiShiTiaxCi54Bs6vGn2WNAMNJOqls+8zf3S1tHSl?=
 =?us-ascii?Q?Tyy1JVm1hhhNGCQoo32NQTgiYIlQe7ZQo7iRzMq2m1WaSI5jWqSyCuyg6TVV?=
 =?us-ascii?Q?g9tlzqfpU2JqHpEZLAhv6uqEaqkb01iL8lfpOsF3LNeAwCjZIVioX6RDOP5e?=
 =?us-ascii?Q?HfhHTu8bqzNgkVmS4n7ENRVsLHwS8fM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: zvkCZ4zVA3r7lRnERQJsljXG1khSBnPV2H83Nj2eMddfBy6zTwGemp5YJe0NY3QQZqAZnDcMBjHSRwLr7xws8LGuDBHqRXSO2kgISBTHxcVTJujeab2MqCnDO7iOaAT+cov2QWjSVXfrS9ZJFvG/YnsscMl8hRIpUhy4FcszC5cVsnUNdWUHF5Mq6VqTPKFPEFKOb6q+RDyEfvxMm7Xc48+9mojeiszHwzzKjD1u/6cIJlEaI6vahB1kDmI+/GKTvb+LI/exl7ucKdjhlgUIZgY92/4lImBbVf1tn3M0BFSg5DxS/oAotLcsbld8dF86UkFLy5xCK/FTpLDe2fozhA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21cd3b72-9e86-4680-c117-08df159c11b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2026 15:46:56.6252 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gbHgRDFlVVWgLHtWhe5BmNPQLEddtsTX0m5TZVGR39vDntyaoBGAVpyti01oQnroF2ydvsH2hVgdpsZJ/AeZRv7xKuaBn8DPrPu+lwoLe5E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR11MB9791
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
> From: Matt Vollrath <tactii@gmail.com>
> Sent: Thursday, September 17, 2026 12:52 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> David S . Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Ben Greear <greearb@candelatech.com>; Matt
> Vollrath <tactii@gmail.com>; stable@vger.kernel.org
> Subject: [PATCH iwl-net v2] e1000e: fix NETIF_F_RXALL buffer overrun
>=20
> When SBP is set, the card may deliver frames which would otherwise be
> filtered out by LPE being unset. This would allow the device to write
> up to 526 bytes beyond the skb's data allocation: over its own shinfo,
> and beyond. This bug is reachable only when MTU <=3D 1500 and
> NETIF_F_RXALL is set by ethtool.
>=20
> To reproduce, build a kernel with CONFIG_SLUB_DEBUG=3Dy and boot with
> slub_debug=3DFZP. Enable RXALL with 'ethtool -K <iface> rx-all on'.
> Leave MTU at 1500. Directly link with a remote machine and set the
> remote link to MTU 9000. Send oversized frames from the remote machine
> with 'ping -f -M do -s 8972 -p 00'. Unload e1000e on the machine under
> test.
> Observe slub_debug faults in 'dmesg'. If IOMMU is enabled, you may
> also see IOMMU faults during pings.
>=20
> Fix this by ensuring that buffers are large enough for an entire 2048
> byte chunk when NETIF_F_RXALL is set. Do this by moving final
> rx_buffer_len determination to one place, right before RCTL.BSIZE is
> determined. This will correctly re-evaluate every time the adapter is
> configured, not just on MTU change.
>=20
> Signed-off-by: Matt Vollrath <tactii@gmail.com>
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Assisted-by: Claude:claude-5-1-fable
> Fixes: cf955e6c96cb ("e1000e: Support RXALL feature flag.")
> Cc: stable@vger.kernel.org
> ---
> v2:
> * Don't make a new function for setting rx_buffer_len.
> * Rewording.
> * Add steps to reproduce.
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 41 +++++++++++----------
> -
>  1 file changed, 20 insertions(+), 21 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c
> b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 844f31ab37ad..f31dd5886b09 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -3094,6 +3094,23 @@ static void e1000_setup_rctl(struct
> e1000_adapter *adapter)
>  		e1e_wphy(hw, 22, phy_data);
>  	}
>=20
> +	/* NOTE: netdev_alloc_skb reserves 16 bytes, and typically
> NET_IP_ALIGN
> +	 * means we reserve 2 more, this pushes us to allocate from the
> next
> +	 * larger slab size.
> +	 * i.e. RXBUFFER_2048 --> size-4096 slab
> +	 * However with the new *_jumbo_rx* routines, jumbo receives
> will use
> +	 * fragmented skbs
> +	 */
> +	if (adapter->max_frame_size <=3D 2048)
> +		adapter->rx_buffer_len =3D 2048;
> +	else
> +		adapter->rx_buffer_len =3D 4096;
> +
> +	/* adjust allocation if LPE protects us, and we aren't using
> SBP */
> +	if (adapter->max_frame_size <=3D (VLAN_ETH_FRAME_LEN +
> ETH_FCS_LEN) &&
> +	    !(adapter->netdev->features & NETIF_F_RXALL))
> +		adapter->rx_buffer_len =3D VLAN_ETH_FRAME_LEN +
> ETH_FCS_LEN;
> +
>  	/* Setup buffer sizes */
>  	rctl &=3D ~E1000_RCTL_SZ_4096;
>  	rctl |=3D E1000_RCTL_BSEX;
> @@ -6079,30 +6096,12 @@ static int e1000_change_mtu(struct net_device
> *netdev, int new_mtu)
>=20
>  	pm_runtime_get_sync(netdev->dev.parent);
>=20
> -	if (netif_running(netdev))
> +	if (netif_running(netdev)) {
>  		e1000e_down(adapter, true);
> -
> -	/* NOTE: netdev_alloc_skb reserves 16 bytes, and typically
> NET_IP_ALIGN
> -	 * means we reserve 2 more, this pushes us to allocate from the
> next
> -	 * larger slab size.
> -	 * i.e. RXBUFFER_2048 --> size-4096 slab
> -	 * However with the new *_jumbo_rx* routines, jumbo receives
> will use
> -	 * fragmented skbs
> -	 */
> -
> -	if (max_frame <=3D 2048)
> -		adapter->rx_buffer_len =3D 2048;
> -	else
> -		adapter->rx_buffer_len =3D 4096;
> -
> -	/* adjust allocation if LPE protects us, and we aren't using
> SBP */
> -	if (max_frame <=3D (VLAN_ETH_FRAME_LEN + ETH_FCS_LEN))
> -		adapter->rx_buffer_len =3D VLAN_ETH_FRAME_LEN +
> ETH_FCS_LEN;
> -
> -	if (netif_running(netdev))
>  		e1000e_up(adapter);
> -	else
> +	} else {
>  		e1000e_reset(adapter);
> +	}
>=20
>  	pm_runtime_put_sync(netdev->dev.parent);
>=20
> --
> 2.43.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
