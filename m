Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330BC606A339
	for <intel-wired-lan@archiver.kernel.org>; Mon, 19 Oct 2026 16:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=m6Zpx9rB;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=R3Cepbo3
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0FF0780E50;
	Mon, 19 Oct 2026 16:53:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NTxeu7XJz5hK; Mon, 19 Oct 2026 16:53:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 878CB80E44
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792428813;
	b=fYu5Pl7SnJW7+TTTX3VJbazCdrPj+3UuF3JdKycc+7/x5ryEqOp+oHAKBfYCgXizPt6n
	 t6OBOHZ3qcry3dDVxjrII2PYA6DcLEmIIKUkYtzNOWC3rr54pUK68H9x8paF24c+17O0e
	 b083nk3/nwVkdCzsDKYTgZDgk7EGlseNQDZLde9IgZQYSCsG6og29XXkY9Nc2flx8sSsq
	 pEXSFaXJ8Y2m5sQqiysOCqkAany5KcdzEAq8OzrA2nIFdO+GhWQRmMU39hKcYX/Smb4+6
	 kQQ25M2m27UYFz2Jq5fCiXFvoXdD785h5Gz+MkCvVZZ4Drlvh2bp5Hqq/4Fi0QXcRZw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792428813;
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
	bh=5NpA8MejPYa5VoiZQgPe6XWOE6x9tmEcKlBuuceH0Ds=;
	b=qD2mKZhHpsaEgFHPyLEQ+sl6uch5q7Jo/mCVKVFkRDyPgqdNObZT6P6fFhwYfT5qlpmi
	 DGrVLJdVfPZ/DyU5bef774RckwD+ynMNP4CtTZai3+sDD39nJYpsL6j5p9IWLByEqsRny
	 /xBAemkkSx7FpnnzUJL294UTJDd4hDUB4YoTJ9M0/NI8IUkR0ShZd6hKxeNMZ6xLS4/h7
	 4Xyosc2DtA/HTm8Do6albHLqDZgvSgoIZ3ieOAw0VEIKa/fuDJ/rNFifmsE/E/yBDvvvU
	 +IZ1UxekdYnZr33a773tzz4wY31OWwIP8SDeEjQzfaaarIxaRhYjghU4wOJzmaQN19Q==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792428813;
	bh=5NpA8MejPYa5VoiZQgPe6XWOE6x9tmEcKlBuuceH0Ds=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m6Zpx9rBWB7yGazfM9Q1JM0/mmnf4t9kc/czaZ/GJto6MbzWdiRm47q0zybJ8mLXR
	 tW0Kpcn74MFwaomLMUQmXBDeBd32vJSg+zN6KBS1sR9zeMMZh12J1CYBl1AwemR1mY
	 dZaKzbUU2W7xaqiu+v4JTAjlK64FBpUzWDBHEe00HsYCx9r18sXUP1S8gjjwMmVT9d
	 xBBxY4C6p4Qs8cWulyJ3M0XYiGDnnIidtsiqZCCdCrokKTiYTwPT1Ex2477lzv260u
	 7NRe1bG6MPDfj+C5kqP31DMU3jB8Yi+kCt7u7aFTCdK3MAKxB5qLPuPe9o0sVDSlN1
	 h45sa+ZTGsUcA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 878CB80E44;
	Mon, 19 Oct 2026 16:53:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id F38861AB
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 16:53:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D135D40688
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 16:53:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QJRQz9vkQfVZ for <intel-wired-lan@lists.osuosl.org>;
 Mon, 19 Oct 2026 16:53:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DA59240687
Authentication-Results: smtp4.osuosl.org;
 arc=fail smtp.remote-ip=192.198.163.11
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792428812;
 b=LWvOyEbzrixw8DzTgUkkBwoD9TWRgjlGyh0HYkJDxAcYJ/vmL+4lm1274hYzIKrF30MF
 WcpXA7kYklH/Hr7dnAUpZPOtUuVVxp7p/9gcFO0x9X5tCOowMoc89SHR4UNjm4fImioVo
 F7PIOc5GOYhR5A4dAWsdHZQNcyamLhe4yak94iJx0cQm2DcA0j+vlaWXcTnmypLYMr1RF
 p5yxmWaVUk6Kl+py+vuA1cm3S8CjuamwkCjzKx9Q8gyByL2++1eiobtNcttrEkT79B+if
 3WZUA+BU/RFxfN83xx5/p91NhxDUtulk3TwASS02wW5KJHIysEIszAbUOWvn/I5TyRw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792428812;
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
 bh=5NpA8MejPYa5VoiZQgPe6XWOE6x9tmEcKlBuuceH0Ds=;
 b=MqfVbFqR/IELDzyEuuLH/P9qH8kzS51TNeM/hRQWgs/nczCoz3hhXZIhF8aXWdA70V6S
 +0jd7bZMzyc36pbF8g9zCVY7ZuIowa4Ct/2CNHKeO8jRBI5L9TQZr61sm/T4DUEJo/yg/
 l2Odemj/6RdbxrpReNxtRTVIaWseeN/P9CW+Jy0p8Oqcnse99QcfGw7Uiz1FZGGfXZ0vU
 W0275RhxeLvOGqfLqsK5PMR493tC9nZIo5Am3RxQD08aDMDVJ8dF0zeKfgLnzkL1wbv/E
 1QPlo7eQGg166LhrueJEDrRAFgnWwjslu1+UD/+3VKki+m3Im5Ns0Oju9z2E5n663NA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=R3Cepbo3; 
 arc=fail smtp.remote-ip=192.198.163.11
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.11;
 helo=mgamail.intel.com; envelope-from=emil.s.tantilov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=R3Cepbo3
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DA59240687
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 16:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792428812; x=1823964812;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=5uLTrQ1OjfNAa/IkbNpa9aGRZvE9G+aO/VExq6wRlVs=;
 b=R3Cepbo3fsiUr5s6DKyi+ZqhnbCfcHggNMCbP7IJVkDU8AE1e2WQFfFj
 uSGxSjMDM3MFxMjFhENkUWPSLnYInRLg5fof3I0qFG69vXckrRIg4GXc1
 NJNjwSHAAmdy5xWSevtWDmIw6PSr2iRlil00Kp+99BOy1NZkTaOz965kM
 pr5z5o7wyG5XY1BJHDmka5es0CWxxgMPl//X2lrPCDCY9pqGv7Zh0f05A
 NMZIRmXq2Y4idPxDlvQDbTwHXK9tau8my9e15qc/XIYbTMuUfEqslS4Ph
 PwrOKgbqIHnlP+F/nhqYez/vEj+Kz6zMlxM8BFfg4D+0a0S5VrQJlQZzp A==;
X-CSE-ConnectionGUID: MpQJ+yvbQSyNNWGhcOc/bA==
X-CSE-MsgGUID: kVesm+r1T3+ANuwQQW7GgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1023426"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1023426"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 09:53:31 -0700
X-CSE-ConnectionGUID: +pW/dmshTvigpF+y+bCAhw==
X-CSE-MsgGUID: DeILLBrOTNuHAWCA0CcYsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2642037"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 09:53:29 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 09:53:28 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 19 Oct 2026 09:53:28 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.65) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 09:53:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XmaGII6MqIGZrZXXfSbucY+VjEtDG8ghj9oo7oT5V7vJzxQhbAZnwb0fd0jJO88j0m0cEyULtwosjb15byw27XFTY+Z1QoEQOibG3C1y5RUEvjvqC89IhWEAhHVZUuHJFAf0N53c8Igvlo/eWXdZ/i7rCsSGwAFg5aoFU1Pj2sGY15Bletgngq0PKr9sm5Ciaua9+BNXiwoxPipQKNjR2POl22Keo+rlFY4q6P/XzPbL96amqKm2pHzCaQPNPUqCfdqzbhrSA/t47bWRdp3tVvc89rMBkLwpMZXLGkyUNqJvOOpODJgG/0K2CVKCVd7OriGVw2pp/awT2tDzQ+asFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5NpA8MejPYa5VoiZQgPe6XWOE6x9tmEcKlBuuceH0Ds=;
 b=f5XiVrhTqV7+k5hAmD02HHsrxlV+B/UdvArnUaYPpdCttYV470OYAiWuLePpBiejiRKYEvs44zrYSJjLSKfn9TIqnA/Fzhc90pp8oul2EEKGOmp5JokzUjx0AaZgYi72zAxiCpENgXZL6V6TKgCkZk9GUDujVCMG7VEBXydNxu/zmKs2fbFmL3W1zmfITRu2XA8OprI7WPj64aMfke1PG1xchigvxypyhdrkX48KdtcedSvwY0dakJ1Ook+vYvKZ+W+Kws/hjFGe0nZOVi3ELXw1CNYjuMnrwohigEbD9OAHZOmK54b2RyFogkJDYAbwKGgGN3k8SiSnDZB1EfUgKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB186312.namprd11.prod.outlook.com
 (2603:10b6:806:595::5) by IA1PR11MB7753.namprd11.prod.outlook.com
 (2603:10b6:208:421::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 16:53:26 +0000
Received: from SA3PR11MB186312.namprd11.prod.outlook.com
 ([fe80::fbe8:9ba6:fcd0:f0b]) by SA3PR11MB186312.namprd11.prod.outlook.com
 ([fe80::fbe8:9ba6:fcd0:f0b%6]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 16:53:26 +0000
Message-ID: <44cc348f-f548-4496-bfb2-ad9dfdee2c74@intel.com>
Date: Mon, 19 Oct 2026 09:53:23 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next] libeth, idpf: use GFP_KERNEL for the initial Rx
 ring fill
To: Luigi Rizzo <lrizzo@google.com>, <intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, "Luigi
 Rizzo" <rizzo.unipi@gmail.com>, Brian Vazquez <brianvv@google.com>, Joshua
 Hay <joshua.a.hay@intel.com>, Larysa Zaremba <larysa.zaremba@intel.com>,
 "Jakub Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20261016151835.2500807-1-lrizzo@google.com>
Content-Language: en-US
From: "Tantilov, Emil S" <emil.s.tantilov@intel.com>
In-Reply-To: <20261016151835.2500807-1-lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0232.namprd04.prod.outlook.com
 (2603:10b6:303:87::27) To SA3PR11MB186312.namprd11.prod.outlook.com
 (2603:10b6:806:595::5)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB186312:EE_|IA1PR11MB7753:EE_
X-MS-Office365-Filtering-Correlation-Id: abe14fd0-2e67-4b0e-9650-08df2e017e79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|7416014|376014|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: Szox+RRSpclIHbFJM+PKPSnD1HzQAKsVeVD6Gfpvc+vfYe5SZ5Ilx+rBu9N0SUjvSbSNRgWdyboxPvhZPQGEhkflp1IcxhhJ/S+0IrKSUsRgBEmiNwQTjIUMP+YafA/mkH9LXW/hmNABd4O+Fkukj09JbFNSE9ZbKeiLTq1MSfSmH/e6bvEzmDRvXVc4JgtmmoU2TLhxxnrD+IYBJFFSemdhe7uflNYNvtkM0TSDLPRoHOjpTnTLCCmIoZoOTNHaqWWpTaK5myptmJOgJG7OzUBv/EgbX4k0526VnEJNJ05hk0MH2KtRgpyQofm4NjEEtKN1g1SF1F+CeFUz0GA+eWXVN+BdWD30aK5fPqnb7Sn7jB5frapgdaUhRFG8blK7uF3CADKstvlPfs6Ba000UZRkbM3CU+rXJdZdP6RaoBI8ReBflGo4hPdhu+uU171SXEjNzcR2X/5QAWPJlpxjwGaUC6L5yP/Ahh6mPKx7C53IEzrD9a4XYW4o7SLyURthA17+tD9x53HYA+P2i64aYzw3hWOvGhs24nl8AmnMIBKDavHyk6R8Le4uvVYEqrp4JcxPfhrDz/fX0QyCh3uTotHV7IcUqUaicWXu+QGT/+bOlVAefFPsXaEfCJA+dNrANBGpLkeZVr3bTY4+Wcax1jSWAUHv0OmJR/avbikyG3s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR11MB186312.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azh1TER2c0ZFYzBUdnVxV3grT1JGZkY0aU1UK3Q2M0JRcEl6S05JZTA4bU9F?=
 =?utf-8?B?bUxzTVhCMm1OVnM0cFZYZDdtb2JoSnYyZGJadEYweS94SnFwYUVhbkdmS2RX?=
 =?utf-8?B?TDBXalh1dmR2R1ZYSWtZd0JVcVRBemZ2ZlRNOVduYldQOUNzREpQSGJaSlM4?=
 =?utf-8?B?K1VvZE9uWWZibWZraEs0c3lJckpmVkxKM0xZcURiYWFvS0h5a0JFWDFPa0tP?=
 =?utf-8?B?MkNoOG9NLzVmWnZ5QWVMbDlyRnVNdXpWYnZVSmVCejd5MFhobTduSmdaSmlZ?=
 =?utf-8?B?Rk9GMWtwK1pnT1N4NVc4cnU1ZmZ4SHpFRXRkd0hSdGg2d3pUeWt2bG9xL0Iv?=
 =?utf-8?B?RjBiNU5zSzMvbnBPOThwNExLaytKTlp1R29nMit4YlZXeGtIZFJHWnozVlVk?=
 =?utf-8?B?ZStpOXpNaGVrbnE1SEMxY1BCUHAxb09OdFNTdFJEeGw1UFRPWEM2djJRelVG?=
 =?utf-8?B?cWd2LytPeThtMWYrUmNkTVdCL1kxVDZrZ0pLSVZ0RENISkN4bHpVYjdqMm9z?=
 =?utf-8?B?UE5WSXhNc1NXYU9acmloWUxzWTlnUmNJU0hyNUk4MU1pZFRzbFV5Ky9yOVJ4?=
 =?utf-8?B?TDdwN0ZFRnJqSzF5akxrcmNtdTNGRFM2RkVGTWVVWlFWeHJyczdXOXh1c2lL?=
 =?utf-8?B?NWduYkxvZG1DNjZkMjRXYnUra3NKVjY1L0RleXF6WlJnOTlkVk1zZEZYeG1m?=
 =?utf-8?B?TjJIamI0azVQVmhHbWlxVEtqNDF3UGVnNWNsa09oc3czdmtUTCt6RW1sM3RT?=
 =?utf-8?B?VnQ2VHh4K3kxZFVDVG5hZTNNaDZlQk1DeVBsSlVMUHpORDRjdTRCTG15MGNJ?=
 =?utf-8?B?a0dtRDZhK09OcnltZUl1bTlTc0FjQTUrdU1KMGkvcHRNWkljZzdOdnVkUk14?=
 =?utf-8?B?OVYvdm5RekR1aEtjYW5rZlUvNUhKendZblAyWFdyQUZpNHltZ1RUSktYZjdv?=
 =?utf-8?B?eVZxL2RTVisyQkNDS1gvMTk4V0Y1OWFKSkFhT2xBY1kzUnEzbG11czkrRlNE?=
 =?utf-8?B?NHg5aUx6eVViS1J3Vjhzd0lJYWd6NGlDQm5rZjVPSnF6bnJOYkZXV2VScGEx?=
 =?utf-8?B?UUcxSW5ZUnpnNE5pbUhEYVB1K1djMng5NEo5V2JMRlBDVmthTlh6U2FHZlh1?=
 =?utf-8?B?N1NmUGlzSmNqVVNJeUNWRTFCbEZHcm9Icy9lWVQxVkVQUy9FZjRaRkxnNjUx?=
 =?utf-8?B?ajRKRFNoZTBYY1JPa1FUaTRORVFWUm1vWVBJRnVUcjAyaC9oSXgzUnZEOVlm?=
 =?utf-8?B?RU84elBHR01tMkVGcEJ3WFJMa3Z5Zk1JUUppVVFjTkg2aFBnOGY0RUtWTkt2?=
 =?utf-8?B?UU5RVFhDdE5pMXBpQzl6SnIwVmJwRmxRWTVuaVVlZnhROEsrS1RnT3psZEhp?=
 =?utf-8?B?dFl0bXA1NjMvZkhmbXpaenFTRnBZam13bExGajN0Wi9PNEV5OGFpL3FnbEI5?=
 =?utf-8?B?bWVnTWFxNXNkUE5hT016WnNMMy9wc1Qra29ZUnRpV0pVYjgrSGQ3My9acXFS?=
 =?utf-8?B?bUFRTUdRZDk4K2ZXY3JrVkpYeWl2MTRHZjJLTW9SUFdpVzlTM2F5VWJ1TndM?=
 =?utf-8?B?TXBLVFFEN3FqcldORVpnNWRlS2ZaRi83MjdhU3dZSjlnaWovdmZjemRTUUdu?=
 =?utf-8?B?T042WWZVVEdUamVUQkxnMUtLYnlOaFFMNXBlRXhmbFlnV1l5Um4zVE9EYUVC?=
 =?utf-8?B?aEFBb1c4SDEvMDVxWHBQb0ZtVWlHakQyQitCTGxrc3VLbG1sNjFFNXBYOUxM?=
 =?utf-8?B?YldIUGtnUzF3eEpLZTRvOFBQWVZzRVVEay91UUVhTUNKeGZtK01yaFgwMmVV?=
 =?utf-8?B?cm1GcnVFdks0d2NWTGhDSW50K1dBOTRDTkxYZjN5b1JGRVJueVpka2dBaFRk?=
 =?utf-8?B?NU92b2xBUXJ1VkxvOWlmNDBqeFpiZTNrbTZqNHJHelRsVjFJM3Z2NzhVMGxK?=
 =?utf-8?B?TjM0WnYvcUVtQ0ZGYUFPbEYxMFJyZEVPcUpzeXJRYUt3eFppYkxJaDdvVW50?=
 =?utf-8?B?VkJPM2gvZ0xwZVltTUdIbGEzODFxSVlhWE9NNEE2aUlYZlRLWnhoUFFVdXZp?=
 =?utf-8?B?QVFYM2NPUG5nYWtDV1N5aHBjS0E4NG1oKzZseGtlaUczRnZqMFFGT25vMDBu?=
 =?utf-8?B?YjN3eVQ0cTA3K0dkaHI0cGNuNzdsaVpQbm5ZbXN5U3BvT0FBK2V6NmVoZmtm?=
 =?utf-8?B?ODN4M0kvakcrUGwzZmswTng5cDJ2U2pYZ1lsaHVYZTJsc1NBOEN6Y0ZqT0ZH?=
 =?utf-8?B?WW05dE5zM2tFTnpVSkY4aEt3YTJlS214MjM4Q0tkTFRsZVpyUzRUWlZid0hv?=
 =?utf-8?B?MTBYMGtsZlpFcFlWUE5EUGQvN1NWaDlacVlNb3lVeGpld3lub2xXRlc3QzJQ?=
 =?utf-8?Q?HPjPTjqI/8FDbkV4=3D?=
X-Exchange-RoutingPolicyChecked: YxlAlE09yuH6xclLehPOnMt7JYEGtazVY0vk7q8XZCUa1d1+MCwhekj/NdFYJi4lFOaptoSOjQI7EFwb7+Wls1L+68D18R1a4rjjcagprGIfsqLyN/oguOcDt2FwJvSoXQZ4s0Dm4rTBiOUr5Mt95Lktc3uqPsgQYKMV903I2Q5eYEQo4Gk2Qru7k04NAonCZGSWToqIIBGKz/Oxy+C0VKifiQJt9ZQ/hjgs/hBJuZxcjt5+UOcSERSjJrvTRHjM+dO8oQJhoXT1o+wlKU9BRiPJpCNfyOAKorSMpqvVUAJM+Lz0V7ksfx/03ncgWV/FWYe6MKPRyiqHI9ztvHsimw==
X-MS-Exchange-CrossTenant-Network-Message-Id: abe14fd0-2e67-4b0e-9650-08df2e017e79
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB186312.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 16:53:26.2592 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RFBjj3KyMV0YI5xC8BBh9Rtlc4NUHzxy4cn7+wIAonqh/CStBLZ1+OAmeWQj+NU+CteilHazC+VOwdDs6s0W5JkO8K882r0Yca8BF92y4is=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7753
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
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/16/2026 8:18 AM, Luigi Rizzo wrote:
> libeth_rx_alloc() always allocates with GFP_ATOMIC, including when idpf
> fills its Rx rings at open or on queue reconfiguration. That fill runs
> in process context, right after page_pool_create() and before the
> queues' NAPI is enabled, so it may sleep, and GFP_ATOMIC is needlessly
> restrictive there: it can neither reclaim nor compact, while the initial
> fill can allocate tens of thousands of buffers across all queues.
> 
> Add libeth_rx_alloc_gfp(), which takes the allocation flags, and make
> libeth_rx_alloc() its GFP_ATOMIC wrapper. Use GFP_KERNEL for the initial
> fill in idpf.
> 
> Signed-off-by: Luigi Rizzo <lrizzo@google.com>
> ---
>   .../ethernet/intel/idpf/idpf_singleq_txrx.c   |  7 +++---
>   drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  9 +++++---
>   drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  2 +-
>   include/net/libeth/rx.h                       | 23 +++++++++++++++----

Since libeth is outside the driver, it may be better as a separate patch?

>   4 files changed, 30 insertions(+), 11 deletions(-)

Reviewed-by: Emil Tantilov <emil.s.tantilov@intel.com>

Thanks,
Emil
