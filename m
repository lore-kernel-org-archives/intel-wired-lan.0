Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06267CA5FFC
	for <intel-wired-lan@archiver.kernel.org>; Mon,  5 Oct 2026 16:10:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B5B4580BD6;
	Mon,  5 Oct 2026 16:10:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FhYPLcY3saxg; Mon,  5 Oct 2026 16:10:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1643680D5E
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791216624;
	b=aJgZ7tSm4Yjl5Bk6rbREjcoO3Fc0h2l3cQMEFhlsc0GqTt3s/rvy0YSoAbjgQF/VoC+x
	 lOvFFNCcCJqtWK/eeT2Yd+TC5nTi9Fh/KAAYabHfTj4685VApmXHbb3mb/FnzDDDH7IAh
	 UlSO3MBl/4dOnSfKdiQwKYvdKv9LdEHOi4Q3ZczplMUXi5rv8m99Z/QniWGlLVEE8Zj+n
	 zrczy2SSqZs2Ivf/2PKR+fDiff53c5W2z8rDjzgKw1QpugXEg93YokBdwUmbuGeRXWTsQ
	 D4IOF7eHSF3+bV7jqdk5xNNzilTkyLHqktvd5cwy7FPS7lyLUHR5Nt83ONT+yDz8mBg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791216624;
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
	bh=yKLcsahXOv/QkNN0//hja42FXaVQ47Ihbyy6bVmESM0=;
	b=rAxRqWkuKsgOZmsuCCXPGOoLCNp8S6u/MS940l1nMJks/USRz2DL9TQefstzgiAZcApH
	 SzMVaWf4/ILrAIF73IPWcJs22PPpUQPOTmkJhQKo/LWTjcIOBE9tIcdKlbYrte/+SX1V7
	 G7I7cK4awQMEbZwD4LlO92JYOlHTHPKhDdMx9r36V4wz02w0DlxC6Af4FwY1LXxgIPrw2
	 ilUbfo8JvBYLuuw/ALM2dCJLTQoX/2sT2KbRGuJNkyBT9Oj0yrZXB+pSD/RiJPsKaKkVM
	 dhfbzANmorZgUeltunE2ogRQQoWMQ3DwxPLWEzL0gvew5Xb+MEPU1aiMzzAdkh9NIXw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Otj31gi9;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791216624;
	bh=yKLcsahXOv/QkNN0//hja42FXaVQ47Ihbyy6bVmESM0=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ycu/mVmedGC2Wkv07nyqc5fFFVpUo65ZQvJEiKyDi6VcCTLQUqK67Ac4oPlabQmzX
	 Vs9fnB8TT7Y09JJuhYyaA6Fd5Cr25NpIPnZ4zzvT5dQRkf5uqWpEgnGDDfQT9qOMsE
	 7wV77wLO2wzYH6OHWUH1abf9Wts4YiOKTG1P5kzFC2b8C/MS88m/pkqojLS6vZx8JV
	 TZ3J7KJJLfi2X8rWYE+cq+DgCjIHGGiQu13lMsov029vPxgHxPEol1xIjKG1NrDNDq
	 y5c+CU1KOF/PtkvaA8z+09jSiAeWUMxdMXwj8ttm0iraSXUVQM7iGCGxODKgmVMr8u
	 1jnz4dXcN5l/Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1643680D5E;
	Mon,  5 Oct 2026 16:10:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4CB6234E
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 15:57:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3E67480D7F
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 15:57:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ygqI_fp_orEp for <intel-wired-lan@lists.osuosl.org>;
 Mon,  5 Oct 2026 15:57:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7AB4280D7C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.18
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791215825;
 b=BlHYY8eLVJx62N07UZbUu93gIHp2lS655aldWP+8VzboveuwvEbl2X/rNZt+AaqymEDo
 mqV+pLB2mPEVLGy1zrEMdhO1NKknGJctvqboQG+Bsd8R7cR1+RADb+ftgRFlhWnV3gqv7
 OE3RU3e9eICuRAVLnC0tOoV/co+OO7xVpNs7LF2wIqs6iKAcvaFhYh1leVc/Sbyc9bssb
 f2gqOgnTGA9KNVKnOrGUZ7p4rOhXQrflNBisanaLekzGPA6wJZl7IOlesjtECh/6Z9P31
 clW1NUISQNz06FJ2WoNdmiVr0eZvTGHkXU5PapIW0v1LiWgzewTgh+Y1Pu9aup+ADlQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791215825;
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
 bh=yKLcsahXOv/QkNN0//hja42FXaVQ47Ihbyy6bVmESM0=;
 b=rtB75uBRgB8rnR20z9P/75NIffxk0g7KJ9HJ7qF2rM3/bCPR/EppXRgs8zuZ8MZlsBmZ
 m/fAOnalpQ2iJle1VFEHsxw1vmH1NT2ss/MaNAsQMGJR/Is15nesqmiUO8yHjtPXQOfO5
 3Jl2TYN7NzBTszbrQR8YlAATot5+C3qVYXiBX14AZNBLCzERC3SIKojquUHqGOnYIfnvY
 MpShgtn4nQavth+5EkEE5xhagCo2u8XD2SsXkKd4d95fdJz8o/9/KFYse9Z5N52GEZYIh
 XCTm1GHUpay7P0k242bBJiKRHw+25bdkHMuEfcJ6vUykPdlF4FSTtnzdSI8splZ7+kQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Otj31gi9; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.18
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.18;
 helo=mgamail.intel.com; envelope-from=alexander.nowlin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Otj31gi9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7AB4280D7C
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 15:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791215825; x=1822751825;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=MUsa56BYciwn5Cz1551gzz42Per+lLE+nZGdcU4728M=;
 b=Otj31gi9mNWV3ke7nKQThNhEt66ImTT/ECsh+HvBPV8gKCIkTfQ/5EDc
 Ws/A8zRHnrOg/2v8g4LbME6NjnaKNB7KPz6o977QlJQgN/rBln72XpHA5
 kdR5hF+aJns7EI4nzyD5DnayUAYkanlg5f4nBMte8idslNpjwk5pJIFm6
 PYtumJS8zqU6EhTUke5lKn4aSruME7fjvczzwynTGAsiuSPjry6Z0QGYe
 rNkgfhmcMwtBVpDgFd9Z7Mr000vXTnBsIglHvX6JHp+V5iWajlHqVUGYM
 Orn6rFiKCuImesvjNm8gKIdZmOvIrAAbPQPGQbc7aiSlP8TXGuPhR5Ja3 A==;
X-CSE-ConnectionGUID: juHxXOcwQs642qKMV7P+aQ==
X-CSE-MsgGUID: EhuQA6vfThWR7AFzLy7pQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="91021955"
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; d="scan'208";a="91021955"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 08:57:04 -0700
X-CSE-ConnectionGUID: Gkq9dGKhT4KWRTjX39x9mw==
X-CSE-MsgGUID: SRKv+DQ/SNGwmNxgcBRxCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; d="scan'208";a="276974553"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 08:57:04 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 08:57:03 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 08:57:03 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.57) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 08:57:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TNLSd50cX6q7DQFRUR9E2FTshgc1WGI4znC6MckKl3ywmI7BPIRlYf8i8s80APNmRdtzK15hukDcr1BkqULg+oT0q+SYvlQoLd7hx/IWTzgmqA3AapyTaNVMynXEtDmcV/U85l4Ducc7av1qvdizAUtnVAp5Epu1wKS1qcomUkr2t9KusJIwkLeexK/Vh7LlX8QHpzH3but4No0j8MmdTVm52LGg6TQeW13PYep5WaJkrFWKkYTfQfDs779v64A9tBZc3QsA42PGYrMEoCpq86olY0H4SVhDHaLKEE7o9FNmpeXxZRxatvmHid8we0t9UDIKW2LOCfLfu6q4zxtJ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yKLcsahXOv/QkNN0//hja42FXaVQ47Ihbyy6bVmESM0=;
 b=b1kYFeECiKCya8u1ReBabfG4picqiLnKvEsDai7Z1f1QAy3wdv2q5W0rEt+C+ZnZshNEX/9XCj33FP039T/zfgchuGknGaW/4LPsqqi1oGYlyM44xze9MXDERook5XPHEVa2TVclfMSsitAhUfg3pO1/Zf6oF4TobpWoNskRq9MiwN7/mWaDzz6Ko3av3vRF1kWgGzF0mdNxdObmZDCLblz5yE/eo8AxpMDOWe4MJSzq0gxFVaHggFHp8CQA8fXNQ6l4fHe4OvvEch4UI/Z+nihiOlM3oj98zkwmPHjDk8rX4IDC2uoBNm6EYHjpCA+RMs+EPQanUf6l8PYua7AXTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by PH3PPFCE69B97EC.namprd11.prod.outlook.com (2603:10b6:518:1::d4d)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 15:57:00 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 15:57:00 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Loktionov, Aleksandr"
 <aleksandr.loktionov@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Simon Horman
 <horms@kernel.org>
Subject: RE: [PATCH iwl-net v2 1/2] i40e: fix set_ringparam error path freeing
 live Tx rings
Thread-Topic: [PATCH iwl-net v2 1/2] i40e: fix set_ringparam error path
 freeing live Tx rings
Thread-Index: AQHdMW1QjXH+nHJpFUGQrl1EhuueLbbvYUVA
Date: Mon, 5 Oct 2026 15:57:00 +0000
Message-ID: <LV1PR11MB87902717E622DF21B3446E7390962@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260821130157.1451118-1-aleksandr.loktionov@intel.com>
 <20260821130157.1451118-2-aleksandr.loktionov@intel.com>
In-Reply-To: <20260821130157.1451118-2-aleksandr.loktionov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|PH3PPFCE69B97EC:EE_
x-ms-office365-filtering-correlation-id: 18d4a61d-e3e1-40cf-06bf-08df22f94a8f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|6133799003|22082099003|18002099003|10067099003|38070700021|4143699003|56012099006|11063799006;
x-microsoft-antispam-message-info: 9AkEPeuLz1u96PhmmX2ccd7ySJ+cd79KaW03I1+CDosigKTEtOXadR5R1z1izqbveynyKwzG4uaPsiPuacJphhIfrNI5mqijTSWujxG/sJqsOq9sUa79247I/ikcabSJ6X++WELJ8PM0t6UVpCFQUdOwKyQB/d9XTQeo+DRzSZ+hO/11NaCV5jwxusHpkB75lba1lZXU+5FVWqyrKMb99qN/XZSW+H+Csfob3IK/utxQ+c8sNietCtj+6tvVTQ/RFEoGTZwbTVHZwIJQQfx2cqFB3TN5IPs6uvfbWWvDFzL0U4lQlTlfH4/X8xa+YPP4y+B2KFSAKVXiT4Ug9zc4q/O3p0HxtNlEKa/DALXcKkN1PvFNuHSmtbrvPzqp352DN42VEiReQm4BAtHHHPF9izF9Do3KK8cMQROHvcBCbTV7TKC56CRDctnJzh2Y2HqTbvhk5WuJht6S/m+ixyMb4pENsq8JKy9txaHOs0Yhkx8kK6KGY/IXEGFvZiJZFjA65OAAnk7SHHIbPK5/m+gk1w1JSG2V+Gitgvj2iPPAsnh10Lg/bjVaq6uI4ZmVnmEhRKNFiFnYzw/KUgkru7M5ysvQCCgHCRf0co5Nt+pmZ1g1Po4dS75SdJoWr/sUqzK5/u/ALqkrv/vZcw2UEMSw9/YVb7KS5rfu6Z/MYjCSdw0vOvvzPrMN/YckOXItJsL5FfxqbcQyeKuERzISy3Tli7m2IY+D9A3QZIEaO4Lhc6Q=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV1PR11MB8790.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(6133799003)(22082099003)(18002099003)(10067099003)(38070700021)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FTgxdtbtlIcYiRG2cTEOENGdfHEJco3dfPSoyfNOD41Bi9uW0kaAJhZB5Swq?=
 =?us-ascii?Q?gJOXf+YWISP+oDE4Wef/3hpxcEkl5ocGmqDWIo4Q71ycHCLLGM3Lw0uQyMiF?=
 =?us-ascii?Q?8aWeC9UvioX0XNObAuRRjp+CyXjeZZZrIeLnmbSN9/mvKDFW0JC4XH4My7Pa?=
 =?us-ascii?Q?GMf9qDmi/kWUJuPTmVFslX2rXAm0+5umHVM8zQyicpUREqtojAKi0g/j0ix9?=
 =?us-ascii?Q?oo044CHk7x5uWDYN6Gn6xc/hHxNC/E9D22ucd0iO5hTEeZAK0qMWsHUlliR8?=
 =?us-ascii?Q?SfJBW1rROq4AHBClzg1561s5PqhACgrBlH1O8Umz0tGVf7zkgsIMbCd0Z6Ie?=
 =?us-ascii?Q?q6IC0dyQBuvgoL0jRgvGENYlvdyHNvVflrWoyVmORevT1QdgfaoUKgMug7+S?=
 =?us-ascii?Q?Isk2w5bpEjiPg0pzUJw0hYjhy7JtPeuxQ8xvZXT8X5DRecubp8P3+FVCjnhb?=
 =?us-ascii?Q?u7XxJ399hzymBJ5N+4LaPjGzYYOrxLl1DfaWfAm8v69/PL4C2zZsUXJbN2G/?=
 =?us-ascii?Q?K+UZYm1AxiSlc2pEz1lH21sBMW81//G45zyKIzZRGdegyxQ3z4Lhki1E29/S?=
 =?us-ascii?Q?PrqYNEjMntSXUtFWGN+qzI4ZdFkPMWRAPo0ya0WcR8GbYRzXJZsgLtIYAstP?=
 =?us-ascii?Q?CRHusjqCY5UOig/E3H5Zw9iH1m89l18EIFUZU/pqLEhhTgAaihdcImrwCiz+?=
 =?us-ascii?Q?r/x+lBognsCXMCKt/FI4jaf9nY5UFLFZ7qfc/X4WOrut6aK9OlpeYELf5vIg?=
 =?us-ascii?Q?GX2k2pfq6D7lu6Jyiry3E5ajAj6YlER1MsaozizYCie9KLJnz78G82kuG31j?=
 =?us-ascii?Q?oik50hCvp92ipUgVgAtnoCGQhIS0h8ICseb6p5GhFVAMiVUxfbDfxf71HH9g?=
 =?us-ascii?Q?StaCC1TG3yMZ5X9lQljJU29O+0mMQeHoPYgC45xECi+4V4LfzG9Yf5tu0TV2?=
 =?us-ascii?Q?qBXHr7pUvzC/J2MTQwIkAAkeauIGT3YDlOBH6wkmwmTkyG3lGRzsbF3oCnGb?=
 =?us-ascii?Q?kQja4zHWbBUZzaaZex5iHTyzz28zrxogrkjm2Fje2o6j6hj5eqHShHFZN6oV?=
 =?us-ascii?Q?tLzpsjF70t+wNLS2O2T1vaQQub7GJogXCju3KIZMppz2Del/rSjJC9Xunfq1?=
 =?us-ascii?Q?WZ3lSgoEXovd+N5OTYv50NotB9yT+22ct67QkBuYm9oPTVDPQwagcRk35Yl3?=
 =?us-ascii?Q?vQhKDrFT/s03Bk7S35Lv7In4HQhg8l41fFReUGehkwhctHMeh9yZF3a0MGI1?=
 =?us-ascii?Q?EVCwmFVEny8e4vqhzc98P8WAECd0Iz+06Wae2xVTXCNsKvH+bdPKOvL4z8rH?=
 =?us-ascii?Q?6WXrh3rq8WQO3BlQezjlaQrRqCho/vammTDH0RAKBj1g5YC3OiTCWbs0+pxF?=
 =?us-ascii?Q?8fenQ/WpZ2Zf8n7Q+/sJxOVArPjV0rqOxdF+Sj+3afrbi4pz9WQAYwPp1Ump?=
 =?us-ascii?Q?XWwWKyXIpaocv83MkMGkBOE7PI4YKbnsq5dWehnhbnwmsIVhWu/ryxkWepWd?=
 =?us-ascii?Q?n1H7p2e7J/Ye/M8h/dtqF55ZrgiiPUeCkV93PMkKGpI8KcKhBr4sFQ2mLQJY?=
 =?us-ascii?Q?hjExNTGBP2tc2+WnN4qa1hdchqNvcaNpI03+TxTjIY3hx9Ue2BbelbKplJ5O?=
 =?us-ascii?Q?Ld+UCYnA2VLN6nmWSIup+NIzTd/7YIIWCeQC4jF7zCAoZkCKU4xXKSNbgksM?=
 =?us-ascii?Q?HAlSdQ7Y5R+Ejae9S61WnjUZTxclOGH3x5PZDoWVuPOh6XS9Qc4xB7HMEx2e?=
 =?us-ascii?Q?pwiseJknjA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ENBS1HAUQhvET3MuI7Ie7uL2yftx4AIIcvRJeOgtFRu55nBiDmVmPLDjhByb5/RSG2rFdRu4cO6wp98E/O6Gf0dK7y6S+ZV1MiZu3xJYC0QB6Ef++tKz8PlJPRF1KLTCrgZDkq89jWRI02UjbV5cCYLYKYHLFBlno8tqkBKGeB+CI1buA4KDexBZQGUXOEcI/IqNIwXwXIJt0dabvsCIxJ2GUpu1SPWfQCrcH+OdzBT27Yg+mvLDdDQene3eec9jySHfF7jgZN0rKvZjFruOKeoGtI/3UYBQtb6REeyo1bRFbDE6SLC41vvnULWqREE92z+NDL3zVcXndl1qgQJ7+g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18d4a61d-e3e1-40cf-06bf-08df22f94a8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 15:57:00.2795 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nF8xnIqHKzg1BazIPuJ2SkuNGsxKULi3XjfN50/Ho+AxiIQ/wuI7Mwa5+EyFq1EJDdW8zkET9CtdYrMO+Pf15vPJT4J0c8aar8WnDhdqDZs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFCE69B97EC
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
> From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>=20
> Sent: Friday, August 21, 2026 6:02 AM
> To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L <anthony.l.nguyen=
@intel.com>; Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Cc: netdev@vger.kernel.org; Simon Horman <horms@kernel.org>
> Subject: [PATCH iwl-net v2 1/2] i40e: fix set_ringparam error path freein=
g live Tx rings
>=20
> The free_tx: error label in i40e_set_ringparam() is supposed to release t=
he temporary tx_rings[] array built before i40e_down() is called.
> Instead it passes vsi->tx_rings[i] to i40e_free_tx_resources() - a pointe=
r to the live, NAPI-active ring - rather than &tx_rings[i].
>=20
> i40e_free_tx_resources() unconditionally NULLs out ring->desc and
> ring->tx_bi.  Because i40e_down() has not run at this point, NAPI is
> still scheduled and the next i40e_clean_tx_irq() call hits a NULL descrip=
tor pointer:
>=20
>     BUG: unable to handle page fault for address: 0000000000002000
>     RIP: i40e_napi_poll (i40e_txrx.c:942 i40e_txrx.c:2769)
>     RAX: 0000000000000000  RBX: ffff8d0a53ea9800
>=20
> The trigger is ethtool -G with a TX descriptor count change (so tx_rings[=
] is allocated) followed by i40e_alloc_rx_buffers() returning failure, e.g.=
 under memory pressure.
>=20
> Pass &tx_rings[i] instead so the temporary rings' DMA descriptors and sof=
tware buffer arrays are freed, leaving the live VSI rings intact.
>=20
> Reproduced on real hardware (XL710/XXV710) by forcing the Rx alloc failur=
e deterministically instead of relying on real memory pressure; confirmed t=
he box hangs without this fix and runs clean with it, including repeated ri=
ng resizes and normal (non-error) resize paths.
>=20
> Verified via git blame that commit 74608d17fe29 ("i40e: add support for X=
DP_TX action") introduced the incorrect vsi->tx_rings[i] pointer at this ca=
ll site.
>=20
> Fixes: 74608d17fe29 ("i40e: add support for XDP_TX action")
> Cc: stable@vger.kernel.org
> Cc: Simon Horman <horms@kernel.org>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> v2: No functional change to the fix itself. During review, a related
>     but distinct pre-existing hazard was pointed out: freeing a
>     temporary tx_rings[] clone with i40e_free_tx_resources() also
>     resets BQL/dql state for the live queue it was cloned from
>     (i40e_clean_tx_ring() -> netdev_tx_reset_queue()), since the
>     clone keeps the same ring->netdev/queue_index. That hazard
>     predates this bug (Fixes: 9f65e15b4f98, 2013) and is also
>     reachable from the i40e_setup_tx_descriptors() failure path
>     that this patch does not touch, so it is fixed separately in
>     patch 2/2 of this series rather than folded in here.
>=20
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
