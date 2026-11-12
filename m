Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6137860A3839
	for <intel-wired-lan@archiver.kernel.org>; Thu, 12 Nov 2026 06:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=fFjBU4fS;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EXX4Bw0f
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3981540902;
	Thu, 12 Nov 2026 06:51:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vDqT2lX9Bhda; Thu, 12 Nov 2026 06:51:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E2B4340892
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794466285;
	b=M3SA518exRmlKP25Mr//W5HnIlbLyuVE23XZYTkUjODqZJNs8jtxd/5cCzHbVVCbs1FC
	 c98R6nz1X45UAsvnp1v0nglbWmCJNQnzjxizT+5IAelzIpYR1wsey/MkYnAWRTtjFSKZy
	 /r6cTt6tqzkh01RKJY2TNLY7XARgeJMAa3wjVU1XAZ0yBY4oFIArINiqdeEMsVJHuJyIp
	 jsZ9YWkYz+7tOIGN9b2ENH5AImn3mOOZs61oylKVLphgajIbCKxvaYLbFx0WYDIHbyPpH
	 dUnfFL3JVZiVvqPnOeAqfm2Fm+54kMqMltK2sTXB3UdEWA/4E0VJ02q4L0dvXqrGrBQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794466285;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=IH9il20ZjJIgSkam44X4Ugnx8QrSwePCKb9nP+mFcT8=;
	b=TFW7hHbkC5mFKsQ5TvsX/qodI4CT6dNQw/a4whakhvPHOODSsjJNygzSaIXoiK0+Hmdm
	 noeDySae/F0eEnaZPIKXqJetI+PRhUK/ms+uLB6m3xd9DC6AkGBvhK7rCBFZcEd8o+grn
	 5liYexTOzMHHE2xOwCEwt71cFD8cBmw/7hxfZ4nm1+bMBdHr7VK4Wk1FUk458VULYeRMv
	 AxxQhHwPZwdCus1012eA+CPDnLbgLbXGACUP1EsJHU+adk945wjxdDDcqS3HCPiP9s737
	 VxMZneZeUcdTs2e7Pdl7tTzTK1KE5n08LRZuHQ/5wzZDHMjX/kwvM+NvVPnJ3hANpEw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794466284;
	bh=IH9il20ZjJIgSkam44X4Ugnx8QrSwePCKb9nP+mFcT8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=fFjBU4fSwJHqSYwPWb0zThed+MnnN9ivsitsT4d4DHIS8qhc6V/SkRIO7lm8TiPwX
	 v/k2ytX8vDulfuDQof6pJoKDbbz7LNT+k1hFRn21oMDFr9C09rKagjeLnwLJYAqaFM
	 aLngjsQ2LJR1V3UQEsy/zKMT5q8A1p67W/rjIf8dw2sYyV2/h8UQ9i2GX9fq/+e+dC
	 KRws50rJ7SxGH1UwIvadWXof1O6nLJzPmXiEJqpfgTlwZSCba8fv9WVQmkOK2ChM0E
	 DSoFE1M+OMo57aS7lKZP3Xb4hNev5B/ndnCm0ojYdCkBtFgmQDRdnNxIgF85yP+S0M
	 1rfxjt28xsY+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E2B4340892;
	Thu, 12 Nov 2026 06:51:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C08841399
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Nov 2026 06:51:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B2301815D5
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Nov 2026 06:51:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d_a2uuLKQ5er for <intel-wired-lan@lists.osuosl.org>;
 Thu, 12 Nov 2026 06:51:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 666DA8128B
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=EXX4Bw0f
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 666DA8128B
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Nov 2026 06:51:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 36A5C612FE;
 Thu, 12 Nov 2026 06:51:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B511F00A06;
 Thu, 12 Nov 2026 06:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794466279;
 bh=IH9il20ZjJIgSkam44X4Ugnx8QrSwePCKb9nP+mFcT8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EXX4Bw0fIEDj3NmqjAVM2icnxwHyHSG1f0QjbHd6Nb4rGeL+lU/NHxrWJ3JzQqtXQ
 5a1aKfJVgVDDxjNKY7ezotal6ehhmpQ2xRYdMIz7EsAoueu1hIY3zDhA713fKsJFTg
 aXha7wmJsX/zYtT0wEFyaeFZlEMTgIPz+Mc2DtwvX3DZXxpzpphToXzdZdcPnXZJfR
 ZAaPm2GRmXF4MGNwAJ6HkFiAjeiT2qrgiitZA29oXIYbxHkx0MaIYzHdSJ6K7n7kRv
 nlFwi7psBtytDYe2H6bBIIzckgGoMc3hNAMildUgUB+A5+FJVRyTO45FZxjnRGYstY
 yTBmHS/9LheBg==
Message-ID: <sashiko-outbox-210542@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v6 3/3] igb: do not split AF_XDP zero-copy frames
 over several Rx buffers
To: "Tjerk Kusters" <tkusters@aweta.nl>
Cc: intel-wired-lan@lists.osuosl.org, bpf@vger.kernel.org
In-Reply-To: <20261111-igb-rx-ts-fix-v6-3-ba5b9903859c@aweta.nl>
References: <20261111-igb-rx-ts-fix-v6-0-ba5b9903859c@aweta.nl>
 <20261111-igb-rx-ts-fix-v6-3-ba5b9903859c@aweta.nl>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 06:51:19 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [Medium] igb: PF MAC filter clobber in igb_enable_sriov() before XSK
  queue check
- [Medium] igb: skipped PF reinit in igb_disable_sriov() when
  igb_sriov_reinit() fails
- [Medium] igb: unlocked VF state and flag rollback in
  igb_enable_sriov() on error
- [Medium] igb: stale real queue counts in __igb_open() break
  igb_xsk_pool() check
--

commit 0d73c7e718f3a4a479e43541f8ed94977b90b3db
Author: Tjerk Kusters <tkusters@aweta.nl>

igb: do not split AF_XDP zero-copy frames over several Rx buffers

This commit programs standard 2 KiB or 3 KiB hardware Rx buffer sizes for
AF_XDP zero-copy rings in igb_setup_srrctl() so frames are not split across
multiple descriptors, and rejects XSK pool bindings, MTU changes, and SR-IOV
queue reductions when frames or bound queues would no longer fit.

Link: https://lore.kernel.org/all/20261028083344.3047350-3-p@1g4.org/

> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethe=
rnet/intel/igb/igb_main.c
> index e787095d3cdbe..c9351a8c4f5e5 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -3777,9 +3777,29 @@ static int igb_sriov_reinit(struct pci_dev *dev)
>  	struct net_device *netdev =3D pci_get_drvdata(dev);
>  	struct igb_adapter *adapter =3D netdev_priv(netdev);
>  	struct pci_dev *pdev =3D adapter->pdev;
> +	unsigned int i, rxq, txq, end;
> =20
>  	rtnl_lock();
> =20
> +	/* With VFs the PF gets fewer Rx queues and a single Tx queue, see
> +	 * igb_set_interrupt_capability(). Refuse that while an XSK pool is
> +	 * bound to a queue the PF would lose; the core refuses ethtool -L in
> +	 * the same case.
> +	 */
> +	rxq =3D min_t(unsigned int, igb_get_max_rss_queues(adapter),
> +		    num_online_cpus());
> +	txq =3D adapter->vfs_allocated_count ? 1 : rxq;
> +	end =3D max(netdev->real_num_rx_queues, netdev->real_num_tx_queues);
> +	for (i =3D min(rxq, txq); i < end; i++) {
> +		if (xsk_get_pool_from_qid(netdev, i)) {
> +			rtnl_unlock();
> +			dev_err(&pdev->dev,
> +				"Cannot change the number of queues, an AF_XDP socket is bound to qu=
eue %u\n",
> +				i);
> +			return -EBUSY;
> +		}
> +	}
> +
>  	if (netif_running(netdev))
>  		igb_close(netdev);
>  	else

[Severity: Medium]
When igb_enable_sriov() fails here with -EBUSY, does returning before
igb_close() or igb_reset() wipe active PF unicast MAC filters in the upper
RAR slots?

Before calling igb_sriov_reinit(), igb_enable_sriov() calls
igb_vf_configure() -> igb_set_vf_mac() with a zero MAC address for each VF,
which overwrites the top adapter->vfs_allocated_count entries of
adapter->mac_table, marks them IGB_MAC_STATE_IN_USE, and clears E1000_RAH_AV
in the hardware RAR registers:

drivers/net/ethernet/intel/igb/igb_main.c:igb_set_vf_mac() {
    ...
	int rar_entry =3D hw->mac.rar_entry_count - (vf + 1);
	unsigned char *vf_mac_addr =3D adapter->vf_data[vf].vf_mac_addresses;

	ether_addr_copy(vf_mac_addr, mac_addr);
	ether_addr_copy(adapter->mac_table[rar_entry].addr, mac_addr);
	adapter->mac_table[rar_entry].queue =3D vf;
	adapter->mac_table[rar_entry].state |=3D IGB_MAC_STATE_IN_USE;
	igb_rar_set_index(adapter, rar_entry);
    ...
}

Previously igb_sriov_reinit() always ran igb_close() or igb_reset(), which
flushed the MAC table and unsynced netdev->uc via __dev_uc_unsync() before
re-syncing PF filters.  Returning early leaves netdev->uc marked synced whi=
le
any PF unicast filters (such as macvlan or bridge FDB entries) that occupied
those upper RAR slots are disabled in hardware and leaked as in-use until t=
he
next reset.

[Severity: Medium]
Can this check in igb_sriov_reinit() also return -EBUSY when called from
igb_disable_sriov(), after SR-IOV has already been torn down?

igb_disable_sriov() calls pci_disable_sriov(), frees adapter->vf_data, rese=
ts
adapter->vfs_allocated_count to 0, and writes E1000_IOVCTL_REUSE_VFQ before
calling igb_sriov_reinit().  If min(rxq, txq) < end (for example, if CPUs
were offlined so num_online_cpus() is smaller than real_num_rx_queues, or if
VFs were enabled while the interface was down) and an XSK pool is bound to a
queue in that range, igb_sriov_reinit() aborts and leaves the PF running
without reinitializing its queue configuration and interrupt scheme for
non-SR-IOV operation.

> @@ -3844,6 +3864,7 @@ static int igb_enable_sriov(struct pci_dev *pdev, i=
nt num_vfs, bool reinit)
>  {
>  	struct net_device *netdev =3D pci_get_drvdata(pdev);
>  	struct igb_adapter *adapter =3D netdev_priv(netdev);
> +	bool dmac =3D adapter->flags & IGB_FLAG_DMAC;
>  	int old_vfs =3D pci_num_vf(pdev);
>  	struct vf_mac_filter *mac_list;
>  	int err =3D 0;
> @@ -3933,6 +3954,8 @@ static int igb_enable_sriov(struct pci_dev *pdev, i=
nt num_vfs, bool reinit)
>  	kfree(adapter->vf_data);
>  	adapter->vf_data =3D NULL;
>  	adapter->vfs_allocated_count =3D 0;
> +	if (dmac)
> +		adapter->flags |=3D IGB_FLAG_DMAC;
>  out:
>  	return err;
>  }

[Severity: Medium]
When igb_sriov_reinit() returns -EBUSY on a live PF, can the unlocked
rollback in err_out race with concurrent readers of adapter->vf_data and
adapter->flags?

CPU0                              CPU1
igb_enable_sriov()
  adapter->vfs_allocated_count =3D num_vfs;
  adapter->vf_data =3D kzalloc_objs(...);
  ...
  igb_sriov_reinit()
    rtnl_unlock()
    return -EBUSY;
                                  igb_set_rx_mode()
                                    igb_restore_vf_multicasts()
                                      i < adapter->vfs_allocated_count
  kfree(adapter->vf_data);
  adapter->vf_data =3D NULL;
                                      &adapter->vf_data[i]
                                        <-- NULL pointer dereference / UAF
  adapter->vfs_allocated_count =3D 0;

igb_enable_sriov() runs without rtnl_lock() or adapter->vfs_lock, and frees
adapter->vf_data before clearing adapter->vfs_allocated_count (unlike
igb_disable_sriov(), which takes adapter->vfs_lock).  In addition, saving a=
nd
restoring IGB_FLAG_DMAC in adapter->flags performs unlocked read-modify-wri=
te
updates that can race with RTNL-protected changes to adapter->flags.  Check=
ing
for bound XSK queues before mutating adapter state in igb_enable_sriov()
would avoid having to roll back live VF state and RAR entries on error.

[ ... ]

> @@ -6778,6 +6805,7 @@ static int igb_change_mtu(struct net_device *netdev=
, int new_mtu)
>  {
>  	struct igb_adapter *adapter =3D netdev_priv(netdev);
>  	int max_frame =3D new_mtu + IGB_ETH_PKT_HDR_PAD;
> +	int i;
> =20
>  	if (igb_xdp_is_enabled(adapter) &&
>  	    !igb_xdp_frame_fits(adapter, max_frame)) {
> @@ -6791,6 +6819,23 @@ static int igb_change_mtu(struct net_device *netde=
v, int new_mtu)
>  	if (max_frame < (ETH_FRAME_LEN + ETH_FCS_LEN))
>  		max_frame =3D ETH_FRAME_LEN + ETH_FCS_LEN;
> =20
> +	/* the frame must fit the buffers of a bound XSK pool, also while no
> +	 * XDP program is attached, as attaching one does not check it again
> +	 */
> +	for (i =3D 0; i < adapter->num_rx_queues; i++) {
> +		struct xsk_buff_pool *pool =3D xsk_get_pool_from_qid(netdev, i);
> +
> +		if (!pool || !pool->dev)
> +			continue;
> +
> +		if (!igb_xsk_frame_fits(pool, max_frame)) {
> +			netdev_warn(adapter->netdev,
> +				    "Requested MTU size is not supported with AF_XDP. Frame size is =
%d\n",
> +				    max_frame);
> +			return -EINVAL;
> +		}
> +	}
> +
>  	while (test_and_set_bit(__IGB_RESETTING, &adapter->state))
>  		usleep_range(1000, 2000);
> =20
> diff --git a/drivers/net/ethernet/intel/igb/igb_xsk.c b/drivers/net/ether=
net/intel/igb/igb_xsk.c
> index ce4a7b58cad2f..7f99e834c1edb 100644
> --- a/drivers/net/ethernet/intel/igb/igb_xsk.c
> +++ b/drivers/net/ethernet/intel/igb/igb_xsk.c
> @@ -91,7 +91,21 @@ struct xsk_buff_pool *igb_xsk_pool(struct igb_adapter =
*adapter,
>  	if (!igb_xdp_is_enabled(adapter))
>  		return NULL;
> =20
> -	return (pool && pool->dev) ? pool : NULL;
> +	if (!pool || !pool->dev)
> +		return NULL;
> +
> +	/* igb_change_mtu() does not see a pool on a queue that is hidden, for
> +	 * example after a fallback from MSI-X to MSI. The hardware buffer can
> +	 * be larger than the XSK frame, so check again when the ring is set up.
> +	 */
> +	if (!igb_xsk_frame_fits(pool, adapter->max_frame_size)) {
> +		netdev_warn_once(adapter->netdev,
> +				 "XSK frame size is too small for the MTU, queue %d is not used in z=
ero-copy mode\n",
> +				 qid);
> +		return NULL;
> +	}
> +
> +	return pool;
>  }

[Severity: Medium]
When a hidden queue is set up again during __igb_open(), does
xsk_get_pool_from_qid() in igb_xsk_pool() return NULL before reaching
igb_xsk_frame_fits()?

In __igb_open(), igb_configure() sets up the Tx and Rx rings (calling
igb_xsk_pool()) before netif_set_real_num_tx_queues() and
netif_set_real_num_rx_queues() update the netdev queue counts:

drivers/net/ethernet/intel/igb/igb_main.c:__igb_open() {
    ...
	igb_configure(adapter);

	err =3D igb_request_irq(adapter);
	if (err)
		goto err_req_irq;

	/* Notify the stack of the actual queue counts. */
	err =3D netif_set_real_num_tx_queues(adapter->netdev,
					   adapter->num_tx_queues);
	if (err)
		goto err_set_queues;

	err =3D netif_set_real_num_rx_queues(adapter->netdev,
					   adapter->num_rx_queues);
    ...
}

Because xsk_get_pool_from_qid() checks queue_id against
netdev->real_num_rx_queues and netdev->real_num_tx_queues, it still sees the
reduced queue count (such as 1 after an MSI fallback) during igb_configure()
and returns NULL for any restored queue >=3D 1.  As a result, the restored
queue stays out of zero-copy mode even when the MTU fits, and for the same
reason igb_change_mtu() can miss bound pools if queue counts were changed
while the interface was down and real_num_rx_queues has not been updated ye=
t.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111-igb-rx-ts-=
fix-v6-0-ba5b9903859c@aweta.nl?part=3D3
