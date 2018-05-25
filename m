From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Fri, 25 May 2018 17:46:47 +0000
Subject: [Intel-wired-lan] [PATCH] PCI: allow drivers to limit the
 number of VFs to 0
In-Reply-To: <20180525170122.GA63280@bhelgaas-glaptop.roam.corp.google.com>
References: <20180402224652.4058-1-jakub.kicinski@netronome.com>
 <20180524235748.GD15320@bhelgaas-glaptop.roam.corp.google.com>
 <20180524182015.1af7b4c9@cakuba>
 <20180525140223.GA45098@bhelgaas-glaptop.roam.corp.google.com>
 <20180525170122.GA63280@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <02874ECE860811409154E81DA85FBB5882E539EA@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas at kernel.org]
> Sent: Friday, May 25, 2018 10:01 AM
> To: Jakub Kicinski <jakub.kicinski@netronome.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>; linux-pci at vger.kernel.org;
> netdev at vger.kernel.org; Sathya Perla <sathya.perla@broadcom.com>; Felix
> Manlunas <felix.manlunas@caviumnetworks.com>;
> alexander.duyck at gmail.com; john.fastabend at gmail.com; Keller, Jacob E
> <jacob.e.keller@intel.com>; Donald Dutile <ddutile@redhat.com>; oss-
> drivers at netronome.com; Christoph Hellwig <hch@infradead.org>; Derek
> Chickles <derek.chickles@caviumnetworks.com>; Satanand Burla
> <satananda.burla@caviumnetworks.com>; Raghu Vatsavayi
> <raghu.vatsavayi@caviumnetworks.com>; Ajit Khaparde
> <ajit.khaparde@broadcom.com>; Sriharsha Basavapatna
> <sriharsha.basavapatna@broadcom.com>; Somnath Kotur
> <somnath.kotur@broadcom.com>; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>; intel-wired-lan at lists.osuosl.org
> Subject: Re: [PATCH] PCI: allow drivers to limit the number of VFs to 0
> 
> [+cc liquidio, benet, fm10k maintainers:
> 
>   The patch below will affect you if your driver calls
>     pci_sriov_set_totalvfs(dev, 0);
> 
>   Previously that caused a subsequent pci_sriov_get_totalvfs() to return
>   the totalVFs value from the SR-IOV capability.  After this patch, it will
>   return 0, which has implications for VF enablement via the sysfs
>   "sriov_numvfs" file.]
> 

Thanks. I don't foresee any issues with fm10k regarding this..

Thanks,
Jake
