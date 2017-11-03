From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Fri, 3 Nov 2017 10:05:17 -0700
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH 1/5] ixgbe: Fix
 interaction between SR-IOV and macvlan offload
In-Reply-To: <20171102233315.15146.95215.stgit@localhost.localdomain>
References: <20171102232857.15146.21583.stgit@localhost.localdomain>
 <20171102233315.15146.95215.stgit@localhost.localdomain>
Message-ID: <20171103100517.00007564@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2 Nov 2017 16:33:30 -0700
Alexander Duyck <alexander.duyck@gmail.com> wrote:

> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> When SR-IOV was enabled the macvlan offload was configuring several filters
> with the wrong pool value. This would result in the macvlan interfaces not
> being able to receive traffic that had to pass over the physical interface.
> 
> To fix it wrap the pool argument in the VMDQ_P macro which will add the
> necessary offset to get to the actual VMDq pool
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
