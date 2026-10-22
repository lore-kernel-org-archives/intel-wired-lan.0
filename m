Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA038606A31D
	for <intel-wired-lan@archiver.kernel.org>; Thu, 22 Oct 2026 18:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=fcbSUjp5;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ejunPKF5
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 984A46066C;
	Thu, 22 Oct 2026 18:22:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aWDJE4V5lSF0; Thu, 22 Oct 2026 18:22:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E45C06070C
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792693353;
	b=S/f5YB9Glf8cmub26rpXq3ESX3TropOaUJEmoSDi8CgY97DbC0xZj8SmsiHwtyd9IKIZ
	 mMmwfbGm/fJUnsraNiIK8K388U+2lUFDSdOMnKRMDEKzhLfeB2IiEztHzzfwIvRfXnttu
	 1f7SMzY79/cFFE1XMD7Vu0Bfknw+vCZsIpfOzm1nZJBvi5IddJQPRrwRld9sP1F16SXKH
	 bnqqnhDLTrGnbeA6K8pvq+EE3sYgyEm9BGwNLNRPc4yfRDUHEmXlfjqPejxMSLzgiLgFO
	 G3JlTlGg1N0j+KTq/XJsqRzsq6KjxGJ0JKQFYbtG/6vCkuM7s+xUKCbOAOm83k48UlA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792693353;
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
	bh=YV55RYss7vg6RCVkBBRHIz5NMaecvfZK0uWVXFn7no8=;
	b=XPm4KnLnR5RTPn4XhLCRtwoAQQMq+RR4AiCSKHIt1aNu93T5JZ+iPWGorTcDUN36LlPW
	 Wbhf0i0YlFWp3CSQzL1lhZ1cznlxy73YITWG4U57wNDJP66KOx7+fvRj9TM4Z5+byWlRY
	 RRvWxr+VqA5vKFKpRJbl0Eqrn0H2JKIXNQY0OwfN/2g7g3AoSobm6wJZAVjY3tNqEgiuj
	 +yYSR7oAZoKPUgvXh5cEVJTYtd4zHoZ3trdIlC2hAfah85SxtH6DXeGIXe4i9gAH5d8Va
	 isr5FMYF1ftRzeZyJzZYvOG6jN5rFEQLrTJryKKSV1ItiGuem8hoZ8ohZOPaw9z+8Pw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ejunPKF5;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792693352;
	bh=YV55RYss7vg6RCVkBBRHIz5NMaecvfZK0uWVXFn7no8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fcbSUjp5j4V0ZP2370cC5FCARUrlPdil7PzNwTWxP3ANps3m0eUkQn0eOMeQloAWl
	 qXMvVpOVK4q0zUnNmTV1m9t034kBUD9hUsTM+R3auXgZ6rySlirIFsaVbs2NR5j8LQ
	 S9b8FZYvjF/7WV6f9fZsIldbi1J9dpDO84npntrwR5PGOajdlcFiokB1r8vgQxZth/
	 cnm9NGBTePxwe/E1TbR3yi4iscd4NqCODAE4dlTKqqjd7RIZ0s954yhmtBHwJmiJax
	 ldtaPOkRnIvuzUMmkaDaxZz49cRoX7fFupsxj3GfvWOXLKMkJ6x/dR1qtZ3YO+bseb
	 ezZtotkPs8yTQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E45C06070C;
	Thu, 22 Oct 2026 18:22:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0C4853AF
 for <intel-wired-lan@lists.osuosl.org>; Thu, 22 Oct 2026 18:22:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E61616070C
 for <intel-wired-lan@lists.osuosl.org>; Thu, 22 Oct 2026 18:22:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fiswYRceBiup for <intel-wired-lan@lists.osuosl.org>;
 Thu, 22 Oct 2026 18:22:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2AAFB6066C
Authentication-Results: smtp3.osuosl.org;
 arc=fail smtp.remote-ip=192.198.163.16
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792693351;
 b=Nx2xXItzq26WLkvW5m0FppO/jnk1h2MqAxsGsQXRVoMTmpdC/ddVaVp+rblFp9HCWqWA
 PUkIrCMx8MDJTldcKREnHR8u76T4Gh4SmpNPVJlyXcElExAeCADZWQ4QPbcpuaLk5QQ1/
 HTRDwbTrWAtQvQZhogJk9RDtf0KfshTDxSCfieR7/N3d7XArk6CqBmNhGfV2/m2femrhg
 tvTDjSYBDZc/CN8SblMYZjWrQD6RagAEZKwpPNUMmaoUJ4x+8PasEmGCTdIsIwVBZpaCB
 2sGzB2B4YHHGfGpmbIQKtzTr8116vYXIfXpgFSMptOjZpm1hZNCl8K4p8W1YjvGJF5Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792693351;
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
 bh=YV55RYss7vg6RCVkBBRHIz5NMaecvfZK0uWVXFn7no8=;
 b=f+1Dm6qMTk4+GzlhmS5U6+oU7xyUGzczGgdiSM9OwwhiaWEiHNX4aAeTmYWmu99b3Y6b
 S7xB20vY2n1VssWqeNEnMngXbhEgm2cvDlYxZ5qOUyohL5rlsERjYZig1ygOn1Y0xDTvz
 XwoGYBhisfDJRzVq0AqZBkRMJQIZGU6wfoQVSyTjhzbpGv7pcgqjuB/1ugnMMPOLCIcsU
 WwS42L4vLqyjXvcqouuqrNpi/id9S4aUDFoKlX5MuHdGI6zvcW+bDbXTMorBv4jh/GAAx
 TVtTNbP1WGoayoLjxxs+NgK6ZVsneX5/8aDJgyh0x5z3lLEi1/0gHw8NAnFCVi2fdfA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ejunPKF5; 
 arc=fail smtp.remote-ip=192.198.163.16
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.16;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ejunPKF5
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2AAFB6066C
 for <intel-wired-lan@lists.osuosl.org>; Thu, 22 Oct 2026 18:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792693351; x=1824229351;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=1CLrz3UjJKBr4cWpJ06lZ1jG7lbEqSXhDamwGO99aCQ=;
 b=ejunPKF5GXkqydnLUGrTqxmzl5SyGbqlzhehchPP8I9lz0JGmhe4DdIv
 IRzeN/P78ypTJ5iDz01qwDKupMLrpmvuASzLxF5FuotxheDKGN8Z0kOQR
 Ze0F0+MdrNUdEvzKN7eTxnOjA2l/CI9Cp5Mp05cM22afEwrxW1jN4Jkae
 G5PcjWr5He9dqcGVFPZ3Iv16uDMtgsfRk0qavro9zfBzg+SFrH5mOPUf0
 TJruuFzFqQ2Z6gsWlJ2vg1SpE+09gl+mV8h/EFr+K84j9/7+QYyhF7spJ
 uUHBSwqIiVFnUU6EJhzVFr3JqpVy+T11suAxT33dfrvnzkBa+/LtaCvea w==;
X-CSE-ConnectionGUID: x2RJ82KQRSW3t990DUBSwA==
X-CSE-MsgGUID: zGQ4NCdaT5akFmHypAgH+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1459564"
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="1459564"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2026 11:22:29 -0700
X-CSE-ConnectionGUID: SMRR1lMgRWODHrmUUiE2Vw==
X-CSE-MsgGUID: EdxExPa5RhyV84VmUw7d1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="5253537"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2026 11:22:30 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 11:22:29 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 22 Oct 2026 11:22:29 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.28) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 11:22:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s0sxT1v1jK33/dYrY+byOP0BS8o8tGSMsi5LGh6nCh358ekeAJGdSOaIgfj0mXxzkHfrROlTnB8NmnHjtghuwqyzBtrrqvocn9q5ROv/z8bEm1TSZyfRomD6Fsofx71pvfr509HNhR8924njwBd6HKXXGIBYH69zFBEVaWzfby5spHQXwNGSkoBcJAQD1J73qBMe5FDa/qrcAbR2qaF81nSPfFGGbuvGaHGTkwP5U0whTVifWcu7i/nwq7UeC9tA6LLS0gI7KzzU43WahmYiT3PwQCm8hNA/j1ZYv7XvcDQA+DdsyTs2rJ1XfxaEJBbZqGUy3kWtKIqZLl0MlEX+ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YV55RYss7vg6RCVkBBRHIz5NMaecvfZK0uWVXFn7no8=;
 b=Id9bAEgwzt/bOieLB9lJUIhZITQieUKRwNCmO/Jsspu10mmHrh7Q9zKR4O0yWkN98fQ2dAD0qhRGjarZ/vmQmGbc4u+Vd31DsUH5JhcirtfjETQQJJ9y1olHaBTnvaaaMZUdn7gXxN9mmI/fs1Mjgi1ZjDq6G7ZJ8ChAEzsJrCDax1RcfVM4IhjaeW1Kt3Yyg/gm6fFqehwgGFC0wXVsbMkf0aRhuzy6UHc/wmEjpsOjs3fvfoIaGiN3PBWer8HBbBRsl68IeyBpDZCjgoIFaKzao0o/ZyJVne9anvN4vL7qJCa/HnUci/gPFnf9XKtvObx3jJ7H55vVtW9XTUEISA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by SA1PR11MB8428.namprd11.prod.outlook.com (2603:10b6:806:38b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Thu, 22 Oct
 2026 18:22:27 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 18:22:27 +0000
Message-ID: <d88c476e-d1cf-4769-81ba-f0e1bd2413d0@intel.com>
Date: Thu, 22 Oct 2026 11:22:24 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] ice: quiesce PTP periodic work before system suspend
To: Aaron Ma <aaron.ma@canonical.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Richard Cochran <richardcochran@gmail.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
CC: Dan Nowlin <dan.nowlin@intel.com>, Brett Creeley
 <brett.creeley@intel.com>, "moderated list:INTEL ETHERNET DRIVERS"
 <intel-wired-lan@lists.osuosl.org>
References: <20261019105155.3793063-1-aaron.ma@canonical.com>
 <20261019105155.3793063-6-aaron.ma@canonical.com>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <20261019105155.3793063-6-aaron.ma@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0337.namprd03.prod.outlook.com
 (2603:10b6:303:dc::12) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|SA1PR11MB8428:EE_
X-MS-Office365-Filtering-Correlation-Id: 428bef2e-9b59-4920-599c-08df30696cee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|1800799024|366016|921020|261022105027099003|261022075727099003|56012099006|11063799006|4143699003|261021121427099003|261009223027099003|261021135927099003|261021123027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Swiq5zJ1+Ja6ypMzGsvXVp0iD8RHLNeZzeXkoEs6UYc05spyEs/LiCp63+rVZvSkBHWPrMSB3v/OgnMHlRuC5xLG842QKKpcR84UVgRlkR/62KPPTCumJql8/VyS3/hZ7/L/RSNt4ySe/1RN0EoWcFU4qdl5ZZ5w2hhejxgmiMjedbALxH1Gqe65N/PQHP4YJga1d9xFoQFGjE+RkuA+wgNjTVIKFSxmC67z5FZuwqaZXK8/Q2eyyW777PXrD38SLUIxiS0LKMWscKlwz69AA37P9kLhqzkbcH4iOGnCurlqty0TIxafKYMt7ndemF8ltLJal10T9vuxfNn5ZTbxhfome8KToy38eo3HBXNGk1cJ5Ruvoq8i/0wkzSCEDEO9XN29PgjYYkGMfwIqwC9ex1TSLzx9ykoAxD90e17KfTiGq65OqLEs560GRSAf0Xu4f6cyv4o7pnzBp8nFUW1ZGllMSlHQoJIIKKPE78vgkKqR8rXDjmGS0qpn3ke7aj1jw7V3O+VXrg1+AxUTGzEgELfwn9hoOMSaZhljoGjzfn/jqa8xSz3sxpxjvONkhCGq8G3phEQbqwhNNZ1Ienzf7if/FVpVs+tX3z1h+iJWRXg3AlY6Y6E2wEnppJdJbo/K5lBAtj6GZGuehkg+QCySkLqJCbSw20zMeWWbuo+1AHQvpuwWruqlZtEigpcrWegQgXrys18Khdth0GuxWLE03g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7381.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(921020)(261022105027099003)(261022075727099003)(56012099006)(11063799006)(4143699003)(261021121427099003)(261009223027099003)(261021135927099003)(261021123027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWdPMFV6Zkdoa2FQdW9VdkJMbXAyRnFnSjNyL0hBZ3FseENPMVV4eER5VFVU?=
 =?utf-8?B?aUE4SW5KQ1M2bDJialVZUXhudDF5WjJTTDNVcVFqS1dnc2FFdGdmeENaQ2Ro?=
 =?utf-8?B?YVlOaVQ5UHlXSDJvdG53cGxuUU9FaVB4R0dpWHBmNTRxMm1aL00vTTRKRWNr?=
 =?utf-8?B?SXNFZHUvcVdEd1ljQ3ljMS94Y2NaTXJISWNRWXpDRGxCV1ZZREN2QzlzclFl?=
 =?utf-8?B?SnNrNnIxdUxBbTRuQkZ1a3dZblJEV2tsdU12SHp2TCswZ2tiQm05UEVHcUNG?=
 =?utf-8?B?anU1dkEyaGtpbEcwc0ZIRk5PMlpZV3dXSzRscyt6SndoZWE3ZTNtWGlobk9H?=
 =?utf-8?B?dUVXTXk0T1lYenFDOGUwMVAwWmwzb2M0bEMxNGE4eGo4SUhWM1VmNllDT2cr?=
 =?utf-8?B?aTkxSzNsL29KT1JycTR5VlIrakpGNHZjaW1mMlRBQnFON3BGbi9MQ0VUZlNm?=
 =?utf-8?B?aGdIYTFPaEsvM3ZhdXlZMTI4aE1mTFd4N2pRWGlHTk5HajRZRDhQVlFTd1M5?=
 =?utf-8?B?RnR0Z0crejVKUDhDcWZJemNpYUx3UXhtQ1VPL0IvclpaSjhmampBZjFza1VG?=
 =?utf-8?B?c3ZYMVVWaEtNY1grNHFmMU9EOCt0M3RsZVJvMnJBVE5qaTl2aVlpQXU1Nmt5?=
 =?utf-8?B?Zk8vMzBjUjArdk0yN092QkkyM3ZaYTVrU3Y2UXRSblB6VDJoZ29zWUFhbDVS?=
 =?utf-8?B?OEpRU2pBV2p2SEw4UjVaWm5HUklQSVpCWkcvSmo1T0RMdmRYeENzaWFSOGFR?=
 =?utf-8?B?QW1TODFQNVJMcXZML0tqWUxZaThYZ1pScVBRK29tQXVtSmhmYVNGWitwV2JO?=
 =?utf-8?B?UjF6NU02bHpsVWZIQVAxeW0yZjZLbGE2Rk1qUi93YkNuMmRJeXc2ejlWTktt?=
 =?utf-8?B?Y2Iyd29aNTNkSVZFc3U2WHBGdXRWaDZNUEtjem1PQ3ZBdjZXQndITkxuTTNv?=
 =?utf-8?B?SXBxTWxZL0pWUnVWdGpzNWZieXQ1QUpKWVJWaUpleHRsY3Y3LzRSNnErNkVa?=
 =?utf-8?B?c2FFY0ZjYmY1UStvUVF5elFReHNFeGFxVHVKdVlqdENjclZhTVhrL2dNQzNt?=
 =?utf-8?B?S21sUFhoQUM5T2VMNFJ5dFZ0RjA5VUR1bWFvMEtwa0pwTFFuaGcrL3Q2c040?=
 =?utf-8?B?TFRtR3lEOWd3cUFtdXRTOHFMdXU0eWw1T3FDYnpmZFl5Z1BvVnF5V0ppTCtD?=
 =?utf-8?B?bjdPb0h5bzExSmxjL1BBNzl1TSt0VXd5OFJTb1dRY2s3SDJhNmZRL0lMZkt0?=
 =?utf-8?B?bzNLbUZVS0ZNbnc1RkN3Q25EL2xQMGZKVmRNbkhLMnZFdDc3c21qOG8xNWZv?=
 =?utf-8?B?YW16dGpaSWhGcGZCYTdGZ3RGek01dVRraWtuMWxIUnJ1b2FEdW90anJxRS9V?=
 =?utf-8?B?RXd6bGZRZk9yY0tsb1NnenF3WHBpUXB2dG5SOGh6MDE0N0RUczJHMjBhTi9Y?=
 =?utf-8?B?ZUFsYXJpZXJlbUkyQ1RFUmFLd3dxdTI0dXU4OXVoSVFlTVN1WlQrQ1N3Ylpo?=
 =?utf-8?B?TFBOejFJcXBzSG1VVVVDaFNtd1Y3dDRTRlh4a2lzZEI0QUFiS010VUVSVHVw?=
 =?utf-8?B?ODZOdFhSbm93U1ZJN2F0SFFYVEFJMVlHTStzTE9tQjE2b1lUaDFUZGRDbWZ6?=
 =?utf-8?B?dmpHTy9SMHNETHNyUzFkancySUk4L01MTzJKLzZjYkZ3cUp1b2ZXN3FKbFky?=
 =?utf-8?B?RmRHWndsaXo2c3J0WnBiTUZ3K0tRV0lFTHAxaWgxRk5YcnhabkY2czgrcGVH?=
 =?utf-8?B?NDg3Q1JSQkdOUGJKVmFXN2padG96ZEg4ejV6Wjh1OTJRdUd5SUs1cEtjTUxB?=
 =?utf-8?B?MWxzVENwMTZOTFhUcUhQZkZvTXBjRlFZUERGWjV2KzVFUmE1enpIUStFQ2xi?=
 =?utf-8?B?ZklTUFpXSjJ5MzNZSjc0dnV5cmMwYlY4bndtSmtPQjN6OWZnOU80N2lHNGRt?=
 =?utf-8?B?OVhRZHB5a1dCS1ZCMDFyOWVmZk1JU2FUdW1LUVc1MHRDYmtmemg1eHd6NDJC?=
 =?utf-8?B?R1pUNiszK0dJNHFIbGJ5RERTQVFkTWlSZ25GenhnRWM2cys0aEU3VHliY2hC?=
 =?utf-8?B?OThYazhMa0E0WXF6YmUrbHJFQXFwdDdCRnBSNEZnMXlVVU5DSUF3VjZnV2NY?=
 =?utf-8?B?cy9BMkorNGU3ZDhDR004elNxMnIzbFByS1BadTdSSGFja0EyZ1hERmdSRFBS?=
 =?utf-8?B?YXpVWXVKT3Vva0VIYjAweFd1djNHUjRSWVYyM25zTUxrQ1lhcHlNNmc0aXlP?=
 =?utf-8?B?bGxRNUdJMytwN2pHeVRFbndOblBTdy9YSjZ1QjBPSmgvMFhsWFljeVZaN3Z0?=
 =?utf-8?B?MlIrZVJ6NXJiaTgzWklOTjg3bWtkTVRUQmRJbU1nWEFyQkFtUENtYi9JTXh4?=
 =?utf-8?Q?OwFjWNWR0RkzJjgU=3D?=
X-Exchange-RoutingPolicyChecked: XtemhFi2sJFIoZb8peIIY8z+NdH+pEI6pCHLCiZnQH5xVOF8BmC8cqoXQYXxbTW+fd1LK5JgQQc4ermGKmS+YuBDcm89lHNT0RukdFgXgTvxlX0UI3mzPMABsy8J9RHScDUcdcLZTRE77yZC1FCXKGuAiz8l/autyNHbI0P05Kt4CASoxC6MiyjFDwn1xN833DH4oM7ogLUxcvSvFOTkeHH4tHWapRgYwuZgZg0DEmN+uinnfz+XYnfojFCKmdRHDwPaaTu3FqEQ9KMAWBn5V6PHAxuPIGEU1ZEDOxbuIUNkZKQD2Ma67n9IOdjcOLy/ySq6C1IHvzIOd1yrMDq1EA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 428bef2e-9b59-4920-599c-08df30696cee
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 18:22:26.8998 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: csfLAB3+1qtzux7MfHJ99LT88vb2BtMJAhTFG/FHjOMgpuaBUh/OunGYQtD6WUOoKKGhzdsL8ratBokARy19d9Hpev94SYw8T7KdSoW+ZNQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8428
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

On 10/19/2026 3:51 AM, Aaron Ma wrote:
> ice_suspend() stops the main service task but leaves PTP work active.
> The PTP kworker is not freezable, so it can continue issuing MMIO
> accesses after the PCI function has entered D3hot. Both the periodic
> work updating the cached PHC time and the E822 offset calibration work,
> which reschedules itself while calibration is pending, are affected.
> 
> Synchronously cancel both works when PTP is ready, after disabling the
> VSIs and before shutting down the control queues.
> 
> Fixes: 77a781155a65 ("ice: enable receive hardware timestamping")
> Fixes: a69f1cb62aec ("ice: exit bypass mode once hardware finishes timestamp calibration")
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index ddebb28b2454f..3962910759067 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -5450,6 +5450,12 @@ static void ice_prepare_for_shutdown(struct ice_pf *pf)
>  	/* disable the VSIs and their queues that are not already DOWN */
>  	ice_pf_dis_all_vsi(pf, false);
>  
> +	if (test_bit(ICE_FLAG_PTP_SUPPORTED, pf->flags) &&
> +	    pf->ptp.state == ICE_PTP_READY) {
> +		kthread_cancel_delayed_work_sync(&pf->ptp.work);
> +		kthread_cancel_delayed_work_sync(&pf->ptp.port.ov_work);
> +	}
> +
>  	ice_for_each_vsi(pf, v)
>  		if (pf->vsi[v])
>  			pf->vsi[v]->vsi_num = 0;

I don't think kthread has the same API as workers to fully disable
re-queueing, but at least the periodic work is only requeueud within its
own run or by rebuild flows. ov_work I am not fully sure about, I guess
it depends on if this can race with another thread that would
re-schedule. I believe the PTP teardown also cancel the tasks but may
happen later than needed? But maybe we lack a PTP flow for
prepare_for_shutdown. Hmm.

This is at least better than what we do now so:

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
