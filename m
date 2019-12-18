From: Julio Faracco <jcfaracco@gmail.com>
Date: Wed, 18 Dec 2019 15:38:43 -0300
Subject: [Intel-wired-lan] [PATCH net-next 0/2] drivers: net: intel: update
 i40e and ice to use txqueue parameter from tx_timeout.
Message-ID: <20191218183845.20038-1-jcfaracco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The scope of function .ndo_tx_timeout is passing the hung queue now
using a parameter called `txqueue`. Some drivers are still using a loop
structure to identify what is the stopped queue inside that function
above. This is a redundant code. So, this series removes some unnecessary
code to make advantage of that new parameter. We don't need rework now.
For further details see: commit 0290bd291cc0 ("netdev: pass the stuck
queue to the timeout handler").

Julio Faracco (2):
  drivers: net: i40e: Removing hung_queue variable to use txqueue
    function parameter
  drivers: net: ice: Removing hung_queue variable to use txqueue
    function parameter

 drivers/net/ethernet/intel/i40e/i40e_main.c | 41 ++++++---------------
 drivers/net/ethernet/intel/ice/ice_main.c   | 41 ++++++---------------
 2 files changed, 22 insertions(+), 60 deletions(-)

-- 
2.17.1

