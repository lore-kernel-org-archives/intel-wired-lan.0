Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F9F606A330
	for <intel-wired-lan@archiver.kernel.org>; Wed,  4 Nov 2026 11:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=9z/DyAuJ;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QJsiassl
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B73AE606F2;
	Wed,  4 Nov 2026 11:04:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i-44YQ9fKOKp; Wed,  4 Nov 2026 11:04:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EBA7A6075B
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793790256;
	b=ZdJmCQ/1zGu5hw/4aVhlPw7vyQTcUMeCgqrQZAFDpyWwi/R7TbcdKjBUPTjBkx0ThZn4
	 tnL3GvHYgA6g0wc38PyadABKkbGr7Jg1NG0hT8rT55RJ5601CbNynyNP6bRtsEcvW/CjH
	 jkhouqxGLuoXnEIfYyIYhXu8Y4P5Aplo3FOCm6RNVb95cf7QGgAj+5GdL+QZqIt5R/Wyq
	 oyAEv8KiwevDhFvHkCE3/Y01h/+2LoNfpey9d5EZmJtGjDysEpxXQBlEWDYI8P05rf2Qk
	 U3VV6M2WG28BFGHlTnRIbeXqirbTaoYFkX+nMQi5qcuxQX/H2E+CMQmzdoiX3oEinNQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793790256;
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
	bh=ssYqF6H1wG93ThUhpSnX8YvrLnmC2IdnJapFBNWUEsM=;
	b=g40kahEQ3VQtSGR4KoVAgi/kHr03BC4OjDHmmBoIERC1IxtOiSa9zrIQJ4+8RMEJM04M
	 otQ+irRcFBj7PCLSqvn07DPosCAV/0Byzwz2rA7q6mq6zuVDZKKWzbOCKjx9/rdL7PaDf
	 +XxNad4BD4cI9hg6PehsN7efJMTO+73bdIEcyg4IekGwj+tryltxMxLDFb6mjvvD/RJFZ
	 axgcJzeClaItc9IyAP+8XVzJq689GAdY1kcn93ZE/regwl9IR+utYow/1MOysvQZfIArf
	 fIxssi/WeI49eBA+dF8+8lh3hlYeSG9aiFCj4dHudloaCC77FjRTE/i1UfkMgPjDPqw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793790256;
	bh=ssYqF6H1wG93ThUhpSnX8YvrLnmC2IdnJapFBNWUEsM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=9z/DyAuJm/Xqywq53Ltlr4oZuiWV2TWt1R4s6EIxB/4R8XDmesPAD0Gg63X3L5lYR
	 fhwg3kWPlkNQUzSBrTXy73nvc+4n++V1vbtZedw72nChFDr3gBpyHRQLQVzVFTT8tF
	 sRY4H4wbfUZdaGbcALoSvTtvTJitm93b/ZBxJtwRMxbMl07HGD4al3ewrGE8ynFZPx
	 LPk4J5dZ4eOgsdJcRUVQXtkW5Bbka5jL7bv+ghAW9J7qNMtRkq1dSYHCcAYaRcb1dc
	 /9CQvdF2kyZSJA1TwfgZKnZL//u1YAKL6A1NehFmSzWVrjzhxnkTDKBnwaPtYgR5XA
	 iMmZXDGGiA/2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EBA7A6075B;
	Wed,  4 Nov 2026 11:04:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1170A2B6
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 11:04:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F39CE4041A
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 11:04:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Oeqz13IhbTLV for <intel-wired-lan@lists.osuosl.org>;
 Wed,  4 Nov 2026 11:04:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org ED52E403F1
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=198.175.65.16
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793790254;
 b=FAvuPrOteQNWMmA4xmZAGeYiCg4Z64N//PYnEJUOxKt3dF2QUUjB8Dt7UnKxoEZRzsis
 jDqxdUZ29VrvVaWCvPu14vZ44zTccpMofaI+bfdURkO2rmQ3Mm0yx1C3rEZwN3eot9fKv
 esvQPCThhdbpUBmbkTdlTx+Fh3B/DVB0BI+P9fE7ZGt/QI0OklZH+paatsVvwNId0O1wk
 KuT+gePozodFoJPouBfN3r3dmdGRlnZQ+24xz2uTCzG8hUqA50bxbFwsqUD6RmXYTGuNv
 QuAy9ZrMwufbNsOu/NtnphVgbJmL5VehLbaE3ljpU02LuOlWgBGk77dRzWt9CvocKMw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793790254;
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
 bh=ssYqF6H1wG93ThUhpSnX8YvrLnmC2IdnJapFBNWUEsM=;
 b=F+OunWFO7MU9CRSyiRXDECK/TE5nQ/cF9HgV6y6Dax6XTtEXFyXGlVmHcJIoVL55rjjU
 ENAegQJOeuXp/xqk7xbCJ2Z4nHPnqdo7UuDNeGbbQbj2+/+WqXEaZpI1yp1lwtwBwpdkM
 oJbqVJ+lMNtMWSnTaVcV5/OubFeqblMjIUZhIeSWY+tYqT1jTS9HKQX6ki1/PEKfbSdz/
 6zxqIL0pdBbbPVXJzGveCDfZMhe11vfgJWlU2jZzwA9vw868xO/mlZ6II6y7oyibylYqM
 UkN1rdv8U6n/p1rHNVyALky+Blvwq8VVY9DBoc1tB0zvMwgvCNpwtGiLsNWXPpLzBIw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=QJsiassl; 
 arc=fail smtp.remote-ip=198.175.65.16
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.16;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=QJsiassl
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ED52E403F1
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 11:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793790254; x=1825326254;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=hPDSZl9LZRLT84q1AkGTD6FGjw0WfDsLARZefnw29p4=;
 b=QJsiasslUCnHC6LQuy7/HTeZ3BlcdBPUE/hJNBH1K/Wpoxz7YXZXCUi9
 KOj2/3kUxPVoNs6qKcgQBfZ0r+nAblNMsMsFq5SbuyDSk5F/Ob7DVg8S8
 YxJlV1u0SiBd+J6hMbZQmdIsfli5Go+bwZnxKW9IuU1b2OZgDrv5X8gfB
 VttN2FdRSQJQ/1eLhjxgLkPcfAD4+lYjkXRcWXzgdjT+kEcmJ8Ubyf6OR
 3GmUZ4bs0FvQ9ZXjvXe1loe1vu6m5AoN5P3fgETGNvjNZkRc5W/3n+w0l
 l0mDAYP7y4WzDue7HcC5HnFieUQKEDRVs6NJABvPsN5MuOnlcQdu48Ohp w==;
X-CSE-ConnectionGUID: zy4QP3E6Q+yw5WFDc+NNYg==
X-CSE-MsgGUID: eP4Gnv+DSVGqRZ9tkFpbjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2534642"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2534642"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 03:04:13 -0800
X-CSE-ConnectionGUID: TByvzgydS5KV5q+DV1shyQ==
X-CSE-MsgGUID: 28T9QthmR4KkzIjI1Yd5rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="8562628"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 03:04:12 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 03:04:12 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 03:04:12 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.15) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 03:04:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pr9MItl8bFp8Lkvyj184WvgduCblAsSGInBNctcjLMc/5wbky8YRXnXltSH4Y+LdYFycNeCeBRkfpPM7MI9qw1Nm/rZ0KqH+zjs+nWOszJB9ghWni4m9ODhLVYybKp7Fp6jCPPYP9cUxg2CnP+8FCXeGpRUkoUfMdr9WCAO2edvCKyLzr+Kch3Et9JKmPq5OhqCvTKmMn7/tWM5MFNDXAQhUEWaC4ffnkbYBNXInFQ/RPEUW1MniJlvvLo1Kki7I0/GUf1IIVrztjiQKWU9ak62bog25wL5wtO4T9gbxU0FPQ8CBd8/as31zJ3giyirT/ckGFNiltyOOp53CFFIcHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ssYqF6H1wG93ThUhpSnX8YvrLnmC2IdnJapFBNWUEsM=;
 b=EOtBgOETciMQqVqknx9YGmCgjvfNkZutrYOPjaxj1etBjRBdf26GYcrfPRRUSICpWb+f/rHIRXgqCef4EuXMSG4AY7wYMJNFANCcYXVSOIf/yVxGLQm1Gm3n35TMqIX4ETBg6aio7q01ooKbOpnIUqYXDJ3sF4/QIgrAsX4LNpo1roYmnhPIXNYAPNkS/sxWW4Qe5go0EO05NmbW570lPJTj1tNyFw1VDAyTdURo8jCHn4MtIpWZ1yZHEzipaxOu/SgmqxGOYVy2KkFr4ZK/AKiO1xCISA3DW/c1G2I2UdoXtuJVKConWrwGJ8u8L71mcFWNCxKz5md2fNW0AaKnvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by MW4PR11MB8265.namprd11.prod.outlook.com (2603:10b6:303:1e1::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Wed, 4 Nov
 2026 11:03:56 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 11:03:56 +0000
Message-ID: <b53bf9ec-2214-496a-a329-b4e406b842fe@intel.com>
Date: Wed, 4 Nov 2026 12:11:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v3 0/2] idpf: fix teardown races around reset and
 remove
To: Emil Tantilov <emil.s.tantilov@intel.com>,
 <intel-wired-lan@lists.osuosl.org>
CC: <phani.r.burra@intel.com>, <larysa.zaremba@intel.com>,
 <joshua.a.hay@intel.com>, <horms@kernel.org>, <brianvv@google.com>,
 <decot@google.com>
References: <20261103235354.1063721-1-emil.s.tantilov@intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20261103235354.1063721-1-emil.s.tantilov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIUP296CA0018.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34e::8) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|MW4PR11MB8265:EE_
X-MS-Office365-Filtering-Correlation-Id: 95041345-6a8e-476f-a15a-08df3a635225
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|22082099003|18002099003|261102123227099003|56012099006|261021121427099003|261022105027099003|261028144727099003|261026140227099003|261022075727099003|261021123027099003|11063799006|261026121527099003|10067099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: 0ZYQHvnuL1YWXKfgUwKiqv0udlk2+bWnMkz+zZ9l44vi1ssrdul1JyeBcAiX6BnxHVHm7H428ad/nv6NXrejgW9Dr8edJSAh9FUK1u2m3Z6mnnAIsE/M+a1N9zHd7pkCYBbzdiVxHkuoIsKPLw8a2nFBzeTnCpWVFdu0zX019qVXSCAQlkhtrWtRdT3rw5rQtmO+gs6keYkmE6ghEQwxp7Le6PIM/ftT76QGjpxd5fVpe5Rm9kR3iyVeKm7XvhQv+rZNMH1BbmJOOHGE471jp6u4nGJlhVRhRDN0GxvJ/tY24G1Y6gaeubyGyr/hHCM/OJBpG6/IBS+nHz2UJX9Je0m+BTkAW//OgXtB7pclo1IGq1wx+DKGOlTjaIwe/hWEiEffqBSrhgoar/H7/XNajJ/ZGvyvbJPL6ROwpirF5t0pymj+TEbElEUppcWOexnEV+rrTZdHPD6KExWiClJ2gTeso1VEpFVdWylAUTV0ihJyFMrxcarJ98B5FoDLSgnVYXy0EbSfkm8V4tZ/2R+oL1oA4PlxGp0IolYpnzH11R2L3ure7AHCGKNY5JF1aD30l2wWKud/26ig7jlv2NW7wYThFljtBNdziXsPVpn0VqFJKwAZDvfelID7lS6wp+Kp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR11MB8508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(261102123227099003)(56012099006)(261021121427099003)(261022105027099003)(261028144727099003)(261026140227099003)(261022075727099003)(261021123027099003)(11063799006)(261026121527099003)(10067099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3FlcnpGZWxjZTNQS1JlOFdmemFmYmk0TGhMU1Y2NVBnZnpuNk95Z0hTeHdD?=
 =?utf-8?B?Qk9kaVBzSzFJTTdVUlczYTVaRDB6aVJNRVZiL2J6WDZ4d3ZHbWduV2Jsd2ZS?=
 =?utf-8?B?SENEZ2oxS0srY2NzaFo0cGpKMTEzU0lhNkNQaExsOHh5SnptNmdGMWpvL1F4?=
 =?utf-8?B?dlRRS01uNXRwcTdIcUVTWUI1RUY0dWhYV0JWRmc3cEVwT3EzUUdMRHR0T0hR?=
 =?utf-8?B?MldIOVNyYnVTaFFhVnZ3czBnanVvZElud0FkenltT0JXL25wdlJzRVh3Vk9O?=
 =?utf-8?B?L2VVMWlla0NxdjVvcHBOQktFL0FWaTlzcWlEZE5HbXpMQUxmb2hJbjZOdlBY?=
 =?utf-8?B?SEMvTnlBWDVpcnM5YVNjdGRmVWdLZ3F6Y3RjZnFpMm9iZXlmUzB2TmE2NWFw?=
 =?utf-8?B?bk1Db25SSWp4Rm1kbnNZaGRDZTdqVGd4RGd3S2dydHBYdXl6d1VSQ3d0NGNX?=
 =?utf-8?B?aTBQSkZxYmVMS05PMjB1bFF5UmpUeEZiYklEbHc2UFpEYk5sTnB6LzFqVkd1?=
 =?utf-8?B?RloxOWFsOC9DWHFNSzlDeUtubnkxaytyQVM0akpZNXluSmJienR2RkMvbFdE?=
 =?utf-8?B?Vzh4NXNaa0pxa0lwd3hXVUxKN0VscEVmdnZQdFY2bDlZUnBnaTlxa2w2YXEv?=
 =?utf-8?B?dXBTbjY5cnd4VTd5WWp3S25oeTlsY01hS3gvVFlRczEvWkFXTVI1bGNpdUVG?=
 =?utf-8?B?YlE5emhFRk0vRVdFVXE2MTNqSzlWb1dLNDdLVjhPQzNhNnBuTHlFWG1iYWNF?=
 =?utf-8?B?RDFUakVsbEZtcmNtQU9VWUNXb1hXVmZnWlY1NnZhMmxQeWRoUkJ0aVplcEV4?=
 =?utf-8?B?VWpFazhzc3d1ZnpoMVlJWUd4NXNFY2tJK2RJU3ZWUEE1T3hFcU5oOUNCSkxW?=
 =?utf-8?B?amZML0JKbmx5dVRaOTVsZzkwaklSZTV0cWg3QTUrQkhCLzIxL1ZFRlpkdjIy?=
 =?utf-8?B?dXN0V2NwZ05VWVUzZXlmcHJtcFhQV2tNSHIzM2UvMWdjTXRTSkpkU2drRklv?=
 =?utf-8?B?WHBwcW1CSkVoL2VpS0JzdDRvU3NrajJPdFdsZVdsNnNsT1BuMk10U2kxV0gx?=
 =?utf-8?B?YVJyQ1lwYnluY25SQ1BCSEQvdHMyY25GU0R5RW8yWEtmWlAya01kUThqc2Ru?=
 =?utf-8?B?Z1ZBWXllTmhQOHJlYlMveG82eVMrMnNQSmF3dWdtRkltNDgvS3ZHNHVKWUV5?=
 =?utf-8?B?UC9jdHkwc1VNY1lvQnJyaTR2RjNFai8rYWs0TnhoU0VjY2FHQS8rL0dqRG9q?=
 =?utf-8?B?VkZLSE9nWGZqSzR0QSsxQmlRMDdqYnRnWWdJTkNuam5Fc1o2dXJJSWw0K0pX?=
 =?utf-8?B?OFJMUytvLzdnTFJXcmhDNjRJVVlZRGpkM096NXcrR0xFVmthMVRCRm1iU0Nx?=
 =?utf-8?B?d0FFVTdKSnEzTUhLdVVFbVlQaDFqUnBDN1lwMTBWb1doQTZGKzNBRzBYeE5W?=
 =?utf-8?B?RlRXWnlEVDROUVdUYkY3b25yL0lBbjFDYWFIMlF4Y3FqOStNY2VYRHRsUmRE?=
 =?utf-8?B?b2ZPVkwwM0FOVnNFaGEva1JJQ1pPSXNuL0RKdEpVU092bFJQWDFiOFBMTUtY?=
 =?utf-8?B?S2dZZXYxVDZZaUNHUXROYVBqM3JiZzBxMWNDVTdhUkZmaDd2NDBZYTJTbldv?=
 =?utf-8?B?WkRqQ3lwZXVJOVhHVjNiSzhsOFB5UE5wdGZRNVM0SU9Nbjh1bjdtbEFBd2Ju?=
 =?utf-8?B?ZWV4TjFlTEVyQTdVcDduc3hUS1JwVW1jR1ZzZlVPU1dvOHZ5cXJqM3ozWUtm?=
 =?utf-8?B?UnM5dk90WjZnSERKYVBuUCtuOWp1SmRxWE5senVNZjVoYXR0SlNvSVdCL3l6?=
 =?utf-8?B?ZlZuUVVpdjdGbmZMYUprNFh2VHIyMm1DK1U4R0I0b3QrSkpiUG5wT242bTFa?=
 =?utf-8?B?UitwMzNqVFkzQmdRdVhabGZuLzJkRThzeFVvUlUxVk1vS0IrYVpwUEVrMGNq?=
 =?utf-8?B?ZTJrWG1GdUs0SFpBM1h0YVEvbnV2K0tWSUs3WVJjSlRJRWF3RHNWRUwwbTJG?=
 =?utf-8?B?OU91cFhWMUxsK29uaVRWOHhXV3RzVGlOdDlOMWxJQklMWVFJVjNON3M5eWJN?=
 =?utf-8?B?ZTZuVkxJR0I0ZWh4Zkg5UlNQU1pBbTFZMFFrK0tlSGFvRW1mRW9USU8wWktw?=
 =?utf-8?B?RFMwenJaaXVaZmVTZEhEc1k3Q0trS25wRnBvQU1lSGFsVmdrVFNReWozWHR6?=
 =?utf-8?B?ZUJsTEVvdHNhYzJpZEh6dUUxOVF6eFN5YzFhc2dUYmlraFlQa3ZxU1JqQVJH?=
 =?utf-8?B?U3RqR2NnYzV6cG53d3NBTXFsZUlxUEdFdU1oUnFkdURvUVFpK0REUmlvVWZP?=
 =?utf-8?B?NW5rMDROV0pDeFhhR0tURDN1aHFsMXRTaXluN0RhbHh4ZlFGUjNtNjhod3Rz?=
 =?utf-8?Q?oV67TqRfT/S1PhRg=3D?=
X-Exchange-RoutingPolicyChecked: lvV9kHYlEL6c4nZqaULJOobjzxBa83OUxbkQsdc4OiW15vCwfeXj1h/yMdngBiB0ry+Cwt+fVg+T37gbn3pvbxLLRFd+hbUu/gsbbzwXvAA1/qyvNfJls5Ooj663+3Y/XgttImMqmK6ExDPfsmyYW6lF8ekoIoskBUPAiBcMPVVo2yh0/4B7OHsivsqXCVBzDn+JJFhqFM1qcmgqMsptKfWfOQTK6j3g9hm8PpVAt6pbYHjTSPv9z5TIDnLFTw3/kvQzuLZBOsYuVAuSc89zybHl6SUpsP5gWAH8aFLDTpox3aAliCUafXq23fIXuohXn/hhX/l3ik4RANJACLvymQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 95041345-6a8e-476f-a15a-08df3a635225
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 11:03:56.6944 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q96QyzsSNY2zhCBLi1z4Kwo1pBwJ3bWhPH/SSb02fjuJqN+kmy+jT5kCFt+IXpEZcaLew9RAPnk7TW0YfOL0Rpn5IWZmr3FjhrbFmJ8JKME=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB8265
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/4/26 12:53 AM, Emil Tantilov wrote:
> Fixes for races between reset, remove and close in idpf.
> 
> Patch 1 lets a reset racing with remove tear NAPI down in
> idpf_detach_and_close() by dropping the IDPF_REMOVE_IN_PROG early return
> from idpf_stop(), and tests IDPF_VPORT_UP under RTNL. Seen in testing,
> trace in the commit message.
> 
> Patch 2 skips empty netdev slots in idpf_detach_and_close(). Reproduced
> on a reset with FW reporting more max vports than default vports.
> 
> Testing: Patches 1 and 2 reproduced as described. Both are not HW
> specific.
> 
> Changes in v3:
> - Removed patches 3 an 4 from the previous series as there were some
>    issues discovered in testing and review that will require more work,
>    and a likely a refactor more suitable for -next.
> 
> v2: https://lore.kernel.org/intel-wired-lan/20261026221908.24690-1-emil.s.tantilov@intel.com/
> 
> v1: https://lore.kernel.org/all/20260811171751.22165-1-emil.s.tantilov@intel.com/
> 
> Emil Tantilov (2):
>    idpf: fix possible race on remove during a reset
>    idpf: skip empty netdev slots when detaching for a reset
> 
>   drivers/net/ethernet/intel/idpf/idpf_lib.c | 16 +++++++++-------
>   1 file changed, 9 insertions(+), 7 deletions(-)
> 

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
