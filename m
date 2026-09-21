Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C9F4C982E6
	for <intel-wired-lan@archiver.kernel.org>; Mon, 21 Sep 2026 15:36:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0827280D23;
	Mon, 21 Sep 2026 15:36:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XvWVXM4dEXoI; Mon, 21 Sep 2026 15:36:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 48E7E80BE7
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790004988;
	b=nbIx91cDxMLYnWk2xjM3b4M5QbGhHaGTQ29ccAeglPLdhV3YayIxSLXiR4Zaa9fJ78Vb
	 Zf+3UUNv1LcWnO+enby6teCrRH4hKetd5vOscbpjwUJW5e9Qc+WMne6765pyCHBMzW6Ph
	 vhWckNdddMVv1GdknWi7/i9X3Bc4YHuTufCdcf2eOxN5Bet24p0YPMBDlou5sI1NXuAhl
	 xSIJ/Zehw16qZYXzrWkXZlu5Ezygv3XXpI9OBujKNaBuMjEm6734VbQ4/0jEXon8vX2Is
	 oXi4FMrIiz7m9TEXHy5SaNTVIAc9fOlKXUsMmRUxqM04i9QAJN1SvkjWsriSU6+glZA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790004988;
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
	bh=HHh0SGe/3N4Psd2lMmEkulFMRk5Ua6qgLoNOXViwucc=;
	b=CYaG1OhM8Bobxh86jAhZBD9uWFWXHdTsnzPdYgdtIz0jjgB5taRIdKh41yfZh8T9Zrvl
	 uWYnmgOzIfGOBHkN/tiSVuKayrSQ76bWx7OT/McpMF+jCPKSjO0Wa69nBb86qNuGfcTJt
	 FuYaL0c5DQBeVS/Hia+qCiWE+XaFdBTBUj4MBfwRiZnkVnzQiQYpi+NIG4TAHRGzHbSqs
	 gX4iu95zAnW2M3tdmX34j7GKnzlVtAKtIJed7WuGeiOlqHo4NUlGnwdglg6fZrirIgstc
	 FFbI5jB+D7L1RGQsESLlbCnU7adtXmVtjRcjxDEUYFNDpxWDGGGlrQzj3s4RQMbaoOQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790004988;
	bh=HHh0SGe/3N4Psd2lMmEkulFMRk5Ua6qgLoNOXViwucc=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=3Agol1GYuGGNgAtMTfd0cyEpP7OqikmMTTLO+29B6rCA8/13hm9dujf5RlnAhfJw9
	 /do+li1pQXYZdFwm+1iaYzYu2rsCF4Fvy+oEtEp2VYvFQH0IK2bQZFN/9LT49yRTmb
	 sSIsdquu213me3oUkEuotg1JrjPOOBVPuZeqY4+p9WA7DjN3WCBWkN6MNxFqf97a8B
	 P+gmExEXjdUIFEH3JyJTR6ZuaSD9xK8QdcDeVC4WNbFWSeWa0bWrdxrmGGqQC5Yp3d
	 qvEfu56uL4ousSFYvaBKPnUbbKOd8uyKHRH6TJ7wL8Isnm9u34YrPAut6rHE2w6cCQ
	 dCtaIMnauNJRQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 48E7E80BE7;
	Mon, 21 Sep 2026 15:36:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7134912C
 for <intel-wired-lan@lists.osuosl.org>; Mon, 21 Sep 2026 15:36:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 622944078C
 for <intel-wired-lan@lists.osuosl.org>; Mon, 21 Sep 2026 15:36:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XvLzlLyr52gW for <intel-wired-lan@lists.osuosl.org>;
 Mon, 21 Sep 2026 15:36:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7D94240782
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.9
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790004985;
 b=lbKVr+uFkMZohex6e5IzIxRMnMvqWWy/enJsv6RcLbWAw5ho49Ot9439U1Fw4lYs1U7h
 eW5+E8TGShDLdTnMUxpm1lPXhwhuMODlVnvbuD6UXboc95YyER58hI5GWGTkggl/NblnK
 WeDhy0tvJBJE4v5Xo0kqv+VFFDL6z/OGnpdWOUf2AsaftDLO8EsZCASnQ525MNvPyvG10
 cPzA/huPQf/Q+FK/YWZmQTIgf5uGbY04fdHPtjvYjGSLYY5JCMqIwgZ6Jof9EXia0giU5
 Vj83lTxXr341RVt1xI3nlj1F8BAE73qJO3vz+brzJr+RFq0BZGXkhRljDgkjrh0RLrw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790004985;
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
 bh=HHh0SGe/3N4Psd2lMmEkulFMRk5Ua6qgLoNOXViwucc=;
 b=asEm0TOkyAIg1Ag1EEEypNwfgzUxZSmlH7HG/ZOT4IyvQkTYx3YHRj231FBzC5ShGhwa
 jsPXdYoFNX5z/oElVCGya6keD118PBw3gL0goFhXQTiSYlwtrcLhYMEFwfqYvYZWy8Qaa
 L5IGoKs0OUokoAtR0q49bLFagndhFxIoNy6cdLzl+dU044ojtZdvhJKkVaF1PyODL5hfn
 w8zL/3ysBjnejv2na+mj/I1PBqt7FqU0skETstuXAqHcTP0W7MpXCg7Be/HeQy4DsKWLD
 5VhudYdeAHu26zEQAqe38BfpbomsmMDEVyrHokxIVR5hOLrRVtzfvXQS7/3gkawdA4w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b="ANz/l/kc"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.9
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.9;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ANz/l/kc
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7D94240782
 for <intel-wired-lan@lists.osuosl.org>; Mon, 21 Sep 2026 15:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790004986; x=1821540986;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=kxmByU7O09AnkQ9wM6OXjJrHJmpPHTptFIToJkxBjys=;
 b=ANz/l/kc+K3PjLTyRNrynLxvjU7e8lLc4lRQPVELnjgQ5YCjc0V2Fsob
 zNxdGmaCCWu7eZeNn3V/Ckfxvj4WMKog3QUXT1nbyqN+WcjE/G4gYBPqr
 RsqXuKZ7EJsMpcdWQBYrK2lMhLnfpe44stBqv78FLEIn8JgWdHLubQTVf
 GgndgZpZQvdDqRYMh87zUTeJ4BXQufLLYRX9/j+DGR86FA9G5bGk6Pl9H
 JI4/BO1sZUxZtoZa+W5LNA5hDsjLsmLtKzy4iHcuhbS3VZ+u/s+V9LU7w
 gstRcnmqlVECjS3kFdu85dokLb/MjkFeBirN9AFkjmHdh1pLsC0KYSKYi Q==;
X-CSE-ConnectionGUID: Xa4lO42RTZmJJqAKrJhxpA==
X-CSE-MsgGUID: DzHbu32HQOu1wGmfJsyf7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="101191540"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; d="scan'208";a="101191540"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2026 08:29:35 -0700
X-CSE-ConnectionGUID: xtavTfPhQUOJ35AV8RofdQ==
X-CSE-MsgGUID: yN5mnIopTuOOSWLN4khTUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; d="scan'208";a="280755733"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2026 08:29:35 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 08:29:34 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 21 Sep 2026 08:29:34 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.45) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 08:29:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QlqdOQwrxJHs69rEMw9acjM5oZ/tNRrqf583T6HjkLUEzKNlbWMCUJC9Z3Zo/4fuaayoTJfZtG5/0jqcv2kI45vydGr4lzHswHkequ0YydevnOsptEVhdGwDUxZqyPBGY2TLjdnfjA71WFPPJqoUPLgtoc6WHjTwnQ90xjToc7ZxTK5qEa64EUAqjzyS160xnfLVph0zMykvx82H0A3qqOfMe0mcO25kEjPK2aFtIX1IK0OgnrKbalnOj+1k0baJYhHHd5mqO1zkbPyv/G5rXQ5k4hlfaVTEPXbbmTFWA4YHcFYhC6gYxWRFT3aADiadgEpFQGYQbO8djyQEHqoUwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HHh0SGe/3N4Psd2lMmEkulFMRk5Ua6qgLoNOXViwucc=;
 b=Be/kcbWzS06sZ+QQgYmRt+8PUYP0l7jRLGApZnaoKNZ3Wvmn2SxLavKv1vmkwC/oYB7Duj74DjjFY3imhrYaQJPvB52RRDl/GY4jcByAWGPEB88bzGKgQ8FtYSNfJYbrBh50HCZKC7FRmqbS42ob3jkSnXyzGm4xXdtA1lxhw2TFAourc6OGd4DkaGs4Mbh5XBSyIWxt6KKKFWTXzcueubNUeXTpU6zXxwsXT/FwIJCFkIM4kqzZikW58ugGfxv5N4W5/Y2d/J62R+m5O/qpsMhMn3rv+9i976dx/zo/4IGsTGbQSS8nYNdsT18DqWAMpnKpcHPDLzo3Yx7zK2ktAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 15:29:31 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 15:29:31 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Wentao Liang <vulab@iscas.ac.cn>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "kuba@kernel.org" <kuba@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "Kitszel,
 Przemyslaw" <przemyslaw.kitszel@intel.com>, "sln@onemain.com"
 <sln@onemain.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] ixgbevf: fix xfrm_state reference leak in
 ixgbevf_ipsec_rx()
Thread-Topic: [PATCH] ixgbevf: fix xfrm_state reference leak in
 ixgbevf_ipsec_rx()
Thread-Index: AQHdRpXD4qrdcwzOE0i2W9ECFRugGbbZLsFA
Date: Mon, 21 Sep 2026 15:29:31 +0000
Message-ID: <IA3PR11MB8986651065381146E88621E4E5842@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260917111418.2148632-1-vulab@iscas.ac.cn>
In-Reply-To: <20260917111418.2148632-1-vulab@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DM4PR11MB6117:EE_
x-ms-office365-filtering-correlation-id: 8407c366-32b4-4427-c493-08df17f521f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|7416014|38070700021|56012099006|11063799006|18002099003|22082099003|10067099003;
x-microsoft-antispam-message-info: 3ujW2BDcQJR0WH06j37TBOhjiSP7IYBpKuQl5RgJsShWhQfX0aRLIgdIQxMuHBYMltuMFNTf0zrMDWe8q6PNVXtaZUgjfxTv7OIE6yjA6eEk66uyk1LYJmcJd9AxCFT29hMctHQ55CvZr1mXig9CLHWAGD142qy9FWiiYsZE4klUEpc2ZK6WSJStA7IlIgLFyzK0GsckXowCl+vSRRwzHvxHz7xSp70BQFvyonY+Gwo0F7GLNcjVh3FSnTsn6HrTOzkrUVvbDO/j1o7+CQYfgRGyDyTm1aA+QSuLqchQw0SS+zaFjnuOb0eX+9/8Pzh1QZmj129bELmDFYdGjTtiiL2muivLB/Pl0rW2sC/L0iXcxY/J7qFZK7BrWTrFLMGe/QYHGIDF/tUYkbi1MaQz5wQyi2XJd3wcibSp/C4i1srcmTZQCPKUn8JZEvViFkddzevMZXrCMp6AcOXvUbVCOjb9jtKKVqS21E4A0HYKETdqY3E6hoF40e2FBrjo9cZ58sKzFBqjw0DqGn0nsuT3r6c9c6nwemqfKELsqs+BmY2Pmfh8GhtlMgqtI3m/HsICj7F0vk5ja4iIa2hsvYYLA3ZMajrgk2IAg0zov9+WOaFdN1xLimffSybTDI9AI/aKRxmSxAUu3yNGkuOkVT887dOkuTN+32zjk5YC7jHRXTfdaDVj5O0QB0ScA66I9sM6zDtp5KbziBGL9Lrh+EhWjMCEQZWdT1qsPVFpIoFFRDQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(38070700021)(56012099006)(11063799006)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?35qx9NSrG4dH0aa5yanJrvobHrGm70GmixOe9rQs8ltvBXup4lj1xLeNePYN?=
 =?us-ascii?Q?xTp1aPaJAhr/myKHqTqgAY2zkhlEdfdnOvHUIFGQWDOQ+O4ayaPXUmP0eUcs?=
 =?us-ascii?Q?TxU+VzdOtOmqFStYpZlnbiRuSKjNN+FEaBXjV4fvchbxLdCnyvLVTOFZe71+?=
 =?us-ascii?Q?QsiPfsbyrdc/hIDSKHpR7udqeqksPi1HQrXKpJpueRYEBEMxcJeOpTz1p8Jk?=
 =?us-ascii?Q?m7oNwv1oBJJKsYNZSPsONF47Zm6uCeKGKjsVnrtjP990FbUHweCQKmOcKDn3?=
 =?us-ascii?Q?+4aco7s/yQ17coRPp4wl7L1s0fW6TDBxaPPLxAW78+RjfFYp9d+Da2Y7O0kR?=
 =?us-ascii?Q?bztMPzTBynjUjz59x21OorSu0DXU+ujPMBy22U6gqN0Q/cTqJ7IisLbSCQ9A?=
 =?us-ascii?Q?j3kXOKoMTUdtP2KfngTLp4C/SGsnP4GuhGv/PGSMbxST1NvSxhgaaR6GucXP?=
 =?us-ascii?Q?yQlspH9O6X5Q76dSY5lXAfB6LasuyenehuplB0Ysd+B3Ju58a7fb/b1iSgRu?=
 =?us-ascii?Q?ofVhdfkZ4uNAyCUqkWyDAhrSctApIOuvmFy9iVgt/K0vZaVp1cLSb2+X0abR?=
 =?us-ascii?Q?8Sh4Ea7h3k1uLSqe6FTPkHnhvoCAO0OjtI1dLBOO+pe4NW2dwq8tn1B1hM1D?=
 =?us-ascii?Q?QxMBV2O84qi1SJumUXiDsKCfybSUAM03e1MDZe/OMvr8JdG/KwcgDewT2L8Y?=
 =?us-ascii?Q?mSx4CfoOhpAli2K+Vzqi1+n6xP7V79Veevg0nvfGmd5duIOIm+H0ETSP3jEe?=
 =?us-ascii?Q?kd5S63M5R7HWFQZAcFsaSpjlQ+BHpnV8VVsUTzSeeCwn5vbZLIMQtFGcNvLv?=
 =?us-ascii?Q?jpE1je5hgkDMKo2BejpkSQk3iz93Eecdw6Ozk3BZFiGwGABnjkcxyBw+46pj?=
 =?us-ascii?Q?urfmmse1seqJloDVB7lb/cV2WGL1x/gghRrWYUVWmx1gGd43cKugSgTL+QDI?=
 =?us-ascii?Q?hsxS2iD3hJwi4X/5U/CFJarDZoE4g+MPJ0vV/42otp2gA+UUhVhbMuxhkGBg?=
 =?us-ascii?Q?oGzV888b890NPDhWKOAc2dxQBmCFVOImxGfnQ8bucCS0kYi3iBhyq3lsG0X+?=
 =?us-ascii?Q?R/zdZD5wfGiHK+Ex3WtG2TQfGEN24WcVFQmylVQlBBRPmt514LIbSF+S6+J9?=
 =?us-ascii?Q?OaspXpxwtVOQrBmL2tuKBrGRtNy7I2iIywteT6jAljtkEcQ+W5N/fSkQx9xx?=
 =?us-ascii?Q?XJc02Ny339i2Cp00SUbYgXV0Vkvl3F8GWHMRwsCAXv352QVG85ZkEdV9CHaV?=
 =?us-ascii?Q?xoUV9eEhO9SxYHC/6cOrVPjbAfCF1200FGlyJAL9h07olGilo9yJpchvQwZU?=
 =?us-ascii?Q?ngBvvkCT0Y3b+kowUGno9XF0A5uJfF4Mb8N8z1ApnEpK4e0uGNxAoEFWyWq3?=
 =?us-ascii?Q?51cRo4ErTAJtFvaYGd3W/K6vMTGF0SggeSA+Zo4lAD2tW63rMOPrYeVJhB9j?=
 =?us-ascii?Q?5Ta0oPneDUT1reCHz6j7VGIADZkaXa0NajZ7fF3YUtEjU/VjVze6d58xQ6vO?=
 =?us-ascii?Q?/XShryZQKLcsUZbxSL1Ye+/9QnJ074XbsIDPhc+O4O9mdweajcUTWqXXe591?=
 =?us-ascii?Q?9HnUbN83otVOOkoz+TDbnx3ASZg9vheZdPhWrVAg6lyD0B7FmeztKwiIEQou?=
 =?us-ascii?Q?Zc/GKXVu4bOxvXvIViib/wQIp4h2b5RVkrXTM+veFyOAjk6mztFGyzksPJNO?=
 =?us-ascii?Q?4fL5MShI9oEv1+tAMbGD/J4+g5TcmrqmcnhCM/anFCgy3FVGkY2Rtu3RnyHS?=
 =?us-ascii?Q?lbYSRyMDAC2W7blORP2JVb29Xx6Y5dw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ryoEu5KMa0vU7H3pFzOW/4zKUiDmmUw7FP9weuLIIwdpX0vtyWX2hRCodZkcT4kiWgQfXikgnTsNIt1Ny37P8ghQyrn7gWDQMIh+vgebjpgDQ1T9SysXb0a0kn6e4TAdjpGxs7sgmvV/2N7/0iK7FMWn+lqv00y2/svrm9WEzvtOBnBgh526VwmpC8V+E+igo40AcLH4rjZKXzvcckfU6xI5ojfDlxEkilrJ/NyedIl9sQApzwiQAIPiuSyPgfYq2Sxt7XiCaFv4tB/y/FhS18P9veFr7DoVxa0uRDyKFTBXgxvXLhWtQ4FQ5bvhGM3Rp81c3yT6KdDsWhD+ZxSJCQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8407c366-32b4-4427-c493-08df17f521f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 15:29:31.3704 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G/1V6ERSJGbw3nhD/O6ruLT93RyHiEcsyueZJNjxjBuG14HMl7dY2ybs9EBHNjBcAmBcsNwRUnNBFPhitPB5pD+pOxHx+9EonthMWeXVrkM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6117
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
> From: Wentao Liang <vulab@iscas.ac.cn>
> Sent: Thursday, September 17, 2026 1:14 PM
> To: andrew+netdev@lunn.ch
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>;
> davem@davemloft.net; edumazet@google.com; intel-wired-
> lan@lists.osuosl.org; kuba@kernel.org; linux-kernel@vger.kernel.org;
> netdev@vger.kernel.org; pabeni@redhat.com; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; sln@onemain.com; Wentao Liang
> <vulab@iscas.ac.cn>; stable@vger.kernel.org
> Subject: [PATCH] ixgbevf: fix xfrm_state reference leak in
> ixgbevf_ipsec_rx()
>=20
> ixgbevf_ipsec_find_rx_state() returns the state with an extra
> reference, which is handed over to the secpath on the success path.
> When
> secpath_set() fails, the state has not been stored anywhere yet and
> the reference is dropped on the floor.
>=20
> Release it before returning.
>=20
> Fixes: 0062e7cc955e0 ("ixgbevf: add VF IPsec offload code")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ipsec.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ixgbevf/ipsec.c
> b/drivers/net/ethernet/intel/ixgbevf/ipsec.c
> index 076fd0a24858..bf3fcab3bd57 100644
> --- a/drivers/net/ethernet/intel/ixgbevf/ipsec.c
> +++ b/drivers/net/ethernet/intel/ixgbevf/ipsec.c
> @@ -596,8 +596,10 @@ void ixgbevf_ipsec_rx(struct ixgbevf_ring
> *rx_ring,
>  		return;
>=20
>  	sp =3D secpath_set(skb);
> -	if (unlikely(!sp))
> +	if (unlikely(!sp)) {
> +		xfrm_state_put(xs);
>  		return;
> +	}
>=20
>  	sp->xvec[sp->len++] =3D xs;
>  	sp->olen++;
> --
> 2.34.1

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
