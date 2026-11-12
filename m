Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADEB606A894
	for <intel-wired-lan@archiver.kernel.org>; Thu, 12 Nov 2026 10:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=n+jlGhu1;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WnrFJacL;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=SmAPnStx
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C3024608A5;
	Thu, 12 Nov 2026 10:49:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P0LoVcX7fNzq; Thu, 12 Nov 2026 10:49:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0DEDD607F7
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794480550;
	b=D0zpv/BTJPXjjkmFQuIuYw/MYyrWqkgAZJGM8e/Fn7R6jx/KPh+Wgq/VnvJDWBD9W1Mr
	 qFfaSgUJn8ELt2lP60LltMigTAfBzJPTh+NXEsZxnA85PRthGhJ9MLebDlG4EuEtILk6Y
	 6X6C37uaRoiIc2naAS/MGzqdLAPjWxbhUDQLIMrljo8Y/wWks4m1J50NfKjLPcjeI8x1m
	 juzg6ToErzBEtT4N8xaiw4rqW3Rg+9TVJClDSxDOI/rHsh8QzAPheO2BsEwdeBIWzdz+s
	 woYz9kq6+ZlVwh6JLJJSMzFVTq29OteTlUs3OLqcizssw1kqANqhatb4UZYBUevv3gg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794480550;
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
	bh=s+8Bf1JdNsgC7Fofp9ENWj4TB60Ab8AFCKKRNM3h+FI=;
	b=gyM8qvoWDv9LDmxT7JNnYP/ILikZ3JQqzKYBvhlExy6PwiliKO0CvFZMvK/tjYiHZ0oC
	 su2eag+aZQ5iUeo55k0KGtGBEb/nC6MuHBG/lUR49KECwajBVr/yBJTlQlfoTIK37EQhX
	 959GxuNnrKSgo8jTuRd+92Xtwu+zd5oq1EbYi2BXE6kkmRkwURgLXXiii5s3pAf5hfgo4
	 F0jIatfjY/EpOzFKKYqawXwpY9vq40WTQc+otLjhEMXEb8QJkJs/9UUNN92HYMllhyDgS
	 HqGdHXa92WJw6lrqs4soKcvdUL8OI25J8Ft4nwvqusuHdzFbsEBISIYPxW5JO4nXyRQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794480550;
	bh=s+8Bf1JdNsgC7Fofp9ENWj4TB60Ab8AFCKKRNM3h+FI=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n+jlGhu1/oiV+lSDHPrrDZgX0tA39Xd9YF2/mrpSekR1t9AiSu5cYqRFKLPfrpw3C
	 47g/D33xJgAXgPxHIZJN78fSmy7jF25L6K8q9RTR+J3g/sDsS42xwfCYzLaUgVjA1A
	 hhMmXQ1qjklLniOSxF8q5m0btogZTXzH7WublxHfpnyA9RQmIhrFL03Bp311z4y/3B
	 rqV52yL0uiqynUpT8w+W5F9bYBMz/olDfkAosAzFGwaZ6nqCXgNAo4EqYYGEgGZ8Wn
	 WRb7AoxajItKTvAiiF3mH1AZ/pnugp23b1HKiVXexfwSObHcJtBjCz2B42qep1zPI5
	 jgL5r1xh+KoYg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0DEDD607F7;
	Thu, 12 Nov 2026 10:49:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B90CB156
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Nov 2026 10:49:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B5ED840086
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Nov 2026 10:49:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5lN1Kfs9cJkx for <intel-wired-lan@lists.osuosl.org>;
 Thu, 12 Nov 2026 10:49:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9F2BB40042
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.13
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.13;
 helo=mgamail.intel.com; envelope-from=maciej.fijalkowski@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=WnrFJacL; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=SmAPnStx
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9F2BB40042
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Nov 2026 10:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794480547; x=1826016547;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=053o4YYfbrSYpYmdBG84htmS0qKHNdXZnpuRxHChw1w=;
 b=WnrFJacLTL+f0TLDgWcHbdsf3JRLkZthaeSoBjnhwaGzIW7mLugXAr43
 UGbqXiFgsUuhq85jcjGTzLHD5GIZt01KfV4u7z8F0rE9cIVVoSAyXww9s
 UgLbjaytLkGRWk4l3XfqLcss8Bq8mD0XabQf74vCM8+YnKNNGhuqnzd7b
 YfQFQc+ftmE4NJZJCKFp9Yy93ywR3bkYGXwy/rpd6Qzgm0T6m5oOnvVpX
 IYqdK1kj7gcZfHep23JnSvLjAJBBEcu0EHCDHSDlG7QVPoJaSwuTnxKPk
 0cvzW/PUrP83SZTIFMbIaFgL6fkH9HWbsaD9yRYcdpONK4DEQtqwr9rrF A==;
X-CSE-ConnectionGUID: +7nGlSekTU+L5IWoeMutFA==
X-CSE-MsgGUID: OUFcSLfsSdyxR9qMXZISMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3146221"
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="3146221"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2026 02:49:05 -0800
X-CSE-ConnectionGUID: 7U39q39xSuqM2dQcNQRUqA==
X-CSE-MsgGUID: +cl2c3B1SkuTichbRtrqDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="8555560"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2026 02:49:04 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 12 Nov 2026 02:49:03 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 12 Nov 2026 02:49:03 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.39) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 12 Nov 2026 02:49:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+8Bf1JdNsgC7Fofp9ENWj4TB60Ab8AFCKKRNM3h+FI=;
 b=SmAPnStxDh3gCHCAFudOhMTxMnZbptWbI7gjQnzMTr1TT884XI35ZWr8WEbpcyXIrRdiRQ2r4dsuQGpe8GJ1gW0JkuBwz3FpOlcTI/NjbtTyaDlb1+MdhpRzN+efIJK+gMCFYZxZXK1wHVzWQg02S7P2pKIMxfrSSXG12kr1jbk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13) by LVUPR11MB9835.namprd11.prod.outlook.com
 (2603:10b6:408:39d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 10:49:01 +0000
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de]) by LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de%4]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 10:49:01 +0000
Date: Thu, 12 Nov 2026 11:48:48 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Marcin Knap <Marcin.Knap@vecima.com>
CC: Jakub Kicinski <kuba@kernel.org>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Magnus
 Karlsson" <magnus.karlsson@intel.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, "jtollet@cisco.com"
 <jtollet@cisco.com>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>, Jason Xing
 <kerneljasonxing@gmail.com>, Nitin Shetty J <nshettyj@marvell.com>, "Joshua
 Washington" <joshwash@google.com>, Harshitha Ramamurthy
 <hramamurthy@google.com>, Sunil Goutham <sgoutham@marvell.com>, "Geetha
 sowjanya" <gakula@marvell.com>, Ratheesh Kannoth <rkannoth@marvell.com>,
 Subbaraya Sundeep <sbhatta@marvell.com>, Bharat Bhushan
 <bbhushan2@marvell.com>
Subject: Re: [PATCH net v4] xsk: Do not free ZC Rx buffer when the Rx ring is
 full
Message-ID: <avWZkOvpKXVzpALX@boxer>
References: <20261109-xsk-zc-rx-double-free-v4-1-24e00ac221a0@vecima.com>
 <20261111173715.75bccc04@kernel.org>
 <DS4PPFFD8A841C21E59BFBD0D40DF2C5EA380702@DS4PPFFD8A841C2.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS4PPFFD8A841C21E59BFBD0D40DF2C5EA380702@DS4PPFFD8A841C2.namprd18.prod.outlook.com>
X-ClientProxiedBy: VI6PEPF0000022A.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8e6) To LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR11MB868673:EE_|LVUPR11MB9835:EE_
X-MS-Office365-Filtering-Correlation-Id: d220307f-89ce-43cd-4dce-08df40aa8ff5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|23010399003|22082099003|261009223027099003|18002099003|261022105027099003|261028144727099003|261026121527099003|261026140227099003|56012099006|10067099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: iq9T7Pu7Xp9j96CT4lDnPEXSxd3+2iXtAeFOpnxE+OtBiKHijubTpg909EnIvBhUx5QHpIbedtFhLdNYauXfYjXWq1OKyE4qUYeblmwQFGwbtFLRaQuVXs673nnC9uaypJGZ84oaSI149lJ3STgC4DYL0tJvC1Z7PivCa6/K4a9B730Ckv70m5VdMG6L1IpEjaW3g7CYPKAD44GWOxLUnHd+EDsp/oRAGrn1Nfd/MdJ6StpEA4xLdKbSKDMQRDpk+56X7wieHfDpsiKHILid08zjwp86ZFTULwwi7aaAoMbI9aVSMf1mcG358sqQUvH3kiygJmcHMkF0VbUexlOE16LHfTUmeU5QXA499tKOrJq88nNj+zfH1QOvpEbUy5lu+vWimjIQGo7qUeOtVAL0p5SkJ7lzn3N2dlPaFaanDdVV8F2S4lBX6QYUw2XjNC71SO00ef3mlmqF2qEWjzzwKgD0Ihc81aOPc780p+4U4LD2MH9ncfOgja9W35z/7G4+vj48TjXZF+uVJuh7xYrnJ+X7uxm78/Py4bHpTwqVr+zpc6u6doHwCXOiqIOBjHWX5uimwRAI61i1BTJsUXaHTflCMh7no7qJBChbDoJUUZmXDw5ZGsFsXHB7rE21DzH++l3BQD8th93pYEJsL3nEjqGhjtjlorpCtFjTh29kC1Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR11MB868673.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(22082099003)(261009223027099003)(18002099003)(261022105027099003)(261028144727099003)(261026121527099003)(261026140227099003)(56012099006)(10067099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?be7V/tj5MqRP7HjK/U2H0ua4CV4rPwkkmlRVG8dsQNV0zsbDSKHeEP35Kpl0?=
 =?us-ascii?Q?oKkUymUePmJhrzhFQQuZcfeB/HVIpjRv/rAZ1Bv8iOR7X8jwnGQeuHlWSkLJ?=
 =?us-ascii?Q?stl4YMaZPYejt5wPtfh/3bjyyF134ti2DoZ5wjLhcD8NOs+SfERliFXkk0+S?=
 =?us-ascii?Q?caf0P+URX04xuz9f0WWBpME/0contOaJ5JZFmlTWmqVt9RjvxUSuULX7CmLQ?=
 =?us-ascii?Q?GOXdV2/EXR6b6TUvE+CeKTdos/XJz9Y1lpgfhOooq/mr09k1gHpu/oLWdpuh?=
 =?us-ascii?Q?H6xzWCOm+eBYji7+ZR0x3BCZeK7e7pYsnTkP/uAwjOn3Pw6opCGeNK4SI7Ql?=
 =?us-ascii?Q?XM1EZrFJe7WkwIEwsA4/XsvwQSh1VxmpZMoPPUQsN4LFpK0/HESmjvylOpeT?=
 =?us-ascii?Q?JPv1f8X6xMBv5vG74vSFDHELGPJZRG+XPKBonCuaf5YYTVishdu+gL9FFNbJ?=
 =?us-ascii?Q?1Xw6WARVJz+PCbsUuyiePnpUd7weNA1h3zG7UqpXvJvlVk4D+Wy0MYoTQv6B?=
 =?us-ascii?Q?t0WWvhyZkfy1ZNMZ89x4rDHODtKa+WzH2Lyz7iKqVR6kE74rTolngc0Ot64X?=
 =?us-ascii?Q?OVXok3YjtSt/ei0oHMRYoMkMIXMXeqMZHfTqpAwfzGDAceHMmHDK1vwmPLud?=
 =?us-ascii?Q?somuhKnyIMe+milwkNHTiZuMmRyc/jNALXCXpHXLDRdgA2YYJsDX9I+v9p2S?=
 =?us-ascii?Q?qNWNYXdZUENmaCII4m5kIiWHxaEGsj+QojEQ3b/qHLo6gvY2/1ucQfJULydF?=
 =?us-ascii?Q?HbSIS7T9RSImVMtAUuCTVDzxTLrtfZOKQL7SxgSfdHMkFMPi59tnV+hKm7EN?=
 =?us-ascii?Q?N8uaGbP9Yub6Udxd6KDfzSs7NXYoJ1a/yh7TNBgjU15T67SNbINOzW5MMLrO?=
 =?us-ascii?Q?YWyY1555vtUB/w3R8fpZp4zX2jLb9hotJOiohJ6jIRExVD43NoyydYdn5UB2?=
 =?us-ascii?Q?XQdxAl6tyZh84MYj1Y+AnMDwlhDWTBep9/UZbfyPqUlWPfdK73+8V7/zIPDm?=
 =?us-ascii?Q?VxmD6P/Wdd1zwIiWFYXMlnusXrLVbrZM3lJH1Rpe9lOuy583bhvpsI1TT+4C?=
 =?us-ascii?Q?ujLDNfNj6QGFk6256S9lQFphc2kZKTYTHLs2b+fJxXjevCWJAj2F3qZCbTfl?=
 =?us-ascii?Q?ih6/wTU2eyKzhi6D7xobDAEyaiag0KlW5IGcpbhG4lF81fLNI/pY9pUIN3Zd?=
 =?us-ascii?Q?oWGQpoSQCm5g7okGcWCQlRBs60x7RnSbLUzDdixFJLuwrrJWeb2QGETOb1R1?=
 =?us-ascii?Q?nIKRW6zGWtE408fcaqE1OaT6tTBASrHW7LU6XnFspyMcGtbLcwGrMEpNCQV5?=
 =?us-ascii?Q?UzjKEfMd2cW8fGM04whZBn+sXX7uWrmye5jS3zSAGIHp44PPmD3NMhPol6qE?=
 =?us-ascii?Q?1L149y7YCXa72NB3JlZoFBYM6EPbk2uJ4HMmY2STBpKvlTMVkuS1lqepCqQp?=
 =?us-ascii?Q?/LLF2VP68DIFQbpu6BvuM3hXFbm2YpBJ8Iszx/InpAiFP1W1HDlFIoZLxWPN?=
 =?us-ascii?Q?+BW3iWwrkr4VRWgo53zQIzXcBFYZEtQVutGDnQrd7YOXjPpAetangwUj4LfR?=
 =?us-ascii?Q?L4q8ep4fSIsArW5gTgU3u0tIP2Gn4/crb6Cl61s7rIOhG2YXBRPGnmrI1c49?=
 =?us-ascii?Q?+QDIySdA2NwJ4nKhfnIUOan+Bm9IprLY0SU5dgff1evqG7DgiXRIzoZyFxfg?=
 =?us-ascii?Q?4TDhGxhCcVa1Tidpy0LDrpr/6pEtqoj+gtAoauSKDchQInSJB3Gxq50O2+si?=
 =?us-ascii?Q?fBiXwKIIlsI71LFOpdnf0+vGdAa0kbw=3D?=
X-Exchange-RoutingPolicyChecked: 3K2lDuKRJqKtKT0YRfVaJfwjoUbb61r/25e3xntHz9GUBF4ak6W+Yb8CtP+mjQi8ITzalkrW7+saW0REp8WdEovc7nBbudehzFi/Tgz65HEjfFsY2ERN33hxkZ8xodDyzHpBTi5q8qIp/TdRKkYffLvVgSZctPPeRIusfBcc/msCTeyq5DAmLvslztT5eZzwGbJBjIRvjO/LajrhBxc1NH4xcTEngb8g26EXUDjHLCpcEH4KJjk/uyov741Y4J75/ib9pihuT1NNMMjeetXdxgQqjjx3MntYRTrm/gAztpm8Js1QXCSekGf27OilNiLtXgemDSPBKWAZzCDBuTLs2Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: d220307f-89ce-43cd-4dce-08df40aa8ff5
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB868673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 10:49:01.4534 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LuQw/HKPG8s3j+sEcSpjyup6HUTLCyF1gBFtN7cgkbXuctGbC+PzT5QXQlEMhNWx2GgZ3eLUT1zgNZdPvdXxeIKuzA8tw64KDu8yhOlNa6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR11MB9835
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 12, 2026 at 07:58:51AM +0000, Marcin Knap wrote:
> >But what's the plan for fixing those redirect targets?
> >I think it'd be much better if we had one series which
> >addresses all the cases, which AI can review...
> >If there's consensus that xdp_convert_zc_to_xdp_frame()
> >can be trivially handled later let's document that (and
> >how) in the commit message?
> 
> Thanks for the review. I looked at the devmap/cpumap/ifindex path. The
> fix I have in mind is local to xdp_do_redirect(): for zero-copy buffers,
> copy into the new frame without freeing the ZC buffer, free the ZC
> buffer only once __xdp_do_redirect_frame() has succeeded, and free the
> copied frame on failure. That gives the same rule as the XSKMAP path
> after this patch (on error the caller still owns the buffer) and also
> fixes the leak of the copied page. xdp_convert_zc_to_xdp_frame() would
> stay as it is, since its XDP_TX users (e.g. mlx5) rely on it freeing
> the buffer.

Hmm. So it seems like currently, when we managed to properly copy from zc
the 'normal' page and redirect failed, we would interpret this as (based
on ice implementation, not sure about other zc drivers) ICE_XDP_CONSUMED
which would do another xsk_buff_free() which would be a no-op on this
xdp_buff at this point but 'normal' page would indeed leak?

> 
> I'm away from Monday for about a month and won't be able to drive that
> change and its review properly before then, so I'd rather keep this
> series to the XSKMAP fix and document the plan in the commit message,
> as you suggested. v5 will have that. I'm happy to pick up the redirect
> fix when I'm back, unless someone wants to take it earlier.
> 
> Regards,
> Marcin Knap
