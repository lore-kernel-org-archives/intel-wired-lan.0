Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C0C5C9832A
	for <intel-wired-lan@archiver.kernel.org>; Tue, 29 Sep 2026 06:30:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 294B1606F5;
	Tue, 29 Sep 2026 06:30:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Wszb-GOh71zO; Tue, 29 Sep 2026 06:30:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 301F76070C
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790663428;
	b=UgU+jcFkYXVyUk18vqisW3EuM3WmIkQMOfXajaTY+o81s3O40Q1e+trzRDBrdRKjEO2G
	 RknoNxQnk7RI8Ze3SA9D+HidDyJkEaCVK1oIgky2ZClN666p994R+3VVnPcqQ1uLw3ytq
	 kB2Ie86vzymviFssLru6XrhonoG2VZed0az2V1bGDG1KY9OOm2PreRk1gpR9BCS5WbF2w
	 Jr8OJN4DbMIWkOT36wnEtyA4jwsCR3I9Bhx2E69UvgCqQky9hYPfBTMstMLEOvKCgCpUd
	 v/MYzPw5OOA4y7XheLUw+nlaPsRh0tRQzuecwLtXZVoRW/LPvRlIzXWgJxZ2p/vaCFQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790663428;
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
	bh=czQA4fai57ygVOmHsDJ6vlacY3uhlOJbwllEbOkRQ64=;
	b=cHH1mKF1oFNxl3pzqvVPuCMG6JqMnVEW/w3jTdSsBZAaCg8RPOBrOZ3GGmPVWiDTJjNs
	 gti9JMV+KT6qjMYAHTaNDWP7kbUrpACxeSqHTgeMDbIowNAV13zXLrPD68f4I/JooOMib
	 JG114usXf1Zza/6V9pVbxLl3EVGo8jqkNf/RZOv/V67DFkIvKgOe4oGH3/+b82nJurQb5
	 hP81SK27jj+Ro6VhpHqI0JO8pXCzQFf107SC7bLqADCOirnVDAuyQ/02UT/wWxD9vJ/lx
	 WYb8kUQXPhyOplok0834bykZQRGKS0Ms4Qrb63saeIjUpEVtJP5XcubGAR5se+2/IBg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790663428;
	bh=czQA4fai57ygVOmHsDJ6vlacY3uhlOJbwllEbOkRQ64=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XhsthSDygTRd48t8hRWwOeZvEBuBnrrGz8j5+feHA4WMLfR5xabyl0HacSAr5JcSb
	 YfUOEO2FriCAP1ty5iMIt+0EHO2sVMRmwodS8r2Szv5WxnLvU7pqOoqGvjJBhFYAOX
	 esVVq0mgC7/UWXCcAvUbVmuro1vubbuq+FJgH961AsyJ1noIVPegOxlpmbm31OCfj9
	 mqP4sOMICmfV8eRl27gOBWTGJQmdYwSJyJ/mKzeKzt1xzXb2x/+YbQDPETeXkF3LkS
	 +LKK5KELE010FW4EZiql9jXhUpkIVz+7pp1i2hiL3Mk+3tdC0kgg9h7uanstkFoEnE
	 1HKdla2HdptDg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 301F76070C;
	Tue, 29 Sep 2026 06:30:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A604B335
 for <intel-wired-lan@lists.osuosl.org>; Tue, 29 Sep 2026 06:30:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 976DF40082
 for <intel-wired-lan@lists.osuosl.org>; Tue, 29 Sep 2026 06:30:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dmtiVJ45Be4b for <intel-wired-lan@lists.osuosl.org>;
 Tue, 29 Sep 2026 06:30:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 8EECF4006B
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.11
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790663425;
 b=QRFw0cq3XiyPLG5XqKn3INxgMsqq3U0VttzezLg+HJGmsL/ON2IAk1r6ijPSM/FvVluP
 XjAGvkdQHZkoeHLKHHSL0yZdB4LOsbC8990DIhFDxTLqbjg1fkAgoKgQwlCF+MCuIU/OF
 kVc0ORlNp1jrlBAuqqPGSTvVOR0LyObngGw2aMxdOaiJ3tLNLV97LG4J+ZK9In6LaTwvQ
 ghxme5lWzQsL4y6pxeb5zR5+KVUoxc3Q9Cv53UGkZQ7EMXMJ2zoqG7eiWTKwOHfq4XXdh
 jB8n8DGOLviiVSBXW6TVf28QA1y/90AWKl5nL8Zd3ecKZFuQO30kYYzHXTibGftWnGg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790663425;
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
 bh=czQA4fai57ygVOmHsDJ6vlacY3uhlOJbwllEbOkRQ64=;
 b=Vt4KODH6HkpC4UZlKEq7x64ZzUPMLn7N4OwGpScyeZ67QRlTEgYnxyQCY/kt9YOJayPC
 JyzWorm1azdAMypYj7BSsdbQhwQAdbrkBf7VpPlX08bj2xjRZ/7tzpI1xyDs/LTRDffj3
 ZJILmplNsLXPPvvfIdX6n14g4aDIrRtCuH7vHQMc4j85/8dXFL6DpZ9l67/9sTyO91Fh+
 wOvJKlq0Yf2ldQ8Mk6i9GTWbp7RDTIYlNJ30tYtEOJDEhqBta2bA1uQEUCkIMN+0hocPu
 hqvuDZzRRpMw/RHCmjc4nUAMSdA3patnC26KUrGFZx50LtmnieWNqNPnhA+Pxn6bHNg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Yc64Tjcs; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.11
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.11;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Yc64Tjcs
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8EECF4006B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 29 Sep 2026 06:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790663425; x=1822199425;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=BtrQB3E9DCjLhnLstjusZfY4Mj0QBezAZ7jVCZtpph8=;
 b=Yc64TjcsMhDHKmtIELnYkONWjYszlSyJznl6nbqotHUbwiohtUwlvdNC
 tHHOCp4BSX5xwPnTswXYpHC70PLfTSPcxWU8dmnBdzBARBw+qXFtOUZ9a
 ksgkeWPloDHwnWGFXo7ZH4mWJ9ba2F7xARP3zBlV/y//ZZIuMlONPTx9m
 6tD9ukGoK5XVt31f339Z9E9vs0SFhcV5VhiSKXchxXr52MaFTS0ngwOvP
 HFJ4XdN3C9r89K3YL0SnWJaNAdrXj5FxzvP5Y3zpk4axl5z+++Anr9YND
 Q8Oj7AMF4qg3dayARUuoSMSQVw89eIjQHeeXlzMLuFR1tQpYSFMINqPwc Q==;
X-CSE-ConnectionGUID: yuCGYRJwTxK5dfoWaz/zZQ==
X-CSE-MsgGUID: B25NkB28SkK2hY+CVdNkBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="101944279"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="101944279"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2026 23:30:23 -0700
X-CSE-ConnectionGUID: glMTKsGuSOKdJkkvdnkvHQ==
X-CSE-MsgGUID: oYFTTqDtSWibL+AhwaM0jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="303234232"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2026 23:30:23 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 23:30:22 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 28 Sep 2026 23:30:22 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.3) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 23:30:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XJmFtNwKXoK2Jp5hcHX877fq2CkCP1A0DMHj1O4wD/ayowVoBharZJ6fRdG8SHp2raxJUqsOMD3P/7F86IbNn/hECXf3sj00wB9SGiJUmQg7p+e4ldfNTjmvin+nOfrp3iZBpqgUd8dY4QlOgYixmAg1lwngaYmFhaRGnxHhLcP45NUScaIwQhewgtKRE6pA8ZBkO6li44Zpr7k6qeGn4bpqLRLUUbrDeVCiCN9aqwBWQZstkkGO9LXoQf/96xDZwB1TW4PevgYXTpsYqigBBdALHwCQuilOEw8ZM8raNkjF19vkfXQZ2Zlzn0WEatW33R/gQPajLEXBHTM/MIfcQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=czQA4fai57ygVOmHsDJ6vlacY3uhlOJbwllEbOkRQ64=;
 b=rfas8NtNqOUxfM62DfnWuWGDoF4MlBoZmjxkE9nlPd0OQaSNoodQEr3mh6cazSkzAR+Z7BTCtnx1p7MFflM5NfUbOZ1JLancKJkbYygWpX4lfGiiSW02+1FN+O2bw2FQpQgxsJtIY5A0BGp+y9Rm3REKDU6c8F/6laOzQm0217FLfhl+hMH9q2327nftXiIMPXw5knRFiqoyAHu8PZyHvoPY2DMy7q9s8s/CPdEJYIsuU5lBYIHSPMmz3v2MzONnwA0lYwo+9+83LbZTGijB3l5m4thHzZwvibL7CAh51ac62LD/g84cDv03zxW/u/rhwNG/A6MbL13leXKhIK5/vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by LV3PR11MB8484.namprd11.prod.outlook.com (2603:10b6:408:1b4::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 06:30:19 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 06:30:19 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Ren Wei <weir@nebusec.ai>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>
CC: "dsahern@kernel.org" <dsahern@kernel.org>, "idosch@nvidia.com"
 <idosch@nvidia.com>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@kernel.org" <edumazet@kernel.org>, "kuba@kernel.org"
 <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "horms@kernel.org" <horms@kernel.org>, "steffen.klassert@secunet.com"
 <steffen.klassert@secunet.com>, "herbert@gondor.apana.org.au"
 <herbert@gondor.apana.org.au>, "lucien.xin@gmail.com" <lucien.xin@gmail.com>, 
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "jbrandeb@kernel.org" <jbrandeb@kernel.org>,
 "sln@onemain.com" <sln@onemain.com>, "fw@strlen.de" <fw@strlen.de>,
 "petalzu987@gmail.com" <petalzu987@gmail.com>
Subject: RE: [PATCH net v1 2/2] i40e: validate TCP header before ATR access
Thread-Topic: [PATCH net v1 2/2] i40e: validate TCP header before ATR access
Thread-Index: AQHdT1wBcXrCtH7MTUSKdftx5cuKmrblGS0Q
Date: Tue, 29 Sep 2026 06:30:19 +0000
Message-ID: <IA3PR11MB8986701989E082F82308B92CE58C2@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <cover.1790082243.git.petalzu987@gmail.com>
 <79c2c81b7c61c61b242dbe1cc9b2db9860524a3f.1790082243.git.petalzu987@gmail.com>
In-Reply-To: <79c2c81b7c61c61b242dbe1cc9b2db9860524a3f.1790082243.git.petalzu987@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|LV3PR11MB8484:EE_
x-ms-office365-filtering-correlation-id: df9405d3-99fa-4be1-25a0-08df1df321dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|7416014|366016|1800799024|10067099003|11063799006|5023799004|3023799007|22082099003|18002099003|4143699003|56012099006|38070700021;
x-microsoft-antispam-message-info: UgtmZRi7+zyLE31WnqllFwd36nkWv5jvljgzlxUtyP9BwmFodQsOcNDvc/XkU/nZWrU1uvyyWQS7JkNiokDyJI9xjGz8auuOAWc20WNRh2R/CsfOBacVGE+yLn+3stcdxcaeuSxFfpxfoqX2r1QxsBqbEFHaMulBzRVIRqUnlNrMM9AX8tTFD3QPqdzwWuOIX9BeWpwkkgBJg3iWa930wo7a6WRYsI01jG54y8KBFCcnXIP9wHLiy+6Yt77y0ZRuJSKtSfbY4beKmlRzGIlc079b18//FX0H0b3MKt9u8GaYz6KIssfWtpYvfnnR1sFKxCtjSCAnKmfahK9gBBNL1Py107PW/FaYzjKE32pAlGeJ0WoJLReQcZQhTLhKhv0X5LxgTLzwJz+kpBrBIDraCZYznTt0GUyItqcnCQkkBB9DDRLI2UnrFPDb/ja+n2TqomqPRnL+9QhlIElkIyrz2SsDK4TN/QCPEfgm7Xz/NWvTQlt0nRXnf+n0bcKHwlrbOlXYntaSq7X7v5yknPrZwr0tlZMk1kb0xKri/4BIn48xCRfikm0qFZPV6bBZwxOHbucTZX6aA9RbgDIM2t00S7LsnN9UArN2YJrN3S/f7kCs3/NfjdjwCSieX2/Ujnpl7iNLhggEeklcjOHxAvTK8rOhjR6kHYQQO4GRWGddAP4p0B7llPc7hYsuVWxoV1EO
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(10067099003)(11063799006)(5023799004)(3023799007)(22082099003)(18002099003)(4143699003)(56012099006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qt9uQgMCiJMJfc3uoQRJUWIutTmsBC1a/lX8ehCD1vJc3QjAQSNnomCLYY6c?=
 =?us-ascii?Q?Vx+3hYJm4vD0rQY0jg0SKJWO+zMSpMciFeHl/60gPOaOustGAGOeSj/CkStp?=
 =?us-ascii?Q?P0M3abCl8ga60N0FLrGisQvvjfwxV65K6D37sxSFEBKkZR83WqbJDog8pOek?=
 =?us-ascii?Q?YsBxjoTgFYgvzoWhxvslM1TqVcWwE/XEe8yS9WHL/vhf0ydBdeI3STD2vVYT?=
 =?us-ascii?Q?QncSrMp/q8q2rJ8mtK5DHRZoz3HKUn529Ar5nfbBhITqNzyP+HRhkbv+zdqm?=
 =?us-ascii?Q?Bhvo95i5MZvYVdopm2p9YHSrzxYaHedcfSaafXjP9B7bKaiJzjYfAMZ6mI+i?=
 =?us-ascii?Q?nOozfJ2kwqRRtJIrWXFM0Lk5hhqNGDb51yT4RGhyngUCh9Ld1pqm6oUAJwij?=
 =?us-ascii?Q?vdnew7X+sWt53kUs8r4DLsWlRmafH/cZLg0pZS2A06+u5IPRfKFvhPZPJlty?=
 =?us-ascii?Q?4scvSFV6cU1pc3gdQHoF4rmU+3sGgZ7kJPlzzvHTyI55QBGauTbarMoBYciP?=
 =?us-ascii?Q?GeqnRLz6HKQ/wE91qmvGWl9RlrBcrNTkloyTYCK+9T/hGYKnAoqDBPJmzos8?=
 =?us-ascii?Q?hNkHtkhRLML+tIuEIB85ZnEH28bLa0ZFXKfwifrqqMt8EtPpqI418ym0L8v0?=
 =?us-ascii?Q?xk/Q/3pdoZoWrtW3zbEs7+yt1/dRCaCQI/5Pr4ibxFGokLvkpI9ywxIPUNxl?=
 =?us-ascii?Q?xYw9ss+u3SDalUF9Jcb0F02RRYtran+dk4kjQaCGn8fs6+hgF+4W2OnB9hbO?=
 =?us-ascii?Q?6KGCl0kCd0W0olHbBzpnbkhPIQUUNcD7f630bb5FqRRvffWEE8bA0uIwrZgT?=
 =?us-ascii?Q?eIcqNTsX2F1691NIJ0PR/oo60dKiBZIch8XN+SaqvfWonr+715IkfqKCdq9X?=
 =?us-ascii?Q?hVGtR5ZbSM9IJTtx1ABV/xJqwdfr701yyl1EfPVkA5vKIJlKzbjn7lwFcxqJ?=
 =?us-ascii?Q?Ons1Ruw+L6w7XH7UWUG7zchLsRLrb6T1b+ftC6l4X4wjXXHESv/231knELL/?=
 =?us-ascii?Q?1CnnyLlzbVJYYbpYo82ZoeswMUc1nDiGzs/uLtBbn3W6MkB2TdwMrJyimK4B?=
 =?us-ascii?Q?y6cSlGG23lPZ6ekioSXs0J4/RSGiq8N9B382qLOkK/yeOcRm8xw/uCqGGddL?=
 =?us-ascii?Q?KhVJsHLdBPDlQDohWiAlqBZog6nJ2Z0zVqazTxZmrBXthtL2/Hrc7zLiQ9RT?=
 =?us-ascii?Q?dPUd/H/rXGola0FuWaPCij7xEAMhP2CZsgFBCbHwnbCcn8Uts9h0S8NETsFK?=
 =?us-ascii?Q?n6s3kJEhC/CJUchRg/5zSGSCRhASNe3TIiTuf9Xg2gBOWH/rVqqM9Y/gvo5N?=
 =?us-ascii?Q?bI1WWDYqfnUu6EIH7y8VS8pNqmI255SKFv/85An1uokSacr5XnTFGGwDYPll?=
 =?us-ascii?Q?0drRItRpHVTOH/MVVCX1g/Upxwde/O3uD8IejRVrYmGnaH31rxqBLtWsKC/3?=
 =?us-ascii?Q?hHyUkVkiuCw6q7RsikUA7dnhC/nzeJ/lfcRx1MueCeeXzIyoJdCm9DE6c0hd?=
 =?us-ascii?Q?ggJLvnoDdyRP3f9LJ/f1iBjgjvyglQ3HLgAbmEMebNlY37QL+MOzSL8oMk9b?=
 =?us-ascii?Q?4SftZHnJi67CSoBPbfYCCycyUCzgmp7knYFRgDlN5DCnFBo0jgyXVDFO5VxG?=
 =?us-ascii?Q?RS71e8z9N9YELxbww3GiO6AGRn1YXcC64ebX5cw2AA5rfqZe5Pej+SMKpGKC?=
 =?us-ascii?Q?DX68jqfwLoHv7tIPmmso29XqUHhUmeHNbbUVYY2HxcC4q2xoo0tTsLlHkT1D?=
 =?us-ascii?Q?0FHDsshiQg21xdu4NGKhN10zu/TEeHw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: b0LDr2KIqo5l3d4P1LUp7dZhX9ZAW2qhIeOtABOhJy0djtr+hGfTLETT0Giy+VnvfL+DxRyXCqoKMdA4V3L5C+JmUFVKGEebiXd2gFuxEIu82qZaZyVsKnliqWfPvRfriGLZ1AaCYKlVr3v4EtR8DrSCqgs555IZq5BqHSDmqduaifdEi4ZfizBgKjAci3pSiFR21qkvT8Z96P5Yr6AU3OqlsHMnpEbtqnz5O+44+F3izU4iaXP9o9Z3EkE5wayxOESeypLetnpdzt3SV4tUlTwpeNok+A5OvyyW/VfHw5xF3K4vdFEg2cYw5GfHxpvYEiZovxKbQl90qoVqYovk6w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df9405d3-99fa-4be1-25a0-08df1df321dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2026 06:30:19.1233 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TZqW23EX8QinL+etnPY4mGx+HCk1r3hdoh2QfycwHspFTcWSqUKI+GRtAPnRl7zvvnZgaT14dxVScfumHrhCwhibkWrtO/N+nIcBPSCI8nk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8484
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
> From: Ren Wei <weir@nebusec.ai>
> Sent: Saturday, September 26, 2026 8:23 PM
> To: netdev@vger.kernel.org; intel-wired-lan@lists.osuosl.org
> Cc: dsahern@kernel.org; idosch@nvidia.com; davem@davemloft.net;
> edumazet@kernel.org; kuba@kernel.org; pabeni@redhat.com;
> horms@kernel.org; steffen.klassert@secunet.com;
> herbert@gondor.apana.org.au; lucien.xin@gmail.com; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; jbrandeb@kernel.org; sln@onemain.com;
> fw@strlen.de; petalzu987@gmail.com; weir@nebusec.ai
> Subject: [PATCH net v1 2/2] i40e: validate TCP header before ATR
> access
>=20
> From: Zixuan Chai <petalzu987@gmail.com>
>=20
> i40e_atr() uses ipv6_find_hdr() to locate the TCP header. A successful
> protocol match does not verify that the complete TCP header is present
> in the skb, so dereferencing the result can access data beyond the
> packet.
>=20
> Check that the complete TCP header is available before inspecting it.
>=20
> Fixes: fd0a05ce74ef ("i40e: transmit, receive, and NAPI")
> Cc: stable@vger.kernel.org
> Reported-by: Florian Westphal <fw@strlen.de>
> Closes: https://lore.kernel.org/netfilter-
> devel/aq1HaYS96SNn7HJY@strlen.de/
> Assisted-by: LLM
> Signed-off-by: Zixuan Chai <petalzu987@gmail.com>
> Signed-off-by: Ren Wei <weir@nebusec.ai>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> index ef5e657816f0..cdac279b8aed 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> @@ -2911,6 +2911,9 @@ static void i40e_atr(struct i40e_ring *tx_ring,
> struct sk_buff *skb,
>=20
>  	if (l4_proto !=3D IPPROTO_TCP)
>  		return;
> +	if (unlikely(skb_tail_pointer(skb) < hdr.network + hlen +
> +			     sizeof(struct tcphdr)))
> +		return;
>=20
>  	th =3D (struct tcphdr *)(hdr.network + hlen);
>=20
> --
> 2.34.1

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
