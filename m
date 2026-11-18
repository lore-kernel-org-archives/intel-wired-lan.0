Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1365606A32A
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Nov 2026 15:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=odZs+kqf;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WRy+Rhzr;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=QYrGd2sA
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B428D40A20;
	Wed, 18 Nov 2026 15:49:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4jWzhVyt52jM; Wed, 18 Nov 2026 15:49:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 93D0140A24
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795016950;
	b=Qz1Ej95BWjUztzNlgXWDMd/hgDU9hZCi2y2yVQ4yu1SQmss8Sj+s3FXCSj01S+PtvMVQ
	 qGOI42Q1i1Pd0almqknoZkMpWkKSAwKBtETepGOxcfpmQj1fjiyLjgnkyzYyapKsr72pH
	 KT9+HZUuCJ+0a4RStaje8CiYDoPLv8mko16peQ8va2MSx6WkADh3jr/MO2rScuATfZOkA
	 7u1eudT0F0sob4NLS6G9KvXVTVb5TnumR5BVv+BoZlg+wPLCMx30a+W8LwJaOH0i53kxG
	 YSh+Pnktpjh4yNwt2e8bzx9ZyOD0hru29hOvMoMQ6Na9krRSN44Co08B4huza0rlCaA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795016950;
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
	bh=j1Tqs9agUvLeI8ANsWSI4JicVFUH5TPT47HTOrNX3Eg=;
	b=nMUj0TAS3gaC7kkRT6LMwSNoORSHpbhiR5Glxi7+WaObv07wR/KO83nCSZfUx5W/aKaU
	 I+qtgI+3MIiUXayljnrmbx+es5cjfLGL70lmmsT5gy54387GNke1wWJETBV/6YH1cUXNd
	 k5g0bQbr7S3rLcQytlkXmNTTV1aWH0xhgOp0Xb/K+wfRjWdt6zaPecjaTZUIdvayGmUg4
	 6pkluY1aaYWDtckqkc02AjNukrXDQg8M/f+KRjLJVJy+zdUH48nAuR5k3bObFYL1qbvMC
	 2cDv4Y4POdiZUyE/7rQetn5wW/uXI36r5YL030NpL9rGGxzG9bGPdVgNxYzUlY6cIeQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795016950;
	bh=j1Tqs9agUvLeI8ANsWSI4JicVFUH5TPT47HTOrNX3Eg=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=odZs+kqfgnr+/vZS5HTMJBSmPkJeYSi0g1yz0kwKJYNSLePyx9H7nzJKjLGx4TYvY
	 0Zlhk0NOKt5zlM6K0Z/7Oi8tMR7KWCTCY9TpSiylOph6ET5arZ34USfJqX1BIX7xJX
	 9h+A2RCcNzz5sUNcSaH66Rti9zX1UxC42YVVFuogvsxqa7AbKgexPa59QQP6/TQTAc
	 21ccxin2WCpOj/jk8MT5Y9RB50epYlSCniEcOvY8L+nI0A+r8j4aP/M3vlOyt1KZvU
	 0hYdNjSjQwgeByVgth/7JIbHzokoTBnnkc8jcE0WUEFz4JrmFJIbVgjS7TX2Tsk82g
	 D7daBO/10oP+A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 93D0140A24;
	Wed, 18 Nov 2026 15:49:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 408E29F8
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 15:49:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 26D7B811A6
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 15:49:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id imTqVL2z1o1J for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Nov 2026 15:49:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DA38580D43
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.18
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.18;
 helo=mgamail.intel.com; envelope-from=maciej.fijalkowski@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=WRy+Rhzr; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=QYrGd2sA
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DA38580D43
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 15:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795016948; x=1826552948;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=8pRueWVu7o5TeBBpVmQw3X2lI9uZhaKTc1gK69AcYG8=;
 b=WRy+RhzrEkPWDM5/aQEdWqs+pIleS+J8Y9N1OeK8X2FI7S6gsYP+Ymwe
 ePi5RrJzFJcq5Dle5/pt58OGpJu+fvfI1t26wK6uMszN7JCUf5TIL8EdF
 BVwDjsn1uJ4iWX2xUsCXO0BaybSqVh75LM2mnz9LC0TG8DPUw/APqtGAm
 R3aQ6eYG4i38IO3NNYYBX/EMC1IeANrSvGU7mXCb2eC7yabbprJ8m/XnO
 gi8LsQiilNYlPCuPV+8Wm2cfT/aF5A9QPHkE1LqZOd9gAkE5SpMV5XdrO
 YXPEEF7p8SlpduYzExfOL25/gMlyaSPhX5GKCGlhQIfU1K85fATcd/ozs Q==;
X-CSE-ConnectionGUID: 4KR1PSWDTH2ht41jNdSciQ==
X-CSE-MsgGUID: xgyZOv6nSFuKv/JNSS+SRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3849461"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3849461"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 07:49:06 -0800
X-CSE-ConnectionGUID: koU6W9rPQyWbs8uwI0XTCw==
X-CSE-MsgGUID: DEtDgM69T+2ttbLOovD6Cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="10390671"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 07:49:06 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 07:49:05 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 18 Nov 2026 07:49:05 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.66) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 07:49:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1Tqs9agUvLeI8ANsWSI4JicVFUH5TPT47HTOrNX3Eg=;
 b=QYrGd2sA6VjOBAHVxzXAMy5+yvXiQAqqaZA5ghJwOV/ny9kIBRKQ7znD9yQQsWOY6GMz7UbE8SOynhxlIzW0TXxqZmT2n8rYQY0uqjq1p07gY7tocOBiMGs7QU9dho8YxoPZ0HW0QX/wjioBzJoRm/YKIcWjt8RXeJAuKGvHpb0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13) by PH8PR11MB6975.namprd11.prod.outlook.com
 (2603:10b6:510:224::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 15:49:02 +0000
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de]) by LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de%4]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 15:49:02 +0000
Date: Wed, 18 Nov 2026 16:48:51 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Magnus Karlsson <magnus.karlsson@gmail.com>
CC: Magnus Karlsson <magnus.karlsson@intel.com>,
 <intel-wired-lan@lists.osuosl.org>, <anthony.l.nguyen@intel.com>,
 <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-net] ice: reset xdp_tx_active when cleaning a Tx ring
Message-ID: <av3I43PAMeBWk+at@boxer>
References: <20261118135920.1063665-1-magnus.karlsson@intel.com>
 <av2zp3AEAB08afQa@boxer>
 <CAJ8uoz0Cr5ZFA9GTybTgw7TB_0+hO3yegayBg0r9n4L8cnTtkw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ8uoz0Cr5ZFA9GTybTgw7TB_0+hO3yegayBg0r9n4L8cnTtkw@mail.gmail.com>
X-ClientProxiedBy: DU2PR04CA0301.eurprd04.prod.outlook.com
 (2603:10a6:10:2b5::6) To LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR11MB868673:EE_|PH8PR11MB6975:EE_
X-MS-Office365-Filtering-Correlation-Id: dc4da82a-4d58-4699-d628-08df458b77fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|18002099003|22082099003|261009223027099003|4143699003|5023799004|11063799006|56012099006|261028144727099003|261022115727099003|261022105027099003|261026140227099003|261021121427099003|261026121527099003|10067099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: qJy9ZHrURJhubRclOojCkQURmEeFR7HXSkC35jthHiou+3rQXxdtRjM8rSfP1kNMxNzy1GGUp+Rd8vPcunF87OeB9xtB54eKhTEfuzld7b+MQED/sWzqYwwh6CPHhTkXbIv8ZNWX8I3QHAZdQGmGikbDo/kx/TuZkuG/RAske8rVc9gwuLc7ZSMuFqezZTYRrGnJlWDZbnW1WPmKxXDrmazyH3LGPibJnyBiber04gOtAW6Hd0USEhHN9C71cJMPWMF1odfMndf4BqK8VFhGlX2mk9PgDHgu+99sE/gmT+Juw39nr8Orkn0ZTxL5l+0HMz3Ah7ufm2U+M8SUATxSREF85iRU+eij//s1vHdKZcswr9Yk0qo1HxX4+po12ERUl7wOPWO2ZIGrH/a/2u3WRJjtLc4fXZyyAQcVYCnv6rKOCjW7WtqWVK1rQkz3QkxfeR2BoVlvSFeVUzuqsE9a/n4Sh2OZyUDz23fCI48MDdbM7+0BFlVWCMKPb7Uj96KW9Xx8cGWljpfd66CgluT4wyfVQKMjIwFEtnF18IYrsPodEZFF0Q2UuE3zVaC3VXJ/qyUzbF910ZBxCy6QkrDFUmpctxJRw817LO7v5HLFj9veXcEkE2bGRUASnumgLixlFSg8qHDWbwfsk4kvLxgG1W/eI7RvZ2wX8w87OQTOtQs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR11MB868673.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(22082099003)(261009223027099003)(4143699003)(5023799004)(11063799006)(56012099006)(261028144727099003)(261022115727099003)(261022105027099003)(261026140227099003)(261021121427099003)(261026121527099003)(10067099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0cgCHoqr3TQMcBycFGqp3l6mRzR5UFwXQzBTYW3fGpC6cNBBF2ceVrNaIBOM?=
 =?us-ascii?Q?gXYEoMsJq5ZMTR+3nxkgS6iQxcXajouAjhG0ntndynP1QjWLDvWtFf+G7fuO?=
 =?us-ascii?Q?NTymf5QqydDRsY2/SUgCbe9tVz4Y/+9PQZ3xbCZpMyl5lkM/P9giP/j8KVGM?=
 =?us-ascii?Q?NE6JkXyrxf6sJBG95r8GtkbxQ86uxTYsJS6yhsGVxF5B8Sz548XMFZk2FWVW?=
 =?us-ascii?Q?MVaNgPRtwu/fr6iAdCNR4IGOocMtydXoDDYcFEyMhWnrvdUKnWYg9GggFU+H?=
 =?us-ascii?Q?NzoHAlKw7J+wgxpZbwwWVLDecjP6Y1nKCGJfptv3732cDFUl428XqM99LYSC?=
 =?us-ascii?Q?GP4mJ5G/RmRZuRql4bRibjftFGfmoxXO9QyYSMVEN3a58CTRPiA301pbjZYz?=
 =?us-ascii?Q?rifsA/iS2tH6hr+IDgfB+t6jbT2ed6y6GagtZ60LnlsIvhSwsvX0J6+2lN31?=
 =?us-ascii?Q?/UIAJ1xd4dP228bpePqgHLYa8jO9BWpFMorYCOftK64A0IzjCnJlWzjaopyQ?=
 =?us-ascii?Q?/EnEvtDDtYOEuNdYbSllilthh0BPNlTIKQ2fX6RrhvIJY4elfVqdnvhYvYPq?=
 =?us-ascii?Q?I7NVt7B1G5q0dvKaAFZGHmaf1VssH1/P5f30emYLp9U9L/mEmj2rF/zpCkl9?=
 =?us-ascii?Q?bgqT1Bx5VchO6j3f9HRl/zTNOOHiC1vjqIDRQv3rvt9G5AAnPU7xT4t4F7Dq?=
 =?us-ascii?Q?W2HPCEhHXXZQd6O5ZIdXaR28B39g0hALN3My/lFs0Bl0Y6et8nP/dKBZ26r4?=
 =?us-ascii?Q?itElDOq8OtOn3vSpZQ6cC9westDeu+DM/88zTP8WDCqWFM0a5oXDXhwV7MHG?=
 =?us-ascii?Q?ahzPzZfBqGaxlgKeRj9QeJ/8fsanfq5QZIAh46+3ML2huWBskjIC485SuWe3?=
 =?us-ascii?Q?o8kets5q5UVz9COVvL3+eMuKsoQ8IK2ctsvU+FAJgy2pXZ7P5v3J5xIozpKG?=
 =?us-ascii?Q?n6F6o4OcOjHo/uXUodE2Twm8slVFosghed94yMdHT74mjyOtf6hsS8rFnwpI?=
 =?us-ascii?Q?kKqvmh/dZAo4IL6+14O3+3Ih48go/orowH7IOy490CdEvFhh+Yptk8+gbb8T?=
 =?us-ascii?Q?AJPo94S5hKMIYg8GOK2RKtw+5MocmxvCYF8DHmzXWf8BoXZGJhaa1V35hEaU?=
 =?us-ascii?Q?yoUfy7DOkX1nrLNi8/oG1+pV2XaP6s8nH4tE4wuwcE1EB2zM1kNwIvV5dyr+?=
 =?us-ascii?Q?7DZRUyrLf5x8f/bcFokbTtG0HBBKQprY1c5R4dtB55szomsmkt362S2tKIPv?=
 =?us-ascii?Q?dl0Le1u3g4Y7LvUz68gZiw9Zbx87CCqK5vCq2NhGjU3yMUAKUOu1me+NxmeX?=
 =?us-ascii?Q?Gws4AdqMxzaMlrGsHaRUAyxInugcKAZGbd/nqk2ZhxFoqlMpEJbE8BO6+2Dh?=
 =?us-ascii?Q?njxRtqvIwUliJSRcbg/ZffmXZHT7M7j5ifbjUbBN3AgLIINYb9EMgyUjOVA1?=
 =?us-ascii?Q?Ay9VRYnNZQPq+hAe5OQYdQAKaRqtt2T9tmd7uxW0NcE19JItifkQyOAfEZ39?=
 =?us-ascii?Q?8M8anO6lcQH3YeLd2QUBoiWcw5WXs0S+qyFiS+a088xrR3GNmzj+Y4iIrXHu?=
 =?us-ascii?Q?YC3Fs+BMqdroNqiBKUcqokt2ytEDitEGALjIlMvH0YvjYqQkPtLxPrMyUQp5?=
 =?us-ascii?Q?5ceGVYg6Vnoyzdvt4ws+4C8V5OWo2RD8L3RbvGy/+RQyby6gJxvmUqG1kPFC?=
 =?us-ascii?Q?W00fdzg+8jX/dIFW+fIq+IElH10ISpgpNVWtH/RBCbbDzBLgevqBeFa02nqB?=
 =?us-ascii?Q?9vyGnDi9VMynrkEcxa+bYx9EcgLSphs=3D?=
X-Exchange-RoutingPolicyChecked: kt+I7AYStGPWroKqTs/ljsJOTIy8AnCvCbG36FAJJ94Q9eYwIPp8P0vn64d1MK65wzgkAHbz60IuXi+YtBcCGh9wO2wDyXRyr4FBpRJhq4cTCC00zUQHKyojH9VruRimJSLh5NhkUzrI/+49kSaVrwy4LB9RKUu/UzmD8cEtaelj8SK7WoOhqzbP4XzEHWutIfzJTrgg9UNqyiiwv64hozJyqKWwYanfObFbEkExQD0evrTIwwlPW5XDsYlK5aHEtB5uD4J2x8DvR+TZiNIflDT39SNsdjr/C3Q8f1iiKy2ZAStGzhvnH0L2MQBXFFuS/phG9SVDwfFUMpjbKUUq0A==
X-MS-Exchange-CrossTenant-Network-Message-Id: dc4da82a-4d58-4699-d628-08df458b77fc
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB868673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 15:49:02.6560 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9iCEA8nZL7hIo4LeEXrsA4Lq20Vau15/4p6P54dyOPn7wVbVylSEP/MHMiC4cfc27dj+28jHTHcsJkJWUHSNqPb9nKPqQaYd/7vPDXkDKQM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6975
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

On Wed, Nov 18, 2026 at 03:32:40PM +0100, Magnus Karlsson wrote:
> On Wed, 18 Nov 2026 at 15:18, Maciej Fijalkowski
> <maciej.fijalkowski@intel.com> wrote:
> >
> > On Wed, Nov 18, 2026 at 02:59:20PM +0100, Magnus Karlsson wrote:
> > > xdp_tx_active counts the XDP_TX buffers on an XDP ring, so that
> > > ice_clean_xdp_irq_zc() can complete AF_XDP zero-copy frames in bulk when
> > > there are none. It is incremented for every XDP_TX frame and decremented
> > > when such a frame completes. ice_clean_tx_ring() frees the frames that
> > > are still on the ring, both through ice_xsk_clean_xdp_ring() and through
> > > ice_unmap_and_free_tx_buf(), but leaves the counter as it was.
> > >
> > > After a ring is cleaned with XDP_TX frames in flight, for example when
> > > an AF_XDP socket is bound or unbound, xdp_tx_active therefore stays
> > > non-zero for the lifetime of the ring. ice_clean_xdp_irq_zc() then
> > > always takes the per-descriptor slow path.
> > >
> > > The ring is empty after ice_clean_tx_ring(), so reset the counter
> > > there, together with next_to_use and next_to_clean.
> >
> > Has that ever happen on your side?
> 
> Nope, but I never use XDP_TX to be honest.
> 
> > Maybe to be sure we are not leaking buffers we should teach
> > ice_xsk_clean_xdp_ring() to decrement xdp_tx_active for ICE_TX_BUF_XSK_TX
> > and on ice_clean_tx_ring() warn if xdp_tx_active is still non-zero?
> 
> Sure, but does that belong in this patch?

Yes - i was saying it would be better to decrement it and see if are back
at 0 rather than blindly reset the counter.

I assume you could unbound the socket but keep the pool and when you
attach the pool again you might be lighter leaked buffers.

> 
> > Feels a bit rigoristic, but I think I stumbled upon some off-by-one bugs
> > where we rely on ntc != ntu loop. non-xsk clean goes 0..count.
> >
> > >
> > > Fixes: 59e92bfe4df7 ("ice: xsk: Borrow xdp_tx_active logic from i40e")
> > > Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> > > ---
> > >  drivers/net/ethernet/intel/ice/ice_txrx.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
> > > index 35a480a1e172..f26646825a1e 100644
> > > --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
> > > +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
> > > @@ -228,6 +228,7 @@ void ice_clean_tx_ring(struct ice_tx_ring *tx_ring)
> > >
> > >       tx_ring->next_to_use = 0;
> > >       tx_ring->next_to_clean = 0;
> > > +     tx_ring->xdp_tx_active = 0;
> > >
> > >       if (!tx_ring->netdev)
> > >               return;
> > > --
> > > 2.38.1
> > >
