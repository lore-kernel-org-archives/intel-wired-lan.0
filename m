From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date: Thu, 26 Mar 2020 22:09:58 +0100
Subject: [Intel-wired-lan] [PATCH 0/2] net: convert to use new I2C API
Message-ID: <20200326211001.13171-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

We are deprecating calls which return NULL in favor of new variants which
return an ERR_PTR. Only build tested.


Wolfram Sang (2):
  igb: convert to use i2c_new_client_device()
  sfc: falcon: convert to use i2c_new_client_device()

 drivers/net/ethernet/intel/igb/igb_hwmon.c      | 6 +++---
 drivers/net/ethernet/sfc/falcon/falcon_boards.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.20.1

