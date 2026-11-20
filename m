Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA972606A320
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Nov 2026 08:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=z68QAD6S;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=knwuWJ5b
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 943736065F;
	Fri, 20 Nov 2026 08:35:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qyBfZBI4qBuG; Fri, 20 Nov 2026 08:35:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B422F6068A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795163723;
	b=UpRVdWP/wAReq7QuNZa6E5Z5uvrcRaLM47XSefTnL+F4am2hw43Bg1vZv7cblwPXDiG8
	 cAf375SpIpWdKZPrk9dIo3z1JhvCz7QM9P8YbVJaztYLbiz0r8153k69gjTMg+kCM43YA
	 9hOZd0JQ3lZVuyatkiGWmMTKudCqePCppl9TP44hhw+8VamytDjYly/qXOFEfNKjjoMe7
	 FEl4iFrxOF5cy0Sj1FLUEEhFL3/HFnrYC5J8OGUtANahDtrAOU5gTHtS87foXK0dXRikx
	 h5uLZTQOVzgLwS6u9U4MfEoNULZRCqCVV5TTDij5yNXDoNcHxubfKxFKnf/Ln/L49pw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795163723;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=cGln8FVjtHumSWCLAXROuRIIllin/ovk1fH3wXcljBI=;
	b=QoJnm6P3Q4hqT9nL/jEGUd5/MTTJAQ2qKZrHRAYELobzE5JU3rb4DEcV18tb5ZHhJKOT
	 CUICKXQTZgUR50E/q8GFwE3XPMhitPDRj5Bkia35uHkWQ/P/l4T0SE0C9Iw5cugWgiTZN
	 pdQZvVAiqBEKmKgjg1RHHZuUrarw0QaQiH6XrMX5C1Mx5Zxkj95BMyHeHzkzJm2ovLV58
	 lHJix9+4CQZtOziuNUIiR+Kk3+fjW4JldG+CnMzJiFD2oSbsS5tSPuxWlCeHM4l3OnYXb
	 Ys2LofwdCwj+1xhl/45r69/QgmHjTowHq87QwwdQo7E3LC5ymK9OY5b0k8zpuI+iX5g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795163723;
	bh=cGln8FVjtHumSWCLAXROuRIIllin/ovk1fH3wXcljBI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=z68QAD6Svc0wtrJWGpEoJk8NSvBpw5ProKGfZZYZbEZqeinmQ2pwcooy3luC2k/YV
	 AS1jGtuVFlvCO7VGBDKn2j8RgrGgQOJSB7I/vY3cnFq/C58FKo3dwxOzuoXtJpsr2V
	 geT3CWy5Tnk5Uufhua2JFOVeoQQbDaF0hnHmzS94flAHtqD70ghlESFbUQYG7IMYz8
	 dcMTeesofxnIXmY2ROlGAYp0YGACQ12rd5V9vZQdQj7sbDZxXH5NQCn55CdXEGedZm
	 HZSTtKYsjNqiizFKcP5NK23GNDBOTVQTaejx5VaFuLrOIO4BQsmczAQiEjl0h0diWp
	 AEN3wmTo7/y5A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B422F6068A;
	Fri, 20 Nov 2026 08:35:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 469211E7
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 08:35:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 440A54020D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 08:35:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ncte0nYhkTpe for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Nov 2026 08:35:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 54D06400D6
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::62e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com;
 envelope-from=magnus.karlsson@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=knwuWJ5b
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 54D06400D6
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 08:35:20 +0000 (UTC)
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2f0458cc9easo3076215ad.3
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 00:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795163720; x=1795768520; darn=lists.osuosl.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=cGln8FVjtHumSWCLAXROuRIIllin/ovk1fH3wXcljBI=;
 b=knwuWJ5bQbAuwMf/fPSyUww+xWiLHt55Y7aQdZPJnMfyadODsJrCCVBuy/uDTc9LFw
 zcYn9PhxRKuOLWhzFaRhXa5dFPZ7HXjwYZt35sTyl4yiSoljzFDAsN8N8n70y0bmpGHR
 rRsexhn80orIoeMaTw8USVZDw0MQJv9VO6TcGnx7VQB35i0aAgGB8XIo34b17LJwlmnu
 K9++b+6s5Kn2PjjNy3hL+ioAQIktcxp+PFd/gdZxV73ibfdWJ5oNqpNNNZw+PmDRDgJ4
 AHFxl7eWmOuk+8cpk+u0S7rO/ptGQEuwFexjLKf9IjwmBF82ACqwWoITYMzFh7FExecs
 WfKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795163720; x=1795768520;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=cGln8FVjtHumSWCLAXROuRIIllin/ovk1fH3wXcljBI=;
 b=nrBfa/Kfsvpf0a2y/8iBb09CYjAImXHSYoDruLwqk6GaVpH0qD+/y2DH8qJoDSQbJw
 Fug4b8i+5xb07UOGrLI2mkHBFopVGriUBDcCWUx7RvQRZ93Pmz9KZe+R9E51rt/ZLmdm
 p9vm0UibmDYMaYzZcShyrwif9mTEew7BcwLZYn4jdnN29ovhDoDH4PZ4cCxAw/RN6WYQ
 5GvEEiWck0Lw+IBgomptjSrN9wvXmAngSFFt6LeG55v5ax57/9EFqYpr80HnZwN8qVln
 KbSeZpMgUODqqprZUTKYMxc82epLW6j+TbU3JuYpstfAM+ngIFaRioaQ0QFFs90fMKmj
 iq8w==
X-Forwarded-Encrypted: i=1;
 AL+hErHRp3mMooBljMXcUhd3vmBluuuJpKU1NBhFbkCOAgjABnB0Lef5dxbvCSztXNdI+wDt1BfiKwb7jmk0hrh/oaA=@lists.osuosl.org
X-Gm-Message-State: APuU4Z8++YqFJ2GGooM8uaQ+GRsHp97M6BXaeehhYlqzSpow1PsD+BcJ
 4oEeut7XO/sSk61I/QKgOY5OIam4YNPvQtyEYHBMHSBGx3GoLTeTiY28wv0uAveJUHhkVSz+M2b
 aet6CelU8SL0HwQwBj6OKoYYcEjVOMnk=
X-Gm-Gg: AZFdTZfkY4MSMuHq67DujwPmpev3aZErt9P/oGNC4ZmkM12dOy9+vyYwMW8oDqbDuTi
 ahYiW408pjsJr9IUACVJ/dhEwPISzIvIUejwvhFHDbYrLZ+25NCqJq4qq1dSJjWgR9OhN5NxJIu
 yXuaDRmH+wRqzHL0kAb6NHWSXZb+5NqZ01HUdr63yURCQg2O8BUoprlZx9nmyJbkECFPgNKc7SW
 k/5T8G+hEtwuvgYPeDLwnQCnasebuHRnqdack7H+slgGqluYyZkUyk7z1VbEin0wlzhSpqu6YXw
 v6xiC1CytlhVoUVXL6JlEJISjldKFlxyHvgd1ER+kJZiVuvvIEWZRYVVtLeKAJNIwBNI+/h6eK9
 69kM1xVUtEGErwzJZcCSYvShegY6cTQhNpnthIxo=
X-Received: by 2002:a17:902:ef45:b0:2ef:d7ed:80dc with SMTP id
 d9443c01a7336-2f03f1e0d55mr25140855ad.49.1795163720037; Fri, 20 Nov 2026
 00:35:20 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261119165340.1071525-1-magnus.karlsson@intel.com>
 <20261119165340.1071525-6-magnus.karlsson@intel.com> <av9Ia2gpMyF9jTuE@boxer>
In-Reply-To: <av9Ia2gpMyF9jTuE@boxer>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Fri, 20 Nov 2026 09:35:05 +0100
X-Gm-Features: AclHuK_6RZLdCqEfKboKrqBzIVM-urAOCv16V7vZrfePzBVVCw2zR12hPxAdyU4
Message-ID: <CAJ8uoz0cv7j7=nHt6ikw4JnJOHA0NTstjN1iKYswGjH8jeWBZw@mail.gmail.com>
Subject: Re: [PATCH net-next 5/5] selftests: net: add AF_XDP USO test
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>, netdev@vger.kernel.org,
 sdf@fomichev.me, 
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
 horms@kernel.org, bjorn@kernel.org, kerneljasonxing@gmail.com, 
 intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com, 
 przemyslaw.kitszel@intel.com, jacob.e.keller@intel.com
Content-Type: text/plain; charset="UTF-8"
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
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 19 Nov 2026 at 20:05, Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Thu, Nov 19, 2026 at 05:53:40PM +0100, Magnus Karlsson wrote:
> > Add xsk_uso, a functional test for AF_XDP UDP segmentation offload in
> > copy and zero-copy mode. It sends USO requests from an AF_XDP socket
> > and checks the datagrams received on a packet socket: the number of
> > datagrams, the IP and UDP lengths, the checksums and the payload, for
> > IPv4 and IPv6, and single and multi-buffer requests. It also checks
> > that invalid requests are dropped and counted in tx_invalid_descs.
> >
> > The test needs root and physical NICs with an MTU of at least 1448,
> > either two connected ports (-i TX_IFACE -r RX_IFACE) or one in NIC
> > loopback (-l -i IFACE). Virtual devices such as veth pass the packet on
> > without segmenting it. Zero copy (-z) also needs a native XDP program on
> > the interface. Standalone checksum offload cases run only with -C, as
> > they test the existing checksum offload rather than USO. As it needs
> > real hardware, it is built but not run by default, like xdp_hw_metadata.
> > It uses the AF_XDP library in net/lib/xsk.
>
> I assume the end goal for xdp_hw_metadata is to pull in its contents onto
> xsk python runner. What is the case for this one?

It should be merged into the python runner that you are working on.
But I need that to land first before I can move this. You could say
that this patch is just temporary until your stuff has landed.

> Also since you're adding support to copy mode i assume veth runs would be
> welcome...

While veth accepts USO, it will never segment the packet. The skb will
just be delivered to the other side as is, so we need real HW for
these tests.

> Did you try to point AI to my set and ask whether it would be able to
> produce python runner for that? Or do we don't want to have this CI'ed ?

I am sure that is possible, but I will spend those tokens once your
move has landed. We definitely want this to be in the CI and
integrated with your stuff.

> >
> > Missing prerequisites are reported as skips. In zero-copy mode, the
> > device must report xsk-zerocopy and tx-uso-zc, and checksum-only cases
> > need tx-checksum. In both modes, cases that produce more than one
> > datagram need tx-udp-segmentation, including the invalid ones, which
> > would otherwise be dropped for lack of the offload whatever their
> > headers. Cases that need more descriptors than xdp-zc-max-segs are
> > skipped, and so are binds that the device refuses with EOPNOTSUPP.
> > Receive-side UDP GRO (rx-udp-gro-forwarding, rx-gro-list) must be off,
> > as it would merge the segments again before the packet socket sees them.
> > USO with launch time must succeed in copy mode and be dropped in
> > zero-copy mode.
> >
> > Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> > ---
> >  tools/testing/selftests/net/.gitignore |   1 +
> >  tools/testing/selftests/net/Makefile   |  10 +-
> >  tools/testing/selftests/net/xsk_uso.c  | 954 +++++++++++++++++++++++++
> >  3 files changed, 964 insertions(+), 1 deletion(-)
> >  create mode 100644 tools/testing/selftests/net/xsk_uso.c
> >
>
> ...
>
> > +
> > +static void get_mac(const char *name, unsigned char *mac)
> > +{
> > +     struct ifreq ifr = {};
> > +     int fd = socket(AF_INET, SOCK_DGRAM, 0);
> > +
> > +     if (fd < 0)
> > +             ksft_exit_fail_msg("socket: %s\n", strerror(errno));
> > +     snprintf(ifr.ifr_name, sizeof(ifr.ifr_name), "%s", name);
> > +     if (ioctl(fd, SIOCGIFHWADDR, &ifr))
> > +             ksft_exit_fail_msg("MAC address for %s: %s\n", name, strerror(errno));
> > +     memcpy(mac, ifr.ifr_hwaddr.sa_data, ETH_ALEN);
> > +     close(fd);
> > +}
> > +
> > +static unsigned int get_mtu(const char *name)
> > +{
> > +     struct ifreq ifr = {};
> > +     int fd = socket(AF_INET, SOCK_DGRAM, 0);
> > +
> > +     snprintf(ifr.ifr_name, sizeof(ifr.ifr_name), "%s", name);
> > +     if (fd < 0 || ioctl(fd, SIOCGIFMTU, &ifr))
> > +             ksft_exit_fail_msg("MTU of %s: %s\n", name, strerror(errno));
> > +     close(fd);
> > +     return ifr.ifr_mtu;
> > +}
>
> this is a lib content which i'm also adding, so we're gonna clash.
>
> > +
> > +/* Virtual devices have no backing device, and pass GSO packets on whole. */
> > +static bool is_physical(const char *name)
> > +{
> > +     char path[64];
> > +
> > +     snprintf(path, sizeof(path), "/sys/class/net/%s/device", name);
> > +     return !access(path, F_OK);
> > +}
> > +
> > +static int ethtool_ioctl(const char *name, void *cmd)
> > +{
> > +     struct ifreq ifr = { .ifr_data = cmd };
> > +     int fd = socket(AF_INET, SOCK_DGRAM, 0), err;
> > +
> > +     if (fd < 0)
> > +             return -1;
> > +     snprintf(ifr.ifr_name, sizeof(ifr.ifr_name), "%s", name);
> > +     err = ioctl(fd, SIOCETHTOOL, &ifr);
> > +     close(fd);
> > +     return err;
> > +}
> > +
> > +/* Returns whether the netdev feature called @feature is active on @name. */
> > +static bool feature_active(const char *name, const char *feature)
> > +{
> > +     struct ethtool_gfeatures *features = NULL;
> > +     struct ethtool_gstrings *strings = NULL;
> > +     struct ethtool_sset_info *sset;
> > +     unsigned int count, blocks, i;
> > +     bool active = false;
> > +
> > +     sset = calloc(1, sizeof(*sset) + sizeof(sset->data[0]));
> > +     if (!sset)
> > +             ksft_exit_fail_msg("calloc: %s\n", strerror(errno));
> > +     sset->cmd = ETHTOOL_GSSET_INFO;
> > +     sset->sset_mask = 1ULL << ETH_SS_FEATURES;
> > +     if (ethtool_ioctl(name, sset))
> > +             ksft_exit_fail_msg("ETHTOOL_GSSET_INFO: %s\n", strerror(errno));
> > +     if (!sset->sset_mask)
> > +             ksft_exit_fail_msg("%s reports no feature strings\n", name);
> > +     count = sset->data[0];
> > +     blocks = (count + 31) / 32;
> > +     strings = calloc(1, sizeof(*strings) + count * ETH_GSTRING_LEN);
> > +     features = calloc(1, sizeof(*features) +
> > +                       blocks * sizeof(features->features[0]));
> > +     if (!strings || !features)
> > +             ksft_exit_fail_msg("calloc: %s\n", strerror(errno));
> > +     strings->cmd = ETHTOOL_GSTRINGS;
> > +     strings->string_set = ETH_SS_FEATURES;
> > +     strings->len = count;
> > +     features->cmd = ETHTOOL_GFEATURES;
> > +     features->size = blocks;
> > +     if (ethtool_ioctl(name, strings) || ethtool_ioctl(name, features))
> > +             ksft_exit_fail_msg("ethtool features: %s\n", strerror(errno));
> > +     for (i = 0; i < count; i++)
> > +             if (!strncmp((char *)strings->data + i * ETH_GSTRING_LEN, feature,
> > +                          ETH_GSTRING_LEN)) {
> > +                     active = features->features[i / 32].active & (1U << (i % 32));
> > +                     break;
> > +             }
> > +     free(features);
> > +     free(strings);
> > +     free(sset);
> > +     return active;
> > +}
> > +
> > +static void get_xdp_features(unsigned int ifindex, uint64_t *xdp, uint64_t *xsk,
> > +                          unsigned int *zc_max_segs)
> > +{
> > +     struct netdev_dev_get_req *req;
> > +     struct netdev_dev_get_rsp *rsp;
> > +     struct ynl_error yerr;
> > +     struct ynl_sock *ys;
> > +
> > +     ys = ynl_sock_create(&ynl_netdev_family, &yerr);
> > +     if (!ys)
> > +             ksft_exit_fail_msg("YNL: %s\n", yerr.msg);
> > +     req = netdev_dev_get_req_alloc();
> > +     if (!req)
> > +             ksft_exit_fail_msg("netdev_dev_get_req_alloc failed\n");
> > +     netdev_dev_get_req_set_ifindex(req, ifindex);
> > +     rsp = netdev_dev_get(ys, req);
> > +     netdev_dev_get_req_free(req);
> > +     if (!rsp)
> > +             ksft_exit_fail_msg("netdev dev-get: %s\n", ys->err.msg);
> > +     *xdp = rsp->_present.xdp_features ? rsp->xdp_features : 0;
> > +     *xsk = rsp->_present.xsk_features ? rsp->xsk_features : 0;
> > +     *zc_max_segs = rsp->_present.xdp_zc_max_segs ? rsp->xdp_zc_max_segs : 1;
> > +     netdev_dev_get_rsp_free(rsp);
> > +     ynl_sock_destroy(ys);
>
> you really should look at python drv-net infra...
