Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC02CA5FCE
	for <intel-wired-lan@archiver.kernel.org>; Mon,  5 Oct 2026 10:25:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7386440647;
	Mon,  5 Oct 2026 10:25:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id orqRUjIV3cJ9; Mon,  5 Oct 2026 10:25:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org BC90E4064B
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791195901;
	b=W3qeRhRcdPgSH+jYbqiHCR/e+aqHeNTOw6RO0IJAe1KYaOAnh4dGO1CXn8/88mdwcb8E
	 mdq7clCzIeHY7Ajjr/cHUZFkZUrZWeTPiakfq0NJUyi4FDlAE2qvHbRHVgxGLLXve84Hz
	 6q4cOlkPfCJErbUS/Htzr9iWwhps/lUM3T55qhXs8Nwon5clsJTtzgQFLZPpxJfmUjpac
	 Flr9nJkHSK6qY+QWSTeiBrlAgKuKD323Ls+1M/kv/4SxdSg2lpnIuLgGf+CSfCtyQ7gnY
	 JzmTz1Vnp+AWvsLDiAonvrheBq8O1ruYWIS8dqOVJTAkTU5SwF6+bpW3+cTZ/ioasBA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791195901;
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
	bh=sn0/5C1CzW3urL2Gcasgyg0d4piD5GVdwUrrvIjhAXQ=;
	b=dHlUT88j6/Vfbsp7LNcLKHmZqmBZLKxdGxKwIIrsmQ7ZgT0oMC+3Rq7LvUBE+6LItvdR
	 7r5eft/50ugTDmo3KQLkzsvy4yqMAO2onnNpO6Z5l1xqGQ9tPh5hwoGzhan/ESFZ7Yjyx
	 dvERHKAy3BBFY4EQSQH7zcjBGr+z3FXn+AYb0eeFH6P452m0XFwar2lbpoPjs25+Uv3Dl
	 GRLiCTdR4U9z96MJvK4OyyZYmA1eMhpeGeo1034SFdxfrQrDmfShPteGDX3V/hfjdaNuy
	 0fJMIVq32v+wbZk8l80VwH1teeWBxFcVv+ZU1HljkWO/m29y5fX4yzbH4W3Nkl9US2w==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="O/rmvfa8";
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791195901;
	bh=sn0/5C1CzW3urL2Gcasgyg0d4piD5GVdwUrrvIjhAXQ=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vnORqzt2L3WHO2nrG/Oirv3ynwlxppWa6V+vMxG88zpJ2evUQSTSSxg3y9q5LCAA4
	 zY7reUAuuuhgqGwa18k1p9HMgIb5qvbBT9LKWBb75zfq7YjDOVZmPJd1wsW2sV39Eo
	 6b8p9bxXxq/qZZ4a3za8wVOxaltqo1GziAHT0/LKa44wvMK8rb6xmh1OYfMovy4AIZ
	 3E869wMVCnPRQ+NzVT1IOnNcnA6hjhrnQF0kScGqHn8LAc+MUnWQz9r8PX+YfR6T5y
	 qzsjH2goCHOGJrywindSQ8M+WO9eH4t54YvbOiXcb/zt5bVkzjO+r10gn1eT1kZ/HG
	 +Y0moVi8Gc9fw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BC90E4064B;
	Mon,  5 Oct 2026 10:25:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 773C12E0
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 10:24:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 689B84062D
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 10:24:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XrmUYloJHUyz for <intel-wired-lan@lists.osuosl.org>;
 Mon,  5 Oct 2026 10:24:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6AB044062C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.14
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791195846;
 b=VtpTvxD7napYLrHhQKtuWRUNo+eSae68+R2lpRAvYUjLj8VEqlRAjB9SvdBTNvPOzCcF
 0ifciGPds4UMXAfys4xEJY9GASXl53dMdaGNi8ZtAUmXuycdpmFICQs5mJBjytjnZUA2l
 LQaM7evZpiT6UGsuX2Aauyisk5v80lrfsRUD/jssXKBzMJZ753i56RHOEZKahheCkxHpf
 pGrptoUv4wjUbajr/ZoP4uhf9zLobdKujmvsEtEspHkJrlNx7PObNFQ6ejVYHwDygk43E
 mvIsLPfP8tKyWMc8Vru9GBOPk4CAbnsbKJMRp/0ORJCiM7TiXkW07v58frjSNM9UixA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791195846;
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
 bh=sn0/5C1CzW3urL2Gcasgyg0d4piD5GVdwUrrvIjhAXQ=;
 b=L9p7E/HbkMhqmEuptYJLpUNk3J6Y+0TImVARrGbqNpa1AKOCU3VhCcEIttb1AQNAt46b
 gNdHW5CbJtBc8TzITEmwD3+i3m+hgTbpwpgzYgQCU4WTq8fh4ZTtgEaUbYN8FTANLCwJ7
 uOGNMs2loE+HsqBpM0tqog/eRIaLIqoJ0QgKZ1Cy2xsft+kH46x/pltr25tSbDit9UDSy
 mczG8lZWn7llYzEGZf1zXj9zP6cr1BC5UUr58KAlFEY8h+7gQ6+uo7ODdldQa7jZgjmzt
 EI0/M2DhxomeXB5FXRj9XSTJSyTQMGuDZKTfKmuNKEEbyYk5oOd+DWza4qd8Stb/v7w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b="O/rmvfa8"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.14
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.14;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=O/rmvfa8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6AB044062C
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 10:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791195847; x=1822731847;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=+XnLtXKHy0a1tKl1vvLLy4QcrX/3Jat22UXfFDhsOWM=;
 b=O/rmvfa8PbtjBt+IO16LuiOwn0HQDjJX20Sar7+DcIoXbb5YLvQ022TV
 GVwLCnz2TQkdl2IFwc7MawcxlpDomlz7gAWQpOy0NeYHR37hd54C+Wu4d
 UAKq+buCXeCWD0SWPPhnZ7HuhDF7FMXtuTfyT6wPswABF6WIcaltc1fzJ
 rLF8ZZMxz4gLmvbJaS5XesMPi8Bugvdqvw+LCg5qBBHmBMvtOrUVS2L6A
 XXwZ0HkxssrMssOeqLgzxpslt9iz6MjJKqUtrWlQnd3Y4f5itGROaCrZN
 1PmIpTFpztntjc7Cor4WbNpteuuo9NgiXGilK9+jV+Ro0AB01HHWuN3Q2 g==;
X-CSE-ConnectionGUID: qKMpCH0US86SzVYzwVPoBA==
X-CSE-MsgGUID: NURpqYAFS4G3xBowvfV/8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11925"; a="91887679"
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; d="scan'208";a="91887679"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 03:24:05 -0700
X-CSE-ConnectionGUID: +hpH4t+wRfunGyMRouCzAA==
X-CSE-MsgGUID: Q5u/9Qi5QmyxsUUBk7XCAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; d="scan'208";a="276877740"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 03:24:06 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 03:24:04 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 03:24:04 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.61) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 03:24:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v+Dt5kEjnyXkhnlICnQyi9Or8t4i5GyPcuArRVsOhAtwvA1dMURNntO2FTKYT2J6SfHG2kqlAqEqqptxjxPWI1kYIz3RB2bLfJhbIrYiu+tXn4jOFpeUdSyYXcA0tht4wsCQfBFzgM/m77HsXtN8qQtsP+S92bwmGKXNOoOuqhJ3lANesz5N93Ibbvgy6QjxOCQYsbQTaaggP9CjWtKVvDG//mwqmmkdNLGMzI765i6h8XdQlFUyRbM/Nl8bSIXAfb0O+T8e+WSbW3/cKxmtL6NzNeabaHZDhzbBPpvZPDQVmLHwlvAZzJPdCipR8lecqQhscEPsf71w2WaUT7iuPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sn0/5C1CzW3urL2Gcasgyg0d4piD5GVdwUrrvIjhAXQ=;
 b=Cr1jxiHJ0JnFPsN7nJqRrkwoFmGlm8RqRMddkkZntLzj/fwvzqTKTTWF6lUeYTzOB2jBinModsEgz0OLtmElWwymnjZUYU25Gcb2PLxlxxPG06rbmDBS3s2vvXu54usDI9u4+P8ex6qp2pcM2sI1zMpJziDAptn4ETnArOsGoi4qrZUvU/b7Tv0acUbPVzh+Cg6xGhyaKvepBVz6OPPvLZc/TQzqYNDR05jY01Veu8m3gEkC4mphPzcys7ii4amJwAHF6MlhvRxrfbVXw+MZdwYpjsfi74jq2vbVVJwXl0zYmtV3E2LqGjD5YzSiU+oJoGZ/LOX5ItKIyc6NCNGCLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by MN6PR11MB8220.namprd11.prod.outlook.com (2603:10b6:208:478::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Mon, 5 Oct
 2026 10:24:01 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 10:24:01 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Oros, Petr" <poros@redhat.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
CC: "Oros, Petr" <poros@redhat.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Lobakin,
 Aleksander" <aleksander.lobakin@intel.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Henry Tieman
 <henry.w.tieman@intel.com>, Anirudh Venkataramanan
 <anirudh.venkataramanan@intel.com>, Michal Swiatkowski
 <michal.swiatkowski@linux.intel.com>, Jesse Brandeburg <jbrandeb@kernel.org>, 
 Preethi Banala <preethi.banala@intel.com>, Kiran Patil
 <kiran.patil@intel.com>, Dan Nowlin <dan.nowlin@intel.com>, Stephen Hemminger
 <stephen@networkplumber.org>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: RE: [PATCH iwl-net 01/10] ice: replay UDP tunnel ports after a core
 or global reset
Thread-Topic: [PATCH iwl-net 01/10] ice: replay UDP tunnel ports after a core
 or global reset
Thread-Index: AQHdUnCRlrRqvb+MEUGYh4NY7NdSrbbuwlkw
Date: Mon, 5 Oct 2026 10:24:01 +0000
Message-ID: <IA3PR11MB8986C71ECE278C137299773CE5962@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20261002130752.2597259-1-poros@redhat.com>
 <20261002130752.2597259-2-poros@redhat.com>
In-Reply-To: <20261002130752.2597259-2-poros@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|MN6PR11MB8220:EE_
x-ms-office365-filtering-correlation-id: 01d61a21-6ce6-45ad-b19e-08df22cac63f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|7416014|38070700021|56012099006|11063799006|10067099003|21046099003|18002099003|22082099003|4143699003;
x-microsoft-antispam-message-info: m6+SyqoDZ+vMmuu1Gfhp9Tvo2dRN53iRrUtNgQ0AcwWOobSwilGLwXqJZvUjX+DOHxWZqyxBfI8h22/IVs+4OEozoM6nSOsJPWhbeF4n0rpjDFv4ao4732F33CAbjvc9Xg+RJ3v0UIMrUf7FGg8NbG3BYoHNvEVy14vXskz8VoB3vZAy67n6RbL3scz4tzVjNxeMeIKxFOrI4A8xxJbOyMQBut6My5RePyfGqQ0a15IOrlwTUEE9lZQ2ahKTHOydNOuAsZSQGLK3NjJQVPZzJ41Ns/5/qGPo8xKwdnbyl0IiGUqn5hRkUJivXNuG6sU89gzRJxTWvJ02O7gcuA8n56d9QBYfHxFEMab+fU1YOE+4J/MLbPjQGisDBEBrS6paqHdM/tYv3PlQBfApGhSUUXfqHbrC6eHYktBU16NX17TMMPIVOwORF4S/W64UixWjP6BHS9eeqj8lAQ1RlRAYg9c7XiAWoon42MLr4uZXYy//N6bRREwYlI2AOu/9GVsX7y864vuqaBziHUZB8JORLgxk8GBx4szp3vuXIZ4uCKCEA8VBzJbiyJUI/C2d9QTGfcmALxwyg6pm+ecnitN/Mdnjr1XrArvZCq41Wjm7b6VZOV6dAqIzGEI8KItUexWV0jQ0gej2yS/Fl1b7hHwDIYfNEouEBDQaJi+v7vFL5Goo1wlsnnjsKl0FkLL3sWFgGxJKs35+D9frxZLV0AviUfhMLwqIXQS6kDXs9vdj7Kw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(7416014)(38070700021)(56012099006)(11063799006)(10067099003)(21046099003)(18002099003)(22082099003)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LWd4u0N6xK4IK+lsisRDnI43++ek5JuWOLE3hIH9nT97dmrGCzZlE7c7kycq?=
 =?us-ascii?Q?Mt2T3C3nkCctJvFUxPCyKzK4RucFzHfDnE7+5JupvjLTRDYFL5ezeFAFWIfe?=
 =?us-ascii?Q?wAO4IaRfvbsc619IWRukchFnNVVZeSRi6vBYMLxLKCdzK7y2hZ/CPaDZZJLL?=
 =?us-ascii?Q?DQDDIVlUh/VRZ7wi2ZM+AZNXV2A3n+VE3kvx6AE70GiDjOu6UHkwnuXbxtZr?=
 =?us-ascii?Q?PgA8iQCK1L3FtUqf1UpKHGsJVNjyrWqXjj4829LpEXT8VkGB6+UeLEMkU2Nr?=
 =?us-ascii?Q?ia61RR/NwIY4nsbSV9yB1AT5sWneHaTOZAVlQr9biAIEcMsQBbGiU+l0La5U?=
 =?us-ascii?Q?i73kqj2iCiKdMcqRJhTg36HTDiL/RPHKoxS8JGv6uHAc44xie82clL4KO4j2?=
 =?us-ascii?Q?CRaZYxpy4iAFCavWrK5jyP0kwS3zEhDiZwyJa9USlks330qlJXZUfPylTKBW?=
 =?us-ascii?Q?zdblArV2GhdSkariHSVQ0ZAy3YzGmJ/Xygtm9PjuQrIUBWDhzoQQIuqPxhm0?=
 =?us-ascii?Q?5sQtuTVRyDDJcwnG0IUFRvmPvGVsqNb0zQLxzYa53lvMXfVitbq5BpntZWD3?=
 =?us-ascii?Q?pHzlqAwHGBzOejlZEttlvNw0zU4Edgkyoz8D5KN+2rdGlGXMmNzhn8d07IQZ?=
 =?us-ascii?Q?PCOJyGLDBKE0eVUpbPGsRyIXINe/yiIjnYewssS7BYPDFMnrYrmlq2elhDTI?=
 =?us-ascii?Q?scvDmcKRtce2201/v5lb0RcQKmWKbzcf6Ko8WyQkTx4Bereta9mhMj38pYpV?=
 =?us-ascii?Q?7X+ZCDbnYQd9KjYizW7YT07skE4BuERrLW7uKt/ETlQ6W0IvQuKDD4nt2QwS?=
 =?us-ascii?Q?TmoidLrfJEcElu2HQyQ4KHi6V6cNUbDl18Oq2atEw8rtRzywqKG5GrK0k1P7?=
 =?us-ascii?Q?Pn4ZdRlPWKHVnkqEo0iVfTYdoPg+ZCgyoj2wSU66oO1lZmLL+LYN5lZeECC6?=
 =?us-ascii?Q?9gEPRcGKA9/jDx47X01pMw7WPoT8N7MndFky51Lj7BgtcI0VHyftkoTCSx45?=
 =?us-ascii?Q?DOf75+PSv3YLE0ycnq00lDvaEHr9cfjO1A1P73uP0WxafAXB0NkN47awxFUt?=
 =?us-ascii?Q?nEQ2IEsCigKDWx6IKbI7I5uAEg9WZ2dH7qjVMpgQX6BTfZDGkGNcUKna+ErG?=
 =?us-ascii?Q?CnvARPE3IuivOQix7bccyb2qWVHVna2Oyw3WmuwVMzqJEWasCqOGjvxkLlZz?=
 =?us-ascii?Q?QrtabhP6Cl6qrVf1j6jF/NjWtknBVuu8s6fmBuZb9vv4hRre+wtpQG8TIqgy?=
 =?us-ascii?Q?XdW+0sWRH0SmY0Qi22hPNs6xhtmLTCm7JLoNR8fOSiJeTX6JD51J3xs39lxK?=
 =?us-ascii?Q?/hOsokDhZk3Lel3xrsTufE5N45dZFR/B4LJqo4HtYnqo83iR/W5Q635ADaw7?=
 =?us-ascii?Q?KxT06kEeLzXJkbvIrGa0LOKQCIjjuUVkozlwx4lOKLV5YNJgNtWYWKofw/TW?=
 =?us-ascii?Q?pFpDzMDWvIjcefVuDo780Jv/Xv5OF8iG+w4FXtQoYuonhGD6p2aP0SsIKNs9?=
 =?us-ascii?Q?IwkjD/EpnsNj4vSa5sQ5K4TapVhkLJG+i2Huougby5BKd6qsc6BkfOGajym+?=
 =?us-ascii?Q?VBinsJVRDLnSkSorf6Satg4jTSR9xSWm2w8rz6YPoqkHuBYyGtR45KyfSq0g?=
 =?us-ascii?Q?FO3BlM4+aOMUCC90w+3Bt6vrEJ+YxMOq9qACQWnCo65A2z4BAXKx7u27a/wL?=
 =?us-ascii?Q?hbxZVW8qs+t2mvCJZet0ym5tFoD4QYtBJBIh9chNi/JbG0EV7+SoSnw+Kt7o?=
 =?us-ascii?Q?+pd3++mMWkPUxJ2JBd2tVttCyxnSeqo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: a17mXO5/fozQckgzFXleLs5zM0VKckGapB3PE4vkg1iZN19a+L3Axj1VVwz8Au0CelzIl/NcNoTkLBrxD+y/QVSBpk6BcSSLgmUPw4fk+jXPncfH6+Lf/SxPp60wad1bFcNgtzq1Ck3opp9EWRZp+26Z7/01dutRq6wxcd6CdWoHzZr5+jwLDSLuzx9iXIErFzn7LyTeeLE0KrbgoM7s1wFM+UWGWcA/a4XDiQZKnh8EI2OixyWYa/oMUXJAKjM2zMu0NBxlzk6t9iKZsCgCznNBP0iw1NQLjG1YDoiMBhCQNlNKKlnz17H+Y3BBroleadNJpvqXaEn7FHdBrzArAg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01d61a21-6ce6-45ad-b19e-08df22cac63f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 10:24:01.4208 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xVdJK0gFWu7cI6n+BjVZxWJpkdkxVUdebJFEXrH2zXjWw26PGB/Bn5H+trkDBQYmPicvQW1a9LXP/hRrZ2De+4z9YxGZxsi8sG52n9yGkvo=
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
> From: Petr Oros <poros@redhat.com>
> Sent: Friday, October 2, 2026 3:08 PM
> To: netdev@vger.kernel.org
> Cc: Oros, Petr <poros@redhat.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@kernel.org>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Lobakin, Aleksander
> <aleksander.lobakin@intel.com>; Alexei Starovoitov <ast@kernel.org>;
> Daniel Borkmann <daniel@iogearbox.net>; Jesper Dangaard Brouer
> <hawk@kernel.org>; John Fastabend <john.fastabend@gmail.com>;
> Stanislav Fomichev <sdf@fomichev.me>; Henry Tieman
> <henry.w.tieman@intel.com>; Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>; Jesse Brandeburg
> <jbrandeb@kernel.org>; Preethi Banala <preethi.banala@intel.com>;
> Kiran Patil <kiran.patil@intel.com>; Dan Nowlin
> <dan.nowlin@intel.com>; Stephen Hemminger
> <stephen@networkplumber.org>; intel-wired-lan@lists.osuosl.org; linux-
> kernel@vger.kernel.org; bpf@vger.kernel.org
> Subject: [PATCH iwl-net 01/10] ice: replay UDP tunnel ports after a
> core or global reset
>=20
> A CORER, GLOBR or EMPR reloads the DDP package in ice_rebuild() and
> ice_init_pkg_hints() clears hw->tnl, so every offloaded VXLAN and
> GENEVE port is gone from both the boost TCAM and the driver table. The
> udp_tunnel_nic core is never told about it and still considers the
> ports programmed, so the Rx tunnel offloads silently stop working
> after the reset. With VXLAN port 4789 offloaded, 64 flows that differ
> only in the inner headers are spread over all six Rx queues of the
> test port by RSS, after a CORER they all land in a single queue, the
> same as without the port. Removing the port later trips the WARN_ON()
> in
> ice_destroy_tunnel() because its table entry is no longer valid:
>=20
>   WARNING: ice_flex_pipe.c:524 at ice_udp_tunnel_unset_port+0x56/0x280
> [ice]
>   ice 0000:04:00.3 enp4s0f3np3: Error removing UDP tunnel - -5
>   ice 0000:04:00.3 enp4s0f3np3: UDP tunnel port sync failed port 4789
> type vxlan: -5
>=20
> Call udp_tunnel_nic_reset_ntf() once the main VSI is rebuilt so the
> core programs the ports again. A PF reset keeps the package and the
> table, so it is left alone. No rtnl_lock is needed since commit
> 1ead7501094c
> ("udp_tunnel: remove rtnl_lock dependency").
>=20
> i40e fixed the same problem in commit 1f190d936948 ("i40e: Reprogram
> port offloads after reset").
>=20
> Fixes: a4e82a81f573 ("ice: Add support for tunnel offloads")
> Assisted-by: LLM
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c
> b/drivers/net/ethernet/intel/ice/ice_main.c
> index 8c4b0fbc790644..f2121e79fca993 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -7859,8 +7859,11 @@ static void ice_rebuild(struct ice_pf *pf, enum
> ice_reset_req reset_type)
>  		ice_rebuild_arfs(pf);
>  	}
>=20
> -	if (vsi && vsi->netdev)
> +	if (vsi && vsi->netdev) {
>  		netif_device_attach(vsi->netdev);
> +		if (reset_type !=3D ICE_RESET_PFR)
> +			udp_tunnel_nic_reset_ntf(vsi->netdev);
> +	}
>=20
>  	ice_update_pf_netdev_link(pf);
>=20
> --
> 2.55.0


Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
