Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0C79CA5FFD
	for <intel-wired-lan@archiver.kernel.org>; Mon,  5 Oct 2026 10:24:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9056980963;
	Mon,  5 Oct 2026 10:24:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dHtfou0DL1n8; Mon,  5 Oct 2026 10:24:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org CF08780BF1
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791195895;
	b=DtMBSme0gaDkxpgbm07nsQfDEIBPGnf2oPuKDEbZBMItzaZQDK9S7cHwSL1oTUJ2DuIQ
	 FemU3Y6YgqxkIvSbzpBc+EhSSr2xsnCMHpUG8aDG2ys4M16H0HVS6TvzSgzAJBjRR9GYT
	 AJtNbs1TShzoFCRezl9nnUKz5ceIcoJEnw9mSFSSKElo7LiXuCYL0YArh5/jLiSlhMmYD
	 4LLuf4hGLUEOTmmP6SVnejQ9eCI9v4zxNZ+6eYZMYPXM8D8yiYWVNIgcHdG08/TE9aoW7
	 voW2dLHBo70Hiqjs2ebNtInkfep2XSTE0zHPhGdf7Y670XQljt43TYf7qEvYvvk+9BA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791195895;
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
	bh=n/9ue3ev6Xt9UV2I1OYcuVdZNZTvsowNc9sZSrbiT1Y=;
	b=p+1lX2wXt/K3c+IHtGHY5D7ZlKHnz0GcQrSO4LiJlH/v66WQ0jkJjP+y6JHQNi0kIMjB
	 h3E5X2FCzQFmz6RghJaO5hvBTMCFgCzg1enWgSW7CKf+HHb9dvNYdz/w3h/5Alf6lYvrP
	 IL16DvXOiHq1JdUfhlcq5rqs8koBlOXNNl/f7WaKK5Il2xVIm+yFkHZQoeUrLMnb9LUZX
	 GSGPGJvuKApnuPNngdH+NE3qyN53SzUPWwntBoX8I3kWbVxgFEpJhN+gU1R2JElraEgxg
	 tKhJHpALvtyBIQTO7Z0a1t0s+XvaAhc1p6Cx9JP4wX1lJHdXM+pNdIEy2wbWvmeBpcQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791195895;
	bh=n/9ue3ev6Xt9UV2I1OYcuVdZNZTvsowNc9sZSrbiT1Y=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fI3h7qOVIEtyPfq9XO6NMZ7BDUE+zcoClisBuUxZ1Sy8ZIuyXF9jL4pTTT9R1qW5b
	 iABWo4yCqt4WvDngGdsOo6H+dq66TENIyBSIGAiuw4+ueoOKAGyMWx6tul08d4tzaN
	 WU/XnzwSMFUWsdRZU2j8VGmeR/A6YgzRVWxFvPR5IISnyOfMwu3Q+qcjtxGX2lhVIE
	 UiKR7GKB3G379H/qgF+09LkbAeFD8SjwpLSMWcOqFEMiSFaxOCRZS27FpmbpD3wgLi
	 tPbMi/XDT56H33rR7WXddHUqLbtuCoCrG/uOBO8tBS4bgG/IySyCei4TvDFv7mS/UU
	 G3553SXlK5lRQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CF08780BF1;
	Mon,  5 Oct 2026 10:24:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9E3D3282
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 10:22:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9BB66400AA
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 10:22:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NLg6L-Iznz3h for <intel-wired-lan@lists.osuosl.org>;
 Mon,  5 Oct 2026 10:22:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 6C5C94007E
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.14
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791195778;
 b=A1PXm5Gi+FvTR85oLk5d5jNQPzRfNhb3fn9kc0TCw7p5GoiBjGwotonNdM8YmCx1W7Lb
 D2C/P4dsjZlROPznzxUO4mX5P/BhpRBfTaKs5WINo3g+tx//SQJ6Wy1JAf/czhRMihIq3
 Jo48+XN2fxE+USl2c/x847d4dTkb9hP+T7Xk2rWhCJReT8C8S6M7+TuNF4FXj5q0TRZ2s
 sby0A9QTNL11jM8vgMxTcf0wJy7M8dHidbbhf/xRhNH38NE9qLbiRHJ51u8tA0mkFThWR
 Q1LQ1He5lk7bHyk7lXpyHPXzz5n6cUlK3UKYKgXfD3wL1QMJWTLT01b/8dgR55lQj5A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791195778;
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
 bh=n/9ue3ev6Xt9UV2I1OYcuVdZNZTvsowNc9sZSrbiT1Y=;
 b=F46R6MgL4YNdA3qZSuuxDDLe/cZsG2TK1TUbXhlNDPhQbO4EKhciGOo1rdYGrnbJztTx
 t58kNQfwQ/xSu+A/hYFs8MG5g76baIk9YpCwiajgbZstGTdsHJrW1sr78GRLs6CaCN5We
 6fEK5alsBgE6tGn1NUSPVW5SwY+z31mhb4GILlGsySfDWSicSSjrXo7Z6KJBjrs8KKgrC
 tS/2L+OxHzDOOTz+mp72DVoNrf72qVFhyIBELkMUFKTsHBROXTrkYjAJvggTj42Ca98M1
 VFGRbSZqKSDmBsVZ5VIfIX5CQxsRwG6Z+yifnokZ1h3Drt1RUspc0iGiOqaF+Q69msg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b="AMBeCU/p"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.14
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=AMBeCU/p
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6C5C94007E
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 10:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791195779; x=1822731779;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=+nlrhPr4Qqn8lbtfOSdw88zmt/e77vWfungr6SYzLhU=;
 b=AMBeCU/pMJ0URkduvfhs1NQkMa4oByDfc7chCpn/d7dOaGqX0GIX/LAu
 aTMmYXKd32PsTeBLSsuT9iFvUsqdgJZD32H1hiEnmOY/bf3HrmVdad8ye
 UM8SgemLJHa22FlaEwqewH+w8qUE1YeTvcWhZHxhdGKM77pGb9Hrm4eap
 B2kJH6oj7hSF6cxHe3XYpZFxgtAr60rQeqXF1AzI++WL4DWO72Lv7SW14
 o2iOcISpy80Amyl1pJlkEZ9unEdFYvbDBbMGzjS0WCZ896/+LnkvKAAYj
 mSpWliyXhmZzFTwL/Zb1vxKFIjSUEwnIi8k7Zx4K0Ej0U0ei0/+95cx5x Q==;
X-CSE-ConnectionGUID: Pj07JfHtRg2eIbJhjoCTPA==
X-CSE-MsgGUID: 5nTxqHb4QPaVkT0LNXzfOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11925"; a="94736753"
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; d="scan'208";a="94736753"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 03:22:58 -0700
X-CSE-ConnectionGUID: w5bGTcDrSi6ED2gjuUbOFA==
X-CSE-MsgGUID: 86Le7YF3Q/yEwiFwvLG2Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; d="scan'208";a="274586332"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 03:22:58 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 03:22:56 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 03:22:56 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.7) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 03:22:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vVfwFiTZc0McN+a0/5zOR0EThElMETezFJi9bATvl07oJPGQ9+Lv9oA7iNVCcWSumD9aVXEpyPSyNueGqEiyRokFTvadD2wfUlRIfM05BlzaKN6AEtTOXcGSzTY1Ko/dbBeYenCyWDrq6kKSf3eh/KWp0SwtoXFsBsZnQy3DbI4RWtF88MQzMMzKITpTADMRtisp+Ux+liv2xpBGlPh7tUxupgnD1rJD0Vk7MVJxR0Qy9+7CX7F85Dr1axdaPK8Pt7eQmsJtLnXRCg4GP5vPihlprgRvN+vQ5TlUJDECEgzghdsIcctqRI9lhYlemkrihZ00DBIEJSG8Q/5tf18mmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n/9ue3ev6Xt9UV2I1OYcuVdZNZTvsowNc9sZSrbiT1Y=;
 b=d0DjpGE1aBupmM2vRUPsSxqW3f0c/becBvDFlYU0jR6R6SIrJgmL0USvQkt/OBmaUG+/6N1TpAhxDFqf3RGliYMedK9vcn9FAHbj7LD7OOLDV5eFuwqxgM7mZiLVWDf1LY9QmGN7nHyJKa2S1seOB1Shemi7E24Pb64VeMA0eGco9tp7+O2UOZEpQgYdfuOXF1GHjwkDSqCaOzNKv7so8yW8iyf/vX2lu1UXw4s2Um9jvkEwaj1W2QWdTmjC668bvxVdQ2OHFDhjzhiNPq1sRGRr3K/PcyMQXj0MkZifWzrKdMtAmXnykQL2cyXEkrRYuyNYTCek4HyQ2YqJNgg9sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by MN6PR11MB8220.namprd11.prod.outlook.com (2603:10b6:208:478::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Mon, 5 Oct
 2026 10:22:54 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 10:22:54 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Benoit DE RANCOURT <b2rancourt@gmail.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, "Gomes, Vinicius" <vinicius.gomes@intel.com>, "Sasha
 Neftin" <sasha.neftin@intel.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH iwl-net 2/2] igc: Flush pending Tx descriptors before
 returning NETDEV_TX_BUSY
Thread-Topic: [PATCH iwl-net 2/2] igc: Flush pending Tx descriptors before
 returning NETDEV_TX_BUSY
Thread-Index: AQHdVBUmqD5C2cfzv0WqZJ4g+PbPp7buvr2Q
Date: Mon, 5 Oct 2026 10:22:54 +0000
Message-ID: <IA3PR11MB89869C7A76B0187265292A44E5962@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20261004152840.61222-1-b2rancourt@gmail.com>
 <20261004152840.61222-3-b2rancourt@gmail.com>
In-Reply-To: <20261004152840.61222-3-b2rancourt@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|MN6PR11MB8220:EE_
x-ms-office365-filtering-correlation-id: fad40251-afb6-40d8-c282-08df22ca9e45
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|38070700021|56012099006|11063799006|10067099003|6133799003|18002099003|22082099003|4143699003;
x-microsoft-antispam-message-info: KyHBNIYt64VCurLshvJ+eGH8RHUKky3ZOQ6AUFe8JBo5m5uO/GB1bNc5jhHIEseM/6jtspruHG+WU1TghY1Mja5RlUgH+r7M7m2k1QoqZqSXTjcM7kTJdM5T458za9ELWBJrEyskib1F0oiy2tYhzh4PdJ2L8Es5FMhAIGU/txxMfMqNaCMPqzeq8ksF6tuK5MX8c2mzNpLy3Bd4Xro8Ql1BaywEIPqYxMAZBpYZhbLjiixrAxenOxpPYrijIkctwfi/CH5VUUXThNGLwn2hl2qbcSyWWBwBhKUDkJ8OoFh0ZjmGBAb9shJP9qPpMqxaWLyioV7ip54/2BeA+Utufk3ex0OceCojDAPU6XFYeM24t7XxCmMCgycZY/6uLMkUoJzngF/feJUlrfpisddbyPHwStJMR2k9zG6DGRMScsC+2+na+a5XcxYtZpTGDBJZkYrGt9u3uslKjx/AlF1goG31Muhc6QJUp8vH5KHFZ0CVLyKJYZJvo/2Ey5u+cPReUelXj8oMRP9geWnDygwkp3sWV+KRIPBQr+3a/OPhFXaif4+x3uLtFsTiKWn1O84GbgzVepbR1L9vn4h8D0SpfRnxFURQBGtVp/1m8cq+A0vHsJA9Wdf58FSkS+3NyD0ceCkOEERvJ3fT6JLv267K7Kyl8h1IxFtWBDSPCcc8YhdYW+ledSNnxOwrGG0bilnx/KwIaWN9/WUJQg9JQoBmElOMAfhFy1BdferKAkg9Ezg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(38070700021)(56012099006)(11063799006)(10067099003)(6133799003)(18002099003)(22082099003)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+j5IlKfg/DifDj1s56eOZMxb2QF7kn3wMbrX4ciV6XBXt7QBHcE2GBKnlfJ7?=
 =?us-ascii?Q?7xdn6RfDleaPivmnZ/+hUWuA7Cw5tYLjw7PSFDYEsEp7Pt7MDewK1lb3f5oM?=
 =?us-ascii?Q?Muyh/+JsE9Yt8xXNHf5N/WioH8OIasQHNDDF3vB0hw8s19iPeM0KBNCCK5KJ?=
 =?us-ascii?Q?fFc9EZ6AOtbUqWohg54fFM0SvtRJgtQkFNfvS/vUHrR7L69tMsUbcIr1Heya?=
 =?us-ascii?Q?h0hhWrsggGg0kpT56PL2935tUHGRFDN4gVMFfjrm2vs+lelJLH8uQWCb1K9d?=
 =?us-ascii?Q?CX73km4o9gyPcJceYBunT87sM/EbjOenYXvQtQUC+2G2Z0y4Bf/H5RJbzdvV?=
 =?us-ascii?Q?PqQxtnUpkDf6eSrk5uYRi7D0w7MDcuyWMtENtOteEDLAATEL2md6zL0Afh5l?=
 =?us-ascii?Q?yVQPXUuUvQaxjyiR9Am75FECIwestj0HZwEq+FUOj2iqAdvPoRrFcPAXhmUM?=
 =?us-ascii?Q?P9E4q4dnc2Na87E/zOO1NOIUZ5V+em9flm0JJomkbF73Pe7S/hMkIWlFdDjH?=
 =?us-ascii?Q?ksizRM5f0IR2xEQm26Lq691UL6eFqV9ZmEfWVsjc957jffpFLgjt3mwBA40x?=
 =?us-ascii?Q?NZl1MxSabx0ZR7RBwa2pA6l590xfa915hWMI4LtfNp9WzftrPSagLO+fUxuJ?=
 =?us-ascii?Q?MVtmFRyGQjWs3tEHMGWRgP/vmy1oof+P9fe9TRJAfEB1u3mL9L4TgeEhHuuH?=
 =?us-ascii?Q?737nwZLEEktioohSTZ4R+6ye7P6ElH+7HdpkOKMWTYxKDdQm/VZl5E57L9dI?=
 =?us-ascii?Q?YKUrTST6AOKLg2gsmXgsMXAPjdzM0iHJLd5XtThh2nCvmrjvD1fZsU15QcOZ?=
 =?us-ascii?Q?LNu5dSK3CUQCcyTP8kplq2kJkvZZdOj2jIFTxLRJI+FUkdx3JK+LRpAHqLB4?=
 =?us-ascii?Q?OBqSW5P3AuUDCOFRnVDK6XX12rpIkjl8OQ02GCHnJuYdFdHCgppouqQWo/uE?=
 =?us-ascii?Q?dtrG8e4g9JWbUxrmT/st3s2FKlDgCx7iMphRO2ZHdQlS3EDo+jgSO9RQxz+A?=
 =?us-ascii?Q?PPHHpnLaLIzBteqvpHJEnUW9ueEftF5XaRbTgkmCJKswljXCbqxzPd4+mV8M?=
 =?us-ascii?Q?UjoXFY2FGmVmBc49vyEvEJMXgfOzCPe/wZazwiInvtq3oTaM1tEcAGglLVay?=
 =?us-ascii?Q?qpsWCoya2sy9cqwJZjE8idIZn2B9+tmYTinVnaAUJLY0E6tVqt+FYPdut9J9?=
 =?us-ascii?Q?bk5vxhnln/xrOyFzLMhIcogb17CCQyETZqOxCTvVQBtPx6Yp8QG83dDsLOur?=
 =?us-ascii?Q?50aljhsYO1vCvHLU5jU2eAZ/9+aH/oRHcuXgIFv5opI5zjXhDxmIgMtoxU8R?=
 =?us-ascii?Q?oW29n50K7AKzRlqhrTbHH7VIfznONkFIlHR79Fx83mcP58wot2pj/D5iikwu?=
 =?us-ascii?Q?BxKU5bco496+M4tLhJgaeRKXg9hgpbzVmROg2P53Q62ASoCuY0TQ1lUXOZfM?=
 =?us-ascii?Q?PqIBzlUiosrxm04t6xZvxyip5K/F1QyF8iICEzrELog/K1VmXnQQuu90OsYh?=
 =?us-ascii?Q?pSnAPerixFQIlOFHcGs7X1aS7Sujj5ljcv42vgw1B2A2CB66ewxaYufLySzD?=
 =?us-ascii?Q?7GmfZ3At5LPk75QSnlatLQWlvldLyPEOrvrg6XudqwhUKOYtUlQeflhV8dYI?=
 =?us-ascii?Q?Nn9tZ7ir/FEcyjJGKfUin83a0XuKUgDiuHLYEmXafvrHMAYeetWVoCMR+b1d?=
 =?us-ascii?Q?M87JLmxXdz/vkTyN9YhCFiXn0eEAhJczRiUTnRgdiPJ9AWlwi4OI2/0oVgz0?=
 =?us-ascii?Q?P6MKZi6QL9PcCRzw+9CfY/+0OTG+2a8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ivC35FpvZrBmT2krLHc2XHIPqn3jaie/ljgjkso/pSr4x52t2NoE0Sa8iGbs3boGbdYKkDoNdCcWs78QxcvaoqmnI3VuxWU64ko9JZPA1F7CiCrUYLkOCs53Rw3fXBgoAwo7KVOl0bZn/WX4PpYaGy0DbJJ1aH2YvkTEwoUa9dyOX96Se3g48PTm1E1YJPL87dqaJ5WVYFPQL0qb+W/EeWnnOmfDJP//yuXaRJU+ZTZ4iO/5lAFXDJ3tFVQrNKof+yrGAZt5QnJ/38nZxNcXPDZRF/6eL9CnIF2dTH9P0AUdSu9vp0hkyBdoTg/DoipLYUTD2ctItuYnyxgMqbkzsg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fad40251-afb6-40d8-c282-08df22ca9e45
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 10:22:54.2863 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lTFu+qer1PS9HU1Zx1mlIzM2FO9OntZ4B5TF6/E3rgwNBce5PK5wMRW/49YupqaTHrKsrYsy6ZfJNFQHPkMZgtfgnlBdqOwXVC+Bge4CvKQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8220
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
> From: Benoit DE RANCOURT <b2rancourt@gmail.com>
> Sent: Sunday, October 4, 2026 5:29 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; intel-wired-
> lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Andrew Lunn <andrew+netdev@lunn.ch>; David
> S. Miller <davem@davemloft.net>; Eric Dumazet <edumazet@kernel.org>;
> Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>;
> Gomes, Vinicius <vinicius.gomes@intel.com>; Sasha Neftin
> <sasha.neftin@intel.com>; linux-kernel@vger.kernel.org; Benoit DE
> RANCOURT <b2rancourt@gmail.com>
> Subject: [PATCH iwl-net 2/2] igc: Flush pending Tx descriptors before
> returning NETDEV_TX_BUSY
>=20
> When the stack sends a burst with xmit_more set, igc_tx_map() defers
> the tail register write until the last skb of the burst or until the
> queue is stopped. If igc_xmit_frame_ring() then refuses an skb with
> NETDEV_TX_BUSY, it returns without flushing any pending tail write.
> Descriptors of packets already accepted in the burst can therefore
> remain unexposed to the hardware.
>=20
> The queue is stopped at that point and igc_clean_tx_irq() only wakes
> it once TX_WAKE_THRESHOLD descriptors are free. The hardware can only
> complete what the tail exposes, so if the unsignalled descriptors keep
> the free count below the threshold, the queue is never woken and the
> Tx watchdog resets the adapter.
>=20
> On an I226-V running 7.2.8, in all 25 Tx timeout episodes of the test
> described in the previous patch, the stalled queue had pending
> descriptors after a NETDEV_TX_BUSY return: the probes inferred at
> least 214 of the 256 ring descriptors beyond the last tail write. For
> that queue, the register dump showed TDH =3D TDT =3D the next_to_clean
> value recorded by the probe: the hardware had completed everything it
> had been given. For example, with queue 2 stopped, next_to_clean =3D 190
> and next_to_use =3D 167:
>=20
>   igc 0000:08:00.0 terra: NETDEV WATCHDOG: CPU: 1: transmit queue 2
> timed out 5353 ms
>   igc 0000:08:00.0 terra: TDH[0-3]        00000099 00000091 000000be
> 000000f5
>   igc 0000:08:00.0 terra: TDT[0-3]        00000099 00000091 000000be
> 000000f5
>=20
> Write the tail before returning NETDEV_TX_BUSY. The refused skb is
> left untouched; only descriptors of already accepted packets are
> exposed to the hardware. Those packets have already been accounted to
> BQL, so flushing their descriptors lets completion processing
> progress; the refused skb is neither mapped nor accounted here.
>=20
> The previous patch makes this path rare again for common skbs, but it
> remains reachable, for instance when the linear part or a fragment of
> an skb exceeds IGC_MAX_DATA_PER_TXD.
>=20
> With this change alone (without the previous patch), three runs of the
> same test on 7.2.8 still produced 10751 NETDEV_TX_BUSY returns, but no
> Tx timeout, against 25 on the unpatched kernel.
>=20
> Fixes: 0507ef8a0372 ("igc: Add transmit and receive fastpath and
> interrupt handlers")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM bpftrace
> Signed-off-by: Benoit DE RANCOURT <b2rancourt@gmail.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c
> b/drivers/net/ethernet/intel/igc/igc_main.c
> index b94a08791102..16f2ca32f5f1 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -1621,7 +1621,11 @@ static netdev_tx_t igc_xmit_frame_ring(struct
> sk_buff *skb,
>  						&skb_shinfo(skb)->frags[f]));
>=20
>  	if (igc_maybe_stop_tx(tx_ring, count + 5)) {
> -		/* this is a hard error */
> +		/* This is a hard error. Write the tail for packets
> deferred
> +		 * by xmit_more before returning busy, otherwise the
> stopped
> +		 * queue may never get enough completions to be woken.
> +		 */
> +		igc_flush_tx_descriptors(tx_ring);
>  		return NETDEV_TX_BUSY;
>  	}
>=20
> --
> 2.55.0


Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
