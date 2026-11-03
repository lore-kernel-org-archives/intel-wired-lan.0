Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F4F606A327
	for <intel-wired-lan@archiver.kernel.org>; Tue,  3 Nov 2026 12:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=M20ZtAZb;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OcaObfbJ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6954D40506;
	Tue,  3 Nov 2026 12:36:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QcemEj1IXWyf; Tue,  3 Nov 2026 12:36:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7F9AC40508
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793709402;
	b=sVF+D6nRo/u0uB5PTWTl6PHR5cO6r93y+oXuWh/JuloIvnjuNR4WTAwsI2H/QNYgsdUc
	 CSa0PYpP6s5HaegX6atHdXH1Rq9S37Ibz6VE4Ugm2hGdchVfXWMAOeTIzEt+EoCIP8RsZ
	 sL1n8yk80zi+TNwIQh6NTeK67FA682bJOH3Od9iwGQYn5wYZTrquBGYm61ULyavuEWysM
	 bqZxkmkpilr6SBmLrCljPB5rsjt+MU1TZJrkA3kW8YZhEtAGkXnXPz2msQwkkTbmfBEJg
	 PcQCbaN1g8qDrh6bD+SjgMeN05dLDeWMurlU0Q7OB7pYyK1ivM1UN7zofeZDKVot0OA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793709402;
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
	bh=xMKtNoJXoBpcWDkQbpJgH7N+X5jzQ8IFV2Vm72XdwVQ=;
	b=rkpTrNwNfFCFxgxMP0q3jMIBSPH+saE4KXnyI5LoXdIRSD1aA9sSFUFMXOCADswKwjg+
	 R+tWRptlICHI62k9+7fa+fmNcUOGGqqZW1IWM+p5s3CiFd0/YICU++MXfTrT6XOhliOoO
	 lpYQ+5Tpr/p1SJTbttGfE6/mpXC5GCyoB6if+mYk1bByY/EW+F+eG9QHUYox1fec9nH4Z
	 Dor8qWB3HvXBfxSYFCoqzJzXH6tcgElWE8Jjt5GO5ALGb5TYH/pYsuHki6nSRGagnwpl/
	 eD+0zX4mOKSAov9TTUV4/zcXLiDItUvb+jxbYvI5gPK4uCs6ivGwaf9HF+J3JPmtfaQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793709402;
	bh=xMKtNoJXoBpcWDkQbpJgH7N+X5jzQ8IFV2Vm72XdwVQ=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M20ZtAZb7WZexwZ3uAKZTvLlQmKeLTBF125GwiBbBTP8UMgdmT9GeVMtQMUhl4Q2k
	 0LZkZzU6nW2cdfCrk2IAX/sz4BjeZDEeInswRCzbrFTU+jUCYs6epMpLJDhwBlXCNq
	 fD0bPwCcHtN1lz3UWB2Hsl5lU50Y0+7Pi/V0tFR9DjpLNqWYzO8nTuI8WFcuuc9GC7
	 I1v6JRl7kHgNVqbbyUoE6xl4w0PLsdGJTToD41Dj5/+T6wrgm2pNEXc7rkaK1XVk53
	 ihozY3tXdWqPPjwGMumlRRPvk/k6DK2il9dbXLg/VvwA56MMfikLcOl7PFio+jqZNI
	 qvC7D6uKlscJg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7F9AC40508;
	Tue,  3 Nov 2026 12:36:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 05F62A5E
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 12:36:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DF62C6077E
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 12:36:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Wm8IJ0ZHRiOp for <intel-wired-lan@lists.osuosl.org>;
 Tue,  3 Nov 2026 12:36:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5F9BD60686
Authentication-Results: smtp3.osuosl.org;
 arc=fail smtp.remote-ip=192.198.163.13
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793709399;
 b=AgEbUfH8xRgYZxUhKgF1rvcJXUiYVA9M9eFgG1CK1ReCMZoezkQJzFFcmfBDJJ2KPLkv
 KpPAbAGS/EIE210pnBJOnYJcJeqOaqx3RBzt4cWCR9Tf60bhTh/QUYI9vNMuhX2wzVsHr
 JISVsPL0zkjWWXqtW6pX3vXqE72HH/drr8Tz3+NJn1nJECZudxOZcSbpxTlotCCsSPjcX
 P78QJG5jR09W0V1Ez4YywJMvx95HtmKn496iYWEroOL18FHi41lkVwIM0lorulYOyZhDU
 dBgfVrQnQvc/pnvNd2X0ZYd/ildLbUxV7nxlAqx4Ajsw5W4DttNSeD0esegASu+V6cg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793709399;
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
 bh=xMKtNoJXoBpcWDkQbpJgH7N+X5jzQ8IFV2Vm72XdwVQ=;
 b=IRgzRL13TQ0UeuL5+zA72NPyBtfr4AVsdJ+JVU/6ZalFXGUANTkBnBZ0OI1E9630vpVN
 95ISDV1q7dDYZrzleqWUd71dxEaGJ0WlhVQ3LFaWMe1adz9DXGFm5p2PDsdNZ+OsFSnLF
 nsSRRwPAQyZjobx2ZfXmlxWZRESK+IZ2AK+MiFkvpLhDQhuum3pnhxQx9vAqXh66cuplI
 EtboSgFe63uLx4fb1ax4QgL4RN1kdbbX0HMMMfP39p+Kc6l5MwoNV2HxcB86HcFlYmjUT
 +5r50heQq00EtnumDdz4+KoPfM1BU5Gas0g+UnVteRtJEC1sbUjW6Z/9a1wuMMzLDog==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=OcaObfbJ; 
 arc=fail smtp.remote-ip=192.198.163.13
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.13;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=OcaObfbJ
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5F9BD60686
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 12:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793709399; x=1825245399;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=oJUXDhIJdNUMEgWxh+qGitUMzbVDg7sP43RXdj0eu0s=;
 b=OcaObfbJuR9LljRRQKvrzZaFgrb609OK6+szowwdyDx1W8NmDz7F7gMl
 yfUiioMTXdHzgjHwG8if6KBRLwavUmUyFJ3JxNNKk+RrGuz6I5RuZB0Q+
 eP2A1kxjSDOhak6HsOt9HPZvZXF+Voipq09WKPzKOxptWQhTpyO+GH+iU
 UBG7GG/d+D4/b41FSIaXBd14LwmQweTn981gW1f/hvKcZA29Va27ieSmr
 8LSUaWM/Ifj4N7YrZL1PbRkHO2b0xqdq5zRyv8lQeBzo24xoff9ahQg1n
 NAMjkSu0j9Wb2vjxbCfbIBQsvYYADp+V29USwnEZXUNzGPzL1zvzH06VO A==;
X-CSE-ConnectionGUID: 2QbcRqC4QmyaOi6fEEFAVw==
X-CSE-MsgGUID: 1h5N1cdhQ3+q8JKbsCoyJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2427541"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2427541"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 04:36:38 -0800
X-CSE-ConnectionGUID: vC2M9wJnTkOjIOkzJcvnQg==
X-CSE-MsgGUID: uRvU4GNXQ8S40t9fRIgwEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6950666"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 04:36:38 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 04:36:37 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 3 Nov 2026 04:36:37 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.44) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 04:36:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OljDKtI923axKXsxxVEs/gdsWh+sooHNcqElxGHPvHM0C+F7Pe7oNiwK3WJOjp5ZHKiAyneL0DZfcNFzYMr5sd5Yhtlff4lgjS/xMItyPrlMNZfF4ptJhfG3khh/BfX+BnbCDlqVJoT9Jc+GAx6L/lQiDw2I3SgfQnIA1kRoQX931GuyFWiBHxTssgvB0r/mx9YNdcF0K3nfpKwuY0Folbk816vsQAnkfN1DwGrd7Ve6r/cgiDcHFGPyQ/AuGC4vOvgxXp4l/s/Gkla6GwwjAsBvBkb8BJSHyfJ/Awfj8bcOB20TJzGC/KjTQLk18sDbAOo/0zsPElZKlbATLssuXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xMKtNoJXoBpcWDkQbpJgH7N+X5jzQ8IFV2Vm72XdwVQ=;
 b=wDp3KoxlHXlG3ltXuwcEN+XbkiyCFNq3DGV6zGsiWCfZxbd7SNnL6uQ6L1gXDF5hMt273+tS91WEJrcBqEYyDuAAsLMXr/ihCYzGoAYeQZERGrWAUQ5BD+4qw+rELj66dpjo1T4g4xTuBZbPU2u+w81Vph13Lo8nZJ6NH838v7zkb+GALMvaW74ykeGIdm50aKEahoTG+gOBjyMeNuO0zAxfI8bhghPk7PSrMW4Xkea8faQihbEGSdPdOSTpLsqp3GutJR3pPxN77iObWrYkoHDrwH6Dmq7hqEec8lsoXHPGOKBsPhQks5z837DHlIeeqhJaPhMUVTtEqHStZIdIgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by LV2PR11MB511473.namprd11.prod.outlook.com (2603:10b6:408:415::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 12:36:30 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 12:36:30 +0000
Message-ID: <3a4b6204-fa1d-4052-a5ee-c0c056b0e3de@intel.com>
Date: Tue, 3 Nov 2026 13:42:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net 6/6] ice: register LAG event handler last in
 ice_init_lag()
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Oros, Petr"
 <poros@redhat.com>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, Sashiko <sashiko-bot@kernel.org>
References: <20261102105346.30739-1-przemyslaw.kitszel@intel.com>
 <20261102105346.30739-7-przemyslaw.kitszel@intel.com>
 <CH3PR11MB566895166EFE8B499CA2AA74AFE5692@CH3PR11MB566895.namprd11.prod.outlook.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <CH3PR11MB566895166EFE8B499CA2AA74AFE5692@CH3PR11MB566895.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P251CA0030.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:551::15) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|LV2PR11MB511473:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f4a27bc-5356-4b41-231e-08df39a71590
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|10067099003|22082099003|18002099003|56012099006|4143699003|11063799006|261021123027099003|261102123227099003|261009223027099003|261022105027099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: XK2sNanpZluIUvocZkYHyC+iF7aiw/vJd4C3zq7hhN92DJdM+bAJguB+hNyH+l8JbzYuk1KigUEXXpPcWrXhlbaWIAHMoEIi4eoT6thdWZ9Nq/tMOOFKLbxdUI1DMGZnfOvBQNmr1lIsWgRwZFQDtI4lVe/n/AKP84MnartWY/WUDIlXJUz/WRxYVjpCplNCj8zdxtGkmMy+48wb/96QbHD7t+R+jF16+kwC6wPHE4B6AleoD60Grio0s2PqHlLMItBnFpabtTaPFXom0L6U3xRbZFYwVYgppCSXu9DFA4VXW2tS0vAsGe7XogWewV3JvQmUbsolb+uXAfe8fQbIRTTal8xqOY7D6KIT2JVmlGjvhyhXyAeDiJNaE96rhDWGEJm3syasRkdFqg1/ZwtdPmoxk3DhozVnbOsOIJxB8h8TR0FWRK4OCa9XZHJ5b3jhUNd3hNnF+SRZnNtQkbdPGhBRqoQc0Jn+0eJXqUpECHseM5QOhUSpbaBf3jrbZRun3BqBDHH+lFpKbvCPiD1QE1cczFuYPsbjOYcieJx/i7yBG4+PRzJwVrZkbY+CMUCpmavLOtCQtOauNfYZ52HK3lUofoYPGiDs+6xwcApp6M8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR11MB8508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(10067099003)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(261021123027099003)(261102123227099003)(261009223027099003)(261022105027099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDkvU1NyVlcybURTb2JnZU9XeG84Q2piM3o3Uk1xY3dqbW12Z0RxRTN5N2pP?=
 =?utf-8?B?dWJsVmt5L1hYU045SGJ5WllCc0IwZ0xIcUhuVERjaTNTNzk5dXZkeFFFelY5?=
 =?utf-8?B?ekxTY29qQkxzZEwvTkxuMDJVVUJOU1NHNW9DQWw4SG1TSHV5MEI2T2IvTnJ4?=
 =?utf-8?B?NWl4cXRMUXBWT1kvd0RRdGwzb09xMzFFU3I0QUh0MDROYVRKd0xiMUtwVVNn?=
 =?utf-8?B?NldTWTlMWFZuZGhZdjNDZFQzb3YrTGRZekRFaE1UdjIvZFBscVowbnBvT1FJ?=
 =?utf-8?B?RjQ3anRoQkRNd3JZZXJJWDFSRXh5SitCakpVOGZqREg3UEFjYjV5aWo3K0hy?=
 =?utf-8?B?YXJDSWRYYkNmZVphaHYwbHlmcS9oc3MwWVl0dW5OblRVTVNoeUZXNnM0QnV0?=
 =?utf-8?B?U0VtVDc5NW9lSnowL2dmSGFaSHFERFViK1dNbkNlRTdxS0lwbVJRcFlmUHpC?=
 =?utf-8?B?SnF6UE80N0FkNGp6M0tkdS9hdGxBQVdnbHdIaU9uU3Y2WnVyYjk3NlExVTU0?=
 =?utf-8?B?a1c5d3ZKN1hlZHNLb0R3dWlTWEF2RVJZaldvYlU3VGEybDVDZzZ6MVpuUW1R?=
 =?utf-8?B?d1B1Vi9HWkRrVGs0M0FkeEJhRHJyd0RpazYxM3BDYzYrS0YzbzdUMzBrTmk4?=
 =?utf-8?B?WXczcWRLYzJ4bGRxbUdMKzZQUDZndnVBM2ZXcGpGU1haRXJtYWtUUVZtVzV4?=
 =?utf-8?B?aG1ocVFjL3BsajhNcGQ5TVlWcDRWcGVocUNvd1huRmd6NXlmOVc3UGNUTDY3?=
 =?utf-8?B?ZVpORTFUN1NDZ0YxeFVvanhNTHNjaTEzd3g0OWcyWHp1bXBmMFdyVkNvWEo1?=
 =?utf-8?B?UFZMb3JZUDF4bm1PREl0YkpCYjc1SDE1Ym1ZclpsYzdsbFhCWUI1ZldkYlI3?=
 =?utf-8?B?cU16K2R1bXppRzkrekM0MWM5RnhuYlFFWmZnUlBIaDl1OHpqNjl0WGs2VDB5?=
 =?utf-8?B?bkJpRHU1UGVLTjRZc05raktrZEp4RFRuZXRaSDl0TUUvY1UyazVia1g1RGFM?=
 =?utf-8?B?dFFDZURoRU42YlBubHRvUnBTLzlzOXk2bU1BblROcUxLdGtjMWkxTlhOa2hD?=
 =?utf-8?B?ZnVKdjg3TUhka1hIU085S1ZZVENMSnhnZXprK20rUGQ5Rmt2R3AxYTYwWTBx?=
 =?utf-8?B?UlcySytIdW9GWEwzSzhLcHEyWmt0dTByVFU2SW5tQmRmenhPdE9WV2JIM2Rn?=
 =?utf-8?B?Y09JblhvWHMvUWNva1BhOUM1WFlrOER5bWorZ1d4UTRCQ3FPeUlrOEZRL1lL?=
 =?utf-8?B?d0FZK283dzdHaUJoMDVaQ3l3bHBrcXQzbXZpY0NaU1dVMnhvZ0dqLy8vU09l?=
 =?utf-8?B?b2toVG1WVHhKZ3MzRFVpb3liNzVZOEIzTVh4T0tjbVJsdkVMYklwc3UzcmhK?=
 =?utf-8?B?bU5IS1k4S3V0alB3SFNNRDB4QkdrQ3JpOHVoNUJpY0tqVjVXemlhRHFPQllo?=
 =?utf-8?B?YjlidFk3VGVEQkVlNEFwc0NSNGw2QkU5UVRrekpFallBazVWdDdONWl4bWw1?=
 =?utf-8?B?MnNuTkZCanJVRDVmUHdGT2RQMVZRMVU4NkVqc0RseEg5enV0UnJnVHFtNCts?=
 =?utf-8?B?OFNhNk1Rb0Ezd1BQYktMbjhBK2FCRzVlamlnZXB5c2VnNW9GMFkvSHYwdjV6?=
 =?utf-8?B?ZnRjenUwZVRyRjhzdGlEQ0tIcW92Vi85ZnlkMXFOb0hYemZXNmNJR0pMRCtY?=
 =?utf-8?B?MXVGcUxkaEFIa1Ztd3puR0dvbUNIV2wyellZSXgvQWhTZ1N6Zm16WHlrbUhC?=
 =?utf-8?B?WlNaOFJZSmlUYmhCVGFqTFlCOEw3ZjlxVFdaYzBGRGJ1Q282LzNhY253UHpu?=
 =?utf-8?B?MXRPQVlLV2lyWFhEbi9xdysrQW9yakp6L2hYZENnc3BydkN3cURZeDJCbWtM?=
 =?utf-8?B?cHp6dmN5WGRXNzNMRGR3TlhPV1RXcFNUTk5wdS8wMXB2blIyRUx3WUlYclhG?=
 =?utf-8?B?a082WW9YVXorYmhaaCtLTlJMQW5CbXh3b1hHUk00Umt1QklxUE92b3BWaEcy?=
 =?utf-8?B?TDRZaHYvRUFrV3FkWmFlWTV0UXBRY29ac3Y3VlJNY1lCZHl0SGprd3hQR3p1?=
 =?utf-8?B?OWtmS2JGZktveVh2WmtWMU5mMTA0ZVJINVV0b010UjFybUpYNURoMGd4c1Bn?=
 =?utf-8?B?TjJycjlIUzk1ajQwbVNOQm1nM092K2lZemROVVQvYnE2ZjQ1QytkbTh0bUQw?=
 =?utf-8?B?Nk1OLzBoSjNMNmdTbzVoQW4xajN4alV2NHVoUndaYlpjYXM3UUQ2SUhLcDRi?=
 =?utf-8?B?WkRrdzd1aTlGdzB6Y0Voak5ZaElUT2lpSVZISDZ2NHVsODNEU05DR3QxTnVl?=
 =?utf-8?B?cUR2STEyakxpRnNtSk80NU16V3d5NUdiVFVxQXpNODIxU1JZODM4MmZ5dFFj?=
 =?utf-8?Q?2jfZ+c7wmWqvEuFc=3D?=
X-Exchange-RoutingPolicyChecked: YiaZVdTw7xXMmVUYf4JgmqPl7dRrt8/lvh6vaSG2UkjRjUAG7k7EtCjlyt2OHA6SGCfcUU8cW/zMppQWOULYyYSQljzFvDGQs46SWbuYbXfrow9mTQIpfKKrFrNh1jay3Wp4QAYwhi92QdjdTuFezLyeEJ0efidpJhc34rUXsyf/xaNOHsed61dQJ2JmfjudZRxNSLYKygUgrJgtkY38hGaadvTEQHHnfbf6CMZBYBBBgmdjA5GrR3n4IQVhF41zGZZ5yY9T3hcWC97xMCG8Nh7Jfq/n0n7GFa7GCdibmX/dCLMGPmGBabEiQ4ncoqIUnRQohgZ9drj2fSnrB5iuiw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f4a27bc-5356-4b41-231e-08df39a71590
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 12:36:29.8118 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OcSHFrITNFmQg5FZf1KJYCHgvjF9OQfZIvcRExD7f27oW98MFWoTb9Z+9GfgeF22Jw+/uNdEi34UfbG6e3uIOGLAc1VK8Hh2K/N/qYzHwuQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB511473
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/3/26 12:23 PM, Loktionov, Aleksandr wrote:
> 
> 
>> -----Original Message-----
>> From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>> Sent: Monday, November 2, 2026 11:50 AM
>> To: intel-wired-lan@lists.osuosl.org; Oros, Petr <poros@redhat.com>
>> Cc: netdev@vger.kernel.org; Kitszel, Przemyslaw
>> <przemyslaw.kitszel@intel.com>; Sashiko <sashiko-bot@kernel.org>
>> Subject: [PATCH iwl-net 6/6] ice: register LAG event handler last in
>> ice_init_lag()
>>
>> ice_init_lag() registers the netdevice notifier before it creates the
>> LAG recipes, but when creating any of them fails, the error path frees
>> the lag struct without unregistering the notifier. A failure of
>> ice_init_lag() is not fatal to probe, and pf->lag is set to NULL, so
>> ice_deinit_lag() won't unregister it later either. The next netdev event
>> then makes
>> ice_lag_event_handler() use the freed lag struct.
>>
>> Register the notifier last, after the recipes are created and associated
>> with the profiles, so the error paths have no handler, nor queued work
>> for it, that could use the lag struct or its recipes. Free the recipes
>> if the registration itself fails.
>>
>> Fixes: ec5a6c5f79ed ("ice: process events created by lag netdev event
>> handler")
>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>> Closes: https://sashiko.dev/#/bug/linux-e0559bca-fcfd-4435-96f2-
>> 15f7e3d74184
>> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>> ---
>>   drivers/net/ethernet/intel/ice/ice_lag.c | 15 +++++++++------
>>   1 file changed, 9 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c
>> b/drivers/net/ethernet/intel/ice/ice_lag.c
>> index 08a17ded0ad5..c4b8af01e2af 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_lag.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_lag.c
>> @@ -2601,12 +2601,6 @@ int ice_init_lag(struct ice_pf *pf)
>>   	lag->notif_block.notifier_call = NULL;
>>   	memset(lag->sec_vf, 0, sizeof(lag->sec_vf));
>>
>> -	err = ice_register_lag_handler(lag);
>> -	if (err) {
>> -		dev_warn(dev, "INIT LAG: Failed to register event
>> handler\n");
>> -		goto lag_error;
>> -	}
>> -
>>   	err = ice_create_lag_recipe(&pf->hw, &lag->pf_recipe,
>>   				    ice_dflt_vsi_rcp, 1);
> I'm afraid act_act_recipe is allocated but never released on the normal teardown path.
> See ice_deinit_lag() it has just kfree(lag);

you are right, the code behaves that way both before and after the patch
FW resets those via PFR at appropriate moment (appropriate to ensure
correctness, not to have clean code).

Not going to change that as part of little fix.
