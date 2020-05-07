From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 7 May 2020 20:50:40 +0000
Subject: [Intel-wired-lan] [PATCH S40 v3 4/15] ice: Add support for
 tunnel offloads
In-Reply-To: <20200506163230.11062-1-anthony.l.nguyen@intel.com>
References: <20200506163230.11062-1-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB1659E27CBA030BCD0958854F8CA50@DM5PR11MB1659.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

-----Original Message-----
From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Tony Nguyen
Sent: Wednesday, May 6, 2020 9:33 AM
To: intel-wired-lan@lists.osuosl.org
Subject: [Intel-wired-lan] [PATCH S40 v3 4/15] ice: Add support for tunnel offloads

Create a boost TCAM entry for each tunnel port in order to get a tunnel PTYPE. Update netdev feature flags and implement the appropriate logic to get and set values for hardware offloads.

Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Henry Tieman <henry.w.tieman@intel.com>
---
v3:
- Removed unnecessary locking
v2:
- Add reference counting for same port additions
- Removed parameter 'index' from ice_tunnel_port_in_use()
- Change message level for exceeding max tunnel ports and tunnel not found to info
- Redo description for ice_create_tunnel()
- Removed unneccesary casts
---
 drivers/net/ethernet/intel/ice/ice.h          |   4 +
 drivers/net/ethernet/intel/ice/ice_common.c   |   2 +
 .../net/ethernet/intel/ice/ice_flex_pipe.c    | 524 +++++++++++++++++-
 .../net/ethernet/intel/ice/ice_flex_pipe.h    |   5 +
 .../net/ethernet/intel/ice/ice_flex_type.h    |  33 ++
 drivers/net/ethernet/intel/ice/ice_flow.c     |  36 +-
 drivers/net/ethernet/intel/ice/ice_flow.h     |   3 +
 .../net/ethernet/intel/ice/ice_lan_tx_rx.h    |  25 +
 drivers/net/ethernet/intel/ice/ice_main.c     |  94 +++-
 .../ethernet/intel/ice/ice_protocol_type.h    |   1 +
 drivers/net/ethernet/intel/ice/ice_txrx.c     | 126 ++++-
 drivers/net/ethernet/intel/ice/ice_txrx.h     |   3 +
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c |  21 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   4 +
 14 files changed, 867 insertions(+), 14 deletions(-)


Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


