From: Stefan Assmann <sassmann@kpanic.de>
Date: Mon, 19 Sep 2016 13:37:48 +0200
Subject: [Intel-wired-lan] [PATCH net-next 0/3] i40e: fix MSI-X vector
	allocation for > 128 CPU threads
Message-ID: <1474285071-28218-1-git-send-email-sassmann@kpanic.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Stefan Assmann (3):
  i40e: check if vectors are already depleted when doing VMDq allocation
  i40e: fix MSI-X vector redistribution if hw limit is reached
  i40e: fix sideband flow director vector allocation

 drivers/net/ethernet/intel/i40e/i40e_main.c | 76 ++++++++++++++++++-----------
 1 file changed, 47 insertions(+), 29 deletions(-)

-- 
2.7.4

