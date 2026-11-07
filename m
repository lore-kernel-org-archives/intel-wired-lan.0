Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBDB606D80F
	for <intel-wired-lan@archiver.kernel.org>; Sat,  7 Nov 2026 16:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=BgizzkVn;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=c5Slh2FX
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9AFFA80F6A;
	Sat,  7 Nov 2026 16:38:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RQuIsp_YA4IZ; Sat,  7 Nov 2026 16:38:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8B4F980F55
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794069497;
	b=ljRV6OQxW43udsRcgIPK4SEMFbk0W3PHaokim5DYPo0XAZeb7Z9RgvBwtyxG7szGBkMl
	 4ybWaSWBnNX0sHFpkuPsDkmHrrx3m+umGAu+Iz7RuRDgNAGCrCdrB2+xvFN2hQxS7zrny
	 JMw7qk+wvgFHZCTHKENh9a/a2GJRW2igATKMqe++c3xwWtIN69ZjGDDzGysLKxtBuRVtS
	 3d7yAJmvb63PF9KBJ3nNRY6Yy34neCWHf6pYvwB2rTarlW4Q5OdEW43opS1b4wqBDRxRp
	 6eoUz73e97gKD4iZroze4Mld3gznTw5HCUi0LJmliyEZbo0qCSaZ27Zbu4BUewl95BQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794069497;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:Received:Received:
	 Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
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
	bh=rs21bQ8ex/2rPG0c+fRHtc0b7xzkYOE3iHllPbnC1HQ=;
	b=XkqKgX+iEbBHfrKVUTnYKk8RKI09yh2lxjaCcvmH9j/++oGFVdk2RBEb4QIGq4KRfoTM
	 QqRe+LoPHT12RunBN56K/CApGrLF5Hf0vCa04FJAyC01EdyKTEH8ZT9OOXHw5Agb8R/I8
	 0XXejDH4D0w3JbWEGzI7S5St9jT1bxacRgHOXQoDe/it0tYfCYbHCb97+qsnjT6n7CLUB
	 +jmL1t8us1Cllv9O15nLC506cq1rQ8DxQ/aCVEaYxsvr8yOGqDWs4eIIrRvaK8w8Pw/gq
	 fXqqzkn6g8HN2phkLqbw+ui6XgE8k28+dIe7OmUGbmv1m/t+LMlzXX7wj/ChPO6wuew==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794069497;
	bh=rs21bQ8ex/2rPG0c+fRHtc0b7xzkYOE3iHllPbnC1HQ=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BgizzkVnnPGJJmFUbfWDWG9p0yx6viUYYmFuicASBkwMQHo12LNw1MzwJZZG+ccJb
	 uDnXZmifOc/XPkorRBnAhlXjfd8FsDHgGJ+4cSbnwlk3CIcjQPidW7UfeoPaqQKJmK
	 6zb0Jz3sURDUtc1xkY7k/TYOVcbrTsrXN3e2g/Vv4r59YBOjFbCx37hBKnelcM4BhS
	 mdr00uJ5kVDfouyU74ufkbTtCBlweGoAVtB6Dnn1Dt6Z7AEEiYEfF7tYe9L63uYQ8K
	 eJGVp2lqZ2N0WqXBzJLbLiKRL/REwcBEiXSBQKP/Qfyk0h8FUhHvbSW5f7wzGNgHtP
	 PMQap//UsWESw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8B4F980F55;
	Sat,  7 Nov 2026 16:38:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 50B5234D
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 16:38:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4219040718
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 16:38:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6lACoMou5Hak for <intel-wired-lan@lists.osuosl.org>;
 Sat,  7 Nov 2026 16:38:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9F6304070F
Authentication-Results: smtp4.osuosl.org;
 arc=fail smtp.remote-ip=192.198.163.14
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.14;
 helo=mgamail.intel.com; envelope-from=maciej.fijalkowski@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=c5Slh2FX
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9F6304070F
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 16:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794069495; x=1825605495;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=XkOq7N01Rc3q9SDAT/OwuIN8n+FkWO9UPm8uaNO/XFE=;
 b=c5Slh2FXfgqGmmZ6VUFM5XOdbXqamCuJ3By2wCLO9AhIF7s1RznafoB2
 dMBIbb95t8f8sRPZfvw7T1whYRfutKzn1dY12p35rJMT/PK6fy4SPdYgY
 Wr2NymTHLE/m5pn1eFDgf/wz0fp7S8mdvpumrCSVvG1fSQTMq458/Dr1m
 q3r+8HDDpwHEAKSzI9AI/iSev5X+9djFG0jNKhC1+1kXtTcKebYRQuKOA
 3dyYNyIKXVrQ4NgLoi4PpFNb3b9gX7/HS+Ex/gl0WoM61HTmTzkK5vO9i
 SmmBOT2lwyu5Jx5fL2ZVNXj0wbmpuFZ4gVcwpQ8Jd6wQuZBxAzQYk1xXL w==;
X-CSE-ConnectionGUID: ClJ1kl5nSuSGZD4sYo2+ww==
X-CSE-MsgGUID: JR0jM+GXSo6qu9KCPlnAMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11959"; a="2895632"
X-IronPort-AV: E=Sophos;i="6.27,200,1787036400"; 
   d="scan'208";a="2895632"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2026 08:38:13 -0800
X-CSE-ConnectionGUID: Pgd9DfMgT2qB7VT+aHySRg==
X-CSE-MsgGUID: k1xGsMnGRbKoFX2J+ra6AA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,200,1787036400"; 
   d="scan'208";a="7407108"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2026 08:38:13 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sat, 7 Nov 2026 08:38:12 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Sat, 7 Nov 2026 08:38:12 -0800
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.51) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sat, 7 Nov 2026 08:38:12 -0800
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13) by IA3PR11MB013943.namprd11.prod.outlook.com
 (2603:10b6:208:548::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Sat, 7 Nov
 2026 16:38:08 +0000
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de]) by LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de%4]) with mapi id 15.21.0592.010; Sat, 7 Nov 2026
 16:38:08 +0000
Date: Sat, 7 Nov 2026 17:37:53 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: <tkusters@aweta.nl>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 "Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Sven
 Auhagen <sven.auhagen@voleatech.de>, Richard Cochran
 <richardcochran@gmail.com>, "Kurt Kanzenbach" <kurt@linutronix.de>, Sriram
 Yagnaraman <sriram.yagnaraman@ericsson.com>,
 <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>, Paul Moses
 <p@1g4.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH net v5 3/4] igb: do not split AF_XDP zero-copy frames
 over several Rx buffers
Message-ID: <au9T4Y1rpxvuEuFv@boxer>
References: <20261104-igb-rx-ts-fix-v5-0-bf4b4367129a@aweta.nl>
 <20261104-igb-rx-ts-fix-v5-3-bf4b4367129a@aweta.nl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261104-igb-rx-ts-fix-v5-3-bf4b4367129a@aweta.nl>
X-ClientProxiedBy: TL2P290CA0015.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::18) To LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR11MB868673:EE_|IA3PR11MB013943:EE_
X-MS-Office365-Filtering-Correlation-Id: 023865bc-81b2-4ae3-96db-08df3ced8138
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|23010399003|18002099003|22082099003|5023799004|4143699003|11063799006|261028144727099003|56012099006|261102123227099003|261022075727099003|261021123027099003|261021121427099003|261022105027099003|261026121527099003|261026140227099003|261009223027099003|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: 9f1ep4R/LeI5dVGrxzoeezJcaUenb5pY7mxRrzLl57zCeoS2XuMw/N1Qth2clKySQp2MmUxGA1+txzRXap3aDBK55cMmwdwsK8CX2OEf5OQ5dpYMnO+e5BymkUhMQemAgCSh3J0lMtSb13rZzuj2d0NSZ+oXrHEz662tDxSgb6uEtd64hh9e55hlqYvvDw6lulPbm8GNzIHTlS+VVg7pL1OroM/M5FVTdN9KKrpAoKQ5Xups4jhJmoDXKknTC7WgXTLJMI572bdN6AM9DtFOKRzc1LKAC2yKWkOy9t82MmwVd7QoXOUGA+mNFYkPT3znsNy68sW1wR7KmRKPtIbCOXURJWuUGoW4BwDhlJ7ZHBwP3GsQ0PKphr//oOC6WtmmmnOyaQVtzUe9863JaTxRwK9Qw1e2Cjy/NyCGbCc/04WJpV/4iIyyhVvFvrB5qJCfL0ouL1ePDySF5VFmwsJ1YpbLX87xe5WVVsY1HqgzPOqO+I7ODEJ1GawqYmF72ZFc9cx0lqt99CvjL3E2utvXfpSvC9yOssGyBL3o8F2C6t/BJnGUO6DlGwLJC+qLqXBLmPqUb9OkAdGwP5Xj42g3aYUEM/bYH10eRgC6XGhLJJ8MLSq0HPacDk47NccgFWNf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR11MB868673.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(18002099003)(22082099003)(5023799004)(4143699003)(11063799006)(261028144727099003)(56012099006)(261102123227099003)(261022075727099003)(261021123027099003)(261021121427099003)(261022105027099003)(261026121527099003)(261026140227099003)(261009223027099003)(10067099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W21Q1znbkTDSW35W+1kpYb93BE+B6Az0bsnnFa+V6GzRGPVE6L164WD3ND/T?=
 =?us-ascii?Q?pxIkvO/ebcwbdB17ZPNBUtpUIkw/iMCzBEBFJcXAuSvLBtMtggQV/9MotbNi?=
 =?us-ascii?Q?OIDz1gjJSHAHUCbfP0CI+5GFFVmXnVujHlC/SoY4/1eAMrD56bHBObM6tlho?=
 =?us-ascii?Q?syucSR+GeX5VXu6Scja1gGtOhwxq/ngUCSIqUfBhPmGgOZJFounbGqC36Z9W?=
 =?us-ascii?Q?Y/MhftcXFbqbCcsL5WsioKzlAvMu4Y7fSxB2PbyqAdndL9bwIiUvjhbTRmOd?=
 =?us-ascii?Q?Ty0ejA08Pi3aHu7uVgNvBlZUd9+hFMIgapDGE4wXrHw3JPC2TaADQob5XFZR?=
 =?us-ascii?Q?Op3z/toM6GEjwVgO1R+mVns2l91Myt1nP837uWjY1ELhKUajnbZkZTCphOta?=
 =?us-ascii?Q?li7/E1JHGT8cJGWu0xsems2BUMteuzRxBTyqN2xQByZZc7gN6Dg9f1fJIBbQ?=
 =?us-ascii?Q?LeU7fK9YJ0ctb+mRJZ3h4rfMQD7qy4OycO1b0JOOtwcGg4uhoisAbsKnpxAG?=
 =?us-ascii?Q?CJf1zfJSxBlDhBk9iC4hP6V412S4/I2SXxl/TeQ9+On98uDbieX6BKxmnTEq?=
 =?us-ascii?Q?ngVFG03mIxO9hAmhoZPtolCMe8hplJ9aIDIYZ28PlCQ2Sp3noYAUj0Jyn3kW?=
 =?us-ascii?Q?PsLB0EI0tnHniHTkYTZ0B1xbaPwA+Sk5z+MXua04bjHYrkhbxMXNO+3U3hmI?=
 =?us-ascii?Q?KzS6JydYIILVJZ4CrsuzeXKNXdyrHrQBtVwkMjkXgPFjkrayGwsy9XCm++FH?=
 =?us-ascii?Q?xlrd7XhE9emuMtapGPf4OA1BF+tLtICIqOVwzIwRJKOuAFpmvmNuKIWAm4gO?=
 =?us-ascii?Q?vQNErHI+LK/9zayS4kafvpIFz2pv55nMaTX5SOGgd30PXT/A/QaiyJ5Eanlq?=
 =?us-ascii?Q?3Yu/OmBcK6X1BateHzVP60ZR4MBCvVlVoPEt2kahr9UUI/my7f5T/t1DOr18?=
 =?us-ascii?Q?22LS2solKL6Ad+fhBCiq8y5XAy38WOqmD5hdeFQ1M0vRSYEl2A/z+zCDGfni?=
 =?us-ascii?Q?bnXhwCrSPJa+CAywJAfe2bna52W8C+6pb08H2YPX/+iPI1jpnkl6C1OJ/5Zw?=
 =?us-ascii?Q?SMmsprVGPb/LqyRPYNdbEFU4NHc4r43wsg0hTduvmf6bOgTV+zefyIO1Yinp?=
 =?us-ascii?Q?9ViPXeU0j0NLTfmGcyzmSy0rdGjED8LL6rmT+GgLk5JzVeypkIc+pWbrTT/Q?=
 =?us-ascii?Q?AKxvmdkeLP16A8YkiUhQQlqHbD1qY/OCeJ9UUojwlRkHS5YqLOvRxhwb2gBr?=
 =?us-ascii?Q?nat3jxcfwNMDzIUymPVf0t1Ky7Pr4KxnGvG3fzqSELy0pjE6rxDwl5AyS0De?=
 =?us-ascii?Q?KYNU1ckRcZuOeO9w94qiNXRuhwCw15uzLn4jlmu15K6Ehci42Qns9MEBnD85?=
 =?us-ascii?Q?jusLi/WzRtFi2QkD4NMn20dLakqVR1D2gwl273rWiypmkN7VnMUjOiiy54+J?=
 =?us-ascii?Q?svOoOMUalqaDODHajJS2WiGYNbO86CQBX+fGJeDSA8OTD9EFp5yLxTeSjF1/?=
 =?us-ascii?Q?xEABXOP+iPFFcXovPK5FHPnEsd1MAiJ8LYIt3ZIKttS0uS2GnjxeHy23zz5s?=
 =?us-ascii?Q?GtkLEAbqyIlBhQwayaw4D2a+yZuEiRlFn/QsFhM9W4a2LZn271v5U1upb+ID?=
 =?us-ascii?Q?t18UMGReoq+BEFPYFJEYIAzeujcTCs+MzUyjWfp/FCSOG5//SN8OZ4mrmFvp?=
 =?us-ascii?Q?eMMfzQiy7IpisfLq7s9c2vxNU5N8eWTmoJDc+iw9J1WOcaTcpI6CAL7dE9Hz?=
 =?us-ascii?Q?ZlgqRW6TEMLiaBKojIE/tjzS6YQFOqM=3D?=
X-Exchange-RoutingPolicyChecked: Q63dPaD5mTur1JB8xX59NQIJ2tsPDuYORHLbw8ttMFyijDCTFQqSBufZ0oh1zSuR2sBu/FzICEW1uvAEIr4jXZOrmETWvI85eQakEwBREHRKOUtkOsop974n9VR7SjRq7rfWbtH7rW5sg6oFy1FPXYkiuGEBjd39dSrUBTrWrMnuguioEZMrZl/kKwN3G80+G2Pgb2PGDuQVY9u78l+lVafGUvkXVPZZmPlIyasaXW3BbIAXY9DfkS0lote/8WhwLGiWIgWPuydZLzx5aOKGdioopP6CyTMEDRK7DV9i4pVT3y5DDC1SoueSaVtVvYtWHdF56abPgIoKThNqcslCQw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 023865bc-81b2-4ae3-96db-08df3ced8138
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB868673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2026 16:38:08.3992 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AfWDumybyXqXJbG7zYLBx1T82x8DSDZK/h4oOEJWfgdjvefwAebKJAE+F3iA1omw0PBQUoBdo3/lmSVZHZqWQckA39S7KZKbFWWbRJWcEEw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB013943
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

On Wed, Nov 04, 2026 at 07:40:04AM +0100, Tjerk Kusters via B4 Relay wrote:
> From: Tjerk Kusters <tkusters@aweta.nl>
> 
> SRRCTL.BSIZEPKT has a granularity of 1 KiB. For AF_XDP zero-copy rings,
> igb_setup_srrctl() programs xsk_pool_get_rx_frame_size(), which is
> rounded down. With 2 KiB UMEM chunks and the default headroom this is
> 1792 bytes, so the hardware buffer becomes 1 KiB and a full-size frame
> spans two Rx buffers. igb_clean_rx_irq_zc() handles every descriptor as
> a complete frame, so the AF_XDP socket gets such a frame as two
> packets, the second one without headers. With Rx timestamping enabled,
> the timestamp header is also stripped from the second buffer, and a
> short final buffer makes the size wrap.
> 
> Program the same buffer size as for the other rings, 2 KiB or 3 KiB.
> This depends on "igb: do not let XDP frames span more than one Rx
> buffer": the receive length limit set there while XDP is attached keeps
> the hardware from writing more than the frame plus the timestamp header
> into the larger buffer. Without it, the hardware can write past the XSK
> frame.
> 
> Refuse an XSK pool whose frame size cannot hold that, and an MTU change
> that would no longer fit a bound pool, also while no XDP program is
> attached. The current MTU is checked rather than the largest XDP MTU,
> as igb allows XDP up to MTU 3030 and that would rule out 2 KiB chunks.
> A pool that still does not fit when the ring is configured, for example
> because its queue was hidden by SR-IOV during an MTU change, is not used
> in zero-copy mode, see igb_xsk_pool(); its Tx then fails with EINVAL
> until the pool is bound again.

I would rather return -EBUSY when enabling VFs on queues with active
xsk_pool. Seems igb sort of steal queues from PF?

We do this in core when xsk_pool enabled queue would get wiped out via
ethtool -L shrinking the queue count.

> 
> This is the igb counterpart of the igc XSK buffer change.
> 
> Tested on an I350 with xdpsock from bpf-examples in rxdrop zero-copy
> mode on one queue, Rx timestamping on and 1514-byte frames from the
> peer. With 2 KiB chunks, the receive descriptors went from about two
> per frame to one per frame; 98-byte frames and 4 KiB chunks were one
> per frame with and without this patch. At MTU 3000, 4 KiB chunks
> receive 3014-byte frames in one buffer. A 2 KiB chunk pool at MTU 3000
> was refused by the new check on the 6.14.9 test kernel; current kernels
> already refuse it in xp_assign_dev(). There, with 2 KiB chunks and the
> default headroom, the new check refuses MTU 1751 to 1766, which the core
> accepts.
> 
> Link: https://lore.kernel.org/all/20261028083344.3047350-3-p@1g4.org/
> Fixes: 2c6196013f84 ("igb: Add AF_XDP zero-copy Rx support")
> Cc: stable@vger.kernel.org
> Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Tjerk Kusters <tkusters@aweta.nl>
> ---
>  drivers/net/ethernet/intel/igb/igb.h      |  9 +++++++++
>  drivers/net/ethernet/intel/igb/igb_main.c | 28 +++++++++++++++++++++++++---
>  drivers/net/ethernet/intel/igb/igb_xsk.c  | 19 ++++++++++++++++++-
>  3 files changed, 52 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
> index 0fff1df81b7b..0495c02544d6 100644
> --- a/drivers/net/ethernet/intel/igb/igb.h
> +++ b/drivers/net/ethernet/intel/igb/igb.h
> @@ -856,6 +856,15 @@ int igb_add_mac_steering_filter(struct igb_adapter *adapter,
>  int igb_del_mac_steering_filter(struct igb_adapter *adapter,
>  				const u8 *addr, u8 queue, u8 flags);
>  
> +/* XDP does not support frames that span more than one Rx buffer, so a
> + * frame plus the inline Rx timestamp header must fit in one XSK buffer.
> + */
> +static inline bool igb_xsk_frame_fits(struct xsk_buff_pool *pool,
> +				      int max_frame)
> +{
> +	return max_frame + IGB_TS_HDR_LEN <= xsk_pool_get_rx_frame_size(pool);
> +}
> +
>  struct xsk_buff_pool *igb_xsk_pool(struct igb_adapter *adapter,
>  				   struct igb_ring *ring);
>  int igb_xsk_pool_setup(struct igb_adapter *adapter,
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index cf9911137bd3..b286adedad5d 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -4833,9 +4833,13 @@ void igb_setup_srrctl(struct igb_adapter *adapter, struct igb_ring *ring)
>  	u32 srrctl = 0;
>  	u32 buf_size;
>  
> -	if (ring->xsk_pool)
> -		buf_size = xsk_pool_get_rx_frame_size(ring->xsk_pool);
> -	else if (ring_uses_large_buffer(ring))
> +	/* SRRCTL.BSIZEPKT has a 1 KiB granularity, so programming the XSK
> +	 * frame size would round it down and split frames over several
> +	 * buffers. XSK rings use the same buffer size as the other rings.
> +	 * While XDP is attached, the receive length limit keeps frames
> +	 * within the XSK frame, see igb_xsk_frame_fits().
> +	 */
> +	if (ring_uses_large_buffer(ring))
>  		buf_size = IGB_RXBUFFER_3072;
>  	else
>  		buf_size = IGB_RXBUFFER_2048;
> @@ -6775,6 +6779,7 @@ static int igb_change_mtu(struct net_device *netdev, int new_mtu)
>  {
>  	struct igb_adapter *adapter = netdev_priv(netdev);
>  	int max_frame = new_mtu + IGB_ETH_PKT_HDR_PAD;
> +	int i;
>  
>  	if (igb_xdp_is_enabled(adapter) &&
>  	    !igb_xdp_frame_fits(adapter, max_frame)) {
> @@ -6788,6 +6793,23 @@ static int igb_change_mtu(struct net_device *netdev, int new_mtu)
>  	if (max_frame < (ETH_FRAME_LEN + ETH_FCS_LEN))
>  		max_frame = ETH_FRAME_LEN + ETH_FCS_LEN;
>  
> +	/* the frame must fit the buffers of a bound XSK pool, also while no
> +	 * XDP program is attached, as attaching one does not check it again
> +	 */
> +	for (i = 0; i < adapter->num_rx_queues; i++) {
> +		struct xsk_buff_pool *pool = xsk_get_pool_from_qid(netdev, i);
> +
> +		if (!pool || !pool->dev)
> +			continue;
> +
> +		if (!igb_xsk_frame_fits(pool, max_frame)) {
> +			netdev_warn(adapter->netdev,
> +				    "Requested MTU size is not supported with AF_XDP. Frame size is %d\n",
> +				    max_frame);
> +			return -EINVAL;
> +		}
> +	}
> +
>  	while (test_and_set_bit(__IGB_RESETTING, &adapter->state))
>  		usleep_range(1000, 2000);
>  
> diff --git a/drivers/net/ethernet/intel/igb/igb_xsk.c b/drivers/net/ethernet/intel/igb/igb_xsk.c
> index ce4a7b58cad2..fb04df82272a 100644
> --- a/drivers/net/ethernet/intel/igb/igb_xsk.c
> +++ b/drivers/net/ethernet/intel/igb/igb_xsk.c
> @@ -91,7 +91,20 @@ struct xsk_buff_pool *igb_xsk_pool(struct igb_adapter *adapter,
>  	if (!igb_xdp_is_enabled(adapter))
>  		return NULL;
>  
> -	return (pool && pool->dev) ? pool : NULL;
> +	if (!pool || !pool->dev)
> +		return NULL;
> +
> +	/* the MTU check in igb_change_mtu() does not see a pool on a queue
> +	 * that was hidden at the time, for example by SR-IOV
> +	 */
> +	if (!igb_xsk_frame_fits(pool, adapter->max_frame_size)) {
> +		netdev_warn_once(adapter->netdev,
> +				 "XSK frame size is too small for the MTU, queue %d is not used in zero-copy mode\n",
> +				 qid);
> +		return NULL;
> +	}
> +
> +	return pool;
>  }
>  
>  static int igb_xsk_pool_enable(struct igb_adapter *adapter,
> @@ -110,6 +123,10 @@ static int igb_xsk_pool_enable(struct igb_adapter *adapter,
>  	    qid >= netdev->real_num_tx_queues)
>  		return -EINVAL;
>  
> +	/* igb_change_mtu() keeps this true while the pool is bound */
> +	if (!igb_xsk_frame_fits(pool, adapter->max_frame_size))
> +		return -EOPNOTSUPP;
> +
>  	err = xsk_pool_dma_map(pool, &adapter->pdev->dev, IGB_RX_DMA_ATTR);
>  	if (err)
>  		return err;
> 
> -- 
> 2.27.0
> 
> 
