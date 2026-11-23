Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2C4606A31E
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Nov 2026 12:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=azk5F0hX;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=axdwEQ1o;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=AbG8j9im
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0938380E1A;
	Mon, 23 Nov 2026 12:31:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BpfA8dmKtAmM; Mon, 23 Nov 2026 12:31:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 402EC80CB1
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795437087;
	b=CDTRyTehGi9oWa7lIlfV7aLcmFZUadp0samTOJw4Sj5j/xpnIeO4KW2V8bbEHF4Zndfv
	 IMqoeLokaWQ3BOU/gghaPwabiCFETHxTUe8gzvoYyuLzX4xiOYgy83/a4sm6e8Im0vCAg
	 wok57oeoTsVzK5r4nBfa5X+YK48IioX+LmRKRnc9tY8ySQWq11Tm71mCGdhMiNIK2oznC
	 o7W2LgbtX598MO4Ua9YxbfH0qMhxECL7cMdqcs+Cl4bbRBkDP5goXKATjU2m/i8q1VrLW
	 StTe0Ba3Er05Co3SpdfCKzBlTusYObfo+QUMutu1MdC2AbXg+6xfwIMRFBO6yWybZlQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795437087;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:DKIM-Signature:
	 Received:Received:Date:From:To:CC:Subject:Message-ID:References:
	 Content-Type:Content-Disposition:In-Reply-To:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	bh=myHi/OOkYOc2wg/44p5gUmxKl7enygWa0O7Z4Dupi+s=;
	b=YLnbWA85iGHVQFJJCiONtiMI4QOTR3AEuLRtNRf3mvVJeg/b8J81iu4ZXMWALED4v12b
	 lTs+oTRUAEiEVebG4qLkoLbWw5iEWs9WlUA+0xMwvMiDg+AUoEZV7hh4B9DUpAZw8m84V
	 PceATJTdT125Nvq6ab/q8A97DZk9N+kE9jYIFLfWMjSa4Fnt0Dkq6uSkyk0DbUjFvoSdb
	 2Oom4s9/gEy5xdfbHwk8EjNyIIjUb7iPcO+2BnV4NKAyn+EHiKP9An8ceFpXqLJKPOmmp
	 dIqlJljSN4ukEfrIGguaXU4So3024gsmHWQ3Jo5JG3VmhTBzSpFOCQlB4y2G3001njA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=axdwEQ1o;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=AbG8j9im;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795437087;
	bh=myHi/OOkYOc2wg/44p5gUmxKl7enygWa0O7Z4Dupi+s=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=azk5F0hX2lvukNnfeF0a32dR2DbOuo71nonk/osnIMbGWT/RML3AUGFTOv8s3iHky
	 Hp9zde2toft1MKADxFKbNzF+M9Z6w5VZXZX/hTF51ejmZPLGQ9YheHUdovzl7Vzq7z
	 nqKjuWHINk5KKh16bUU9anaBblKeBASrzIsKj6WHbXIglhOGjrsAnCTNsrYVgljJN6
	 /S5WjHdEmZp5SA1duPN0oy349wvkvry9niTzVtuDiA3FD5L/JslLyymaHtoX0xS2lN
	 MdwkS4KNXUlEONh2vMj5gZ3txnIWJKONvw030f1Q7TuU1ErYNuFJmifM6H1m+iY9XW
	 k3+9/wVh990Tw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 402EC80CB1;
	Mon, 23 Nov 2026 12:31:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B5776260
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 12:31:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 99CC680DA4
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 12:31:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nPAdKgkMdAIQ for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Nov 2026 12:31:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 447A680B08
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.19
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.19;
 helo=mgamail.intel.com; envelope-from=maciej.fijalkowski@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=axdwEQ1o; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=AbG8j9im
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 447A680B08
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 12:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795437085; x=1826973085;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=lObjSCaOA0P5UCj2X9+XPtwFFUK5NMr8pOD/JdyYFvY=;
 b=axdwEQ1ouT+WFmIeCW4NEi9RGFZaHJ4t0ydWhQAM/r0v74dUmGuJhSGL
 O+uhEIyI4+t9krZx+l+gBf9hYyQc/V/qHLp+z+ADmTLYWB80Nq1FBsLWb
 LaQ94JSU2yHVkzuSbr8ldXixOgeUpLrCAVQNRPIr2MDfePjE6SginKDF2
 S2QjUeUyx5gMXvhCTJPeG8TJob5d0hSlF2LIQbipAIsZ7htznd43tua+m
 uwqtVjE2e0aAsLjgBaIAR5THKV3Jr7zqPRGdyP2IaU7Ke+1Idjd4puBLD
 SVmeos0PLZCiVp5ca4CkJVwds4+bqH6a23wgD4vRHteS6UYDpSt8LNgwu Q==;
X-CSE-ConnectionGUID: sILCfhsMQmu9wj7c8dpqoA==
X-CSE-MsgGUID: KeHFmHXCSWSWcNXmHinE3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4284207"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4284207"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 04:31:21 -0800
X-CSE-ConnectionGUID: 1PpQqBzXSNKPV/6SXy8J5w==
X-CSE-MsgGUID: XHwfGDyzRNWClt3GQxBykw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; d="scan'208";a="11168600"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 04:31:21 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 04:31:20 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Mon, 23 Nov 2026 04:31:20 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.16) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 23 Nov 2026 04:31:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=myHi/OOkYOc2wg/44p5gUmxKl7enygWa0O7Z4Dupi+s=;
 b=AbG8j9imM3tvsMSrW3RbAr3tKeE8SDGIduu7+LiSDGe4Lz3iMSCUGwsmgEXAgJOK57Q2BIdlm1EhUKKRSycd1ax00GW/T533zJh2q59c8YZnTY0zwrA93fav2GhgB/KQexrI7bXJLAQkOptNWPzT6tx/d6t6ftwStdSo5aZwYWw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13) by PH7PR11MB7663.namprd11.prod.outlook.com
 (2603:10b6:510:27c::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 12:31:14 +0000
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de]) by LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de%4]) with mapi id 15.21.0639.011; Mon, 23 Nov 2026
 12:31:14 +0000
Date: Mon, 23 Nov 2026 13:31:02 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Jacob Keller
 <jacob.e.keller@intel.com>, Petr Oros <poros@redhat.com>, Magnus Karlsson
 <magnus.karlsson@gmail.com>, <netdev@vger.kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, <edumazet@kernel.org>, <davem@davemloft.net>,
 <andrew+netdev@lunn.ch>, <horms@kernel.org>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Marcin Szycik
 <marcin.szycik@linux.intel.com>, Aleksandr Loktionov
 <aleksandr.loktionov@intel.com>, <intel-wired-lan@lists.osuosl.org>
Subject: Re: [PATCH net 0/6][pull request] Intel Wired LAN Driver Updates
 2026-11-13 (ice)
Message-ID: <awQyBgvgGLziCfLC@boxer>
References: <20261113231225.1864810-1-anthony.l.nguyen@intel.com>
 <20261118115915.116177-1-poros@redhat.com>
 <CAJ8uoz0MMUx68rMZWoZs-JwjodpRixwQSrgpyta1NsanGPn=dg@mail.gmail.com>
 <av2syi6lE/Vp86QW@boxer>
 <f7f1ae2d-a623-4eb7-a178-c618316beaf5@redhat.com>
 <0bb65ff3-2e27-4f2e-aaa3-2b8eb7cda356@intel.com>
 <fe1ce4cf-3400-4a87-8e46-072563f8fe9d@intel.com>
 <20261121162859.3522ab89@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261121162859.3522ab89@kernel.org>
X-ClientProxiedBy: DU7P250CA0019.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:54f::12) To LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR11MB868673:EE_|PH7PR11MB7663:EE_
X-MS-Office365-Filtering-Correlation-Id: ea667231-b88f-409e-bcfa-08df495daa0a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|23010399003|1800799024|10067099003|4143699003|11063799006|56012099006|261009223027099003|261021121427099003|261022105027099003|261028144727099003|261026140227099003|261026121527099003|261102123227099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: jGlfQCk8rYcXMxEVBxrOwvDUpb2z4HAQ+pPxxhVFjw0FIWgFjUF3w9Nf4YG4J1dBznSuUCMOv2V5q7SiqTjVknu/kk/eLaAsYzj+Fx5hR9kqYLPMNOvmbL7+7eTB7zxb4+hgC7y3VOUpQzo7/Vamr1+ta4xeRCNiHvk5n+/lewLH3b6xpA15Oi4plYh0hLP8g2sL8kf8vm8m25frdanmGTb8pUczHB9o/ekmufkNMZu7k1QUvsFcqnNA41FS90yomYYaUM57xgPJb5nm2EmlybH/q+MrUY+zlzQ7IycpXshMrzEwHfkv5Gjm2yaYnK1GuGUU9qkEYv8+bfqy1pf6vH3HYN+7SIsY0oauQJCeJbTXOtg4rA39XkhDHFOxMzggBh2APQBYR9hrbTfVjFEBSg2xFW81GMiQ4VZumxDL/wzQbyArZmT9GaK1Z2hdQfIG3Zr60UzWLOqhmOT/R+DFEQD9rcKwow4Awj9DdlqUnHFuguxX2ZnM3gphwmXPPOs/4EjfTymrkLsVg9gfpb1kA2o9NWfXnTA9poTMoAhT9YMRFf1n+pjNnhF+qMeNFz02tfIg7XNdaIcIk1Zqxq13R1Hp0TVYuHErgdLSgjmeXdZNQuLC3/EjNANeFBPmAVKS2tORYGLtJpkBkrxkm0j9Ou9JfNqPOs1s4S2ZF0qeAss=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR11MB868673.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(10067099003)(4143699003)(11063799006)(56012099006)(261009223027099003)(261021121427099003)(261022105027099003)(261028144727099003)(261026140227099003)(261026121527099003)(261102123227099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rY2YaJwnTrze7rVOJmsVeSfsvNQj1bkTrR74AhUeBsVIOU70nqvEy/EzzNTB?=
 =?us-ascii?Q?a5LdndaYGihMhhnkSG36CCPdyOYgA8LTJEE8/cFjhyYDk052/ivH5kY6yZUt?=
 =?us-ascii?Q?iJE5O23Tv49RygTWQO0NQL6MbpsVBxz7AIuS/eykoyA1tVWQhBktUax9/eg+?=
 =?us-ascii?Q?GbKsMGSYkLOyGEw8SAFBLOtEhaWZHbHSzK6kfxEYJ9utMOKVGiZiiNvSTMnk?=
 =?us-ascii?Q?VLgYXOioGcxtz0WEshahybxv/MxBIDhUpqrezRqRZllF4yQSEPG44P9iF3cI?=
 =?us-ascii?Q?sZbVeIEhV5SxdFI3ANuZXPFcKnbuqFTM3ctX76Pz+L2aujguxbVrSY7sY1R3?=
 =?us-ascii?Q?bEu1Txlu1MrmZxzYjC7NZ5ifTUEy5Q5OWBuDK2vQxS4FZUUWgkJ1OT6OPJYy?=
 =?us-ascii?Q?XtzLrtMe3PrZqT8u2sRhY8H3YmssztD8D18DPWZwgkSKMXL6obD5r+ELyuYz?=
 =?us-ascii?Q?IH3uVBA0zQokFrRgvojGGd/Zl3g1Oh3ZLFuzJ6XJ/S26UA2jy8oRRP9dAitV?=
 =?us-ascii?Q?NqG7aZeOFJ3MHGLMlcGnXPG3ZoEk4JbeXOdy7Q3lnHG2i9Imqr29MKRDCRkE?=
 =?us-ascii?Q?J8FRpO1C1Sob20ZoYpbpJPQvXedWRhuPhA2ZdlCeikO56sTc8x8QVKEs8Guc?=
 =?us-ascii?Q?dF8G2j8t6XrSKKkA/d0gx9DMKq7C3dXuYUIbIjmD3K8fAYk2IsAytJgx/9QE?=
 =?us-ascii?Q?q2aI2vewEX39q2h+LK6O5x/x/HED3/3r/tYNRXFDWef7Ts01FBXy60BUNema?=
 =?us-ascii?Q?JAL/FyNxeSqj3LOWrz1y0iR4Eldb3+fmTqXHkvSBg1V1xtP/xbwi3vENYrQe?=
 =?us-ascii?Q?uCiCZLL/YCHuDJAsD7u/PsHI4tcaTp1UdX7FOoM6KKzxt1jqBdyEf/Orkt6k?=
 =?us-ascii?Q?vZTwMjNwBv+TajegSWbzOg/yJx8m9L8bmCpGQn/AKAdOq7oWdRCcMAw5RvYK?=
 =?us-ascii?Q?yotHO3fPIEmKD9ns8i5RM76bkhLxVlsQYP58FxlpO3uV8eH0l9rB+qOA0Oz2?=
 =?us-ascii?Q?ITcjoUBKD79p/1i26NecTtSEIf5mXXz/QeEdzrj38hyHC5jkUuUAWZlRw3ec?=
 =?us-ascii?Q?zlqpo/MT0hJ3QJyWpciEGk7OOjodNQx8y6/s5mw8Wv75o+xT6Tv9BDchk4G2?=
 =?us-ascii?Q?iBIsWOJDB72+vUNtDW1Cf16Ecx38p415C2I4DeTqNk6tYaCEn2/+hBuEPXMD?=
 =?us-ascii?Q?6D4CumE7Q8uoPfQVmPI25DiNpfb4cSgPj6hp5/i7zxUEtYxp04y5meUKn95+?=
 =?us-ascii?Q?pR2ASFI7qvTG8pXt+4Ewz2VNKv8/yxM5EXDMqeIFQO2iHqs0AYlJvosGr8/f?=
 =?us-ascii?Q?U8BDhqHcLc0/0h7bvNi9iuNRXHKRWrYuT2JglyLU5JYvGxQy5jWRn139XpZP?=
 =?us-ascii?Q?HuJHrqM/PfLGNn6BF2zDVAhlLL1xdruRzH4mzX54LaGSWlCX63CEjy+BkoqV?=
 =?us-ascii?Q?XthLtDvVvlrvPscScXS+o4kHa/epiKTuyg/T2cGFmgpS1g+hVf7d1UCWNZj/?=
 =?us-ascii?Q?e4Tpo7Q2JHKFqhLemvANpcOwb/CcswwUJb2BNW82AHhyyuSJW2E2g24biWA1?=
 =?us-ascii?Q?qUPPxU8xnXl3Cb9O/fOEPXhmpMN5je/zhvKKjQ4/zQ/U+dsSHdLa1Jn3v4nB?=
 =?us-ascii?Q?G+kWv8BimWiEaBecmjETpEbZzd0K/uwb4kgcE1vPMb21nPl0RPjeEg9kuXpp?=
 =?us-ascii?Q?CmfwSUyMm3V5JT5qZ05GELBdSH23dB0q7i2HvDdJRUTW4zxj4dL+KWcYmfV7?=
 =?us-ascii?Q?TvHPTlQRZ95DDPCf4ZkqghPz8QqQbEI=3D?=
X-Exchange-RoutingPolicyChecked: k7AkqzMK26AODIM8ihmieNNfSKNjPnO9rJnBYdCpBHMZhuxwbneYQpMdo/Cd6eFNlRkmhrYKOLNqHlfMf5JtYj5G7hT5W9B1+BxQGqOrKy0WFCDJHGAhg+tC0EdoEzDWB1nnHWye5jnTjD8+xyEBpady7Hp7f6YVPiDSbNegK5/T7e96MCqXMCnBaaeBVuRp2clg9IMTeUBP8lRwH4jm4hJrNIArDtHSUmbaemRuZcaywkhHryjTykJNB3tnwsQckDltPar9rTK9McTPyit2h2/LQ1D8MiaGJtH8YB+gDEY1xG5j16jSQr5j5zT/FRr3m/YXTlArr/eqFNg/Oq5CaQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: ea667231-b88f-409e-bcfa-08df495daa0a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB868673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 12:31:14.4418 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iuFC6ypwYcPUxWTVsMPEvsSYD1HUKlSjJVb9K10fLkdkHT6mWQmrzd7RH5MVmjg1pHF46lc9IdFyOr0Y6M9efYZkc0uWo5genVGNhBayg1Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7663
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 21, 2026 at 04:28:59PM -0800, Jakub Kicinski wrote:
> On Thu, 19 Nov 2026 10:07:10 -0800 Tony Nguyen wrote:
> > An idea, but this would still increase the queue for netdev, would be a 
> > separate budget for non-Intel authored patches. This would allow 
> > community patches to continue flowing without being blocked by Intel work.
> 
> No extra patch budget will be provided.
> 
> As I think I mentioned multiple times netdev maintainers are happy to
> take patches directly. My understanding is that it's Intel that wants
> to feed the patches thru their internal QA and have the ability to work
> on timelines, let's just say, different than netdev works on.

Here's a food for thought - I asked AI to crawl ML traffic from 2025 and
2026 with closer look at Tested-by tag. This is a TL;DR summary which
clearly shows the flaws (3rd bullet is nasty ;)):


* Q1 (2026): 32 of 458 Intel-authored commits with a Tested-by (7.0%)
  later got a merged Fixes:/Revert; 37 (8.1%) when fixes that are posted
  on lore but not merged yet are counted.  Intel commits without a
  Tested-by: 4.5%.  Intel Ethernet (drivers/net/ethernet/intel) only:
  4 of 126 (3.2%), 9 (7.1%) with posted fixes.

* A Tested-by does not predict fewer fixes.  Kernel-wide, commits with a
  Tested-by are fixed later *more* often, for Intel (2026: 7.0% vs 4.5%)
  and for everybody else (6.6% vs 4.0%); 2025 is the same.  The tag
  marks risky patch types, not quality.  Inside Intel Ethernet, tested
  vs. untested: 2025 13.2% vs 10.9% (p=0.50), 2026 1.8% vs 3.2% (p=0.46).

* Intel Ethernet carries a Tested-by on 69% of commits, other Ethernet
  vendors on 0-22% (6-7% on average).  Their later-fix rates are
  statistically the same: 2025 11.8% vs 11.4% (p=0.77); 2026 1.5% vs
  3.3% (p=0.12), or 3.4% vs 4.4% counting posted fixes (p=0.46).

* The gate costs about a month per fix.  Median time from the first
  posting of a fix to landing in net/net-next: Intel 29 days (2025) and
  33 days (2026); other Ethernet vendors 3 and 5 days.  None of the
  fixes pulled from Tony's tree landed within 7 days of posting; for
  other vendors 95% (2025) and 91% (2026) did.

* Validation is most of that month.  Median time from posting to the
  validation Tested-by: 19 days (2025), 28 days (2026); only 3-4% come
  within 3 days, 10% take longer than 45 / 64 days.

* Backlog on 2026-11-19: 220 patches in Tony's queues, 142 of them fixes
  (median age 48 days, 24 older than 90 days).  201 have no Tested-by;
  143 of those (71%) are already reviewed or acked.

* 95% of the Tested-by tags on Intel Ethernet come from 27 validation
  engineers.  None of their 959 Tested-by mails on intel-wired-lan says
  which hardware, firmware or test was used.  In 973 messages over ~23
  months they reported 8 distinct problems on the list.

* The gate is already discretionary: about 1 in 5 Intel Ethernet commits
  that went through Tony's tree had no Tested-by at all (104/476 in
  2025, 44/228 in 2026), and they were not fixed more often (2025: 10.6%
  vs 13.0%, p=0.62; 2026: 0% vs 1.7%).

* Since 2026-10-01 netdev requires every fix to say in plain English how
  it was tested and on which hardware ("not with special tags").  A bare
  validation Tested-by does not provide that; anyone who tested the fix
  can.

* Proposal (section 11): a Tested-by from any non-author who states what
  was tested counts the same as a validation one.  Validation does not
  block fixes (or is time-boxed) and stays a gate only for large
  features and new hardware.

* What the data cannot show: bugs that validation catches before posting
  or reports off-list.  The defensible claim is "no measurable benefit
  after merge, a large measurable cost", not "validation is useless".

> 
> We wait for an ack/review of a maintainer, from Intel such acks never
> come. Przemek / Tony can start acking things directly on netdev.
> You can also add another maintainer to your entry, or split it up
> and designate even more people.
> 
> IOW I agree that the Intel process feels dated, and life would be
> easier if Intel switched to an upstream first process.
