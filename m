Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFE2606A32A
	for <intel-wired-lan@archiver.kernel.org>; Thu, 22 Oct 2026 18:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=KOQkDTAb;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=g9TpZhoQ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E9E6F6079B;
	Thu, 22 Oct 2026 18:19:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NUL-cMCmnghc; Thu, 22 Oct 2026 18:19:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5B30E6070C
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792693189;
	b=DaFRoAIxMNdLa1j+4tQ1b+xflZR7toQo20s9/fpNULiLNRP4lBQaBatrlobcpQFsOWcd
	 zUW0CShJJmMzQAE3pdPQqAlv6JQ7b2QWb5lJ7bYDgWMvf8wSkrw9ssEob2Uef4LBKz1uA
	 v22TnzoMEzctzCjV0AlHO+cIKqbmMchWEii5SfXzTBT+q2wdRUoCWe0r07LlKzafOXO9x
	 VFQuftTGLAABrFk/2VJr+T+PZHhQWn9IxLc003kNsl7S0LhvvTFJxfp/EF/u9Hhmgws3S
	 /Kd24geLqtvoQlS/GsGfeXlkvTFd/rcWWzW36z4GTUgF66FP2DZGFcnl1vdKzdpHIbA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792693189;
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
	bh=WQc+aIiJ7s8hgiGfMxXsehnerRuHRfXguO3PbQChDkY=;
	b=SANtr1o7LacfUjXeMU31stQ3eKltzNFHtbsGEpZS9UL/2ct0mrr0ZTLVbL6B8tFWa+pV
	 8EouwkCbTDhuw0PcrlJqsXu0CLstndF3c7xEpP6qQdQTJ00NMyrVowpO2GAuePrBN4Bgo
	 B2Vykse3WqISs4buYuJZqTtuyU3MCkVWkuq0uftND02EIKuWxQwBJf1yLb6yAh4Jcy2gm
	 s7bkBxtKvQYTqJRfcorNan6v3/qq+T/ZvjzbB7VOMUFxHWskLyhQkZVamVuGI8xNKvU9j
	 peXJpwZQXSLqKCLZ3m++QnvGuaUXBV4Jk/NneQGafPqjByvjttheA3f9piOlKwZ3cdA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792693189;
	bh=WQc+aIiJ7s8hgiGfMxXsehnerRuHRfXguO3PbQChDkY=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KOQkDTAbIHV9wVTv6w2I382FekqrPTG5b1XjPhI2BUXJu1k6cqhCUZ14DJnItLPQk
	 DCvHmyX7woARadlsQ7v/wJzhlbpkuOkmMSK7qe3bhnpAIpvU8ST2n5TIB9FTGJdLwu
	 6oQPEk6LmfXmv3sbi3SxfAq8cZzC4Wf3vn2xsvsm/EuATFukKh4v9pA9ozMUJ22AZU
	 NIEFUsV/KFJi12K3a9zPhyUwc5stCy54x+njbrQNh7bmaZ7ioC9YPkMYFS5+hW8yhK
	 1INPmB2i1P62ztc7MdYR7hrvD5WvF3o/wTJ3TM/vM0IjAms+rnBh/455xP8TZYjlgL
	 Hc9YRMpQbwlqg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5B30E6070C;
	Thu, 22 Oct 2026 18:19:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C5A97499
 for <intel-wired-lan@lists.osuosl.org>; Thu, 22 Oct 2026 18:19:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B716140998
 for <intel-wired-lan@lists.osuosl.org>; Thu, 22 Oct 2026 18:19:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2Nvkf_B4lbIZ for <intel-wired-lan@lists.osuosl.org>;
 Thu, 22 Oct 2026 18:19:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5A0F640578
Authentication-Results: smtp4.osuosl.org;
 arc=fail smtp.remote-ip=192.198.163.13
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792693186;
 b=Noz3cUgnTHyydLaWGFjhskcFYPa3x28NbbGW4/kHDjstrNUP2GEMJ9CrOJGBOKob8GRp
 nuuQEzerElDzxbxqQi2B5b64qFVZq504vU8wKzkoltgJT0GXRu0DPAm3HT7xpW5T1YpvW
 GTetjlclgGNryWGPd59ZFGjQ5BpMth+8wtJ5BvOJWi3aI2ogTT6D0PrIsUEbuLTWpc8iX
 oUWUq1mOxpWdBGME+trCZE11e0U3faVk6rYT5v9b8SgpLWgovmhFXKY6aAyzFQigyvp0D
 5XALyG0j1hhrWR8yfqQbTlwpQFrSA/8iDfAhlTfGjSSYl7rgdhmXSpPf1lZwewRKkxg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792693186;
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
 bh=WQc+aIiJ7s8hgiGfMxXsehnerRuHRfXguO3PbQChDkY=;
 b=q7kJ1WWbmsFiELZ2p5+T/dmppEva5YYvB2oZr48DvYcMkQqfQMwN1jxWjRDKxQ3+zfDB
 e5fJaWMqNr8997xBE8WRGYrQK6ESyNdWhGTKluusmOYrNy3Mrbyz1Mv5zJDwm7BdwdIX3
 qI7o5LCZ18/oQwHPDxs3Rn7gab4kKy2tFyaJShLJVUqarBFstZhNz8omE4h8nrvaF5inF
 OU2ZExL2ENI+zJdca/XZL1Kxc1HmpxFOiVc4UaEJA4Smv06dGZXk1SGieqPCBwZdliG78
 k3KoH9srX8C+UyLb/QzL4fLpVR6WLgElCi5KkO2jN3xjq8yacevzpcIdQ5rsA/7y7cQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=g9TpZhoQ; 
 arc=fail smtp.remote-ip=192.198.163.13
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.13;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=g9TpZhoQ
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5A0F640578
 for <intel-wired-lan@lists.osuosl.org>; Thu, 22 Oct 2026 18:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792693186; x=1824229186;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=xrZykq9yUYTWChJuuB3jArY1v4OfsCRgbs5pZRzXKRw=;
 b=g9TpZhoQUgA3CcAwKlRlqmAnYncwUvsunwmne2MGadDKjV028Z30xOie
 bFO44hFaMgGLfoxVmIW1J6alk0OgxZZhopjra8MSyZMP+5/3H0CsIpg75
 Bs4Wefw5HlvspHLD20HYQcdrDCk7jqbMCVv92gOFN5tPQMqUcn05tHWtD
 QvEm2GtVmKg8h80DKyvNssQ5b4mA7jE9SNOi2JGOFDzG9oDNZ6PAIKuak
 kJx9s9jNDJDHWjPkxroT2mYVUaEsl+wghPnJMBTm4jeFzfVuhXwqvAxip
 ohvMegrknDxKobcXaP9MvYTW6G7XWhFRN3r4Wb2EVqg/ro8jnkrdkRS8D A==;
X-CSE-ConnectionGUID: ub+ryH61Suunx8/RvRN3kw==
X-CSE-MsgGUID: k9p1AlFaTqqQIZ6RpVUVuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1438516"
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="1438516"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2026 11:19:45 -0700
X-CSE-ConnectionGUID: sSdsEXAqT9+Winc3k6XjnQ==
X-CSE-MsgGUID: 6zr+yn9/SDWMbIBOlwCp/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="3516847"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2026 11:19:45 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 11:19:44 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 22 Oct 2026 11:19:44 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.20) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 11:19:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=adIkT4f/W9Hf6X91K9IDRqYe+Lj8xpfH3Y7Bkb+01sSLbOFMTX+kabu0O2tamLOwGEqNt09wozgIvWB6lMdSji5MTvve5cSyBPxE1I6OOlSKTdjx9s7mA4vpfu2vWAuvNSEvdKxj0yFquWnOBom50MTXfhck7piDUBX2N+g55yi99eQF1MwhOOrbfOkgf29rrGiY5svrm5zuHIUUEQZMrdgps/DwHNCi+/tfvSoRo3nBwoR8UWs8gdDttpqbVMjlkdYLBOcyfBq+MJTvzoZ+dX8rF0Egm6VgDlwsWuvVdCwyzyWX0BpoCtUDnXo2xjQOI6AVXQC/49lKqOVB7q3YmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQc+aIiJ7s8hgiGfMxXsehnerRuHRfXguO3PbQChDkY=;
 b=E8zei+c+v3f20tNptcO68Xo88KxrGg5NaxwTgFIEBQwIk/pLvSofi/sZdLWTsy4Ea7dz0lNx5iloG36EyTAaInqdyILy2PxePLrSaOTGrvWZftjJ/qJnzl5x7C9XZ0d7ZNT+I9dA/bqd9DB+WRjeIqaIcW69rAxgcfQMThbmFecQry2rlUc3KMO4MeE7IyoxnCxk7MLROlh+LSSggX1yX18waALKQyFBnTJ+mNeWvBMfJjhz9g+5r7P48d6qRfoUUkR+Z24BrTSBZvuJxW2MDBvyh0cpYkxxaYIihV5qmUR4Pg7Tb/czC9zv1RRVtaCwfqe5bt3GYYbYX3FZlzbQYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by DS7PR11MB6125.namprd11.prod.outlook.com (2603:10b6:8:9f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 22 Oct
 2026 18:19:27 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 18:19:27 +0000
Message-ID: <1232046a-bd51-4dfb-9eac-720e1a943dbf@intel.com>
Date: Thu, 22 Oct 2026 11:19:24 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] ice: scope global configuration lock to the adapter
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Aaron Ma
 <aaron.ma@canonical.com>
CC: Dan Nowlin <dan.nowlin@intel.com>, Brett Creeley
 <brett.creeley@intel.com>, "moderated list:INTEL ETHERNET DRIVERS"
 <intel-wired-lan@lists.osuosl.org>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Richard Cochran <richardcochran@gmail.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
References: <20261019105155.3793063-1-aaron.ma@canonical.com>
 <20261019105155.3793063-4-aaron.ma@canonical.com>
 <ac4fb583-4721-48ec-bea5-ee4e7380f606@intel.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <ac4fb583-4721-48ec-bea5-ee4e7380f606@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0331.namprd03.prod.outlook.com
 (2603:10b6:303:dc::6) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|DS7PR11MB6125:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b7c600a-2450-4bce-3fd1-08df306901f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|7416014|261022105027099003|261022075727099003|56012099006|4143699003|11063799006|261009223027099003|18002099003|22082099003|10067099003|6133799003|261021121427099003|261021135927099003|261022113327099003|3023799007;
X-Microsoft-Antispam-Message-Info: 5yzU4HmM/m+mIIQ/Qlf+QocFOZwfj8n0MMeFNrEjfxfgAjXutxn8+EkHFypqZUrVNenXv4qN+TIFxdrv7xNLsMnYGakD0QamzcBlFOdmNyAwCf/V47hArK2PDH6Bi+nThR8QpSDNsjvWgU3W2BVCYdYhrM+hjPkD5U086Z9nV0S/8IhdYOOl4LeU5vXDHAsactY1Ur2/QQ7YhSzzPdBkvmiMSLlk7xsRZlyy2wWj/xW9U+j8DX3wSpYQO+yD6nyQ8jjTJK71MbgHUIGmYFQlJuHoPObe6Ri+zlIuMtNQAu7PqVWUdOIieRUObexh7m2MMaEDL83Sah2SBeoh4Fel3qW3BoubLTqyR/SjCWwGeifS2NroMFeFt1XDJMQwjbB263nqfZ5SHyD9mwe3yaBe3BcCFYLnK1lZrKr3FO7Vz9GRLQ/g+g1MhzqVGgXL42OHnr6TaYRMZqY4t7BBxdsbFvX/H5qFi6clIkeSfIlKPzSjG9uRY2zsOawKkY39Uul1cTrofSm+om1DKz2qCijXBTKL62yBhi9833KbTokfGjB5sP5CIiALIYk4Le6hKdCxrcyHHx8fxshLtubfHQ/p4pv/bnwu18s+IHuWKyc6MR3idWKYbjkp0YmdFSi085wy
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7381.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(7416014)(261022105027099003)(261022075727099003)(56012099006)(4143699003)(11063799006)(261009223027099003)(18002099003)(22082099003)(10067099003)(6133799003)(261021121427099003)(261021135927099003)(261022113327099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UU1DUzJTTWExTVdLdWJhbUpoQy9WL1oyZ0FhTUE1YzZNeW8xYWZrc2l1RWM4?=
 =?utf-8?B?clMvNkRlaVQxYzZsWWxMYUx2TWJFL05qV3ErRnEwWUxSN1o4d3NFVmdOT21w?=
 =?utf-8?B?QU5oQmVLdUNNTmlRdW5TOHBCMW5ZZVRpMHZydVBZaVpiSG43cjdGZXZTVVc4?=
 =?utf-8?B?WUs0Y1l1aThJZVZnTjVQQ1UyaHBaY2MyaEU1dFNGZTBCRzBTeW5zUlNEMlZy?=
 =?utf-8?B?MEY0akd4Ryt3WkwyaVo4a2dIVU5rUjVWQU9EWndWUC8zNGpiS3l6NTBHdlRJ?=
 =?utf-8?B?bld0QnlHeUhCT2J0ZlV0YVZJaTFsUUdHM0tkTVlEbzhDQU5KeFovOHJXbTJP?=
 =?utf-8?B?cWFwM0lXU0poVGR3TXJtRXg1T1Mzb09XZ0Z2RTBxU3o5cEpwNW9qNXQyQm1x?=
 =?utf-8?B?VzNhK2ZvblBNZjg1UW8wLzlrVmtEWXcycGZPdllUSkZ6Tm5GQnByTzZ2QjJI?=
 =?utf-8?B?TnkzOE42U0JZY3dqZzh2QXdRRTQ5bDFST2tlams0cXNta1dSOExHQXlOUnBX?=
 =?utf-8?B?V0VnSTN2U21mVkxxNzRUSFFjWUdod1g2Nit3bCtxbjdQKzJCUHVIclp1bTlC?=
 =?utf-8?B?NDhnNmhUMmhWNERTcDdKMnhKS2F4ZjIzTEQ5QitYK0g4cWVoVXRaQ2FrYkIw?=
 =?utf-8?B?cUJqaW51Wk5wbk1qOWpKaGxqT2crazFaS1g5eVRiNEdydFZ5djBmSVVoRmRn?=
 =?utf-8?B?T3VQdnJsaGt3cnUwc3k2M25LeVdRdllWMnhCT0J0UVVRYkcvR1hkV243ZXJK?=
 =?utf-8?B?Y091VUJBQzBuL24yNEpsdVJoMGtWd1B3U2U2alJCWUlzQWtnNEJRazhYdm9K?=
 =?utf-8?B?T0MxN0gxTHBFQU5kdExuOUxnTUZKem9EY0hsQUtydHRkQXFzMGZxSEU1YVNK?=
 =?utf-8?B?cWQxR0pqT2grckl1SzBzVnpURForcmZTQkdKWUlNa1lJQmFoSXkxOURwYllq?=
 =?utf-8?B?ZzI2Tjg0aXMzdnF2WXdvbkQzbkJZbkVsVGZTYk1INGQ2VXdpaS9KTndFVkdD?=
 =?utf-8?B?N1BVUk5KaThPMXVMSHV4RUVUenNIaUZEQjlzSmU0TkZiaFdCSEp2NlJ0ZFVS?=
 =?utf-8?B?aFFoYUNTTlpQVXJGTGtYdjI4MndYRHZJa2RlK2xOY3hKNHBRNFBEYXo5OEk5?=
 =?utf-8?B?VEJjbUZxc3pOR0NISnFJT3Vkbis0SC9JZ0hienFSUThxSlJuNkVrRVRLMENV?=
 =?utf-8?B?UmNwdUVwcTFOdk01NGoyb204OGFjdU5NZWdjNkFQTmp1eHJDcUxRVTIxeHFE?=
 =?utf-8?B?WG96Tm4zTThKeEcyL2RXeWVlZlluVk9iYUF1aExCNG03LzcvUWhiZmtqVzIz?=
 =?utf-8?B?aWRmTDljdE9uZHFlWHN4dzVkRk1oTWNrM1RZb2FMZmZQQVRnVmdWdWpFMVpt?=
 =?utf-8?B?aU14WjBzUWtrZFpSMXdkaTJHb2o0WTdxdTBtWFd0L1VIOTIwYzBzUTUzZkxO?=
 =?utf-8?B?MVlwZnhrL2t2MlBBL3RKdW1paDJCSlo5ZlNWM1EwZU1NcUN3YTJBb0VNLzZF?=
 =?utf-8?B?VGNtYnlTSXBkY2syM3ZYeVp1QzFZa3hnUFM2dkhWb2ZlTis0eW9nTUJXb04x?=
 =?utf-8?B?eUNyUWxyTFE0M3dwVFV4Q2VFK1FiUW44SWVpZXZXTHRlZHNoSGs1eVBHWmxz?=
 =?utf-8?B?elYyQUtSSGM4Vms0Q3hPdGp1R0RiY0NETi9LWXRYNnEzZW9iM1hya2Rjb3hZ?=
 =?utf-8?B?WmJ5WWVyL2FvakVYWkQyUGFqM1NkOHNQWEpQb0hhU0l3dUs0eUFiZHRQLytS?=
 =?utf-8?B?QXhtbXBlb3ZvMkltZGgxOG5vYVZzME5uV0U2bkVhRDEwY09IZ25lc0Y4RUNv?=
 =?utf-8?B?T3NneXIyMW9HclRhdkgvSXRYNkZjOGVpbjEycVhibzNsUU9QczRaT3dwMHJV?=
 =?utf-8?B?RzFuZjFSdzhqZDB5aHFWK1NIUXhYTlNLS3lmbEJyMisyWWM3UStwZVlMTXFY?=
 =?utf-8?B?K0pzZjVaS1NDZ1hRdEFUV0wwSzV6VWQvR3V3KzdiSzdnakJQeHNxTFhTa2N3?=
 =?utf-8?B?eEk0bTRralErTlZ3dFBQM2d4M0NmbUpRalpSVXJ6NWUvK1lQL2VHRFA1RDBU?=
 =?utf-8?B?M2NHcy8xemgyRVhadG5jTDZNeHg0aU5WZG9pNDFqZm56Z3hkaFNmZGNFek1S?=
 =?utf-8?B?WWV4ZlNuczRZWWtQSXA2RFMwV2p4S3NOekwybXg2aFJUOGYvRmN1NmViMG93?=
 =?utf-8?B?MnRqQzl6bi9JOEpnTjNXMlN2STdaK2wzTURHWUg2R3p1VmFvcDB6eWtVQUc5?=
 =?utf-8?B?d2YxYno0Zkt5YUdoVzIzQXg0YlF2RTdUZnVxdXYrM2plUEhUaTYzajV0Zk9R?=
 =?utf-8?B?QitkMEhFQm5KOGJzdkJPSnZENmRBZHV5RG5PV3ZtV3VMbFNBelZybzZMTjN3?=
 =?utf-8?Q?Cl758xc64Xf55iWA=3D?=
X-Exchange-RoutingPolicyChecked: FwvsRM8YM+xgRa6N1ul+YPj6VzB7yAjZt0K3mYr9z7/No5y/TZkCy+AlTiAfySqs3QGLgF3DdZ/nsUEUx8bVxPn9vnd5/HWsGR4k5f6POTM/9RnO5+Od0VocqawIJ+QR9mMSYfTypIH9LjkQ3E6Ozl7TUNLdvnG/F8mpraaQDrNbOxzvIKE9b9sRoo/SsAdbjB52NODQeIV0fELLxxmWON31BLaQbhU1B9GezYOKgCkwjbPCJyOltj4e0/eGBfijnGibaWU60YbO6bAeScGYMUUR9rWaPTvuwPFwQ/1ITLPF+WY54SdMOrJGE1qlF+P8IL67FRpFxapN6pfKMN3KYQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b7c600a-2450-4bce-3fd1-08df306901f5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 18:19:27.4428 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vwtmq2R/wWtiCojp6lUU/Afdi8xR1NfowqR9WgcxKDEPkcfw08gLATsZfTU1N2ieU79+Fl4O/suOnZEmPXsZ5sveOddmep8DU+Fak7gWPMo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6125
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/22/2026 4:10 AM, Przemek Kitszel wrote:
> On 10/19/26 12:51 PM, Aaron Ma wrote:
>> ice_global_cfg_lock_sw is a module-global mutex, so a package download
>> on one E810 adapter blocks Admin Queue commands on unrelated adapters in
>> the same system. In addition, the mutex is acquired only after firmware
>> grants the Global Configuration Lock and dropped before firmware
>> releases it, while the opcode exemption list in ice_aq_send_cmd() does
>> not check whether the caller is the lock owner. Non-owning PFs on the
>> same adapter can therefore submit exempted Admin Queue commands or
>> sideband requests while another PF holds firmware ownership.
> 
> This is not a bug to allow exempted commands, does not matter from which
> PF.
> 

Its not strictly a "bug" but I do think it makes sense to only allow a
single PF to send the set of configuration commands.

>>
>> Move the software mutex to struct ice_adapter and record the owning task
>> across the entire Global Configuration Lock acquisition and release
>> sequence, including the core reset path in ice_cfg_tx_topo(). In
> 
> this is fine,
> would be better to not track mutex holder
> 

Yea. I'm struggling to understand what the reason we need to track the
owning task vs just having the lock.

>> ice_aq_send_cmd(), require non-owning tasks to wait on the adapter mutex
>> while allowing the owning task to issue the permitted configuration
>> commands. 
> 
> 
>> Route the Admin Queue fallback in ice_sbq_send_cmd() through
>> ice_aq_send_cmd() as well.
> 
> perhaps this should be separate commit?
> 

That might make it easier to review.. OTOH we also have been limited in
how many patches we can get merged, so I could see the pressure for
reducing the number where it reasonably makes sense...

>>
>> This patch depends on the previous patch in this series.
>>
>> Fixes: c76488109616 ("ice: Implement Dynamic Device Personalization
>> (DDP) download")
>> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> 
> 
>> @@ -1895,17 +1894,24 @@ ice_aq_send_cmd(struct ice_hw *hw, struct
>> libie_aq_desc *desc, void *buf,
>>           u16 buf_size, struct ice_sq_cd *cd)
>>   {
>>       struct libie_aqc_req_res *cmd = libie_aq_raw(desc);
>> -    bool lock_acquired = false;
>> -    int status;
>> +    struct ice_pf *pf = hw->back;
>> +    struct ice_adapter *adapter = pf->adapter;
> 
> RCT violation
> 
>> +
>> +    if (READ_ONCE(adapter->global_cfg_owner) != current) {
>> +        guard(mutex)(&adapter->global_cfg_lock);
> 
> no guard()()
> especially here scoped_guard() fits nicely
> 

Yes. guard() is not well liked by the maintainers, and I believe
recently they have strengthened their preference against its use, but
its at least documented as discouraged:

https://lore.kernel.org/netdev/20240829152025.3203577-1-kuba@kernel.org/

I thought recently there were some high profile issues caused by __free
and/or guard() that strengthened this to a hard no but I can't find the
emails.

Please stick to scoped_guard or regular bare lock/unlock where
scoped_guard does not provide much benefit.
