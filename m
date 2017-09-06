From: Stefano Brivio <sbrivio@redhat.com>
Date: Wed,  6 Sep 2017 10:11:37 +0200
Subject: [Intel-wired-lan] [PATCH net 0/2] i40e: Two trivial fixes for
	09f79fd49d94
Message-ID: <cover.1504684488.git.sbrivio@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Two trivial fixes for recently introduced 09f79fd49d94 ("i40e: avoid NVM
acquire deadlock during NVM update"): 1/2 fixes a comment about locking
and 2/2 gets rid of two useless variables and one initializer in nvm
functions.

Stefano Brivio (2):
  i40e: Fix comment about locking for __i40e_read_nvm_word()
  i40e: Avoid some useless variables and initializers in nvm functions

 drivers/net/ethernet/intel/i40e/i40e_nvm.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

-- 
2.9.4

