Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667F8606A329
	for <intel-wired-lan@archiver.kernel.org>; Thu,  5 Nov 2026 17:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=0+PfG4un;
	dkim=pass (2048-bit key, unprotected) header.d=muni.cz header.i=@muni.cz header.a=rsa-sha256 header.s=selector1 header.b=pds91FXp
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 44D7F81138;
	Thu,  5 Nov 2026 17:09:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DdMcStIvb-FH; Thu,  5 Nov 2026 17:09:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2C6148116D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793898549;
	b=GuSZjZ3/x9fYRXK/HjEzK1C3nC5R4nWyCktPbgdcWtDQJ9zqxCNG36dtJNFjr2Zcy8U3
	 ZFmoCJ9uoBQ6JXvjoMsbmmRThenQEwGpn+ZzoT6nO7Z/MZ+mZ/hfT9pg59S1Zi7awDTvn
	 8O+bthmdyWiNmYPhje9ZMtfuV76XI4A+v9O/axVtQxbrsqpkUyVrhsyEZCi365gROzDEI
	 jNrE8MjZKthG0PDNqc359o8AVgGzahsh4i35Au3saPsKQJtZKw9e27VbXeP8+0neXsGys
	 ZjoznGf8xuRxzY4a59yAcFcXX94vvJ0aQY9pquC5nT/BU12wY7HPpgLOsR12wWxN/mA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793898549;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-muni-spam-whitelist-from:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:MIME-Version:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=TJUFZt8gyY1yybmJFpBSjnHXIOuQSUN6L3pZvOe1uP8=;
	b=G0QnZ4Nq05fqxVfp6oxtlI2zuBuNjsEo7LFvZARcLeMPLwRjbPOY8/lx5o+bxP8/kZDJ
	 IVSBz0dKRtnXrbOn5+QrnKtbQJLZhA2GgplqIK0Ek2NizOfvMundoriwQcSPwA7100kZz
	 r43wLGBoNvfo+NfIZnlCBOtFEtmtQtLcSLoJDJhGocXZMcpkkDtv2Klk1BDa1uhOVodZB
	 6Ht3c7YaZmS7U/PZyFCmB+S3FH4YGCRtCosLfV1uaP8I8KNUOHhEiHOZAR2lxQFhSlsr7
	 xCGwZyDuMRpcbAbeGZEofGIHSXmsZZzqmrdwkCCRsTY+PzWSlLUPY7TPmMJPmZ3zsyw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793898549;
	bh=TJUFZt8gyY1yybmJFpBSjnHXIOuQSUN6L3pZvOe1uP8=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=0+PfG4unHHCUqWD739UDmjL4mEl21ON0C/IITnp4b4DIfHUOXAB/HoDi73FOVw8Wb
	 DNe12o8OvUGiglqqDLU/OoleGQ9ZkioXUDoZdFOvU7EJ57lfdrgK/MuV4vbSE5ifZP
	 3jNdPQWi0yDmqbChPCznQ+eV+cq343eufdQsg7bDaD1g57g8Mf7CJQYvIyyIDfh0xL
	 +DBk8FndYjBCObAVSkf1TbaNIEi/WtKmL8k7149igqUWKWvixdD6nBom4kmWNmrPZ7
	 i2nGpWAL0/bh0d+fEB4QHLWpXZQ9azxqr6FyAG+wy/RZhE1HHYQ5FcC/ClXo/LyapK
	 +N/lEYd4ZsMXg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2C6148116D;
	Thu,  5 Nov 2026 17:09:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 53FD852B
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Nov 2026 09:05:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 39DBE607D5
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Nov 2026 09:05:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0fkgUJa5HO2F for <intel-wired-lan@lists.osuosl.org>;
 Thu,  5 Nov 2026 09:05:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 89F0E605D6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=40.107.162.111
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.107.162.111;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=241000@muni.cz; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=muni.cz
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=muni.cz header.i=@muni.cz header.a=rsa-sha256
 header.s=selector1 header.b=pds91FXp
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11023111.outbound.protection.outlook.com
 [40.107.162.111])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 89F0E605D6
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Nov 2026 09:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=muni.cz; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJUFZt8gyY1yybmJFpBSjnHXIOuQSUN6L3pZvOe1uP8=;
 b=pds91FXp68xxYYIUEv6ZMYlY8ymusnJCj+48Xq13LriSNHn+yUdY9HDSh7XdCG9yTxPtceqpUTdMwGusaJFKVJOQLUAeerTUTuiYWYJUXZi7/HjnAoFID+wfiRbn46a5Df+9i2/DhuAd8rwhPWIub23GR1khduRVfff0kUcxmfj9Vgnv/Q07LGjx3IojMxui5P0djWI1gJvniKxkZA5ejhG77SFQrzMRxGLbQBLqD3tDcSzCi5V8YTepmsnUenu/F99ZxXgCxL8xJAzQS1basXo/nNFaSzpRWdaSEWEAbBo+Ki6VYko/GsJ9gvR4+GHrNphT3z5VB1S2bA5xuaGSVQ==
Received: from DB7PR03MB4601.eurprd03.prod.outlook.com (2603:10a6:10:16::17)
 by AM7PR03MB6420.eurprd03.prod.outlook.com (2603:10a6:20b:1b4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 09:05:19 +0000
Received: from DB7PR03MB4601.eurprd03.prod.outlook.com
 ([fe80::424e:3796:8a90:ae43]) by DB7PR03MB4601.eurprd03.prod.outlook.com
 ([fe80::424e:3796:8a90:ae43%3]) with mapi id 15.21.0592.007; Thu, 5 Nov 2026
 09:05:19 +0000
From: =?iso-8859-2?Q?Dominik_Dvo=F8=E1k?= <241000@muni.cz>
To: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [BUG] ice: rx_bytes inflated by up to 4 GiB per XDP_DROP (buffer
 length read after libeth_xdp_return_buff())
Thread-Topic: [BUG] ice: rx_bytes inflated by up to 4 GiB per XDP_DROP (buffer
 length read after libeth_xdp_return_buff())
Thread-Index: Ad1tA8vFXhdI4PwrSAq5n4Z3HWy2Fw==
Date: Thu, 5 Nov 2026 09:05:19 +0000
Message-ID: <DB7PR03MB460158B90A64D025962670E0D5772@DB7PR03MB4601.eurprd03.prod.outlook.com>
Accept-Language: en-US, cs-CZ
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=muni.cz;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR03MB4601:EE_|AM7PR03MB6420:EE_
x-ms-office365-filtering-correlation-id: c742d3e8-674b-466d-e7d0-08df3b1beab8
x-muni-spam-whitelist-from: O365
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|6049299003|786006|366016|1800799024|38070700021|11063799006|56012099006|261021135927099003|261022075727099003|261009223027099003|261022105027099003|261026121527099003|261026140227099003|261028144727099003|10067099003|18002099003|4053099003;
x-microsoft-antispam-message-info: 4v1PvKGUekwLmQ0IqwJekts0Y6V6H9vk7ytnt1UjhCCp90JpbQ3fm1fj3bZRnik8rhn/DiBDRx5sKxdRoPVjhIG2lktEWNGMYAOoByKjHeLPWx+dGn8Qg/U9OtRq8OftUGPSgYEIVnstYaBoUWdGt7wfBofnVLKi73yHFDksR2vlKbl8Npk8M8hnpfOxV+M11rp1U67SVbmmS8zfH7FBDlWsE797DRC0oZEk4WADU/lNp8BCUAuLTAPCwA2upboVDE/+ObDbEZ29bWv0DzZK0kP0Vk0xSNbdB54c1FsglKWacuhwQQzcS9XnpnPtLRo/GXRNu7nMipxsVPHbmXCzpTMU2wg74s0xWbHzbO2+VLbqKjsofRmlr9jX6uMqB9neLAvIeHUxiQHBWdMqSuxdP0/MrvzAzNLY4MXJHiVdmS8uYVSXmUxlOcGk6Ogt4psU6YsxR7N89G9YH5bBisTIvgnDtgYIMwdNAJBXCk7iq4E5f6HSkyrDjjHIF1Elt5lN7LkewChcp5WdHP4WCwVswistls8N+f6i/aydt/cxA3Ls3zJtJ5jf73u+rIqKRvOic8vJKgF+lxXq7NEvbtq0Y+rUoRtKEevtwh42+xdmTFeSbskdPi5reN6vMLKaMgtjvm3ntKYSjl1adGVoBP5BM92Wi2fGuWbdiCOmUJ8c7JV/0C1u0nKjsf2lu6X1iI7C67g5ITRu9Il/hiK0cr+q9Z5sG6pEF4ZCE31xJ9XMB+o=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB7PR03MB4601.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(6049299003)(786006)(366016)(1800799024)(38070700021)(11063799006)(56012099006)(261021135927099003)(261022075727099003)(261009223027099003)(261022105027099003)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(18002099003)(4053099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?KSHsY4G7eCdUmgh4rsG0gykI6YRD4mL6Oq6MaXEi9AvBEYR7amHttZWn35?=
 =?iso-8859-2?Q?1/Nc3Cl/XXxZoX1qrb94skNjabUVkN7oLVfMQKKh9Qp3QUQRHUN2d46Aml?=
 =?iso-8859-2?Q?k6ShpF5YKhWJK/yYEf/MpZKG8MlMfln0kvkcb2zopOEcIz0l7DFsuO5gTh?=
 =?iso-8859-2?Q?KWC6RBBIzD8z2z3Gagi6HC2LhPB647KsX2/Fe01xhFexJ3QQrIOmvk0OOd?=
 =?iso-8859-2?Q?RHH2Fjji9e++OvVtBFqoZWdBEhWKkdTzxm2v8QUSUQgwU6hDoLvFw7G3pd?=
 =?iso-8859-2?Q?iaMHVmFGMpYhhdsNO14QrRXU+rlpC9YgkDVeAji5QzEoNsP9EsTpKsoX61?=
 =?iso-8859-2?Q?fzt7ff3HOs8j0/0JycECKpmhHRloFuZdDea1ktLJNOzX/c/Itkoh+f6fXj?=
 =?iso-8859-2?Q?ldhlKWKY/WoeMYnWnEZQUtiqRX/2vCWbo+je8js3KDX4aS7SPH9iODbGrg?=
 =?iso-8859-2?Q?iyb+himFzjqho/qeab197kJFzHkV8hgCTr92/DQbWZoAojdflVWbG3fL5Q?=
 =?iso-8859-2?Q?j9yQPvNd038AH92pwTimLvQ+GJ2eByx0Ks3TgYUY91fVYsCe9ArYNBQ1tQ?=
 =?iso-8859-2?Q?OYZoxcaPG0IVttQOlW4LR9tdDxV0di38Mb09oIa4CuzrnbiLhMeBTLgcGf?=
 =?iso-8859-2?Q?ViYvYPNXhky7teeLiQc1fxWJRG2tSHh/0ZecpFw8FEJF9VYZ1YUedGpanQ?=
 =?iso-8859-2?Q?LD1lla3KILQxgebioxAPTolA0jeoWzyFXTwDr+vKwTSbDkdka7zguaVtiJ?=
 =?iso-8859-2?Q?JUKdPH/w2Rp9PJIov/wgQi9bqEISUateB1AbfsVsYK/0FSBiEnHcCe7few?=
 =?iso-8859-2?Q?yN+C2rudBobOuvUvHK0vZ9m526aRWlmXekd0kONZSzd/un5vDi8M5qajdc?=
 =?iso-8859-2?Q?C0CqD7YOVWb1fxZBKFEpms7jXHjj/703NiH/QN8skpDytilrqZbQbagEOc?=
 =?iso-8859-2?Q?CSRAO8hGcIURDf8JAl+RGezJ8z8SBXKLU0OGuB1KucIDCNJiGgOcNco9r8?=
 =?iso-8859-2?Q?Hgem8IOj76wHKYdlCp1fcZ/85aTS0/vJzwjD//qdeKmCds1HEE+LkaZgQV?=
 =?iso-8859-2?Q?OIQUbNxkGY3nvDAN0vrL22zIwv+qfqfv08aKukcwnNrDNmZmvjtK4Uesn/?=
 =?iso-8859-2?Q?VrYGpUMui0YLNvznQWXgyX0J2MQ8ijPm2r3dZnDHlxH2/qDwGk4j+jLmlN?=
 =?iso-8859-2?Q?TbIzZAim06mgvp9XduOR+PZb91Z+wtP9aZUbECBo9D6cDqSvIzF24dCwIz?=
 =?iso-8859-2?Q?vAOI+VWVucETFNLsOQfkQ0X3dx6x9wzyOcc4ae3rk5i/dqRQcwN+COfcFf?=
 =?iso-8859-2?Q?6kKbYVPu1mXkskD6cEHn7e+7uU5cWv7cHCQZKxb/Pa4NCKaFd1CNrDAhXN?=
 =?iso-8859-2?Q?3vUHPjOB+cI4lx2L32Of+DlnrSBKFt5fAcc5Nf+C6McVyZiUILZv+uA7Oy?=
 =?iso-8859-2?Q?019xUDEKgOwmYSwbgemSUM2i1jhHTSHneJdvkNNoCZknEvza8x+kQvhQLh?=
 =?iso-8859-2?Q?7UL9AsCxU7zKETYvX3tB/2oGZxqKKmobFxOrK9taNkxe4x8+thXeK/dgjW?=
 =?iso-8859-2?Q?p9tFeduQyfeHZQY8yXfOICSeTzDG0ggvsUV5UmXk9UbwXNzKg+awDQ3FHv?=
 =?iso-8859-2?Q?MqNaVcr8q75MOp3T1d23VWjxfemQwX1BgHXLX2Ffv+2QFHON8hy5bNUwYc?=
 =?iso-8859-2?Q?Fkgoiib2PJIbx3sZpD75/qnqLV+Z/KaquTUH5Jg3QpAxK6EPl/UFejvNJ/?=
 =?iso-8859-2?Q?5GqOoJCb6r0V/9VSqu+n9yl1eueGCTIakiE/E4AJW2Efcx?=
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
 micalg=2.16.840.1.101.3.4.2.3;
 boundary="----=_NextPart_000_0092_01DD6D0D.29041A00"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: muni.cz
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4601.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c742d3e8-674b-466d-e7d0-08df3b1beab8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2026 09:05:19.7505 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 11904f23-f0db-4cdc-96f7-390bd55fcee8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vyHoRV50VNwh02SoFlHrgxD9+/x5ZMBzwVJNMcqUjI6rewickNk+k+6JZjPLLLWN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR03MB6420
X-Mailman-Approved-At: Thu, 05 Nov 2026 17:09:07 +0000
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

------=_NextPart_000_0092_01DD6D0D.29041A00
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

Hello,

after upgrading the kernel from 6.8 to 7.0 (Proxmox kernels
6.8.12-34-pve -> 7.0.14-26-pve), the software Rx byte counters of an =
E810
started showing phantom jumps of hundreds of MB to several GB. Each jump
is exactly one packet. The cause is a length read after the buffer has
already been freed on the XDP_DROP path. The bug is still present in
current master.

Setup
-----
- Intel E810-XXV for SFP (rev 02), FW 4.30 0x8001b891,
  DDP ICE OS Default Package 1.3.43.0
- in-tree ice, kernel 7.0.14 (Proxmox build 7.0.14-26-pve)
- 2 ports in an 802.3ad bond, native XDP program attached to the bond.
  The program returns XDP_DROP for blocklisted source IPs and XDP_PASS
  for everything else.
- 6.8 kernel with the same HW/FW and the same XDP program: not affected

What we see
-----------
One sample, 1 s interval, ethtool -S plus netdev stats:

  rx_queue_4_packets: 76843 -> 76844        (+1)
  rx_queue_4_bytes:   32920496416 -> 33701427810  (+780931394)
  rx_bytes.nic (HW) on the same port grew by 2222 bytes in that second

Only the queues that receive the blocklisted flows are affected (3 of 16
here). All other queues show normal bytes per packet. Every jump is
smaller than 4 GiB. 780931394 is 0x2E8C1142, which looks like the low
32 bits of a kernel address.

Root cause
----------
In ice_clean_rx_irq() (drivers/net/ethernet/intel/ice/ice_txrx.c):

    xdp_verdict =3D ice_run_xdp(rx_ring, xdp, xdp_prog, xdp_ring, =
rx_desc);
    if (xdp_verdict =3D=3D ICE_XDP_PASS)
            goto construct_skb;

    if (xdp_verdict & (ICE_XDP_TX | ICE_XDP_REDIR))
            xdp_xmit |=3D xdp_verdict;
    total_rx_bytes +=3D xdp_get_buff_len(&xdp->base);

On XDP_DROP, XDP_ABORTED and a failed XDP_TX/XDP_REDIRECT, ice_run_xdp()
has already called libeth_xdp_return_buff(xdp). That function frees the
buffer and sets xdp->data =3D NULL. xdp_get_buff_len() then computes
xdp->data_end - NULL, so the low 32 bits of a pointer get added to
rx_bytes. For multi-buffer frames, xdp_get_shared_info_from_buff() would
additionally read skb_shared_info from a page that has already been
recycled.

This looks to have come in with "ice: switch to Page Pool"
(93f53db9f9dc). The old Rx path did not clear xdp->data on drop.

Proposed fix (untested)
-----------------------
Take the length before running the program:

--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ static int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
-		unsigned int size;
+		unsigned int size, len;
@@
 		if (ice_is_non_eop(rx_ring, rx_desc) ||
unlikely(!xdp->data))
 			continue;
=20
+		/* ice_run_xdp() may free the buffer and clear xdp->data */
+		len =3D xdp_get_buff_len(&xdp->base);
 		xdp_verdict =3D ice_run_xdp(rx_ring, xdp, xdp_prog, xdp_ring,
rx_desc);
 		if (xdp_verdict =3D=3D ICE_XDP_PASS)
 			goto construct_skb;
=20
 		if (xdp_verdict & (ICE_XDP_TX | ICE_XDP_REDIR))
 			xdp_xmit |=3D xdp_verdict;
-		total_rx_bytes +=3D xdp_get_buff_len(&xdp->base);
+		total_rx_bytes +=3D len;
 		total_rx_pkts++;

With this change TX/REDIRECT count the length before any
bpf_xdp_adjust_head/tail. If you would rather keep counting the
post-program length, the same thing can be done inside ice_run_xdp(),
before the buffer is returned.

The root cause analysis and the proposed fix were done with the help of
Claude Opus 5.5 (Anthropic). The symptoms and measurements come from our
production firewall. I have checked the code paths described above
against the v7.0 source.

I can test a patch on the affected box. The issue reproduces reliably:
each XDP_DROP produces one phantom jump.

Thanks,
Dominik Dvo=F8=E1k
Head of IT Services=20

Masaryk University | Faculty of Economics and Administration
IT Services
A: Lipov=E1 507/41a | 602 00 Brno=20
T: +420 549 493 183 | M: +420 739 487 807
E: Dominik.Dvorak@econ.muni.cz



------=_NextPart_000_0092_01DD6D0D.29041A00
Content-Type: application/pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgMFADCABgkqhkiG9w0BBwEAAKCCJXww
ggWqMIIDkqADAgECAhBVUvge2xskLJ67lhjNAig+MA0GCSqGSIb3DQEBCwUAMG8xCzAJBgNVBAYT
AkdSMTcwNQYDVQQKDC5IZWxsZW5pYyBBY2FkZW1pYyBhbmQgUmVzZWFyY2ggSW5zdGl0dXRpb25z
IENBMScwJQYDVQQDDB5IQVJJQ0EgQ2xpZW50IFJTQSBSb290IENBIDIwMjEwHhcNMjEwMjE5MTA1
ODQ2WhcNNDUwMjEzMTA1ODQ1WjBvMQswCQYDVQQGEwJHUjE3MDUGA1UECgwuSGVsbGVuaWMgQWNh
ZGVtaWMgYW5kIFJlc2VhcmNoIEluc3RpdHV0aW9ucyBDQTEnMCUGA1UEAwweSEFSSUNBIENsaWVu
dCBSU0EgUm9vdCBDQSAyMDIxMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAgdtXQpAs
dDX0+Lh0GU2rCVp3RYFzYrA1n/jQtzMAhxO2lqsOVBIwB7ybt0jX0RmDro7YqfGpAISwjF6e6AyP
VGm/9tQITyZw/hhBYxqzMotA+AerVzHwxhZ2Z5q03S/y0WvF0JKEkXFuDy5j6R9TpN1SE8wJgymB
DMVTdUSxDmdTGNDDH4hLn5QktCm8u+hO/W/SFR1J3I1w8hEaIFFVEbqIb8T3UHnWqjHihD1eMsh3
KlBx5Qsv6bbq76sKMzkO/Y+lZ0OCjphpCQkbQM04Z0fqyeyXcRLeJPVyPNH3Q0wm95CyielFS1U9
MQV6QeKVukPAF8W2hT0ZjWRw81uszZ/TKXWHS5Vnaqb40d28kIaJQympN1v1XbAmWlNCdpArz55W
bCtUz1yaZd9bi0hgOHz7xQvPdgRjAjMqffWDZ+f6xkP9Kw/UJi93pDLBJOpknb+zOHExRPJHuKJm
QaH7m3u8x0Zqdb9aoozoakTBuJa1wDIILXt0NXOyysb+rxFyGPbnyMLPpSrqe9ZZ6HygsmpACWkO
pZbb0QC58YhuNvCIsp3xUvLDfL8wiTwKafkipGXhm+B0xrGFl5YsrpSPUKY5Eh++R/KBeNN1Np59
WiCX4lKumZ/GfJtm8/7Yz+69lwYdLYXcPjZTlnsguujI4a2WYj4RfLMAhJ6nTHGrSjcCAwEAAaNC
MEAwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQUoNYHPV4k93ugRC4kUg0ZqisEkacwDgYDVR0P
AQH/BAQDAgGGMA0GCSqGSIb3DQEBCwUAA4ICAQANR/kJZjFS7HnuwqjyaD7tlkXLOqaYYz/qK01O
A9AcguHL0+XWq1tnKLyd/gyZCoBVp84bI2ENsFfw/uDKvuaQ24MsvoOO9Hm2/tANQqdYH2nqgfUF
pf5GaOtseMng6ufm3jHF0tUsgmMonV2oGn6I5ucr8SzV0AWe3C29N2bUBKKnrb86wqg7rf+NnTPg
uZqEoYcfdvSCdNcO+TBIPluIPqpca9YvDOiOc8IYkYM5tmZa0B9gJ11N4/Y6DWZQnHh7q/MTEK4P
L6voZLMYIJ1GNWQlc+qbEFxYNYmxRkin9KzUHZ5bzKmlGhNPJFCq2RttsUD7nd1YdMTCbxRy7Ns1
n7hUdUXDpsgaKDU6rmXyqZjOr1vJOIwxO3/M3Jb94lvW0Fn0droLy0+DEMdA0B1g6SrlSFh3DEVp
vhlxBCTi4yQfSsjBPpn1lpg4SCWhFbAb1+KEGFv2cTWaaHtAzBhcDCSd1JX1mapG6q6sv/QUGSTo
jOzj9bwGaIoqDAVfCpd1p9x+wP3XehjfMNE4Sx+wmHC/zHxz8G7EMaWklx2sv85sIUq+JyNn8wZW
gQqRjrbhAwUzLNo0CE1OUCOtH6XF1Hr+6gnspyhgi0Z8teqb3U/552sVxojPQ9vlJ9wEVm5vRhXx
Vi3oXAxzwyOBOCDLyQxpzyyrO4RgMxlS/WkUMzCCBd4wggPGoAMCAQICEAH9bTD8o8pRqBu8ZA41
Ay0wDQYJKoZIhvcNAQEMBQAwgYgxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpOZXcgSmVyc2V5MRQw
EgYDVQQHEwtKZXJzZXkgQ2l0eTEeMBwGA1UEChMVVGhlIFVTRVJUUlVTVCBOZXR3b3JrMS4wLAYD
VQQDEyVVU0VSVHJ1c3QgUlNBIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MB4XDTEwMDIwMTAwMDAw
MFoXDTM4MDExODIzNTk1OVowgYgxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpOZXcgSmVyc2V5MRQw
EgYDVQQHEwtKZXJzZXkgQ2l0eTEeMBwGA1UEChMVVGhlIFVTRVJUUlVTVCBOZXR3b3JrMS4wLAYD
VQQDEyVVU0VSVHJ1c3QgUlNBIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MIICIjANBgkqhkiG9w0B
AQEFAAOCAg8AMIICCgKCAgEAgBJlFzYOw9sIs9CsVw127c0n00ytUINh4qogTQktZAnczomfzD2p
7PbPwdzx07HWezcoEStH2jnGvDoZtF+mvX2do2NCtnbyqTsrkfjib9DsFiCQCT7i6HTJGLSR1GJk
23+jBvGIGGqQIjy8/hPwhxR79uQfjtTkUcYRZ0YIUcuGFFQ/vDP+fmyc/xadGL1RjjWmp2bIcmfb
IWax1Jt4A8BQOujM8Ny8nkz+rwWWNR9XWrf/zvk9tyy29lTdyOcSOk2uTIq3XJq0tyA9yn8iNK5+
O2hmAUTnAU5GU5szYPeUvlM3kHND8zLDU+/bqv50TmnHa4xgk97Exwzf4TKuzJM7UXiVZ4vuPVb+
DNBpDxsP8yUmazNt925H+nND5X4OpWaxKXwyhGNVicQNwZNUMBkTrNN9N6frXTpsNVzbQdcS2qlJ
C9/YgIoJk2KOtWbPJYjNhLixP6Q5D9kCnusSTJV882sFqV4Wg8y4Z+LoE53MW4LTTLPtW//e5XOs
IzstAL81VXQJSdhJWBp/kjbmUZIO8yZ9HE0XvMnsQybQv0FfQKlERPSZ51eHnlAfV1SoPv10Yy+x
UGUJ5lhCLkMaTLTwJUdZ+gQek9QmRkpQgbLevni3/GcV4clXhB4PY9bpYrrWX1Uu6lzGKAgEJTm4
Diup8kyXHAc/DVL17e8vgg8CAwEAAaNCMEAwHQYDVR0OBBYEFFN5v1qqK0rPVIDh2JvAnfKyA2bL
MA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MA0GCSqGSIb3DQEBDAUAA4ICAQBc1HwN
z/cBfUGZZQxzxVKfy/jPmQZ/G9pDFZ+eAlVXlhTxUjwnh5Qo7R86ATeidvxTUMCEm8ZrTrqMIU+i
jlVikfNpFdi8iOPEqgv976jpS1UqBiBtVXgpGe5fMFxLJBFV/ySabl4qK+4LTZ9/9wE4lBSVQwcJ
+2Cp7hyrEoygml6nmGpZbYs/CPvI0UWvGBVkkBIPcyguxeIkTvxY7PD0Rf4is+svjtLZRWEFwZdv
qHZyj4uMNq+/DQXOcY3mpm8fbKZxYsXY0INyDPFnEYkMnBNMcjTfvNVx36px3eG5bIw8El1l2r1X
ErZDa//l3k1mEVHPma7sF7bocZGM3kn+3TVxohUnlBzPYeMmu2+jZyUhXebdHQsuaBs7gq/sg2eF
1JhRdLG5mYCJ/394GVx5SmAukkCuTDcqLMnHYsgOXfc2W8rgJSUBtN0aB5x3AD/Q3NXsPdT6uz/M
hdZvf6kt37kC9/WXmrU12sNnsIdKqSieI47/XCdr4bBP8wfuAC7UWYfLUkGV6vRH1+5kQVV8jVkC
ld1incK57loodISlm7eQxwwH3/WJNnQy1ijBsLAL4JxMwxzW/ONptUdGgS+igqvTY0RwxI3/LTO6
rY97tXCIrj4Zz0Ao2PzIkLtdmSL1UuZYxR+IMUPuiB3Xxo48Q2odpxjefT0W8WL5ypCo/TCCBfQw
ggRcoAMCAQICEBo/pq/lUJN6aUAia7ZT3qAwDQYJKoZIhvcNAQELBQAwYzELMAkGA1UEBhMCR1Ix
NzA1BgNVBAoMLkhlbGxlbmljIEFjYWRlbWljIGFuZCBSZXNlYXJjaCBJbnN0aXR1dGlvbnMgQ0Ex
GzAZBgNVBAMMEkdFQU5UIFMvTUlNRSBSU0EgMTAeFw0yNTA5MjkxMTEyMDFaFw0yNzA5MjkxMTEy
MDFaMIHSMQswCQYDVQQGEwJDWjEbMBkGA1UECAwSSmlob21vcmF2c2vDvSBrcmFqMQ0wCwYDVQQH
DARCcm5vMR4wHAYDVQQKDBVNYXNhcnlrb3ZhIHVuaXZlcnppdGExFzAVBgNVBGEMDlZBVENaLTAw
MjE2MjI0MQ8wDQYDVQQEDAZEdm9yYWsxEDAOBgNVBCoMB0RvbWluaWsxFzAVBgNVBAMMDkRvbWlu
aWsgRHZvcmFrMSIwIAYJKoZIhvcNAQkBFhMyNDEwMDBAZWNvbi5tdW5pLmN6MIIBIjANBgkqhkiG
9w0BAQEFAAOCAQ8AMIIBCgKCAQEAtZkV6QKM725/AhoWMFpFNtRgceAdOoeHZKeME4SryX95allw
33irdn6ZKdwtJTauYtnerx3BIR/YqnCwhMdNQkGnAlmvXHvsi3ANsKXhSF+yGryeViGiR4GaOVEI
0SjWhaoDXEDPeZtgHKBtnPBrFHt7JbeSJ0k/X82Xo+dhCfoBYwjow4HBdmPdUz5bZRa4XyC35Lbg
Dc0GqwRca/2163SyTdAQGv/0gFKpBiJ5pd4TL2UiW5AjrvfyUYQ58ziko468zib8R7bd8pdbMHN3
v3sQmiRYvRH+JPie2oCu3GXgtpnFpbZL2ffALV41lY8Wg0qB+QRVuBLKGwyGpqGeFQIDAQABo4IB
sjCCAa4wHwYDVR0jBBgwFoAU67IvO/2uAswqRAZdJc0dEiJosEcwSgYIKwYBBQUHAQEEPjA8MDoG
CCsGAQUFBzAChi5odHRwOi8vY3J0LmhhcmljYS5nci9IQVJJQ0EtR0VBTlQtU01JTUUtUjEuY2Vy
MEsGA1UdEQREMEKBEzI0MTAwMEBlY29uLm11bmkuY3qBDjI0MTAwMEBtdW5pLmN6gRtEb21pbmlr
LkR2b3Jha0BlY29uLm11bmkuY3owYwYDVR0gBFwwWjAJBgdngQwBBQMCMAgGBgQAj3oBAzBDBg0r
BgEEAYHPEQEBAgQCMDIwMAYIKwYBBQUHAgEWJGh0dHBzOi8vcmVwby5oYXJpY2EuZ3IvZG9jdW1l
bnRzL0NQUzAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwPwYDVR0fBDgwNjA0oDKgMIYu
aHR0cDovL2NybC5oYXJpY2EuZ3IvSEFSSUNBLUdFQU5ULVNNSU1FLVIxLmNybDAdBgNVHQ4EFgQU
++KbU94vtKCkt0dHUT9gI8KQa+wwDgYDVR0PAQH/BAQDAgWgMA0GCSqGSIb3DQEBCwUAA4IBgQBf
h/KenULJDA2G6pwUyS352BJwiZNHmbTo+yaBNUIx2SuXft8kOEjO7LUBCcRsasphTMHgZTp9BKpi
maKApD9tzwLxSJgssDYLBrbaSuzkLqk2e8MEezgCXssxnMkYm1W8Zgyh2vESs8huEQLwxkDlYgNT
8NsAdv+2ardXs83fr1XvD83cSrL6JCDsn0r4nopMNHTMk+a1RjbJlZdpAi+Y3vrY+rxs1CrBGqqr
qnDFjcTHUYYVuM5DVq2K853JcYai5cYo8YMNhrX8s3QIwypopNE84z93Qcd/gCHkuRfwJKwgSePl
ftF1yoHhjIbnFbnoTpBfXLkmbTD454oJ+EMV+UaiXxEtBM8Os+B610Kd3EvdCCRaLj+WfjO4u7ku
qghJvn8A5WXv0dsxHgsa9GRc4DmbZkveM0BsgF2HOw/sEZS6OSu9kVxDuOsSvTiWUElOEIF0dBBh
5Bp/OSrvxPbuw6zs3PhdvvH00XNdwVi502KcNoBuxj8XMwaP5JWNfEAwggZEMIIELKADAgECAhAV
+a5sqo0u1NNveH8e3HsBMA0GCSqGSIb3DQEBCwUAMG8xCzAJBgNVBAYTAkdSMTcwNQYDVQQKDC5I
ZWxsZW5pYyBBY2FkZW1pYyBhbmQgUmVzZWFyY2ggSW5zdGl0dXRpb25zIENBMScwJQYDVQQDDB5I
QVJJQ0EgQ2xpZW50IFJTQSBSb290IENBIDIwMjEwHhcNMjUwMTAzMTExMzA4WhcNMzkxMjMxMTEx
MzA3WjBjMQswCQYDVQQGEwJHUjE3MDUGA1UECgwuSGVsbGVuaWMgQWNhZGVtaWMgYW5kIFJlc2Vh
cmNoIEluc3RpdHV0aW9ucyBDQTEbMBkGA1UEAwwSR0VBTlQgUy9NSU1FIFJTQSAxMIIBojANBgkq
hkiG9w0BAQEFAAOCAY8AMIIBigKCAYEAq7hur/5vIqMejblfPfZgGY75auSZz5SZ9x1dIIjvJrDB
T0lIwQcAAoABJomkuv0kDK362UH+uf9JrOdLBjiKkEh99HQPmT+d1+Ijnnd1aAjiL+2Q4aU16P/s
nITYJL2ROU46zqmDkdoOnCqMCEKSN74gHKDmApYfqXO8wmjmNA62wYHarp7lxgrBr0sk4BxHyKq5
2z0sWyxsdIy5V1K5OOkCNwYupZ9b74LRhelYP5SieNDqU0S6IpQOasVz5IS0vDnqVi2ni67Gbgtb
8dBKzH6gbAwGppHoeEFDcvJ042Oxtxt6BGolkUmguyfAgeisRqDjhQi+NfNgkDH81OLBV0eV07tw
S9axwNvJAtH2SgGiWKrYeuBgVCzs1DFT7sws1KHyLrOdZU0hJQSDfoz/8jwFmXhWoPvQQuWEoo3u
vH6LsHAo53aDF1aAUmGQ/JC72j7zZH16leJFuWj+t2TK/7YEVHtWluA9TOdx2Lz/SHh0/+pAVicD
4N/QUWPuBhzPAgMBAAGjggFmMIIBYjASBgNVHRMBAf8ECDAGAQH/AgEAMB8GA1UdIwQYMBaAFKDW
Bz1eJPd7oEQuJFINGaorBJGnMFAGCCsGAQUFBwEBBEQwQjBABggrBgEFBQcwAoY0aHR0cDovL2Ny
dC5oYXJpY2EuZ3IvSEFSSUNBLUNsaWVudC1Sb290LTIwMjEtUlNBLmNlcjBEBgNVHSAEPTA7MDkG
BFUdIAAwMTAvBggrBgEFBQcCARYjaHR0cDovL3JlcG8uaGFyaWNhLmdyL2RvY3VtZW50cy9DUFMw
HQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMEUGA1UdHwQ+MDwwOqA4oDaGNGh0dHA6Ly9j
cmwuaGFyaWNhLmdyL0hBUklDQS1DbGllbnQtUm9vdC0yMDIxLVJTQS5jcmwwHQYDVR0OBBYEFOuy
Lzv9rgLMKkQGXSXNHRIiaLBHMA4GA1UdDwEB/wQEAwIBhjANBgkqhkiG9w0BAQsFAAOCAgEAO964
RfbcPCuTKAq2wXsOZxMaaLxITbSOYkt7RMxPw3CzU2qmkTQALKbVqC1jUiNQWbkxZpsb8hy9FOHy
wH1xFmANAypks0Iuh+ovhqP90oFcfhvAfYxV2M0cGga9mTKFHP+QET7HW9pZdyWFZAw5fmdW9Ex+
IQmJii0w/sozzwhpVn0OQYkkRV+2ydRa68JZS2NqAPpdaWoseM2X4u5+Jn+H2UO9paobX+ht91K2
Ch8xzfREv4RLqBgpHBmkIDVygXNdXsKfDHy2hOXxtF6oI1d7ErPGWoBxFc86aUqQlC6pEjb3ug24
w+eg1kJj7IufHJ3iRm67Rdw5M1OlWMzxu+DwAKqFJhqes0OL/NOJOTuDCb0bIfVfjl8U0Y0QWCkh
oCmNPZQQu6QM6Y/XxnALgRB4drA8kip98wSZQmbqptE8oac2ZzLKCHiJlTdBuREsundnpBXdahMS
rJ/mYv2pMZLpYkbrkvyhorDVeH9t0a5UgPIFqGl8/ZzakJ3RQfr7HvdGur0YWU6KNWvY5BK8qHMR
M0b3XtK9xREIGEychAVReodDIhjrR4fWmjpa006r/UrmSk4bpKrVFVzTYsSK3jy4ri1ExVQp6RI6
Ou4ZdbfwOYCuI9wweMjpVBuqNzRKrVU/Pvp57gUzm4u+JJRkdioMOoxZrwsUiYr2KIojwTcwgga+
MIIEpqADAgECAhBrFefKeFkgsf+oF6QMLp5+MA0GCSqGSIb3DQEBDAUAMEYxCzAJBgNVBAYTAk5M
MRkwFwYDVQQKExBHRUFOVCBWZXJlbmlnaW5nMRwwGgYDVQQDExNHRUFOVCBQZXJzb25hbCBDQSA0
MB4XDTI0MTEyMTAwMDAwMFoXDTI2MTEyMTIzNTk1OVowgb4xCzAJBgNVBAYTAkNaMRswGQYDVQQI
DBJKaWhvbW9yYXZza8O9IGtyYWoxHjAcBgNVBAoTFU1hc2FyeWtvdmEgdW5pdmVyeml0YTEOMAwG
A1UEYRMFR09WQ1oxIjAgBgkqhkiG9w0BCQEWEzI0MTAwMEBlY29uLm11bmkuY3oxETAPBgNVBAQM
CER2b8WZw6FrMRAwDgYDVQQqEwdEb21pbmlrMRkwFwYDVQQDDBBEb21pbmlrIER2b8WZw6FrMIIB
IjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAmdF5yNyFIPCHEQ36pdQ7nzx4uo0m8cYS32Yi
OqLELbNeDo089Ze389ARoxrZkRH75FuCM0bcVwf5qY388Se2dT+RMFj3Dn3G34/NA7oYXUansUnp
zAQmw/EcN0JhxJtYDr6yy3DFzoJn/u33dATwOqEcqMcbRqyOhr9t0mxF0yocCiFJKxD9j3TQP5Qh
IBFy13U0tMr9qmrIYsu75ScpmFzrGqip13yaZQUweWvsdjveKtgHo9pJmWqirfBdpO0nOpa2NxB2
FDJCnkIHlVLz5GvCNcTyeS6DLlV25RWDS6Rw3xaDHg0OCO8vUdA8LjJ2K2Atqcrtr+fz95H4GXfE
lwIDAQABo4ICLTCCAikwHwYDVR0jBBgwFoAUaQChxyFY+ODFGyCwCt2nUb8T2eQwHQYDVR0OBBYE
FAWA66WHxVro9mdtCoeejwlTHlwXMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMB0GA1Ud
JQQWMBQGCCsGAQUFBwMEBggrBgEFBQcDAjBQBgNVHSAESTBHMDoGDCsGAQQBsjEBAgEKBDAqMCgG
CCsGAQUFBwIBFhxodHRwczovL3NlY3RpZ28uY29tL1NNSU1FQ1BTMAkGB2eBDAEFAwIwQgYDVR0f
BDswOTA3oDWgM4YxaHR0cDovL0dFQU5ULmNybC5zZWN0aWdvLmNvbS9HRUFOVFBlcnNvbmFsQ0E0
LmNybDB4BggrBgEFBQcBAQRsMGowPQYIKwYBBQUHMAKGMWh0dHA6Ly9HRUFOVC5jcnQuc2VjdGln
by5jb20vR0VBTlRQZXJzb25hbENBNC5jcnQwKQYIKwYBBQUHMAGGHWh0dHA6Ly9HRUFOVC5vY3Nw
LnNlY3RpZ28uY29tMIGZBgNVHREEgZEwgY6BEzI0MTAwMEBlY29uLm11bmkuY3qBEzI0MTAwMEBt
YWlsLm11bmkuY3qBDjI0MTAwMEBtdW5pLmN6gRtEb21pbmlrLkR2b3Jha0BlY29uLm11bmkuY3qB
D2Rkdm9yYWtAbXVuaS5jeoEPZG9taW5pa0BtdW5pLmN6gRNkdm9yYWtAZWNvbi5tdW5pLmN6MA0G
CSqGSIb3DQEBDAUAA4ICAQCeuzxVmXn1BeYabBQzDddKcs+yfLN4uiew03f3i2kz+pSzfBpazdcQ
jHBiKF83GinMq1LGLQBklcyzKw3oi5EeCZj4GHhUgpNcC8dXnsjNjuTg9wqRB1iPlNPHwEi3Z+5l
dldDaAL9VkWnbGUKi9sBQI5JMUb1r+5mPFQAnMsavfqKKGdwRInFyHPFJOTRlnLoHpbdE1zTbZat
jz8lkj8KHMIODl/c7AyGzszubKTUqTjNoXJvWplg6gWDF/3VDWx+CAVXIObMvjoickQz13UZ83jA
hcmZXACnQtLihbZ3VwWfnb2V7koiUU3RGX3PZguWznPhN1pc0YYEeGRFYQAXhc7aMTPZKVRvUH1m
x1EvMJ5ds5QIqIiihS6ueDstiy2YwB3XFYUaNgKVF/h7DEDwBcru59Fc3ebPU9n+FKoaa3esVcCO
SReAEPy3ULdlqw4mTJkDPZMAmK/wvyjdGDNZPdj3/ylmNVFrIYw6kE1ygIHECWvDVcpqaLa81En+
ZBgPfpVRdkdAbd92FR7lMFwLJFH85c43qoGHWjdhWnvwr1TaKTM14/pGnr1grbc56+f2IHFjWttk
UKaiFwSwtzc3w/LtqUvdCUWHg0GKjXXJYa1DM2CuF/XnYHWszprtja1HNRCrieGEkww3Y3WCzkDU
HaVpngkObKTZIS6j2k33fjCCBuYwggTOoAMCAQICEDECcNQ1vpskmvhW0OHihUkwDQYJKoZIhvcN
AQEMBQAwgYgxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpOZXcgSmVyc2V5MRQwEgYDVQQHEwtKZXJz
ZXkgQ2l0eTEeMBwGA1UEChMVVGhlIFVTRVJUUlVTVCBOZXR3b3JrMS4wLAYDVQQDEyVVU0VSVHJ1
c3QgUlNBIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MB4XDTIwMDIxODAwMDAwMFoXDTMzMDUwMTIz
NTk1OVowRjELMAkGA1UEBhMCTkwxGTAXBgNVBAoTEEdFQU5UIFZlcmVuaWdpbmcxHDAaBgNVBAMT
E0dFQU5UIFBlcnNvbmFsIENBIDQwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCzSuIi
Xidb6QRbFAQ1MiAUrrTSMUDGzVDAHqFEyq+eSmF/LZDeYpszai2kQsqWATz/cBA9gGjunvJ45G48
ycC4D6gwZFvbBt5JotxlunBeB8K+crGar3v+RCQ4VfvToX07v+HTJ6EeEONR3IzJPTMyzgAwENGs
AWf9va9HePQFJiChCzXqhKpp0zen53S+8f9itEy06GS8aku7Mvyb4tMBBa9An3Y3ALIqIeymg/iY
s8m9WkSkMyekNtFRB1+1KlnNUpM05G8+sY9EucnQQRUIdHzYsvqjP3XlaSuB4Jj0ia66UGfi5Wx3
1mm5sKAz8Re9UGVWIqq6wKFKxkSfuO4iwYiIPJoiGEux3dqabwFLduAroDF1IxE40PqGIdPXzYuZ
/wL6BEfFAb0xy8bfm5S9G7y/ts9mIlFpPtkLZ/nQ/iVOWdsu9ale/nK/uGF47xsxeW2LIvB4sH5U
2+D4ad8vpNbcCrXIXXKtkBnNHgxumNNZ0R1Isq/Pz7TALCxxDzWdsM7AO32/Jn7R4ldtGRZmKpJy
fACDn8HU1QPhOtiWsjifrMWnanJhQ6K7M/5qz8BmfPrca+MUrr1Y4NHZb9MrgPtWKQQyGDXy+G5F
/iHGdZk7LS+F8NH+Ddolt2wZpz52JqGMTDPIH5Qok4LLO95wbxtn+79Tw+wQxmDTuIg+LwIDAQAB
o4IBizCCAYcwHwYDVR0jBBgwFoAUU3m/WqorSs9UgOHYm8Cd8rIDZsswHQYDVR0OBBYEFGkAocch
WPjgxRsgsArdp1G/E9nkMA4GA1UdDwEB/wQEAwIBhjASBgNVHRMBAf8ECDAGAQH/AgEAMB0GA1Ud
JQQWMBQGCCsGAQUFBwMCBggrBgEFBQcDBDA4BgNVHSAEMTAvMC0GBFUdIAAwJTAjBggrBgEFBQcC
ARYXaHR0cHM6Ly9zZWN0aWdvLmNvbS9DUFMwUAYDVR0fBEkwRzBFoEOgQYY/aHR0cDovL2NybC51
c2VydHJ1c3QuY29tL1VTRVJUcnVzdFJTQUNlcnRpZmljYXRpb25BdXRob3JpdHkuY3JsMHYGCCsG
AQUFBwEBBGowaDA/BggrBgEFBQcwAoYzaHR0cDovL2NydC51c2VydHJ1c3QuY29tL1VTRVJUcnVz
dFJTQUFkZFRydXN0Q0EuY3J0MCUGCCsGAQUFBzABhhlodHRwOi8vb2NzcC51c2VydHJ1c3QuY29t
MA0GCSqGSIb3DQEBDAUAA4ICAQAKBU57DY8fEzkA/W/sYsbD7e0XquMBzHjcP0eXXXRD4EAEAGCW
Ss+QRL9XIxmx+52zx9wMa8YTejlR+NKejiyKPTF0q63zMxrO/z/hUwo8IDcRRLS0NSgvTW6AN2rC
XJe5iLN5fIfYgIBB9cy1L6trPuZ/vjUJm87nQ7ExQzGqWN5F9U8MlAk0c5iLanG7GCMoNjHiF1n0
baj6guUeG7n5qcwOQTyDS19+NEqfwjUPUGasN1ZH8h1sE6PrzvRpti+rKzWpiU+i2/k3l2b5fFDy
+Wu9jv6R9BoBh47es/UMzwEZ2kSrIVVr4jSukk+FpmR5ZbtwiYNAV6sdb1srMGsILzXlrdasSE2n
GHvZklk2zUdgn7b01MHq67g0mNozGmT6Dam41Kbhv25WMFs871XqwVIb4gGoT1yRf/VePMm1jwau
qijhKJFvrNweGnebGPeipaLxIo2iEA4qdRztEg/qyzWGogXK/TFdmivg322fMPQWjQkMhRGMM8SC
jlZN22L8x0ZOYoVA2rHJm5P25IjZe+HPyn7ikJiSJmqlqFmUeowXF3D1dFlCCs/5yC06RYRqI2RE
Fu+28t2nswIvY6xCFAR0RtS8Mz2yXNld0js2MmiRUGrc7imWzdUPbPcv9sdUF7SsERGPIzYL8dIi
Hzit+YCoGCSXMg6peF37hHNp1TGCA50wggOZAgEBMHcwYzELMAkGA1UEBhMCR1IxNzA1BgNVBAoM
LkhlbGxlbmljIEFjYWRlbWljIGFuZCBSZXNlYXJjaCBJbnN0aXR1dGlvbnMgQ0ExGzAZBgNVBAMM
EkdFQU5UIFMvTUlNRSBSU0EgMQIQGj+mr+VQk3ppQCJrtlPeoDANBglghkgBZQMEAgMFAKCCAfcw
GAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjYxMTA1MDkwNTE4WjBP
BgkqhkiG9w0BCQQxQgRAk+KDeV1WgeQvjqVYTsrvS3bMAfo4ow2bKbIxU/yIVrqvb6gs4H9JMpgr
JVzm3JavIWI324aXQqMrhfkwnZjKkTBpBgkrBgEEAYI3EAQxXDBaMEYxCzAJBgNVBAYTAk5MMRkw
FwYDVQQKExBHRUFOVCBWZXJlbmlnaW5nMRwwGgYDVQQDExNHRUFOVCBQZXJzb25hbCBDQSA0AhBr
FefKeFkgsf+oF6QMLp5+MGsGCyqGSIb3DQEJEAILMVygWjBGMQswCQYDVQQGEwJOTDEZMBcGA1UE
ChMQR0VBTlQgVmVyZW5pZ2luZzEcMBoGA1UEAxMTR0VBTlQgUGVyc29uYWwgQ0EgNAIQaxXnynhZ
ILH/qBekDC6efjCBkwYJKoZIhvcNAQkPMYGFMIGCMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYw
CgYIKoZIhvcNAwcwCwYJYIZIAWUDBAECMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAL
BglghkgBZQMEAgMwCwYJYIZIAWUDBAICMAsGCWCGSAFlAwQCATAHBgUrDgMCGjANBgkqhkiG9w0B
AQEFAASCAQB1q4e7ErKaQabwpgACTWOOxIevBhAYSYXGsIGXZ6fweGvqr37EySdD8SW9z/gX4rNM
579hqe98jAbn2V/qwUhkg6EQk1hnFBz6qLa0C5BNlJAKHDDqN8kL/YXeV0+++6RP9E7SVeD8jvtD
JOF0Pm/4sH445SUVrVJQYzQSMm9bXxgNtJ2o/sX2YCPS6R6o+dP1BEx1DeLIm1mZ2cj8su/IZdoI
S3D/N8+COcLx/Mq19+vy7toLyw4sAmq0ojfB9ZS29FfO19uKBu2YxzGV2oFPBbqmEs84eYcI6FNx
crsR//ybdCgg8VTh65jXQ0Eu4RRfj/Gvzg9m3I4LSIKA4sQmAAAAAAAA

------=_NextPart_000_0092_01DD6D0D.29041A00--
