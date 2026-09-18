Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E906C982DC
	for <intel-wired-lan@archiver.kernel.org>; Fri, 18 Sep 2026 11:35:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C1D7340B79;
	Fri, 18 Sep 2026 11:35:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Aj3xKeCHiBiG; Fri, 18 Sep 2026 11:35:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E60B840B70
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789731301;
	b=iUXVhllAhzorocsz1g20Npj81bxozbEyvSeYF8HHM9pf90blkzHhe7KvGSQPo15xqGOq
	 H5y6zzt6OuXnMD02fOxVeQtJKNA9zPDktnsO8tXHTqr9hA/hsL5NWR74aRPbnwRPN6rVF
	 DAA6c4SiNTsHl6na4EUR6q47qj9VOCCIJ8WPnrxbEkz8VZ78bAK6cE7rdeonGZcK6m/5s
	 6q3JIBQkV9C1faQQIXGBjBfgtVXIiPHucWNAx+BicaMr8JG3dgrntWkezEuVqVCjsGGJJ
	 ZjxwCmWR2gEfjNiX49y/Mhut019s4Ti91GtjYwIb7OvGalTfsr3y5oOC558mcTlDltA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789731301;
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
	bh=wiWQtt/SSNIcRWCHMvL1xSQqxIVsz+KQbOJE0nOOjNg=;
	b=W0BU/BZ0IotWuO6tAk6tj1kNOepcCbb+bicdl14Ho3QT+Ll72G6fPutOYB7ErjtafaqA
	 akXY+LfCaCaoY12D5SxvlZpp62X76dZRyes7gIuUbDMbEBwTFQ/Ddeu5xYyQdFRD6T49c
	 hMKT0z0mPFbmeJ4oyGVn5E/JDKzCPTn/fj+z19haWv/2q7Y2qdlt0RcKYUDOIAhCveqcW
	 +vQETSJHUMkjdgzo1m+/tlQ8p8VyZrAOUkgJrReZshTtcJsyGbfXpC+s6dqhssKA/MpWt
	 K+Yl4ZOFriF9ect0zraINg0SZwrRn/poJbGStpAOP4vpYhVh9C7Xv7Nhh40HU7ERjuw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789731300;
	bh=wiWQtt/SSNIcRWCHMvL1xSQqxIVsz+KQbOJE0nOOjNg=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZrLRHoKf7zQn0neUNQU4589e6gjgIObce+WW1z8ofhIpFq9JiTP/8IO8/FEH0ZCrH
	 eADm7IVZGx5xLfY2sn7EEfTIr/iHcaOO+uWEIbrfp9FS0grmQ0IPC6han4j7MSodB7
	 xUfNsedblkTWn0dmIVgv/1Cl4L2CvGgFPhiV2S8Y9YoizdYCa91l8W4b8FTDFsVdfk
	 mzS6rfFJdCrG2qrXxpzIr2BBYiK7QvnXMaZgE7LZLCxq+NiZ6pGvbWptUaVzNhOg4Z
	 zvv1/UqNBxx7EFVXBxzw1tME8SuW0m2irng/jSvEv45+FUNZoNoI/OgLK06BP0WIeR
	 4cTI8lE5a7QZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E60B840B70;
	Fri, 18 Sep 2026 11:35:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 37674422
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 11:34:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1D82A40049
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 11:34:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FBANhKUqLns0 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 18 Sep 2026 11:34:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org E7F8840048
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.8
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789731298;
 b=V11NzUVm1pyc+iR3wzWGaSUMsxW924NxNdySw9jizj8PBIpSPaO0zzESvtnmk8bdpPvl
 a0QUUiImz2bxcU/G/XCkGF73OGFSaWJKthhkJnwa9dRb+ncglxMHz1syFMFkc8JWFXxih
 ytImuoo5TU8Mnbb8qsmZZ2+CAAriuhZ1iKAvhpzUNfeZ7qcS8fDI23MvxgCTC7d6MDWf9
 NXUEals/vOhzZJvl5tKA0nMb+GG6HyORgj/TRQrfuZqlldIYo02KUE61itiHcLcy+tGRs
 FVzCq1CjF1ChtFnxP4NdFO5FzHtq+5YaRaR0nV/1zRUQ4q8lalZaC8gvyrkfTAqzzFg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789731298;
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
 bh=wiWQtt/SSNIcRWCHMvL1xSQqxIVsz+KQbOJE0nOOjNg=;
 b=BnKlfk/m5KDIRD7v4wwLfe866zwaRmze+DEg2xqt/V5W7pdUuc/Gs2CJDpkwImleoauG
 WC/3SCCA7x5nfKmyCYN41ZgDwQgAepc9Qf/CSBr9qdaYZiFhV1amukauKrTooW2BrAXUT
 0XPLE4JLM3WPjK5rP6NCer5Y/787cbXpEIyJVIXqJZjUz7DnRNoKPgHLnVkb1qyBWfzgf
 dFcuh8K1ztw9WjY+LrUQA8CXq8m/bZbI/kPEVbDmagdBbfxun4KANFFTMfCjwHXV6AEUF
 4s8W5z/oiWVoYIC+taj39kSOcjzPS8T29Z8Sru2Iehjd5DhmZK3Ko8EqenXUE7cLnUg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b="PmRf/TgI"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.8
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.8;
 helo=mgamail.intel.com; envelope-from=rafal.romanowski@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=PmRf/TgI
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E7F8840048
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 11:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789731298; x=1821267298;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ZhiPrYALwbuTJFHLi3F2XCLI1Fqeey/a8j+G1rHA1EM=;
 b=PmRf/TgIc6zN2/A7U6MxFV4vLF/+xJa3DwT+piaJZt/CH1nCdhtM2hmO
 av4YcvWNf/P7ByKCSaXVFHkg1/BBilwSj0Gd14Sy/L29ayqCNTPPiRiDJ
 FcKkeGJTsTKSwFGVHhkPPL0NB9/afnT452OMigE4lLSCPv2wtfmnZYpXr
 BJHyZk67yXTXqoburTYPrxGxsm53wICrE/II9IwH2RdkUuvh4EGt3E/5d
 D/rnYJPljwSTnRbzN0kKn73slus0gqY7/ESn4KOl4hNQSTU+5Gv2NhkqX
 Uoi/Oy/1CQ4PsivwHugnsodq3Q0kn47PhA1lt4paWlxrX5kkETcIp0N2G g==;
X-CSE-ConnectionGUID: OTaEXVXkSJySBEzkQHFPcA==
X-CSE-MsgGUID: 1DptbIJcTuuPXPkMD8FClw==
X-IronPort-AV: E=McAfee;i="6800,10657,11908"; a="107734051"
X-IronPort-AV: E=Sophos;i="6.27,108,1787036400"; d="scan'208";a="107734051"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 04:34:57 -0700
X-CSE-ConnectionGUID: mBPcgenjTk+niouAjg+Qfw==
X-CSE-MsgGUID: RGpOlWoPQ3uMHwDe0rDuyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,108,1787036400"; d="scan'208";a="270674839"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 04:34:56 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 04:34:56 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 18 Sep 2026 04:34:56 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.10) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 04:34:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FIMmL4BkWZ2A4RTiY4F1qmJyCI2gttTeUdGoeUVMCqZupPUQohfrf3dkuWsCAvzKTRmfB5D/olMDmt+1XcZ4Eh+KXAUfiIbr5YE2a36P1wnS/AOpd3fLGdrun0dE+c3agQpozeBQ7Bu8bt6p91AG44WwEPxTCLAKmemoRjYcTuZqfbNUw53JHhdK0nDmEt0Veh4yxDjcgNqCXHFWFuOycpmCIArTUuMLpMxbsfTjRjx63g83SUpqOht2HvJUPOScfAJ1/ugvNSEooyzeLg4MMyXf7hqKuEjn9/e/RDoc1HtyxBgrT5jiUdAkv311O5CwJiUXIc9LXOgpZsyu9ErA7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wiWQtt/SSNIcRWCHMvL1xSQqxIVsz+KQbOJE0nOOjNg=;
 b=uEai9wql/Do0c7fuFoygffJYj3UPF1mmc4D/RjRx/oB/XpwZbWkrEx/ftFRzht0eVDyBY94U+lVAQsP4kqh8V9577QteOLaTKIf7AFiG0ntTT91wXuBR4YetauXrLHDJTh2LMBZtr1xWOJuFLHJrBggBv3yF3h7I20nbsmWD4wGOxxYipHIyu3eeEd1B1q8oeT3raXzCKMsMYB4Rw1ejONo5YNuAhl0oppzX0UtNkB4AbGVUWiXWT634L2D8lfaf1yGYN+PrA8b/K3O/GWjnUAMreEumZm/HfJu519wG04S6q3UKAP0+W2dKAqoTcgmLHqa7VErNPBJrxijBaba2ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8985.namprd11.prod.outlook.com (2603:10b6:208:575::17)
 by LVUPR11MB9787.namprd11.prod.outlook.com (2603:10b6:408:39b::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 11:34:47 +0000
Received: from IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d]) by IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d%3]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 11:34:47 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: Simon Horman <horms@kernel.org>, "Loktionov, Aleksandr"
 <aleksandr.loktionov@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Subject: RE: [PATCH iwl-net v2] ice: fix bound parser hash offset before
 reading packet data
Thread-Topic: [PATCH iwl-net v2] ice: fix bound parser hash offset before
 reading packet data
Thread-Index: AQHdM8u8+Zv9K5UDEkCIlV8s7cJwI7a8wpAAgBeZMvA=
Date: Fri, 18 Sep 2026 11:34:47 +0000
Message-ID: <IA3PR11MB8985E72E458EF05B54E9095D8F872@IA3PR11MB8985.namprd11.prod.outlook.com>
References: <20260824132248.3396788-1-aleksandr.loktionov@intel.com>
 <20260903111216.GM396647@horms.kernel.org>
In-Reply-To: <20260903111216.GM396647@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8985:EE_|LVUPR11MB9787:EE_
x-ms-office365-filtering-correlation-id: bb31e1fb-a0a3-418b-3622-08df1578d7ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|11063799006|6133799003|22082099003|18002099003|56012099006|4143699003|38070700021;
x-microsoft-antispam-message-info: 0K/5CSdvqZBTWBhvwN7259JPPQPKJgRXChW02BnblrCQj6YTjzF2PE573/ujEZED/7s8pwsxH5qKsFcPPXl6TGbtoTwS1Sz96FoJZ4SWiKzWIoJAiuXR7xrNarVfbmVpkK93BOk8eG17VtHJ6irBH33cN7CSY8mrR4GnDtqf0WV+PaiuVrXcVTW3eriGSTIpknSduuzR0OPiEp5IakaR8UMcYMHeouNiisFAWk64h5+uNCOm0pr5uM89MCZAK6yBxwckLO9hbd5q+c1gusV4/yHel20I/UMb4cVOank73CnTbipO2bDhOLSQ+BXJJj0dJtaLb3xlcy3lNwW29Wc140V/FGc6Z0SOvlBJhKqJf5tHdJnEaJ+vw0bRGGT8sNuEdYg9H6gmGUCOh5tYO2QTNDkJVIPepGHpgG24mifIxdJ+a/rPvrWZQABpUUHhPv8qC5tTfd4c+NQmFPv0BALrkj4RYCUPuuIIROHo8aYlcdf0SVc4ZYnAsGyjulX5tkmq/8xBgsx2W8yZWVsBXVk1Wb01ZLkt7mvPvLu+KkcM74Lpx5BzmYZEo1l7ipNeJ3GO7gA2YL9LOcs8MNggcCpzXsC9pVt3ou+yTksnmp6/KzUKws+wyivY9RckbgibEbnmUTW6nXHdPoffBOHVXXmc9EGR0FEWujGgVWfM72kz4J0Vmv9aVExGQ0IwM5ieresWROsoB3NNCXqBpR4d2H/nuvucFRxZ4dQdP4+lgZ4b0Hs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8985.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(11063799006)(6133799003)(22082099003)(18002099003)(56012099006)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jlfATbISHgG+cYdBwVWlK4PvFtzqExeSV1g7AXfbtanU5iliR5ahWJvVuvUZ?=
 =?us-ascii?Q?m3gc5pYS5KqMz+uptiKr0ApfQRxTNDFoZgHmroADUOSHyEkYV4v2/1wBZ1z5?=
 =?us-ascii?Q?OlbQ1OhtUdga8y2DwSUhhJmzhQXzHrV+/crluuBj5xpZpeIdoS1lQDeNmUhf?=
 =?us-ascii?Q?rOc/1iAxwWVS6bfiNJM08riUslOELh1YdgSsIuK/QnV4DoAj3M72ko2Y9lzq?=
 =?us-ascii?Q?IIM/5XHwK40Ief+Jih5e4VdIq5RvEpAHRbkA2IvmEFVQ+Nb0fxZBAtllPiKC?=
 =?us-ascii?Q?Vv66Xk7ymfxFhkkkeMrgbl1paK4OEGERtml7Kq7yR4XWbz5b1YK4kggZ6cZz?=
 =?us-ascii?Q?T1GBdcWx/GHe69F2HK7K9tUTmhbPOp3y20HgkirAD1c43UdQIg2WLGOwd8PC?=
 =?us-ascii?Q?hH5IF81+kXu739tgPcrb3RYBftit9d3Y1q9T8jcDvMOsZ6AhhnJMVOxFq7RP?=
 =?us-ascii?Q?/d87/MN1PwnAh8Wl3uaMc9AqroVvGya0Yby2JE/j83cL8Po3hiNriGje4VKk?=
 =?us-ascii?Q?wy25pGW57yccmejEOGl9pYBj3UPVXQP04+4JQWB1achVDRHxrQUltV6v/oTR?=
 =?us-ascii?Q?KIwHhPaZdH0b0hZ5z6O80tYfi/z9dBP+SH9Nfp++dSAYRw6CXJkWC10QPGmt?=
 =?us-ascii?Q?pqK/OEd+3Lfj7LKWGLeqcXAhSriElDpF5cKJjLB6ujb7tynU0HMANMUPcgwm?=
 =?us-ascii?Q?/wwg/3BzIGkU9wmJwlaI2LHwXXNpOu2tU7HA5XKHn+U6T0Ss/XLU+FpEWzcH?=
 =?us-ascii?Q?O5pd0JDrHEyQuW5jKfNrCNZkkO4uUhmjz+8cakp6Kf0MIpJyDWUsN+sSL24A?=
 =?us-ascii?Q?OFmEwTZqx/Beg83zI+jetIUIvzXKTRttl/uaMMuQNsmwzXU5fzL3lRqp7oOJ?=
 =?us-ascii?Q?S4Kbj0JmWspoDGunEElfdtStAF34P/nU50fzHXeAsxHgzmbD9dN3pxkk73eO?=
 =?us-ascii?Q?ot7efloB8jceTITN0u5I728ZHn1tZ3Rtt5KW4K3Qbw671lUWcy8L7oMnsQxZ?=
 =?us-ascii?Q?aCb3jOj0yYl9dcIMt7wTCKywCnbf33bGJhUmh9C+4PrhB2Awc9ijILdPq5/R?=
 =?us-ascii?Q?EHSaCtMzz+3wdQ73H9BzaCc9theDOF7sz6hLruexf3g43zPTD4EYbxsiVO5w?=
 =?us-ascii?Q?VFT7qiHUwGPTKr6rUwP1LXrBoL342kcYQ87ptVQK9NamDrO1RCYWyYqR+yks?=
 =?us-ascii?Q?5cwxDHTadWKXOTj3RD4/4gjJ7rwmIjADIeTIBw20AV0KbecnN0Qlx1eFGEaB?=
 =?us-ascii?Q?3eUdwooe48G1ltggq+mnlgNTg1s8LH1sXXCvxP9ieLyyqxySFGzVSVy1ALGV?=
 =?us-ascii?Q?wcX4Y3jJyQC4PyXxE52NRDmNnJAZ1Nub384h0rH+E/P9/PAb4xBQOHhxU/Pq?=
 =?us-ascii?Q?o7P8zITA+pCMN1la2sfZsCl69fs2+7Lw5O4UwRe6YUltqcQ3MY4vVUHbBOK2?=
 =?us-ascii?Q?Tg7YfyHP8XSkFL6mN5QGwvwTD3Nruiz66stu4HSo5hiYaUDTniyX6g9olrE8?=
 =?us-ascii?Q?35d1uB/xZ6XfxL5dsPLHAoutH4ycCDpPvrsrXOPiwq1L5pL8dac5eHtcPZVj?=
 =?us-ascii?Q?trlRUMvaHNgDzkZJRcN7l+C8I4swtxjk1JYgK0ORH3O7D5JpbLyWajrpCaxn?=
 =?us-ascii?Q?8hDV6jMcKkSvbmCK5EbX9eE1qrEZTmaXm8jhizy4z317S8drwvrTfFmQHBpn?=
 =?us-ascii?Q?M1NzbxzPJ2y/G/ld76ahN/xtjsnjobozznR06U5vUJ+sK8tA4vFeSUolJPYx?=
 =?us-ascii?Q?e9z4y8tsyQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: X+LXzk+epSWUHO8Z8rLeYiRTex6wfZIB/00iTI0EYZbgEBST9qOXuBuWG3b0A1zL+xLQVFuN2iuxMs+rFxi8+qOT45U1HfkGkPGHGVaQaQmrn3tRe/aeuG3hOJ4p4CEEH0+RoJXMYR6eyirrtaCqzbUVrdomIzgPzIlwLpkbR4PzesluRAiqd76oxNQLE0J348Df7VXIk1yAv/ikk10b1s665lrVVaXzYNzTU9K4GBiP+HDfpiejoqW4hDEOCqalbSV/31EadFwXu+gAgwlctBOGaX7U6igg7VUbCHOcUug95zaTVLOwSQDL99kusaivYOuUVteHma/r45nvQM30dA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8985.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb31e1fb-a0a3-418b-3622-08df1578d7ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2026 11:34:47.2661 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6hfRgw8ZDP+CYUKDKYl5scEYK3mKmh5UY+1q5wq6duTLptId5/i5NQhB4NVc2sV8v5G7v8+SrMdSpLYTfy2dNvyoT5aNX6GqHJlqy/FGuz0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR11MB9787
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
> From: Simon Horman <horms@kernel.org>
> Sent: Thursday, September 3, 2026 1:12 PM
> To: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Cc: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; netdev@vger.kernel.org
> Subject: Re: [PATCH iwl-net v2] ice: fix bound parser hash offset before =
reading
> packet data
>=20
> On Mon, Aug 24, 2026 at 03:22:48PM +0200, Aleksandr Loktionov wrote:
> > ice_rt_ho_set() uses the HO register as the starting offset of an
> > ICE_GPR_HV_SIZE-byte memcpy() out of rt->pkt_buf. Potentially HO can
> > be advanced by user-controlled data reachable through
> > ice_parse_raw_rss_pattern() -> ice_parser_run() ->
> > ice_parser_rt_execute() -> ice_rt_gpr_set() -> ice_rt_ho_set(), i.e. a
> > VF-supplied raw RSS pattern (virt/rss.c), with no bound against the
> > size of pkt_buf.
> >
> > Clamp HO to the last offset from which ICE_GPR_HV_SIZE bytes can still
> > be read out of pkt_buf, deriving the limit from sizeof(rt->pkt_buf) so
> > it stays correct if the packet buffer layout changes.
> >
> > ice_parser_rt_pktbuf_set() stores the caller's raw pkt_len in
> > rt->pkt_len, even though it only ever copies
> > rt->min(ICE_PARSER_MAX_PKT_LEN,
> > pkt_len) bytes into rt->pkt_buf. Both ice_parse_raw_rss_pattern() and
> > ice_vc_fdir_parse_raw() pass a VF-supplied pkt_len of up to
> > VIRTCHNL_MAX_SIZE_RAW_PACKET (1024), i.e. larger than
> > ICE_PARSER_MAX_PKT_LEN (504). With HO now capped at 504, the "HO >=3D
> > pkt_len" loop exit in ice_parser_rt_execute() would never be reached
> > for such an oversized pkt_len. Store the already-clamped length
> > instead, so rt->pkt_len always matches what was actually copied into
> > rt->pkt_buf and the loop-exit check remains a valid bound regardless
> > of the caller-supplied pkt_len.
> >
> > Fixes: 9a4c07aaa0f5 ("ice: add parser execution main loop")
> > Cc: stable@vger.kernel.org
> > Cc: horms@kernel.org
> > Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> > ---
> > v1 -> v2:
> > - also clamp rt->pkt_len in ice_parser_rt_pktbuf_set() to the same
> >   ICE_PARSER_MAX_PKT_LEN bound already used for the rt->pkt_buf copy,
> >   so the "HO >=3D pkt_len" loop-exit in ice_parser_rt_execute() can't b=
e
> >   bypassed by an oversized pkt_len from the raw RSS/FDIR VF paths
> >   (reported in review)
> > - dropped Przemek's Reviewed-by since the patch changed
>=20
> Thanks for the update.
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>

Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>

