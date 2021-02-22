From: Stephen Hemminger <stephen@networkplumber.org>
Date: Mon, 22 Feb 2021 09:30:49 -0800
Subject: [Intel-wired-lan] Fw: [Bug 211859] New: Difficulties with macvlan
 on igc network driver
Message-ID: <20210222093049.395aea61@hermes.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



Begin forwarded message:

Date: Sat, 20 Feb 2021 01:21:32 +0000
From: bugzilla-daemon@bugzilla.kernel.org
To: stephen@networkplumber.org
Subject: [Bug 211859] New: Difficulties with macvlan on igc network driver


https://bugzilla.kernel.org/show_bug.cgi?id=211859

            Bug ID: 211859
           Summary: Difficulties with macvlan on igc network driver
           Product: Networking
           Version: 2.5
    Kernel Version: 5.4.0-65-generic (x86_64)
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IPV4
          Assignee: stephen at networkplumber.org
          Reporter: pjw at rhyme.com.au
        Regression: No

Driver: igc
NIC: Ethernet controller: Intel Corporation Device 15f3 (rev 02)
Mobo: ASUS Z490-H
Firmware: 1.45 (latest from Intel)


This NIC is known to have some hardware problems, so this may be
insurmountable. That said:


Creating a macvlan attached to this NIC results in failure to route Layer 2
messages correctly (specifically, DHCPOFFER). The config used was:


ip link add mvlan_name link eth_name type macvlan mode bridge


When the link is brought up, virtualbox VMs connected to the ?mvlan_name?
interface in bridged mode can send DHCPREQUEST messages, which are sent
correctly over the interface, and received by the server. The response
(DHCPOFFER) is never routed to the VM.


Further, attaching the VM to the NIC interface directly in bridged mode has a
similar result.


Performing exactly the same tests on a different NIC (Intel Corporation I350
Gigabit Network Connection (rev 01)), results in correct functioning: the vlan
setup works, as direct VM bridging to the NIC.

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.
