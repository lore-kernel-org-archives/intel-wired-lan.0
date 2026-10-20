Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6056B606A320
	for <intel-wired-lan@archiver.kernel.org>; Tue, 20 Oct 2026 09:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=9Qv8h17f;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eWTSWwJ2
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4356480BE5;
	Tue, 20 Oct 2026 09:18:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QZAsQFN390Pz; Tue, 20 Oct 2026 09:18:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4E29480C25
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792487926;
	b=HTIUODsRjskNJz4nyhoAFVzg8s7zXyf8kPTTfToLPJtsMeztSEdlCTMoxo6vTDO88Iey
	 LkVMJA3ptW8lm1e+zNoj6etZXU0yN+HxSFErVB3OOk2YHyXImOACo0oo7gboiV/sLmA62
	 gvfCFPyQ1Vasp8aJJqg717QlBKkkHxhitMF4nJnjoHkuSBd41KyUXirhiRxLV0lEvVP43
	 PrH8T5z5Kex81RCTYguxQvHhFmfjUN3XOJapjjiNDaa6G59NICy2aV9HZVIsBKSa/nOAD
	 CrZ5xxpVIagWay/5Ueo3ZMKWDTktBUbGfmByBGkWMRq0QLLcn7t1RwcUqhr8LUL93wg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792487926;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:Received:Received:
	 Message-ID:Date:User-Agent:From:Subject:To:CC:References:
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
	bh=wdECPA+tSgWP98+ShqOszoWHNf0AjVVJJKgyDhye4i0=;
	b=qNO2r0SknwvHrpMx2WwkM56efIa1qvFAE2oBt6ys/STc/hpNQjvZzlSSvkbMx+03GlzW
	 jUYw0pLFsUUsd/4xaTJA4R+p7UyajD+wjhlHYYbO4idT+8Enbxncxb85wX6uJMR7iD39w
	 c8HdFrc8pBQsHFtxcGwzIsNzXzjQAO2QCbkOQpciTE6W7wnWDCluyK561Uyz7Qvto224w
	 O9wr4JtKRXINv5dr8fTY7Vse+Fcs5KGjxs+3uTMqbN9m/5tQxJ3MJFCbyhA0GZZunCnmB
	 qVb8Cb85H6rZzTgiBCk/+Rxd0A2na9qS6oPpZNIhi7Kurt6YFbBEGgHrA4DN0kp43TA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792487926;
	bh=wdECPA+tSgWP98+ShqOszoWHNf0AjVVJJKgyDhye4i0=;
	h=Date:From:Subject:To:CC:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=9Qv8h17fBqobZZzGl7E7I1zvnZX+5WvqTz2CWIG5kcmrpU5CtTGgakL7HtOAZu1eT
	 yI2JqbQNa63Lrx0phZi3KmjZacqLXi4XXXk4m/uXZ7TRDVr/7QM3Xe1EUGH7Cean1K
	 8NRBvbmIaNiuZpfyBBMdFVMU1IHbL2yNsd5yrzlcvCWC5e9QHxOBwghVwz2fcBrh7o
	 yNBo6+0FMHiYgaTlU2sW4KoiK5dhaTR5OmpPxxxwlFJVlYFlC1XarJ71H1Goftsdxk
	 ZvicdUsDc2CIUQrSHI4jYSk0w5y/rjmVDSWJOB+kiDxdkp4ER30byLAT+DTzf8xIIz
	 5EaMk9JQvKJpg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4E29480C25;
	Tue, 20 Oct 2026 09:18:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6224A465
 for <intel-wired-lan@lists.osuosl.org>; Tue, 20 Oct 2026 09:18:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4868E403E3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 20 Oct 2026 09:18:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UFfikXiSR1xG for <intel-wired-lan@lists.osuosl.org>;
 Tue, 20 Oct 2026 09:18:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E8ECF405A9
Authentication-Results: smtp4.osuosl.org;
 arc=fail smtp.remote-ip=192.198.163.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792487923;
 b=O1qOJpe7M9SY7WQe3G3sM0MzFz3kQmoU3hkzuWhxnNQHJxV9THkOHuYq5N9Uix0aXT/4
 uWoGXCV0xdKEHLqy/TzEJYXQaE3xJRMKrTgk1J0zs+NVRIx8JK6FI0raDAzsf0qSkxv/p
 11mL9VMcESZQ+gXx3QjxZvwMMZ26kO0O+zX2pANKaIdkzyg7/mPnEuvQaz5VY6jtY9Ll3
 J+wC9joaAbimjiUPyijctSYjn0RfwgHKY6/3eqvNNRuBuLchvdztE/UFnVOYwnL7v39WT
 ENsz+XP7+bAqHQP/N8iUN7ocGPKIZZSMUz88ztjF5W6cmuIygHrJ/O4yqBRHxQ9y2IQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792487923;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:Message-ID:Date:User-Agent:From:Subject:To:
 CC:References:Content-Language:In-Reply-To:Content-Type:
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
 bh=wdECPA+tSgWP98+ShqOszoWHNf0AjVVJJKgyDhye4i0=;
 b=l17pBm3uzzOPELTrdQ503zhtblnOat0/6w3qsXrfWPUIjXU+8UWQg1oKnhjmnNbnEupq
 BSjb96J00spXGKF5gd+mEUeTDv8ReoVNwiaZUgKajoV+RiC3cfjHB5pVh9Z2/09Q+bzwU
 jksrj7t3sh5TwJjIPl8+YNBrwBP8Wb7X3YZdUQndQZ1nCEZF4uoywg0tHTu4XLhonyjU5
 uPZSb1YIQvzU4l/MeKZ8EaljY4HD7PRuJiKOmOxMLgEPsygk1Okuvv6mr+T19n03YHwKh
 d3D/AnQ0nFz+Dj5XP3c/f1Gc2BEKA8tWRpJzIhemmdGDD9mftxKLn2E64KopXXVP8AQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=eWTSWwJ2; 
 arc=fail smtp.remote-ip=192.198.163.15
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.15;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=eWTSWwJ2
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E8ECF405A9
 for <intel-wired-lan@lists.osuosl.org>; Tue, 20 Oct 2026 09:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792487923; x=1824023923;
 h=message-id:date:from:subject:to:cc:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=uAedrzuvDjDgyMuhP61ekkUtxNJZMAsEBafn5pv492Y=;
 b=eWTSWwJ2vewm5MnPy1zNHzOFZve7n9+XhwOEKfmYQT0Tk55HHI1YOGVR
 9BH6+7artsxL/vEFA+VkxUE/tsZ8pxcFlZBJ0knaW7UkkEwSvrmzerCgj
 1zqjOCLBNsor6lGR4wvYYHvjSew9WojNMzmj9c4ul5up6ASAYIs0EdTFo
 KCH6aUq0wbXpJYGihVQPliGvC7wd++pL5nMevba3vx48s+i2cnvEK06n6
 hRZVKXE0UbfxWG3mFRK4dPkeDWuJwtBv9dJMns7KDg/tVpQChHSxQf1fu
 exXsIZvxcanYxl6s69UGfUuPVZTYrvlAPm/+Xy5qxebhcMEo/seJ095oQ w==;
X-CSE-ConnectionGUID: Tz2iJpAKQO+E16x2UTwpfQ==
X-CSE-MsgGUID: sTEuOftQQ/C68gwwIzf31A==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1197288"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1197288"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2026 02:18:42 -0700
X-CSE-ConnectionGUID: z1u+dOTLRrKkvXryOS0ThA==
X-CSE-MsgGUID: xGTY40epQTiSawq4zOW7cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2806554"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2026 02:18:41 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 02:18:41 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 20 Oct 2026 02:18:41 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.5) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 02:18:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M0680DDycgyd0t/R4soDEaMFMlzlmLLyEOoUbp5SxRzEEReqsfZWNnAJEoN5/6LFrERCo83pL7mI6pWOUXmxo72Wsb4Ti/gkzku6y8Ce120ODAHkUPGSo4oOz59XMAsRq9Nm2X6sx9Hst9GF1hXo3ivVgPp/zEE2rHCwmImqfiWes3vNHdoO6rNqSUnGZH5Wp5c/aHcJVB15xEpYGkclWwDB2lDyEt5V8OyckE+Wj3NnGeXXNxKXJuxiPHYNd+yUgmRhK8Lfwi7+Q8Hoz0zVtOteLrRPtZVtTr4n17/5BKjPV6ZGr3/Ra4ho8wJ2JmZBjfSyblV8wzQg/UvXrzZb1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wdECPA+tSgWP98+ShqOszoWHNf0AjVVJJKgyDhye4i0=;
 b=b6y4TdqoHMIcU0iATSDxpNl8w3H1V6PDuBvuc01kKPkMnNiwcOoFjdBbBd+nCXxFG6ANmJgOOYNPGV0czZyY80gFZMk3ZvVXIdTB4cWSs5iRzZ7Lge3j62+fUBfhPK/9y70jThg7X4ichkIggxgg0//DrwZkyzl6ZwxtbgUWJzz3eksYAA6mf1kGjCGbb/eqaWOG+Lh+WPXC4gkNQtKq+hNvjXuouIQxCDNRtxARAN9vKkk2TuVaoyOUKNZGRf9EtjdKuM50KljrS600HbTEQ1n0e1CDLFbBrqZtLbBBb3WbNeElvyhJgielD1499IWttyOnzTBA7PsWEb1LIk0pdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by CC6PR11MB058488.namprd11.prod.outlook.com (2603:10b6:170:200::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 09:18:33 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 09:18:33 +0000
Message-ID: <62a43d55-f114-45a5-824f-c09f87bea537@intel.com>
Date: Tue, 20 Oct 2026 11:24:27 +0200
User-Agent: Mozilla Thunderbird
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH 2/5] ice: retain the adapter throughout hardware
 initialization and teardown
To: Aaron Ma <aaron.ma@canonical.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Alexander
 Lobakin" <aleksander.lobakin@intel.com>, Richard Cochran
 <richardcochran@gmail.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
CC: Jacob Keller <jacob.e.keller@intel.com>, "moderated list:INTEL ETHERNET
 DRIVERS" <intel-wired-lan@lists.osuosl.org>
References: <20261019105155.3793063-1-aaron.ma@canonical.com>
 <20261019105155.3793063-3-aaron.ma@canonical.com>
Content-Language: en-US
In-Reply-To: <20261019105155.3793063-3-aaron.ma@canonical.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0015.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::7)
 To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|CC6PR11MB058488:EE_
X-MS-Office365-Filtering-Correlation-Id: dc25f8b4-4ccd-4f59-f3fa-08df2e8b1d2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|7416014|6133799003|18002099003|22082099003|921020|11063799006|4143699003|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: hk9Cu/wJw/NNKQBf8VHr4OW6bNy+BPFtd2brbihkVNiSQhd5twWKotUcrfFmx5ArF2CbqLdHyE8rz/mXhuwUEN7Elik/PqUCJZGsjBbPVXBuW9XuKYz6ISqnpCyuNr3sEfqfxkIj+CFUZrb3cbJRZbCqtQh6p9ozgs4DLc5zccLOhJzGelFSX9zc/+3Xcn+tQhhjyHtRY0mWx3g0Gu0q2esLd1H+P3dOw6DX8u0Km+r77lp2a6sYbyFhK3gGFa51x13I/tB4MJdehFzh+uH6YFIBYmANFQvrzxuw07pivcoJTr4CyoyxdrbJvoyjrkbwipvgIDkxRpxDG3LlQMb1lvsJkiyMX4U8YooFzKnQvpUiWQNDdQAiMXvSIKcG+18VipoKiCxEFSy4FnWJMp9jK9e0BRr8MaAFRx+ZXHdlZA1WbXH0MHwkMP6A3o6AJc47ZHERSIutW2L3WkI/hDeGIJEODP3xKomI/jjMJzP6mFjyLKpQqN316m+H8MqHtvoWVOYBKZseEQwUtg9g4QKxrvXDC5opVH/1vaSKGjBc31BUwTO3zW78xSqz4rivbIaK2nxXyjThp4Zuo7IEbsgKcKVpg7lWx6v2uLevkGjFP1L8LwGKxBt/MItRJ4H7TROKNgEBYTQhLK0F79SwzxdwG05OF2zmF1PV+3ZHryJxhGehVKOSsm04FG6ZxI5miDQ+NQgaD/m/uNNFVBaOcuV5uQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR11MB8508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(7416014)(6133799003)(18002099003)(22082099003)(921020)(11063799006)(4143699003)(10067099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWFzdXB3dW4vdVVHTW0va242N0JPS0pMcGtwODEwdEFPTUU5cm5UWlBLL1gz?=
 =?utf-8?B?Mm1RVWtPMlJIb0tYL3o5eXZTYmxrYVpIcUZCV2lWb0JYM3YvZXdSNE9RNm1V?=
 =?utf-8?B?bEFBVzY0b1pWL1RtRUdYbTdPZ2JmaEVhTWpWbGdiYVREWmxTVGlNczVXQURo?=
 =?utf-8?B?aHNld2JkKzFBZEl4VDJIVlYwVzNBWlo3d1pYN2JlUmcxeXZQbFF6RmNTSmNq?=
 =?utf-8?B?SURjOUZybWRySWZWMkF5TWFKTEk2emhXNGdvTnJ1bWVDMm1TR01MVGRxUXM4?=
 =?utf-8?B?RHFMVHN1M1k2cENzMk1wRmY0TkhyV0xUSnBvMGJNVnFId0RMSnhGdkI4aVpt?=
 =?utf-8?B?NTdMUSt6R25NWjROQlByWi94dzkzYmxKU25PSHdOYWNFczFrb0lpbWJhcEpj?=
 =?utf-8?B?RVBDejFnNGEvVW5GTWdmTmtMNlNwVk4zNXZGNjB6TSsxUTQ4Q2poTVZtSW5t?=
 =?utf-8?B?WGE0VlNKTlBlc0lzRURyZzhWTGFvYXlCcnRZcytYaVhNdTNYZXViUkpsemM4?=
 =?utf-8?B?N1MvL2ptZzlSalZhMmQ1TW9ZUk1SekpmOVQvY1FpVyswak1CYW9XR05sY1dy?=
 =?utf-8?B?QXM5UUp0VFo4c3U3UGN1Sk9DZmgwazZJN29SVGJnRm5KZHREeFYzbVZMN2Ir?=
 =?utf-8?B?S2RTQnhwMHlPdE56UXlrRnN3cVp0WC94aVZuNHI4Rk9TOENGSjMvM2RpQW9T?=
 =?utf-8?B?UGRER3pmcnhBaStNTHlCZUtVUDZhdlJadENROWNFVHVoOHRubHpDbEtGT1JF?=
 =?utf-8?B?dCtkcjliREtSSEZMbm04ejZuL2tnaDJ6TXhXWU5kSENQcE5QV3d5NVlsMTZw?=
 =?utf-8?B?enRjTmVWZkxKZkFhYTJEMHpJOGhTMi9talg4YjN1b01wQXdkbXRBWDdKeUtO?=
 =?utf-8?B?M2dhYmxQaiswdUcxMEhJVWo2VG9sczRaRjNHck44MWhFKzR0T21GZS8zNDNs?=
 =?utf-8?B?ZmNYZktxTXBhSUJKSVBDQjlLZ2tXNUhyQTRER3RyZUdVV0x1K0QvVDEwUjNj?=
 =?utf-8?B?MnAvQUVlVmwyYVVqZXYvQ1c1UDlZa1kyQlpvTkFJTzdSS0xBdTViK0VoTnEz?=
 =?utf-8?B?RHFoVzRBVU11SzRpM2o4NXhlMjgybTJMcGRuOFo2U0JFdjJ3ZEhoRkJpR2tZ?=
 =?utf-8?B?TnFXMktlRE9XQkQ0L3VLU1FKTUZyR0NJcFVRdVdGS0J1cXlLRnZvUlV3MzMv?=
 =?utf-8?B?bEdwSFBNUFZERnp0OWwyRlVhYkhMZmt4VWlHN3ZaMUw2UFUzTU1EY0VTdnlW?=
 =?utf-8?B?Q2JPNVU3ZEdaNlNiZ3ZFUUh0bkJjTW5SWjlEeUdQRGFHUGRIaGhtUkpEZ0tO?=
 =?utf-8?B?QlNCVER2a01GNlN1WE1IMTNlWEwzN1lrbjNURWVUY0J5eGVObGNKRTRUUi80?=
 =?utf-8?B?WjFUYWhhNnh4aTlwWmY2SnJxaWMyL3hTWjlKcHEyVWZhbDN5WjA5VVBjOWZr?=
 =?utf-8?B?KzV0cU9DQ2ZVR1BWVU4ySy9qblNibnFmc3gyZlNlb2RqbU94SDdpdjRqYXJF?=
 =?utf-8?B?VnlDU0Q0eklPOUZxemNNM0tDYzRIWjc0QkNwTWJleFZsRTdvSjNJV2k1UGw3?=
 =?utf-8?B?NklhRnZsUzYxTWQzUDJpVGJoQ3ZkMUlBS2J2OWxRcnE0a0ZSbThKWURyakcr?=
 =?utf-8?B?alhGNGwyZ0xxLzR3SFBFL1R5cm9BcUhnQkFKaFJVUlBmODZoRWIwMHNPTU1W?=
 =?utf-8?B?TUtEQTNiN0Z2UWlDZTBMb0FkcCtNTGFPYkFFM2xKUFVqZWdOcUd5NEd5U2RL?=
 =?utf-8?B?VGt3Z2l5L0ZrL0d1QjNtY002cUNOT09HZys5OSsya1d3T1dNVG1SaUMzMWow?=
 =?utf-8?B?S2lJb251aTIrSWRlQ29pMmYydXNpOWpXVlBrV2hsV1UrTVZDaTN1K1lkcUZ0?=
 =?utf-8?B?UnVQR1BZS1piSGwyRlRSWm5vbmRzZll2cnh1T2x3S0xqN0xObmxIVG9XRTUw?=
 =?utf-8?B?S2RweUllTmtya1RQZ2czd05kWWt4eTQ5RS9hbk9aT09wMzdoNnBjOURkNTNY?=
 =?utf-8?B?SGJWcjM5UWZSUjE3bExaNXBISCt1ZUZMeDdScHhNUUxRbTY3djNYcEEyWHVI?=
 =?utf-8?B?MEtBRjRyV2xUQlgzSzMvRlUvK2VXTzM5OVhiVnM0UWxYL3FaUzdDczJ1S1Bz?=
 =?utf-8?B?RWxIZjFUZ1FwVkJVNVA4cjk1dUs1TjFUTGloeFI5M1BMVE1TR2NLb1VDSjJ0?=
 =?utf-8?B?eU1oMjgyMEY3SjROTm90aHBibHZEUTZmL25rTnZudWpSZFFFVnlzVTZvRzJR?=
 =?utf-8?B?QitTTjdSZDJKUzRROXFsZERXbktGZEJUY0NkanVWM3ZkbVk3WlB5QWNYYjBM?=
 =?utf-8?B?ek9tVEtWWXJ4MUpka2RzeEp0NnU5Q2s5YU5MbWJOREY0aGs2bFJuOE9PVTRn?=
 =?utf-8?Q?bkKgz4sf+aX+ec9U=3D?=
X-Exchange-RoutingPolicyChecked: KjAZll801l2Um60yc664p7WJtSJ5LbGE0k991y0vw4PTdhXpQ2r0FE9HlrTXJ1PulcGz4dP0eQSfKbCHBJFaEpQaJlyYYNn0xduMuxIMccBZ9oGIh7jQbwosFeMrmMTP48XvXk1QyBpxR70iH/cK3hlj84ubSN/sP3OCQeVHhzQt1FayebT27VHxeJOnR2T6pTDRBXllPdGvJ6G/+E3Fz/4Rl4F1vY7QH+nMhgdf+r/3UsvfytP3ean79sAdueZ9W0XHdvNhmyS6pzdJAtJJrb+5vuVYJiaOMlT9pjL8JhCwhBi6dX5WhekWqBs9GdTfHqS4y817GRn8aMKb9pnUaw==
X-MS-Exchange-CrossTenant-Network-Message-Id: dc25f8b4-4ccd-4f59-f3fa-08df2e8b1d2d
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 09:18:33.6965 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lgGo/BhB34kyPRMCxlPq7wpmhKy7dYIhrIfwA7Jy0uZXGiQjXAgZttciRgJkgUmqd6On6Oa69caSf7Ha2gIzWKIIKP1KBTNXvkFYtqB896M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CC6PR11MB058488
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
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/19/26 12:51, Aaron Ma wrote:
> Adapter-scoped synchronization must be available to Admin Queue users
> from initial queue creation through the last teardown command. Probe
> currently obtains its adapter reference only after hardware and package
> initialization, and error cleanup and removal drop it before hardware
> teardown.
> 
> Acquire the reference before either normal hardware initialization or
> firmware recovery-mode initialization. Release it after hardware and
> device cleanup, balancing recovery-mode probe failures and removal too.
> 
> This establishes the lifetime prerequisite for moving package ownership
> exclusion from a module-global mutex to the shared adapter.
> 
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>

it was me to move hw init before adapter init, to make hw details
readily accessible to the adapter

but I agree that SW lock protection covering HW reinit will be great,
and my needs could be achieved by other means, even if less elegant

so, I'm happy with your patch
OTOH I have a big series that git-conflicts, would be easiest if your
series will be merged first (so I will adjust), but I don't want to be
delayed (will be CCing you on it going forward)

the real thing is of course the 3rd patch not this one

> ---
>   drivers/net/ethernet/intel/ice/ice_main.c | 31 +++++++++++++----------
>   1 file changed, 17 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index 164428ba116a0..ddebb28b2454f 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -5242,27 +5242,29 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
>   		hw->debug_mask = debug;
>   #endif
>   
> -	if (ice_is_recovery_mode(hw))
> -		return ice_probe_recovery_mode(pf);
> +	adapter = ice_adapter_get(pdev);
> +	if (IS_ERR(adapter))
> +		return PTR_ERR(adapter);
> +	pf->adapter = adapter;
> +
> +	if (ice_is_recovery_mode(hw)) {
> +		err = ice_probe_recovery_mode(pf);
> +		if (err)
> +			ice_adapter_put(pdev);
> +		return err;
> +	}
>   
>   	err = ice_init_hw(hw);
>   	if (err) {
>   		dev_err(dev, "ice_init_hw failed: %d\n", err);
> -		return err;
> +		goto unroll_adapter;
>   	}
>   
>   	ice_init_dev_hw(pf);
>   
> -	adapter = ice_adapter_get(pdev);
> -	if (IS_ERR(adapter)) {
> -		err = PTR_ERR(adapter);
> -		goto unroll_hw_init;
> -	}
> -	pf->adapter = adapter;
> -
>   	err = ice_init_dev(pf);
>   	if (err)
> -		goto unroll_adapter;
> +		goto unroll_hw_init;
>   
>   	err = ice_init(pf);
>   	if (err)
> @@ -5287,12 +5289,12 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
>   	ice_deinit(pf);
>   unroll_dev_init:
>   	need_dev_deinit = true;
> -unroll_adapter:
> -	ice_adapter_put(pdev);
>   unroll_hw_init:
>   	ice_deinit_hw(hw);
>   	if (need_dev_deinit)
>   		ice_deinit_dev(pf);
> +unroll_adapter:
> +	ice_adapter_put(pdev);
>   	return err;
>   }
>   
> @@ -5377,6 +5379,7 @@ static void ice_remove(struct pci_dev *pdev)
>   		scoped_guard(devl, priv_to_devlink(pf)) {
>   			ice_deinit_devlink(pf);
>   		}
> +		ice_adapter_put(pdev);
>   		return;
>   	}
>   
> @@ -5403,11 +5406,11 @@ static void ice_remove(struct pci_dev *pdev)
>   	ice_setup_mc_magic_wake(pf);
>   	ice_set_wake(pf);
>   
> -	ice_adapter_put(pdev);
>   	ice_deinit_hw(&pf->hw);
>   
>   	ice_deinit_dev(pf);
>   	ice_aq_cancel_waiting_tasks(pf);
> +	ice_adapter_put(pdev);
>   	set_bit(ICE_DOWN, pf->state);
>   }
>   

