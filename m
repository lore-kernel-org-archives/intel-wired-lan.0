Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93836C982F1
	for <intel-wired-lan@archiver.kernel.org>; Tue, 22 Sep 2026 11:13:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3ABA76074A;
	Tue, 22 Sep 2026 11:13:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v2LKLdqNXyRo; Tue, 22 Sep 2026 11:13:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9EDDD6074F
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790075631;
	b=iRxvwibHmSg6kWWJmLtmkRV0s0sZYFfYzrIg7xMeMgBbhCy8G4V6mezsDzsQqZGuirK5
	 jGw6BaCgnTnUyEt+ho4EeKJAEriMyJK2h7Klwbp7KplLSEWKaNGIYjYSSDxh6ypIGdIIl
	 aRHd5wXJnJUbAiYxleXAODYwdiqgtMn86jiJkyVlchQJ4SZY6vCeIKEMWK2ONH+PbCJy5
	 Q/KRuxyKTyutX+zU9TSJc8t2Fv3DcZZ4pwwipYa7VTLW2kMgBwdOeZA8vAhm7+UU6NlO/
	 MI1kZiNclA55reACkqb8u5pgG9JtgweZO5YkIkNHsRdD338M+rlGNwtBS6pmCATk5rA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790075631;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:Received:Received:
	 From:To:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
	 In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
	 X-MS-TNEF-Correlator:x-ms-publictraffictype:
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
	bh=IhStF+EweKtqyZAy9L/jfCfNkPs72EVr8oyGb78Izhc=;
	b=SYRoLVzqJoOxBrkMVg37HjSyzkQgpEWnD6SwFZiLXLGmFRckdvhQ+Sg5H6c+tY3UCsOm
	 EYj1egF4cFJrTnqYf4l8SYU7Q2k7J65PvN2YXA8JzzwiZLE2e7F5lTY7ewJO1ovUDzwtl
	 lAY95tXa41V97XtNH1F94Y99m3NaRKMrdn4vYkzjzdBGt+alRlylq9X7VeQ/zN7jlYj9i
	 XT2k/K44JpHcqycUtMy1SkwaMW8G6JwrJ3gf0KV2Nux0G5JY0DeoDWt0dYeYSEjicJgpH
	 cmwYdJTf/EVFqT4P2l75P5Ax9oOa9cIsWiDcpqJCS7+1OsrAm+9gfZdPHM9VG011nmg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RRsrAuw+;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790075631;
	bh=IhStF+EweKtqyZAy9L/jfCfNkPs72EVr8oyGb78Izhc=;
	h=From:To:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=blwoyaCS9mssRiLVb80Gkt3iVa9LW8Ql3IUJ1DYICqlNohzTtsh5+HKxZpRY//1IB
	 Ls0/6WC4F41bjxA+a/xqYFAt01azXXSzmvk+rTojFbED0w+HGOUkv/0fK+HpqW8Ihg
	 mbL2cnhXFFlTqUKcCMfIhgpZKw/lKKLs8J05w9V2Z0x3IWoGrZhA793RAgy5ZLqu3s
	 wwvDAgFVF0vd196E5rkwGOb9doulnRVZD+aPIyqimMra90ivLhdeAoRy/RL7ezb9Mv
	 q5HOKDnB24drINZ06e9/eaKJnloFprDszaiq/NeXLY7oHY2UnZLAZVCTyGoyMp0iKf
	 WR8LjDjsiw7fw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9EDDD6074F;
	Tue, 22 Sep 2026 11:13:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 449ED352
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 11:13:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 36C306074F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 11:13:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K3m6rucz-OG3 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 22 Sep 2026 11:13:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 69ED56074A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.4
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790075629;
 b=sJuW0w/nFc55mGbOtKBz9XhdeK8uUuDHgaCyuQSvyjSrT/dskVSxyTNWGehlqa2+Z9tl
 ZzX5JBR4EmhYpCBzRg41P9rDX9Rmtn2MSiQRS1Dr+mCxrZvZSx8rJcTGa+ybjXVkjcrFX
 VZK/Z8eeoslR57AvGV3klalyxYWPBY/AgwH5Ze2h8Zjj7Nm2+7RHKiQCCCmH7BPMy3yv9
 uszOQKEaolhAz1dAOw0CalMUB5FKaoZw7Dmk9SV3swtoyYj0tXE7fbMG65o39YIKaouzl
 gzQEbByjBjxBidxvG4TfO54cPzMzEhihml0XXcGBdYZlgWH1PWlrZneiBJKSBU7a34w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790075629;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:From:To:Subject:Thread-Topic:Thread-Index:
 Date:Message-ID:References:In-Reply-To:Accept-Language:
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
 bh=IhStF+EweKtqyZAy9L/jfCfNkPs72EVr8oyGb78Izhc=;
 b=cHJJImcmN9i+FTx2byzw6yRA9q6WBrldb3wiX6fIxZYV72PVkfhH9TchyNLbz7xzYcCD
 jSAQIaKkXV+Pl3lsse4VsDbP8zBTfz9exSL9IQDm74TK/4L4hXE4hVwLIJ/QkEiakR5a1
 ZVwJZlEnf7Rod8gWb1WIqJChemi+ibbK4NtDE9BkHTaVZNvuyBvo6RMX2pi0QeHb1fm7H
 Dcz+lthr46XaHymXrj4ICPqjLtoz9Dojw1XqS+kz/mgVPeXfiTYIqHUKDU+ye1uk5Vj8/
 iCZlaNxpTvr4lI/qpkGjMXt9EOcayo6J2QOOvnR6Elt+KwcmK47n38UlnySiMZ+EL3w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=RRsrAuw+; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.4
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.4;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=RRsrAuw+
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 69ED56074A
 for <intel-wired-lan@osuosl.org>; Tue, 22 Sep 2026 11:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790075629; x=1821611629;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=2fQkxvIVbOVB06r25F7t+IucHq/uaJpubt79Azpq7wk=;
 b=RRsrAuw+5xwlaOdSIYslqbNrXkd8WZETH5gC56wTC48yUu+xmwv2y+QS
 EEwQE7iEyYBLwQxbb6Yz3QDqwTXWzd7sMJfUSdai5aRSMyRynedBBSMRI
 HecCPeHxUnPF9ps7a3k2Qr3eX9oFsf7VYu1Uibedd19H++MJVo7hbhhoz
 hFi2j0z054IoojuNTuQ0fVGApe5rNen9+dMOl14QKfUg33TEV+dpmP5gx
 k+aMuau+dqPhrMBPhPZQ2Xjxk4E3ovrZ0jq1g8heVuMiWY8v36rpAelw9
 cALoG+eZzKl+JCyl4nkKX2wvWrHvx/CPzTmiiEoculvUm1T8uJ0ghXoGQ Q==;
X-CSE-ConnectionGUID: GWdSD8DrQVe+56MmuAEXAw==
X-CSE-MsgGUID: 9dWJUrPbQBmD+MJojc/y9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="1176827"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="1176827"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 04:13:48 -0700
X-CSE-ConnectionGUID: m3CcSbZNQwyde3obZcfoNw==
X-CSE-MsgGUID: 4xhsADyJRY6A94vxATH40A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="281146487"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 04:13:48 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 04:13:48 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 22 Sep 2026 04:13:48 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.39) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 04:13:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T9r1B8rxTQobGykC61mXJKwYvWsIJwiFRTdbpaUPgdQNvMLqziwZkxNckkT6z921mglz/q3JDvXPU2T/z+d8wX9+1jbVKgFStljLwvno4Tv8tU3G7dpqn2C622U4eQaDiKPZu5ZflXhocWEGRQip+m3eHvFZQ1sly8VqT/cdLMuqSEGQwUouJXGT49pXwuQbKU2Tjz2KD6ttkQeFyJPG7YRyfRnHTuRnvaMLkWk0JQwSjFZoKrh552ZNOox05nJmA8DXAscWK6p05AVUldEQdbbNRpeDhyE43M6AIgb0gH02VYSpqeXeCDckYxX8Kd8ihjxlmbDkA1U35i5+eqQQmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IhStF+EweKtqyZAy9L/jfCfNkPs72EVr8oyGb78Izhc=;
 b=fp3mAFmZlnWNOD7L+YdInqkkT7RfKNV5m8EKK3QhYfv+8vBvyjo+cTTTVnpdBejGIZH3T3PQYllstXZUSW+6/ByJokfhxTL/cbdTVEsDgBtsxxiSWTZaN0eJASpEPxeymsKp6TkSpDatZ6yz4/caMIU135+3toO5x8j+4gI5H0oFoxg2Y7jGx6A+XLR1VnpQlhq8Os75SDVT1Gy3Mgr3oRPJPAX4zu1MpGXwF+oNz08kKVOgvrayRhAy/kZ72N0Hz9xOacXzby2gurGvPaa4bTGt+/VTxyprR6l0cMXsl1rIOgJX2RglDvB9NoapfJwG/pansvwUIXeVhH9On0a5bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by MW4PR11MB7103.namprd11.prod.outlook.com (2603:10b6:303:225::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 11:13:29 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 11:13:29 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Sasha Neftin <sashaneftin@gmail.com>, "intel-wired-lan@osuosl.org"
 <intel-wired-lan@osuosl.org>
Subject: RE: [iwl-net, v1] igc: Fix typo in IGC_NO_QUEUE macro definition
Thread-Topic: [iwl-net, v1] igc: Fix typo in IGC_NO_QUEUE macro definition
Thread-Index: AQHdSn4Fvi+mB175KUO/YIEiA/bYFLbacb6w
Date: Tue, 22 Sep 2026 11:13:29 +0000
Message-ID: <IA3PR11MB8986C7D5F958DE30DDAA3455E5832@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260922103434.55912-1-sashaneftin@gmail.com>
In-Reply-To: <20260922103434.55912-1-sashaneftin@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|MW4PR11MB7103:EE_
x-ms-office365-filtering-correlation-id: 75a9352e-1773-49a1-b5f0-08df189a87fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|38070700021|56012099006|11063799006|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: CbbOQW+z6mf65P9hYUPLNm8n48Zi1i9Kh0aOIkfc84XjhRVrbeSVl/KfuIj4gofK8CYjMqkgRk63QxwxDrEPBjavOM7W0SIB5fkgSgrjtD0ziWa5hLV6EYNFuqlFTJDsSOJZhCldEmArt8pyM8wty+pUuTsk3Wfi0daT5HsUVq7B3GLvBXJEHtFXx3AFlVpXCqcM4R+qv6f+tfGI9svTWQDC9QIjyhmml1+HpmLhE1tDdtTFx2Tr0pPvTr0Y2hW7gFqwMrsoYdaVWjVG6n+GePWov7NBb7N3/tONNdcSLyLoELq39Q4kDbZbcDiUQWvxPhVnHAKRwwTGMCYi36H/WU5M8HR8fpPRRvTv5war7X6AN2CvSF3mcqbtnVoQNHfeAwwQjmE2y2nHRH7AnNtJHQ0tteT4d1Gs+gJFqV21Ur4VduXEVmdOqB+N15xhHM+L+NBRiN0P/1Wy7S5j8VFuscJWuVRGlm1g1Cr3GF18GFvq2Jg7Lf1VV+3dDlDpSHGcO0ZdofPPSuoKH+uQ38TmuL+zJcH/2UJZzMnx0iC/0ycHYofNqp9sjhf45wmcI7YgpFepvAnpBTE6t0feQlFOjp13xM9Moyerf+jf2HYJZn3w0YKbPrKOHucBF26BKve7KgM8AI3yxc4U+VRJBOjHI4+3mI+Qofwa2szuBsGm2Tdv+gSUlskuHS9qxybE2Vj5sap/3pBBkSrIFNi8pECYeaa/McxLzXQbVyAmhbN3MK0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7lXk6IABmMjfdr3Z9ai2Yb81OROAYw3DuMWKqxDttwtED7wkhfuzyDG95Bpv?=
 =?us-ascii?Q?1AVjfGpUcPMnXKOqY7lWCt472U4qr1A6h/ivRERPrL34q9G+biRmnHe5fLWX?=
 =?us-ascii?Q?Nlq38ZbC4pL9UxtaXP72SBfZ1ZQxsLn4L8zyHUaka3mmyY65vuWH4aLMDUyI?=
 =?us-ascii?Q?j/Ljt3Jkzdmx46P3j1qgSM2MbqsKHL7lYE1VfdXgAVkoHi/fifHjXSYEo+dZ?=
 =?us-ascii?Q?yw9HxFcJFchuYB4sbLxmRzG695uKBsPzdCSYYkL4jxivLhuCfcviSzm2LCIJ?=
 =?us-ascii?Q?cduFHXTHiD1c5NXqalfPsPkOoZzWjIFAPiMQ5buO1Jq7vhzYN/5QG3MuX6ZR?=
 =?us-ascii?Q?7xJWnn3yXFpQqe1+PrSaLapY9yXOywowLwpVTISc1stxQD6NsIGR0TzMDmjb?=
 =?us-ascii?Q?FtAKtsFp1nJkBG7lOvgAdbpP+x+51rFBz/95wCQCSbHoajeKTOH/cp7Tn/Gf?=
 =?us-ascii?Q?97yixxQdvvTACz082xyJEJBbW33dasYBecifSLhVntmTjFN2olcrq5jyO1J3?=
 =?us-ascii?Q?j1S289c/M/tFccm/nI5jSPYfS4W4iOw/Ew9W/SKLbI/qV+W3DBGGlBnrvGy+?=
 =?us-ascii?Q?wQroVgG4nNbxmMCmsdfCm9FGywISgR884orrFKkQ+Ro7TPvLzZNHRaxYeoo5?=
 =?us-ascii?Q?/rs3rEFvIw2KVCgObIOh0Wb3/H1lWaztknx+X/bfIPzv9XeHecMCxQGDf9lw?=
 =?us-ascii?Q?L5Ve8p64nnavAgYu8WDn4dATgcWI6bVxS7g4ifSnMRHNHzjP0ROUULofaGrh?=
 =?us-ascii?Q?eXMKu2wrb2a3iNkFOozLDkgeIzPxHH0UtL/sD95BQ6sYvFod/6Ankb5UladV?=
 =?us-ascii?Q?NVKU+wyUmqrpLijLEr/uqiwaCHm6h2FQ1Dy7mzM5KJMZIfDpsdOquHjRPQ7V?=
 =?us-ascii?Q?myuOKGwLPobAiYpxuPK5NIcb7IgFdarL8DoHAGqYV9RxygCznpicoBRcjjuN?=
 =?us-ascii?Q?KwcDgXEXklKelasN92XgY1pL5SdWlc/SfbVUvdvwvPwwPUZ9OhFsgfzj0nMI?=
 =?us-ascii?Q?JIMd6BGHgkhisuez90hqJbmZHfqNUpm+NW01G/5h7K5bc9YEk1r3KzhUMAtW?=
 =?us-ascii?Q?x0eZEiGyjeC2+4K6EIGcidwtXh4/OgDPRym855VAEDtbkds1+hYo5sHsryQX?=
 =?us-ascii?Q?Qem0VfimG1zONGeVWDejGrUol3pIzeuNxeSIsyGKC4+pJmt0kbpIhEsJ0mxu?=
 =?us-ascii?Q?68OLsRIBXhlBeWlRApjgkWG1P7dPEq1PLgYEy4xiOVOIeXc3GsVxnFh0AVqD?=
 =?us-ascii?Q?Lsueck4kuEIwZ8OWcyLm9EQxybLnRpdI6Y8AN+WQkBLBeEaphrApNYTeFe2q?=
 =?us-ascii?Q?OyNWJpiAANV1vbNl1Is6OwYWCV8jQGMFxcyhcbNNMPyshGvUaf15SST2q5/F?=
 =?us-ascii?Q?L68o7OicuY0CAsoJBstjVK+anmD0uYBMiAFXI4Tfqb//EEjvO/rvBbaY8rCM?=
 =?us-ascii?Q?C1ZKqE4ASJc+JNPXWaXWczEZyDs4lqkFy+qmCxzHde86gAnG98Sk9SShNQi2?=
 =?us-ascii?Q?V3DRO2GjQxYhY3lFOVnmD04tIfsp5MLQ6LyjUtUahBbw/Sz+cNUlxHXP7lag?=
 =?us-ascii?Q?NA0JlqHQKmfSBylwSnic0YeZlP/HH2SRUkQ5tx9mDpET3PaAeY5mzezVAFQh?=
 =?us-ascii?Q?KZyyVLa7ONXGUflTVC197RuYue4OK95mACY20kUpUXsUyKY5QQM27RHiHF2W?=
 =?us-ascii?Q?B/kJ4B8k+a74gLDb6FxkccB/F4Tp56Wly4NxLcoKrD84icMwrNavCIujRc3J?=
 =?us-ascii?Q?Hqzvl/Qj+yWMeKJEjxUA9wE3Mj0NcZk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: RL8Mx+48c4D0XzRBJnsp5UM8AY3BLUZ/6l3h7SOJCJ7EuLjs3H0fZT8kPetjWAX4r7vUGW7zwXlGEvHWYmaS7LctDFsqVerF/mVEp8PAIDIshWbiL7O6nHB5s6rQAKtn1u1hrp7xkRKDgSr/igOAPNFNMcqNuTFaVeUEigbkEKINPfPgeDvaNxTGi33Dg2i+uNLCUkkcnbvmtmAc5FeZAq7bAqAG+VFAIdDYaeYk5YfdG8lXazwCGNLj7Fd+S2yy8QFDkIOeEHEZHPUuqxhI2Fv97S44yNoM6tnykos1Bmei+i1PzYWTzwKa+c9SKQepx2jtX+ExNZd5ccPG09QYng==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75a9352e-1773-49a1-b5f0-08df189a87fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 11:13:29.5392 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VQynto+1NPzt+K1rfp7b92rMTdBVWWJr68k45uwtv6zOzpDJVA87pSYiEDbpNIeqwV1b+PKqlrqaip8GjRV4WiXmAnY5lebFCmmoY2iVy5Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7103
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
> From: Sasha Neftin <sashaneftin@gmail.com>
> Sent: Tuesday, September 22, 2026 12:35 PM
> To: intel-wired-lan@osuosl.org
> Subject: [iwl-net, v1] igc: Fix typo in IGC_NO_QUEUE macro definition
>=20
> Correct the macro name from IGC_N0_QUEUE (using digit '0') to
> IGC_NO_QUEUE (using letter 'O') in igc_defines.h and update its usage
> in igc_main.c.
>=20
> Fixes: 16ecd8d9af26 ("igc: Remove the obsolete workaround")
> Signed-off-by: Sasha Neftin <sashaneftin@gmail.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_defines.h | 2 +-
>  drivers/net/ethernet/intel/igc/igc_main.c    | 8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h
> b/drivers/net/ethernet/intel/igc/igc_defines.h
> index 3f504751c2d9..ab55b88d4d96 100644
> --- a/drivers/net/ethernet/intel/igc/igc_defines.h
> +++ b/drivers/net/ethernet/intel/igc/igc_defines.h
> @@ -721,7 +721,7 @@
>  #define IGC_LP_EEE_1000BT_MASK	BIT(2)
>  #define IGC_LP_EEE_100BT_MASK	BIT(1)
>=20
> -#define IGC_N0_QUEUE		-1
> +#define IGC_NO_QUEUE		-1
>=20
>  #define IGC_MAX_MAC_HDR_LEN	127
>  #define IGC_MAX_NETWORK_HDR_LEN	511
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c
> b/drivers/net/ethernet/intel/igc/igc_main.c
> index 1fb5f3cbe93c..ba75350291f5 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -4223,8 +4223,8 @@ static void igc_assign_vector(struct
> igc_q_vector *q_vector, int msix_vector)  {
>  	struct igc_adapter *adapter =3D q_vector->adapter;
>  	struct igc_hw *hw =3D &adapter->hw;
> -	int rx_queue =3D IGC_N0_QUEUE;
> -	int tx_queue =3D IGC_N0_QUEUE;
> +	int rx_queue =3D IGC_NO_QUEUE;
> +	int tx_queue =3D IGC_NO_QUEUE;
>=20
>  	if (q_vector->rx.ring)
>  		rx_queue =3D q_vector->rx.ring->reg_idx; @@ -4233,11
> +4233,11 @@ static void igc_assign_vector(struct igc_q_vector
> *q_vector, int msix_vector)
>=20
>  	switch (hw->mac.type) {
>  	case igc_i225:
> -		if (rx_queue > IGC_N0_QUEUE)
> +		if (rx_queue > IGC_NO_QUEUE)
>  			igc_write_ivar(hw, msix_vector,
>  				       rx_queue >> 1,
>  				       (rx_queue & 0x1) << 4);
> -		if (tx_queue > IGC_N0_QUEUE)
> +		if (tx_queue > IGC_NO_QUEUE)
>  			igc_write_ivar(hw, msix_vector,
>  				       tx_queue >> 1,
>  				       ((tx_queue & 0x1) << 4) + 8);
> --
> 2.43.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
