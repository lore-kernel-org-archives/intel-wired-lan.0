From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 16 Jul 2020 17:50:04 +0000
Subject: [Intel-wired-lan] [PATCH S50 09/15] ice: distribute Tx queues
 evenly
In-Reply-To: <20200713205318.32425-9-anthony.l.nguyen@intel.com>
References: <20200713205318.32425-1-anthony.l.nguyen@intel.com>
 <20200713205318.32425-9-anthony.l.nguyen@intel.com>
Message-ID: <BN6PR1101MB21450B9DAFEE1DC1B8EB7DB38C7F0@BN6PR1101MB2145.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Monday, July 13, 2020 1:53 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S50 09/15] ice: distribute Tx queues evenly
> 
> From: Victor Raj <victor.raj@intel.com>
> 
> Distribute the Tx queues evenly across all queue groups. This will help the
> queues to get more equal sharing among the queues when all are in use.
> 
> In the previous algorithm, the next queue group node will be picked up only
> after the previous one filled with max children.
> For example: if VSI is configured with 9 queues, the first 8 queues will be
> assigned to queue group 1 and the 9th queue will be assigned to queue
> group 2.
> 
> The 2 queue groups split the bandwidth between them equally (50:50).
> The first queue group node will share the 50% bandwidth with all of its
> children (8 queues). And the second queue group node will share the entire
> 50% bandwidth with its only children.
> 
> The new algorithm will fix this issue.
> 
> Signed-off-by: Victor Raj <victor.raj@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_sched.c | 55 ++++++++++++++++++++--
>  1 file changed, 51 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


