Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E349C88E73
	for <intel-wired-lan@archiver.kernel.org>; Mon, 14 Sep 2026 14:26:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F0EBF80E3B;
	Mon, 14 Sep 2026 14:26:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tEroNyK4R34J; Mon, 14 Sep 2026 14:26:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4137380DC5
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789396014;
	b=R9Zw23zxvIzlbeDbRNxyIy33zUbtbO7IMIN4oN+HoS7xKV1Fw4ft/aqO0Qv2Mc4Ju/o7
	 BZTu8rkRbbwB+D88UrCNgR7vddKygNCGJn+V18fUjmnFKm7k97cWJhM6zLShcABxFVudx
	 qm6Q5cccb5yxjzxTiXPVf0H3AV0nzT+84ub9/L06839cf59q4ZATkeE9e9Y/ff6KL3lPV
	 emCWF1fRjB+pHT17XHHgr8ReuanTcXCx/gyFF49HVMKp1kH8yB5GsL7U0YihsplutjvEB
	 Dw5hPdCHU/wt6TuH9q6LJAc7KP+aP7f5ERluyyAPiLJ2y12R4zPXRhSTxdP03TGVgQw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789396014;
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
	bh=rdnL+QZmldllhSEXwjFZivd45EvahUwSh+69ex8mtx0=;
	b=p3n7PgSZnsI1+FSMTEhMDBtGgPFfeDT8M1OzgXSLqPCNHjoWSckvIW52jY1f7Gm2Vk2K
	 OGdOIa4h4n52MBInWdvChqPCzlYZ3ic4agshSydbROB6Lzm5JcgjJilkDVaKHA2T0dVsF
	 BV7bm1Cy2pAbDlrf/e9uTocQRrtNaALQ6+8YCoeN+CE9TNcclONiaXGZq6erULMPV5O/E
	 R1TFkfT9nxpyu2dkUZaZZ0uc5TZrXcYF+sJlzfq8Jd4QkmdSxV8LVRgtCuydSbzRV9s+F
	 5Icsv0LgYKZDkAcZvfBlquPOCYOd7SSzF4/OrksS+yfrA8bYdHapV946C00Q09XiMxQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789396014;
	bh=rdnL+QZmldllhSEXwjFZivd45EvahUwSh+69ex8mtx0=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mXI8KpnueoN7fXU5yJAoAlOXYvjZ+/iKEw8hQV0tIylVNha1X3UTd9Wkqsy0tXT0o
	 NmYsV+swSsCccDkwWvgWLn9Z3WLVSJdCneMlAdyfc1KFkS6Acx6I68JonM9G97Jf17
	 BJRw8OhD7z4aAE3Xg6bL2QDef3TzJD51F/tbsy+OdyojedoMJhHcQYaO5gJZ97iUzb
	 UqeY67khmx/vclsAxnmsOBUKDNYuW2bK7jO/rL/oq9aAqCpTjyngP3syi6wzIdR705
	 FjMoPIOC4WJ2MPFj/DCAOXnesJYHdqIbBtD6cr7zjj25ZoboMf56sYkJ0VSJ7mV75x
	 tHpipYUMRJYyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4137380DC5;
	Mon, 14 Sep 2026 14:26:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 252B1118
 for <intel-wired-lan@lists.osuosl.org>; Mon, 14 Sep 2026 14:26:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 16B71405C5
 for <intel-wired-lan@lists.osuosl.org>; Mon, 14 Sep 2026 14:26:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id scdsFsSr_T96 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 14 Sep 2026 14:26:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4157B405A4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.13
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789396012;
 b=JL1KXG3yP83jFcjzJvZhHvMnAKmEWlXAhNag3wI7shHgn4auaE64JN1XJo9oo3QOpS2a
 PvsYMAO6ysWOaAgAtidyxfh4OFUv1xIqnqzKsaJJnRPV8sOVWCgAVMhFKhJ24r9Q6dwON
 uM02nTsXMCMW+EDt/OyugDL0LGw87YsdIOxDCf9PYObVqcjrHuR+y3B59RXGoMN1XYTRM
 VPYjAK1iUNBPRx2j9F0g0U5J9JYzwpl1HgWJ2adUBA+JivD7uZKv5tfZvRvProtNnPs7G
 eF82q2I0uZxLQnIyV+qNbcs4b2R+/ipaf7FtYW2Yc6SmnHI4b49d0P6RSAESiIgerOw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789396012;
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
 bh=rdnL+QZmldllhSEXwjFZivd45EvahUwSh+69ex8mtx0=;
 b=aVmjeAGJPAVBfx6+NZWpF/Gz39OoIVs55a00+pR54wczmyVcveUwTsj4MRZB8k8Q75Iy
 QiF9cGaEwvGEHpK40sXcHnCjn0Yhfw2gdVzTmg6Y5QpiX3XS+JVpI81S7jrfQNxdjEsdq
 s9q3kKJkbeLIdq38pb8Cc0xY4r3Wt/Ddsu0abxcHflo1eWcC9jDPZHMZIVtnYx/nKBvmj
 63yeXFBIIFJ3U+/+GIWYoW9aCcFotdRSzvOex0n1+ARc+HqVq52MpSKXuUCng8TjuaeQe
 4O2mbbi4T4bX7YgYTMsSuMdqxJtJHO6Gm7+rpdOTJ2nzp29/k2v9fEJdj3zVsKzzr7A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=fxc7LwFO; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.13
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.13;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=fxc7LwFO
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4157B405A4
 for <intel-wired-lan@lists.osuosl.org>; Mon, 14 Sep 2026 14:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789396012; x=1820932012;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=4tpHJxEMyHesdcKKtEGa4IYtCot2xNVTg0/2vxAb27g=;
 b=fxc7LwFOcCJkoSLcnYXzrfIEALmalsSJKOa3sckzh3qfH1hledqGmLQL
 Vd+KBPY8nEnUvE/iC2knP7UlQGh2YAgbMK3ArwiCqXxeOAUg28Ws21zRv
 6/69NKvxvmxJF+pvhSJCsaRhJVzCjF7NMwCGkCRjpzxTDjQm74/qpTCNK
 eQV4jSzSXgNoqlxqKAMMR1u2b4CR+1zC45pMk69TYD2Kt0vbKNvn33U/i
 w8Vic9BWLhGxk/aT7AesO2S5U0DpnUXpd5FT71PMZZAyFttpNEcd7XAxL
 yMpgvFnTnDqBMzARHDcKcUKXqvh9G4P+sR+T1bgEGbA2zQ3ScBrWqE1Jf A==;
X-CSE-ConnectionGUID: 3uYiT7hZTmylnCMLTciYwQ==
X-CSE-MsgGUID: ZXO5OaPFRUqY6pAMTvfG1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="100902749"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="100902749"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 07:26:51 -0700
X-CSE-ConnectionGUID: unwUCVsZTEaJ6WsyAhiI9g==
X-CSE-MsgGUID: MEH4tILnQ9enlkSRxXKtsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="310931867"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 07:26:50 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 07:26:50 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 14 Sep 2026 07:26:50 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.44) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 07:26:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tKL/hywxdUV7/65inI497Ql5hAWqfToEmy5OZi9IIRs8krDqiLCVDqyao6uyn4KTCwy1gh/Mcnrr4B6UdJnOBAUEEKD9jZew+TySvCvIetmyn4oVa0kFa60wmZfyAorhhPL+lF3LK95+KB3fFQyWR42B/4STXj/gs5kpIUqabPL5fVunG6TdSI0LxYamsbDctMHRCYmitrxwqmJRAhSIFcBWJK1Rg8dDeLQiHJ7VnqGSaMFzSszBCJWEznuZ3BCks7DhhvZIZySWG6veT4tM57md6jXw6dAwi85GT8zQM0nLnj80PsR4hjIEOxDSVLT0wGkBEELdCwNeZPgBk8smfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdnL+QZmldllhSEXwjFZivd45EvahUwSh+69ex8mtx0=;
 b=PZhJDjKALRw1xJF48mpoK2WeN1PgicAPPOeIyP1EMIPHuIPzMnnVBnreVR8K5pwYU2y9FMDqqpyLESCoLi0HwOC5oQyt1Ovso+tIyIDv+vg4/AUOMmbWZj9Tx54981V2F5ZEKpCmX/m2K84NUfalD8jiubBi6Fli2F6jxItzdkwj73zT0Bgda5Nj8x5TIr2BSthoejNCOzmY2OgAZ5cOggNldONRa5ny/GubOrLp7C1ZIK/ya8jaia+/O3gYvSiuRI61bzB7hTTwOJQFc4AcA1ey7eEN9klPjfkn0omSb9p9eznM3htnwYZASEL2MhS1DmI13AO15SYV+YIcWG1PhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by MW3PR11MB4761.namprd11.prod.outlook.com (2603:10b6:303:53::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Mon, 14 Sep
 2026 14:26:46 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 14:26:46 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>, "jianhao.xu@seu.edu.cn"
 <jianhao.xu@seu.edu.cn>
Subject: RE: [PATCH net] e1000e: roll back registered MSI-X IRQs on failure
Thread-Topic: [PATCH net] e1000e: roll back registered MSI-X IRQs on failure
Thread-Index: AQHdRFTyFW2ggf/aAkCrhbJxnl54ebbOIWfQ
Date: Mon, 14 Sep 2026 14:26:45 +0000
Message-ID: <IA3PR11MB8986C766ACED9D36CFFE5B1AE5BB2@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260914142014.428184-1-runyu.xiao@seu.edu.cn>
In-Reply-To: <20260914142014.428184-1-runyu.xiao@seu.edu.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|MW3PR11MB4761:EE_
x-ms-office365-filtering-correlation-id: 1e98e76a-1471-4400-9402-08df126c34b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|376014|1800799024|10067099003|11063799006|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: 1oDfw5SIgNbROtWMlyfab2E5awVqBx9KQCiaH42wiLW0FRBA07oFAqR4IC5X2E/v8l7iRWchPSYwlFppktgTYjf1oLF3JsxLxZ22lrD6sZs2gYAKLI+iBt0IqlUZ7rxerD5fWkflQ5XyWL9uF872or/oce2Z8zsrMKK21xEj6dcduArgSpXoqOxCc2lJs738Cgs+LGY0+9Zvtn7inWkEzwElde7uwK7FT0cHcp9sKiW0PdiiJfBadEcNL04jmVdOtUU6rY+d18a0Nb3gZnymJrwQsxrRF+Uo78/xl1NBokLOOp62OXA28dUQHV031aNAoiGVsRkkgpaPk+6yilLvfNHdv/dhkQl3P0aas2oHIeTN/wtDuVXeYdp/IiiPMwKhsLmzg5+tmzwgiSbfqAM64qqYQb7Xc9695V/xIc6InGQlPet8q3EWGKGsdEjKvVfn2vkQBrYVZdASmQchNI38xCNCa1p2OyqGo1YycH2HzgbiR7x1egOyPgBib2gdAPDB0+m7R8Py/6CqjaUqSfR3ImvDCSkIM97pTl9P0BavIFAF+dTRs8n1lkT0J0PaymgTsyaaruPfBAYz6GH++a2gxsLdrDefs3No5umqqvMSK771rYyz5qEzkhG+x1LznGMIDm4T4As0NJk9ot1LBBL/0QZDIaXj4kxdH5qUkTB79Dk38kOSjaH46a/eSxIcxInvSw2u6HNzd9UwPBQjIC1iDpMin90z40xO3VL7zDiaNfo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PXHHACxSQf7GB2AhHvAWNPlGBJQl75JYA8U+4+ntzqBlNtmoRvnjmcaPRt/T?=
 =?us-ascii?Q?roEDXNSrdE/qjZZVI0HUmCFd69ObKi563w7nm25tt1Hl6ymq0dTVGLyGd7VK?=
 =?us-ascii?Q?Ln/FyJtbxJSP7Q+MxVULUwIEiX4twIo58GTIqARzSK7WiMrnymFRVwnYXRDe?=
 =?us-ascii?Q?Im1XxYshfvnI6dBAny1hELvAbjRMe64VrBQGky+CRMUYVU3Bm1dPGOT7xEfM?=
 =?us-ascii?Q?VP8t4WS/5fFaKk2+xAKJgQ51TGNnME2BdLbTcTbJiF55Ez7Gm4ubTV9hSxnz?=
 =?us-ascii?Q?M/68sRWueLh6hoqBN3zue9CP32ABx2lUPcZeUd2/328OXWzRmYrw9z8Xwe04?=
 =?us-ascii?Q?2CHh5WKU7W5RtNqu3ff3Uhv87hXrlD+PEKsFBtbeP5m9oabFcBJJSuUCPh4o?=
 =?us-ascii?Q?PdoHz/gkFs5Z2Rflpz3lUAJ/NvR18AD3GTcUdjiFAxqKIfRKcLn6IjgHRhgM?=
 =?us-ascii?Q?QO0IYPDIsuDEuG9QB2VUjPu55hEdX3lKZYXVVZ3NHl9UtxtmLDT1IKAnCkUy?=
 =?us-ascii?Q?e7LrKWrmOc/+PDh0tDRKSj0uNSFPfEminzfFb9qmL4aQH4farqvWPBkODC+Y?=
 =?us-ascii?Q?gRCQhjS+d+iYugg9nXVvy6kaZZiT1dUWPmy91HOzyGwUXoFh2s+DAZXCgXns?=
 =?us-ascii?Q?SIEVog7elFRqjOy9oPG18dYvAdOIJF18lKIkK7LSyWrUNOeuRbgKou/oCRdX?=
 =?us-ascii?Q?mmBE6O5sKpk8Dm4FuX8DyAUHlzFb9597EmCDZyYXQ08tIvH0aKBWRPs9L2xz?=
 =?us-ascii?Q?1A15ve5hQgDD5qzaQV7AK0p1Wi9BszyxbfD/3g19POXqJWGRia2Wd4J7nB0F?=
 =?us-ascii?Q?oyNOxcyBgS1lllP2ViZ/F7dcQq81MrCvdUh97jryoqxRqG9kWixU2dOAXqw8?=
 =?us-ascii?Q?WgFe/tEXd7NJ/e1RuhcHdOGm/3WzPChbmTX+YPKTu6lRLYT82LUInkyRFAyb?=
 =?us-ascii?Q?Vdm4not/udUJ+mK7LdX2Szg5FicUjtaysdL/0AjLecuYAcDBUwXQ0if0b+Wy?=
 =?us-ascii?Q?krX1C4KU18cPx72YRXpdCCFnUZTPD+8Z/LiN2qM5aJE8ShwCefShT7tLDPt/?=
 =?us-ascii?Q?BVg48H1v64AaIx8BZcYNvjxjoQ2HzNgxbDkLbQbpcgxxWzc7p4R6aBMEJOxU?=
 =?us-ascii?Q?DLrxtPM8bdE/7+cPRzHgkR4NkIT/ICKE8uEKuTNGfWVNUg0wJGbkm86vOA3R?=
 =?us-ascii?Q?I6BB2+ZVr4p6K0KheJ9iYCw+9/Q1qFVQz1xqOWwLFt6GEs7nNf2zyNnfABsE?=
 =?us-ascii?Q?4PBudF1QXl1AcuP8d+P/1lxCWmI6AtaMBo2gwHXbu0rB++m+HgBVGyEirdL0?=
 =?us-ascii?Q?C92fC0EmjNt/XQASBes/0DiAuHYkG0SZO7pVeyJSjM9nseQ6+tDhJGoFF+Jj?=
 =?us-ascii?Q?97I0lKgSsedI0+bOeXHTT+Gq4cZgexPcLY/eh/jVv+UBC7h4nF6Zd1Yip3hy?=
 =?us-ascii?Q?Y1aGXsshUaQMr4z0acKuYGmebj0euvTd1odFXemI6yg07sFZ/uwRrtUS7dku?=
 =?us-ascii?Q?rIo/VhMz6hfZtPRzEZtrY/YkV9/fMGF7/cGnGzeyWA90I3czDpLOuhVxv2Fy?=
 =?us-ascii?Q?1TZ0tBXDLSN0tHyh6jPZrxWTJH3T6kKOaLh9zz9ESCJn2CXCJi0mJ1yfBL/h?=
 =?us-ascii?Q?sIqO+F21YnW8q9ay7zZZ581ToChJRMXDlI6oeU5bRkcbF8qS3aH8nIFP8JuI?=
 =?us-ascii?Q?nsORWQJnLZOxCRb4urXNP61fNikAwPRfMYBvIi+XXcOlzpPOZVehcZLf9HLQ?=
 =?us-ascii?Q?3R8DUg+Xid4JJXHStrPH0ReIrcYiW3A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: d9G/YQwOBGyCQnGdZRbYsB1iXkclZenu5OpnrwnqRW4As2t1ly0H1EgFb+UDJoCDBd9d6PSxOiRExTM2PEWtrvBT7YaG9XM8CpowPu+z2P3KPK/FeMCl0Z3xBMUb/rOGY+XJFd/VJDSmwbBMbOsZlf6wq4VTtxWmjhUt6yMsCP7A7s5X6ZDDbcvq2mEdi5qINW7t3ECYyeBLLBSLowzqeEg9vKdvHWRs3DfGXgbjDoIPVhMLMuktNVkID3f+duQL0mAAXqVBsooEsfxvN5B5guVh6EWzrkG1ip18brQT0+aEe9HRTCn/lPOUYOW4JQALcXrf6o0KySBuyw02IdxPWA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e98e76a-1471-4400-9402-08df126c34b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2026 14:26:45.9091 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B9LYTq25MLq0XVF0pQriOsceHySsHPNTgoeFMyjdJWScjODb4QHUzNyOO3/UoQEOxSW9QUPyw1W808q4ItUvNUuVTkAl+TC6wt+3mezB9Iw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4761
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
> From: Runyu Xiao <runyu.xiao@seu.edu.cn>
> Sent: Monday, September 14, 2026 4:20 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>; David S . Miller
> <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
> Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; intel-
> wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; stable@vger.kernel.org; Runyu Xiao
> <runyu.xiao@seu.edu.cn>; jianhao.xu@seu.edu.cn
> Subject: [PATCH net] e1000e: roll back registered MSI-X IRQs on
> failure
>=20
> e1000_request_msix() requests the RX, TX, and other-cause interrupt
> handlers sequentially. If a later request_irq() fails, the function
> returns without releasing handlers that were registered earlier. The
> caller then disables MSI-X and falls back to MSI or legacy interrupts,
> leaving those handlers registered against disabled MSI-X vectors.
>=20
> Free all handlers registered before the failing request in reverse
> order before returning the error. The failed vector is not freed, and
> the existing fallback path can then disable MSI-X without retaining
> stale handlers.
>=20
> A QEMU e1000e test with deterministic failure injection at the third
> request_irq() reproduced a residual IRQ entry and warning on the
> unfixed kernel. The fixed kernel reached the same fallback without the
> residual entry. The injection is deliberate and does not claim that a
> third request_irq() failure occurs spontaneously during normal
> operation.
>=20
> Fixes: 4662e82b2cb4 ("e1000e: add support for new 82574L part")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM Codex
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c
> b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 844f31ab37ad4..f55aec340342b 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -2139,7 +2139,7 @@ static int e1000_request_msix(struct
> e1000_adapter *adapter)
>  			  e1000_intr_msix_tx, 0, adapter->tx_ring->name,
>  			  netdev);
>  	if (err)
> -		return err;
> +		goto err_irq;
>  	adapter->tx_ring->itr_register =3D adapter->hw.hw_addr +
>  	    E1000_EITR_82574(vector);
>  	adapter->tx_ring->itr_val =3D adapter->itr; @@ -2148,11 +2148,16
> @@ static int e1000_request_msix(struct e1000_adapter *adapter)
>  	err =3D request_irq(adapter->msix_entries[vector].vector,
>  			  e1000_msix_other, 0, netdev->name, netdev);
>  	if (err)
> -		return err;
> +		goto err_irq;
>=20
>  	e1000_configure_msix(adapter);
>=20
>  	return 0;
> +
> +err_irq:
> +	while (vector)
> +		free_irq(adapter->msix_entries[--vector].vector,
> netdev);
> +	return err;
>  }
>=20
>  /**
> --
> 2.34.1


Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

