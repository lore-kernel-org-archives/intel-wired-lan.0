Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E215606A31D
	for <intel-wired-lan@archiver.kernel.org>; Tue, 27 Oct 2026 19:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=nR9JpNmf;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Fq/YASpQ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 55653605F7;
	Tue, 27 Oct 2026 19:28:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kzNdGDdTYqTj; Tue, 27 Oct 2026 19:28:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8F60A6061D
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793129318;
	b=pbTkBn7/3wjpeE4YJw30r2G8h9Qwna0g17mLreNoEjBOgvmwM7tF0heUjtX8fUn4R/J8
	 n5EoT69cmzumRajog5lT8lL3H3vlMAVgcN4jjBpPkxqzCiywTzUJS2BN5RLeWCqVS7yWq
	 D1i9/La4yqghw+BpqnmEDzwLQUShShKyuwBBCISt2ygyZ8RoFG1Wt81Pcn0b1dqLeq+o7
	 rf3vXJodSDfcY2fdHsEwOKYA6ArUsOEuGl8CnALxY6vJpDE5Eje7tdWL8GIdxpvY3TiTO
	 yOR8Z7/tkg2qAnmboRB+hD2MLxGNwGmsaxKsabsmhYm60t0YQ7APMyIS7Xo74gphDuA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793129318;
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
	bh=Nl57zlsd+k2nrd6YqdQVhOCrwu1TMSZ87ziaV5Rhz+k=;
	b=Dgx7LaDLIIsQNKKAK41DQYixgrfi5YBzsfkHPKW9hl4mS6znh8x/b+paptNg8yMVq8hm
	 cGS0T97i6IqP9ppC+paVud3oCaHN1CxgKiY+6/5izb3GttDsoITAAsqul2bc+b/FpjmRU
	 OhHnVGn97cGN/TEgyXQtK4pLOV/SgwF4b7aX18NU8V4QPIKdskRX7+paPiISJgpLBKj1n
	 1DMETd8p2zFQ+wG8uCp+3nBoDVX9BJ0C+EKAciQEBlh6MCMqe7OFHLZDU9HMnXCg+atSc
	 DsTILb/zqJ2iM3msaNfxCRNbTPSO/toR+XqC1W85REpNizHpXY8GQ1A8helLMRGQIng==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793129318;
	bh=Nl57zlsd+k2nrd6YqdQVhOCrwu1TMSZ87ziaV5Rhz+k=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nR9JpNmf3blgMNvWnKA4Z2kBwmtnz7jOhwHY8m9vp4GWi3OcoQidtCCbIrZFByX1j
	 anaFql5BFCFeO1h3hvggG0d8eXl21yNrLJQ3zYnZG4rktl7r5pvO5r1W3X/DsfTMtP
	 4juhawztmUkCgvECKBQkCNlZzQUE/ZEgJkaUrYEHwpuqIfzocYS3MmI4HfLW8onYUv
	 7zLleaMmY3keEqOlTWPRG2S32crQIdiu5G7XGU/OZgU6hnvWAoPU0Gv7aAPSTGo3NE
	 A073AgAVeBlFeS88SfTn0iQd/F8so00pxN0KqT0Z2aCrFM8QWY1omIs/N86zcPCf6c
	 mJ2MoBqHt4MMg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8F60A6061D;
	Tue, 27 Oct 2026 19:28:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id BF95E473
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 19:28:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B10994066C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 19:28:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uHeZLFL_tOpf for <intel-wired-lan@lists.osuosl.org>;
 Tue, 27 Oct 2026 19:28:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C18294065B
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=192.198.163.9
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793129316;
 b=Jqd/a6Z8aTA4B1iN6STwS/yWMrD1FwV8NOepyiQT7AC4xFGVjN+QYUm/hA7PZkumuLeC
 1+Ha8Jwsj1BeRO4fEe3U38bfreiImsmF6A6s9QR1GYI8yVCj9oBwpIRxNpoKSkkfzMQ9s
 s3vDvOkHL4dYoVVWS2Y/0/nQ8F4oI2Q+9DLEPbgbv0t6o7vGTtNE21a48ZrxpLuRKmhrC
 GVaz5DhfMsIlaKRxTXbfU76IjhGAWXZSo5ns4Dwotf7gY+0xLyaHpO5SXt/ybin+DgCLi
 h7I+PF6Dy3/zcgav18bqfrrXymWxpOyBQmmaauTIqjCIhwhPk5DGmimg9IQ6o9bRUcg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793129316;
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
 bh=Nl57zlsd+k2nrd6YqdQVhOCrwu1TMSZ87ziaV5Rhz+k=;
 b=eNbfV/TSpwOVyolVTjcYi8ZMfuEXjWPb33sB39ciyM2Nt7+BYu+DVmv21+XnZFM75Bh3
 +sBvS+A/d5qXKKTRL9IVlv9t7R8jrjQZXGJPHIli1+/DYoZfocJclOySPOW3wbuRoPErO
 jGtaVjNpawE7ryyW4UDQZTOMNN+L9Fff792PCuGkjPaKFFHUei8dSa2mjjwHtENCi4rPt
 MM8LvafCbyN7F2edYWscEm41zbBpl2ahKoy1zAWZyQ/pkA2voIZ1lDfeorE1Ewd3GYNlr
 7c8Tdh36/AecKmt6nirrSeHJOPUV50WZtU2S9COO1WoO4HDZJRi5KSRYwx4QJYWe57w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b="Fq/YASpQ"; 
 arc=fail smtp.remote-ip=192.198.163.9
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.9;
 helo=mgamail.intel.com; envelope-from=emil.s.tantilov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Fq/YASpQ
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C18294065B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 19:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793129316; x=1824665316;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=VGeqrjK5uxXzux3+CWdCheudePXRQo//IqLHT08dG/o=;
 b=Fq/YASpQGdcFcgpFhuYHMo/ICexDwadNz0doFkBiK/XT/PmmpppEvPw4
 dSZw/wyyURT1oSHHp1KmniQ7dRG+J4WtAMf/Xttjr4xu5+JAcGvLCmXX4
 Q6qCyd3jZ9ByDL9vm17u9j3+6x+MfhVq/Zz2KhJHOZW2dOd82kzUfk+TM
 nX8r0JXY29xVGQHSCf9FZPFBuyzqt4nQO5z8hk+IjxfEiNTyrmavm8VTl
 nQwp5MsNMlxjPIseJwGwtxVsIof+BW8Z9heWxHZNVz43onMkUQEHJuAzi
 8aH+nzDblNeCCsqIjpSHClOXZleJ9iihInSbFT96q6w5ZESMkzpZFwmtL A==;
X-CSE-ConnectionGUID: OdF/xUXSTFWFx7wk7GA4gQ==
X-CSE-MsgGUID: HNKDhWoHTvOe2G46wjQwVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1723783"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1723783"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 12:28:33 -0700
X-CSE-ConnectionGUID: /zYwsuj2TsOJFFtwJt8eBg==
X-CSE-MsgGUID: aSBPtBXPSIiMIywoqx5Mvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4636397"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 12:28:34 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 12:28:32 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 27 Oct 2026 12:28:32 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.20) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 12:28:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q02WVC8nlwQOPBC55TMzl6gvGdJIQJDKW29yOSVIkcdueM2wmj6BG3dmCY2mWvinTvKYJ3KbEUmBaexwZzEwAxvKeDQsJq7qQ3pBzeVVxIWfCGRjwXkG4FhCPX8p3Ri5HNdyMvLR75VFsuch5B+R7HGRPNh6wqB4rKfB0ICj//ncl/Po+Cl3wsefyusOD73SIpBcWik1eGaQ1jQbXA9g83DgQG3ungCh+IXQzjU0zi1ep/0F8eX6Gc2Lfb46eidq7lvAwJJWpAyeuRDNBTVZfRxXrS8pdr8Anm1dhzRaEDoC5MwR8LYJ+LsN+0758ZfAc3ELjuXdOtq0eIMS8rPy+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nl57zlsd+k2nrd6YqdQVhOCrwu1TMSZ87ziaV5Rhz+k=;
 b=DUEeabY21FcwRW8CLRMpFHKFk89/uC02jfuoCRQoDpiqoH9owLWU/YbP3ObzAPhqGVLWlWRcyecvJwP7C0KXS2ziCCtbzf85GDCU6rF9RJQ+FNwsKl5NeeRs+5evLjcCUNZxqHlYu9piaaIH8P/n+ii0tAHlQhAO/4CmzTkx9OGEx/O5eh+VXEmWwFyWJG20AlNsjauq0VfnAuY/yG21IZzMkN9JDQCF2vPK/33SHakrI7x322ixA4ZO+RfeMVdXY7HB92oJtpqYgfWVh8NNWs8Sf2sPDZEz9Zel6xi324vU3SnTSRUhi88T45mcv1iGGIWQ7zIKhzBJclvH6sHx4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB186312.namprd11.prod.outlook.com
 (2603:10b6:806:595::5) by PH8PR11MB6952.namprd11.prod.outlook.com
 (2603:10b6:510:224::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 19:28:23 +0000
Received: from SA3PR11MB186312.namprd11.prod.outlook.com
 ([fe80::fbe8:9ba6:fcd0:f0b]) by SA3PR11MB186312.namprd11.prod.outlook.com
 ([fe80::fbe8:9ba6:fcd0:f0b%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 19:28:23 +0000
Message-ID: <8502343b-1fd5-4edf-94f5-5a0d467eab1a@intel.com>
Date: Tue, 27 Oct 2026 12:28:21 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v2 3/4] libie: release all waiters once the
 transaction manager drains
To: Larysa Zaremba <larysa.zaremba@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <phani.r.burra@intel.com>,
 <joshua.a.hay@intel.com>, <horms@kernel.org>
References: <20261026221908.24690-1-emil.s.tantilov@intel.com>
 <20261026221908.24690-4-emil.s.tantilov@intel.com>
 <auBqpvpNx3D1e1Sl@soc-5CG4396X81.clients.intel.com>
Content-Language: en-US
From: "Tantilov, Emil S" <emil.s.tantilov@intel.com>
In-Reply-To: <auBqpvpNx3D1e1Sl@soc-5CG4396X81.clients.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0021.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::26) To SA3PR11MB186312.namprd11.prod.outlook.com
 (2603:10b6:806:595::5)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB186312:EE_|PH8PR11MB6952:EE_
X-MS-Office365-Filtering-Correlation-Id: e1719277-b087-4ae1-4056-08df3460776e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|261022075727099003|261022105027099003|261021121427099003|10067099003|56012099006|261026121527099003|22082099003|18002099003|4143699003|11063799006|5023799004|261026140227099003;
X-Microsoft-Antispam-Message-Info: Wet6WGUzix7GRH0BiA8pbNI/2XatrCKK+u9hWh8wk83FAe8wUHVKjOnw7PgSsraodH6ocR8ysLDuYC4ahF3nZ/LQpYB8Af6IJzH4gg/OtG8vN0p06wX3VTPVgEvMgnk12naIMKcWe87z3SmssP2axYnpKoOYJBakmeB+LVfU3p8HRL3XWsIL26126wjnSqUeERx7kkrFReMSJOupx/LjqIL+bmu5OzmMdYqG2F4or3pqUDkCySDUAevzfCcufi0r0ja+yXJGNRHNgx+8ZqvHq2gWz6eIfai78DPADpMx1lW1F5n9yttJxBnThNmEvpXh7648Wn6JHN5w0Ddru4vsRs8vV53zkwWmbzZepbpenPzW8PTz2w43ZJDHuCTZ1dHFZPElPSVpcKOjbWfNEBbX6uvQ2as/w0lNluUPWYaA8VPDdHw5fmn0LVQcBdOlIlmUAhgTXYg5B5+UuQWisghkwgT/c0sVDbO+KK55xsAtvxv/zEy7gynLuL9qrS/zrtSEyBhmgCgTiyTyLqhvUDo1So6/1OZxvh024NfxTkJS1zDJD3zTLRnTIo5243lKcAFEH/+3LnYOkaifQoqMIp96sQlwHfdIUsHd4vI4Lpo6KeVGhsW5AzqXu5ZWucIFZ9Wn+oHM+/oA5/dIqRZhV5mC0JXIw6h1nh6sysytLDQdyuQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR11MB186312.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(261022075727099003)(261022105027099003)(261021121427099003)(10067099003)(56012099006)(261026121527099003)(22082099003)(18002099003)(4143699003)(11063799006)(5023799004)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWdLN1o0R2ZZK2lxR0thWUZ3ZmtTL0dlRE03bytISVFtQis4eTdGVFdsa3gz?=
 =?utf-8?B?UVd3bzJnYTllMVZod1lYV1gzNVZ4bUxvbFJDY1ZOVU8zUGtkODUwM3hYc2tq?=
 =?utf-8?B?M09MZzdWTFFJdFg1UU05SFJ4TFoxT09nREhmNWZJN3FmZTdmc3FFZGNJb0VX?=
 =?utf-8?B?eE4wVkFlVzFFYXIrVDJiY3ViSnZ1YnJDcUljeE5PS2FiQlMwbEJFTDB1Sm54?=
 =?utf-8?B?d2JmK1V3UWM2eThuM2lpTmo0dTl5SDhZOUEvOFVrbGhzdXdGOFVyQTFsaGtL?=
 =?utf-8?B?dDM3T1MvTmdzSktWTTU1QnZYSUlxYlI2azZjTEFmTWprSVd0WVNReTdISERQ?=
 =?utf-8?B?SU5EaURDd1JmditiUm85TWhkSlRqYzB6ODA5RW5HYlY5cDBzSkM2aDVzUGUv?=
 =?utf-8?B?ckd6bGl1QVpxb2xMYTZTS08vS2tsRnZKTkJCUnJKSk1wbHBXTHlyYVkwMHBN?=
 =?utf-8?B?ZXg5czUzd3FqTlk0dXVSZVY0dDZzajdCWjM3ZjYzTGp3U3RjSWNIOTducjRD?=
 =?utf-8?B?TmFBbUVpNEM2K3haNzJSdTBSYjlJMGlQeUxqY1dTV3FWYmJWVEVEMXVhWnB3?=
 =?utf-8?B?Q29vRHhxMmFqdk44YnFNNHd2V1ZwV21aM2JsZ3FqVk1kMHJ3aWxHSGgyUUhJ?=
 =?utf-8?B?QldPN1ZFZDJNQ1BEa1FtSERnRXhyZnc3UXB0OVB5M2NQQURDV1JCOTNzYnRp?=
 =?utf-8?B?SFl1RGZCNlp6OVRwQTRJdk1LM1ZMMmJJaWR0eDY1RzhmMmFVMlREbXlzVXZH?=
 =?utf-8?B?ay9mbUdiUFhaV2ltYkh5eHF5b1dMNFc1R3pUSFJUeUJQYnVGdk80TVBYK1Vj?=
 =?utf-8?B?djFjT2UxTWZJaTJEMTBUVFdROSt5RktKZlhpOFh3dTBPdnVtR1hSajZwQzBv?=
 =?utf-8?B?MkFNcjlWQ1liUWJhSXpiaFNOVzZtSXk0V2c5VmcxQyt2aGMwblR2bFBFMnJI?=
 =?utf-8?B?SG1IeUZ2cmdMUmpwNFVwZnZoV045eEQ2dHZNSFJaYXBKUWhVVWgwM2dLcVFI?=
 =?utf-8?B?aHQyMnJIaGpseHRrWXhHRFdCWUFhelB6L1IrV09CTDBrY1FVd3l4aUgvZER1?=
 =?utf-8?B?UEVnQktwOElyS1BiaVlsWFZXRUtUQU9RRHc1bWsva0l3cCtaYmVnT1FPT3pF?=
 =?utf-8?B?blpKMVdHWi95OTVkdW5DT0FpR01GTGZpTEc0aXQwR2tJK1VING1TbjdjNzBz?=
 =?utf-8?B?MXJMMUFzalkxVUNmdlJyazFmdCtLU3k5Wk1vUmpBbmRhaGV4ajhEbHZqTGtP?=
 =?utf-8?B?SzVTOWVZU003N25JZEgwdG5YQXdLYlJpYzZNOXBsV3hVZ0FWQlViMWNjVDl5?=
 =?utf-8?B?U214RjRkK25aN3BYemluYnBHU0EwNXYyaXlnVzJGQVpLWjVma2NtYmdXU1lU?=
 =?utf-8?B?YWtLSXFmSjk5R3lqL1JqVVRyQ2RaMjFYV3Z6Njlwd0x2ZWdhWmtNUmFpaEJT?=
 =?utf-8?B?R1VpUE1nT1FJVFFBSWZZS3piQnpweG9sMitrcDFraVpVbmY1WE1jeEFORlFX?=
 =?utf-8?B?cGZUM2ZOZFNQSm84Slh1SE9SM1J4UWhFYVVuLzZ0TjhRZXdxb25jSVFSTjh4?=
 =?utf-8?B?eTZoYkJEWUY5VHgwNjd6UGtyRWVXT2tYUFlhVzFzeXhXZHhsVDJmMFhKRzNE?=
 =?utf-8?B?aG93Q3orTEZ2Z0JYZ3lCR1NlUzZackprZ29adUZzNkRuRTVRUUozcmVZbUZl?=
 =?utf-8?B?RHg3KzAxQktqUEQwSVFRTm5aMjZ1RFFPRW8zL2h6dVBMZjk0NVVLZFkxMS9B?=
 =?utf-8?B?WWZSUkRWNXlYbENaTCt6eHRiUXJwOHRGUFUrVEdBNmh1U2QrMklDNUgzcTRO?=
 =?utf-8?B?elBZK0lqTDl3R1E1Q21vVVZ2TEtmNUFoT0RFdkpUa2pLVDBKUGhVYmZEclhv?=
 =?utf-8?B?UEpjV0dFYVdBN0NEdmtmcm5YZXBHY2d3cHc2WGRQWnNmNlNsTFZxRkY4L1I0?=
 =?utf-8?B?aUM0enU2Z2NUdGhtTmF2NGhzL1FnamV0L0htU25ZR09YdXZqcTY1YmJhREx5?=
 =?utf-8?B?bHExNnNYck5qVmtmc3E0NzFiUTNPQ0phVzRQSm52SzFYdWREVFdpc0pqWmxK?=
 =?utf-8?B?NG1jK1lmdTlHdDdxT05YeVF3UU5xNmJ0NDJKNWpFbkJPeXoxbUpKZHRNM1kr?=
 =?utf-8?B?NU1nVHZqeDhoaFY5VVFwaU45cnJYaG1nTmx1Vnh4TEE3ZW00WTdmV1hIendy?=
 =?utf-8?B?Zitock9jTDkxZzZ2RHNNRlhWcTBlZk5oM3AxdmdhWkI0enJSRFlLNFFRcXNm?=
 =?utf-8?B?MXBqcnJtY3R6Mm8rUEJ4ZmJKYm1DblhDeUxkWnV2RWRReEI0OUMvMEJZMGdT?=
 =?utf-8?B?OXdsRjVVU0QwYWcwVGhQc1N3MUg4b0t2b1hRQTljNjB4YkdqWmY5bTZsVWpz?=
 =?utf-8?Q?usX4jGFSV/t7SmtM=3D?=
X-Exchange-RoutingPolicyChecked: IXGZwWtKrAkGNZKc2emnDGwW2ECKK4MKc9crq2I5l1j9l+TUDCDA8YECwrsJh9fgGqy5n6fZ3t+hS3DWOikT76iyJliE9stVYCNdeTUhc+dC34/sB/EGO4gvGhIxUQRDBONHViz882yHo+BCPXLKvDyharSBLTnuIZLX2GLo8GGUHY2bOBOBnXh8qM3ghRtrcFrubzh2DOcYQY1JjarLVRCx/yQS4xXOHfWPJuND8rCqIzvU11RKt56Gu40EVZhKrGzlpO3Fo4sr4TRehNQuIgmvz7u7S1y5AV8ou3/kyuRx1XJ+jkGRySdX+fBGUgK9sVYjQjI3CefOMTj6F/rLLQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: e1719277-b087-4ae1-4056-08df3460776e
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB186312.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 19:28:23.6474 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rhHO7gAWlNukAYxyDW7c6g0bXHj+Kq6AHCwTtQCLaEUt/lpzBix2qi67O7Z0qkRywIm0IoHAD+vaUhBt1mzQOcemYE1xi4A/W894hUdg6yE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6952
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
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_NONE,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/27/2026 2:11 AM, Larysa Zaremba wrote:
> On Mon, Oct 26, 2026 at 03:19:07PM -0700, Emil Tantilov wrote:
>> libie_ctlq_xn_shutdown() waits on xnm->can_destroy for the outstanding
>> transactions to be returned. libie_ctlq_xn_push_free() signals it with
>> complete() when the last entry goes back to the free bitmap. Once the
>> manager is shut down, libie_ctlq_xn_pop_free() hands out no more entries,
>> so that point is reached exactly once and only one waiter is woken.
>>
>> Nothing restricts libie_ctlq_xn_shutdown() to a single caller, though.
>> If two threads call it while a transaction is still outstanding, both see
>> the entry in use and both wait, and the one that is not woken blocks
>> forever, as wait_for_completion() has no timeout.
>>
>> A drained manager stays drained until libie_ctlq_xn_deinit() frees it, so
>> signal it with complete_all(). All callers waiting at that point are
>> released, and later ones find the bitmap full and return at once.
>>
> 
> Yeah, I should have used complete_all().
> 
>> Signal it before free_xns_bm_lock is dropped. A caller that finds the
>> bitmap full then knows the completion has already been signalled. That
>> leaves libie_ctlq_xn_push_free() holding the lock after it has woken the
>> waiters, so have a woken waiter take and release free_xns_bm_lock before
>> it returns, the same lock/unlock pair completion_done() uses to wait for
>> complete(), see commit dec13c42d21a ("completion: Replace
>> spin_unlock_wait() with lock/unlock pair"). Its unlock is then the last
>> access to the manager by the time any caller returns.
> 
> The way you phrase this, the locking change seems redundant, as complete()
> provides the same end synchronization. I can't see a scenario, where just
> complete()->complete_all() change wouldn't be enough by itself, so please
> describe the problematic sequence.

Correct, it's a leftover from my earlier attempts to solve it via 
locking... Will clean it up in v3.

Thanks for reviewing!
Emil


