From: Christoph Hellwig <hch@infradead.org>
Date: Tue, 29 Sep 2020 18:46:54 +0100
Subject: [Intel-wired-lan] [PATCH v4 4/4] PCI: Limit
 pci_alloc_irq_vectors() to housekeeping CPUs
In-Reply-To: <20200928215931.GA2499944@bjorn-Precision-5520>
References: <20200928183529.471328-5-nitesh@redhat.com>
 <20200928215931.GA2499944@bjorn-Precision-5520>
Message-ID: <20200929174654.GA773@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Sep 28, 2020 at 04:59:31PM -0500, Bjorn Helgaas wrote:
> [to: Christoph in case he has comments, since I think he wrote this code]

I think I actually suggested this a few iterations back.

> > +	hk_cpus = housekeeping_num_online_cpus(HK_FLAG_MANAGED_IRQ);
> > +
> > +	/*
> > +	 * If we have isolated CPUs for use by real-time tasks, to keep the
> > +	 * latency overhead to a minimum, device-specific IRQ vectors are moved
> > +	 * to the housekeeping CPUs from the userspace by changing their
> > +	 * affinity mask. Limit the vector usage to keep housekeeping CPUs from
> > +	 * running out of IRQ vectors.
> > +	 */
> > +	if (hk_cpus < num_online_cpus()) {

I woukd have moved the assignment to hk_cpus below the comment and
just above the if, but that is really just a minor style preference.

Otherwise this looks good:

Acked-by: Christoph Hellwig <hch@lst.de>
