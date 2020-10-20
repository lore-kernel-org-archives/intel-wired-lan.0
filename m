From: Thomas Gleixner <tglx@linutronix.de>
Date: Tue, 20 Oct 2020 16:16:52 +0200
Subject: [Intel-wired-lan] [PATCH v4 4/4] PCI: Limit
 pci_alloc_irq_vectors() to housekeeping CPUs
In-Reply-To: <20200928183529.471328-5-nitesh@redhat.com>
References: <20200928183529.471328-1-nitesh@redhat.com>
 <20200928183529.471328-5-nitesh@redhat.com>
Message-ID: <87v9f57zjf.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Sep 28 2020 at 14:35, Nitesh Narayan Lal wrote:
>  
> +	hk_cpus = housekeeping_num_online_cpus(HK_FLAG_MANAGED_IRQ);
> +
> +	/*
> +	 * If we have isolated CPUs for use by real-time tasks, to keep the
> +	 * latency overhead to a minimum, device-specific IRQ vectors are moved
> +	 * to the housekeeping CPUs from the userspace by changing their
> +	 * affinity mask. Limit the vector usage to keep housekeeping CPUs from
> +	 * running out of IRQ vectors.
> +	 */

This is not true for managed interrupts. The interrupts affinity of
those cannot be changed by user space.

> +	if (hk_cpus < num_online_cpus()) {
> +		if (hk_cpus < min_vecs)
> +			max_vecs = min_vecs;
> +		else if (hk_cpus < max_vecs)
> +			max_vecs = hk_cpus;
> +	}

So now with that assume a 16 core machine (HT off for simplicity)

17 Requested interrupts (1 general, 16 queues)

Managed interrupts will allocate

   1  general interrupt which is free movable by user space
   16 managed interrupts for queues (one per CPU)

This allows the driver to have 16 queues, i.e. one queue per CPU. These
interrupts are only used when an application on a CPU issues I/O.

With the above change this will result

   1  general interrupt which is free movable by user space
   1  managed interrupts (possible affinity to all 16 CPUs, but routed
      to housekeeping CPU as long as there is one online)

So the device is now limited to a single queue which also affects the
housekeeping CPUs because now they have to share a single queue.

With larger machines this gets even worse.

So no. This needs way more thought for managed interrupts and you cannot
do that at the PCI layer. Only the affinity spreading mechanism can do
the right thing here.

Thanks,

        tglx
