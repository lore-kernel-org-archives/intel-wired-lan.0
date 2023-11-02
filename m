Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9AE3C4167B
	for <intel-wired-lan@archiver.kernel.org>; Thu,  2 Nov 2023 20:21:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 70AE670756;
	Thu,  2 Nov 2023 20:21:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 70AE670756
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1698956486;
	bh=9gMO1VrI1wQKQZVTiikrt6FuElDXNZ2+8uMpPLII/pg=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=XozwSKcRpfShb25nghGcDq0j//YdIzQJscEkbA9wBrqCCSd8XQJHDtrlXCyqBoqF+
	 8ol1XY8y+g2SGpM3qyH/gZx8/6CifQessbHN47m8j6Sa5sYUV3wuU6HOXZttKbJYlt
	 9zT60FTlugKT6MFlarnKzxb9+cKbjtQPh5/zJksBUKwobLYvewuOYCc7nHRi1k3YpX
	 jzbHBQn0YIEsVMwVy0T3QS7o4lL4nX6X7H947TMq8pqWzCktEr+/GmnKYD7YWoIlVx
	 /tuVPVYFGXM+LA3A8AR5H9FCkJmUeDtHTiRjkkfURXzpPT4a+Iasptyqd12RI3eNJq
	 4I3c+7UQq/ynA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v-UT7x9SsBRp; Thu,  2 Nov 2023 20:21:22 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id E5FEC70780;
	Thu,  2 Nov 2023 20:21:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E5FEC70780
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id B1B951BF287
 for <intel-wired-lan@lists.osuosl.org>; Thu,  2 Nov 2023 18:55:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 97BFE81FEF
 for <intel-wired-lan@lists.osuosl.org>; Thu,  2 Nov 2023 18:55:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 97BFE81FEF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Eh4IviljPLfE for <intel-wired-lan@lists.osuosl.org>;
 Thu,  2 Nov 2023 18:55:50 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com
 [IPv6:2607:f8b0:4864:20::1149])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4175C80E88
 for <intel-wired-lan@lists.osuosl.org>; Thu,  2 Nov 2023 18:55:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4175C80E88
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-5acac8b6575so19021267b3.1
 for <intel-wired-lan@lists.osuosl.org>; Thu, 02 Nov 2023 11:55:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698951349; x=1699556149;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GwZROZlK9UfWkKR+Oep5UTLdUA8cSVn3j1Qp9AwudVw=;
 b=ReNchEeSS6O468asabjzVXdKXquRoDtbrA0ncGWITVqaZvcDkLxrTPPGazYA0LTkc2
 tZlJbXc2/mtdqkccZ44m+NF9L3cz+6GwZn4/4UCcYlos43FGhm9cAhw9Lf6mm+kgElzV
 neVoIl78ezStUrvieyNfWAUSGVAbKIMWDmk9KHuJO3tvwayL6W0jAhdhp6+ie6E7xx7q
 bsJyDO/ZNPtsPluCbcgv3WG+fx6jeRLMNOIV+gz9fB+xE488KhtMKHJETaWqade2B8Ph
 NlpOkku0PXQAy28FCuZmn+An+GfIz4SV9Wh+CIfD4tUhVLmQQR3wdoGEn8I1NUGlp+ck
 o9sg==
X-Gm-Message-State: AOJu0Yz4XZvSvEPKeEC1fXFRYCPtBtp/5hoOLUQd4s5ms+GerrKSM5oi
 sPmedXyo3tIPZtPYmhCvNJpNKoqLE+Naop2Hig==
X-Google-Smtp-Source: AGHT+IHU+DjdhGyfLwL6+kKjSdSmxJWkpryViec8cwwDoWtQDNOiyfbquBqPfJ/wOCFKMWI8x2MjGy7G4ggPBzP5Kg==
X-Received: from jstitt-linux1.c.googlers.com
 ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:45:b0:d9b:59c3:6eef with SMTP
 id m5-20020a056902004500b00d9b59c36eefmr8657ybh.0.1698951348803; Thu, 02 Nov
 2023 11:55:48 -0700 (PDT)
Date: Thu, 02 Nov 2023 18:55:41 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAK3wQ2UC/33NQQqDMBQE0KuUrJsS8zWpXfUepUhMvhpQIyYVi
 3j3BleWSpfDMG8W4nG06MnttJARJ+ut62NIzyeiG9XXSK2JmXDGIWE8oxia4FxbDK/gC9sNLVV
 JKvOqKrVERuJuGLGy82Y+SI+B9jgH8oxNY31w43s7m5Kt/+NOCWVUqAxUDgZKye+1c3WLF+26j
 Zv4nhBHBI8EM0Lq0hiWwfWHgD0hjwiIBKRCKC1kDiz9ItZ1/QDJe1zHQwEAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519;
 pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698951347; l=4723;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=jFTdO8kx/UlazPhR0MRqYdFyWA/L3tuMaQQIucen34M=;
 b=v2F1dfbbHaeo64cGZOjBP3/iolmGrFIsPfCBQHud2JK2GSSDr5CUsMsWVAeI/q16gcG+J6OW+
 QYzrftVSbVSBn7OqwukQ4KtKDMdJQi+bVfKV5GmEwqA8bEfbAtqp47F
X-Mailer: b4 0.12.3
Message-ID: <20231102-ethtool_puts_impl-v4-0-14e1e9278496@google.com>
From: Justin Stitt <justinstitt@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Shay Agroskin <shayagr@amazon.com>, 
 Arthur Kiyanovski <akiyano@amazon.com>, David Arinzon <darinzon@amazon.com>,
 Noam Dagan <ndagan@amazon.com>, 
 Saeed Bishara <saeedb@amazon.com>, Rasesh Mody <rmody@marvell.com>, 
 Sudarsana Kalluru <skalluru@marvell.com>, GR-Linux-NIC-Dev@marvell.com, 
 Dimitris Michailidis <dmichail@fungible.com>,
 Yisen Zhuang <yisen.zhuang@huawei.com>, 
 Salil Mehta <salil.mehta@huawei.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Louis Peens <louis.peens@corigine.com>, 
 Shannon Nelson <shannon.nelson@amd.com>, Brett Creeley <brett.creeley@amd.com>,
 drivers@pensando.io, 
 "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Ronak Doshi <doshir@vmware.com>, 
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, 
 Dwaipayan Ray <dwaipayanray1@gmail.com>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
 Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>, 
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
 "=?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?=" <arinc.unal@arinc9.com>,
 Daniel Golle <daniel@makrotopia.org>, 
 Landen Chao <Landen.Chao@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, 
 Sean Wang <sean.wang@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 "=?utf-8?q?Alvin_=C5=A0ipraga?=" <alsi@bang-olufsen.dk>,
 Wei Fang <wei.fang@nxp.com>, 
 Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, 
 NXP Linux Team <linux-imx@nxp.com>, Lars Povlsen <lars.povlsen@microchip.com>, 
 Steen Hegelund <Steen.Hegelund@microchip.com>,
 Daniel Machon <daniel.machon@microchip.com>, 
 UNGLinuxDriver@microchip.com, Jiawen Wu <jiawenwu@trustnetic.com>, 
 Mengyuan Lou <mengyuanlou@net-swift.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>
X-Mailman-Approved-At: Thu, 02 Nov 2023 20:21:17 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1698951349; x=1699556149; darn=lists.osuosl.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=GwZROZlK9UfWkKR+Oep5UTLdUA8cSVn3j1Qp9AwudVw=;
 b=O+VYxoiYRHfYS7Iiv0KRuMDAybAm0lea9wDyWjnnH0KvR5hxEXd5a7yBaCxdZIeSIl
 AqhHG3/TX30eZipVT1H+5WRrB0Ap4fbHkmVhXnGEBSniYad24emujpHyv4fL0xLE4Alx
 aylBQiatyjuHZpEqLkPWZhupP22aB2R2JtnD34rtxK95WAjtE14ohaPb33YwCOYmiYnP
 N36D7OAEkwVA2sW0GcJnPQ6sAcsbByjtIQ1G9dzTybdCR/0mvPC5U5mg2FoZLbl923bs
 8JWCfy2+3cy5kniyA7q4mXsut/vynntFBBoMP4Rx0V8w23Svxw4JK5zFDAu+PBp1nCwX
 StwQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20230601 header.b=O+VYxoiY
Subject: [Intel-wired-lan] [PATCH net-next v4 0/3] ethtool: Add
 ethtool_puts()
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: linux-hyperv@vger.kernel.org, Kees Cook <keescook@chromium.org>,
 netdev@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
 linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
 oss-drivers@corigine.com, intel-wired-lan@lists.osuosl.org,
 Justin Stitt <justinstitt@google.com>, linux-mediatek@lists.infradead.org,
 bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Hi,

This series aims to implement ethtool_puts() and send out a wave 1 of
conversions from ethtool_sprintf(). There's also a checkpatch patch
included to check for the cases listed below.

This was sparked from recent discussion here [1]

The conversions are used in cases where ethtool_sprintf() was being used
with just two arguments:
|       ethtool_sprintf(&data, buffer[i].name);
or when it's used with format string: "%s"
|       ethtool_sprintf(&data, "%s", buffer[i].name);
which both now become:
|       ethtool_puts(&data, buffer[i].name);

The first case commonly triggers a -Wformat-security warning with Clang
due to potential problems with format flags present in the strings [3].

The second is just a bit weird with a plain-ol' "%s".

Changes found with Cocci [4] and grep [5].

[1]: https://lore.kernel.org/all/202310141935.B326C9E@keescook/
[2]: https://lore.kernel.org/all/?q=dfb%3Aethtool_sprintf+AND+f%3Ajustinstitt
[3]: https://lore.kernel.org/all/202310101528.9496539BE@keescook/
[4]: (script authored by Kees w/ modifications from Joe)
@replace_2_args@
expression BUF;
expression VAR;
@@

-       ethtool_sprintf(BUF, VAR)
+       ethtool_puts(BUF, VAR)

@replace_3_args@
expression BUF;
expression VAR;
@@

-       ethtool_sprintf(BUF, "%s", VAR)
+       ethtool_puts(BUF, VAR)

-       ethtool_sprintf(&BUF, "%s", VAR)
+       ethtool_puts(&BUF, VAR)

[5]: $ rg "ethtool_sprintf\(\s*[^,)]+\s*,\s*[^,)]+\s*\)"

Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v4:
- update documentation to match:
  https://lore.kernel.org/all/20231028192511.100001-1-andrew@lunn.ch/

- Link to v3: https://lore.kernel.org/r/20231027-ethtool_puts_impl-v3-0-3466ac679304@google.com

Changes in v3:
- fix force_speed_maps merge conflict + formatting (thanks Vladimir)
- rebase onto net-next (thanks Andrew, Vladimir)
- change subject (thanks Vladimir)
- fix checkpatch formatting + implementation (thanks Joe)
- Link to v2: https://lore.kernel.org/r/20231026-ethtool_puts_impl-v2-0-0d67cbdd0538@google.com

Changes in v2:
- wrap lines better in replacement (thanks Joe, Kees)
- add --fix to checkpatch (thanks Joe)
- clean up checkpatch formatting (thanks Joe, et al.)
- rebase against next
- Link to v1: https://lore.kernel.org/r/20231025-ethtool_puts_impl-v1-0-6a53a93d3b72@google.com

---
Justin Stitt (3):
      ethtool: Implement ethtool_puts()
      checkpatch: add ethtool_sprintf rules
      net: Convert some ethtool_sprintf() to ethtool_puts()

 drivers/net/dsa/lantiq_gswip.c                     |  2 +-
 drivers/net/dsa/mt7530.c                           |  2 +-
 drivers/net/dsa/qca/qca8k-common.c                 |  2 +-
 drivers/net/dsa/realtek/rtl8365mb.c                |  2 +-
 drivers/net/dsa/realtek/rtl8366-core.c             |  2 +-
 drivers/net/dsa/vitesse-vsc73xx-core.c             |  8 +--
 drivers/net/ethernet/amazon/ena/ena_ethtool.c      |  4 +-
 drivers/net/ethernet/brocade/bna/bnad_ethtool.c    |  2 +-
 drivers/net/ethernet/freescale/fec_main.c          |  4 +-
 .../net/ethernet/fungible/funeth/funeth_ethtool.c  |  8 +--
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c |  2 +-
 .../net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c    |  2 +-
 drivers/net/ethernet/hisilicon/hns/hns_ethtool.c   | 65 +++++++++++-----------
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |  6 +-
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c     |  3 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c       |  9 +--
 drivers/net/ethernet/intel/idpf/idpf_ethtool.c     |  2 +-
 drivers/net/ethernet/intel/igb/igb_ethtool.c       |  6 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c       |  6 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c   |  5 +-
 .../net/ethernet/microchip/sparx5/sparx5_ethtool.c |  2 +-
 .../net/ethernet/netronome/nfp/nfp_net_ethtool.c   | 44 +++++++--------
 drivers/net/ethernet/pensando/ionic/ionic_stats.c  |  4 +-
 drivers/net/ethernet/wangxun/libwx/wx_ethtool.c    |  2 +-
 drivers/net/hyperv/netvsc_drv.c                    |  4 +-
 drivers/net/phy/nxp-tja11xx.c                      |  2 +-
 drivers/net/phy/smsc.c                             |  2 +-
 drivers/net/vmxnet3/vmxnet3_ethtool.c              | 10 ++--
 include/linux/ethtool.h                            | 13 +++++
 net/ethtool/ioctl.c                                |  7 +++
 scripts/checkpatch.pl                              | 19 +++++++
 31 files changed, 139 insertions(+), 112 deletions(-)
---
base-commit: 3a04927f8d4b7a4f008f04af41e31173002eb1ea
change-id: 20231025-ethtool_puts_impl-a1479ffbc7e0

Best regards,
--
Justin Stitt <justinstitt@google.com>

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
