Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6793CE91290
	for <intel-wired-lan@archiver.kernel.org>; Thu,  5 Feb 2026 09:01:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 36D1F83FAD;
	Thu,  5 Feb 2026 09:01:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xFdThKMSmDvS; Thu,  5 Feb 2026 09:01:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 53D6883F94
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1770282105;
	bh=+lWsVW3dizc8jplUsXdA3xtAbXOH2xrWoHhn49V9j3M=;
	h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G2PmcoG6eOfrLi1m446R6NYU5vKr3liMpnK6PtCzt2I6qCNOyTXeVu67gCoeJIO7h
	 UbsxKekHoKJJdd6x5NhFAbP1L3PcFAXeNDjPnD/ZRSPBoDrsfOApQM/KKkEkix3Ycy
	 1tiHe5cpmOKDWVdaODqIpqyzMbp6UqPxXrlCiuPKmZXytc7MQZhGGbFnl9rYvirkGD
	 wQ1Ifkh1hUSZnnMZL/tX4SW+K02ll4E0U6t4HOMkGDAnPyRknq++pVGe57pt2hxn92
	 bQLQboaNQrUMrTygRT8HY7ZTW+jq9BkKRSxmChDrHMHJhT26NXyGcRUfxWuL8m9hfn
	 OWspOKkoZh45Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 53D6883F94;
	Thu,  5 Feb 2026 09:01:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C5A40F5
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Feb 2026 09:01:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A72A74009D
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Feb 2026 09:01:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e6bKMKbCObJM for <intel-wired-lan@lists.osuosl.org>;
 Thu,  5 Feb 2026 09:01:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.10;
 helo=mgamail.intel.com; envelope-from=arkadiusz.kubalewski@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org F146A40088
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F146A40088
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F146A40088
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Feb 2026 09:01:42 +0000 (UTC)
X-CSE-ConnectionGUID: XtBIiC+2RwWYhxpG2v5emw==
X-CSE-MsgGUID: 57/tb09hRkGjLfbtkdRzXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="82847104"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; d="scan'208";a="82847104"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2026 01:01:39 -0800
X-CSE-ConnectionGUID: Jo/M09/BTeGdjHdSw3kKhA==
X-CSE-MsgGUID: B1svGZZRRQG68O0GrU5ihg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; d="scan'208";a="241093098"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2026 01:01:37 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 5 Feb 2026 01:01:36 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 5 Feb 2026 01:01:36 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.9) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 5 Feb 2026 01:01:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JBG8vx0F4CK3NpRjkfOGTncrz1cBfP9STiT8G5nvlQ3fUrcz2msk7uI01un1ECXSazP3zAfTNKOD+yYBPFpJLnXuLIqJxmJnAYaQsFF3DUp+H6UHJUKiVT6Xl2qTnl99ueTE9D+rNNAXJug5LsVfpsj41S0CHaj/6ogEsWy7c8qlOYKT91cLpn2bApCCqQj2Nl+ydtGfaV87STM+PGYhfQcztfe4CquCm+27gaq/TM3T3PtcMbBnwIE+8ZtvlSUBYB8Jd+nH4kz3LTD8zU/1SNffBt7MXWpWCmTam0m8tY/9J71h8NkMbbTZtWKR2fkJazjm24Ujvx8KwFZcuyhsIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+lWsVW3dizc8jplUsXdA3xtAbXOH2xrWoHhn49V9j3M=;
 b=PhsmxG29lap/w5pQ9p8iQ1UWYx8EnnMAQ0JCcrx013lCi6/wv2C0jXTPzS/EVJG08q39cNzHv6xjIfm75nKPStxuG77MX694w0QLDWqEpQNSI6Zx0ECJBIBprTBJx+2y97isYu89O8l8+nw7kI3CipBEmJ8a0D+QJZQZ0t+p6zJJXOk+bMrmabgI/KAeuD+nnIybgZ8DoqHQ8tvUIj7YnH1wte5bXAYTlBoAkHbvn9KYsj7+c8zfRk4hLB5ysheVe8ZhqvF+vdyjgE4SWNbDJcTkxj+OksOFt2vjdsYLsoS4gsG5bxhdQelU0kTj2cQ8tOFrJ/NLdhREjjHFgNbFIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV4PR11MB9491.namprd11.prod.outlook.com (2603:10b6:408:2de::14)
 by MW4PR11MB6887.namprd11.prod.outlook.com (2603:10b6:303:225::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 09:01:26 +0000
Received: from LV4PR11MB9491.namprd11.prod.outlook.com
 ([fe80::6f0e:9ee3:9e98:1ed]) by LV4PR11MB9491.namprd11.prod.outlook.com
 ([fe80::6f0e:9ee3:9e98:1ed%3]) with mapi id 15.20.9587.010; Thu, 5 Feb 2026
 09:01:26 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: "Vecera, Ivan" <ivecera@redhat.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
CC: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, "Lobakin,
 Aleksander" <aleksander.lobakin@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Jiri Pirko
 <jiri@resnulli.us>, Jonathan Lemon <jonathan.lemon@gmail.com>, "Leon
 Romanovsky" <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, Paolo Abeni
 <pabeni@redhat.com>, Prathosh Satish <Prathosh.Satish@microchip.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, Richard Cochran
 <richardcochran@gmail.com>, Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan
 <tariqt@nvidia.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Vadim
 Fedorenko" <vadim.fedorenko@linux.dev>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>
Thread-Topic: [PATCH net-next v5 5/9] dpll: zl3073x: Add support for mux pin
 type
Thread-Index: AQHclTRIHFbA9XxxlkeIRtKjaQJCV7Vz0SuA
Date: Thu, 5 Feb 2026 09:01:26 +0000
Message-ID: <LV4PR11MB9491A19B076E218F8CA0546D9B99A@LV4PR11MB9491.namprd11.prod.outlook.com>
References: <20260203174002.705176-1-ivecera@redhat.com>
 <20260203174002.705176-6-ivecera@redhat.com>
In-Reply-To: <20260203174002.705176-6-ivecera@redhat.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV4PR11MB9491:EE_|MW4PR11MB6887:EE_
x-ms-office365-filtering-correlation-id: 85b130e8-5629-404e-0b9b-08de649524c4
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?FWZ66C8t8BVBwNOir6HYzYnCUV12MCLjacBtx2MmCERbUFpJ7g9ZtqEmSJz9?=
 =?us-ascii?Q?6RHsKsf7PqLMv86mFkh/i0nC0s0umGFz+DF9mEXZNGeahVCriTRDxlkxzY9m?=
 =?us-ascii?Q?ACa5s+QZ37D5KlFlL6gTHdEkyHePOlU0J3z8w0yLKfuKG+iB89cf3J80ebCz?=
 =?us-ascii?Q?Bayi+PSL57MYr3ybZjVRcGR0a7WUxMub3Y/2+VBm8kUII0EUvC9MPnKbN/Ff?=
 =?us-ascii?Q?C8+LPzQ/HvsDRSbuIPN7xtQaGyodCWDYj00WDgrlMZQXlt7C6d9cIYdhwMZK?=
 =?us-ascii?Q?4laJaaJuAedbBq2fucw39o2nG9tR2oEhMoILdyoyjaHJDNIROx25U/S9h1VL?=
 =?us-ascii?Q?u4HfBfKWNDCAuQ/30OcHAZ9MyIjzkCNdRBqd4ZSii+f6vtVEa+Xo0KpK0/IZ?=
 =?us-ascii?Q?NC6JKpcAV9RxOU80/p+SzNRd32Kbvo/GzSqFmadgWwIb1FOSqSwPK2NrAUgx?=
 =?us-ascii?Q?tcJbfgdEoRphCaP4qJZVMzOvrBRb6PKf/Y3b7neXFf/GnnCYV69cnPTbqM8m?=
 =?us-ascii?Q?JXPvLLvdxi7EbMgCd4Zqbi3VKV2IrKrabmJexU7L7k5cSaSebTrlBLV5vo6I?=
 =?us-ascii?Q?mJG+oOPlCSFNT9mlXlKOu3IVlyT2pqP+6v20oP047avXyGYHi8bDF50EWRYV?=
 =?us-ascii?Q?ADYfUMOCMMYdjXkyB93z5GdQiTAVyOIr72lV6eDJ1+s5R7q+wvpRC9zN3kUY?=
 =?us-ascii?Q?OBbDlqFngIcmte0GeEVGHwDJQUIpphChB0VNreVxLEv5YO5D3EVmZ5v0+2Zh?=
 =?us-ascii?Q?diGmD8/WSfn92eyrg9vzpiAUEC8tTkXqQjBcRIsTKIdX+pEhm2DDBL1vTmi+?=
 =?us-ascii?Q?1Q3iSBx2qctEOSBT9L0W+w9wlNyepKOl9kqJOLSUZk4QcD6F9MPfGrcd7+hw?=
 =?us-ascii?Q?kFBC9QijtdUi8AukyIso/ljJMp0B6ynIdV+qqVv/p0grl/xb6KNuHzfgj8V0?=
 =?us-ascii?Q?xleQZW48pad6jUZu53MIvMi76OCWTsUO4G72fiIPdgBK7d5HHAnhY/VGNpR5?=
 =?us-ascii?Q?zr7GcChkTb+t0Zfis0GcW2vpepoSxwm1TJ3HRlMiCJIKZ+6Awed0B2avGhtX?=
 =?us-ascii?Q?I2/XSgdV3Rm4ZncgnO7IB0XNFq7tuoxncAnEuB+HWfTq2El2cIW4JKEow3ht?=
 =?us-ascii?Q?rfkk1hi3t34Z8YVlw7pXxzhuwCJiUhOvktXEoaRMtGYt2KZma9gd+T+ciCct?=
 =?us-ascii?Q?rrJ2ltfedsSWtCGSUrTASKevqEXuxaqKzX8xLVvlg/gCzvy+yXT4cSkGKRbn?=
 =?us-ascii?Q?Pu+eqCbUhIw72wdfH2hZJ/eFDaw7XHiyDPuKnv5eCIvYt7RHqGPheFfXeFe2?=
 =?us-ascii?Q?aeOATjeih/w4e1rkXsq9qZqZc8nCbF8bj8zAp+QH1Rd3z+JU+GOj2Yvxd8yR?=
 =?us-ascii?Q?1BZnyADipapV+7AaTBpZIt6ufG7aeexUFHgp1LQZPBaDHSgm5GONxXcebXmK?=
 =?us-ascii?Q?gwi7jQpl3GzKuCtMMpTKxu61+LILAOQ52AfgkFJZ1O0w+FpTXVvh3R9/c32i?=
 =?us-ascii?Q?MdeO++a1XFoFcbg37TjOVl9FuqGbjGgUMwQUHXOO62xVVTzqMifYd9teByhv?=
 =?us-ascii?Q?9TQFndejHIEIPI0IY5btQn3nCt4hR5oaQVrumz1+lBx/mBnng3qpjpJivjUj?=
 =?us-ascii?Q?2g0xm7g2POIB9eRSoDa+EyY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV4PR11MB9491.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ydPPJWy5ipGGczT/zOHHQzHEUwFgxFYltC0u9Re3pPTPnc7XDTZuXsncVZF1?=
 =?us-ascii?Q?r3pPzTfTMsCzeMyYO0Kgy9zz713bORHu4raOCgcXQToyTI+psbabZgssUNE9?=
 =?us-ascii?Q?u4bEyT1paOtu/a+ZVy90EJWKTp4F04FcwA37JkT1G+qOWR+WZuqU54xNcrJK?=
 =?us-ascii?Q?OarIpKs/X8kG0ex5ZUOLSn8G0dmQHyLqWHw71hpjZjJeOh6tX6IHkgP9ZU52?=
 =?us-ascii?Q?7MurwmrtJ8ChhnSb+pP/cF+lGurENGEgcXPN3PDXoTC+siqG13XiJUbQ+0id?=
 =?us-ascii?Q?piVLyKtD/RRBij+MBvjOYkx5Wn5oPTHaMCfrACdyNIvEUG2khKUiJeMyucCB?=
 =?us-ascii?Q?I4nOf8yYl+UQheHMBK40fPw6xQYrO+HZ0fHkIWmq1sycX/oUYhAG48MjL9e+?=
 =?us-ascii?Q?pbmdI+gMH76jOaEI5PqSKkg28VBiSUwP3+DHQ0y+5jyv1c61GkIx/AsXiRY0?=
 =?us-ascii?Q?JwOuclBoh7PX4I3Xq5qLjomwjao7Qae1H1ougRkgpqUuSHjjFQ8Es4EeJHfm?=
 =?us-ascii?Q?7jdOpkKec7tcgR51UUpsooaJitURAy7VZXEKT1mgInDtKCEmYEYzPawpUWgm?=
 =?us-ascii?Q?GoNwX1Kcr/Zy45zQdsE/pWTP2y0/kElsIe0EgnGul/DPrt19X0Nk2dVtjClq?=
 =?us-ascii?Q?lZhDHc81nxWB4P7fOSf+9VHIWRpK9c8nS5UM21rz399Ha2HdWgAa2WOt2jAq?=
 =?us-ascii?Q?8aP7UdueylNtcYSYLPVtHMP37pIt6fo6rtwAGXItfvIVmNwZjSP38WSustDI?=
 =?us-ascii?Q?mPQjPMOWG9MFTshH1dM3Vxb4LKWQv1J0MvWaLM+oC+qcF9B5o2rBbAM6ukt3?=
 =?us-ascii?Q?R7XZnY7zUIqitvd0se0mjVDIoKAurbPas+nX2TxUrNrJx6KPYOQX4VnKVltj?=
 =?us-ascii?Q?AsEU/leclX98h2AFhdM5DoHnoxGW7vhD03RQHxn24H/fHz7mXLpmahZ6PKOX?=
 =?us-ascii?Q?Ev5eBnuo1KgqstB70Ot+p1eVMUjtxnYPNqgGTkoiyNIZBbPn+e84yVpo3ezz?=
 =?us-ascii?Q?ybez8lRvZX1PUXPRicMWMd3GOLvpPlJM3h2oXXNCReFvWW8Zndzv8uo4gdEO?=
 =?us-ascii?Q?5VCbR/wx6YRyUY4NRZxoxDbhu2nPBwls+b0darS6C4fOESUE+RK4DB+1kZTU?=
 =?us-ascii?Q?dNwNqxW8Hm19Thg1v2phNpCYGQhc/k12a+YQh6cuTvCp0RhzGiA9SRYZrPNS?=
 =?us-ascii?Q?Ws2H6YmDlX5l8pG9dYVJ969hSTPEa2ejPXSU2vTJvo4kuoJzcZIM2X26yd9u?=
 =?us-ascii?Q?qxmzmkpFxBUsl+w2aa552utJJWF2jGsRxgFEXU0YyI2eUZiAS9FS5h5l/90G?=
 =?us-ascii?Q?PYEI8XPIsR4B30jQAga6mpSeH50CmyRvkK2KLCLUtcV822Ymy8VALlLC0O+f?=
 =?us-ascii?Q?eroBk6ar5vsZKFCzOrElUYPO0Ype1WDUwhZoX2aMxSZGUjeP1hH9nCw63+fe?=
 =?us-ascii?Q?6aismIlxCF9SjK85Fu5/EphO7pavTwLe1v/moAu3m3ogjhNeTvg7FR8gXCaT?=
 =?us-ascii?Q?hVA9Gjjz/IU0xljoTeMpT05y8yczASW5VAAkBZhjFF2r/gQz9rYXPzomLt7A?=
 =?us-ascii?Q?m6W0JGPIl0mWO6Wx1gTh0wpu0yLvSEGhFxO5CzdLmODDWiEUk80SV34I6Vpo?=
 =?us-ascii?Q?mFvzIxIWfB++yRVGhfhORecNpvIuK3QI4N/VOmSPWIIR4E+mwM8jeKQdQZUr?=
 =?us-ascii?Q?BAMjAY478eJLuND89+1xaCjCwHa/AoYnPqcl3EXncsJDoJkJYBzl3qXIMakG?=
 =?us-ascii?Q?C0VmUj9izwFBS1s1nL68+OESxGzUaBw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV4PR11MB9491.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b130e8-5629-404e-0b9b-08de649524c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2026 09:01:26.2418 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5ruPbTcZYvqZzp4dBThDTRCQZBITog5RD6YOTfV4AioV+1nMmr6NrGAjugrmb8XpvGQRryb3R00NychM1CKmIqiOS6FPsJChwiAbTo1lRuM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6887
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770282103; x=1801818103;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ssN+adMLy4+7Iuvru39EuIi7g5QbseOa3JDuw41YI1I=;
 b=mVS3ghZECnwOPw8CF6pAXTmZtprzw/xw8GsVIQkBGW6wCy8lQeBnxvf4
 b4D+oceOnuJRK0q5W7Naea6fcxZMOJSMRmZ2qLmiwJm6eybYQLDHbE1bz
 URTtt7jw4SwSHQavmY0oQqt5OpLdHgWsG05VLFdpXJLSS+aFFYrm4dEGv
 9r3kr5bybGolV6zWz0TZ/k43LMwIrrG78L0F4KhFku9z/4rRkb5CkOLCz
 0K28MMppaaQEIJnoby5sOtHsxZ3SiqsI2TFWDKSOXBHMIJWzWSvBX4GpU
 jF3CpXik2XStenyO/ALT3zQQohrxngtOVoWmVyc9HFbo0JVuinmZLlJNz
 g==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=mVS3ghZE
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH net-next v5 5/9] dpll: zl3073x: Add
 support for mux pin type
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Unsubscribe: <https://lists.osuosl.org/mailman/options/intel-wired-lan>, 
 <mailto:intel-wired-lan-request@osuosl.org?subject=unsubscribe>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

>From: Ivan Vecera <ivecera@redhat.com>
>Sent: Tuesday, February 3, 2026 6:40 PM
>
>Add parsing for the "mux" string in the 'connection-type' pin property
>mapping it to DPLL_PIN_TYPE_MUX.
>
>Recognizing this type in the driver allows these pins to be taken as
>parent pins for pin-on-pin pins coming from different modules (e.g.
>network drivers).
>
>Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

LGTM,
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

>Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>---
> drivers/dpll/zl3073x/prop.c | 2 ++
> 1 file changed, 2 insertions(+)
>
>diff --git a/drivers/dpll/zl3073x/prop.c b/drivers/dpll/zl3073x/prop.c
>index 4ed153087570b..ad1f099cbe2b5 100644
>--- a/drivers/dpll/zl3073x/prop.c
>+++ b/drivers/dpll/zl3073x/prop.c
>@@ -249,6 +249,8 @@ struct zl3073x_pin_props *zl3073x_pin_props_get(struct
>zl3073x_dev *zldev,
> 			props->dpll_props.type =3D DPLL_PIN_TYPE_INT_OSCILLATOR;
> 		else if (!strcmp(type, "synce"))
> 			props->dpll_props.type =3D DPLL_PIN_TYPE_SYNCE_ETH_PORT;
>+		else if (!strcmp(type, "mux"))
>+			props->dpll_props.type =3D DPLL_PIN_TYPE_MUX;
> 		else
> 			dev_warn(zldev->dev,
> 				 "Unknown or unsupported pin type '%s'\n",
>--
>2.52.0

