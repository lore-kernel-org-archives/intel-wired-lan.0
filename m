From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Fri, 11 Dec 2020 15:57:10 +0100
Subject: [Intel-wired-lan] [PATCH net 0/2] i40e/ice AF_XDP ZC fixes
Message-ID: <20201211145712.72957-1-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This series address two crashes in the AF_XDP zero-copy mode for ice
and i40e. More details in each individual the commit message.


Thanks,
Bj?rn

Bj?rn T?pel (2):
  ice, xsk: clear the status bits for the next_to_use descriptor
  i40e, xsk: clear the status bits for the next_to_use descriptor

 drivers/net/ethernet/intel/i40e/i40e_xsk.c | 5 ++++-
 drivers/net/ethernet/intel/ice/ice_xsk.c   | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)


base-commit: d9838b1d39283c1200c13f9076474c7624b8ec34
-- 
2.27.0

