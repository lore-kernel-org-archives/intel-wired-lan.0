Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2B6606A333
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Nov 2026 16:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=ohHceYZq;
	dkim=pass (2048-bit key, unprotected) header.d=g.skku.edu header.i=@g.skku.edu header.a=rsa-sha256 header.s=google header.b=l3c1m8T2
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 415A1607C0;
	Mon, 23 Nov 2026 16:24:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kjjqZ-BK4tKD; Mon, 23 Nov 2026 16:24:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B752E607A9
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795451072;
	b=bl1R91kKNB8GjWvbBw+WzIX0IZqHuwRIyhrIlJNddLcRf7//5sX28dpcp6fX+ovIUNsK
	 oH3lWkhsqTBnIhwO7YjDMtEg7DiyM/vyq/QAuzjC/sygJWnqqybS/Aqi4v7NGcMYwRBYK
	 ohL1Dm9NklclgES5qwmMaeuCqr5nr4IutgoxcJC8sFVMznRIFR9/HK3D4tR4XxIrSucQB
	 1rQzg/NS6KoU1L6QzsfHQa6psjCNmFlYcSlhmqihWY+xMI3PYLKbfxzvUZCudYCZA6X9y
	 Mh3Lj8CaQ/HxPcvdhpfKDkM3bakiTFk0gQZrT1m1Jhd8UQvfbgMy+ZW3/k8DKT/mphA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795451072;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=gJkkbu5QUHPvQj7/qFq1LEbKcJ05skU/Z9RFzwRX4Y4=;
	b=XB5Jp9KaBVHqm7mR2lpxmS7nnEMrQs6e1w/z2TipEgP14Uu9z0VjlIHl3h32a5z7IXke
	 ew8XHAfwQtpCDRwSUxqXEui2ujQ7HSh2zA1jVvjiShLnwRfZKzyRI+MaS3i3Eq0ltTZYq
	 Qk7W4CD3s11S3JXsPF9PDM6JO1XL14IAHBEcQz/W3kjAEhODnzXp3TbFp+/M9Vsd6MEpA
	 X8Nb77Mm+mlV+cqfEuli2KC2bYD1Fw3q2u+iPryUCmyI2ZGQ4uSxM94XYu+rV6wzXXr9u
	 49d3BH/VKj1fnfYhrByo8yfLZ7RBchXUja7ttXFMuh/UqvqYEpaocfdhlwKQmLT6oww==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795451072;
	bh=gJkkbu5QUHPvQj7/qFq1LEbKcJ05skU/Z9RFzwRX4Y4=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ohHceYZq+yfNsfEB0ySOzABFrJbreHipSULujGY6gdWev309xMxj+AdnSpXmYMDwZ
	 R/UFkKb4n4ekIAq1UiWZa6VSFxyU8SllCsnTKFLYup/oftFDM/v1xU0pPLTBKKT4X1
	 o/hXKOyCLp41+WoBnxZi6hGjLeouJNkCFuYXMZISD41uO9mLuBlP2QoRRD1cSAPMSo
	 A+V2qjp+00RiyWqshLYqeoPtxrL/XPiQCGfFC42h/QuXo3ZImrHcfzXGhuflnSHk7k
	 tqn0bkLdDd22mRjA16HAicyWz6lpV5iKr252EW3PVxXJ9wZZQltD3QUx4vw0GzjFyP
	 n17easFhOO5Xg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B752E607A9;
	Mon, 23 Nov 2026 16:24:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5296022B
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 15:00:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3C64780C67
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 15:00:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nHYxhQV4vqeA for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Nov 2026 14:59:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4F1A580C43
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1130"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1130; helo=mail-yw1-x1130.google.com;
 envelope-from=for8821@g.skku.edu; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=g.skku.edu
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=g.skku.edu header.i=@g.skku.edu header.a=rsa-sha256
 header.s=google header.b=l3c1m8T2
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4F1A580C43
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 14:59:55 +0000 (UTC)
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-8b4c2da74c0so19865837b3.1
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 06:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=g.skku.edu; s=google; t=1795445995; x=1796050795; darn=lists.osuosl.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gJkkbu5QUHPvQj7/qFq1LEbKcJ05skU/Z9RFzwRX4Y4=;
 b=l3c1m8T2itwN+3TWrvgPPt8Oznb8260wwug+00BDaL1OYN+QGo1IR5zx3qMCKXvmpf
 eoQa8VHT46Gg2DKYpUBXM5EyJuLtQYTk7DdY7I5Dtels0sa3/GWoTOgULoDeEkyyrmJJ
 x+Fs0bMTizNn/Any9v9c6KI0CUQ2gH51IB8okzTKutIB7QQdxbJV2CC/m8g8r3UzyHnS
 EoRAELWSOnFc3nThOPL5gQVDpluNJd7p+fRSj2UNXOiEO1JbHbQFjcFKdl5xj5ZPAvPI
 TxZ0x1vlu98cvHlUIdnA600PB+buPAdZ3XRxtQRog+RTYt6dHVcpCceYw1hCCn7Z1S1d
 mhlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795445995; x=1796050795;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gJkkbu5QUHPvQj7/qFq1LEbKcJ05skU/Z9RFzwRX4Y4=;
 b=fc5p6YFTLpa/IkitqBYCoy35qXZKJoMPlCgmeHvHrSGesU/6yJ/4gZlnUoqyLJ6YYb
 Fv8nkcw2ppjmMEzWbhu8F1RzU82KkkKQAHjUGlagQvWeQVYZqauSFiCaTFw6AdUg5IYJ
 RPywk0eOXcYm6DT9XF42F1faJHdv5TpkcRzoeiM1z+33MjbknXXREYlv8XjONU+09qdf
 pLIepxe6qU9cZIPdAyDv3JOZGSnK/lKpjd3oacNw+lAe3OjPGIwjxIW7QqjHpbx/TLMJ
 eJZoJ1zWvyv3EwP7we7OVnnAdlIisVbHbnOrF9Zpt401yuPKYtnLZuP5p6nAbIbdPD40
 czWA==
X-Gm-Message-State: APuU4Z93FIvwU+VM6vW30Yf6zt4HLlxgdNyS6/DUO1Bkd4JLk8UwgKnD
 rplL3YlZioyg1en70WOZNMuJvTQ4PAcJiz8BVaIHwSnMzCMCQHDLSmoyzpi7zeGY3rQwQ7/jRtq
 H0Xv4JBtX4axkUDyMO2Ad6lBdV5ZpF4HdYuVGcWCxoaLTuZgsKCj0fs3uW+BQ
X-Gm-Gg: AZFdTZcbR1/jGfS1Y/cPYG5C5emAqnOuHBye/M8iVk7Gn/uv3XIdMYBs4Pr5BLFqSfj
 wyHXb4+Utv/rGs7H+83XCOUdlx6/3ESghMOtcwaGP5FDPvCdqbtT+y0NUk88mWYd/b0S+llnaDO
 AsktDGXanX5RH2ANSCX4x/IDbxrqYPLgvqnc+Y79MHYPKyZGxSQhxVbCo4FEtEHR9ogdZ/mNUGP
 Kky0QRCjPzbEsid18XFbnGKNHK+n+dZRfmv9DV2B57CMJLvQp4Q3fHfwv5LGLVVtwj+SmQZ/eJl
 gOFxXt/MyFLVkwA4iaC02Wsq4rgjc0MIcyXg0wlp56u5p9xO4jd5wshj+31lQw5ZuSYN5ti6CFE
 LVhQGQjQvzuKR2Zkqg1OOR13WqxOIHp3XVRvlKWaI46hIfmlGsla/wtHOtZsV3ktpEI7i
X-Received: by 2002:a05:690e:b84:b0:679:ab08:5278 with SMTP id
 956f58d0204a3-67df43f24eamr3304507d50.32.1795445994776; Mon, 23 Nov 2026
 06:59:54 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?7ISx6reg6rSA64yA6rmA66+87ISd?= <for8821@g.skku.edu>
Date: Mon, 23 Nov 2026 23:59:44 +0900
X-Gm-Features: Aa3M54poxAkIMO5zRgIp3LWlm9Dtgn9G48qgYg1fwvEAkcRHQF-7CMlbbfgIgMY
Message-ID: <CABBEkySNmAHTuoiC3jZqvAS31AdzMb2bHe3x0EAKQGibf0xi9g@mail.gmail.com>
Subject: [PATCH iwl-net] ice: bound the CEE DCBX priority-group id before
 using it as a traffic-class index
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, aleksander.lobakin@intel.com, 
 stable@vger.kernel.org
Content-Type: multipart/alternative; boundary="000000000000bb78230660f2d8bd"
X-Mailman-Approved-At: Mon, 23 Nov 2026 16:24:27 +0000
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
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000bb78230660f2d8bd
Content-Type: text/plain; charset="UTF-8"

The CEE DCBX priority-group ID (PGID) is a four-bit wire field spanning
0..15, whereas prio_table[] is sized to ICE_MAX_TRAFFIC_CLASS (8):

  #define ICE_CEE_PGID_PRIO_0_M  (0xF << ICE_CEE_PGID_PRIO_0_S)
  #define ICE_CEE_PGID_PRIO_1_M  (0xF << ICE_CEE_PGID_PRIO_1_S)

The IEEE ETS parser in ice_dcb.c masks the equivalent nibble field with
0x7 (ICE_IEEE_ETS_PRIO_{0,1}_M) so it cannot exceed 7, whereas neither
CEE path bounds the value.

In the wire LLDP TLV path, ice_parse_cee_pgcfg_tlv() extracts each
nibble into prio_table[i] and inspects it to select tsatable[i], but
never rewrites prio_table[i], leaving values 8..15 intact -- including
the defined sentinel ICE_CEE_PGID_STRICT (15).  In the firmware AQ path,
ice_cee_to_dcb_cfg() remaps only ICE_CEE_PGID_STRICT to oper_num_tc - 1
and lets values 8..14 fall through untouched.

Downstream consumers then use prio_table[i] directly as a traffic-class
index:

- ice_vc_get_qos_caps() (virt/virtchnl.c) indexes local array
  u8 tc_prio[ICE_MAX_TRAFFIC_CLASS] via tc_prio[tc] |= BIT(i), writing
  past the end of the stack array when tc >= 8.
- ice_dcb_tc_contig() (ice_dcb_lib.c) accumulates used_tc |=
  BIT(prio_table[i]) into a u8; for values >= 8, BIT() is >= 0x100 and
  truncates to zero, causing the contiguity check to pass silently.
- ice_vsi_cfg_netdev_tc() (ice_lib.c) indexes
  vsi->tc_cfg.tc_info[ets_tc].netdev_tc with ets_tc = prio_table[i],
  reading past the end of tc_info[].

The driver already enforces this invariant when writing prio_table[] in
ice_dcbnl_set_pg_tc_cfg_tx() and at the VF trust boundary in
ice_vc_cfg_q_bw().  Bounding the PGID at CEE ingest enforces the
invariant at a single boundary and prevents the u8 BIT() truncation in
ice_dcb_tc_contig() that per-array bounds checks would miss.

Fixes: 015307754a19 ("ice: Support VF queue rate limit and quanta size
configuration")
Cc: stable@vger.kernel.org
Signed-off-by: Minseok Kim <for8821@g.skku.edu>
---
Notes on testing and tool assistance (per
Documentation/process/generated-content.rst):

- Tool assistance: Claude Code (Anthropic) was used during static source
  auditing of the CEE DCBX parsing paths, to draft the initial commit
  description and bounds check, and to run build/style checks.  All
  findings, code changes, and commit text were independently verified
  and edited by the author, who takes full responsibility for the patch.
- Testing: Compile-tested only on x86_64 (defconfig + CONFIG_PCI_IOV +
  CONFIG_DCB + CONFIG_ICE) with `make W=1 drivers/net/ethernet/intel/ice/`
  against a clean baseline build, and checked with `scripts/checkpatch.pl
  --strict` (0 errors, 0 warnings, 0 checks).  No reproducer was built
  and no runtime testing was performed due to lack of E810 hardware or a
  QEMU device model; the out-of-bounds accesses are established from
  source inspection and header constants.

 drivers/net/ethernet/intel/ice/ice_dcb.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_dcb.c
b/drivers/net/ethernet/intel/ice/ice_dcb.c
index abea84f14658..a36458b01fc2 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb.c
@@ -407,6 +407,15 @@ ice_parse_cee_pgcfg_tlv(struct ice_cee_feat_tlv *tlv,
                        dcbcfg->etscfg.tsatable[i] = ICE_IEEE_TSA_STRICT;
                else
                        dcbcfg->etscfg.tsatable[i] = ICE_IEEE_TSA_ETS;
+
+               /* The CEE PGID is a four-bit wire field, so a peer can
name a
+                * priority group this driver has no traffic class for.
Several
+                * consumers use the value to index
ICE_MAX_TRAFFIC_CLASS-sized
+                * objects, so clamp it here, after the strict-priority
sentinel
+                * above has been consumed.
+                */
+               if (etscfg->prio_table[i] >= ICE_MAX_TRAFFIC_CLASS)
+                       etscfg->prio_table[i] = 0;
        }

        /* Number of TCs supported (1 octet) */
@@ -805,6 +814,10 @@ ice_cee_to_dcb_cfg(struct ice_aqc_get_cee_dcb_cfg_resp
*cee_cfg,
                        /* Map it to next empty TC */
                        dcbcfg->etscfg.prio_table[i] = cee_cfg->oper_num_tc
- 1;
                        dcbcfg->etscfg.tsatable[i] = ICE_IEEE_TSA_STRICT;
+               } else if (dcbcfg->etscfg.prio_table[i] >=
+                          ICE_MAX_TRAFFIC_CLASS) {
+                       dcbcfg->etscfg.prio_table[i] = 0;
+                       dcbcfg->etscfg.tsatable[i] = ICE_IEEE_TSA_ETS;
                } else {
                        dcbcfg->etscfg.tsatable[i] = ICE_IEEE_TSA_ETS;
                }

--000000000000bb78230660f2d8bd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">The CEE DCBX priority-group ID (PGID) is a four-bit wire f=
ield spanning<br>0..15, whereas prio_table[] is sized to ICE_MAX_TRAFFIC_CL=
ASS (8):<br><br>=C2=A0 #define ICE_CEE_PGID_PRIO_0_M =C2=A0(0xF &lt;&lt; IC=
E_CEE_PGID_PRIO_0_S)<br>=C2=A0 #define ICE_CEE_PGID_PRIO_1_M =C2=A0(0xF &lt=
;&lt; ICE_CEE_PGID_PRIO_1_S)<br><br>The IEEE ETS parser in ice_dcb.c masks =
the equivalent nibble field with<br>0x7 (ICE_IEEE_ETS_PRIO_{0,1}_M) so it c=
annot exceed 7, whereas neither<br>CEE path bounds the value.<br><br>In the=
 wire LLDP TLV path, ice_parse_cee_pgcfg_tlv() extracts each<br>nibble into=
 prio_table[i] and inspects it to select tsatable[i], but<br>never rewrites=
 prio_table[i], leaving values 8..15 intact -- including<br>the defined sen=
tinel ICE_CEE_PGID_STRICT (15).=C2=A0 In the firmware AQ path,<br>ice_cee_t=
o_dcb_cfg() remaps only ICE_CEE_PGID_STRICT to oper_num_tc - 1<br>and lets =
values 8..14 fall through untouched.<br><br>Downstream consumers then use p=
rio_table[i] directly as a traffic-class<br>index:<br><br>- ice_vc_get_qos_=
caps() (virt/virtchnl.c) indexes local array<br>=C2=A0 u8 tc_prio[ICE_MAX_T=
RAFFIC_CLASS] via tc_prio[tc] |=3D BIT(i), writing<br>=C2=A0 past the end o=
f the stack array when tc &gt;=3D 8.<br>- ice_dcb_tc_contig() (ice_dcb_lib.=
c) accumulates used_tc |=3D<br>=C2=A0 BIT(prio_table[i]) into a u8; for val=
ues &gt;=3D 8, BIT() is &gt;=3D 0x100 and<br>=C2=A0 truncates to zero, caus=
ing the contiguity check to pass silently.<br>- ice_vsi_cfg_netdev_tc() (ic=
e_lib.c) indexes<br>=C2=A0 vsi-&gt;tc_cfg.tc_info[ets_tc].netdev_tc with et=
s_tc =3D prio_table[i],<br>=C2=A0 reading past the end of tc_info[].<br><br=
>The driver already enforces this invariant when writing prio_table[] in<br=
>ice_dcbnl_set_pg_tc_cfg_tx() and at the VF trust boundary in<br>ice_vc_cfg=
_q_bw().=C2=A0 Bounding the PGID at CEE ingest enforces the<br>invariant at=
 a single boundary and prevents the u8 BIT() truncation in<br>ice_dcb_tc_co=
ntig() that per-array bounds checks would miss.<br><br>Fixes: 015307754a19 =
(&quot;ice: Support VF queue rate limit and quanta size configuration&quot;=
)<br>Cc: <a href=3D"mailto:stable@vger.kernel.org">stable@vger.kernel.org</=
a><br>Signed-off-by: Minseok Kim &lt;<a href=3D"mailto:for8821@g.skku.edu">=
for8821@g.skku.edu</a>&gt;<br>---<br>Notes on testing and tool assistance (=
per<br>Documentation/process/generated-content.rst):<br><br>- Tool assistan=
ce: Claude Code (Anthropic) was used during static source<br>=C2=A0 auditin=
g of the CEE DCBX parsing paths, to draft the initial commit<br>=C2=A0 desc=
ription and bounds check, and to run build/style checks.=C2=A0 All<br>=C2=
=A0 findings, code changes, and commit text were independently verified<br>=
=C2=A0 and edited by the author, who takes full responsibility for the patc=
h.<br>- Testing: Compile-tested only on x86_64 (defconfig + CONFIG_PCI_IOV =
+<br>=C2=A0 CONFIG_DCB + CONFIG_ICE) with `make W=3D1 drivers/net/ethernet/=
intel/ice/`<br>=C2=A0 against a clean baseline build, and checked with `scr=
ipts/<a href=3D"http://checkpatch.pl">checkpatch.pl</a><br>=C2=A0 --strict`=
 (0 errors, 0 warnings, 0 checks).=C2=A0 No reproducer was built<br>=C2=A0 =
and no runtime testing was performed due to lack of E810 hardware or a<br>=
=C2=A0 QEMU device model; the out-of-bounds accesses are established from<b=
r>=C2=A0 source inspection and header constants.<br><br>=C2=A0drivers/net/e=
thernet/intel/ice/ice_dcb.c | 13 +++++++++++++<br>=C2=A01 file changed, 13 =
insertions(+)<br><br>diff --git a/drivers/net/ethernet/intel/ice/ice_dcb.c =
b/drivers/net/ethernet/intel/ice/ice_dcb.c<br>index abea84f14658..a36458b01=
fc2 100644<br>--- a/drivers/net/ethernet/intel/ice/ice_dcb.c<br>+++ b/drive=
rs/net/ethernet/intel/ice/ice_dcb.c<br>@@ -407,6 +407,15 @@ ice_parse_cee_p=
gcfg_tlv(struct ice_cee_feat_tlv *tlv,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dcbcfg-&gt;etscfg.tsat=
able[i] =3D ICE_IEEE_TSA_STRICT;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 else<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dcbcfg-&gt;etscfg.tsatable[i] =3D ICE_IE=
EE_TSA_ETS;<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* T=
he CEE PGID is a four-bit wire field, so a peer can name a<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* priority group this driver h=
as no traffic class for.=C2=A0 Several<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0* consumers use the value to index ICE_MAX_TRAFFIC_=
CLASS-sized<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* o=
bjects, so clamp it here, after the strict-priority sentinel<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* above has been consumed.<=
br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (etscfg-&gt;prio_table[i] &gt;=
=3D ICE_MAX_TRAFFIC_CLASS)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 etscfg-&gt;prio_table[i] =3D 0;<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 }<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Number of =
TCs supported (1 octet) */<br>@@ -805,6 +814,10 @@ ice_cee_to_dcb_cfg(struc=
t ice_aqc_get_cee_dcb_cfg_resp *cee_cfg,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Map it to next empt=
y TC */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 dcbcfg-&gt;etscfg.prio_table[i] =3D cee_cfg-&gt;oper_n=
um_tc - 1;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 dcbcfg-&gt;etscfg.tsatable[i] =3D ICE_IEEE_TSA_STR=
ICT;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (dcbcf=
g-&gt;etscfg.prio_table[i] &gt;=3D<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ICE_MAX_TRAFFIC_CLAS=
S) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 dcbcfg-&gt;etscfg.prio_table[i] =3D 0;<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dcbcfg-&gt;etsc=
fg.tsatable[i] =3D ICE_IEEE_TSA_ETS;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 } else {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dcbcfg-&gt;etscfg.tsatable[i] =3D=
 ICE_IEEE_TSA_ETS;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 }<br></div>

--000000000000bb78230660f2d8bd--
