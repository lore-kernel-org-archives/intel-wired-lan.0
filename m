Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D872FCC6B2D
	for <intel-wired-lan@archiver.kernel.org>; Wed, 14 Oct 2026 21:08:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7A7F281011;
	Wed, 14 Oct 2026 21:08:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AUdrvoj3EmIQ; Wed, 14 Oct 2026 21:08:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A6DC981028
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792012116;
	b=jFB24GLcEp9CdWjqpk0uIKcbL+Tcw3bXaq+PIVZMLCks6zBYcVBkze1mYZHlEwdMDIz6
	 mdVhoZeDlni1KqymXICj6GdV9zZhSXPXSy7/om1G5ajXTxqY/avmifLkAE1J02AxZPDrk
	 VEkl+yHST2mCw/rmLMbJ+5WBCbbN4BZoPBH7Tu+yUau/iHzuG4lOnsZGh0zPQrJGeQTjb
	 G3Cywz2WSXiSc/pveB6PC12m1kSw9ccNwguVvjzF7oRGUDiT4pH+fRdXktDmOqJDwZUpY
	 GiU/OEo01lJsLDU+OYGOlkQvHchsCBTo46i2Pf/X3+wZ0rZGCN3sblLJdIdwV3qpKeQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792012116;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:Received:Received:
	 Message-ID:Date:User-Agent:Subject:To:CC:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
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
	bh=Tjx+qEyCK6zdoMDnL8rY2I3Y6NyD9IYAYvMuWzbE2uI=;
	b=mXdvo77dAKoN87pvkemku3Uho2RvOFY53AjVZfeAAO5JcgjnVwVzkDxKiUM0j8DLwdF6
	 KRUy1pBlc7AB42Owec7Mun61LWDnQUz9r9s0OnI8N03FN3PQECuObVPBQAnsN847aDwPZ
	 sJhYMakf8oSZzNJfdOGXjhMsE8sRhhGP/9nKGhEkiOAz4JxbRKXLUaGCXEt+zNf0UXAVx
	 03AjFIcEVO8mb1SLRG98tOIk8Y2JNyaWMocHeTVuG3ej+YEhLLpIqcEYT5H1I7hneZ7xW
	 p2b/Hgsg+8B/jrzFv5Q0IG1dj9PlpZ1NOuqYOfbUIhKFAs/yUFRd+sODUg3DuxNvBSQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792012116;
	bh=Tjx+qEyCK6zdoMDnL8rY2I3Y6NyD9IYAYvMuWzbE2uI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g87pPz97JDlhUcTv9YAx1QxUoxTbKNewvIQuthAaY3KTPycjBkA7kmOTtpYkQ09Rr
	 kcEjAFalJVWJyU8dcBpvgOk45NLL2HJrBjDY4r0+lVncqCXuhSDzW/DFHCT58O+KLw
	 pYRAWs0v1mgNiPCNbqyQ13Tt1HcgltNgNDBciv3hl/0GE1SKolNk4sas/XKudgFQum
	 owDyfUprzAEsNrB7AdWtYQfsPDNZptWUaDFZR0UWyfH8HkcE8jaZn4QNGAWhhRE9kM
	 FnkTAq9dW+4ns53fa04VP4AJZ1T7OVr9sWUeMyyqTFc5h3Yidx22rohEjAvIg9Z+iR
	 D2HxXK+qwGVXw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A6DC981028;
	Wed, 14 Oct 2026 21:08:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 996D41DE
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 21:08:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8B252407E7
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 21:08:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tCEgKZrJbBt4 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 14 Oct 2026 21:08:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 786EA407DA
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=198.175.65.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792012113;
 b=RWar+Abp2kEovUoHDORb8HGnjon3RyNPzRao7kGf+qOaG9pfEnXQ1GIuUixT/9vXT5+4
 O1BhfvEPPOHjmMuxcrxIaXl3MgVjUL3TxIYiqvO9jCJErpbMo/ziwhFDi1y3aOZU1MFBU
 GJLA86X9fg8FzM5j5lMH2FckZdAHQ5MGdWxrDqP+rvz07z03L/+jNJJxfG94hxC+tRvtB
 HlZqouxTJlZU+OYpnKJbwjUEDlLWIsIMIyrOERISiElesZt8WCOmz9gEIYUAkPof6EvOU
 quMtHfttPFBPFUwWRc7kya5k7V+0/rH53siwB5gmHyE+2XSztYZihQIRfBahTBIElMA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792012113;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
 References:Content-Language:From:In-Reply-To:Content-Type:
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
 bh=Tjx+qEyCK6zdoMDnL8rY2I3Y6NyD9IYAYvMuWzbE2uI=;
 b=S/GUHKT39A7CcwIkdaxkQccZVys7EO77oaCgS+7Fh+oMMaSnt5Y414Ck8yDG4bEDUEF6
 zTZSeXl46I1tadyiQNVOxb1a6QRIU7j1J+QqAjlL+u1TigLHTKV+5UtXjXx1Jv05LxR1u
 m0OkjwU0uurKqsvot1WWLrA2vNga0F5pLFGNjmc7oyHRsn5gVm7cEkHqYsOpPQpRAFxM1
 EoAcaRT09/MVD/xZdSEad867abRdqhXqYaxzUWZSHZ5+zpc1gzEn+ROoQUQW8uSdOcEz7
 mXcGU3/URTHO6i0rSqlwkxOxGen26ua+TR2HkKiZdWi6vx4C68QYZJNM7IexOModlaw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=cJbDDwfz; 
 arc=fail smtp.remote-ip=198.175.65.15
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.15;
 helo=mgamail.intel.com; envelope-from=anthony.l.nguyen@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=cJbDDwfz
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 786EA407DA
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 21:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792012114; x=1823548114;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=y5B/04zW5KG1jGhJZwQB387FePaJrdI3JCIlwDcE2kA=;
 b=cJbDDwfz3xkc7R9hgIOPvUI/FRog5h52jmsVjAPBeVvu3BADy6l4+fty
 Q0QT4zLESpngwof53F6gDmWOjvcY2D7T3tlqCtDwMU/QrfskElBb9QSY1
 ajhMubwR9SgwMqNR5zYBTWyHP8DgVmBXUF0k+p5cEsLl4HGO8qU0Euubs
 azImdb1KypurHM67hjEprQMDdnsqdKg2rYu59FE2+70nKIwORb2ZNQRwX
 5ngWgYToF4H/bipSrZcobKrzwzD3/sJarH/rTTwfhZFETBUSyWPefZ9su
 EpScfpgH9cyuRizLlfp9vIkjzOMH8s+nQpOkx2I5HbDyco8xZTPGAQmb8 g==;
X-CSE-ConnectionGUID: bAUAJXKFRjKWFI3cHf4V1w==
X-CSE-MsgGUID: cqcvBBh0S+enj9s0OT1bwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="767090"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="767090"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 14:08:32 -0700
X-CSE-ConnectionGUID: ptSWGm1XR2+yZ0jV7RuJ/g==
X-CSE-MsgGUID: VtQZwT64SvCdHNsCzyqX5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1880244"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 14:08:31 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 14:08:30 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 14 Oct 2026 14:08:30 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.1) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 14:08:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZQDm3c5iOKZ5eK7ddOIrHNDi9/wLmcvNe5zYyrGRZvm7LpdVoCKTUidyNR9L955ux9TgiQVcI4CxSH5eatxT8+S9uLC+fBZhGc0Y3dmiglsyeqbJLmD4MCI1lky7hS1H/VbrAX58RpNiMm5uQbXemmkKE+7/JzClbyxrRnfT29R7CdF7f5aqP8gpxnbkYA87q22xnJ37BKkiXLJnpwUhiuqDnKNqMNh90ts2KyeX4fq5+rZvaNUudlkQALnPU16lVMEHU/6n0KzhdDH7Xk+VCkYdHtUXryMCcfykEOVXbXfMw2isLnaJS6QxUYBv7jYRBE2dc7G00n/MJVFAc38o1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tjx+qEyCK6zdoMDnL8rY2I3Y6NyD9IYAYvMuWzbE2uI=;
 b=lnPQvp6FxtHBoav5Jefq70Yk2RVHsnOz0K8a6YvA2pG5wMuiw9p6zjQHBs1nj9gopwvKmVBoUyEFiLst+fT3nI+w32BKQQG4SwrRGIkJf8kJEWRggsAHO5/O3lNaPgozwh7uZe9V8t/BO97+Fs4nQlvWsU/zqJ27hOaCbBr9nci/nMiMcvAE5bt4tGdisnVQfPDE3svojHxrJGAe5SYZBqefgYmXFRisd84QgllruqIkalPct76ZPXPB4+JfNnZYYeWPNlZN2Orwrxsj1zJPzq24DTcwHvLutyJGAR7Fs5a88t0CSJgaRqR8TqA+qvW3EEEn+aK5mioBX2qS4aasQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8230.namprd11.prod.outlook.com (2603:10b6:8:158::21)
 by PH8PR11MB9770.namprd11.prod.outlook.com (2603:10b6:510:3a4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 14 Oct
 2026 21:08:27 +0000
Received: from DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40]) by DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40%6]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 21:08:27 +0000
Message-ID: <9086c9d4-d2d4-4ea0-91ce-5eb047dd931d@intel.com>
Date: Wed, 14 Oct 2026 14:08:24 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] e1000e: incorrect modified flag check in
 e1000_read_nvm_spt() (Bugzilla #221729)
To: Ruan Bahia <ruanmed@live.com>, <przemyslaw.kitszel@intel.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <kuba@kernel.org>, <pabeni@redhat.com>, <intel-wired-lan@lists.osuosl.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <CPDP284MB39374BC5A0CD11C9253CABF7C79D2@CPDP284MB3937.BRAP284.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <CPDP284MB39374BC5A0CD11C9253CABF7C79D2@CPDP284MB3937.BRAP284.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0307.namprd04.prod.outlook.com
 (2603:10b6:303:82::12) To DS0PR11MB8230.namprd11.prod.outlook.com
 (2603:10b6:8:158::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8230:EE_|PH8PR11MB9770:EE_
X-MS-Office365-Filtering-Correlation-Id: 0465c601-f33e-4120-4acc-08df2a374a0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: VPUKA+QpjW/zx3H3aBup3xcq84swrg7R5743jKGjIFXWBuMiqlKWNkm3Bdyt1FEM4vcbCg1WJN4XJ6cGjY0a0JZqDMjJ3NF6Cag3748cyP2lYBDmHg4X8nUtQBLhpU2MPLSRY3j2/jrSsInzhFQ2STuWlbbo3b1D/ERm0NDGFVSC3aal3x2mkcLXoFvmKMubhIKxluWcHD7RGiPmDdpxdX9Pf3Sa0P+qJeq5U1HK0v+Dh93/PkntbLQzNdubIC7IjhbbCiNqY9dHErug2lW+mrRwRGkbUaVdxvWJfz5W8pXIzYLXOF+zmCGdbiW6rVcTg2f8FQtX50Lu7Segf+esQazbu/hYGFznmV3eGADogLlBh5CJ3syw7USdPylA3z+LyY0dMczObBvPgYhWgvwCgaxQskqUmYydus1LFwu37vUb76UcCZWaZTB8VOe0FaQtQGJ4n153kJOG7LC+1ET8i73MvlLoe4Ky8Z4+ZnnUuQN/rsMXUVGjxRyrsDoOPiWNWhMBD7Spygjeitf5VAC5092z4btDmk3eGO6Kot7GKSFeP/ukduiHpro6ANfMT6HhWeQQYnuI9/lgsBX0N/kL9qjNy/fYyChHDZeO1xSRp7Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8230.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTFXdDdQcGlTUGd0WldwM0RHWTVhckFmQWRtb2wwdk1yaS9ERllrZ0Q3VFRW?=
 =?utf-8?B?K1BYNS9wd25lUEZaa1dzRldZVlVpZEMwZGk4c3RRNXlCMFp1UWpUZHY1b2RH?=
 =?utf-8?B?bHc2RmdoQlJhK0kwVVJGMkRYaFdtay92bUd3NUxTNDdHOFlWbldhVldrNFNG?=
 =?utf-8?B?WHJuVm8wUEdabXM0KzRVOVFXbGQ3YnhlVk5Vb1c3QWIreDl1REdhRVIzazdC?=
 =?utf-8?B?NjN2ZVBzc3F6UkZxc0NUUDM2ZzFwVlZwWW9TcHRYdXBSMEI1UjlKTkxYcjcr?=
 =?utf-8?B?VmUzWlR5SDdZWkdrRDArZVFSMjQ3U25PckUxZ1dScm1lcVhoYkFNYTVYNm96?=
 =?utf-8?B?OFUzamFsdXI0NUE1RTR2YlM0cjNqWk5rLy9yQ2Z2NHRld2VWemRpaTNCandB?=
 =?utf-8?B?YUlrdzFCOU81Y092dFB5MXNNRTliL2FCUUxKU2tIa09jZkduR2pGTWltZHFJ?=
 =?utf-8?B?SktGdjVWWU1BN250NW5MYUJVakg0WWl4eW9mYjNiUGp3UVV4MzVnODdXemVP?=
 =?utf-8?B?OVpKeExqaWdIOVdMSlFTY1poSVk2OGZyNzNSTHRjeHFSZEVxN3BZRkxwcHcz?=
 =?utf-8?B?SzRCaHVwYWtuQUp4MkdtU3RzdTAwNzkxU2hwQXMxZHNMVzlmWUg4TUJMVFls?=
 =?utf-8?B?UW5mazZhTHQ0ZDVjQUpISGVNSlBHTTJYMU9kQVJvTjlJT3RzcW9NUzZRNTdD?=
 =?utf-8?B?akdqaHJ4ZUhWM1NBREhTQlVML3NMdkF3ajdmUGR0d3RFRFlleGRJYUp2THcr?=
 =?utf-8?B?SzFPd0ZuTllYdWE5N3hNeU5wcldOOXY0Q0dpUllLMVpCYzVEWUwwemUyOW1k?=
 =?utf-8?B?MmZMdWJENlMwamhkUzAyYmFsZlBaeWZMWDdZZUEwTVlkZTBLRkc1RTU5Z2FH?=
 =?utf-8?B?dDJNRGhRQ0QybE54ZGd4YVpVMlpFVVVtUW9KYStCOUhzKzYvZlpKN25pTmk0?=
 =?utf-8?B?SUtJeWh5RFVhWHpVMSs5ZzRmZWdYMmk4WVVHZWo1aXB3aUxweThMSlZ2WGc0?=
 =?utf-8?B?eEl4ekYyalIvTUdzb1VmTFpZbkptWklMVjBTTGhRODR5ZVhKbkFUQTl4WmxO?=
 =?utf-8?B?Y1FNLzdRVmpIZzhWVktidzRFdDRjVStCV09NM3BGZVliU01lZHA3R3dyWDJD?=
 =?utf-8?B?UlpmL0NLSVUzcmNvZUY4VWtyQm9VVWtmSnNJczVrVmdsK0xFWmFLMXh1UW5u?=
 =?utf-8?B?RVAxY29SWjNPdE5Xb1pYS1dQNVZFY25XSHZreDNFVWtGRUJxZDRHcHh4dFlD?=
 =?utf-8?B?bUQxUzVRbGF3UHUxTlNadWhkUjJKeDRSbVhyaUQwT0kydDZoMStJeE0wN3Qr?=
 =?utf-8?B?djJuVzFrK1NCSUhNUkI4Q3g4ekRqZHVMNGlZVjVuQkx6d1pFdzREV3l5aTh6?=
 =?utf-8?B?ajNzYkg1T2xnenRROU5jbENRUkVvbXRUSTc2L1NnMzdHamFDQmF4QkU2anpJ?=
 =?utf-8?B?VTM0ZU1ZREUwZFlNZFJiYmpSV0p3YkZBNkFGY1hCUVZTVlhnM1ZiOFlCVXg1?=
 =?utf-8?B?OW91bEI5UXZWODRtR2NpUDVqVHgzVEJTT2xONDRKK3JZM3RpTy9WNXptODdk?=
 =?utf-8?B?eHEyZGMxZjdvamNPR2tvdzFMWE1rdzJBdlF4cUo1ZGlyZDZQSGJLYlRtWXNm?=
 =?utf-8?B?YVVZeENEVGMvRStKcWpneHE0YjFhY0RPQmwwQU9WQzA2UDltMnlabkwxWExK?=
 =?utf-8?B?MERBQ28xOFpoZlFxU0JnSVkrQjFSYktrYlRNRFFGUWRkb0toWkhyVVNOMW9v?=
 =?utf-8?B?dnM3WUMwaitUMjVzNWJxNm5nQTE5MEJZbXpwcG9ZaWVBSHR0aENLUXVZRlB2?=
 =?utf-8?B?K0RIakV1bk5laE5YZGw1bGVsNVJGSmR6T3ZLUDl3K2VtOERtcVo0M0pZbkRS?=
 =?utf-8?B?YXNXWkppNC9meEtNZWtKNitSUURPSWcwbk5MOU91NzRCTnJKK3NDeThuc0ZD?=
 =?utf-8?B?VDE5V1hjRUk2dlJ4cHY2bEY4NmNYZ0dEQzczeVYzM2dSMmlYOUNCRGNmY0Fu?=
 =?utf-8?B?NUNSeGdFdVJXbUpzNldUMDlmWnV4SnFlQ29BS3lMY2h5UFAyTFRlR3ZVWU1o?=
 =?utf-8?B?Zlo5UVFxVWo0OVZGMWFGYkIvRWh5SWw3RFYrT1crQ2w1eFNxR2gxM2s2RU1m?=
 =?utf-8?B?Z2NBUk5jdmRXRU5iakNTZEt4WVd1OXp6Zkp1TGJTa0dla1dIc1d2OHlrVk51?=
 =?utf-8?B?U3pPSDRWc01wN1VrY3lPck55UFgvc0dNbFJNeXF0R2Fyc1JvR2J4ZGpPbEZr?=
 =?utf-8?B?QTZ6dHBibkF6akMyZnB4aCtRaGY1K0Nsd2pCYlNLQjVJN0N6RG1FZGsyR3lN?=
 =?utf-8?B?SXpGU2s0K1RJa0RaMUN5N2JMMEpFU0thMmtFS1FzSG5nY3o1UFlQU042S283?=
 =?utf-8?Q?LP5W4wdS67xneQk8=3D?=
X-Exchange-RoutingPolicyChecked: nfgg8e+/WYKMwcPDTlgMmvNhre7jPg9kozo6vh7CPFga1+PQmNp2V7gyYhtlJ0KjIg0vWbirhFzDgpZv+Qnjwt3dwbVilHcVrAULYswW4vk6pldwIjk2giiOolK1MGGuoMYOfScebjHPpZ0c+vMcUi3mK2N2CsjBcSY4TwDIwPEBSZVO7qetKIf14/cUUQG1Kbdp6gyJ1wyO5+fpxlw8tCXVphADzGdle5TDA6CgT7keoDbercElY4xZFf71QF+vfhu81+m8SGLlPbKWV8SWrxpYq3QEXghPcG2Dd7Uma8WaO7Zdqp3TxQIBOaQysoNcjer24v3VSVDExYvRSLLtmA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0465c601-f33e-4120-4acc-08df2a374a0c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 21:08:26.8383 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nPlIPRL1+gTBmhSUHcuF6mXsKsqTsY3qsC5nIKFvwyaaHbGY2mHOoIRPJh5XL7PiDyrWGzdgnI4je5HVxFniogO56n28MYJT1Htku64kFos=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB9770
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



On 10/14/2026 10:47 AM, Ruan Bahia wrote:
> Hi Tony and Przemek,
> 
> I am writing to bring Bugzilla #221729 to your attention (reported there 
> in 2026-07-06 19:39), as it describes a logic bug in 
> e1000_read_nvm_spt() that can cause silent shadow RAM corruption on SPT+ 
> PCH chips.
> 
> A fix for this was recently submitted to the intel-wired-lan list by Ivy 
> Lopez. I wanted to ensure the Bugzilla ticket is linked to this 
> discussion for tracking purposes.
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=221729
> 
> Please let me know if any further information is needed from me.

Hi Ruan,

Thanks for the information. I've have it queued up; I'm waiting for room 
to send it. I'll let you know if anything else is needed.

Thanks,
Tony

> Thanks,
> 
> -- 
> Ruan Bahia

