From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Date: Thu, 28 May 2020 12:43:28 -0700
Subject: [Intel-wired-lan] [PATCH 00/14] Virtual bus implementation and SOF
 multi-client support
Message-ID: <20200528194342.3495-1-ranjani.sridharan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This set of patches introduces the virtual bus implementation along
with the example usage in the Sound Open Firmware(SOF) audio driver.

The primary purpose of the virtual bus is meant to be a minimalist
software-based bus used for connecting virtual devices to be able 
to communicate with each other.

The SOF driver adopts the virtual bus for implementing the multi-client
support. A client in the context of the SOF driver is a device that needs
to communicate with the DSP via IPCs. With multi-client support, the sound
card can be separated into multiple orthogonal virtual devices for
local device (mic/speakers etc), HDMI, sensing, probes, debug etc. 
In this series, we demonstrate the usage of the virtual bus with the help
of the IPC test client which is used for testing the serialization of IPCs
when multiple clients talk to the DSP at the same time.

This version includes a series of incremental changes in virtual-bus based
of Andy and Pierre's comments. These should be squashed with the first commit.

Dave Ertman (1):
  Implementation of Virtual Bus

Ranjani Sridharan (13):
  virtual-bus: rename struct virtbus_dev_id
  virtual-bus: reword Kconfig help
  virtual-bus: add comment for virtbus entry
  virtual-bus: move MODULE macros to the end of the file
  virtual-bus: remove INVALID_ID and fix error path
  virtual-bus: remove #ifdef for PM ops
  virtual-bus: remove superfluous assignment
  virtual-bus: fix return value for match function
  virtual-bus: reorder header includes
  virtual-bus: remove filename from header
  ASoC: SOF: Introduce descriptors for SOF client
  ASoC: SOF: Create client driver for IPC test
  ASoC: SOF: ops: Add new op for client registration

 Documentation/driver-api/index.rst       |   1 +
 Documentation/driver-api/virtual_bus.rst |  93 ++++++
 drivers/bus/Kconfig                      |  11 +
 drivers/bus/Makefile                     |   2 +
 drivers/bus/virtual_bus.c                | 209 ++++++++++++++
 include/linux/mod_devicetable.h          |   8 +
 include/linux/virtual_bus.h              |  62 ++++
 scripts/mod/devicetable-offsets.c        |   3 +
 scripts/mod/file2alias.c                 |   8 +
 sound/soc/sof/Kconfig                    |  29 ++
 sound/soc/sof/Makefile                   |   7 +-
 sound/soc/sof/core.c                     |  10 +
 sound/soc/sof/intel/Kconfig              |   1 +
 sound/soc/sof/intel/apl.c                |  19 ++
 sound/soc/sof/intel/bdw.c                |  19 ++
 sound/soc/sof/intel/byt.c                |  22 ++
 sound/soc/sof/intel/cnl.c                |  19 ++
 sound/soc/sof/ops.h                      |  20 ++
 sound/soc/sof/sof-client.c               |  89 ++++++
 sound/soc/sof/sof-client.h               |  79 +++++
 sound/soc/sof/sof-ipc-test-client.c      | 348 +++++++++++++++++++++++
 sound/soc/sof/sof-priv.h                 |   9 +
 22 files changed, 1067 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/driver-api/virtual_bus.rst
 create mode 100644 drivers/bus/virtual_bus.c
 create mode 100644 include/linux/virtual_bus.h
 create mode 100644 sound/soc/sof/sof-client.c
 create mode 100644 sound/soc/sof/sof-client.h
 create mode 100644 sound/soc/sof/sof-ipc-test-client.c

-- 
2.17.1

