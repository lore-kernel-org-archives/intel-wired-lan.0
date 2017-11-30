From: Stephen Hemminger <stephen@networkplumber.org>
Date: Thu, 30 Nov 2017 11:53:17 -0800
Subject: [Intel-wired-lan] Fw: [Bug 198047] New: Regression in e1000e with
 kernel 4.14.3
Message-ID: <20171130115317.041c950e@xeon-e3>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



Begin forwarded message:

Date: Thu, 30 Nov 2017 19:32:04 +0000
From: bugzilla-daemon@bugzilla.kernel.org
To: stephen@networkplumber.org
Subject: [Bug 198047] New: Regression in e1000e with kernel 4.14.3


https://bugzilla.kernel.org/show_bug.cgi?id=198047

            Bug ID: 198047
           Summary: Regression in e1000e with kernel 4.14.3
           Product: Networking
           Version: 2.5
    Kernel Version: 4.14.3
          Hardware: x86-64
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Other
          Assignee: stephen at networkplumber.org
          Reporter: rwarsow at gmx.de
        Regression: No

Created attachment 260963
  --> https://bugzilla.kernel.org/attachment.cgi?id=260963&action=edit  
screenshot network manager

I got a regression with my network interface e1000e.

With kernel 4.14.3 and Fedora 27 the network interface e1000e doesn't come up
if I set MTU to 1492 and boot with that settings.

with MTU set to auto sometimes the interface is active and sometimes not.

In network manager (Fedora 27) the button to activate/deactivate the network
interface is greyed out. Computers backside network LED'S are off.

there are no errors in the logs nor selinux issues, ...

up to 4.13.2 all kernels from 4.13 series I got no errors.


how can I debug this ?


Maybe from interest:
with the late Fedora 27 Beta (I believe kernel 4.12.x) I remember issues
switching interface MTU from auto to 1492.


lspci:
=====

00:1f.6 Ethernet controller: Intel Corporation Ethernet Connection (2) I219-V
     Subsystem: Micro-Star International Co., Ltd. [MSI] Device 7a72
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
     Interrupt: pin A routed to IRQ 123
     Region 0: Memory@df100000 (32-bit, non-prefetchable) [disabled]
[size=128K]
     Capabilities: <access denied>
     Kernel driver in use: e1000e 


dmesg | grep -iE 'eth|enp0s31f6':
================================

[    1.255886] e1000e 0000:00:1f.6 eth0: (PCI Express:2.5GT/s:Width x1)
4c:cc:6a:bc:8c:a2
[    1.255889] e1000e 0000:00:1f.6 eth0: Intel(R) PRO/1000 Network Connection
[    1.256032] e1000e 0000:00:1f.6 eth0: MAC: 12, PHY: 12, PBA No: FFFFFF-0FF
[    1.495646] e1000e 0000:00:1f.6 enp0s31f6: renamed from eth0
[    4.091853] e1000e 0000:00:1f.6 enp0s31f6: changing MTU from 1500 to 1492
[    4.250990] IPv6: ADDRCONF(NETDEV_UP): enp0s31f6: link is not ready
[    4.463180] IPv6: ADDRCONF(NETDEV_UP): enp0s31f6: link is not ready



nmcli connection show:
=====================

NAME       UUID                                  TYPE            DEVICE
Profile 1  0e0cc197-be48-43a7-83d8-423ee89a448e  802-3-ethernet  --

-- 
You are receiving this mail because:
You are the assignee for the bug.
