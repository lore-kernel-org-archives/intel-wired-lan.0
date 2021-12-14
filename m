From: Ken Cox <jkc@redhat.com>
Date: Tue, 14 Dec 2021 07:21:49 -0600
Subject: [Intel-wired-lan] [Patch 0/2] iavf: Fix panics due to active
 work queues being freed in iavf_remove()
In-Reply-To: <20211208102153.669338-1-jkc@redhat.com>
References: <20211208102153.669338-1-jkc@redhat.com>
Message-ID: <da53dc2c-d35f-94a8-68d2-affe5bed30d9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 12/8/21 04:21, Ken Cox wrote:
> This series fixes panics that occur after iavf_remove() is called.
> 
> The panics occur because the iavf_adapter structure is freed at the end
> of iavf_remove(), but it is possible that new work has been scheduled using
> the work_struct's contained within the iavf_adapter structure.  If this occurs, the system will panic when it later tries to process the work queue.
> 
> Ken Cox (2):
>    iavf: Fix panic in iavf_remove
>    iavf: Prevent reset from being scheduled while adapter is being
>      removed
> 
>   drivers/net/ethernet/intel/iavf/iavf_ethtool.c  |  7 +++++--
>   drivers/net/ethernet/intel/iavf/iavf_main.c     | 17 +++++++++++------
>   drivers/net/ethernet/intel/iavf/iavf_virtchnl.c |  4 +++-
>   3 files changed, 19 insertions(+), 9 deletions(-)
> 
NAK for this series.

These patches were generated off of the wrong branch.  I will 
re-evaluate and re-submit if necessary.

