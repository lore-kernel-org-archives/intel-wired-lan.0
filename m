From: Stephen Hemminger <stephen@networkplumber.org>
Date: Tue, 26 Jan 2021 12:49:56 -0800
Subject: [Intel-wired-lan] Fw: [Bug 211363] New: i40e: WARNING from i40e
 when ethtool -S is run.
Message-ID: <20210126124956.72374445@hermes.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



Begin forwarded message:

Date: Tue, 26 Jan 2021 19:23:29 +0000
From: bugzilla-daemon@bugzilla.kernel.org
To: stephen@networkplumber.org
Subject: [Bug 211363] New: i40e: WARNING from i40e when ethtool -S is run.


https://bugzilla.kernel.org/show_bug.cgi?id=211363

            Bug ID: 211363
           Summary: i40e: WARNING from i40e when ethtool -S is run.
           Product: Networking
           Version: 2.5
    Kernel Version: 5.10.10
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Other
          Assignee: stephen at networkplumber.org
          Reporter: wilder at us.ibm.com
        Regression: No

When veb-stats are enabled ethtool -S hits the WARN_ONCE in
i40e_add_one_ethtool_stat().

To reproduce:
ethtool --set-priv-flags <int> veb-stats on
ethtool -S <int>

unexpected stat size for veb.tc_%u_tx_packets
WARNING: CPU: 61 PID: 10113 at
drivers/net/ethernet/intel/i40e/i40e_ethtool.c:110
i40e_add_one_ethtool_stat+0x140/0x1a0 [i40e]
<cut>
[  649.377973] Call Trace:
[  649.377980] [c000003b6d937810] [c00800000debab54]
i40e_add_one_ethtool_stat+0x13c/0x1a0 [i40e] (unreliable)
[  649.377996] [c000003b6d937890] [c00800000def3b4c]
__i40e_add_ethtool_stats+0x84/0x6698 [i40e]
[  649.378010] [c000003b6d937920] [c00800000debe904]
i40e_get_ethtool_stats+0x2bc/0x4e0 [i40e]
[  649.378023] [c000003b6d937a20] [c000000000c99854] dev_ethtool+0x6c4/0x2be0
[  649.378033] [c000003b6d937b30] [c000000000c1340c] dev_ioctl+0x5ac/0xa50
[  649.378042] [c000003b6d937bc0] [c000000000b8ca7c] sock_do_ioctl+0xac/0x1b0
[  649.378051] [c000003b6d937c40] [c000000000b8d564] sock_ioctl+0x234/0x4a0
[  649.778238] [c000003b6d937d10] [c000000000559c40] do_vfs_ioctl+0xe0/0xbd0
[  649.778247] [c000003b6d937de0] [c00000000055a904] sys_ioctl+0xc4/0x160
[  649.778257] [c000003b6d937e30] [c00000000000b408] system_call+0x5c/0x70

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.
