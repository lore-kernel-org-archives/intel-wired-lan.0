From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Tue, 26 Apr 2022 17:24:00 -0700
Subject: [Intel-wired-lan] [PATCH net-next 0/3] refactor irq allocation
 in ice
In-Reply-To: <20211222062201.36302-1-michal.swiatkowski@linux.intel.com>
References: <20211222062201.36302-1-michal.swiatkowski@linux.intel.com>
Message-ID: <c149bf88-f63e-667d-6a00-cafd962018b4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


On 12/21/2021 10:21 PM, Michal Swiatkowski wrote:
> The ice driver uses the old PCI irq reseveration API. Change the ice
> driver to use the current API.
>
> Implement a fallback mechanism where, if the driver can't reserve the
> maximum number of interrupts, it will limit the number of queues or
> disable capabilities.

A very similar implementation was already rejected by netdev [1]. I 
believe there's kernel work being done for dynamic MSIX allocations 
which is the route we should look to take on this (when it's completed).

Thanks,

Tony

[1] 
https://lore.kernel.org/netdev/20210113234226.3638426-1-anthony.l.nguyen at intel.com/

