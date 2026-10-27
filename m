Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E67C606A31A
	for <intel-wired-lan@archiver.kernel.org>; Tue, 27 Oct 2026 19:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=69mKjd+c;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=id8XFGwU
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 79CF280DA2;
	Tue, 27 Oct 2026 19:22:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fbHGILPyeL5r; Tue, 27 Oct 2026 19:22:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1A65680D58
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793128957;
	b=pn56o9tbE/sIc64TbVp3WjZa7lz4LMP2D+rRhClr/fimo7gIstmgB/ON2I2bvYsMvtlS
	 k6sT2HJM301EUAZxl+NBupd21VLcqrpPLwMTRQp3zT1wBmilPjaDyIeFf/+k1F9/lXrzk
	 Iia6qQcBKPH2ZFILZstmu+N0X+dXxjMibYrT8FC9qhDeHCbFsssMhHnnv26sua4oXiCNt
	 SeX695zipHf7H+fWTPlDLHUgWX4RdFoBup1J3Klpzef5Dq+FFzg6mkD0HrSK4H0GQ93R9
	 gZJTDdqHpGltFBVlJPPlKw6NeQ1uOXIPxQYC6ecODLV0KLCzOvSJ/sAAgCQa1o0ezhA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793128957;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:Received:Received:
	 Message-ID:Date:User-Agent:Subject:To:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=WrjJ210tUx+GDtjvq8dmmpooB5aVjih5AHs4ZvOtsFY=;
	b=oXy/3kItuxwwvemIHcB/LEYksGSGR0gF/6nBrUakQAZppWHnKcGAfUXATjUmgnwPRI24
	 NqMLx9xA4/zVoIplpEbiw2M/LOwBNE7jRql/bXryn9DRXKPamjr2fVyJJ//hpbflzRDz8
	 dFooCziUV+kkhhoXvGih8wahiPtYUD7DYDDJmt85hbNOE86cYH/uWDZYmCTGUQbUk18Dl
	 Es9i10/3MrPexORMktGKTpQEtpE6vzQ/Pp+a4VcpukgUuYpkkVdjBARRPtvmoXIHvSuXj
	 rK49kAv97W8ZvG5gpJ74eYMnUXuPL5SQidZLIBusYl5CHWHiY7RhcbzrfNzpFlsVGLQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793128957;
	bh=WrjJ210tUx+GDtjvq8dmmpooB5aVjih5AHs4ZvOtsFY=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=69mKjd+cLasD2o8TKh4YxYtB2ErrXJP8debAM2KVjZWPd22AG3nTuX4ZXDr39Z30L
	 EHa8F2zyYstQEkQDBD66flrO7UagiS4/UXcepSzP/JuNx9ybbaCrb+RqdePq4/HE/9
	 AhJ50hrneKzZrT1AOGebSbGX7i4oAJPMz0Ds84z8hNm1+kAGRS9905Oj80M2XUeluo
	 E4CNWOZBMBAZfGTe0QXlbGGvc0RGhQ1tbQKlG1UwZmQj7dJ+jJeDmLQd3GZ+jKUhl/
	 F37aHh/y92TTZzRmWpr+ym0RwpucLQ4I1hGV3nzsnG7LuJt8u8dc2lfzVsPdLzAmUH
	 it8Vq5/LkP+GQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1A65680D58;
	Tue, 27 Oct 2026 19:22:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id EB6E3473
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 19:22:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DD099401A0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 19:22:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3UR3AwK_PfIk for <intel-wired-lan@lists.osuosl.org>;
 Tue, 27 Oct 2026 19:22:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 688644006F
Authentication-Results: smtp2.osuosl.org; arc=fail smtp.remote-ip=198.175.65.10
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793128953;
 b=Be47gLftluIItTKYyJyDvs1vWTBfmeyyw2MBLD65iEAEIjNyo6q6q1HWHc8w8fDhdzxw
 0yQsRHoedyeNn+Varn2A9BG/P+BIbIC4oyi3/PQ3s+ZTN+bbyaJG3mIJSTqwyNECIP8ho
 ZpRSpEq+hQKn1NEnpdPjzuh9pTmbZZysZPsCgg6wAcOBkgvMeALHEjPJ6b5D4cgu3eiUY
 wgLLEaFD7v/J6bVYv30/CoqLQKLwaoEUhHRlzdNOmIvaGMl3XOMai3GLscEle+W9sdxAd
 gD52r4pbNWRPr9f9yx4Xnu+4jlpLqPG1jo8M77nb0nS8x+Y8bJQxYonENV8rOv1Fc+w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793128953;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:
 References:From:Content-Language:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 bh=WrjJ210tUx+GDtjvq8dmmpooB5aVjih5AHs4ZvOtsFY=;
 b=RPlLfsDAuFOPnSOACKPjVF3fs/B1DT9ACxfVeUnG8+/f/QNehW9XlCaBPH4/ZasjUVTM
 gQZXFeHyOiTZeXeMTgI6ylY1Stw4Xqxp4Yt0+XBzXMxzWT7wV5lc+XHEPhXCowroN5+cb
 hxlz5LYVp5aMbq2mIpQ8tmvFakB63dZX6k2GAukl2EtfhF0d4pFLAKkKcCPOpeYgO+CCZ
 ARcayR8M/yB2/wZ5e08niRgJtfPykvH5z/beIQ+tKLHh/VeiqdI29d08USAfA3rlL5jh6
 a2a5EYvbb8FsdztLNvuaQdJ5/psaegESzhLFxN14KywSIBJ+HSSkDfCffG01PRkmQHg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=id8XFGwU; 
 arc=fail smtp.remote-ip=198.175.65.10
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.10;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=id8XFGwU
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 688644006F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 19:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793128954; x=1824664954;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=0pePTGYxMkROE8eGdV9jJNE0dtoVG/0CcB02lDULthI=;
 b=id8XFGwUPNmKR8do7aNeYcAUrP3j3URvxs1MYFjXzdF7Ad868QftiEHf
 7ZantKLdZyZSAOOVIG0z9DkuA882H9zB9lP/iZ6Ydu9oM/8Z4snDS/WjJ
 oPc3QTgUGIjlzJCGC/E8ZnasuCWBxBKFl7rAfVdBe1Wsn4bd7PPAvFmfX
 jKx5NeFCZ1l0VAa/N7wQC2j09FiRa/r1wcAXnhSSLGZ6jGDNyH6Gvb69F
 fEazYvpVfFup4cXbQOcrCMJ59pB/SwWrknqLO/a1eakgW1N7FbgCgeiiI
 P4R0q5ReLyhzhJkUulTCtvu8aUawuPL5FULiAHaqp+JuQnYGLaiPcKLmX A==;
X-CSE-ConnectionGUID: K6XaYiDEQj2QEDJ6XMrTOQ==
X-CSE-MsgGUID: O+rI1TV8RPqM4kUR54dVWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1731253"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1731253"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 12:22:33 -0700
X-CSE-ConnectionGUID: g5blVs8hRsy8QJ40AXinYg==
X-CSE-MsgGUID: PanwR3plQtGhtJFbRct8KA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4716338"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 12:22:32 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 12:22:31 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 27 Oct 2026 12:22:31 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.45) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 12:22:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mb4GJGvJxT8bbcu6mug78MW32Nnonh4RJqKA3J1QmojVLFNC3K6sucB5l5zMAQtlDj0N/mdu1R6T17LWO/FDsIyUsy+Wxa//wCzdG1a1anmltHhfxq4qCBFvpQMmoJb2Fq21r9Q4J9Fuj2azGb5J4yS6M6VTIJ6yb31sk64zB6LLBkuMVKKZ9cTwoY09Yo2Yfjl2QVDm6UORG12GvV0mymQOmXRB3mpzGtvx+lM5FbauQGhqqrLLbYynNh1DF6XshE5Ltb14uWbkpmTd8XiNbg7GXOldGiR9n0il1wADc19egt+IuFfFYz7AiJ25xQTWZBrGuo7NKLwZD1lig6oGvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WrjJ210tUx+GDtjvq8dmmpooB5aVjih5AHs4ZvOtsFY=;
 b=Lb8vQqtCEvRY8BcghsZD86VI5JxvcqXW7X3nTH11hJ9rlVXk6wMWBInTKWmqzQfYQE5TmzIGFrk75OvmGUmjiLXJ2Mf2PKi+zIa+Tvwk4Nh10nLpyqUh4XkBiuTllQVSEW4IMYxiOKcbtJSeB/3Dqv6noXPj+/y5DFtWwM7EACkZRy7DwuTldy1UZ8AEzq3SgQRFcv2oy4iVmGsrqX3VyDPIVVyZETxCjTZSGo5kSrFCiu7qC+zJkM42wtKAhI1r42xkATEuyYf+5STk1svx166SHJdWQ5gv0AMHTmR6t8bsPsfe0O6UNsJAQBB6frwWik32mdYx17COroqqr7XMag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by CH3PR11MB141418.namprd11.prod.outlook.com (2603:10b6:610:362::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 19:22:30 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 19:22:30 +0000
Message-ID: <cbee478d-c729-422a-8f52-117de23f2c12@intel.com>
Date: Tue, 27 Oct 2026 12:21:14 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net 2/2] ice: use struct timecounter for E825 and E830
To: <sashiko-reviews@lists.linux.dev>, Intel Wired LAN
 <intel-wired-lan@lists.osuosl.org>
References: <20261023-jk-e825-e830-timecounter-v1-0-e932602f0d16@intel.com>
 <20261023-jk-e825-e830-timecounter-v1-2-e932602f0d16@intel.com>
 <sashiko-outbox-183498@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-183498@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0279.namprd04.prod.outlook.com
 (2603:10b6:303:89::14) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|CH3PR11MB141418:EE_
X-MS-Office365-Filtering-Correlation-Id: fbda2b98-a062-435d-256e-08df345fa4c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|261026121527099003|4143699003|11063799006|56012099006|261021121427099003|261009223027099003|261022075727099003|261022105027099003|261021123027099003|3023799007|10067099003|18002099003|22082099003|6133799003|261026140227099003;
X-Microsoft-Antispam-Message-Info: YRXe5twYHwBtlW1hxAIZf9ofWrLg/gxP8ulRm6vE0nBLbfSBdxfYT+yiiJb1JgCzvk10nYLNIPq67+fYPsOxgcVpBfv2yJoH7daL9D9IHgzsS/nSlwvSt/Pv2w6LchYjAfddz2Jj3V29uBhaIoXhGCzdmahl12V/Pj2zxmqG+i47GlhghuU788OgGfeepFrpzyoOaCnK6lGSNYwQyLOkrAw+I7H3FqcKSQQSV4MwZfHEPQfmek6sH7D+KFrHG6Z2MQlSshDzVoOcLJ4lGU7963joLs6h95KOmhEdAtL+DJnLO2PHO2nXZ+fzsADZFTRB+Wkhl1Od6JF9jy4Te2LEK+Q3f2PxDcYkXCniu5a3Pmd/11Tkcr6P3HfPJRH0DoirBLAeSNcgE5vZmNJVmXBp9I7lTBGZLIuAHME8U189pX91ep2K+4qB4vcm9wZL5P+eISIJaZvGQTwmNf7CIzIKssO7MlkxF7d3hbR3Fz/Y4NjwWUUgIUqAq0Zb5jyafffvTV7gpnnWSl03ZH/8s1Lp9A0LkvShfqjIRiBr15qrL+oYJA5Tbp9074b+rC9B52eZ8Sn/WbiGLOV58A9ErjYlgTePX9Ma+72uLJHVfQZjeC4GNvo2myOMuqe69W3VRbQBura8so9btRuouzNDGw+RvTcikV5XdBemSXO4xOfSlm4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7381.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(261026121527099003)(4143699003)(11063799006)(56012099006)(261021121427099003)(261009223027099003)(261022075727099003)(261022105027099003)(261021123027099003)(3023799007)(10067099003)(18002099003)(22082099003)(6133799003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1V5R2pvaFdIWTFReUU1NEJnMWFTb1hqZkxhZlN2YmlXRWxTL3N3bnd1UXZP?=
 =?utf-8?B?UEdXY3J4cWJqODBaTGJtUUdYV3NacHNua0orempFTGhPaXJocmJxVFlubldi?=
 =?utf-8?B?ME03RGVYalA2VkZ6T3dlblVvcGZTVDR3SUhWeW9KeFpBQUtML2RRN2JvQ2NY?=
 =?utf-8?B?TXRTNy9xODAwL1l3N0dPRTBkZkpDY1RjbnRROXNqdCtNY21ubEZnQ1k1QzVj?=
 =?utf-8?B?RTJPMHJBQXNTS0NhbnVmNkpkOXFWdzUwY09QSDRqNWo3djVXbDJhUkVTbE5k?=
 =?utf-8?B?UnhxRE9RVnYwQ01yUzliU2FwRmE1WDk0dFlGdjA5dWVKYkgxV1NuS2lXM0Zj?=
 =?utf-8?B?VlFkc3FCU3pNSXh5MHVmSWM4WW02dW8xWlFSQ0NIdmFsK3cwZGdta1JhNmxW?=
 =?utf-8?B?ajV4Q1RYWS9xajRRRnpnakdsUUlybVNyQVByaUN2NHFIYi9qNFg5RXpGLzlk?=
 =?utf-8?B?N0V1WUZPY3VEeEJoK0ErRXY1cWxOTDVXYnl5b3Q2eTdQRFpKTDY5bGhybEUr?=
 =?utf-8?B?VFZvdWkwNTBXTktWU2FPaGt5UW5KTXJnNFdqL3RHc0tiYnVyWWVocEtkMlNZ?=
 =?utf-8?B?a3ZPMUQxcUxKWXdEQ20zZXpTMWNsRUZKM09GQ0daVDZrd2VBc2tBTVhzNk9M?=
 =?utf-8?B?Tm1SM1FGVWZKRFFDUWM0V05sTzBJaHllL2FNV0dzenhITGl6NjR4Wi9VQk5D?=
 =?utf-8?B?bXpnRnRHZk9qeVR0V25YL3lWWmgxNy9EejNpV1BRaG1pYVh3bUhUbUIyWUN5?=
 =?utf-8?B?MkdpUUlJUHBWNWdkaEIza0VPQzdqVUNSN3RiNHQ5cU9CdS9VNFd5RVdHd3V3?=
 =?utf-8?B?OXU0ZmV6NmRhUGM3Wk5kZXRZSyttNm5BaUl0V3Zkc2g5MDlVcVRTakRRalhI?=
 =?utf-8?B?TGhoL3BkL3UzNGdEZWFsVkRjYUhkT2wwVWt3Y2xwTlFVRXB5N1d4dVVjYVZN?=
 =?utf-8?B?WXpJQ3hSUTBsNU5uR2MwUFIzalM5SjhFNEtaSkNNNktzRndpUWQ5VEJ5M3lM?=
 =?utf-8?B?VTdwWFJTb3MzdUVjd1dMVlI0bHd2SVpvMkwvZjZJeEVzVnovZ3JkSHZSV1NR?=
 =?utf-8?B?Wjlua2lLV0xSUWdYZU1lemtFM1krZlcvK3g5S2Q4MGtYNFFMM212M1B1NThi?=
 =?utf-8?B?V2JsS3BoS2dBb0xhb2Q4cTR6MS9PTEdwak9JOC9wVEsyTVkwRS9TMUIvTGpn?=
 =?utf-8?B?NFllK3NoRnErcDBxa0QzSTRnWXNSM0g5TFNXZmt5czNRWWMwelIyUHFML2ZT?=
 =?utf-8?B?anhkMkdxQkRiMWtaV3pBMyt5UGlEZXVTUnlhZmVCRGMxaVoxT3ZXZkZGbVVt?=
 =?utf-8?B?RitPNzZXZ2crT1lNdGxBOFdLd2hlUWpUNjhwSWEySm5HaHJwdXRDSmpWeWpo?=
 =?utf-8?B?OWxjZDI0Rm1Zb1RJc0dxZ3ZwMU1tK2Z0dWlFNmV5Q0hJQzl5YUZvODZreFNO?=
 =?utf-8?B?blRKUlJ1VHMrOExhTU52ODc3WVd4c01KOExEd0EvY0xRY0lLeUE2RWhtWWRX?=
 =?utf-8?B?U3QyYm15bnNYUkJieVV2VWEvRjZEYVlBMW85QUtkeUpXWUEraVFIN0VUalRZ?=
 =?utf-8?B?bzBuSWRuOElmamhXM3dYRndSTkUxOUZsSUNmc2RZMUIxT25SemJyL2RzMDZw?=
 =?utf-8?B?ZlErTjF6bU1mUEg1VjIyOUFVNXdPaVYxVVYxQnRabTVjNzBNaGFtekc5YjBu?=
 =?utf-8?B?VVQ4ZG9ndUt3YUFyd1lKVUpQWkpKTlYveS9pTHNYaDEyTXFuVGszU0trWXFN?=
 =?utf-8?B?SXhuWnk5M1c3ckxmTlo0MHdSS3pXT015UlJCS3hKVGdvZEludnZpZ3ZiTndL?=
 =?utf-8?B?M2NxNXhhRDdSdmtmTCtyZGFjNVZ2endINUxuNWM3WnFMQktkZWx3RVpVaGlo?=
 =?utf-8?B?RlRGeW5TWWdyRXNHeU51TnFVTVBYYkJsTnQrb1dWSmtWaktTY2FMRzFhZ05U?=
 =?utf-8?B?ajAwZzJCWk5FT3V1TWVISlN1QllkOWlrU1Jpd2FNUkdOMTZBc3NCY0xZWmFB?=
 =?utf-8?B?Umk0VEZmVDhLTFk5WWVNdlhCczBqUmFPOWh1NWJtQk1LY0Q2YzhwVXkzYkgx?=
 =?utf-8?B?M3FFZXJRMGphYkd3Qi9vOEZhREtnNmNNdmtIMVN3Y25MRDZxdUN1RFUzaVF5?=
 =?utf-8?B?M2FTc1d0U1JXa3dUWXpCQjJyaGZlamlhN0ZsbHFmSTdsZSs1N2U2d0FlL3ly?=
 =?utf-8?B?b3ZJNlh2dmJhSUMvTlMzNGVRRklJODBrelBCaVlXdUZRU0RCM3d0SStMdkVo?=
 =?utf-8?B?Mmk0Rk9Wa1E1YmlTQ2d4U3NoeHN0a1o2Vkliai9RVG5tMnVYeFJ2VnhMTStI?=
 =?utf-8?B?NTlYMm5QV0xCVWpRR005VEh4RW0rRmxxSGIvU2xHT0lMMk0rakJOL2JqSXFX?=
 =?utf-8?Q?XcgUxWpeiXY8cwDs=3D?=
X-Exchange-RoutingPolicyChecked: 4DSk8uyIVUuSi2UYnd2wCIIgAmTiVmnAdcqd/ZUMH0mGZMUcE9BYojmDsHIvcuV/JtTJlVruzxACwkvWPsWuV3/2B/YRCBqQ7205o7n2KLvGobRNe52rK0ek/IsJPbWFbPoxZZ39oE5DOC84k0sdddmn1T8SHAY6DVtVXcC1or192mj2dWzVf8I6byC3cO3s28RWVwBDwx8zuNN9I/q8hTrHsvowt1aE2Kjg9XhbfdaiDqdh6PO6iO9Wwx8w1Suppk+05SaYaVouiuYZV8d5xEJ+nRnWZA5NIgmbtZmfnMpVmTd/EDOMRbOL+PSgMgrF8RRpb1e2YkIls7b7mP6BZQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: fbda2b98-a062-435d-256e-08df345fa4c3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 19:22:30.2286 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v8q0DttH+lX9T2R8BlLalYhEk8EllcgxV9WHzGHXmyBozgyjEflkSwEGzpcaXV4KZSfvP4w61Z4Rqf9dUKSAKvNFoWWejjK/E7T7pbLoVvY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB141418
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
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,T_PDS_OTHER_BAD_TLD,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/23/2026 6:55 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 6 potential issue(s) to consider:
> - [High] ice: 500ms offset before ice_phc_cyc2time() in ice_ptp_cfg_perout() wraps
> - [High] ice: uncompensated timecounter offset for E830 TxTime in ice_tx_map()
> - [Medium] ice: late PHC update check broken in ice_ptp_update_cached_phctime()
> - [Medium] ice: missing timecounter conversion in ice_vc_get_phc_time()
> - [Medium] ice: missing timecounter staleness and validity handling in ice_phc
> - [Medium] ice: ice_ptp_prepare_for_reset() converts zero GLTSYN_TIME via timecounter
> --
> 
> commit 348b48a49347fa2790d183338857035e4d8f1fa4
> Author: Jacob Keller <jacob.e.keller@intel.com>
> 
> ice: use struct timecounter for E825 and E830
> 
> This commit switches E825 and E830 PTP hardware clock management from direct
> hardware timer adjustments to a software struct timecounter and cyclecounter
> embedded in struct ice_phc. This avoids PCS timer synchronization stalls on
> E825 caused by manual PHY timer adjustments and converts timestamp extension,
> clock reads, cross-timestamping, and periodic output configuration to account
> for the timecounter phase offset.
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> index 4b4a00beadd2c..488db8298059a 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> @@ -210,6 +210,38 @@ void ice_ptp_restore_timestamp_mode(struct ice_pf *pf)
>>  	ice_flush(hw);
>>  }
>>  
>> +u64 ice_ptp_read_cycles(struct cyclecounter *cc)
>> +{
>> +	struct ice_adapter *adapter;
>> +	struct ice_phc *phc;
>> +	struct ice_pf *pf;
>> +	struct ice_hw *hw;
>> +	u8 tmr_idx;
>> +
>> +	phc = container_of(cc, struct ice_phc, cc);
>> +	adapter = container_of(phc, struct ice_adapter, phc);
>> +
>> +	scoped_guard(rcu) {
>> +		pf = rcu_dereference(adapter->ctrl_pf);
>> +		if (!pf)
>> +			return 0;
> 
> [ ... ]
> 
>> @@ -995,19 +1046,17 @@ static int ice_ptp_init_tx(struct ice_pf *pf, struct ice_ptp_tx *tx, u8 port)
>>   * ice_ptp_update_cached_phctime - Update the cached PHC time value
>>   * @pf: Board specific private structure
>>   *
>> - * Update the PTP hardware clock time values which are cached in the PHC
>> - * structure.
>> + * For devices that use a timecounter structure, update the timecounter.
>> + * Ohterwise, update the cached PHC time used for timestamp extension.
>>   *
>>   * This function must be called periodically by the clock owner to ensure that
>> - * the cached value is never more than 2 seconds old.
>> + * the timecounter or cached value is never more than 2 seconds old.
>>   */
>>  static void ice_ptp_update_cached_phctime(struct ice_pf *pf)
>>  {
>>  	struct ice_phc *phc = &pf->adapter->phc;
>>  	struct device *dev = ice_pf_to_dev(pf);
>>  	unsigned long update_before;
>> -	u64 systime;
>> -	int err;
>>  
>>  	update_before = phc->update_jiffies + msecs_to_jiffies(2000);
>>  	if (phc->cached_time && time_is_before_jiffies(update_before)) {
>> @@ -1018,21 +1067,33 @@ static void ice_ptp_update_cached_phctime(struct ice_pf *pf)
>>  		pf->ptp.late_cached_phc_updates++;
>>  	}
>>  
>> -	/* Read the current PHC time */
>> -	err = ice_ptp_read_src_clk_reg(pf, NULL, &systime);
>> -	if (err) {
>> -		/* The source clock is gone, so the cache can no longer be
>> -		 * refreshed. Publish zero instead of leaving the last good
>> -		 * value behind: neither ice_ptp_get_rx_hwts() nor
>> -		 * ice_ptp_extend_40b_ts() may extend against a value that no
>> -		 * longer tracks the PHC, and both treat a zero cache as
>> -		 * "no timestamp".
>> -		 */
>> -		WRITE_ONCE(phc->cached_time, 0);
>> +	WRITE_ONCE(phc->update_jiffies, jiffies);
>> +
>> +	if (phc->use_timecounter) {
>> +		unsigned long flags;
>> +
>> +		write_seqlock_irqsave(&phc->tc_lock, flags);
>> +		timecounter_read(&phc->tc);
>> +		write_sequnlock_irqrestore(&phc->tc_lock, flags);
>>  	} else {
>> -		/* Update the cached PHC time stored in the PHC structure */
>> +		u64 systime;
>> +		int err;
>> +
>> +		err = ice_ptp_read_src_clk_reg(pf, NULL, &systime);
>> +		if (err) {
>> +			/* The source clock is gone, so the cache can no
>> +			 * longer be refreshed. Publish zero instead of
>> +			 * leaving the last good value behind: neither
>> +			 * ice_ptp_get_rx_hwts() nor ice_ptp_extend_40b_ts()
>> +			 * may extend against a value that no longer tracks
>> +			 * the PHC, and both treat a zero cache as "no
>> +			 * timestamp".
>> +			 */
>> +			systime = 0;
>> +		}
>> +
>> +		/* Update the cached PHC time stored in the PF structure */
>>  		WRITE_ONCE(phc->cached_time, systime);
>> -		WRITE_ONCE(phc->update_jiffies, jiffies);
>>  	}
>>  }
> 
> [Severity: Medium]
> In ice_ptp_update_cached_phctime(), the check for late updates still tests
> phc->cached_time:
> 
> 	update_before = phc->update_jiffies + msecs_to_jiffies(2000);
> 	if (phc->cached_time && time_is_before_jiffies(update_before)) {
> 		unsigned long time_taken = jiffies - phc->update_jiffies;
> 
> 		dev_warn(dev, "%u msecs passed between update to cached PHC time\n",
> 			 jiffies_to_msecs(time_taken));
> 		pf->ptp.late_cached_phc_updates++;
> 	}
> 
> When phc->use_timecounter is true on E825 and E830 devices, phc->cached_time
> is initialized to 0 in ice_adapter_new() and is never written. Won't this
> cause the condition to always evaluate to false in timecounter mode,
> preventing late timecounter updates from ever emitting the warning or
> incrementing pf->ptp.late_cached_phc_updates?
> 
> Also, by moving WRITE_ONCE(phc->update_jiffies, jiffies) above the
> if (phc->use_timecounter) branch, phc->update_jiffies is now updated on
> legacy devices even when ice_ptp_read_src_clk_reg() fails and systime is set
> to 0. Should phc->update_jiffies only be updated when the clock read
> succeeds, and should the late-update check also cover timecounter mode?
> 

Yea, this makes sense, I think I can re-order things to make that work.

> [ ... ]
> 
>> @@ -1793,8 +1859,9 @@ static int ice_ptp_write_perout(struct ice_hw *hw, unsigned int chan,
>>  static int ice_ptp_cfg_perout(struct ice_pf *pf, struct ptp_perout_request *rq,
>>  			      int on)
>>  {
>> +	struct ice_phc *phc = &pf->adapter->phc;
>> +	u64 clk, period, start, phase, cycles;
>>  	unsigned int gpio_pin, prop_delay_ns;
>> -	u64 clk, period, start, phase;
>>  	struct ice_hw *hw = &pf->hw;
>>  	int pin_desc_idx;
>>  	int err;
>> @@ -1840,12 +1907,21 @@ static int ice_ptp_cfg_perout(struct ice_pf *pf, struct ptp_perout_request *rq,
>>  	if (err)
>>  		return err;
>>  	clk += NSEC_PER_MSEC * 500;
>> +	if (phc->use_timecounter) {
>> +		cycles = clk;
>> +		clk = ice_phc_cyc2time(phc, cycles);
>> +	}
>> +
>>  	if (rq->flags & PTP_PEROUT_PHASE || start <= clk - prop_delay_ns)
>>  		start = div64_u64(clk + period - 1, period) * period + phase;
>>  
>>  	/* Compensate for propagation delay from the generator to the pin. */
>>  	start -= prop_delay_ns;
>>  
>> +	/* Compensate for timecounter phase offset, if necessary */
>> +	if (phc->use_timecounter)
>> +		start -= (clk - cycles);
>> +
>>  	return ice_ptp_write_perout(hw, rq->index, gpio_pin, start, period);
>>  }
> 
> [Severity: High]
> In ice_ptp_cfg_perout(), 500 ms (NSEC_PER_MSEC * 500) is added to the raw
> hardware clock value before passing cycles to ice_phc_cyc2time():
> 
> 	err = ice_ptp_read_src_clk_reg(pf, NULL, &clk);
> 	if (err)
> 		return err;
> 	clk += NSEC_PER_MSEC * 500;
> 	if (phc->use_timecounter) {
> 		cycles = clk;
> 		clk = ice_phc_cyc2time(phc, cycles);
> 	}
> 
> Since phc->cc uses CYCLECOUNTER_MASK(32), timecounter_cyc2time() treats any
> cycle value where (cycles - tc->cycle_last) & 0xffffffff exceeds
> cc->mask / 2 (~2.147 seconds) as having occurred in the past, subtracting the
> delta from tc->nsec instead of adding it.
> 
> Because cycles is already 0.5 seconds ahead of the current hardware counter,
> doesn't this shrink the forward window before wraparound from ~2.147 seconds
> to ~1.647 seconds? If tc->cycle_last was updated between 1.648 and 2.0
> seconds ago (within the normal periodic update window, or during
> ice_ptp_adjtime_tc() -> ice_ptp_enable_all_perout() where tc->cycle_last is
> not refreshed), ice_phc_cyc2time() will wrap backwards by 2^32 ns, making
> (clk - cycles) and the resulting GLTSYN_TGT_L/H start time off by 2^32 ns
> (and shifting the periodic output phase by 2^32 mod period).
> 
> Should ice_phc_cyc2time() be called on the raw clk value before adding
> NSEC_PER_MSEC * 500?
> 

Hm. Ya that seems correct. Can fix.

> [ ... ]
> 
>> @@ -2414,15 +2546,9 @@ u64 ice_ptp_get_rx_hwts(const union ice_32b_rx_flex_desc *rx_desc,
>>  		return 0;
>>  
>>  	cached_time = READ_ONCE(pkt_ctx->phc->cached_time);
>> -	if (!cached_time)
>> +	if (!pkt_ctx->phc->use_timecounter && !cached_time)
>>  		return 0;
>>  
>> -	/* Use ice_ptp_extend_32b_ts directly, using the ring-specific cached
>> -	 * PHC value, rather than accessing the PF. This also allows us to
>> -	 * simply pass the upper 32bits of nanoseconds directly. Calling
>> -	 * ice_ptp_extend_40b_ts is unnecessary as it would just discard these
>> -	 * bits itself.
>> -	 */
>>  	ts_high = le32_to_cpu(rx_desc->wb.flex_ts.ts_high);
>>  	ts_ns = ice_ptp_extend_32b_ts(pkt_ctx->phc, ts_high);
> 
> [Severity: Medium]
> When pkt_ctx->phc->use_timecounter is true, ice_ptp_get_rx_hwts() bypasses
> the cached_time check and does not check phc->update_jiffies (unlike
> ice_ptp_extend_40b_ts()) or whether the clock owner is active.
> 
> Because timecounter_cyc2time() with a 32-bit cyclecounter is only valid
> within +/- 2.14 seconds of tc->cycle_last, what happens if the periodic work
> is delayed past 2 seconds, or if the clock owner PF on a multi-PF adapter is
> unbound in ice_ptp_release(), fails ice_ptp_rebuild(), or fails
> ice_ptp_init_owner() after setting phc->use_timecounter = 1? Won't sibling
> PFs continue extending Rx timestamps against a frozen or uninitialized
> phc->tc instead of returning 0?
> 

True. We weren't checking jiffies before because it wasn't accessible
and partially because it was considered expensive and not worth doing
for the per-packet Rx timestamps.

We can fix the

> Relatedly, in ice_ptp_release(), ice_ptp_cleanup_adapter() clears
> adapter->ctrl_pf before cancelling pf->ptp.work and unregistering the PTP
> clock, which allows ice_ptp_read_cycles() to observe a NULL ctrl_pf and
> return 0 as a valid cycle count into timecounter_read() or
> timecounter_init(). Also, ice_ptp_init_owner(), ice_ptp_rebuild_owner(), and
> ice_ptp_settime64_tc() call timecounter_init() without refreshing
> phc->update_jiffies, which can leave phc->update_jiffies stale across a reset
> until the periodic work runs and cause ice_ptp_extend_40b_ts() to discard
> valid Tx timestamps right after ice_ptp_restore_timestamp_mode().

Strictly, i don't think I had really intended the jiffies protection to
be applied to the timecounter logic. But I can fix that. Additionally,
ice_ptp_read_cycles() is actually only ever called from the periodic
work (all other callers should be using timecounter_cyc2time to avoid
modifying the timecounter unnecessarily and causing the seqlock contention).

I can try to rework this to fix that.

> 
> [ ... ]
> 
>> @@ -3133,8 +3266,11 @@ void ice_ptp_prepare_for_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
>>  
>>  	/* Acquire PHC and system timer to restore after reset */
>>  	ptp->reset_time = ktime_get_real_ns();
>> -	if (ice_ptp_read_src_clk_reg(pf, NULL, &ptp->phc_reset_time))
>> -		ptp->phc_reset_time = 0;
>> +	if (ice_ptp_read_src_clk_reg(pf, NULL, &ns))
>> +		ns = 0;
>> +	else if (pf->adapter->phc.use_timecounter)
>> +		ns = ice_phc_cyc2time(&pf->adapter->phc, ns);
>> +	ptp->phc_reset_time = ns;
>>  }
> 
> [Severity: Medium]
> When a hardware reset (such as CORER, GLOBR, or EMPR) has already cleared the
> GLTSYN_TIME registers to 0 before ice_ptp_prepare_for_reset() runs,
> ice_ptp_read_src_clk_reg() on the clock owner PF returns 0 with ns = 0.
> 

I am not certain this is actually possible, I would have to check if
those resets actually do clear these registers.

> Previously, ns = 0 resulted in ptp->phc_reset_time = 0, causing
> ice_ptp_rebuild_owner() to fall back to ktime_get_real_ns():
> 
> 	if (ptp->phc_reset_time) {
> 		time_diff = ktime_get_real_ns() - ptp->reset_time;
> 		ns = ptp->phc_reset_time + time_diff;
> 	} else {
> 		ns = ktime_get_real_ns();
> 	}
> 
> With phc.use_timecounter enabled, the else-if branch passes ns = 0 to
> ice_phc_cyc2time(&pf->adapter->phc, 0), which computes a 32-bit delta between
> cycle 0 and the pre-reset tc->cycle_last. Doesn't this turn a zeroed hardware
> register into a non-zero ptp->phc_reset_time shifted by up to +/- 2.147
> seconds, bypassing the ktime_get_real_ns() fallback in
> ice_ptp_rebuild_owner()?
> 

I'll try to fix the logic regardless.

> [ ... ]
> 
>> @@ -3375,10 +3522,21 @@ int ice_ptp_clock_index(struct ice_pf *pf)
>>   */
>>  static int ice_ptp_init_owner(struct ice_pf *pf)
>>  {
>> +	struct ice_phc *phc = &pf->adapter->phc;
>>  	struct ice_hw *hw = &pf->hw;
>> -	struct timespec64 ts;
>>  	int err;
>>  
>> +	switch (hw->mac_type) {
>> +	case ICE_MAC_GENERIC_3K_E825:
>> +	case ICE_MAC_E830:
>> +		/* Use struct timecounter for E825 and E830 devices */
>> +		dev_dbg(ice_pf_to_dev(pf), "PTP 1588 enabling timecounter mode\n");
>> +		phc->use_timecounter = 1;
>> +		break;
>> +	default:
>> +		break;
>> +	}
> 
> [Severity: High]
> Enabling phc->use_timecounter on ICE_MAC_E830 means the hardware
> E830_GLTSYN_TIME registers are no longer initialized in ice_ptp_init_owner()
> or ice_ptp_rebuild_owner(), nor adjusted in ice_ptp_settime64_tc() and
> ice_ptp_adjtime_tc().
> 
> However, E830 supports ICE_F_TXTIME hardware offload:
> 
> drivers/net/ethernet/intel/ice/ice_lib.c:ice_init_feature_support() {
> 	if (pf->hw.mac_type == ICE_MAC_E830) {
> 		ice_set_feature_support(pf, ICE_F_MBX_LIMIT);
> 		ice_set_feature_support(pf, ICE_F_GCS);
> 		ice_set_feature_support(pf, ICE_F_TXTIME);
> 	}
> }
> 
> And in ice_tx_map(), the TxTime descriptor timestamp is populated directly
> from first->skb->tstamp without compensating for the timecounter phase
> offset:
> 
> drivers/net/ethernet/intel/ice/ice_txrx.c:ice_tx_map() {
> 		ts = ktime_to_timespec64(first->skb->tstamp);
> 		tstamp = ts.tv_nsec >> ICE_TXTIME_CTX_RESOLUTION_128NS;
> 
> 		ts_desc = ICE_TS_DESC(tstamp_ring, j);
> 		ts_desc->tx_desc_idx_tstamp = ice_build_tstamp_desc(i, tstamp);
> }
> 
> How does ICE_F_TXTIME work on E830 when the PHC time is maintained in the
> software timecounter while the hardware TxTime queue compares descriptor
> timestamps against the unadjusted hardware clock?
> 

This may be somewhat tricky. We need to compute the inverse of the
timecounter phase like we do with periodic output.

> [Severity: Medium]
> Similarly, when an SR-IOV VF requests the PHC time via
> VIRTCHNL_OP_1588_PTP_GET_TIME, ice_vc_get_phc_time() in
> drivers/net/ethernet/intel/ice/virt/virtchnl.c still reads the raw hardware
> register without converting through ice_phc_cyc2time():
> 
> drivers/net/ethernet/intel/ice/virt/virtchnl.c:ice_vc_get_phc_time() {
> 	if (ice_ptp_read_src_clk_reg(pf, NULL, &phc_time->time)) {
> 		v_ret = VIRTCHNL_STATUS_ERR_NOT_SUPPORTED;
> 		len = 0;
> 	}
> }
> 
> Furthermore, in the VF driver, iavf_ptp_extend_32b_timestamp() in
> drivers/net/ethernet/intel/iavf/iavf_ptp.c computes:
> 
> 	u32 low = lower_32_bits(cached_phc_time);
> 	u32 delta = in_tstamp - low;
> 
> which assumes the lower 32 bits of the PHC time returned by the PF match the
> raw 32-bit hardware timestamp domain in the Rx descriptor. Won't enabling
> phc->use_timecounter on E825 and E830 break both VF PTP clock reads and VF Rx
> hardware timestamp extension?
> 

We can use ice_phc_cyc2time to convert the time reported to the VF, but
then the raw timestamps captured won't convert properly with timestamp
extension (they lack access to the timecounter). I think we need to
disable Rx timestamp offload until we figure out how to resolve this.
