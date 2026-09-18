Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12CE9C982D7
	for <intel-wired-lan@archiver.kernel.org>; Fri, 18 Sep 2026 17:59:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C131840BE6;
	Fri, 18 Sep 2026 17:59:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xEHsKQfiCRxY; Fri, 18 Sep 2026 17:59:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E2F2940BFB
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789754391;
	b=J/9K4Bje0CAWAsPRxplTirI+mpX8o3+kKoiTdyQD5yBH54IQV7oPk/ds9dB/aNsCk+DI
	 Uuf7Nl2MMvcUkv6ZVP5zMDaa0ptM4GZuRAgN5Nr+bQ8+xf+NE3Q1uwkVFXwnwXDM1IybR
	 axT0yAM1oiS4vOBKt3QEyjgE4wTGdgrCyifYNHIW2aXjzxIiPolMXS8+H/RNn5dhcX7VA
	 RUFON9HaJJv8NgSESRWWm/H0jglYAtXIxEy4ThYpO35ts4sI358YhJ2P7HCPlK7VPdq8I
	 U55vUXZOWB16hJLvm0ZY6WsUIXCSx7KVFa4cN9agg0JE72/voF42gxDUszi+iM3eqCA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789754391;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:Received:Received:
	 Message-ID:Date:User-Agent:Subject:To:CC:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
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
	bh=RVwlzK4CFQGiWw3/kzTWjj0z5xLezSFnnRxaZjwrBf0=;
	b=lkJmuLf0M16H71JYO+HywZOWSpa+NTcD5r/cy9t2XDTftiyymSPbzCHt/YT6KfjvaM+u
	 RG6DIw6qwVxTVgRQ+2dxj6h3DLqJ+ATmf7ovmZtYXcVTz37nuBrAW0gmUsmFkTYvmzBvn
	 jIvkHMtgpLss8eC4tGmYX170jd+5QsCAS79pHB4831YCOEtnPHkYEEsigXqLC/XlbvmK4
	 E/KsL/Ua88t/G0khgZW0mECKtaqxyUr4iHq7gKG/W2CvJlloF8kvARwTTgkaJlOEtUk9B
	 K7dZnTkZB25BsP3YN8erFW66kc6N//Gg/6/zPKv69/CO9voatlnfgTUp2n3h7QUV4yQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789754390;
	bh=RVwlzK4CFQGiWw3/kzTWjj0z5xLezSFnnRxaZjwrBf0=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VvgqSxrPtCw7bVmLZ/Qcwt+rJ/VAKbVSrZYc3YLu4xEjhLt2AJIVLvuIU8//45B8t
	 NFqgH6HQ4RagmcT6mIZLqX1gNFJwuCepITKpx2UZHvW69/9KNhsrdYGZvipu4nQEA/
	 4XcoujU8mgCnVCRy3awZIhmBfTHY28pw/IiRHVpCCOCvKUVx3ms+t9nSEl3Ps2Tfdh
	 StIr5P73MpgSAnsefZNz1wgqVhC4Bs2oX2Lto8WpZe+FcalD3evu842FBLtF9UbrZC
	 xUJa6O/X8rHy7pPIvpXas78zUONm0XEUkS4QHL1HVFfx0jgGkMkuSHsDGNg4QSar5s
	 4513DIqlIzi6w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E2F2940BFB;
	Fri, 18 Sep 2026 17:59:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4B8DC237
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 17:59:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3178060D86
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 17:59:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5U62LzT64AjE for <intel-wired-lan@lists.osuosl.org>;
 Fri, 18 Sep 2026 17:59:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5265B6060E
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=192.198.163.7
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789754388;
 b=Uw8FYXSW+vMEi0OJn10eeYoU+Bz9L5sN4M/Idu7GDmX1awrTJfC/kb7pGEFjnf2hRMkT
 0LdLL2/o/laPg4H6suXFBqMy2u6Q1toNhB6+46ULjUCCuQRDUg411jLbg+kMaSXr+QVjs
 jw45almsv52ZBpIza5uTpUSzh+A4qPAdUq6APVU8io02BAdS0fgM5POQebkLIPT9cFzBj
 Eva6oRyZLONVNgRVkIJ1kYyYstrHPGQH3yanWANNawG/eMzkCO3BauKQDg4zEN0gpS7s4
 X4Bs/p7OB3R/Brw0lc0PibD9SNFWPi8u9i8HXmziTpQ/vRKFNufZ+0p2mmsUQpXoiZQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789754388;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
 References:Content-Language:From:In-Reply-To:Content-Type:
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
 bh=RVwlzK4CFQGiWw3/kzTWjj0z5xLezSFnnRxaZjwrBf0=;
 b=U8YNlsao3ZxQkym3QqpM6qk8zwYkD4c0EkMs9DmzNCajbFTRQTNeLXPcIrRTMjcFnn33
 qsAPhaTLFI9UD4MaNTFV/8cf5ECLB1RpjisaVQWok3mlYjRALIdSHvffzCMSMMe/0d3+W
 W28gIobAygHai1HdmXrYiNKcJ+DnqKSBeSFF1KL6GRlG020Gr+11aSjgqx6by4vm7mJMA
 VEYEMPf7OdHCK+GCdABwiZ+TnQPxuWp8Fh60udnvVgniDC5D1XbbzmY/vbzN7SzZpFvTq
 bra2lPhaAUKBt3F42LTJLPtvRku5zIjO/UFkbxr1t/H8sXsewb8l3A42tqFZ8QKmDag==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=FCq0jyNX; 
 arc=fail smtp.remote-ip=192.198.163.7
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=emil.s.tantilov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=FCq0jyNX
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5265B6060E
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 17:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789754388; x=1821290388;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Q1sHwzVeg2uzi+BLKCa1kWVlD8aZGZ2e8+edZzJYaW0=;
 b=FCq0jyNX8dULups0/jKX2fCr0MMJFdUVuN21zWS8eQ8GlKZQPGjEWegm
 3qIQNdY/C/D23uCbe0E5FuDcrMoGdqyaBe0A7wp2estdgYwbjlkI3Gfqn
 8u1bT28CTASnUe7cdJC2PkkWDnuUFCS9aMweX8YfRqYa6W+CVhOnjq8sA
 dcp2b+g3743UOhyLR9Wx7F14UxygIkArcUmIgHeBT1MsslLiaAxqyqpuA
 YYoxqADZPzbEcw1RhLdb45kYqVMA3fFgUNUeR0NTJYF2lSHu/vtU/7Svr
 2F04QmskM5SWkkzV6W1FWqChroIvwFid8mJUjy60F2zIDoKfsvnc086OC w==;
X-CSE-ConnectionGUID: bsPo34H2SCqqjcomHyt4Yw==
X-CSE-MsgGUID: CaEO2gqsSmOzYLyI7+4dRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="115809930"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; d="scan'208";a="115809930"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 10:59:47 -0700
X-CSE-ConnectionGUID: bbMjl34ISbmjgZ34ALa0aQ==
X-CSE-MsgGUID: WBgsZEeTQZmXgMKQurXddg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; d="scan'208";a="271846483"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 10:59:47 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 10:59:47 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 18 Sep 2026 10:59:47 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.1) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 10:59:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jwh8dN0LVsLxuqO4HFHEfkZCNv5u6+xr/Z8bPPH2v+k/CsZ6Ky3WDEd4sB33DNEUAWR7T57VVbEm4AOs8OMY0aD3bOQN5UpP6X2sv0EPzodzFU1pnQTSlMWauzvaMNO1qd+MjSBf5WzIT4yEjTB6qe0u97aD7TNdmKrRcGnicGaGzIFyqapbYAAItkgldZx5OYGbjmEsIxI+6T85dDV0K5A70SEubLddCX7wAdyCSRREp9IVXSCSciBUDsL2Rm1WZU+wfXcrTMPEeg4H+GmPhAqd9DGRAl9+D8Vk8k3vsCiDDujpjEqVLX6G7+ypYwOWEpcCPRkdJTAfdIxt/eod7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RVwlzK4CFQGiWw3/kzTWjj0z5xLezSFnnRxaZjwrBf0=;
 b=aPU49eksPUHgH3g0VKDHDgvEtVNBlAzl7iTG6V55LNGMsvjppTOv1xClojfergU6ociafpDattAeww+rXL5NRn8LiyF8csMIRzA8Mh+EkJXLBTfyVZQiSCAVRKzJbFaIDgoxXJ/giRa9attD7jQPw67bbkCw7N0A1U9smFtKlTJ7I3d1o9nQrGDg2tPlkVrOJkYxjp/GC7KiQfE1bhv73QowZjRKQgV2fFEtrdgwuRJzmR98ZrYyPEBxTn/8ITEFBlWFaqwhQolOm2BOYxIF7oDbrwrln+1/dKrRSR5W7PdHH8r3Rn3K0fK5JQDEJQTJHdHRqJKktiD/TQ3/mgFu7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB186312.namprd11.prod.outlook.com
 (2603:10b6:806:595::5) by CY5PR11MB6283.namprd11.prod.outlook.com
 (2603:10b6:930:21::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 17:59:44 +0000
Received: from SA3PR11MB186312.namprd11.prod.outlook.com
 ([fe80::fbe8:9ba6:fcd0:f0b]) by SA3PR11MB186312.namprd11.prod.outlook.com
 ([fe80::fbe8:9ba6:fcd0:f0b%6]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 17:59:44 +0000
Message-ID: <45ffbd03-653c-46fc-b500-07e9b99f295f@intel.com>
Date: Fri, 18 Sep 2026 10:59:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net 1/2] idpf: keep the mailbox up while tearing down
 vports on shutdown
To: Tian Xun Ng <luckilystar08@gmail.com>, <intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, <anthony.l.nguyen@intel.com>,
 <przemyslaw.kitszel@intel.com>, <aleksander.lobakin@intel.com>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <kuba@kernel.org>, <pabeni@redhat.com>, Tian Xun Ng
 <tianxun.ng@bytedance.com>
References: <20260917105205.37561-1-luckilystar08@gmail.com>
 <20260917105205.37561-2-luckilystar08@gmail.com>
Content-Language: en-US
From: "Tantilov, Emil S" <emil.s.tantilov@intel.com>
In-Reply-To: <20260917105205.37561-2-luckilystar08@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0009.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::14) To SA3PR11MB186312.namprd11.prod.outlook.com
 (2603:10b6:806:595::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB186312:EE_|CY5PR11MB6283:EE_
X-MS-Office365-Filtering-Correlation-Id: 87cc0f4e-8f7d-468b-756d-08df15ae9ec4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|56012099006|11063799006|4143699003|6133799003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: TIHtCYNHS4dsTKw9hV0QKuXZ+RdVtDp8fviVQy6K9VBIaR3MWPzFxGh+CprfjvMOmCV+EegYTOeiV7eW0EHENZo6rvMdl26ZzxlfPnA4oz1/vpzs6IY8YY0Jpvf6O+McUZBWhF5aCi35kpZEqsc5+WT2oZGBlwJEQxu4DWw9l3YHULNvoi6c3L0PTYEK5CRDjTXIyVF7roJFIF9sjJ9sg53uxBltmw1svxPpASKYE59q18jeXC93wa2YYUh70vUzkyIGZNmVmaESCaeSP0rSFE3qQPkfxLH7jvKUdIOG0OfFf4ciXGfz6LOl6ChceKjwVkpRIjLQPEPmURXq6cZRVHl43/4Z5cIZM8U/B2rCCQyCjDzCS3wtCZZfwx5dYTeuoctZ0NaxPT+AMEqEnKQVM1h2KcgXYHYJ1UhV1ODI/dWSUXYaC5abPHOU/w7t1kDBX8l2Xn5Uif5fqBND7LiZbnvqzyNoKm+m9Po5SVf9JftpJ93DMyhV9irsk6E+VA5o+TdAFk2GLV9hXxK9RJe/FXqCXF2OvahigLMSxHm4C3Zn7Jgl9Be6nlGWk0+IoVE0CAcX77ATF/h991d9Nkr8fz2/mFKOY7nuC67WpCk20C0c/yRjJG31UV2y8mdvtP5B5d0jF1yTwcIT28qYGiU9II9B0KIUST/5JqBLxuwc32Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR11MB186312.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(56012099006)(11063799006)(4143699003)(6133799003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bU1OU1VQRmp0NzNNQmdwd1prUFBXQ2s4Q0dINU1LTk9uUnNNNnpwVGYyK3g2?=
 =?utf-8?B?N2t6a3RBVGN4YlpuWXh2R0tWNGgzNzIvbTZ6ekFLaGFmQllmOXNsMWVOS1lh?=
 =?utf-8?B?emhPLytKcVdmQ25zdy9IeFlqODdoUDdrcWNCY0pxQWh5Ukd2Sndoa212Y205?=
 =?utf-8?B?a1NOam9oRHFxQW5OZ0ZFa0xLN2Fwa3g4L1kzUWFvY3pjQ2RhUm1WblMrMStY?=
 =?utf-8?B?OWgwUzR2OU43VXM5aVNTS1lKNkhzeUdybW9RMnFMeTFhYnFhQVR6bkR3Y0Fo?=
 =?utf-8?B?TFEyLzMyekNoT1NyYWZnK2VTTk92bVZTQURTWmRKRTdZUlprNVliVjJ2QjhM?=
 =?utf-8?B?bWNFQ3paVVl0czlDZjNyOUVnT0JIZVV4UHptSzVZWUFFSFcrQllWR3Z4SEFa?=
 =?utf-8?B?L0dkN2twKzZpWHVaUTFyMTg0cHZrcmVYaWh6OHI4TWhnSVp5L3Z2VDdHekE3?=
 =?utf-8?B?anRrS1lOVU9ONGo4R3dKR1VteG1vU0l5U3lweHZGNEpVSm1oN1g4cVdrcXRs?=
 =?utf-8?B?NGh2VXJiM290R3RsSjByYUFSUVhWUWVDUlN1VGpKRFdhbGovcTVzMzN1M0tZ?=
 =?utf-8?B?dnZTRUh6cWdjVUJKb0FpRzlHalc2dkVOMzBkREh1SEd1ZmlYai9NeGpnajgz?=
 =?utf-8?B?WFFpbitudVJ6T2hUK0dacmZncStrY0dIeFVadUt1WGRDQWVnY3RZbUZiakJM?=
 =?utf-8?B?QzlJVmtaVTcxdHZZSksrTzVqQUord05wY0pNVjlKZHNtZm5lTHF6N3RxRDNY?=
 =?utf-8?B?ZG4rMDIvZXk2RWhCMVhmUXE1aGtSWmR0cDV3azNlY1JEblpQNjhZcTdWc1Zq?=
 =?utf-8?B?dXZtc0dTTDBQQkZiTlI3OUVTNmxGci8vK2tNL2hybUZiRDU0eldLeFJ2aW14?=
 =?utf-8?B?akhuVnVLZmZ2L052azdkZUdsbjZ0eHBBenVlU3FJTDJqdXdGa0F4OWJOSEYx?=
 =?utf-8?B?OU5BK0NaWmVRNEQ1WTFSdEF1MkJnT2VUVHEvUlBMdEV3d0t4eWl6Rk1TMTVI?=
 =?utf-8?B?NE90NVIvR25LMXhzMlJBb284YnlWa2ZiQ1Z0bnkwMzhISENpcmZWa052WXlP?=
 =?utf-8?B?QlZWeDk3cW1jK2N3aG5Td3VvQVRrTStiZHdGUGQreXBNTnNOQnRrTitzRVMw?=
 =?utf-8?B?VzdIU1ppZXY4QTQyVnhteTFrSjZuVGdzdU50aUk1T0orRDNzRE5zVjU0MjBP?=
 =?utf-8?B?UmdyaUp2bXhGZTFkT053Nllmeit2cTRpUlNQdm5ZdnAzRVYwcVBoYmJJVERw?=
 =?utf-8?B?WmlWdDQ4YVFIV2g0cklaaWM1dEQ4UHpNR1IzRkw1YUFRR2ZWcEllL1I3aHZ5?=
 =?utf-8?B?djEvbUVZeFlsOVcvdWMzS1pIc0wwUlhManozSkE3YzZPcVNUaFl3bkVVVWpq?=
 =?utf-8?B?VitQblVYb1NJNWdhMTdud1V6a2VtbkNBb2daYldBVnhEWHBSMlp1MVU4ZDZC?=
 =?utf-8?B?M1NncE9RVDRFaHB3NUxDd1loUWNUenJsRENxYjVOeHFqNnZiZThJMUYxS0Zx?=
 =?utf-8?B?MUVRck1yRkNkVVNzTERiKzBVTkJ6WmxLYlN4MGtPVU9IWWd3c1M0ZUtZUUpU?=
 =?utf-8?B?NU1hMnZEeThTZ0dFSmxSQysyUzBVZnk2eXBsVmVzZjI5MWZhaVZlcnd6c3Fh?=
 =?utf-8?B?ZTlNcDRqeUNsemdJQ2ljZkc2dXJZbDZBclFOcmRtV3BSSXQwUy9VMVZNalR2?=
 =?utf-8?B?QlVCSFNKck43VUxxTms1cDdpRzI1OE1MbkJYK0toTjBnVnYweHBNZStLNFdB?=
 =?utf-8?B?UmxoZ0RHYkkwc05Xc09FNDZ6b1pydjNhQmF0UXRRT3QrM29WbnRyRmZLVy9x?=
 =?utf-8?B?ZVRKaDZtbTVpS1JDWXlmbnFlVnhVUWw4YVJ1MFZhbjVlU1Vxa2hkWHBjMmU5?=
 =?utf-8?B?NENHb3psa0xJakx1UFhEYndTRlpLTmFpK09IUmJvazAzVEFmYW9HMGdmQm1E?=
 =?utf-8?B?bXpZRW5UVFpiMkRueVJTNVRjUXV1Q3NadDEvSzVYUkRKdTE0RUY1OGFjMnU4?=
 =?utf-8?B?czQ3TGZUaTA1M3B1OXJQd2JEWjE1MndtajBRemNhL0NVazVleG9OelFtNWg0?=
 =?utf-8?B?Tno3SnZzdkIrRTlXTG96VDgwQ2gvbWxaZjVEdnpHNHp5b1V6azBsZW9INmNI?=
 =?utf-8?B?TkFGY0dJV0QrdUlDWnM5aGd0MlV4Rk14cHN2aHYydEQ1bGZiVzRMdUlNRzQw?=
 =?utf-8?B?dXpPejhDaUNyN2JqUS90d3RGWC9WRzRyN1pVN2VhZmhSczI2UzNQTzZZMGMv?=
 =?utf-8?B?UDNJbE5yUW43QUllOHhYZzBqMDB2c0lzQTFzejcxL2p0cDV3K2F2UHpyOEZZ?=
 =?utf-8?B?aTVxb1F4VU9EMHRJN1hJdzBVSy9HMlBvTmkvT1hBTHVxV0ZONVRXMGdTQkli?=
 =?utf-8?Q?2O1pYM2AptHIhcio=3D?=
X-Exchange-RoutingPolicyChecked: 5cqNN5PagCkLl/rcydfywMacHq/+CaVVGQMkQ9qlJHlGZcFqUzLcHGjv/9ddGbgYEvrIGEMqGZ+fgMGnMjAcNmqUvfgXvMqdlFZhR/kRTDTpBoN6mZkFu9eT1AFQLkRWpRbbNQD4q0UEZyDwpW1TTHPBzqSeDLHL+AJKjHMc+DagZUr6eDroBtq6tqkKLAjTgG+vFm/VLr8ASF5LeQHO8Th9mLxQ2KpNf9Aj4eA0bzGF6h7W2SCCM9JQg1g5PelFMByMVuXthH97MIY1cTxotGAGXjm1ZrHOu4P3Qum+8/meqn8XSZil+8uNPKgvPJAa1rif4A4ZMmXZdb+SIsatqA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 87cc0f4e-8f7d-468b-756d-08df15ae9ec4
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB186312.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 17:59:44.3103 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bfnv9/58EWZ2YZiS8DRRLfDCnC9bcIDrwIDTrHQKFvkV+S36rNyUb1FxIQhaqNeZD6aFipRWHN4lc8lolfDyvijZvi5aC+PCp+nri+i+jGc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6283
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



On 9/17/2026 3:52 AM, Tian Xun Ng wrote:
> From: Tian Xun Ng <tianxun.ng@bytedance.com>
> 
> Since commit 4c9106f4906a ("idpf: fix adapter NULL pointer dereference
> on reboot"), idpf_shutdown() calls idpf_vc_core_deinit() directly instead
> of idpf_remove(), so IDPF_REMOVE_IN_PROG is not set on shutdown.
> idpf_vc_core_deinit() uses that flag to decide when to shut the virtchnl
> transaction manager down. Without it, libie_ctlq_xn_shutdown() runs
> before idpf_deinit_task() tears the vports down, so every message sent
> during that teardown (disable vport, disable queues, destroy vport)
> fails at once. The device is never told to stop its queues and keeps
> them enabled, with the ring addresses of the kernel that is going away.
> 
> After a warm reboot, the first queue reconfiguration of a port that has
> not been opened yet (udev setting the MTU) sends VIRTCHNL2_OP_DEL_QUEUES.
> The device then drains the queues it still considers live and writes
> SW_MARKER TX completions (qid_comptype_gen 0x2800 / 0xa800) to the
> previous kernel's completion rings. With the IOMMU translating, those
> writes fault on every such boot:
> 
>    arm-smmu-v3 arm-smmu-v3.17.auto: event: F_TRANSLATION client: 0016:01:00.0 sid: 0x30100 ssid: 0x0 iova: 0xffb70000 ipa: 0x0
>    arm-smmu-v3 arm-smmu-v3.17.auto: unpriv data write s1 "Input address caused fault" stag: 0x0
> 
> In IOMMU pass-through mode they land on pages the new kernel has already
> reused. With page_poison=1 that shows as "pagealloc: memory corruption"
> on most boots. Without it, nodes crash in unrelated code, e.g.:
> 
>    Unable to handle kernel NULL pointer dereference at virtual address 000000000000a830
>    pc : __tlb_remove_table_free+0x48/0x118
>    Call trace:
>     __tlb_remove_table_free
>     tlb_remove_table_rcu
>     rcu_do_batch
> 
> or with a slab free pointer that decodes from a slot holding 0x2800:
> 
>    Unable to handle kernel paging request at virtual address 002613b73e862c6e
>    pc : kmem_cache_alloc_noprof+0xc0/0x3d0
> 
> The early shutdown exists to avoid waiting for transaction timeouts when
> the mailbox is already gone. That is the hard reset case, where
> idpf_vc_event_task() shuts the transaction manager down and sets
> IDPF_HR_RESET_IN_PROG before idpf_init_hard_reset() calls
> idpf_vc_core_deinit(). Key the early shutdown on a hard reset being in
> progress or detected instead of on remove, so that both remove and
> shutdown keep the mailbox up until the vports are gone.
> 
> Hard reset behaviour is unchanged. Remove is unchanged unless a hardware
> reset has been detected, in which case it no longer waits for message
> timeouts. Shutdown now delivers the teardown messages; if the device
> stops responding without a detectable reset, shutdown can wait for the
> transaction timeouts, as remove already does.

Actually we can't wait on shutdown. If the MBX is defunct, like CP is 
down or unresponsive, the shutdown will hang for a very long time. This 
is the reason why we wanted to avoid communication on shutdown. Have you 
tested the shutdown after stopping the control plane?

> 
> Tested on arm64 (64K pages) servers with two idpf functions, with this
> change and the next patch backported to a 6.17 kernel: no stray device
> writes in 151 warm reboots across IOMMU translated and pass-through
> modes, against stray writes after 20 of 20 warm reboots without them.
> 
> Fixes: 4c9106f4906a ("idpf: fix adapter NULL pointer dereference on reboot")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Tian Xun Ng <tianxun.ng@bytedance.com>
> ---
>   .../net/ethernet/intel/idpf/idpf_virtchnl.c    | 18 +++++++++++++-----
>   1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> index 1caf52706..646b6e074 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> @@ -3197,14 +3197,22 @@ int idpf_vc_core_init(struct idpf_adapter *adapter)
>    */
>   void idpf_vc_core_deinit(struct idpf_adapter *adapter)
>   {
> -	bool remove_in_prog;
> +	bool reset_in_prog;
>   
>   	if (!test_bit(IDPF_VC_CORE_INIT, adapter->flags))
>   		return;
>   
> -	/* Avoid transaction timeouts when called during reset */
> -	remove_in_prog = test_bit(IDPF_REMOVE_IN_PROG, adapter->flags);
> -	if (!remove_in_prog)
> +	/* Shut the transaction manager down early only when the mailbox is
> +	 * already gone, i.e. a hard reset is in progress or has been detected,
> +	 * to avoid waiting for transaction timeouts. On remove and on shutdown
> +	 * the mailbox still works and must stay up until the vports are torn
> +	 * down. Otherwise the disable and destroy messages never reach the
> +	 * device, which keeps its queues enabled with ring addresses from this
> +	 * kernel after a warm reboot.
> +	 */
> +	reset_in_prog = test_bit(IDPF_HR_RESET_IN_PROG, adapter->flags) ||
> +			idpf_is_reset_detected(adapter);
> +	if (reset_in_prog)
>   		libie_ctlq_xn_shutdown(adapter->xnm);

This logic already exists in the reset handling, there should be no need 
to replicate it here. Do you have a trace and/or exact scenario that 
leads to remove being called while in a reset, but MBX is still alive?>
>   	idpf_ptp_release(adapter);
> @@ -3213,7 +3221,7 @@ void idpf_vc_core_deinit(struct idpf_adapter *adapter)
>   	idpf_rel_rx_pt_lkup(adapter);
>   	idpf_intr_rel(adapter);
>   
> -	if (remove_in_prog)
> +	if (!reset_in_prog)
>   		libie_ctlq_xn_shutdown(adapter->xnm);
>   
>   	cancel_delayed_work_sync(&adapter->serv_task);

