From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 7 May 2020 20:44:46 +0000
Subject: [Intel-wired-lan] [PATCH net-next] ice: report netlist version
 in .info_get
In-Reply-To: <20200505225537.3318391-1-jacob.e.keller@intel.com>
References: <20200505225537.3318391-1-jacob.e.keller@intel.com>
Message-ID: <DM5PR11MB1659DCDDE7D1A976AF7A72CF8CA50@DM5PR11MB1659.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

-----Original Message-----
From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Jacob Keller
Sent: Tuesday, May 5, 2020 3:56 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [PATCH net-next] ice: report netlist version in .info_get

The flash memory for the ice hardware contains a block of information used for link management called the Netlist module.

As this essentially represents another section of firmware, add its version information to the output of the driver's .info_get handler.

This includes both a version and the first few bytes of a hash of the module contents.

  fw.netlist -> the version information extracted from the netlist module
  fw.netlist.build-> first 4 bytes of the hash of the contents, similar
                     to fw.mgmt.build

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 Documentation/networking/devlink/ice.rst      | 11 +++
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   | 27 ++++++
 drivers/net/ethernet/intel/ice/ice_devlink.c  | 23 +++++
 drivers/net/ethernet/intel/ice/ice_nvm.c      | 86 +++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_type.h     | 11 +++
 5 files changed, 158 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


