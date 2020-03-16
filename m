From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 16 Mar 2020 20:23:34 +0000
Subject: [Intel-wired-lan] [PATCH v3 8/9] ice: add basic handler for
 devlink .info_get
In-Reply-To: <20200312015818.1007882-9-jacob.e.keller@intel.com>
References: <20200312015818.1007882-1-jacob.e.keller@intel.com>
 <20200312015818.1007882-9-jacob.e.keller@intel.com>
Message-ID: <f248147f82294cb6893f3799a6ab2999@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

-----Original Message-----
From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Jacob Keller
Sent: Wednesday, March 11, 2020 6:58 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Cc: Jakub Kicinski <kuba@kernel.org>
Subject: [Intel-wired-lan] [PATCH v3 8/9] ice: add basic handler for devlink .info_get

The devlink .info_get callback allows the driver to report detailed version information. The following devlink versions are reported with this initial implementation:

 "fw.mgmt" -> The version of the firmware that controls PHY, link, etc  "fw.mgmt.api" -> API version of interface exposed over the AdminQ  "fw.mgmt.build" -> Unique build id of the source for the management fw  "fw.undi" -> Version of the Option ROM containing the UEFI driver  "fw.psid.api" -> Version of the NVM image format.
 "fw.bundle_id" -> Unique identifier for the combined flash image.
 "fw.app.name" -> The name of the active DDP package.
 "fw.app" -> The version of the active DDP package.

With this, devlink dev info can report at least as much information as is reported by ETHTOOL_GDRVINFO.

Compare the output from ethtool vs from devlink:

  $ ethtool -i ens785s0
  driver: ice
  version: 0.8.1-k
  firmware-version: 0.80 0x80002ec0 1.2581.0
  expansion-rom-version:
  bus-info: 0000:3b:00.0
  supports-statistics: yes
  supports-test: yes
  supports-eeprom-access: yes
  supports-register-dump: yes
  supports-priv-flags: yes

  $ devlink dev info pci/0000:3b:00.0
  pci/0000:3b:00.0:
  driver ice
  serial number 00-01-ab-ff-ff-ca-05-68
  versions:
      running:
        fw.mgmt 2.1.7
        fw.mgmt.api 1.5
        fw.mgmt.build 0x305d955f
        fw.undi 1.2581.0
        fw.psid.api 0.80
        fw.bundle_id 0x80002ec0
        fw.app.name ICE OS Default Package
        fw.app 1.3.1.0

More pieces of information can be displayed, each version is kept separate instead of munged together, and each version has an identifier which comes with associated documentation.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 Documentation/networking/devlink/ice.rst     |  67 +++++++
 Documentation/networking/devlink/index.rst   |   1 +
 drivers/net/ethernet/intel/ice/ice_devlink.c | 189 +++++++++++++++++++
 3 files changed, 257 insertions(+)
 create mode 100644 Documentation/networking/devlink/ice.rst

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


