Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DBF2CA5FA7
	for <intel-wired-lan@archiver.kernel.org>; Tue, 29 Sep 2026 18:11:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 45C6780EDD;
	Tue, 29 Sep 2026 18:11:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zYgLIXgyxxMG; Tue, 29 Sep 2026 18:11:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9315180EE3
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790705470;
	b=nq9f1j7mwdzUnqAzvcQDKsQ3qX0zcukF0zl3WwEXw3c/tIQqB2ZKFXPgmiR216NDms5B
	 KB9gKoO+4Agf9yTfS5rqNc9Wq93CpdWo3W5zFk3Zs1zXMS46HSrTyntsPqB4t9mkF8ENc
	 epTnlsMlW0lG74TPLLIzqLIB1N+bseaeEN4ZE+ODL3LhWB8f53Bbmv7LT+IYdiIjI2uRC
	 RjLPtjKHtqAISiGtM+6QSLENMY9MwLZb7GltlB1kkVmoXhozCitCKJu4rEgeLXDb1I5sX
	 VVsGT5YUjkWL/7BZedjyLzp/er8ThiHLs+pAAGrQoXo+g6sVv8pKg6vNkKY0RXmfs1w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790705470;
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
	bh=jRt2rzThKfNjz3h3AQbcxaaAAgYMLamJGnIlhto2xMc=;
	b=iotAg22Y1R3sm6OnNvilAJiKzfdDZz0L2wETFVHs/99ZYb1egFrqpUkWCvmbxYfvfMzC
	 psJ2WoQi3fDChvSQy6K6ZsNFtFdDm0UE4cPXes57GFdqZGcUF9GX0Cq3JJwped4xC4EB2
	 YcHhyyl7bkL/6ECeokRege1TMtz5/aCFStVpprZMNla5n4SNzzdQeimWrG+qq2g+BSZ+4
	 AMVf7dyyJKznvh2Eb7DgD2DOh8MASpmSuuD4s3HnPA0fiPqz+ZK1REmYWC6IB71O5oZCo
	 1R5ZyUV8vjLPDYD7/KY7M1Msb0KKn01zJyM+9xycHq9KywmHRfKR2LEb0IcnJMh1uVw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JlXPTL2y;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790705470;
	bh=jRt2rzThKfNjz3h3AQbcxaaAAgYMLamJGnIlhto2xMc=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wzDMikvuIBDUHVbddBN9Z49BGiDiISlcFMAusd5ITYiUj0uzdI3EWao06sy39IkHr
	 IpSnfz+QEjqB6VoKoLWYLwDsNGt2OqlQpah3Vb3Hppy2CpYgKqgkNGxv5hP8Jeupb6
	 jHZOiWLDWk6fA83rF6ysZ//DgNAfYvj2nMNp3drPrp2prON5NjQbO4iaFYOL9Jmu5+
	 CkJ19q5KYXdxKK1cLHDalDTkDH+aDhugvytUI7Yw6/GMIwJBoKlce8vFW/R218gPHX
	 Qc60QUPfHRIhm3QpBLNA8UZN0v5lBvMOVqwo89nEtzdJDJkbmQ4/g8d6o2QP/19z20
	 dOFl5M3tVajDA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9315180EE3;
	Tue, 29 Sep 2026 18:11:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 30796282
 for <intel-wired-lan@lists.osuosl.org>; Tue, 29 Sep 2026 18:11:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 219B280EE0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 29 Sep 2026 18:11:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t2wskfGhIrvA for <intel-wired-lan@lists.osuosl.org>;
 Tue, 29 Sep 2026 18:11:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E025080EDD
Authentication-Results: smtp1.osuosl.org;
 arc=fail smtp.remote-ip=192.198.163.19
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790705468;
 b=ZLfpgxSw+GlDnj12ZQMXAoRUy2+bN8Cdqc095cWlSTl506EI1RRfaIkbbbZkpS5h8QH/
 iV7OYG0rcFRLi5sBbvUj8zfMO8X/13AsAerG1ejwDllpbPwyVhaHAyfmwQLgz3HDFiGai
 l1FQSk8qe3DsKHZFIX50FrIfmsidoOfCPvQf691lYh/Vy60xVHNp1HTw6Am6WpOK8PHLv
 yVmb0ECQMGczxbB1ZPxCvFfUiT5rjBx9rTJXCk/BAHQVasnkhlMIB75t9vpeSiBwn3B1N
 GNOmlH9798J6ACDyFsZdQIdRh/vZMjeDSFVLkv9wsGNQUIaomn/i2vuexVTWIrRDXDA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790705468;
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
 bh=jRt2rzThKfNjz3h3AQbcxaaAAgYMLamJGnIlhto2xMc=;
 b=jz3Oc8zMvQjmapCIm+y2P2/990q9QpeELwWZU8dggwlZKQ1jW4gBt0sLDkclokiQT6lP
 97x8LQCNfOlfLHMnJwstDmORYRUMHIqUn4LX9eqQtiKtioQeVt1bbpzFLwbZxCpypT/Rw
 mNf3Wp/N6lNfHMJvZFhWIZ0u4YqR1N9rFZsQNQrPzWHjLNQK6BNDpCqNQjtIIzosEbL+x
 HKTyU384GAma8pSVOC6rsWV8cf74XxyFlZ7/VbkJ/glnxyEyH8Ba/8VGIpTv2zVoVpsPG
 Ejd8Glv2P35oZD8CPhlIwouUS91sDNnCiTMj/NgpESMbCMAJZ73kxfV4JZDuW1sHF5w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=JlXPTL2y; 
 arc=fail smtp.remote-ip=192.198.163.19
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.19;
 helo=mgamail.intel.com; envelope-from=anthony.l.nguyen@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=JlXPTL2y
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E025080EDD
 for <intel-wired-lan@lists.osuosl.org>; Tue, 29 Sep 2026 18:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790705468; x=1822241468;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=tL0c7GPTj7dBl7wwbYlRD0Jsn1jnHM2ARr1vlZGeNdQ=;
 b=JlXPTL2y+G0ly6Gf/50TrcCngpm3AR9zw+eccox5GyGyuLwxZIAP6J+e
 I0tMmgTrg07/fYdIJgn4huIcXNtWloyGrUQJQYMJ4FwHYuqu2cEa+M8YT
 ZbFgPv+0GFyMxXovYhpL2Y0HYv0igFqYyhdqYWNMh7cBusdJf18ZHPUvP
 4M9bvTihdpnjmt11WdjnTyj15kqgkY9X6BF0zufRB9AftE2XunKMmlXnG
 gzrK/q8m5lrbIz8c8fgKw52THXw0W0g4OKbLpg7hrq/ZoH2A4bjNrQjOS
 EpidqkUC+mu6SZGrt2x90GSc4uPOtDSn2b14ouQsxC55t/ndFCneFd+O9 Q==;
X-CSE-ConnectionGUID: TZc3IAzhQ6+5pof/r/Ak8g==
X-CSE-MsgGUID: Cc4061cUR7+gaVqJTWGCzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="90331435"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="90331435"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 11:11:06 -0700
X-CSE-ConnectionGUID: 7zqWG0laRwOsB+VFjD5rgQ==
X-CSE-MsgGUID: jLKAs1YIQ0+i/2v0UODwhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="280200294"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 11:11:06 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 11:11:06 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 29 Sep 2026 11:11:06 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.26) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 11:11:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oHH1T7q5jWkPvrBVnZNgc0TlgGNd+y5giTswLlFC9XAkjcPsIM+libpWOjbKxMz8UAZuVqV8iyJ0cHSyxcLBNvaZ4tHon6o42Od0zezMedjRI/80D0M8izyFA58PRQxkzf0s4Z1nuiUsGY9pbQF3/Qo41g0Zcpnp7NnjRiVUD2POU3C68zfslDO9r7CVSD3J2n9YY5D8z0kE1wAuE1Hngal0x0J6/q/tbvjiHxFf0ejbNxft9bPFea71x91UXhkd6vMRai2ywDFZ9nPsDLycuHDDYucV90yxw30FCNIEiM1/nMrHeJ4md5AculMOuDfocehPVNb6PIQzAYLw47BbrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jRt2rzThKfNjz3h3AQbcxaaAAgYMLamJGnIlhto2xMc=;
 b=wcx6X42Hv1KQDl+X/GAIXvlPcB6bsdiiNX8GPEm/Bv+BN/hz1MUwQMJczIwqjQZXbAjklM2UnnBQsz9FChzqJvcsVdkkR6DtQ5Zd7eiOtd6wC/tMD+dhP2+3NguLDEbHPQCLBb2SbV6URpku8RioK5HjU8N75ju7xFQdssawitNd1B/ZJCBBFCzxHHLXibHaUO7cKVr2kwDiXrkqVKQvqBOsnWzWOMsCTlmpyx5jQ/0awz/5f62N+Tlqi/umIMbU4SyRBkccHqNDDvUEaCsL+vLb0Oz0F2f6XMprEsStcS3ktEkzU/+wIgndu81bKzQ5ielT372EjOhRIe0ciT2Fow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8230.namprd11.prod.outlook.com (2603:10b6:8:158::21)
 by MN6PR11MB8146.namprd11.prod.outlook.com (2603:10b6:208:470::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 18:11:03 +0000
Received: from DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40]) by DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40%5]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 18:11:02 +0000
Message-ID: <547ed917-77fc-4670-974c-4d4fd6fbf3e7@intel.com>
Date: Tue, 29 Sep 2026 11:11:00 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v2 1/2] ice: detach the VF representor when
 ice_start_vfs() fails
To: Linkui Xiao <xiaolinkui@126.com>, <netdev-bot+sinfo@kernel.org>
CC: <przemyslaw.kitszel@intel.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <intel-wired-lan@lists.osuosl.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Linkui Xiao
 <xiaolinkui@kylinos.cn>, <stable@vger.kernel.org>
References: <20260928065306.1514795-1-xiaolinkui@126.com>
 <179057875290.31693.7249107578001642813@kernel.org>
 <d3f4ae98-3340-414b-9bd0-9f4588810821@126.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <d3f4ae98-3340-414b-9bd0-9f4588810821@126.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY1P220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::8) To DS0PR11MB8230.namprd11.prod.outlook.com
 (2603:10b6:8:158::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8230:EE_|MN6PR11MB8146:EE_
X-MS-Office365-Filtering-Correlation-Id: 6827bf87-f913-41d5-d8db-08df1e5505c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|7416014|376014|18002099003|22082099003|4143699003|6133799003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: rm2STdpYaGNK/LvyuDz0hyoVJomKKq5J5Odet7KLoNglYXB8NH8yGHCCMCh1hOFjDfuKPDQo7Q6Ck5CLQ/ZFx62i0Tbdgv47GUjnPuPTW4wxj5wzWvhUFb4ijg3ZZySwTEtiUtbrH9cCpqCmtT9iHtRrLy+CsW1Rhs0RG8nHSshV4/UTIKrl0foMrlQ72KR/GYE3pooW0PrBL2vvxgPjRVpk+jf43H8KEO6p7NZeSBbY35zN9EBjEzR7gyKXkQ+PLBXFe5JVKa1vU+pz20KFAodQkQhi84s1ZEoNKrB63nXBg2AiZ3t0fGUkt5MboUXgegodFyt10nQ00ujlxOB7BLFChHgRV2SElQgUmyb2a8nVEsNYRRLrEEZYGv2hqqWBAhFnooeVmhEvL0RzkfTuXJVxk19EfTPYBhhsTOBK5uMybAPSvNma2Lp8jFG3tq6vKOi7IJALnbc9Z9erN4x0nKY4RZjaIvPcHwolhhOvSFXX7KlryajxFoFyO35U3THa6aMan3bp3r/0ao4/qvPJyhXoqALKOJ0AYIH47pF4FoXkZA83hCWA/0nJlUklesqRlZ8mpl62QrUhZg548oZGWUyocWhwmQydQtnyoNa7vc73Y+q2hQuQ81VLvlb2IK3dehvg37N80A2pNaSungHwcRA4+PcmadwzO1z27LpDpVo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8230.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(4143699003)(6133799003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHBUc2FVSmE1Uk9xc2NDRjFnMndQQktKM1Vpb0d3b04vbTVrM2lJS0d6QjNi?=
 =?utf-8?B?NzNRb0VseVVBQXJQMUVCMFVDZndlVzlCNlAzYVhDS1NuWVhSTk9RZFlOVVNm?=
 =?utf-8?B?aDBMd1RJV3g5NkRadVozdXFweWhvMEFYTlBlNWQ5dENBbHBmUEhRYlFpSjc3?=
 =?utf-8?B?UDhwVHQxZEhYcEkycWU5dmxpN0I0dVFlSS92WDVPdkUyTEZGWk5seWx5Q1ps?=
 =?utf-8?B?Mlptdm9HTkR5cG8rTVVJN2tJcGg5TzNIMG0xL3l1YTZRVkpBOXc2MGZWWTlG?=
 =?utf-8?B?bXR4TDZzbUl4eFdTOEZ1SGt3R0FrOE5OcnljVVMzaW9LZ0NINTFzajRBMUR5?=
 =?utf-8?B?NFBtd3o5YWlkRHNQTjBRTHVjdlhVNkRoWDVMbVdnUWlpNHV2azlqQjI5amlY?=
 =?utf-8?B?ekxQZmQ3OWtMbmxzbk5Ba1RLL01KbExCUU1KendQdlNGRHArUXdNaHowWWhq?=
 =?utf-8?B?cDJXSk10Vm1IbzRPY2V3QzBUUGtncHBtWDluMUZvOHVrNEd1RVQ3bC9NVkVQ?=
 =?utf-8?B?SDVMQ05iR3ZYbzhQdjNyazJGQzRpOHlaai9QY0YwTSsra3ByRXRkVjl1bnhi?=
 =?utf-8?B?Umd1US9rc3lWcEdzYWRNTEc1OUlEdXpSZDcvZkIxSTZndHFuOXlXS21jMXdt?=
 =?utf-8?B?TE9ZV21VbERaTEVMZnVzQW5kZDNnM1diRi9OTDdDZDBhSk9MYmx6aUhsN2xD?=
 =?utf-8?B?Q2RlM2tiMTJqTWxuTWJSQTQvMWtwdDd2YnI2aENJcjV6UTkzdThmMC9pZ3By?=
 =?utf-8?B?b00zS2FjVDFNQnlIVGJ0Kzhac3lHcnMyTHJjbDBVbmJWRjVnUzFveFFBb09W?=
 =?utf-8?B?WmxWN2ZtOHlUaHNxcHA0ZElxVmN1NzYwTTI2UzAzWERhdlZxZFJiNTNvRDhu?=
 =?utf-8?B?cisvWmIzU1ZOUzk2Y2szR1lJS3lPeDhoR3c2M2dJQzd1dm1mSEtzNW1GK0dC?=
 =?utf-8?B?aHdMOHpJalRyWUdqQ3VqRU1jTDN5VE01UE82QVVyM3dBOHVKZlo3KzdpRnBB?=
 =?utf-8?B?YVN2WWZUa0k2U3M5ZmZURVB4bkVQenNiSTUzNzlMTHUyazdTT2U2TzRGcW5Z?=
 =?utf-8?B?NGFUK2pmR3dwRFdrcHE0eW94Y2l2WXJSY2VVVUtPbGRObWhZZE1RcTJMNGFy?=
 =?utf-8?B?OUQ1U080UjRiLzgwTUx0L0FkOWxzeDBvbkcxVERUbzhGOWk2blRVcnIrSDRz?=
 =?utf-8?B?ZGpZbmRUWEIyekI5dnlxMXNQVU9HOXBMazd4clBScFhTQ0lQbHoydVArQ1ZL?=
 =?utf-8?B?anRibzFla0xacDEvemk4NWljbVhIRGZPMCtZM05KSGorZHQxZTFJYjlLcGlW?=
 =?utf-8?B?dXpHQUJpclFJbHFtb0JOWmFmL2F2RTkrNElJRDRjbnZDaGpyTU0wUzJPdDBy?=
 =?utf-8?B?ZU04NEd0MFM4bngzWGpVelNnVTJvOER5ZDVKQkhLNzNsL2RwYzY5SFpibUhZ?=
 =?utf-8?B?dWZxaWdMNHoyYVgybGVoRjVBT0xybjZkZTgvZ3hwVStzanRvZys0Z0Zoa1Vr?=
 =?utf-8?B?Q1FnaHBqdmIyMWRWdC9RVmhFT1J4MzBoVmtGcklNclRaVXlndXp0ZHNLdWFQ?=
 =?utf-8?B?VDVDZEROMmdOK2tWYjZnZDJNbGtuRVBPaTdRdDVuRkl4OWM0Vm1jNVQ0YVd0?=
 =?utf-8?B?eVdCRGFMNm0wT0xOWnhuTndyKzlYNmNnN2xhd1kzdXZNYlVpbG5mSlN5UVhW?=
 =?utf-8?B?bmxKeW15K1o0MkdSWVRMTkpaRWMyNVg1TVlQZktlS1gyaDdDMWM5em5FUWY4?=
 =?utf-8?B?VHQ0THg4d05COFBuUUFtTVVqVmJkM3pZYzJLWFlIR252TEQxdWtuQjVkZitj?=
 =?utf-8?B?eVhSdmRwWS8xeXdxeVEzcTU4eG9aV2JXQkdoRm9pTzAxZUhjNE9XNC9Jc3Fa?=
 =?utf-8?B?dTlvZzRDR0NCMTVZTXZ3dkdFWWFQQ0N6blExS1NWU3BWNkdYcHRWNi9wTDdu?=
 =?utf-8?B?YUVMSnlLOFUrMjZVNHFoT3RCbklmaFZwaWVvaXBFM1hONUdwYzl3d3Z5dENE?=
 =?utf-8?B?SnkybWRLRE0zZkNkQnl6RDFkK0duSVF2UVpyNFZYK2hBSjZQK3Jaa1I0c0VX?=
 =?utf-8?B?M0psQjBBMHFXcTVRL1RLUGZjZlJmbEhybHhiRVE5aGNPOGthS1d3OUhZc1p4?=
 =?utf-8?B?aUNKd242TGdrY2RpKzgxK1VIY05qWnpZRnZIcjdScHdwWVpWSEpDM05PcFIv?=
 =?utf-8?B?SVJZdFdxTlI5Unp1U2NJUEY1MXBsa3Jwc3ZEWDVobXdiU2tPWHBRNVM0bXB6?=
 =?utf-8?B?ZWhNTy9CeWlRM1FnRjFFOTJSc2p6R1ZwMk1IMTFOMldJZVpSYjJhRFlQYlBt?=
 =?utf-8?B?MHg0bnhKYkRVZjBhZnVjTG9SV001R05pY1RwM00xZlVlNk5icWN0eVRWVE1O?=
 =?utf-8?Q?6UV//OiNBuENoB+8=3D?=
X-Exchange-RoutingPolicyChecked: e0sWxhBZO4VwCPOx6qbIYeIq6EPC6smlym9xawNTIXx/FXwsWX6FXtgbPwhzp1MWmxMtWOErsmnVCPuEghd/JpUsSIHIV7/9ChrnjSU5VVwZ+3jTGsEoV4qgPijLvKo5UegJlqw3rLhnLr1cl4Ye5NEbA9MSSIG8V3gnK60PB7ahSktxjE9IgwJczhfkvbLwUu34eI0ScTDWYIVnCaEc5Puq75RqXO3MecBWx8f3MVVfA61S1CLwifHUKMIHXG+tnZSDKdqhVH8qfG6gOT2gIPQCfNgnIU5B+4y22ok1UndKjvGLEZPPoMq6odkGb7b+7+ZWR3YRlbyaP6lsudSv7A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6827bf87-f913-41d5-d8db-08df1e5505c4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 18:11:02.8999 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aHE+1RYJId+wfibI1rRMlbvfOsME94zQ+S6Dya/PVhaKgTOYZ9N/qtW7bOWPGVF+a1d9rF4apTV00oK/5Y6dFNnSdzFbDLl8hj2o8tAQuKs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8146
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



On 9/28/2026 12:14 AM, Linkui Xiao wrote:
> Hi,
> 
> Thanks for the review. Please find the missing information below.
> 
> - How the issue was discovered:
>    Found during manual code inspection of the ice VF setup/teardown 
> error paths. It was not reported by syzbot, a static analysis tool, or 
> an LLM scan, and was not hit in production.
> 
> - Whether the issue was actually triggered:
>    Not actually triggered. It is a theoretical error-path cleanup issue 
> found by inspection; no stack trace or error message was observed.
> 
> - Hardware tested:
>    Not tested on real hardware. The change was only compile-tested; no 
> affected Intel NIC/firmware test was performed.
> 
> The same applies to patch 2/2: it was also found by the same manual code 
> inspection, was not triggered at runtime, and was only compile-tested, 
> not tested on real hardware.
> 
> If a v3 is needed for other review reasons, I will include this 
> information in the commit messages.
> 
> Thanks,
> Linkui Xiao
> 
> On 2026/9/28 14:59, netdev-bot+sinfo@kernel.org wrote:
>> Hi!
>>
>> This is an automated message. This series looks like a fix, but its
>> commit messages seem to be missing some information:
>>
>>   - How the issue was discovered, e.g. hit in production, hit during
>>     development, syzbot report, manual code inspection, LLM or static
>>     analysis tool scan.
>>
>>   - Whether the issue was actually triggered, or is only theoretical
>>     (e.g. found by code inspection). If it was triggered please include
>>     the symptoms, like the stack trace or error messages.
>>
>>   - What hardware the change was tested on. For driver fixes please
>>     mention the device (and if relevant firmware version) used for
>>     testing, or say that the change was not tested on real hardware.
>>
>> Please do not repost the series just to address the above. Instead,
>> reply to this email with the missing information, so that reviewers
>> can take it into account. If the series needs another revision for
>> other reasons, please include the information in the commit messages
>> then.

Hi Jakub,

For patches that go through iwl-net, how did you want this handled? It 
says to not repost just to address the above, but since this will get 
submitted later, did you want the commit updated to make the latter 
check happy, did you want me to copy/paste the response to the commit, 
or something else?

Thanks,
Tony

>> The evaluation is done by an LLM so it may be wrong, if you think
>> that is the case please reply and explain.
> 

