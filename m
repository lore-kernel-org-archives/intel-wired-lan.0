Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3A4606A32C
	for <intel-wired-lan@archiver.kernel.org>; Wed, 28 Oct 2026 08:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=VNazyF3/;
	dkim=pass (2048-bit key, unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=gG5mgoNR
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7802480E22;
	Wed, 28 Oct 2026 08:35:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EYGSncf3MC5u; Wed, 28 Oct 2026 08:35:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4990480E18
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793176511;
	b=pSyAbFrEcwOIUm4jJt/M4nipUUJBD4f8eipuKtkOLsJ6DwD5kyNTtndmMpcLeKl5y9cA
	 VnNAFRnCjCENN4T5sXw0UXUsaNq91X6tNDGmMr7p3az4ccBLnxOCkflnt6BcHznzBafGe
	 OBbybA5o8Gx5UIAxdi1oebmLIMG0c1idHsrZD9qRB97Z64liUNVtSL4PLz6EdvMSUq961
	 zLSTGyYVWfHnsMddOWabtKUZwQ1zNUEipHsUAPmQ1hXKjJtJ1iVFkrmdglZ6WByprPgDt
	 nBdqesQraV72PCiNnRXwXG4tRlmkCkCZZLg0YXelxYT8tC8IAmyyyAKpvalBKW4jejw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793176511;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:Feedback-ID:
	 X-Pm-Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=4od7Sr2E6qFuyNeg8F4/VjgHxNRfB5PEspoSjeOV7ho=;
	b=oP6rRQPQKTNRH62qfdW5CqxVqs+QK6L8QEQQjurx5UMUI6iVIP26WSxovO9vQ7JqRwi2
	 HE4cnAabJ9gsaLEfLHhKfAB0qyMne0e/zanPh5jpRdnYMXxsMihQB6G48JAHYNV3e3sNn
	 Jjl8kjAI5QX04WjlwaCYuQlH2WY2/exEhvR/b5ckT6b8C4TJnBuMEqyR1x5XjaQejza1u
	 fIyL1N1Nqs/0x+lg+LCh2BgQytZQDP1yqfIcetrgaUP8BdlylDDgvJOPqh9IDpRgMAQ+g
	 k7TCZU2htPTYyzmTYxdExw2XOeEu0ckwJqFNkjd1x97kYfgCMZQ4+Gkx6W8xz3zXOFQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793176511;
	bh=4od7Sr2E6qFuyNeg8F4/VjgHxNRfB5PEspoSjeOV7ho=;
	h=Date:To:From:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=VNazyF3/pg9fZ5W1+WY6Dqtraoy2kCsIFLFpUuUZnV8w7kJNNBiG03LUZ0nWXdpN4
	 nH5CyyoZ0lJkoD4dF9EKkObKhMYp1241+aSCkQb55nUuJO4akzbvFtgj/yD4JO9UJD
	 rCjmJkXdaJixxhIU7+ft4gh2mg0UeJJgfigM7ee4a/XPC6XMgQLtDCLP9wRVuEzIdh
	 U0uGQoX6DBPeiftr/jmBMHY8BWT/PzqftY6n6A3p+iwoybA8U6o3+QjxAL600kQfaK
	 YTGvvnqNm2Ioq6O//B3K1/2OC2G+9yIorltKFO6Om0mZH+eGt7aYFQ57zZ3SwCSmsj
	 5JFag3KyPFmAQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4990480E18;
	Wed, 28 Oct 2026 08:35:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3F42D972
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Oct 2026 08:35:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3115460658
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Oct 2026 08:35:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LfFl0nZwNAiH for <intel-wired-lan@lists.osuosl.org>;
 Wed, 28 Oct 2026 08:35:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 271AB605F1
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=79.135.106.100
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793176508;
 b=FwtPSR3Rh8O/R0YslmuEX1yfRDXMmACPjZEnNh5fknTB+bS5Xcr8zX33UuhBQfxWpaQf
 u1JZvBp9PksXNGXwgpYEH1f8Mrxws5G9wuJdSCWUdinIh3nz8mLfTF79JrCYY0sXiSv2k
 WGsUnd1OIWdIE5aq9f9AMORUfQArVO8WEzGDjwND0tjwcx5+z3mUag1cUFqyUT5UVZ4tQ
 lj7KDIowj9Ly8WX9CDWx+LAdHwBaKWYz9FrdhD5jjNpxRoWW/CJa7f//3NYpkRchZfoVA
 A9zm3xb8cwI32624n2Lr35VRTurxRK9Z5oTbQhR8MO9Lw+15f62jTd+f1OeMMUjERjw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793176508;
 h=X-Greylist:Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:
 Message-ID:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=4od7Sr2E6qFuyNeg8F4/VjgHxNRfB5PEspoSjeOV7ho=;
 b=Ql1k1zdwAawSDiMwisw3KQY00w0FeMzqP6xTDvbsxj5vAOt0y9S6iTKnpunAJktXJ5Hp
 QA9IsXe1FLeENBq3rmyuF/3Nh8CIWCfRROqcoburM98oZUD8VfMtz9hEWX3dEQaN+1zS0
 MqZUgC1UDCPhDeB0z8efFt4C/kuourDkiNPrgCoLctW9DlAoXefIG4Uq5ScGMLchaIusH
 Q/wVnYrHE1NfsYmgSlrOzY39jZtaVOrAl6bBNC2Ze7FQjH6boUZ3PCaiLuR2ketAYwrgn
 unD5mp0+UVRs8YfnbzEuA2MkvTUyuFl8/TxaW55Z/XQcpvoNHiOjQEslX4qA6aNLLjg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=1g4.org;
 dkim=pass header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256
 header.s=protonmail header.b=gG5mgoNR; 
 arc=none smtp.remote-ip=79.135.106.100
X-Greylist: delayed 170329 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 28 Oct 2026 08:35:07 UTC
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256
 header.s=protonmail header.b=gG5mgoNR
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=79.135.106.100;
 helo=mail-106100.protonmail.ch; envelope-from=p@1g4.org; receiver=<UNKNOWN> 
Received: from mail-106100.protonmail.ch (mail-106100.protonmail.ch
 [79.135.106.100])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 271AB605F1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Oct 2026 08:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
 s=protonmail; t=1793176501; x=1793435701;
 bh=4od7Sr2E6qFuyNeg8F4/VjgHxNRfB5PEspoSjeOV7ho=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=gG5mgoNRl4xIkZwhHeUeVMXaTZ1srRIPysbH0wRr/4GQy0pvOMQsDGs/VNecU0kjt
 MfrSgd/VP3NcM5LjQwuKdM9Yk+aJK1UANTJYBQyOmLqfWlMCoM/SuBmhhNvlon+fan
 kymLSMcO6TebGb4H/fwI7gCRlJZY36CwSWc/WVCHxfwM+aQUNL46kUm6upIxQipO8V
 zznEusdjExt+DZBEtA293MxBCQwvHrV3iYu3xE1xUPdGIgJkSMUriKXHnfB2azwxv8
 n8KZSsmQB4SLMGOAFSZpZ5ifO5Rxk+b/ItwVOgHuBV6A+9MZihjTmXcN5pJnZyYaq4
 e3zzZiTUVlrGw==
Date: Wed, 28 Oct 2026 08:34:52 +0000
To: intel-wired-lan@lists.osuosl.org
From: Paul Moses <p@1g4.org>
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, vedang.patel@intel.com, jithu.joseph@intel.com,
 maciej.fijalkowski@intel.com, andre.guedes@intel.com,
 aleksandr.loktionov@intel.com, avigailx.dahan@intel.com,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH net v3 0/2] igc: fix RX timestamp handling and AF_XDP buffer
 sizing
Message-ID: <20261028083344.3047350-1-p@1g4.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 4ded5c9b518f4210a9782b3821add11c04f7d4cf
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

v2..v3
Restore the original timestamp fix and description instead of tracking
frame boundaries. Patch 2 carries Maciej's AF_XDP buffer-size fix unchanged=
.

v1..v2
Changed commit message in attempt to satisfy bots. No code changes.

Maciej's patch:
https://lore.kernel.org/all/at+t%2FjHczGvyXKRN@boxer/

#
# REPRO
#=20
# Receiver: igc / enp1s0 / 10.0.5.175
# Sender:   RTL8125B / enP4p65s0 / 10.0.5.165

# Both hosts
sudo ip link set dev enp1s0 mtu 9000
sudo ip link set dev enP4p65s0 mtu 9000

# Baseline: RX timestamping off
sudo hwstamp_ctl -i enp1s0 -t 0 -r 0
ping -n -M do -c 5 -s 8972 10.0.5.175
# 5/5 received

# Enable RX timestamping only
sudo hwstamp_ctl -i enp1s0 -t 0 -r 1

# Receiver
sudo timeout 20 tcpdump -ni enp1s0 -s 0 -w /tmp/igc-jumbo.pcap \
  'icmp and host 10.0.5.165'

# Sender
ping -n -M do -c 5 -W 2 -s 8972 10.0.5.175
# 0/5 received

# Receiver
sudo tcpdump -nn -e -vvv -r /tmp/igc-jumbo.pcap
# length 8950
# [total length 9000 > length 8936] (invalid)
# wrong icmp cksum

# Expected Ethernet length: 9014
# Captured length:          8950
# Loss:                       64 =3D 4 continuation buffers * 16 bytes

# Disable RX timestamping again
sudo hwstamp_ctl -i enp1s0 -t 0 -r 0
ping -n -M do -c 5 -s 8972 10.0.5.175
# 5/5 received

--=20
2.56.GIT

