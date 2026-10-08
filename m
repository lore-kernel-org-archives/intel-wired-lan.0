Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D451DCA6017
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Oct 2026 21:25:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A1943408F2;
	Thu,  8 Oct 2026 21:25:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EM2Zm4kuetPs; Thu,  8 Oct 2026 21:25:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1A6E94091B
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791494745;
	b=YhIeAg3Hq/wEHWtb5gbglYdJmn9QbMQSjkbMuNHRAb0RbZ9Zgil6UU15Qi30fKxP5Yc1
	 c5KruOnOIwy9qNBSBFC0gHuSJuYun9ziZ1jdx6a7ubcS71l5JaSPrkcFT5roDmQDPrPTZ
	 eMl7JJOYqOzqcsUo8uTO977DR9HslWWKK9wNZIQToMIkUFjUVGpd/mjJbef3N1/+7Aeme
	 aH85pYufmmUFV3zGneNG6R94Pv2JA7xDGkb6jnnqrna+GrOS+25RV9IioRAjtHt+4Opq4
	 2jSU6fLENa59/KLMOejb/+v6yWzn3kBYG+Yf3LIqzAPvv25wczESoEe8mAfOjvLMZQw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791494745;
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
	bh=B7rVc28W6HqDuSFAycaJIa5KWSfNiJujxKcW66RGO+w=;
	b=BlX1rXbl4tiMvE0+ZYnV+dLnEtLLHRsmY6UH4Z9ZgwtOKBcfIXzvSwzKY27Nr6ygyO0l
	 TjbALuw30o2fe8/2jb7hVnp2ChqmPv2lNr3fyZk9iIZOXnSkhSr6tcIGqnPnOlfnCV7a3
	 Kskh0vgoKMsHKGvh2Bt2JXWNyFbh8tIZT3Jg/2LyNbamjzDmyYGDfDyfQBo1fHjq/yBly
	 AhqiPetq0xJqnlhhTP0Gew9FgH6XbJ612oEgMmAI3p+kib/ZJbaY+sCsJwfLXsyuu2XiD
	 fR6KPsmAO1Iow4gYPEXR4ScDxxTXdIM3ptHHF/urH5iWiEgTATjHN/QvZQcLJjGzGzQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EA77wacK;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791494745;
	bh=B7rVc28W6HqDuSFAycaJIa5KWSfNiJujxKcW66RGO+w=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jY07pKQyKIbCv06+85vJI2tE9p1yrSIsr6O07QyNuKpjgBUqNhnCYBaBScTv41MSO
	 Ogi9zXz8pgApgZRYMsoUnBNFS72Gbc245BV6UbHEyGeks6fVov66Rf9iEt2M7DPLBq
	 1K6zxL9zrPoduz2OqgGLZL5nAo1U6Flels+HnlV+3z49znzRhesrUNakuc19d4811I
	 KZr3ySst4fSzxqvo4qNsh/4adIhQ+5x+lMWS2CcsVMB8jSDD3vuN8BzlQj3E3dWHPh
	 YsaokWz3iWB9tZG5NqFI9z9bMoXjHntGhB9efzv4vSlcAJczE7wng2RcBRK2T2/moa
	 ay81vmzV/qU1A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1A6E94091B;
	Thu,  8 Oct 2026 21:25:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 719CD2B2
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 21:25:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5733A4091B
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 21:25:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OG-BueaIeyp9 for <intel-wired-lan@lists.osuosl.org>;
 Thu,  8 Oct 2026 21:25:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B9ABD408F2
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.9
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791494742;
 b=BIzce+zkaNDJbQmd7BniZ1wZOhS5OKVQ5b1v6EVQAY7vySZ3qa9wbWzCRng7Rp3OLmH+
 m0C6Q5RpiEfeoUUGtQYfS5xWwOhDGmQHOza5lauVP/nIofDdumblcC7YdZqUq3F4wriUL
 I8dKv2NOHPkkRbYYfkTummamKV/FzGlhdJWHX17muIBKW7K7BDTfOjSAL974qNdfNI9t4
 Ix2DxqYhkH35ZW/Qb9aAdRFd8brRhU+cRjGq8oR53JucWZ4e8XIpgJzApITIDtQTYkGdn
 Q+2mgitTwUDinpp5pRsyesVR0PXyEzo+hr2++nS73KnAeLPpNRb0Vs6WGYJUvqU0UuA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791494742;
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
 bh=B7rVc28W6HqDuSFAycaJIa5KWSfNiJujxKcW66RGO+w=;
 b=qMM9VC6VkPapGCTeJugFbpuihut05aYrR2LBwlvbK3HOqenSfR2T1D7gZLCqs89Ne1tI
 uQNc+AIyThJnTmyhHNHC0Ed4ZQvGACyrO3L9Ob0ViHqm5qV3PKWVIvP3zlM3zjEfpt2K7
 oHt3Tfwj5kMw4BZs5B31/ooendLLwo+BAZYR4v3RJ4yacKHRblg5wdck/t+mqu92t3iXE
 WK572OpD31VpDhBae9OxvwCfd+iRHicpj/3rRkIJZEicnZd/4oHOw/ZMs3oRUEU5OPBkv
 pemVfk4yphFEka/K4adHqrmWvdabSaRqkF1F58E47XuJt23TX2/f3fsUpzYLBvD1wHg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=EA77wacK; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.9
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.9;
 helo=mgamail.intel.com; envelope-from=samuel.salin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=EA77wacK
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B9ABD408F2
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 21:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791494743; x=1823030743;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=B7rVc28W6HqDuSFAycaJIa5KWSfNiJujxKcW66RGO+w=;
 b=EA77wacKllVXUz7oXbHqbAcNtVPQFiYw8UGeE1g3Y6nJomiuWnA5vY2N
 OMecOesICr1N/NeALWzj0Y26IWDiHPtWuBb9P2SMDMUZUEAtex9OwB0gO
 rGO2Nl4kUb/u8dBqJtGT7UyObwu5D/S7O2kUGMELmqiJX9F6Kg/cccPlo
 EImGFORi7I/z3TdpJuUGafL6Zm7G9Lx3oYbmhD3yuVoHyYGo1XnNbvwgk
 ZPxe/8DsBLm8VVESVewUAUny0OVCJX43Sz7HsM/HFMHnHcdGMMFc1Y81J
 1/N2KMKgZGUJI+7QU+jDqSvDXUuhESc6MKBe/8FL8yMZyy64hEFhJ3Wo/ Q==;
X-CSE-ConnectionGUID: ugVhpQM+RRqecWDI/rnkgg==
X-CSE-MsgGUID: jDy9tRpUTQ+kV3idd8Fobg==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="185032"
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="185032"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 14:25:42 -0700
X-CSE-ConnectionGUID: 7K4IzhZLS7uPDjgu1/NodQ==
X-CSE-MsgGUID: Zhl/iX+PTzmSuipxHEIuTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="145934"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 14:25:42 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 14:25:41 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 8 Oct 2026 14:25:41 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.15) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 14:25:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oUfVY12jnHm0s0pxbPLmBTzCrQZIbycNsbylXb5QSY7cHHC0TpTuS+aNpYIJz2bm9oSKud+HkK+RO997t2MDN4LuNPwgOOssxEqw5vwWNG8ld4QpNueq+VPs2srqofo+c92hsYzl8XW1KAEZ2BVB1ugK0gY9484qx982suAxz+5nhPqvO1hAy0xAXtj448Hb86XON9o+P4VcIiyy1HkDfa5Vwaw2mH9bOW/Fqwkg4tpojWQirUZL4L+rQyYB3uarYZv/OZv1CBh+tGqhbZTw32kl/LcdSwRqY96oUKTjAGi18VCBZiBUZ2jrm12oFpA0tRX/EvuTTjl1hQMgVZqttA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B7rVc28W6HqDuSFAycaJIa5KWSfNiJujxKcW66RGO+w=;
 b=CQHWjHT4HUcfwGrPTdsMHclWi+tHkOCl7WduS1hGe6IKtK303b+GQO+/WLuuhgjitXBnSt9K0ExBeqaLA8bfxO3LWvapk6/4MsyySmf9tR0Lwqcp7m1n1++GTZ7D3VZdGshBGJ3DQ7sQclSRZ9H4F6w137qIk+mNgdFPsMTVwoXFySt6enJFmzpIWoPLgfR1ScLak7oB9j3qt+DohqU1gaR3LOaLJ3nHxckQFLrZRXUcgD9guBgnSiu7d8IBR2DKsevhB3+MgXC6/cOeDbb+AiJYr36qz+6hcpIYJPtK7UEFF/2G6DJRnOHYY7IC6Fl3d13E8G2/l0MQ9JIh5QzNSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6422.namprd11.prod.outlook.com (2603:10b6:8:c6::21) by
 DS4PPF8ECAFAD61.namprd11.prod.outlook.com (2603:10b6:f:fc02::3a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 21:25:39 +0000
Received: from DS0PR11MB6422.namprd11.prod.outlook.com
 ([fe80::d257:46d9:13f4:adb7]) by DS0PR11MB6422.namprd11.prod.outlook.com
 ([fe80::d257:46d9:13f4:adb7%4]) with mapi id 15.21.0472.016; Thu, 8 Oct 2026
 21:25:38 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Zaremba, Larysa"
 <larysa.zaremba@intel.com>, "Loktionov, Aleksandr"
 <aleksandr.loktionov@intel.com>
Subject: RE: [PATCH iwl-next v2 04/10] idpf: drop v_idx from q_vector structure
Thread-Topic: [PATCH iwl-next v2 04/10] idpf: drop v_idx from q_vector
 structure
Thread-Index: AQHdQfHZRAUmlEiXz0WRopp7LK/K+7b0Uyeg
Date: Thu, 8 Oct 2026 21:25:38 +0000
Message-ID: <DS0PR11MB6422A2D727FEE9CA6A697D5C9B932@DS0PR11MB6422.namprd11.prod.outlook.com>
References: <20260911124921.2881348-1-michal.swiatkowski@linux.intel.com>
 <20260911124921.2881348-5-michal.swiatkowski@linux.intel.com>
In-Reply-To: <20260911124921.2881348-5-michal.swiatkowski@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6422:EE_|DS4PPF8ECAFAD61:EE_
x-ms-office365-filtering-correlation-id: 9b018498-7bd8-40db-2e29-08df2582b2da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|10067099003|38070700021|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info: CXT9kh0YomVF/hM7d0DKlsVITpBOZWHtPOALKhSlHviiGkBDA62efEDBcHzD5NPrYqIADO+3kJydZOAahwZTCXvHkKucy/iBMs5nnrlJDWKugohjwUs8hmE7PWbH9zdgPpwel3jbSCiUOJIYeihKrZY6inG6eQK110teJK5IIM0YV24jy07iLAchgiLcphPT40cs5x+wD9hNjNZ/ahB4PLMxqXD9m/UhHttfDN+CyI+Nj0LzOtdlMSemTpy5YFnFKHWJ1A7BtO0+xkPJw28+TWiCXaeHSBgS/D4eYEUK/f9jMcITivLqowTgCjJ3Ri9AXUbQfY0TR/WsqnfxTzGxA6xoC7QLwVz5EmvTTcXpV/bZmxYj5QwDsyu0gi/U8WaQ3F8kbC8ZqBobOAzIg2RgXf6+Ei2SJOmvNctVU9KkZRSeCLrq065fxlHo23U+kKoGJVzx7+X2r6+2keKTNJwVPo2qW12+UOZl0dvcL/WG+OrdTF/wqGw+ZcafDEDy9zvDKzbLg1b79iFkQiAGUiWEIFKrUvydg8MY8YunfD25coxnLmogtbwCKb+DCZ4sxd8s3DVceY5eKQIjGjmnRyFw9kZ5ScPJWg2lAD3Xfsv2o0TLZOH+Ik73NAf75UF8qRQn0VfTwC5IuXsZ0iZvIr9ob/6POYtm/3+2D7AlCAvf9KJF/NYKsGhIbEbhvp+U+V4kzuTHGnZpirpAc37/rXxCRph9RcNPJcpZYmDt5hUXf0I=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB6422.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(10067099003)(38070700021)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GT8jdMgG/MDVIN6p5ZmKRk/aeCzAxhJGoByixIxgq8jxCHBy/UTdL2po3szT?=
 =?us-ascii?Q?L+GQurnJtcf0IGMXkv8Qtcg4DtDOnhFnlox+FbjWagC+cgrWo4YIEI9JlnRS?=
 =?us-ascii?Q?bF5DFfX4bdtdFsBBSqZh15pmSHTj5F8aKAmemFxHdMoEs6rS7BRy4SExdXGu?=
 =?us-ascii?Q?zhODfxcWg6yq/ETHs14CJpMwlPjGV6+2XCZDhDait8TD/g5LtrQia19R1Cdz?=
 =?us-ascii?Q?MBOT4g/nIm0tQusb/UH+zPDfga11TpSnOg1QWPI+FkKUZxz8obhMRYH/wgoG?=
 =?us-ascii?Q?yRZAtwyob4mX79vA9/n5wEPIqWKxJkJryXzL9Mjmx633R8PjUMeegWrLbDeL?=
 =?us-ascii?Q?X0WHG4sQWmDJostAbHqIUp/RMrzPr5RwiRuSNKZohpic63NZMxbkwHQbF6i6?=
 =?us-ascii?Q?LrfYWC/X8UBs8kU5Hb/7kC4ZMQJZFulTSHYXrnNI2U+mBIybscNT+mpJjarw?=
 =?us-ascii?Q?AJv+MGk4nsHZb8Xddp7nyCmpJ3rh6ahpvMAqXCrc6KaWa+3FNNlv88/cPd1F?=
 =?us-ascii?Q?vQjBKAUkCuuneWiBA+RALWT2RVQ5wXv11fRqmI9FOn/1q7vVQyLTQ5LXdH2B?=
 =?us-ascii?Q?nt62eQEBmwGCKI2ePFY/abvvfoQ3okEdDpo0icb6jABMZvXqg6n4KAdqMRI1?=
 =?us-ascii?Q?7glM/CW885Pen8a9xMg/56dtM5jMWjlmmKVFir4OCpDRDjiLv3SSVA1SO6dw?=
 =?us-ascii?Q?NwjYBpQaLaU+ASrDs11xWKJGIrnKKk9AS5TcT8LiRafGNjFI1cXcKIBIMyqj?=
 =?us-ascii?Q?UumMRqPDSkutlvFwjYxHUtaIGwAL+cWLAoqdIhRgmq2KRSKd4+P0VWyNG4Y2?=
 =?us-ascii?Q?WNjsPTEHx0pomGQZQkD0A/zrvweIVYNyR3ZdJf/d7o1vIRO3qHNHmv16bAUs?=
 =?us-ascii?Q?F76Z5fsvHexl65S1juoxl2SNPgTcckTyhVYT7nFTC4nmHTue7Xca5qAL7zKc?=
 =?us-ascii?Q?Fn4VTqrxktUYFNHzuXcB2MAnBFsHPp8qiWAiyOr6G3Qiq6Ry8up8b5vlBQcP?=
 =?us-ascii?Q?ThqlbfYZsMuGEqAPRJM9NvphV5LCFflSEYy76AmiAAoUO+udbpufO/l1J3Ai?=
 =?us-ascii?Q?iahsXXSU001ln0I64bfMOdPND/KKMQjBIYbd6x0ivPfIBwEDHpk8mQHi3bXj?=
 =?us-ascii?Q?JcFF4OVieZTuH0rJ5nXtIIFH29Zw0Jw+t0mnk2oYTpoO3FVB1leyItcoX51Y?=
 =?us-ascii?Q?mJ6zGC99A1MHs4j2oRnDYP7A4yRJnzWm17agPy2DHn1OPrVn56UlYYmx+C2R?=
 =?us-ascii?Q?lCkxJ26UQam7EEanrtDeSqQioa2aOIQyqB8+2Jtr15Wb8aeFrBLmG2Z8trD8?=
 =?us-ascii?Q?7wBpl/YFNowtPzIVRa9uYtOTHChWutAeI/488cgbPWvpZdQ32jzQHVu12qQQ?=
 =?us-ascii?Q?oTE5orhNDrlo0s+jDHn22bX/A9YM3Jpk2bgrj/IGj2YFfiz/uV2eJ4JlCSgC?=
 =?us-ascii?Q?1yDO/EOQUtKKCVKHfS7kn3uFMwMFySHhhI9pYZD44zy7JX0Q0qPpr8kX0C96?=
 =?us-ascii?Q?/CaDgEW8UCRm8J9ZmZncDWdwQNjTFAQwhitoG3+U8R/N3kJQiqp0iT7I+HRF?=
 =?us-ascii?Q?hwJcLCqLa1H/JsPtC/InbXms5Z0vXHsoKNQOo5psu4xrhJmDLVyIzVWy3SI7?=
 =?us-ascii?Q?Q1lCIytwFiaOvOzC4v25sMjueber5xb4n0T6D7W6vRqJGEmPPI/0uj7AKpw0?=
 =?us-ascii?Q?Hmqo588PYv5hU7n7QEGSJSlsk5reK4SScXITFKpwFPWN/ejb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: pXvMy4qT+71NdTGFDycHAOMnKmMDK1DuAhAUyz6yJA51/mDkHbAghSwJzC/qCN0YU59rjFBaHVE6ETw+T19hvozzd+sHiVjDrwqfbTBSeTErEDWZkKXigEkn/+TcW+2/tDMaCPdOMjI8I4q6lILPjj5C7r872sn6zFBWhh4lF9unJ4E2LwrdtE1Un4/6XLKymqIIybZSyXl2PBJQHOMkwjeCLVCMcwXr+8/Ldp0lTfGlwVqC0R0AxY0KCoiaDPtI5wdGEFpkoBzQnogmCeOIuAvdMOmQc+szxzqazgXMp5rqaJwGoF8XyAKarLIAm0p7NYte0hVLRnj/XihRo5HPow==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6422.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b018498-7bd8-40db-2e29-08df2582b2da
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2026 21:25:38.5859 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xCUiK8jyxeeTrNk1rxDBTJ192nXrYf61reVvVdeEV4oM6FtxD1dwk9lSY1oEt5QIMR5lTzt7wMxBKkg3ea6wpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF8ECAFAD61
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
> From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Sent: Friday, September 11, 2026 5:49 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>; Zaremba, Larysa
> <larysa.zaremba@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>
> Subject: [PATCH iwl-next v2 04/10] idpf: drop v_idx from q_vector structu=
re
>=20
> Storing another index related to irq in q_vector can be misleading. It is=
 only
> used when matching q_vectors with queues. It can be obtained using 0-base=
d
> software irq index.
>=20
> Use irq.index (from q_vector) and get the hardware irq index (q_vector->v=
_idx
> earlier) from irq_info structure.
>=20
> Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
Tested-by: Samuel Salin <Samuel.salin@intel.com>
