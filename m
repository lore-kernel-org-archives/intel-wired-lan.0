Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51675C98304
	for <intel-wired-lan@archiver.kernel.org>; Thu, 24 Sep 2026 01:06:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0B8DF60B4E;
	Thu, 24 Sep 2026 01:06:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yE8v4m6LdllQ; Thu, 24 Sep 2026 01:06:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org CF47960B49
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790212005;
	b=d9yhwAOqfqjBwjoZLk7RAEulCgZBBNx7VE6VMWvcFcO258BLvnubWMmQP1sAXj+HMvBN
	 NKoUgLve8J5szJjb7jKOUlJjr9iE0D4zX1fPy+zYY6q04flRUb8w0ouFSWzqjJgGIG48L
	 4Ms4vllk248tylSSZA+MaoXxfcHQQu0tUxkxH4dXltPs+wmZPqenytsQHrB41KpNCCJQp
	 UjhXwH2isJW934M78vgIBAm2poE4ZMIivuSP9xfb49x3P0BImX9RjJrCJYpIkYSBdbmmL
	 CPnee40oXiYjdL5Qlz/1xH2Eb+M3Gne5U2YxDPkmLsISSe9TASRYjJKUypG0QCuFUeQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790212005;
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
	bh=SRWrK33UnmKQQ2qh6+3rUQuMH3/EI28AdoeWCZbU5q8=;
	b=Ls/VwaJmkVovFcS4YLIGQsv5NSoxpDbNEbNeZolIHEKsW/rLLkZxNXOqtiMRoj7Cibg/
	 OeD2dHcIe3t+mz8tWTfAhPDH5Nod1Oz/1rC6R814O8YXTXnTHcV1E0y5FVpwdXxhOT1z7
	 u9BFQNE6iNkrsT/tWRLAhUnM0x8ForW/9BlH0nRzI9fyRWeNcKZqQkh3tj5pJndYFngat
	 dIGKXKiw99M7rFZF8kT6vJA7miac6ekqk1avdMIqpEpPHnB2u8r9AZWskiUSJ/fvCg3gW
	 s2Plkt5yZ1ocsVSyfijxuC4ygrVZCr3RhQg7bUULPBG2eNRVxN3MicgH8pePNG0f9Og==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790212005;
	bh=SRWrK33UnmKQQ2qh6+3rUQuMH3/EI28AdoeWCZbU5q8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P+8zDDK0M1+DAYgakfoj/jh6L2lFhXV//TDLf9avtTUC04D7tAKHmhUi1BmoLVTZr
	 Ck+qR6gUkEaoADrejYgL4MAaLIQoDCTLmoxfZ6Ve5YjCK+1ny3z/gboAmAkIh5/Yi9
	 fdA0tFU/DPjA6yk+0wxG3pVElDIJ+0uYRu52IqtMkaPm1mkAeFn0+4ewHphZJlR/xh
	 1JTtyC9gotwSwmjcaPkQtOpYG+2r2votMp3Z+7e7VgrBoYT9/sk6v2xllsHNSQgqad
	 H1nTUATSNKOz+DdTK4/rpXwqzBnSJjvALfzYvfDTfHeBWQHlKL0jl/k0OldOSIBEaf
	 0oDNJGWzi4H7A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CF47960B49;
	Thu, 24 Sep 2026 01:06:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A44A11344
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Sep 2026 01:06:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 95ACC40122
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Sep 2026 01:06:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w-R_6mHDYx6e for <intel-wired-lan@lists.osuosl.org>;
 Thu, 24 Sep 2026 01:06:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org B6E67400AE
Authentication-Results: smtp2.osuosl.org;
 arc=fail smtp.remote-ip=192.198.163.18
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790212004;
 b=b/ZZbZwwqwx7/chdJNwUIMSHPl1gmLmlA1F7cPV1BbYceX8jIjxrV4HBGEfaIzruqBf2
 z/QU6yJ6pecTh7i6TOPzPJ8szvrsB9hhgQ6cXWbCtsUk/F7r1nD2LWygRDVE9pmPRCd8R
 19rf2wqX8YJjBuKjFwyToYYXxHmj3LsxyTy9bEoFb3ceNgUennbRcUCiakuW1HrPVOlvH
 LmUpXnjJi8HlSF5V1EiQiYMIM718iLOz/pJg+kAL6hd01NG5peigKYKXLtKXFiHz8qi+q
 uRDnGyNSTdFopzG0M2HiX3XiJmunq2uQVbes7hkI5mLkks71XOv5LtKPiMXneNzPNoA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790212004;
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
 bh=SRWrK33UnmKQQ2qh6+3rUQuMH3/EI28AdoeWCZbU5q8=;
 b=fYA7DbMs+yS2NrPQ5z3v9WUlSiSCkipCyPHLbFtao1KouDAXAkIFSVAHYT6VQ11zF4/m
 GR/kWLKaLad5YBEAPynsdMtZ4VUmHfXL6aCHgXc0WbQ4OMbtoJM8U5TvXAKKX5Mw0r/iA
 vv3TdUx5TFAJ2ymVB6mLzAPVzIjYLSJT5oSW0kuNXKEe4vTzvvZ8u3AakufHzA6FR9BXX
 1EkA3Eo17fDIkHOSjeIDFWgb50geq39u9swTT4+QNhjhjfrM8KBvhAe2kw6CbRmVgD9tj
 rrwBizehLEulKoLNdYshtG6cr7hPoDZoZJ8tHCYf4XAI9RCiHTLPTemGxlFeyFVfxbw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=lmfQ+9WK; 
 arc=fail smtp.remote-ip=192.198.163.18
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.18;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=lmfQ+9WK
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B6E67400AE
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Sep 2026 01:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790212004; x=1821748004;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=NvkfFbxCtaaGOsjWp5rTJzVzMaTmO3jmGa9W1YXYWp8=;
 b=lmfQ+9WKsLcnff5B/Nf72B43rFUbvvXGELoHTcOg6rPgeY96FcYRZcja
 /vSj/E8aRQIY2f5kP1WAXtVV/fvA3bN2vHV8G4/Rm7JPHEUD2htK+SzXZ
 CdDI8IbrDTRg/NGHfBm/WlZZHCTThorXZWaJVJ6ZvWtFdJeqh2g4LbXIz
 re1bXxaNyZIpv/Bdygc36DQP6I0XpRcPYG5Aa79mgMv+8Y8vwO1C4HO3/
 h7df+58UCjrN15zmgmraUx9Nv7tFzz5RAAHUZ5LBkuIobqqw1fwPfsYjZ
 t7A8irlEvIC10ggw5mvhCPNchV2+ngcEE3Qh7CMF3pbKS8yv/r+2GE7eZ w==;
X-CSE-ConnectionGUID: QjHnt+IyQMK6v2ARbKaG4A==
X-CSE-MsgGUID: kfVaxMvWQ6eMfbIA9CULRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="90088345"
X-IronPort-AV: E=Sophos;i="6.27,119,1787036400"; d="scan'208";a="90088345"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2026 18:06:42 -0700
X-CSE-ConnectionGUID: N4p3fXWRQnmPoug0+aJ+aQ==
X-CSE-MsgGUID: 6gpsF3cBRrKSuLogpqENBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,119,1787036400"; d="scan'208";a="274031675"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2026 18:06:42 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 18:06:41 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 23 Sep 2026 18:06:41 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.70) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 18:06:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KQvUYHROiBJJ6sxJ8yp+MoEC415UuHlJln+opq9RytcaKde2QxhBcyzU3d/aWc7iKlGmZVRZlnH6cpxUl4lLA/yYtS5GbziCSaB9OHmdRd9L6RTEI5Kuvoz36Bc+ogRqDPMOY4Hca7ALnm9NeCOAW1fYp0aYeDMqvxq3D9sPJOOJD9bdpIIVR3uPqEwUFIDseJN16PM5UyOyr1XEjKwCVGtUUTXlyefYxp6vJX936oo93IwgGSJkU+W2ZrovulsCY85j99SMihxD4aXBRyrROqYEtn+q0B31zs2QjGDvYoKmIRHJ1MTZmVW7NItkyT6EZFm6gqn9KsicQXLZc5tNqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SRWrK33UnmKQQ2qh6+3rUQuMH3/EI28AdoeWCZbU5q8=;
 b=kgpDESdPsqwFtC6k/0ErLAz3jVKsZ2xIThcy6vJyLuwSU2fG3/3AoNMKIv+9Tox8pd5sjY6v3Sj2s9ZCsX5POcNkuUTOY6AEVbA1Dykq3sEFV0evaDUtOvA3uvLXxQ7T6l+7BICqV2wIpKHqVVPsvl33IT4EllH/BniiiXPS7WQwENX1JwxvBH+a0/2zOeRC3ISr0VGw77lGWNfAwK4RYHoIzdQc/VON+jWRPYL+c0CiknE/i1RIcaXLS+81e5TiqwN8Hi+xYPBcQkueb1lX9lIhtVhndzolrLnfSitO2gFJhAzkt0WgX8PQaEYhCMMvJh4eFDrC+bmj96XKYw70gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by DS0PR11MB7444.namprd11.prod.outlook.com (2603:10b6:8:146::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Thu, 24 Sep
 2026 01:05:53 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 01:05:53 +0000
Message-ID: <b2596696-2d5f-421c-ad77-2f47d1b0fad4@intel.com>
Date: Wed, 23 Sep 2026 18:05:51 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v2 00/15] ice: E82x: timestamp processing logic
 fixes
To: Grzegorz Nitka <grzegorz.nitka@intel.com>, Arkadiusz Kubalewski
 <arkadiusz.kubalewski@intel.com>, Intel Wired LAN
 <intel-wired-lan@lists.osuosl.org>, Maciej Machnikowski
 <maciej.machnikowski@intel.com>, Przemyslaw Korba
 <przemyslaw.korba@intel.com>, Anthony Nguyen <anthony.l.nguyen@intel.com>
CC: Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Petr Oros
 <poros@redhat.com>, Paul Menzel <pmenzel@molgen.mpg.de>
References: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-0-e55b692d0e6b@intel.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-0-e55b692d0e6b@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0027.namprd02.prod.outlook.com
 (2603:10b6:303:16d::32) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|DS0PR11MB7444:EE_
X-MS-Office365-Filtering-Correlation-Id: e06201e9-99e3-4ebd-140f-08df19d7faf3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|10067099003|6133799003|56012099006|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: X2H318txnkLxvdpgxNdqyg9TTOfd/geG97u8UthJRXDQszztIaaL0mzBTRAQth1ale2YXmlA6TfsRHIF9DNMRhyuJov8jzSQZT3ImVQQnZhtpTGK9shH4UYFSSJAOt1tNmq27NQhtlgZjJIxUkz8XENxUUQahTGW2akPdPcugNm3U+on66v+wstk+G8QDBWoLrslUQxRMVf2ATfbzU4brioSDgjZ6VkyF4aKIu1qwTz4PZp7UhHcx3cYmH+zo45w3yWay4N3Kg2LAP9p+KI98NIkR+K7ffv7fbuuNgOCNEdEUCvut1Xu1ZFEKXx/yNC+pUl9fBHDXLQ7UZREbtY0IQuURDjiDTLpvMCjTtjdC5YOlflcBzxMFCqHnwl63s0bnXxT224pF8J17dnYJG9qL9QtS8YGHIW/OYsa9sxa3HnKKyjxfEnQ7I8yvGUSlAdh0fWzpjcI7F/7eZx8VkWXMMQA9zQ3M3HvKFZKmXPIQlkQYa93RbRqylBQ6J0KJOzUuhf9IAsEBZhk5dXeteMiV2GQ3Z4rzksFaexpU+MYrwPPnYgdbK4Q40tVBLHDXPaWF2K0M5dHJo5mn58g3gbzz+CowLRBijvQKj2mw9biLxK0Vw540EzB3zSb3klDPLbVyFeOFwUG9ynQ0upzaRQBDi9gM1JrW9FI/WyZJZeHFVo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7381.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10067099003)(6133799003)(56012099006)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGRwSm13QlEzVjg5dUN3ZHFYV3cxNk9rVy81WkUxWUxsNWsxVUhZQmtsczlo?=
 =?utf-8?B?YktRRGFLT2NDTC8vOHJSNDZ5WDFDRnRkV1pYS2RsVjNYUkxwYVprd0xnWG5I?=
 =?utf-8?B?Z2FDTUFGVUcvUkMvT2U2WlNzNW93L3hDWlRwZ25BbS9RaG9EMXNNS1NraWd5?=
 =?utf-8?B?aEpieU1NNjBrRktUbStTd1hWdG53TEJ3RnUyOEZHRjl4TGNDWTdRTVJvK0VX?=
 =?utf-8?B?R2hvUDlNMGhOVDM5TVVPUE83R0hVZzZGOVV5NUNZRlA2ZDVrQUxXZnNSc2gz?=
 =?utf-8?B?NVpGRHZ4dHgzS0lRRXU2eTY2R241MzlDOUNMZ2Y3elVQeHA1ZVR0Zllmd0Nj?=
 =?utf-8?B?cGNvYUxqV2lMUTRXOXRHbkJtaDRpanBnOFlSYmhNOEZnN0xaS1VxZUdSY2lU?=
 =?utf-8?B?ZEZObno0cWkxeC9oMUx0MDVFQ1JMdTVZSS9EenQ3Q3pUdXFSSEZQcy91MFB0?=
 =?utf-8?B?MW1KQU1LRm90YXRyc3dqRXlad1NqNWYwOU5Pb3V0NXptT2FIT3lrbklmK2pK?=
 =?utf-8?B?Tlhjdm9tOXFrM2c1MW11aWhrNkpnZkhCS21jYVJodDB5RkJPNW5ZTFNYcXJX?=
 =?utf-8?B?cVRLUGpZV3FTT24xZFkyZWxTOFlkM0t6WHVRdk16TGE5ZHpvV2FGL0pEZklS?=
 =?utf-8?B?ZVljeHlaYmpxWTN5dGlqSkpoNWxpNWtjL2c5V1dST0QrYzdzL1lXamtmZjJ4?=
 =?utf-8?B?WXFPQzcwcHh1aG44WnNaWURQdWIxTGZVZFN1Z1lMRWNSRXZlRVREdUV4eDNQ?=
 =?utf-8?B?UzlBSUV0WEJpbHVKTUViZjFPazd6SkIyZ25WcmIxM3czWStXWE5BeUtNM0N4?=
 =?utf-8?B?RllyMFJITTViV2tyTkhlYUVjaGZ1djZWVmlmUVRMbkFkeEJpZUcrRElOaWJC?=
 =?utf-8?B?VHF6YUNyQzBUQkNIUGhuVFJSem5idE9VYUhncmkvQXUyc0lqM0lCNW9rcE9E?=
 =?utf-8?B?MDJZTGhVNjNCVG5yUXlyVmlCYnlaV2ZXZ1pVczFpWS9QV05jMnMrSmlrYWZL?=
 =?utf-8?B?aFdaWlVza1pPdXV1V1o0MzZKRXF4OVp0U2IzVW5GOThJOHhYZWZMUE1jS2Jn?=
 =?utf-8?B?Qm9vSjhpbE53TFQxTHkvb20vRXJKR3lMQUFvL0xsMnlKTHYxdGFjNnFSY3RS?=
 =?utf-8?B?S3B3NHhyQXZJTEtMZkIvSVo3Vm5vM1VyUmY2SXdPTEtrMlk4Q002dmgrRDlm?=
 =?utf-8?B?SkNPQ2U2c1dCV09PZGQ4MkNQUFBkRFMxNS9yQWtXMmZrMFBjNXJnM0FER01w?=
 =?utf-8?B?K0dVU3F3eWYxMlB3S2ZkTDBoZUtxR3htUTVNSkRZTHJHbHQ2YkNQYVRLOTBh?=
 =?utf-8?B?YWdSWW1ybGFydlVWSEd1Z2lQVnpOMjBROUh0bkdyTDE1bmhqS3ZEejhiVnZ2?=
 =?utf-8?B?V08zOVU1NDluaDliTTg3M0tNSmZvd3VSWkJ1cmNyWTV0OXJseDd4NlFuVk40?=
 =?utf-8?B?WnNOTmZxaDlPK2M5TXRQbnJUaU81dFBBY2RNaEFuZU13N2pJNkdERDFXNngy?=
 =?utf-8?B?RlNuWTd4Q3lkMzVHc2owckV6VFJ1SHJ0N3ZBbGI1bjROMlpDT2U3NEJjdnl3?=
 =?utf-8?B?RGNIVWpFS0doQVE0akY0MlVWZlE3eDRFWG11WVNnRkJBUlhDa1NTbXFiMk9t?=
 =?utf-8?B?Z0htb0VNaUh1bnZvL1V5MHk5QnBVR3RXdGt3ZG1TUTAwY2pZeVY1MUhycnY4?=
 =?utf-8?B?NDVRamJQTFMxeFVZdkoyT3RqYmM3akMrL2FTOGZmNXlsamk2NUhLRGF3OWVS?=
 =?utf-8?B?QlQ0ZTBtbUtFNnN2OWJpUng3WkRaeTJTQ1JnNmdRb042RlYwRUNsUnJseGlt?=
 =?utf-8?B?WCt3U3ZkL3psWlk1TXI0TlB5OVIyaW9JVk9icGxES2tUUURIUDVnZ1ptZ1lr?=
 =?utf-8?B?MHdjTjBmRUVHelpiRVBFcnhZazIzWS9RbGdicWRNaGk5M0VEQVN6WHZqWTBH?=
 =?utf-8?B?NzFIU01jMEhURUFWeXRBUHM2c1hRU2c3UkNkS3ZxVFE0T0xUTXZOS1hSZHgz?=
 =?utf-8?B?RjlWM3VxenhweGpZK0twbWI3ODFOZnRXT0owbXNtNXhTTERuNXNvWlRoZDh2?=
 =?utf-8?B?OW56WWFHSXZUNW1JWTJ2OHBvQU9MdDF5RVMxS2pycXJJVUFKSVRUYnltTi9Y?=
 =?utf-8?B?Wkd0bkM2Z3kzVHRWWU93dk85UjgzWEwxbXp2cUNEY05iQXZJeitjWXlwdFhF?=
 =?utf-8?B?WWNBL2o2YjNIdTFNMkF5a1BtNkNlenBaK1BOb2c0K255ak0rdHV1cVhZVUE4?=
 =?utf-8?B?TDM4aVRhci9ESmpsSllLOTRnQUdtYmp4Y05HTi9HeTRCaE41Z1I1SUhINURv?=
 =?utf-8?B?ekdaSmRLdVJnWXJXSHA3MDVybUs1Z2J2OUd0K2NOUnliYnY2SUpRcUVuMlZJ?=
 =?utf-8?Q?7eTVNrfeN32pGNu0=3D?=
X-Exchange-RoutingPolicyChecked: iPm71UEEEFsPiRGza1QeW4ORzfiNfuY1N/b+dcx686oYrGvd03hGWS11XkwfhbZ72OMowcGLwg62Q3sPoSxzzIsMTxKDCECKDtkCWMqLuEfi2hoN29U/WKx/zyC5ncouqjaN2cBNebbASIUc6dRcmPxdi2Tyh3X1eh0J4PqCMFKRToUkuC8LotjZkV9YGonheqK1soZ90geq286V7nouu1Fqy9jg0iimy170YcwVdqAi8JlfeOn4ANx/tlB8LQjnW2KnADtmDH4YY5QCsBr1fwyxdSPeuaqulIMjnKZGK8lqpIN4RgpjJnorrEu0sFbte09tvDYTYb5Tc6zQQWXxYw==
X-MS-Exchange-CrossTenant-Network-Message-Id: e06201e9-99e3-4ebd-140f-08df19d7faf3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 01:05:53.1072 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /VHUX+2B0s/n4yWSym+LXRHc2PTb+90So7EVCzRsI7ACR+qsCacj+25qapQh+dG4ndpJU6BcDAdVucMe3+HWnSTvDaWXC77OiUkY2vsasQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7444
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

On 9/22/2026 11:02 AM, Jacob Keller wrote:
> Jake Keller says:
> 
> This series contains several related fixes for the ice driver PTP logic
> relating to timestamp handling and device (re)initialization.

Sashiko once again still had a few nits, so i'll need to make a v3. To
help reduce list noise, I'll work with Tony to get a version that fully
passes our internal Sashiko runs without issues before posting a v3.

Thanks,
Jake

