Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 055ABC5DF7D
	for <intel-wired-lan@archiver.kernel.org>; Fri, 21 Aug 2026 20:59:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8C9B9409D7;
	Fri, 21 Aug 2026 20:59:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 00uWo_MKaNov; Fri, 21 Aug 2026 20:59:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787345975;
	bh=LebL994XkMcN/9zTWfEffqb7UQOujw6A1rp1cyz9GW8=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cbOlc/dRHu/abdyCVxbxogPlnChNE9WpHiETitaGl+UFQbMMsrh9Wdk4UJXzf2kD5
	 ElV/PLZI10gV3ZJpF0OCMqXOW8EFrH+MV2iTE8hqVC34he0Vl3+OCd9QQcKO/X1NTx
	 tAAMcXK/7t+0M/oQahIa+lps6vZZuaTkqvHQkOpi42EuAAn6ym9HwfN2dx/7Tzoad2
	 KRb96UNfM9NN57nPyK66gDyKuUY1iR/4wdtJ7QKrkvw1J3NwKrx3mj8bOvH9SIHjjf
	 iRpVZfWmKWkIHCK4yCJiHPXwnoBdEDCQ7AeQU/EsOgkjoGdk7qHplC4+Wy75jXAVwn
	 cEqZ9ijbMIYcg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C3B2940816;
	Fri, 21 Aug 2026 20:59:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 03104386
 for <intel-wired-lan@lists.osuosl.org>; Fri, 21 Aug 2026 20:59:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E8EF440447
 for <intel-wired-lan@lists.osuosl.org>; Fri, 21 Aug 2026 20:59:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xmkiJGSd87BN for <intel-wired-lan@lists.osuosl.org>;
 Fri, 21 Aug 2026 20:59:34 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.9;
 helo=mgamail.intel.com; envelope-from=anthony.l.nguyen@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=AFiR91Od
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0CC134024D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 21 Aug 2026 20:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787345974; x=1818881974;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=QdGEGlxGlnZNuREN/7k5kDYI4hboQnEeZgGn7L1+8g4=;
 b=AFiR91OdFkPVnvRYyp2rjAkuz3+MKt1n/uTWoN+Sq517e+t9LWHZWbXc
 ysvn6+QcBERMWWx6Pt7XwMxqtr1oR4T0Lgcvr5mvzKobYtfUD40jSqJm7
 CxbSqbCXWFNo32lgmAwVK0fJA78yh+75GvuuZ0kwQD38SgaTr6L9kqf3X
 kxd2TwTW5PhQ8qrOKoA5HeEppKhOY+6rPwhMl1FqQfGOZTnpeQWJ2dC/o
 e1Mey6/CIhJhGXnmdzx64yjMvxXpNSIAWiNbiiJxWaSPJfXSP6YPDg+9/
 VVMWB7mFslE0ddlJPqPiHN+RFwoPywXaUEZmJwLq77VLaNQk3bmMJXqM9 Q==;
X-CSE-ConnectionGUID: jJIoWtj0SGSOzE3Ystfe4w==
X-CSE-MsgGUID: LMTG1JMaS12BY+9nzwCeJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="110686856"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; d="scan'208";a="110686856"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2026 13:59:33 -0700
X-CSE-ConnectionGUID: 4wUPg2sZSZ+F6LZDvhkpGw==
X-CSE-MsgGUID: xVNzzE73TOOr9MODuBJU7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; d="scan'208";a="260297792"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2026 13:59:32 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 21 Aug 2026 13:59:31 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 21 Aug 2026 13:59:31 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.47) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 21 Aug 2026 13:59:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H72DcxbfNBgyg1kLJIvDymPEtsywYqEZB/SIwcC37bj0RNmk6a+M49v90z3OwjR2dfm9836/iGrsHQnSZFTHt6Dv+rTJkxF6Ydd5X/gZFiqoNBpgHcAXBQQyVz/5N9urLuAaFTVVKqrMlZo8KjrFnT08WRTYxGsC1z3Se9giz5WTh40C0iLZ/svgXvJeltLNNXoxZE5pPfljAmwWVWACWXc7paHqjyJbAlv5lgEQSjx5HrZiZj7MB6uzfRpC00ltuX3XVVWwdNzt7zAAUntZb6IfIUiS/T7xv13UIZTyQuD1hUsp/G5FZR5hOgcEw/FxIklbKCoEmwSdI+0gzmrpOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LebL994XkMcN/9zTWfEffqb7UQOujw6A1rp1cyz9GW8=;
 b=VjSs5Pj6hY5jG3/d3cQDt113UroO+zuKb3hgCypD0R1oF+AKQDI9lLBZPIIZ0xRaXFJ23MGjI1PovOWgYLjya/TqsPmTQ49umHB23v9Sme1B6z2khw5oPPmgy9h54gAhZyqJPREbtBPdm5QzCdYi136li9GtRe2T2mcGjd5roL0nj159flFxPYjh2uEJojJ9yDpsAR08z05wfWXAhSNqOdElXvsYGz3HDB2tEbs6tlzG2huLpsMEhZ9/EG+XPF6YA9DG9PiTr9jbczlMEJbvTUhQUqTm0vzc4IPeUWmEsaAb6TV7WcKFl0EEhP1vSFFJEoA2Dr+MwJIDk7IWUhqOYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8230.namprd11.prod.outlook.com (2603:10b6:8:158::21)
 by SJ0PR11MB8272.namprd11.prod.outlook.com (2603:10b6:a03:47d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Fri, 21 Aug
 2026 20:59:28 +0000
Received: from DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40]) by DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40%5]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 20:59:28 +0000
Message-ID: <477734d9-ed8e-4696-8160-382b29e7491c@intel.com>
Date: Fri, 21 Aug 2026 13:59:26 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ice: rephrase LLDP filter fallback message
To: Thomas Bogendoerfer <tbogendoerfer@suse.de>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Ertman, David M" <david.m.ertman@intel.com>
References: <20260717084453.9521-1-tbogendoerfer@suse.de>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20260717084453.9521-1-tbogendoerfer@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0344.namprd04.prod.outlook.com
 (2603:10b6:303:8a::19) To DS0PR11MB8230.namprd11.prod.outlook.com
 (2603:10b6:8:158::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8230:EE_|SJ0PR11MB8272:EE_
X-MS-Office365-Filtering-Correlation-Id: b6598860-a666-48ab-e40a-08deffc71700
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|10067099003|6133799003|56012099006|11063799006|921020;
X-Microsoft-Antispam-Message-Info: HqaZYyRXaqpnYAVBVpQ5VKi1dVzAlFG3y5tW5wpBcJxyigkECWlb8gzEk2Gpm8pcOLkDGwif7X50R3IrabUwTVgOgj11DxLIs2dZnH8QhIFmvKQtXwmQTgv7RQ+l8YIqyAWYbL1m0IQLSn4Fx9CARNPKlcR/3W7kvWR9hGCJkpAaiHuXnlUapGd0uarSOkbL2omqliSROVfnf7BNGjXV2xwk6+Hx7HKyoVaawNkOt1Wy3fX1+jfv6g5oxixanoIlL0KUodvSIedsJyBH2uInDLBmtD5baNVbS5Z+x7MSRN8kAm28iKYTtXxRE2G0K1ccU+4aZ/ZmOZnx7sSsWikZ4V0lTTKopC8JkEoAOKTcJk+3JlTC08P2C1MTovTpYOzp/namEAU1JHPtGiIKvJF3CYFUQ1/H4WR60wh5ZDRWl2fjClczZxRI77cXDUG6OVJ4gfkYgOh+pDffzwOUj1eq7oP0Fm9AkLJCoW4KXXpV+olxx6wqwDF3GBDVP7JTMRjAb5lirpWrinHJxcovGxphdy5SYh1Ra8ek4ExO8X5mlODQiwq/NxTTfkcoDooK7xPkglSDk6TaDxb9qNCa2FCsucXGqlCnz4LMKpAk8DVSiAmIGViCYHZmiszX8jmazB4tacEPZHutlcDAOBQQRCG3o05nKTCNhA7O7RgPxyZxKJo+ESPYD1NE0vXZxtpj/7eg9z8xME2ytYfVNK60hjle3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8230.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(10067099003)(6133799003)(56012099006)(11063799006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWM4bUk5c3lwVEtHaTNFdExoblhJdzVtbE94emc1MlJWZ2hzRWROWG1POG1K?=
 =?utf-8?B?ekhwSVpXUng1MXk3VjdMMG9JemkzblJoNWRuZy9icGdOTnhkZXpFRFMrZThi?=
 =?utf-8?B?OFJ6MzZaWXRRaWN4U0dZSHhhaG11amZvS1BQdmJRRGFLeGllSlQ5emkwQ25o?=
 =?utf-8?B?ckxycFErc3lDc21YZXZBd21ad3FiQXg3Ni9rMzNzN1JPRXQrNS9iWWg5U2tJ?=
 =?utf-8?B?Y0VwaElsMS9hbDJXcEIzbmRUeWkvMTZMVlBmYm5MT1luSEhQcFJmNXRHbVRq?=
 =?utf-8?B?bHF0a0lmcy9hcFRvZHhNMHR0TmlEMUdRMjc2b3pwWi9CQTJrRHR3YnFXdk0x?=
 =?utf-8?B?Zlp3NTFYcW5JZHRtc0xiZjBSbWpjUklpaFlkSXg4T0xKNTlXVmp1Q21NanlG?=
 =?utf-8?B?cEIzWkdsUElPbnJQNlV0Q3IyYkNQZEtBTXZ0cU9kZlVSS3VDVmVJaEFML0xL?=
 =?utf-8?B?ZHR3WVRNMEVNZnhUZUh3MktLSnMwV04wTHFOWU5vdFV1NE5ZRHBvd3YzWExC?=
 =?utf-8?B?OU83U0ttTGh6QmZQaHdiU0pRejdWVHhweFUxVi9yNWVSeW1wMkRIV0tyK0RT?=
 =?utf-8?B?SnFCQTNHS0ZIU3BIWW1xSWFPOXlpTm9xZkJNdHhSVFpuVWtkWGtvQWNnWTJO?=
 =?utf-8?B?dXA0UENPMkhnSU9TbmwyWm1TNWg1RUhVaWdOU2RtbG40aXdseEdiaHFKcVpw?=
 =?utf-8?B?SXlVcHN5SXliVDVZL0x5Ky9zZk9YVzRnN0NjckIvUGJXQ1dtaTUrcW1jNENw?=
 =?utf-8?B?MEVOb2ZhcFB1dUg2YTNCNlpzdXE0ejhjN3VsWW5MZzZaZ1c0Zkt1Y01HeHlx?=
 =?utf-8?B?cVh3NHVPTG9XckI4K3ZIZnJzc3gvQzlxZGNvRmdYbnh3MThVMXV3cDRJdE0r?=
 =?utf-8?B?MDJmRm1QM1ZQczAxNHptb2hFUkp2RjlEOXdCRmxjSmRMdHgycExaV2JmeUly?=
 =?utf-8?B?R1BKQ2JoZHZxN05ReTlibFVpbHkyN0phK2orWVpGVlYvR2htNXZQKzVFUTV0?=
 =?utf-8?B?UmE1UGxndmVFckpDODhaTGRiY29EcUpXaVdobGhpQ2VyU2JSTXB6M3FrT0oz?=
 =?utf-8?B?akFZVDVSZUovdGdWS29QNmdXQVZuVFN5YjdzOU55YXBiSXh5ZTBjZjIxbzk5?=
 =?utf-8?B?NTFLNVFmaGhmRW85ejNSMkFGSjNiSGZvMC84WjNzYkVodHloZ1FpOFkxQmQy?=
 =?utf-8?B?ZVJVTW1JZG1VbDRoQXRaWDI5eFF4bEtMeG5oSlhucXpzMzVJd1J4REtGM2dx?=
 =?utf-8?B?QnFaYUoxaFQxZ2t0ZUg1UjA3RENEQ3J3TWxyZW1QZkxmN0VjLzgvdGgzcHh1?=
 =?utf-8?B?UkF2UVU3aFVsWXY5WnVaNFpXdXhrSERVeDUvc3BhdFBmaHVXNnovY1FFS1FJ?=
 =?utf-8?B?dFB5QldNY3c5WXk2ZHpwRWpCT0RlblF6c25JbisyQzdnSjh0VWRXSEt1NFNJ?=
 =?utf-8?B?Z0JVUG1rYTMzazFGbDhFUlpyblEzaWdqQ1EwRGdGa0JSQ2VVMGR3dFdzbmgw?=
 =?utf-8?B?TnZ5OVEwUStJYitrbGpCUVBZbjd4dThaSnNxL1huZXZNUXJOZVFVQmhoaE9r?=
 =?utf-8?B?Yk96MldvMjRJYlYvczIvUXh6VVNXUDJrSXpIUm9QeDJ5cUhUTVduV2d5RXRT?=
 =?utf-8?B?Kyt1eG1JK0V5eCtQeXA5K3FsS000T25wd0U5Sm5qem1Xcll2RmhNU0pYQUtN?=
 =?utf-8?B?aktISGhBS21GL2s4T0EzR0Z4R1A0UWo0NUI5YzJmUmdrbEIybXY0TzFWUU1y?=
 =?utf-8?B?ZnVaZ0VGOHFwaGU3dHJTMnN1NFlmVG9LSzM3blhIVEJMYU5vaEVrQTJFaFFm?=
 =?utf-8?B?UzFxbnlaL0RYZjVPR2JPSUlFQnVac1RJdTQvNFh5eVdqYVVzaFZlTDVsZEw5?=
 =?utf-8?B?Mzg0YjNTY3F2Z1RPL2NKTjlTRFpNTk1CMkhLc0FCWlVJbWhJcnd3WHVQSXRa?=
 =?utf-8?B?b3lsNVlKNUZDbnE1NytvNytLRnozV2VzSk1iNnNoWGJha1VGWFNCUUpoN3NX?=
 =?utf-8?B?dHFPQUhsYWtYaVo5ZG9wWS9GamozaTY3Smdwam12WkhCNmNRamlLeStCQkI5?=
 =?utf-8?B?c3pTTklhYW9ud3JpRmRkSzRFT3laamp2a01pblhHakQwNm51UFdnUjR0eG1r?=
 =?utf-8?B?OTZXNExHTVdJUUg4azhVMWlPSkVwcTlRd2FySS9IOHplV3FLeFA3Y2w2bXBL?=
 =?utf-8?B?ZSt0ZzFDUzVieGh3bzJwTVJqbFVMcENwamM3Qm1SSXhuM1R4N0I1eldFYVVB?=
 =?utf-8?B?aTdnZnpQUmtGNjZQdnRSMGhmTkxGQnA4SmRqT1JXMlFpRnBiRzJlcDRKNjc4?=
 =?utf-8?B?Ri9PZm1KQ2E4YWN2SVpXUkVUZUhON2YxMSt2N0tNNHdjaWkyeDcvcTFDNnR4?=
 =?utf-8?Q?FEZhKIBNOi5C+sTk=3D?=
X-Exchange-RoutingPolicyChecked: WiW75Z2RrqsqxgHwE3WasBPoC3L4DvzZMVni/DYHZDSdpdpt7jn3D0BKqa0hzZJCA8X7Aebs4JU9iiBFhwvE2HGogU1Trwn1JUxa4Oetx9Q5SbudAYmRiVAdZOPIYd0fFz5kCEXxxQhluBhZ2yUTJ1rLHucgR6uORfysrphL+IqyH+RaeudZ0+ioF8mSIb7rU89CL8GL1jVPhyoCyUX32x5v0jWMYVOyOcQZdvwD2AdyIVHrJEmL/rW5+n3/SXv/6FMV/87JpPgGj6EwuE12KVZ8lNJPCwFZWgHxah08KGzUSkgcXmbJ296j57lr2K9wst0DezTweSxSP0BqgUCrew==
X-MS-Exchange-CrossTenant-Network-Message-Id: b6598860-a666-48ab-e40a-08deffc71700
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 20:59:28.4908 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IXOrkcnaJuh3VhXH3/zaYl0Msb92P8MjcaWN2tfsn4vyk48qi3+Vle8R1WkU0p3CjGhQFIJk8QvR7qfpsvgfZCiyFQ6w3lYznqioJ+zp8D4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8272
X-OriginatorOrg: intel.com
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



On 7/17/2026 1:44 AM, Thomas Bogendoerfer wrote:
> Seeing an error message in a logfile triggers scripts/admins thinking of
> problems. The LLDP fallback message itself is not an error, it just
> indicates it's using a different filter mechanism. So rephrase to a
> less "scary" message.

Hi Thomas,

I believe this patch [1] will remove the need for this change. Could 
test it and confirm that it will work for you?

Thanks,
Tony

[1] 
https://lore.kernel.org/intel-wired-lan/20260811181127.1142095-1-david.m.ertman@intel.com/ 

> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> ---
>   drivers/net/ethernet/intel/ice/ice_lib.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> index 8cdc4fda89e9..59341b5a0c05 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -2097,7 +2097,7 @@ void ice_vsi_cfg_sw_lldp(struct ice_vsi *vsi, bool tx, bool create)
>   				goto report;
>   
>   			dev_info(dev,
> -				 "Failed to add generic LLDP Rx filter on VSI %i error: %d, falling back to specialized AQ control\n",
> +				 "Using generic LLDP Rx filter on VSI %i is not possible (%d), falling back to specialized AQ control\n",
>   				 vsi->vsi_num, status);
>   		}
>   

