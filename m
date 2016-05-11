From: Schmitt, Phillip J <phillip.j.schmitt@intel.com>
Date: Wed, 11 May 2016 18:47:13 +0000
Subject: [Intel-wired-lan] [next-queue PATCH v2 2/3]
	ixgbe/ixgbevf:	Add	support for GSO partial
In-Reply-To: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D2658@ORSMSX104.amr.corp.intel.com>
References: <20160414210725.14141.25917.stgit@ahduyck-xeon-server>
 <20160414211931.14141.18864.stgit@ahduyck-xeon-server>
 <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D2658@ORSMSX104.amr.corp.intel.com>
Message-ID: <305E19FFAC908240AB6DEBD1E2D8C1E180D94916@ORSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bowers, AndrewX
> Sent: Wednesday, April 20, 2016 2:21 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: Re: [Intel-wired-lan] [next-queue PATCH v2 2/3] ixgbe/ixgbevf: Add
> support for GSO partial
> 
> > -----Original Message-----
> > From: Intel-wired-lan
> > [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of
> > Alexander Duyck
> > Sent: Thursday, April 14, 2016 2:20 PM
> > To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> > <jeffrey.t.kirsher@intel.com>; alexander.duyck at gmail.com
> > Subject: [Intel-wired-lan] [next-queue PATCH v2 2/3] ixgbe/ixgbevf:
> > Add support for GSO partial
> >
> > This patch adds support for partial GSO segmentation in the case of tunnels.
> > Specifically with this change the driver an perform segmenation as
> > long as the frame either has IPv6 inner headers, or we are allowed to
> > mangle the IP IDs on the inner header.  This is needed because we will
> > not be modifying any fields from the start of the start of the outer
> > transport header to the start of the inner transport header as we are
> > treating them like they are just a block of IP options.
> >
> > Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> > ---
> >  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c     |  133 ++++++++++++++--
> > -----
> >  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |  129
> > +++++++++++++++-----
> >  2 files changed, 180 insertions(+), 82 deletions(-)
> 
> Tested-by: Andrew Bowers <andrewx.bowers@intel.com> GRE tunnel traffic
> works as expected with speed increase with GSO on
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at lists.osuosl.org
> http://lists.osuosl.org/mailman/listinfo/intel-wired-lan

Alex,
Turns out this patch is causing an error when attempting to create a VLAN.
Would you be interested in submitting a follow on patch to address this?
Here's repro steps:
1. Install Fedora 23 and compile the next-queue kernel (v4.6-rc6) with dev-queue branch
2. Reboot with kernel-4.6.0-rc6_20160506.next_queue_dev_queue.
3. Created vlan 3260 interface with Spring Fountain

[root at lin-nd3-114 ~]# ip l a enp130s0f0.3260 l enp130s0f0 type vlan id 3260
RTNETLINK answers: Invalid argument

Expected result: vlan 3260 interface should be created. 

Actual result: Can't get vlan interface.

Characterization/Isolation input:
[root at lin-nd3-114 test_script]# dmesg | tail -50
[  366.829260] ixgbe 0000:82:00.0 enp130s0f0: VLAN features are set incorrectly.  Q-in-Q configurations may not work correctly.
[  366.829639] ------------[ cut here ]------------
[  366.830002] WARNING: CPU: 34 PID: 4643 at net/core/dev.c:7016 register_netdevice+0x309/0x4f0
[  366.830378] netdevice: enp130s0f0.3260 (uninitialized)
               Buggy VLAN acceleration in driver!
[  366.831225] Modules linked in: rpcsec_gss_krb5 bnx2fc nfsv4 cnic uio dns_resolver nfs fcoe libfcoe fscache ip6table_filter ip6_tables libfc scsi_transport_fc 8021q garp mrp stp llc cfg80211 rfkill intel_rapl x86_pkg_temp_thermal coretemp kvm_intel kvm irqbypass joydev iTCO_wdt iTCO_vendor_support dcdbas crct10dif_pclmul sb_edac crc32_pclmul ghash_clmulni_intel ipmi_devintf ipmi_ssif mei_me ipmi_si pcspkr edac_core mei ipmi_msghandler shpchp lpc_ich tpm_tis tpm acpi_power_meter wmi nfsd auth_rpcgss nfs_acl lockd grace sunrpc xfs libcrc32c mgag200 i2c_algo_bit drm_kms_helper ttm drm ixgbe i40e crc32c_intel mdio tg3 dca megaraid_sas fjes ptp pps_core [last unloaded: netconsole]
[  366.834201] CPU: 34 PID: 4643 Comm: ip Tainted: G        W       4.6.0-rc6_20160506.next_queue_dev_queue #1
[  366.834692] Hardware name: Dell Inc. PowerEdge R730/0599V5, BIOS 1.2.10 03/09/2015
[  366.835184]  0000000000000286 000000005f89205a ffff880436a37788 ffffffff813caa5e
[  366.835681]  ffff880436a377d8 0000000000000000 ffff880436a377c8 ffffffff810a48cb
[  366.836183]  00001b6800008de0 ffff880446165000 00000000ffffffea ffffffff81a5cdeb
[  366.836719] Call Trace:
[  366.837221]  [<ffffffff813caa5e>] dump_stack+0x63/0x85
[  366.837727]  [<ffffffff810a48cb>] __warn+0xcb/0xf0
[  366.838237]  [<ffffffff810a494f>] warn_slowpath_fmt+0x5f/0x80
[  366.838754]  [<ffffffff813dfb85>] ? find_next_bit+0x15/0x20
[  366.839275]  [<ffffffff816abf69>] register_netdevice+0x309/0x4f0
[  366.839831]  [<ffffffffa0451ad9>] register_vlan_dev+0xd9/0x230 [8021q]
[  366.840358]  [<ffffffffa045366b>] vlan_newlink+0xbb/0xf0 [8021q]
[  366.840905]  [<ffffffff816bb18e>] rtnl_newlink+0x6ee/0x8a0
[  366.841422]  [<ffffffff816bac16>] ? rtnl_newlink+0x176/0x8a0
[  366.841945]  [<ffffffff816b9686>] rtnetlink_rcv_msg+0xe6/0x220
[  366.842464]  [<ffffffff8121c173>] ? __kmalloc_node_track_caller+0x223/0x300
[  366.843005]  [<ffffffff81692c07>] ? __alloc_skb+0x87/0x1f0
[  366.843515]  [<ffffffff816b95a0>] ? rtnetlink_rcv+0x30/0x30
[  366.844018]  [<ffffffff816dff74>] netlink_rcv_skb+0xa4/0xc0
[  366.844510]  [<ffffffff816b9598>] rtnetlink_rcv+0x28/0x30
[  366.844999]  [<ffffffff816df953>] netlink_unicast+0x183/0x230
[  366.845480]  [<ffffffff816dfcfb>] netlink_sendmsg+0x2fb/0x3a0
[  366.845979]  [<ffffffff8168a408>] sock_sendmsg+0x38/0x50
[  366.846456]  [<ffffffff8168aebe>] ___sys_sendmsg+0x28e/0x2a0
[  366.846939]  [<ffffffff811c35fa>] ? lru_cache_add+0x3a/0x80
[  366.847418]  [<ffffffff811c37bc>] ? lru_cache_add_active_or_unevictable+0x4c/0xf0
[  366.847898]  [<ffffffff811e81b6>] ? handle_mm_fault+0xf26/0x1d50
[  366.848375]  [<ffffffff8168b814>] __sys_sendmsg+0x54/0x90
[  366.848882]  [<ffffffff8168b862>] SyS_sendmsg+0x12/0x20
[  366.849369]  [<ffffffff817c45b2>] entry_SYSCALL_64_fastpath+0x1a/0xa4
[  366.849869] ---[ end trace 7f8e70c0cbf69fdc ]---







