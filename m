From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 11 Nov 2020 16:43:23 -0800
Subject: [Intel-wired-lan] [net-next PATCH 0/7] ice: implement display of
 stored flash versions
Message-ID: <20201112004330.2896993-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The devlink info interface supports the ability for drivers to report the
version of firmware that is stored (downloaded) to the device, but is not
yet active.

This series implements support for this in the ice driver, for most flash
versions. This includes the UNDI Option ROM, the Netlist module, and the
fw.bundle_id.

To support this, two major angles of refactor were necessary. First, the ice
driver's main driving loop for reporting versions is refactored to allow for
a context structure. This enabled more easily extending the available
information without having to permanently cache the firmware values in the
driver structures.

Second, the way that we read the firmware versions for most fields needed to
change. The existing methods of reading the flash values were based on
reading from sections of the initialized Shadow RAM. These values get loaded
when the device is booting up. Because of this, they were not capable of
being used to report the inactive versions stored within the non-running
binary sections we downloaded.

To support this, ice_read_flash_module is further abstracted to think in
terms of "active" and "inactive" banks, rather than focusing on "read from
the 1st or 2nd bank". Further, the function is extended to allow reading
arbitrary sizes beyond just one word at a time.

For each of the 3 major firmware components, the version function is
extended to allow requesting the flash bank to read from (active or
inactive). To handle this, the exact algorithm used in each function must be
changed.

For the main NVM version which includes the bundle_id, this is simple. The
location we read from is now the section within the NVM bank that is used to
initialize the Shadow RAM.

For the netlist module, we simply replace the module-based reads that
request the firmware to handle the low level details with direct calls to
read the netlist directly. This slightly changes the offsets we use because
the firmware interface strips out the type field at the start of the netlist
block.

For the UNDI Option ROM firmware things are not so simple. The existing
method for reading the Option ROM requires reading from the Boot
Configuration block. This area is populated with the running Option ROM
version field when the device is loading the firmware. There is no
equivalent for reading the inactive version. Instead of reading from this
section, a new algorithm based on scanning for the actual version block
data in the Option ROM binary is introduced. This data is encoded within a
packed structure that begins with the 4-byte '$CIV' ASCII string, and uses a
simple modulo 256 checksum for integrity. We scan the Option ROM section of
the flash for this data, rather than reading the copied value in the Boot
Configuration block.

With these changes, the ice driver will now report the stored versions for
many of the firmware components when an update has been initiated but the
device has not yet switched to the new bank. The major exception missing is
the management firmware version (fw.mgmt and the related sub fields). This
data is not encoded in a way that is easy to parse out from the inactive
image. The driver is normally informed of the firmware version as part of
its initial messaging over the Admin Queue. It may be theoretically possible
to determine where exactly within the firmware binary the version fields are
stored, but this is not implemented in this patch.

Jacob Keller (7):
  ice: introduce context struct for info report
  ice: refactor interface for ice_read_flash_module
  ice: allow reading inactive flash security revision
  ice: allow reading arbitrary size data with read_flash_module
  ice: display some stored NVM versions via devlink info
  ice: display stored netlist versions via devlink info
  ice: display stored UNDI firmware version via devlink info

 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  27 -
 drivers/net/ethernet/intel/ice/ice_devlink.c  | 247 +++++++--
 drivers/net/ethernet/intel/ice/ice_main.c     |   2 +
 drivers/net/ethernet/intel/ice/ice_nvm.c      | 509 ++++++++++++------
 drivers/net/ethernet/intel/ice/ice_nvm.h      |  14 +
 drivers/net/ethernet/intel/ice/ice_status.h   |   1 +
 drivers/net/ethernet/intel/ice/ice_type.h     |  52 +-
 7 files changed, 609 insertions(+), 243 deletions(-)


base-commit: a96d90adbc085e947f2b02cd744dc32aab9d00ae
-- 
2.29.0

