From: Mario.Limonciello@dell.com <Mario.Limonciello@dell.com>
Date: Tue, 6 Aug 2019 15:53:06 +0000
Subject: [Intel-wired-lan] MDI errors during resume from ACPI S3
 (suspend to ram)
In-Reply-To: <81004059-6d91-d8be-c80e-70c52359350d@molgen.mpg.de>
References: <81004059-6d91-d8be-c80e-70c52359350d@molgen.mpg.de>
Message-ID: <2277f25bc44c4aebaac59942de2e24bb@AUSX13MPC105.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Paul Menzel <pmenzel@molgen.mpg.de>
> Sent: Tuesday, August 6, 2019 10:36 AM
> To: Jeff Kirsher
> Cc: intel-wired-lan at lists.osuosl.org; Linux Kernel Mailing List; Limonciello, Mario
> Subject: MDI errors during resume from ACPI S3 (suspend to ram)
> 
> Dear Linux folks,
> 
> 
> Trying to decrease the resume time of Linux 5.3-rc3 on the Dell OptiPlex
> 5040 with the device below
> 
>     $ lspci -nn -s 00:1f.6
>     00:1f.6 Ethernet controller [0200]: Intel Corporation Ethernet Connection (2)
> I219-V [8086:15b8] (rev 31)
> 
> pm-graph?s script `sleepgraph.py` shows, that the driver *e1000e* takes
> around 400 ms, which is quite a lot. The call graph trace shows that
> `e1000e_read_phy_reg_mdic()` is responsible for a lot of those. From
> `drivers/net/ethernet/intel/e1000e/phy.c` [1]:
> 
>         for (i = 0; i < (E1000_GEN_POLL_TIMEOUT * 3); i++) {
>                 udelay(50);
>                 mdic = er32(MDIC);
>                 if (mdic & E1000_MDIC_READY)
>                         break;
>         }
>         if (!(mdic & E1000_MDIC_READY)) {
>                 e_dbg("MDI Read did not complete\n");
>                 return -E1000_ERR_PHY;
>         }
>         if (mdic & E1000_MDIC_ERROR) {
>                 e_dbg("MDI Error\n");
>                 return -E1000_ERR_PHY;
>         }
> 
> Unfortunately, errors are not logged if dynamic debug is disabled,
> so rebuilding the Linux kernel with `CONFIG_DYNAMIC_DEBUG`, and
> 
>     echo "file drivers/net/ethernet/* +p" | sudo tee
> /sys/kernel/debug/dynamic_debug/control
> 
> I got the messages below.
> 
>     [ 4159.204192] e1000e 0000:00:1f.6 net00: MDI Error
>     [ 4160.267950] e1000e 0000:00:1f.6 net00: MDI Write did not complete
>     [ 4160.359855] e1000e 0000:00:1f.6 net00: MDI Error
> 
> Can you please shed a little more light into these errors? Please
> find the full log attached.
> 
> 
> Kind regards,
> 
> Paul
> 
> 
> [1]:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/n
> et/ethernet/intel/e1000e/phy.c#n206

Strictly as a reference point you may consider trying the out-of-tree driver to see if these
behaviors persist.

https://sourceforge.net/projects/e1000/

