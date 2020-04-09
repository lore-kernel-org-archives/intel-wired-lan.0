From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 9 Apr 2020 18:10:48 +0000
Subject: [Intel-wired-lan] [next-queue v2] i40e: Add support for a new
 feature: Total Port Shutdown
In-Reply-To: <20200407180252.1920528-1-jeffrey.t.kirsher@intel.com>
References: <20200407180252.1920528-1-jeffrey.t.kirsher@intel.com>
Message-ID: <cabe5a3627e545849fcf40604771ca7b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

-----Original Message-----
From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Jeff Kirsher
Sent: Tuesday, April 7, 2020 11:03 AM
To: intel-wired-lan@lists.osuosl.org
Cc: Kwapulinski, Piotr <piotr.kwapulinski@intel.com>; Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
Subject: [Intel-wired-lan] [next-queue v2] i40e: Add support for a new feature: Total Port Shutdown

From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

Currently after requesting to down a link on a physical network port, the traffic is no longer being processed but the physical link with a link partner is still established.

Total Port Shutdown allows to completely shutdown the port on the link-down procedure by physically removing the link from the port.

Introduced changes:
- probe NVM if the feature was enabled at initialization of the port
- special handling on link-down procedure to let FW physically shutdown the port if the feature was enabled

Testing Hints (required if no HSD):
Link up/down, link-down-on-close

Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
v2: added missing define

 drivers/net/ethernet/intel/i40e/i40e.h        |   1 +
 .../net/ethernet/intel/i40e/i40e_adminq_cmd.h |   1 +
 .../net/ethernet/intel/i40e/i40e_ethtool.c    |   8 ++
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 125 +++++++++++++++---
 4 files changed, 114 insertions(+), 21 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


