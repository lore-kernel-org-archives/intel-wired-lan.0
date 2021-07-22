From: Nikolova, Tatyana E <tatyana.e.nikolova@intel.com>
Date: Thu, 22 Jul 2021 18:25:12 +0000
Subject: [Intel-wired-lan] [PATCH v5 06/14] RDMA/irdma: Use
 irq_update_affinity_hint
In-Reply-To: <20210720232624.1493424-7-nitesh@redhat.com>
References: <20210720232624.1493424-1-nitesh@redhat.com>
 <20210720232624.1493424-7-nitesh@redhat.com>
Message-ID: <DM6PR11MB4692D7AB064416EFBBB53331CBE49@DM6PR11MB4692.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Nitesh Narayan Lal <nitesh@redhat.com>
> Sent: Tuesday, July 20, 2021 6:26 PM
> To: linux-kernel at vger.kernel.org; linux-scsi at vger.kernel.org; intel-wired-
> lan at lists.osuosl.org; netdev at vger.kernel.org; linux-api at vger.kernel.org;
> linux-pci at vger.kernel.org; tglx at linutronix.de; Brandeburg, Jesse
> <jesse.brandeburg@intel.com>; robin.murphy at arm.com;
> mtosatti at redhat.com; mingo at kernel.org; jbrandeb at kernel.org;
> frederic at kernel.org; juri.lelli at redhat.com; abelits at marvell.com;
> bhelgaas at google.com; rostedt at goodmis.org; peterz at infradead.org;
> davem at davemloft.net; akpm at linux-foundation.org; sfr at canb.auug.org.au;
> stephen at networkplumber.org; rppt at linux.vnet.ibm.com;
> chris.friesen at windriver.com; maz at kernel.org; nhorman at tuxdriver.com;
> pjwaskiewicz at gmail.com; sassmann at redhat.com; thenzl at redhat.com;
> kashyap.desai at broadcom.com; sumit.saxena at broadcom.com;
> shivasharan.srikanteshwara at broadcom.com;
> sathya.prakash at broadcom.com; sreekanth.reddy at broadcom.com;
> suganath-prabu.subramani at broadcom.com; james.smart at broadcom.com;
> dick.kennedy at broadcom.com; jkc at redhat.com; Latif, Faisal
> <faisal.latif@intel.com>; Saleem, Shiraz <shiraz.saleem@intel.com>;
> tariqt at nvidia.com; ahleihel at redhat.com; kheib at redhat.com;
> borisp at nvidia.com; saeedm at nvidia.com; benve at cisco.com;
> govind at gmx.com; jassisinghbrar at gmail.com;
> ajit.khaparde at broadcom.com; sriharsha.basavapatna at broadcom.com;
> somnath.kotur at broadcom.com; nilal at redhat.com; Nikolova, Tatyana E
> <tatyana.e.nikolova@intel.com>; Ismail, Mustafa
> <mustafa.ismail@intel.com>; ahs3 at redhat.com; leonro at nvidia.com;
> chandrakanth.patil at broadcom.com; bjorn.andersson at linaro.org;
> chunkuang.hu at kernel.org; yongqiang.niu at mediatek.com;
> baolin.wang7 at gmail.com; poros at redhat.com; minlei at redhat.com;
> emilne at redhat.com; jejb at linux.ibm.com; martin.petersen at oracle.com;
> _govind at gmx.com; kabel at kernel.org; viresh.kumar at linaro.org;
> Tushar.Khandelwal at arm.com; kuba at kernel.org
> Subject: [PATCH v5 06/14] RDMA/irdma: Use irq_update_affinity_hint
> 
> The driver uses irq_set_affinity_hint() to update the affinity_hint mask that
> is consumed by the userspace to distribute the interrupts. However, under
> the hood irq_set_affinity_hint() also applies the provided cpumask (if not
> NULL) as the affinity for the given interrupt which is an undocumented side
> effect.
> 
> To remove this side effect irq_set_affinity_hint() has been marked as
> deprecated and new interfaces have been introduced. Hence, replace the
> irq_set_affinity_hint() with the new interface irq_update_affinity_hint() that
> only updates the affinity_hint pointer.
> 
> Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
> ---
>  drivers/infiniband/hw/irdma/hw.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/irdma/hw.c
> b/drivers/infiniband/hw/irdma/hw.c
> index 7afb8a6a0526..ec8de708a4df 100644
> --- a/drivers/infiniband/hw/irdma/hw.c
> +++ b/drivers/infiniband/hw/irdma/hw.c
> @@ -537,7 +537,7 @@ static void irdma_destroy_irq(struct irdma_pci_f *rf,
>  	struct irdma_sc_dev *dev = &rf->sc_dev;
> 
>  	dev->irq_ops->irdma_dis_irq(dev, msix_vec->idx);
> -	irq_set_affinity_hint(msix_vec->irq, NULL);
> +	irq_update_affinity_hint(msix_vec->irq, NULL);
>  	free_irq(msix_vec->irq, dev_id);
>  }
> 
> @@ -1087,7 +1087,7 @@ irdma_cfg_ceq_vector(struct irdma_pci_f *rf,
> struct irdma_ceq *iwceq,
>  	}
>  	cpumask_clear(&msix_vec->mask);
>  	cpumask_set_cpu(msix_vec->cpu_affinity, &msix_vec->mask);
> -	irq_set_affinity_hint(msix_vec->irq, &msix_vec->mask);
> +	irq_update_affinity_hint(msix_vec->irq, &msix_vec->mask);
>  	if (status) {
>  		ibdev_dbg(&rf->iwdev->ibdev, "ERR: ceq irq config fail\n");
>  		return IRDMA_ERR_CFG;
> --
> 2.27.0

Acked-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
