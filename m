Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05B3ECA9EBB
	for <intel-wired-lan@archiver.kernel.org>; Fri,  9 Oct 2026 21:48:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9CB8B408F0;
	Fri,  9 Oct 2026 21:48:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pmy_RKua8iog; Fri,  9 Oct 2026 21:48:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 47FF3408EE
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791582523;
	b=H9LE0MlPKGOSsjWjZm136DpLGqk222k6bx6BjwfUlA/OGkHzUkpqFOfyYBNmBRJQC+6Z
	 2qNq/Bw26Enf0S4CimLijqN5tRJumdXQKZOBVOVc5RUkqjnHDFnuLwLn1Hm4LtwJY5XU2
	 6KnSLgzOHePKPL+dU6dmAf6QuZc+tpYN3SsjkDRIVYxfpxaakMU/vI9GY8dA2W2pY1vaf
	 UIBpSURcl80DnyJ3FBCOPaScOwZROwsiIQsoIzodpperbCvdUPU4NNrvVwWhKYkR7nynb
	 4wSI3NddP00nHjXlXfbTVs2VByaIngKhe3hp6w+UxpM0VTYPIewI8QRMByW5FTc+LZA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791582523;
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
	bh=upU9DudV3Ms7lDLTExWkoI7FgC7hvFtJY5n8d7fpsLI=;
	b=td5ZJZKLGgF6yIEi5oKVCMX6pKP/S0EVFbDgy78/CnknitWhcemZ3byZq6LlHNjWjSlv
	 VjIcKjC8cychVTXr+2lYplDiym8bTzOvdmDUNuL96neN3RQtf68AQ3kIFI3jtvkZw5399
	 cdW15jiCpPSSxBUFFB04iVVJ9FOrZipq5fq7Ol6GGx0pcMxQKNidkPe5TuUrXIg8vySV1
	 VUUIHFe2wdST/bzVXYG6MIYwZ/mwurPhHtC1p+YwLt/fkDZJE+/i0ha6Ac6JvfJXtfLnP
	 DuyEmEN1lWJeumfV5AOVVprJeTUG7Ai7Jz47bOOhM6X60SSewuOvlcgfjwHaXO4gEjQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791582523;
	bh=upU9DudV3Ms7lDLTExWkoI7FgC7hvFtJY5n8d7fpsLI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jrtwW+JOyByDVUXfVR93n8jbgVEvxlfZpJiiSG4HRs1PBzZsu2WK/ExwRCXgybbFS
	 hJlNJyifCnq0+9cKZgPJLOlps8ssZLVivO/6kBJwkgN1pUeZGNyuQcYJ0lxvU2+H2c
	 3zdp09nSWedsLxioEQJFKxK6xBdUF5iO9sjyn6FWuzorgdvyfaHh0VDgQNkVBz3nNP
	 6UFJXBDCKMOJEByPi9FUfVNHjeaEJzoXmbzcKmvk4psJTKA1FXKN2eJF4/ekP9CqvC
	 DDaPmi8uA93xgE0TpvPfIaEXtruAVIfxHK0YOEVEv7KgNu/EEA0ndU5GfnkcAX5O4U
	 9q2MWQTb7ezzA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 47FF3408EE;
	Fri,  9 Oct 2026 21:48:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E0D3C13B
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 21:48:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D18D94009C
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 21:48:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AOHUrihFkDsw for <intel-wired-lan@lists.osuosl.org>;
 Fri,  9 Oct 2026 21:48:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 4A59440053
Authentication-Results: smtp2.osuosl.org; arc=fail smtp.remote-ip=198.175.65.11
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791582520;
 b=UgigZxuJ+ytqfq/YYTkEQwTL8EqHE5+Lg9K754bGcj1L0z2UtJpznZcpiolcgyi5XxQH
 XivzPat0wFwcb8sqR1XbxTNMJGg8CNtKJLTkqctcYnA3uUXhqgZ9VmBBK+jD4MwYyb5Qt
 nVOvQjc2ktjd9SDvF/9aUaSDrwE5RSz+mJkMHnf0csgzj4078sbL/SGXQMQgfHpK7CRqA
 qmPkSctVXBiDhHLieTmZOvMLHIC7vydUI5AFSFClo2z0YakkQno+/+0WsMjY8XODOWK1w
 hT22SXDHp74dpWoTtmzzAI/W5OjiDqMZW5RpMC5zOyiQLtC5hQVlQXp03iuLKUi5ZlA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791582520;
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
 bh=upU9DudV3Ms7lDLTExWkoI7FgC7hvFtJY5n8d7fpsLI=;
 b=UTmgiERdAGicdBeXzy/obQ+hUq2Nfsvk8GF51Z8K0wrCxPVFlJWYDA6Hfony2lUBKvL+
 l7m6alIUMTNBNa1p6rMSGU8rhEUxJyKVvMwmY8rp3i7u6kykfs7/ucIAUhycPZ/lRCgbM
 ad3+2ndkBJAxPC22tfVez5xUZZgsdKiL6M2cXSbVdArCpRSKVdhIB8KV1FfbQMKrgS++o
 3tS5ZRfr7RCZb8l/goXF21i+TgwxpmFP/d7cQ2JT0godf2cA9aqXCny0ga09RQ7o9YwPi
 tgSGXGtdR8/h/BjI7acDvvFPPsYI89ejyABqYKJLvCk4xQkeskU7MP6XUM5RttLrx4A==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b="nLgKkH/z"; 
 arc=fail smtp.remote-ip=198.175.65.11
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.11;
 helo=mgamail.intel.com; envelope-from=emil.s.tantilov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=nLgKkH/z
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4A59440053
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 21:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791582520; x=1823118520;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=tVWdtKtbVtcL8MACTaJLC3i2Yy+wHysqnLig0h2mUe0=;
 b=nLgKkH/zXrIXN3XHTLPfXm//sYzHXNLkc86djH5d/Iexz5rDAwINEMr3
 xYn+cNrM6V6CTffv8/AwOH19weiAiNzgML+3u9vqRpon/IbtXl+70x4FE
 pUuXVrJuWwH2GPwbE9pi5hTGYq6iLsjB1lFoI/93F4ZU43ftOUBQrowJz
 EJXcJ/6OLDnl+6g1ahHmuA66q/2vjFavrl+BxmCzCI8nGJI/xhzv+xpt3
 h1cV7K2hFAnpanEPWPOSNBLwJFbZSj9MrHfvk5iFkFEkYZnddZ/ZfLeSR
 YgNTXCuT1JdV4DZV0fNA77BEjf5/kxWpuw6MwwEDhXH8Ze/Ck8xnB5fao g==;
X-CSE-ConnectionGUID: G6AQ3H+RTWme/UzrHuJYAg==
X-CSE-MsgGUID: czBCqI5KQKKenDYhCDIlJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="274996"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="274996"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2026 14:48:39 -0700
X-CSE-ConnectionGUID: BNIRpSLdSWOBOuoC1HRyIA==
X-CSE-MsgGUID: WmyvUiS1S1WgmlXYfurX/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="2244574"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2026 14:48:39 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 14:48:38 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 9 Oct 2026 14:48:38 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.9) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 14:48:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sJbmH41UOQuRz2dEwGPYKafRYfymr0KmOMwRN77VyPw7kw9Wf3T6aHfY8GpI1VqPhIT0uoswOlxGNIZH6a5Xxas77Sx64C9LCIOT34WnvLq2Ht8sxnt8BAwu6yZdxtXAN7I9fAwzv/Ldw0QjYi0vgf4OnXoFiLNppiqUSP3jkIO1TdpY3OTGNjUQ1ISY5OdmQSM8kMeYfRDIolImEimRULAJFrvBMZDYaxLMgwacLpwAyJugdePUsmT/CmZyR6de2PYS6hgodw9RNTZ4DBZ2E4JSayU07Sxiw6/ipCCRyh87F1jx4Qj4h4RW64auzGXB7N3i44Ll4uf3172vax/0XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=upU9DudV3Ms7lDLTExWkoI7FgC7hvFtJY5n8d7fpsLI=;
 b=vvRq3DIy3WRAz8StecG5n6mdGUxQqfz03mwbw3APMS8DcMAIcOwu582rfW1TBuosXyfnpvfgkttRPVSXlBRM0CjWY+e6u0/kM1dX6iqnbRHxNcYr/QGu0FgcAd5xihpsE2Le1J2rAfsnmCx7kh7QgLoBf64JeDJSzSjvRZOsDNRXmsR5UP7q2fOioG4zWTGWCf54Qg4vmNhxDi7FdlxqHL7X7hyYQCOEQKJBcJMN/OSGwH0ysnSyyraLBkHTSEDT/7iyBvi6dsSbXouOXjLhJYhKmFWUkueVAWSw4uMG79aunLEVHGXaysSHdQQkgU9InQ8Ycv5HOK9tl2P9p/Rktg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB186312.namprd11.prod.outlook.com
 (2603:10b6:806:595::5) by IA1PR11MB6369.namprd11.prod.outlook.com
 (2603:10b6:208:3af::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 21:48:35 +0000
Received: from SA3PR11MB186312.namprd11.prod.outlook.com
 ([fe80::fbe8:9ba6:fcd0:f0b]) by SA3PR11MB186312.namprd11.prod.outlook.com
 ([fe80::fbe8:9ba6:fcd0:f0b%6]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 21:48:35 +0000
Message-ID: <103b5631-01fa-4dd0-8c11-e2bb20960850@intel.com>
Date: Fri, 9 Oct 2026 14:48:31 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v3] idpf: keep the mailbox up while tearing down
 vports on shutdown
To: Tian Xun Ng <luckilystar08@gmail.com>, <intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, <anthony.l.nguyen@intel.com>,
 <przemyslaw.kitszel@intel.com>, <aleksander.lobakin@intel.com>,
 <aleksandr.loktionov@intel.com>, <decot@google.com>, <andrew+netdev@lunn.ch>, 
 <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <pabeni@redhat.com>, Tian Xun Ng <tianxun.ng@bytedance.com>,
 "decot@google.com" <decot@google.com>, "Hay, Joshua A"
 <joshua.a.hay@intel.com>
References: <20261009032706.94324-1-luckilystar08@gmail.com>
Content-Language: en-US
From: "Tantilov, Emil S" <emil.s.tantilov@intel.com>
In-Reply-To: <20261009032706.94324-1-luckilystar08@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0268.namprd03.prod.outlook.com
 (2603:10b6:303:b4::33) To SA3PR11MB186312.namprd11.prod.outlook.com
 (2603:10b6:806:595::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB186312:EE_|IA1PR11MB6369:EE_
X-MS-Office365-Filtering-Correlation-Id: b5534905-196f-4b00-20c7-08df264f11b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|7416014|18002099003|6133799003|22082099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 1DJ1PNonWphXODocjXY1btx6tq0j/LQrTHy+KeW4vjX89WmekvRlizTkhRwxW4pXIBwZRdK1mVrlwmOef3dZ8br7l7wxC+voqWNXJdZMFs462M98p5gzoRQLJG3z8DQgFjURFhgaUKBRcyjYobhVlXAdH3vNUayHu4Zk4OI0ge6scEE22gJapV0+t6R5TOYMUvwgW2R6B+UMP4eLa8I2dQvbWAFyjAMjOZZg2nR1Qd9Ns+j9i1+q0wL65ZcTB+eeQiUGFzAnjIlZUBisGCQBmUOLNRxUNgrLz5ehp+pICxy0vwGNZVQ7lTvNa/ycIYdlAKAaPCH7/DTFfJKpixBrW2UMa02RwOlPOau+IEKdaVunJaIuXg2pwuRN9nUyt8TBU1TSdzq5T90HPKbEIaULIbWCwVd9C1Z2rezIy7PS7oFTvg3q74L3KS8+1IMtGHc4cz8vpOIp1mqZ99az34N+NYmE5w07EbvqjiwYD63D4wVj6f6IkG9nnXJGa8Rhwo543RsqWOtpMJbKHrjNGSD0DDbds+TqlviV56o2a6XM/oEZARUXHUAMeLbN5ZH3E+G1qxRPN3HpFWLyLnBMAjpv5ERdshjvEsXGVdhnvxKtY70=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR11MB186312.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(7416014)(18002099003)(6133799003)(22082099003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ui9ueDY2b295WFBRTURNTU0xY1VhakdNdjEvalVKYVRlQTM2WEx1Y012OTRM?=
 =?utf-8?B?c3JTLzJQVDJVTWN4SUY2bTZqTmZkU3liWm1IQS96UEMzY1pYTHdJazE2Y0t5?=
 =?utf-8?B?bWRQdTRDOVdjbzU5SWhWWDNjYlJtY1p0WkExTTA0Mm9ldFk5bGNoYzJZbkdz?=
 =?utf-8?B?SG1JenlRYTNiRVQ1T3FtTXVJMTkvVTl1d280TlFUYUhCdTVhRU00cmJLUTFP?=
 =?utf-8?B?Lzc1eUpDcDgzTDMzK0pQeW5RY3Y1TlRqK002emZDNzJvclQxeXVPdExzT2tv?=
 =?utf-8?B?RFJHSTRXTENBOWNNSlBxVlNWZi8zR2k2TFhBclBVTjVhN200T25RL25aeDVa?=
 =?utf-8?B?SndXbDJYZTI3MjFCSXY0VVBTckt2NmUwditjREtBd1NBYlFOUFlVOWh5cUVx?=
 =?utf-8?B?cEhXbTRYQ1J5S0VnYm80bEdEWkp3eUFPT0w1UHF6M2l6N3Z4SDBsUHlzODhz?=
 =?utf-8?B?RFM0OTMwUmJ4eWhrYTZjakp0Y25XNHJEb1I4UzdtQjhoYXpTWTkveVNjbWJG?=
 =?utf-8?B?M2liQVJZNjZqUllkQ0MwM1JrWWxDR0dWY3lnQnRaQlBJZkVNWVlrZFZGc0Rn?=
 =?utf-8?B?MTl2RVVVS1lKbUxBREdBOTMxb0doeGlWa0ZoajRTSVNaRTNXODhMNFJVeEVW?=
 =?utf-8?B?QTRkWVl6VXlRZmxTWnJEWVJWN0RXeTlSWDdYM2IvOWExMFN2RGxhb2hjcTVR?=
 =?utf-8?B?Y1YvcHJsRDVtQmdPVzZnU1ZZcUJIR3RlZGkwRFFoeHpRU2JNQnlTVFBJUFNS?=
 =?utf-8?B?R2M0bTBhcXJBdVl2eUcxemhsbzU3YzNuUVRINFN1MDNzT3A2REEzNTJyamVY?=
 =?utf-8?B?WC9tRmx6VU90NDY2WDVVT0FPYXNOcFU0TWsxcERUYkdTOTNHbitvdUZiZWdx?=
 =?utf-8?B?N0R3NWpZeGoyN1UxM0hpcTdueHRpN09KVGFvQ3pSTDBFTnkrVThWOWZXSHBD?=
 =?utf-8?B?M0ZvbGQrKzFvYkN5ODJ5M1ZYOFF2RTRnZG9lZ3Bmd3lWL0Zsbys3ZURuVjEr?=
 =?utf-8?B?ZC9tYVpvUHRLVGRBeThjbVFsbXIvWEtVbHY5cm0xbDRvcjlSQ08zLzdhaUVp?=
 =?utf-8?B?NldtZXRlWlBZN291aFJQVHlMZzBXakdEU0lQR1dqamoxUS9uUzdOU1pSbklx?=
 =?utf-8?B?eCt5dVpraFFwL2piWGN5TE5hK1dudExIVUJWSEUwYms2aTkyNGgrSWE1WElj?=
 =?utf-8?B?NE1zc2N4Q1RTa3BFUlVYMThJeVBzWjFpNEh4Z01HMGVibkd5dXIwWVJpdHkr?=
 =?utf-8?B?QjZvWnhjaFRISVZ0M1VEKzJFcC9XU3Fia3JtekIzK0U5WVoyYXRucW5tSGN1?=
 =?utf-8?B?aktnU09IdkFSR1ZldWVWSHQyaGM4WlcwRWpjQVFVekRzSUxWV3dYS2tWc24w?=
 =?utf-8?B?YklnbWlSQXd5TTE0d0VaYjBUd095aVVRZUcvL20yYVpBK3BqVnFjblBXMDJj?=
 =?utf-8?B?bjNWUmRDaVpGVTdZRUZFYUszY0o2RjdiZEFHS01Mekg4dHdKNU91RENOclFm?=
 =?utf-8?B?alFjUWJMS2E4aUJVUkFXYTZwYTgzNHhvaWdjU0VRaE1Tc29FTWMvUHlnSmVB?=
 =?utf-8?B?Zk0vNkVMNkVvVVorRTB0V0dOQVkvWC9jSjZwU2ZzK1ZyZTZDNXBuNUdvMHQv?=
 =?utf-8?B?eVh5S1FvME1hSHZyTTVJbTFFc0Q3MWRqY0pFWmFabk1kby9ETmZXVTFtMUJ1?=
 =?utf-8?B?REk2R1U4SSsyZklsNG81TytvQ3VDQUN5WlRzbjBQRGpIMzlPbVBGcEtDNE9m?=
 =?utf-8?B?dmt2RWRRMHJOTGYrVUNSYXFIMloyQ0haTDltdTlKZDdHVGhlQXhDK1dmMGRH?=
 =?utf-8?B?Nm5Mb0ZOOUtEaTZhUGJIcjRmejJmMnlDSkhmbTc2MEVEVm1IKzVFYW9EdzJ5?=
 =?utf-8?B?UHJWSDVEY1EyUE5wZEtGM0hxaWdrRG5oQXZJU3gzdlcydm5IVi9JQTlHSWly?=
 =?utf-8?B?QzkySnlUdkQ4OEdxdndoLzR0U2JEblZaR2tMRlp0aWR3em5VbExCa1ZjVU1l?=
 =?utf-8?B?VHk2RTZBYkhJUjVyVG56TVIxYzVHSUR2dmttbFAyb0JVTXFuRjRWY1VUd1V6?=
 =?utf-8?B?RmRYTU5jS0UxVU0yUmtMbDljYjhPZkprR3RIN0srMjFSb010WCtxeEx2UTJ3?=
 =?utf-8?B?VHJGaTYxSWlVMFY5dGgvMktIbk1yQlRiMjVEU2hBUnh5UjltSU85ZXJyUC9E?=
 =?utf-8?B?SkRIZTk2NW54eDJOTW41OHVLNDhSdGtsRUdTV0hLN0JXTFVKQlkvY0RaVW83?=
 =?utf-8?B?Y1V2S0UyVUpnUUh3ZTJ1TXVXcXNuM0grRzFQbHh4K0EyVTNRWnR1cC8wUHlG?=
 =?utf-8?B?ZTVqc09nN0dFRjFXYWlzTlpBazdXNEs2SWNQdVkwNWt0YTRkSzRRWm5nRTh6?=
 =?utf-8?Q?Qo965EHlu7CbSKIo=3D?=
X-Exchange-RoutingPolicyChecked: mGFKFfE15MgdhrlKJPPhSFvyubxxjWeQfj2vtTRZF2BsjaHyCCrr3bnLGj/dSFGHFfhDWG462lsWIZfrlt6t6j0GlFj/3FHcEdTpPLHvCUT/RPsRm1Gu3azXPvPnfJBTd2vC2YAGbBn6Zi58qhN50lNaLV9aD69EgIJsWARrxPB0XE9ADmcLHzfQ8YY7kK+zZ+BfoBZnBIzVVAj0HV+oBe2fvbyhdh7qMUC+tAb0Bh/Qldxgsud9FBl61zKgI+6YsjsVryAENgm7TG+8TI4MrSpu22Y3K7pF/bHZkeGX5JnHb8Ow8XH/OOoT3AURj+BQGOuR9Qjy1AIP4JPPLaWcPg==
X-MS-Exchange-CrossTenant-Network-Message-Id: b5534905-196f-4b00-20c7-08df264f11b3
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB186312.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 21:48:35.1958 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HDQ5o9CepnJLt54WXeSpXHZNzCDlHUCLEqPW1VEfEv8c2AYvc+1Dn0fGxYb6N3XHzAERQwr+1MKoQVsAgX0x4VjOZ7RaQkTKYfCanUl/FCQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6369
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



On 10/8/2026 8:27 PM, Tian Xun Ng wrote:
> From: Tian Xun Ng <tianxun.ng@bytedance.com>
> 
> Since commit 4c9106f4906a ("idpf: fix adapter NULL pointer dereference
> on reboot"), idpf_shutdown() calls idpf_vc_core_deinit() directly instead
> of idpf_remove(), so IDPF_REMOVE_IN_PROG is not set on shutdown.
> idpf_vc_core_deinit() uses that flag to decide when to shut the virtchnl
> transaction manager down. Without it, libie_ctlq_xn_shutdown() runs
> before idpf_deinit_task() tears the vports down, so every message sent
> during that teardown (disable vport, disable queues, destroy vport)
> fails at once, and the device is never told that the vports are gone.
> 
> A reset should clear that state, but on the system where this was found
> the device kept the queues enabled across a warm reboot. The first queue
> reconfiguration in the next kernel (udev setting the MTU) sends
> VIRTCHNL2_OP_DEL_QUEUES, and the device then writes SW_MARKER TX

This case -> DEL_QUEUES/SW_MARKER_TX will also need to be addressed by 
this patch. A CP that acks DISABLE_QUEUES and doesn't post markers would 
end up timing out by 500ms per TxQ.

Something like the following can be folded into this patch:

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c 
b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 3afd6e62e86f..7ffd512561ea 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -372,6 +372,39 @@ static int idpf_send_chunked_msg(struct 
idpf_adapter *adapter,
  	return 0;
  }

+/**
+ * idpf_wait_for_marker - wait for TxQ marker
+ * @adapter: driver specific private structure
+ * @txq: Tx queue to wait for
+ *
+ * Return: %true if the marker was received
+ */
+static bool idpf_wait_for_marker(struct idpf_adapter *adapter,
+				 struct idpf_tx_queue *txq)
+{
+	u32 timeout_ms = READ_ONCE(adapter->vc_xn_timeout_ms);
+
+	idpf_queue_set(SW_MARKER, txq);
+
+	if (!timeout_ms)
+		return false;
+
+	idpf_wait_for_sw_marker_completion(txq);
+	if (!idpf_queue_has(SW_MARKER, txq))
+		return true;
+
+	if (timeout_ms < IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC)
+		WRITE_ONCE(adapter->vc_xn_timeout_ms, 0);
+
+	return false;
+}
+
  /**
   * idpf_wait_for_marker_event_set - wait for software marker response for
   *				    selected Tx queues
@@ -392,9 +425,7 @@ static int idpf_wait_for_marker_event_set(const 
struct idpf_queue_set *qs)

  			netdev = txq->netdev;

-			idpf_queue_set(SW_MARKER, txq);
-			idpf_wait_for_sw_marker_completion(txq);
-			markers_rcvd &= !idpf_queue_has(SW_MARKER, txq);
+			markers_rcvd &= idpf_wait_for_marker(qs->adapter, txq);
  			break;
  		default:
  			break;

In addition, adding a check for the REMOVE_IN_PROG inside the loop in 
idpf_statistics_task() should help, since your patch keeps the original 
timeout until stopping the tasks:

    if (test_bit(IDPF_REMOVE_IN_PROG, adapter->flags))
         return;

Rest looks good to me, although I would suggest waiting for the AI 
review before posting v4:
https://sashiko.dev/#/patchset/20261009032706.94324-1-luckilystar08%40gmail.com

Thanks,
Emil

> completions to the previous kernel's completion rings. With the IOMMU
> translating, those writes fault about 19 s into every such boot:
> 
>    arm-smmu-v3 arm-smmu-v3.12.auto: event: F_TRANSLATION client: 0006:01:00.0 sid: 0x30100 ssid: 0x0 iova: 0x3ef60840 ipa: 0x0
> 
> In IOMMU pass-through mode they corrupt pages the new kernel has reused.
> 
> Set IDPF_REMOVE_IN_PROG at the start of idpf_shutdown(), as idpf_remove()
> does, so that the event task cannot be requeued and the vports are
> destroyed while the mailbox is still up. So that an unresponsive control
> plane does not hold up a reboot for long, cap each transaction sent
> during the teardown at 500 ms instead of 60 s, through a new
> adapter->vc_xn_timeout_ms, and fail later ones at once after the first
> timeout. A transaction that is already waiting when shutdown starts
> keeps its own timeout; bounding that would need support in libie. If
> the function has already been reset, for instance a VF whose PF went
> down first, idpf_is_reset_detected() fails the messages without waiting.
> 
> Tested on two arm64 (64K pages) servers, each with two idpf PFs, with
> this change backported to a 6.17 kernel and the IOMMU translating: 20
> warm reboots without a fault. Each PF's teardown took about 1.2 s for
> six mailbox transactions; the slowest, VIRTCHNL2_OP_DEALLOC_VECTORS,
> took about 300 ms, and the queue-related ones at most 240 ms. With the
> driver made to skip sending the teardown messages, the first transaction
> timed out after 500 ms, the rest failed at once, and every reboot
> faulted again.
> 
> Fixes: 4c9106f4906a ("idpf: fix adapter NULL pointer dereference on reboot")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Tian Xun Ng <tianxun.ng@bytedance.com>
> ---
> v3:
> - No new flags (Emil): idpf_shutdown() lowers adapter->vc_xn_timeout_ms
>    (60 s from probe), and idpf_send_mb_msg() caps each transaction with
>    it and sets it to 0 once a shortened one times out, which fails the
>    rest at once.
> - Shutdown timeout 500 ms instead of 2 s (Emil).
> - Set IDPF_REMOVE_IN_PROG before cancelling the service and event tasks,
>    so the event task cannot be requeued (Emil). The timeout is lowered
>    after the tasks are cancelled, so a reset that was still running keeps
>    its normal timeouts.
> - The comment and commit message no longer state that a reset does not
>    clear the vports (Emil), and say that a transaction already waiting
>    when shutdown starts keeps its own timeout.
> - Retested as a 6.17 backport: 20 warm reboots without a fault; the
>    slowest teardown transaction took 306 ms.
> - Not addressed here: with the transaction manager shut down later, an
>    async PTP Tx timestamp reply can race idpf_ptp_release(). The same
>    window already exists on remove; left for a separate fix.
> 
> v2: https://lore.kernel.org/all/20261007055741.30629-1-luckilystar08@gmail.com/
> - Dropped patch 2 (function reset on shutdown): on a VF it queued
>    VIRTCHNL2_OP_RESET_VF and then freed the mailbox.
> - Bounded the shutdown teardown and failed the rest after the first
>    timeout; no VF special case, since a VF whose PF has been reset already
>    fails fast through idpf_is_reset_detected(). Not tested on a VF.
> 
> v1: https://lore.kernel.org/all/20260917105205.37561-1-luckilystar08@gmail.com/
> 
>   drivers/net/ethernet/intel/idpf/idpf.h        |  3 +++
>   drivers/net/ethernet/intel/idpf/idpf_main.c   | 10 ++++++++
>   .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 25 ++++++++++++++++---
>   .../net/ethernet/intel/idpf/idpf_virtchnl.h   |  1 +
>   4 files changed, 35 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
> index 470bc23c8..0739861a1 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf.h
> +++ b/drivers/net/ethernet/intel/idpf/idpf.h
> @@ -625,6 +625,8 @@ struct idpf_vport_config {
>    * @asq: Send control queue info
>    * @arq: Receive control queue info
>    * @xnm: Xn transaction manager
> + * @vc_xn_timeout_ms: Upper bound for each Xn transaction timeout, shortened
> + *		      on shutdown and set to 0 once a shortened one timed out
>    * @num_avail_msix: Available number of MSIX vectors
>    * @num_msix_entries: Number of entries in MSIX table
>    * @msix_entries: MSIX table
> @@ -684,6 +686,7 @@ struct idpf_adapter {
>   	struct libie_ctlq_info *asq;
>   	struct libie_ctlq_info *arq;
>   	struct libie_ctlq_xn_manager *xnm;
> +	u32 vc_xn_timeout_ms;
>   	u16 num_avail_msix;
>   	u16 num_msix_entries;
>   	struct msix_entry *msix_entries;
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
> index 129bccaa6..ec751f4a6 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_main.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
> @@ -194,8 +194,17 @@ static void idpf_shutdown(struct pci_dev *pdev)
>   {
>   	struct idpf_adapter *adapter = pci_get_drvdata(pdev);
>   
> +	/* As in idpf_remove(): keep the event task from being requeued, and
> +	 * destroy the vports while the mailbox is still up.
> +	 */
> +	set_bit(IDPF_REMOVE_IN_PROG, adapter->flags);
>   	cancel_delayed_work_sync(&adapter->serv_task);
>   	cancel_delayed_work_sync(&adapter->vc_event_task);
> +
> +	/* Bound each teardown transaction, so that an unresponsive control
> +	 * plane does not hold up a reboot for long.
> +	 */
> +	WRITE_ONCE(adapter->vc_xn_timeout_ms, IDPF_VC_XN_SHUTDOWN_TIMEOUT_MSEC);
>   	idpf_vc_core_deinit(adapter);
>   	idpf_deinit_dflt_mbx(adapter);
>   
> @@ -267,6 +276,7 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>   	adapter->req_rx_splitq = true;
>   
>   	adapter->pdev = pdev;
> +	adapter->vc_xn_timeout_ms = IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC;
>   
>   	err = idpf_dev_init(adapter, ent);
>   	if (err) {
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> index 1caf52706..3afd6e62e 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> @@ -190,20 +190,32 @@ static void idpf_prepare_ptp_mb_msg(struct idpf_adapter *adapter, u32 op,
>    * Cleanup the mailbox queue entries of the previously sent message to
>    * unmap and release the buffer.
>    *
> + * The transaction timeout is capped at adapter->vc_xn_timeout_ms. Once a
> + * transaction with a shortened timeout times out, later ones fail at once
> + * instead of waiting again.
> + *
>    * Return: 0 if the request was successful, -%EBUSY if reset is detected
> - *	   or Tx control queue is full, other negative error code on failure.
> + *	   or Tx control queue is full, -%ETIMEDOUT if a shortened transaction
> + *	   already timed out, other negative error code on failure.
>    */
>   int idpf_send_mb_msg(struct idpf_adapter *adapter,
>   		     struct libie_ctlq_xn_send_params *xn_params,
>   		     void *send_buf, size_t send_buf_size)
>   {
> +	u32 timeout_ms = READ_ONCE(adapter->vc_xn_timeout_ms);
>   	struct libie_ctlq_msg ctlq_msg = {};
> +	int err = 0;
>   
> -	if (idpf_is_reset_detected(adapter)) {
> +	if (idpf_is_reset_detected(adapter))
> +		err = -EBUSY;
> +	else if (!timeout_ms)
> +		err = -ETIMEDOUT;
> +
> +	if (err) {
>   		if (!libie_cp_can_send_onstack(send_buf_size))
>   			kfree(send_buf);
>   
> -		return -EBUSY;
> +		return err;
>   	}
>   
>   	idpf_prepare_ptp_mb_msg(adapter, xn_params->chnl_opcode, &ctlq_msg);
> @@ -214,10 +226,15 @@ int idpf_send_mb_msg(struct idpf_adapter *adapter,
>   	xn_params->xnm = adapter->xnm;
>   	xn_params->ctlq = xn_params->ctlq ? xn_params->ctlq : adapter->asq;
>   	xn_params->rel_tx_buf = kfree;
> +	xn_params->timeout_ms = min_t(u64, xn_params->timeout_ms, timeout_ms);
>   
>   	idpf_mb_clean(xn_params->ctlq, false);
>   
> -	return libie_ctlq_xn_send(xn_params);
> +	err = libie_ctlq_xn_send(xn_params);
> +	if (err == -ETIMEDOUT && timeout_ms < IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC)
> +		WRITE_ONCE(adapter->vc_xn_timeout_ms, 0);
> +
> +	return err;
>   }
>   
>   /**
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
> index 5d27805ff..911a25ad9 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
> @@ -7,6 +7,7 @@
>   #include <linux/net/intel/virtchnl2.h>
>   
>   #define IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC	(60 * 1000)
> +#define IDPF_VC_XN_SHUTDOWN_TIMEOUT_MSEC	500
>   
>   struct idpf_adapter;
>   struct idpf_netdev_priv;

