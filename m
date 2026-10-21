Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D37606A31A
	for <intel-wired-lan@archiver.kernel.org>; Wed, 21 Oct 2026 14:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=sSIwZ42P;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PMCBY8ZU
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 21F4C81195;
	Wed, 21 Oct 2026 14:57:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mC8wjcQ0OaPm; Wed, 21 Oct 2026 14:57:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 359238119B
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792594643;
	b=ZxmbW3cDauHsIfo15iULcUflr0OQq29VY3rGxho5O0hwsEhMiMBlcuhdZsK/x3KA7PhV
	 cmWGrgzpzB9jjNORC671cflkZ+E279L9NMa8C53LBi6qI0iVed0XnzhGZ5TiTGcASQ00v
	 HP31g14KsqonSzfNn7Sx82vhjyGTat48cfSJpRH36Utwv+NHD2uk8x/LL5hYrA3sb596y
	 c/fXlzCix0HDXsi/vz5fKDLp6OeMoEwUoY/ACYmx/E5prUbpE7gdMfX/xTlUWGpVypZ+X
	 kVNL3SX7cpdxcu0jV9dHm5b50fgfKV5uQTDXwpC3yKXsoa2bLo9RzGyAXoCXmbosd4Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792594643;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:Received:Received:
	 Message-ID:Date:User-Agent:Subject:To:CC:References:From:
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
	bh=B7Pl2inO9IpqkhssPOglP1H/b0sEfirJlvBcRbOzkR4=;
	b=sIMdKFs9HA76+wrS+g8RKvnwiJ1yLtpi/YcF9BUnP1zL7vl4+y9x5Z4IqKURK7YXkQBt
	 QY+Ruu+Pvmx690kNF1cT63a9mJnpBnIVUiqr3j6gMaAKiTHE7kOxj2anq3wCzmJD31eW6
	 CqllboTDT+XgiTJbbej0BBY/ewV7MmfaMzk3NSD03tGy623LtGGOyj0wGojfztAXHXgPe
	 +QdYNxwc3R49H2yf1yvpnaeAEj+CAx8gn6NJI1KjYmdR2E74c7zHQJsqg5ZFE9jYb+v02
	 kztp2yHPufZ0EoxuW8dFbiP1fQlei8JhahdB2PqTaQba5ABHVfuHAgYdIHBJI/baUdQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PMCBY8ZU;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792594643;
	bh=B7Pl2inO9IpqkhssPOglP1H/b0sEfirJlvBcRbOzkR4=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sSIwZ42PTdeNX59q2pN4iYi6zThG8JtkwBUVy3NJ8R328aA+XYr0Jfyc18LfQba3r
	 I+4WN4IG0C13zSqc2IuMLwq4ZcFPTtE8kGYMxPtfWBB0H8yH+547Cq1Qr1WGYJKTaz
	 IFNh/a5l+Fd3LTYpxO/KM+qz7BtNDsP7HHvi6aI5DSPlp5Ki4VibKaBaum1IojO93h
	 WW9avmxzo5K3zn2F1z0UkCI3m74w+b0r7N7ofBKRpSfTjTm5LTh1WQHLMEzhM1K9RU
	 ihn0P3rw0PPp4cIL6vpVnYRhtNxrKxbPS7T1SCTWoHE2bWfmaKoWlbngw5L1FaIvc6
	 7Vn7HkomZ3xXA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 359238119B;
	Wed, 21 Oct 2026 14:57:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1A23C995
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Oct 2026 14:57:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F3BD18119B
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Oct 2026 14:57:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Iha6wwwZXVpG for <intel-wired-lan@lists.osuosl.org>;
 Wed, 21 Oct 2026 14:57:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D4A0D81192
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=198.175.65.14
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792594641;
 b=mky5QxlGz+fsFOctNXNI2OjWJIHw5MqDU1KWYsXMiWbmI48NZjh4yDRZWWkFMIsyNISH
 06difvvFE5hm9FS60FQH+hMTtoEVJw2dHe+BNROAovYGsPUhlsKgCKZ4VZ9582iXx2ivT
 6OR7kPFu6XV8XALCyZ4Gxn/XqaVeA3tCTmypeipHJRGpbHUB5LnxybillTUDz+xgzjkDY
 8fHE6twQcwPUGxdZ9fPcqTHyqfmGzAsts4JCq6kkxcEH10FJ5dEXWIw2A+LIen1/Ilg8s
 3adClxyojWVPUPAY7iZDTYrdXuZ++aZoHVRJxXXnxcsaMHRR5JX93s21LumyMbAYm3Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792594641;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
 References:From:Content-Language:In-Reply-To:Content-Type:
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
 bh=B7Pl2inO9IpqkhssPOglP1H/b0sEfirJlvBcRbOzkR4=;
 b=jIncf2HQ6a3NjznlUFdb3PykCkX2GCdsl3sNifrwONrs/1tvd+AM/K1Ut+XUa25RmzF+
 M4aVOEq0OfZqYgWUHxeD4YNmRCYhUjGN7gAuXPnAEHmbB4bRzDtRQie960THU7j2NW+0c
 IBKUOjyCslpwfwd0HUuE7BwPZeAy6k4A+yIWHkEAIhGKa32x3AOsuBwS1W+sAV6yUrIKI
 KvXCN7WS3rD0qXtEMI0FnmyF81G2eSi26D0PIKFG49AON1MvKfbqFrRQMVYV4OsJUgMtp
 2RgFSCQt0LwHokKEl3A/1+RnugHXsQGS1Ap9bJxFWMPtBXFUWT0GzSF4A+kqlsHVT1w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=PMCBY8ZU; 
 arc=fail smtp.remote-ip=198.175.65.14
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=aleksander.lobakin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=PMCBY8ZU
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D4A0D81192
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Oct 2026 14:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792594641; x=1824130641;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=12ZJVmNOUMJ2Woq0j3ZKjo956VMFI0S7dN0zuh6+wQ0=;
 b=PMCBY8ZUKtObxewe2KpqcxiVgxPXyQN/gLGxJV82kx4zo5zZGLJfzIlY
 MweqXtYyFiM+TMYm75+fsGrplXqGsuDXu1bwyfj2S+PSL1RWyan1gJh94
 GvTFxva+pqWTdwVp5JfaTFjRCJlLnpvfS02JIYQ4sNf0yuAWty0q0WFFZ
 vLPy0BhCD1xz0Paun3QTbu1Yi3VOfQifeJo+2HZCjOIVeyRoPzsZyytGf
 SAAGCWebv17915gqEcXFrlGM7bcOB6sRDl+xFHYtWgug5dl0nDmB04Y3x
 1T3cCmPSqrcC0ImOmt4/uxRTuxJdtxfg69/T8rA2wxXe1fdX10Dr+DXd0 w==;
X-CSE-ConnectionGUID: p02S+WGfT4qAnxYVi43BoQ==
X-CSE-MsgGUID: H6AVKXnvTOugVBdr/QbdtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1194895"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1194895"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 07:57:20 -0700
X-CSE-ConnectionGUID: tIjKDqQvR7i73AsWwtoEEA==
X-CSE-MsgGUID: mG8KKfgPSXmmtbfyrgp0Rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3053103"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 07:57:20 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 07:57:19 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 21 Oct 2026 07:57:19 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.37) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 07:57:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fZfWBHSSr7MD/uhoDp8a/cTRltr/VRYJHWK+rLxvQMDUmINiT4BvZGwKuDEUtLPY2dotSyckO71hFpbIE3oepv1aafuqzIEt5MwBy6DGe05Qiu0Qf5OmQC0HcDvc+cmG3DPVLAzwKwfi86jthnvSmM5Tgu565eE0rq8jrcytu6MRKE3yIpSEvgGS0kyve7wlvuwW2MuPf7AvDjekTdNCQqlsY10vxONZ3juy1Nao6076uwFPidwHmD4sRp0xEKrRJIzNKCB1NyyvPSaiiiGN5T5FwFWL0CbJ3OHjCK3JQ4mIdA3ePYRJW6Mx+8yVjBZyuNXRi5QIs9dFsKCiGN9bkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B7Pl2inO9IpqkhssPOglP1H/b0sEfirJlvBcRbOzkR4=;
 b=jflMSmyyIlWdFz1BpzLNKu+KIw4JMwivKsSvQKzaylQ7KZrRaVTiynGI+hASnAd84Df+muhmLb7u5s5F0R17vZMpICoUCV2wxSxH3/bvY7t2+/3IT5h2Sz8G0hkts/zVOmeoFGOMdWB3q51wq0Q7Gs9BsBY8kaEqOao7TTum6BmRcXnUPHnawZ/41+KWt3SScYHjKyNzb02aV/GVvKUGxEGLF0HFfh+gjilXQSt5aesjfj0zpYntMB/uDXUDgd4YQs9hisvZ2RjYA1TnJFckEHS9stIYZccj3m9CeE3NfWkxsMSilr/rBjuKBBozbJ7jNM+fqs87ra/Ta2LZq1iOkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CH3PR11MB395573.namprd11.prod.outlook.com (2603:10b6:610:362::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Wed, 21 Oct
 2026 14:57:12 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%4]) with mapi id 15.21.0496.021; Wed, 21 Oct 2026
 14:57:12 +0000
Message-ID: <c599f939-0308-428f-aeaa-fc990446cea1@intel.com>
Date: Wed, 21 Oct 2026 16:57:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v2 0/2] libeth, idpf: use GFP_KERNEL for the
 initial Rx ring fill
To: Luigi Rizzo <lrizzo@google.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>, Tony Nguyen
 <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Luigi Rizzo
 <rizzo.unipi@gmail.com>, Brian Vazquez <brianvv@google.com>, Joshua Hay
 <joshua.a.hay@intel.com>, Larysa Zaremba <larysa.zaremba@intel.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20261019210604.2433620-1-lrizzo@google.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20261019210604.2433620-1-lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0007.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::9)
 To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CH3PR11MB395573:EE_
X-MS-Office365-Filtering-Correlation-Id: 660156ab-36f3-49a0-a2b3-08df2f839647
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|7416014|366016|56012099006|11063799006|261009223027099003|18002099003|10067099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: XrkqiYP5LLrLZ7qUwPpNQqu0J9h1u6BDptcD2rPDOXzaqLOZtLPp7v8CXQkVBCEUD1GbChBaclBrSQcI9XEp5lhf3mtgB4aiFf+vYdGqb6D+Eb2xSN0Wx4QsWg+0+juHvb8PxowQPVaIUB1BFiYwaJWGVmBUdqNha6F5+/YHVYBs2eEkSgWN6rjuTBcXmj0wCvYz024KpZ7kNZQRcSCinXGuWE8c3yE5APuQ82nGgsKaAqILpRhuFROsal6Xg/J7MX655T7l++9Vc6RCs4x9q4aGUvLSqkHf4CslMkKRawe/XsVJHPnyUn6lXXQPC03ahqz+7os90R3RBmFP3JQHm1eYgPeCk6NV0Ggt9UbXBQUpuhMKzRcfi/RwcrkOSL2QBUmO/ZCVnqNiWUYNbBG22wFcqUAaHJr5jD0L9jLfSzauXrbwy6R4pUrIYNpiInW2DQP89gZpq41KfsaB8ERGmT/mmNa4iOcPQbEilQLtZIVyXI2QgFnzHrvRuPkmSfrxQoZHjy9uOGriOM78/oj3fKrpgS3RzMq7TlO6EXYpK/A2p05g8qcVVTqbzJWfhLWD6JbmOSeEt2GAXHVQgsWHkysT6fhw/bnq9/P6iU5U56lOjP2DjgdH5X+BCaViIfDq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8718.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(56012099006)(11063799006)(261009223027099003)(18002099003)(10067099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEZ4ejdubkxEU2pOdlFvbG93ZU0rQjZSdUhwY3lZQnNFeHhVNlp6aStadkcw?=
 =?utf-8?B?SnMyaytLdUhoY29NT3VGUHJqNXFlV2JicVdFNDA0alBlVXpCZmp0WnNWQUtY?=
 =?utf-8?B?dG4vZlNIVGZjZHZROFVENDN2ZTEzcHV1aitMbndQdk5kWHFRYUxURWs0QmVF?=
 =?utf-8?B?U3pCUFNKM01JbUpSampMam9yRGlpZXBhMlZ2OU05K2hOeThQYlpYVW03amMr?=
 =?utf-8?B?Ymt4cWl0VWdONTlpYlRWaGlobTlQaXpwQjN6WDUwbC9GR2EvaE1sa2VWVWM1?=
 =?utf-8?B?bWZGUUFzYWNmSHFZZXpob2hTSVJXSkZpa05YbnZFVDd3VkVSbVRGb2RUZ002?=
 =?utf-8?B?RFBid0dNaU95SVJSaVIwMTlkRmh2UHRGL0JNRGsxYTNLeGthVlduMGhjU2pO?=
 =?utf-8?B?Y3h1N2pFRjdreThWdklzdEZON1diRUdxYXpiaERVSnVaRXhUWm44c0gwaVlH?=
 =?utf-8?B?d3ZkSm11Y04wS21xVWlMMzFUU2h1SFcxeGdEbDFqNjNIb1A3N245Y1FkeCt0?=
 =?utf-8?B?TWZPQjhtMW9XWGlIazdCTHRwSGhyVTdSdHlNZ2t1VWR0a2QxeVJMQnZEYWdJ?=
 =?utf-8?B?NGltRkdGZVFVVFBPeXZmb3h6OFBJc0pxL2xXeUViVTltOTE0VmYzaDA0RW4z?=
 =?utf-8?B?bTNqK2YzWU4yYW5QcDdkdXEySnR2dE5UQmRKVGVwc0ZRaU1sK2x6a1BpN2lJ?=
 =?utf-8?B?cXpkdUVmbnhrVGRvc0M5ZmEwSVNDQlpjenBSbnNrYWtuYmI2OStXdGNLdDVz?=
 =?utf-8?B?Wm44RXUzQVZYdjJnRUU5TWFOOWsyRXNtM3ZySGZEU0JscEZyVXMzV0hDNG5p?=
 =?utf-8?B?R1p2RHlxWmhuQ244Z01VamIvTk92SnNVUjNSbkNuNDdKam9wMFlpQ0d6aERs?=
 =?utf-8?B?NmYrNk9SMG90ZTk0WC9YRzF1cGQ1dk5vSU5GRDB4NnpZSEtNS0FQZjRqWHhw?=
 =?utf-8?B?QVpGWHVZOTkzQW5CWHpKS05jK2RHanlBVWNUUXpzRVFDS01GZlJ6eU5lc0l1?=
 =?utf-8?B?VnVZLzQzZS9WdW1YOFMzTkxUVXdXWm01K0hBMEhQTWpEMkcyLzlrazJTTmN2?=
 =?utf-8?B?b2QwUXBLRm1YS0tPUlJxMFMwL0FBZDdQVTM3SThsWHNXNlU2V1Z1K1lTdnEy?=
 =?utf-8?B?TEJTbnVvd1BhODR1N0wvT2E5aFhvQnFqNUYyaTlKaXRmVy9jREtVaEpMRWl3?=
 =?utf-8?B?YUw5L0lrNHhVSUVsN1N5THEreUtjZGFGYnB4a2tEb29GSkM3SGM1NjhJbGNE?=
 =?utf-8?B?NFJxWis5cUhrUjEvWVRkSXpVMmpsUEd5bFVFVFQrQUZTQzRnaW9pMy9RVTBW?=
 =?utf-8?B?REFVMnBmYmpGb3pENmk5N1ZHRUxwQ1dkeFFxTEE1bWhGcmFiekxZVjlWanFp?=
 =?utf-8?B?U0hQdzAwVHo0MTdmQW84WWtNcjRoVVA5ei8vOWlNWHhPaHFzWER1N01XTDBz?=
 =?utf-8?B?THlKNXpEVHBibnRFNHFtbnZrMkc2TTRDeEU5WWVxRVp6QUJRVXN4cEwxNzB6?=
 =?utf-8?B?NWpEVWN5NUVFUDUxamkzZ0hGR0JtcEJpcHZsTmhDSXF1MXEzRWliRVlFYXNu?=
 =?utf-8?B?SzVuZXVPVjZhRmFxZDJmZFdJUWk1bHN4a1E3YkFnNjZEbS9mNnJnV3JVS0Mv?=
 =?utf-8?B?RERvQldTaEhvTC9OOVNPY2dvd3UxbzBQK3RoUjQwVG9UYVFyYWFEZzJHWE9q?=
 =?utf-8?B?dGEzblpUY0p4d04rNytLSC9USXM3eUxjbGZLVVB1bEpldGhKVUhDc3Y0Vmha?=
 =?utf-8?B?RFEwOEZuSDZKc3ZMb2hHeFppeHd1cEFrWklPT0Z3ZDRRQ1NIdzNzcUdxSzFm?=
 =?utf-8?B?VkpEOU5xNTlyVHlFK3BZYnBFZitqM09FTVJEWUJHODNDV3VaNTdTcy9uSWoz?=
 =?utf-8?B?SkIrdnZQUENsRi8vZm1jWURnSmlDUVF6L0pkUDJiS1Z5dnVQVEJlMmYzdytY?=
 =?utf-8?B?aWk4M1Npc1hJS0loZHRERHd2cncrVzFkaUpxZUplWVQ1bmVHOUhLUVBYSVB2?=
 =?utf-8?B?SHdMaXV3UWhFSGsrVGxiRm54ZVdYZis3Z0pMQUdzMm4rOFcwV3BWM21wa08z?=
 =?utf-8?B?blZoVkNZL1RUa3pmNkQzSklSUC9YN1pIRWxQQnZ2NnpDMWN6b0FjTW5WNVM4?=
 =?utf-8?B?Ylp1c2lTR0tEZmE1MDNEZ1V3Ym8wRm9rS1ZhcTdmZEFQWm9ONkF3MWJ2ZEdq?=
 =?utf-8?B?WXZiTktUeDhzWTFnckJLMUFESE8zZDhHczZ2M2czcnFQQWV2ako0TktqZ1g0?=
 =?utf-8?B?WmM5c1ZFazFEcDVYaWlKN2x2LytWK3lvWnNvOVlVM2JRWXNRVTZkek5sQkZk?=
 =?utf-8?B?OVM5OVNYWThNRlBiOHFYQ0JmRllySEd2elpvSERmUzRTRHNwTUZJRkxkbGg0?=
 =?utf-8?Q?v8+dnLA0OGud6TSU=3D?=
X-Exchange-RoutingPolicyChecked: 5C7ih9J6LNIv8wuIP7lFMqXmiuM37CzfZZw3/PGeAOB0gRbXcWrE/lNlzWH+FHDTDY1nfmH8XhV2AbmdW9PcJPpMO7QVq8/k2HOhEc+bvluVZ6d0XGMcZk1fSZoX9eFrZ7KPopAk4OV5/Q+9r1Ah+DUWUACCYoCVbCVPvmWh8Skgatlt4vbJM5GXp4mKgVnL3+Hk/3fBzXehUY6KImgacgLc6+WkdIXt12NxzElXKv40/iGICzOov84dzUFYpjGZy4ZjBqWeRVlxNfn5bxM5D7ChpBZ74p7jkIs0PhFpVtz6z7EEN9fVgP9RyCI9iNBUge9jsEmraO3O44vgcdUWtw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 660156ab-36f3-49a0-a2b3-08df2f839647
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 14:57:12.1642 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jA+UnsLjeEOFvs5CTaxEPNenuUJIenhICtDD7r4uAFvqW476fzm6CLGYA0NtwL8R7zPixg8b9J1npNlwRmyiGj+2ziYnx+kbv0wTCiKPPvs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB395573
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
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_NONE,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Luigi Rizzo <lrizzo@google.com>
Date: Mon, 19 Oct 2026 21:06:02 +0000

> libeth_rx_alloc() always allocates with GFP_ATOMIC, including when a
> driver fills its Rx rings at open or on queue reconfiguration. That
> fill runs in process context, right after page_pool_create() and before
> the queues' NAPI is enabled, so it may sleep, and GFP_ATOMIC is
> needlessly restrictive there: it can neither reclaim nor compact, while
> the initial fill can allocate tens of thousands of buffers across all
> queues.
> 
> Patch 1 adds libeth_rx_alloc_gfp() taking a gfp_t parameter and turns
> libeth_rx_alloc() into its GFP_ATOMIC wrapper.
> Patch 2 switches idpf's initial Rx ring fill (both splitq and singleq)
> to GFP_KERNEL.

This is done for simplicity and performance reasons (although I've just
realized that this helper is fully inline, so it will inline your new
GFP argument as well).

But could anyone explain me why the initial fill is bad to do with
GFP_ATOMIC?

> 
> v2:
>   - split into two patches (libeth helper and idpf consumer)
> v1: https://lore.kernel.org/r/20261016151835.2500807-1-lrizzo@google.com/
> 
> Luigi Rizzo (2):
>   libeth: add libeth_rx_alloc_gfp() to specify allocation flags
>   idpf: use GFP_KERNEL for the initial Rx ring fill
> 
>  .../ethernet/intel/idpf/idpf_singleq_txrx.c   |  7 +++---
>  drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  9 +++++---
>  drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  2 +-
>  include/net/libeth/rx.h                       | 23 +++++++++++++++----
>  4 files changed, 30 insertions(+), 11 deletions(-)

Thanks,
Olek
