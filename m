Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A3C606A324
	for <intel-wired-lan@archiver.kernel.org>; Tue,  3 Nov 2026 07:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=3PQrGoOa;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BYSKdE3W
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3DFCA60642;
	Tue,  3 Nov 2026 07:17:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fK8ji24FA06l; Tue,  3 Nov 2026 07:17:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 97E4C606B6
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793690251;
	b=hrVjbEQ7H/ip1i2FNH0kHCn6Vrcn3vPMGDoyoGpWA4NBWT5DFM3zwTk26G0nuFZyyBy/
	 UAu5AxJB5Z/7FcQpGxTy4pXM1L6xuT5RxYScVD6EEEaM3YqLSVn2fCAzMlospB3UTcVtF
	 xp/o31h6z9DFYYBYE6XnB11yJr5Hv5m7Nzi4wqQb1X1/jSTJA2buhy642v2DGxR7NCSXv
	 L5mSfOIQbsF3kB59ZMXU/EGIhTa5Ppd/Em6f23ZuJbGEff7mQbfibb+vpOWGwnM4eEvyg
	 2qRMSnAMBLHN6ATdDMHVnUyUGAtxLPjy4jGWcMYaAIFTmVJcBYDPmIUQNcufiPKY78w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793690251;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:Received:Received:
	 Message-ID:Date:User-Agent:Subject:To:CC:References:From:
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
	bh=trAI6vJUUf0qRpN0TIfwanKcnc4rGli/9pJu9vTFNMY=;
	b=TJKNlPqXJLykSQpQdUEq0la8yV2gpwJmcLV+pW2iV25wFu2FVEHCLPwRxnarQoMGXU1c
	 3jeUUwAPRvzaj3a6GKrY4+FdI3GXpZ+TNoKHmLGAKqjPjsKXtxi4JbusWWMLCbmT262z6
	 5m4/SnrqXPI3OenCDDQhk4IkhyZmjXOQ/uSkmlR7zQwJs21h/LiOOGxbQf3C24xYHl9TD
	 RVcP8Y1oHhsbRJW2R6bR7gbk013MMrbF1EFr7casmsr/OPi40c611W3F57qvZhBi5s7oz
	 bdSqiIFTOMUTjmQAGjkHW4/y41JpZvlWozGKVK6loubs9a8Fq9Pc65uMiwtCYXkyv/w==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793690251;
	bh=trAI6vJUUf0qRpN0TIfwanKcnc4rGli/9pJu9vTFNMY=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=3PQrGoOaM5OQSMfPb7xRx2I0K6tcaCjWopLe7TxRGZcTplY7GMjQruGy7PeYEQROp
	 o7utkcwYhBX4LqHhm3VjYxyyP+0h+7FyUPpctuk3QfC38gn3qMUiequoWna7jrRfEK
	 EWyyGipabU/jbtLf846WJQxQ/D9MH8oD/2iYyby4/Jph8YQXKEe2sfa8g1mxwsloae
	 DhVOCE0SbLx0dHQETb94v985wHfppQCBF8LL6+ZpRozzwViCCKf4y1Wk+xxAW45uNQ
	 CAj7Nv8y2n1lR3ZFM6Ly5LWrbE3SieP3hOeLeZTlbTqE25wsYYOEXYJFR8neGmZG9c
	 oRpzgngXtYY7A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 97E4C606B6;
	Tue,  3 Nov 2026 07:17:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id BD416411
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 07:17:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ACC7E80D0B
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 07:17:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nIz14BSg861J for <intel-wired-lan@lists.osuosl.org>;
 Tue,  3 Nov 2026 07:17:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A710C80CBC
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=198.175.65.21
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793690248;
 b=sfOjzIADZBzRFdaaT+DBAcKm3S9AdhHa63hCIoU4ucE8T/SkaERpAi9LKeXV15eC8bwj
 7l+jXYbNmqxg64cYiLxOoyWcIG8sPG1PZPXMAx0yR6RDJuPUWrNN0g4atNkaSk6Yu9pnK
 rKsgnnN2CU78ZS9Y30oZZPD7zRJLj99PGzAiCndlvkBexF797wXnTz2vRJ0Zk9SDWaQvK
 i1Q/8KIzcChiDLIyc5QgdNHr4VUfO2VyQHqKtLzscLi/2BnUkVCu1vlyaP7un1rGFjfKg
 f1GAQ+A6rF5lAbWN7fQuzpX5pj6IGlwiUvp3gX2WoyzREhfKurNfYP0x8wRjMW7Hk/Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793690248;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
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
 bh=trAI6vJUUf0qRpN0TIfwanKcnc4rGli/9pJu9vTFNMY=;
 b=DA4VaTkyIVWsJrTWt0gtx6SKEqHibjR/xSJrfwUmqW2Ldmea5S+ZZ6428KaFQlnFx/DG
 RNLsX5T5ilIeTXK7rnn5OvVd0f7A0KWT+mzycnyJkdy+zqeYIP2M+Do4cnexOnKkT3xV+
 Xr2cxrK2Uf1xqd4xIdMTZeLOW6QCJFapa11M6q8/xlNR8sWZCsJVwnJKStDvwgRhLZBka
 oay+UDLWnYznFFUc8uMYwtpncANlW6BkyBlHimwXDycJxD8I8vHAyjkI5ccl0LpPfxUcf
 ylLaz/UELS+Ti0M7kuzu3/9EU03/S8qgZBB7p5eSdiwv8u/nKHl9G0LrEl+I8/PtmoQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=BYSKdE3W; 
 arc=fail smtp.remote-ip=198.175.65.21
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.21;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=BYSKdE3W
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A710C80CBC
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 07:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793690249; x=1825226249;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=t+pTFUMhjE7rAEZf+fmE0PSJ0fLvKEisxsCLI5MvQrc=;
 b=BYSKdE3WVqBZAhfgmJBAjr71j2pLtaoFvZ8P3KOnnqP3q/J4cyB0mF9E
 ietP5oAEgTCFw6Co6+KWO9n7Jt51OgZwmMqDxQFIwwRa3oz14/kAB0YA7
 +u9upDbOSsso+4HmgxnX5yOaepkfVdK0UfCEXTOx7emooa05C4eBTZn49
 DVQT2XWt8dSYSUXK5VLvFQh0vt86CDq0+o+Qj42zv/s+Y3rtJ+HuwifqT
 u/tHye6X6tSTzHHMI+YYWsANjL3VCSaCkIIFegna2bqDVw8Y/1JMaEVbG
 s9L2FkcqSeqvJAv+07UxU8b12TBFzONYgPo/6qqzHztzGPKEC9FB0V40S g==;
X-CSE-ConnectionGUID: H0E9M4dcT5qNlXSfPM919g==
X-CSE-MsgGUID: fXjy3s9vQDaRINQu9xDpBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2493548"
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="2493548"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 23:17:28 -0800
X-CSE-ConnectionGUID: KNqOH9+1Q5qUiim/XWVDAA==
X-CSE-MsgGUID: ibK2bYC0T5mbjJm8/nUIqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="6461307"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 23:17:27 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 23:17:26 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 2 Nov 2026 23:17:26 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.41) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 23:17:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JsNKiK27uYrN5OBf8N0qdR8JJ6iuFo/rjAJi2tZABF8J0TdvgqkpQ9ljKNYoohwzWTX52w3mHv0axDT+OdM/6hIxkYUlDTH4TAeQxhJYe+H5Jqx5BOAWbFSAK1xsrvW8BBTxO40NN5W8jU68pE69SaPgQZ4R9LaTCuaEPdmVeKt3J/VPhFKyNvfqGwRaLkLsSpGPhrwouSWMdWiU8LK3SmPLlUiMsT2Uh4X7vFjO6yGxIb3epHfGmqbpZjlDHlNetLizaC7af1P1eE2JBXejubW1QHGDe9CEJTf15mDplMHqWbX1zDX+r98sTpTiSrXFQi366VCB6TNsex3ZV74UvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=trAI6vJUUf0qRpN0TIfwanKcnc4rGli/9pJu9vTFNMY=;
 b=ix/4tFDxXei+2Sa0Y350nocF/RdO+QmTFW4BH5BYLj59CyRLymUzPttHlTud4bMAkgDUPEYuf6hcjpXKqALf7IBJMAk3Xnz4dfuCW9Y23bbrCDfryOCjUNUuBogLSvCwUjrnDL8GRq5vcybxJw/sfG1hukrDE7QMrmB987IVN9LBMfVah14Ux/ABrOiMnPZZZEIBRsibhNwm/s/sTGL5cxnxKyI3q/Flrbsj71CSE21hT7P4HjESZghirVCW9aSmH++oPtvJYS7sCyl4c/Os0imCX/8tiktVakrur4/lcnH6T/7ypwuHt4rAph43RfyoA2S1QzMSqDRle0bVNxv35A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by SA0PR11MB4621.namprd11.prod.outlook.com (2603:10b6:806:72::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 07:17:19 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 07:17:18 +0000
Message-ID: <84054d1a-9e89-42ff-ba85-f2d04b821415@intel.com>
Date: Mon, 2 Nov 2026 23:17:15 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/5] e1000e: do not cache the hwtstamp config before
 it is applied
To: Linkui Xiao <xiaolinkui@126.com>, <anthony.l.nguyen@intel.com>,
 <przemyslaw.kitszel@intel.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@kernel.org>, <kuba@kernel.org>,
 <pabeni@redhat.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Linkui Xiao <xiaolinkui@kylinos.cn>,
 <stable@vger.kernel.org>
References: <20261028090455.2291659-1-xiaolinkui@126.com>
 <c4c4833b-b0e9-4d79-9e7b-7db9eee67535@intel.com>
 <7f3b08fb-8eec-4ff1-a696-f8a1b3df7b45@126.com>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <7f3b08fb-8eec-4ff1-a696-f8a1b3df7b45@126.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0174.namprd04.prod.outlook.com
 (2603:10b6:303:85::29) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|SA0PR11MB4621:EE_
X-MS-Office365-Filtering-Correlation-Id: c606c90e-1394-4198-f343-08df397a7ea8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|1800799024|366016|6133799003|10067099003|18002099003|261102123227099003|22082099003|56012099006|4143699003|261026121527099003|11063799006|261022075727099003|261022105027099003|261021121427099003|261022113327099003|261028144727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: JONxv+TAheceY9vXrrs3lf/fkIxQ5Uwt5rZlWCGR/O9725XZ16exAouYpgO4gRKDgJ2FGJP0IgbVlO0H2VdQMN8P8H+L7QTD0VMoA/QWJZFZtd88aDE8bnV6BfD9EdsdVITwrk8Cu7C5kWTs2IDMX8ZeG+m1GGGVoXVS/OIImq4sWnBZscgbY5ZwXiSFebH9nqjVqxF/2YZFtJD9K1okCR+oNAxNgPsuCOYif4EWPGtJrW0GHzTdC/XIL/C+fwi//6OxVweYwov/5GzyaDgwjE5NUgn88FB6YeZnaCb3vnduEDm1e0ye/kWt6IHawyH/+mW9V6oAPMTWgtSH9pWV609AG+s2YZGxNsuCMgWkgj59VlBkXq+u5hboZiDX8GkyPbSL32z9VStBWWueJEUE2FVlOMCCu6jDVs8g1AsVY+0V2xdo5s9ulbL/ML99wWuD0obXX6MFn2LeYfjJVzHGvjVcrtVLU/0pXhqcCKYl35KOnJn0BfYMhCp6NhMN3iB1xHc3TNb4bf16uhabxe9Nafst9gEXxkDmdMl0oDndLhicME5hboJZ3XaKdMDyEhJiOfIZzYpO0jkYjDkJ4wkcrs1jvkkfdVckjYyqmJbcm5UWpTRVggJft1IFJwg4ba+Led6zzSbqrjfCD/Ugnsj5B2yMcX7QtOWIdTftd26MjhY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7381.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(6133799003)(10067099003)(18002099003)(261102123227099003)(22082099003)(56012099006)(4143699003)(261026121527099003)(11063799006)(261022075727099003)(261022105027099003)(261021121427099003)(261022113327099003)(261028144727099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2lrRWE5bWN2ZUZrQjFjbFF2TzZFOVIwMFQ1a1FzTHpaN3U0MkNCQWZUbDJO?=
 =?utf-8?B?anJBWXhUb1RjY0dzSFNva2FNcEJlc3BQQ2RESk9KQnRPSVFCREk2OWFMR0Nk?=
 =?utf-8?B?SDcxR3lSUFU4YXZPYWhsMUpkWTc5djFwKzBmTkZuWE84d016RVhYdVVJZjNi?=
 =?utf-8?B?TmxUT2VEMU1IK05BUEJoc1BJVzZUd2k2K0Z2Q1V4OFBBekVyRTJZNXNSSWt1?=
 =?utf-8?B?UUgwS0xhZVFvdkp5amVRT3dFOFRDaS9Na296SHF4WXVESEVmT2pQQWlvdUZM?=
 =?utf-8?B?MnBBcmNmTjU0eHdnNFRtRHQyc1lab1ZWbVVCc1NnVG4rY1ZkN3hqNHZuMXZI?=
 =?utf-8?B?N24yWktHT1BiNWFVNi8zTnh3U0EzdkJQSk1ETHhqSUkvaVdKTnBpMWxBOWJn?=
 =?utf-8?B?bFY4TEV2RHRqbXJtbThhZVE0M2szMEZEaXlWdHVGNUFSZTJkbHA4c1JuejlR?=
 =?utf-8?B?ZVZlc1dFYVcvVG8xamcwMWNLUEptWWwwL0VZaXlVVjNmM0VkenNxalJRQmxj?=
 =?utf-8?B?MEVjc2lkYzNTeTI5RG1xVWorUlBCQm9KNEE0OWdnbUFlb0NFRWVuekVLVHN0?=
 =?utf-8?B?UTdWUTBuWjFDSEVFaXU0N1RDMlhMSWJuOEZwZ1FRR0NzQ25OOTROSzloMHFH?=
 =?utf-8?B?T0ZzSlQweFBOZVNGWW14VUhtczlHMnNKY1I2T1RhdFZnbEVPRmtTSFVBSWNH?=
 =?utf-8?B?T0NGNWZieldnM2ZzSW9XTE5xQXlLb0ZhV0pTQWVxN1lZWkVJT1RjbTZ6cC9Z?=
 =?utf-8?B?SWhBR0I5dHI5bWNhcXRYYnQyZ0xSOVpsUDVVYjJHQVBQb2NGZ1MxSjlVMFVp?=
 =?utf-8?B?Tzg3Skd5ZlYzc010a2FlWW9PU1hZbUt3NU01UWVpVlJlTnZJUHNnS1lHcGlM?=
 =?utf-8?B?SXZjVnNMMmx3UGVDMWZIYzgwN1hWZDhmNnhQS1VMdStSbklSeEZ1aWYrS2dl?=
 =?utf-8?B?bFZIRnR3eVBvNTY5NEtiN1BrQXJiYlMrczl4RmpZUUhMVS9RZzRkRlVVNE9B?=
 =?utf-8?B?UG1SRy9HNTdJT040SDJjMHVkWHJUU3lHSlNQRnI5ek9lNHUreldiRlVGZHR3?=
 =?utf-8?B?WVN5RmZ5WjhRUHY4WTNvT2lWb09BZVlTaWxvRHVTUVdvNGZwdEhaWWNnZVhB?=
 =?utf-8?B?Y0ZxY0Z0V3VXekNzL1p1cEtuRkozY2pBWXpJNXU2Y2I5Uy85MzM5Tk5FeWVt?=
 =?utf-8?B?UEVoZzdndkpsVHYzOExQM2l6aUViZmRDbXcrRlZyMDFkbDYyOGlrZUppRElu?=
 =?utf-8?B?RXlvbWF2dUU1OVBLZmw2SGcwUURmMnhpa2FmQTFuYlVlSW9UNUl6QVlxUjNz?=
 =?utf-8?B?eHEyOFJ0MEpBYkg4TWNZMFFuRmh4RXhkVTlBYUFFSkpPSGVaZHF6czNDekZS?=
 =?utf-8?B?RitlS2cza3YrQ29aU1ZiYVZoeEM5TkxMTE5VZDRJbGpqU3B2eXFvUzl1MmRH?=
 =?utf-8?B?QU90TEV0ak1JVTR1L253U21WVC91eWNrd2JJMVJnMXFaMXo5YUhXU0tUU2Z2?=
 =?utf-8?B?RVJsLzc3enNKUHJyc011Z3ZzQ2NmNG1QTW5ZSnBUUFBOdFMwWm0zR0FDa0Iv?=
 =?utf-8?B?bVB1NS9RaEdBY0FRWk4vTkpvbGJrUjF2UFhJbEZ6Q3FGdTBFUzhJTERXSzVV?=
 =?utf-8?B?dVd2MllXVE5qa24vbDRzdFVmaFBlblV0bnlPa3I1OWxISzRuN2tjaGh6cHQz?=
 =?utf-8?B?dkJpa2M3VnQ1SkE1emVUcEhOaUs5ak9wamRGMHMzSXBMaVJ0eTRTUGprUVVJ?=
 =?utf-8?B?cHY1RDRZRjZMVE5VN1I0WUVuSFJBRDlrYXBFejdOb3NmWFYzWDI5MllrOXRk?=
 =?utf-8?B?S0p6cVVXSERkaFoxK2Jvbnp4V2w4K0JjbU5SZVF3a2IyZnZZU2EzU25DZjA3?=
 =?utf-8?B?N0hDaWUxZWdPdjFXSnEvelo0RFFSL1ZsMS9ldmVuQ0RlcWlkSzBjWXo2WGFj?=
 =?utf-8?B?NlF5eXlWNWNNK0hnN2RjY3VtMCtXMjM0UUZMZUtWV1hkcWpvZTZnTzZQNFpm?=
 =?utf-8?B?L3pteVJjUzJYQmlRMnBBSHlzemtqcnhGaEMzWHo0dDBOMGVRanZsOWhsZCtO?=
 =?utf-8?B?U1k5M3ZiR2lXbGFSSWFIa1JqN1pTNFR3YWdTd1lOYm1tWCt1bmpIT3QyZ1No?=
 =?utf-8?B?OXhrSUhqM1NGMXdiNEVpOFo5c1pFUDBiV2VvK2t3NTBSOGE4SWZSbFBxcDNz?=
 =?utf-8?B?cEVEY2NQT0xHTEloMGhGK25TWi9IOUdGSDJmN2hPc3lmcWVRd2NJWlhiNVV4?=
 =?utf-8?B?SzhkeVhaZGlUOEkycHhLdW9nQ0N3WGRwRzdCQXhxMUNOK245cGxYSVk3S3RZ?=
 =?utf-8?B?UkJIQTdLWXdxajlOWGxpa3ZLK3FqZVNqRzQ4ZWFETmo1T3JjaWNJUT09?=
X-Exchange-RoutingPolicyChecked: XAatw2UM6AUQxPFCvNzPLrHnZfo57If9mTNC+V+WQ0OWE4/59LLGCZ3x/22K++LpTrfkVgrE/9KkcStJOwJKOkr3JYsUljAbawVFk7gxTWGMX4+B8vOh0yIjnU8VoOxClCJXrek1SA8uEfzdtgLPHgEaVuXEmwqE96LihYwOP9e/enHytMkX3GFVk+G7ShEKAPo8vDKtF6+clZ7Tv9BgLjB3FLtxY72n3+UBtvkPVpdnXt8BIpHj8A8NQBgg3hjHq70zzmcpWpGomndweRBFpVvj8munMprFtKCtGenwraTAW5kh86/NcifnOyJ8fsPzeQ1kaCRRorrX6KxBjm87SQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: c606c90e-1394-4198-f343-08df397a7ea8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 07:17:18.5131 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aP7At7YegapxmoayTFp1SH02655nT7VXTqXuQObF18jD/mbk2IWafZ0rd0tXXQwiEzhjaRmPCIYyG1nLuRpIV3vZMdVB+dZHajcs2lh5Vmg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4621
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
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/2/2026 5:04 PM, Linkui Xiao wrote:
> Hi Jake,
> 
> Thank you for applying the patch and for the review.
> 
> On 2026/11/3 06:15, Jacob Keller wrote:
>> On 10/28/2026 2:04 AM, Linkui Xiao wrote:
>>> From: Linkui Xiao <xiaolinkui@kylinos.cn>
>>>
>>> e1000e_config_hwtstamp() stores the requested configuration in
>>> adapter->hwtstamp_config right after the rx filter has been
>>> translated, but the two register writes that follow are verified by
>>> reading the registers back and each of them can fail with -EAGAIN.
>>>
>>> When one of them does, the driver is left holding a configuration the
>>> hardware never accepted:
>>>
>>>   - e1000e_hwtstamp_get() hands it back to user space, so an
>>>     application that reads the configuration back is told that
>>>     hardware time stamping is in effect while it is not;
>>>
>>>   - e1000e_systim_reset() re-applies it after every reset, including
>>>     the ones the watchdog triggers, and keeps failing;
>>>
>>>   - e1000_watchdog() starts polling TSYNCRXCTL_VALID for the cached rx
>>>     filter, and e1000_xmit_frame() still parks skbs that ask for a Tx
>>>     time stamp because it only looks at FLAG_HAS_HW_TIMESTAMP, so they
>>>     are eventually dropped by e1000e_tx_hwtstamp_work() with a
>>>     "clearing Tx timestamp hang" warning.
>>>
>>> Cache the configuration only once both registers have been verified,
>>> so that adapter->hwtstamp_config always describes what the hardware
>>> is programmed with.
>>>
>>
>> Any idea why this got marked as patch 2 out of 5? This doesn't appear on
>> either netdev or iwl with any other patches.
> Regarding your question about the "2/5" marking: it was an oversight on
> my end. I generated this fix from a local branch that contained other
> commits, and `git format-patch` automatically added the series
> numbering. The patch is indeed a standalone fix and was not intended to
> be part of a series posted elsewhere.
> 
> I'll make sure to use a proper invocation for single patches going forward.
> 
> Thanks again for your time and for taking this fix into the Intel Wired
> LAN tree.
> 
> Best regards,
> Linkui

Thanks for clarifying! I mostly wanted to make sure it wasn't some issue
with mails not hitting the list (spam or other issues), and potential
fixes being missed.

The numbering will get fixed and merged with other patches once our
review process completes and Tony finds space for submission to netdev.
That may take a bit.

Thanks,
Jake

