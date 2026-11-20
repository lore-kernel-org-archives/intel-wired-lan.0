Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CB660A262B
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Nov 2026 12:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=Ey9uXeGF;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=P3Ng8mYr;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=U+NGRzLI
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 599EE60750;
	Fri, 20 Nov 2026 12:00:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r654tttltG7E; Fri, 20 Nov 2026 12:00:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AAC096076D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795176023;
	b=h4RN8C4uS1Ob+GbTAvUf0l9hrJ5Ipftf88NX4U9N+X63uK4TXM0YOnMWIX8ryk/84EAb
	 hGtleWh7EmFykN3SpQC9XV8a1VbcnzfE5uBqF5s8eq3+KU21iS1TQEfRPdVpvLN6pJ4Aj
	 kA0FbeDbw+aWQUbaJSYOLr1mhEKwwXrva1z0hK9UX3oeBJcB70tiZW13W0xhfeggNsNRE
	 EoOUNixn8luEdcUUGO9+TsGHfXY3XvREFogUwzLpbHJLWfSNz5L/DYEoq4LF4EYQJtlNU
	 OgJxy7D0NuEfFIdekOfXCkgasNLLPz5T+IAoVasWpxCECvLCiQ7+wPfq2wvZ74O3Qng==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795176023;
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
	bh=W+Tcs4p32MimWLsPr4OwINRR0jBvzTSdbypNpnigGQQ=;
	b=R3L0u6JT7NOfLqSxGn/SMEi/E39Vw2+P/dxyzfvZyAkYAZPmQhrEUO4U573KGUAmDN4o
	 U5W2NyaflJ+TnZEyDeQdpwhGGOd3Q66UGeNF/ybi0RJmshe4ZZrzLvtMmsMgDH6vQ6Kl1
	 B37ABG8gnTkoALmD4iQbVoEwwXFSUqGmMkByNtuOTh8kd3blsAlAsLht//s09j6/P84R9
	 tNN5zL1c853Zqmepbh4m+WP3p+gf4AEAknNMy2ITyHjso/N9h0HuKhd63Y3R0FOGTRvPi
	 ywF6HSDLayEsb9XZyzBzFPritOr591G6VEDd/+zq1JkRGzK0SHC0PQVClFX92fpihmg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795176023;
	bh=W+Tcs4p32MimWLsPr4OwINRR0jBvzTSdbypNpnigGQQ=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ey9uXeGFejge9f/5Y5nbaOo0UdoLtzeeQVCemi07BBNs9bvxaO4EZsRlZQGSlCK6o
	 jkruKnQqvZDap1Gxa+By8BgI3W8MvUPKmU20p12fMjTK2tMXNu1z2ebMYdJrIqYMOb
	 Z29s7AvMDuv0GGYvHa5oQXYkK4kXCk1+XcPqJvVkWSjrrPXW7Fqv73TfP6MlF2iPa9
	 BYzFmIdmLgwcBneY4k4zsd0be+P9OoYtL4FW3PjzjL0HcuuFz5BptlS6TPR+fwyx+O
	 ZkPuetVU6qsP3o6Lb0hfXflE2g0oq85huR1dAa5WTfBEq7yIIFJLNeVboxEh875hwk
	 e/wJgHJKWjEGQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AAC096076D;
	Fri, 20 Nov 2026 12:00:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3A896169
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 12:00:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2B46D40DD7
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 12:00:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id klklKCkY3u_F for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Nov 2026 12:00:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0462540DB2
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.14
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=maciej.fijalkowski@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=P3Ng8mYr; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=U+NGRzLI
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0462540DB2
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 12:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795176021; x=1826712021;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=TYt32pZbmqc8WYhpd0UP75k0CEPw0IYCjUIu7Rus5JI=;
 b=P3Ng8mYrUt4YdcSTZvdRvrBMbmOrAypfxobvIDAKjGlDComEZIsSCqbF
 kaxu24Xv8d1pVloXv5f+5AcneRwMaJvcn6mUTLUsukU0ls31lZQ03gryL
 YZ28Uv/Kero3NgUVtzjx5vA4j423CCZ+myLUXIzWRWsKg4bin1GzfnsFW
 yEadINluzqEsgiA4aFhzrCx6Y1iWZ2dpWJ7VnKOsmF01Ps/B12xR3kDi+
 ocau8Q7h+YrgNw+h4Z0jCPmXH4KN1843jw3CAaZe/Sa98YMGkb+LWf330
 omcP9et06TzmD5JBNyn2oaqtEnamAzupzH7jDhTagD+mhoM+k12TulPVe w==;
X-CSE-ConnectionGUID: xN3SUKJ5QGSTBAOOVVUvUw==
X-CSE-MsgGUID: U8ZMvh1HTP+bi4dxZi5g6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3943113"
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="3943113"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2026 03:59:48 -0800
X-CSE-ConnectionGUID: BJX15HbhQwmtHAF6OzX6bw==
X-CSE-MsgGUID: guw6wdWxQTyfJWosAuRfWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; d="scan'208";a="12676066"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2026 03:59:45 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 20 Nov 2026 03:59:43 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 20 Nov 2026 03:59:43 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.66) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 20 Nov 2026 03:59:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+Tcs4p32MimWLsPr4OwINRR0jBvzTSdbypNpnigGQQ=;
 b=U+NGRzLIDjZJ4UHd1M9lYLrTsP9/OEFPeYQYQ2nxFSN5I3dTk1vFTbmqnkQ8jdYreAOk/HS0CD/W7U0dfO+qrt9sxa4Ozk8tt8CGa12Y2DT0EeUbOn/OcGu65pNupmWBU1dhNpOVyyk6E3gyUqEw2PdZoSfkoaEDwbPEyXcQrLg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13) by IA4PR11MB663788.namprd11.prod.outlook.com
 (2603:10b6:207:13e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 11:59:40 +0000
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de]) by LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de%4]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 11:59:40 +0000
Date: Fri, 20 Nov 2026 12:59:18 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Magnus Karlsson <magnus.karlsson@intel.com>
CC: <netdev@vger.kernel.org>, <magnus.karlsson@gmail.com>, <sdf@fomichev.me>, 
 <davem@davemloft.net>, <edumazet@kernel.org>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <horms@kernel.org>, <bjorn@kernel.org>,
 <kerneljasonxing@gmail.com>, <intel-wired-lan@lists.osuosl.org>,
 <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
 <jacob.e.keller@intel.com>
Subject: Re: [PATCH net-next 2/5] ice: add Tx descriptor builders and header
 length check
Message-ID: <awA2FrMwDMaZ7Yzw@boxer>
References: <20261119165340.1071525-1-magnus.karlsson@intel.com>
 <20261119165340.1071525-3-magnus.karlsson@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119165340.1071525-3-magnus.karlsson@intel.com>
X-ClientProxiedBy: DUZPR01CA0015.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::18) To LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR11MB868673:EE_|IA4PR11MB663788:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f0df521-78f8-4981-f42a-08df46fdc227
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|23010399003|4143699003|11063799006|261009223027099003|261021121427099003|261102123227099003|56012099006|261026140227099003|261022075727099003|261022115727099003|261028144727099003|261022105027099003|261026121527099003|261021123027099003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: qRcBif9FJi0EG+AnyJ+ZUB6vmGPUo+91S8LqaD9rYQpSyMaUUShwoH2o/l5HWi5TSrLS0Aw1SSbr1Uls/K20ZVQftzTmdmuXBt2pxpCNDLc/MvDNtihj+Ouoxk7jPMY2eiPIz6Ysf6miR53p9W03Zb0ZAP5yWisXvxT67R7dCzEstshmDAdO7/nr1izYEb65j59DZO/dulnEz6GlyOz4eLBW+0m7foNurvZFWnfYAXXnfT64xrPShwGeXykBnMmr7Uie/k01D0Wy/xOONHorlopdOBt5CvMD6ggr5qjBCQN8kHSCt3wELfBDc8N8astI/EDIHGoxN+t54+tR4rofGXhJiWE5tsu8tXpn9e6jJt9FUSASehkwjVxy8RRE3fTxINZEz6hLnVnFAvYOh0wi95C+V7u3be9/1X/sY6opp3vjBcxQ6IJezK+Yj5OtkRFs082izHoO98c9KergD5ejU27KrYAJFKsnziTudxdD7TjPS19QMftluzt8AjF3+MLbeBYXb3QsX+fXGGZTu+abYfEPM+XtX8JIirVZyppNBwtDm8lk+2KE6nf11AM3J/joZIkhV/jVlbDmR+CtgRTXjlnmERUzr709MAXd5LM9eioEucqvwyPL1MCUuTbI4s+zk2NMMKXHrAIj3qZB13H1uoBz1z5N/JjrW3zv76KDSOM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR11MB868673.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(4143699003)(11063799006)(261009223027099003)(261021121427099003)(261102123227099003)(56012099006)(261026140227099003)(261022075727099003)(261022115727099003)(261028144727099003)(261022105027099003)(261026121527099003)(261021123027099003)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?97LzHVAtV3df1e3OOCXVw4n5GNehLaJEUh7N/Wz3htgNaU8E09OYDVnXHF37?=
 =?us-ascii?Q?iEZaIjADRSNr/D8fcDQfvBN5ztP3lgmzVr5sq9caBmmWsFBvc8xHdwAL/vF0?=
 =?us-ascii?Q?Hh748Co76xY9SlreOqyaJdTXTzZMjaoKftW7eUpuerad1O9X0gYfLZXMRhQV?=
 =?us-ascii?Q?hKsJ9/mJiU5EDlyLeS80vZQ7jvPQvcIBl4I8lt03/6A1bj5JdUKAA+gsICKj?=
 =?us-ascii?Q?ao7Qx1j60gHp5Ma1DhvweGyKU+Zt6lw2TRJTKts/En2R/dbafAlJu/OYfi74?=
 =?us-ascii?Q?HW7cU5e1pwdQGLB93uDfRL3apT7GK8RuOsR5hSNYQ26DdGsVdIyLhVjEmaNA?=
 =?us-ascii?Q?ZVzobWsh37AK8jFTJDshkYDg32gljN31naXXrZouPbg1c7QJ5XH1POBV+Rza?=
 =?us-ascii?Q?q8+CkNqoMvybAjLIfTeyi6zI8Xe19x/weJJ4fMtKXBSbZCo+xxVLmNHqXNyD?=
 =?us-ascii?Q?7KSuk/APOjsi6IsVVnuyDOSQzvmsil8Ro/48lH9iWQYdfq9k9AdAEhLjyONh?=
 =?us-ascii?Q?Sxu4Y5wgoC1MzsXPIIKwbZ9IQtBcugKXNBB7IQVWDVCRmoToE0DaQOwGWGGv?=
 =?us-ascii?Q?yginw2612MXlQJ/vsHjrFFpf+u1e70M26EA011oclm/r2KtqbWqPtZb6sxIz?=
 =?us-ascii?Q?vqX5H6QU70Z7FDGuhbY3Y3L2H8g7mT3u5btpO9QmKWGFply+VSMTL3KbYl0m?=
 =?us-ascii?Q?2WiKiu6MfVwEkkXI8vHCBNrpgDeZsokcXUx78WblCP1oHa0tolxfKJWixhmU?=
 =?us-ascii?Q?n2lodtK5lHaLqjNhqWrOWs3HJ99TYfrBc1hu8Dg8t02MbPsgWQu0hskTGqNv?=
 =?us-ascii?Q?bheV0uRT7+wGah0LnBTWSZfTjzwCerv4+5ZX7kPCFHRXBzpDdPuC3Ugs2lcz?=
 =?us-ascii?Q?kx3d+44R06xNzjfiU7bWCNDzJ44JudXofSGSzrIJprq/nULXgXi0zuNImR8J?=
 =?us-ascii?Q?DVEoaxGm6yfRjg0azYCpSkZMx7PJ0/V65eLeRDAvCcmO1i/6It9ENsusbAuR?=
 =?us-ascii?Q?Fbw++wfuAlAY8dfqMLoVfwMu0R/WxElf5JfOby6PCyO7Omd+L+1o/T7r4slA?=
 =?us-ascii?Q?Mlg5KLgckDrvMUK4f2qewlkMDjaDykTtRHbj6jicUe/WEC/RRpgEJMLmQtYg?=
 =?us-ascii?Q?fGfHzNBX37yFP30il/NHwVAVik5uux0yNy+n2PyYZ5ukeGP3ehJlKSpwn+D4?=
 =?us-ascii?Q?q1Pp2PVoBXBy+qpgc5gKTeL9Ij+5EjGpqPdhE/+LApcCpfvPipAbPxZn3o5O?=
 =?us-ascii?Q?fAWH/tuJqHEj3qP/FTyiurvoB2hqUVOUAHp2qQ3nvrjXqMGR/tZreJ++fPwi?=
 =?us-ascii?Q?iFxcpfFRullxsmF+ewpALEpqBEtrR+j9IEGTbVi8SxNl040yK4b0idJlWwYn?=
 =?us-ascii?Q?++djtJzMWw8NKsx1yxkmWT629yraMVuEQR98lID15cq7EMakpsOkYAqSeghF?=
 =?us-ascii?Q?vrIiUJspC6w35dKzAop4hxsEUJ97iNmFJPgMI4hA61//4u83uovXpx8RaEx3?=
 =?us-ascii?Q?M4q39QmpKeSJrqm4KGLgtcCDRneCdY80KshzPC+Je2NFHzjTOn4xrrv9FDsw?=
 =?us-ascii?Q?X47G7ZpOaT0Bj+xgF1plIOTpMfXwwXqT12Atyu1Y25wzluNrufg7B/er87VB?=
 =?us-ascii?Q?GRnC1Oh7pfwYENX39QpdG4uFMC0ZrLUs6hG8nxpWdLnl4xqUU53P0JnfnpXa?=
 =?us-ascii?Q?w3QiJjgYGfXyLJPPgLolb8PBbAnzprrVjFBd6/qatosf3bbngeSzQtvZmm6F?=
 =?us-ascii?Q?e+MVY9gSC5u9sy72n3e8VRoQ7I5Ir4c=3D?=
X-Exchange-RoutingPolicyChecked: YfYT+ruTRuThMJQZCbdAllxcsq4CoAcBXq58jd94Ea95YJHDBFnmxInTfAmDTjVXFkLr9+2dbIN/Hxz6GOH4cQBXEaZZ1el7dKbZeDBKKogGioxGew+qr7p5pzxhTRA/rJnMfmz/aN5MrBmhIy5MW3nQBSqlA/aCjoncIZeqUpoveSc9qPf+NcYufhY4IdAm78sCGSMA5wrvbqSeZlJBda/bD5qLS291c+SYiBHs9OQQy9ydOYMN5HiGmvBd7WbzXKIyCGrR+CDFyzw6MefNqtzeSfbpt++BMVwmtoZCIFx2cNNlqcltXCwFdVsT6RHZD6hOqrRwSERy4tuKXG2v2w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f0df521-78f8-4981-f42a-08df46fdc227
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB868673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 11:59:40.8746 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8xauQD+XkaIXo4sQblw5tDqDhB2CMaksdpiufhgfFW4BJC+D/Qm3B19yQ/G3zfwKACsLyhbsFRjRSLDIQ/Ikql84PMWT3AkF0W1V88ZzoC4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB663788
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

On Thu, Nov 19, 2026 at 05:53:37PM +0100, Magnus Karlsson wrote:
> Add ice_build_tx_desc_offset() and ice_build_tso_ctx_qw1() to
> ice_txrx_lib.h for the length fields of the Tx data descriptor and the
> TSO context descriptor, and use them in ice_tso() and ice_tx_csum().
> Add ice_tx_hdr_lens_ok() for the header length limits of the data
> descriptor, and use it in ice_features_check().
> 
> This prepares for AF_XDP USO in zero-copy mode, which builds the same
> descriptors from a copied packet header instead of an skb. The new
> check also requires IPLEN to be a multiple of 4 bytes, as the field is
> encoded in dwords, and so does the inner IPLEN check for encapsulated
> packets. The IPv4 and IPv6 header lengths that reach them always are.
> No functional change intended.
> 
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> ---
>  drivers/net/ethernet/intel/ice/ice_main.c     | 12 ++---
>  drivers/net/ethernet/intel/ice/ice_txrx.c     | 20 +++-----
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.h | 48 +++++++++++++++++++
>  3 files changed, 60 insertions(+), 20 deletions(-)
> 
> + */
> +static inline bool ice_tx_hdr_lens_ok(u32 mac_len, u32 ip_len)
> +{
> +	return mac_len <= ICE_TXD_MACLEN_MAX && !(mac_len & 1) &&
> +	       ip_len <= ICE_TXD_IPLEN_MAX && !(ip_len & 3);

alternative would be to use mac_len % ICE_BYTES_PER_WORD, but modulo has
a bad reputation when it comes to performance.
