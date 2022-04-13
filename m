From: Christian Melki <christian.melki@t2data.com>
Date: Wed, 13 Apr 2022 08:10:47 +0200
Subject: [Intel-wired-lan] No link up before IFF_UP? (early link
 optimization)
Message-ID: <3438c789-d4c2-1b41-79d2-d2fb9ff6f089@t2data.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

I have a optimization task for a time constrained boot process.
The system in question is an AMD Ryzen from the R1000 family with an 
Intel I211 running igb in 5.17.1.

The current kernel and driver behavior:
UEFI (link up) -> Kernel starts, driver is probed (link down) -> link 
stays down until userspace IFF_UP -> after an extra +6-7 seconds the 
link comes up.

This means that the userspace can't start communication after 6-7 
seconds after device open. Moving the interface initialization earlier 
won't help much as IFF_UP is about 0.5 away from jumping to initramfs.

So the question is: Can I get the interface to stop powering down after 
probe? If reset is needed, then take up the interface again. Of course 
the kernel won't start forwarding until netif_carrier transitions.
But I'd like to move the resets and powerups as early as possible.
I guess that also means no resets if no settings have changed.

Regards,
Christian
