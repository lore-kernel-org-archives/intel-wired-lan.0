Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 340F2C3DA7A
	for <intel-wired-lan@archiver.kernel.org>; Wed, 14 Oct 2026 20:09:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DC22A40786;
	Wed, 14 Oct 2026 20:09:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4LTmV2L8-RT6; Wed, 14 Oct 2026 20:09:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2816E40787
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792008570;
	b=nRVRpT+CQsmfnKTXPN5QKRaqmJsqLdjq/2kQJ4O+bJmrz68bHkuAzMAgETZueZ6KTlcM
	 uQEdj8dQOLhZRFAgIEg8BO03gBq2PMcXMqaFY0ELmmDKAMJZ6rPMCyggElRYc6ZR1k5am
	 BXL9sRPm0P+LBQutrvdd2TdCGu26uwjm7VSjUA7Ijd3HvHAF7Cn3lSmKcC2cyUZytjYYt
	 NH+jJXcSUnmlIGMO2kfTwEXdwDHeAVgKK5ZAa/k3dfZ4OMoJ/a4dnzV20W13sWU4w7yM/
	 lXyi8ZJ/b6hgviJiFmE8zDkMjldHQxwMuBdrf3ls1yNQV/B1Nu0xTmO0YJs30yKnvfw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792008570;
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
	bh=t8CB6qwHOMt6J2F40OAQ5YEd/E47fc43GUL2k4cmbDM=;
	b=ptgMKm+5c8YNhDQGhw+EehtZqkgQ/Qxl72/qhfOIGeuOwvhgAGU0Y7f3D3I5lV0f3yeE
	 kHSD7Tp08OtmrSMK+w6wXYZdZbOvTQ6wJN7lKLVEVKe+euaRTRVbQBjSgkmZKIKK/2m3U
	 Pvi/hUzzjwMMyWcUqAnMkTjxD8t0Xm9soCw54j42+8U/FsatjTbDs6PP+x5OC/nfDpiAE
	 +dw7JtclelAz6hHy3dwbpipgrl2loCYfLPSYItIlVQHIEw2O0O0x0TkxyN8tcaeuz6kA8
	 AI9fqeCGDVYZLKXrB1LTA5FcPPOm8zijKD3ls2Ol6ZWZcPHwv1/yLMoXC2X3REoDbZA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792008570;
	bh=t8CB6qwHOMt6J2F40OAQ5YEd/E47fc43GUL2k4cmbDM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lzOCB4G2uW3rhgmyxGmshCcWPEliTvIlxWxFpUS6CzP1khvCZYSNKVMW6zY8wmPjg
	 gm9o6H4zojeC+9I0teMCCAHBvpt71rtRM2yyVmk9f86I6/F79LWVU7mGN+olC5ul0O
	 BMClxNwAqt7iGwaFnNcr2Ty+0LfE0flcjPDA37qD5IJulXDGQtws9E4uEB24f2Rvhl
	 yAVfWwEW5k7e1qHFCaS6lx7xSA8G0PUS2ZG+ZkNRrxZb+Dijf7GD8Zz27v6y5hXv/e
	 +0CXI3XPjl9qsBfZz9OgxOTk8iLbVrIIk0r8It5FOjjRTe6it05BqUqB4xtd12Vy7X
	 cpnhjQhTD5cZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2816E40787;
	Wed, 14 Oct 2026 20:09:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 73503769
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 20:09:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 59316808C4
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 20:09:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ClhOYx4nxA-9 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 14 Oct 2026 20:09:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 854DF808C0
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=198.175.65.14
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792008568;
 b=iyx3lYpfZ+ne085XafJZRK5RGgkzQjxfiVRv2ZGR9PIoT7lclAb2UPLyoK9MxXT7KMGi
 6px4dVt4utX19tSIgOIccLpjivSKNu6KsIOeKR7YVR/9yj/Utf9Y30LZV5KwGVRolzXdQ
 4XgG7ynjrEfuyJL+8KM+wRWrwDjT3DAI5GJbqLp/Sx0kMjkLWTN9G4kasRMt2riaQeV/b
 tMqak6Kel8uLmZkokSj0paMXZhXBKHgq7429fTsuFYXyvc+hMx3BxwYUduvynhw3jEaWc
 kWReM+GABvZgzvT/42Qm1Kw1SvFsH5xMsV1ZzGUDRDqhu0dr+lZEi0B0r0zVHiwTlMg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792008568;
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
 bh=t8CB6qwHOMt6J2F40OAQ5YEd/E47fc43GUL2k4cmbDM=;
 b=TLYklKtldIPLo2Vs44bEeHfR4mpJxzupTBEjDCueysvUVIZuh9U7lxG717n89zHmzsXI
 OpZyZ+d6gaoIKa2rPoDawGhmHzAtk0WZc0xMrqG6WgHAAfzrLz2Dk29b9tsScS+x0IgfA
 6rAXm59CCnKhN2AGvrX/vkZ8zceVw/u323Zf4MiA63Y3qfdziWwFYQi4BbDAusgdc6ybn
 m7uvFQlPp47Vhl8VMB8gbU0iCztWbamWg7emDQ/eJZWu/RRPr7mIqHarYiA4X/vtd0+Su
 +UX0WC6Vpe/AA563auH/Bv543aeQjYyf+BwS2dooen6jJGXvyzGapSIovonwifknNAA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=dzrPq4N2; 
 arc=fail smtp.remote-ip=198.175.65.14
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=anthony.l.nguyen@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=dzrPq4N2
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 854DF808C0
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 20:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792008569; x=1823544569;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=yJt3xdbSYT9MzIZlFMfU7dmK9pRjsnn1jwWtw8agkxU=;
 b=dzrPq4N2VFBuqlRO4oHtyQ30yRh7YpCefdMXiwLB4dXvqdSyWU+FljB+
 NkV5sD7eWUj5Xdrakx5DSEJlR8Zk3p4hx/iNsrMatOh9UU7Z14q/MNMds
 hD114q+XSkAhhjwC66vF6Gv86BT2U1icPUVBiEE24FUMBQNyzKfE7iwmQ
 NV5vEg+P0+ZvW08MeDtTQjFlpGZ+kMMO5i1jbtsF4s6snj7jdzZflPtyG
 BRKzrlPDsulkj3AnyBwPbh05MzrHOC/NmvRp5URAMIh7Yu8cXGXDzyltl
 wUsGcz14pIxs/K3IPkrnpj3QDPbFRS44UNb2DQxtCR89i/HmiQpHbq8b9 Q==;
X-CSE-ConnectionGUID: ldP+PWz/RaaQRo8yIrwTqg==
X-CSE-MsgGUID: WJ5BunICRUmCsWgvoJPZbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="645511"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="645511"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 13:09:27 -0700
X-CSE-ConnectionGUID: sEVnrUzrSM2PtISeGAjypA==
X-CSE-MsgGUID: 3VltGRThTbmYlqNPcYZY9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1849494"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 13:09:27 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 13:09:26 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 14 Oct 2026 13:09:26 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.23) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 13:09:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BMiJ+iJIlDss66bMjSb6c0AFE+MWI58niVZXjjRJAzvcvU8oUP9q7LG62FHD3A0xZ6N0MOVWSun1rL30AGjlHMTDBjWIk4cBpQ9tHA3omJPfCrojWfxv2Q4cr12mhwzZmP0cXVZhgrDWZ4qYxt1zAySNneUS6jLQP1luYyu8KMTzEvgP1qi6tS8AldgcTrCGK9Ytj9L+PF30pEvBLPrVjfzmHAa0sFmjZ7BhSvtDWXGHdJJlFPWFLOsf5aJENkz0bnaF+P5pSZdTXR71kyjR90uuZnzFed8RimtSUaBD9agEY0CK+rfQ7rQzW/3ys0Azj7ZmeR3UVh5h7DdlB/FVjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t8CB6qwHOMt6J2F40OAQ5YEd/E47fc43GUL2k4cmbDM=;
 b=fStUtahQ3TYzy1F7uQVIzMrIoHO0oxpewI8yQP7oTH2TA1GHyLLFXRPyAQGP57jDXrk0uR5MDMgIzLO80hV8rvCu2RKhX1A1M/xo16QvQg9HQILP77e1gO4hyBxRENatJkEIYMKZ26I0/t6kVsILEKJytu0w4ufvVOZNMWtdkiEpBUW0RmlqgkzlbEFpSwP5UqfDwcHtJBH78KVTNqMnn0Fkgn9LHGjO+IfAYux/Z92Wutkao6Oyrbvqwqs0b4Ab/269unWuewuGUK+r5RHubkUWTO2sK0UiYllmgsQcrTkJtEUP+u4xKM1Twv7Lrze0H9P1R1cQ+uVGFmH2gNRvlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8230.namprd11.prod.outlook.com (2603:10b6:8:158::21)
 by IA4PR11MB9130.namprd11.prod.outlook.com (2603:10b6:208:56c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 20:09:24 +0000
Received: from DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40]) by DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40%6]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 20:09:24 +0000
Message-ID: <2faf0d91-0821-4597-9a73-2ae61f9bb1d3@intel.com>
Date: Wed, 14 Oct 2026 13:09:22 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ice: correct PTP register access debug messages
To: Alok Tiwari <alok.a.tiwarilinux@gmail.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
References: <20261011113545.16718-1-alok.a.tiwari@oracle.com>
 <IA3PR11MB8986155B5F35281999A764C7E59F2@IA3PR11MB8986.namprd11.prod.outlook.com>
 <e614943a-0521-4528-a635-ce0cba7fa8b5@gmail.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <e614943a-0521-4528-a635-ce0cba7fa8b5@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW3PR05CA0021.namprd05.prod.outlook.com
 (2603:10b6:303:2b::26) To DS0PR11MB8230.namprd11.prod.outlook.com
 (2603:10b6:8:158::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8230:EE_|IA4PR11MB9130:EE_
X-MS-Office365-Filtering-Correlation-Id: f1e18c37-5018-4e0c-a513-08df2a2f0aa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|10067099003|18002099003|22082099003|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: JfJwUA8E39R7Ot3EnszhK0H8DtcJw1zEz2BvKDsv2YohnR3lZFwQiZbaECBUnrIXWwmS2w9TO+jYc7T2b1MnVxaUv0MfIeivbWRxwSx8/D3ne0ozHyjVsMn3spV2pnNthxO/hXUG/s05ajwRhwIENQuugFP41y3FvElOWXpOc0xBtsFtAynGVdT1VskyjFvKEMzIebw/3XSI7ED3uvzcjJrIXat5uGypzEb7n04bPevFvk5OUfUQpgxTiaLsPj7OB6bRWbvdBBxop2wdqvpQGzDYEoSgmOjf9XQbuT7RLZMsPtaZtaC3OAVPG9Z0t2QNaoTniJh0O9kSF4iHhmRn5PIMIS9IfdNVlZQYdVljgowErPLWfM1csfGGKc0Wz52S0UUAp/L1es2BGRliMLUnagIShIMpbHQy/PrAz2X6Q3j/qP9/kCpvKgKRYwARMoIzKuSGKMh87yb4P4UgfrjyPGuBLZaOcnRD7bIZIgAqcgb+lCwmPGxSeOnBaU9fAc1iwfCJCbU2Lw9IUeZ2sJ0vm/bgfg1TWioEhvdpvJGZcdE03ofCxh4XPJWXNIgXkbczDmJIfYhiyp81zu9C5Eq9c72Uc2/BwVHJGqcY00cI6LRaV1x1UK78Y8C+xInrXq7OHcbUxGVZedCHHVLfhkHwGFoXzpFo12zfM4RxyKD5phY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8230.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(18002099003)(22082099003)(11063799006)(4143699003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHM3T0FUeGc0eElpT0tTMTkvRUNTcDlXMFVoZUR5QWNzalR3NTBuSlhXbzR0?=
 =?utf-8?B?elh4MmNsUmpRU3FVMlhmc1JnamNaQnZicHRiaEs2TVdYS3MrbHZveDNzTUN1?=
 =?utf-8?B?dXd5U2I3SXlTcXp1eFlCTVNVTWRMa3Y2YTJkZEdmYW1QSE9FcllJVzdKZHRB?=
 =?utf-8?B?c0VpVWNOZ1drcC9lUnkvN2tGdmFsUk5QK1ZQT1RIelFsYnQ3b2U1R0dwT0tv?=
 =?utf-8?B?YTQzc2FEUEZVbFhmQi9UQS92eVFxQnUzclgxUGUvNnk1TFJTR3EwcGQvZHpJ?=
 =?utf-8?B?V0tiVUZrT3g4MEVMaTc5Y0RhWUtZZlBQN1RQbTdXMFcwYVVUbjk1aDVXMTAx?=
 =?utf-8?B?MElaV1Z6aDNCV0ROSmN3MUk3M05TeEVkMGtYTDltQ2RIL0wyVmlBdk9KU0p4?=
 =?utf-8?B?ZzlqREx2TEV4azMxa2pKUEJwZSt6eHJFQ3BGd1hEclYvZ2dYaSs1SGJmU0Rk?=
 =?utf-8?B?TEZmdWVqcXVLWXVLMmVYQ1RIdXpJbk1wWDVTbmNpbkpmV1BkR01aVTFaaFFz?=
 =?utf-8?B?K1ArUS9NbUhRSEdrWkNXMlFtRWFOSTRpUXNkL1JWaWVxZW9hWnJlcTNxV1U2?=
 =?utf-8?B?QXBVWmZBREh1a3JtL21sL1NCRmRjbUZGL3EwSkJ6cXhGekhHbVd0Q2Z1TG1k?=
 =?utf-8?B?QUhRaS9xVFgyMGt6QVp4NHlTdVFpQnFpR09WUGlTY05tR1VJOGY1aG1sVy9H?=
 =?utf-8?B?OUYrVXhhTzYrekN6THRWeklDZ3hhRndNWmxDVFZaNUJWREVYVTBoUGJsdno3?=
 =?utf-8?B?K3BYRzhzVTlCWnY5WkM1Y3A5VklnK250cm5vcHN3bWRRaUl0VGdMWDFXUUZB?=
 =?utf-8?B?OW9XTUhaTDFvZUU0MXdhVEJKUVBOait6d0I4SVpxeFVKRzY2Q3A4OWZ2NEJX?=
 =?utf-8?B?LzNRbWpsRmVVV2lLaEY3SjAxZzNnSW11N3M1RDdVYzFKNm1CSS8yS2J1dlR0?=
 =?utf-8?B?c05pRHVaNnV0Y21iUi9RdENXVEgwTk9iWDgxZDNYWVJSdW9WY3V5UUFPV2xl?=
 =?utf-8?B?bkZ5cFUrRHc4WDVvU25ubWowRjJVNHVRWW9qbU9CUzU0dys1d1hNaHBUMHNl?=
 =?utf-8?B?R3Y5K3FYR2JpMXhFRXRwbWFoZHp3Zm15YmVuTVFaaXFub3c4Z2M3dHhWUHVw?=
 =?utf-8?B?emdQdXZ2ckRGS0I2TDljOWFvSHlRWFVRZ2gxMzl5cEZ5RUVUVldxU0E1QUR2?=
 =?utf-8?B?aHlZVUJGWFVKaDU3NlpMSUNDcVVMVUxWVWVyQStxTU1acEhOZjJEU2k0eXR4?=
 =?utf-8?B?ejZ3RkJscWExcEduRlZJSE9teUFLa0dCb2RKOGZYQ1JqNzlTOUFpakwwbko3?=
 =?utf-8?B?eWFKeHd0MkNGR29iR2RXUVJ4cklHT0NNVENQcGlBb1VqZC9hajIrMllNZyt3?=
 =?utf-8?B?clpwSWkrd2VXRXY4b1BaWGhBUDFJYVAxS1VNazB1cW01TUdwK3hrayt6K3Bt?=
 =?utf-8?B?S2h1d1I0d3lHYTNkZllmSU8wbGNzbUNzV3NGM1RjYzJWZFpsdGxlT3BXU1hw?=
 =?utf-8?B?MjU1RER2WTRuUFI1aGFuYXYvR3hDaDNFZFkrWW1FdzVDRUdtZFp4Y1c4QjA2?=
 =?utf-8?B?WERvLzJJNno2NE5OeUtCOUZmRk42RTU4MXVtY1NiTmZ1OFhZekNHdXg0MEYw?=
 =?utf-8?B?WC9GUlo3b25qaHkxd3lNUjErWGVveGlFOTkzbEkvdUVibzI5aU83cjRhSkwy?=
 =?utf-8?B?YXNVZjl2anpJUS9WazFtT3FrajIwZ3ZyR2tRd0hjakpPQmlMUk9aSnFxT1lX?=
 =?utf-8?B?eTh4d0wyald4SXJjNW41V20xWU9xS0pMNGx3VDl4N09uUnpYUERrZWVQYm1i?=
 =?utf-8?B?NHVVcTZBUGVrYmZkL3gzMm5tb3pXQStRVDJTZVNVT3NrSzJLU0xndUhBMjdW?=
 =?utf-8?B?eTRHRWpIMlNKbjNQNDBlWWgyWkpMZEc1bVFVQjFsMDZHbXRuK2V4MTlXbm52?=
 =?utf-8?B?MXBESzF5bFpPTHhGU0l5TWdIMC9YcjRQN3lvK3pvUkdUL0owajJEbWNaanVJ?=
 =?utf-8?B?QzVWWS84MW5IRWFPRmp5VThuRjNBZlhaakl0WDU0Y1VKRDFVODd2ek1FMGtN?=
 =?utf-8?B?VWlxOXNwc1JsSnN3L2ZjSkp6RXBmS2d1c1RsZnFHVnFvQThMQkM1d1NDQkkr?=
 =?utf-8?B?ZnpnMFpRNTk5bmNrN2REUWVlMFpTQTZLTityblVsUzlmMVgwbURGdllJaGJB?=
 =?utf-8?B?Y0UyYUlkc1dQd2pFMERkcmJadmQ2NHNpblZiUXRMRnNBQnNvb1Z6ZGE0K280?=
 =?utf-8?B?c2dTd0w1ZnltUnNmcFJHRS9hekZHVUJweWpNM0FrSjZxcWxQUnRGTVFkdVl3?=
 =?utf-8?B?Q204eFpOcGhLVmR2VnJRa3ZJcHFldElpTjVvQjMvZjFuQXM5RzJpRE9hS3pX?=
 =?utf-8?Q?pm5XuYklrbtVg1UQ=3D?=
X-Exchange-RoutingPolicyChecked: Jw9TVY7p9g9BhU1QEpaLHNcgPPq/EnIVKDW7OTp810OY/2CPzx5B/W42i13yoHLNdGAQdj7hQoMXlHikNwk8TszkNaqa0n4YJSz7DBP5zUm2giawX041t+nmsczjUhIAAqMr83Y4Tl15fk+A34DMmZhQ8Pvf3uB0Hk9WdGqv7T8jvW0gu7t67fyySwvPnvWajFM2XNsqWlIEXMkFIcO5jygkVPMWHc8MVdyNIJV2sJBpK6Ho81UkC4pvnlnyO4y6KyDANLi5n0TW0HcDlkvbuoZzqfWImxNB5AYao+Ghwoh/17pUmOcT0wU75z4+oOCQab+iOjLlE4sfcO1A9SotMQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: f1e18c37-5018-4e0c-a513-08df2a2f0aa8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 20:09:24.3311 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kB1rDr/zB+1TId7ad2J5+tVlxeyLKAGDq8S/fHAJJaC8tyCo5uXLmtf5Y6kV+3tcxnkQZdNOxvh0qqk5WrcfOmq9RxwlQRKvKcBvdHz/CTk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9130
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



On 10/14/2026 9:05 AM, Alok Tiwari wrote:
> On 10/12/26 14:34, Loktionov, Aleksandr wrote:
>>
>>
>>> -----Original Message-----
>>> From: Alok Tiwari <alok.a.tiwari@oracle.com>
>>> Sent: Sunday, October 11, 2026 1:36 PM
>>> To: richardcochran@gmail.com; Nguyen, Anthony L
>>> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
>>> <przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch;
>>> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
>>> pabeni@redhat.com; netdev@vger.kernel.org; intel-wired-
>>> lan@lists.osuosl.org
>>> Cc: alok.a.tiwarilinux@gmail.com; alok.a.tiwari@oracle.com
>>> Subject: [PATCH net-next] ice: correct PTP register access debug
>>> messages
>>>
>>> Report a write failure rather than a read failure when updating
>>> PHY_VENDOR_TXLANE_THRESH.
>>>
>>> Fix newline placement in PHY register read and threshold write failure
>>> messages. No functional changes.
>>>
>>> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
>>> ---
>>>   drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 6 +++---
>>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
>>> b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
>>> index 3a41c711e751..289e0b3ef6ae 100644
>>> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
>>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
>>> @@ -1529,7 +1529,7 @@ static int ice_phy_cfg_parpcs_eth56g(struct ice_hw
>>> *hw, u8 port)
>>>       err = ice_write_xpcs_reg_eth56g(hw, port,
>>> PHY_VENDOR_TXLANE_THRESH,
>>>                       ICE_ETH56G_NOMINAL_THRESH4);
>>>       if (err) {
>>> -        ice_debug(hw, ICE_DBG_PTP, "Failed to read
>>> VENDOR_TXLANE_THRESH, status: %d",
>>> +        ice_debug(hw, ICE_DBG_PTP, "Failed to write
>>> VENDOR_TXLANE_THRESH, status: %d",
>>>                 err);
>>>           return err;
>>>       }
>>> @@ -2589,14 +2589,14 @@ ice_read_64b_phy_reg_e82x(struct ice_hw *hw, u8
>>> port, u16 low_addr, u64 *val)
>>>
>>>       err = ice_read_phy_reg_e82x(hw, port, low_addr, &low);
>>>       if (err) {
>>> -        ice_debug(hw, ICE_DBG_PTP, "Failed to read from low
>>> register 0x%08x\n, err %d",
>>> +        ice_debug(hw, ICE_DBG_PTP, "Failed to read from low
>>> register 0x%08x, err %d\n",
>>>                 low_addr, err);
>>>           return err;
>>>       }
>>>
>>>       err = ice_read_phy_reg_e82x(hw, port, high_addr, &high);
>>>       if (err) {
>>> -        ice_debug(hw, ICE_DBG_PTP, "Failed to read from high
>>> register 0x%08x\n, err %d",
>>> +        ice_debug(hw, ICE_DBG_PTP, "Failed to read from high
>>> register 0x%08x, err %d\n",
>>>                 high_addr, err);
>>>           return err;
>>>       }
>>> -- 
>>> 2.52.0
>>
>> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> 
>  > [Severity: Low]
>  > In ice_phy_cfg_parpcs_eth56g(), is this missing a newline at the end 
> of the
>  > format string? The commit message indicates that it fixes newline 
> placement
>  > for the threshold write failure message, but the modified format string
>  > still lacks a trailing newline when ice_write_xpcs_reg_eth56g() fails 
> while
>  > updating PHY_VENDOR_TXLANE_THRESH. Should a \n be appended to the string
>  > here?
> 
> Hi Alok,
> 
> I know this is pre-existing, and low severity, but since this touches
> that line and the commit is fixing newline placement, would you mind
> adding in the missing newline?
> 
> Thanks,
> Tony
> 
>  >>           return err;
>  >>       }
>  >
> 
> Could you please consider this patch in its current shape?
> I am unable to submit a new version with the current ID at the moment."
> 

It's a "low" so I'm not going to push too hard for it. If you're ok with 
it, I can add it in when sending on to netdev. If not, I can go with 
this version.

Thanks,
Tony

> Thanks,
> Alok

