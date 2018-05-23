From: Pavel Machek <pavel@ucw.cz>
Date: Wed, 23 May 2018 12:40:29 +0200
Subject: [Intel-wired-lan] [PATCH v2 1/1] drivers core: multi-threading
 device shutdown
In-Reply-To: <20180505154040.28614-2-pasha.tatashin@oracle.com>
References: <20180505154040.28614-1-pasha.tatashin@oracle.com>
 <20180505154040.28614-2-pasha.tatashin@oracle.com>
Message-ID: <20180523104029.GC15312@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi!

> When system is rebooted, halted or kexeced device_shutdown() is
> called.
> 
> This function shuts down every single device by calling either:
> 
> 	dev->bus->shutdown(dev)
> 	dev->driver->shutdown(dev)
...
> Finally, with ixgbe_shutdown() it takes 0.37 for each device, but that time
> is spread all over the place, with bigger offenders:
> 
>     ixgbe_shutdown
>       __ixgbe_shutdown
>         ixgbe_close_suspend
>           ixgbe_down
>             ixgbe_init_hw_generic
>               ixgbe_reset_hw_X540
>                 msleep(100);                        0.104483472
>                 ixgbe_get_san_mac_addr_generic      0.048414851
>                 ixgbe_get_wwn_prefix_generic        0.048409893
>               ixgbe_start_hw_X540
>                 ixgbe_start_hw_generic
>                   ixgbe_clear_hw_cntrs_generic      0.048581502
>                   ixgbe_setup_fc_generic            0.024225800

ixgbe is network card, right? So ... it does not have any persistent
state and no moving parts, and there's no reason we could not "just
power it down"?
>  /*

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180523/8c822be1/attachment.asc>
