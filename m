From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Fri, 23 Jul 2021 14:28:48 +0200
Subject: [Intel-wired-lan] What to do with info log message: `e1000e: EEE TX
 LPI TIMER: 00000011`?
Message-ID: <04a175b6-797c-ab25-dbd4-f8bdbb165674@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear David, dear Linux folks,


On several devices, like the Dell OptiPlex 3620, Linux 5.10.47 (and 
others) log the message below with info level (often during shutdown):

     e1000e: EEE TX LPI TIMER: 00000011

     $ git grep "LPI TIMER"
     drivers/net/ethernet/intel/e1000e/netdev.c:     pr_info("EEE TX LPI 
TIMER: %08X\n",


What information is that supposed to provide? For a normal user it looks 
like spam.

Could you please extend the message what to do about it? Or should it be 
made a debug message?


Kind regards,

Paul
