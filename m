Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 358BAC9830B
	for <intel-wired-lan@archiver.kernel.org>; Wed, 23 Sep 2026 20:31:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F0D3760B73;
	Wed, 23 Sep 2026 20:31:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A_Su0eyIAOju; Wed, 23 Sep 2026 20:31:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 680D360BBD
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790195488;
	b=VlzdmzwIZ6GCeHMDahgfBHNjFy98jfpMbgHti6MiHjHx8Cs7fNc+6esNQ8rjTLeaC/Gc
	 pjTy++BnXvVw5jjQKAZruiDWgrj8x+xpXELqcWGZUBCicZiCAW0yYhmsobEkX/PPz9s8E
	 igjZ9pVj4HkJQjEuiatfvcroO6750LySRPh88nq3yDpSUtnwTVM/+7P91BTQEetfBM1Rv
	 FWHz+FvsXjNXlR9xVgXl0eYpwT81xe/MeVhe1jmhOrOGyNgRhyK6grCYFZWtcEgnH56is
	 +dZHpOAq84hb9q+wco8FNz5T2wcdI9zYtaeGoofc7hXs/pQhKJ9W9/seWS4QEvVpJqg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790195488;
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
	bh=Xsq822C3F7Fi2fPf/F08BVp5R8QssBFiE+UMaN93WhU=;
	b=rSDzxKPgR0/J046j/fYnOdFuw00mc/M0oaLBFO5U9ctKytT+R/EoF7KidmvdK/nUatvK
	 k2mW5VksBXPee5xNT30EZMTD1aGR9+JmWTRDfQBdDU+OBIaRZiILf7T6LAGOvU3SPbKAq
	 eGnb2t4vLeaZeFzjimiSVD5x1Nu2iiya68VCLhuxCrAgnM5bzQzJGQ6lRU5p6ldndsbk9
	 Cng6wnMJ2oJnaear4P/dkGQ5QsqZmx0MnMHkpx6p8NOEUXhUePdVA/V1VPhYTD/FMUJQh
	 +cpjLoBadcBrcgT4DGbezjCSrQsxoJqi9sfNNNwDw3xrMYcCs2eNRGGEtB37dZpvkDQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790195488;
	bh=Xsq822C3F7Fi2fPf/F08BVp5R8QssBFiE+UMaN93WhU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1+EMab6/f1LbC95xNIlgJjw0QhVbT5lRwPwRlMHETtwc7EPH5G+bCoIR+8bFiYF/1
	 S5ti3qcd1NnTaRX3UhAkvYwvzVV04jwYhCx466hei0WxkYsqibghA6TXDzjzEKOV31
	 Zd83nfMVMgwVIR1dxa1qQhI5i71utaaaCrnDwEBPkFzupTi1x2IFsdwkxyMu/h41EW
	 GIknavkYu3sFiLrllvA4PCIPs/dlFJqTB3P3ocFL8Atd35HKL/m1oihvDA6UyRV6kU
	 Zy+MqzDesN3B9CpQZgqz0oocN2dCoh2CDg+FX68MbtziY/8xtfE0vxAkZVEATi09ko
	 GFmK4Tc4D4BNg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 680D360BBD;
	Wed, 23 Sep 2026 20:31:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 003023A9
 for <intel-wired-lan@lists.osuosl.org>; Wed, 23 Sep 2026 20:31:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DA295427BD
 for <intel-wired-lan@lists.osuosl.org>; Wed, 23 Sep 2026 20:31:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 55kLDNsD9Iq5 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 23 Sep 2026 20:31:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 21CA8427BC
Authentication-Results: smtp4.osuosl.org;
 arc=fail smtp.remote-ip=192.198.163.17
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790195486;
 b=M/pGLnrzKdMwzeDOrKhZkZPFQpMo7OCsFAEHxJIlb0PhgJ6B/gZoFH+7GI3jF2nCwiAq
 eFbBRd2YJnsRb6SAj3RchLvEEa8lrCVc/4whLQAg9F5AeJbW1SeGZW7OGxvHxuYxr2/8y
 t/lO6XOKClx5xzeunCMAp8g1AKieiOwvDkJpVgNNDa0ACvTYxZJpgQqhvqawgOotQhTwr
 71R94oWWwmAXc89umMTlwmp6uHc84noPcpiuOAJDjPzfS3zKpTC1sXMoFjc/ZTJHBBxbJ
 bbVmyb2dh2sPBuVXu60/vfJgH6fMxzXgdo37weeEpGZbuHDKItqB5wGp9qZU2PJLxag==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790195486;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
 References:Content-Language:From:In-Reply-To:Content-Type:
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
 bh=Xsq822C3F7Fi2fPf/F08BVp5R8QssBFiE+UMaN93WhU=;
 b=JQgp/PLD1C0ob8RGoKLp+AW1V03DYuWK4asCWhZnFKFwz59j0JtAk/eXMISoxSFhi6RB
 1JwUwxPjszbw7QrzZpZbYlijGAy8tGSef69PWfIceMeEdtvgrdYBsokmZ+1enz8cDLd1h
 c4CmPXK42xonx1mc/QPQ53x5GC7b+IsZ9ZTfkZVsl8lQVIJ1r34rmRt/gUJ7C6JiK2FKh
 7jYoXeMxeHjqYbOubzbC/WFfJFtof9AcG2A1ekD08iKoMcyC4CITd9z5orvDy2p3oHjbG
 z6Rb6/Ga+sclmfkTbzShRyQTH+tzrOofbUP9UyRnTSDYT7WkN4MNH+YByE579aDDFWQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=U+6WEPVT; 
 arc=fail smtp.remote-ip=192.198.163.17
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.17;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=U+6WEPVT
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 21CA8427BC
 for <intel-wired-lan@lists.osuosl.org>; Wed, 23 Sep 2026 20:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790195486; x=1821731486;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=DxOv4fJjoqv33tRIsmr2rll194Es6UEMw9PbLCfLMsw=;
 b=U+6WEPVTiK9w7o3Y8EhW4i6R/0KCCTSK9xjTmE/yj3nMSMrM+gts/py4
 CEGtYRmM4o3j9o1tI/8/kv4HvIZtpY42idWkkiwDBhHWpDi3BOHfsU1bm
 0PP0muFgP9u7CNz0k6bilk48JcSSbK8L36rIoQv3USzJ4iwdk30J9B/MW
 7JLs97/J8klylKSpjL+phsUouo64dSK3x1lI7NPOa3ShkB+6uPnszQRSw
 NgT6Jr6pAygzTbYgx7EIfPfUfUTALqSJ59fAO2h0YMVlqnDZin5mXcs1h
 h2a8WHJ0s/hz4GL9PERcQZb4jvdRCjGBC/gNyWVjvxDcOgMqce5lcabnh Q==;
X-CSE-ConnectionGUID: MvRNJVZ/R/WUXx/IKfIxHg==
X-CSE-MsgGUID: 84zT6dRGTGmDsYTHPFqVpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="90800045"
X-IronPort-AV: E=Sophos;i="6.27,119,1787036400"; d="scan'208";a="90800045"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2026 13:31:25 -0700
X-CSE-ConnectionGUID: wgXR9Ao/QOCaC7qTXo2HKw==
X-CSE-MsgGUID: bzREmg1MT1mkKCi5HwcYmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,119,1787036400"; d="scan'208";a="270271373"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2026 13:31:25 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 13:31:24 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 23 Sep 2026 13:31:24 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.24) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 13:31:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tu+CcfmDrkkz8OQp3gzMlQ9Xg9I48rAxkyQAq5qAsnPF92B3SHLJfuria1SkMsoGa75wSQIBujj/mGeKBa+ZfNQIlkVsi0WULBi6akTL4YeBYUcxfH6vZWikRorzCs5NpHwZFmHA56Xblg7BuRPFkZjAvENF+IDbXVEIECXdrKc/xVz38jtSKgTbgRv+Ie4rcmxVsl/sPEQJIBY3WXIIODElVTDIz+e06TZYKadLv3r97daZ/PQyiTtJGmC+Bz4Xlpfi0eMe2cBiUCK6o69DS8nXShBEZdAq2QmiXXrVjgncT9IaUbQORKafTpNl8bQKDuV2N5cZm9cpI59QJmCbuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xsq822C3F7Fi2fPf/F08BVp5R8QssBFiE+UMaN93WhU=;
 b=DlOXlMkvQ+FePZreeYT667TLm1b975FaN0E8ljO/7sF6q2lHzjeSjXH57GQF1B6HcYurYhpCuvZoPz+DKcL4iwllkb5w1bRmavlBHf+sclkIqHmo+RJfhDooqzckeLvJP15BuQgRSKMiD7OLbER5P/8JwXLfrSqOLKhFufzpLUOhzK+PEkm8s0Biip9EHTuWLWog+qq42ZZ636x7aYoi1M4mKvLFuvvSiSEZnS4DGWNTrK6lRujhRVwua+yQoVe67/x8sXSvVJ6QAm8N/byO5e47l6e/TI0Ty1DICM1lmFJSY6ihg1hxW1xvFKO+xUYF/rZlHo28raPZFUClENX6Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7364.namprd11.prod.outlook.com (2603:10b6:930:87::14)
 by CYYPR11MB8432.namprd11.prod.outlook.com (2603:10b6:930:be::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 20:31:21 +0000
Received: from CY8PR11MB7364.namprd11.prod.outlook.com
 ([fe80::1b92:4856:eb86:f7e3]) by CY8PR11MB7364.namprd11.prod.outlook.com
 ([fe80::1b92:4856:eb86:f7e3%5]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 20:31:18 +0000
Message-ID: <ba81e646-ac3c-4532-96bd-f1fd7a400f02@intel.com>
Date: Wed, 23 Sep 2026 13:31:17 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v2 00/15] ice: E82x: timestamp processing logic
 fixes
To: Jakub Kicinski <kuba@kernel.org>
CC: Grzegorz Nitka <grzegorz.nitka@intel.com>, Arkadiusz Kubalewski
 <arkadiusz.kubalewski@intel.com>, Intel Wired LAN
 <intel-wired-lan@lists.osuosl.org>, Maciej Machnikowski
 <maciej.machnikowski@intel.com>, Przemyslaw Korba
 <przemyslaw.korba@intel.com>, <netdev@vger.kernel.org>, Anthony Nguyen
 <anthony.l.nguyen@intel.com>, Aleksandr Loktionov
 <aleksandr.loktionov@intel.com>, Petr Oros <poros@redhat.com>, Paul Menzel
 <pmenzel@molgen.mpg.de>
References: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-0-e55b692d0e6b@intel.com>
 <20260922112216.41e6f8cf@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260922112216.41e6f8cf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0110.namprd03.prod.outlook.com
 (2603:10b6:303:b7::25) To CY8PR11MB7364.namprd11.prod.outlook.com
 (2603:10b6:930:87::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7364:EE_|CYYPR11MB8432:EE_
X-MS-Office365-Filtering-Correlation-Id: 79da1bdf-8aa0-4b37-d2f8-08df19b19f90
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|10067099003|11063799006|18002099003|22082099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: uwk1dL+Km1TQSszPRsE5TeACndpAPuDRGZEkC3gVNYACDhg3RmSXjtZpPE+eRQPhhPAb2hBkYewI9JV3Wm+qnCTMdlo8XoKwFdNqJppotDL7+uqIF1iKDrVyHLeZtVrDmFO9sUviGmi6XeVcOsHHB5TNYgGZiizHLmtfoQlH4/gCq2SpQOH4ZF1ma17gYAcI3SjRjHnIDDJSvGhbT6DbamzMSRUibkHBDr5QjLQVfiSXXQFnDDpdNQce+Bgexnqo7RCJ5ajOKVFLS+SvdBG7aU30hpwGC3rUv8Svr67mlKp8i4Yd/UmgwXBn2HY1O6+wDw/BouZLFh7m3MzZIEC5VppjCmjVhIfmw1yQmtArmIxXBcMUMDhLLdnsuMeNYkiWyLJvc0ONP6I/INMoYMpLYgp8mkHY/NkCNQQOxeVZtWstHuC68K2F4SEi8TRHJWQ98wY+qHxHBRHkCBYAvXDIVTipI/pyk3tv5y0EsGXKp9ldqkVfaEhItC48D1k/x3Buf+9AGNFOl0iJmF6IV3nuo7Rg6dkBYOnh99scDNRdnCTBl3JlfCRJVMaI6MzpEglWGKXevPsca0G6G1STl3QKQvE6V2N/2rzosZs+0/TaUM513EW6iiN3m4ohc0IthJ4jWhEF1TPFYZIyQOTFZKfAzzI3+R5wjqXkMPlxpw7fcDM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7364.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(10067099003)(11063799006)(18002099003)(22082099003)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXd1SXNYZWlnUk9sN3Y3blI2bW96NUIxYVlUMW0rR3FWSVpsRmR6dUdhOGpB?=
 =?utf-8?B?dVE2QitwQ0FXaFBqbVZVWHIyT0kzV3RCY3IvRE5XbzJYQnpJQVl2Szk1K2o4?=
 =?utf-8?B?SjUzbXFjVUo4bVV1cVVHamdXeURIMGxKWWFreWU3Qy9ONFlLMDNONjh2aW9U?=
 =?utf-8?B?WU5vUFlJMlJhYjVRT0MvUUFhWXRNMHQ2YVY5RFpNSGFIMmNxUElYMDFTZWhQ?=
 =?utf-8?B?S1JUY2hrRWhndlp0M2ZIRm4wcXNlN3h6dVFlV1ZMSFlCMTR6ek9YbGU5UC9k?=
 =?utf-8?B?dEtXTlcyV0UzZ2M0L0JoNi9LcnhJQWgzTk54em5xL2wwTDVlR01RM3E0N1Nk?=
 =?utf-8?B?YWsxTzVLV05PejRLNElVY1c1L0tjYy9FcUF3VWVwdlNwcDRWZDBSVDRneTBn?=
 =?utf-8?B?ZXRLYlE4RHNNd0NwSjZ5YzQzOGNZajh3eFY0UHVHNDlHcDU1R0RQSWVFZkhv?=
 =?utf-8?B?Ly9WYjQzRlE0SE90LzcyUkI0eXp0VDR0SGY1LzdpQXdpKzJDWVpINXJnNWp6?=
 =?utf-8?B?engyU1Z0K2VaQ1JrUHRhVnllaHN2YXNVeHhuN3A0WHdhWWNKakxUc3podzZ2?=
 =?utf-8?B?T2RScm1tTTZuSVhzdUdha3JPUzVPQ0piZS9wN3Y0L1FRQVJ1U2tOcmxsL0Jm?=
 =?utf-8?B?c2RDemltYVcvcEJsSkRlNnIyVVRKZHRVaDlIZmNQNTdBaGZVY3RGYnROTzIw?=
 =?utf-8?B?VlNKejBhYmoxc2M2V1liZjJDdnhaSVJic3RoZUNIK3VwYTFpKzBNbmluY0hN?=
 =?utf-8?B?UE9KeEVFYXVoTUYrL01jWCs5WmhWVXdxYUZuMlhrM3dtMy93T3R5NmkweGN6?=
 =?utf-8?B?QU9STk5aOGdZemlhaTBNclRYeW1IWHJKMGZBSDVnb2gwMXE2U0QweUcybnVK?=
 =?utf-8?B?c3o0YWJxSzVJYWJzbmVzVlphZVFGR3RyWE0zT1NQSHBELytwVVBjWHJLMXVK?=
 =?utf-8?B?SHNYQzhLZ0JNdENlVVVMWDdleVlaVXRaWHZQK1h0TkJYR1M4aDE3U29NdVlB?=
 =?utf-8?B?QUllSS9uRG9uN3A4ZnBqVTVoYWh6aEkwYnNVMng3cWM0bEFjclV1YzJTWXdm?=
 =?utf-8?B?SVRuWFpOa0VZZ2psb1VmQTdzSE96T1FCcXE0SkdpT0RmRGcrS2RDYzZHV2ZD?=
 =?utf-8?B?Q20yTU02YVRVVW1DMlBtZUt3ZEJLUHliNXltcklNWXkzYVpqaVVCRGhQVjBz?=
 =?utf-8?B?VEd3bWNyZVNVaGFQM2hjU2VuTGE0WnppWkZMUUtpWDlEbzlaL0tnd2FsZFA0?=
 =?utf-8?B?aDJ6Yms0dmhHcTN4aHI4Z2lGVmx5UzdacHRzK2ZjL0JaUk85Qlp6b01qSWFz?=
 =?utf-8?B?UEJUeTRiYkh4QTN3T01IajBKb1FOM3ZWM0NGd00zSlptRlphSWloU3VUWGh4?=
 =?utf-8?B?R1BwbWJDR2JsL0NveUJ1Y1Z3cmN3WlNmSXJYdlhXSklrQSswMlo5bU5hZUtX?=
 =?utf-8?B?NThqNS9obDdLZTdNQVIxTEFsWW14azUyc1ZtUWJHeDhQbUg2T3g1NGdCRzNl?=
 =?utf-8?B?aWNEZ3pFYlpkUDJxT2VBODFySEdDQ1lKQzdLTmlzZDJuUHhUeExrT21LOWhJ?=
 =?utf-8?B?cUpVcm9PNHBMcmhpWmtsdnJ3MTJNdVU3b0lKQzZQbFVjejFNQ2FpZjY5cVdT?=
 =?utf-8?B?N0NxUGZQcjNUUXdPS0Y0d2dwZkFvOG1QTEJoNnVuVStGcnlYN202TFdVZUtu?=
 =?utf-8?B?YTVVQ0NMUFM1MnZ4U0U3WXp3cGhQN0NvTnp4Z2xYRitjM25ZWEVKVmd1K0ZI?=
 =?utf-8?B?UEE5RzVLbWhmcURmdWwzUXNNM2Exa1BpOGNoZVpuci9odzV3amlEaVYxVGJv?=
 =?utf-8?B?OFRPTGw3dVdtQjI4b25CVDMzeUc4ZFRLM3B4ZmlPdlgyYXc3YWVtNXIzNVpj?=
 =?utf-8?B?UWlYaG5rTnZNbjIxY1FOMW5YQUNDNzhubmxIWlFTbHMxYW1QY3NkMjQxZW9v?=
 =?utf-8?B?Y1hOV1pvUnN3Rk9DOVdlMVc3eDYxU3ExR1d3TmpPa0lTV0NWTVNxZDNMMkMy?=
 =?utf-8?B?eHlRUTlVa3BycjJHMTY2eGhwNkVUamhqaTl4WVZWUVRMTEFmNDJVNDFKeWI0?=
 =?utf-8?B?OXZXOFg0bytiREMrOFl0TTk3WEN5cU1CampSTC9wMWgwWmtsazhLRjJWRDd6?=
 =?utf-8?B?WUhsZGhmQXdYRVp2OG5IK3dIQ1RhUUpKczE0NFF4SDErZS83Yy9uM2NYbnZB?=
 =?utf-8?B?aWhGQ3ZjUTUvcXlreGdXQUdXajBhWUpzdUFhYno0aFdSU0lWUFdqR0ZFOUow?=
 =?utf-8?B?Z2JkVG1CbWI5ZFpJdzQ2dFN4c3hlVmtzQ1dCQlFSNmprZnRHQzJQOUI5d2Zw?=
 =?utf-8?B?S0t0QVBKbnRMTnV6bEFKWG5UME4vdk04ZXFyRDA4MXVSTDYvQ0FIVnJLMlJE?=
 =?utf-8?Q?tSpe7TMKT/eMaRhc=3D?=
X-Exchange-RoutingPolicyChecked: MY3g+FBVxD1HlvuuIOYvEnp1NGlLci/MsKGwensk+mGrYNo/l+0re/EIZHxxeOGymLiEiW4Y0gq88SxjD4mmYbajEYi11ajXQTc6SVnORnTHsWDgtGmBLJIf8AiWLirilQl3ykzsjKBhevGe/c9lIqJvrrT9kNpG57aHJ0thQsvvRxflNzHn5qYU+iwwc6AQxfyBnw9MQz3WAnPEw2A9XodU9/Qtt1YZ4T46i9r6ekWGVpQw8and9/slp76WZiAjxuXzTZZ86O2fZTV3A/+aw5OL8KkHKQbQVXmOuL+0FkjpvGD7yDs5kenYo2Atq3PTksy1h6oKZpWnM9GdXNsoog==
X-MS-Exchange-CrossTenant-Network-Message-Id: 79da1bdf-8aa0-4b37-d2f8-08df19b19f90
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7364.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 20:31:18.8480 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MsQb1l+VtHKpYjvozhv4H347kW0PuVbHSuYipfoaTKrUiRtBAOPyZuFr1vneKnXBOCmltgb/gsLezkMMFv2u3Go/H5HEdJUIUnOFRLO61Bw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8432
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

On 9/22/2026 11:22 AM, Jakub Kicinski wrote:
> On Tue, 22 Sep 2026 11:02:33 -0700 Jacob Keller wrote:
>> Subject: [PATCH iwl-net v2 00/15] ice: E82x: timestamp processing logic fixes
> 
> I think we need to reconsider iwl cross-posting to netdev.
> I can't get my unread email count to stay under 1000, and
> I don't think the cross-posting is really bringing much
> benefit to the community. IOW only Simon and Intel people
> look at the Intel postings, anyway.

I can't remember the reason or source of why we started doing this. I'm
happy to avoid spamming netdev for the intermediate versions of series.

I think it makes sense to include netdev only when we're doing something
outside driver work or believe its particularly controversial.

I think Tony reached out to the rest of the team to see if they recall
more. Of course, the maintainers wishes here take precedence.
