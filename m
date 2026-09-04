Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C113AC79F80
	for <intel-wired-lan@archiver.kernel.org>; Fri,  4 Sep 2026 07:00:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8EDB840B7B;
	Fri,  4 Sep 2026 07:00:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5Z6Pv0XCPBBI; Fri,  4 Sep 2026 07:00:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D44E540B52
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788505250;
	b=EK4FYHn1t+cJWBGBHqWrPgtDAQtHpqLajQr+m0D1OKMmQA2gsr4nz73dAESFcAiGwZZR
	 Szgj4KRojs/Xu69iergitRiaB8Z7VeWPGDZQcGh0a0d4yQIs3vKfSCyqhbxEA7az+EoUl
	 sFhJNhmbY+SmxPxfmpJHT/HvSGapTg88B5wRwEEvvqLxUBO3nlKfVxLJK0mUDlAezcmUN
	 fzZsQNGR2igjEx3aW90qQfK+0MWxDLwRRw6jBUbi0UQJTwHNH2r87EExNFd2JfPbauiOC
	 uk2zxq5/UuH90se8Yd0m3mwN+2j76mAFSpwoO3d5O4ZiHHR8Snh3K2dG2o0c3GiSeJA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788505250;
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
	bh=t6oN/IvB1dnKvfki8LUVrMboYjvjkZ6iJrJvULajK4I=;
	b=GOD8oKqu7tK1LDZnctkJT20LKggTen6uG4F9jqGkAwfjp81ODzx6ifn3DxiYwiSU9VJn
	 hWlfuC/7auE1A1eNMaSs/TB+PFmKE9b6OYBhzXoQsUu+sLZUTSFy8Tx6ybPrlHa68EdFF
	 6LMsmusIuR10sGXFp5Rl/kdGejdx7JHoY4PDTpfSwepfYHrvBnD5urhmAnVATFyQb5Phi
	 Zdm6Qk11Yzdx6vd2GMs9sNkUTTkvhk3qDp9aFyWt5ZCTvG+myP4DfSOQmrN8RSP/ZQMqY
	 Rdc2nO886jhRL5PztiRKFOq1wmjdWLCJIEonmoS4hFBMLu1FTr7vihGdmX4brQ8Ho5g==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788505250;
	bh=t6oN/IvB1dnKvfki8LUVrMboYjvjkZ6iJrJvULajK4I=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TnJFEda1kLcp//RG3i1mrW6cF7ov6YEeEWgTiP6JqVedfLe5ZbrbtAS7sI8yY5SSF
	 4kG8i5llnxZ4nPRqlT7Di3zOWfj1AIKplVs8XQsGHz/VSg5bJdQDKN7d4AlRN7UNfd
	 4Ufp/w38A/GM+4WrDUMjzluUnt1+WIHHiTuTEXhlVEgjem2NF6buPGj5+jwzVTazqY
	 39bUjSjMyONeyIRCifZJFBN6B6jusyGn7wEIAezkdCf+euKNpekHEeXedDCqi3o1ee
	 f6c5HklPHNYhSwlMuqpZ8eqjUp28ZLIPjYePgkmkNfP8mmD+WM3pByHVRTbwbJGDJY
	 NoWpPrsOjIPZA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D44E540B52;
	Fri,  4 Sep 2026 07:00:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id ED4572FD
 for <intel-wired-lan@lists.osuosl.org>; Fri,  4 Sep 2026 07:00:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D2E6581153
 for <intel-wired-lan@lists.osuosl.org>; Fri,  4 Sep 2026 07:00:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DTFJdCxtFIxB for <intel-wired-lan@lists.osuosl.org>;
 Fri,  4 Sep 2026 07:00:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org DC32781113
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788505248;
 b=R4ktQwd+8beybzi9DiAgoixyr19Isrm/V5yqP1Bx/elZ3QrSOFa8/DJNc/MgHy0HqINi
 JkFsH9L5Nr5A1C6dOd7sFpFEFAJM43Su5CeR6QcVR3RQFvtD6xTKVrjDLkKyfOYOSw6wg
 VDCxDT35511zoGbYx+oiAroNGcIzkxjv+ZRqXd7HDQ8iL2Bg0VfL2Eyp9lRevvtzsEC1c
 JqIKY7QI6972bhYfqp6XcpfAOYNVJh0CsJcXDwV69MEYlPeVDhaFccAx7VmZWLi++fzgy
 fOOxBvwQzXQPIwpGCGO6rHaa9DU/XOPQWzQ29D5NGvjge+UAAk14Welg/JftPpkhwjQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788505248;
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
 bh=t6oN/IvB1dnKvfki8LUVrMboYjvjkZ6iJrJvULajK4I=;
 b=II3oCaRwimkLmExYmLtUocYadkWLAiw0XeCsglUE/fD1Sj4B4o3QCuiCPV5UkY0K427C
 9uSR3sBRXV1ACYz4BfmpFbqG4YQr09BbaCQq3jtOIoay4x/PdiNZ4g/c22kfz150Bm2QR
 P6v9qsFDw7RunHCchWo3xvnGtLz96WRxKqlQ03EUOYc/6CsCEj7kyT6vRo37oa2ZXfoNu
 BY1fq3gSr4nJnZMVIArnpRt6hwc7o1Z0P9UyUq+RyyZPtbjPiUYbr2z+B29wNWJHQrWMn
 GNpiILhZqGaass2KP0KwnJqgULZZBYwolPxXyOHH+Z8LLWaiNW4b8lwx1T4+dZlzVaA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Co6eGBvT; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.15
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.15;
 helo=mgamail.intel.com; envelope-from=sx.rinitha@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Co6eGBvT
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DC32781113
 for <intel-wired-lan@lists.osuosl.org>; Fri,  4 Sep 2026 07:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788505248; x=1820041248;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=t6oN/IvB1dnKvfki8LUVrMboYjvjkZ6iJrJvULajK4I=;
 b=Co6eGBvTV3tkmhWJ7yDOoMFDIto6GpY5seqzqWhNjrse+9nTRL8KCp49
 yX15E+ntgyYLgehlMsn4BL3p14wO0uXErzY3b3k8QLVFOxatXtGHIZ98e
 ImB2PxYS/V6I4L3e9dJ5phgk10KfShBoW6FOjfiJ0nR+kW2obiUpvOupK
 0TpOXC7S+aXxz/bpmg/Qx9O8NORyCRkM5mThNaEu4i8ooct2JASXPchEQ
 Z77EAGBHP3jDPYQgTcfJWaP4H5SfyiFszIxQHuj0fAMNWks7GpuYFqLxX
 0PFqvyiHPDp6MpOEB1UqAMZ7n105l58zZUiU0QfUcQdgXuVltWYPYAwM6 g==;
X-CSE-ConnectionGUID: LICrXI/MRSemvE09WJepJQ==
X-CSE-MsgGUID: qVsUd1onTjS9fGxBM//4wg==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="89123654"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="89123654"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2026 00:00:47 -0700
X-CSE-ConnectionGUID: PVLxgpHPQBuFGLiQSMelhA==
X-CSE-MsgGUID: bbUvBAZoTcOtpH4g3tqt0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="263760166"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2026 00:00:47 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 00:00:46 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 4 Sep 2026 00:00:46 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.59) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 00:00:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j2JiD5Ho8mdinVTSju2ZKQ7mdvc0bZDzJQGcLWxG8ePpQV3Xc17dEA+Mj1h6pKIcEBq8zowTwR/l4BSCVy8Ish2hkbdKNsEaGEk2v3g56XI8MdCL7E9R6B3PR4NYGlf3erNafcFRIXDJrRhe9jrqeYc8EDInq0oTe4ObJP0nU3k5DUtnUbHVhlDIaqoWOy6bgxIZSqRIdtDpFVcPnDBE4Or1qTo3+E6oejt3CPdzfRM6NtG7Jx63qpBFipYlpbN/O5jxWEcPO4grf7Iy+M8kBvqq8fefZaHUKkiqXdtnNhtmQ50G+uWPVtFVX4VuxBecMyx8yzOijgWRNZU5l/pZnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t6oN/IvB1dnKvfki8LUVrMboYjvjkZ6iJrJvULajK4I=;
 b=Qbi4gBK/6PxdRV8TMy/DJPSVaVStScen7PkyNw/JPFGvNyEzWYgItGIJ5VZsNBzFEwdpV6mbJxpItBiac0wYZ+twoXwXKhp4bit9/QOWtV/KdVdohZs7U4JCUM2rBYh5FfN4t6VoX6eMZwuCjjU6pPmyWlMsFnHsfw6WcK1V5kQWZZg4GgnYBrl0cIIb11zoQyWXo/Z3B1ovKWI9Todo6SIpSdUIeq1iknAUrXOKNAh1lQKW90MwMyMuXmkSSGDwdYXSfk3tv/TlLBN06CjCMlPE1OQBqUnZtPfgzLZgt9KQYIIaY/sl5nBgP147hODiOG1Hd+abVXeRtMJA9PyImQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by IA0PR11MB7355.namprd11.prod.outlook.com (2603:10b6:208:433::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 07:00:43 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%3]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 07:00:43 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: Marcin Szycik <marcin.szycik@linux.intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Penigalapati, Sandeep"
 <sandeep.penigalapati@intel.com>, "S, Ananth" <ananth.s@intel.com>,
 "alexander.duyck@gmail.com" <alexander.duyck@gmail.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Loktionov, Aleksandr"
 <aleksandr.loktionov@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v5 07/12] ice: use plain
 alloc/dealloc for ice_ntuple_fltr
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v5 07/12] ice: use plain
 alloc/dealloc for ice_ntuple_fltr
Thread-Index: AQHdChZJQoAvX5JSHUiUduS4KF2ibLa+UyCA
Date: Fri, 4 Sep 2026 07:00:43 +0000
Message-ID: <IA1PR11MB62415B9434009D43219E35918BB52@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260702103007.97020-1-marcin.szycik@linux.intel.com>
 <20260702103007.97020-8-marcin.szycik@linux.intel.com>
In-Reply-To: <20260702103007.97020-8-marcin.szycik@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|IA0PR11MB7355:EE_
x-ms-office365-filtering-correlation-id: 932d7f69-e1ff-4b66-bd89-08df0a523d0b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|10067099003|56012099006|4143699003|11063799006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: 4OLrUUY6r0a8czJBXbeqZLAoGMsBb6Wq9NTnNJOx2m9+tRoZei+K0tEZcLTs/44QvkL6jACT1qeTiv4dkmGrb6sTdo2FoptgKJ7mBi4VPQrIHNWcVUc4rd6/iwxyLwRcPcyZfIm3gvALHSev88/z2G/3vDoDYG0mu5xl3xMhZVTJ4tSFnYk9GwAxMfbrJ+SO9vjKlhByReMFABGzTPvJUMrgkXMoJ++Mtme2m4mTtIk9zAup2et91jHsbpHmffnXRjiqpfrfANmLEeaLRMaKOeVJtdOEVd8uVftkfsPnhP2QvoIQ6MmxrbunLERyj2MpuqfijLbQdkGWfgjkO1aETGCbjuxeuTL+nTAtkBZ6PSKpoJeLQk7XCDazpXEGWJZzpfDi6ylMNV42RY8wRDfaxKS1PPIAz9OmhpZ1WtspANF4p3xkZ+fqXmuxz96G6yJxw5hdaIHg5/p0FZfYvbAPxKGMX2oBRMSGB0x97U6DjPappM8x0fXzeAkLPwvLLerLUYFavZGvcwHgIyVZHCxk8xMQRwb3GTSNq4m7HN2kTToXYJBxtogQyVon2ecOWx9jWkKfZOtBxdBCMM7opaobPtiBgrxIGw7RI/7q0xL3Ld/x5oM+YYNdfzc2LTih5Gba+mujhoRYtGDbaHk8j/QXPat9nyw6tFRjp2fj60w1dkW4iHXsejNBZt/wpzvZ5xPzMtRVo0Ri/RM3qRfhcn4rlogT+azk4XTHTjR3nWq6nXA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR11MB6241.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b4JDhFa07DP4V1CmreQeMVasp4O/NQ7v97V/dBXXsII1b9H1yV9vxAI73qlW?=
 =?us-ascii?Q?zyR/w6w58KTATt1vJ3oUPBxZRj/RFKrpuJx/vJr/uK5M7G7YFhKVWV6boRAM?=
 =?us-ascii?Q?dzYjwJjFfCNycZH0stxxWuy4hLW1l8KbzRpRIU66jv3g51O4Pt1pGZ6oXuPU?=
 =?us-ascii?Q?coqOgrZp8uj4VvcNWalkaySd9AxwLZ4vuqYmjJke1EqyFbCOfddKOvhXOM8d?=
 =?us-ascii?Q?2SQ/hoPeH2rNmnGY0cpN2XjEKwFDanGdIa1F6/t0FhbV2prXk1ba6OlDIoG/?=
 =?us-ascii?Q?SmxVn5wfnpamzuB9FMMUl5A1lAs//RmCkuO7GJs29mvfpfF5lJBx83Rq07cR?=
 =?us-ascii?Q?KL5csyECLD1oQD0QtOQ8x4f3XmCc4eDBH1PUK49tultpIHnVbXIi2W6hn16o?=
 =?us-ascii?Q?W5c612zboRH1NrsjbcPKUswIl12N/Z7K8q5GRoUZXpuM/i4pMs8rIexIBqTO?=
 =?us-ascii?Q?wJ0B9oFJKFFKI8Tx0X0/SL6pJD5OVd5ILwzZoQ9cSN3xbUmgTyU/vKbNmy/H?=
 =?us-ascii?Q?nenJhWBp+bJmtE9OHb7FMUwDMeBKJPyUSQAmAS3kBzJftobd6joWqf/TBxrY?=
 =?us-ascii?Q?rkvBCaFyCR2HzR+fZwKrVgI3KivzFw11wtDWGzAmkIDq3aR4DtksxFMg0gAp?=
 =?us-ascii?Q?BZ/I3AzJYezpr7YniimOcLDb537HKm7jYXx3oMwXdCj2YPqbegFH0l8Cy8/r?=
 =?us-ascii?Q?zz8cKS9RJr7HhjHRGqXaH8h5TJxpXR9+o3lGvQv+QNt19jiWYOqcP7xSpt4T?=
 =?us-ascii?Q?z5LAg5UJPKBU73RBP9l/KROU3RabJlaT2/9VfPLYGr0/C2QYbUcA4g/lT/WK?=
 =?us-ascii?Q?IsyZg2KkdFG+VJmcGE2jM1LSMedViZVfMhzM9kxFfcxunGeYxOPe+mHS1sP3?=
 =?us-ascii?Q?RTUB2z/dnvgma34CMQcGB8kVFelTMdiavD7bkDFoVnChgID4HAtuWigHNHSb?=
 =?us-ascii?Q?Jur6bidtDDMYnwWyrW6ocBKP5Crok19bl7WZpHw0Rm117Jpb0t0Bhckly89i?=
 =?us-ascii?Q?4mYa7rYYHHRIWE5s01r3oAwvQ1kHR0Q8bAc4ImUQ9KFE6IZi0yMQ4TSwXj4z?=
 =?us-ascii?Q?W7y/sKOlV3oqLq6FdeRRnmw4ajhswD9r9cYAZFogegKSLpvaNX7AxGjni9tg?=
 =?us-ascii?Q?tslEy0twg4JeZX1DoHC1dNdTUQuPMMxr8jrnsIsV07x0chUvvot+957Bx2hu?=
 =?us-ascii?Q?L4N2ArD1Jy0lOblWvH12WIqu4K0LZhmhDPG9geFLKXX8vIZvR8nv8aOu6ltT?=
 =?us-ascii?Q?bctClyn2ilc8O3xc97AzxJKl7HgbtYSGIDYHdCGFBJp1kbD0yLi5ewDm2YWX?=
 =?us-ascii?Q?Jjv3YCKztn9iLvVh+t/VRy3kJW8ihakPQgBzR5KKzveFFUgrisOhKaGqswWI?=
 =?us-ascii?Q?P38CUAwo3eR7SEpril+MArkeSOd1g1cAzIuV/BRVuaw0i/weSyMhM1y3oNz0?=
 =?us-ascii?Q?2B1jI0NL4Php7bb5LxoA7aOhicYMI1fbJtjryRAgVr1uxueYuaE7/o+wje96?=
 =?us-ascii?Q?FLNycLcCPSnzMtWnJ4So745tXJOYDbxzt+mqJ5C8xrUJLmp0qQV5RljBSa+e?=
 =?us-ascii?Q?JeCRqkRpYE/khR/R3aeRYtxg3Y3CS2N5v3ASj/E/6hFaJQ42R72DYkQOC7GC?=
 =?us-ascii?Q?f82Hwww+dbKwV70zZCeB8m2lWOTWMtDSq9iJis6GGSFoMkE9yxfCmOZjRVai?=
 =?us-ascii?Q?0118hLeoeGZcriVaka54+c1s8hE/iqOCnAgrr51+qotOxYBb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: JQ/q8F1Y7bAegfhIZ9PFjexYVoRVAmSJJXpwU9y+Cj4UTIkWAWN1lpivreK/tmIucP2mK1fo+2HJ9udQ7O2XluRXFoLA9VHh+rzkkFL6CQTT38JzPfiSCKGh2Ht6HHjgda04PVwEU7/hLHDOksDa4VWvt6Uuv8yVM2fHB5uhycLlw5R02JT3/cwlgC0ZYSOycHVf6pnH7LE42a/0Y56Y3iQ7lQvml2IWeXuJv6seRIdWp5A5Cg06dP4e72Ok4MAgI/A7JnnFRdLtzX32LJ+yrOzr9A89YC0/W8FZGGMqDGBG9NLtoynsZmXkInnRxakuRrofHyVEAGvm5uqylmHkiA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 932d7f69-e1ff-4b66-bd89-08df0a523d0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2026 07:00:43.7356 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aY5YQBzQo2t9lnDziJJWYqd/juGXc2j4YYWBe2QLKN0pzfwX0zaUA/MVkLJOuHE37nWVpCOnSsZK4Ra1889k7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7355
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
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of M=
arcin Szycik
> Sent: 02 July 2026 16:00
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Penigalapati, Sandeep <sandeep.penigalapati@i=
ntel.com>; S, Ananth <ananth.s@intel.com>; alexander.duyck@gmail.com; Nguye=
n, Anthony L <anthony.l.nguyen@intel.com>; Marcin Szycik <marcin.szycik@lin=
ux.intel.com>; Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v5 07/12] ice: use plain alloc=
/dealloc for ice_ntuple_fltr
>
> Change struct ice_ntuple_fltr allocation from devm_ to plain alloc, since=
 its lifetime is not tied to the device. All such objects are being removed=
 on device remove via ice_deinit_features() -> ice_deinit_fdir()
> -> ice_vsi_manage_fdir() -> ice_fdir_del_all_fltrs()
>
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> v2:
> * Add this patch
> ---
> drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
