Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EB3606A321
	for <intel-wired-lan@archiver.kernel.org>; Tue, 24 Nov 2026 15:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=Tt+Q/KPS;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Em2NQVHZ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 422C7605D2;
	Tue, 24 Nov 2026 15:39:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LXm19Ic2Er7R; Tue, 24 Nov 2026 15:39:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 89F19605E9
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795534762;
	b=sgS9iho1BDeLn3ofV09SyeaFXY6hET6l/gEsi0e/4MfpNPyUdBFs6Z0XTZqExz6VHjdD
	 LGlJFYReXMikNuxzkGx22PM/yc99Z/CYoMPaRxqsIioto0xOzmpEZrvuVaP7Ktd8sYQoo
	 ZEg7Z19vggze1dAf7AVFON4q/BfOCEFkQFnBtnkDquGNcRzxzdh6+2YeZqJoB0rhs7Ljt
	 6Bm4EF812Jao4Phax7D3UddCxFWBUPsR004bMWumwGbQMDBjMW4/lEzfrkqOUKu10RI3T
	 86l7acIT1UBmJSihB2gjJDX3doTU6XHjbVx2AaoFn8rcXyZWNcFYPjv7mvErePubu9A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795534762;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=aBBkZUCZ/0EJxZ3yNmCwBFcXFFqep/KFSI38/raVTAE=;
	b=loNoAYpRIAP5jRmGrqEADkMBVgUk4q8nm1Y4DDrRnm5E2zuDS8LQDeuOA3g6/zKga0gw
	 K/q6m1okgGx0e7f7PNh/OeX3Wmskzx+Rok015HBG3NEdf2t4DyhVtjKfGa2lcoxra7LeX
	 +zegsytz4Cg0iuOpFPGKy7++v2JaxVfKjM5buhJOIsV1SD93XnleJ9Oi/Qefn2J/ynPch
	 R+xeBYz/g8YUUFcTBZ4FLHLMjcxmieRhnQAMw+IHotLrojV94xNz9QXxELe+hMnWvaN+B
	 +eXvxKMvMqKugVs84Pcm1rzipdbHSKTtqp1niNJjFi0Hp+cG+2mAfSl2yzPf9/qeldA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795534762;
	bh=aBBkZUCZ/0EJxZ3yNmCwBFcXFFqep/KFSI38/raVTAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Tt+Q/KPSYwFqkFTDmvLArmjLUWc1Zl8Wlp23v7fEFc8Ab9gwaW6M84HM01ICrtrLo
	 Qm0XdIvxDo08LZmx7Ybx1fyKDiiW0VTEadOuPs0NorofSNZfVKbLWP9N6d+K+ObxmF
	 0JqrjpKA8ZSldDRYo+TQlwVR00Os1v1evP2x+nHs1zGk5C8Qhs0iKCG6kfS35dsII8
	 Aa1z6fcDngxIXJnLOWO/dINis6YqZY+jwcQ7Xe1qfaKS12gqyR9jH8h6SQzS2tmOHr
	 LrBaOvgGtigDJnhnb2k4n/ciumRjOeOzZCXYnMSiTD8RHhv/ehWii+ZMNnwPyveBhT
	 NBkb+yzhkChsw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 89F19605E9;
	Tue, 24 Nov 2026 15:39:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 40F381AB
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 11:26:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3209740665
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 11:26:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dMKBkVV44tHn for <intel-wired-lan@lists.osuosl.org>;
 Tue, 24 Nov 2026 11:26:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6F25240662
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::132f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::132f; helo=mail-dy1-x132f.google.com;
 envelope-from=kor8821@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=Em2NQVHZ
Received: from mail-dy1-x132f.google.com (mail-dy1-x132f.google.com
 [IPv6:2607:f8b0:4864:20::132f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6F25240662
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 11:26:35 +0000 (UTC)
Received: by mail-dy1-x132f.google.com with SMTP id
 5a478bee46e88-385c497bfddso426850eec.2
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 03:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795519595; x=1796124395; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aBBkZUCZ/0EJxZ3yNmCwBFcXFFqep/KFSI38/raVTAE=;
 b=Em2NQVHZsT4GJhhnpte2IFGLO6VJTWTwp+tbPqOYl2dPXCLWRz8ikirAesdfJJIavs
 ishW62JXRzfMmQ8ncGdrllBDAXFoINHl2IVjcUR+XeyVx8RbcPsT8TmGA4m3OZVSCErH
 rwbZwdpWOsxbSAHz1ltxCVnLflUYmMeeZTFiET/lj0yZ2INqfaBi/fCIjoQnz9nE47G9
 2Sh7G45bJTS7UW5WoFqWPZKc0WO6nOjIOwDLFHMRDj5hEwl7Qq8Exm0Jpe5HsPCaoAzd
 TYi/uOJVhnibFsUNFgTjQnG8pA4x8jTHKISj/tbG2Q0qWzidLc2qPOqU8EeAlJAUqTr6
 cLew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795519595; x=1796124395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aBBkZUCZ/0EJxZ3yNmCwBFcXFFqep/KFSI38/raVTAE=;
 b=khZCnSNNlPQjhoockK0KXzKJ1wFZtOWrVqRa5wEeN2VtIzLbqfxORhNmKeleFpdlxB
 zY5k7t1DCUTzXARwC/eHlv3RPR3ckM2rKGS+DjrN3nzlrU+WjJ0rfap9nOiNqc3lIsKi
 WRrzEiMqmF72D54WdI15DN8KsbuEcdedlyZhjyTlmt8TZpX1F/PCPPm2r54RRjoXnJaA
 JbbKSFx8luVVtjnizPCijNUMKGkqCA12dylRPH7RCK+v1AxaHzfn3XB2rUOBksIYZ2p4
 F/90m8nzxQaXIa2zVoQTPBHOtlqolZyPH+aBxd/b3huW1i+7udTLYtg3ddU+dFtYIBiX
 IO1Q==
X-Gm-Message-State: APuU4Z/O5omeY7O+269CNhzDB6LIuLS9RGq7mSyhAmtmLoUtEWLoplk/
 ziixJnMoNor4KZ5xJPIo0CGMDx86YB7sdDJSef/Aeg82FUB0CzO/hBAKyFd4sMbeqsA=
X-Gm-Gg: AZFdTZeCjmz/72m2oK4EEPEkispPzJvAgKJv8SZnk3bfpuT2Ycp6Opceu65I2MippHG
 /16U759BiqyxE4OWRaYjok8fBBaYh9uSeOolabGjy+nbbgsY/O7TM8mKYMFPFawmzEAZEe5vyuI
 tQjdR530J44RT6lAgZXIqp6D3ttRxQLb+vZaztyJ23jHxXTauUP+IK5fdeqsY2hJYeorANhgdNF
 fFN6awvm+/TsESPIdwNKWdy1BRi3omXKJ6WymEd7pmF0TOX5qmgryN/szNb2gezhQ+PjnPLyxOW
 bZtrRHdsxEHnUDOU7p4Rd+4AjDPqXN27zGS8L8N2CcQnueI0PqFm+xCMvfTj8Ml++/vqhPxjZy7
 dmI4yIO7HiPAKdFdYnySpESABnrb0akBtEiVFqv09AvDQ2TTsSB7U/Wj7KUTmVKwl7JdQDtC+IE
 JEYetzgsleIFltFhentsKnRMtXCwr2k57lfxDHOogWJZwnTy962F5vaEj0HpFT3xAIqPjSwcUUI
 PrUA13tiCa5T+H1fszENOsPySuPFbq2F6klzSFkAAtRBORzqaVXML2RuQRF/fGBO3srWJ7fZFl8
 etZZRXV7LlaN1yks9Mm3Kxs7CIB3Ce3hzx5wajiYzu0ijRclCd2O
X-Received: by 2002:a05:7300:1c24:b0:384:a0cb:a6d0 with SMTP id
 5a478bee46e88-3856de58f7fmr24082962eec.1.1795519594859; 
 Tue, 24 Nov 2026 03:26:34 -0800 (PST)
Received: from localhost.localdomain ([14.47.155.101])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-38566cd4efesm46086998eec.12.2026.11.24.03.26.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Nov 2026 03:26:34 -0800 (PST)
From: Minseok Kim <kor8821@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, aleksander.lobakin@intel.com,
 stable@vger.kernel.org
Subject: [PATCH iwl-net v2] ice: bound the CEE DCBX priority-group id before
 using it as a traffic-class index
Date: Tue, 24 Nov 2026 20:26:31 +0900
Message-ID: <20261124112631.43172-1-kor8821@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <CABBEkySNmAHTuoiC3jZqvAS31AdzMb2bHe3x0EAKQGibf0xi9g@mail.gmail.com>
References: <CABBEkySNmAHTuoiC3jZqvAS31AdzMb2bHe3x0EAKQGibf0xi9g@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 24 Nov 2026 15:39:20 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

Fixes: 015307754a19 ("ice: Support VF queue rate limit and quanta size configuration")
Cc: stable@vger.kernel.org
Signed-off-by: Minseok Kim <kor8821@gmail.com>
---
v2: resend in plain text only.  v1 (Message-ID
    <CABBEkySNmAHTuoiC3jZqvAS31AdzMb2bHe3x0EAKQGibf0xi9g@mail.gmail.com>)
    was sent with a web mail client that word-wrapped the diff and added an
    HTML part, so it does not apply and netdev@ rejected it outright.  No
    code or commit-message changes.

    Resent from kor8821@gmail.com; v1 came from for8821@g.skku.edu.
    Same author, switching to an address that will not expire.
    Signed-off-by updated to match the From line.

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

diff --git a/drivers/net/ethernet/intel/ice/ice_dcb.c b/drivers/net/ethernet/intel/ice/ice_dcb.c
index abea84f14658..a36458b01fc2 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb.c
@@ -407,6 +407,15 @@ ice_parse_cee_pgcfg_tlv(struct ice_cee_feat_tlv *tlv,
 			dcbcfg->etscfg.tsatable[i] = ICE_IEEE_TSA_STRICT;
 		else
 			dcbcfg->etscfg.tsatable[i] = ICE_IEEE_TSA_ETS;
+
+		/* The CEE PGID is a four-bit wire field, so a peer can name a
+		 * priority group this driver has no traffic class for.  Several
+		 * consumers use the value to index ICE_MAX_TRAFFIC_CLASS-sized
+		 * objects, so clamp it here, after the strict-priority sentinel
+		 * above has been consumed.
+		 */
+		if (etscfg->prio_table[i] >= ICE_MAX_TRAFFIC_CLASS)
+			etscfg->prio_table[i] = 0;
 	}
 
 	/* Number of TCs supported (1 octet) */
@@ -805,6 +814,10 @@ ice_cee_to_dcb_cfg(struct ice_aqc_get_cee_dcb_cfg_resp *cee_cfg,
 			/* Map it to next empty TC */
 			dcbcfg->etscfg.prio_table[i] = cee_cfg->oper_num_tc - 1;
 			dcbcfg->etscfg.tsatable[i] = ICE_IEEE_TSA_STRICT;
+		} else if (dcbcfg->etscfg.prio_table[i] >=
+			   ICE_MAX_TRAFFIC_CLASS) {
+			dcbcfg->etscfg.prio_table[i] = 0;
+			dcbcfg->etscfg.tsatable[i] = ICE_IEEE_TSA_ETS;
 		} else {
 			dcbcfg->etscfg.tsatable[i] = ICE_IEEE_TSA_ETS;
 		}
