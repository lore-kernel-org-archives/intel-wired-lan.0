From: Ken Cox <jkc@redhat.com>
Date: Wed,  8 Dec 2021 04:21:51 -0600
Subject: [Intel-wired-lan] [Patch 0/2] iavf: Fix panics due to active work
 queues being freed in iavf_remove()
Message-ID: <20211208102153.669338-1-jkc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This series fixes panics that occur after iavf_remove() is called.

The panics occur because the iavf_adapter structure is freed at the end
of iavf_remove(), but it is possible that new work has been scheduled using
the work_struct's contained within the iavf_adapter structure.  If this occurs, the system will panic when it later tries to process the work queue.

Ken Cox (2):
  iavf: Fix panic in iavf_remove
  iavf: Prevent reset from being scheduled while adapter is being
    removed

 drivers/net/ethernet/intel/iavf/iavf_ethtool.c  |  7 +++++--
 drivers/net/ethernet/intel/iavf/iavf_main.c     | 17 +++++++++++------
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c |  4 +++-
 3 files changed, 19 insertions(+), 9 deletions(-)

-- 
2.31.1

