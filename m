From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 22 Feb 2016 18:32:49 +0000
Subject: [Intel-wired-lan] [next PATCH v2] i40e/i40evf: Allow up to 12K
 bytes of data per Tx descriptor instead of 8K
In-Reply-To: <20160219201130.16927.24329.stgit@localhost.localdomain>
References: <20160219201130.16927.24329.stgit@localhost.localdomain>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F995798@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Friday, February 19, 2016 12:17 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH v2] i40e/i40evf: Allow up to 12K bytes
> of data per Tx descriptor instead of 8K
> 
> >From what I can tell the practical limitation on the size of the Tx
> >data
> buffer is the fact that the Tx descriptor is limited to 14 bits.  As such we
> cannot use 16K as is typically used on the other Intel drivers.  However
> artificially limiting ourselves to 8K can be expensive as this means that we will
> consume up to 10 descriptors (1 context, 1 for header, and 9 for payload,
> non-8K aligned) in a single send.
> 
> I propose that we can reduce this by increasing the maximum data for a 4K
> aligned block to 12K.  We can reduce the descriptors used for a 32K aligned
> block by 1 by increasing the size like this.  In addition we still have the 4K - 1 of
> space that is still unused.  We can use this as a bit of extra padding when
> dealing with data that is not aligned to 4K.
> 
> By aligning the descriptors after the first to 4K we can improve the efficiency
> of PCIe accesses as we can avoid using byte enables and can fetch full TLP
> transactions after the first fetch of the buffer.  This helps to improve PCIe
> efficiency.  Below is the results of testing before and after with this patch:
> 
> Recv   Send   Send                         Utilization      Service Demand
> Socket Socket Message  Elapsed             Send     Recv    Send    Recv
> Size   Size   Size     Time    Throughput  local    remote  local   remote
> bytes  bytes  bytes    secs.   10^6bits/s  % S      % U     us/KB   us/KB
> Before:
> 87380  16384  16384    10.00     33682.24  20.27    -1.00   0.592   -1.00
> After:
> 87380  16384  16384    10.00     34204.08  20.54    -1.00   0.590   -1.00
> 
> So the net result of this patch is that we have a small gain in throughput due
> to a reduction in overhead for putting together the frame.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---
> 
> v2: Fixed build issue when FCoE was enabled for i40e.
> 
> Testing-hints:
> This primarily requires just basic throughput testing for regression.
> 
> The performance improvement can be difficult to see.  In order for me to be
> able to reproduce the results above it was necessary to manually adjust the
> ITR value down to something on the order of about 25us as otherwise other
> items such as the socket buffer would limit the throughput.
> 
>  drivers/net/ethernet/intel/i40e/i40e_fcoe.c   |    2 +
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   |   13 ++++++---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h   |   35
> +++++++++++++++++++++++--
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c |   13 ++++++---
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.h |   35
> +++++++++++++++++++++++--
>  5 files changed, 83 insertions(+), 15 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Saw slight performance increase (~900Mbits/sec) with patch applied, as expected.
