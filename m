From: Frederic Weisbecker <frederic@kernel.org>
Date: Thu, 1 Oct 2020 17:49:49 +0200
Subject: [Intel-wired-lan] [PATCH v4 0/4] isolation: limit msix vectors
 to housekeeping CPUs
In-Reply-To: <20200928183529.471328-1-nitesh@redhat.com>
References: <20200928183529.471328-1-nitesh@redhat.com>
Message-ID: <20201001154949.GA7303@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Sep 28, 2020 at 02:35:25PM -0400, Nitesh Narayan Lal wrote:
> Nitesh Narayan Lal (4):
>   sched/isolation: API to get number of housekeeping CPUs
>   sched/isolation: Extend nohz_full to isolate managed IRQs
>   i40e: Limit msix vectors to housekeeping CPUs
>   PCI: Limit pci_alloc_irq_vectors() to housekeeping CPUs
> 
>  drivers/net/ethernet/intel/i40e/i40e_main.c |  3 ++-
>  drivers/pci/msi.c                           | 18 ++++++++++++++++++
>  include/linux/sched/isolation.h             |  9 +++++++++
>  kernel/sched/isolation.c                    |  2 +-
>  4 files changed, 30 insertions(+), 2 deletions(-)

Acked-by: Frederic Weisbecker <frederic@kernel.org>

Peter, if you're ok with the set, I guess this should go through
the scheduler tree?

Thanks.
