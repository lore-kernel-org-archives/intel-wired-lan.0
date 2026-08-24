Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0873C5DF94
	for <intel-wired-lan@archiver.kernel.org>; Mon, 24 Aug 2026 09:29:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9219E605F0;
	Mon, 24 Aug 2026 09:29:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jB-nt-oqX_mV; Mon, 24 Aug 2026 09:29:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787563768;
	bh=VvodmYJd8EWM9QHB4a5z1VhQZcIZ8U6kEDNhdrpTqvM=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=4X+pfvahXa8/B29fbOavjmhCpiky0zbrVnFUo2bNInjRe4o7o0tAVdzfitpUTuzs4
	 bUxGVKQw3Py5I2jbNYx7dlG94WQG0YPxYmbE63Ftm5ssEdGjGtLubnPk2+UZRr+GUD
	 cM5jEUdvOsR782zAh1K1/LWE64v6+YX7E579YAqiW6z+HWqH9I/6BHM9Ml265Kaoea
	 qh3PVg46zvZVt3iTbZzra+8sZ1lEjCTCxdPlTjvcGcPf56hwJDC16ON3A1tpxcG6rL
	 g4KYVXEyN0jivOQ2gB9D95XMXks8R8bfSxBMJ16+Xfr2UHXt9SNiSr3gcjfRHIn0wZ
	 eazgGK7Ytj7wQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DCA24605EB;
	Mon, 24 Aug 2026 09:29:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id BBB2E386
 for <intel-wired-lan@lists.osuosl.org>; Mon, 24 Aug 2026 09:29:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A1DB6807F5
 for <intel-wired-lan@lists.osuosl.org>; Mon, 24 Aug 2026 09:29:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rMe2TlpEhwJR for <intel-wired-lan@lists.osuosl.org>;
 Mon, 24 Aug 2026 09:29:25 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.8;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=PkkKQQTH
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ACD87807EB
 for <intel-wired-lan@lists.osuosl.org>; Mon, 24 Aug 2026 09:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787563765; x=1819099765;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=VvodmYJd8EWM9QHB4a5z1VhQZcIZ8U6kEDNhdrpTqvM=;
 b=PkkKQQTHB5KHs4tufeL67HW+9EoZTwm9BwaZWLnyw6l5kYq+spbk9wsm
 4YhTC6Ej9pAdJ59p04aXolTRST3wLiW9T+obrHLQfGcaZUY3GxpkN+7vF
 11Q7PNjCqvAIMIkgDIT+qWJsJAfj2izpIE4nHWupv7QJNBfZIRrurJ8Oy
 cCEcZ3DDB/F3dqTSDVNQAVExTkTDhNX4XgTZsZYzJsJBiTM0u8/T6b4y2
 knyS+pxnqGs8WI7rclS+TmMqi151ZjT6dWzfbLFjLr/dCophKvNdIkAko
 kr7+goULiFpMOQGFxEmwje2ISyQVd8JRmAl0zUyzaoP/dlmtgv2blD+wY w==;
X-CSE-ConnectionGUID: tBpDfoWGRr68JAx+v5v23w==
X-CSE-MsgGUID: o5h+5JeBS7ajQpcl9R6puA==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="105547128"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; d="scan'208";a="105547128"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2026 02:29:24 -0700
X-CSE-ConnectionGUID: 90TyMzz+SiqotkBNdC5Evg==
X-CSE-MsgGUID: gg9kp5/zRXGznlDF9WX5aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; d="scan'208";a="272160994"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2026 02:29:24 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 02:29:23 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 24 Aug 2026 02:29:23 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.35) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 02:29:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FzmLalxiCPuNDuBhmU2EKDs2ErIagdfAvW1JCFmYeNsnX7j88DI1q6qrwFaVCSOGdhAKr5rdsxkUyuxRNFooaWmGv9AXEFs5/y8vop7J3Z9zSDRokxGfFwDDJBZRF3pG6BpXWB6YXrReGJxeJ3dWdPnLhUlSIIX7RCLVl5cEX8z2wTp/H7er9fdL01zWxEW+7M4JkD8gUQLj5aDwDGqTRsPpMmzdVH7YmKi5FFo0ljnh+8KQGAZmQ2zAb6SzBK0eLfcK/AfYlnVTMFZeDc1MNJ9QrSyjNaXdGHzn8q0PZTcYoN/LTdqsvrzzy6U3abdZwkiE20USy+R9rcPuaivThQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VvodmYJd8EWM9QHB4a5z1VhQZcIZ8U6kEDNhdrpTqvM=;
 b=EXwYv2Vss+DU8OSlkY7rN5I3aGYEd0kLJV9IqyVtRldoBwdw0wv1/pSkq7y0hURElwWECfbZqqWqPxMMq0fKV4uha1SCAWT+twDgWCJgd+DiG/dpI81RJSWosliMXQmYIPOIIP4aORNsEN3vuQPWpI0Ul1m2IoQ1WhOXeKtR/b4JVh0ybtopC0T7tmfnEv29u/TjYzBvz1MxjXa7ApRaIf3/9IVWsZgjXyo3NeQWft6JdXEbDvPVAU72Wu704iTIs1EVYyS2VA7dkBlQVo7GLvgBE8gEwadOzdGsv/VwtsyZkiMLyb+OiNDe71/ydksOKhH4QnkLLyW3vc/FhuxanQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by LVXPR11MB9706.namprd11.prod.outlook.com (2603:10b6:408:388::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 09:29:21 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 09:29:21 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, Intel Wired LAN
 <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Machnikowski, Maciej"
 <maciej.machnikowski@intel.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Korba, Przemyslaw"
 <przemyslaw.korba@intel.com>, "Nitka, Grzegorz" <grzegorz.nitka@intel.com>,
 "Oros, Petr" <poros@redhat.com>, "Nowlin, Alexander"
 <alexander.nowlin@intel.com>, "Bross, Kevin" <kevin.bross@intel.com>,
 "Cavatur, Ranjit" <ranjit.cavatur@intel.com>, "Keller, Jacob E"
 <jacob.e.keller@intel.com>, "Machnikowski, Maciej"
 <maciej.machnikowski@intel.com>
Subject: RE: [PATCH iwl-net 06/12] ice: E825: clear PHY_REG_TX_MEMORY_STATUS
 prior to soft reset
Thread-Topic: [PATCH iwl-net 06/12] ice: E825: clear PHY_REG_TX_MEMORY_STATUS
 prior to soft reset
Thread-Index: AQHdMctcDTNwHB/auE6rqic1MOdWCLas8ckg
Date: Mon, 24 Aug 2026 09:29:21 +0000
Message-ID: <IA3PR11MB8986909708EBD370C62E3C2EE5A02@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260821-jk-e825c-minimized-fixes-v1-0-9d0731eb4858@intel.com>
 <20260821-jk-e825c-minimized-fixes-v1-6-9d0731eb4858@intel.com>
In-Reply-To: <20260821-jk-e825c-minimized-fixes-v1-6-9d0731eb4858@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|LVXPR11MB9706:EE_
x-ms-office365-filtering-correlation-id: 2a983aa3-c33c-41e9-eebb-08df01c22db6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|38070700021|6133799003|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: Bgtqqw42IiZCVhUNfANrHpA4obQhvt99AZLja4ity9Qez2Zp9fQJ6LgChlGDconXiiY1SnoksXx7EVC0t7MFiv0kuhH+6TAE/w4Y8FA70jk6Zo1HigC6XttUqTun04k2IMRzkGMUpByhGLwo9d0nJNcJNw8lOPDV6KBi5D7cRv0mLs/ASVBbK7Fnp+dVkghFLdRCdLxY++QZN5kJn+9zTmBF+47TLtp9yc9FBB+DEWdlepwfyAL8mmoVC73a2k32+6UbcpIJlg33r+g0S9jWkX75oQkguIUgqwN5sOCYJXDsLzZX5lzf7ltrqDPLZq3fmfTM3hW41hZbQwZrxomspxPK7ch3XRl9+7D3nMLWa8f+vCfTmUwNUSLd+o9GTbqrisHhH/WH8pj659Jrb9jjD91crXvq2ZTXMqqlbv4nhAZ0YQ/Pwp8GmrJiW2LwnjdTrZNUL2GxEO1o6hSX9Fjpgsmq+WryldnNJzm7qPrkdfP8LXnCefEAx2JtkfyxTLDYDmgw4JbAVNuw+I5JyrjRszP0oE6f7ws24ZDt8A/DaF7Nh0XiMlRaR8I6Z1cJuh18ROsOoSEw8Ljed+Zj742Apd+Bk9ZpQd3A1+N+E15oMjhCIQKhYfbwxMfBS8mB/VSQDnGaje8WJwNYV2wHjr4TammsxaZXOqKWHRlzc2KSos72k1XmsZLxJY/Eaa1K32Q7ct5FU7QAa2Q/wwJqd2x6Q5e9TUBxmfaUe75md4xCH7k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(6133799003)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UzkveExtUE1BaGEydy9lWU5UVGI2dEhhYzc1OEl3VndVblA2TEY4OXl4UFFy?=
 =?utf-8?B?U3BrdUY0Q25VcHdZcU1HazVQMUtMU3JlbzVJUTdIajhoYmlhb2ZDdE81R01E?=
 =?utf-8?B?NmFhdi9hRklLbjlOV0dLTGV1ZUh5S2RMbHF0OFhzTEVBOEhheU9pRGF3NHJK?=
 =?utf-8?B?Rk5CTmh4ZlhCQWllTmhoczFrSURscGlRdDRGZlBvSDJ1WjZZczJodHFoNmtj?=
 =?utf-8?B?YWY5ZlN6ZytyOUQ5a2luOWJORlAyRGdaanNHWHpKbS9PN1V0NVhhazI5S2sx?=
 =?utf-8?B?RVBCUXNnMkJlNEtsWHp3RVFybzk5R2c0OTVlUnJhaDVzazF6elhTMWdwY1J5?=
 =?utf-8?B?RVZFM3lHcVZzakI4T2JPVGFxem5DMit5anBBd3RLdEZacVZPY3FNMlFLZVZT?=
 =?utf-8?B?SGw2NmpoY3AwYXIzSjVLU0ZXbk1tK1pEbTZNN1JIZnZaMFRqU1JZNk5lWHpZ?=
 =?utf-8?B?eFJzSFZYOFFyZm5HaXFyVHFXQnNEMnhaVDl5S1Fic3I2V0lXdEZCNThPaWVj?=
 =?utf-8?B?cjdTMFk2dWVBV0d0Q2UvdTFRT3pXOWpFbHhPaEpabHZRend4cVFRbzVDYTB1?=
 =?utf-8?B?cklDWDZvUDh1SmQrYllSNk9BaXdCUEMwcGhmMWFvUDNwdDg1bEh2cnFCMWRh?=
 =?utf-8?B?MnVVM0NXK3hvek1zOENHNWI5aGdwaGRPd3NhQXBsZXNKckR5OTM0L2hlYTJM?=
 =?utf-8?B?MStXZU1pZUMrTXdwTGtITVNpc0xTN3A1cVpabHMrU0xoT2o3aW8zRzNKc24z?=
 =?utf-8?B?TFBVYjg5dnJxWjM0U0h6M29ZU05EVkRlTzdTR3VZaE9rcUdmT2JmaXhqSlhV?=
 =?utf-8?B?cnZERE9pdW9ibm1nR1hNTVBBSEE4c1EzNGRpajBYRXU1SjJvWEREdk0wSlZT?=
 =?utf-8?B?bXlIKzIvVGJNM0ZNZGRMQXF2U1hMQnlvY3dhODkvdzcvZXZyamJ6VE91NVRF?=
 =?utf-8?B?Y080dmdCbmJMWk81U2ZZVmpqK0EzMUQ4bkNlcUgwS0FiLzRrUGRGTEtmRzlp?=
 =?utf-8?B?WFN6SDVraml1ZE95Ym56VmJoWWVDM3lGam40WXZGUktWNVJySjlrL2xaYm05?=
 =?utf-8?B?Ly9TcFB0WXlyZWVTN0RmaStkTXk2WTlMR0hzWWhWSjN2K1F3NzdxV3J3Q3gy?=
 =?utf-8?B?NmhZRCtkR0NIV1Q5a0hLNlB1dUtNUkQrZktYTUN1bWhnV3Nqd2dFNkhmc2JS?=
 =?utf-8?B?ZGVoVTRqSE1tVmRQand5WTR4QVkzVzlvVXlXdTkzdm5yN2k5WHFqN0RoczBE?=
 =?utf-8?B?MFlwc2ZNWkhVNDVWckhsTlloSmFGZjB1dDBRMmkvazhVQ3JkbzllTSthdy9F?=
 =?utf-8?B?UFdCZitLdzNkaS9yR2FZU2NHWTVUSFpTSlJEbDd3VzgvNjllUVZrYUNFMEo0?=
 =?utf-8?B?ZVd5dEh0OUp0ZGlwQXMvai9ZTi9VZ21PTUh3ckRueWthOTZtL2lmejNidVVK?=
 =?utf-8?B?a3R0UEw1MWdKU2VEWEc1aW9yQ01IYVpZdldFN0FBcVIwUldKWVA5bXZmRXZP?=
 =?utf-8?B?RGU2TXFTMUlONzRsZ2o3cUtyV1VxV09MQjlKY05Ycmlsaml6cTJrbFo2bDh0?=
 =?utf-8?B?elQzeitKQ0NQZXNEbHhiWW9DS3hMTlFZcnFDUTVhUVlRM1RPTjJwVWVEOHYy?=
 =?utf-8?B?bEZqbllWMWxwc0tSTVIweHp5elk4MmVzZjNtRGtRSXFXYVQ2QXVNS0toSVVq?=
 =?utf-8?B?elI1bWN6dXlpUTVmR0FHVU1IRVlZVnZwUHJtM2Y0bzdkekNVSVNtWEdzRXZq?=
 =?utf-8?B?MzIvM0VVaHhLSHZqN0FMSUdUNmJ4a1lDZVJlZkFMRkdmYWtzVkdVOFplcDFX?=
 =?utf-8?B?N3RjQXdyZElMTVUvTHk2cTVPaFVmNVRCNzk1bkNZejMyQzdrSnY3MDNjYmlS?=
 =?utf-8?B?WWJIQUQzWm9OV0ZPbktuRm9UejdpUnc3YXE2ZFk5ai9qZ0JBOXllVlNObjMx?=
 =?utf-8?B?Z1BBenJKcFZXNGtPZTFsRHNIZGFwQ3VoTmJobWxxSmduVVJSb3RiZGQ5L0or?=
 =?utf-8?B?RE13bVBGMmphM2labmprTGlRQXQyLzc2QThSd1FZNXRNM3poSldrNUJhdnRU?=
 =?utf-8?B?eC9nK29BdnFXK0QvNitRU2V4TTM4U1NhYXZhSVdzY2MrbmdUQTV0NDE2TUd3?=
 =?utf-8?B?YzFlMDRJUEI4aHg3WHNWZVZSMytoRDd1blpzTTZTOG91UDhjeHBQQ1lUS1hY?=
 =?utf-8?B?K3ZSSDJrSFJ1OFoySlpsdlNXdWxyZTloUkRrMmJLK2xNN1ozdVpyWFpXdEEv?=
 =?utf-8?B?SVRqMVVZdXpzVjE1cVR4TFVURU5JUnBXa0l5YXQ0bXZuYm12S2ZqalI1RG94?=
 =?utf-8?B?WVNITzlQY1B0UDNqUUVmSHdiVFVvZlhXMGNvbDEzQmcwMHpIY0JhOWtYM3ln?=
 =?utf-8?Q?soljY7tjPFIXKg2s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: GJphlnOrsbkjdbhmTtBEk/xSO7SXM/1R4g7DRC5PKSKasUwzmMF+lV5lA5uGxLK2kXTSN5TZqWJ7F+EEYE8+IQuSInfoGXGqjlZh3BB3SABBwKG392fnebB2yaMzQHqy3ZkZhLPuMIa8M/NI9yct6e4dffbJVJnBTgPO5Qr26a1TMtHVYBiQMf6QyqXC+gUwFf5l4h15imVaorFArUbR34UNKa2cYfPYahVXSf3h2xPUuGjsWNg5qr/m2Cqtt570/zJSCKHoW8HyDLph6zMMeJTkL7Rt4McUEzgsaq70G9KKxuJpwrKrWMh2WeaNS2ZjjzS8XhDMTi0/QnSHORsh3A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a983aa3-c33c-41e9-eebb-08df01c22db6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2026 09:29:21.1937 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Lc+Wy4OjXcBcHqcUKQ2LkYCcqxrwuRrMCvE9ymaRKaQBt012JFqQuuP6SvIXNwxMZrDdZMUp2R3Dzua70nfBpoovvqAR2/n+HmZNmt1DSs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVXPR11MB9706
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFjb2IgS2VsbGVyIDxq
YWNvYi5lLmtlbGxlckBpbnRlbC5jb20+DQo+IFNlbnQ6IFNhdHVyZGF5LCBBdWd1c3QgMjIsIDIw
MjYgMjoxMyBBTQ0KPiBUbzogSW50ZWwgV2lyZWQgTEFOIDxpbnRlbC13aXJlZC1sYW5AbGlzdHMu
b3N1b3NsLm9yZz4NCj4gQ2M6IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IE1hY2huaWtvd3NraSwg
TWFjaWVqDQo+IDxtYWNpZWoubWFjaG5pa293c2tpQGludGVsLmNvbT47IE5ndXllbiwgQW50aG9u
eSBMDQo+IDxhbnRob255Lmwubmd1eWVuQGludGVsLmNvbT47IEtvcmJhLCBQcnplbXlzbGF3DQo+
IDxwcnplbXlzbGF3LmtvcmJhQGludGVsLmNvbT47IE5pdGthLCBHcnplZ29yeg0KPiA8Z3J6ZWdv
cnoubml0a2FAaW50ZWwuY29tPjsgT3JvcywgUGV0ciA8cG9yb3NAcmVkaGF0LmNvbT47IE5vd2xp
biwNCj4gQWxleGFuZGVyIDxhbGV4YW5kZXIubm93bGluQGludGVsLmNvbT47IEJyb3NzLCBLZXZp
bg0KPiA8a2V2aW4uYnJvc3NAaW50ZWwuY29tPjsgQ2F2YXR1ciwgUmFuaml0IDxyYW5qaXQuY2F2
YXR1ckBpbnRlbC5jb20+Ow0KPiBLZWxsZXIsIEphY29iIEUgPGphY29iLmUua2VsbGVyQGludGVs
LmNvbT47IE1hY2huaWtvd3NraSwgTWFjaWVqDQo+IDxtYWNpZWoubWFjaG5pa293c2tpQGludGVs
LmNvbT4NCj4gU3ViamVjdDogW1BBVENIIGl3bC1uZXQgMDYvMTJdIGljZTogRTgyNTogY2xlYXIN
Cj4gUEhZX1JFR19UWF9NRU1PUllfU1RBVFVTIHByaW9yIHRvIHNvZnQgcmVzZXQNCj4gDQo+IFRo
ZSBkcml2ZXJzIGN1cnJlbnQgaW1wbGVtZW50YXRpb24gb2YgaWNlX3B0cF9yZXNldF90c19tZW1v
cnlfZXRoNTZnKCkNClByb2JhYmx5ICdUaGUgZHJpdmVycyBjdXJyZW50IGltcGxlbWVudGF0aW9u
JyAtPiAnVGhlIGRyaXZlcidzIGN1cnJlbnQgaW1wbGVtZW50YXRpb24nID8NCg0KDQo+IGlzIGZs
YXdlZC4gSXQgdHJpZXMgdG8gY2xlYXIgdGhlIHRpbWVzdGFtcCBtZW1vcnkgYnkgd3JpdGluZyB0
byB0aGUNCj4gUEhZX1JFR19UWF9NRU1PUllfU1RBVFVTIHJlZ2lvbi4gVGhpcyBkb2VzIG5vdCB3
b3JrIHByb3Blcmx5LCBhcyBpdA0KPiBkb2VzIG5vdCB0cmlnZ2VyIGFwcHJvcHJpYXRlIFBIWSBh
Y3Rpb25zLg0KPiANCj4gVG8gY2xlYXIgb3V0c3RhbmRpbmcgdGltZXN0YW1wIG1lbW9yeSwgdGhl
IGRyaXZlciBtdXN0IHJlYWQgdGhlDQo+IHRpbWVzdGFtcHMuDQo+IEhvd2V2ZXIsIG5haXZlbHkg
ZG9pbmcgdGhpcyBhcyBwYXJ0IG9mIGljZV9wdHBfcmVzZXRfdHNfbWVtb3J5KCkgaXMNCj4gcHJv
YmxlbWF0aWMuIFdoZW4gcmVhZGluZyB0aGUgdGltZXN0YW1wIGluZGV4LCBoYXJkd2FyZSBraWNr
cyBvZmYgYQ0KPiBjaGFpbiBvZiBhY3Rpb25zIGluY2x1ZGluZyBjbGVhcmluZyB0aGUgcmVhZHkg
Yml0bWFwIGluZGV4LCBhbmQNCj4gZGVjcmVtZW50aW5nIGFuIGludGVybmFsIGNvdW50ZXIgaWYg
dGhlIHRpbWVzdGFtcCBpbmRleCB3YXMgbWFya2VkIGFzDQo+IHZhbGlkLg0KPiANCj4gVGhpcyBj
YW4gcG90ZW50aWFsbHkgbGVhdmUgdGhlIGludGVybmFsIGhhcmR3YXJlIGNvdW50ZXIgb3V0IG9m
IHN5bmMNCj4gd2l0aCB0aGUgYWN0dWFsIG51bWJlciBvZiB0aW1lc3RhbXBzLiBUaGlzIG9jY3Vy
cyBiZWNhdXNlIHRoZQ0KPiBQSFlfUkVHX1RYX01FTU9SWV9TVEFUVVMgcmVnaW9uIGlzIG5vdCB6
ZXJvLWluaXRpYWxpemVkIHdoZW4gdGhlDQo+IGRldmljZSBib290cyB1cC4gSW5zdGVhZCwgaXQg
aXMgZmlsbGVkIHdpdGggZ2FyYmFnZS4gT24gYSBjb2xkIHBvd2VyDQo+IG9uLCBhdHRlbXB0cyB0
byByZWFkIHRoZSBzdGFsZSBkYXRhIHJlc3VsdCBpbiB0aGUgaGFyZHdhcmUgdHJpZ2dlcmluZw0K
PiBhIGNvdW50ZXIgZGVjcmVtZW50IGZvciBhIHRpbWVzdGFtcCB0aGF0IG5ldmVyIGhhcHBlbmVk
LiBUaGlzDQo+IHVuZGVyZmxvd3MgdGhlIGNvdW50ZXIsIGFuZCBwcmV2ZW50cyBuZXcgdGltZXN0
YW1wIGludGVycnVwdHMgZnJvbQ0KPiBiZWluZyB0cmlnZ2VyZWQgZm9yIHJlYWwgdGltZXN0YW1w
IHJlcXVlc3RzLg0KPiANCj4gV2UgbXVzdCByZWFkIHRoZSBQSFlfUkVHX1RYX01FTU9SWV9TVEFU
VVMgaW4gb3JkZXIgdG8gY2xlYXIgc3RhbGUNCj4gdGltZXN0YW1wcy4gQnV0IGRvaW5nIHNvIG1h
eSBjYXVzZSBhIGRlc3luYyB3aXRoIHRoZSBjb3VudGVyLiBUbw0KPiBwcmV2ZW50IGlzc3Vlcywg
cGVyZm9ybSB0aGlzIGNsZWFyaW5nIGFsd2F5cyBhbmQgb25seSByaWdodCBiZWZvcmUNCj4gaW5p
dGlhdGluZyBhIFBIWSBzb2Z0IHJlc2V0Lg0KPiANCj4gVGhlIHNvZnQgcmVzZXQgd2lsbCBjbGVh
ciBhbmQgcmVzZXQgdGhlIGludGVybmFsIGNvdW50ZXIgYW5kIHRoZSByZWFkeQ0KPiBiaXRtYXAu
IFRoZSByZWFkcyB0byBQSFlfUkVHX1RYX01FTU9SWV9TVEFUVVMgd2lsbCByZXNldCB0aGUgcmVn
aW9uDQo+IHZhbGlkIGJpdHMgZW5zdXJpbmcgdGhhdCBubyBzdGFsZSBkYXRhIGlzIGxlZnQgYmVo
aW5kLiBUaGlzDQo+IGNvbWJpbmF0aW9uIGVuc3VyZXMgdGhhdCB3ZSBhbHdheXMgaGF2ZSBhIGNs
ZWFuIHNsYXRlIHdpdGggbm8gc3RhbGUNCj4gZGF0YSBhbmQgd2l0aCB0aGUgY291bnRlciBwcm9w
ZXJseSByZXNldCB0byB6ZXJvLg0KPiANCj4gRml4ZXM6IDNlYzQ2ZTE1N2M3ZiAoImljZTogcGVy
Zm9ybSBQSFkgc29mdCByZXNldCBmb3IgRTgyNUMgcG9ydHMgYXQNCj4gaW5pdGlhbGl6YXRpb24i
KQ0KPiBTaWduZWQtb2ZmLWJ5OiBKYWNvYiBLZWxsZXIgPGphY29iLmUua2VsbGVyQGludGVsLmNv
bT4NCj4gUmV2aWV3ZWQtYnk6IE1hY2llayBNYWNobmlrb3dza2kgPG1hY2llai5tYWNobmlrb3dz
a2lAaW50ZWwuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9p
Y2VfcHRwX2h3LmMgfCA4OSArKysrKysrKysrKysrKystLS0tLQ0KPiAtLS0tLS0tLS0NCj4gIDEg
ZmlsZSBjaGFuZ2VkLCA0NyBpbnNlcnRpb25zKCspLCA0MiBkZWxldGlvbnMoLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX3B0cF9ody5jDQo+
IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9wdHBfaHcuYw0KPiBpbmRleCBk
NDhlYjNjNjE4MjMuLmI3ZDIxN2FjMzFmMyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvZXRo
ZXJuZXQvaW50ZWwvaWNlL2ljZV9wdHBfaHcuYw0KPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5l
dC9pbnRlbC9pY2UvaWNlX3B0cF9ody5jDQo+IEBAIC03MzcsMjQgKzczNyw2IEBAIHN0YXRpYyBp
bnQgaWNlX3JlYWRfcG9ydF9tZW1fZXRoNTZnKHN0cnVjdCBpY2VfaHcNCj4gKmh3LCB1OCBwb3J0
LCB1MTYgb2Zmc2V0LA0KPiAgCXJldHVybiBpY2VfcmVhZF9wb3J0X2V0aDU2ZyhodywgcG9ydCwg
b2Zmc2V0LCB2YWwsDQo+IEVUSDU2R19QSFlfTUVNX1BUUCk7ICB9DQo+IA0KPiAtLyoqDQo+IC0g
KiBpY2Vfd3JpdGVfcG9ydF9tZW1fZXRoNTZnIC0gV3JpdGUgYSBQSFkgcG9ydCBtZW1vcnkgbG9j
YXRpb24NCj4gLSAqIEBodzogcG9pbnRlciB0byB0aGUgSFcgc3RydWN0DQo+IC0gKiBAcG9ydDog
UG9ydCBudW1iZXIgdG8gYmUgcmVhZA0KPiAtICogQG9mZnNldDogT2Zmc2V0IGZyb20gUEhZIHBv
cnQgcmVnaXN0ZXIgYmFzZQ0KPiAtICogQHZhbDogUG9pbnRlciB0byB0aGUgdmFsdWUgdG8gcmVh
ZCAob3V0IHBhcmFtKQ0KPiAtICoNCj4gLSAqIFJldHVybjoNCj4gLSAqICogJTAgICAgICAtIHN1
Y2Nlc3MNCj4gLSAqICogJUVJTlZBTCAtIGludmFsaWQgcG9ydCBudW1iZXIgb3IgcmVzb3VyY2Ug
dHlwZQ0KPiAtICogKiAlb3RoZXIgIC0gZmFpbGVkIHRvIHdyaXRlIHRvIFBIWQ0KPiAtICovDQo+
IC1zdGF0aWMgaW50IGljZV93cml0ZV9wb3J0X21lbV9ldGg1Nmcoc3RydWN0IGljZV9odyAqaHcs
IHU4IHBvcnQsIHUxNg0KPiBvZmZzZXQsDQo+IC0JCQkJICAgICB1MzIgdmFsKQ0KPiAtew0KPiAt
CXJldHVybiBpY2Vfd3JpdGVfcG9ydF9ldGg1NmcoaHcsIHBvcnQsIG9mZnNldCwgdmFsLA0KPiBF
VEg1NkdfUEhZX01FTV9QVFApOw0KPiAtfQ0KPiAtDQo+ICAvKioNCj4gICAqIGljZV93cml0ZV9x
dWFkX3B0cF9yZWdfZXRoNTZnIC0gV3JpdGUgYSBQSFkgcXVhZCByZWdpc3Rlcg0KPiAgICogQGh3
OiBwb2ludGVyIHRvIHRoZSBIVyBzdHJ1Y3QNCj4gQEAgLTExMzksOCArMTEyMSw4IEBAIHN0YXRp
YyBpbnQgaWNlX3JlYWRfcHRwX3RzdGFtcF9ldGg1Nmcoc3RydWN0DQo+IGljZV9odyAqaHcsIHU4
IHBvcnQsIHU4IGlkeCwNCj4gICAqIGludGVybmFsIFBIWXMgb2YgdGhlIDU2RyBkZXZpY2VzLg0K
PiAgICoNCj4gICAqIFRvIGRpcmVjdGx5IGNsZWFyIHRoZSBjb250ZW50cyBvZiB0aGUgdGltZXN0
YW1wIGJsb2NrIGVudGlyZWx5LA0KPiBkaXNjYXJkaW5nDQo+IC0gKiBhbGwgdGltZXN0YW1wIGRh
dGEgYXQgb25jZSwgc29mdHdhcmUgc2hvdWxkIGluc3RlYWQgdXNlDQo+IC0gKiBpY2VfcHRwX3Jl
c2V0X3RzX21lbW9yeV9xdWFkX2V0aDU2ZygpLg0KPiArICogYWxsIHRpbWVzdGFtcCBkYXRhIGF0
IG9uY2UsIHNvZnR3YXJlIHNob3VsZCBpbnN0ZWFkIHBlcmZvcm0gYSBQSFkNCj4gKyBzb2Z0DQo+
ICsgKiByZXNldCB2aWEgaWNlX3B0cF9waHlfc29mdF9yZXNldF9ldGg1NmcoKS4NCj4gICAqDQo+
ICAgKiBUaGlzIGZ1bmN0aW9uIHNob3VsZCBvbmx5IGJlIGNhbGxlZCBvbiBhbiBpZHggd2hvc2Ug
Yml0IGlzIHNldA0KPiBhY2NvcmRpbmcgdG8NCj4gICAqIGljZV9nZXRfcGh5X3R4X3RzdGFtcF9y
ZWFkeSgpLg0KPiBAQCAtMTE1MiwxMSArMTEzNCwxMSBAQCBzdGF0aWMgaW50IGljZV9yZWFkX3B0
cF90c3RhbXBfZXRoNTZnKHN0cnVjdA0KPiBpY2VfaHcgKmh3LCB1OCBwb3J0LCB1OCBpZHgsICBz
dGF0aWMgaW50DQo+IGljZV9jbGVhcl9wdHBfdHN0YW1wX2V0aDU2ZyhzdHJ1Y3QgaWNlX2h3ICpo
dywgdTggcG9ydCwgdTggaWR4KSAgew0KPiAgCXU2NCB1bnVzZWRfdHN0YW1wOw0KPiAtCXUxNiBs
b19hZGRyOw0KPiAgCWludCBlcnI7DQo+IA0KPiAtCS8qIFJlYWQgdGhlIHRpbWVzdGFtcCByZWdp
c3RlciB0byBlbnN1cmUgdGhlIHRpbWVzdGFtcCBzdGF0dXMNCj4gYml0IGlzDQo+IC0JICogY2xl
YXJlZC4NCj4gKwkvKiBQZXIgdGhlIFBIWSBzcGVjLCByZWFkaW5nIHRoZSB0aW1lc3RhbXAgbWVt
b3J5IGxvY2F0aW9uIGlzDQo+IHdoYXQNCj4gKwkgKiBjbGVhcnMgdGhlIGVudHJ5J3MgdmFsaWQg
Yml0IGFuZCBpdHMgY29ycmVzcG9uZGluZyAocmVhZC0NCj4gb25seSkNCj4gKwkgKiB0c19tZW1v
cnlfc3RhdHVzIGJpdC4NCj4gIAkgKi8NCj4gIAllcnIgPSBpY2VfcmVhZF9wdHBfdHN0YW1wX2V0
aDU2ZyhodywgcG9ydCwgaWR4LA0KPiAmdW51c2VkX3RzdGFtcCk7DQo+ICAJaWYgKGVycikgew0K
PiBAQCAtMTE2NCwzMiArMTE0Niw0MCBAQCBzdGF0aWMgaW50IGljZV9jbGVhcl9wdHBfdHN0YW1w
X2V0aDU2ZyhzdHJ1Y3QNCj4gaWNlX2h3ICpodywgdTggcG9ydCwgdTggaWR4KQ0KPiAgCQkJICBw
b3J0LCBpZHgsIGVycik7DQo+ICAJfQ0KPiANCj4gLQlsb19hZGRyID0gKHUxNilQSFlfVFNUQU1Q
X0woaWR4KTsNCj4gLQ0KPiAtCWVyciA9IGljZV93cml0ZV9wb3J0X21lbV9ldGg1NmcoaHcsIHBv
cnQsIGxvX2FkZHIsIDApOw0KPiAtCWlmIChlcnIpIHsNCj4gLQkJaWNlX2RlYnVnKGh3LCBJQ0Vf
REJHX1BUUCwgIkZhaWxlZCB0byBjbGVhciBsb3cgUFRQDQo+IHRpbWVzdGFtcCByZWdpc3RlciBm
b3IgcG9ydCAldSwgaWR4ICV1LCBlcnIgJWRcbiIsDQo+IC0JCQkgIHBvcnQsIGlkeCwgZXJyKTsN
Cj4gLQkJcmV0dXJuIGVycjsNCj4gLQl9DQo+IC0NCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gDQo+
ICAvKioNCj4gLSAqIGljZV9wdHBfcmVzZXRfdHNfbWVtb3J5X2V0aDU2ZyAtIENsZWFyIGFsbCB0
aW1lc3RhbXBzIGZyb20gdGhlDQo+IHBvcnQgYmxvY2sNCj4gKyAqIGljZV9wdHBfY2xlYXJfdHhf
bWVtb3J5X3N0YXR1c19ldGg1NmcgLSBSZXNldCBvbmUgcG9ydCdzIFR4DQo+ICsgdGltZXN0YW1w
IG1lbW9yeQ0KPiAgICogQGh3OiBwb2ludGVyIHRvIHRoZSBIVyBzdHJ1Y3QNCj4gKyAqIEBwb3J0
OiBwb3J0IG51bWJlciB0byBjbGVhcg0KPiArICoNCj4gKyAqIEZ1bGx5IHJlc2V0IGEgc2luZ2xl
IFBIWSBwb3J0J3MgVHggdGltZXN0YW1wIG1lbW9yeS4gUGVyIHRoZSBQSFkNCj4gKyBzcGVjLCB0
aGUNCj4gKyAqIG9ubHkgd2F5IHRvIGNsZWFyIGEgdGltZXN0YW1wIHZhbGlkIGJpdCAoYW5kIGl0
cyByZWFkLW9ubHkNCj4gKyB0c19tZW1vcnlfc3RhdHVzDQo+ICsgKiBiaXQpIGlzIHRvIHJlYWQg
dGhlIHRpbWVzdGFtcCBtZW1vcnkgbG9jYXRpb24sIHNvIHJlYWQgZXZlcnkgZW50cnkNCj4gKyBm
b3IgdGhlDQo+ICsgKiBwb3J0ICh0d28gMzItYml0IHJlYWRzIGVhY2gpLiBUaGlzIGRpc2NhcmRz
IGFsbCB0aW1lc3RhbXAgZGF0YSBvbg0KPiArIHRoZSBwb3J0LA0KPiArICogc28gaXQgbXVzdCBv
bmx5IGJlIHVzZWQgZm9yIGEgZnVsbCByZXNldDsgY2FsbGVycyB0aGF0IG11c3QNCj4gcHJlc2Vy
dmUNCj4gKyAqIGluLWZsaWdodCB0aW1lc3RhbXBzIGNsZWFyIGluZGl2aWR1YWwgaW5kaWNlcyB2
aWENCj4gaWNlX2NsZWFyX3BoeV90c3RhbXAoKS4NCj4gKyAqDQo+ICsgKiBEdWUgdG8gaW50ZXJh
Y3Rpb25zIHdpdGggYW4gaW50ZXJuYWwgSFcgY291bnRlciBmb3IgdGhlIG51bWJlciBvZg0KPiAr
ICogb3V0c3RhbmRpbmcgVHggdGltZXN0YW1wcywgdGhpcyAqbXVzdCogb25seSBiZSBjYWxsZWQg
YXMgcGFydCBvZg0KPiB0aGUNCj4gKyAqIGljZV9wdHBfcGh5X3NvZnRfcmVzZXRfZXRoNTZnKCkg
cHJvY2VkdXJlLiBPdGhlcndpc2UsIHRoZSBpbnRlcm5hbA0KPiArIGNvdW50ZXINCj4gKyAqIG1h
eSBiZWNvbWUgb3V0IG9mIHN5bmMgYW5kIHByZXZlbnQgbmV3IHRpbWVzdGFtcCBpbnRlcnJ1cHRz
Lg0KPiArICoNCj4gKyAqIFJldHVybjogMCBvbiBzdWNjZXNzLCBuZWdhdGl2ZSBlcnJvciBjb2Rl
IG9uIGZhaWx1cmUgdG8gcmVhZCB0aGUNCj4gUEhZLg0KPiAgICovDQo+IC1zdGF0aWMgdm9pZCBp
Y2VfcHRwX3Jlc2V0X3RzX21lbW9yeV9ldGg1Nmcoc3RydWN0IGljZV9odyAqaHcpDQo+ICtzdGF0
aWMgaW50IGljZV9wdHBfY2xlYXJfdHhfbWVtb3J5X3N0YXR1c19ldGg1Nmcoc3RydWN0IGljZV9o
dyAqaHcsDQo+IHU4DQo+ICtwb3J0KQ0KPiAgew0KPiAtCXVuc2lnbmVkIGludCBwb3J0Ow0KPiAr
CWludCBlcnIgPSAwOw0KPiArCXU4IGlkeDsNCj4gDQo+IC0JZm9yIChwb3J0ID0gMDsgcG9ydCA8
IGh3LT5wdHAubnVtX2xwb3J0czsgcG9ydCsrKSB7DQo+IC0JCWljZV93cml0ZV9wdHBfcmVnX2V0
aDU2ZyhodywgcG9ydCwNCj4gUEhZX1JFR19UWF9NRU1PUllfU1RBVFVTX0wsDQo+IC0JCQkJCSAw
KTsNCj4gLQkJaWNlX3dyaXRlX3B0cF9yZWdfZXRoNTZnKGh3LCBwb3J0LA0KPiBQSFlfUkVHX1RY
X01FTU9SWV9TVEFUVVNfVSwNCj4gLQkJCQkJIDApOw0KPiArCWZvciAoaWR4ID0gMDsgaWR4IDwg
SU5ERVhfUEVSX1BPUlQ7IGlkeCsrKSB7DQo+ICsJCWVyciA9IGljZV9jbGVhcl9wdHBfdHN0YW1w
X2V0aDU2ZyhodywgcG9ydCwgaWR4KTsNCj4gKwkJaWYgKGVycikNCj4gKwkJCXJldHVybiBlcnI7
DQo+ICAJfQ0KPiArDQo+ICsJcmV0dXJuIDA7DQo+ICB9DQo+IA0KPiAgLyoqDQo+IEBAIC0yMjkw
LDYgKzIyODAsNyBAQCBpbnQNCj4gaWNlX3B0cF9yZWFkX3R4X2h3dHN0YW1wX3N0YXR1c19ldGg1
Nmcoc3RydWN0IGljZV9odyAqaHcsIHUzMg0KPiAqdHNfc3RhdHVzKQ0KPiAgICoNCj4gICAqIFRy
aWdnZXIgYSBzb2Z0IHJlc2V0IG9mIHRoZSBFVEg1NkcgUEhZIGJ5IHRvZ2dsaW5nIHRoZSBzb2Z0
IHJlc2V0DQo+ICAgKiBiaXQgaW4gdGhlIFBIWSBnbG9iYWwgcmVnaXN0ZXIuIFRoZSByZXNldCBz
ZXF1ZW5jZSBjb25zaXN0cyBvZjoNCj4gKyAqICAgMC4gUmVhZGluZyBldmVyeSB0aW1lc3RhbXAg
bWVtb3J5IHJlZ2lzdGVyIHRvIGNsZWFyIGl0cyB2YWxpZA0KPiBiaXQNCj4gICAqICAgMS4gQ2xl
YXJpbmcgdGhlIHNvZnQgcmVzZXQgYml0DQo+ICAgKiAgIDIuIEFzc2VydGluZyB0aGUgc29mdCBy
ZXNldCBiaXQNCj4gICAqICAgMy4gQ2xlYXJpbmcgdGhlIHNvZnQgcmVzZXQgYml0IGFnYWluDQo+
IEBAIC0yMjk4LDYgKzIyODksMTIgQEAgaW50DQo+IGljZV9wdHBfcmVhZF90eF9od3RzdGFtcF9z
dGF0dXNfZXRoNTZnKHN0cnVjdCBpY2VfaHcgKmh3LCB1MzINCj4gKnRzX3N0YXR1cykNCj4gICAq
IHRvIHNldHRsZS4gVGhpcyBwcm92aWRlcyBhIGNvbnRyb2xsZWQgd2F5IHRvIHJlaW5pdGlhbGl6
ZSB0aGUgUEhZDQo+ICAgKiB3aXRob3V0IHJlcXVpcmluZyBhIGZ1bGwgZGV2aWNlIHJlc2V0Lg0K
PiAgICoNCj4gKyAqIFRvIGVuc3VyZSB0aGF0IHRoZSBpbnRlcm5hbCBjb3VudGVyIG1hdGNoZXMg
dGhlIGNvbnRlbnRzIG9mIHRoZQ0KPiArICogUEhZX1JFR19UWF9NRU1PUllfU1RBVFVTLCByZWFk
IGV2ZXJ5IHRpbWVzdGFtcCBpbmRleCBwcmlvciB0bw0KPiArIHBlcmZvcm1pbmcNCj4gKyAqIHRo
ZSBzb2Z0IHJlc2V0LiBUaGUgUEhZX1JFR19UWF9NRU1PUllfU1RBVFVTIHJlYWRzIGVuc3VyZSB0
aGF0IHRoZQ0KPiArIHJlZ2lvbg0KPiArICogaXMgY2xlYXJlZCwgd2hpbGUgdGhlIHNvZnQgcmVz
ZXQgcHJvY2VkdXJlIGVuc3VyZXMgdGhhdCB0aGUNCj4gKyB0aW1lc3RhbXANCnRpbWVzdGFtcCAg
LT4gdGltZXN0YW1wDQoNCg0KPiArICogY291bnRlciBpcyByZXNldCB0byB6ZXJvLg0KPiArICoN
Cj4gICAqIFJldHVybjogMCBvbiBzdWNjZXNzLCBvciBhIG5lZ2F0aXZlIGVycm9yIGNvZGUgb24g
ZmFpbHVyZSB3aGVuDQo+ICAgKiAgICAgICAgIHJlYWRpbmcgb3Igd3JpdGluZyB0aGUgUEhZIHJl
Z2lzdGVyLg0KPiAgICovDQo+IEBAIC0yMzA2LDYgKzIzMDMsMTMgQEAgaW50IGljZV9wdHBfcGh5
X3NvZnRfcmVzZXRfZXRoNTZnKHN0cnVjdCBpY2VfaHcNCj4gKmh3LCB1OCBwb3J0KQ0KPiAgCXUz
MiBnbG9iYWxfdmFsOw0KPiAgCWludCBlcnI7DQo+IA0KPiArCWVyciA9IGljZV9wdHBfY2xlYXJf
dHhfbWVtb3J5X3N0YXR1c19ldGg1NmcoaHcsIHBvcnQpOw0KPiArCWlmIChlcnIpIHsNCj4gKwkJ
aWNlX2RlYnVnKGh3LCBJQ0VfREJHX1BUUCwgIkZhaWxlZCB0byBjbGVhcg0KPiBQSFlfUkVHX1RY
X01FTU9SWV9TVEFUVVMgZm9yIHBvcnQgJWQsIGVyciAlZFxuIiwNCj4gKwkJCSAgcG9ydCwgZXJy
KTsNCj4gKwkJcmV0dXJuIGVycjsNCj4gKwl9DQo+ICsNCj4gIAllcnIgPSBpY2VfcmVhZF9wdHBf
cmVnX2V0aDU2ZyhodywgcG9ydCwgUEhZX1JFR19HTE9CQUwsDQo+ICZnbG9iYWxfdmFsKTsNCj4g
IAlpZiAoZXJyKSB7DQo+ICAJCWljZV9kZWJ1ZyhodywgSUNFX0RCR19QVFAsICJGYWlsZWQgdG8g
cmVhZA0KPiBQSFlfUkVHX0dMT0JBTCBmb3IgcG9ydCAlZCwgZXJyICVkXG4iLCBAQCAtNTc5Nyw4
ICs1ODAxLDkgQEAgdm9pZA0KPiBpY2VfcHRwX3Jlc2V0X3RzX21lbW9yeShzdHJ1Y3QgaWNlX2h3
ICpodykNCj4gIAkJaWNlX3B0cF9yZXNldF90c19tZW1vcnlfZTgyeChodyk7DQo+ICAJCWJyZWFr
Ow0KPiAgCWNhc2UgSUNFX01BQ19HRU5FUklDXzNLX0U4MjU6DQo+IC0JCWljZV9wdHBfcmVzZXRf
dHNfbWVtb3J5X2V0aDU2Zyhodyk7DQo+IC0JCWJyZWFrOw0KPiArCQkvKiBFODI1IGhhcmR3YXJl
IG11c3Qgb25seSByZXNldCB0aW1lc3RhbXAgbWVtb3J5IGFzDQo+IHBhcnQgb2YNCj4gKwkJICog
dGhlIHNvZnQgcmVzZXQgcHJvY2VkdXJlLg0KPiArCQkgKi8NCj4gIAljYXNlIElDRV9NQUNfRTgx
MDoNCj4gIAlkZWZhdWx0Og0KPiAgCQlyZXR1cm47DQo+IA0KPiAtLQ0KPiAyLjU1LjAuODE0Lmdj
NDJmNDU0MzFkMGYNCg0KDQpSZXZpZXdlZC1ieTogQWxla3NhbmRyIExva3Rpb25vdiA8YWxla3Nh
bmRyLmxva3Rpb25vdkBpbnRlbC5jb20+DQoNCg==
