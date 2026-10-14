Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43824CC6B1A
	for <intel-wired-lan@archiver.kernel.org>; Wed, 14 Oct 2026 09:35:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DA3A880D1C;
	Wed, 14 Oct 2026 09:35:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s6n9KpfzP3tF; Wed, 14 Oct 2026 09:35:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 10A1E80CF1
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791970519;
	b=nt/ztTx5Woqwfy6TX7VWkqJW2M42XTgIRh78Cj94GUOxwTVN1hpW4lrD921NxBXt66XB
	 yjEzgTDDs94w0PjB1D3oFlB65DwH3Gj82VAN7BitNzbW1+7yrN+PktnXwevlQKxdpuh7d
	 cAwpYspOzGXU4xHvDG3ILKxm5YbXHe/8Uef2+OWvXOFK5zWo8lmB81Nbw7p8dIGBqCLDG
	 y/FUMcmXyFy3hf4Yj3Qob349UpTvO52Rbh4nu1E26T8mwpXAtXmEpHcwh4waT4YCuz5qe
	 Y9/4obHp5WC927Z5m5bWekQV6ioZinGIQx0SsS3PXbxJLxS+aejBomTfwcwDU5IBrxw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791970519;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:Received:Received:
	 From:To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
	 References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=1kFcZHrXw8Qu6uV32AKjB7AQo0+pg0djUP/9HJDes4c=;
	b=EMn3EgSjGLoV/+JFufm4wkwV4/Mdz0nBBICTzUTrGEYz4AkPrqCTSi25NWBe7fq7Arf0
	 joMrWQCvSzgl8wdzHTJkXiPErrx+LxaYmQm6wtiwC+qM4Y+sa63Z3uXzJCrTw2U60Pda/
	 gkZw0VTCrUyMtPDRRYTRdhEOdqdB1t1vuJdssWq9zlXII/L64msjPnaCFPr7zfrLo4Rvw
	 57Hn5UdzpFr24ePbw8xhSYe2x2u541oo6Ss66r9pU0ljDezEt2H+6I1mKw/6QsTSKyYYQ
	 nb6ml4JKrOeurmNBFIwr9TTeAwFlmERwgq2rHCpmz6r6q3JYrLoIgPAIrp1qabD+9mA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791970519;
	bh=1kFcZHrXw8Qu6uV32AKjB7AQo0+pg0djUP/9HJDes4c=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=akV4q42bg5Mhr9jY9wU3mYyJQh/Pb2gl45aVGbLM+qSdeiODJ9j+8+UHb/Yi2zbzU
	 i2KdMj+A78b9T/WCOaYkkbUm7mzjsfdgzlOC/ejSs3PAmVNYAB00OMfYh/ZuObWhiP
	 Wpt9MUAxYvlYVQUHN4wGTMV+vX24hBAw3zzBNAOPQQV5TzGlHl92XICqKrhhd3TwMd
	 jtaM5/XjFxiHwNZRa2NwpEc5qHcGC+Bc2UHPL83Vx/fLpznkZv8yVx4Rwu0kjqHbF0
	 PXrdfI4Fu3YNC/BWscC4dWQzZ6b7jtCg8OlELcmh1bLVVriIYHqGcEXTEpnOSzoFCK
	 h1qqdlN+pfIuQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 10A1E80CF1;
	Wed, 14 Oct 2026 09:35:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 77F691DE
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 09:35:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5DFB84067C
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 09:35:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Red4SpHCUR9J for <intel-wired-lan@lists.osuosl.org>;
 Wed, 14 Oct 2026 09:35:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7FC8D40675
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.13
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791970516;
 b=T5peBII9bKsLpjOy9mbMm3TARjxdvmGMqcjgkeE560jTVLdwhkUvWsXRxnbxuC22eAhL
 ZZo0vAk102uaqALc1zCNjBJTmSGeDDnM3+u6cHnERRGMhGIMD6xIuf6/YT0YQl/SqSOG7
 c+UFnrGmUT/yX9KK0VnB0ZvrqM6+dwiEDonw2peT85Z5s7jFrnNU9mwc4ulEaK1auC2IS
 S6Nqaq3xHeXC1JNOykgWYI/S6H2Bk5tQ74EFNQWtgKILkh+CzmrX/miO4fims+QiHiPfh
 PzsUDQIW3lTV3BM6lgzGsGG3vWpWQ5PXw30oS0n+fRLwSghy6L3Qvx2wDg+7aopqmow==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791970516;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
 x-ms-publictraffictype:x-ms-traffictypediagnostic:
 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
 x-ms-exchange-antispam-relay:x-microsoft-antispam:
 x-microsoft-antispam-message-info:x-forefront-antispam-report:
 x-ms-exchange-antispam-messagedata-chunkcount:
 x-ms-exchange-antispam-messagedata-0:Content-Type:
 Content-Transfer-Encoding:MIME-Version:
 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-originalarrivaltime:
 X-MS-Exchange-CrossTenant-fromentityheader:
 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
 X-MS-Exchange-CrossTenant-userprincipalname:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 bh=1kFcZHrXw8Qu6uV32AKjB7AQo0+pg0djUP/9HJDes4c=;
 b=nL+Pr0/LtU81fpC+xKzno017FPX+cCuPL/DKWuy5ULMXRbZc0zHkVZ5tXS9bWSc3ltuF
 RxfDkUqb7chddR/bWxpMvL9czIg1K/u/cAmKtIQ8ATE6Ydp2fbKk/IbTZfYNmVHEqwdWz
 FrgQovJFL/GHpctY5L4pOnJF3C6p4YBGYCuBmf7nd0Q3ydrYdQQcB08wzKC4fEzfgnRjz
 gGvZlQemAGdUkskkzJN1b/hePEoDwvLgIFbr1u4KAPU1rUtSDLNfUTdbYUjmi+mPRHovY
 VzRuQ0Q2VvHoiGyxyA0snBtoEYX50uDpITqVGdie/myIgfxQ2wLAXMkiI5vrJ7cCM9A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=bL2CJoDt; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.13
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.13;
 helo=mgamail.intel.com; envelope-from=ayush1x.singh@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=bL2CJoDt
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7FC8D40675
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 09:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791970517; x=1823506517;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=jqtS870I3bDoJHvuvUSC6Fnx/hfb/HPXUchppRZGeF0=;
 b=bL2CJoDtQq1x0FaQzxz2wzUYOuQVSz5qbS1bhZXm8ysNBf/IC436J9cA
 e9k12hRD9EO0IYoRazH8CNkAXfiuWzrToiw81cHbNGJitqIsqqE6f5NLr
 4J+Y3J3V4Jjja+dtvG0l+x8vvwcM/YXaIpWzgcCrUa003xhc0DRW7wIWh
 tYwWURONSSI/uisbgfB6QClyfK0blZloqOkoQ9JHbqoDcWeHWaCuMn5Q1
 3kFpE+BWRDjsQT8rqrCGTvt2bg3AzxRsOefEtrgDGxJa5AfTgLDH7ihMh
 HGFVFNBuO1aIsF3I1VLVLIgYFpY3HtIPRBcxGRMlGepk7M5N+dRJp4Va0 w==;
X-CSE-ConnectionGUID: UHxrm4A4Qsq/p/IguooVxw==
X-CSE-MsgGUID: aX8efu6NSzqGdtevYJcjQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="598181"
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="598181"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 02:35:14 -0700
X-CSE-ConnectionGUID: UQSIXrxWQ7+HqkiwbSEzPA==
X-CSE-MsgGUID: HMGwhLoaT1+K6IbS4SX7ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="1276300"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 02:35:14 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 02:35:12 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 14 Oct 2026 02:35:12 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.52) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 02:35:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TWiwyPEp/TVARQ5gFZd43ESlGutdXqMwMWRf8K9aJRCXwm+h95pxU+EbHBOXCdLpdgIdh0y8LSjlsfLDnkZFnVE9rQBe7wN19caY6lujoJWTFMAeqvHWQe+jl4q0FI38Y05mpUVXF/aJWns4NmmIoysYQiRDf7XJ0fmLsgcsfbJkNhwiSBMznzgzg6Z9J6mjGGiIfWFeJoluz6HsqIEL/mWOF2m4TJLcwY8b9P3N5hbIr49xpwK22iV+nw/h6kod319UFuDF7/EA6hm5HrGTpbeRg3DPLCFro73KNEE4FudsxQ2y282Rl93FZyj3SjuV1JrpSPCxpXQ+8TGYKfp2aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1kFcZHrXw8Qu6uV32AKjB7AQo0+pg0djUP/9HJDes4c=;
 b=ZGy51ZNsePA7scBbkf9pUkzI80hWrP1i4exY/UPwPqkt0CXG5BEz4x2TgvnsZN4AgP5qyqRwo/zodZ/XezqcA0LRJ1rwBIwzhlIzsSY8sXPcejNFuMpmDJaKWlGlbWGdqNyTVTZnJwUUzxO03PKxXnCmjuNCqXUMzAwowDyQ0lCDSgBnI2tjbKKlDeDzeCjGwoHjFcW3X/clKTpbPjiv5xwlRTH6aStGYT3Wy6X8A+UCZmCEBrtwDqUNy0BoerVGckTVHqaafs9sY0hr4pBCx83SWYpF87P+wne5KAuy4NFY4iOV4iEtCOk66iyJlh1ZoOQNHFkyo92s8BDEm73rrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BY5PR11MB3976.namprd11.prod.outlook.com (2603:10b6:a03:187::14)
 by IA3PR11MB015924.namprd11.prod.outlook.com (2603:10b6:208:549::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.24; Wed, 14 Oct
 2026 09:35:10 +0000
Received: from BY5PR11MB3976.namprd11.prod.outlook.com
 ([fe80::c23a:c952:eb75:d4d4]) by BY5PR11MB3976.namprd11.prod.outlook.com
 ([fe80::c23a:c952:eb75:d4d4%4]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 09:35:10 +0000
From: "Singh, Ayush1X" <ayush1x.singh@intel.com>
To: Aaron Ma <aaron.ma@canonical.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Henry Tieman <henry.w.tieman@intel.com>, "moderated list:INTEL ETHERNET
 DRIVERS" <intel-wired-lan@lists.osuosl.org>
Subject: RE: [PATCH v2 1/2] ice: restore DDP state during PFR recovery
Thread-Topic: [PATCH v2 1/2] ice: restore DDP state during PFR recovery
Thread-Index: AQHdPr92hThMv6PwgEOYNqDAyH0Qr7b81Q+w
Date: Wed, 14 Oct 2026 09:35:10 +0000
Message-ID: <BY5PR11MB3976043EE58AB3365BE48619A59D2@BY5PR11MB3976.namprd11.prod.outlook.com>
References: <20260907115221.926007-1-aaron.ma@canonical.com>
In-Reply-To: <20260907115221.926007-1-aaron.ma@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR11MB3976:EE_|IA3PR11MB015924:EE_
x-ms-office365-filtering-correlation-id: 6538d981-2f5f-4266-27a7-08df29d670e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|22082099003|18002099003|10067099003|921020|38070700021|11063799006|261009223027099003|56012099006;
x-microsoft-antispam-message-info: wMf/G1zSsvfV3UYIu7z9YvsUy6GDTj3ZFeQqG6ED8gLEZ/Er+91a9Y9HUfTiN7FxZ4QFYwXIMI58HZhHkzUJaBtDbCpBBWgEozPPyEkRrRj7t5OiASi/C41qh/3OQMVSmovp+B22O36L0rfSTthy2k7hg3Cqtnioe3T6fa8li0T82UooQkp3V/xCV3W7vpNw5O7Mjz4nv4jGeP6EiSWfYZBc043mf9TvgzirBuxO1hBijfGWkuvDtZNkK6VJX1Nng68EY5JN4VsOe9iWyY79TMlWDW5ipY/rSh2rRwfWfCiA3rWkKgzcFNIfw2qZs+Gk4dS97o+zGRUUKrM4qVy1Hm3LSrXHT/vLcQLXYwEiJTxn8m5a7XwwvvNCAtlFDqxQgvFO2y3J/ATZFFQ8Q/eO5lWlGHvtG/BsMm6dNC0+K3mRXPTm+yZEXesW0+CmdHH/JMiRIbxK9UfbEeMFMChIqcG7TwywVkD9a1xG3o/lwfdiyPgIMGHokzIwU8WVGzj5C6nlQg3gK36b7El4yOb1b4YafU0chZQjvBjKYGy/vfMmONz8d3rw4p1t9Afu9ilK/BuA4KVXid1N9sIG1n4Inu/XehNn6NqogFALVwAzOCkQxEMZQ0ERcnKrf500X37tCZnpruCKtCt/iZehDyta8gfpgeLU7NhDOmJDzNcE7uQhE8Fnn0eeIv6Cn0DdQcK2qCNUp60lyd3K2QsYPeQwJXwQtSQXfQlu+wd7hzIqV7atBO/yUsa5wlScDNGXNzZA
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB3976.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(22082099003)(18002099003)(10067099003)(921020)(38070700021)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?syXzTypCTTwJXOCWqcQP8nFrwCM9zzfqkNCVh5WTyP7yuraZeOcuJpaHs2/c?=
 =?us-ascii?Q?423GjyPUWZ4XKHxWUCSh4VgFFS9EcEurTKZyvHgKzrf0P1EeJSvpbUZnckij?=
 =?us-ascii?Q?SnaGs9SIF7Pe9EKJjP69UNOmqAKXc6whumvoB+7ymn+KndspwKSeCwPhhoHq?=
 =?us-ascii?Q?IG2C4rQTkcJZN0wrtTEkkVKaHUY0R0gRNGkZazzUXNpf3KgTxjxscybT1eh2?=
 =?us-ascii?Q?RpI3lk4QGvNziTBj2s4zZ4MZBdxkmKScu6XLe434pPndxQX006GAHweB7fQf?=
 =?us-ascii?Q?LF1wyL6p678ZVzkZTFtKlwkYlumz3WTNgvidnDrOPL4lsANU4+tXFaOMVlDK?=
 =?us-ascii?Q?3cu2f6PxR2kUl0OTPh9JRIyyGCyMpiMfWHkivi6HXWydXnKwKhZdJ7O/wMFN?=
 =?us-ascii?Q?XFTVf4cfaEkGHTow1+mZ36MoLqWU9P79OXzbUlkWnr90cY3PERBJVOrZEMJQ?=
 =?us-ascii?Q?hyLAR0MbWj/HHlF4v8pgStZaS55lYfTIMKaRjcFEvDolRyySY8XFpP/CU1zh?=
 =?us-ascii?Q?iS7BKsFuuUXr7B20BlxUxcfDnDepB6GFfTIzdsYK5XgDNLzoFriAWivX5KYh?=
 =?us-ascii?Q?dWvlG7TyMWljFBgCJBPfZkKQ41r8ew2Bayp0FytVZDYvw4VQyyVTX9EZdSlh?=
 =?us-ascii?Q?Gl2eme0ec7o38UOoeUAbQqIjgEsGhrCbWF9XCnQfvC+JwDPnnWfpY14ju/Y5?=
 =?us-ascii?Q?wYS6Zaw2h8DzBWPYgSWD4+YZsyJMZm7koKB5t8HN4naGshLFO//SMzRB16BZ?=
 =?us-ascii?Q?0Bgh2Bp+yPkLYyXvAV4MqMuIh1IxxWrrZd8QUAGZvLGCPdZex3eganX2wO7S?=
 =?us-ascii?Q?fQWJ8eLPSM0Y303Qo44YAbuXm9BtluZ4ii1qhYXPJ1fBx1igQTlLJPXADNlW?=
 =?us-ascii?Q?tnFJaChMbyEbvXbaDybKrz3pKZr3atu+SUxDLKeVmK7wPf7E26D8uAA7MYSV?=
 =?us-ascii?Q?VCI6JLQk1rpic2FpVeaWQ8By7BSOL8ECOToyHF1ExXHgb/3RTJNj7ankGSou?=
 =?us-ascii?Q?u03e7yoa128rRAULgKiTqGclfR96Cqq+cp6iyDmeWXeDZSV8mhuewYnHGhep?=
 =?us-ascii?Q?tYwkZmS+O/L3bvl4D7aZaKQCLiArB8+gkxbNwc6z3MU6Grtgf9Z6q3gFu7fP?=
 =?us-ascii?Q?MhAwtaQXp4fbow10juNYGZN5SoSMrVfkbasteJaWESSOjnRnOh1M7jZrwXg/?=
 =?us-ascii?Q?vUmxesKtgDwMDN3tn7ktjP1G1qx/JbQctCCUikAlp1DLROB7LhrKCQREX+gT?=
 =?us-ascii?Q?DSuYsB0QuwQI+tCClQwcKGNN6JNoHZjCfcBinFU8D0ScV9F6c8+47qv5dHyt?=
 =?us-ascii?Q?GHhnAX3OWGyK6RPgr5zv+8mfafT39Me+x2dQCqk4yWmn4Lw18M7A4hlNivnw?=
 =?us-ascii?Q?p4CqCUKpzjg9b/uc/DE1uoUClMqeWWjQnlyPBMSi7VS3pZaCKXaP6h0HCaGg?=
 =?us-ascii?Q?yukXYHj2W3298Q4c9nqlkwTE7F/az7KIVm1M18a7a2cJbG7fXshUTyOfDouh?=
 =?us-ascii?Q?Y2vnnAYYAFF8unVq9HRdMYCpik/YWzpB3Egm23p7NfCUnd/u377FS/Cb1FrO?=
 =?us-ascii?Q?ywMf5RHcGl7CCNx0gWXk/mje7hkaApoJfJvKMZHQSQ8hM26eIjJ/UMI9rwpF?=
 =?us-ascii?Q?BMl5wSXS+EojpaRIcQ/e0vTXS1MrExjTSV7YdJTA7FsPO9VPHV9/Mw3Zbfr+?=
 =?us-ascii?Q?zQuZ3w9qqLmbugYS7Pzx19B8Zhr1G3P9bZ+J1+hk2TDMqnmrOuJLkjKyMUnR?=
 =?us-ascii?Q?9DED/7MIIg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: H96yXz+ZfvYdmMyiRMEBrkOqpwYvSEFeJW3pjjmBYKFf7rr6ouc8w3ZH53HePyV4hYY9eXZxvVkTn66lECLNIeWJxFq4+3YukNgDo/4NjXyt1wppUa9Mdlpn1ro0FyT7DZuHC41moZehu+3Sn9PLqPSRvxm95ZJTPEsuXiNQycP3vRN3WKcbYreyDqSbBvWC3uKKLnWmkNfnVxIzloHcUMt4SDKsAroD2GOFjOY/G1Zfg3I47tbhmLpFnRBUp/HSFBAb9hv35WOWf43jyBU0ZAt1RgxcsuR9Tua2GXfCMiBbLfc2ZyXSJautIc6DjeHA1gKKqK1z92YpMQUVsjnWqA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB3976.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6538d981-2f5f-4266-27a7-08df29d670e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2026 09:35:10.3741 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f02HmVSpk9dvm4AEIuM8W1piQ7lSe35sN0UW7ozcA8hihOE4Xz4Y8euMZNBW+HXEpYGE6M6Wfmh42/MF3AR7KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB015924
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

> -----Original Message-----
> From: Aaron Ma <aaron.ma@canonical.com>=20
> Sent: 07 September 2026 17:22
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <=
przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>; David S=
. Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub K=
icinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; netdev@vger.ker=
nel.org; linux-kernel@vger.kernel.org
> Cc: Henry Tieman <henry.w.tieman@intel.com>; moderated list:INTEL ETHERNE=
T DRIVERS <intel-wired-lan@lists.osuosl.org>
> Subject: [PATCH v2 1/2] ice: restore DDP state during PFR recovery
>
> The firmware package and switch recipes are shared by all PFs of an adapt=
er. However, each PF rebuilds independently after system resume. The result=
ing package downloads and recipe updates can interleave, causing firmware t=
imeouts and leaving interfaces unusable.
>
> PFR also clears package-derived firmware state on affected devices. The e=
xisting PFR path only rebuilds the driver's block tables, so VLAN recipe pr=
ogramming can fail after the reset.
>
> The failure is reported as:
>
> ice 0000:04:00.0: Update pkg failed: err -5
> ice 0000:04:00.0: package load failed, -12
> ice 0000:04:00.0: Rebuild failed, unload and reload driver
>
> This was observed on an Intel E810-XXV-2 adapter (PCI ID 8086:159b, revis=
ion 02) with NVM package 1.0.0.18 and ICE OS Default DDP package 1.3.43.0.
>
> Serialize rebuilds across PFs of the same adapter, while allowing each PF=
R to complete independently. Reload the DDP package from its cached copy an=
d restore the default DVM recipes before rebuilding the remaining PF state.
> Abort recovery if either operation fails.
>
> In addition, stop the service task before tearing down resources in
> ice_remove() so that an in-flight rebuild completes and cannot dereferenc=
e
> pf->adapter after ice_adapter_put().
>
> Fixes: 462acf6aca85 ("ice: Enable DDP package download")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> ---
> v1 -> v2:
> - Stop service task early in ice_remove() to prevent use-after-free on
> pf->adapter if rebuild is in flight.
>
> drivers/net/ethernet/intel/ice/ice_adapter.c  |  2 ++  drivers/net/ethern=
et/intel/ice/ice_adapter.h  |  3 ++
> drivers/net/ethernet/intel/ice/ice_main.c     | 35 ++++++++++++++-----
> .../net/ethernet/intel/ice/ice_vlan_mode.c    |  2 +-
> .../net/ethernet/intel/ice/ice_vlan_mode.h    |  1 +
> 5 files changed, 34 insertions(+), 9 deletions(-)
>

Tested-by: Ayush Singh < ayush1x.singh@intel.com > (A Contingent worker at =
Intel)
