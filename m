Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35161CA5FE2
	for <intel-wired-lan@archiver.kernel.org>; Sat,  3 Oct 2026 00:51:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E1B0A60604;
	Sat,  3 Oct 2026 00:51:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N-N0diOMKF6L; Sat,  3 Oct 2026 00:51:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org ABBF260649
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790988679;
	b=dJyGUhvidPTftixWG50MUcK4ISG7CwueRJttMq0E4bZ6EAITuLUBrDgg+9ujQJDq49fP
	 ZFzaiRUjhruBF7wg7X1oFzM3tU96EL3Wc0RnuUWrKg7SqFfR8Buw1asw7QuYTvvIGsHKS
	 w48hx8qwFwwsAHQnacZwNiQbV4MMPnC3Iefx744jgfQO0rpWLXXp9RtkvuJSqA6kgvtSZ
	 m4VSplezrlfPgDz8EmdrjEnQNqLIBfG9reylICfxuLGDQvJeed/17g5YJbMPOMZbJIHiM
	 aLLFdcS/Hmlm9cvQQLG6hJowKEsPCZUTS9r1RT9ivMqUlartdGi5O5bz614TzA4T3mg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790988679;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Received:
	 Date:In-Reply-To:Mime-Version:References:X-Mailer:Message-ID:Subject:
	 From:To:Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=s/1KSnCfTM2HoQFYrzlkQiDNVBbx+AxFgFGR2VFoziE=;
	b=Zce0NAy/Msblqoxue6SJs4l/CMG7OwNZTX//PinJ90z/f4z4UJnPNjPH523Rs31KE+SZ
	 tI42AWS5sg9j7FQuBH9GgAVPyVj3aWel16VHSufFrnM7QauPH+VIjMRjeURUaeGM9KDsJ
	 qiVSAoGdf/+EMg4VaeGRNWOI20I98nGsJoQslw7MdEXc6vQw/XpsAtVRcuiuqToyoBF7T
	 R1dts34JrRQRuWlieh2wI2YFVCVeJozLSqSOpd2OQA37jEmdqCKnlGGlzWucwyyo1Ohwb
	 0F/oalruUyB4LLd0WHyYr1D/OrziSvMDqtLVu09reBNiD7gX2J7/iTa3fhRHUs+DKFA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=CAGL11t5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790988679;
	bh=s/1KSnCfTM2HoQFYrzlkQiDNVBbx+AxFgFGR2VFoziE=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hO83lGztIxEeWQE6kjyyG4LS1Qa0zadgMYAi6mIQxnvtJaDgflK6Ml5ra5H8fwSgk
	 Uj4+Wf1kaqRimX6pKW9kjVcEsR+kx33lapT+sziE2lcMr6wuDPD2c7x+rp8AjC3AcA
	 Citkq/mNn41u73Z4fnYhnVkRQpamcEfP6m2JKYGsHxd8LJMAA+x33MV5rDaKjznM70
	 ukY6wPe5RDbDFuZ9KXDyMAx9FpXIxAYFniU4uotcOfQfy8tGfr5q0RECh1zcEpSQ/M
	 Bg+Vb3Fpgh9kasXuFnN2qoUVEkpDDHAIZw18IkgOMLzYiRMf4mJAzZjArXCt52exn6
	 mdwWaOqPqm1ug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id ABBF260649;
	Sat,  3 Oct 2026 00:51:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2A1D12E0
 for <intel-wired-lan@lists.osuosl.org>; Sat,  3 Oct 2026 00:51:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0FDD560649
 for <intel-wired-lan@lists.osuosl.org>; Sat,  3 Oct 2026 00:51:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GSM7TbFDTILD for <intel-wired-lan@lists.osuosl.org>;
 Sat,  3 Oct 2026 00:51:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A666860604
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1345"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790988676;
 b=oI+kIhLW2TsVDGtGL5NP9yKOHxq7y8obi01CvvK2hfZeMC7Ol1xQSzhYPLax6u8YSlWR
 RVDPvImU2DcFE3gB2E4AkuOd3PW//CjkCP+5YUD6Awh08JLzAwPJNnUkBdzaCe6sO/kte
 ze4C6A8oVusO0lrnvMKF+h6uvyMHyjS98+LtjDP0/7QvmE+RR257XBFVJSQ+VbeJeMsLv
 ffs14CrpsclQJzkVho6edY86ZALQJxhizaF6HqqgBDiT+30JuZOrPVnLXGht77yL2YHvw
 rAWYxmNmbMmk6AEszYXNf+SSe8EsvKl3pkmD9A0Vt6lLc8K63VA/oLnxgHfs9qYCGEA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790988676;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
 bh=s/1KSnCfTM2HoQFYrzlkQiDNVBbx+AxFgFGR2VFoziE=;
 b=eqJJS2Y8fJVMYploXW0vKNZul5eY/1MIigYlZYEK/ehW5zMw6JJjUBJmGBQA3FjjYH3c
 DNMl4FvthApH/lfS37OQv2rdkMsRdoahazxDTlKVsNyHU1xAJgJl8DEAAqQNSjupzTGQy
 jlxZCB4+Uiuv0pNGx/4Gi8XW7YTwCWjddevZy4M/khFUIHMWkDoTlNTufDtQr4ko4Mph+
 FoFi7JQialc8ekCvyFEn4Z8WRKmhI98MsEYrkDN50ovSWlWaBedSBuj6AKB/gcc5qnhmf
 yyDUpTLk7BRnNICFws1p8RxN+ZhfhN8CGCxb5v42UMr8LHvT3En8c2U98sE/IiKXzhQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=google.com; 
 dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=CAGL11t5; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1345"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1345; helo=mail-dy1-x1345.google.com;
 envelope-from=3glhaaggkd4mkpnvu6hsnvvnsl.jvtpu0ls-3pylk-shuspz0z.vz1vzs.vyn@flex--digonzal.bounces.google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=CAGL11t5
Received: from mail-dy1-x1345.google.com (mail-dy1-x1345.google.com
 [IPv6:2607:f8b0:4864:20::1345])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A666860604
 for <intel-wired-lan@lists.osuosl.org>; Sat,  3 Oct 2026 00:51:16 +0000 (UTC)
Received: by mail-dy1-x1345.google.com with SMTP id
 5a478bee46e88-30f1b904861so193961eec.0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 02 Oct 2026 17:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1790988675; x=1791593475; darn=lists.osuosl.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=s/1KSnCfTM2HoQFYrzlkQiDNVBbx+AxFgFGR2VFoziE=;
 b=CAGL11t5Ns4vcxi/QPlDPqGyCDkLUZGR7OIU6OuzW4ocP6ZB+OAdibOnuCSaMYvYiB
 FEqus/Yzp+KYYu8wbBqx612bAy8LA7xkJK4tm6YT24PszHwbDLtMMpYrCwGedqwixeQc
 vyPUF9XgtXg3kDDbqoRyXzvWR95yq8i+8bwm2c0rOfCW5VJvMkXthvH6So7TB3rbOj3I
 JywX1J8C0O+KHLv5Pon8ZxSnRdWHFqxd6HpIvjyLv24x9aMKcQxvYaU4TzMjc0PpzBO1
 lMeI8JaEVOFoc/BXriO4rbY6F7G7Xx+/qiO8iOd5lUD8MAbfgHWGPr6HkjlHMYJEKrFj
 gNaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790988675; x=1791593475;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=s/1KSnCfTM2HoQFYrzlkQiDNVBbx+AxFgFGR2VFoziE=;
 b=EKc+lmXqzU0dHcZ399fcvY86NcyoPQcpoqa8yJzC3I1K7BoTEYyCZQdjHCKQpIMzCS
 z/Y71M80rI9kX5Hyyie6B2uKAMDQoXMyLXeIQOnPLQVj+3A7FuokHJpuVVkLUR4opljs
 NB5iqFJVCZMM69yOmwt1j2wHdNZwScvEsdrDi+YVCDGyt7LQdDMWHUsox3G/k7bIDZG/
 ZvFqHzxD/iFYONFJ1yQSaZQd+n6yiZk5DbzVxNuqvOcUsCYtFwbz5ahaGZc7BnRGzt50
 exRzcfN96Yq2s5E1/elW5uKPJ1CCeh6cJLVd4UUUqzqT7p3m3jqnudjox6WJlmFoWSHG
 3wkA==
X-Gm-Message-State: AFuF++mfLnPxmXxGtpjKDX/m4hLWgjyPRuraRdPFyL5VmtyqBtwkc8Ul
 GAjs5lcY+qGw0XPK79pRbcVZKtPmIbdTrUOp8cd7WO/sYrrkqb/nkEet/g4XkcfriX2LkTxc0RU
 xEmfKgWa8GPQmgA==
X-Received: from dlbep23.prod.google.com
 ([2002:a05:7022:1097:b0:14f:6db8:4f48])
 (user=digonzal job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:701b:2094:20b0:144:eab0:9cbc with SMTP id
 a92af1059eb24-151c3d879e1mr1370018c88.37.1790988674717; 
 Fri, 02 Oct 2026 17:51:14 -0700 (PDT)
Date: Sat,  3 Oct 2026 00:50:53 +0000
In-Reply-To: <20260904103714.978256-3-paul.greenwalt@intel.com>
Mime-Version: 1.0
References: <20260904103714.978256-3-paul.greenwalt@intel.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261003005053.3845070-1-digonzal@google.com>
Subject: Re: [PATCH iwl-next v3 2/3] idpf: add devlink support
From: Danny Gonzalez <digonzal@google.com>
To: paul.greenwalt@intel.com
Cc: intel-wired-lan@lists.osuosl.org, Danny Gonzalez <digonzal@google.com>
Content-Type: text/plain; charset="UTF-8"
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

On Fri, Sep 4, 2026 at 6:37 AM Paul Greenwalt <paul.greenwalt@intel.com> wrote:
>
> Add a devlink instance for the idpf adapter and implement the .info_get
> callback, reporting:
>   - serial_number: PCI Device Serial Number, for device identification
>   - fw.mgmt.api: running version of the driver-device communication
>     channel (virtchnl)
>
> This enables NIPA CI and other tools to uniquely identify devices under
> test and track device capabilities. This phased implementation initially
> focuses on stable, readily available information. Firmware version
> information will be added in future patches as support is exposed
> through virtchnl and the driver architecture allows reliable retrieval.
>
> The adapter structure is carved out of the devlink private area, so
> devlink_alloc() replaces the plain kzalloc_obj() in idpf_probe() and
> devlink_free() replaces the corresponding kfree() on both the probe
> error path and in idpf_remove(). The instance is registered in
> idpf_probe(), before the reset worker that performs the virtchnl
> handshake is queued, and unregistered in idpf_remove(), so it stays
> available for the whole time the driver is bound.
>
> The serial number is omitted on devices that do not implement the PCI
> Device Serial Number extended capability, where pci_get_dsn() returns 0,
> rather than reporting an all-zero serial number. The virtchnl version is
> omitted until it has been negotiated, as the instance is registered
> before the handshake runs.
>
> $ devlink dev show
> pci/0000:85:00.0
>
> $ devlink dev info pci/0000:85:00.0
> pci/0000:85:00.0:
>   driver idpf
>   serial_number 00-a0-c9-ff-ff-23-45-67
>   versions:
>       running:
>         fw.mgmt.api 2.0
>
> Link: https://github.com/linux-netdev/nipa/wiki/Netdev-CI-system#device-information
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> ---

Verified the devlink info output:

$ devlink -j dev info pci/0000:05:00.0
{"info":{"pci/0000:05:00.0":{"driver":"idpf","versions":{"running":{"fw.mgmt.api":"2.0"}}}}}

Tested-by: Danny Gonzalez <digonzal@google.com>

>  Documentation/networking/devlink/idpf.rst     | 30 ++++++
>  Documentation/networking/devlink/index.rst    |  1 +
>  drivers/net/ethernet/intel/idpf/Kconfig       |  1 +
>  drivers/net/ethernet/intel/idpf/Makefile      |  1 +
>  .../net/ethernet/intel/idpf/idpf_devlink.c    | 98 +++++++++++++++++++
>  .../net/ethernet/intel/idpf/idpf_devlink.h    | 45 +++++++++
>  drivers/net/ethernet/intel/idpf/idpf_main.c   | 13 ++-
>  7 files changed, 186 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/networking/devlink/idpf.rst
>  create mode 100644 drivers/net/ethernet/intel/idpf/idpf_devlink.c
>  create mode 100644 drivers/net/ethernet/intel/idpf/idpf_devlink.h
>
> diff --git a/Documentation/networking/devlink/idpf.rst b/Documentation/networking/devlink/idpf.rst
> new file mode 100644
> index 0000000000000..5121cffd8f476
> --- /dev/null
> +++ b/Documentation/networking/devlink/idpf.rst
> @@ -0,0 +1,30 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +====================
> +idpf devlink support
> +====================
> +
> +This document describes the devlink features implemented by the ``idpf``
> +device driver.
> +
> +Info versions
> +=============
> +
> +The ``idpf`` driver reports the following versions
> +
> +.. list-table:: devlink info versions implemented
> +    :widths: 5 5 5 90
> +
> +    * - Name
> +      - Type
> +      - Example
> +      - Description
> +    * - ``fw.mgmt.api``
> +      - running
> +      - 2.0
> +      - 2-digit version number (major.minor) of the communication channel
> +        (virtchnl) used by the device.
> +
> +The driver also reports the PCI Device Serial Number through the
> +``serial_number`` attribute, on devices that implement the PCI Device Serial
> +Number extended capability.
> diff --git a/Documentation/networking/devlink/index.rst b/Documentation/networking/devlink/index.rst
> index d4a83fdcff7fe..538494b1051bd 100644
> --- a/Documentation/networking/devlink/index.rst
> +++ b/Documentation/networking/devlink/index.rst
> @@ -85,6 +85,7 @@ parameters, info versions, and other features it supports.
>     hns3
>     i40e
>     ice
> +   idpf
>     ionic
>     iosm
>     ixd
> diff --git a/drivers/net/ethernet/intel/idpf/Kconfig b/drivers/net/ethernet/intel/idpf/Kconfig
> index 586df3a4afe90..4ee8bbc401fe6 100644
> --- a/drivers/net/ethernet/intel/idpf/Kconfig
> +++ b/drivers/net/ethernet/intel/idpf/Kconfig
> @@ -6,6 +6,7 @@ config IDPF
>  	depends on PCI_MSI
>  	depends on PTP_1588_CLOCK_OPTIONAL
>  	select DIMLIB
> +	select NET_DEVLINK
>  	select LIBIE_CP
>  	select LIBETH_XDP
>  	help
> diff --git a/drivers/net/ethernet/intel/idpf/Makefile b/drivers/net/ethernet/intel/idpf/Makefile
> index 4aaafa175ec37..81b27a4067478 100644
> --- a/drivers/net/ethernet/intel/idpf/Makefile
> +++ b/drivers/net/ethernet/intel/idpf/Makefile
> @@ -7,6 +7,7 @@ obj-$(CONFIG_IDPF) += idpf.o
>
>  idpf-y := \
>  	idpf_dev.o		\
> +	idpf_devlink.o		\
>  	idpf_ethtool.o		\
>  	idpf_idc.o		\
>  	idpf_lib.o		\
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_devlink.c b/drivers/net/ethernet/intel/idpf/idpf_devlink.c
> new file mode 100644
> index 0000000000000..afdb5bc2e002c
> --- /dev/null
> +++ b/drivers/net/ethernet/intel/idpf/idpf_devlink.c
> @@ -0,0 +1,98 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (C) 2026 Intel Corporation */
> +
> +#include <linux/pci.h>
> +#include <linux/unaligned.h>
> +
> +#include "idpf.h"
> +#include "idpf_devlink.h"
> +
> +#define IDPF_DEVLINK_INFO_LEN		128
> +
> +/**
> + * idpf_info_get_dsn - format the PCI DSN as the device serial number
> + * @adapter: the idpf adapter structure
> + * @buf: buffer to store the formatted serial number
> + * @buf_size: size of @buf
> + *
> + * Return: true if the device reports a DSN, false otherwise.
> + */
> +static bool idpf_info_get_dsn(struct idpf_adapter *adapter, char *buf,
> +			      size_t buf_size)
> +{
> +	u64 dsn = pci_get_dsn(adapter->pdev);
> +	u8 dsn_be[sizeof(dsn)];
> +
> +	if (!dsn)
> +		return false;
> +
> +	/* Copy the DSN into an array in Big Endian format */
> +	put_unaligned_be64(dsn, dsn_be);
> +	snprintf(buf, buf_size, "%8phD", dsn_be);
> +
> +	return true;
> +}
> +
> +/**
> + * idpf_devlink_info_get - .info_get devlink handler
> + * @devlink: devlink instance structure
> + * @req: the devlink info request
> + * @extack: extended netlink ack structure
> + *
> + * Callback for the devlink .info_get operation. Reports information about the
> + * device. The virtchnl version is only reported once it has been negotiated,
> + * as the instance is registered before the handshake runs.
> + *
> + * Return: zero on success or a negative error code on failure.
> + */
> +static int idpf_devlink_info_get(struct devlink *devlink,
> +				 struct devlink_info_req *req,
> +				 struct netlink_ext_ack *extack)
> +{
> +	struct idpf_adapter *adapter = devlink_priv(devlink);
> +	char buf[IDPF_DEVLINK_INFO_LEN];
> +	u32 maj, min;
> +	int err;
> +
> +	if (idpf_info_get_dsn(adapter, buf, sizeof(buf))) {
> +		err = devlink_info_serial_number_put(req, buf);
> +		if (err)
> +			return err;
> +	}
> +
> +	maj = READ_ONCE(adapter->virt_ver_maj);
> +	min = READ_ONCE(adapter->virt_ver_min);
> +	if (!maj && !min)
> +		return 0;
> +
> +	snprintf(buf, sizeof(buf), "%u.%u", maj, min);
> +
> +	return devlink_info_version_running_put(req,
> +					DEVLINK_INFO_VERSION_GENERIC_FW_MGMT_API,
> +					buf);
> +}
> +
> +static const struct devlink_ops idpf_devlink_ops = {
> +	.info_get = idpf_devlink_info_get,
> +};
> +
> +/**
> + * idpf_adapter_alloc - allocate devlink and return adapter
> + * @dev: IDPF device to allocate for
> + *
> + * Allocate a devlink instance for this device and return the private area as
> + * the adapter structure.
> + *
> + * Return: adapter structure on success, NULL on failure
> + */
> +struct idpf_adapter *idpf_adapter_alloc(struct device *dev)
> +{
> +	struct devlink *devlink;
> +
> +	devlink = devlink_alloc(&idpf_devlink_ops, sizeof(struct idpf_adapter),
> +				dev);
> +	if (!devlink)
> +		return NULL;
> +
> +	return devlink_priv(devlink);
> +}
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_devlink.h b/drivers/net/ethernet/intel/idpf/idpf_devlink.h
> new file mode 100644
> index 0000000000000..3ace09be8dddf
> --- /dev/null
> +++ b/drivers/net/ethernet/intel/idpf/idpf_devlink.h
> @@ -0,0 +1,45 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright (C) 2026 Intel Corporation */
> +
> +#ifndef _IDPF_DEVLINK_H_
> +#define _IDPF_DEVLINK_H_
> +#include <net/devlink.h>
> +
> +struct idpf_adapter;
> +
> +struct idpf_adapter *idpf_adapter_alloc(struct device *dev);
> +
> +/**
> + * idpf_devlink_free - teardown the devlink
> + * @adapter: IDPF adapter structure to free
> + */
> +static inline void idpf_devlink_free(struct idpf_adapter *adapter)
> +{
> +	struct devlink *devlink = priv_to_devlink(adapter);
> +
> +	devlink_free(devlink);
> +}
> +
> +/**
> + * idpf_devlink_register - register the devlink
> + * @adapter: IDPF adapter structure
> + */
> +static inline void idpf_devlink_register(struct idpf_adapter *adapter)
> +{
> +	struct devlink *devlink = priv_to_devlink(adapter);
> +
> +	devlink_register(devlink);
> +}
> +
> +/**
> + * idpf_devlink_unregister - unregister the devlink
> + * @adapter: IDPF adapter structure
> + */
> +static inline void idpf_devlink_unregister(struct idpf_adapter *adapter)
> +{
> +	struct devlink *devlink = priv_to_devlink(adapter);
> +
> +	devlink_unregister(devlink);
> +}
> +
> +#endif /* _IDPF_DEVLINK_H_ */
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
> index 3dbbe21459990..34a69bb2e36bc 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_main.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
> @@ -3,6 +3,7 @@
>
>  #include "idpf.h"
>  #include "idpf_devids.h"
> +#include "idpf_devlink.h"
>  #include "idpf_lan_vf_regs.h"
>  #include "idpf_virtchnl.h"
>
> @@ -127,12 +128,15 @@ static void idpf_remove(struct pci_dev *pdev)
>
>  	set_bit(IDPF_REMOVE_IN_PROG, adapter->flags);
>
> +	idpf_devlink_unregister(adapter);
> +
>  	/* Wait until vc_event_task is done to consider if any hard reset is
>  	 * in progress else we may go ahead and release the resources but the
>  	 * thread doing the hard reset might continue the init path and
>  	 * end up in bad state.
>  	 */
>  	cancel_delayed_work_sync(&adapter->vc_event_task);
> +
>  	if (adapter->num_vfs)
>  		idpf_sriov_configure(pdev, 0);
>
> @@ -184,7 +188,8 @@ static void idpf_remove(struct pci_dev *pdev)
>  	mutex_destroy(&adapter->vc_buf_lock);
>
>  	idpf_decfg_device(adapter);
> -	kfree(adapter);
> +
> +	idpf_devlink_free(adapter);
>  }
>
>  /**
> @@ -263,7 +268,7 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	struct idpf_adapter *adapter;
>  	int err;
>
> -	adapter = kzalloc_obj(*adapter);
> +	adapter = idpf_adapter_alloc(dev);
>  	if (!adapter)
>  		return -ENOMEM;
>
> @@ -349,6 +354,8 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	INIT_DELAYED_WORK(&adapter->stats_task, idpf_statistics_task);
>  	INIT_DELAYED_WORK(&adapter->vc_event_task, idpf_vc_event_task);
>
> +	idpf_devlink_register(adapter);
> +
>  	adapter->dev_ops.reg_ops.reset_reg_init(adapter);
>  	set_bit(IDPF_HR_DRV_LOAD, adapter->flags);
>  	queue_delayed_work(adapter->vc_event_wq, &adapter->vc_event_task,
> @@ -367,7 +374,7 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  err_init_wq:
>  	idpf_decfg_device(adapter);
>  err_free:
> -	kfree(adapter);
> +	idpf_devlink_free(adapter);
>  	return err;
>  }
>
> --
> 2.52.0
