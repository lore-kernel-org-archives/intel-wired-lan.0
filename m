Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D61606A320
	for <intel-wired-lan@archiver.kernel.org>; Sun, 22 Nov 2026 12:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=peD1kdqi;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XAtRG0wl;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=bAJwUn/p
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E9CA6406A7;
	Sun, 22 Nov 2026 12:43:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ATfCC2qgvk_l; Sun, 22 Nov 2026 12:43:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3043C4065D
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795351400;
	b=LiLfmYy8eSPQ5cS+RQCxE/8y5EUFijGJrn535MMCamKpq2zGNLCa6HRNXOG3bovh373N
	 kV89a5KXBHVpdJSK7n4n4Bi2p3hqvV2pLUwQYwD+0Jjw+1ugCLgwpY0G5W9jM1Zkt7URa
	 +2pQ6furTlGYWDRwryRPgGnb926kP0UW8sSHtf5SfGfRS32cCcn6fFLhn2RRYbVy367jb
	 khZfRbJzMZ1tHT3fPXM9knxMzc/pNzGfrvSESu6BYULuxpsiGwPE6BVTE+Qz0SDPCdU/c
	 OnXuxgKWncWY1oPHSJmk4JV4mYgkupxrQmGtOfMZ51p76nGsyjAIOCFr+hQEI5kH32Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795351400;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:DKIM-Signature:
	 Received:Received:Message-ID:Date:User-Agent:Subject:To:References:
	 Content-Language:From:Organization:In-Reply-To:Content-Type:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=fl6stXh3rkSZDNnK13HLbNP6aKbHhqoU7Q0PB4jctdI=;
	b=aaoi5ZHwHxrk59OTja186JHtCmLXjudRBr5TDYBugwuvUAV1G7q3b6L7GYdPa5MHaGWW
	 O5MmTLzfitnjelU+6xXq4dgM+hQwvlhrof225sBswfyVMp1qwnuO2Ws52uXqieyQj9eFy
	 mZB0i+Es1Pp1U5NguS5eR4W0Otcvd/a5MvJXqIYauhE68Vh5DIWI8pwQkpABpV9K9fuWE
	 qSPP53DnE0wcqVsst41k3OFpv3aWByNFWtbSMzN2sKH7oxP39lmm4EYX/ZcLr1+KyP1j+
	 lv0BvJH0/xHMyXF2zN7AJLLTSlLY8XEEjgUVA8MHu5eAqhunIMCSUU5c0Qs7BgBTmHQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795351400;
	bh=fl6stXh3rkSZDNnK13HLbNP6aKbHhqoU7Q0PB4jctdI=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=peD1kdqiqAS84rgAhtXwVfrd60ujhm3Jg+VV7QJ+IwbEC5XMyhsVqo33Y5qzpVPsf
	 fHxWls7Ll3WDnZbeWLNfFZOi7O1wtlEGPUV3rXGood+pDPFQs8S3t+B18aI9Siam98
	 J5VY7AyUF5fivVn38Bq4xlsv7GanuHVsBxXefHQ0dpDJkrARaOg0meyGp2pODFWIGP
	 AUDh0iaSOmauvRhsdjHueuSy7y/XzyjuZk40B2KyvD48O4KfhoXrJwjUmrTKqvby0q
	 V+XgrwQaxqIegfDEh4XIO98HRLHWKB3Al+ozGZqnqQXdD7vUTYQO5UDfi6vvGRhoVA
	 CG2zbZ4dLpCHw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3043C4065D;
	Sun, 22 Nov 2026 12:43:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C8767310
 for <intel-wired-lan@lists.osuosl.org>; Sun, 22 Nov 2026 12:43:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B99D460609
 for <intel-wired-lan@lists.osuosl.org>; Sun, 22 Nov 2026 12:43:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZoYFkpU4PtYU for <intel-wired-lan@lists.osuosl.org>;
 Sun, 22 Nov 2026 12:43:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6238F605EE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.18
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.18;
 helo=mgamail.intel.com; envelope-from=michalx.cohen@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=XAtRG0wl; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=bAJwUn/p
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6238F605EE
 for <intel-wired-lan@osuosl.org>; Sun, 22 Nov 2026 12:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795351397; x=1826887397;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=TuhchEYRGaGLewKqrDmcvaTSUYwiCRtpp4xbi8wXqEk=;
 b=XAtRG0wlTsosrbC1DRo5F6/aEqanB/2vs+tGgCjcE0P1J8S3/t15v+OE
 4HjiFppt7RYo5gCLv7jenb6cRzfAExSrmb6wNkyM9wJF79bLN0NDQ9XJ8
 an8z3F8xxN30/xQmCYlBrg8j0d0Lp7T0/G5418rFXKUKzvka892yEclqc
 ImFLF5LvvnJhj+vXTda3zhxcb4UXpbMF/jOwZSc3RNihfyz3XdYHeiSgS
 TvVDgOsFApczDpbCf5Uuy33yga/2Ve6WCDEYJLtjIity+OAoMUzL187ZN
 /sHWf73oXjQ0pyCgUbzR9HEzuSjS2zeIK+JifJnaFR7dDWvl5UXnABYL6 w==;
X-CSE-ConnectionGUID: wKgI3graRFGkBVvDJk1yww==
X-CSE-MsgGUID: KgFAMKu6Qxq6gHdptTog/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11973"; a="4185842"
X-IronPort-AV: E=Sophos;i="6.27,226,1787036400"; 
   d="scan'208";a="4185842"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Nov 2026 04:43:16 -0800
X-CSE-ConnectionGUID: fvC4sC3ZT/CzEv95AvV9IA==
X-CSE-MsgGUID: RdPVzlY5TMO+pA2mFq845Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,226,1787036400"; d="scan'208";a="11166828"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Nov 2026 04:43:16 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sun, 22 Nov 2026 04:43:15 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Sun, 22 Nov 2026 04:43:15 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.67) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sun, 22 Nov 2026 04:43:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fl6stXh3rkSZDNnK13HLbNP6aKbHhqoU7Q0PB4jctdI=;
 b=bAJwUn/potjvmpwgh6J7DIS73DwmBicyvQw9Ghv1wXbfHrpx6dJMmpKCxCihdarFy/bezGMPnt7GIVX7FEJgF3mTMWPI1U/bmP+J9Sbof9qltXl+009ChlZaWWkLgP956qqLlRald8o+k1tfsLLb0SlqG472h57g1CsOO+T6d8U=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5520.namprd11.prod.outlook.com (2603:10b6:5:39f::20)
 by SA3PR11MB984244.namprd11.prod.outlook.com (2603:10b6:806:530::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Sun, 22 Nov
 2026 12:43:13 +0000
Received: from DM4PR11MB5520.namprd11.prod.outlook.com
 ([fe80::75b2:c8b1:10eb:2ed1]) by DM4PR11MB5520.namprd11.prod.outlook.com
 ([fe80::75b2:c8b1:10eb:2ed1%6]) with mapi id 15.21.0639.012; Sun, 22 Nov 2026
 12:43:13 +0000
Message-ID: <f7b3fd3f-f28c-4cd6-8ccc-0075723c6e07@intel.com>
Date: Sun, 22 Nov 2026 14:43:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [iwl-next, v1] igc: remove unused igc_update_nvm_checksum()
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, Sasha Neftin
 <sashaneftin@gmail.com>, "intel-wired-lan@osuosl.org"
 <intel-wired-lan@osuosl.org>
References: <20261024163701.134489-1-sashaneftin@gmail.com>
 <CH3PR11MB566895C0974875AD501296C435E5612@CH3PR11MB566895.namprd11.prod.outlook.com>
Content-Language: en-US
From: "Cohen, MichalX" <michalx.cohen@intel.com>
Organization: Intel Corporation
In-Reply-To: <CH3PR11MB566895C0974875AD501296C435E5612@CH3PR11MB566895.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0013.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::20) To DM4PR11MB5520.namprd11.prod.outlook.com
 (2603:10b6:5:39f::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5520:EE_|SA3PR11MB984244:EE_
X-MS-Office365-Filtering-Correlation-Id: b19a71a4-99df-46e6-770b-08df48962bf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|18002099003|22082099003|11063799006|4143699003|56012099006|261026140227099003|261022105027099003|261026121527099003|261028144727099003|261021123027099003|261009223027099003|261102123227099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info: NWPXyoMLtexd3YHhwGI3KOTCRgxgjCVKoWZtGEqBI1FJdhIutQt6lvdx5yboyxP9fEXAD/SJsfdsrZVDeRiWcmwOqU1Q8YoWftHg5kBFKvmA4lvptnc2RdI0+qX34r7Q3rbSpnOlut26gPWCLoNK5Xp4eezWL5qIKMi85zXNLZQ1ccoW98Cp2fWOdbleEyE7vqZYptItiq2mQoYfc9jfx6qXYrbf9OEfeho0Om/Grz/7+whDJPDIT4e4B5+ReU/d7Km98s+CQoTuLwEtRAJG4jr89NGdUnzgL0WBAMRMPfc5YLHIalfcYz/F3KmReUrNVteBST/YEf2lAFTMYX/oVxHrCaAyiT/cPJB1srw7Fwib+uTSZVBAodfNQ0nCnRIQxOKtP03W0NAkLiqmVrEWYN0Ut1YHbtCyB6Wv9jt31FzNLCgLHxU7iRxeXKl4dmKOgryaUtCpv0mddeHlfnyiNZJiDUVeB08OAWBMDWPXzZtAvirKIk+oxkQM2qgC+vTsnfWbVwwKwl+6gYyxWshSmn46yZ23/ReB4p9THv1eoexjxSx7HdZcQye2NmNkSzGRPMrBZXfWf3tz7D7Ga8Mz+b9w0FmzTlVuU0PI9I8qWUwZRg+rt8Y+9quqVOEuObXz2AsdTEXOd0xdUPzL0TWpXO0Y35Q6fdMQcEotc/VCzaA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB5520.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006)(261026140227099003)(261022105027099003)(261026121527099003)(261028144727099003)(261021123027099003)(261009223027099003)(261102123227099003)(261021121427099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEZISnRPNVd6TW9SQkh1azFDMUkrQlVLbTRTOTZSTnpwbHFVVjlvV1JZOWxN?=
 =?utf-8?B?ZW82RDZLMlpOSWZuNWRjb0ZuemQxTWkxWlpFVkNQUDlUb2hFdzJGUlc3dms1?=
 =?utf-8?B?VDNZMGd5RkRQNy81aUFwK0c0T00reEtVemRDeHF1cFZkRW0vU3dFNXRLSDVr?=
 =?utf-8?B?VkFyMjdSa1JXaENkOWZEckhyWmxSQy8yWElQZlRwZWc2SEV3MFRHZHU5R2pF?=
 =?utf-8?B?VHFISUhJWVk2SkRwMis3aWlBTEJSME4rLys0WFdydElNcDNEZ2hQM0ZuUE1U?=
 =?utf-8?B?a1RzRFdBUkZGTDdKb0dGaHFiSmdmSlJmaWhlQ01PK3UrdjVseDZuMGZDUnR4?=
 =?utf-8?B?bWhoQnJCQmI5V2FMNG0yRmVIdjVlOXdrbG0zZkpseDhIV0x3eDk2V2RBNThB?=
 =?utf-8?B?bzR0QTJydERzUzlVZXVDdUVMQjgwLzhOaFZFZHhUMG44ZDFnODIrNEEybFI2?=
 =?utf-8?B?U1pNcnFZLzlrZlE4WnArZ29IU3ZGdERteVFLdmxqcjVkRFZIVXNnbXk1dGRH?=
 =?utf-8?B?citTVHhJcTJObG43aEcrcUZ0ZVhXOC93TW1kYmk5UWxZOFRqODcybnlhbXkr?=
 =?utf-8?B?WkRkVXJTTEo5SnBheFMydFpJUm5XWmRHVHdibFg5TTQyZW5JRkU5RWdjMnRI?=
 =?utf-8?B?b2JEeE4yWUl2OEhMM2ErUEc1NmVPd2I2RkVtUm9CL2crWjl4aUdHbll2RkhD?=
 =?utf-8?B?cmxzYkJrUE5CbFhUTFVhUlBEN2Jab0lrRUM1d0k0OVR5YjVsZVhIbzJIdVo0?=
 =?utf-8?B?dC9mdHU0T2o4S3Y5dWFacTZkN2F0aDFkbC95WUsvYVVSOHdWNURxaVRrbkxB?=
 =?utf-8?B?eE1NU1JEd2EvU1NUOFhxcDhsVzgycWljMVpvbVFvQmcyOFBzMlVHNE5vNFRw?=
 =?utf-8?B?eHAxTVFSN1BXVU82VTBUTkh2c0lPbzMzZG1qb1poZ1NaYm1OWkhEVEI5Z2Ro?=
 =?utf-8?B?MWJFQkx3aUxud0gvRzQxUW92YmowWStmWmFUSFJndXJyVnZteVJwNlBIa3Mv?=
 =?utf-8?B?TnpxeXdpM2hSWS92U3Y2RWk0cGFIRjhlZTdFMG05TmtwdTdmQVdwMUpwNmdJ?=
 =?utf-8?B?TGJuRGxuSjlveHlqQ2hvQlExNExqWHRWVHhhR2wyR01BeXd5QTBENVZ1dFdX?=
 =?utf-8?B?YmJ2ektEWmUydjY4T2tpTFhxbk0rTkpiUERkYTFPdDV6QkpPWmwzRElyY3Jv?=
 =?utf-8?B?emVOaUd0YXo5S0hLYlpPajNCdXluQXJpM1orVjVLakZvL2hGZmpHczNVTk1h?=
 =?utf-8?B?bU16MnUyVk03elhtN1FRbEtKVnVESFIxYVlyLzFxQjhYMThlVW5DcVhmK2Nr?=
 =?utf-8?B?Uk9vSXB5bTVxR09ld1liZ2g4VFptS3NxN1N2TndoV09tMmJoWGUyNUlXcGJn?=
 =?utf-8?B?TVNHTWYvdkIwdGFhMXB0US9aQVZSM1M5Vm9DNmtEZHplYWZ2SzNmOFVOZ0hY?=
 =?utf-8?B?eXFnSExuSVd0WERDNEV5bERNWXBYRkZza3dSVnU3a0ZIWkg5V1FHdk1rZnoz?=
 =?utf-8?B?K1FWYkNLYjIySXh3TTJvOExjMmlpcGtMRWZLaTZKQ1lVK09sZjlnRjYxK2R1?=
 =?utf-8?B?eHIvVjJTQUR4THU1VExNdk9VYmwrazMwUzBWQk12bklDZWhsblE5N1FzT0li?=
 =?utf-8?B?Mi9qMnVRMmV1YlNNTzEvV2lHU2wzVFFVazNwOGZIWlYwcjFyUnZCamVXKzIy?=
 =?utf-8?B?dDQ3RzRFbVJkUHVYeC93cGIvZ043Zk5yQ1IvbUc5KzExWEtpcXhxdEcveE51?=
 =?utf-8?B?S29DemNKRmRZN0crOHJzMnAvakF0YmYyMmQwNkNPM3ZjSkJiQk90dmxtQmRS?=
 =?utf-8?B?dUZtM045YmppdUpTWkNHOExHNndmV0gxa21ucThCd0xudU9GaUl6SnkyU05k?=
 =?utf-8?B?c09oTjN4NXB2T09YUUdObm9YMzExdVhYYVE4SHhoNzRSOXk0UHEwbWgrN2Uy?=
 =?utf-8?B?T014Wm5qU0VqcU41QVNkU0g0aUd5TkpaNGM2UnNGUnVYdzVlc0FsV0dubW1U?=
 =?utf-8?B?SFZyY2FsbGY1K0o5RVZrN3Y0WEx3MXQ1SDFSUjA4WVlXMEVaZWhsYU5NMVVS?=
 =?utf-8?B?djFWem5WdE96eGlOZ3Fwem9UUE96Tnl2bi9WRDdNVC9Md1VhU3o4YVRDTXM1?=
 =?utf-8?B?Z25Qcno4UXVLZ3ZzNDROQStGZUNGQ3ZkdlloQnpLejgwRE9TSGVlNU5MSUJU?=
 =?utf-8?B?M3lGQ0JabGFlWncrTDBpWWtIVlFxTlVkcVJ2akRSa0VNZ0ZzVXl1WXk5d1d4?=
 =?utf-8?B?UStwNVhIRy9NKzZxOWZsaVdQNHpQNFhYbVdPWlJWYXk0cTZzdzlvd2lvaGR1?=
 =?utf-8?B?YVBWOHp5N3BWWVFvbEhaZTFXN0dudDgvTnREelc4OFJoUGR2cVg1dz09?=
X-Exchange-RoutingPolicyChecked: P8CPAJDBr8667uC31LlSUF1ti/aY18pLKgLitmriMIQp0VYWV9RS2tyLL59RJZgLlKMhK4aUVzQypHtC3y1TcwejCY9Vt3ZxT2XPXuEznBw10jqKr/L18KPa9MeFO+g7oQwH0dHwLcci2xzZNxiTQq3xV/PvXlXn7YuXF4Fe0CjWVEzfklhSf/qSfkW9h3d+NcgDmQVz3+p7DW/4nm2XXjevSyhz77DolhJ+K1+V5c5jnnhZ+WBvM84l8+Hpk0HAnpYODdSts3c+wA5PQTEoOWzfzY+0ezBmba2N/Uz//nlsYUiE/LtZ/cLf9+Qs8foNjbDPbBUKH4IG23A0iIHbvQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: b19a71a4-99df-46e6-770b-08df48962bf6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5520.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2026 12:43:13.2386 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yEze0ccYTSXC1P0JTxpWVX90CCQiBi8JjNL1H4iB9DTM0UtThBVpKqziGwAfApXcv+ozlAdm7ThdTp9boFlsZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB984244
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 27/10/2026 0:09, Loktionov, Aleksandr wrote:
> 
> 
>> -----Original Message-----
>> From: Sasha Neftin <sashaneftin@gmail.com>
>> Sent: Saturday, October 24, 2026 6:37 PM
>> To: intel-wired-lan@osuosl.org
>> Subject: [iwl-next, v1] igc: remove unused igc_update_nvm_checksum()
>>
>> igc_update_nvm_checksum() has no callers in the tree. The i225 NVM
>> operations use their own implementation, igc_update_nvm_checksum_i225(),
>> which is what nvm->ops.update points to in igc_init_nvm_params_i225().
>>
>> Remove the dead generic function and its prototype from igc_nvm.h.
>> While at it, add the include guard name as a comment to the closing
>> #endif in igc_nvm.h.
>>
>> No functional change.
>>
>> Signed-off-by: Sasha Neftin <sashaneftin@gmail.com>
>> ---
>>   drivers/net/ethernet/intel/igc/igc_i225.c |  4 +--
>> drivers/net/ethernet/intel/igc/igc_nvm.c  | 31 -----------------------
>> drivers/net/ethernet/intel/igc/igc_nvm.h  |  3 +--
>>   3 files changed, 3 insertions(+), 35 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/igc/igc_i225.c
>> b/drivers/net/ethernet/intel/igc/igc_i225.c
>> index 5226d10cc95b..0971debca3a4 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_i225.c
>> +++ b/drivers/net/ethernet/intel/igc/igc_i225.c
>> @@ -220,7 +220,7 @@ static s32 igc_read_nvm_srrd_i225(struct igc_hw *hw,
>> u16 offset, u16 words,
>>    *
>>    * Writes data to Shadow Ram at offset using EEWR register.
>>    *
>> - * If igc_update_nvm_checksum is not called after this function , the
>> + * If igc_update_nvm_checksum_i225 is not called after this function ,
>> + the
>>    * Shadow Ram will most likely contain an invalid checksum.
>>    */
>>   static s32 igc_write_nvm_srwr(struct igc_hw *hw, u16 offset, u16 words,
>> @@ -275,7 +275,7 @@ static s32 igc_write_nvm_srwr(struct igc_hw *hw, u16
>> offset, u16 words,
>>    *
>>    * Writes data to Shadow RAM at offset using EEWR register.
>>    *
>> - * If igc_update_nvm_checksum is not called after this function , the
>> + * If igc_update_nvm_checksum_i225 is not called after this function ,
>> + the
>>    * data will not be committed to FLASH and also Shadow RAM will most
>> likely
>>    * contain an invalid checksum.
>>    *
>> diff --git a/drivers/net/ethernet/intel/igc/igc_nvm.c
>> b/drivers/net/ethernet/intel/igc/igc_nvm.c
>> index a47b8d39238c..b69889bfeb42 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_nvm.c
>> +++ b/drivers/net/ethernet/intel/igc/igc_nvm.c
>> @@ -132,34 +132,3 @@ s32 igc_validate_nvm_checksum(struct igc_hw *hw)
>>   out:
>>   	return ret_val;
>>   }
>> -
>> -/**
>> - * igc_update_nvm_checksum - Update EEPROM checksum
>> - * @hw: pointer to the HW structure
>> - *
>> - * Updates the EEPROM checksum by reading/adding each word of the
>> EEPROM
>> - * up to the checksum.  Then calculates the EEPROM checksum and writes
>> the
>> - * value to the EEPROM.
>> - */
>> -s32 igc_update_nvm_checksum(struct igc_hw *hw) -{
>> -	u16 checksum = 0;
>> -	u16 i, nvm_data;
>> -	s32  ret_val;
>> -
>> -	for (i = 0; i < NVM_CHECKSUM_REG; i++) {
>> -		ret_val = hw->nvm.ops.read(hw, i, 1, &nvm_data);
>> -		if (ret_val) {
>> -			hw_dbg("NVM Read Error while updating
>> checksum.\n");
>> -			goto out;
>> -		}
>> -		checksum += nvm_data;
>> -	}
>> -	checksum = NVM_SUM - checksum;
>> -	ret_val = hw->nvm.ops.write(hw, NVM_CHECKSUM_REG, 1, &checksum);
>> -	if (ret_val)
>> -		hw_dbg("NVM Write Error while updating checksum.\n");
>> -
>> -out:
>> -	return ret_val;
>> -}
>> diff --git a/drivers/net/ethernet/intel/igc/igc_nvm.h
>> b/drivers/net/ethernet/intel/igc/igc_nvm.h
>> index ab78d0c64547..d5f1f1a449eb 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_nvm.h
>> +++ b/drivers/net/ethernet/intel/igc/igc_nvm.h
>> @@ -7,6 +7,5 @@
>>   s32 igc_read_mac_addr(struct igc_hw *hw);
>>   s32 igc_read_nvm_eerd(struct igc_hw *hw, u16 offset, u16 words, u16
>> *data);
>>   s32 igc_validate_nvm_checksum(struct igc_hw *hw);
>> -s32 igc_update_nvm_checksum(struct igc_hw *hw);
>>
>> -#endif
>> +#endif /* _IGC_NVM_H_ */
>> --
>> 2.53.0
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Michal Cohen <michalx.cohen@intel.com>
