Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF7D606A32C
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Nov 2026 09:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=mtCfrSDr;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=O14yYNVj;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=LRIVUYpH
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DDAEB4040F;
	Mon, 23 Nov 2026 09:04:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X3niOW1QO8QN; Mon, 23 Nov 2026 09:04:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BFB424041A
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795424662;
	b=U5Y+/vvmvESq1roJY+ydhR2bjYR6QZ9y6OoSTlxcVCTfu1a6VkIFIUO4BJzEqpkn+ESd
	 ULKwLos82emIU1NSe0z++54KFu6p5WRcqfHtT/VWqF5/7IO54RXP4JrMdJGrzQs+BSycq
	 CNfK2ZzUAQoPa2FHux+0hrS3hYGVMrJ+b9UESdDhc9HN4HVp0mRgff7yjxUbbbi6rDSGe
	 5SHqz+xEKmci3uk42ImQHZFqEoMXpDVQxKh6KEVHQkwg1/HMxwZ6S6QCz4OiEPIBru8bL
	 toU2T8RKpeM4CnZa4G97WFOW0it2dgdIlBJZRaZiZ5DQQ5uA4FgqNp7DxV/tcLqtsiw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795424662;
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
	bh=QlFqW+jK+SoBxfo/SRfS358aoFR3yGz+0/30x7CMFzk=;
	b=FS4JUvMENzK21fiZFMdFVw1OvapMIpQ3f+b2jEhwvsZmmxAGSBwAZT1OjAouV/rgohci
	 LkDipmBNSfsog3kXhSAdqt+sytnn6pR6u8Me8vf9/KkC/EGppIouWDj29eBJis0w+7iO/
	 6v3JQaHDgWS/uvNX2d0rI4MVYfAAH0k8AKbAZREi4+gbfWPWXbQz6YPT8z1GujxGAS+RM
	 PmlXhEtxWXYjkS9oQXiXefQPO/NBeko1b34XN4Dod4l9BBh7WFLDQ227yqsBD12JjtJpM
	 PgDcxlhxyqvnlFPBpI6O82YTSHM+kyPSSA8ly3mB1rrALI/40vE1dI/3PNfXbxbkNtQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=O14yYNVj;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=LRIVUYpH;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795424662;
	bh=QlFqW+jK+SoBxfo/SRfS358aoFR3yGz+0/30x7CMFzk=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mtCfrSDr7vKVs+yecTyoCnzro/NWMPjIhFqJzF193LndlZVPljP5XLU5Ad9q0naUd
	 MBaARoiOfANwW6sSUvrKyZQZDaZIZqeEWSG3b28Uw9Se3oDlDthPJLHqAhNVHm5lbM
	 ImqFxIUeVF5EQyv3KMfT29hHIBKSJZpwd7I0lIHbKfb1308tM9BVpRe4oDc5b73/04
	 cQDiVCwXbGMbXExICnnZOItNOVCRSLp7yb9UCMNT8llL8a+WImEyS7fFb2Fd+3rTrF
	 NBG5vK41B/iGoKDEfCIP4LnuKaDRlRkSdXe/ZR84SLrcFxiAzHHApRlG7bXjelQ2XB
	 9tpvvHhV1wRlg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BFB424041A;
	Mon, 23 Nov 2026 09:04:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DB9BC1AB
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 09:04:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BD54D403AA
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 09:04:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Gj6ZhKiEqF4E for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Nov 2026 09:04:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 134BE40379
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.11
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.11;
 helo=mgamail.intel.com; envelope-from=maciej.fijalkowski@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=O14yYNVj; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=LRIVUYpH
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 134BE40379
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 09:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795424661; x=1826960661;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=JJvUehBWa09I1u2XMjOKycrCPzzcUazbve56rt2tPjs=;
 b=O14yYNVjfw3AOPSNBGEqAeRuN+34uf1EcTOH7KSbJzEOnv3jXvrKEuAc
 XG9YTAcXC5lV652gNjQGdPSW37ToiONT/Bam3zx4cTVTnq8vi7cMaPVyL
 HF/mnpM0vtxXo6qGy1TAWTmkrNLkTS1X6dCAEswXW+P/7ilt+p/kqA7gW
 P6U9qkq0gGa9XfiPJX/k7rY+4U+RNOCB2FULxENehhrpBKFVjQRSvvV0w
 uUZpMKTUPMALvwYguadEe5J4PctL2ukWgY+VQlyr+pnCjffZtNE2/8t+d
 lybi7UpuBs0prO8lAMRoMWhie/hVkSNLoR4+nfL3UTwHit+11qD7//K83 w==;
X-CSE-ConnectionGUID: hqtLFIqrQxWHfJT3Ahsecw==
X-CSE-MsgGUID: o4wtz/BBRH2eSDQ8l47SwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4122889"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4122889"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 01:04:19 -0800
X-CSE-ConnectionGUID: vbtYKpdPRr+5Acru2p+h3g==
X-CSE-MsgGUID: jwI0uFanSxmE2fAaFAeNWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; d="scan'208";a="12951132"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 01:04:18 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 01:04:18 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Mon, 23 Nov 2026 01:04:18 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.15)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 23 Nov 2026 01:04:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QlFqW+jK+SoBxfo/SRfS358aoFR3yGz+0/30x7CMFzk=;
 b=LRIVUYpHhks65N80cDSqznK7/OAatBNn/YHDFk3/5unn22Bq9EAyKVBL5URdZjMhHuMHBgTvml4TbPziFZpsRTpEuH1jvAuFkBkdft4iwunmeJnA4wcB4hUmRV0XmOkNko+jM4NbB+tjxoSwxU2+OB90atZyxhtCpTLC7P8KOxI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13) by DS0PR11MB7441.namprd11.prod.outlook.com
 (2603:10b6:8:141::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Mon, 23 Nov
 2026 09:04:07 +0000
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de]) by LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de%4]) with mapi id 15.21.0639.011; Mon, 23 Nov 2026
 09:04:07 +0000
Date: Mon, 23 Nov 2026 10:04:01 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Magnus Karlsson <magnus.karlsson@gmail.com>
CC: Magnus Karlsson <magnus.karlsson@intel.com>, <netdev@vger.kernel.org>,
 <sdf@fomichev.me>, <davem@davemloft.net>, <edumazet@kernel.org>,
 <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
 <bjorn@kernel.org>, <kerneljasonxing@gmail.com>,
 <intel-wired-lan@lists.osuosl.org>, <anthony.l.nguyen@intel.com>,
 <przemyslaw.kitszel@intel.com>, <jacob.e.keller@intel.com>
Subject: Re: [PATCH net-next 3/5] xsk: ice: add USO zero-copy support
Message-ID: <awQBgefjtxMdZYWg@boxer>
References: <20261119165340.1071525-1-magnus.karlsson@intel.com>
 <20261119165340.1071525-4-magnus.karlsson@intel.com>
 <awBXmCqkMKxsc+9i@boxer>
 <CAJ8uoz2tKthHN6MHUJoixtjzkGqJR0ukdJCWRG0_2_J11PN_uw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ8uoz2tKthHN6MHUJoixtjzkGqJR0ukdJCWRG0_2_J11PN_uw@mail.gmail.com>
X-ClientProxiedBy: DUZPR01CA0029.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::18) To LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR11MB868673:EE_|DS0PR11MB7441:EE_
X-MS-Office365-Filtering-Correlation-Id: b152c371-97a3-4108-de1a-08df4940baa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|23010399003|6133799003|261009223027099003|18002099003|22082099003|261022115727099003|261021135927099003|261022105027099003|261026121527099003|261021121427099003|261026140227099003|261022075727099003|261028144727099003|56012099006|10067099003|261102123227099003|261102130727099003|11063799006|5023799004|4143699003;
X-Microsoft-Antispam-Message-Info: o7MrW9wIscx2NnAb84pIFog7+VGUqYy0uOvKJTQzn8wFqkgibjIK35UQ94oj+ZKq7cvYRZ8S6kOGi/BmofTqnGUP+9HAnJO0Kl59n0zSWG8UPZpdganOsmF46oBTxJdZ2eH70ZDwwMeMloy45ASRrfeherlFqqhIqfAcYbAUXsobpxEnJq0YB5f1M0HC+HZAxvOvRARYkaTZypvcBgCSFwcq6GTFcUaa1bkDwOfm0YgSM/AGbjuLo46bVQWIADr2h4cUyVw6rxGurhEZbCpG2mWZxj33fxi86lXaWSjJPaavc2Li+qiaB+lKq/dfVo/UPeNvmqbnFBfZ7LfkrRgMM8AuusJLRPE/i8qNNFVUDTBfxwheQ3JwoRjzzom7bg7c4JSzglLWQlhieNWA20FFVs1CDX+0tpx5wEOIxkVBjqGMoNyJNEzS2LBTl5sodlPe0L+NZJIo+LUJdCjmCxEeUhjf/krdhbY+GdLWLA4tGbUuC2XDwpoDD7HJ1U8CYwFbnR2MsUxeS3thjZ8htmAwTA/ywWMeAkxY6wlBZNWHNWBOYcCBQDprpl2kTnVVJjb/JvJZP0t2KmZaLzX4lkfeyz7u61FDS+9I/ah9vPPm/dmDLnroReWYav2N2uTk1zRwlpO3F0FjL7/uOdwyP7sIbeRIMlVo/Qb2uDtTcaO/YKQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR11MB868673.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(6133799003)(261009223027099003)(18002099003)(22082099003)(261022115727099003)(261021135927099003)(261022105027099003)(261026121527099003)(261021121427099003)(261026140227099003)(261022075727099003)(261028144727099003)(56012099006)(10067099003)(261102123227099003)(261102130727099003)(11063799006)(5023799004)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?06CitorWgIXqsiGb2IHbxASeQOpGKM4pouyRRLE2bFjcvOGx/uhGg1qZBtDl?=
 =?us-ascii?Q?Psw6i8/sLnkueaOgjfLqE2ZUbwlaCHl7ETAgNSxQcRgc6/emeyqLvqCAlxts?=
 =?us-ascii?Q?8seV8or/diSlVTa0HbC/0NtFG6ZV8uAagZypJa86QHO1TyS3TQnt1viNbNYI?=
 =?us-ascii?Q?90ww9iLUbasVyFGZe/RPugBVxMynjoEaX0VVygEMbCL1bWnYStbAmYeK7rMB?=
 =?us-ascii?Q?SpisCLSTYP5cwLxvzyKpFeFyHThdgPe2siR9TOmYJzJl7sCTGIyMC7cBgW7W?=
 =?us-ascii?Q?Ta7mOy5NbG4ilSuQZwWZqN0u9l4vRjOIKyGwG/cOC9Y0BkIGzlQPyUsAHGFC?=
 =?us-ascii?Q?BRi3u7T4lEoMhUb0btjG82DeM1MscvzvqRXOyqrq76lSZBboslR+fpPHUKtk?=
 =?us-ascii?Q?d/daa61wYezOzadNDtHFpleL9XA3sHGMsj5MCPSqWMHEuqDnB6Zy/ajntlsy?=
 =?us-ascii?Q?a+NMdo96gigSgWkmqJJxCEOoUpqHlGU6JkgKeahRMNsMySSMsk5tbtJvOrET?=
 =?us-ascii?Q?6MUs4bjiTcnqROunETz6OQvcCJ+TBu+lztD/Aj1lsM092rDarVSLOaRt3Y4X?=
 =?us-ascii?Q?oYCLXsDOu1nIU1g7HWojphmKO78TLayZCqRdOuBVJ1pVEir1AkXKKPIZd/Nx?=
 =?us-ascii?Q?46UhH12OGWTlOZ4V/Fw66L7VkSx5rFDUeCXMfyopp9Aex3iKf6FMUBXPCUhI?=
 =?us-ascii?Q?EYRDywSCWMHTGH3aU3aHSQ2dOTCxgcC6x9EAfPA/WSiW5QZ4OGooC0Dlwm+C?=
 =?us-ascii?Q?+T02ItS5iFfBFm7URm/zrVjOoE04qn5RBYrIaWgE+maVcSNic23lbeoCwCRr?=
 =?us-ascii?Q?JHNm+Xmz4EP7kR4TnUWbi55fi89nx2tTCBrUs3EtV3SNWypjHCFmSjd1jWcs?=
 =?us-ascii?Q?NFoGGcz/KBYb50i6HvRgzAkvkqDwgC9n5YwnoHZQxSPe664AOFN2mcsPMZN5?=
 =?us-ascii?Q?1IsCIvlBRH0cBkuWSmcRM+V/688gUmyq8aFdY3iZAAaSzsDIuWTXqc4HcxcE?=
 =?us-ascii?Q?TvXWOvEnVGFgJDFDv33z6XIHkc9u7ivl6mSk/cmYJ+ej9r5vI0VRClcwm6TU?=
 =?us-ascii?Q?xdSmAislCJ5cudzzrE9zuOnfBCf+PJp/9Q0dse+LCSNUrX5daQKbgtmHdYKU?=
 =?us-ascii?Q?/Tng9qrbOuPohdDlr0CZPDQcdxdeZTW/DqLsXl17HDw5IwnacThu5Ppui53j?=
 =?us-ascii?Q?yI2uaydYDfE5ZmhfqHq/eI9iuMjcydNHuo9G35mEWkyynA40aTI8e/nbFQ99?=
 =?us-ascii?Q?V2thRqjC5NJn6Q2k9GmROvLZ6aE1WK/LYZ/REGn2QxqbCn+4rvEOBA1WEAGb?=
 =?us-ascii?Q?xnQhKJeSyKwaOrgQApeTggyS3Uk3hcS856xjeWI01Jx2KC0olDPd0PQoCGmi?=
 =?us-ascii?Q?4KONxHLl1oUGal3r9+T3TELr0CCj8Daagm9ZcjNMmh4xPdFEF/DJt8STFdaR?=
 =?us-ascii?Q?LJIky2p92q8i+H/KsTUiLProK1t1y7HDHegPvrwLQuPtN6NAgHuBvv3V7gtt?=
 =?us-ascii?Q?tdg2+z8erkwzuTwS9p5n+uhd0GK/R+6RmUrUYEsoeoRlkf7bY7jh4Hrw80QW?=
 =?us-ascii?Q?kq8gZGZ45bSqHYr9VEr3zdO2mrDxuhjMt/3cNOTrXefjJqiZydiiAIvUrN35?=
 =?us-ascii?Q?EY059nlXjInff2Py26051Civ267UgyaO6cc6RhseekAB3R6Ktk3SrP6JFneU?=
 =?us-ascii?Q?n9p2zYGzpLEW/g7wpe/xFj/80lNCJ7Qp6j9JZcXkhkBjk3eXvhSWNYjZq+EI?=
 =?us-ascii?Q?ZAeHtzrjUvtUygOTZApqbMsr3UU+fKY=3D?=
X-Exchange-RoutingPolicyChecked: BKveTCgXzSGwkSDuTc+oouf/1YByc6xNMAHI2VMPyD3euqBoqtAQ+WhKZtPug5ydAEcWH1wcUNpwJsz015MFO5bud32tioZfIFmX1wLyXwBri+MhEXBLooix3UeArKH22OqNXy1CoMX/Uk6fjp8PdAkqUHcj+dZmJOf0oq28WiXyAUniTycoHSfcXTcoPf/1z3m5y6sN9NKGJ0GE/i8zBskb57DK7p3cKEpQtKSpV4CljhAApvlXn68VPQLByGFtVuCy8j834ILkYvHlUgp7V9rhKM0XgHJhXj/NpG2xuOXfuQhXjROU7HuL83BsKGPZQQ/JdZipkbCaKB8f0fdW3w==
X-MS-Exchange-CrossTenant-Network-Message-Id: b152c371-97a3-4108-de1a-08df4940baa6
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB868673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 09:04:06.9966 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RpCjnceD4XSYI6W/zqDfWM7+/Nz8hX/mOVNu7MjYsj2cfR29zfYqQ/FhEkNziSpWOi40wkM0KtiUQirAZ4jQ7y6Pj+7EIQ0bZpnkKwKk868=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7441
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 23, 2026 at 09:40:37AM +0100, Magnus Karlsson wrote:
> On Fri, 20 Nov 2026 at 15:22, Maciej Fijalkowski
> <maciej.fijalkowski@intel.com> wrote:
> >
> > On Thu, Nov 19, 2026 at 05:53:38PM +0100, Magnus Karlsson wrote:
> > > Add UDP Segmentation Offload (USO) for AF_XDP zero-copy and implement
> > > it in the ice driver. Drivers advertise support with tmo_supports_uso,
> > > which is reported to user space as the tx-uso-zc netdev XSK feature.
> > >
> > > The core exports xsk_tx_uso_parse() and xsk_tx_uso_prepare_headers() for
> > > drivers, which snapshot, validate and prepare the packet header, and
> > > xsk_tx_invalid_descs() for accounting dropped requests. Drivers without
> > > tmo_supports_uso keep handling a USO request as invalid metadata, so
> > > xsk_tx_metadata_request() ignores the packet's metadata. As in copy
> > > mode, requests that produce more than one datagram also need
> > > NETIF_F_GSO_UDP_L4 on the device.
> > >
> > > Packet headers are copied into kernel-owned memory before they are
> > > validated and handed to the NIC, so that user space cannot change them
> > > afterwards. ice keeps a DMA-mapped header slot for every two
> > > descriptors of the XDP Tx ring, as a USO packet takes at least a
> > > context and a header descriptor. The slots hold only header bytes and
> > > are allocated page by page to avoid a large contiguous
> > > allocation. They belong to the ring: they are allocated when a pool
> > > that can carry USO requests is assigned to the ring, and freed with
> > > the ring. They therefore follow XDP attach and detach, ring rebuilds
> > > and netdev unregistration rather than the pool. Only the copied header
> > > bytes are synced for the device. With fewer XDP rings than CPUs,
> > > queues share XDP rings and would share their slots, so no slots are
> > > allocated and USO requests are ignored for now, though support for
> > > this could be added as a separate patch set in the future. tx-uso-zc
> > > is still reported in this case, as documented. The slots are only
> > > set up when an XDP program is attached. If they cannot be allocated
> > > when a ring is reconfigured, the ring keeps its pool without USO and a
> > > warning is logged, while a bind fails.
> > >
> > > When the slots exist, ice_xmit_zc() processes descriptors one packet
> > > at a time. A USO packet gets a context and a header descriptor, then
> > > shares the data-descriptor loop with ordinary packets. The Tx budget
> > > reserves worst-case descriptors per packet. The per-packet path is used
> > > for every pool with a Tx metadata area that can carry USO requests,
> > > whether or not it sends them. Other pools keep the existing batched
> > > fast path. Both paths share the budget, tail, stats and wakeup
> > > handling. If the Tx ring cannot hold a maximum-size packet in this
> > > worst case, such a packet could never be peeked and Tx would stall, so
> > > no header slots are allocated, USO requests are ignored and a warning
> > > is logged. The pool flag is not cleared, as the pool may still fall
> > > back to copy mode. This is only possible when PAGE_SIZE is 64K and the
> > > Tx ring is set to its minimum size.
> > >
> > > Packets that exceed the hardware limits are dropped and counted in
> > > tx_invalid_descs through the new xsk_tx_invalid_descs() helper. Their
> > > completions are deferred behind in-flight descriptors to keep the
> > > completion ring in order. Packets without USO are dropped as well if
> > > they would exceed the eight buffers, which is possible when chunks
> > > larger than a data descriptor are split. A batch from the shared-umem
> > > fallback can end inside a packet. That packet is dropped, and so is
> > > its remainder in the next batch.
> > >
> > > On completion, a buffer of the existing fast path still stands for one
> > > completion, so that path writes nothing to tx_buf[] and struct
> > > ice_tx_buf keeps its size. Buffers of the USO path carry an explicit
> > > completion count in a union with fields that zero-copy rings do not use.
> > > USO header slots, deferred drops and buffers split into several
> > > descriptors are tracked with a per-ring counter, so ordinary traffic
> > > keeps the fast cleanup path. The header slot of a context descriptor is
> > > found from its position in the ring.
> > >
> > > The descriptors are built with the descriptor builders that the
> > > previous patch added for ice_tso().
> > >
> > > Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>

> > > +/* Returns the number of packets queued on the ring. */
> > > +static u32 ice_xmit_zc_metadata(struct ice_tx_ring *ring, struct xsk_buff_pool *pool,
> > > +                             u32 count, unsigned int *total_bytes)
> > > +{
> > > +     struct xdp_desc *descs = pool->tx_descs;
> > > +     u32 i = 0, packets = 0;
> > > +
> > > +     /* Drop the rest of a packet whose start was dropped in an earlier batch. */
> > > +     if (unlikely(ring->xsk_drain)) {
> > > +             while (i < count && ring->xsk_drain)
> > > +                     ring->xsk_drain = !xsk_is_eop_desc(&descs[i++]);
> > > +             ice_xsk_drop_packet(ring, pool, i);
> > > +     }
> > > +
> > > +     while (i < count) {
> > > +             u32 cmd = 0, offset = 0, skip = 0, slot_offset;
> > > +             u32 len = descs[i].len, nr = 1;
> > > +             struct ice_xsk_uso_page *page;
> > > +             struct xsk_tx_uso_info info;
> > > +             int uso;
> > > +
> > > +             while (!xsk_is_eop_desc(&descs[i + nr - 1]) && i + nr < count)
> > > +                     len += descs[i + nr++].len;
> > > +             /* The shared-umem fallback can end a batch inside a packet. */
> >
> > No, it can not... or at least the intent was not to. the shared umem
> > fallback has been written in a way that it also calls
> > xskq_cons_read_desc_batch() which is supposed *not* to expose incomplete
> > multi-buffer packet.
> >
> > Is that a special case where you don't set XDP_USE_SG but packets are not
> > linear due to USO, or what?
> >
> > I wouldn't like to propagate the draining disease down to drivers. We've
> > put enough of convoluted code onto layer above, let us address it there if
> > there's something missing?
> 
> You are right. This should not be here in the driver. I will fix it in
> the core instead.
> 
> At some point we really need to simplify the skb multi-buffer path.
> Always gives me a headache.

skb mbuf is not a victim here :P regardless I agree on rewrite.

> 
> > I'm gonna cut the review here and keep the comments I had so far.
> >
> > > +             if (unlikely(!xsk_is_eop_desc(&descs[i + nr - 1]))) {
> > > +                     ice_xsk_drop_packet(ring, pool, nr);
> > > +                     ring->xsk_drain = true;
> > > +                     break;
> > > +             }
> > > +             page = ice_xsk_uso_slot(ring, ring->next_to_use, &slot_offset);
> > > +             uso = xsk_tx_uso_parse(pool, &descs[i], nr, &info,
> > > +                                    page->addr + slot_offset + NET_IP_ALIGN);
> > > +             if (uso < 0 || (!uso && !ice_xsk_bufs_fit(pool, &descs[i], nr)) ||
> > > +                 (uso && ice_xsk_xmit_uso_hdr(ring, &descs[i], nr, &info,
> > > +                                              &cmd, &offset))) {
> > > +                     ice_xsk_drop_packet(ring, pool, nr);
> > > +                     i += nr;
> > > +                     continue;
> > > +             }
> > > +             if (uso) {
> > > +                     skip = info.header_len;
> > > +                     *total_bytes += (info.gso_segs - 1) * skip;
> > > +                     packets += info.gso_segs - 1;
> > > +             }
> > > +             ice_xsk_xmit_descs(ring, pool, &descs[i], nr, skip, cmd, offset);
> > > +             *total_bytes += len;
> > > +             packets++;
> > > +             i += nr;
> > > +     }
> > > +     return packets;
> > > +}
> > > +
> > > +/**
> > > + * ice_xsk_setup_metadata - register AF_XDP Tx metadata operations
> > > + * @netdev: net_device
> > > + */
> > > +void ice_xsk_setup_metadata(struct net_device *netdev)
> > > +{
> > > +     static const struct xsk_tx_metadata_ops ops = {
> > > +             .tmo_supports_uso = true,
> > > +     };
> > > +
> > > +     netdev->xsk_tx_metadata_ops = &ops;
> > > +}
> > > +
> > >  /**
> > >   * ice_xmit_zc - take entries from XSK Tx ring and place them onto HW Tx ring
> > >   * @xdp_ring: XDP ring to produce the HW Tx descriptors on
> > > @@ -801,9 +1222,9 @@ static void ice_fill_tx_hw_ring(struct ice_tx_ring *xdp_ring,
> > >  bool ice_xmit_zc(struct ice_tx_ring *xdp_ring, struct xsk_buff_pool *xsk_pool)
> > >  {
> > >       struct xdp_desc *descs = xsk_pool->tx_descs;
> > > -     u32 nb_pkts, nb_processed = 0;
> > > +     u32 nb_pkts, nb_processed = 0, packets;
> > >       unsigned int total_bytes = 0;
> > > -     int budget;
> > > +     u32 budget, cost = 1;
> > >
> > >       ice_clean_xdp_irq_zc(xdp_ring, xsk_pool);
> > >
> > > @@ -811,26 +1232,38 @@ bool ice_xmit_zc(struct ice_tx_ring *xdp_ring, struct xsk_buff_pool *xsk_pool)
> > >           !netif_running(xdp_ring->vsi->netdev))
> > >               return true;
> > >
> > > -     budget = ICE_DESC_UNUSED(xdp_ring);
> > > -     budget = min_t(u16, budget, ICE_RING_QUARTER(xdp_ring));
> > > +     /* Reserve worst-case descriptors for each potential USO packet. */
> > > +     if (xdp_ring->xsk_uso_pages)
> > > +             cost = ice_xsk_uso_desc_cost(xsk_pool);
> > > +     budget = min_t(u32, ICE_DESC_UNUSED(xdp_ring) / cost,
> > > +                    ICE_RING_QUARTER(xdp_ring));
> > >
> > >       nb_pkts = xsk_tx_peek_release_desc_batch(xsk_pool, budget);
> > >       if (!nb_pkts)
> > >               return true;
> > >
> > > -     if (xdp_ring->next_to_use + nb_pkts >= xdp_ring->count) {
> > > -             nb_processed = xdp_ring->count - xdp_ring->next_to_use;
> > > -             ice_fill_tx_hw_ring(xdp_ring, xsk_pool, descs, nb_processed,
> > > -                                 &total_bytes);
> > > -             xdp_ring->next_to_use = 0;
> > > -     }
> > > +     if (xdp_ring->xsk_uso_pages) {
> > > +             packets = ice_xmit_zc_metadata(xdp_ring, xsk_pool, nb_pkts,
> >
> > nit: could we stick to 'pkts'
> >
> > > +                                            &total_bytes);
> > > +     } else {
> > > +             if (xdp_ring->next_to_use + nb_pkts >= xdp_ring->count) {
> > > +                     nb_processed = xdp_ring->count - xdp_ring->next_to_use;
> > > +                     ice_fill_tx_hw_ring(xdp_ring, xsk_pool, descs, nb_processed,
> > > +                                         &total_bytes);
> > > +                     xdp_ring->next_to_use = 0;
> > > +             }
> > >
> > > -     ice_fill_tx_hw_ring(xdp_ring, xsk_pool, &descs[nb_processed],
> > > -                         nb_pkts - nb_processed, &total_bytes);
> > > +             ice_fill_tx_hw_ring(xdp_ring, xsk_pool, &descs[nb_processed],
> > > +                                 nb_pkts - nb_processed, &total_bytes);
> > > +             packets = nb_pkts;
> > > +     }
> > >
> > > -     ice_set_rs_bit(xdp_ring);
> > > -     ice_xdp_ring_update_tail(xdp_ring);
> > > -     ice_update_tx_ring_stats(xdp_ring, nb_pkts, total_bytes);
> > > +     /* Metadata packets may all have been dropped. */
> > > +     if (packets) {
> > > +             ice_set_rs_bit(xdp_ring);
> > > +             ice_xdp_ring_update_tail(xdp_ring);
> > > +             ice_update_tx_ring_stats(xdp_ring, packets, total_bytes);
> > > +     }
> > >
> > >       if (xsk_uses_need_wakeup(xsk_pool))
> > >               xsk_set_tx_need_wakeup(xsk_pool);
> > > @@ -939,12 +1372,7 @@ void ice_xsk_clean_xdp_ring(struct ice_tx_ring *xdp_ring)
> > >       while (ntc != ntu) {
> > >               struct ice_tx_buf *tx_buf = &xdp_ring->tx_buf[ntc];
> > >
> > > -             if (tx_buf->type == ICE_TX_BUF_XSK_TX) {
> > > -                     tx_buf->type = ICE_TX_BUF_EMPTY;
> > > -                     xsk_buff_free(tx_buf->xdp);
> > > -             } else {
> > > -                     xsk_frames++;
> > > -             }
> > > +             xsk_frames += ice_clean_xsk_buf(xdp_ring, tx_buf);
> > >
> > >               ntc++;
> > >               if (ntc >= xdp_ring->count)
> >
> > I think we could pull out core enablement for zc uso out of this patch
> > maybe?
> 
> What do you mean with "core" here? Core as in AF_XDP core, or
> preparatory stuff to the ice driver?

I meant xsk core as preceding patch and ice changes here would only play
in its own mud + make use of introduced api before. This would reduce size
of this patch.

