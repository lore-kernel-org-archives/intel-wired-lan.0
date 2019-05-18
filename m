From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Sat, 18 May 2019 18:56:33 +0200
Subject: [Intel-wired-lan] [PATCH] Reduce e1000e boot time by tightening
 sleep ranges
In-Reply-To: <8ef1b846-caf6-45de-33aa-a46406548167@molgen.mpg.de>
References: <8ef1b846-caf6-45de-33aa-a46406548167@molgen.mpg.de>
Message-ID: <1fb0c7c6-f687-f492-0f8e-487ada0b2542@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Linux folks,


On 17.05.19 16:55, Paul Menzel wrote:
>  From 6ce17ba6e04802462425ee9d38084523fc1a7ab6 Mon Sep 17 00:00:00 2001
> From: Arjan van de Ven <arjan@linux.intel.com>
> Date: Mon, 25 Jul 2016 06:44:34 -0500
> 
> The e1000e driver is a great user of the usleep_range() API,
> and has nice ranges that in principle help power management.
> 
> However the ranges that are used only during system startup are
> very long (and can add easily 100 msec to the boot time) while
> the power savings of such long ranges is irrelevant due to the
> one-off, boot only, nature of these functions.
> 
> This patch shrinks some of the longest ranges to be shorter
> (while still using a power friendly 1 msec range); this saves
> 100msec+ of boot time on my BDW NUCs

On the Dell Latitude E7250 with Linux 5.0.1 from Debian experimental 
(without this patch), the module e1000e takes quite long too initialize.

> [   68.449925] calling  e1000_init_module+0x0/0x1000 [e1000e] @ 315
> [   68.449926] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
> [   68.449926] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
> [   68.449949] e1000e 0000:00:19.0: enabling device (0000 -> 0002)
> [   68.451074] e1000e 0000:00:19.0: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
> [   68.767735] e1000e 0000:00:19.0 0000:00:19.0 (uninitialized): registered PHC clock
> [   68.864427] e1000e 0000:00:19.0 eth0: (PCI Express:2.5GT/s:Width x1) 34:e6:d7:6a:72:f4
> [   68.864429] e1000e 0000:00:19.0 eth0: Intel(R) PRO/1000 Network Connection
> [   68.864454] e1000e 0000:00:19.0 eth0: MAC: 11, PHY: 12, PBA No: FFFFFF-0FF
> [   68.864498] initcall e1000_init_module+0x0/0x1000 [e1000e] returned 0 after 40406 usecs
> [   68.868506] e1000e 0000:00:19.0 eno1: renamed from eth0
> [   73.932930] e1000e: eno1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx

I have no idea, why the `initcall_debug` time of 40.4 ms deviates from 
the Linux message time stamps (414 ms).


Kind regards,

Paul
