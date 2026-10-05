Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B9DCA5FFC
	for <intel-wired-lan@archiver.kernel.org>; Mon,  5 Oct 2026 16:48:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2977C60678;
	Mon,  5 Oct 2026 16:48:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aXdmmLhHIBXW; Mon,  5 Oct 2026 16:48:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3DDA060725
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791218925;
	b=KsDgH4qQYCeP8fFCBw5jRNiCPI6zWqApV0vx3U4d9cLHjC2HJGu18wiDh7w/ztXHHyTX
	 a7VKAYorSbPeUhB6mqo6qa7Ll81t/dwpsNfjgZ+V3vJBrJNvgbx7hFVTkZxzHmN/JZPIY
	 ogmnCNZy84VPRLz5VeEZ3YGJJrMM6/B9rEEdm0H9BZQSMlgLDF9PeXVAacRdabHt/aE1f
	 S/vr9BNn2NLAnG6kVBmwKgp/gx4MArKQf46XdTzRJnaF7NrsXUQujMQCSKQGMsET5NkKh
	 adOmNtP99xQ2lg28NJvVOeDnWkK7RHq8xgiROW2PDjzTrBOT3W6EIpX79t1Sv8DLUeQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791218925;
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
	bh=AeL5SGV4rUFXRrlJbmKN5hkrlQn24rhB9mCNfvTQ0CI=;
	b=FCG2ABNcHWohFOdjHpGlyKaSaFp+hLM6QeskdTgAjp+FaJjil2xRJl/aqcih8KsChQlf
	 OuLaH6G5fCerXQDHNizXHEfjgv5VvHGS27JA9ehH5JfylwAeaP6EuPxYGquvD8QZIyL2i
	 9Nk80X4kVezP0Uo92ZXgMOyFiZY5UkGO86GdbqRlI8Fs0TfP4MAaVjxO2iH2meY7RBFvY
	 9QNTszJuENK7Pc7sgGlN774Ryz4VZHgEfQXTao29jSuqI8Eq7T1RX+X2V3JZeSlIX/RgI
	 qIq4+xgz98m7jEazzOHLlFhyOuzBZHNDbcLRb7luCbPkAyehhVSUEKwjclcOt8wnUkg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gcbRD+EI;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791218925;
	bh=AeL5SGV4rUFXRrlJbmKN5hkrlQn24rhB9mCNfvTQ0CI=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UjpI9wQY0NJDNay/Lfol5z1bAB6pX3I/IEwGBDQnLcfuED5c12KFTd93ahiFZoMGQ
	 xSYS7pGMM2zZmtrw69R20lFXGPTNfLnPpRDgWEzvZehpBKdtpB7oXbU4QCdRqVYQlG
	 YvvY6qBi7d8kTxLWlR9IT0UnZbv1QzXw7oTLum8C+hyHJbP17p/mgZu8jgiN6UMHq1
	 arpLmp5IHTJYdts/Uh56b7iqms0fx8tbETDYrs3CyB5ByiX1dJMpXNfShdyKaQ5GsZ
	 01vyp4p9n0PFNmpLK8UwiIp5Pfo9hD1KluD49e9OdLRDdqiGJAkDwC4GpQz0W+zD6M
	 COqvqpx67HJrA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3DDA060725;
	Mon,  5 Oct 2026 16:48:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A323F1A6
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 16:33:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 894F66072B
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 16:33:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tXp7Q5fDKojW for <intel-wired-lan@lists.osuosl.org>;
 Mon,  5 Oct 2026 16:33:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 46A5B60725
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.7
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791218023;
 b=aD81AXW5Qi1UK/dLLhpzMKBCFhr4ouFBH7tVjRLij8dSjDdz/WH4XXJgfeAfPp0M4Z4q
 zFnN3KA2mNTFA4sNmCMwSi3vjLxqgxa/Uv81ZwUu28/scTIsttBH1uB5Ehd3jPjflbqLy
 KH2f2rSbGfE9cDEB87LbsnXlR78GxiyTD8J7mxCsqkJY52srtInj682TEMA2rwhgYJz9W
 Mnbr90yVBr696gez9PV0hpX4iqup4rVj5XjFXzwY7G+FT2zDgfdbJ1xMJwglwAP5doal8
 HrnqMc71hanYOjiBhgPBSRXpcA3rFGK0l+F7XQqpeBq4+xRSAizuQOpnLbSDnQD5lPA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791218023;
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
 bh=AeL5SGV4rUFXRrlJbmKN5hkrlQn24rhB9mCNfvTQ0CI=;
 b=ESPnN84gkLnKDCMx8kVm3zCg0LYG+VR7Vn5HDopmAbPd4vvQ/M72zhm2/NWowBouOPFH
 hfxn5dGAakm5a8+v30il7NClmCVF+tqekAarqfiL7h7ByUL5YdtvzfSBRq1JBGDroFCqy
 couH4icfpolzcs2FZ9fTp9S+lhGwT3BrnJFOhRYNVosTfB15hnfgxlIIV8jLd5OrCAtSq
 sNewCJ3fCMA2JXxLVwbbDVWVDTIepUiscCnPcIXQw44u3zPzd/sd4J4N9W/LmTRbY6BsQ
 lQHPWkhkOqinX3P/4wKmSqrIVR85X0zx918jDfbhdmBjva50HRdhdAJ3OmJuaku0nOQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=gcbRD+EI; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.7
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=samuel.salin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=gcbRD+EI
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 46A5B60725
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 16:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791218023; x=1822754023;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=JVuan3HGDGkfntoBHU3K1cu2PnUqXAafedtKOkEj+Es=;
 b=gcbRD+EIm+T3IOSYZPPf8rDeZ8NI3cT8E0prvJbaMlwogOq9Mk68OsAG
 V6tVjWmvSo2f81xYJoiLWoO6ek8t/wSRu1XTLtIdMh59gqipX406ecOfi
 RJMKXzJS3933536ccV41dQjFApMQipTEeO5AHxKp4ni2SjjYDB3qW6RcZ
 AqCLrWlhx9auFvLYAoX6YVZBxnLJZRry2OKtp/Q+s5W99YMo7Ss96EF4t
 h6N5DfdY8QewII7olDW7N1gGzuQ/vIPcxR77MffR10BwIO2Udw6QEV+I1
 jjqZObQLwovGfj1IpBpm0+52DJRTBj93StobrVFabt2398fiE0ik5mFYw A==;
X-CSE-ConnectionGUID: Z8jIQnwVTruAg2+eXl9yOg==
X-CSE-MsgGUID: VVWH7RHOQUKWgUywPPVnzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="117411055"
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; d="scan'208";a="117411055"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 09:33:42 -0700
X-CSE-ConnectionGUID: IQnePp17SRGOFDAoVVziLQ==
X-CSE-MsgGUID: WvD53x3+TB66lAmYXoZSYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; d="scan'208";a="276390006"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 09:33:42 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 09:33:41 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 09:33:41 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.57) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 09:33:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ySuO/t1/OSE/sbdHRwjCjRjrc0R7KkmrclTf2LV0odJYj50OP1wUbSx+k9/R7nEWk0c8uAAi+cY7F62hfojHNat9VtTPfU9eu8p5y/XEX5TNu2kk+nCpaGVmVcXoWUcM/8Xyxg8clvnKS/+yXhPv9VyRgVwm6f/UFDxxBXPiGruBN3P1tIqVqb80rYY2t/PT6g20wf4kQzVYGOdvudsymvUj/QVumH1sX2SfOPHD0hMpOhiJupibqnU97fvw6uMttY2YFdJv7lMzdZTQbV/UBfmj4IfKJP5JFseJGQN5Br7yJQVOmNySMISJtQaUksjk3Dq7RdNrcVJIp2jovxOPOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AeL5SGV4rUFXRrlJbmKN5hkrlQn24rhB9mCNfvTQ0CI=;
 b=yiTw8kNgQWOYNi/1j1udTI7P8I6XvcLrK5YepyF92lMkrKbyqNQ/Zbpk8/Tlt9os+DkkuPKdkawbgVHZN6KqUBASn26Cnt+I0rAdU7JgiKGn38+ssMZ5lGczt7n01yDR6zEU7WU22ke5cMSMTvurwnF9Wc3gAPFEIS1neWbIUZu36ymPaJQ1h2QyHwAfgfEIXyaeMUyHifgnni+ukzKqibWxJ6rLokOL5a6HM2KdTagBsJ+MKheEaBvbwgBn3Xap5xXcXsuWI3uhnrgAH+AApRKdZ6Sd85em0t3/Xe+/rhnIJdN944rnkpcCZgp5kS9VSCU6JzhHgMVUkf8lmTVxPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6422.namprd11.prod.outlook.com (2603:10b6:8:c6::21) by
 DM4PR11MB8129.namprd11.prod.outlook.com (2603:10b6:8:183::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.25; Mon, 5 Oct 2026 16:33:30 +0000
Received: from DS0PR11MB6422.namprd11.prod.outlook.com
 ([fe80::d257:46d9:13f4:adb7]) by DS0PR11MB6422.namprd11.prod.outlook.com
 ([fe80::d257:46d9:13f4:adb7%4]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 16:33:30 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, Zhang Yunfei
 <zhangyunfei1@kylinos.cn>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
CC: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH iwl-net] idpf: fix NULL pointer dereference and memory
 leak in interrupt request
Thread-Topic: [PATCH iwl-net] idpf: fix NULL pointer dereference and memory
 leak in interrupt request
Thread-Index: AQHdPIOjyLDzNoP3BEed2n9ZO0HTvbbEru8AgCqmb9A=
Date: Mon, 5 Oct 2026 16:33:30 +0000
Message-ID: <DS0PR11MB6422321E58E2409053C197649B962@DS0PR11MB6422.namprd11.prod.outlook.com>
References: <20260904091827.911123-1-zhangyunfei1@kylinos.cn>
 <IA3PR11MB898652715785B4094C61E50FE5B12@IA3PR11MB8986.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB898652715785B4094C61E50FE5B12@IA3PR11MB8986.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6422:EE_|DM4PR11MB8129:EE_
x-ms-office365-filtering-correlation-id: 7df7fc8e-d252-4baf-fc46-08df22fe640d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|22082099003|10067099003|56012099006|11063799006|4143699003|18002099003|38070700021;
x-microsoft-antispam-message-info: DzEbsTSjxdCO7u1/CA1OIR2WKpMwaIXHo2HmbwHDl5qopWildV7L94Tt3BEW/L5uU058OB/57JeVz6bohsDVQe5hXp4JCwM9/5Pkw3OlEVa/WcE42bgsl2ke0ULA+PS9iReB/q0JX+2jTp39gx7lfKktvWnsaN64jJsXi6bsQ4BqI9i2VMRGwkuWvG9i9Dv60J6lgxzuTouBrH1kd6b91TE83V6eQvkWn5fAbTF8UbMwPm1Gs5v0wF2dUfUJNGumWxKNU1yLv/mXBg5ppuSsRNk6FJGFL24nM8OPDey55ilZG5F6mDYQYjfV4xvPyQ2fm2JZUZ9eKHTilRC5/Mp72FmUdTao8RFbAvI9YqjPLarRqwMNT7ZgmppGaXoB2Rcp4IyAAVicnEWmp1ktHOaCHertY6KIpxaoycNyQqTuM/EDiOSq17LMQI4QAP3Jqr1+rgkrZTTLTZ5twzIQw2SwDCz64OIIkS9bE3dnP9KPhrxaPJWdZNKiR7o9vFEXetBWBjw7MTmbNrf++qn55GpFUw7XJYFcs7ybeiUKEg6yI+DaoCQZ/XqVu+4fKGs5t2pf85epldzpuuyzxyrc1jDSjeB8JKtZSsrCpyYu6qBQDUrxcwCuqDtkKqWTxpDNPIx57ynNI99kSG5062/lk/Vzc2KT8i3hJw9VSS+PyOc+A7cCdnfdkjmv59XT9tpJ9aTjjHhYmAl0WrctD2gsRy3Qapvrj4EUzbGmoXFlvsGtT6Q=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB6422.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(22082099003)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Rj5AE8etuyojFPA0RcNVqbvG44jRpPynclwX54fcegPiDbtZthHnIQxW7U4s?=
 =?us-ascii?Q?SOGfrpY4lcpnvUGMNm2/oEhRm0uEDV/+WiHT97cSDS7F0O/p1UwgXAxZQIjg?=
 =?us-ascii?Q?+k6r9zspMgku9w9P24XUYpXGRmoCMhDTkBnw2y2ZEFw/WdGFN7FtzGxLBMSp?=
 =?us-ascii?Q?DuxS5oClxnx5v9ygq1KuBtj6NUao/eg3sY4mfSUeQYQKF/K4g71fR4NBzYK5?=
 =?us-ascii?Q?RCX9SrmO8oNuTeqLEa/kf+HSeozX4dVgGLL5TL6iwjpAAhs47NKE8HefYRp6?=
 =?us-ascii?Q?cULHf4ZCGMFKy5Tfa5ZWKup2j8lpxj7NVxrNbQvEFqqValb9XkxmD4tvWXBy?=
 =?us-ascii?Q?bf4kwXAgHAK+2E6+GpxesQO7LAfK+UFfk7vc3CmUvSL0b5dhT759tGdPMyYf?=
 =?us-ascii?Q?4v6nLzczG1utWlarTiPIDshVXt+8dKaZtR+bqnM9p5jvcycstePN8W5CRgib?=
 =?us-ascii?Q?Q0oiclvteXkXUIk91kugHG5GynVnGmwEgCRY9qAHhpI5ndCWWSYPIT+utUfi?=
 =?us-ascii?Q?tOkONc51fgZaaXYPVOdbICiMtCeMDm5t7o1XWrQwqqYin1xgIaN930tJNjkY?=
 =?us-ascii?Q?R/9t63rBB1NRIs6e0kb02NQSaIUz9yV4o127Iz5uoYsSIzFgQK1SOPBVMx66?=
 =?us-ascii?Q?kCOqB2xD87AkudpMcXEfK16GlJ8sHuQmW8ChrEK6560pwz0ghy9msR7eRUhB?=
 =?us-ascii?Q?ooLUZjawWdURsoire18jyTejlIbYIx5PHIfGsfKejyy97z7Pa5VOrpJA8HI4?=
 =?us-ascii?Q?pxKQfXlb8RM0L/Ot86PV2QAYhn18S301SYJ+TwiZsp8smTjUPsBVtSF7KkI5?=
 =?us-ascii?Q?wei3Zu/u9hXDCozc8GfmVba34/0f+Ura9kTM55Bv7tjKY294Ul76bYyhJD6b?=
 =?us-ascii?Q?snOSAYuUzkpwrfmHauOASpIVJYzFi4AYlfKZdvjo0LPCs4vZA6IDsYUkS5ou?=
 =?us-ascii?Q?Mwe3ItRBI40vBUn1Q2qtnU27qcKl7iTYWxeRZO4CrDXNOxOkqqujsW8SSDrk?=
 =?us-ascii?Q?1kejTPU8tg3baINKwYK07BUbhgJ0jxm45nigok+zvUjyE8zYXLnxWjyQhGGz?=
 =?us-ascii?Q?97mxflCztz0OHfbFdoGXKyXTGd2F+Ne02qnRwvwDUrOG0iwcnrvVpBKVS1zZ?=
 =?us-ascii?Q?5aC/6hnqxKdfDrBbSmbnOS8jgkzpEymctPjT/t89hLl7dwPUHR2ggP8PtUX5?=
 =?us-ascii?Q?CDBkgDtf87ev3kj6k7uh/q5VEasVXfdtz69sANrt08tYIx9sZPnhafn3fxrk?=
 =?us-ascii?Q?ykThRLKe5yJSgS1B2GyTQgfqlk/w+VH3FB9GQPJZMizZ2r8QlES1MeHa9SJI?=
 =?us-ascii?Q?3IS0wWgcRNOyZZdLWcONibDvEttfGqUxjX+CJlbtHy+kRvz64sbFSojjHhxf?=
 =?us-ascii?Q?/V7sL7Zk562QLUjT0FaR8F6+gmj1tQfNCaqLFp20Avh9ud8NsXevhisiSaOE?=
 =?us-ascii?Q?KNgSYF8pUDz+sQlx6wJK5n/QVuarh3RadNetrDQUNmWjgKn8eZhJFZ3jMk/b?=
 =?us-ascii?Q?yr/Hw4+XgdvwMG/SCf+oMJf29wQRaTzwXQVahCmiq+aqB08e+sqpUaWyNMT5?=
 =?us-ascii?Q?/GKNpd7lrZlXvr3q38o2lOQ31PC19/xE3Ou9JbJgIUdWvP/SLFJ46jmcfthH?=
 =?us-ascii?Q?shSlOWzZ6uVlC/JKcEsurafokMREw+ZS+GbF6dCDHcVcVHqyzXRo5nmWfzbG?=
 =?us-ascii?Q?fyNMeOg9GbXqdpQYuwiOMvliDrW0LD+90x15zZuQ9pl7zmue?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gIQb7I72NlOM4MjlWfhZKZN5R3rUkj5Kr7GdDmTYhicOWiCg7uKaXCJS/MO7SIuHJoSZUZcgfS25wTz+icXOLdNzkF1EQ2/PK4aofPuNKkDnpULqnJn2qJKn0QrON75ZV9q/8fx4XJuGoP7UOkglzGRPNwW7AKUy8fwO5oMKWgbazheCRlBlNi5cTsTN/5rVr34SXz5Vype6FRm+5w3tn2wOfPOpIt2FDAncdGccgIkmXXzS7q2hW5qEFSdEXO/MaU7xJgDRtzmo5ZAznh0IG2/Sr2O5blImZhKK1ALEvPvTuxfCALOJkljoBB4EwGnlR/xPrziLkDzKfG3+n/POSA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6422.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df7fc8e-d252-4baf-fc46-08df22fe640d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 16:33:30.5168 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vVbQkoedQY8tK9c9vk14/mW04G4Uj+jq/m5uKWWZyjaHdLHh4oGUo+AzWWt7EVP65LUoHHiGwCcU9nV/luZkpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8129
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
> From: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Sent: Tuesday, September 8, 2026 6:15 AM
> To: Zhang Yunfei <zhangyunfei1@kylinos.cn>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>
> Cc: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; intel-wired-
> lan@lists.osuosl.org; netdev@vger.kernel.org; linux-kernel@vger.kernel.or=
g;
> stable@vger.kernel.org
> Subject: RE: [PATCH iwl-net] idpf: fix NULL pointer dereference and memor=
y
> leak in interrupt request
>=20
>=20
>=20
> > -----Original Message-----
> > From: Zhang Yunfei <zhangyunfei1@kylinos.cn>
> > Sent: Friday, September 4, 2026 11:18 AM
> > To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
> > Cc: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; intel-wired-
> > lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> > kernel@vger.kernel.org; stable@vger.kernel.org
> > Subject: [PATCH iwl-net] idpf: fix NULL pointer dereference and memory
> > leak in interrupt request
> >
> > The kasprintf() call in idpf_vport_intr_req_irq() can return NULL on
> > memory pressure, but the result is passed directly to request_irq()
> > without a NULL check. The IRQ core then stores this pointer as
> > action->name and dereferences it later from /proc/interrupts and
> > procfs, leading to a NULL pointer dereference.
> >
> > Add a NULL check after kasprintf() and bail out with -ENOMEM.
> >
> > Additionally, when request_irq() fails, request_threaded_irq() frees
> > the irqaction itself without taking ownership of the name string, so
> > the caller-allocated name is leaked. Free it on the error path only.
> > On the success path the name is owned by the irq action and released
> > later via kfree(free_irq(...)) in the cleanup loop, so it must not be
> > freed here.
> >
> > Fixes: d4d558718266 ("idpf: initialize interrupts and enable vport")
> > Cc: stable@vger.kernel.org # 6.7
> > Signed-off-by: Zhang Yunfei <zhangyunfei1@kylinos.cn>
> > ---
> >  drivers/net/ethernet/intel/idpf/idpf_txrx.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> > b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> > index 24b91be25676..86dedf5c1c09 100644
> > --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> > +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> > @@ -4063,12 +4063,17 @@ static int idpf_vport_intr_req_irq(struct
> > idpf_vport *vport,
> >
> >  		name =3D kasprintf(GFP_KERNEL, "%s-%s-%s-%d", drv_name,
> if_name,
> >  				 vec_name, vector);
> > +		if (!name) {
> > +			err =3D -ENOMEM;
> > +			goto free_q_irqs;
> > +		}
> >
> >  		err =3D request_irq(irq_num, idpf_vport_intr_clean_queues, 0,
> >  				  name, q_vector);
> >  		if (err) {
> >  			netdev_err(vport->netdev,
> >  				   "Request_irq failed, error: %d\n", err);
> > +			kfree(name);
> >  			goto free_q_irqs;
> >  		}
> >
> > --
> > 2.25.1
>=20
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Tested-by: Samuel Salin <Samuel.salin@intel.com>
