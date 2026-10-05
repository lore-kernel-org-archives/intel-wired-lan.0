Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06C8BCA5FFD
	for <intel-wired-lan@archiver.kernel.org>; Mon,  5 Oct 2026 18:20:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B9BC460761;
	Mon,  5 Oct 2026 18:20:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7rQndM0igb9c; Mon,  5 Oct 2026 18:20:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org EC38A60740
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791224447;
	b=eGtO9PtGkW5eLj1zK8QLL67EZ4uOhjosMaUGPsnIVFECaBDzTWtTqRtAsM+DQAqP9DCw
	 Re9Eqi9m52voeUHJUAt75P2g2hFRBZXGlTdJGh9042+Af1bwsuSw0pWphf39BEFMgfBar
	 h0703rOvcCHJ2m0A/nfJ304+h9OVbI4qP7tlv7KedVyRVCE53XZMzbPSFH3pXHPBGD43U
	 3Qlq30HugnsS6d/O5Ylf28ZJVlzIPSSEOuSLwezQjl1mMMnj4ARsEX4TUoid9IBE/Crd5
	 tzhA//pXrv4sPkrf1Iv1v0G9hLhILAgez8FObjv4m7bbJVBn3gs4rI0aHgzb4T+J14A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791224447;
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
	bh=xWRPuUHp/RDNq0pqENTdP6D4Eoqbp5Mc9r9/rsYrABo=;
	b=sonXQ8Y+81ABcElS7D0lBCal75zzX46eEsE0uZ84NM0qtNIj8HPSnfF1ym8NnKu1/QRI
	 Fo5On7BVgKHjHbetmR/CDXJOFePxU8LKYC4YrCOlrvufliuWCUKsx8ZDJXw5OilYiKkWo
	 6IrzVvjKmjgN67ZpxqihFwadBpq7/OgwMESZZmLbnkdaUxW0nBzPqoUjUAJIAK3hTdBEv
	 1SFLIJERMQMNdPMJY9Z+uVKFX6H5OXnk3JKVYFi2a6mw1WH+eM118rBGa1d0/dJrS7ym3
	 dt2tLTcY6JxufcllfLfbuwg6Xm6ynjrKr0uXkb8qApbktbWgyzmsBCtcik1+IiSpnpQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791224447;
	bh=xWRPuUHp/RDNq0pqENTdP6D4Eoqbp5Mc9r9/rsYrABo=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BeLwqfO/U3Hkr5Yd8+0MyswngYQmloFqUF7xk57QDOxvmGEyL/qzi8hU8pyOeQS5i
	 8EJYj91iFn4eHHxqvHSRwPNb8U131dQD0Msl7tXj43xlrr2Eh+r7s14kthAgUnAWrq
	 uQhLD73TKLTYht+Twzy5jaP6OtYhxzDArZR00DtdrhBdYETO5hJEWJIsPU1d93gOOk
	 lynZn/VxPAOK6ZrVHcg4kxPNDFVbxJ4tQa++Y/q5XikeFdJgE3b7JrXXSRGmme2Erq
	 Kan0pLo7oiEkw6LpFS58zAJrDX4noqtr0crocm1bvtoOETIJNKXaEqP40Me9KSEv9E
	 aAl6fulsaTnFQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EC38A60740;
	Mon,  5 Oct 2026 18:20:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8713DA10
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 18:11:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6D7DB401EC
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 18:11:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WEEzTbNQ4UWD for <intel-wired-lan@lists.osuosl.org>;
 Mon,  5 Oct 2026 18:11:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 6D09740051
Authentication-Results: smtp2.osuosl.org;
 arc=fail smtp.remote-ip=192.198.163.19
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791223891;
 b=hIUpRBmLxQVS6IBwlzC3KEqspwyG0rrrhZ1EYvt5P8sY6Ep5UIiD3M8w3zNNcMj5spxR
 0UCuKH3AVUg9V9AMxxD4Se+R0s/awrW2ZF8DovLMxke///y6LFbowZlbr190Ds6ONkBUM
 +VOxnJP+qhDtNKUJI4SHX8vFWLEm59voYm708zyG9G0pBJxB8y5n6QRPGpiYnUlGIRXTn
 vgnuDtIwE7GFFsbwZ6C/Z2QjzR2Kcts8+pf8sIBYkZsFLATnXDGwL1BqRXO9DDgNb4jyN
 55rPS8LaxHU4sQiIqOj1ab+xv6sOQ4OjXEPgnRDACO0WqpmsCMIMu2K24Bv0e20LjVw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791223891;
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
 bh=xWRPuUHp/RDNq0pqENTdP6D4Eoqbp5Mc9r9/rsYrABo=;
 b=F7Jwem2ll8ea+EqOvl93a1oDXns/jGVoHQ2UXYwxSJYVX1Xqgv8sp/SDo7baLIyoukCM
 HuwYSBFk8wFbeVhFACtSAHPH5XnK0ECZLKAyb+fOJiwQZ2sqKS4x2abKSfZ+0scNtl2U1
 J/T4qd304/OJsxwaH2/mvaEKVTK5JquWCBs3xVxm39jKQqeA+rwCNooI5oAi4L0V0gor2
 p3cbHk/GZm2/UKXZR49EuQandq75ap835ODDY5CxZXww2TdyHJszLfKT+MJgQRGBJswiM
 +m5CHIqlJuENlh5sT2kX37xZFJH10oi4ueBzKgiO3ZLV77f7oVrf3VOccR2x7apyw3g==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=XwOc78Az; 
 arc=fail smtp.remote-ip=192.198.163.19
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.19;
 helo=mgamail.intel.com; envelope-from=dima.ruinskiy@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=XwOc78Az
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6D09740051
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 18:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791223892; x=1822759892;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=C09jS4HlmZOH+VMfuJ+NDM4xyh1+6QVYwUmtDUCTozQ=;
 b=XwOc78Az8P1b6Wd1mM0kFQJST3ZdLYpfTrmu1XJysnN9PR36a2qOZUWh
 VlgPfunaKmISgwpMgAsZprmEO0PtPf9Iy+lPECh7VurpuVz/eGkykN9Yz
 qhSs3Y77ZXE51ZRR1EcyBvoSyf03iKbPeCm+6KkDasRcfw5spm+HQnNYD
 0UbaBXKhHZXnuZn7Zu9XWMAoO6xW17wlBWtfQ+nEVqsa2kngwTZr1lcw2
 B3c7idKT6iF7gx8ISp5uvhUaoFmcdy6+3zmVu2L1S0LzSg3sYvMyi1Q86
 GG2dSZI+ywVfW+Yhhey4Prv0hAAiRb3lTT4Z2hnxSU/AVG8pmsH+wrmQS Q==;
X-CSE-ConnectionGUID: aND/XgvvSliZfy1eN9S2wQ==
X-CSE-MsgGUID: v7gYYzvZQ0OIGhtlqnm7mw==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="53331"
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="53331"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 11:11:31 -0700
X-CSE-ConnectionGUID: vdvauQfuTpedyWj/fl/lkQ==
X-CSE-MsgGUID: VOcCXL1/RdiHdOU1Ccrrfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; d="scan'208";a="274680113"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 11:11:30 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 11:11:29 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 11:11:29 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.51) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 11:11:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p9cQMuFUuawX5IzaZYE1xmjWnubxw3ykH78noZP1GjnXdtFwBN6Ega/FSsC5fzrTZUTR9KMIZplj1aB6YwOKp3o9x3u4oHQKb+FrcwfcuQ39hslPS0HXCJcov3yjwZE33bAZfcjkcHy8rwIbbbJY+ht95TYMLIziW8tkiWHT1hk4SS2c9THNqLjPYtgie+AOqk+JwvGjM6OAdSctrzi4S7F1UwZ/G0aV7xEF6e4UpJUrqfSd+avQ7rKWoRLhSmplRtbTSP4O6ANvyC3X3+woPrU5PBxsQcWpiuWimy6T4Iodyx7z9oBJKOk5FlXecrZR7iQYbtKsPYt9B4SFPRLAMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xWRPuUHp/RDNq0pqENTdP6D4Eoqbp5Mc9r9/rsYrABo=;
 b=toPTI1ppixrlVBYfpHRHgZNKq3x7aMuHH34jnDDZ7lv0cdOZ240Y+LRNiDcqrXD70CY2Zq6GMfyWC0K9UPoIXq3gWeQj936FlocOjyZolqdBQkFVCpFpQnu4oZ5CAUng1hWuY4Ho4XhtygI+EcZcs6aH3FwV8X9VobQ7KM0fW2zc4zNbTS1dMWH7FKbDVHWS/5xgHAPn5d7sie2XLfhzUSkG62o/SuqyUqSgLyuh1+EOmVH3KXpJ67/KArLprX4pFRnCbUG7qQE4QBsJrGAz7PK+3/RktOvspWpBiJHTsXr+W8CQFp/uKnCK0M2Uqr+9KGypKj3zVTN1NeKqSr559Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PR11MB872716.namprd11.prod.outlook.com (2603:10b6:8:509::16)
 by SJ5PPF20F246184.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::819) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 18:11:23 +0000
Received: from DS4PR11MB872716.namprd11.prod.outlook.com
 ([fe80::ae5f:9b62:3239:2e85]) by DS4PR11MB872716.namprd11.prod.outlook.com
 ([fe80::ae5f:9b62:3239:2e85%4]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 18:11:22 +0000
Message-ID: <86add723-6e77-433b-83db-d186d98140ce@intel.com>
Date: Mon, 5 Oct 2026 21:11:18 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v2 2/2] e1000e: fix ps_pages DMA map error sentinel
To: Matt Vollrath <tactii@gmail.com>, <intel-wired-lan@lists.osuosl.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <stable@vger.kernel.org>
References: <20260913171555.89537-1-tactii@gmail.com>
 <20260913171555.89537-3-tactii@gmail.com>
Content-Language: en-US
From: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>
In-Reply-To: <20260913171555.89537-3-tactii@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0013.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::7)
 To DS4PR11MB872716.namprd11.prod.outlook.com
 (2603:10b6:8:509::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR11MB872716:EE_|SJ5PPF20F246184:EE_
X-MS-Office365-Filtering-Correlation-Id: eba924aa-5c6e-49e8-ddc2-08df230c101c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|11063799006|56012099006|4143699003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: mQg5lUB58WyWe9x/fBZup5+dYb1T3t0gABul6EJiJtBtek96Q+LqEZAjg5VcNd20MOGW88eYpwdzWRsQ1haZ1ng5D0aybQArU8SABvCPN6ENL4bfw6AxsU0sqatXY2Dyj6JxcXFT1CmiV3EwOERS9MAaBGuSmdH48ud2TF7fZVf2LFWmZztAwxIK9SsIJ7yrcI82gzsD+B9d/23Tpj8saNhTMeqdRizklV73z4sLiJSW6636vGbkswg65KFzW7X+JZaZ6SvIXMc7R2gVmZUANcZfWjM9YvPjyypLjrLbJ1NqkbchMrmpO1hxsjehN32s6TQl0T2GiXcGrxlxXBfI7BQIpz3si4QANRizIVJWQw2F15L3w03u08X29BMHX8gjI2jYueM1NBGYosnXNe+pqqtj4vqZMW0mBvhNc5KRUva6UVuEoz/3x7DKZF33ZMidX3iVsLWRTMu5Ar1G7BtOnMgatOshqC+zHIrPwJKgbeNLq2V89LfPQttcajxXlTy91WrnYfVHSvs3SQGhKH29iuvG/mvY5HQZmLcB8VWIK/lzLeDYrQs86ue5KgkTwhvqPKe/J1ZaGeU6hnjxOXacFVrGS4WGQ+8uslLTp+imNsyJ3GkPTGcangay9vb+NtmjZTySFsD/3CgrQ6Gz8Gts6+mrcSyss78KfR9eSQ6CIm8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PR11MB872716.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(11063799006)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ck04ZmdZV3JDYXdySkRmMWlHTDI5dnRxTVczRTMzWUpFWDgvYkFDdG9tbnJU?=
 =?utf-8?B?ejljazNyK2dtN1YyQmtJd2ZqM2tmQmNUN3ZPMVpVa1grOW1oR3lZM0dJcDlJ?=
 =?utf-8?B?MHlkbzArMmYyaFA5NmFGR3lzWkxoVHlZa25qRDVSN0YxK3Bsa1lsZTFwVlR5?=
 =?utf-8?B?ajhrdUJqVHFGSVUrYkJPSm5keXZRenFpVzVqVjdiOExTQzRkNytyUldwdzdI?=
 =?utf-8?B?UTZxV3ZvOEFnRTh6QjJlZXNHazZ2WXIvWURsSCt4L2E2TW1ad3hTV3ZIYU9Y?=
 =?utf-8?B?cGtWL2x1aVg4WklxR0lTVSthdTJyMk9MaElJNWgzYnRKdUlKaWVCNlpPM1c2?=
 =?utf-8?B?Y2pUcERxSUdpUUJnUWZjZmhKV0MzUllBcUNVd2tqSDc2RXA0QS9vNVBrSnR5?=
 =?utf-8?B?WFFQYy8wc3Q1a3l2Smc5aG1lM0R4UXArWFgzVm13NkNCSFM2VzNGWlY5cUF0?=
 =?utf-8?B?LzZISWh3N0NwczlDaDlyODdwV3NmbnZudGUrM0ticHhFb1RLWHFRYmhGYXd6?=
 =?utf-8?B?b0xHWkNqalRvckJVNmRDTWVGYmFRYmhCa2pXanVtTVRRMng1bi9pQ0M4SkVv?=
 =?utf-8?B?RVgzQmRDNjFpVXJMTFAyY3k0a0Nadkx5MzFTZ0xVN25GeFV3SlpHdmIzUW14?=
 =?utf-8?B?MFBCeDZjcEJTZ1dNbzBoalZ0a0pmOCtIOHhZaHIvMHdjNXpKMUdvZk96RXdG?=
 =?utf-8?B?Q2t2bW5HVGRKVFFVY0kwdFg3VDFsTUp3blFPTHJ4bXppRkdBck56UG5GdE4z?=
 =?utf-8?B?NXZBTFU4RjZHeFNYSnJVbFQrTTJMc3JTQW9YL2NuaGZGTjhTT011bzM3QThH?=
 =?utf-8?B?WTR1YmV4YWY4azAwVmlyc2FWUmNhaVpQcGIvQzlYK2xodDFaMnM4WGo5ZDdw?=
 =?utf-8?B?R24xdmpEckJlZjZKRVVwa1JLVHlNWmp0N2VrS3JOR1RyVTdaSWJIQlRqRm1I?=
 =?utf-8?B?aW9qQ3RTcC90LzlnTkt1dzBxRUkyLy9FRkNhK2xFN0ZIVC9IYkJUVlVrM0Uy?=
 =?utf-8?B?L1JxUmhYR2RFNUpFeFZpenFpb1FGSzFCKzI5U3JtQTdmOE1ySWJnaFB2Lzcz?=
 =?utf-8?B?ZnJzcjh0Smt2M09WcDlYQVZ5UVQ3RElDWlpxT2J1Ukk3V0xlaGJ2L3dybHNq?=
 =?utf-8?B?eGV1WnQ3WVlrT3hqVmdHelJNMzkySXYvRm9lMnJJeS9nVEJPV0lOVEY1MXpn?=
 =?utf-8?B?dCszRURxZGxrTnFZanh0T3RSU0dSUzdaem1rUExNWjhsbXFrczgxclJ0aGFH?=
 =?utf-8?B?Z0dEcWlXK05NVGZMcm1wU0tQbDA5UmRVUThHUG1ZUmJtS1IxeDN1VU43eGxH?=
 =?utf-8?B?bXZ6QWRLZkJVQXhoS3hJcmdrRjVrV0hnZ1owMlhaa2tqSWpUejgxNlp1RDlh?=
 =?utf-8?B?bjQ4M0NmMGZ4SVA3bDJMV1p6ZjgwSCszRjlHeExHZythWVlLVmxYVHRyU0sv?=
 =?utf-8?B?R3BTRS90YmdRNzJmbm05YVROeFZLRERDZ1pxMVRQZHQ0UHlCMVlyNlF2bUh6?=
 =?utf-8?B?ZXJzcXFkSGRSV0VyeFk3Ni9BdHhTZGx0SWFONDdONXA1Skw0UkNSL0tCa0lU?=
 =?utf-8?B?d1hwMFY0Y21QUVpFalhXSTNFMTN5MDZQdlIxa0R1VG9ZRkpSN2ZjU0dybmpm?=
 =?utf-8?B?SDNKdzNtMy9ZSGYycFZmOUVlcXl2ZUlQZ2pPMUZBYTlUR0l0allJSXhlZjVy?=
 =?utf-8?B?TUJ2VHVrekVGTld6VFoyV0RVbmMyT2NydW9zeUhGMGRJLzRaSVhVT3NmbXNU?=
 =?utf-8?B?a3pQUGFLNisvQWVITlZDaDQ4ZGJXL2dnS3B3SmpEbzdvcHcwWjY1d2NLR0s0?=
 =?utf-8?B?MjVORjExU2c0b2FseVA5NmJLQ0EyZ0I0UitwMVRHWWRlc2RqTHRrdjZuMlNT?=
 =?utf-8?B?UTRzVlYzenJBMG1pT1UvSTFjbCsvTEVuc0p1c1hsb2RZUFIxZ2I3enJKenZ3?=
 =?utf-8?B?QUlybFhBY0xaY29iQkw4L2VsOHpEZi9BakRqeC9PbHdhR0JkODZSVDdLTytU?=
 =?utf-8?B?RTFNT1pscGJuakROdDNkM09KejNFL0duYmlESXc3dDY2TTI3THdxSWpYV1pz?=
 =?utf-8?B?SzNGRzFMZUNXMFhZM085MXVEdmx1TlZUOTZ5bHVIOXZ4UE9iWDk1S2JrejRL?=
 =?utf-8?B?ODdSVXlYWElSeTNXcWc0RjZ0SjN1L2lqWm5HZ2dXdVhnNEszd3NmcFZnUHRH?=
 =?utf-8?B?YUhWbmYwVUpZVE5FYU9rSlBOemw4YXlpQjhrVW9BaXd4ODVWVkpVbVFoOGRp?=
 =?utf-8?B?azBKUC9SSExHQ092RWdTMWNSSVhJMjhlMktQVE1EcHB4V20wVUFwYVRmaWxz?=
 =?utf-8?B?STdabmVEYzNNRlVBUmVpSXNXK1JwdHpPTTM3dXl3WktuelJnUzJSQT09?=
X-Exchange-RoutingPolicyChecked: Fd3XQZTcyMBmNjnQfy6u3620OgxzyetRYVdul5+m/eN1OlSWPcf5jfp3SzOgqDbTVMN542McehqPglpc0jGyqPGRt4abnufNChtR0bqTUvaJcTF2wbz3ESGZ0zW82JwgLGSqb1I7aZd1zCe93YzFT4CMxWki/EOpETV4eMirvWkb96tJoSEarvudYhQksX4JNsA19fNERwdE0b3fFv+t8E36mccjibrm9b4D+d7HkgrtTDCB3QEl7ZuPG63F7TYEJhsB2qPyd+VnKlP4el9+rm5YRvJ7W8tMZQWL3ASqJKCt+WBA+BjRAVkY5+4I2vHy7ABBWrtgvVixmc8ihG9k4A==
X-MS-Exchange-CrossTenant-Network-Message-Id: eba924aa-5c6e-49e8-ddc2-08df230c101c
X-MS-Exchange-CrossTenant-AuthSource: DS4PR11MB872716.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 18:11:22.8835 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W29bDRK+wmdA1isiDtsfYBAJAoAlXYi8owFu8Xvu3JfJOeOdUxjzEueYfQ6QTbcc6Rv2mreEZPRXsHOnIi+njw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF20F246184
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

On 13/09/2026 20:15, Matt Vollrath wrote:
> While allocating packet-split buffer pages, a failed DMA mapping would
> leave DMA_MAPPING_ERROR in the ps_page->dma field.
> 
> This would have two consequences:
> * The next attempt to allocate that buffer would write DMA_MAPPING_ERROR
>    to h/w if all pages are allocated. If the h/w uses that buffer and is
>    handling a frame large enough to touch the affected page, it would
>    cause a DMA fault and be dropped. The driver would then call
>    dma_unmap_page() on DMA_MAPPING_ERROR and unknowingly send the
>    uninitialized page up the stack as part of the frame payload.
> * On ring teardown, dma_unmap_page() would be called on
>    DMA_MAPPING_ERROR.
> 
> This condition is only reachable when MTU > 1500 and PAGE_SIZE <= 16K.
> 
> Fix this by setting ps_page->dma = 0 upon mapping failure and separately
> testing ->page and ->dma during allocation and teardown.
> 
> The rewrite of the ps_pages section of e1000_clean_rx_ring was necessary
> to recognize the case of an allocated page without a valid DMA mapping.
> It also fixes a separate bug which would potentially leak pages on ring
> teardown. The cleaner stops cleaning pages when h/w reported that it did
> not write to a page in the sequence, leaving the following pages
> allocated and mapped. The teardown would then break early and leak the
> unused mapped pages. If the ring is re-constructed by down/up with
> similar configuration, it would reclaim those lost pages. This would
> only affect configurations with rx_ps_pages >= 2 (MTU > PAGE_SIZE) and
> the same condition of MTU > 1500 and PAGE_SIZE <= 16K.
> 
> Signed-off-by: Matt Vollrath <tactii@gmail.com>
> Assisted-by: Claude:claude-5-fable
> Fixes: bc7f75fa9788 ("[E1000E]: New pci-express e1000 driver (currently for ICH9 devices only)")
> Cc: stable@vger.kernel.org
> ---
> v2:
> * Reword last paragraph of description.
> ---
>   drivers/net/ethernet/intel/e1000e/netdev.c | 19 ++++++++++++-------
>   1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 26f45ee8c7e7..063fc8cd2673 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -759,12 +759,15 @@ static void e1000_alloc_rx_buffers_ps(struct e1000_ring *rx_ring,
>   					adapter->alloc_rx_buff_failed++;
>   					goto no_buffers;
>   				}
> +			}
> +			if (!ps_page->dma) {
>   				ps_page->dma = dma_map_page(&pdev->dev,
>   							    ps_page->page,
>   							    0, PAGE_SIZE,
>   							    DMA_FROM_DEVICE);
>   				if (dma_mapping_error(&pdev->dev,
>   						      ps_page->dma)) {
> +					ps_page->dma = 0;
>   					dev_err(&adapter->pdev->dev,
>   						"Rx DMA page map failed\n");
>   					adapter->rx_dma_failed++;
> @@ -1722,13 +1725,15 @@ static void e1000_clean_rx_ring(struct e1000_ring *rx_ring)
>   
>   		for (j = 0; j < PS_PAGE_BUFFERS; j++) {
>   			ps_page = &buffer_info->ps_pages[j];
> -			if (!ps_page->page)
> -				break;
> -			dma_unmap_page(&pdev->dev, ps_page->dma, PAGE_SIZE,
> -				       DMA_FROM_DEVICE);
> -			ps_page->dma = 0;
> -			put_page(ps_page->page);
> -			ps_page->page = NULL;
> +			if (ps_page->dma) {
> +				dma_unmap_page(&pdev->dev, ps_page->dma,
> +					       PAGE_SIZE, DMA_FROM_DEVICE);
> +				ps_page->dma = 0;
> +			}
> +			if (ps_page->page) {
> +				put_page(ps_page->page);
> +				ps_page->page = NULL;
> +			}
>   		}
>   	}
>   
Reviewed-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
