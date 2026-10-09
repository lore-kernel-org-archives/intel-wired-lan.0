Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B64D5CA601D
	for <intel-wired-lan@archiver.kernel.org>; Fri,  9 Oct 2026 16:29:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8E11E60609;
	Fri,  9 Oct 2026 16:29:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AEi9g4T1KrsF; Fri,  9 Oct 2026 16:29:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D3B846060B
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791563395;
	b=CrAvorD4daiCXgVVe6uzYW3AcaSEQZPppzFtLqYJOaLDtqidZO495HRkT9uMJRmHTKtV
	 KzZIn28fjsdIdRF1NfK3xlxsrBqA9cJOxcYb5eVAitFFTGS+lM0uj9+B7NtAtdQ3odUld
	 JnWKX55U2nxL7sd6nA8YLIaIWcKHsZS6QbHlCoEGw/h/+FTtnU8mh8sdRSSIE5xT/NGwY
	 LOZa317JYhQ6PpO2h4wZCkt73thvhU+I5DyLpQnCtFyrytBlK6TZG0F4xNO6UBODwNWOQ
	 Fr+s33uw+YUjCgt+voQoyRlykFN57UGoQ6K06m6kQKT5BVARtlf7AOaFouegTRHndCw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791563395;
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
	bh=ZQUXiFdO+lqMNM8HEdidX19GvsXl5MwlafIx1yeIoF8=;
	b=JiB7j9EWxr3NGxi97zCuOSSpx6d2WGKwtyA+wMPXui06tjDS9wuWT+w3TvlQQvTo+T4r
	 oZ8Ieoc8LfXBvsHsD61DOaRy1qI1KwZqQHLmgkgyQCBNupeSUSjFJ/BuIckkxNTo/2ztY
	 RHTGO3jiXNQdULxc17E/nRb0pDugQOCH/WVlp7KKqqkbM1G+zOFugGjR+m2LLEj4FotnG
	 xEoMCLSiT4+hFILiacJM23VPkjMp2TpF12TOrlXfbDbTInI9UWLlUbu0gTjuq34hqmcI3
	 4DxXtRV9PuYU0f79QwvXi3/4Xj51VTJbMZGIlnBp/7QhhhtLWvDGHAfeAlCQNzJm3ug==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791563395;
	bh=ZQUXiFdO+lqMNM8HEdidX19GvsXl5MwlafIx1yeIoF8=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ymdsFPQSoeOsCfcibcbRxCVtIR2/2GeDCBNycn3sMcRxEh0bYBQzVKSQvSkVIHOlF
	 4M3gDw8fqzBOnW2oYdEsTyW183eXWyN6WThCZcd+D7PSQjshBtxPB/DPuJFklTwqdr
	 OtU3YKJCJMPcyekM8ih7aodK9a+/EBRLzM/gbm7jDoMJwobnXbpCObYZHpN4aKJ9cc
	 bKY8P1NdRHRyfNEQvy/0w8zjIwaBp58LSybgVGHN3XMt/p2TppK4qn37eekW/zLilp
	 ZswvcVYyh6pjMjgIlAgUjoBupUoos850nwOeC5lt0ut7vB1xzTrYlv43wobydmRgwy
	 8SCn8FpIVh8gg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D3B846060B;
	Fri,  9 Oct 2026 16:29:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1ECA6317
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 16:29:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 107FE400FD
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 16:29:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6a72MpNko4eV for <intel-wired-lan@lists.osuosl.org>;
 Fri,  9 Oct 2026 16:29:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 42DF040050
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.10
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791563392;
 b=GeLFCuVm2egbXzo/VlKk55s0CIp3KK6GqbiVAm+rm4Qd3VxnTCTodSSolEMCKevcuIXI
 PBLWblPuZncwvDPmpdQ5TuI2HL9Av+saP0A0UstHDWCE679svUjHDJc5a0fRpumA7zV+Y
 OpiwjwnKv24mt3eHseSWV6ikWdAIxnKji6cz/Jm62gHuT7fipINnOxRRQnb7Zw0MU1I1w
 elgxprU6cgTEkvlr0vItHfEJ+PcM2fpC7b9gjAiPZxDBUR7IS7iLAi0+UP4ymLITeYF0L
 NqDZs14sTrImi+MgePhJ7SPG4ZQS7jQz3fJUJnHRKUXzHiAwhO0OTFBLiGePckAA3Ug==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791563392;
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
 bh=ZQUXiFdO+lqMNM8HEdidX19GvsXl5MwlafIx1yeIoF8=;
 b=bN/N376c0Z9r893s89Ij9FpS6qqt1hwzNGd9ES+wuK1dcCuIfpWidc+TVGVgBLw0ToFi
 2JmwnwSECc9dq+j0PZCAEutM+p0G/mkFLi4ADzzRmyCV1w6TPzBzSUNqTnqtFHJpqpJ41
 zZmcHBqb5N7M06PVFMFAegZwRLEGs/6cdieFlYD/zwSRoROiU6ewjYr2WQ2cCbaIzDZK4
 i6sGdy4H9eFrRT9ony8OQz5K1MO9lOfBDniATIvz8kCNv6PJN4kj9kUfcxVcQJH2EtvSP
 5SkLUCQCZwRfpzotvLxEPD0/mfljhgfF35JI8SAMgDQ/DCjZomm2KbL9LjRPRvtWhsQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=YzWc2EA+; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.10
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.10;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=YzWc2EA+
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 42DF040050
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 16:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791563392; x=1823099392;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=AbHKi0RSHz5VUbfirgtyfncjavNg0NPLNI/VdmMR29U=;
 b=YzWc2EA+QWwozkwVnbiKv1zLoXmf4wk7G3CshFQ6NT5+wF5wuXXqwEuU
 j0zsKXB1YVRkimIigD19DlhKX5Gik3mJlFf6rOP1y0+gCYJybrCMnErI0
 QHYf/3qwheXdQ0xri7l1w3JS3tigUxLKgmBugm2ptUZBiD6rZRLWZPTwf
 xQfnyoRvohE+OkeZG3m1czQ8dbLtxj+ayQU3TRYVJmL6uWEeDNTJAjSNB
 bLJZ93dsfNFpG9ew/45yWsa2xqrStC4N3zrLQq1oPSCxJk0dtG28GbNt3
 Amctk0KLU0iUsqR15RbeeUBVYP5ysVjSLeianM+o1Fs67JR7u/nIm45VO Q==;
X-CSE-ConnectionGUID: i9hrJYOtSFKiIgG4QpOUZA==
X-CSE-MsgGUID: wixeM81kTB6udnBLKiSSTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="253858"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="253858"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2026 09:29:51 -0700
X-CSE-ConnectionGUID: 8g32LN3FT5uT04VCLWh25w==
X-CSE-MsgGUID: ut+bDdVLRPytK1RPLoVy1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="348803"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2026 09:29:52 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 09:29:51 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 9 Oct 2026 09:29:50 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.56) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 09:29:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ogGH9J4zlIrNPoXAxOi3k3sXO48o32EiOAcUZXnrxBizF8OB/Ky2E16C4h6cl9FO70bxVExpFJMlXG/f3G6eSXtPfmaw2XbUK7mn+k8/mbYqQU3TvVBtD0yMoAHTfjfe/Rlp/oCuaPER1AoQyYy6bKuLcd6YlEmf8eOJJPMSlrN8mEUrJ9NJjtSwXPNVUp2e1umSRI06tWmi6oBg8dE9zdXJ9EQnQ1on/pb+7zAUjEIx7wsmLhGDKcwANEKnWkk7jBUV2FnaIWUa6yoJgRsGu6osaKcyqqn6iW3UHL/ISbC6xCdfdoOBmousNflGQQWfxe0Mup5m7bGir2L8iGalCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQUXiFdO+lqMNM8HEdidX19GvsXl5MwlafIx1yeIoF8=;
 b=BmNeEL68g46DbpRb6eWAUmmjtJ+CwHpy6e6OJjzHV8AWkfhYFTTasae0x/1Rc7GmS7wvPa8qTONYISpj37h/Yq5ERoafZsEMh/9bzt51VlTllXIp6g7MoUaiEQsLLQ5/5jsyX+AWpx42vvuh9taVd5U7WdmWqqDYpGElIqu+wrviaYRS+TWunHkOdq68fEMu0Tr/TfhSwBqzNrPmMzbH8X4NF2lBLWinF9fiiJ+rUbp25IedDC4ZDAvnrfvULD9bEkfZYw+WwyGeD8MlLc9Lj3deNVzEJxS/at6jtm2+nN+xwmiT6+V+pXB/11DlPn0ubWcgl3JxBZ8yFFTWmji/0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SJ0PR11MB5215.namprd11.prod.outlook.com (2603:10b6:a03:2d9::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 16:29:48 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 16:29:48 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Simon Horman <horms@kernel.org>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Kiran Patil <kiran.patil@intel.com>
Subject: RE: [PATCH iwl-net v2 1/5] iavf: fix null pointer dereference in
 iavf_detect_recover_hung
Thread-Topic: [PATCH iwl-net v2 1/5] iavf: fix null pointer dereference in
 iavf_detect_recover_hung
Thread-Index: AQHdRRGGgFoVqBgo7UmT8sgCTkbHlLbUdc6AgCEWpHA=
Date: Fri, 9 Oct 2026 16:29:48 +0000
Message-ID: <IA3PR11MB89863A91929BACC5F0B01BF9E5922@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260915125551.3976068-1-aleksandr.loktionov@intel.com>
 <20260915125551.3976068-2-aleksandr.loktionov@intel.com>
 <20260918151125.GK51261@horms.kernel.org>
In-Reply-To: <20260918151125.GK51261@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SJ0PR11MB5215:EE_
x-ms-office365-filtering-correlation-id: 0229ad3a-f783-4ed6-8631-08df26228978
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|56012099006|11063799006|4143699003|10067099003|38070700021;
x-microsoft-antispam-message-info: tepU9eFL1DAaCC5DJjh537B4Y4NOJGqjjKoKkHV/zL9mZMoHYzG3RiWtFCrrpFwDZPiJzfipp87ZxduY0L5IDZdjgLk7hNb9KZwfS8S7xpf1I8/VWewtKr6Jmw/2KBGcT0Iw7ML92HBkQ8J3Mcjrld7rdiHIa2EMzXXaI1TBjGUGz8j+cfbebn3maetSo97qRF/BlObMuKxBiogBbNLjRM8N1VLyphJTsW2cnvkOodJk07q5zMFe647qqIgWag6cKE78zm3MWk1cjpsLXfRAbCkqqMNArcLN4YwdW9uoPtluLhaSteJmLt3LN0gyIIl4+u5aMShWYZzq3tMu2dC/bXnf9IGs8a+t0D7pYBWjyrQOjfaIH27wbyugGCK0dmmpwEc/CL6AikRDN9K/w6nUlf8GXOUf6HBjgzUGlctJtVgvw1qG1piCNwjA6uwrzXtnp3wMVaOGT6M8e3NE3TFh49pad8xeXDM1+H6prr2wT8AtBES23mL8ov10xxpF/F/MasbWHbSpvANDQpPSbuC39P2HshTXVsHXkf29SCdNPkRn4B2F27b35N48YoW7QyQmUyX3nx/Glfb9KkpSrcVqId1XOOKTaDNCmtasCh72qSiizS08LS5ZwUgFV+N2L1flYnYnjM6O8MvzJWjC5vBOExbXfTdi9g+I3i9x8IuMC7eZ0cEcJcXJVsZOI8Mt1lJuqZzsJaGSfmEYr4aqPdSo8cyjBnPbjfzvIdokzvT8XO8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(10067099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Fn/bpdqSUeYGXsQqQlMnvDR3bKpWjCZBf16714TnhaLL/BEOxOK/+zD3j0CV?=
 =?us-ascii?Q?QgaRUfykC20QNegyZVgIVfsUzuAWk+lrQMcb3c8tT71HLv7d9AHb98pBv1xu?=
 =?us-ascii?Q?2DPDjJ+4fOUbZ78YoeZsTcHvKirIiYiEz9MhUflZMDByloG/K21OawTnyYpj?=
 =?us-ascii?Q?5pTuhyEWqtWcTHiTpUjzjgTiEOxFD0+/DV700HCiD3ZzLnneuMlb/9jxFcFR?=
 =?us-ascii?Q?g0W7wgVlEG/Xv3D/m0+O02thOqa/XbuUEFCDvWnf0ThrufANAQt8/ChjiP6D?=
 =?us-ascii?Q?gF2jd3DfJVgdG06/h2EM5rCWklX+9rsGT61etkfm6cU+J5zgn47vc4zHD97v?=
 =?us-ascii?Q?9jOl0qCRwT6xt9TX7lCdczimNaN51vWtmJEv++bI5JrVOQPVJw2agS/sbnJt?=
 =?us-ascii?Q?gRpDlPV39Aakaza4AXX8a9JWh9yI63jMV9EdknlImUTa7D8vvV+1MwrFfvTz?=
 =?us-ascii?Q?pLicAy9PDm9nLDxGH8Wz5UyPbGqybTeNFSLjeIDaeOPh9HWEDvSOHCISvoXk?=
 =?us-ascii?Q?IHttk1u3Pnup0/fbROY2oY5Opb677GDT7kx00l1CqcbSx6xTMkVD6z8xDQYb?=
 =?us-ascii?Q?uct9TKrYWUJHyRvz2FPQyI9adbl3+jGZWiOE0U5iEA+Cyt6IUwXGeBCc/mH+?=
 =?us-ascii?Q?8Y8G7kkVAwAqnGIAAPxV7i0DzIkg0rkZx74lCzBX+u4hBjOGMlKat3ge7b7x?=
 =?us-ascii?Q?CRvSBiEMdMWbbCbowGipS05nwrH+Y75c6AQKMt68L/i9/NGEVbo544qJKz88?=
 =?us-ascii?Q?IN7p4UHJnysUkmPJiPsezwjwsQWBI7M2BJzELHdqdbf6KnX0C7PSp9swBNi3?=
 =?us-ascii?Q?20gEj59AjIID809s80cnfuajTaKf31nEHXsdKr2yCT47hj+EMgvFiBqw4moU?=
 =?us-ascii?Q?n7UhZqRbip0ArjkprWQ/+ZdvxcIYt2q+30p749opCo0GZcbwhtw7L7aqF9cC?=
 =?us-ascii?Q?17p2DwYROmIKILF3kVwYlmtHh0GJcBp89Z1KxegmJ76xii80+TfvCbP99m5k?=
 =?us-ascii?Q?8HQCLY30Bxxr+LjcSjSempFnKVFAh1ISSMRvWAae0V/2H+ssE9/JkN0EI6un?=
 =?us-ascii?Q?H5roH3MUywU3faPyfHBssi8shOlhq4hY5G9qWAGJ/GTWwkl9sIwiYB23HrnM?=
 =?us-ascii?Q?8dsDtTprO7yqgJJ5MYj+CGb/2qTbDkqkkTvYrf5U0X/vogAJsZgcQo7hfPaX?=
 =?us-ascii?Q?9ZSiZkTu/qLQNgt/WN6tzgm1da5diCZu9Dij6sDY55Mmtx9xNi83sPIfUtE5?=
 =?us-ascii?Q?3F12y/K1OvZahc1iHCpWtwa6kjPpisGu2Z8GIQrP8+6Ug5LWapgfrOAYsmj1?=
 =?us-ascii?Q?oqoG/1z1Obo/oYSJaeX8zeJmRlXDdCU+kBw5SPAk95X2GvaN8UC1HdX/LOhm?=
 =?us-ascii?Q?YLu/TeocyzcBNV7Ddu94FRNfUIfJuhNRPjYVRwPm4d9MCs+6fkyvDpb7rS/t?=
 =?us-ascii?Q?YeOlrXAobK1F9k9zz6y2ervAEqrO1eMH8elpcF3Df7YUL09uahqpdhKdKi6O?=
 =?us-ascii?Q?5vFoAKllUNWijY7zH2xAu2PxMyDax7uVEUxLvM/B06Prk+czdWfnh0TbxV1d?=
 =?us-ascii?Q?X5Gjqzk4oxNuxnhHi/4VXBsEv0GN9+ystxDOuLlZJWemKWQMV0fzqPs8RML8?=
 =?us-ascii?Q?Yal8Atl1wawq+5kJD9dqilvntt+F6ceWNwnzYgZp1memFRF63TYO0uUzpUJJ?=
 =?us-ascii?Q?CGni+BHnoloUukK+26GrdCpOfTLDU9QtS6+B2pW1nNLlBLvt6MquOAEiJmdx?=
 =?us-ascii?Q?apuoUoMw6+KoDv/yDp1pIgWKATmZUG4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: VdA33aUcy673Ad5v1p9mM3Vkv1TSRzm6jDoBGXiarYnrJd0np1np4PhES97l/H6c2BiGNFbTydavfx7NtlOC/QxD2GPl8Vqj6USHh+nymbJ/IoRIIT3yvU23A9mI4qmsUIma1PFuUf1R58fPp0zaL21rbffa6cuWsYoUNIs6JKGVLklnA+ByiSOJdYn9elqajzbvFu87VLJgJQnxqa3sLBeKJLZM4/F/bKN40WAAQPiA4mLW21AW3oRIa7qd3cBYT9XwVCPryMgv9W9/npA/jCr3OI7T48ZFiSk6kxER5zWijMR8oPZB0EOzV7i/oCG0C7poC6j/SyUjVzfrl1HUyg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0229ad3a-f783-4ed6-8631-08df26228978
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 16:29:48.6416 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0rjtKGVQvyolCvzE4eif/z8D6nJ9T6Z0YKB4onCfTiCV2buPDus7+N7ycu+LUwhKPX1q8aZGQc4iVS0j8H7UD4nd9do8Bok0DKSOcfK60ms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5215
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
> Sent: Friday, September 18, 2026 5:11 PM
> To: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Cc: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; netdev@vger.kernel.org; Kiran Patil
> <kiran.patil@intel.com>
> Subject: Re: [PATCH iwl-net v2 1/5] iavf: fix null pointer dereference
> in iavf_detect_recover_hung
>=20
> On Tue, Sep 15, 2026 at 02:55:47PM +0200, Aleksandr Loktionov wrote:
> > From: Kiran Patil <kiran.patil@intel.com>
> >
> > iavf_watchdog_task() and iavf_reset_task() both run as work items on
> > the same ordered adapter->wq, so they can't race with each other.
> > However,
> > iavf_set_ringparam() (and other ethtool ops) call iavf_reset_step()
> > directly from process context under the netdev instance lock, without
> > going through that workqueue at all. iavf_reset_step() can free and
> > reallocate adapter->tx_rings and the q_vectors array via
> > iavf_reinit_interrupt_scheme() while adapter->state still reads
> > __IAVF_RUNNING, so the watchdog task can concurrently call
> > iavf_detect_recover_hung() and dereference a NULL q_vector inside
> > iavf_force_wb(), or index into a NULL tx_rings array, causing a crash.
>=20
> I am concerned that iavf_reset_step() is also called from
> iavf_set_channels(). And in that case the netdev instance lock is not
> held.
>=20
> >
> > Guard against this by:
> > - returning early if vsi->back->tx_rings itself is NULL, since
> >   num_active_queues can still be nonzero while the array is being
> >   reallocated;
> > - skipping rings whose q_vector is NULL;
> > - reading tx_ring->q_vector once with READ_ONCE() into a local
> variable
> >   and reusing that same value for both the NULL check and the
> >   iavf_force_wb() call, instead of re-reading the field right before
> >   use, which would leave a window for the concurrent reset to swap it
> >   from underneath us in between.
> >
> > Also move the tx_ring declaration into the loop body and drop the
> > redundant outer NULL initialisation, which the compiler can never
> > observe since an array-element address is always non-NULL.
> >
> > Fixes: 07d44190a389 ("i40e/i40evf: Detect and recover hung queue
> > scenario")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Kiran Patil <kiran.patil@intel.com>
> > Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>=20
> ...

Confirmed - same gap as 3/5. The READ_ONCE()/NULL-check guards here only
narrow the window where iavf_watchdog_task() can observe a half-torn-
down tx_rings/q_vector array; they don't hold a reference or lock that
keeps those allocations alive, so iavf_free_q_vectors() and
iavf_free_queues() can still free out from under the watchdog between
the check and the use, from set_channels or any other path that calls
iavf_reset_step() without the instance lock.

Dropping this patch rather than resend guards that don't actually close
the race. Once there's a real fix for the locking gap across iavf's
ethtool ops, I'll revisit whether any of these NULL checks are still
worth keeping on top of it.

Thanks,
Alex


