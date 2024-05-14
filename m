Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 891E8C04FFE
	for <intel-wired-lan@archiver.kernel.org>; Tue, 14 May 2024 08:09:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3F63D407B9;
	Tue, 14 May 2024 08:09:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7EeScyvWNzjn; Tue, 14 May 2024 08:09:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8F56440671
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1715674187;
	bh=4eXfZhzqpqMxxqMfSDt/iMj3dyX/0STQtNt3Xv738Y4=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=Z8zOdnHGVlNZOQOofWTT5OjTNdFTrADGUSKvQR8PwRK0qb3nKs9+ma42JrPBV5a4N
	 aYKtEqkG1qwAyeENYA/PiZL7bMvCcRtb66IwsXenl5IgyueibEofEaFMu6AiMGpqgv
	 4uwPDrUd63JY4GNR+yjYdMg+Bado/cQLmF0c7tmZ5in29FzCr6jd0HOR1F61RR0eyT
	 n5j7PF3B3MuufiBbh3Hwdxw+4b0xBPiRjFfJWPEWq+6sI2QzOxhdqCc2CfjbsgUHC9
	 NLeTboetu+FqMxRR8bLZ9jo/qgH1cxvL9gMwG5grQvR9j9plI2eQhn1PRT3DO4kqTi
	 zZ/N6EsXHYmPg==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8F56440671;
	Tue, 14 May 2024 08:09:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id C802E1BF2FD
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 May 2024 08:09:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B285D40671
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 May 2024 08:09:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vrC-iqny5w6G for <intel-wired-lan@lists.osuosl.org>;
 Tue, 14 May 2024 08:09:45 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=jiri@resnulli.us; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org AD2974064B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AD2974064B
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AD2974064B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 May 2024 08:09:42 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-420180b58c3so12166785e9.2
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 May 2024 01:09:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715674180; x=1716278980;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4eXfZhzqpqMxxqMfSDt/iMj3dyX/0STQtNt3Xv738Y4=;
 b=D41TrpFrP9DIP5FR547H5wUcWAqwf9GRLV9kiz03mrP+Pzw483+iQYMnI7P/vVEzxq
 /nKQytAlSAoD7se0jN1yU3sCFxwXt3mI50f+Ls0JUjecdGl2eNfFvEF0P1kFRTPEM5dp
 oZjINyYwb5HouKLdNNtoHqHdovagdrKqyGzPMPUYdeZ/p0XoBNFzBBFvstP15/LYt0w/
 ZhTDhxVxdoMA6UcGBd/jnv3s+uK+c8kTdbTaCkYeVC38iVfAWZcDY849Ip3JuzjglbiR
 OGupCISPV4L7741F4shGgrncKnCPOCDAoERXcvzoV+WfBrtMZ7REv+aq679ybhbNDmVH
 RQog==
X-Gm-Message-State: AOJu0YwLE3YYOMFrp3yHaA/bTVEAoWUuxDZGOYw6uear2bh1zWKNXwo2
 I5XuW2z1RB5ti3MPMagcekg9wOo7+KHzTJcTg/8FNTn76JRxW6/UZ8TuYwiSM74=
X-Google-Smtp-Source: AGHT+IEKybC29u5QFqLb0noL3UM0DJR98zKLIls5EVTQA+hArm3Tc/2NQxav9keJQlFXSA7NuiIfNg==
X-Received: by 2002:a05:600c:a04:b0:41b:ca45:8263 with SMTP id
 5b1f17b1804b1-41fea93a609mr96726025e9.12.1715674180328; 
 Tue, 14 May 2024 01:09:40 -0700 (PDT)
Received: from localhost ([193.47.165.251]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-420149b1c24sm73755965e9.41.2024.05.14.01.09.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 May 2024 01:09:39 -0700 (PDT)
Date: Tue, 14 May 2024 10:09:36 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Message-ID: <ZkMcQII3AlfMu2Yl@nanopsycho.orion>
References: <20240513083735.54791-1-michal.swiatkowski@linux.intel.com>
 <20240513083735.54791-4-michal.swiatkowski@linux.intel.com>
 <ZkHztwMeJFU73WQm@nanopsycho.orion> <ZkH9DurNJ/OFDvT/@mev-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkH9DurNJ/OFDvT/@mev-dev>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1715674180; x=1716278980;
 darn=lists.osuosl.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4eXfZhzqpqMxxqMfSDt/iMj3dyX/0STQtNt3Xv738Y4=;
 b=l8KS+E2vfBuf8UyVm6PVaXJVwwu8iGr7TFMXbXLeb5zDWrvIqCUVGODvv+4OgGmqYL
 QSyfgjoeJnbKQ7xhzQxtWMsqWnzGUohNP+EyfzIVgXfIq/3CYgDUf983kaoogTxc8JBM
 IBjal9PO+ryPfv3ridbKEYaZ05EKRjTiozrWj4NuQQKvrFjfVoAZ4TvGbT8jqxKixkQn
 ImR3KLduzQiE7OPKRzaY/DFWzM6BkaMbfDBMCBIckPsvL75DJpsEvGX4HkKEfTeURAQS
 JFzU9xLvNZ3FgkJLusVzwkhTanv1d14TA37uHC+0kaiGuWV7dREVDUdMgT1BJsEU0x7l
 l7+A==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=resnulli.us
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=resnulli-us.20230601.gappssmtp.com
 header.i=@resnulli-us.20230601.gappssmtp.com header.a=rsa-sha256
 header.s=20230601 header.b=l8KS+E2v
Subject: Re: [Intel-wired-lan] [iwl-next v2 03/15] ice: add basic devlink
 subfunctions support
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
Cc: shayd@nvidia.com, maciej.fijalkowski@intel.com,
 mateusz.polchlopek@intel.com, netdev@vger.kernel.org, jiri@nvidia.com,
 michal.kubiak@intel.com, intel-wired-lan@lists.osuosl.org,
 pio.raczynski@gmail.com, sridhar.samudrala@intel.com, jacob.e.keller@intel.com,
 wojciech.drewek@intel.com, przemyslaw.kitszel@intel.com
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Mon, May 13, 2024 at 01:44:14PM CEST, michal.swiatkowski@linux.intel.com wrote:
>On Mon, May 13, 2024 at 01:04:23PM +0200, Jiri Pirko wrote:
>> Mon, May 13, 2024 at 10:37:23AM CEST, michal.swiatkowski@linux.intel.com wrote:
>> 
>> [...]
>> 
>> 
>> 
>> >+int ice_devlink_create_sf_port(struct ice_dynamic_port *dyn_port)
>> >+{
>> >+	struct devlink_port_attrs attrs = {};
>> >+	struct devlink_port *devlink_port;
>> >+	struct devlink *devlink;
>> >+	struct ice_vsi *vsi;
>> >+	struct device *dev;
>> >+	struct ice_pf *pf;
>> >+	int err;
>> >+
>> >+	vsi = dyn_port->vsi;
>> >+	pf = dyn_port->pf;
>> >+	dev = ice_pf_to_dev(pf);
>> >+
>> >+	devlink_port = &dyn_port->devlink_port;
>> >+
>> >+	attrs.flavour = DEVLINK_PORT_FLAVOUR_PCI_SF;
>> >+	attrs.pci_sf.pf = pf->hw.bus.func;
>> >+	attrs.pci_sf.sf = dyn_port->sfnum;
>> >+
>> >+	devlink_port_attrs_set(devlink_port, &attrs);
>> >+	devlink = priv_to_devlink(pf);
>> >+
>> >+	err = devl_port_register_with_ops(devlink, devlink_port, vsi->idx,
>> >+					  &ice_devlink_port_sf_ops);
>> >+	if (err) {
>> >+		dev_err(dev, "Failed to create devlink port for Subfunction %d",
>> >+			vsi->idx);
>> 
>> Either use extack or avoid this error message entirely. Could you please
>> double you don't write dmesg error messages in case you have extack
>> available in the rest of this patchset?
>> 
>> 
>
>Sure, I can avoid, as this is called from port representor creeation
>function. I don't want to pass extack there (code is generic for VF and
>SF, and VF call doesn't have extack).
>
>We have this pattern in few place in code (using dev_err even extack can
>be passed). Is it recommended to pass extact to all functions
>which probably want to write some message in case of error (assuming the
>call context has the extack)? 

Always.

>
>> >+		return err;
>> >+	}
>> >+
>> >+	return 0;
>> >+}
>> >+
>> 
>> [...]
