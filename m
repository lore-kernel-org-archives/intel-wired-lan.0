Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08861C5B56A
	for <intel-wired-lan@archiver.kernel.org>; Wed, 12 Aug 2026 10:32:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C2727811C8;
	Wed, 12 Aug 2026 10:32:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q4ydxuo2c98a; Wed, 12 Aug 2026 10:32:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 348B780F0D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786530732;
	bh=EutJ+MtQEeHidPNdFbp6qqfRAm3ruBv5knBMXDM+jfA=;
	h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=180TE1NxwtC8j/0PDsr7aEcd6O8y8lVPaSPrOgRGTbbxrZFYMHwfugW/23GSq7Xg7
	 v1ZR8r152VHE+6+roTp3YA6tjIS5dA1bYsArkdZ32jG79B0trlh7TACdkj5T1mcqhr
	 MkUU41OPo9If39AlMJFdxZf5SIk0i+A1zsHNy8YtrIbezjFpnerbVYKma5r4V7ZV+m
	 YVURJJTIrHnFK2lt2RHDJcOfVcsLcxYlJnPFYfm/ctR0PR298SAXFjRUfAkhataN8w
	 P0IPlu4y4IHTcFTP2VH0Ya7tzySibRT/wtt4dd1oge/P2gpi0grIsWnKtubmh/PQrR
	 oo/ogglSvblAQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 348B780F0D;
	Wed, 12 Aug 2026 10:32:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 62E22361
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Aug 2026 10:32:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5C156405B1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Aug 2026 10:32:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RAaULs2cLpI7 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 12 Aug 2026 10:32:09 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=sx.rinitha@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9779C405B9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9779C405B9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9779C405B9
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Aug 2026 10:32:09 +0000 (UTC)
X-CSE-ConnectionGUID: yHz03gQ1RVmp3/pqS7HiwA==
X-CSE-MsgGUID: 7Fa7BadETciV5oWs+7lCUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="112624473"
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; d="scan'208";a="112624473"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2026 03:32:09 -0700
X-CSE-ConnectionGUID: dTsrs4r7T3aGQGena95ykg==
X-CSE-MsgGUID: g4RJ4HUDSPKs9kiRPnH8OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; d="scan'208";a="260289176"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2026 03:32:09 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 03:32:08 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 12 Aug 2026 03:32:08 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.56) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 03:32:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JWvlba77FhEAR4Zid/HIsey6OPLeW0vXPydZEEUWeFevdIdVsCpBuB9KzYGdEXWCsIxwGWcjjtuRwbMyaeAvyHdDduZtWCKBhvNiWLA2sYv9RGyR7YheH5+RK4lGFsRngGC+8jk8vQK8iiRSggcIKtRbFBWlcSl6n4jVgBZM5DPlFrDsFL/1RftXQ1hawZHurZHya0oUEm3ZNTqhEqprfdBElONczFg7bo4nQGPXbK9Jjf/0YhIfZVmsQl/VwJHF8mwQKOmF5Rny3Qvi3N0ICXn/TMumBGq2N/FxzDCKErlOPJ5zJ6XWP/8SsdR95yt1mr7Hp0KdAJmrum+chuzcSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EutJ+MtQEeHidPNdFbp6qqfRAm3ruBv5knBMXDM+jfA=;
 b=ZD9x/ardf10Qjht72RKBkz4H/8Ogde1EoOrmIIyBW7rNQObNiXQr0B31qeTsiDym2InFVBV0whT5XcqY1GQGvT2p4Yx2FQ3QwvYEpuyf8I78p0EU38zUs2l/gk4RGMHginaI2EAgRYfrM98DQz27y+fGJNeFJxTacvJ8mcBl7RSci1FtkzUxyIUOenObo7hhD34e/WKKTP1UyghYLVitxpYY6qYrbVaA/mdSS25F4eZ41O0JIazAfLu5lPO8yvIi6CulydO/KET7oruDOWvTu+nbgV5To1+ODVOBK+4njFdGpXJNNQUlhDyWOoZ8bOydN8RstMj1HS1bx2h6h7Om6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by DS7PR11MB6247.namprd11.prod.outlook.com (2603:10b6:8:98::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Wed, 12 Aug
 2026 10:32:05 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%3]) with mapi id 15.21.0292.024; Wed, 12 Aug 2026
 10:32:05 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "Jagielski,
 Jedrzej" <jedrzej.jagielski@intel.com>, 
 "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v1 4/6] ixgbe: E610: re-enable
 LSE unconditionally
Thread-Index: AQHdCgYpHnBEh/w7t0a0r3ZhcgNY67aadJSw
Date: Wed, 12 Aug 2026 10:32:05 +0000
Message-ID: <IA1PR11MB62417318F09B207F7E837D838BDC2@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260702091553.57112-1-jedrzej.jagielski@intel.com>
 <20260702091553.57112-5-jedrzej.jagielski@intel.com>
In-Reply-To: <20260702091553.57112-5-jedrzej.jagielski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|DS7PR11MB6247:EE_
x-ms-office365-filtering-correlation-id: 6f9436a0-cbae-4f5d-cf42-08def85cf495
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|4143699003|11063799006|38070700021|56012099006|10067099003|6133799003|22082099003|18002099003;
x-microsoft-antispam-message-info: osflTBdR92aNwUaAB/x1yrkFiqyWixQtzZKc8ky8JX13pGvQIRMX7SmcL3+bhaKfcId027cPZMQYbzkR0iEapP+vZ4nICaJTfqpN6z3U22d09dOsKidkk4LyebpWReQJhgipfaJdD4ECg3OJ8j8e8TzK72v9fWP+ZS02bzEPGzKEX64qfj51xPLuaClmonUaVsZaeXGQmnIWuYWZcjD03T6/HQO1rSnpafw/TArFJKMMqKUxbif/fUxY0nPw2LFtXzmx0ktugoGqUmlnjDiUyFR0hfBlEKFzRqq5lvT3ggoUAK2GJaEDmtLogVfmJa7RWSrVGudMPxviCFvidX38MM+VO29Uhd3c5p+QSNfX4sJ8W1dg1K7UtSVupSHB6fUZvS0S4mBv3wZWzhi+ZXnOzjqJmsuf2OCbdp8oygkNmeeQMn6Cg7PE/RHGbncggvA14HXWOr3XIx+Xub+fJBCqptftII47p/PXsobj7PkNjoh0x1l0XBaaPIs7BzA2kSwX0P9AERmZhVFkQnWdNMbb3xzhRb/9bP+KYAOIufkpQydr/PCwtJEsCQatIMO9G/rDk/mHvinewIdG2vQUD42GShBDi387wtIjlcn98YentUDL9eccNGrXED8gk2hy0fOg1T/xQ+ClW3adXN3lNXcZnGvwA6rNO6ORMzPaiBGZZxZx3X/Df//lnkNldIbmI64mKzt6ySruTodvamhkNHSe4YIbh5QsPwt2Ic1K+BhWNSE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR11MB6241.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(4143699003)(11063799006)(38070700021)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XW7/o9rCGW4CTGM0/cScOVBusE/cldnrCXDwLGhMnCJjY7FvBBNI3w9+dhNk?=
 =?us-ascii?Q?cL4awvjD9Iox0ZfdNSiLSQKksn636EjjQTCkNzsXpw0ep4WDe9VEPsMgB3N/?=
 =?us-ascii?Q?mLvcZFRzvuOW0dcjRILO1QIGda7ZZmMMJ58JrTSgyafPGF1ZIZBmWYcugvwI?=
 =?us-ascii?Q?6Wm1o9CHOjkdGXBLkJN6pLTAo9qD3pfhRP053MI6oN5CinN9NR4GfSn//Zd+?=
 =?us-ascii?Q?g2Y0lKnfkuHCOEeng4TDQ+bIFVbIxGEqEdLsD91LyCX/pFjteQQ6T6soAay4?=
 =?us-ascii?Q?M1mwVenzniabpNHwft5gTSN/iGwlb3StH7sbyPLadvifz5e7Ae37ZMfwumoe?=
 =?us-ascii?Q?iJY7VH8N0C/tblF+Ihko7sygXnnQJ1aaJXxSNuJctoE5H+qcGGE6MCLkKOYQ?=
 =?us-ascii?Q?cgSMD8vx+sCoiE7e5/iFZaUhd+5atxpEbAPfvitDVOcMUB69T3NFa2aqWYq9?=
 =?us-ascii?Q?lxm5gcO2vjvTD2RRGdiqy1jMcbW1XO3qV2y3yOLu+SBfqkrP57fKun3bh63w?=
 =?us-ascii?Q?cORBEAsxQC2bkFIswtS0Qh8NfJVkTtCw8N2JIuUn6BjnxrmJ7DSepp6Ecp1g?=
 =?us-ascii?Q?GoTotI7+z0dGTK8UNkbZ+4ltQHH0FkKbUZ9xg3RF5/qwNQBY0HJuY/EtL3Zl?=
 =?us-ascii?Q?5u7Ic71oL//W+pV8Oxm/tc+SNVGti+yNmeguEoAj6lw2toQZ+HPZEWWVlNPH?=
 =?us-ascii?Q?oc0CHOcA4RjOc1tDe/W/9TmkyUNh1FQbKpE6PjiXeaXEvO3ltDdxoUG1Jipm?=
 =?us-ascii?Q?9L/b/VS7QFw0962Cx3rjSVfxM+x8ojYi395KJopqK2SjQm8b/WOUp06hRmXy?=
 =?us-ascii?Q?35sNJqpSIURrwuVpu7mG9e4wqWdfFwZkgpMxjn6F+0HPh7mpV9tyPfUE1Yue?=
 =?us-ascii?Q?TtO+z1DH+/pfz+XltvFEKUKe53u7clMvxP1j9WPvcEE312NIGmRDcuC55zKq?=
 =?us-ascii?Q?TpnFcTye8IKjrLBTP2LaX0TMqi9AHzC1zpbBDkbxLABBmsd2KglvQcLohQrn?=
 =?us-ascii?Q?AlRMC6RGzIgc/0DTD+VVdNS9TQt8+3aR/UpcraErtVWFtejddUWtUih2vZmm?=
 =?us-ascii?Q?iJNwIGxG+/kLUb+XDX7qMK+oDV2MAI7aTDURODLtVrUN6PRQ3i5twz1XgjNu?=
 =?us-ascii?Q?7KfvrVT9h3FhVXu+z32WywOnvOmkaysY7a9CwOhGLhzG+MBgZrE17G3B/DDV?=
 =?us-ascii?Q?OtINn+IaSiSLV0elHEXqSZjm1Em57XBphXWgJeN43Tke87Lsesu2iyXKDHbo?=
 =?us-ascii?Q?XSS63+0fqqtQD4suAwzpbxDwtWACtYTSgHwBxyR9cxI1/34YluLK7jE0EhTk?=
 =?us-ascii?Q?e51tiihccv3AEk7Q6shhPHepJUwGfkrQatEaIKBhxGq7huU0GL+cK1CTz99Q?=
 =?us-ascii?Q?GUbwd9uBVYeuluP+Lg7GQjP86MkYUnXkOmKode+i1lH3e2IHQdcpqUQuqlvZ?=
 =?us-ascii?Q?/TAdivpc4WGnErHRkzJEDS38nURgeXkJfMmXuoG+jjSy6pF9YbWySYpM6M8A?=
 =?us-ascii?Q?+vd9XUOqu4OJyWZP8VFSNEESsmwzuR0XDwO6SCZozHVUdWliBE4UTs/wgl8p?=
 =?us-ascii?Q?QksYgUB0Hzc6RtJTaiVoarqsu5WzMkjYJ8YKC71gc4uKvQZVJ7Gs+1qJ1GTD?=
 =?us-ascii?Q?TJ9veI87oLgteOmpb98tJTmKV+PniMOKV788r9u65kxMhuJCtSjbOQ0hoOOg?=
 =?us-ascii?Q?CrFsV9GbahQqT2V9IQexR1SmSTzh095cq2cJlYHLn4h/mS/H?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: VWp1OZcNm1i0y/yLqD6Q9wYHNg91flu8tJP/d8fKGq25LSzC15STQaMRtYqO9WmjnbtZGknBK0ijDwsO4pYhVd2cbfaPioA8qgDJ2i5LHMvgkia8VN5oC1cjwV311LP0x4Lg0vq+xoxwy9tUPyIHNno44vTnfxyeV7+ZR8a/Tu48i1TRv8dRZ7KwOi8udyxK+zhVXgI4oR+zJnKa/+Vja7He0XG/Wbvl6TICmet9pZuVvz18JvJzEhC9IFUQXm5nMSZU2qtjWo+l1MnfSqODE6XcU4auYs1SW04d+VutRRUkcZZ70FknHodBjUFra/yBYg060H8slot5x/Wmmfl/7Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f9436a0-cbae-4f5d-cf42-08def85cf495
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2026 10:32:05.7070 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Io17QAAvckMLY7nq5+CASCdbbE89oYYETt3dCgMT43Kw9Jo9OYGP8+rxW5nDI0xXkqYE2jb/wFIlZHjn59phjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6247
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786530729; x=1818066729;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=bfrbV83eyl4U/o+k1vnrQ41rl4WxGMUXu8ubbjyZB+w=;
 b=Wp+XNN86Ma5XzoX/FfmCmerwyB5H11xvnaKIDiL4UqBpOtRFYsehnlN5
 vnFdaIOeGbVJKkQ+Vv4QIuDvi9xLzzSGe6FHGOhaOXOXkbUWO3Jzz6pgg
 KR6aSIOkR5yLdoQhMHTN48mK3Akvn27jFWUxlJcQhv6SWKtCAkfPT9fdY
 bnPJ1xBdrvpf8+qSpKTiMG4o8awoaHy3cb2TcxTIHajjfggSHSQBhV/OF
 KWM3idxEfm1fohEZIH5KAweo7TzUyjHvL88DuM5kcF60qI7PDKCa0VUKP
 b61ISt0yQKha2T19OXBnJRPQMIIwtkepMnKtaZmetYBBZa4ZEdZnJcOjo
 g==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Wp+XNN86
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1 4/6] ixgbe: E610:
 re-enable LSE unconditionally
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of J=
edrzej Jagielski
> Sent: 02 July 2026 14:46
> To: intel-wired-lan@lists.osuosl.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; netdev@vger.kernel.or=
g; Jagielski, Jedrzej <jedrzej.jagielski@intel.com>; Loktionov, Aleksandr <=
aleksandr.loktionov@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v1 4/6] ixgbe: E610: re-enable=
 LSE unconditionally
>
> ixgbe_aci_get_link_info() currently allows to [en/dis]able LSE by @ena_ls=
e param. This isn't proper approach as this function objective is completel=
y different than toggling LSE feature. Creating such parameter was probably=
 dictated by the fact the flag corresponding for LSE enablement was placed =
within the ACI command used by the function.
>
> LSE should not be switched off while the ixgbe driver is running.
> Current driver behavior doesn't provide such possibility for the user.
>
> Enable LSE by default whenever 0x0607 ACI command is sent. Such change co=
rresponds to the fact that FW disables LSE whenever new event is triggered.=
 ixgbe_aci_get_link_info() is a part of routine handling LSE events, so it =
ensures that LSE remain enabled.
>
> Remove wrappers utilizing @ena_lse param to [en/dis]able LSE as they are =
no longer valid.
>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
> drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 25 ++++---------------  d=
rivers/net/ethernet/intel/ixgbe/ixgbe_e610.h |  3 +--  .../net/ethernet/int=
el/ixgbe/ixgbe_ethtool.c  |  2 +-  drivers/net/ethernet/intel/ixgbe/ixgbe_m=
ain.c | 23 +----------------
> 4 files changed, 8 insertions(+), 45 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
