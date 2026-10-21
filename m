Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CEC606A328
	for <intel-wired-lan@archiver.kernel.org>; Wed, 21 Oct 2026 11:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=sVsAaytM;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Hv1Am+TA
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5339280F88;
	Wed, 21 Oct 2026 11:22:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HB1QVzkNyqiL; Wed, 21 Oct 2026 11:22:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A081280FFF
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792581770;
	b=On+MQnEyyUjsoFFEbjDqLY42PKu0ThUmqPt6aKqY93Ye5onpYSR/69s8esjPLAS8lhUj
	 9d+fGp8785MnuI116t6dsMCnbrKfxrB1/jGVzY8kasZSrA3d0ZVHS1qDTxB2Ysiw4Ip6b
	 oDxq68AAsTGyhGjo7MLH/3r5Mr9vvNhMryCphZUh/zNo36IWtGqVawoC6+4VTQ3/W+B0B
	 Fuf/iqvC4FZ2qpt4YVkOHCqkJcj7npxH9x/zreOOovneZ972uYxhvq4guPTOvdcc/t3Mn
	 kMzG2oNPvzWVQAmU9o+1MjrEs145mym+IfAXn5wmT1G0+8S7y+2lo3CFeD3jXTeawKQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792581770;
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
	 x-ld-processed:x-ms-exchange-senderadcheck:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=QirMFq1vSO7/XYJQ3ZZHkphib6vGvDhieS96H4njS0A=;
	b=HAHpBT/C35oVFb2MsGySL74n5yaWg4l7ChSc2s7NXWnPLsZWRODL6T6SaxKAg61jlvJq
	 VRf9MRwInc9ZcHZG5XarbEQKKOi8855ZasD8QCazrhp/nTO3mocdvRROErsuUckdlZE43
	 dakJG2zT4VIJGwhUYNxHL4Pe2Zm00iA+RWmVBNt+u02baxcffGH8Re6TtZQOPxh1gL4hI
	 vO83dVks3zRR7ljFbAC5sQxzwqbXvKBqhYzuwq42yLwNnfibPHywnDgDTtzllSZNQSq3g
	 inL02I3ohEADqdObip4vzitu9XXuRBbyP5AA21hXNQNMTJeF4Gbel24i9CzRYbjw2DQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Hv1Am+TA;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792581770;
	bh=QirMFq1vSO7/XYJQ3ZZHkphib6vGvDhieS96H4njS0A=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sVsAaytMXYarVffFXq80q5TJm/EEE/TmGEZbNkK6ci6USRmJwM7VZjJeQ6MU0zv4f
	 Dm3auMjipvS+OIcr4Tw3ShEb1I5pntUPU/KeH1OsHTgN9KL2kLWVFKYOq49A4kLBxX
	 R3nHEVhE1ODe1Otfh9xeikekKfUY6aHU0QkzKaQ+Uukaq91KSBTmBHJdzoknVfUOxv
	 yMuzYwaqnHwCFnw5N0X/iFQk4U+2KVLfI5ONQF38CpcONflFKb+dTlccVcI+au3+Tn
	 3XwOAGaiXI3f27Heu9UFuViMW11JrXfOWWmxZN0kA7e/86acFPHpYWWigpBp9olEZJ
	 Yvyy2A1H8rhUA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A081280FFF;
	Wed, 21 Oct 2026 11:22:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8BBBD1AB
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Oct 2026 11:22:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7D18680FFF
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Oct 2026 11:22:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RsbLaeX4Qjyo for <intel-wired-lan@lists.osuosl.org>;
 Wed, 21 Oct 2026 11:22:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 663DF80F88
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.11
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792581768;
 b=dr1pBqq6YY+xocW2n7A1RsG8deKQPFYAYjJdZf1sYdUWNsFc2Jsn5M7ugiKBHynWCNaE
 AHGrhUjKzY12/vdGvS00JyWrN1SCyjoXQ1uLGXAzBja5b5gg3edYzowtGme0/56lHpPjv
 foN6z+P/PhRfY0iLj6x97gKQLKk7n+DX5mcBZHXyrDHI/bX84hL4NAQtKfXsUdZE+UAJr
 sVEVqs4xjQdMStZgE3R6MKF3/Ip6Lw0bbEx1nzrDOoz5BMpoV92eH1Fv0ZQ8lGe1qr86V
 Z17FU/k9FK9jvbNJPiIkUSIqeFEv0Miyan2xq8czKlDU34Thi2rJ/BPhYHu/jD2IRww==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792581768;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
 x-ms-publictraffictype:x-ms-traffictypediagnostic:
 x-ms-office365-filtering-correlation-id:x-ld-processed:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 bh=QirMFq1vSO7/XYJQ3ZZHkphib6vGvDhieS96H4njS0A=;
 b=A8PAicOwzbfGP8sq05aXL9c+DaUN8r4mgijMiQ5CGhTF6iTX8LSVu1LMExcgodHqBOBU
 Hxxots6hmF94J3a55Tx84tqiDUwoRIr2uqL+cPIiqZcJJPaG0eNrFLgWkqQ5RIBFuSBPe
 fw6/C+vEfRTCU6HM8n8tP5VfJiguYmx1+GHARHV39utiCVCWlBidlgN2H5U7FsEwomJML
 aMGh9l2IgnksGiyXAxzTgS1IE6NEMAEXWPxExaGobwNSBd7jlCeqUWLz2x14mxeup8sWx
 9uG6VZhyt64E5xtzjkOdSXnlpipZmfZO+ztLu3TgFmMeROkl3TltpKf+E7IlTweNgjw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Hv1Am+TA; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.11
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.11;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Hv1Am+TA
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 663DF80F88
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Oct 2026 11:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792581769; x=1824117769;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=hnlzjverBfQQ4rjq1+hOi0pQU4SfO7//PCQ8wSCdlZY=;
 b=Hv1Am+TA4n7bTMxQS2l8LbFkvd72+d51g3gDvyjty+rZcqOMCHpHTHo4
 IPpNqyNuxyhyWhPAW5/tKCoX5e9ewwhkinAnpNE86o3TgU+Tptqv6fk+4
 +JoMUrehHvcmS9zkyH4XjVEMHOqL/rynTQFul7oHoPmZlZNMU6WU+XAOz
 2GxTwkjDEPIe2/YgGmuwLNgVQOXzS0vh+Dqh1co8jvEAHSsX9lYYIuBLx
 lzzmpx/Bks7DDmOvGQAPcz4j3hrFoMAghhajtLdiiQ2zobePN88KivHsH
 loZIQOEczcPFYCC3sYI2/WVFqrvU98cMau8Fo2BMVgU3Bz61w3zonCPRn A==;
X-CSE-ConnectionGUID: eOak7I7xTvG8ockNasn+NA==
X-CSE-MsgGUID: F6e6/QC3Tgaa9xs9oUIr5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1191658"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1191658"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 04:22:46 -0700
X-CSE-ConnectionGUID: 6v5NiwLkQcyVM2+FU1AVDw==
X-CSE-MsgGUID: cE1KZNybTjOB7Ej8Ho0H+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3407425"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 04:22:46 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 04:22:45 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 21 Oct 2026 04:22:45 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.66) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 04:22:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dd4g+MIO41FpxcTo6iSoeLUQnpluZ8QNIG8I96ccoZsqjVx40NApo6hJfmBMP/OfqY/auBNW1QmBkpyJhd0A5UnoeBKOP/4Dk59sC8eJy+i+BIQhFHU1qTITa723LKiTJcdDCKo6YyTnDEnMAZtwE+jo6wP8qlXaWxiLaAxpdwSvY0vlmzplkh7vT9OOm4SMhryIFxy7QuTgdhruM5zX28htHZvxTlqV40JFUXo/ch68TETGXmcLWBpgL3V9b/QaUn5o+I5IJ9/jHifILfH7/PyxKKYsd+i34shj8sFsurBrbkzIDlu5//Xxw6uTzhSK5e79Hk8LKML2SwrA2QkzsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QirMFq1vSO7/XYJQ3ZZHkphib6vGvDhieS96H4njS0A=;
 b=KcCQK5KhgHv210Lqj0FxoR4x312ckibAjBcHUc4CGg77cQ1XOxPe3BktWhhJxhaA65w1ar70ywsz+f70liLXuji40+K5FUfmdraIxRsXnSbJ1Wkv+Eet0ybWwokn5KyMOsX8IE64D6hiP20DIqS/l6Qgm1YpiU3saiOWZZyaWNM9OLiRtgpHdDgMuHaRSHqu0dO7oRnVwW0W1AImx9mCZeVuovvfmZyliwQX+HR81xAEl1vWaZUMJnmDQV5ipTOPd9n4+qtn7NGGeOhvOYpaZCbHR2qL4NfpnxHWTvsBbDUHkufYEWVdPwY641q5zZOpt6yYHcs1hjwFa9GkXRrBSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 (2603:10b6:610:34d::22) by LV8PR11MB8512.namprd11.prod.outlook.com
 (2603:10b6:408:1e7::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 11:22:41 +0000
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584]) by CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584%7]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 11:22:41 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Oros, Petr" <poros@redhat.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
CC: "Oros, Petr" <poros@redhat.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Ertman, David
 M" <david.m.ertman@intel.com>, Shiraz Saleem <shiraz.saleem@intel.com>, "Leon
 Romanovsky" <leon@kernel.org>, "Maziarz, Kamil" <kamil.maziarz@intel.com>,
 Rafal Rogalski <rafalx.rogalski@intel.com>, "Schmidt, Michal"
 <mschmidt@redhat.com>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Mateusz Palczewski <mateusz.palczewski@intel.com>,
 "linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>
Subject: RE: [PATCH iwl-net 3/3] ice: do not block on the aux device lock in
 ndo_setup_tc
Thread-Topic: [PATCH iwl-net 3/3] ice: do not block on the aux device lock in
 ndo_setup_tc
Thread-Index: AQHdX5ajzo293ziltEqeFtrtBEK9U7cH3YlA
Date: Wed, 21 Oct 2026 11:22:41 +0000
Message-ID: <CH3PR11MB566895E0410B0694F734EA7DAFE5662@CH3PR11MB566895.namprd11.prod.outlook.com>
References: <20261019065301.3983537-1-poros@redhat.com>
 <20261019065301.3983537-4-poros@redhat.com>
In-Reply-To: <20261019065301.3983537-4-poros@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB566895:EE_|LV8PR11MB8512:EE_
x-ms-office365-filtering-correlation-id: 1c2e7e95-9226-4a11-eb02-08df2f659f10
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|23010399003|22082099003|18002099003|38070700021|11063799006|261009223027099003|56012099006|10067099003|4143699003;
x-microsoft-antispam-message-info: 3ZWlmE/WttOKlW7MR692XgWP5L2QbYnd/k58jt5yk/bA0rJ09sE+xhD91/hjyOjeWqXPEYpLNaOLsFYs9d2d7nexS/dJVgfdmc1EJhCJDyP07DRCNbMQ2TXzkK/fGscIIc67eD6/spzXBD1NpaB2j7QPoHOU8QYdapRjL827llbJFj6wAMdZcUxp85rpNlkBaLAY2pNHulrTHodjX3fbonYbGODEITIpoaqllJpntNo76kUAen4sIvVLx5dYE/bYYkK7RQZhDL+kwwrLFJKMZbPGQGDt3l+Iv9CNF50hG/+LXG+1mL5BeUYNPgakhhZsR8gjtUk+PTYOaiGKyEYq4bJ1hkY0CenzdxZ88Aq4nwD0zk3YYVAzHsHL5QLC1IcOzcH/xoZrn7h+MQM2xEhs3UZB9LjZKiOChUTsaFTJUBo+t+FqIOm1pqCuQgdnUpuzKRszVWVDIMs2DgYeqRrA93tB7wf0nVEzRAZe/VHMr3wj2o/d2qhKv/eCRIHGAd/Ji880vnuE6zNVo+tinqhZu5psiMuPHXs2qLhRcxM+27wQ1mcnEc1W4ROyL4O+/Z+b0cxN7jdKZMetbBICfw3/pa4cdwOsbEGNXUcEXm0ZoThzmBI0gSPQV58ltPxgRFQv3SbB+t/2HUpJpPksM7QHrwsb8msqrg3lvB4NSg05E3V5VES4Ae1jJFvlUQFUdaXCHCYf0lFNIYK2A6x3Zs7iiGt3dyE63h5gf4mtV9hehGc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB566895.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(38070700021)(11063799006)(261009223027099003)(56012099006)(10067099003)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?p//+7SFSgUh/WCKI4aGC/f11YInGJeTGk4CMQCoPX4mA1/8l3gB5t/vP80gi?=
 =?us-ascii?Q?DWsUGI+WVcIEYPcme7fTuWD/tf3AmfmZir9iXokKDPm8Dap+9ZmPrEGwB7Ao?=
 =?us-ascii?Q?2vT588v2osuKT1sIAy7JqcsoVMDGMw7tKGbLEXT3inzesYZyC+H9GkOpmLi8?=
 =?us-ascii?Q?DYL69z5Yy6vfR1D0T9TxSOuLxBtnG37RX6n4abqGhYIVeZ1mC95g50mmVQZ/?=
 =?us-ascii?Q?Ow60Qefj8p2Vtv9XDdfe2pQdQaYVcqkhBs+fR95p3qzw8a3XJGWv6gcppLNZ?=
 =?us-ascii?Q?cDsPk+gNkbAehVBYfGgdnq4Rn2DHTA6XRHy9W7Ei6cSP8oayf6ZsytDmUi1c?=
 =?us-ascii?Q?PxbSHSjXGiwTgOAD7Np8YARYesMCnDysofk+L/tstFrLWamfBqRI2QhVpsCX?=
 =?us-ascii?Q?iUt6YNrQy+JVMf5JnoX+LZAeDpjmfeJhJ1VFgbOlLVFoJatnbNW4STcXKyjm?=
 =?us-ascii?Q?qvbY1R0/l3hdww4WzD5TghoijIZo/PdkaL7wNrfaOPSH2Kttm+ExuSrnjTXF?=
 =?us-ascii?Q?1l9Luw0nzcRBBpot7kWtLdf2EcRLq3q5LOOTgQNHpKAq37PUJSq1xvAbt0c+?=
 =?us-ascii?Q?Jz5Qq0TmqUz9IkOeEa1KxvCV3MMRhVzHygrghz9nxLFNORdIDtcDAEMfbsdx?=
 =?us-ascii?Q?AiLF6CMIqRoSp1Bo7BTl3lVjJZIdTKHITonyUHKN/ZqHurERIpfz5ik3g8Bg?=
 =?us-ascii?Q?rJZGzgdNS+8OJOyc27aG1BQ/SaaGiqGa4ScsaQ39XIptR3A9TLAHrwoPNJWC?=
 =?us-ascii?Q?dthudP+B5OAxN6xcntF/bgM+iTZz8ZBQZuUTq0J+tTYU9OLdfSe8KmIVJVO1?=
 =?us-ascii?Q?E0k3MjmzishvC7QHMyYGR3rse7/ApT6YUPw9v8ZfXMw/xUEQr6CAJgL2IA0+?=
 =?us-ascii?Q?Batre8BrQySGnD7lPRwtY/c2XQYNR5zw/bMryFszPL8HR5PLLoSnM6QxuXGN?=
 =?us-ascii?Q?/jx5BdVvuwuo5u2vQVfRqx8Li5csZinW8H7tFirvvh0Nrp1s8ZFKV/B1aDus?=
 =?us-ascii?Q?g8v5rRiqiJtuSRo+Q1fD83S7eHQ+8W9pff3t9Jc1muRdjHENLdAmpKJGV4B5?=
 =?us-ascii?Q?B451hcx4nbeodrSAQHtlzeMzAsL6EQfmgdxmJ4xOLFHBsJ+txS2PqCw1OpwI?=
 =?us-ascii?Q?x4y+aXfoXmorYGaQi3eoo8t85tPDp+NRFWE0Zs3rC/4tnIIp1GWWVtOhxSDH?=
 =?us-ascii?Q?/teFENVWhLOYlmQIEquRpWRZy5FzrtM3DzmllgKBM+i2Txp1HURl+SMPIeik?=
 =?us-ascii?Q?vTBCce5Vd6o1k6QW13HWY2WySWvH97ia/uYrxE/mo+okIG/DlckRYB1Hg9MI?=
 =?us-ascii?Q?bTaZjGNH2ljwt7sPFm3BnFaPzDMKS3UKy4vPsOluOSxHPtOWbC7LcV1DiAFZ?=
 =?us-ascii?Q?NvUkFCrnWB40MZUPH9Lm0F3Q+sDB3x/b2gT4dujh0zhOsQCyrqeguL7DdyMh?=
 =?us-ascii?Q?OP2f7iWWngfKw54Sr0fba6IXAUkPY4RgYd40dS0QyA9ABuYINWZj9NW5md3D?=
 =?us-ascii?Q?Egw6VWk7K+f7z0MfL3M8Nqvc98kqcHovsNsoeSZoJLAW4lqzNbg8BGUF3wre?=
 =?us-ascii?Q?vdel0Rr4qHr4s17loZp8t01ATYkKa5bzSl6UeaI+D46ah3S8d5itYB526MQe?=
 =?us-ascii?Q?LRYcu3nBuM81LDf4dPI2+MaXT6aZKsg/sgvxYFbfrAn1e8mH+2oDLiaJg1kh?=
 =?us-ascii?Q?PATkz7fD3m/AtP0cscfNK8O2lnTxPY723kdn52uabGPD0RvkXxZEIbxCU3On?=
 =?us-ascii?Q?RmQ4EfR7Ew=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: lDC2CxCSpKshEVG2BbsV+By0gtziSuRb1qXwFveIV5SvdtiN3WYmnhYQXjGGTBkB0sAml5P6NrFB1sKD2uqCCJUL9WU9+f09B4WUjdatZ5LkD+HFsKYk3fXFLkUb7vkdIkbmUti3UDiIYnmuWntg5MCVyVxectlv/OwUv5tzeQVvzY9BN1rlVxVRk3mGUkjsTo7jPwDb//+LRfQOdVOHeU5X89jD4hh2fUXxz+2yHrt3V6WvA0xuwRlUaTbe0MDv/j0jKiFmSIMFh74orFk3FZiiGa/C/Wei65w0BgNbO0/4iTEPjbqTbgmnSIDK6TPPmPUcubK3HDn/pnMCboLdRQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB566895.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c2e7e95-9226-4a11-eb02-08df2f659f10
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2026 11:22:41.6687 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N1WGPyL0QlOqmDGjmTdl8mNkGpaIrQlaiA5OCYRi07Z91cIFaRI4xHt5yeqx3rc/R4WojOrjklUEdZ1rH7aQZPIXH0xPkNdodz0rQVrMz/c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8512
X-OriginatorOrg: intel.com
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



> -----Original Message-----
> From: Petr Oros <poros@redhat.com>
> Sent: Monday, October 19, 2026 8:53 AM
> To: netdev@vger.kernel.org
> Cc: Oros, Petr <poros@redhat.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> David S . Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@kernel.org>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Ertman, David M <david.m.ertman@intel.com>; Shiraz
> Saleem <shiraz.saleem@intel.com>; Leon Romanovsky <leon@kernel.org>;
> Maziarz, Kamil <kamil.maziarz@intel.com>; Rafal Rogalski
> <rafalx.rogalski@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Schmidt, Michal <mschmidt@redhat.com>;
> linux-rdma@vger.kernel.org; intel-wired-lan@lists.osuosl.org; linux-
> kernel@vger.kernel.org; stable@vger.kernel.org; Sebastian Andrzej
> Siewior <bigeasy@linutronix.de>; Clark Williams <clrkwllms@kernel.org>;
> Steven Rostedt <rostedt@goodmis.org>; Mateusz Palczewski
> <mateusz.palczewski@intel.com>; linux-rt-devel@lists.linux.dev
> Subject: [PATCH iwl-net 3/3] ice: do not block on the aux device lock in
> ndo_setup_tc
>=20
> The TC_SETUP_QDISC_MQPRIO path of ice_setup_tc() takes the auxiliary
> device lock to test whether the RDMA driver is bound, and ndo_setup_tc()
> runs with the RTNL lock held. This closes the same cycle against the
> RDMA auxiliary probe as the two preceding patches.
>=20
> Use device_trylock() and report the device as busy when it fails, with a
> distinct message for the same reason as in the previous patch.
>=20
> Fixes: 4b31fd4d77ff ("ice: Fix RDMA VSI removal during queue rebuild")
> Cc: stable@vger.kernel.org
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c
> b/drivers/net/ethernet/intel/ice/ice_main.c
> index edb62606d2aae3..7b251136149615 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -9448,7 +9448,11 @@ ice_setup_tc(struct net_device *netdev, enum
> tc_setup_type type,
>  		cdev =3D pf->cdev_info;
>  		if (cdev && cdev->adev) {
>  			mutex_lock(&pf->adev_mutex);
> -			device_lock(&cdev->adev->dev);
> +			if (!device_trylock(&cdev->adev->dev)) {
> +				mutex_unlock(&pf->adev_mutex);
> +				netdev_dbg(netdev, "RDMA auxiliary device is
> busy, try again\n");
> +				return -EBUSY;
You return error here, but it looks like being silently dropped in mqprio_d=
isable_offload() isn't it ?=20

> +			}
>  			locked =3D true;
>  			if (cdev->adev->dev.driver) {
>  				netdev_err(netdev, "Cannot change qdisc when
> RDMA is active\n");
> --
> 2.56.0


