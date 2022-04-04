From: Alexander Lobakin <alexandr.lobakin@intel.com>
Date: Mon,  4 Apr 2022 13:04:07 +0200
Subject: [Intel-wired-lan] [PATCH net] ice: Fix use-after-free
In-Reply-To: <20220404100615.23525-1-ivecera@redhat.com>
References: <20220404100615.23525-1-ivecera@redhat.com>
Message-ID: <20220404110407.1106047-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Ivan Vecera <ivecera@redhat.com>
Date: Mon,  4 Apr 2022 12:06:14 +0200

> When CONFIG_RFS_ACCEL is enabled the driver uses CPU affinity
> reverse-maps that set CPU affinity notifier in the background.
> 
> If the interface is put down then ice_vsi_free_irq() is called
> via ice_vsi_close() and this clears affinity notifiers of IRQs
> associated with the VSI and old notifier's release callback
> is called - for this case this is cpu_rmap_release() that
> frees allocated cpu_rmap.
> 
> During device removal (ice_remove()) free_irq_cpu_rmap() is called
> and it tries to free already de-allocated cpu_rmap.
> 
> Do not clear IRQ affinity notifier in ice_vsi_free_irq() when
> CONFIG_RFS_ACCEL is enabled. This is a code-path that
> commit 28bf26724fdb ("ice: Implement aRFS") forgot to handle.

Hey, thanks for the fix!
I posted a patch which supercedes these changes to the internal
review on Friday. I would proceed with applying mine (which I'll
submit in 2 hours, it should've waited for the internal acks first),
but for sure I can add you as 'Co-Developed-by:' if you want (or
vice versa, me as co-dev-by?).

> 
> Reproducer:
> [root at host ~]# ip link set ens7f0 up
> [root at host ~]# ip link set ens7f0 down

--- 8< ---

>  		/* clear the affinity_mask in the IRQ descriptor */
>  		irq_set_affinity_hint(irq_num, NULL);
> -- 
> 2.35.1

Thanks,
Al
