From: Stefan Assmann <sassmann@kpanic.de>
Date: Fri,  1 Sep 2017 16:02:32 +0200
Subject: [Intel-wired-lan] [PATCH 0/2] i40e: fix firmware update
Message-ID: <20170901140234.7840-1-sassmann@kpanic.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The first patch fixes the firmware update which is currently broken and
results in a bad flash (corrupt firmware). Recovery is possible with a
fixed driver.
The second patch reverts a commit that causes the firmware checksum
verification to fail right after a successful flash. This is related to
a recent workqueue change. Haven't gotten to the bottom of this yet, but
for the sake of a smooth firmware update experience let's revert the
commit for now.

Stefan Assmann (2):
  i40e: use non-locking i40e_read_nvm_word() function during nvmupdate
  Revert "i40e: remove WQ_UNBOUND and the task limit of our workqueue"

 drivers/net/ethernet/intel/i40e/i40e_main.c | 12 +++++-------
 drivers/net/ethernet/intel/i40e/i40e_nvm.c  | 24 ++++++++++++++++++++++--
 2 files changed, 27 insertions(+), 9 deletions(-)

-- 
2.13.5

