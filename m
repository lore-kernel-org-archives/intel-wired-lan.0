Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937D8606A32A
	for <intel-wired-lan@archiver.kernel.org>; Mon, 19 Oct 2026 21:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=23XtU56k;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jmLLiPr6
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 672536075B;
	Mon, 19 Oct 2026 21:10:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lZbhGkiTSrnl; Mon, 19 Oct 2026 21:10:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6225460756
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792444225;
	b=aS2FCGMwMmyXo9ikSog2cl8osblPrVyr5DNTRa2tSjN0pCPfkF3CxmoL+L2TzQNAxaP8
	 OwErew/yM87fxSa2Iydny+vnmyn6mxGsPfxdKNJm1Ojq5ufSQOmpOdpPL6pozxlL8vdsY
	 70JYGHIKj9MvBFvAKdjYIqzm57fRgEGz1g27+uhmjqmXra4Bf+N5Q3ugB9LqY8DtR/jXL
	 D1a4nMI22nzCb6Jn9kBf8bg+yep2Ts1db8MXpZgbWLs5HogvE7UtQaHQEQbqy0LjboaZe
	 4F3X15n+5SBYJZKnTV8dzLZcR1rBe4chbimuaVknCf8yAPLY8xSzCv2KAaOiptBFJSg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792444225;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:Received:Received:
	 Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=qvWPtQmajTjIK0k0n0hxpjvn4eGZxNY6946G0uWEQr8=;
	b=RCdA/VgS77841zS/YJ/Wno9g3+GPaFRMBjQh8NtdbLM0hWKIGHiopoWtMhxkdtLpNGZy
	 FJWhCsq380grVVeOV2XXf8DeI0PgsOsP9atDaXrT+k02RmT7/g+rYeWjKQENtnvQsPsiW
	 JLN+fr8OFZI1DCwduUngDGCVdmivUwIki7Rax5pk1lvOGIgvHuS4cYqsnWlS6iMiv/U1D
	 pOGGzjks1onDTex/qYzLVxVPLNoynkobGvUKSSz2xLbJgPnInjSA+MD9eQtGhK+A0I6hB
	 BKd7rCtELmPtYieQq6KkkbnwEz/YRLVgMk2JIUwPe4G2O3WHq8jOXvUjFcYpy5ZRg4A==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792444225;
	bh=qvWPtQmajTjIK0k0n0hxpjvn4eGZxNY6946G0uWEQr8=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=23XtU56kJeFXGKfCYEha1bpw4DavYNpNoFW5Qy9t7B7Ja28grpaKDzlm7uWp8HrZc
	 r/Hg/YnJ6VxpLMQJ4LI35QpFevlp0Y23NytdHRqbKjwDkHtOTCRuzjswRudA++uXD/
	 Mf+b5lqloPVfpULjQoSnLZw1KGrhvuOPFuCEnwc1srjPBtCeoRpuq6q6gXlsJ4lX8M
	 gwEDzbHL6k0gxOLyhPjg2stY6w6NXu1gfp0XexRJrdZ5GNkidEKjTDXYYFrxOEmrQ8
	 /6otSDzOU+wubR0kTNwKuoJXx7LMDevo9pqAnytSwMsZjgsAjXZnYarfM8tCuznQpX
	 s6EYabZ7+WDqQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6225460756;
	Mon, 19 Oct 2026 21:10:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 909FF23F
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 21:10:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7667E4009D
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 21:10:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 941OSbU8fwpv for <intel-wired-lan@lists.osuosl.org>;
 Mon, 19 Oct 2026 21:10:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org EB6FF4008C
Authentication-Results: smtp2.osuosl.org; arc=fail smtp.remote-ip=198.175.65.12
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792444223;
 b=o8nj3Oduy6CLEn1hkwPgb9jhbgI4+4gfsCSg/No+PGzq8siOEMzP4JVUPbkF+URm6aNj
 d8o9v9CTXV4q9bNgDBNd80t3oJB0lP0+bUhAWkmB/lwkAMscJiSFnKAONfCUzru892L+2
 pom7J8NXWLhRm74AQrKuvDxlHqHK2yCif1xbHD8zKw+yXpfe7PAXuNe9E+oZpGgJqx0qE
 w3vZ6GrLq5VIH1h6srUPmo4Q83b5eXYluhusozT7I0Gb6vl0Mzoq+MFUJ6QiQE6IpFwBW
 J991tbQzpdSVw3a4iQWhmmOaKh6bem1umdhq7MhxiUvv0oYUuoNMBBRFtGDc+4H0pbQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792444223;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
 References:Content-Type:Content-Disposition:In-Reply-To:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 bh=qvWPtQmajTjIK0k0n0hxpjvn4eGZxNY6946G0uWEQr8=;
 b=Ji164xHS5sFEJEyrNUZGOJSxhnbBwbXBshlsYEjP61YYx8Vj8Pr7FbAloBxXJJW1DsjW
 BjgARYzcrXx4RzjH/Jp//j9Lzd7cAlLc0B3fpcocI98W8TTY12VaYzaY/fKomL1Ko3bDr
 1XMb/mHVr470GNpUSGO6x7O3iw66HWhyHpKpEqLWuW9prcI5OLSzEiinrFwKM+/fYISfL
 E8ELGSDRFvLGG7y8O7/L19tf1aQ4tWTQOHipTIX3ItBwo2114KX2mi7l0o99AQqF9JiNf
 DmNeFnfgrfvVgVK3ZSP6PXuz6QIsguNKNy8pq/DqKJvBgx8F9BAieHpIkWROJj0H2fQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=jmLLiPr6; 
 arc=fail smtp.remote-ip=198.175.65.12
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.12;
 helo=mgamail.intel.com; envelope-from=maciej.fijalkowski@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=jmLLiPr6
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EB6FF4008C
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 21:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792444223; x=1823980223;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=pjLqf4lyO+XM8fZg4hEonRtZfle0L0xgUMjYizf6CHM=;
 b=jmLLiPr6B9Gs/1GYO1hzNjJrTMngBz/ct933BhM+If111BQ6vjIsIPOo
 wmCxfRLQ/ssh48k7cstNz6VP3oUoErClvBM1BLkpZiTmHW6whlyS65GUJ
 sk5gzSi4UifN93wdNYl7lLDfm1zwZl/E2kbATCbFDfgEVtziQ+2+QXWHf
 ZwJS5pPhjmFrtJw4NHJYprgOqs41YyjHuNfTenOPyJJMiHQDdDmmuZ8Xr
 ApbeZUo+7J2tb5BnmaxqvnPnHckI1LuinMTEqjbHPZp6Db9vFaXE15hFD
 GLPFvCA/NxiDxuIKfevZZufH1xOjL2LtgaWXEgKXofJfXX6ezBZtfKTCA g==;
X-CSE-ConnectionGUID: oX1gwWPTQwqErRHvb87orQ==
X-CSE-MsgGUID: clQZKpxeTxKblkQjFzDHCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1019423"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1019423"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 14:10:21 -0700
X-CSE-ConnectionGUID: sdEmvCVeSPW0gAAF9OzksA==
X-CSE-MsgGUID: /6uRPwwZSJWyAgGO/Ia6Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="3039173"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 14:10:21 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 14:10:20 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 19 Oct 2026 14:10:20 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.40) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 14:10:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZjsCo8m+gNxXEI5THF2qgqsmq8XA3hKZ5oTXIUFKI/pbU6ibz5ASpe9C/YkGnc7jK1k9pgZFdnZ0+LXOoFaksKhzlEhBCVKkncJx6tyov78DYO6xZEyppNENUcuU396s57roMQ/HX4h8OQIy5E0Zj5symXXZW9UfstYgZcfWRQ7pmsWaxSJgoO6VDV/mrn7CbNctJVdgn5fdeR3Ky3+xkWtXfrM2r2XPCXdLskF9WDPziJ2p5DnR3wbhrusq6yFLMjhhPqlTU4/AD/AhGtRkUerTCN96p+uBd32366rCJVsgOLD2F+czXEhxOsD/GNvbDfCZ9zgflESpFjJjd0W7Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qvWPtQmajTjIK0k0n0hxpjvn4eGZxNY6946G0uWEQr8=;
 b=Rl/j37A9ESTSa0etGZTsT6GbrEbo23TL/RqDa2rH3xZ3Bnd7dTpCh7dO5/0RpnfyTUFmijdjhQVhlDpd0mYYSRsR95bphW1V05Zcux7jvXXk0jHftS2I3/uB3tIxkWKuwJmsb8eQKg5Qc2gpl6kgh5e2Fk3sm4R1dso7GUV8vTHclhPnVwdybIq3TKypMkkdbmaaUIeUYw8lidHtFHGnzNb7AhRdr/lcObajm2OT9ktL0Vjxr+LRx7Fv2PDbfSBArxacyLF1qCbrxpXqmd05UHqQtSQ6yqy2XNUHs05sVl19tLmNhyhllVQTdPffeamPo3mdO6R0eOHxXPZWeQWDpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH7PR11MB6605.namprd11.prod.outlook.com (2603:10b6:510:1b0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 21:10:16 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 21:10:16 +0000
Date: Mon, 19 Oct 2026 23:10:03 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: <marcin.knap@vecima.com>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Magnus Karlsson
 <magnus.karlsson@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, "Simon
 Horman" <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, <jtollet@cisco.com>,
 <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf] xsk: Do not free ZC Rx buffer when the Rx ring is full
Message-ID: <ataHK9s/MpNgXWhT@boxer>
References: <20261019-xsk-zc-rx-double-free-v1-1-2aa19f6628fb@vecima.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261019-xsk-zc-rx-double-free-v1-1-2aa19f6628fb@vecima.com>
X-ClientProxiedBy: WA0P291CA0004.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::14) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH7PR11MB6605:EE_
X-MS-Office365-Filtering-Correlation-Id: 044db109-7fac-4c02-ccf8-08df2e255fba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|1800799024|366016|260925021911599003|56012099006|260925022911599003|260925021311599003|11063799006|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: yFHiKmm5Yb6YefDyi3KkbFZKE4Tt64+jwvaF24YgyjJ/izzo2dYSyngRyVv1O6MPSawjg4OFF9m139osuA97xwLsD7IEV3VHqp0yfEQ5bRsRqq1tk4HAdQvoMab/X16+UZjp3KGq8VvGwesOYQPO6FwDw5xZqwK3RLGbgPTyI8wWW7xqwNAQJgEdT7DZu0axXqOH040/GlF19rIHZEbQDLn2yscCzsxNz5Xr5KcH6qcD+SIAUH0SdfjGFF6xJCorp7RMciqg9vo6OW4BK9AXpNptyVFbv9/q3h9OE8VKmLHjn3FSGgJwZliBtOr7Ptytiu85r71HqFMgDttB1exmS6T8Tw4gbNWR8VIgfi4n2nvTqgvUMIFEaxFyBRjep3q4wUvZgOhYJ64XDeyTSI/PDROgxLMX+/+8dkirdPTgeZMVOFbdRbubqTNtbht1ILlj7d5oz5S5wJip7IYhcjWXol1dQYNnUiBCjAgClU4iI1bdjZFlLF8enPCm69bwKZKqvm2hl+kyot7cfbebVWf7FM63yKY5nR1yC5SIIuFcZooiIz4TjCZVHeC8iJaoZnAGG7krCmhQNkctZj7b3lDyfleJd2JPygFZ4LXRBFTKnEA25DZYMpSIgr8W2WwLSQNnF+SujaX/9ZmQQ48/iliGr2rNvMHexdNW5Uo2FGlEsfU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6117.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(260925021911599003)(56012099006)(260925022911599003)(260925021311599003)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2ngHSpm40q7Q0TFkTYfGcN1rNbhFR39FrGzqLdny2TO/9uBUpw9ScTA/dMBW?=
 =?us-ascii?Q?JwwdTHu6in6ftlfVEaAF+08RgDrCyocof/l6TnnVTAmzU7ed9rU+qGqZiGTW?=
 =?us-ascii?Q?QXgL4KyJrCknaT98X8Rasrm+S3HWp6wc/MhrHk+aiqQwgtjo1Ukt6jnyPm8r?=
 =?us-ascii?Q?Yv3rC2O5g8G4F642jGpivZt7Grj8P/Q4B4clmEMIDtyGd1g/QzLRLBgkLtx5?=
 =?us-ascii?Q?hQqzQg8pqTJOCHNy06JnD+AyaJAWcQIKpfZLc6+x8bIF1i748Z3Zk/NE6cYA?=
 =?us-ascii?Q?qJw+EAXYY7aEBfKlAUUpAhkbEMUiHNaK0QQ5DFu/x+qmyda5R/oNZAlUeFfb?=
 =?us-ascii?Q?W94+xcSGNmDM6PM1y9wKBLgNVUuD26mIx/6IWpItdcNdVu8iQ5s9Csu2t9n9?=
 =?us-ascii?Q?Rr1sfEFMPIOhp1wC701TEwQC+bDr4/xjT/A6VQYQvJ40Ppk+6ChBHBartKby?=
 =?us-ascii?Q?BuKOcMyV8RzFMlWEIpTSnGvLugUyuosNrzwUB7ekTXnALGtHgeIYHM8nv6ml?=
 =?us-ascii?Q?XBYpsJBt35giFSn6K5TySp0tgXiDB3u5544nIhZmr++T+PwKG8lwqLjkrR/S?=
 =?us-ascii?Q?j6UTku8hjJZwL051OaATa1RKG/RV7pzBViOeWbsHsmzOyBDREVz5froJrtPy?=
 =?us-ascii?Q?64o9zSRfOfCAb82a8twDvM03Ed6lwWeaDN6ndRVF+OvJIN+tO6iRwIJ0U52e?=
 =?us-ascii?Q?NU7qsuespWqYJtG7eeFmGIcMpJRaHAU7uTkt6zfapywzxiJrB6XGHVa31W6X?=
 =?us-ascii?Q?0+Vq8jVRhz8Vozx5H4gsaZZt9u6En3/tnUl77vuv3swUchqkbZNwmK2o9hjV?=
 =?us-ascii?Q?E8HcPJtj8RQebXgj89KdFhPHMPGNKtw3x/L9qGpH2+WoM2zzsJdLNT+C3d/7?=
 =?us-ascii?Q?pNR+8LFLSLXJ8DrNXeH8RN8k2FAaiRTMFg/N89RLvo8F3lgpVmoAOlnOf5wX?=
 =?us-ascii?Q?bYDHtzzjf9qWrDYg9rJxhETF3vWK4JFAdTMzjsCO77WW6dU/rfiopdnTPLEO?=
 =?us-ascii?Q?nG3tX1qh4vFGXoUSbV8EkqCwpQUS2KEyb8V80hcfXB0U89utKJRelWNBxgOn?=
 =?us-ascii?Q?KcvjUO5Egv7/H1m/u1c96eKlkoU+UWwisrZxQoIDODvO4grMNfmpIuKPYBJ8?=
 =?us-ascii?Q?/rdDu8p61O8covX8CO3hXFdrxcMaAwdvsgGAm5/PJiGu6gBbGITIgu8bI8uc?=
 =?us-ascii?Q?EqDGuugJC8l2WDYxxOy5FouoJOt6jzQgGc80IkNxTvC9VWufpjfwlzSb0qZH?=
 =?us-ascii?Q?lXuxf0D+rhDsPXxzHqJuPju1G6H+8EGBY17mtOZPm5p6LXJNfmNJ6NeGbPyl?=
 =?us-ascii?Q?BiEj7qevkdaIes5Ri9+8yW0wILCFEh2XQXpHye8iM6MtT6b9twjJ+jZUI8UK?=
 =?us-ascii?Q?DMcMqXyrfLyvKlvnxqE1QDmTDArN60SZ6vRFW1xuAejx95vAgnM7qPxm96s4?=
 =?us-ascii?Q?/7kaj4V+hOjjFddX4nzoKTTlnYS4EMhNRvAS5FrixwMfi5wCSjXMRID74wjb?=
 =?us-ascii?Q?rI9Hs6a5VSJEXtxdACAbfAYM6YAADxV12fFr4hFpsrh7fIfansRSirK7ttPZ?=
 =?us-ascii?Q?gb0Cn82prDVZINSc+S5m9gCD8mhUNF3O0joYl+X0R9XWl0W0ziFMj2f/etmW?=
 =?us-ascii?Q?8+duTN6VWL3BbeJNlxhMDPEizimd+hLPbnLQoyU228aX2OT0d+xTHlisK1vq?=
 =?us-ascii?Q?+vxzQekO7YdDhZMJ9esBJGesLvVMDuyzbexHwS1kyg/wqUrDcGZCF5eAIwT7?=
 =?us-ascii?Q?eNvvrgRNRNaogKm3VrB/V52a7f1DEk8=3D?=
X-Exchange-RoutingPolicyChecked: zfUSHZumVBBOSem/UfBb8pdgLu9Mf+I9QDgnI9xQ2lytUBIBsh3ozp6Ewl6dZoqEXzkB3LVFUL41LAtMMvOtejDqdcns/Hft/zZepoW8CDVCqvWgycYjhbnyOFltejbnyz7e6fhO/KI3ufZf56RuKbz8H7+oRw8255tFUciQDmpZaA5vX+WhCnkp2YwDwsGvhIT/hGpb35Me/UPb6667+shM9TrbpqyXpCKVjw3ASBk1RXXfq7dR5Uncyn7u3lJWw1UbYxxVIS6oB64p9VvKEnfvyvQxIYsqogY2z8VuHUBoeQw6ksAyJrU9hFdcV3IHMXYBSPKG2P1T2NmLJ6MB1A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 044db109-7fac-4c02-ccf8-08df2e255fba
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 21:10:16.6342 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BdLTnNcA95ttFapgEQpEQYXPw3acSDbz2xcbFPoixWeXB9d6XZHTHi7tum19LnwWF7Kq1OkVMLS4nuCj5fOvCWHDZfTwpbWIDs/FpFfd8vc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6605
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
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 19, 2026 at 10:22:02AM +0200, Marcin Knap via B4 Relay wrote:
> From: Marcin Knap <marcin.knap@vecima.com>
> 
> When an XDP program redirects a zero-copy buffer to an XSK and the
> socket's Rx ring is full, xsk_rcv_zc() frees the buffer and returns
> -ENOBUFS to xdp_do_redirect().
> 
> A failed xdp_do_redirect() leaves the buffer owned by the caller, and
> drivers rely on that: mlx5e treats the failure as XDP_DROP and releases

Sashiko report shows that drivers are rather inconsistent here

> the buffer when the Rx WQE is refilled, and i40e and ice free it on
> XDP_CONSUMED. The buffer is therefore freed twice. It gets reused for
> another Rx descriptor, the second free puts an in-use buffer back on
> the pool free list, and the same UMEM frame is later handed to user
> space twice. 

Did you verify this or is this rather a speculation? xp_free() protects
against double-free cases.

> On mlx5 with striding RQ this also ended in a NULL pointer
> dereference in mlx5e_post_rx_wqes().

Please more info on this then.

> 
> Leave the buffer with the caller on both the single-buffer and the
> multi-buffer -ENOBUFS paths, as xsk_rcv() and xsk_rcv_check() already
> do. i40e and ice relied on the core freeing the buffer on their
> need_wakeup -ENOBUFS (XDP_EXIT) path, so make them free it there.
> 
> Seen on Mellanox ConnectX-6 DX MT2892 (FW 22.47.1026) with AF_XDP
> zero-copy on 7.3.0-rc6 when the user-space consumer could not keep up
> with the Rx ring. With this change no duplicate frames were seen with
> striding RQ on or off.

Have you thought about massaging mlx driver instead of intel + core?
Even when that would be correct approach ixgbe would miss being addressed.

> 
> Fixes: 269009893146 ("xsk: recycle buffer in case Rx queue was full")
> Signed-off-by: Marcin Knap <marcin.knap@vecima.com>
> ---
> Tested on mlx5 (ConnectX-6 DX) in zero-copy single-buffer mode.
> The i40e and ice changes and the multi-buffer path are build-tested
> only, as I don't have that hardware available.
> ---
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c |  1 +
>  drivers/net/ethernet/intel/ice/ice_xsk.c   |  1 +
>  net/xdp/xsk.c                              | 15 +++------------
>  3 files changed, 5 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> index 9f47388eaba5..d32c7255f0b3 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> @@ -358,6 +358,7 @@ static void i40e_handle_xdp_result_zc(struct i40e_ring *rx_ring,
>  		return;
>  
>  	if (xdp_res == I40E_XDP_EXIT) {
> +		xsk_buff_free(xdp_buff);
>  		*failure = true;
>  		return;
>  	}
> diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
> index 0643017541c3..7c1dd4c87a71 100644
> --- a/drivers/net/ethernet/intel/ice/ice_xsk.c
> +++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
> @@ -636,6 +636,7 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring,
>  		if (likely(xdp_res & (ICE_XDP_TX | ICE_XDP_REDIR))) {
>  			xdp_xmit |= xdp_res;
>  		} else if (xdp_res == ICE_XDP_EXIT) {
> +			xsk_buff_free(first);
>  			failure = true;
>  			first = NULL;
>  			break;
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 33475b180ea6..0edc160c660f 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -224,21 +224,15 @@ static int xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
>  	struct list_head *xskb_list;
>  	u32 contd = 0;
>  	u32 num_desc;
> -	int err;
>  
> -	if (likely(!frags)) {
> -		err = __xsk_rcv_zc(xs, xskb, len, contd);
> -		if (err)
> -			goto err;
> -		return 0;
> -	}
> +	if (likely(!frags))
> +		return __xsk_rcv_zc(xs, xskb, len, contd);
>  
>  	contd = XDP_PKT_CONTD;
>  	num_desc = xdp_get_shared_info_from_buff(xdp)->nr_frags + 1;
>  	if (xskq_prod_nb_free(xs->rx, num_desc) < num_desc) {
>  		xs->rx_queue_full++;
> -		err = -ENOBUFS;
> -		goto err;
> +		return -ENOBUFS;
>  	}
>  
>  	__xsk_rcv_zc_safe(xs, xskb, len, contd);
> @@ -252,9 +246,6 @@ static int xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
>  	}
>  
>  	return 0;
> -err:
> -	xsk_buff_free(xdp);
> -	return err;
>  }
>  
>  static void *xsk_copy_xdp_start(struct xdp_buff *from)
> 
> ---
> base-commit: ff47652a4b66c067c765a7ad464d930b5a9367cc
> change-id: 20261019-xsk-zc-rx-double-free-1a3b059cd41f
> 
> Best regards,
> --  
> Marcin Knap <marcin.knap@vecima.com>
> 
> 
