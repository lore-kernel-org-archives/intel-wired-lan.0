From: Stephen Hemminger <stephen@networkplumber.org>
Date: Mon, 25 Jan 2021 14:20:09 -0800
Subject: [Intel-wired-lan] Fw: [Bug 211335] New: Network connectivity issues
 after hibernation
Message-ID: <20210125142009.01b6278d@hermes.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



Begin forwarded message:

Date: Mon, 25 Jan 2021 08:41:52 +0000
From: bugzilla-daemon@bugzilla.kernel.org
To: stephen@networkplumber.org
Subject: [Bug 211335] New: Network connectivity issues after hibernation


https://bugzilla.kernel.org/show_bug.cgi?id=211335

            Bug ID: 211335
           Summary: Network connectivity issues after hibernation
           Product: Networking
           Version: 2.5
    Kernel Version: 5.10.10
          Hardware: x86-64
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: Other
          Assignee: stephen at networkplumber.org
          Reporter: morfikov at gmail.com
        Regression: No

Created attachment 294843
  --> https://bugzilla.kernel.org/attachment.cgi?id=294843&action=edit  
hibernation log

I not sure where to put it, but whenever I hibernate my machine, the process is
interrupted with the two kernel warnings. One is "TPM returned invalid status"
and the other is "NETDEV WATCHDOG: eth0 (e1000e): transmit queue 0 timed out".
After this happens, I'm able to hibernate the machine again without this warns,
but when I resume the machine from sleep, the network doesn't seem to work well
-- I get bunch of errors when I try to visit some http/https pages in firefox. 

I attached the full hibernation log as well as lspci/lsusb. The machine is
Lenovo Thinkpad T430.

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.
