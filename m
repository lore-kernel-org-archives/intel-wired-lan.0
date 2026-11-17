Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A483606A889
	for <intel-wired-lan@archiver.kernel.org>; Tue, 17 Nov 2026 11:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=Q22pMQWN;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mCaFIUZH
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 680E380DF0;
	Tue, 17 Nov 2026 11:18:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d17J_0HHjZ19; Tue, 17 Nov 2026 11:18:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8081780EF4
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794914318;
	b=CayLvkEkTdGvzjj5I3Uz0SA1DH5Q/7puac1O9t/I5LeGbzevDMe5A1Or7sxj9EzFIjHC
	 n5nHMDw7Ejb+vCrbpZNPJW2l/n74U1YwrloD/wkdHFV9Wbt6k8qA/VqQEs/E/u9C65oxc
	 uHA/iDJut62MvAEXvYEkT+NvP2b8klaGbJHjGowbfBfbavAbxkRxxsmR+UHEGbMowyHE2
	 D36yIipya444hZTeww6NUz1TFMUUb2zByFEj7yCDowI0RFpPpaWw6GMrx17HpkxGWOI7j
	 loCGMEE0j1YI07u8f9JmASWj0bnUJgpfWhw5H6S5dhzhP+CK6fLD1R1TSU6b/3fMXOw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794914318;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=IqLBpYE7h7awA0TG7t8nA0duIGgbrcEUjs5NwXMZs9w=;
	b=X6Ig9rCAOJ1lB2YDq9Aw9W+c9jX6IUaFnOtwgeSSiktG/W3JzwSaYNoQ7XTK4VVphRBx
	 O0oVBCrg9uzr/wpgn1Lh+/HZzfO9Cjv2RuIzyChNzkLfckNMDm92qS12I+GjTIH8lmyaG
	 fv/PnSg9S01MARjVNJs6PBfW9aKJLS24gplFA84hMsu781EAHwvZFtvE9dCyQz+/mUmoZ
	 jeo6dj0brDIckgIbnG46y1kmJFATdzndccz/Zxh7w+ls/JCAoR03JyuyltAuyQ0OD/b1q
	 mu9Av8OS6tVKZnFouAINsFgN5PVqbtsvhRr1qE2mvTzTGlfhwX/RQBc6shjcFTYEZTA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mCaFIUZH;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794914318;
	bh=IqLBpYE7h7awA0TG7t8nA0duIGgbrcEUjs5NwXMZs9w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q22pMQWN7YvstwV4HyVuWuA63u3btjNbYHnonICWlbsaws7gx5efAew7ksrJfUSsq
	 GA3PX2RMA0A4WoBySGqGrP6uFgP0U9hwb+Xiacdd9/EVtf4kjeN/Na2NoYeGwyyYKe
	 u+UIvHpAa/F9byBd0ty/OVu+Du6N+p6x9fxJ95dtL4O/WF57pWc2RSZPgpHXm4wByi
	 YLgb8iqNwzje+gojA7JiLxJ7v5VI7HyEkrU62+++8Y1NS0A7FvyQ0HIRlRMzlFGtuo
	 LYGPkuKw5nmBPN+ZIHoz6L8atma9jnhgPAF+KYSeU/xtC1jp7l6+zXV7gcScXaHA4p
	 PDizF7kJhhAiw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8081780EF4;
	Tue, 17 Nov 2026 11:18:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D8B5870B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 11:18:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CA86080EF4
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 11:18:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b1zhDmTlXqlI for <intel-wired-lan@lists.osuosl.org>;
 Tue, 17 Nov 2026 11:18:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B983080DF0
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=mCaFIUZH
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B983080DF0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 11:18:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6CE7B40131;
 Tue, 17 Nov 2026 11:18:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB7801F000C8;
 Tue, 17 Nov 2026 11:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794914315;
 bh=IqLBpYE7h7awA0TG7t8nA0duIGgbrcEUjs5NwXMZs9w=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=mCaFIUZHgw8kLUr6stTj4HbPc4TcRO5utbPuxEnmgAh2uyLh1xZi8xwK8jP3U2fmD
 smuWD0opczWQVBhCsXOtMOQyIebNiRDs+4AnLZMwvi4II0g2YITzYMsEpw7AoLNnNt
 V78ked96eUSWdEvNqFUAjqjOzse+If31UgybNkxZrn7MVJzDNCRHzo321wLlyzJgZY
 LSFaVSe4HyqMqI5d/YpqstPM5cx9PgX9n/P+rEzrOmZLvdl1SZkk1+OpBl/nT6X/6d
 DSTysjKCUqcJ9LGqiYJvmnaqVLAEWWhLnuJkDp14qoFFqRh3x1nc3BOKr5e1JevbB9
 6nKQLbxB1TvwQ==
Subject: Re: [PATCH net 3/3] igb: only allow runtime PM if the device can wake
 up
From: netdev-bot+sashiko@kernel.org
To: antonio@mandelbit.com
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 zheng.z.yan@intel.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Date: Tue, 17 Nov 2026 11:18:34 +0000
Message-ID: <179491431428.3136.15501039766024079493@kernel.org>
In-Reply-To: <20261113105835.3821433-3-antonio@mandelbit.com>
References: <20261113105835.3821433-3-antonio@mandelbit.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Probe and remove can disagree about the runtime PM usage
  count.
- [Medium] The patch decides whether igb may runtime-suspend from one
  pci_dev_run_wake() check in igb_probe().

--

igb: only allow runtime PM if the device can wake up

This patch changes igb_probe() so it drops the probe-time runtime PM
usage reference only when pci_dev_run_wake() is true. Devices that can't
signal a wake-up from D3 therefore no longer runtime suspend.
igb_remove() takes the reference back under the same condition.

> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index f1ce9aa696ab7..145daee832640 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -3677,7 +3677,11 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  
>  	dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_NO_DIRECT_COMPLETE);
>  
> -	pm_runtime_put_noidle(&pdev->dev);
> +	/* A device that can't wake up wouldn't notice the link coming back
> +	 * while runtime suspended
> +	 */
> +	if (pci_dev_run_wake(pdev))
> +		pm_runtime_put_noidle(&pdev->dev);

[Severity: Medium]
Is one check at probe time enough to close the bug described in the
commit message?

pci_dev_run_wake() depends on pci_target_state(), and that can change
after probe. On ACPI platforms, acpi_pci_choose_state() limits the
target to D3hot only when d3cold_allowed is clear:

drivers/pci/pci-acpi.c:acpi_pci_choose_state() {
    ...
	if (pdev->no_d3cold || !pdev->d3cold_allowed)
		d_max = ACPI_STATE_D3_HOT;
	else
		d_max = ACPI_STATE_D3_COLD;
    ...
}

Root can change d3cold_allowed through sysfs while igb is bound.

Here is one sequence:

1. igb binds with d3cold_allowed=0. The target is D3hot and PME is
   supported from D3hot, so the probe check passes and the reference is
   dropped.
2. Root writes d3cold_allowed=1, so the target becomes D3cold.
3. The part doesn't support PME from D3cold.

On the next link-down, igb_runtime_idle() or the watchdog schedules a
suspend. igb_runtime_suspend()->__igb_shutdown() arms the WUFC
link-change filter without any PCI-level check. Then
pci_finish_runtime_suspend() runs:

drivers/pci/pci.c:pci_finish_runtime_suspend() {
    ...
	__pci_enable_wake(dev, target_state, pci_dev_run_wake(dev));

	error = pci_set_power_state(dev, target_state);
    ...
}

pci_dev_run_wake() is now false. Wouldn't the device then go into D3cold
with PME disarmed? The port would stay down after the cable is plugged
back in, until user space resumes it.

Could igb_runtime_idle() or igb_runtime_suspend() return -EBUSY when
pci_dev_run_wake() is false? That would cover this case and also remove
the need for the separate probe and remove accounting below.

>  	return 0;
>  
>  err_register:
> @@ -3899,7 +3903,8 @@ static void igb_remove(struct pci_dev *pdev)
>  	struct igb_adapter *adapter = netdev_priv(netdev);
>  	struct e1000_hw *hw = &adapter->hw;
>  
> -	pm_runtime_get_noresume(&pdev->dev);
> +	if (pci_dev_run_wake(pdev))
> +		pm_runtime_get_noresume(&pdev->dev);

[Severity: Medium]
Can igb_probe() and igb_remove() disagree about the runtime PM usage
count here?

igb_remove() calls pci_dev_run_wake() again instead of reusing the
decision made in igb_probe(). The result comes from
pci_pme_capable(dev, pci_target_state(dev, true)), and the target state
can change while the driver is bound.

One way it can change is a write to d3cold_allowed through
d3cold_allowed_store(). That changes what acpi_pci_choose_state()
returns, as described above.

Another way is surprise removal of a runtime-suspended igb that the
platform does not manage. pci_device_remove() calls
pm_runtime_get_sync() before drv->remove(), and during that resume
pci_power_up() does:

drivers/pci/pci.c:pci_power_up() {
    ...
	if (pci_dev_is_disconnected(dev)) {
		dev->current_state = PCI_D3cold;
		return -EIO;
	}
    ...
}

pci_target_state() then returns PCI_D3cold when igb_remove() runs. On a
part with PME from D3hot but not from D3cold, pci_dev_run_wake()
changes from true to false.

After that, pci_device_remove() runs the same sequence regardless:

drivers/pci/pci-driver.c:pci_device_remove() {
    ...
		pm_runtime_get_sync(dev);
		pm_runtime_barrier(dev);
		drv->remove(pci_dev);
		pm_runtime_put_noidle(dev);
	}
    ...
	pm_runtime_put_sync(dev);
    ...
}

If the check was false at probe and true at remove, doesn't the usage
count stay one too high for good? The device could then never runtime
suspend again, even after rebinding.

If the check was true at probe and false at remove, doesn't this drop
one reference too many?

With power/control=auto, rpm_drop_usage_count() would warn "Runtime PM
usage count underflow!". With power/control=on, the extra put would
silently cancel the pm_runtime_forbid() reference.

Would it help to save the probe-time decision in struct igb_adapter and
test that flag in igb_remove()?

e1000e and r8169 also re-check pci_dev_run_wake() in their remove paths.
Following them doesn't by itself show that the pattern stays balanced.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261113105835.3821433-1-antonio%40mandelbit.com
