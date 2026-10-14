Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7723CC6B1D
	for <intel-wired-lan@archiver.kernel.org>; Wed, 14 Oct 2026 10:46:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7D3016076B;
	Wed, 14 Oct 2026 10:46:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ea-hn7os_3ep; Wed, 14 Oct 2026 10:46:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 77F1C60783
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791974815;
	b=oAM+TAoE3qQih+/aUm9MC5Hi/9Z7XToIHHV85mNHG7hZrSGbArynUBYCS/U7bG6GmyDI
	 3aSRwBINpDDHHgaq5qJz0eyXrMVWZf9mkWsrh8B1uWfwBuTDdlz2oH/d1PTG70GFDx/Z7
	 XhBBDVhXC4iJVzLWJCutggQi55CuYrLUahF4M9j3K7kVVqSLeFR7H1Yb1VG7vHb8MiU9r
	 /Jqcc9uItReQH+2rEsYId04iZq+JfUMgxvm2mBjg8aZLhCUg3G/5U9QBRgRnbzUb9UWaB
	 jfGqp6qh0dxEy3TzZ6XI4WXLMpbvNitIi4LTTzXeB36aKQfnb/3/v1dSsvm6TDxoAhw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791974815;
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
	bh=Tji8Y0mE9fxusvR6SC28fYXxNCyZwVdPavVGbVQYfxk=;
	b=GhZiSNavDNjGqBFhP0FLOO+tWKzv1efNz75YrRpMqKjQYA1klrww88XnOn9eMrm3TKWL
	 5sxyi7gHNzpYmF97oGngPJbqzRb0MDd252ItuvA1z1ks11lW7d+s8LUnDNvPptR9XYcs/
	 XWllSLKyFT6YW9vgL1Qd6/cdxk3BSNSNuk0yEVhkwd7NKtmulycUCfRaBGpeX4Dopsn36
	 s86fFl00Ijfet0+FjJQOGKh9d+HSqLQctUcB/ZzssD7MUDTn/9AL1SKflyl1Q2Govf6lc
	 YfcYja1l+46hccu4BVazBISagxpFMj1IOLJ48WegIgyloR5aM+UBizUaBVmtKp0aWfg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791974815;
	bh=Tji8Y0mE9fxusvR6SC28fYXxNCyZwVdPavVGbVQYfxk=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XEkUXHCcBHZJw4+hZKw7mfaI94BoSBdRhOYWWgbvp52YrgyhaMc2LN+Qo00BnlLcn
	 BbBbWJmqhcp724d/vipR9BDOBkhAEK2/nixC3orXfDhOOidtBMcBdUUR0HuePl2PVI
	 rYehyZQ+0TZbEa6FcuH3HjwvrzaXyuZuv7JdtXIoTJIZfA2I8tcA2BY7p4WKuoj3mo
	 39BG5ldvFIbOfhlU6PyhZ6WFFctyyCJLj2bmbyzGlkSJtwx2Ed12xN+TmvAs5gS86/
	 d8QC/iSXZuf0HfpfnpyGTfnOQ1P9Vntu0VzBMoxKfx3EcazJonrKLrBBWqYibu0HUv
	 jhJF9/MgSzYpg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 77F1C60783;
	Wed, 14 Oct 2026 10:46:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1F27B255
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 10:46:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0DE7C80D07
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 10:46:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5K_3Nubf-veq for <intel-wired-lan@lists.osuosl.org>;
 Wed, 14 Oct 2026 10:46:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C6F1080C42
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.21
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791974813;
 b=MwHrYLPmCkiiupkV0tVK8bqBjKkYIAMX8bKbvmAHTOIne/8jdVl53c8Ung7if4AzXOjR
 AomC2cfmbBOxgZcVeTcd9QLloC2KKlfKxNwdeklS2vgjDBJWO0p2Cyrb0bUweu2rY6uxG
 8mvYn1szxt+zlCyMNd54WzjXSMEMVkHFve+LL+hinu4hQ4rDUKk33k6u2WFULl6/qWVRq
 /oDOJvsnMdwuDCYWzUh2S468I8q0hghfS0gFLYqTWfG1xp5wzF7ntE1HQx2dKCORljmwR
 3CNDtikXIYIcxsJyCosNWDc9Pe8bdCD9SckrJAdhu9xkD5AEK4gLz9rjoU4VVkKw7dA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791974813;
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
 bh=Tji8Y0mE9fxusvR6SC28fYXxNCyZwVdPavVGbVQYfxk=;
 b=nT+HdWnjoCpP//411Hoxh+t8OgIBHgKE0knZgbGZlvLN5nS0RiVMcMEm+zjW1JIyq838
 ipRGgc4usQM55juYrztD77SCQi6/a2kP+WfDexXcgeGKaqrsG1FxVoALAF1+vy35e7svU
 9GwlYMWaRPeTGYf50XmqjxjL3dx0diA6Nsa3986ac/5C4QoNLTYsuj03dnNUneWnJuGfk
 6Br3ZYgzWjfE7Pv4EWEvLJovUPO2vGSwAnwx4AtsKuc2gGOYTqb2zzuviMhiAhHWC8230
 t9JVygKjXF+1mPQ4MgdYSVbFs9tuca9ayfUG9oHtZNRQihlNdfBP1PrJbsVQ6Y3zU5Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Q8bMM3K8; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.21
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.21;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Q8bMM3K8
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C6F1080C42
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 10:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791974813; x=1823510813;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Tji8Y0mE9fxusvR6SC28fYXxNCyZwVdPavVGbVQYfxk=;
 b=Q8bMM3K8MToxPcPPAHTkvMl+zx03c71qnIOHVH/senrmJNphDbfSQ6zs
 oqR7dFIZNgVm7OdRxg41MGLS++mKfQ6xBMNcLJ11A9DNm9t1lpUyXbcSb
 hkQ1C2AUVnpREeYgqMnh6DO1Xc3P8seKWfsHCnNibi6ZfN1BkN0DrOfLm
 QGeZ8GcIMZvuG8+iXtZY58hq0ksSAaCWDgF6X4dmnHU7fe/upUwohXf8T
 DHpYChO+dEVXxnFHU2KcTvt2ncPu5775N4X95ZEOZ6XOiqyd1y40swqkU
 bj6vGX7IyMFhCeI7hB4O+IiAWlbErO9rtmyuay0ZgIBaWrVoeNEbQPwxS w==;
X-CSE-ConnectionGUID: V9sptkEsTIeE8P2tuF8lcA==
X-CSE-MsgGUID: wicPdpNARLSRu2kkTzovqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="814983"
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="814983"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 03:46:51 -0700
X-CSE-ConnectionGUID: 4JCknSFATO63GcwljscCnQ==
X-CSE-MsgGUID: Br1qjpadRHyFBWwFhJWX3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="1610373"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 03:46:52 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 03:46:50 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 14 Oct 2026 03:46:50 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.56) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 03:46:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zBEf2K8hKDzP3gdxHjpDEZoJLguCQbQ626+qcKsCHz4t0EsBiQQs4sRfZZ+ajQuayl8n7ufvpTZU6mYVw40wxxy3wnUs/cFYI0MPP9iGv38YqLL5iprl93T5MBMSd1Q57/HfDRzKvOGH8E62avyCFqxCgVj2c60czpDJr6ND1ujEx8kQV98zYfGQfN9Vjaq/d8NEIhj0jX/z3D3ox2uvJjnIDpIqJCH/xIN2U6w22cuTvEGzLrTELPcrZXcHVQSthgojeESKpU/PAg/SKhC+adKcEf5s9KTa/Pgx4v9SxcfE+mStf/tOLfwLydFWuasg+UoS7XEm8AqWEwiWlWu3eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tji8Y0mE9fxusvR6SC28fYXxNCyZwVdPavVGbVQYfxk=;
 b=MHTrhMoSuinEDP7m2YGY1u0yLHMNN7UyCV6ZQGgqfiF9+ISHPhtvEbaWEz+IcdlUDwa+Ij7lIOPxsqIiYt7fupXplMD1Gwj2GQ9TFGJPGT9iXZ0KZJI/NAlbbc9MWxcKt4xb9zsK4ktQzyA/IeSBVhZG7yKBiMqJih8zj02Ym/zuaY2e91yOJAmOgVY17MVCb3X7P6HLICA696MnJd7AuIP0+7/9gvsdky1Ly3nG4bHvp+GZnC/ZPpZY4LYetlMnW9mc6V/zbKM+CdKnPPxC7oD+nZB+8gvbIyXhEX9iDV28B6hWBmYuC5FsndhiNjvVZSK6UHRlaCkcE2mec0DVDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF7551E6552.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::31) by SA3PR11MB403611.namprd11.prod.outlook.com
 (2603:10b6:806:58c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 10:46:43 +0000
Received: from DS4PPF7551E6552.namprd11.prod.outlook.com
 ([fe80::ac6c:1d96:c766:799f]) by DS4PPF7551E6552.namprd11.prod.outlook.com
 ([fe80::ac6c:1d96:c766:799f%5]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 10:46:42 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Brian Vazquez <brianvv@google.com>, Brian Vazquez
 <brianvv.kernel@gmail.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, 
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
CC: "Chittim, Madhu" <madhu.chittim@intel.com>, "Hay, Joshua A"
 <joshua.a.hay@intel.com>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "David
 Decotigny" <decot@google.com>, Li Li <boolli@google.com>, "Tantilov, Emil S"
 <emil.s.tantilov@intel.com>, Paul Menzel <pmenzel@molgen.mpg.de>
Subject: RE: [PATCH iwl-net v2] idpf: wait for the reset completed state in
 idpf_check_reset_complete()
Thread-Topic: [PATCH iwl-net v2] idpf: wait for the reset completed state in
 idpf_check_reset_complete()
Thread-Index: AQHdWBpjolveLFtmyUmwuswIknNeArb84lcg
Date: Wed, 14 Oct 2026 10:46:42 +0000
Message-ID: <DS4PPF7551E6552686B1C0E5EF78B23A44AE59D2@DS4PPF7551E6552.namprd11.prod.outlook.com>
References: <20261009181553.582029-1-brianvv@google.com>
In-Reply-To: <20261009181553.582029-1-brianvv@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF7551E6552:EE_|SA3PR11MB403611:EE_
x-ms-office365-filtering-correlation-id: 2b2eacf5-6b51-4d1d-dabd-08df29e06f37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|7416014|1800799024|376014|366016|6133799003|22082099003|18002099003|10067099003|921020|38070700021|11063799006|261009223027099003|5023799004|56012099006;
x-microsoft-antispam-message-info: YvMY1HcQidqRaSUYjEnBJv4m6DVzBWQQXJvWU5VOoHZIJIecNTyrSk1NRET4rlZ9V8qEnOwa7Lzac8T3nRM8KP616CZ2xCJLJuO9pFYq7NUfhNfvWSHrSeHjK0N3aU0+OuXnIHOGXW4Gp8OfqTkAx8sdN0DYYUNqhUNEsclyA8jnFo6hTFtdqHaGC4ue+M+vatN4N8MLR+ANkqyA9ZGpBwOgf3Lsp7Wnh/CE6hNTu+zgW9WBDQuomN1AyFltgOXWRW3611JWajjApgV+Jc7tcrGsxHJIDoFeZftSYPkFMjBXRCLHPImYsS12ENpIEsNvFvldHs98cfoOeTU9BvAKwXAz3S1uZ7IEaJ56iJMY6IDVyjQDwhZNpfwAxwAjTaXP8qj79nt5iGzgI1aT11C4RXyRuzok/nnjZZxvrqqJmQ2SLOUd/tyexRNXI0ARn4yEIJfX+akfEzCJ7mrkzQXCg9r25OfxlYheUq8C43aiiniSIInHLzEabP8onxxMaHndNjQvQKoaHa2MIkPYFmKkTW3TFA6F6CD/MNNrh6nGzsdRMzIH0hBsA/hDypJXjUOZXTxm7A1ohyKcE93cJEj9TnWfaBEn1PNjK94lBUbHu4EoUW6p5BwGkisvMnjf7SlPHtCohHZnfojE5J8T5ggvD/ALzOTwJzwaw1N3GfGvhHeAoCUWslmoPXjJxgMn5Ff657D91N8sMZNdjnKbYUxrORaAD6Ika0tXCOI9WCG8/3QonKVyLLXid0lhO+JtU0vE
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPF7551E6552.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(1800799024)(376014)(366016)(6133799003)(22082099003)(18002099003)(10067099003)(921020)(38070700021)(11063799006)(261009223027099003)(5023799004)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1dtZXNERFcxNk5wckpMSGt3Z0RUT2N6dU10RHQ3OG9VMHY1WlZRSUlodFU4?=
 =?utf-8?B?UkhTUXZRMzBvZkVZd1I1NDhKZWRxZDBWMTE1a1JpUkF3S3ZINTE2c1hzRjBO?=
 =?utf-8?B?d05wZnVocnBhdXphV2oxeTE4MVBiN01BMVZEaWQ5WmZaOVlZa2h5N2M2YllP?=
 =?utf-8?B?dDRCc25aeVo0NFR5UGRMSml4MUNnaHY0L2htTXYrUTd5Nm84TTFVemR5N0U3?=
 =?utf-8?B?ZFd5RnJuU1A5R0JDY0NPeTNJbDcvSFp5MWlvc0dDMXkvSDZwNjFoODlHUmV4?=
 =?utf-8?B?aFR5NC9icm81cnlvK3ByVUs5YmJ0Mmt1ODJpS2RZU3crTWlrSnlhazB3by9S?=
 =?utf-8?B?MFJBNGt2TmxKazRwalZaQkp6ZGdoSWF3MkthY3Q0VU1HbjR5OFM5TWJNZXZx?=
 =?utf-8?B?VHF1emp5MStRRHBidlFLSjNlTVFobDc0RUJ3dFp1LzFVS3R6SmMzMDhPSTJY?=
 =?utf-8?B?QlJ0KzAxWTE0bXdHd2E5MTk3Y2M1UjByRUM3YXNGaW1scUNIK3JId2xydmpP?=
 =?utf-8?B?MzhvMERBZ2ZtTmtnYjlWMzMrSmJMSTNCWTFqWTZQZ0dSYlNXYnU1NGo4OVVZ?=
 =?utf-8?B?Zkw2VG5kOWZyQk9DcEZBZTlpTUJ6cnJia1Y1c2xReXRkWm1FUGdYWjU3Ymt6?=
 =?utf-8?B?OWZHb3B6a2x0c1Qwc2dzeVkwTUJuc29Pa0U4UUxzNmRUMTdoeUFHTDVKN0g1?=
 =?utf-8?B?Tk52TTVCOXV3MG1YaUZXcXBFSzl5VytDR3hLWWN2VGIxVGN2YVJTMlQrREJV?=
 =?utf-8?B?UWxhMThwQXZ4QUxCd1dHT0ZtcDlGTWhDcGUwc203c1hSS2U1QTNrN2lEd0pi?=
 =?utf-8?B?c2tiNTVIQVEzQjJkWVFQK3AzL3YyeGc3Z04vZVcyQzBsVW9UaENQeFRRcEk1?=
 =?utf-8?B?NkZnemh1UzR3UVd0alJTR3cvNzRSTHVYTXdhb3JSUEs2b3NQRU9MTjNyZU1B?=
 =?utf-8?B?NjN4RVhnbjFlK0JGbmgyakFpVjBxTnNMbTVNdTFOSjBrRWpCNW1ZMzBGbjBU?=
 =?utf-8?B?K2xlQ0laUkNpU2g1Y0tFTDZHQWREYnFEdnN4cEdCaGtXaFRaYkVVWGdZRk5h?=
 =?utf-8?B?SDNnRlpHNk9ycVFuY244N1UzNERjSWNNTjdXT0ZJZ1J4aVNmT0VQS3p4dndF?=
 =?utf-8?B?MmpQV1ZGRld3anFVc1NQblRnOERkMGRpcHl2bjU3QWlGVmVWQkd2aE1XOWRB?=
 =?utf-8?B?TGg1VWRlWFNxdWUwWXdxQjRsRGhZTEt4NE4rOStVNWtBblhNUkZIaE1kemRj?=
 =?utf-8?B?R2hrV0pOekpPOG9TUVZiNXJrQmQ5UUtUMFhHeWhxVDYxMWZqb3EwalJ4ZGZY?=
 =?utf-8?B?UFUwb0pIT0x1czBjdk8zRmNaellrQkFORE1QY0oraVF6TDdwVGVVOC90ckFq?=
 =?utf-8?B?eGlBVXYxUUJUekxjazg2UzJMelhMMmF5L256V1FsN0laNjY4ZDhBM1k0clkz?=
 =?utf-8?B?RUpBNHUxRzhJMXZBS1BEaWRrZ3RkTlJGSk9hczdKQ0tibER3K01SaFlCT1V3?=
 =?utf-8?B?dzZLdHFaQmV5a250WWtsOVlpZGZ2T25Kd3RmdmtyVE1DbTJYaDlsbHZ4V2Vz?=
 =?utf-8?B?eE1Cc0Y0VlVmSE9UMWkxd1NxV1ZzdkJxaGRVODN4ZUcxelpNQzlwM3pnYXRl?=
 =?utf-8?B?OXNKb09zNlZwbjdkRy94TXpiODNYbTUxcnBKOWNhYkhWQUpuM3BZNGRnRDVR?=
 =?utf-8?B?QlB6bXlJdGJ6d3d2dys0Vi9IU0hSSTVaQWMraThSYnNLZ2RVZ1RFMFNmWGpv?=
 =?utf-8?B?TXdOcFJ3b0kxTEtpMmx4SGhWRWNaOXNQU0Era0R1amlRV2ZETmgyOGxSb0tR?=
 =?utf-8?B?ZWRhUXd2YzA4SEtsaDJwSVp6dEJQeUpWZ2N1VzhQRmhlWTkyNDFqWGNTejRt?=
 =?utf-8?B?UklVVlJNSEVPcXFkVTlRNllwd29JdW5FZHdTelJvQWJueUZnRzArVGhqQ3ZK?=
 =?utf-8?B?YzE3dXh4Wkpvd05mR09yTTdLdHVKWXoyM2pvend6cUJXSkRUc3hGRmF5Nk82?=
 =?utf-8?B?MVlxRncyclJZN2hLWjU2MVpSZVozVUNkNC9MWHNISndxVHZQR0VKUXB4UXB1?=
 =?utf-8?B?ckZXSWFHYkVtVHY3MjZqQzFXRnpyUVJOczYxcGVYdGdWU2RqMHRvemhHYkhI?=
 =?utf-8?B?LzFucFFEeFFFak9NbC9XR2F0VlBQdnFtVUF1bUdaTzVmNnVyMjdRd1JBNkZC?=
 =?utf-8?B?T240NE12bUg4YmFLSlp0TU45ZWIvU3RNSXNoL1hwVDZyNlovTzZTSWZrWjhG?=
 =?utf-8?B?aU1VdUY5MGdFL085ZUpqd01WQmFrK3AvMVQxcDZOTDMvVFFSR3RpRTU2NGZt?=
 =?utf-8?B?MEkwRHpEdGdyT2Q3b0xvbDZvTmJtWldOZE5IMUM4bEFwbEZxNE0wNHI5S3RP?=
 =?utf-8?Q?LhEtKnAWnkM/GCxU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 466gmVbbQwXIVlkP+bX2DKEn3jvAM3ACWwgRXQT7bmDkyMfDlrjFTF/Ufyrs1MV9Yu5gyAkWbdw3j8dv4S1gIBUnkN36VHu/VBo3CEqREXOzgW3NNW5x6X6v9fmj+qXu1zlIh+OTfOqvVRImyNAsRhUXlwElsxwKbd736l+heXSh5WogL3DzUt+Y6WqJODW64omVvPI9svXAMq2U2o1bJuqXtc80zmLp0kyGjRVtwMqfrhKatUxSGhAOMgZj1mRh0G2Ul37YANKnE4WqNq0P604S2jtHrSrryh4KUHq0jrgUagizDXUnHUwvcXr1ZVPqHimX+FgDQWrzUllUSPvs1A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF7551E6552.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b2eacf5-6b51-4d1d-dabd-08df29e06f37
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2026 10:46:42.5016 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fTMB9ypARpmczYprNcWckrbUP6NjQYDvkS3glDhpcQqMDpkbf3kEL9bv57LhaNtko/9jf3LZSIujvLKIQfXfPOPhjoGzRccO1lmwGwXBAj0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB403611
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQnJpYW4gVmF6cXVleiA8
YnJpYW52dkBnb29nbGUuY29tPg0KPiBTZW50OiBGcmlkYXksIE9jdG9iZXIgOSwgMjAyNiA4OjE2
IFBNDQo+IFRvOiBCcmlhbiBWYXpxdWV6IDxicmlhbnZ2Lmtlcm5lbEBnbWFpbC5jb20+OyBOZ3V5
ZW4sIEFudGhvbnkgTA0KPiA8YW50aG9ueS5sLm5ndXllbkBpbnRlbC5jb20+OyBLaXRzemVsLCBQ
cnplbXlzbGF3DQo+IDxwcnplbXlzbGF3LmtpdHN6ZWxAaW50ZWwuY29tPjsgQW5kcmV3IEx1bm4g
PGFuZHJldytuZXRkZXZAbHVubi5jaD47DQo+IERhdmlkIFMuIE1pbGxlciA8ZGF2ZW1AZGF2ZW1s
b2Z0Lm5ldD47IEVyaWMgRHVtYXpldA0KPiA8ZWR1bWF6ZXRAa2VybmVsLm9yZz47IEpha3ViIEtp
Y2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+OyBQYW9sbyBBYmVuaQ0KPiA8cGFiZW5pQHJlZGhhdC5j
b20+OyBpbnRlbC13aXJlZC1sYW5AbGlzdHMub3N1b3NsLm9yZzsNCj4gbmV0ZGV2QHZnZXIua2Vy
bmVsLm9yZw0KPiBDYzogQ2hpdHRpbSwgTWFkaHUgPG1hZGh1LmNoaXR0aW1AaW50ZWwuY29tPjsg
SGF5LCBKb3NodWEgQQ0KPiA8am9zaHVhLmEuaGF5QGludGVsLmNvbT47IFNhbXVkcmFsYSwgU3Jp
ZGhhcg0KPiA8c3JpZGhhci5zYW11ZHJhbGFAaW50ZWwuY29tPjsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgRGF2aWQNCj4gRGVjb3RpZ255IDxkZWNvdEBnb29nbGUuY29tPjsgTGkgTGkg
PGJvb2xsaUBnb29nbGUuY29tPjsgVGFudGlsb3YsIEVtaWwNCj4gUyA8ZW1pbC5zLnRhbnRpbG92
QGludGVsLmNvbT47IEJyaWFuIFZhenF1ZXogPGJyaWFudnZAZ29vZ2xlLmNvbT47IFBhdWwNCj4g
TWVuemVsIDxwbWVuemVsQG1vbGdlbi5tcGcuZGU+DQo+IFN1YmplY3Q6IFtQQVRDSCBpd2wtbmV0
IHYyXSBpZHBmOiB3YWl0IGZvciB0aGUgcmVzZXQgY29tcGxldGVkIHN0YXRlIGluDQo+IGlkcGZf
Y2hlY2tfcmVzZXRfY29tcGxldGUoKQ0KPiANCj4gUEZHRU5fUlNUQVRbMTowXSAvIFZGR0VOX1JT
VEFUWzE6MF0gKFBGUl9TVEFURSAvIFZGUl9TVEFURSkgZW5jb2RlIHRoZQ0KPiBmdW5jdGlvbiBy
ZXNldCBwcm9ncmVzcyBhcyBhIDItYml0IHN0YXRlLCBub3QgYSBmbGFnLiBGcm9tIHRoZSBJRFBG
DQo+IHNwZWNpZmljYXRpb24gWzFdLCAiUEYgUmVzZXQgU3RhdHVzIC0gUEZHRU5fUlNUQVQiOg0K
PiANCj4gICAwMGIgLSByZXNldCBpbiBwcm9ncmVzcw0KPiAgIDAxYiAtIHJlc2V0IGNvbXBsZXRl
ZCwgd3JpdHRlbiBieSB0aGUgY29udHJvbCBwbGFuZQ0KPiAgIDEwYiAtIGZ1bmN0aW9uIGFjdGl2
ZSwgd3JpdHRlbiBieSB0aGUgY29udHJvbCBwbGFuZSBvbmNlIHRoZSBmdW5jdGlvbg0KPiAgICAg
ICAgIGhhcyBjb21wbGV0ZWQgVklSVENITkwyX09QX1ZFUlNJT04NCj4gICAxMWIgLSByZXNlcnZl
ZA0KPiANCj4gVGhlICJGdW5jdGlvbiBMZXZlbCBSZXNldCIgY2hhcHRlciBvZiB0aGUgc2FtZSBk
b2N1bWVudCBoYXMgdGhlIGRyaXZlcg0KPiBwb2xsIHRoZSByZWdpc3RlciB1bnRpbCBpdCByZWFk
cyAwMWIgYmVmb3JlIHJlLWluaXRpYWxpemluZy4NCj4gDQo+IGlkcGZfY2hlY2tfcmVzZXRfY29t
cGxldGUoKSB0ZXN0cyAocmVnX3ZhbCAmIHJzdGF0X20pIGFzIGEgYm9vbGVhbiwgd2l0aA0KPiBy
c3RhdF9tID0gR0VOTUFTSygxLCAwKSwgc28gYW55IG5vbi16ZXJvIHN0YXRlIGlzIHRha2VuIGFz
ICJjb21wbGV0ZWQiLA0KPiBhbHRob3VnaCBvbmx5IDAxYiBjYXJyaWVzIHRoYXQgbWVhbmluZy4N
Cj4gDQo+IFRoYXQgb25seSB3b3JrcyBpZiBoYXJkd2FyZSBtb3ZlcyB0aGUgZmllbGQgdG8gMDBi
IGFzIHNvb24gYXMgdGhlIHJlc2V0DQo+IGlzIHRyaWdnZXJlZC4gT24gdGhlIEludGVsIElQVSBF
MjEwMCAoODA4NjoxNDUyKSBpdCBkb2VzIG5vdDogUEZTV1INCj4gdHJhbnNpdGlvbnMgUEZSX1NU
QVRFIHRvIDAwYiBvbmx5IHdoZW4gdGhlIGZpZWxkIGN1cnJlbnRseSByZWFkcyAwMWIuDQo+IFdo
ZW4gdGhlIGZ1bmN0aW9uIGlzIGFjdGl2ZSAoMTBiKSB0aGUgZmllbGQga2VlcHMgaXRzIHZhbHVl
IHVudGlsIHRoZQ0KPiBjb250cm9sIHBsYW5lIGZpbmlzaGVzIHRoZSByZXNldCBhbmQgd3JpdGVz
IDAxYiwgd2hpY2ggdGFrZXMgYSBmZXcNCj4gaHVuZHJlZCBtaWxsaXNlY29uZHMuDQo+IA0KPiBD
b25zZXF1ZW50bHksIG9uIGEgaGFyZCByZXNldCBvZiBhbiBhY3RpdmUgZnVuY3Rpb24NCj4gKElE
UEZfSFJfRlVOQ19SRVNFVCkgdGhlIGZpcnN0IHBvbGwgc2VlcyAxMGIsIHJldHVybnMgaW1tZWRp
YXRlbHksIHRoZQ0KPiBkcml2ZXIgcmUtY3JlYXRlcyB0aGUgbWFpbGJveCBhbmQgc2VuZHMgVklS
VENITkwyX09QX1ZFUlNJT04gd2hpbGUgdGhlDQo+IHJlc2V0IGlzIHN0aWxsIGJlaW5nIHByb2Nl
c3NlZC4gVGhlIGNvbnRyb2wgcGxhbmUgdGVhcnMgdGhlIG1haWxib3ggZG93bg0KPiB1bmRlcm5l
YXRoIGl0LCBWRVJTSU9OIGlzIG5ldmVyIGFuc3dlcmVkLCBhbmQgdGhlIGRyaXZlciBzaXRzIGlu
IGENCj4gNjAgc2Vjb25kIHZpcnRjaG5sIHRpbWVvdXQgKC1FVElNRSkgYmVmb3JlIGdvaW5nIHRo
cm91Z2ggYSBzZWNvbmQgaGFyZA0KPiByZXNldCB3aGljaCB0aGVuIHN1Y2NlZWRzLg0KPiANCj4g
QW4gRkxSIG9uIGFuIGFjdGl2ZSBQRiBpcyBlbm91Z2ggdG8gcmVwcm9kdWNlIGl0Og0KPiANCj4g
ICAjIGVjaG8gMSA+IC9zeXMvYnVzL3BjaS9kZXZpY2VzLzAwMDA6MDE6MDAuMC9yZXNldA0KPiAN
Cj4gICBbICAyOTkuNjg1MDMwXSBpZHBmIDAwMDA6MDE6MDAuMDogSFcgcmVzZXQgZGV0ZWN0ZWQN
Cj4gICBbICAyOTkuNzE1NzEwXSBpZHBmIDAwMDA6MDE6MDAuMDogRGV2aWNlIEhXIFJlc2V0IGlu
aXRpYXRlZA0KPiAgIFsgIDM2Mi45MTYwODddIGlkcGYgMDAwMDowMTowMC4wOiBEZXZpY2UgSFcg
UmVzZXQgaW5pdGlhdGVkDQo+ICAgWyAgMzY0LjMxODI0Nl0gZXRoMDogKHNsYXZlIGV0aDEpOiBs
aW5rIHN0YXR1cyBkZWZpbml0ZWx5IHVwLCAuLi4NCj4gDQo+IE5vdGhpbmcgaXMgbG9nZ2VkIGR1
cmluZyB0aGUgNjMgc2Vjb25kczsgdGhlIHRpbWVvdXQgaXMgc2lsZW50IG9uIHRoaXMNCj4gcGF0
aC4NCj4gDQo+IE1ha2UgaWRwZl9jaGVja19yZXNldF9jb21wbGV0ZSgpIHdhaXQgZm9yIHRoZSBz
dGF0ZSB0byBiZSBleGFjdGx5IDAxYi4NCj4gVGhpcyBpcyB0aGUgc3RyaWN0ZXIgcmVhZGluZyBv
ZiB0aGUgcmVnaXN0ZXIgZGVmaW5pdGlvbiBhbmQgaXQgZG9lcyBub3QNCj4gZGVwZW5kIG9uIGhv
dyB0aGUgZmllbGQgZ290IHRvIGl0cyBjdXJyZW50IHZhbHVlOiBmdW5jdGlvbnMgdGhhdCBhcmUN
Cj4gc3RpbGwgaW4gcHJvZ3Jlc3MgKDAwYikgb3IgYWN0aXZlICgxMGIpIGtlZXAgcG9sbGluZyB1
bnRpbCB0aGUgY29udHJvbA0KPiBwbGFuZSByZXBvcnRzIGNvbXBsZXRpb24uDQo+IA0KPiBXaXRo
IHRoZSBjaGFuZ2UgdGhlIHNhbWUgRkxSIHJlc3VsdHMgaW4gYSBzaW5nbGUgcmVzZXQgYW5kIHRo
ZSBsaW5rIGlzDQo+IGJhY2sgYWZ0ZXIgMS41IHNlY29uZHM6DQo+IA0KPiAgIFsgIDIwNi44NTY2
MzVdIGlkcGYgMDAwMDowMTowMC4wOiBIVyByZXNldCBkZXRlY3RlZA0KPiAgIFsgIDIwNi44ODcx
MDZdIGlkcGYgMDAwMDowMTowMC4wOiBEZXZpY2UgSFcgUmVzZXQgaW5pdGlhdGVkDQo+ICAgWyAg
MjA4LjM2ODcyMV0gZXRoMDogKHNsYXZlIGV0aDEpOiBsaW5rIHN0YXR1cyBkZWZpbml0ZWx5IHVw
LCAuLi4NCj4gDQo+IFsxXQ0KPiBodHRwczovL2dpdGh1Yi5jb20vb2FzaXMtdGNzL2lkcGYtDQo+
IHNwZWNpZmljYXRpb24vYmxvYi9tYWluL2lkcGZfc3BlY2lmaWNhdGlvbi5tZA0KPiANCj4gRml4
ZXM6IDgwNzdjNzI3NTYxYSAoImlkcGY6IGFkZCBjb250cm9scSBpbml0IGFuZCByZXNldCBjaGVj
a3MiKQ0KPiBSZXZpZXdlZC1ieTogRW1pbCBUYW50aWxvdiA8ZW1pbC5zLnRhbnRpbG92QGludGVs
LmNvbT4NCj4gUmV2aWV3ZWQtYnk6IFBhdWwgTWVuemVsIDxwbWVuemVsQG1vbGdlbi5tcGcuZGU+
DQo+IFJldmlld2VkLWJ5OiBMaSBMaSA8Ym9vbGxpQGdvb2dsZS5jb20+DQo+IFNpZ25lZC1vZmYt
Ynk6IEJyaWFuIFZhenF1ZXogPGJyaWFudnZAZ29vZ2xlLmNvbT4NCj4gLS0tDQo+IHYyOiByZWZl
cmVuY2UgdGhlIElEUEYgc3BlYywgbmFtZSB0aGUgZGV2aWNlIGFuZCBhZGQgYW4gRkxSIHJlcHJv
ZHVjZXINCj4gICAgIHdpdGggYmVmb3JlL2FmdGVyIChQYXVsKTsgY29sbGVjdCBSZXZpZXdlZC1i
eSB0YWdzLiBObyBjb2RlIGNoYW5nZS4NCj4gDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRl
bC9pZHBmL2lkcGYuaCAgICAgfCAyICsrDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9p
ZHBmL2lkcGZfbGliLmMgfCAzICsrLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5l
dC9pbnRlbC9pZHBmL2lkcGYuaA0KPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lkcGYv
aWRwZi5oDQo+IGluZGV4IDQ3MGJjMjNjODQ0Yy4uY2U4YTFiZDBlYzhiIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZHBmL2lkcGYuaA0KPiArKysgYi9kcml2ZXJz
L25ldC9ldGhlcm5ldC9pbnRlbC9pZHBmL2lkcGYuaA0KPiBAQCAtMTY2LDYgKzE2Niw4IEBAIHN0
cnVjdCBpZHBmX25ldGRldl9wcml2IHsNCj4gIAlzcGlubG9ja190IHN0YXRzX2xvY2s7DQo+ICB9
Ow0KPiANCj4gKyNkZWZpbmUgSURQRl9SU1RBVF9DT01QTEVURQkJMHgwMQ0KPiArDQo+ICAvKioN
Cj4gICAqIHN0cnVjdCBpZHBmX3Jlc2V0X3JlZyAtIFJlc2V0IHJlZ2lzdGVyIG9mZnNldHMvbWFz
a3MNCj4gICAqIEByc3RhdDogUmVzZXQgc3RhdHVzIHJlZ2lzdGVyDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZHBmL2lkcGZfbGliLmMNCj4gYi9kcml2ZXJzL25l
dC9ldGhlcm5ldC9pbnRlbC9pZHBmL2lkcGZfbGliLmMNCj4gaW5kZXggODI3Yzc5NWFmY2I2Li45
MmViM2U5ZGU3N2MgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lk
cGYvaWRwZl9saWIuYw0KPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZHBmL2lk
cGZfbGliLmMNCj4gQEAgLTE4NzQsNyArMTg3NCw4IEBAIHN0YXRpYyBpbnQgaWRwZl9jaGVja19y
ZXNldF9jb21wbGV0ZShzdHJ1Y3QNCj4gaWRwZl9hZGFwdGVyICphZGFwdGVyLA0KPiAgCQkgKiBy
ZWdpc3RlciBmb3IgdXMgeWV0IGFuZCAweEZGRkZGRkZGIGlzIG5vdCBhIHZhbGlkIHZhbHVlDQo+
IGZvcg0KPiAgCQkgKiB0aGUgcmVnaXN0ZXIsIHNvIHRyZWF0IHRoYXQgYXMgaW52YWxpZC4NCj4g
IAkJICovDQo+IC0JCWlmIChyZWdfdmFsICE9IDB4RkZGRkZGRkYgJiYgKHJlZ192YWwgJiByZXNl
dF9yZWctDQo+ID5yc3RhdF9tKSkNCj4gKwkJaWYgKHJlZ192YWwgIT0gMHhGRkZGRkZGRiAmJg0K
PiArCQkgICAgKHJlZ192YWwgJiByZXNldF9yZWctPnJzdGF0X20pID09IElEUEZfUlNUQVRfQ09N
UExFVEUpDQo+ICAJCQlyZXR1cm4gMDsNCj4gDQo+ICAJCXVzbGVlcF9yYW5nZSg1MDAwLCAxMDAw
MCk7DQo+IC0tDQo+IDIuNTYuMC4zODUuZ2QzYWNiOTBlZjgtZ29vZw0KDQpSZXZpZXdlZC1ieTog
QWxla3NhbmRyIExva3Rpb25vdiA8YWxla3NhbmRyLmxva3Rpb25vdkBpbnRlbC5jb20+DQo=
