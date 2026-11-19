Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A53E606A32A
	for <intel-wired-lan@archiver.kernel.org>; Thu, 19 Nov 2026 19:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=5kAHkV1p;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=N3OiN/Qg;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=O4eDDCSg
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 65104814C0;
	Thu, 19 Nov 2026 19:05:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CJe2qFQldF-v; Thu, 19 Nov 2026 19:05:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 821F5814BA
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795115142;
	b=A0zKDw5KZBBmoUuZYP/wD4wYvPXw9akzLObQ2cGThRgVyfAvBCfw+E/09b2fzZYXgYL0
	 z9OyoclPTgUDkwMzHccWCewaAXV7ZA3vzbEVFhxa4BuWkOVI5Ly+15qdd0cGgt9S5lKcz
	 Kp6Y/dyTiZXkQtidPyJ5oLiQ1d9NeLuLjBIb8Xe8rWGCs51oS8XylFPOiOYHuSSWG3Ek1
	 1DEgiXRfrqNOJOFBxt/62j2fp0LesJNCv0PoJrPbPiApe4UYkigfw7wjASFJAC2bZl20j
	 8XCHTwQm8V9X6h6GNiiXqHOGdTJwwcMPHiSc3kwz4YANDO1RvRThvNhRxjcssAOM63w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795115142;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:DKIM-Signature:
	 Received:Received:Date:From:To:CC:Subject:Message-ID:References:
	 Content-Type:Content-Disposition:In-Reply-To:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	bh=QLjGJKkmi+Oj9BCIKBFtpyLhAr3EaTS2IyWKcdrF2kA=;
	b=ROoe2lg5fhUfNxqeigLmV/K1UOPFms9ng//CMATUO4O3N1LfVa0gLYr8193N8yv5pV6d
	 ZaRCm/xKusx6g21naGLWKQy2ZQH+mp55ZB5J6xkBACgv2h1oq99R3tQVNrZEbcoaTQbfv
	 4HtlMI4G+aEIhap9cOo5ZJr3AGS/MdjR0+21K7fHe60q+BqlJVkNr0dd/h//lwZ2/ZDFp
	 RKnrmOqfmjHSU6g78et7jiETZaCmOYwPfneIKPFUE9JXfY17Esq7bBtzCSfscyiXyIBDW
	 cKqbUKfr7orUNjec8d3wTsucjRDenDK3cKbvPJp9gS1m/LeKnBEnUGOq7KafcUIfu2A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="N3OiN/Qg";
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=O4eDDCSg;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795115142;
	bh=QLjGJKkmi+Oj9BCIKBFtpyLhAr3EaTS2IyWKcdrF2kA=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=5kAHkV1p2XVbrMG3Wa1YGuc/Lxq+E/CJDn+wzjQB4mDFTlG2t1wWx/k9ggkTw+3x5
	 LGHTeS9DF4wzRWwtjEatXKq4+pWUM71JtH2nTwsSJot9wxFb5bAIauA5Mh5mEDAFBf
	 WS+kjlXe8RygN/I4StXFlQxA2EQkdFz5vJE639Oiw9Twl6LrECDdSwciEKisNlqm6E
	 W6gI+RZVb0r917OT+gkanm31n/LETIQJmpb5OpHbkhyFH+LnEuM8sbs+OQu4hEYszw
	 Ch+Mf3hPg5dMvW0ilZ2OjAElZdo65xvVAViuVcspGAoXqnGeFZtlFzWfZMMkwN74Jp
	 Oa9/Jmv0v+ABA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 821F5814BA;
	Thu, 19 Nov 2026 19:05:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1AD6F465
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 19:05:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0BB958148B
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 19:05:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Cz_jxRPkMBJ6 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 19 Nov 2026 19:05:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7EF8A81401
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.10
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.10;
 helo=mgamail.intel.com; envelope-from=maciej.fijalkowski@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=N3OiN/Qg; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=O4eDDCSg
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7EF8A81401
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 19:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795115139; x=1826651139;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=6d+2stocgPxYhgLEioo8a10DGQcSRQ60ADfAmxua9VI=;
 b=N3OiN/QgQXDvAOgckPGcPastE8kFlIJ5NUj1FkcbFKVVoJ/xyi08HTsS
 TLgDQxdtrbbszobgO/IC5EmGnEedEJhf8BNkSmzFdKAClRM3HWltnGi/f
 1IUcqLTit9CfM4JW24McGQh48U/Cq0ksvEWrq+qxWQVIb76dtJ8tS+zev
 +diMj5zf4GdtyNFulBI+b1FHaDFS9wCOrpKUqCNoqwvAR34PFMi2yULFR
 TbCcpvrndIc1VdiLcZQY+WdfGJob+Iac3lrK+dvJaV+hT4JP4yRZk3gGH
 L8Swx478GfWDEX5scVn3oPNUwNtMaXyb1b/4mLs496U6Ovy4flS27rOPr w==;
X-CSE-ConnectionGUID: +CRUBc+ASPaPSIFrLMHEGw==
X-CSE-MsgGUID: C46z5jqCTuaxwB5JpX3ryA==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3895712"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="3895712"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 11:05:32 -0800
X-CSE-ConnectionGUID: HQBBZx8NS4KpM9kuuOVb7A==
X-CSE-MsgGUID: A4Fho3jhQCCwnoGH32b9jQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; d="scan'208";a="10418701"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 11:05:32 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 11:05:30 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 19 Nov 2026 11:05:30 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.14) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 11:05:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLjGJKkmi+Oj9BCIKBFtpyLhAr3EaTS2IyWKcdrF2kA=;
 b=O4eDDCSg43ma5gK+wj1x3BtdEf/UZRqp5gIqk+57p8Cf9Vz2nzwkQYSfi3qc8ikkVd+VFVsTSFoUC9A6VbNJokdXCvNqrKH5ZMpmFen19/xsqXNMSujiSRPc1xwNMuWf9dVQ3XmAWOAlD0hrDAjM0Kv90+oNiMy3/f/VJHJmHeo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13) by SJ2PR11MB7519.namprd11.prod.outlook.com
 (2603:10b6:a03:4c0::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 19:05:27 +0000
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de]) by LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de%4]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 19:05:27 +0000
Date: Thu, 19 Nov 2026 20:05:15 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Magnus Karlsson <magnus.karlsson@intel.com>
CC: <netdev@vger.kernel.org>, <magnus.karlsson@gmail.com>, <sdf@fomichev.me>, 
 <davem@davemloft.net>, <edumazet@kernel.org>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <horms@kernel.org>, <bjorn@kernel.org>,
 <kerneljasonxing@gmail.com>, <intel-wired-lan@lists.osuosl.org>,
 <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
 <jacob.e.keller@intel.com>
Subject: Re: [PATCH net-next 5/5] selftests: net: add AF_XDP USO test
Message-ID: <av9Ia2gpMyF9jTuE@boxer>
References: <20261119165340.1071525-1-magnus.karlsson@intel.com>
 <20261119165340.1071525-6-magnus.karlsson@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119165340.1071525-6-magnus.karlsson@intel.com>
X-ClientProxiedBy: DU2PR04CA0309.eurprd04.prod.outlook.com
 (2603:10a6:10:2b5::14) To LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR11MB868673:EE_|SJ2PR11MB7519:EE_
X-MS-Office365-Filtering-Correlation-Id: 9279fdc1-8038-4520-700d-08df46701278
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|7416014|376014|22082099003|18002099003|6133799003|56012099006|261026121527099003|4143699003|261026140227099003|261026130827099003|261102123227099003|10067099003|261026135527099003|261022113327099003|261022105027099003|261028144727099003|261009223027099003|261022075727099003|261021135927099003|261022115727099003|261021133027099003|261021130227099003|261021121427099003|261021123027099003|11063799006;
X-Microsoft-Antispam-Message-Info: y+1e+vgDrnWtDG4z1F60xTUq8lLc8tfsxlautzo5l7feAJARdVTjiDn7pbop/nFjbobc+eSxCMIVUwMDQVT//5gp7djkgINDz3VoRjU3tMq1d7MEpbzTgUHFOcBL2QdXYQQe0O7bJ9b2zJtV7j+MjbX3gZzfSBPisYELryeW80bR2DIs5Iq3F30H49sBWyj7jUsS93T7Qx2uv3CdxmL11rwib/y1lMvb6v/sAc9055k5RPteozEyhRfQgvDA63xsrzKspsBVwoKLPPj8eloO95w2NuG24+6q8iOGUoNPShQP4aI7Eo4+QjItxreuDhP481frCfaH+W8wfcq4JFG30zyShrzgpFFdx08L9MgfmJo1EYZFTIiCOZjbYKXGEmDEFRvJ9hOwu9r6BL4k5cD81KUNYKjw2r5g5w046nP2nxBthHzrzu3kzyuzhZdJuY1ilhQ/1UDGzbm6QmuweyzubvAo02WskvoECBvaXVU80W9sIMzaNtiGqbEBtTXrDqXF6D5WaBccJFKG9JIIvWh+rqeqyymhi/mIrU18YT2XuUVBdbvv7SymxdX+UCVAkTAG62Z/UKwA8p+wxn0JMtvOTO0ZfOAshTkcOgfdhCWF194JymP0EVa9rTU8hgA5xDoQ4Gg9kfV2oHL4dI+lAEbm3yvLIrS51xE4XuRx86ZA0Gg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR11MB868673.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(22082099003)(18002099003)(6133799003)(56012099006)(261026121527099003)(4143699003)(261026140227099003)(261026130827099003)(261102123227099003)(10067099003)(261026135527099003)(261022113327099003)(261022105027099003)(261028144727099003)(261009223027099003)(261022075727099003)(261021135927099003)(261022115727099003)(261021133027099003)(261021130227099003)(261021121427099003)(261021123027099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C6iKcFGWlhXvhQVzj49oeqvb90QiTsLmkodxg/+sC1vU+G68JVNEULsZBv2h?=
 =?us-ascii?Q?+sOyYt7c9MuYvm3dkGWmoaBg4CfHLHyy0HUW3O6LPtrdDj5NBvWjhwmdVrIJ?=
 =?us-ascii?Q?Pxoo8YtjewjbT4OMHBsYssjOwfLXaTp09g9yCmVF7la2L/GX2QWaTnyp+yb9?=
 =?us-ascii?Q?EXeH+2tWFXsq1jqhARbDxXofTCaYWjstD1uNsl5vNLJczMJESVCu2Pgr4Fiy?=
 =?us-ascii?Q?JGhaSVRA2zoErtpb7WdbldAFd+iUBaoS9Ovuv7yWrTPgosLvbn1Rimko65VV?=
 =?us-ascii?Q?lmQkkH89jqN0UseQLdKCT+Lk1lkbeG1B/qPKnrEMdatY1tzspDVh5IYOPMSO?=
 =?us-ascii?Q?598QrtBX/fFg8v3qaNjZHrFtl6c7twSC6dHH55BdiIhD4nyrJ3N/PchKAM2V?=
 =?us-ascii?Q?fL5jOTLRczrc86gHpwIh1vqL3eOGlB8YCHalpaRpdx0F6dIH9pY/JuPrFqH7?=
 =?us-ascii?Q?nBIl77dCeeURygw/+00kjRmrzXsV/R7H4NQohsegn5g43ggSqWFr5RB9GvZ0?=
 =?us-ascii?Q?qwm86gg6oQ1A9mWtHI9XvtJWvV1PbniOzbLMGLN4JIPPnkAEwQ1KLSU/ExiP?=
 =?us-ascii?Q?8J8+OscIWEB/+H8iq7bHB6Saz/JHn/JGfuK+wQ0mYU+OMfcgRKrNe+6+uGQH?=
 =?us-ascii?Q?xcFFznUKJ5TcQoyU8rYTW2wY6PPW/Pl8kgyZYUV0K5xe6XGVkbSG38FD6YaK?=
 =?us-ascii?Q?j2a0r4BusDT46DuiFHupr0JcXYmVnvnR4OfRNc6WA5NgC1cN7baS4WifrA7g?=
 =?us-ascii?Q?HrqTquCiQGTZ3Wlydf/YLt4Kqi3SmF1h6ItTlvCtxu1/Als268vJEgm81+Yc?=
 =?us-ascii?Q?3YZhIsuFAKAcLqVDlZt1rRNT84TFVctMTUWqlSH5qLE71SreKMPWVrUBMl0y?=
 =?us-ascii?Q?p5iJdXU2kMzrXtFt0KTUd284jK4RVSiNgShLdPSW78xq7vROnoXYadtvZ3aT?=
 =?us-ascii?Q?Uqp4zWRU6Xl4ZK6R2s/xOw5cO/qtx9gYAHxYUXVcoOyh3v7mkax34/4h3aM4?=
 =?us-ascii?Q?0P8JBlXyDvW59ZYqqU9JlL+Ys+5tNwwM7BJHDyUe6DOnEjp/3MKeF0z+DTj+?=
 =?us-ascii?Q?Vpl1wW4q34ohLr7blIcYpyjn+zAq3Ei5IqHlANtT85k387k3EsmHq2Mr4maK?=
 =?us-ascii?Q?PUAdZm4RvgQd7vHJuQ7/i45YhtwKAzq057LG0lsaPfrpC5eds7ktH10jIROn?=
 =?us-ascii?Q?G0l+Q8SMErKS8P7q10YrR0wF7cfb8zhSCVpSIMGilzT1pg1loYqlKXOgARct?=
 =?us-ascii?Q?jbNK/u0X1K/I1nEFjRa4C765O5hrp45eF9rSN4/bNqiQHRgvAkCOHvcGPEbO?=
 =?us-ascii?Q?jQG2wP7SJRnvhNEZOLCgmO7g/dTaOBofFHIPQhwo1+k/zyhv+aSNwR3I2ha5?=
 =?us-ascii?Q?9WI9oAQJqpnMcIyBSO75aMauDerWNelq84HyzrJzKCbQzQ35S85pp7GylqfH?=
 =?us-ascii?Q?WWBrCkE8hdCsHYhL1WVk8zRTUJSbl9iYDkaJYy4sl2NFGBYM1QRNILOMHE0L?=
 =?us-ascii?Q?1IYIh7LOXeFNNdJDkskV6rTvK/UzKSo7LjdFNiQUFjXUbOO4D79uDEh9da19?=
 =?us-ascii?Q?vevVoiAbLCatO+vwjtQKPpjyZguPbeMeQHaN67cosY6qr5YyIppA6i33e6bL?=
 =?us-ascii?Q?zCCWlBQ7R0G3S2UipL4/stUMlgzMeVDt3+qE57mUXSIWWrpWofgrDjiUaPNa?=
 =?us-ascii?Q?hTlYhU9vs8dbXHaqTAZxrIOcPQRAzbyco4b0b9/Vr19gFwjtWP2K70Otm6Th?=
 =?us-ascii?Q?Z+3RpDilp02WodUfr50dkAUrPCfTeLI=3D?=
X-Exchange-RoutingPolicyChecked: OU4nUPeLxq20Pn6Q+J+5MASGFXWePyygaku1GX1YZXk8mUqWaz8cPHbvYpzqt+QXvyXYzWLxOzLaE1rLmoGzBJcrjW2WOAbMUsM01Wl6KWEIdVPCKR6v1hf6baJ/0fiuzYxhpNqSu1DiYfwzvRZWfFUBF6jOfmDf9T6QX8i/V07S8aDdDrx9x9jGcewrihVdPfXppW8ycFYieRQZx+k8noK9YFGLUW6bQfoo/RuKKeqGjnRDyRG1yAkalupv260waS5rUobjk2x4UIn5bjW+h4afDklgCBwT2o4Q+KaX/HvYNuaQm0Atgk0CsW889WRTWBKSy2r5JXEkVc7BLFBJEA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9279fdc1-8038-4520-700d-08df46701278
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB868673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 19:05:27.1002 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pxjZm/FsnIUCtOWwqcXPfNssQn+OC3RRHtWPO9gNdiHhyvKoIJ1W/MqHepc0/eXH6b+VBgZuhqUjb1G7aP8Tsxa9XtDNsowzCcpapfwiEp8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7519
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 19, 2026 at 05:53:40PM +0100, Magnus Karlsson wrote:
> Add xsk_uso, a functional test for AF_XDP UDP segmentation offload in
> copy and zero-copy mode. It sends USO requests from an AF_XDP socket
> and checks the datagrams received on a packet socket: the number of
> datagrams, the IP and UDP lengths, the checksums and the payload, for
> IPv4 and IPv6, and single and multi-buffer requests. It also checks
> that invalid requests are dropped and counted in tx_invalid_descs.
> 
> The test needs root and physical NICs with an MTU of at least 1448,
> either two connected ports (-i TX_IFACE -r RX_IFACE) or one in NIC
> loopback (-l -i IFACE). Virtual devices such as veth pass the packet on
> without segmenting it. Zero copy (-z) also needs a native XDP program on
> the interface. Standalone checksum offload cases run only with -C, as
> they test the existing checksum offload rather than USO. As it needs
> real hardware, it is built but not run by default, like xdp_hw_metadata.
> It uses the AF_XDP library in net/lib/xsk.

I assume the end goal for xdp_hw_metadata is to pull in its contents onto
xsk python runner. What is the case for this one?

Also since you're adding support to copy mode i assume veth runs would be
welcome...

Did you try to point AI to my set and ask whether it would be able to
produce python runner for that? Or do we don't want to have this CI'ed ?

> 
> Missing prerequisites are reported as skips. In zero-copy mode, the
> device must report xsk-zerocopy and tx-uso-zc, and checksum-only cases
> need tx-checksum. In both modes, cases that produce more than one
> datagram need tx-udp-segmentation, including the invalid ones, which
> would otherwise be dropped for lack of the offload whatever their
> headers. Cases that need more descriptors than xdp-zc-max-segs are
> skipped, and so are binds that the device refuses with EOPNOTSUPP.
> Receive-side UDP GRO (rx-udp-gro-forwarding, rx-gro-list) must be off,
> as it would merge the segments again before the packet socket sees them.
> USO with launch time must succeed in copy mode and be dropped in
> zero-copy mode.
> 
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> ---
>  tools/testing/selftests/net/.gitignore |   1 +
>  tools/testing/selftests/net/Makefile   |  10 +-
>  tools/testing/selftests/net/xsk_uso.c  | 954 +++++++++++++++++++++++++
>  3 files changed, 964 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/net/xsk_uso.c
> 

...

> +
> +static void get_mac(const char *name, unsigned char *mac)
> +{
> +	struct ifreq ifr = {};
> +	int fd = socket(AF_INET, SOCK_DGRAM, 0);
> +
> +	if (fd < 0)
> +		ksft_exit_fail_msg("socket: %s\n", strerror(errno));
> +	snprintf(ifr.ifr_name, sizeof(ifr.ifr_name), "%s", name);
> +	if (ioctl(fd, SIOCGIFHWADDR, &ifr))
> +		ksft_exit_fail_msg("MAC address for %s: %s\n", name, strerror(errno));
> +	memcpy(mac, ifr.ifr_hwaddr.sa_data, ETH_ALEN);
> +	close(fd);
> +}
> +
> +static unsigned int get_mtu(const char *name)
> +{
> +	struct ifreq ifr = {};
> +	int fd = socket(AF_INET, SOCK_DGRAM, 0);
> +
> +	snprintf(ifr.ifr_name, sizeof(ifr.ifr_name), "%s", name);
> +	if (fd < 0 || ioctl(fd, SIOCGIFMTU, &ifr))
> +		ksft_exit_fail_msg("MTU of %s: %s\n", name, strerror(errno));
> +	close(fd);
> +	return ifr.ifr_mtu;
> +}

this is a lib content which i'm also adding, so we're gonna clash.

> +
> +/* Virtual devices have no backing device, and pass GSO packets on whole. */
> +static bool is_physical(const char *name)
> +{
> +	char path[64];
> +
> +	snprintf(path, sizeof(path), "/sys/class/net/%s/device", name);
> +	return !access(path, F_OK);
> +}
> +
> +static int ethtool_ioctl(const char *name, void *cmd)
> +{
> +	struct ifreq ifr = { .ifr_data = cmd };
> +	int fd = socket(AF_INET, SOCK_DGRAM, 0), err;
> +
> +	if (fd < 0)
> +		return -1;
> +	snprintf(ifr.ifr_name, sizeof(ifr.ifr_name), "%s", name);
> +	err = ioctl(fd, SIOCETHTOOL, &ifr);
> +	close(fd);
> +	return err;
> +}
> +
> +/* Returns whether the netdev feature called @feature is active on @name. */
> +static bool feature_active(const char *name, const char *feature)
> +{
> +	struct ethtool_gfeatures *features = NULL;
> +	struct ethtool_gstrings *strings = NULL;
> +	struct ethtool_sset_info *sset;
> +	unsigned int count, blocks, i;
> +	bool active = false;
> +
> +	sset = calloc(1, sizeof(*sset) + sizeof(sset->data[0]));
> +	if (!sset)
> +		ksft_exit_fail_msg("calloc: %s\n", strerror(errno));
> +	sset->cmd = ETHTOOL_GSSET_INFO;
> +	sset->sset_mask = 1ULL << ETH_SS_FEATURES;
> +	if (ethtool_ioctl(name, sset))
> +		ksft_exit_fail_msg("ETHTOOL_GSSET_INFO: %s\n", strerror(errno));
> +	if (!sset->sset_mask)
> +		ksft_exit_fail_msg("%s reports no feature strings\n", name);
> +	count = sset->data[0];
> +	blocks = (count + 31) / 32;
> +	strings = calloc(1, sizeof(*strings) + count * ETH_GSTRING_LEN);
> +	features = calloc(1, sizeof(*features) +
> +			  blocks * sizeof(features->features[0]));
> +	if (!strings || !features)
> +		ksft_exit_fail_msg("calloc: %s\n", strerror(errno));
> +	strings->cmd = ETHTOOL_GSTRINGS;
> +	strings->string_set = ETH_SS_FEATURES;
> +	strings->len = count;
> +	features->cmd = ETHTOOL_GFEATURES;
> +	features->size = blocks;
> +	if (ethtool_ioctl(name, strings) || ethtool_ioctl(name, features))
> +		ksft_exit_fail_msg("ethtool features: %s\n", strerror(errno));
> +	for (i = 0; i < count; i++)
> +		if (!strncmp((char *)strings->data + i * ETH_GSTRING_LEN, feature,
> +			     ETH_GSTRING_LEN)) {
> +			active = features->features[i / 32].active & (1U << (i % 32));
> +			break;
> +		}
> +	free(features);
> +	free(strings);
> +	free(sset);
> +	return active;
> +}
> +
> +static void get_xdp_features(unsigned int ifindex, uint64_t *xdp, uint64_t *xsk,
> +			     unsigned int *zc_max_segs)
> +{
> +	struct netdev_dev_get_req *req;
> +	struct netdev_dev_get_rsp *rsp;
> +	struct ynl_error yerr;
> +	struct ynl_sock *ys;
> +
> +	ys = ynl_sock_create(&ynl_netdev_family, &yerr);
> +	if (!ys)
> +		ksft_exit_fail_msg("YNL: %s\n", yerr.msg);
> +	req = netdev_dev_get_req_alloc();
> +	if (!req)
> +		ksft_exit_fail_msg("netdev_dev_get_req_alloc failed\n");
> +	netdev_dev_get_req_set_ifindex(req, ifindex);
> +	rsp = netdev_dev_get(ys, req);
> +	netdev_dev_get_req_free(req);
> +	if (!rsp)
> +		ksft_exit_fail_msg("netdev dev-get: %s\n", ys->err.msg);
> +	*xdp = rsp->_present.xdp_features ? rsp->xdp_features : 0;
> +	*xsk = rsp->_present.xsk_features ? rsp->xsk_features : 0;
> +	*zc_max_segs = rsp->_present.xdp_zc_max_segs ? rsp->xdp_zc_max_segs : 1;
> +	netdev_dev_get_rsp_free(rsp);
> +	ynl_sock_destroy(ys);

you really should look at python drv-net infra...
