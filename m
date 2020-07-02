From: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
Date: Thu, 2 Jul 2020 20:05:31 +0000
Subject: [Intel-wired-lan] [PATCH] igb: reinit_locked() should be called
 with rtnl_lock
In-Reply-To: <CA+HUmGhfxYY5QiwF8_UYbp0TY-k3u+cTYZDSqV1s=SUFnGCn8g@mail.gmail.com>
References: <20200629211801.C3D7095C0900@us180.sjc.aristanetworks.com>
 <20200629171612.49efbdaa@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CA+HUmGjHQPUh1frfy5E28Om9WTVr0W+UQVDsm99beC_mbTeMog@mail.gmail.com>
 <61CC2BC414934749BD9F5BF3D5D940449874358A@ORSMSX112.amr.corp.intel.com>
 <CA+HUmGhfxYY5QiwF8_UYbp0TY-k3u+cTYZDSqV1s=SUFnGCn8g@mail.gmail.com>
Message-ID: <61CC2BC414934749BD9F5BF3D5D9404498748B57@ORSMSX112.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Francesco Ruggeri <fruggeri@arista.com>
> Sent: Thursday, July 2, 2020 12:35
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: Jakub Kicinski <kuba@kernel.org>; David Miller <davem@davemloft.net>;
> open list <linux-kernel@vger.kernel.org>; netdev <netdev@vger.kernel.org>;
> intel-wired-lan at lists.osuosl.org
> Subject: Re: [PATCH] igb: reinit_locked() should be called with rtnl_lock
> 
> > Do not worry about the other Intel drivers, I have our developers looking at
> each of our drivers for the locking issue.
> >
> > @David Miller - I am picking up this patch
> 
> There seems to be a second race, independent from the original one, that
> results in a divide error:
> 
> kworker         reboot -f       tx packet
> 
> igb_reset_task
>                 __igb_shutdown
>                 rtnl_lock()
>                 ...
>                 igb_clear_interrupt_scheme
>                 igb_free_q_vectors
>                 adapter->num_tx_queues = 0
>                 ...
>                 rtnl_unlock()
> rtnl_lock()
> igb_reinit_locked
> igb_down
> igb_up
> netif_tx_start_all_queues
>                                 dev_hard_start_xmit
>                                 igb_xmit_frame
>                                 igb_tx_queue_mapping
>                                 Panics on
>                                 r_idx % adapter->num_tx_queues
> 
> Using in igb_reset_task a logic similar to the one in ixgbe_reset_subtask (bailing
> if __IGB_DOWN or __IGB_RESETTING is set) seems to avoid the panic.
> That logic was first introduced in ixgbe as part of commit 2f90b8657ec ('ixgbe:
> this patch adds support for DCB to the kernel and ixgbe driver').
> Both fixes seem to be needed.

So will you be sending a v2 of your patch to include the second fix?
