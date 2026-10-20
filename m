Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648A2606A319
	for <intel-wired-lan@archiver.kernel.org>; Tue, 20 Oct 2026 10:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=XOc5n76w;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JjclTK3P
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3F84380E0C;
	Tue, 20 Oct 2026 10:00:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xhvaXxGmCi4K; Tue, 20 Oct 2026 10:00:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 98C2780E5E
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792490419;
	b=bXDkQHz00dqhn85sOD572RL4PGR6K6oWC42PA3EQ+noVZhn6GPc3RcgoCTo8/AC/Fe29
	 3Ok/AxdCPyfNLmGgEeWo15Ftu0UlclsfTf/2WjZqcMjgb/cvlVHGL6E6Hvqko4vYcPIRS
	 xgTFSKtsEeQkScztRU0Avb0sTFmpDUlCVlUG/Bl0Lo9kepaVzgk1GSTkFeWhhqYFOJDij
	 XFsd6go8ihZ38iY+D7TEdXRMEEpnfJ2jE63JBmuEAqI0n81XmUv//yBU0rQZliGX2LaRB
	 oteCLqPyCN39Xq12b+dBMGF2FBM8OO7MVkcx3qoO7yzFBE56nYSSJtu7StQxJKyGE4A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792490419;
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
	 X-LD-Processed:X-MS-Exchange-SenderADCheck:
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
	bh=Y4o7ioPRxdyVp3/5E3Mq0wih/zuNtfAYFlBkHud17l4=;
	b=HqBFVbNxVuyY1VJkEK5c8m3SxocfblkA06BSsPqp8hgMXjL8Lp7yN4QebZi+3TajXO5z
	 S50DsCSzBmNKuNmG89DBBdxum0IGR47APfi/au7ezHbf6Pl0EKjXH/uICAYY2WOu12FbI
	 0+uxonX1mFpYR69zq9Csei0DXA4N0qflDzX9tQ+e5vDm0c3QOnMpQ6Pt873US848AMqpV
	 aevfl6pH3vjubxxJU5NeD8+7osCDfZ91xZPmfnVTONbA56d30Zh8VdXQf3jAVwLmBWj8g
	 08+9wt7Y2Pw+JzzpZoGo0PTVpE32jCZk6+HAIwwVuG8fSw8RtdUtJqcDPJxeum/U1pw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792490419;
	bh=Y4o7ioPRxdyVp3/5E3Mq0wih/zuNtfAYFlBkHud17l4=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XOc5n76wbAoAtz2KMnTwbSxhXgqEj7AiqHoescH0uFc/CDwF42bN7ncPjPc8t1XHx
	 tsx4XnNS8R7WXJ/Yrqw/ammksZKrrrQ25OHCvpdMlVAe0GMd8CS6rntvR+cr/Kcwrs
	 fgIENLLvOL8ritRuv02buBBdn1vTYpzGekckfHKa7NOGWG/QyUV28TuZt385Z+3QlG
	 7n9MG/cA0JlUu3JVcTvri4ccslahukkBPXUiqMMqhbUngvawHa4qDgsfoP9tbaHxEb
	 lIRcbPANodb2v9tvy4/UDeeipt6ueOXOwLRBZk8lPGWJvoEvrlnMGq5IR+fOaFA2ov
	 C8eGK/2Uj7MgA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 98C2780E5E;
	Tue, 20 Oct 2026 10:00:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3BF203A8
 for <intel-wired-lan@lists.osuosl.org>; Tue, 20 Oct 2026 10:00:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2D509406E6
 for <intel-wired-lan@lists.osuosl.org>; Tue, 20 Oct 2026 10:00:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k0C2hf_PBr-o for <intel-wired-lan@lists.osuosl.org>;
 Tue, 20 Oct 2026 10:00:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 01504406BC
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=198.175.65.21
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792490417;
 b=N1knae6mOGtE02EHsLUXdIw79bLCNNpoVRlb7LeVxgoQOZhSxjFEAcqUPHYnar0H+Obo
 mP3atx1LtZJ/ZvAnFk1cc69EnhQV7v40dPQs+u/fn25npw75L6bw8yqoemt05XXGiFv7j
 rtd+ssw392xc+PF+kjvHl58uQ74+94ruZku9i+1Nxn3Om422mWP0C9ZGoeQt4nHm2K/RP
 EDtG60A7MsSr+QgTd661BVHThp4/rDtEyMSrpBns4clgxPaxsXGrx3O55GXn8Fm7Ahgza
 YzZBb5Tq/Nbx/U9fTw7S2OZBdEhQtXs73nwBQ99YMGm/IRMNo0JaeD7UnjoCjWs0fiA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792490417;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
 References:From:Content-Language:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 bh=Y4o7ioPRxdyVp3/5E3Mq0wih/zuNtfAYFlBkHud17l4=;
 b=QDYDm0V4pk2M1xcFVTF9glMe+jmNux0DwpjayacBD/NofnkGFVxeQawZKC6Hx5+Zxf6y
 VGNAzreEe3U6dHbokJ+5aDWyeZ7/2b0aORVgqSxl4i4uacuXgqtYE1eUcKOtgD+dAdSw7
 vumlUdDm0T3076/VvrNKETB1ivlX6j2QzvsZGX4eS5+bAHcJSb1cgYAYKGhCxyJ8IDQCK
 uSE4qXLAaap9wYHEsk/KY5ljF8p4wLZYrHuVqFIWnJNM6GSbKGehTJnIpg9pngKOJFsc1
 RzfGgvzVyrnyVD4//PphTEjKy7ArENAUi70hzXmc9JCAldVkiVeeThPm91Wywr2oXsA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=JjclTK3P; 
 arc=fail smtp.remote-ip=198.175.65.21
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.21;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=JjclTK3P
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 01504406BC
 for <intel-wired-lan@lists.osuosl.org>; Tue, 20 Oct 2026 10:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792490417; x=1824026417;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=huz12Eh3UnInZTzw0A0FJ/ki3/RHI6dQLS5wIc8L42M=;
 b=JjclTK3PiJQX7chFXX7NRdiMSbDjO9Ylwmof+NHGJDZR1GTqvzt6Ud7U
 KMQwWVQQNw5/2B7f+e0JPG9m7ARatOeDSphoIC/qVMD3+bdCwC8fQV9bN
 hSB2Tt0J+KOIEs3Df/f8tf3hkIz/W8EYMvyqrryarJNy7JgPX0winaSuY
 M9y2j2+ApLS1dEEme3WGzMMdOhyIUaE8MXCUlQGEzfDUnKqcLazfnQ/Jz
 qzU2UD3hBzcbA+WcKtTTP8E/j7uG1DPu9DvURg/TpK206e2al2ZbdJRn3
 C4oQxOUyUl7bwI/I2JqOTy89AWgl5/GWaYHNBWLGUlsMZKtihRwAE9umS Q==;
X-CSE-ConnectionGUID: bM/opKJ2QCaz/jGsAT+mlw==
X-CSE-MsgGUID: 7BAVJDkcRBa2v/COpK0uzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1288969"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1288969"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2026 03:00:15 -0700
X-CSE-ConnectionGUID: X/wCCW9YT6mOzlUjZqpu6w==
X-CSE-MsgGUID: E+IqtaTIRVWK4JlkLDgZOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2729295"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2026 03:00:15 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 03:00:14 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 20 Oct 2026 03:00:14 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.67) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 03:00:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i8bxh2zkCvMOHgzlmrzwZGUOHzKu5/6Bc69gY9wAhY8/jfiLvx1eL5LHBCPA9eKjMDgUGEYSXutKCN+i7P535l4LCKxzOkWwyDKz2TBWjxHDroyocycvC39g3L3/VaSS+xXpwyyFe5gbI5lRaFPT8Uo+bL0tu3QdN0rzA0oOfNOj8IPQ7ldli9RZh7dRx3Byd4puj4OVaNZFE32q9DpxSge+mTlq7XkVMiQ1Mdm2BG8rU5YanI1SsILkOsUvHfAjdOho7VzXupgcqORf0p/3+uHUh+Qm1uZQEf2CQPPdwyxt/GkseauwkJSdxlY0+OxmrqiwufRhiQUd09S8f8I7vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y4o7ioPRxdyVp3/5E3Mq0wih/zuNtfAYFlBkHud17l4=;
 b=mGM0RPQimNrMzfXs8b5oL8ulPGGQD/V6v2qbKp3IFOG7QZKdwmyD7mKjgJb/npGyxAoEGQYFZSjxZY7jlxyjBF15Z6KWXh5XJ/1Uf7ufHkFCV3OPbah/VdId7SzrMYNhNaAEkeGnYpefbKiRYaxCipzwVJFqhG2ePXG1NzRr/nnmIzR01ZijqUI9+Mj20GEVcx+YulAkjy9jCFdXYWUbiL2e1pPslgUcuSDULGZc3MwsODH39kzc4zDFluiZDIsHSStzAh5Z2edSXFFRQBvAgThAOrMlf70CtvCBK+DJlDKjVjU59n+vuKJujoU6QN0Db8Rf1cccKX+UHRlY5R5bZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by MW6PR11MB8337.namprd11.prod.outlook.com (2603:10b6:303:248::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 10:00:11 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 10:00:11 +0000
Message-ID: <cd628fcb-9092-4361-a823-5f7bea3bee27@intel.com>
Date: Tue, 20 Oct 2026 12:06:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net 0/3] ice: fix RTNL vs auxiliary device lock
 inversion
To: Petr Oros <poros@redhat.com>, <netdev@vger.kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky
 <leon@kernel.org>, Kamil Maziarz <kamil.maziarz@intel.com>, Rafal Rogalski
 <rafalx.rogalski@intel.com>, Aleksandr Loktionov
 <aleksandr.loktionov@intel.com>, Michal Schmidt <mschmidt@redhat.com>,
 <linux-rdma@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
 <linux-kernel@vger.kernel.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, "Steven
 Rostedt" <rostedt@goodmis.org>, <linux-rt-devel@lists.linux.dev>
References: <20261019065301.3983537-1-poros@redhat.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20261019065301.3983537-1-poros@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0678.eurprd06.prod.outlook.com
 (2603:10a6:20b:49c::21) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|MW6PR11MB8337:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ff5e09b-8e2f-44fb-9c93-08df2e90edd7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|23010399003|261009223027099003|10067099003|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: GZpGwGeE9yTgCFlN85DXkS+6ysIr8O0TYf5Zz5eMNVs3IWcHQp3K894LVSm5gl1TZcLNJyy2wwyW5akTSZruSWE3NILcwcNr+MlPB2R0lrNUT6KWywXpv+1s88MH1RoWAlvjzJdMxbUHDuJd295TTeXAjqoKx+fRnLPK6d5bpqRFbPaaKI/FKIt0q5lQod8o2JcSKEJv22+74DRcGlGRd3ZtfwimnoWcDmxVs3F8rswieAkCiek3r7mMTsyX6uULZuk9QNk0gUBD9t7iv595CTHxqLvSS3GqYOtyqF9BL1j5od8GWavTp0bzcuv0C4HPVGFcC/aSINPDLKFbsLTkxjdX14ZMPQWveSN3yva2v8UItpOI+K7qco+OmBamz1L38g0VBeERvckOF64QJt+9KAOq7R5baPz5ipaxYEVrkHukAhCbqyIeLpCxoYQXUjyP9VwrOD2UfjBlGbtUMja30D1U4o1h5zAkS7z5c0MOVm+XJrmWiqkjc9LqQdo1XzvRdenyzba/K+EqcSkkR/FzPDIcsLLpSg8wuFyIEb8xWA3zobjJip17LoQMw1EyjxgOWr6fv2ESx1dpmQpmZh1rG8YaRMrUzXeqypwLGTWcjHojWMFByv4i+5cbDC+0Um8RbuJpyeVPN8xR2lihU91iyeGah5Ti24Fp3TEt77MMA7I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR11MB8508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(261009223027099003)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N095MGxOcEpSVUVBNzAvZmtSZWRCLy9Jbk56akczYjhhQ2pJNHRMZFR1U0Zi?=
 =?utf-8?B?RVNWMDVqeHlwd0ZGWkR1S3NoZnZSRElaQlZXOWFsajhhV2xhMFZyR2VGWnJ4?=
 =?utf-8?B?NHUrYzcwNzdOYlRHMXIyaGUxeEJ6UTNZYWM5U080WDVKRXpBMFR4OHZVQUox?=
 =?utf-8?B?Z05zZXlQd0tGV0R4UDJqVUlGMmhtYjFDSTdIZFBaNDJxZXhMaHJaYXkyY285?=
 =?utf-8?B?VkJwTE9JWENTVHpJMnNkZ0c3MXRZdjJoNW9qUHhUTlVUQnoyTzd6Y0FnWUNP?=
 =?utf-8?B?bUhuRzlwWEZMSUtPZVhCNk5DVnB0ekk3VE5UeGxxYjZESWJFUWtySzVMVmU1?=
 =?utf-8?B?RGUvZnpNMkdjVHZkZVM3SnN3K2IwS1N1NzFUc04vczIxVHhKSVA0YXp4Ukx4?=
 =?utf-8?B?bXdKNlppQWZodFhGUEJnaW5jY3RGWm5RbmJIRzlQSXVUS3Q5cm5ub1lXMzFl?=
 =?utf-8?B?TDVNTFNvQ3U4bUNzdmZvQVk1aTJRWjMzRGp2T3M1SEtDa2FTTG5oV3Q3TkZI?=
 =?utf-8?B?K3hOOGx3VEpTUCtDaitEdHl2Q2gwazR0eFRFODUxdXBvVUdTaWhxZWx1NGpB?=
 =?utf-8?B?T2JkUHJxUmxtSEpSSEN2VUVwZHNSbmdMUWJMd0N0WGRnRUdER2s3aEZMaVV3?=
 =?utf-8?B?ejcxa3FLc0hjNzd6ZXRSdFJqYVZSY0d4SEJTNitTejIxMTliR3FoVE82TWhy?=
 =?utf-8?B?Qk80dUdjV05pUjNDRXZpL29QZEMycE5qTFZqV1pYanFuNWgxcW1oNnFNOEMx?=
 =?utf-8?B?OFl1Y1pycWhuZHFDTnZEQitXNE9RNjVQVUljK0l4Y0tCSnUyZXlMcmF0ejdN?=
 =?utf-8?B?YmM0aXhOTnE1UU15TVhUQ2NpVGtPakV2a0FpK01kTDlRYlRqY0JzVjg1OUFm?=
 =?utf-8?B?TXBKUU5OaHdSY3cvQ3FKWEd5ZEpmeHY5dHRTZ1huZlNhWnFLQVl3Y3RMWXdm?=
 =?utf-8?B?SVRNSlhpTnU2ZnY0d3JHeFRGQ0lLSnRrRFJzZXRUWERTVWkrZGZENXlQK0tl?=
 =?utf-8?B?U095Q1puVXRBQ2ZsdTZYenNLR2dla0c5VkZ5SG5Mb0RRWEI4WEdLQXhEMVMz?=
 =?utf-8?B?clBqMWo1eGl6YWN6dFM4YVhQMHhvWnh0UWQ3Nnc4WG91K2dwSWY2MG9pOFZu?=
 =?utf-8?B?dVFTN1l6TXVxeGl0UmE3RXVGeWt1SzBDYjljeTNkWTJqTUU3UnRjMGNrVDVo?=
 =?utf-8?B?L05saWZtU1JQeTluUGQxTS9kRnU1d2JGSHE4LzJTVXVRRnBLVHZIMDgzM3Jr?=
 =?utf-8?B?TXJ4ZVd3TUhMSFVDL2U3UUJlREdOWUdaUkJjTXpzRFFzWGNpUkhRWjJnbUgw?=
 =?utf-8?B?ZjlrUE9yUjNZdElrV2ZxaFJQQk1RUmRhR2tuSE42ZzFzVzRSNlNkOWR1MWx4?=
 =?utf-8?B?NjFQM1BqWWt4bnhPQ1l4K2dHZ1FtM3FpYTBTTmdBcm5DTzkrZ0pOOXhYRGtK?=
 =?utf-8?B?aC9BVi9pVmxXUkx3K0tSV1MxaVVKbzZzZTFIQ01uUDc2Q0U1c3doczlMcDU1?=
 =?utf-8?B?WnlmWUgwaHdHRXY4aWJhckhLM2FzaUkxSHY3LzE4VW53Q21sVlkrY3ZVOVlz?=
 =?utf-8?B?Sm1FMzRoMFJCdnM2d3psQURqTnZ2MkhPdnlwRFhwTThoVzV2QndweGNySStt?=
 =?utf-8?B?SEZpY0xVeThFU1lzUTl4WDZOekpUZDg1UFVwYXhzV1FFdUJYaTF6UmRUT0Ja?=
 =?utf-8?B?RzVONzBvbUhxRzZoNCtGeDQ2ZTkwY0ppSE5aekhpNDExc0JsUWgrNjZIVm9W?=
 =?utf-8?B?MlpyZHNRamp0cnZ2WElmV2NQR1dEUHplczJ6Q2NCZ1lXZXNCd3dtSXJNYm5F?=
 =?utf-8?B?RWNHRUVNR0p2VzhKWGtyZFpvL2YvdHg0SzgrTCtsa0hLT2l3OXdVc0liMWZ5?=
 =?utf-8?B?cGMrTXZBdWZ3ZS9tTnFYUWpHTWVybzRCaUZzYk96VjRQbUE3eFFTYU5aNnZZ?=
 =?utf-8?B?RjUwaVIrNzJWSC9LMVN1TDM1LzNZUkE2bUl0SHRSSllKdnNjd0o5a0ZrWndY?=
 =?utf-8?B?bWJyYWgxRkNidXVleHdCVU01NEp1azlheGUrQ0JyQkh4OXhobDhuelljUTNh?=
 =?utf-8?B?QzV0RDZTcHpJMlJQdmdrdXNid0cvZDRPb1lnM0VqRVd1S0t0TGMzWWxUb1ln?=
 =?utf-8?B?SXJJdlNHcmNkRzF2bnpJNWx5T0ZGV01NZHg4bVhIRVJNYlAwTUswMTZhcE15?=
 =?utf-8?B?eWRXeHY3OTFLRUtBOGNCcG5kaWtsbUd2UERkbmk1SDEyVnZkREViYi8vODF5?=
 =?utf-8?B?WHkwdE5nMjMzSno5ZENZRm5Ca1BicWZFV0FOelllbiswQU9aTmNpU25DbU5i?=
 =?utf-8?B?SVZrNUdGRFo4clhmS2tFMmpTVU9YOGswRmtSNXdBL2VYRjhTOWYvTHg5NTdZ?=
 =?utf-8?Q?KAWmCoXqRQiBLN3I=3D?=
X-Exchange-RoutingPolicyChecked: FPThWqXa6G1xXpI06V/EjoVRn4DrycmS220DRbO9lSg2+TbapLQkD97DYBNhuzzc8dpLsuF49oKuRETHa6GD4yHCHAroDfeNjFfQAncULz4ZW6ydQUuYjkaQ5P3pyLidpTRPnCTF2CXOCGfauMa+qxJcI4nASAp7HTcPdJwv2QLg3Kq7F1WpOx6qbgPjPq+jmyLvfjBAgEu0gleLdQSwIdf5N0LnV25/Mii5ZhtX45cpU+6JQHNX98bobFZgWX3hgJRnkPLr9EXcdecAzmarp4K7EsfocvibQz4NUgJiGkxX/uw+QpbaCRfYXXj8tnFaR3VLlwGTgRO90aMXg93GUQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ff5e09b-8e2f-44fb-9c93-08df2e90edd7
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 10:00:11.2380 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xx1LgLenppL1r5EGOQ9gZDV17JSafFCO4D6YxnmtghqLepNTMw9bDea6kBup4rUBQCEICAE8mspqNE+Ids6pag51DkWcS+oCiaVPhXVBuHo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8337
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

> A window entry is a contended device_trylock(), that is, the exact
> moment really_probe() holds the auxiliary device lock and waits for the
> RTNL lock, so each one is an occasion that used to close the cycle.
> Without the series the console shows both halves and the box only
> returns through hung_task_panic. 25 reboots on the patched kernel were
> clean.
> 
> Petr Oros (3):
>    ice: avoid RTNL deadlock when notifying the RDMA auxiliary driver
>    ice: do not block on the aux device lock in ethtool set_channels
>    ice: do not block on the aux device lock in ndo_setup_tc
> 
>   drivers/net/ethernet/intel/ice/ice_dcb_lib.c |  9 +++++++-
>   drivers/net/ethernet/intel/ice/ice_ethtool.c |  6 +++++-
>   drivers/net/ethernet/intel/ice/ice_idc.c     | 20 ++++++++++++++----
>   drivers/net/ethernet/intel/ice/ice_idc_int.h |  2 +-
>   drivers/net/ethernet/intel/ice/ice_main.c    | 22 +++++++++++++++-----
>   5 files changed, 47 insertions(+), 12 deletions(-)
> 

trylock is clearly an antipattern, but we don't have anything better,
especially for a -net material

side note: we have resolved the same issue via rtnl_unlock()&relock()
in OOT (to be published within days), which is even worse anti-pattern

Would be best to have proper API as -next thing, glad to hear your
support on that!

side note2: I have a few fixes around the thing you touches, but no
conflicts so far, will CC you
