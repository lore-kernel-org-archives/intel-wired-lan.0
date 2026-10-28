Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2677606A329
	for <intel-wired-lan@archiver.kernel.org>; Wed, 28 Oct 2026 11:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=VlZjus/t;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kI1rHfZZ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ACFAF80E79;
	Wed, 28 Oct 2026 11:09:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RZAj0vli3mZ4; Wed, 28 Oct 2026 11:09:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C606D80C76
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793185753;
	b=JM0wBkzcneXq6QNk5DeW6UZo4PLh+qkmTBuoFTd77crM1D+qGREbS2lRl+J8ERZYxYQl
	 RhI9A7Pd89xOZdHCOvXbIt9SPh8LvU4fWgdoKKAKzmAmQNPjlrwfe9dSVu1fHzTnfNT4t
	 g5Z++IbNSrkTcJePZXAxk6iDSjXq7YVrB8L/w+ZObPOoatpgC1uq4/pH9mBL9qLZX/BUi
	 o5K9rfcVsxG3iWkNrpnVgLC1T/qmIhcn0wh7e+l9+H0kPoCJBqRkDIZqtciebikNkJJ68
	 yj3PWr7iU7TdXG3ZI36HR8ln1BzAndW/Z5o49J9BymKIP5Ktjp630kOPyFRZxcFDoBw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793185753;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:Received:Received:
	 Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
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
	bh=6PD7tb8VYR4og3ubdSCjm3CpYB7Oa1u4CeePMjqVi6U=;
	b=QiCYlh3Qe49z8eTOG+sgcoqkHeFbKXQua4r6Jzuk4tnMpoR8SwkaSg0u4vIOnIhvw3wC
	 WwLeND9pzeKIwkORaSmJvxDOvYCPO1LaTdDli+FtM1eJdgCXPEj2mo0LeaBcaKAc8rlhw
	 wDqZZd0mypPa0KoCZsT+/mAynGV809gL8p6VQC7U9soRn038XKFYs8Vrz/cg+ilN799hx
	 HgrmXQ0qFCkTcWNC39DdQsc2nqhg/eTZGljzNCqU3tBM17z6dAd4BZGIn4If5stWca5wU
	 gwS8DvwIwwMBOCh55Bo8D6Q094GhY+aLXoJJfmu7D+OCwTJO6jM9EVjx8SiAOybYKSA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kI1rHfZZ;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793185753;
	bh=6PD7tb8VYR4og3ubdSCjm3CpYB7Oa1u4CeePMjqVi6U=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VlZjus/t8vb1a3lZKI/elyWs/nG1y7eplsIsI3kmFw1b9+9uEU42dYYyOWY0gbkFM
	 jrolvAA/C1wKuLVKTJXA0IHRK/pk1DTrAAONnQBnq7X+/LbNbpMcneK21Ml6OdVTJL
	 vAG2pHCVatGkCV2xNrXrcCbxSPjY8+Qycu/k8xjQzw2M8SlL9anm1/L53wRIGvtxUP
	 8QiaGfawEXAiUdpp6hbg6wCNJ6JfDbqxKzwAGJRsX/SAXlJzltFh2oBVi37ZihHWn2
	 TeJFO9ufo/B1mrr2cv04voqLbnLJA4tu+CivuqKeP9KoCQuKO6fQVh9AKfr9ScvQCh
	 LU5HBbA1GTmvA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C606D80C76;
	Wed, 28 Oct 2026 11:09:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B83F3D1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Oct 2026 11:09:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9B1C980C76
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Oct 2026 11:09:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZaeuY5i0vLDL for <intel-wired-lan@lists.osuosl.org>;
 Wed, 28 Oct 2026 11:09:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8E87A80BA6
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=192.198.163.8
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793185751;
 b=IaTHWctEi9j8YEnKTdFZtkXC8XUGGV6t/tVYZPo7kQR8DO/R1lk/R8WhYVuWTraeJu/w
 EtGaExGNlCbfxonbFUXiVOfB4Dtatp/RnInWtvrMtLPDs7dD6P1LKAqJQw4OAjtpUWRG4
 60PWJKt91ofyjbbj/XC8vaxFYUobaDLFFx1PLzgLbijEd7EdH7kdPZZMIjhOKdcUNny3U
 kzl1cysg6l4aPCMa4ySQkioFOWaIEgCZR2Gplc2/GcSqNjxOChGWYqbMADL2c3RoCJdNZ
 wsIJ3fI7UHIoCTo+AE/ogEBYtK4g+3FmK1omaf07EcIXvzD+QAS8rhtiD3JbuK1XFoA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793185751;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
 References:Content-Type:Content-Disposition:Content-Transfer-Encoding:
 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 bh=6PD7tb8VYR4og3ubdSCjm3CpYB7Oa1u4CeePMjqVi6U=;
 b=m4UWH+fjD8uewBYi3qDf6P/kPumcBqXx4fTNM9zpOb5bTD5DwgoQWVNiwK6F2x1u/da/
 9OxLNcj9R3/+kiao4Id5y7Dt8yWERXmsbhbJvlN9BkLMb70iS5T7HD9IQl3DzzIN8gtLP
 O0RMhRpAKESmMvNFoVROr9ZMvvqEocPt0nmZ1SdTFPgmS1fYcWoKRDf1KvOi+1Bv9VZ7w
 9Wi/2OAALsJ//4c0csiSwq0di9mHS37QMyOgXG1Og4CAbLQzJtX933jLJovWe27jdhsuy
 8ha+wuMcVzfI4REse3lajaqFE4ku8UVUyb3bOYBNXWlHOnqPPuJSUGLsX76SbcsehsQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=kI1rHfZZ; 
 arc=fail smtp.remote-ip=192.198.163.8
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.8;
 helo=mgamail.intel.com; envelope-from=maciej.fijalkowski@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=kI1rHfZZ
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8E87A80BA6
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Oct 2026 11:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793185752; x=1824721752;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=xCd65ZRLvtmcM8c8qZybZNVhlhGUMKQTOtvyyCJw3yM=;
 b=kI1rHfZZpvY5HH4/R5i7uj1uoM/CckKFfAHlY5iXXQwJgYdUJYC3PIkP
 j7ge5fFBLJ4N8V+0IeqM/6kEsYFsk9afjhtaCR5UKpQvq/ykYt3qgrc+t
 eJx/8tC3ulEBqH4s4qLUuhIkr/igk0zz4Auzoge78OnZm4M3YDB/QYyKo
 5+GHQ0/is2HRYvFLlGxaNDy3zRGdc0sRGTdUv2DMX55+b2lhNlSxx+fG8
 UCdf0LwhSNqCp09PoAePm2phMe9NhYDLdQoFnmPoXTfTeItTjJGsrFece
 E9KJMiDBhYBDTQUj+WAJJNyN10QQR+Bwp0Py4k9bYZ2eLyJh/jd7ISl7J A==;
X-CSE-ConnectionGUID: emW/6IeyTTi0A65Fj37etw==
X-CSE-MsgGUID: 1nMXUIyzRMOU+ycNxdBG9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1795174"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1795174"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2026 04:09:11 -0700
X-CSE-ConnectionGUID: neXZsLDUR0C8uA9nrd4Tew==
X-CSE-MsgGUID: Ec6zCP1vS9WS1cl8HQe2Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="4845345"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2026 04:09:10 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 28 Oct 2026 04:09:10 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 28 Oct 2026 04:09:10 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.62)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 28 Oct 2026 04:09:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AghKL0JzXZwf2odGD6ZArYdk0pUt9+s8Ofo4+NNrf0lTLh9Gu4qlmJQ7I6YM03dA6gZAbVMYnroWSDZV+PDEVizJ8kftl0K7HeGoavKx1taCi1rGcoRIAOoni4mDT4OX76PBImF+6SKS1a3hdt5FteLt4kK6le9oB87xae6udbYZ1aTZ/sNaINWFYKBO+iw6Cen1jkB8Tus5nDkicPrYEVAPb5Hgto4zH8AaivRswPfBXYiUJVTUzMdF6/s2Ul1FW3YKFh/n/gqkcCeAdXsbbBxZrWgT7aSRerzQ3+8NSlMqE5j90mvQPrV2OpluUrpgrU5iRnB7LZkTwK+IdJWmpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2hXH2DN/nHMjZWMb7syCov5lrUpgv7mPTFPSxEEXzpc=;
 b=FTRHM/n+XyRWSAPiFZdWFELu2Phlht1Cw3lAGuTQlEscZHxfbBqRHXjj8j8v8cyLmPZsZGf6kF4C9iaID3uPeB4H3PMN61Y9Smm8nrYdt89d3VvjrhvnmaSMNBo8hHDAfjHAjory5TkwuNzhPqObCn+24+hfImcw/rh5EZD7QYvslByEYjhHVLhZnPqReqpQFOK4MVu8Zx4BAOQxMztIzWAXNjB3WEzvdMYbKhuuvmEsESUJp/DVhB6nUVON7sCsSssmDV1AGcnSZ4m14jfwf6KpmOHh0+k2wDPcUakthvYp8Mre6ZuUTWe0OmyDnCwSj0fXbD+yjiP+9/n2ZXhilA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13) by DS6PR11MB943645.namprd11.prod.outlook.com
 (2603:10b6:8:499::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 11:09:07 +0000
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de]) by LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de%4]) with mapi id 15.21.0569.007; Wed, 28 Oct 2026
 11:09:07 +0000
Date: Wed, 28 Oct 2026 12:08:56 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Marcin Knap <Marcin.Knap@vecima.com>
CC: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>, Magnus Karlsson
 <magnus.karlsson@gmail.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Magnus Karlsson <magnus.karlsson@intel.com>, "Stanislav
 Fomichev" <sdf@fomichev.me>, Simon Horman <horms@kernel.org>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 "Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, "jtollet@cisco.com" <jtollet@cisco.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf] xsk: Do not free ZC Rx buffer when the Rx ring is full
Message-ID: <auHXyG7M0UGtia+j@boxer>
References: <20261019-xsk-zc-rx-double-free-v1-1-2aa19f6628fb@vecima.com>
 <ataHK9s/MpNgXWhT@boxer>
 <CAJ8uoz38cE-1diOnih=HYW+ACqq9YQhaM7tz8KCHjTxgZVc+rQ@mail.gmail.com>
 <DS4PPFFD8A841C2AC917618A9B1B19453C480672@DS4PPFFD8A841C2.namprd18.prod.outlook.com>
 <atddQ8qN/R1tU1fk@boxer>
 <DS4PPFFD8A841C22E2663DBBA3A1B4F581E80672@DS4PPFFD8A841C2.namprd18.prod.outlook.com>
 <87ld7r6xqh.fsf@all.your.base.are.belong.to.us>
 <DS4PPFFD8A841C2FF8203BAD3C773A7784D806F2@DS4PPFFD8A841C2.namprd18.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DS4PPFFD8A841C2FF8203BAD3C773A7784D806F2@DS4PPFFD8A841C2.namprd18.prod.outlook.com>
X-ClientProxiedBy: DB9PR01CA0024.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::29) To LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR11MB868673:EE_|DS6PR11MB943645:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f35ad3e-1eaa-4c85-7945-08df34e3e2c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|23010399003|11063799006|56012099006|4143699003|261009223027099003|10067099003|261026121527099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 2Je5J2LcrOYz5euiMpru6JCO/J2nsn18yfLucA2xtQa10YMprO742uYUKV3foDk6c9ZdZ+kAiGOV6ZPUHjIzjAwz/j28pl3SQ/8T4ZKo45LuS2y6dbdS7YW9FEyBSfhWPWqiCj7/RDFCR0CratUNBlKV8JCQNHZoqAUb/zeZ5PKFO6t8hWrwR+ebvJPDoIwnADwWQ/iu5W2ia/ede01fk2EjNwf+K0a3Xh983UgOyDH3LPJrZ9pdhaM9voCinfVEcn19pmyKyg9naGtcDkoaqVfn0smxwvZasIhee48wqUs+53WNTYVR/awVwrEpeCFVCLgR8yJvOl4vihk56xi+qR1SGiAUcW1PsvjC5z6NSkLXFTi177GHlFDcFixtt23Fy9zF3MeMTuGF0wHG4PvqmQMQhHz5xxMZc9uYvnmNQCHzjuGiiOzjHtiirVUPRoW98Hhad7F+mtVtoBawkD4TMu6inSxeFGTSXabM31MIVnprx8XGb3ZxFnChsA26qQ3yEi/q3bT8UzFsvRfl6d+uDhVRi9g8muJAUEAKkpB8U/HsrggpesyGw+rMjDHTKBpiVAkEz3+tvGPbNKbIRQJ9rd6RoQEjhrsPzbMCUOTop+/5y0k22mM0UzJTMGJduffu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR11MB868673.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(11063799006)(56012099006)(4143699003)(261009223027099003)(10067099003)(261026121527099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?mv5D5wlsdHiRQ3dMtZs+8ZosC93YvwZLf/kiu21EKxjoDYodbB1YOQJRFl?=
 =?iso-8859-1?Q?M//F1XzAPGYzuWE3uq8h5owEUfR5JEuYX8i9aqx5Hphkyhr2vRUGH105x6?=
 =?iso-8859-1?Q?cz1K8Ti4xysyNFaa0Q83gFjMnZzvMdVQCIlllXGklyRxhF1JYtMzIcolpI?=
 =?iso-8859-1?Q?pzFWJ3h7gMmqysXETZNa9j8J1PfmICZdh3BNx8xQwLyKeYUUyTZuVJERST?=
 =?iso-8859-1?Q?0DegA1qCTNrXZa7CCuhsNJNNJOEDoehAoH9ilquCX4oJxvl8gQyiGH0lyj?=
 =?iso-8859-1?Q?eAXPNgNA7L9OKOTNEwPOtbE9P2Tb5XAle7/1gMoQGv3eOFM7YU8ea6HVGo?=
 =?iso-8859-1?Q?U5a4VdQJ/VidettmkOzM+/0798VcMpYDeqwzjmtkog9hs3R9e5f+TwnMxd?=
 =?iso-8859-1?Q?mVSqwom+4qmplFf8fgtdbEK7JcztwC4asgAgzuEMqWj88ZQ/bph2N+lsbg?=
 =?iso-8859-1?Q?4A7CSZymjqxKaQxDO0SlsL6jOS3P+E8OAeU/ukwTy8HZ9qPXq83fY1y/FK?=
 =?iso-8859-1?Q?VCZ6Gad8KJsXr01T/dh7VAyg63IoUYCVyHt0kfKM7VAkLvL3clHHzfNyGF?=
 =?iso-8859-1?Q?Jfv6iie9gi+tZu78yYdT8lXVtFGb2dbg/ElvX/XqSGmgQVmVCcBKeRGTmg?=
 =?iso-8859-1?Q?Sn7stb9AuGAi/QmPj3oJ1kUWprvONyw4cPqmGNoQ9xvBxItL9Y4DDYFqUj?=
 =?iso-8859-1?Q?EaHxH+DPA+O6q35wxslQfYaXgJT5N9TpVZpM2UAuz9dKM7p5jaDQqtIOZp?=
 =?iso-8859-1?Q?bMTWGVgT+Sqn9kYrcjMDivarE77AuI5jKBRuF8b8jFNWv6QY97+bcgySb3?=
 =?iso-8859-1?Q?mAi+lItx4v7EVbAgswGtP6I5yAx0grk7gtfdrZhBtgfbAXl2hhPqB6Yfyz?=
 =?iso-8859-1?Q?E6rBKAm2kv7AbLfcLUbOjQWd7BTa2+yYtIBVQAWJlUoYEl+C3xhZGLYnQK?=
 =?iso-8859-1?Q?ylf+BAdvVStuwQ3tb9V9kCgst5T1eMgCieHSkNvq6MZZRdobg1OTe3102M?=
 =?iso-8859-1?Q?B7OBV7ym0blpDZVrIhRo1FOBHbkuZmdrlChgzTocizTktp5ARczQQW4ePT?=
 =?iso-8859-1?Q?hZ3eJnN+evVaAn+R5mChZlGn3hCwFHKzdmadNQrnr4qxc6mm5ohK6NCTDV?=
 =?iso-8859-1?Q?JT1bIxyvxLgsiLjvowSoO9UXrlBuRJthyFGE9n0oCRevtUfSs7i1Rh67kW?=
 =?iso-8859-1?Q?E6QGeyU9yvYblSUQrNSVvVzlIdTojeEsEoSGvjtdHru8L+bC1hU8j/cayJ?=
 =?iso-8859-1?Q?Cwg3EJrr+EAqcsT8/Gp0uVdg530U7nBg989vWntBpXi7QfRdecS0dZ0fWN?=
 =?iso-8859-1?Q?7lnrUkxAZNkfTfJoRQRKmu5ab9bVuRuknJPzu/FkbKpQePOEIqf1AVPj5M?=
 =?iso-8859-1?Q?gGoilqpE7c/OZX1zVuv4O+DCyk21Zz5fNS6fQduwlVr/07MQRIcFVmqUwY?=
 =?iso-8859-1?Q?R4f4SiHWT39gEY2L8v+0HMGvW4j3Wq0Nu9WWdIkYnx6NDqxmG6vaK2RN9r?=
 =?iso-8859-1?Q?fzMusIPrkMCXdUnRz+atGf5mRM+UbiZgaFuFhm6kAsCOz8DkcUOg3DjdTC?=
 =?iso-8859-1?Q?TnlPglryGy7QqczQqNNL2RHPyclkprt+5tZNbrkKFWc/KRZCz+7ZICu1ec?=
 =?iso-8859-1?Q?ldHW3mIE6QuMOsRuqLPB14gZZHGK+l23kVcN4IfjzfpLt1RdUj4DIZzyTw?=
 =?iso-8859-1?Q?t9oKDPjhKWag5jqJGyIlT5hqO95kFpTZ7Jl5bmhy8yNHXdIixZcXKJOX/O?=
 =?iso-8859-1?Q?1Olsdx/efkm7NMy6JwQEEP0fiABlGDfnpaSX6F32F8R+6oM1GGl6kZS/WI?=
 =?iso-8859-1?Q?OywpuMiyYWMNgE96wyMWpdhTuHl8pB8=3D?=
X-Exchange-RoutingPolicyChecked: Gk5MG3RnfyVAGHQ/Ty1pvw+9TUAEYkETT4mdhFQiArpjCaww5qBpCVjwNbzpG4B0OrG5pW5AGsKLBhp674qIuwieR1B3+qFqn3YpNiixzAUyb95U3dKazwMjDsf2zrBYlnzp9pEiRIy+emfF9IJXxHl5M1q4K9+9f9fQtQbl9Hc72qxNSrH8mtkFszqDqpSZyX8VGSZxUF0b7k2DOuzUPGygOPKQQM61Ba9c8GSCOzw9brwuMVFK6p2vUgldWb8gJq1TsCoSpJEj3UPnerCDDlmKagQ2GJTg7rI/Bima6zKKeKes5sMjvf7d5Z0N/wrSHPH5OoJ/EgEWtNRV9ezmZg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f35ad3e-1eaa-4c85-7945-08df34e3e2c7
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB868673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 11:09:07.7823 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ib2bsS6mMeIjMBkqtz6BQBXOC3s1nATu3jFyMOXqIdPbz06nOjpWWhrPcBO0yiAGYgf7WtyxQnKZMdPQGWjt/5RcLRqTABsUtQFrxrExVko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB943645
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28, 2026 at 08:40:06AM +0000, Marcin Knap wrote:
> > Marcin, FWIW, we'll discuss this topic on the office hours today [1].
> > Feel free to join! I added a link with suggested wording for a future
> > doc [2], and asked an LLM to audit the drivers [3].
> 
> > Björn
> 
> > [1] https://lore.kernel.org/netdev/aqPxxX9MeGmAqGy6@boxer/
> > [2] https://gist.github.com/fb-bjorn/d6835c49650bc3433b427a9c9708fbe2
> > [3] https://gist.github.com/fb-bjorn/181786547c4dd8182ba09e23cf394dbe
> 
> Sorry, for late answer, I couldn't join last week, I can join today if needed.
> I saw your audit which is very descriptive, that helps with understanding it.
> Thanks! As I understand you would like to fix the drivers ,which broke 
> the R2 handling considering RX Ring Full rule.
> I can send fix proposal for mlx5 driver. if so should I create another patch
> from scratch and link that conversation only?

I believe we agreed on making drivers responsible for releasing buff, so
full audit requires addressing existing -ENOBUFS-aware drivers (intel),
removing release from core and then teach rest of the drivers to handle
-ENOBUFS properly.

Basically this is what you initially proposed but with bigger driver
scope, but maybe for now stick to addressing drivers that Sashiko pointed
out (gve?).

Bjorn might be OoO today but this is what I had in my mind after the
meeting, without revisiting the links.

> 
> Regards,
> Marcin 
