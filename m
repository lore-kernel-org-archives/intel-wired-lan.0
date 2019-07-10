From: Stephen Hemminger <stephen@networkplumber.org>
Date: Wed, 10 Jul 2019 08:37:33 -0700
Subject: [Intel-wired-lan] Fw: [Bug 204123] New: i40e: Kernel NULL
 dereference (at 0000000000000832) with dpdk
Message-ID: <20190710083733.2fa58772@hermes.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



Begin forwarded message:

Date: Wed, 10 Jul 2019 08:41:52 +0000
From: bugzilla-daemon@bugzilla.kernel.org
To: stephen@networkplumber.org
Subject: [Bug 204123] New: i40e: Kernel NULL dereference (at 0000000000000832) with dpdk


https://bugzilla.kernel.org/show_bug.cgi?id=204123

            Bug ID: 204123
           Summary: i40e: Kernel NULL dereference (at 0000000000000832)
                    with dpdk
           Product: Networking
           Version: 2.5
    Kernel Version: 5.1.12
          Hardware: Intel
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Other
          Assignee: stephen at networkplumber.org
          Reporter: kmateusz at inf.ethz.ch
        Regression: No

Hi,

When using dpdk-devbind with kernel 5.1.12 on Ubuntu 16.04.2 it happens we
encounter NULL dereference at a specific location 0000000000000832

```
Jul  9 17:14:16 scion-r4 kernel: [ 8745.935155] BUG: unable to handle kernel
NULL pointer dereference at 0000000000000832
Jul  9 17:14:16 scion-r4 kernel: [ 8745.935161] #PF error: [normal kernel read
fault]
Jul  9 17:14:16 scion-r4 kernel: [ 8745.935163] PGD 80000010771d9067 P4D
80000010771d9067 PUD 1075f2a067 PMD 0 
Jul  9 17:14:16 scion-r4 kernel: [ 8745.935170] Oops: 0000 [#1] SMP PTI
Jul  9 17:14:16 scion-r4 kernel: [ 8745.935174] CPU: 31 PID: 2401 Comm: ntpd
Not tainted 5.1.12 #1
Jul  9 17:14:16 scion-r4 kernel: [ 8745.935177] Hardware name: DALCO AG
S2600WTTR/S2600WTTR, BIOS SE5C610.86B.01.01.0027.071020182329 07/10/2018
Jul  9 17:14:16 scion-r4 kernel: [ 8745.935205] RIP:
0010:i40e_get_phys_port_id+0x18/0x40 [i40e]
Jul  9 17:14:16 scion-r4 kernel: [ 8745.935208] Code: 46 38 48 89 47 f8 c3 90
66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 8b 87 c0 08 00 00 48 8b 90 40
0f 00 00 b8 a1 ff ff ff <f6> 82 32 08 00 00 02 74 13 c6 46 20 06 8b 42 6e 89 06
0f b7 42 72
Jul  9 17:14:16 scion-r4 kernel: [ 8745.935211] RSP: 0018:ffffafa70afd78b8
EFLAGS: 00010286
Jul  9 17:14:16 scion-r4 kernel: [ 8745.935214] RAX: 00000000ffffffa1 RBX:
ffff8a0f38319500 RCX: 0000000000000000
Jul  9 17:14:16 scion-r4 kernel: [ 8745.935216] RDX: 0000000000000000 RSI:
ffffafa70afd78c7 RDI: ffff8a0e02980000
Jul  9 17:14:16 scion-r4 kernel: [ 8745.935218] RBP: ffff8a0e02980000 R08:
000000000000000c R09: ffff8a0f3ba79bc2
Jul  9 17:14:16 scion-r4 kernel: [ 8745.935221] R10: 000000005d24af48 R11:
000000007ffff000 R12: ffff8a0f3ba79ac8
Jul  9 17:14:16 scion-r4 kernel: [ 8745.935222] R13: ffffffffbb37e270 R14:
0000000000000000 R15: ffffffffbb3215c0
Jul  9 17:14:16 scion-r4 kernel: [ 8745.935225] FS:  00007f8dd4374700(0000)
GS:ffff8a0f3f740000(0000) knlGS:0000000000000000
Jul  9 17:14:16 scion-r4 kernel: [ 8745.935228] CS:  0010 DS: 0000 ES: 0000
CR0: 0000000080050033
Jul  9 17:14:16 scion-r4 kernel: [ 8745.935230] CR2: 0000000000000832 CR3:
0000000f56860003 CR4: 00000000003606e0
Jul  9 17:14:16 scion-r4 kernel: [ 8745.935232] DR0: 0000000000000000 DR1:
0000000000000000 DR2: 0000000000000000
Jul  9 17:14:16 scion-r4 kernel: [ 8745.935234] DR3: 0000000000000000 DR6:
00000000fffe0ff0 DR7: 0000000000000400
Jul  9 17:14:16 scion-r4 kernel: [ 8745.935236] Call Trace:
Jul  9 17:14:16 scion-r4 kernel: [ 8745.935253] 
rtnl_phys_port_id_fill+0x2a/0x80
Jul  9 17:14:16 scion-r4 kernel: [ 8745.935260]  ? __nla_put+0xc/0x20
Jul  9 17:14:16 scion-r4 kernel: [ 8745.935263]  rtnl_fill_ifinfo+0x512/0xfd0
Jul  9 17:14:16 scion-r4 kernel: [ 8745.935269]  rtnl_dump_ifinfo+0x1ab/0x580
Jul  9 17:14:16 scion-r4 kernel: [ 8745.935279]  ? __alloc_skb+0x96/0x1b0
Jul  9 17:14:16 scion-r4 kernel: [ 8745.935283]  netlink_dump+0x2a7/0x370
Jul  9 17:14:16 scion-r4 kernel: [ 8745.935287]  netlink_recvmsg+0x273/0x420
Jul  9 17:14:16 scion-r4 kernel: [ 8745.935292]  ___sys_recvmsg+0xf1/0x240
Jul  9 17:14:16 scion-r4 kernel: [ 8745.935296]  ? netlink_sendmsg+0x132/0x3b0
Jul  9 17:14:16 scion-r4 kernel: [ 8745.935300]  ? __sys_sendto+0xd8/0x150
Jul  9 17:14:16 scion-r4 kernel: [ 8745.935305]  ? __sys_recvmsg+0x60/0xa0
Jul  9 17:14:16 scion-r4 kernel: [ 8745.935308]  __sys_recvmsg+0x60/0xa0
Jul  9 17:14:16 scion-r4 kernel: [ 8745.935317]  do_syscall_64+0x55/0x110
Jul  9 17:14:16 scion-r4 kernel: [ 8745.935326] 
entry_SYSCALL_64_after_hwframe+0x44/0xa9
Jul  9 17:14:16 scion-r4 kernel: [ 8745.935330] RIP: 0033:0x7f8dd311a38d
Jul  9 17:14:16 scion-r4 kernel: [ 8745.935332] Code: 13 2c 00 00 75 10 b8 2f
00 00 00 0f 05 48 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 4e cd 00 00 48 89 04
24 b8 2f 00 00 00 0f 05 <48> 8b 3c 24 48 89 c2 e8 97 cd 00 00 48 89 d0 48 83 c4
08 48 3d 01
Jul  9 17:14:16 scion-r4 kernel: [ 8745.935335] RSP: 002b:00007ffef6c1cb40
EFLAGS: 00000293 ORIG_RAX: 000000000000002f
Jul  9 17:14:16 scion-r4 kernel: [ 8745.935338] RAX: ffffffffffffffda RBX:
00007ffef6c1dca0 RCX: 00007f8dd311a38d
Jul  9 17:14:16 scion-r4 kernel: [ 8745.935340] RDX: 0000000000000000 RSI:
00007ffef6c1dba0 RDI: 0000000000000005
Jul  9 17:14:16 scion-r4 kernel: [ 8745.935342] RBP: 00007ffef6c1dc10 R08:
0000000000000000 R09: 0000000001274be0
Jul  9 17:14:16 scion-r4 kernel: [ 8745.935344] R10: 00007f8dd33d6b78 R11:
0000000000000293 R12: 00007ffef6c1dba0
Jul  9 17:14:16 scion-r4 kernel: [ 8745.935346] R13: 00007ffef6c1db80 R14:
0000000000000f7c R15: 00007ffef6c1db90
Jul  9 17:14:16 scion-r4 kernel: [ 8745.935349] Modules linked in:
ipt_MASQUERADE nf_conntrack_netlink nfnetlink xfrm_user xfrm_algo iptable_nat
xt_addrtype iptable_filter ip_tables xt_conntrack x_tables nf_nat nf_conntrack
nf_defrag_ipv6 nf_defrag_ipv4 
libcrc32c br_netfilter bridge stp llc overlay binfmt_misc intel_rapl sb_edac
x86_pkg_temp_thermal intel_powerclamp joydev coretemp input_leds kvm irqbypass
crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel aes_x86_64
crypto_simd cryptd glue_h
elper ipmi_si ioatdma mei_me ipmi_devintf ipmi_msghandler mei lpc_ich
acpi_power_meter mac_hid acpi_pad parport_pc ppdev lp parport autofs4
hid_generic usbhid hid mxm_wmi ixgbe i40e ahci libahci dca mdio wmi
Jul  9 17:14:16 scion-r4 kernel: [ 8745.935398] CR2: 0000000000000832
Jul  9 17:14:16 scion-r4 kernel: [ 8745.935402] ---[ end trace e311b8f03bb40fe1
]---
```

It does not happen on a clean environment (i.e. shortly after reboot), but only
after the NIC affected has transmitted lots of data beforehand. Exact steps to
invoke the bug are as follows

```
sudo ip link set dev ens787f1 down
sudo dpdk-devbind -u 0000:81:00.1
sudo dpdk-devbind --bind=i40e 0000:81:00.1
sudo ip link set dev ens787f1 up
```

Let me know if any more details about the system are needed.

Thanks,
Mat.

-- 
You are receiving this mail because:
You are the assignee for the bug.
