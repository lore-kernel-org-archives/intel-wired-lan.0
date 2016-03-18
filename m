From: Alexander Duyck <aduyck@mirantis.com>
Date: Fri, 18 Mar 2016 16:06:41 -0700
Subject: [Intel-wired-lan] [next PATCH 0/2] A couple of minor fixes
Message-ID: <20160318230425.14801.87895.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

These two patches are minor fixes for some previous work.

The i40e patch updates the code so that it will correctly compute the
checksum based on changes I made to the upstream kernel.  However the
impact should be minimal as TCP doesn't appear to currently generate frames
large enough to actually overflow the 16 bit UDP length field.

The igb patch is a fix for a bug reported by the kbuild test robot.

---

Alexander Duyck (2):
      i40e/i40evf: Fix TSO checksum pseudo-header adjustment
      igb: Fix sparse warning about passing __beXX into leXX_to_cpup


 drivers/net/ethernet/intel/i40e/i40e_txrx.c   |   11 ++++-------
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c |   11 ++++-------
 drivers/net/ethernet/intel/igb/igb_main.c     |   10 ++++++----
 3 files changed, 14 insertions(+), 18 deletions(-)

--
