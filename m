Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D662E60A260F
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Nov 2026 14:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=r1CKuX+w;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=d38Tf7BW;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=RBI5cV9c
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AE86760A7F;
	Wed, 18 Nov 2026 14:18:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id frWAScGgbLgu; Wed, 18 Nov 2026 14:18:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B1B9860A7C
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795011511;
	b=BWBtpPCckpdoiDtUAtmeSOjSax2N64z6Zo/s/WacDH5gHghy4lOuqVgIJiWKyxCLkMOn
	 5WaMIqKyXjaPlQbFFFHRCoY1rffxHGA07XSR9UsvtIi6KJavElqhSie7thiyU2rMZ8sUt
	 NxiidRhHWN0GN6URo7QpzlMCI4H2oE2K5u74r+CSAEfOnbQaKAa74RuySAQqUjT5Yxxbt
	 vBudWKptj5mTNsEZx6jkZSLnhZPRfR8zwWBZkfh7lZFIYwPukNaofhnxeCNpqW0PacCQq
	 e6AsIWTz6kbiGTMjbnIUKtn5aOZvJCmf0GQlTHfTYhUawmMBa4Q+eUwc9SX6qBccxqw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795011511;
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
	bh=e9z/u45NuEg4HXYDtzDUp5YdYFqpo4/+sRlujleJzGE=;
	b=awiIERjImiMd3AQmwb6VIy1L4qd8V6jrcNV0LbGaf5lswr5FrqfgLlsWnL5+NxMsy+J7
	 pMQfS6JZekDGjHqYF8Af3XIGsdwdfVVCg1f2lYJDoYNOaiYieNFlHY0XXrx2RIdchO+l0
	 M4ZakUSO3rR2uq/YR+PSYnrLIEZYS72IFpnNL/Z6X9UdlBE3e1cRooh4zYF218mqUkLAx
	 6yEK7WZKYmyw61l6QebUV0W/EvoW8/Ucf9tG/tq7Q0r6Xsa1GTJT4tH6d2Whex7lGOB0N
	 6sx9EVQ750YkP+d9tHUi0ugvHAiTalzXbri1ccXK3d55zI1Zjb6oPw0oCfK53RmjUMQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795011511;
	bh=e9z/u45NuEg4HXYDtzDUp5YdYFqpo4/+sRlujleJzGE=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r1CKuX+wL93tTxuAH52agKIrlPvUPerAugvNRCqppnqLw36xIHyoCUKJJfdN9lT84
	 KkftJBD7OrqGgUQjzIScEIIcSqi+/XxYNJrC9QcRrp9XCi4o4bRqjCutqyXDuOCLWZ
	 k48rZ4b/aBdNx00Pw0jXxzmz4LYXtBCc4pWsHg3oYkt7N4YMOeHemv1z3L8jhM+EWQ
	 MoeToxGKcmw8XiIH7EIltokgZI9+PsXX3hHYRmhFWUTgc8PyCVj2bO0uengnHFYKy+
	 FISpmwdEM7Xy5bny0yCMOQe4RJI+CEejJ+0nh16g1laVukLT1EVa4WvlxZ80LGtz42
	 7tSjAePEjkaxw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B1B9860A7C;
	Wed, 18 Nov 2026 14:18:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id BF6039F8
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 14:18:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A5111409D7
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 14:18:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nu-sXccgrrlE for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Nov 2026 14:18:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B599C409CE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.8
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.8;
 helo=mgamail.intel.com; envelope-from=maciej.fijalkowski@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=d38Tf7BW; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=RBI5cV9c
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B599C409CE
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 14:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795011510; x=1826547510;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=1bkwxp8hpOk0zRz+BF6wGVkq9ZUAwDTAtLsFOPGkA7o=;
 b=d38Tf7BWDqzxfddmmpg8aE8meLqDkzGint7JM7nQ1PGnDhs14EEgWcAc
 fZpE06sVgHZo8mJFcwBrjLb9rqhCz7vItb8x/05aIEGusH4ueHT6Hth0R
 xM1vqLzVabwhy99oXYPwO4djlixFIzS2nzOnMXtzMaPt2/kqMNDig5LZe
 FdTPJBKJRCXM0DrCujeq6V20KbYMHtv6ieh+MUAPXEKNgIQ/9YhbFYP8L
 px7AiXZ1nOjiTC4zpllIfli4CR1s69MxeUx8gUpZT6bOhAJgvIH7IU9Lj
 mqQpOIGU6ocDg6HpWBcq2LTMpNK5TWEXwcMRUAIr4I3w9fCC+aNJkr74b Q==;
X-CSE-ConnectionGUID: sd2AmqndSvOEHPnk92HMzw==
X-CSE-MsgGUID: nJwgj9ihR7WXLu/VefX3rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3714212"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3714212"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 06:18:28 -0800
X-CSE-ConnectionGUID: q4DGTe8gQMaOroLOfBNG4Q==
X-CSE-MsgGUID: YsjnIMI1SGKXCkz3qGyTdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="10146496"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 06:18:28 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 06:18:27 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 18 Nov 2026 06:18:27 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.13) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 06:18:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9z/u45NuEg4HXYDtzDUp5YdYFqpo4/+sRlujleJzGE=;
 b=RBI5cV9cVH+rpwDdiWz5512yziMJBJLy0fo+D5kW+s4BUs/IJMBByRA3x49QiREbDJCAbr9fXFFkO8ojlcveqgoq6zEF0+e88vnSQ8YD8OQDdYAklM+4QA/0t4N2OKXFDFGB13DcFP9wQDeFtO/xXXsPKgIg0QGpc7jBir4xOLY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13) by SJ2PR11MB8471.namprd11.prod.outlook.com
 (2603:10b6:a03:578::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 14:18:25 +0000
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de]) by LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de%4]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 14:18:25 +0000
Date: Wed, 18 Nov 2026 15:18:15 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Magnus Karlsson <magnus.karlsson@intel.com>
CC: <magnus.karlsson@gmail.com>, <intel-wired-lan@lists.osuosl.org>,
 <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-net] ice: reset xdp_tx_active when cleaning a Tx ring
Message-ID: <av2zp3AEAB08afQa@boxer>
References: <20261118135920.1063665-1-magnus.karlsson@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261118135920.1063665-1-magnus.karlsson@intel.com>
X-ClientProxiedBy: DU2PR04CA0167.eurprd04.prod.outlook.com
 (2603:10a6:10:2b0::22) To LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR11MB868673:EE_|SJ2PR11MB8471:EE_
X-MS-Office365-Filtering-Correlation-Id: b96c1f5c-626c-4107-36e5-08df457ecee9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|22082099003|18002099003|261009223027099003|261102123227099003|11063799006|56012099006|261021121427099003|261022115727099003|10067099003;
X-Microsoft-Antispam-Message-Info: yFmSLXgDytSaKDQIzJHkEmmZBZgF1x4wr4/7aMrVABiT+wQ2YdzEraXJIiJQLFxyJCO3gLH36CYy5p52QOcKxrlNI6qio8IHiEwvrwbzo02c3swS4kSk+aTJgYAA3Ho0Tu6bexhPlmflEPbLC3CH2P2F7+ANty/EPAvC61vPyGB71GKGSJffxN+L+EMpTAG1r4LEwKxZx1sMKZYtEEIuulqTAyD+Tq06Ko7GRJdhlAjI0MOz8I0DJrD+JBDTQOLajGmwMcyvVa+rCo7xpJQQxMSfbSJ2xC9lITGAGZRuT9FMY1U0jrmctjLLK6lQMkTs//nECHUtxUxfpfEVAp1J7DAeL8vLKITskPWxGpwdd7tJQAOnfyDEpgiKxeF/38vCVuAJEeYU3SX8BwzLBAui3/AS+p4HY5sBbdrH5Ksd/0hUrBo9pmczBy/pqCd7uz3QmNZEbf3icW5mz8jdIBGRZXZ+4yj9hz7pRoyyVa/BUBi3j9+jptW5duXsMjqxhFFzr7/Rp/5QDrTso6uN3w8DH1jbOi9gOmRO02IoFunCZs1TAr0WwUWVk3HmWBUoox5+IeM3meMSCL9Uns3bBmB2osEy3hmwCaO9imjy80A6PSBI32e4OdnbOEEbfnOZX8eMIerHJJyBRSf3bSfF5Ao6WCNpmsujtljjeLsjmPngAio=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR11MB868673.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(22082099003)(18002099003)(261009223027099003)(261102123227099003)(11063799006)(56012099006)(261021121427099003)(261022115727099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vfMsBLxznaEcTm7uwiEJhGBzehOAwnN4QZXEA+U74ia+x1YQE3odEXk3IOpQ?=
 =?us-ascii?Q?BO8Y8Fg8vDhDmeKmgv7SDZlronr7eySUPv3qWWIETHezOLLu57Zjs4zTWMH9?=
 =?us-ascii?Q?IiEy0FI24kjIbgTK+NkLQ7H4wSU+B206huOUeHDfYlZG7ggVbWT9q2SX7Tco?=
 =?us-ascii?Q?53nbJ1Cjn373cERX12Bs4HofoaWoMg3k7oMMQWZvqCZGmoREzxmboTn7yggc?=
 =?us-ascii?Q?xZTR5wILvRqdk0gj7rgOUcq+1UTBKpsA3HsqIbfoPRI9lpkzaR3tK6mb7sFk?=
 =?us-ascii?Q?pHdXMtTGTVIyBLCYT5C8VY3Hs9mIXbz0oPZc9EKFy91kkVi7Q+Nmn8agn4v8?=
 =?us-ascii?Q?yDGZ/fOYYbct5iLJM9zEiefyIF7VS/yO7eqzLXeD0KKejWi39DA0T85I6POD?=
 =?us-ascii?Q?ZHWYIbhW7zzIwwaEP/HFd+8OE6ciVnWotG1EXb4iNawyF7hicqsE4v/wnKJj?=
 =?us-ascii?Q?Newi2Hd4oFZrKikMEvvBElMeHeZTzcPIZ5zj3jzh37l+dw7gruosn6uk4QzF?=
 =?us-ascii?Q?mYXbiLYAfnYpNHaPD0RQE8wphiHTPTktiuh/KIGliexc5zgewT6tX4cu++51?=
 =?us-ascii?Q?g2tbxttCmaxVyQ+D1qAl2cAj7db/uEMnFNKPQNDFSqN28NE4xAtumNk+maCE?=
 =?us-ascii?Q?bAWmA3FPlekN4GtJ1B7pBM5v6XbumRUYhut0R+POSsEYNgiyyZWgIBVUQvx+?=
 =?us-ascii?Q?sxDfep6IL9nIMUGMndtw79W/TUN1lCyB3YWND8XxGnm4S3YVDfXtHURWRXwk?=
 =?us-ascii?Q?kZrSnquXm9T0mxsI8C81Ui86JpKrn8JZL0BGm0SGEBJymGm4iacKhJub21a4?=
 =?us-ascii?Q?6RScr/mLd+3i6Fv0vCc2Kx8k+Myl1tg26BWqbd75i8E52Xq06OJRhCyZTMBR?=
 =?us-ascii?Q?sMbaeID8ZBVNkv0+fOpx20ow5pyRufCDK5B30y41waZiedMnIMFmpVS1x0Jm?=
 =?us-ascii?Q?wINeFTGioEA/LUS9LLfy79IxtV/+p5VtF/i9jQdLyUEeFkzzSmH0xEACMxEa?=
 =?us-ascii?Q?3Xmw6swNOPjNPILsf3lveWhwGzSDv9biVz+AdvCUJTwq+jrWlRk3pmLjXied?=
 =?us-ascii?Q?Mq7jcdphbqSKJZT3Yw2FNWh52yEboakMjIcQTzciccz6bsT/D9EhYf6220L1?=
 =?us-ascii?Q?L4T/ZdkCUar8GLH/e24myD5x6fZT3PL74FMLLEflaibh9l5hegZxc3Osksho?=
 =?us-ascii?Q?peETP1SIK6cPkybq+AkZdBGlUpaWJLe9cLds7+z0eV5b7qaKIG1GJJZL8NJI?=
 =?us-ascii?Q?ph1sf5YRKp6MZ6waEuB/hqij9oiFTONTZIP1/DW29j8G81npm7wqzI1lbWHN?=
 =?us-ascii?Q?s+c9Ga6i6/xLO2nSfy3fZKrHKRqSJhQxUd836UW8Q6XGn5jmU8nYmEY34/hs?=
 =?us-ascii?Q?QRxfb0+NB5RSbYBmof1Id+vVOBljW2w0jIZEvJ4NgtNKRCAQyWBCIZGfCjzN?=
 =?us-ascii?Q?LfJhfMG6WrgL3FERLmFXEw2IzSYWInCye6N+HaAcZPsewMmFqF5xU4S8AsBA?=
 =?us-ascii?Q?aNUcWuCIp1vap64sXGeuthXDoWEbrLP2qJytnVBH/gTq3O6CZlbhl2Egbe0i?=
 =?us-ascii?Q?EinZuhndQ2PA+O7W+74WTX3DivxpwiK5vVEc85oKB+bdHppQhorEmTXWwwbM?=
 =?us-ascii?Q?s/QotPXxMjTiib7/JwYJDozElHL2Y5jWA9WjY86Y0MnFbgH7w4/6AjFWGVUf?=
 =?us-ascii?Q?w2kr6yHXSP5Xqmtv5VDBOvr+6BI0QVerhmNtNOwO4VQrHpYgMXEkLlpo64Uk?=
 =?us-ascii?Q?avPKGiiV3NnBdSKyNi1AcIE+WArZYnc=3D?=
X-Exchange-RoutingPolicyChecked: UEWXZjxZnMSJSFtEb/Nx7BwntdZ0j3az7HkLGqndpKJJ6z5b6zmPXrfWQcKTN60mB7Yh7Q0k8rD7HdG7hHMRd/GVZa7PG9w9sJgtXC5EQz8v06uZfUKT/cDr7wh/b+NWzYeIsT3tIJqepJMubC1InctnmU5RArTuykB+xdOLSiW0s4IlCc0K82bz3Bjy65G+53d/JPI95NmZoUdXxQjOmEOxlOFMZuZj5oJJgRWUFUKnIrCnBx2XeZbh7M5Q2Yy+uU8TRyNz0UXbJrxOaoR/hmolz38FPTcIx20SKkddLnesEnYkhA1m4JNz4WdwpyxtlI9iA+mvj3qg2JJjHxwvEQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: b96c1f5c-626c-4107-36e5-08df457ecee9
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB868673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 14:18:25.0200 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZgBoN8E3ikteQxWC3ISJaUe6iT54m6I0MvN9e9UfxUHb3a8Rst9MxzlUr51VsPruk4bbtGzRUre30EQ5CzpMNQ/wY20tkIk4CRtfQZdnVqs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8471
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 02:59:20PM +0100, Magnus Karlsson wrote:
> xdp_tx_active counts the XDP_TX buffers on an XDP ring, so that
> ice_clean_xdp_irq_zc() can complete AF_XDP zero-copy frames in bulk when
> there are none. It is incremented for every XDP_TX frame and decremented
> when such a frame completes. ice_clean_tx_ring() frees the frames that
> are still on the ring, both through ice_xsk_clean_xdp_ring() and through
> ice_unmap_and_free_tx_buf(), but leaves the counter as it was.
> 
> After a ring is cleaned with XDP_TX frames in flight, for example when
> an AF_XDP socket is bound or unbound, xdp_tx_active therefore stays
> non-zero for the lifetime of the ring. ice_clean_xdp_irq_zc() then
> always takes the per-descriptor slow path.
> 
> The ring is empty after ice_clean_tx_ring(), so reset the counter
> there, together with next_to_use and next_to_clean.

Has that ever happen on your side?

Maybe to be sure we are not leaking buffers we should teach
ice_xsk_clean_xdp_ring() to decrement xdp_tx_active for ICE_TX_BUF_XSK_TX
and on ice_clean_tx_ring() warn if xdp_tx_active is still non-zero?

Feels a bit rigoristic, but I think I stumbled upon some off-by-one bugs
where we rely on ntc != ntu loop. non-xsk clean goes 0..count.

> 
> Fixes: 59e92bfe4df7 ("ice: xsk: Borrow xdp_tx_active logic from i40e")
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_txrx.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
> index 35a480a1e172..f26646825a1e 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
> @@ -228,6 +228,7 @@ void ice_clean_tx_ring(struct ice_tx_ring *tx_ring)
>  
>  	tx_ring->next_to_use = 0;
>  	tx_ring->next_to_clean = 0;
> +	tx_ring->xdp_tx_active = 0;
>  
>  	if (!tx_ring->netdev)
>  		return;
> -- 
> 2.38.1
> 
