Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBE5606A31A
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Nov 2026 19:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=dIwgZm9B;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=R3UOrPwu;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=Jnmc4Tq/
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8BC7D60608;
	Mon, 23 Nov 2026 19:14:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8QAp-4MYnynP; Mon, 23 Nov 2026 19:14:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E672760661
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795461276;
	b=fjRrRFpGwrmJ9me+NzDeY+LfUnbqiX9DEd7EKXzxAHao7gFLstpvaggQFTM965H67C9L
	 m5q06ZwRA9vrAMP7O5f/JpRcjWvoDLdUgeSCCyjCA0QEyPx0PLk61TQ2j6NFt3knNK9GR
	 Jf+fsnugZld2bwrDcBXI4XrvwzLjz6bTH1Fguiui0ocYKOc3NULRdgW7lFynbwaET5EMc
	 SEDpl6MC/Ia7IDqUSr083IVA5DiYaJid/Ezjdtyzk76K8M22zVUakgEGaCN4zre9TsJEm
	 kGdyhm6cexQeGX21I7Jv28wLhUjNVjFVuOgOXND5Wm7chMsz+Db8pU3VcoPdgT8EanQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795461276;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:DKIM-Signature:
	 Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:References:
	 From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
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
	bh=kxcLL6eWT+iUOeW4/jFXwg5CdCIFLGdICmNXEfGI+2E=;
	b=YhXbSEBIzMm07US/be1QWe5HHBpsQMtyEpUtApzeBAVAgyTfRi3Ryxmxg8EdbjeyAK5o
	 uuI5QcT4ytB9La74aoHlgMp42JGkNv3QnHbrVMIVg48Sm8NezId8Yq5JFBiQ0Jk+jCH/x
	 nniOvD36rqS5aB/kmdpLAsPnXUA9g6epWObS179Q/2x2//2jMRueEMttHeiSU5qPcV3iR
	 k2Jo3clnifA/S+gYcpma4NVRA1K/DCEKPtUqGWpcNnSXSl9lqN31jcQ6H9yNIzSUYnhNS
	 4qssmjdGqH6kltMOJ82irUJG0OeudGtxUkcEjp4/kiG4eL5u8CdIo3lEq7cNRX2+R2w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=R3UOrPwu;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b="Jnmc4Tq/";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795461276;
	bh=kxcLL6eWT+iUOeW4/jFXwg5CdCIFLGdICmNXEfGI+2E=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dIwgZm9BLtGDFLSeNBADhIiMCloozGIYFTho9HOVq0EFnnD7yYEywon1I7JnY36ko
	 uWhCZzzuWbBf7y+7eTfpCP14JUp5jXQyF38+7HdHHf0VQn0K+nLq8wbj/ZK/hNLT1d
	 nW5Nl9YYOhXUQW2Woq/ORzkUPQrw5/U2+82p+LPhgf/aM4uW9wIfK2jl/SPy2kPd/o
	 9Xv0OePZ5sGc8fAs2PLS0fN1QH4oGgVUN9t8FjLrAcdUF8q2xkoQ9MekUXf9HcVus5
	 KK9lcKF791W5M3i/uTnXHLO1VYEkzfw+R+Jk0SGsdB8EHPgu9KP71HNPXHBFSo0TG4
	 u623aNkC4JyfQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E672760661;
	Mon, 23 Nov 2026 19:14:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3484E22B
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 19:14:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2638060661
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 19:14:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f5uacBkJ9_nz for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Nov 2026 19:14:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C770B60608
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.18
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.18;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=R3UOrPwu; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=Jnmc4Tq/
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C770B60608
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 19:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795461272; x=1826997272;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=R3WREPDWeapbSnPLfjb1tKUjLtxXgCSMrMJaYG7PW4g=;
 b=R3UOrPwuv56qH77mee6MJcx7Epa883d+cBDBsu+H4vAF+hExR18aXriN
 jWCKuzqUyUU2nTDrNuPbXlB5plxAE39uKksgKa/nyaJ5NBCEPJPPixMQY
 Y3TDAr4zTWdzwU48Ttfxrq2X00Rj5zrdABFF7gzAtxc7EuluzQ2H890OC
 smv8DrNpwZtU4G68ZiAC247Cl/GtMPbR5Gv++pKmTQJtOv3tKTMAHnfwL
 Ce5/g+fetGPlFZWhiCiIKrCCvLbfyQhxztT8LxybVqIGLvL6R5JCFBD/d
 eG2U8dbH7ovJ3S353LjEn5VGWqE3F/HYNncPFeLqNK7jkVjGQx3+gbIWK Q==;
X-CSE-ConnectionGUID: PKf0d56BSSm9rdtHDxTzBA==
X-CSE-MsgGUID: cm19JNf7QMqX3hOoW3WEMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4308960"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4308960"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 11:14:32 -0800
X-CSE-ConnectionGUID: IB/Z9TesTYO3uuqlKlxNHg==
X-CSE-MsgGUID: MdCcDxhbSDS3pDNkw+qUKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; d="scan'208";a="11453428"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 11:14:31 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 11:14:31 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Mon, 23 Nov 2026 11:14:31 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.25) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 23 Nov 2026 11:14:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxcLL6eWT+iUOeW4/jFXwg5CdCIFLGdICmNXEfGI+2E=;
 b=Jnmc4Tq/RIPv68ZS6GZzWDQixadkyOg+XJa+wWXajXWRXZAiHtl0iiwy8k/Rf9+TbbEWYfcH2Dvoc9GJSN0Sd6zoiU1PF6lCnYZczgeBOA9K+4Gv0vp2WmwOmZZK/lMDP5q7IvyUxHhrgPKEUV5t6ICBbYJ+JfysU1W84WOA6SU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8451.namprd11.prod.outlook.com (2603:10b6:a03:56e::20)
 by CH3PR11MB291940.namprd11.prod.outlook.com (2603:10b6:610:366::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Mon, 23 Nov
 2026 19:14:28 +0000
Received: from SJ2PR11MB8451.namprd11.prod.outlook.com
 ([fe80::7d5f:b2ba:92d4:5f3c]) by SJ2PR11MB8451.namprd11.prod.outlook.com
 ([fe80::7d5f:b2ba:92d4:5f3c%4]) with mapi id 15.21.0639.011; Mon, 23 Nov 2026
 19:14:28 +0000
Message-ID: <455bd1da-b844-44d9-8cdd-ff979043dd51@intel.com>
Date: Mon, 23 Nov 2026 11:14:26 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/6][pull request] Intel Wired LAN Driver Updates
 2026-11-13 (ice)
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Jakub Kicinski
 <kuba@kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>
CC: Petr Oros <poros@redhat.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Magnus Karlsson <magnus.karlsson@gmail.com>,
 <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 <edumazet@kernel.org>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
 <horms@kernel.org>, Marcin Szycik <marcin.szycik@linux.intel.com>, "Aleksandr
 Loktionov" <aleksandr.loktionov@intel.com>,
 <intel-wired-lan@lists.osuosl.org>
References: <20261113231225.1864810-1-anthony.l.nguyen@intel.com>
 <20261118115915.116177-1-poros@redhat.com>
 <CAJ8uoz0MMUx68rMZWoZs-JwjodpRixwQSrgpyta1NsanGPn=dg@mail.gmail.com>
 <av2syi6lE/Vp86QW@boxer> <f7f1ae2d-a623-4eb7-a178-c618316beaf5@redhat.com>
 <0bb65ff3-2e27-4f2e-aaa3-2b8eb7cda356@intel.com>
 <fe1ce4cf-3400-4a87-8e46-072563f8fe9d@intel.com>
 <20261121162859.3522ab89@kernel.org>
 <ab89dce9-c124-49e6-b6bb-036b69beef6f@intel.com>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <ab89dce9-c124-49e6-b6bb-036b69beef6f@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0204.namprd03.prod.outlook.com
 (2603:10b6:303:b8::29) To SJ2PR11MB8451.namprd11.prod.outlook.com
 (2603:10b6:a03:56e::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8451:EE_|CH3PR11MB291940:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a36543a-d82f-472f-60b9-08df4995fe7e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7416014|23010399003|18002099003|22082099003|11063799006|56012099006|4143699003|261026140227099003|261022105027099003|261028144727099003|10067099003;
X-Microsoft-Antispam-Message-Info: 0DpKP4u+7Ev5GhU3PLy1098pZvuOimN5HRayU4RbC2JV42j464U9E7C8rppdpz9Q2UJkRDxNUr0p0NQ6X+Q/BB4ZQYm3QrbonUUktfajlnedceUnEhZfGmLMuxxtRzj47ZtlzZDwXx1ngZ2mXOByXxS2wQdDrNYAA3lNTJ7JTF+UOPvEGDtCmROBMbzkUnuEX71v7kpFHW7tYFK+/rtRpEpKoR52bQ9F6Y6kmBjGdup7rJijPsRTr5jPlY5gkxcHmdaFGes4jHqJJP9xQxRT6xhpb9Uk88QLCkd70+R51065I5vyHZ9MtUWczEgB3szuBPuWXSXzLdjD8FETNOL/QQorKjMHju9YoiuQchXqA249qoeIm8wIx9xsZsTXJDAggIT5+rb8ycNCpPlF2/iOZG92Jsx6vkIwreTTy1+4nyBGWdFr+/qljDYv5iFiKW9UIZV+JIabe5n1Bfwh1cN8Ln2qwalhxhhPc3iaXOosMgpW4/C9JxjHqsmbrObNZEmwirHadneuo26cuZydffIQQWFRwwvd99sfWQQslOhp9+s7jew4Aqe+3V334dc08BtvxuUC2Jx3AMaAhP64gndXlCSthXcBPHMIoOFnzR1gkcKbllfJOlgchpZjIMd/efFXr8LsGclrVF6/IXOLSyrRDH95wovWtGgniDEmPQQw4p8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR11MB8451.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7416014)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003)(261026140227099003)(261022105027099003)(261028144727099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkJnUU1PYXRlem1BNFRTblhOeHFrajdBbmUrblhvRG0xaExLSEl3dXZNUDNw?=
 =?utf-8?B?YUFrVzUyNUQrdVBCSm9pSHFTQzFrcEMrZjR5Yzd0eDR4MDR5WEZhdFBXRmdx?=
 =?utf-8?B?UjZxdU0vR1NxRjYxZ3BwTnpBMU9KMHhCWXpqZzd4cURBNEdMUnEzcElHNjJG?=
 =?utf-8?B?KzMxeUh5djFjNmNmNGt3VlVHaDQvZW5DNnFDWGtzMFBFZGpTajNseXZqQWhK?=
 =?utf-8?B?S2RWWm9EMWRlbktkOXFRRE04TzQ3b1dsQnAxZS94K1FXOEEzUlRwL2FzQ3cz?=
 =?utf-8?B?cXQyYkg0OHU5QVhBSHF0SnRwUjJGZHpFNHVsL2dtbFJzU0JOa0psajJNcXc0?=
 =?utf-8?B?WTFOR1lsK0kzZnFoTzI4MHFJTDRzZEt0Yjh1RXlqdDlXS2YvNy9SWTgvZHFL?=
 =?utf-8?B?bFJkNTBuNU9Ndis0R2lXaStCMVpOMlRBVmhBdzYrTkwyK3lBK3ovazFvaFpN?=
 =?utf-8?B?UWt2R0hIN0FqUXV2cEVCdWphK2pzcGxvdjhmTGhXa1l4ZlFTWWtiKy9ialhm?=
 =?utf-8?B?Ny9PaEJRekhPOFR0dDYwZE1tNDN1SDNaSHJJZXJSR2JKckVqL0Q5QWtiOStk?=
 =?utf-8?B?cjdxWGxaeTg3TUw0UW5kbVltYXJoMTBMdmpONUp6ODVYZFNlVGdicXZCTi9B?=
 =?utf-8?B?dnVLOUJtUEZ0RjhFbEVtVjA3K082YTJDTWFmY2J6ajhSSjk5QTArNkN0QnZX?=
 =?utf-8?B?dFc1b01uWTRCcDRlV3VNb2FnakVsS01rR3JhRDVLaVYrU0V6MjRXamFmZUNy?=
 =?utf-8?B?THFZaXlXbHhVcXUweVF5ZU9OSzdxWE4zeUNZaGZjdDVQaVhETXNqQTZuZkxY?=
 =?utf-8?B?VlJPNnZOMHpsYnp5UW5wRDd3WW1idUFCY00yV3Z0QjN6SUZzajQvOW1WaXN3?=
 =?utf-8?B?Q2NtSHVObmIxaEkzWjFYUG81Mzhrb1JxZGZGSnZRdDVBTXd2SXVDMjVtNTl2?=
 =?utf-8?B?eTRDbEZxb1B4aUFYdkxSUWVHRjRkZDNLMGJGSmF2MWpxV3NKTCs2MHVaRGl3?=
 =?utf-8?B?TDZMV1d6eTBEWWtoWkhwM2tGLzNsaklaMW5zNWY0NTlmREFhUjYvbldHM3k0?=
 =?utf-8?B?SEE1Nks0U08ycTJaemdzQ0VNZDRNSXhOKytmN1ZwVzlCb3VIYTI2M3dJWGV5?=
 =?utf-8?B?bnBPREZueEx1QU04dStLb2h1Q1M0Nmw2dlQzdVJCdU4vb0dHaEo1L2o2OXRm?=
 =?utf-8?B?SnpyaytMYldwY1E2TWdvN1hDUDVUM3Q4ZXphcklVR0FtQmhMNzgwSFlzMVpu?=
 =?utf-8?B?clpseGlzejMrQmR4SmJybEVTNXFhVk9yT3RaR1d3MU1GSThkV0VTRC9VZkxY?=
 =?utf-8?B?L2NhdTJBVzMrbzNzRkFHNEdxR2p6MXRLaU01bkliVWRHSEdPY0ltZExieGtM?=
 =?utf-8?B?UzFqMzZhbERCRkREUzd2akRWY3JmR1lTbkd3eE41TG16OXk5QmovQlBLQkhN?=
 =?utf-8?B?aXIrWFgvQ2tQcXVLYnNGV0Nna0dyalNEMTQvZU1IRENhQ1ZhREFkU3Q2dXJ1?=
 =?utf-8?B?YkNUakFFKzZxNU9Ba255bndZYW5QRVFURzlnTkNGWjB1ZEJhZWFuQzNmR3da?=
 =?utf-8?B?akpCc2VSbk5lZGhjR0U4dFZXSjI5ZHpYSXlKeVA1aHhUNkNkdXkzcGNzWWlt?=
 =?utf-8?B?UU9JNk5QWEdyR01jRXQvNW9LdWpXc1lZQytGaFlFa2VnMXM0N1pTa0MvQng1?=
 =?utf-8?B?RUNTR2RvaG03UHNSQ0ROVW5PY2dCVzRBT3JjVmZOazUrdGJRK3R0QS9xb3lO?=
 =?utf-8?B?N254MytZdkV1alBMMTVyQUlpRVJoeWkraHJ0UDdqanVxMlY1UGQ4R2dOSkFs?=
 =?utf-8?B?TmlxOUxROE53V1VMVzJkQUJHejhBVzJJVmR2N2tqUCtBVHhzTWNER1RYclpM?=
 =?utf-8?B?YmdLNlVQbmEzRjZOdC92Z0dkWlpzYXpiRHBoMmRFbXdUMkV5NEI5bklOUnNP?=
 =?utf-8?B?OStpVkJ4dVBqRkU1OUJsMFNaN3A4d0M2d3VJY2lHUTRKM2JVeFE1NzhXVlZa?=
 =?utf-8?B?THpuZ1VEV0dwOWlUa3lGY3NPeEJkaExKTmRuYW1wUS84UFFPTnMvNDlxWGRT?=
 =?utf-8?B?dnY0Z1JEaER5WERua2wrMEFMeWMvK3JseEhsQWdvWFM3ZUtYYWg1aXBtcEcy?=
 =?utf-8?B?SXRuT3dhb0JCd090RGg5UWZteUtRbDN6anQybHhoNFUzVklNTG80Yi9XQml5?=
 =?utf-8?B?akJQcERPbFpRYkRCMUhZOFlrejlNVmdDeWI1UGVRZUhjRnFnUUVCMEMzT1ZL?=
 =?utf-8?B?QkV2Zm1QMkJIZzZINjhTL0FpTVlXMjRCVEhHN1FNeEpQNVZWQ2pBR0F1RDg3?=
 =?utf-8?B?MWN2LzhIcEdkY1RaZ3FpMm4yMnBvMDdGMDd2Visra2liY1dhMlBEdzQ1RE9N?=
 =?utf-8?Q?3/nFRhD3wqN67I/o=3D?=
X-Exchange-RoutingPolicyChecked: XKf0vs3mQLi5XeTpJQbJahZ5vD9YCw2EdEcdC4FrU2NHN3wSSw9OIohtcXtiaBQm864k3DQU7TEHXSMuzCmZ/v2ue8CWDKfkH/LbrbunQl0/nyUrOVf2gyn93R4cPayWKnrgB01lcrVH/1tMYiqFFX/2E4WGMMox3LKBDb/QkMRjjmtSRimcfNsEnDxEjZ5mnEz16ZgZZQM3DEXtr4WiyOsYgXEYUB1Vd+eEuGcMbguWAUaegOblMn4fBuvEXy5T038Nku4r5vkPMZ/CY7I/5LYNBcD7C1e6pjKzvGeci7VG038JNPU9Ag1Ccb4rzODbzVfJsPmN4B5YaxY+2g/vyA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a36543a-d82f-472f-60b9-08df4995fe7e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8451.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 19:14:28.0362 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ypjli9kkrEp1StdgKPPUj77lHmMN/bXUi/c7RtF6KXftpLrWTNFDs+ijjCIVGjA29FnpIVUXp2i9dUbfaY1xPIWOrL6iXGewN1Vcslq2aA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB291940
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

On 11/23/2026 6:55 AM, Przemek Kitszel wrote:
> On 11/22/26 1:28 AM, Jakub Kicinski wrote:
>> On Thu, 19 Nov 2026 10:07:10 -0800 Tony Nguyen wrote:
>>> An idea, but this would still increase the queue for netdev, would be a
>>> separate budget for non-Intel authored patches. This would allow
>>> community patches to continue flowing without being blocked by Intel
>>> work.
>>
>> No extra patch budget will be provided.
> 
> for our purposes merging a patch from outside of intel, is the same of
> +1 to the budget for given day ;)
> 

My read is that such a merge will impact the "budget" of what the netdev
maintainers merge, regardless of how much we send.

Thanks,
Jake
